Return-Path: <kernel-hardening-return-12344-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELt6wpwjAfoD88Uz5rjPD1kyLLOmKm4gs+v6PjjEiRvBGrBaaDXQdX6gv783iqxWoHuHY5Nf
ARC-Seal: i=1; a=rsa-sha256; t=1520634855; cv=none;
        d=google.com; s=arc-20160816;
        b=rpXJk+XqhMS6RxPkPulh7I28fIx/U54aHqjY31NCXzBIPgVpcmkIF3WKNWAW/oWKBC
         nsoiCu4UZsEUPstJFpTEVeA3xWlqpMfGGHRLaD3SOKJvjTNiQogtBDRqtJcnMu6Rkx0+
         g0xBzrJ8M/kn6GsEtnS3SukcZ+sw7/E88EaE3hR5p+LcMVpD+gVehijiYyIe7JutEdk/
         ZLPTpBN3TRIdr3pWNKnIG7Zdk39AWu6AmVzeRviBRKU4RkmxaeDlJjcFkIiO9VQRlxv3
         +hbAsk/a7b8Rwj+qgvDuWKg1QSuc7AzUyiSRZio8gAibJ8mf5woLkcLhbSst9ZIxyakC
         R2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=l6Sp2j82YKDbdBpdeR8DFzN4G5+CLK3hdH3aENbgfsA=;
        b=j5scsW4tCyb8T5zalBLfnmVXtkqLYu05PBjgWPBY8E8lolxcVYvKHyaRBa/RMiqC05
         PfNnhZs7TbaFiE+DeVqQ8fpeuUVVoo4YyadOy+yqP9mEVZC5Xr0KolVcoWnyrDdZrcAA
         wZ08AWQWDHVnQV2uawxEGu+ZrDsWtllFdEg4LfBI4+qtgo23ddc+wI8Y1JNAk80pWAaB
         noxuU/t3yY5WWv918zw98Dk22YY2dVdKNiLsPGBi7AJUhPJds09hI/PoXP1YjfMGMHXT
         im5+VJEbmrNFvnLXHR73TEpzWMGtAsryZZul3XbhFpeqTY322aHwpFJQYFQDUsiJZfW3
         njGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12344-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12344-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12344-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12344-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Stephen Kitt <steve@sk2.org>
To: hare@suse.com,
	axboe@kernel.dk,
	jejb@linux.vnet.ibm.com,
	martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Stephen Kitt <steve@sk2.org>
Subject: [PATCH] scsi: resolve COMMAND_SIZE at compile time
Date: Fri,  9 Mar 2018 23:33:55 +0100
Message-Id: <20180309223355.21222-1-steve@sk2.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180309232933.14e39858@heffalump.sk2.org>
References: <20180309232933.14e39858@heffalump.sk2.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594501214170730131?=
X-GMAIL-MSGID: =?utf-8?q?1594501214170730131?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

COMMAND_SIZE currently uses an array of values in block/scsi_ioctl.c.
A number of device_handler functions use this to initialise arrays,
and this is flagged by -Wvla.

This patch replaces COMMAND_SIZE with a variant using a formula which
can be resolved at compile time in cases where the opcode is fixed,
resolving the array size and avoiding the VLA. The downside is that
the code is less maintainable and that some call sites end up having
more complex generated code.

Since scsi_command_size_tbl is dropped, we can remove the dependency
on BLK_SCSI_REQUEST from drivers/target/Kconfig.

This was prompted by https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 block/scsi_ioctl.c         |  8 --------
 drivers/target/Kconfig     |  1 -
 include/scsi/scsi_common.h | 13 +++++++++++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 60b471f8621b..b9e176e537be 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -41,14 +41,6 @@ struct blk_cmd_filter {
 
 static struct blk_cmd_filter blk_default_cmd_filter;
 
-/* Command group 3 is reserved and should never be used.  */
-const unsigned char scsi_command_size_tbl[8] =
-{
-	6, 10, 10, 12,
-	16, 12, 10, 10
-};
-EXPORT_SYMBOL(scsi_command_size_tbl);
-
 #include <scsi/sg.h>
 
 static int sg_get_version(int __user *p)
diff --git a/drivers/target/Kconfig b/drivers/target/Kconfig
index 4c44d7bed01a..b5f05b60cf06 100644
--- a/drivers/target/Kconfig
+++ b/drivers/target/Kconfig
@@ -4,7 +4,6 @@ menuconfig TARGET_CORE
 	depends on SCSI && BLOCK
 	select CONFIGFS_FS
 	select CRC_T10DIF
-	select BLK_SCSI_REQUEST # only for scsi_command_size_tbl..
 	select SGL_ALLOC
 	default n
 	help
diff --git a/include/scsi/scsi_common.h b/include/scsi/scsi_common.h
index 731ac09ed231..48d950666376 100644
--- a/include/scsi/scsi_common.h
+++ b/include/scsi/scsi_common.h
@@ -15,8 +15,17 @@ scsi_varlen_cdb_length(const void *hdr)
 	return ((struct scsi_varlen_cdb_hdr *)hdr)->additional_cdb_length + 8;
 }
 
-extern const unsigned char scsi_command_size_tbl[8];
-#define COMMAND_SIZE(opcode) scsi_command_size_tbl[((opcode) >> 5) & 7]
+/*
+ * SCSI command sizes are as follows, in bytes, for fixed size commands, per
+ * group: 6, 10, 10, 12, 16, 12, 10, 10. The top three bits of an opcode
+ * determine its group.
+ * The size table is encoded into a 32-bit value by subtracting each value
+ * from 16, resulting in a value of 1715488362
+ * (6 << 28 + 6 << 24 + 4 << 20 + 0 << 16 + 4 << 12 + 6 << 8 + 6 << 4 + 10).
+ * Command group 3 is reserved and should never be used.
+ */
+#define COMMAND_SIZE(opcode) \
+	(16 - (15 & (1715488362 >> (4 * (((opcode) >> 5) & 7)))))
 
 static inline unsigned
 scsi_command_size(const unsigned char *cmnd)
-- 
2.11.0
