Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AG47ELsTPIWwjCNRQYGHbQQxH76UiKX6i2zzXRRsJgOw83A4NBW3a+WvfwfZYXvDs33c/EvooFrZ
ARC-Seal: i=1; a=rsa-sha256; t=1521208182; cv=none;
        d=google.com; s=arc-20160816;
        b=GUsD53Q3LGwmuKm9hKp3ld/HCAmVku9ySdqDwf2JeyFUOkZNEvMi79h6Bgcj6M333J
         EPejFoVee4Kw72skwGWpxZTIXdFHMbDP5mlTd4zBfDzWcK27hukClFho9K0vs3AeDrC6
         Ix+iazpXAT/vFgBTbdJQ6Lcdzc7bj2ShNB1WwJAj+Xcpc8ziB1A2AzO2QZlBqbpq3Rzm
         D7sJNBMQXKAObVuPD+2XQmU9LIjBVg7e4NbwJAJPh5MSa/XOG3aksXUvL5fZqjUUYlTB
         zfwvSayE2EPohf+1l5CMgYBr/oJpf8bIoU82WQ6Mzyy+l5A/sov7/XWEEnbfPuy45O7h
         tVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=iDHq7xz/kALLKtwX8pqgJWmSyA0AsYfiUUEKhvgTKjg=;
        b=xpIeVkVs7O40mIGZctLZHdDzBZew4ceUUNoDIAsAzY9vynTDzesPwdhawc8I3wk7+S
         y8EcV8shX+MKccRA/tzT3uomGPfj4W7ATBDrfqz2rb+H8LKTuN8FUxpMQDTn7/eXSxCg
         gYCXJw+nZ2yNCbB1ikyl9Z3WpGZFp/WkzlNlKBz6Njvc8f8IqqSKW+3cfcHeCExYbHOo
         cKBIEWU9khcofVRmpm8X2HCbXyAz/7+hUoELoMjKAEArZ4m12byH/wj5F7Wraf8Y3gJw
         7uUGKj87pZg8El6mJ8r4aFiS2V/LCu6xQqYvTFrcwroD5GGhe5PRZqX3xA9UqWcFaMIA
         xNfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:18 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:18 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
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
Subject: [PATCH v2 2/5] dma-coherent: Add NO_DMA dummies for managed DMA API
Date: Fri, 16 Mar 2018 14:25:41 +0100
Message-Id: <1521206744-1504-3-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521206744-1504-1-git-send-email-geert@linux-m68k.org>
References: <1521206744-1504-1-git-send-email-geert@linux-m68k.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595102390638471173?=
X-GMAIL-MSGID: =?utf-8?q?1595102390638471173?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add dummies for dmam_{alloc,free}_coherent(), to allow compile-testing
if NO_DMA=y.

This prevents the following from showing up later:

    ERROR: "dmam_alloc_coherent" [drivers/net/ethernet/arc/arc_emac.ko] undefined!
    ERROR: "dmam_free_coherent" [drivers/net/ethernet/apm/xgene/xgene-enet.ko] undefined!
    ERROR: "dmam_alloc_coherent" [drivers/net/ethernet/apm/xgene/xgene-enet.ko] undefined!
    ERROR: "dmam_alloc_coherent" [drivers/mtd/nand/hisi504_nand.ko] undefined!
    ERROR: "dmam_alloc_coherent" [drivers/mmc/host/dw_mmc.ko] undefined!

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
---
v2:
  - Add Reviewed-by, Acked-by,
  - Drop RFC state.
---
 include/linux/dma-mapping.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 5ea7eec83c0fbb82..94f41846b933fca7 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -776,10 +776,19 @@ static inline void dma_deconfigure(struct device *dev) {}
 /*
  * Managed DMA API
  */
+#ifdef CONFIG_HAS_DMA
 extern void *dmam_alloc_coherent(struct device *dev, size_t size,
 				 dma_addr_t *dma_handle, gfp_t gfp);
 extern void dmam_free_coherent(struct device *dev, size_t size, void *vaddr,
 			       dma_addr_t dma_handle);
+#else /* !CONFIG_HAS_DMA */
+static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
+					dma_addr_t *dma_handle, gfp_t gfp)
+{ return NULL; }
+static inline void dmam_free_coherent(struct device *dev, size_t size,
+				      void *vaddr, dma_addr_t dma_handle) { }
+#endif /* !CONFIG_HAS_DMA */
+
 extern void *dmam_alloc_attrs(struct device *dev, size_t size,
 			      dma_addr_t *dma_handle, gfp_t gfp,
 			      unsigned long attrs);
-- 
2.7.4
