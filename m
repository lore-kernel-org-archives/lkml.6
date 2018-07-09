Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E33C67790
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD162089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NgJvOrr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD162089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933178AbeGIMUn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:20:43 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45182 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932949AbeGIMUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:20:23 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180709122021euoutp013608d91fdc270b0f990a552d5bc1e004~-sqVtcZV61581215812euoutp01B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jul 2018 12:20:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180709122021euoutp013608d91fdc270b0f990a552d5bc1e004~-sqVtcZV61581215812euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1531138821;
        bh=7a8sDyhqOTgN/n1BR+E2/tqwrVB55JiXnhqmVV0jYcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NgJvOrr80+oWDTOCw5nJJRFQ2v3+WvB9B30qQ1AI3cRXU8Haks9FMbdXauDhFo5o9
         miduJJ4SGtgmKHds6Bzd7siifhU93GiDjuV2fuNfA/EAVUlqa3/5srWt0DY+Cj8SFX
         4FukRs5F68iD5pxTgICBgEHw/S8ZQx/pHGw7LhYs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180709122019eucas1p10f2fc51b8ede3712f7610523227ffe36~-sqT6-lew1760617606eucas1p1U;
        Mon,  9 Jul 2018 12:20:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C4.58.05700.303534B5; Mon,  9
        Jul 2018 13:20:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29~-sqTPJKij2939229392eucas1p2j;
        Mon,  9 Jul 2018 12:20:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180709122018eusmtrp20e11a2eb9793fdd2a5091b39dfd5f9e2~-sqS-oKnB0639506395eusmtrp2k;
        Mon,  9 Jul 2018 12:20:18 +0000 (GMT)
X-AuditID: cbfec7f2-1dbff70000011644-d0-5b4353035db5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 25.CF.04183.203534B5; Mon,  9
        Jul 2018 13:20:18 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.116.147.25]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180709122018eusmtip23ae66e3c343425162a095093782a0b9f~-sqSHyKj91870018700eusmtip22;
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
Subject: [PATCH 1/2] mm/cma: remove unsupported gfp_mask parameter from
 cma_alloc()
