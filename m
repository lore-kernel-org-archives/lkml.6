Return-Path: <yehs2007@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526916062; cv=none;
        d=google.com; s=arc-20160816;
        b=uornIIXRrm4ZuVu2zfPfMrCpk1hN8d9KP4B7BHG/4R788iRw9N5p6h3B9rsZwgZtsp
         q4RMykgJ6hlcbzMzygsfshrJ2Tu+49pYq+BMObAgktY6fVxMXUY6yHEWbwWEOsnzXijG
         lK/4g3+f9+PAKnAvnyBAj3VLX9FD5sFcJ9FnPC2pCNsJOQHbIUZCB/IfpujUw2c5hNhC
         eAbp7Khuk+N5gdooj5ubsO1esTsHcDhFNBW20cY5XNAcklZhN0SwqcxV/pVfUkEh5A1o
         GLfkLjGt5y5+FtApYKlTcVY45T5oad0rS4cRi9mCF0yJ1/AYtNDxb8Cg3ZemLT/iERaV
         WBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=gCVeji/sj287tYAdssy/5sld4ZpSGcCIq6efDVH4m0A=;
        b=REpKZplH5Va2x7/SYq2Y06jDF3/0unIbfJctK88791tU0GF1tM8mTR4qcb7ovmwHFC
         htQRcqL5J5GZleVSqUZ5nd3J80SdQ38AtQBrfHmyszt92I/K/jydafYdM+660x+LHEKo
         3XzjB+QzehRvo/X0BOl/IE3nRuyrWsvDA0wKz+INE1kl6Ju8IFeLbwajqZX1FOyvLqyn
         LgmRs45e75WcQC84y859/ekOrhPKh19GUYybJRNepiaTTmTdIVFDsc0oQYzHERi/WKEz
         uwDCFwGZlZl8dFLK0VJPszfZa44+SzNl7b6HrFdGjoiBHkYC2YuH1U38yTV0k+8GRibq
         PoHA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BXvzDbOh;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BXvzDbOh;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrAVYVwjqdf6R5rZmASog1IIgq3LzXj6kL3m/+HAwjZcmaBn+BSUjHEhS8RpB2wn2D7TxjLPg==
From: Huaisheng Ye <yehs2007@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: mhocko@suse.com,
	willy@infradead.org,
	vbabka@suse.cz,
	mgorman@techsingularity.net,
	kstewart@linuxfoundation.org,
	alexander.levin@verizon.com,
	gregkh@linuxfoundation.org,
	colyli@suse.de,
	chengnt@lenovo.com,
	hehy1@lenovo.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	xen-devel@lists.xenproject.org,
	linux-btrfs@vger.kernel.org,
	Huaisheng Ye <yehs1@lenovo.com>,
	Joerg Roedel <joro@8bytes.org>
Subject: [RFC PATCH v2 04/12] drivers/iommu/amd_iommu: update usage of address zone modifiers
Date: Mon, 21 May 2018 23:20:25 +0800
Message-Id: <1526916033-4877-5-git-send-email-yehs2007@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601087537076286514?=
X-GMAIL-MSGID: =?utf-8?q?1601087537076286514?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Huaisheng Ye <yehs1@lenovo.com>

Use __GFP_ZONE_MASK to replace (__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32).

___GFP_DMA, ___GFP_HIGHMEM and ___GFP_DMA32 have been deleted from GFP
bitmasks, the bottom three bits of GFP mask is reserved for storing
encoded zone number.
__GFP_DMA, __GFP_HIGHMEM and __GFP_DMA32 should not be operated by OR.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Cc: Joerg Roedel <joro@8bytes.org>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 74788fd..3921d53 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2614,7 +2614,7 @@ static void *alloc_coherent(struct device *dev, size_t size,
 	dma_dom   = to_dma_ops_domain(domain);
 	size	  = PAGE_ALIGN(size);
 	dma_mask  = dev->coherent_dma_mask;
-	flag     &= ~(__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32);
+	flag     &= ~__GFP_ZONE_MASK;
 	flag     |= __GFP_ZERO;
 
 	page = alloc_pages(flag | __GFP_NOWARN,  get_order(size));
-- 
1.8.3.1
