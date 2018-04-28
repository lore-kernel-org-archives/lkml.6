Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZonWRAoV9xVbxUBJCYSuvUb04MxE4NYhvfsLE+BKJYfipwL2eDxPyVWbGPKmWOudhwbp1ew
ARC-Seal: i=1; a=rsa-sha256; t=1524874530; cv=none;
        d=google.com; s=arc-20160816;
        b=iSmuxTeZRdtu/rbDJ+p6xGrL5r63N+70V1T8Vvdd62UdVl71REamP+OIlLxYZMIbRO
         n3w7zcBBWa2n76LMHcvum9KhZhjbPzLSxm3wXDBzm0wlsugUDYjYF9jaJFsXRNEUJDqa
         txKu17A6Qsm2tv+wFevvqyapE4ofRk/g57BuqSLIu+wGOqrxtHQ30jZdBeXAJJf2i1ML
         3lAf4W0eOTgDp+b8BF1+dfZ4NRL7tgH9V5QcaFFCUq+Kggp54i7RrDni9TSC1u8og4Qh
         OmNDz0pKUWnep9gLxrfBnEgDezXCceSeCo6UHo3FGU0A0A0gWcp4j3GFJWZCPBJOVkBC
         AlJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dmarc-filter
         :arc-authentication-results;
        bh=TJN5jtAEoUgHHPs9Y1KasX4OorS5/JJBoOdPqLmxyks=;
        b=B6+79UYWMaK6jNgIE+p810smFHgclLHAYFLySTQnEymtNo8vGZSGQ8gtX480SaphWu
         8PS7D1QQnUXi8Hmqpt6VTdzeNkisHILvfny/bo1MnILdDa2/FID1O6XYzISi7tdGbHBH
         3gW0ayOLD4iSn0VXeAOadSNckXfYrp0XnlpvVin/vG+14QLrDplp901XPn5bp40qHt/m
         MvmXgiEMBuyHdaouGy9gVqu474TsYSiOTYIh2XRxoQmh7g1zYRP2Z6BAeb56IzEuBEib
         +/diPHVp/g0yy4js5YaTX0gC9juCF/hhLaMKuCqYtFquLS7O0XCnkOTQXI/QghSCGU6w
         GUQw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1649921926
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: arnd@arndb.de
Cc: gregkh@linuxfoundation.org,
	linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH] mm: provide a fallback for PAGE_KERNEL_RO for architectures
Date: Fri, 27 Apr 2018 17:15:26 -0700
Message-Id: <20180428001526.22475-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598946836077947117?=
X-GMAIL-MSGID: =?utf-8?q?1598946836077947117?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some architectures do not define PAGE_KERNEL_RO, best we can do
for them is to provide a fallback onto PAGE_KERNEL. Remove the
hack from the firmware loader and move it onto the asm-generic
header, and document while at it the affected architectures
which do not have a PAGE_KERNEL_RO:

  o alpha
  o ia64
  o m68k
  o mips
  o sparc64
  o sparc

Blessed-by: 0-day
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/fallback.c |  5 -----
 include/asm-generic/pgtable.h           | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 31b5015b59fe..90f36be9e5ca 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -219,11 +219,6 @@ static ssize_t firmware_loading_show(struct device *dev,
 	return sprintf(buf, "%d\n", loading);
 }
 
-/* Some architectures don't have PAGE_KERNEL_RO */
-#ifndef PAGE_KERNEL_RO
-#define PAGE_KERNEL_RO PAGE_KERNEL
-#endif
-
 /* one pages buffer should be mapped/unmapped only once */
 static int map_fw_priv_pages(struct fw_priv *fw_priv)
 {
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index f59639afaa39..da47fe81df51 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1083,6 +1083,21 @@ int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
 static inline void init_espfix_bsp(void) { }
 #endif
 
+/*
+ * Some architectures don't have PAGE_KERNEL_RO. This is the best
+ * we can do for them buggers for now. Currently known to not have it:
+ *
+ *  o alpha
+ *  o ia64
+ *  o m68k
+ *  o mips
+ *  o sparc64
+ *  o sparc
+ */
+#ifndef PAGE_KERNEL_RO
+#define PAGE_KERNEL_RO PAGE_KERNEL
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 #ifndef io_remap_pfn_range
-- 
2.13.2
