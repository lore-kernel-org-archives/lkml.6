Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD80DC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B4620881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DXa1Vnwr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B4620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933135AbeGIMUl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:20:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:32957 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933027AbeGIMUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:20:24 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180709122022euoutp0237a9e985b945105be3364a26347ea47f~-sqV8kSsX0090600906euoutp02P
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jul 2018 12:20:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180709122022euoutp0237a9e985b945105be3364a26347ea47f~-sqV8kSsX0090600906euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1531138822;
        bh=/sGu62G34gZWe6yiP8J3NnQCnvipI839Mo7SBSyiJog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DXa1Vnwr3+Gd3Z5A+tkIYpwVtLdlmYBvyeS1zhfqn1K+nzc+/SQATiIdjHJW4g2jD
         IZpqNQNh3uufQnhOaIVAlpshHEjR8W8CYWKDQ5I05F/2CUaIAYNwSj7J6By9l0rIsC
         WNLR9eTI/FL7+v+K/aLoUBsDH4Vsj7+b+TJfJp3M=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180709122021eucas1p1236151189c3e5f127406642f222b5591~-sqVFbf4M0876608766eucas1p1I;
        Mon,  9 Jul 2018 12:20:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2E.B9.17380.403534B5; Mon,  9
        Jul 2018 13:20:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180709122020eucas1p21a71b092975cb4a3b9954ffc63f699d1~-sqUFoa-h2939329393eucas1p2Y;
        Mon,  9 Jul 2018 12:20:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180709122019eusmtrp2e92e421e7a90a8ce48dd7b32d05f5277~-sqT2K2fn0663106631eusmtrp2K;
        Mon,  9 Jul 2018 12:20:19 +0000 (GMT)
X-AuditID: cbfec7f4-713ff700000043e4-f8-5b4353047272
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D6.CF.04183.303534B5; Mon,  9
        Jul 2018 13:20:19 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.116.147.25]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180709122018eusmtip2d6617189d863d5e3ed86a7dbc1296e3a~-sqS-S3QW1821818218eusmtip2I;
        Mon,  9 Jul 2018 12:20:18 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Nazarewicz <mina86@mina86.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Zankel <chris@zankel.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH 2/2] dma: remove unsupported gfp_mask parameter from
 dma_alloc_from_contiguous()
