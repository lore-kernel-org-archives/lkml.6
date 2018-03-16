Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AG47ELsSvZ0QBb2lvPjOGB8hFtdbjiFmUP7ytRUbgtOqvR21BNTnUcx5aP1AQdgYfqH6C0sMS+Tq
ARC-Seal: i=1; a=rsa-sha256; t=1521207884; cv=none;
        d=google.com; s=arc-20160816;
        b=1GxwhZXNedkX1XjRyhwjAi1sdW46zEKlg88JChSd2WNbHdmPN0RvWjm/quBmIPj1/C
         G+2P16fG3vsFoahkCDuwY4o8ILqopVJXrNyb15gaWMxPnnKyZZtCSyHj0BwT2BcMmL0Q
         17APNaCRB2haKHENdza5TZGWXaAJiLXvRpw0ehyOBtRMoticK6RriF81Z0pUnZu1Ftjw
         9qjPOAnQnG/z/fitmpX+XYK6e4PU2ZjRB9PT8lMIFE+C4J+iB0mB4degzeweA+vpPgh2
         nW/CN7NTmT9jcmP8Nc6noj0gdfi7kkuTNJ2CnX6x77Z2LzmLOes4uVSM2jPrpkZGl33x
         hCDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=HczLhBd6gbBp44usSF+onwMysAhvWrLmY+qOllIUfUs=;
        b=NJGtZuhUCWyVTDgBEDzYRcwdqMAPDckDuReEbFW99Z47Nxs+ulVLWlNwLUmnBPOtfZ
         AVcY0XiPI5TTiUQWiPmlLFp6rejkNleuGj5TtY1SOBiLYQusmyjUf1FwLO3HPV0hDWzP
         Hs4p/FRBFxJyt7lFs0KV+eADqD395P2G39SZl9ajRnS7K4YVROwjpMVtclGHEnyK//1h
         Gds4HxznZsjAJZjozFEQ3ZTD65IuMDlgoBfMW4UGO08By84Qyi/oJnwQeFPUVbyGuhmD
         e/94A8zw1Me2yNDN3SzrC2qKjyWLlWUSnWSEvyqRtHm50ubNBu6S1BN80wGRDGzC0hMD
         Hi1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a02:1800:120:4::f00:15 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a02:1800:120:4::f00:15 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: iommu@lists.linux-foundation.org,
	linux-usb@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 5/5] scsi: Add NO_DMA dummies for SCSI DMA mapping API
Date: Fri, 16 Mar 2018 14:25:44 +0100
Message-Id: <1521206744-1504-6-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521206744-1504-1-git-send-email-geert@linux-m68k.org>
References: <1521206744-1504-1-git-send-email-geert@linux-m68k.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595102078804105420?=
X-GMAIL-MSGID: =?utf-8?q?1595102078804105420?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add dummies for scsi_dma_{,un}map(), to allow compile-testing if
NO_DMA=y.

This prevents the following from showing up later:

    ERROR: "scsi_dma_unmap" [drivers/firewire/firewire-sbp2.ko] undefined!
    ERROR: "scsi_dma_map" [drivers/firewire/firewire-sbp2.ko] undefined!

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
---
v2:
  - Add Reviewed-by, Acked-by,
  - Drop RFC state.
---
 include/scsi/scsi_cmnd.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 2280b2351739572c..aaf1e971c6a368d1 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -174,8 +174,13 @@ extern void scsi_kunmap_atomic_sg(void *virt);
 
 extern int scsi_init_io(struct scsi_cmnd *cmd);
 
+#ifdef CONFIG_SCSI_DMA
 extern int scsi_dma_map(struct scsi_cmnd *cmd);
 extern void scsi_dma_unmap(struct scsi_cmnd *cmd);
+#else /* !CONFIG_SCSI_DMA */
+static inline int scsi_dma_map(struct scsi_cmnd *cmd) { return -ENOSYS; }
+static inline void scsi_dma_unmap(struct scsi_cmnd *cmd) { }
+#endif /* !CONFIG_SCSI_DMA */
 
 static inline unsigned scsi_sg_count(struct scsi_cmnd *cmd)
 {
-- 
2.7.4