Date:   Mon,  9 Jul 2018 14:19:55 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180709121956.20200-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0yNcRzG/d57cex1snwXGzvmLmmYH1ku2fw2/7SZ/qgNJ71LU+G8KpeN
        dHRxpLkMSXSRcuqkpFoXt3OkY0UptEwJZXNrHZIO0XFer8t/n+d5vs+e3969Aq1N5XyEqNjd
        kiFWH63jPJnqxm8tvvSGoLCFpc3zcXaZhcOOpGQaDxSmI3w0v4jD5pJ7FDYfNXI493YAPnK+
        nMfmG04Kf3nyisIVvR0sflyXzeEXFheLbadvIjwyPMri0oZuHvdkrMK59sMsvpDt5LDV0cfi
        wZYUHjd1D/L4/KEMhN99us+sAtJnvUgRy0ULIo872mhifW3jSPrHwyyp+HySJ6b+JxTp6rjB
        kfuZIwy5XnCQPB/tpcmpziJEWjPzEKl/lsiRqz/eU8Tc3sYHe4d6roiQoqPiJYNf4BbPbXV9
        ZfzOunl70lsPMYkoZboJeQggLobn5gZeYa14BUHyIDIhTzd/QWB/M0ypYhBBYXEN+7fxIL+X
        V4MiBM6uN7QqhhDUd3cxyhUn+oOp38QpwUQxB8FLaxKrCFrsY+Gty+TuC4KXuBF6SpYoBUac
        ATmNZyh1YiqUlN+hFfYQAyGnwfV7AcRKAXpdPb8DjRgPqY4qRi2shVu1R/6wF7y3V/IqTwFX
        bQ6llo0IUjOzeFWkI6jKruHUqwC4a29jlRfR4hwoq/NT7dWQdsnIKTaI46Gzf4Ji0248WX2W
        Vm0NpKVo1euZkGW/+m/W+qidVpnA05sFrPqFTiAw9p9Ax9HUrP9juQgVo0lSnBwTKcn+sVLC
        AlkfI8fFRi7YuiOmArl/z+ZR++caNNQebkOigHTjNI5da8K0rD5e3htjQyDQuoka/XK3pYnQ
        790nGXZsNsRFS7INTRYY3STNptkHQrVipH63tF2SdkqGvyklePgkolsFfnPHVPmHV3146/CJ
        uPazqdpn7brT90IbZ4VWpq18tiho2tNzHiFFrqX5rcGyV3NTHpdsHLgUnEEeljwc+zUubMWx
        pOCE/eudnVEBU44hY8InZ6n3mcQRy3fDMDMcctl3KCiwsSV/ZmdQx8vCOVuzktaMbfW2ty07
        F2nyhcX7Iop1jLxN7z+XNsj6X0WxtcuaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSa0hTYRj2O3etxWFaHSRIJlEYTudtn5YiRfIhBJIQpJYe9KCSc7UzJQtx
        WoodTazIzHtWyvKKXVAzyqWZFg5T1MgLNkEsreWiEkWbjv4973PhfeB9GVy+QLgzqel6QZfO
        pykoF+L9xsCMNxZ9PNZ3cTAEVrU1U9Cal4/DHw3FABbVN1LQ2NSPQWPRVQrWvToCr1e209DY
        8xeDv8bmMNhhGSfhaHcVBWeaN0louvMSwLU/GyRs6Zum4WxJOKwbuEbC6qq/FOy1zpPQNlxA
        w6FpGw0rc0sAXPz5jgjn0HxvDYaaa5oBGh0fwVHvFxOFipeukahj5RaNpOUxDE2N91DoXfka
        gZ48zEGfNyw4uj3ZCJC5/D5ALz4ZKNS6/hVDxo8jdNSeGOVRnTZDL3ikaEV9qCJWBf2UqmCo
        9AsIVqr81WdD/AIVPmFHk4S01ExB5xOWoEzpnm+jL3QfvlRsziUMoMBTAs4MxwZwH+ottARc
        GDn7CHCDc7m0Q9jHDZYZSAd25dbHJcphsgEud9i2LVCsipOWHYIb+wBwK5sj5NaAs79JzlJR
        TkiAYVzZaK5rSbMVINgDXO3bMmyLlrGhXMvqIceC/VxT+2t8CzuzYVxt3+Y2ltstBUtDRCnY
        VQecHgM3IUPUJGtEP6XIa8SM9GRlolbTAexHfv529WknkL5HmwDLAMVOmfXisVg5yWeKWRoT
        4Bhc4SbjQ+yULInPuizotPG6jDRBNIFAe6ebuPvuRK39ZdL18apAlRoGq9T+av8gqNgrM/tm
        xcjZZF4vnBeEC4Lufw5jnN0NYCLihjKyckda3GRqdA8tXYma7bS2xK2dnlSUxOaHr8SfKYwI
        9po+0RWeMhCRPZWTfTegpghVnBs2nGotDK1eeN+VndP07GDODXXd2vllo3laG+Lk88Yj6N6A
        zbfhJBqMJ/tLPa0fLCBvuICfCm1JMHtPtA5FSscmjmTPdWx+y1QQYgqv8sJ1Iv8Pb7wBTvoC
        AAA=
Message-Id: <20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29~-sqTPJKij2939229392eucas1p2j@eucas1p2.samsung.com>
X-CMS-MailID: 20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29
References: <20180709121956.20200-1-m.szyprowski@samsung.com>
        <CGME20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cma_alloc() function doesn't really support gfp flags other than
__GFP_NOWARN, so convert gfp_mask parameter to boolean no_warn parameter.

This will help to avoid giving false feeling that this function supports
standard gfp flags and callers can pass __GFP_ZERO to get zeroed buffer,
what has already been an issue: see commit dd65a941f6ba ("arm64:
dma-mapping: clear buffers allocated with FORCE_CONTIGUOUS flag").

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/powerpc/kvm/book3s_hv_builtin.c       | 2 +-
 drivers/s390/char/vmcp.c                   | 2 +-
 drivers/staging/android/ion/ion_cma_heap.c | 2 +-
 include/linux/cma.h                        | 2 +-
 kernel/dma/contiguous.c                    | 3 ++-
 mm/cma.c                                   | 8 ++++----
 mm/cma_debug.c                             | 2 +-
 7 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index d4a3f4da409b..fc6bb9630a9c 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -77,7 +77,7 @@ struct page *kvm_alloc_hpt_cma(unsigned long nr_pages)
 	VM_BUG_ON(order_base_2(nr_pages) < KVM_CMA_CHUNK_ORDER - PAGE_SHIFT);
 
 	return cma_alloc(kvm_cma, nr_pages, order_base_2(HPT_ALIGN_PAGES),
-			 GFP_KERNEL);
+			 false);
 }
 EXPORT_SYMBOL_GPL(kvm_alloc_hpt_cma);
 
