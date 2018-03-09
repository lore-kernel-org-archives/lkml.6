Return-Path: <kernel-hardening-return-12343-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsWVTmFAMIXAnftCna3BkNu7nsAxBlk0F47oKBweNILi1ZpykirZu74lgZxYywCkBgccWL0
ARC-Seal: i=1; a=rsa-sha256; t=1520634767; cv=none;
        d=google.com; s=arc-20160816;
        b=NslZsA8Mo55rOMUVyIkeylU585qn1F17e0gh/UMEPuzN7kyHrnqbP5dV6uedRM7p4t
         Ab3icbf1wDn1lxMGkWEA2BKueRycLHvrXkpxaQbK8uPZcsaiYVSkLJ7rk9XeY509lKgh
         w89PsJb01FMRBXFfYYYrCmsNSfqE2RRcDlUNu/Fw24c40Rhgg44uKschHaNuUdt9H/da
         KCl9GSlCHj931up7cmnSsfQNM+3E1+7WdJxGAig3OHvGDqLuIADpONoSVToIVtKvddLT
         2+xDr7kcWrwLv5PU0GzhoYtr2cDND8NYGYUHv1futAE1/x8/NLMc0JQgy3X1xXrAFkx4
         XSnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=TzGJL5rQN5RUtGhgQ/iqCzq8IqMQorRHAoyOheKtGYY=;
        b=rOgaZQ8WSLmxpwE9f6D/0sU1aCxK0c0vemG/KoNr1q5S2qr6uGJwX6mpfXJTkR9jnc
         5rx8nAZVT/ECUGxto8y3cv+hhlP4ccimBcaTmtzSbto0WPFrIHmuVQaYhcVdjpaRoqEv
         W8/kDGmye7oBcwIF+3NfOEK5W8fSl38UyFmb14313IgY+V/7FSlXMowdOMKUBPY/0OyE
         oGMvmJrVzhvTD6vWcYde6m68XJQFddVITiRDFyJDr6c7TO00e2pYso1hUsSCuq9FcaPq
         w5vbRrWXuG9mcMMPtCJImURw0gEbPNUdfwn65JRkMz1Z8rR0AEbAPDLlfhQlpMqlfCCW
         Riyg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12343-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12343-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12343-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12343-gregkh=linuxfoundation.org@lists.openwall.com
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
Subject: [PATCH] device_handler: remove VLAs
Date: Fri,  9 Mar 2018 23:32:11 +0100
Message-Id: <20180309223211.20473-1-steve@sk2.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180309232933.14e39858@heffalump.sk2.org>
References: <20180309232933.14e39858@heffalump.sk2.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594501121445271854?=
X-GMAIL-MSGID: =?utf-8?q?1594501121445271854?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In preparation to enabling -Wvla, remove VLAs and replace them with
fixed-length arrays instead.

scsi_dh_{alua,emc,rdac} use variable-length array declarations to
store command blocks, with the appropriate size as determined by
COMMAND_SIZE. This patch replaces these with fixed-sized arrays using
MAX_COMMAND_SIZE, so that the array size can be determined at compile
time.

This was prompted by https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 drivers/scsi/device_handler/scsi_dh_alua.c | 8 ++++----
 drivers/scsi/device_handler/scsi_dh_emc.c  | 2 +-
 drivers/scsi/device_handler/scsi_dh_rdac.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index 4b44325d1a82..982a52528a1c 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -138,12 +138,12 @@ static void release_port_group(struct kref *kref)
 static int submit_rtpg(struct scsi_device *sdev, unsigned char *buff,
 		       int bufflen, struct scsi_sense_hdr *sshdr, int flags)
 {
-	u8 cdb[COMMAND_SIZE(MAINTENANCE_IN)];
+	u8 cdb[MAX_COMMAND_SIZE];
 	int req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
 		REQ_FAILFAST_DRIVER;
 
 	/* Prepare the command. */
-	memset(cdb, 0x0, COMMAND_SIZE(MAINTENANCE_IN));
+	memset(cdb, 0x0, MAX_COMMAND_SIZE);
 	cdb[0] = MAINTENANCE_IN;
 	if (!(flags & ALUA_RTPG_EXT_HDR_UNSUPP))
 		cdb[1] = MI_REPORT_TARGET_PGS | MI_EXT_HDR_PARAM_FMT;
@@ -166,7 +166,7 @@ static int submit_rtpg(struct scsi_device *sdev, unsigned char *buff,
 static int submit_stpg(struct scsi_device *sdev, int group_id,
 		       struct scsi_sense_hdr *sshdr)
 {
-	u8 cdb[COMMAND_SIZE(MAINTENANCE_OUT)];
+	u8 cdb[MAX_COMMAND_SIZE];
 	unsigned char stpg_data[8];
 	int stpg_len = 8;
 	int req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
@@ -178,7 +178,7 @@ static int submit_stpg(struct scsi_device *sdev, int group_id,
 	put_unaligned_be16(group_id, &stpg_data[6]);
 
 	/* Prepare the command. */
-	memset(cdb, 0x0, COMMAND_SIZE(MAINTENANCE_OUT));
+	memset(cdb, 0x0, MAX_COMMAND_SIZE);
 	cdb[0] = MAINTENANCE_OUT;
 	cdb[1] = MO_SET_TARGET_PGS;
 	put_unaligned_be32(stpg_len, &cdb[6]);
diff --git a/drivers/scsi/device_handler/scsi_dh_emc.c b/drivers/scsi/device_handler/scsi_dh_emc.c
index 6a2792f3a37e..95c47909a58f 100644
--- a/drivers/scsi/device_handler/scsi_dh_emc.c
+++ b/drivers/scsi/device_handler/scsi_dh_emc.c
@@ -249,7 +249,7 @@ static int send_trespass_cmd(struct scsi_device *sdev,
 			    struct clariion_dh_data *csdev)
 {
 	unsigned char *page22;
-	unsigned char cdb[COMMAND_SIZE(MODE_SELECT)];
+	unsigned char cdb[MAX_COMMAND_SIZE];
 	int err, res = SCSI_DH_OK, len;
 	struct scsi_sense_hdr sshdr;
 	u64 req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
diff --git a/drivers/scsi/device_handler/scsi_dh_rdac.c b/drivers/scsi/device_handler/scsi_dh_rdac.c
index 7af31a1247ee..d27fabae8ddd 100644
--- a/drivers/scsi/device_handler/scsi_dh_rdac.c
+++ b/drivers/scsi/device_handler/scsi_dh_rdac.c
@@ -533,7 +533,7 @@ static void send_mode_select(struct work_struct *work)
 	int err = SCSI_DH_OK, retry_cnt = RDAC_RETRY_COUNT;
 	struct rdac_queue_data *tmp, *qdata;
 	LIST_HEAD(list);
-	unsigned char cdb[COMMAND_SIZE(MODE_SELECT_10)];
+	unsigned char cdb[MAX_COMMAND_SIZE];
 	struct scsi_sense_hdr sshdr;
 	unsigned int data_size;
 	u64 req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
-- 
2.11.0
