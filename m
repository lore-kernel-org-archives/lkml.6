Return-Path: <yehs2007@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1527093560; cv=none;
        d=google.com; s=arc-20160816;
        b=OqARsZyvnpr6Pcm0B/cnTyhoH/370iLIZChj4CTd+k6Cgwfwg7iSyTtrGdeUVJV5Uy
         odULbu20uBtC3jSNrv2deM5ntgpqh1N8sDmOqenPSZZODc3CnLiD8P/+y2b7Y5IeKAXE
         WIMeWG5JmebOJe49LFmavXjZ/O25KeBIDDSAryq1q71zsOLl5lmB4pVL8y4IH6DRo9Ty
         vdrQc+LSBIWVrirQo1XUfEZpictbyhLpXJ6pW91eY9pFcnJ78n9iTPXUr4eUY1WJXaWC
         ukyd7DnN90Uq7ln9SPgYRkufiWEJt+IheGPzkRmqkokpKZBvtfvdQaytkeGI9i0On9+O
         UNSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=1zBkKMItrypN9B4fxKZ67AXYmiFJtTKxi6aHDwsB9Dw=;
        b=IOcIHZKrady0GLOSr8FLYr1uf4eYtcJUbgvpTX8y5i4HbRocugwamSaRCVr1HqLVtG
         8RCnMshF4lm7L7/AEWWSAOM3mWadQJw8YDxTwME2T4BOCTJac/tls7vwerZqs7cV6XYl
         k8nIceSrFWCBza+3ExKkubHEILyatqeL/TNlpofSU/wsHjffJ/k0/Tp3YwHtPF0SdhWl
         NBoDAMLeItaeT9R3zF5sRXS25BrRQNL892AGnO0f6baxAGW9HbC60eKtNx6RfQoDo89d
         NiBWLLdRr1LVSrCM+b+q9zKEgDUW3Zn9RLanGnpD1J2/mmJRVQGz4tkCbAzj42X+8ae4
         iYAg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=krI0dL1/;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=krI0dL1/;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqyhfYx9llnrcDVfch2aZsZx9qK1CdAa+2yg6jnY+p4NlkdxlT49OLUTiakcoMX2C4OWqvYDA==
From: Huaisheng Ye <yehs2007@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: mhocko@suse.com,
	willy@infradead.org,
	hch@lst.de,
	vbabka@suse.cz,
	mgorman@techsingularity.net,
	kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	colyli@suse.de,
	chengnt@lenovo.com,
	hehy1@lenovo.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	xen-devel@lists.xenproject.org,
	linux-btrfs@vger.kernel.org,
	Huaisheng Ye <yehs1@lenovo.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH v3 2/9] include/linux/dma-mapping: update usage of zone modifiers
Date: Thu, 24 May 2018 00:38:50 +0800
Message-Id: <1527093530-4000-1-git-send-email-yehs2007@gmail.com>
X-Mailer: git-send-email 1.8.3.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601273657034491951?=
X-GMAIL-MSGID: =?utf-8?q?1601273657034491951?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Huaisheng Ye <yehs1@lenovo.com>

Use __GFP_ZONE_MASK to replace (__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32).

___GFP_DMA, ___GFP_HIGHMEM and ___GFP_DMA32 have been deleted from GFP
bitmasks, the bottom three bits of GFP mask is reserved for storing
encoded zone number.
__GFP_DMA, __GFP_HIGHMEM and __GFP_DMA32 should not be operated with
each others by OR.

Use GFP_NORMAL() to clear bottom 3 bits of GFP bitmaks.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@infradead.org>
---
 include/linux/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f8ab1c0..8fe524d 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -519,7 +519,7 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 		return cpu_addr;
 
 	/* let the implementation decide on the zone to allocate from: */
-	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
+	flag = GFP_NORMAL(flag);
 
 	if (!arch_dma_alloc_attrs(&dev, &flag))
 		return NULL;
-- 
1.8.3.1