diff --git a/drivers/s390/char/vmcp.c b/drivers/s390/char/vmcp.c
index 948ce82a7725..0fa1b6b1491a 100644
--- a/drivers/s390/char/vmcp.c
+++ b/drivers/s390/char/vmcp.c
@@ -68,7 +68,7 @@ static void vmcp_response_alloc(struct vmcp_session *session)
 	 * anymore the system won't work anyway.
 	 */
 	if (order > 2)
-		page = cma_alloc(vmcp_cma, nr_pages, 0, GFP_KERNEL);
+		page = cma_alloc(vmcp_cma, nr_pages, 0, false);
 	if (page) {
 		session->response = (char *)page_to_phys(page);
 		session->cma_alloc = 1;
diff --git a/drivers/staging/android/ion/ion_cma_heap.c b/drivers/staging/android/ion/ion_cma_heap.c
index 49718c96bf9e..3fafd013d80a 100644
--- a/drivers/staging/android/ion/ion_cma_heap.c
+++ b/drivers/staging/android/ion/ion_cma_heap.c
@@ -39,7 +39,7 @@ static int ion_cma_allocate(struct ion_heap *heap, struct ion_buffer *buffer,
 	if (align > CONFIG_CMA_ALIGNMENT)
 		align = CONFIG_CMA_ALIGNMENT;
 
-	pages = cma_alloc(cma_heap->cma, nr_pages, align, GFP_KERNEL);
+	pages = cma_alloc(cma_heap->cma, nr_pages, align, false);
 	if (!pages)
 		return -ENOMEM;
 
diff --git a/include/linux/cma.h b/include/linux/cma.h
index bf90f0bb42bd..190184b5ff32 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -33,7 +33,7 @@ extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 					const char *name,
 					struct cma **res_cma);
 extern struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
-			      gfp_t gfp_mask);
+			      bool no_warn);
 extern bool cma_release(struct cma *cma, const struct page *pages, unsigned int count);
 
 extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data);
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index d987dcd1bd56..19ea5d70150c 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -191,7 +191,8 @@ struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
 	if (align > CONFIG_CMA_ALIGNMENT)
 		align = CONFIG_CMA_ALIGNMENT;
 
-	return cma_alloc(dev_get_cma_area(dev), count, align, gfp_mask);
+	return cma_alloc(dev_get_cma_area(dev), count, align,
+			 gfp_mask & __GFP_NOWARN);
 }
 
 /**
diff --git a/mm/cma.c b/mm/cma.c
index 5809bbe360d7..4cb76121a3ab 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -395,13 +395,13 @@ static inline void cma_debug_show_areas(struct cma *cma) { }
  * @cma:   Contiguous memory region for which the allocation is performed.
  * @count: Requested number of pages.
  * @align: Requested alignment of pages (in PAGE_SIZE order).
- * @gfp_mask:  GFP mask to use during compaction
+ * @no_warn: Avoid printing message about failed allocation
  *
  * This function allocates part of contiguous memory on specific
  * contiguous memory area.
  */
 struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
-		       gfp_t gfp_mask)
+		       bool no_warn)
 {
 	unsigned long mask, offset;
 	unsigned long pfn = -1;
@@ -447,7 +447,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 		pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
 		mutex_lock(&cma_mutex);
 		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
-					 gfp_mask);
+				     GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0));
 		mutex_unlock(&cma_mutex);
 		if (ret == 0) {
 			page = pfn_to_page(pfn);
@@ -466,7 +466,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 
 	trace_cma_alloc(pfn, page, count, align);
 
-	if (ret && !(gfp_mask & __GFP_NOWARN)) {
+	if (ret && !no_warn) {
 		pr_err("%s: alloc failed, req-size: %zu pages, ret: %d\n",
 			__func__, count, ret);
 		cma_debug_show_areas(cma);
diff --git a/mm/cma_debug.c b/mm/cma_debug.c
index f23467291cfb..ad6723e9d110 100644
--- a/mm/cma_debug.c
+++ b/mm/cma_debug.c
@@ -139,7 +139,7 @@ static int cma_alloc_mem(struct cma *cma, int count)
 	if (!mem)
 		return -ENOMEM;
 
-	p = cma_alloc(cma, count, 0, GFP_KERNEL);
+	p = cma_alloc(cma, count, 0, false);
 	if (!p) {
 		kfree(mem);
 		return -ENOMEM;
-- 
2.17.1