Date:   Mon,  9 Jul 2018 14:19:56 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180709121956.20200-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTURjv3Lv7cDS5zsrTA6KFoj3sSRwyKrPoEL0wKOi97DKlzdluakWU
        r8o2lR5UYmtaaGrNB8tKbVabrkmBZaVpT0v/sEjzsV40XNuu1X/f7/X9Dh+HJeUn6UlsQuIB
        XpeoVCtoqeT2w19PZks2xWyb2/1yMTJWmWk0kHGcRF+v5QBkuFpKo/IbDgKVGzJpVHQ/Cp26
        VM2gcutPArlefCCQpbudQs/rjTR6Z/ZQyH6+AaDfP0YoVNH0lkHv85ajImcWhS4bf9LINtBD
        oeGWEwx69HaYQZfS8wD6NNgsWQ5xj81EYLPJDPDz9lYS2z7aaZzzJYvClqGzDNb3vSDwm3Yr
        jZvzf0vwzeJj+PVIN4nPdZQC/CT/CsB3O9NoXOn+TODyZ63MxglbpUv28uqEFF43Z+luabyx
        cUNS76KDtuISOg18naUHASzkFsIz7S5KD6SsnCsDsKY/kxCBC8ChiyW0CIYBrDZUkX8jafeK
        R12lAGZXDUpE8A3ASquF8blobh7U9+n98XFcIYBdtgx/C8n1ULDXo/e7grk9MLsu3b9XwoVC
        87d0IHZMhTeqH/j5AG4pLGzykL4w5KwsfF3zlPIJMi4Fll747n0I6xVWwlfvVGI2GH521jDi
        PAV66goJMZsJ4Mn8AkYEOQDeMtbSoisKNjpbKd8ikouAVfVzRDoamm+ZRvcHwo6+IB9Nesez
        ty+SIi2D2SfkojsMFjgr/9Xanj4bPReGWQ1ORrzQGQBzrLXkaTC14H9ZEQDXQQifLGhUvDA/
        kU+NFJQaITlRFRmn1ViA93s+HnG6akG9e48dcCxQjJUN7F+xTU4pU4RDGjuALKkYJ1Mu9lKy
        vcpDh3mddpcuWc0LdjCZlShCZDvDj26VcyrlAX4fzyfxur8qwQZMSgOxn7R5bsNHa26AaYHm
        6J2g+IgQg7NrYfHEVYbpjjX9odq6aEd0l5CxjmmJitvuzk3oszR9qN68RdVm0TJsSPgUaWh/
        oKM1OMGjzm9WDzUEHdkRkz3DJG0BrsLU2LLO3jG553e0ZS6buSbM/X78+mlrtwQOOlbLG+Nj
        7qTqKiouKyRCvHLeDFInKP8ASg9v65oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsVy+t/xe7rMwc7RBkfXmVrMWb+GzeJDUyuz
        xftlPYwW3YuWs1msXH2UyWJldzObxYL91hadszewW6zc84PJ4suVh0wWmx5fY7W4vGsOm8W9
        Nf9ZLQ5N3cto8fv7P1aLtUfuslvc73OwWHC8hdVi7pwfbBYHPzxhtfh8ro3d4tTdz+wWsxv7
        GC1efjzB4iDh8eTgPCaPNfPWMHpcvnaR2ePgo0NsHj1vWlg9Nn2axO7R9fYKk8eda3vYPE7M
        +M3isXlJvcftf4+ZPSbfWM7ocX7GQkaP3Tcb2DzW/XnF5LHy0kX2ALEoPZui/NKSVIWM/OIS
        W6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYw5h/0LXphVHFyylK2B8b1O
        FyMnh4SAiUTDviVMXYxcHEICSxkl1t69xQaRkJE4Oa2BFcIWlvhzrYsNougzo8TsrzMZQRJs
        AoYSXW8hEiICixklPv2/yAriMAt8Y5V4PGsGC0iVsECCxPcNC8HGsgioSqz52gjWzStgK/Hu
        /hYWiBXyEqs3HGAGsTkF7CTmH/kPZgsB1bS9OcUygZFvASPDKkaR1NLi3PTcYiO94sTc4tK8
        dL3k/NxNjMBY3nbs55YdjF3vgg8xCnAwKvHwfih0ihZiTSwrrsw9xCjBwawkwptoBRTiTUms
        rEotyo8vKs1JLT7EaAp01ERmKdHkfGCaySuJNzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCeWJKa
        nZpakFoE08fEwSnVwGgWckyvu6FQeQPzPK0jpq9/Xt1h7xtrtvLqPcmXK4/snm31tzGR3fXx
        jJ0/5KMP8TfvNtR/W/h7/3euTOPgf7pLQ790/Yvz3ua56bqc/MHHixYWTH3jlP1I6tXulLxN
        2idL3FVSHCYd/XlYsvB38oTVf1U4RTWMPp2oXZe0WXFv9l2H9dxFezcpsRRnJBpqMRcVJwIA
        Yashu/sCAAA=
Message-Id: <20180709122020eucas1p21a71b092975cb4a3b9954ffc63f699d1~-sqUFoa-h2939329393eucas1p2Y@eucas1p2.samsung.com>
X-CMS-MailID: 20180709122020eucas1p21a71b092975cb4a3b9954ffc63f699d1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180709122020eucas1p21a71b092975cb4a3b9954ffc63f699d1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180709122020eucas1p21a71b092975cb4a3b9954ffc63f699d1
References: <20180709121956.20200-1-m.szyprowski@samsung.com>
        <CGME20180709122020eucas1p21a71b092975cb4a3b9954ffc63f699d1@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CMA memory allocator doesn't support standard gfp flags for memory
allocation, so there is no point having it as a parameter for
dma_alloc_from_contiguous() function. Replace it by a boolean no_warn
argument, which covers all the underlaying cma_alloc() function supports.

This will help to avoid giving false feeling that this function supports
standard gfp flags and callers can pass __GFP_ZERO to get zeroed buffer,
what has already been an issue: see commit dd65a941f6ba ("arm64:
dma-mapping: clear buffers allocated with FORCE_CONTIGUOUS flag").

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c      | 5 +++--
 arch/arm64/mm/dma-mapping.c    | 4 ++--
 arch/xtensa/kernel/pci-dma.c   | 2 +-
 drivers/iommu/amd_iommu.c      | 2 +-
 drivers/iommu/intel-iommu.c    | 3 ++-
 include/linux/dma-contiguous.h | 4 ++--
 kernel/dma/contiguous.c        | 7 +++----
 kernel/dma/direct.c            | 3 ++-
 8 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index be0fa7e39c26..121c6c3ba9e0 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -594,7 +594,7 @@ static void *__alloc_from_contiguous(struct device *dev, size_t size,
 	struct page *page;
 	void *ptr = NULL;
 
-	page = dma_alloc_from_contiguous(dev, count, order, gfp);
+	page = dma_alloc_from_contiguous(dev, count, order, gfp & __GFP_NOWARN);
 	if (!page)
 		return NULL;
 
@@ -1294,7 +1294,8 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 		unsigned long order = get_order(size);
 		struct page *page;
 
-		page = dma_alloc_from_contiguous(dev, count, order, gfp);
+		page = dma_alloc_from_contiguous(dev, count, order,
+						 gfp & __GFP_NOWARN);
 		if (!page)
 			goto error;
 
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 61e93f0b5482..072c51fb07d7 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -355,7 +355,7 @@ static int __init atomic_pool_init(void)
 
 	if (dev_get_cma_area(NULL))
 		page = dma_alloc_from_contiguous(NULL, nr_pages,
-						 pool_size_order, GFP_KERNEL);
+						 pool_size_order, false);
 	else
 		page = alloc_pages(GFP_DMA32, pool_size_order);
 
@@ -573,7 +573,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 		struct page *page;
 
 		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
-						 get_order(size), gfp);
+					get_order(size), gfp & __GFP_NOWARN);
 		if (!page)
 			return NULL;
 
diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index ba4640cc0093..b2c7ba91fb08 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -137,7 +137,7 @@ static void *xtensa_dma_alloc(struct device *dev, size_t size,
 
 	if (gfpflags_allow_blocking(flag))
 		page = dma_alloc_from_contiguous(dev, count, get_order(size),
-						 flag);
+						 flag & __GFP_NOWARN);
 
 	if (!page)
 		page = alloc_pages(flag, get_order(size));
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 64cfe854e0f5..5ec97ffb561a 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2622,7 +2622,7 @@ static void *alloc_coherent(struct device *dev, size_t size,
 			return NULL;
 
 		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
-						 get_order(size), flag);
+					get_order(size), flag & __GFP_NOWARN);
 		if (!page)
 			return NULL;
 	}
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 869321c594e2..dd2d343428ab 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3746,7 +3746,8 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 	if (gfpflags_allow_blocking(flags)) {
 		unsigned int count = size >> PAGE_SHIFT;
 
-		page = dma_alloc_from_contiguous(dev, count, order, flags);
+		page = dma_alloc_from_contiguous(dev, count, order,
+						 flags & __GFP_NOWARN);
 		if (page && iommu_no_mapping(dev) &&
 		    page_to_phys(page) + size > dev->coherent_dma_mask) {
 			dma_release_from_contiguous(dev, page, count);
diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
index 3c5a4cb3eb95..f247e8aa5e3d 100644
--- a/include/linux/dma-contiguous.h
+++ b/include/linux/dma-contiguous.h
@@ -112,7 +112,7 @@ static inline int dma_declare_contiguous(struct device *dev, phys_addr_t size,
 }
 
 struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
-				       unsigned int order, gfp_t gfp_mask);
+				       unsigned int order, bool no_warn);
 bool dma_release_from_contiguous(struct device *dev, struct page *pages,
 				 int count);
 
@@ -145,7 +145,7 @@ int dma_declare_contiguous(struct device *dev, phys_addr_t size,
 
 static inline
 struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
-				       unsigned int order, gfp_t gfp_mask)
+				       unsigned int order, bool no_warn)
 {
 	return NULL;
 }
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 19ea5d70150c..286d82329eb0 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -178,7 +178,7 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
  * @dev:   Pointer to device for which the allocation is performed.
  * @count: Requested number of pages.
  * @align: Requested alignment of pages (in PAGE_SIZE order).
- * @gfp_mask: GFP flags to use for this allocation.
+ * @no_warn: Avoid printing message about failed allocation.
  *
  * This function allocates memory buffer for specified device. It uses
  * device specific contiguous memory area if available or the default
@@ -186,13 +186,12 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
  * function.
  */
 struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
-				       unsigned int align, gfp_t gfp_mask)
+				       unsigned int align, bool no_warn)
 {
 	if (align > CONFIG_CMA_ALIGNMENT)
 		align = CONFIG_CMA_ALIGNMENT;
 
-	return cma_alloc(dev_get_cma_area(dev), count, align,
-			 gfp_mask & __GFP_NOWARN);
+	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
 }
 
 /**
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 8be8106270c2..e0241beeb645 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -78,7 +78,8 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 again:
 	/* CMA can be used only in the context which permits sleeping */
 	if (gfpflags_allow_blocking(gfp)) {
-		page = dma_alloc_from_contiguous(dev, count, page_order, gfp);
+		page = dma_alloc_from_contiguous(dev, count, page_order,
+						 gfp & __GFP_NOWARN);
 		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
 			dma_release_from_contiguous(dev, page, count);
 			page = NULL;
-- 
2.17.1

