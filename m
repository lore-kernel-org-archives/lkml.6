Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AG47ELtCQeNpxdQ6umfBjaMl5j223RoyOrajhaVbyaduuabsorjTC/vJU3Jp7cXK6J/YJT7h9wn7
ARC-Seal: i=1; a=rsa-sha256; t=1521208178; cv=none;
        d=google.com; s=arc-20160816;
        b=uW4MIYl76ljP1VMoVQSZsfv7UPXqcVSYZfulodXpSLbXhmAjtDL4IbyzQvE4idlgfg
         j3eAeJxltl05uH+MhsYF9K5rnqEGEymKdMGcQtw+NXwsLt0BjsJ2gocr6UGsCqQzRloG
         SGgn9PvoKWs6YIy0skB1R9+mA5nCvLRfseSLOFQ559l8y2/on77UfoBU8ggr26ThoVPT
         CEkoTdBSW3qlvkiHZqDFH/kkDUxZQIte2UREx+MdWavW7wDh4xYQWIyB1FZ0fUNKQHCT
         biFhiDgaw/mkfZUBzJOr2WJCZPU22BWctqnpYJJJ9QaLYXyxRFTbwPWmBDcJ17MsQlr7
         8rFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=nur7l6MnTbCFa2GACFTXwPaBZpJAoP46VYAO/MyzMZ0=;
        b=I/l6IAFDq9Y0HVn9NQ4BpSAv1pwGFSyF/srAGEGS05ojr1RtryW1rudwFiLH95iURX
         bGV+H3sjMLTozsoU1F3ylD2VO+Dx8Epa9U7fxlLVX9xHZ1Nx6Sq60qvYLrxWUGOMkkqm
         9uUjU73hJDusR/H6R/ZgDaUeleTnE1YX3V4Aac7NQBzS2+u2K+6ltJ2p3nEiJzsCJF6Z
         rHOxWKdtK6dL53repZpVIaHIVXQJ0DKaUwfreS/r/DK6oDrnpanX779KfvvLXxlXdb7r
         WdExUASaZW6pZnWcUKXk9aLMSoEB1bQ4FhU+af4Mrx5hYfroW/tPXIzVx6ZXGpOGgzpz
         Pd7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a02:1800:120:4::f00:13 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a02:1800:120:4::f00:13 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
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
Subject: [PATCH v2 4/5] mm: Add NO_DMA dummies for DMA pool API
Date: Fri, 16 Mar 2018 14:25:43 +0100
Message-Id: <1521206744-1504-5-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521206744-1504-1-git-send-email-geert@linux-m68k.org>
References: <1521206744-1504-1-git-send-email-geert@linux-m68k.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595102386187325334?=
X-GMAIL-MSGID: =?utf-8?q?1595102386187325334?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add dummies for dma{,m}_pool_{create,destroy,alloc,free}(), to allow
compile-testing if NO_DMA=y.

This prevents the following from showing up later:

    ERROR: "dma_pool_destroy" [drivers/usb/mtu3/mtu3.ko] undefined!
    ERROR: "dma_pool_free" [drivers/usb/mtu3/mtu3.ko] undefined!
    ERROR: "dma_pool_alloc" [drivers/usb/mtu3/mtu3.ko] undefined!
    ERROR: "dma_pool_create" [drivers/usb/mtu3/mtu3.ko] undefined!
    ERROR: "dma_pool_destroy" [drivers/scsi/hisi_sas/hisi_sas_main.ko] undefined!
    ERROR: "dma_pool_free" [drivers/scsi/hisi_sas/hisi_sas_main.ko] undefined!
    ERROR: "dma_pool_alloc" [drivers/scsi/hisi_sas/hisi_sas_main.ko] undefined!
    ERROR: "dma_pool_create" [drivers/scsi/hisi_sas/hisi_sas_main.ko] undefined!
    ERROR: "dma_pool_alloc" [drivers/mailbox/bcm-pdc-mailbox.ko] undefined!
    ERROR: "dma_pool_free" [drivers/mailbox/bcm-pdc-mailbox.ko] undefined!
    ERROR: "dma_pool_create" [drivers/mailbox/bcm-pdc-mailbox.ko] undefined!
    ERROR: "dma_pool_destroy" [drivers/mailbox/bcm-pdc-mailbox.ko] undefined!

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
---
v2:
  - Add Reviewed-by, Acked-by,
  - Drop RFC state,
  - Group NO_DMA-stubs under a single #ifdef,
  - Move dma_pool_zalloc() definition down.
---
 include/linux/dmapool.h | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/linux/dmapool.h b/include/linux/dmapool.h
index 53ba737505df31c7..f632ecfb4238404e 100644
--- a/include/linux/dmapool.h
+++ b/include/linux/dmapool.h
@@ -16,6 +16,8 @@
 
 struct device;
 
+#ifdef CONFIG_HAS_DMA
+
 struct dma_pool *dma_pool_create(const char *name, struct device *dev, 
 			size_t size, size_t align, size_t allocation);
 
@@ -23,13 +25,6 @@ void dma_pool_destroy(struct dma_pool *pool);
 
 void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 		     dma_addr_t *handle);
-
-static inline void *dma_pool_zalloc(struct dma_pool *pool, gfp_t mem_flags,
-				    dma_addr_t *handle)
-{
-	return dma_pool_alloc(pool, mem_flags | __GFP_ZERO, handle);
-}
-
 void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t addr);
 
 /*
@@ -39,5 +34,26 @@ struct dma_pool *dmam_pool_create(const char *name, struct device *dev,
 				  size_t size, size_t align, size_t allocation);
 void dmam_pool_destroy(struct dma_pool *pool);
 
+#else /* !CONFIG_HAS_DMA */
+static inline struct dma_pool *dma_pool_create(const char *name,
+	struct device *dev, size_t size, size_t align, size_t allocation)
+{ return NULL; }
+static inline void dma_pool_destroy(struct dma_pool *pool) { }
+static inline void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
+				   dma_addr_t *handle) { return NULL; }
+static inline void dma_pool_free(struct dma_pool *pool, void *vaddr,
+				 dma_addr_t addr) { }
+static inline struct dma_pool *dmam_pool_create(const char *name,
+	struct device *dev, size_t size, size_t align, size_t allocation)
+{ return NULL; }
+static inline void dmam_pool_destroy(struct dma_pool *pool) { }
+#endif /* !CONFIG_HAS_DMA */
+
+static inline void *dma_pool_zalloc(struct dma_pool *pool, gfp_t mem_flags,
+				    dma_addr_t *handle)
+{
+	return dma_pool_alloc(pool, mem_flags | __GFP_ZERO, handle);
+}
+
 #endif
 
-- 
2.7.4
