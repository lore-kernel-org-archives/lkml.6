Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFA2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85071218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HWgMzsoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404534AbfBNAGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:06:11 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48096 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391135AbfBNAGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 19:06:11 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1DNwk6t099402;
        Thu, 14 Feb 2019 00:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2018-07-02;
 bh=Ov6dF12doUxji6ePINUtaYIJxqhm2/VTB1zpiOjT1tA=;
 b=HWgMzsoVLWuxYs5bJDKNiffhWGRMwUJsNHgz0cMMCPscT4fdXMdRnfNdp9sKENEJvwft
 TXF3uWQrqHXeKNtriV1PxiSLggLWtrKHDZbqDPKfC2vSDmyGgCvykt4L33owldrq6md1
 TQQBpA6dSqxhEIVIk5w1iCvxCAnQfbKcOuFvv8SErUpmXO8Gu4GIlFIIKLHDLf3O5o4+
 ufPr2YjYEzK5U4hHeZSfwBGrufuBkFk0aiuvWEs187yLF1EZ2nbUxudhQYjrx/FwpdC3
 jHTyqjS/1miNz9E4XceIQ4rlIkCOYGq8Vpq/8qTkxjsEyQH8SgC1/wxD+ys2W18dm4Sm 2A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2qhree55nq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 00:02:30 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1E02TBh001559
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 00:02:30 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1E02TYJ018941;
        Thu, 14 Feb 2019 00:02:29 GMT
Received: from concerto.internal (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 16:02:29 -0800
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de,
        ak@linux.intel.com, torvalds@linux-foundation.org,
        liran.alon@oracle.com, keescook@google.com,
        akpm@linux-foundation.org, mhocko@suse.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jmorris@namei.org,
        konrad.wilk@oracle.com
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, deepa.srinivasan@oracle.com,
        chris.hyser@oracle.com, tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, kanth.ghatraju@oracle.com,
        oao.m.martins@oracle.com, jmattson@google.com,
        pradeep.vincent@oracle.com, john.haxby@oracle.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hch@lst.de,
        steven.sistare@oracle.com, labbott@redhat.com, luto@kernel.org,
        dave.hansen@intel.com, peterz@infradead.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v8 14/14] xpfo, mm: Optimize XPFO TLB flushes by batching them together
Date:   Wed, 13 Feb 2019 17:01:37 -0700
Message-Id: <6a92971cd9b360ec1b0ae75887f33f67774d681a.1550088114.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1550088114.git.khalid.aziz@oracle.com>
References: <cover.1550088114.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1550088114.git.khalid.aziz@oracle.com>
References: <cover.1550088114.git.khalid.aziz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902130157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When XPFO forces a TLB flush on all cores, the performance impact is
very significant. Batching as many of these TLB updates as
possible can help lower this impact. When a userspace allocates a
page, kernel tries to get that page from the per-cpu free list.
This free list is replenished in bulk when it runs low. Free
list is being replenished for future allocation to userspace is a
good opportunity to update TLB entries in batch and reduce the
impact of multiple TLB flushes later. This patch adds new tags for
the page so a page can be marked as available for userspace
allocation and unmapped from kernel address space. All such pages
are removed from kernel address space in bulk at the time they are
added to per-cpu free list. This patch when combined with deferred
TLB flushes improves performance further. Using the same benchmark
as before of building kernel in parallel, here are the system
times on two differently sized systems:

Hardware: 96-core Intel Xeon Platinum 8160 CPU @ 2.10GHz, 768 GB RAM
make -j60 all

4.20					950.966s
4.20+XPFO				25073.169s	26.366x
4.20+XPFO+Deferred flush		1372.874s	1.44x
4.20+XPFO+Deferred flush+Batch update	1255.021s	1.32x

Hardware: 4-core Intel Core i5-3550 CPU @ 3.30GHz, 8G RAM
make -j4 all

4.20					607.671s
4.20+XPFO				1588.646s	2.614x
4.20+XPFO+Deferred flush		803.989s	1.32x
4.20+XPFO+Deferred flush+Batch update	795.728s	1.31x

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 arch/x86/mm/xpfo.c         |  5 +++++
 include/linux/page-flags.h |  5 ++++-
 include/linux/xpfo.h       |  8 ++++++++
 mm/page_alloc.c            |  4 ++++
 mm/xpfo.c                  | 35 +++++++++++++++++++++++++++++++++--
 5 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/xpfo.c b/arch/x86/mm/xpfo.c
index d3833532bfdc..fb06bb3cb718 100644
--- a/arch/x86/mm/xpfo.c
+++ b/arch/x86/mm/xpfo.c
@@ -87,6 +87,11 @@ inline void set_kpte(void *kaddr, struct page *page, pgprot_t prot)
 
 }
 
+void xpfo_flush_tlb_all(void)
+{
+	xpfo_flush_tlb_kernel_range(0, TLB_FLUSH_ALL);
+}
+
 inline void xpfo_flush_kernel_tlb(struct page *page, int order)
 {
 	int level;
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index a532063f27b5..fdf7e14cbc96 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -406,9 +406,11 @@ PAGEFLAG(Idle, idle, PF_ANY)
 PAGEFLAG(XpfoUser, xpfo_user, PF_ANY)
 TESTCLEARFLAG(XpfoUser, xpfo_user, PF_ANY)
 TESTSETFLAG(XpfoUser, xpfo_user, PF_ANY)
+#define __PG_XPFO_USER	(1UL << PG_xpfo_user)
 PAGEFLAG(XpfoUnmapped, xpfo_unmapped, PF_ANY)
 TESTCLEARFLAG(XpfoUnmapped, xpfo_unmapped, PF_ANY)
 TESTSETFLAG(XpfoUnmapped, xpfo_unmapped, PF_ANY)
+#define __PG_XPFO_UNMAPPED	(1UL << PG_xpfo_unmapped)
 #endif
 
 /*
@@ -787,7 +789,8 @@ static inline void ClearPageSlabPfmemalloc(struct page *page)
  * alloc-free cycle to prevent from reusing the page.
  */
 #define PAGE_FLAGS_CHECK_AT_PREP	\
-	(((1UL << NR_PAGEFLAGS) - 1) & ~__PG_HWPOISON)
+	(((1UL << NR_PAGEFLAGS) - 1) & ~__PG_HWPOISON & ~__PG_XPFO_USER & \
+					~__PG_XPFO_UNMAPPED)
 
 #define PAGE_FLAGS_PRIVATE				\
 	(1UL << PG_private | 1UL << PG_private_2)
diff --git a/include/linux/xpfo.h b/include/linux/xpfo.h
index 1dd590ff1a1f..c4f6c99e7380 100644
--- a/include/linux/xpfo.h
+++ b/include/linux/xpfo.h
@@ -34,6 +34,7 @@ void set_kpte(void *kaddr, struct page *page, pgprot_t prot);
 void xpfo_dma_map_unmap_area(bool map, const void *addr, size_t size,
 				    enum dma_data_direction dir);
 void xpfo_flush_kernel_tlb(struct page *page, int order);
+void xpfo_flush_tlb_all(void);
 
 void xpfo_kmap(void *kaddr, struct page *page);
 void xpfo_kunmap(void *kaddr, struct page *page);
@@ -55,6 +56,8 @@ bool xpfo_enabled(void);
 
 phys_addr_t user_virt_to_phys(unsigned long addr);
 
+bool xpfo_pcp_refill(struct page *page, enum migratetype migratetype,
+		     int order);
 #else /* !CONFIG_XPFO */
 
 static inline void xpfo_init_single_page(struct page *page) { }
@@ -82,6 +85,11 @@ static inline bool xpfo_enabled(void) { return false; }
 
 static inline phys_addr_t user_virt_to_phys(unsigned long addr) { return 0; }
 
+static inline bool xpfo_pcp_refill(struct page *page,
+				   enum migratetype migratetype, int order)
+{
+}
+
 #endif /* CONFIG_XPFO */
 
 #endif /* _LINUX_XPFO_H */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d00382b20001..5702b6fa435c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2478,6 +2478,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 			int migratetype)
 {
 	int i, alloced = 0;
+	bool flush_tlb = false;
 
 	spin_lock(&zone->lock);
 	for (i = 0; i < count; ++i) {
@@ -2503,6 +2504,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		if (is_migrate_cma(get_pcppage_migratetype(page)))
 			__mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
 					      -(1 << order));
+		flush_tlb |= xpfo_pcp_refill(page, migratetype, order);
 	}
 
 	/*
@@ -2513,6 +2515,8 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	 */
 	__mod_zone_page_state(zone, NR_FREE_PAGES, -(i << order));
 	spin_unlock(&zone->lock);
+	if (flush_tlb)
+		xpfo_flush_tlb_all();
 	return alloced;
 }
 
diff --git a/mm/xpfo.c b/mm/xpfo.c
index 5157cbebce4b..7f78d00df002 100644
--- a/mm/xpfo.c
+++ b/mm/xpfo.c
@@ -47,7 +47,8 @@ void __meminit xpfo_init_single_page(struct page *page)
 
 void xpfo_alloc_pages(struct page *page, int order, gfp_t gfp)
 {
-	int i, flush_tlb = 0;
+	int i;
+	bool flush_tlb = false;
 
 	if (!static_branch_unlikely(&xpfo_inited))
 		return;
@@ -65,7 +66,7 @@ void xpfo_alloc_pages(struct page *page, int order, gfp_t gfp)
 			 * was previously allocated to the kernel.
 			 */
 			if (!TestSetPageXpfoUser(page + i))
-				flush_tlb = 1;
+				flush_tlb = true;
 		} else {
 			/* Tag the page as a non-user (kernel) page */
 			ClearPageXpfoUser(page + i);
@@ -74,6 +75,8 @@ void xpfo_alloc_pages(struct page *page, int order, gfp_t gfp)
 
 	if (flush_tlb)
 		xpfo_flush_kernel_tlb(page, order);
+
+	return;
 }
 
 void xpfo_free_pages(struct page *page, int order)
@@ -190,3 +193,31 @@ void xpfo_temp_unmap(const void *addr, size_t size, void **mapping,
 			kunmap_atomic(mapping[i]);
 }
 EXPORT_SYMBOL(xpfo_temp_unmap);
+
+bool xpfo_pcp_refill(struct page *page, enum migratetype migratetype,
+		     int order)
+{
+	int i;
+	bool flush_tlb = false;
+
+	if (!static_branch_unlikely(&xpfo_inited))
+		return false;
+
+	for (i = 0; i < 1 << order; i++) {
+		if (migratetype == MIGRATE_MOVABLE) {
+			/* GPF_HIGHUSER **
+			 * Tag the page as a user page, mark it as unmapped
+			 * in kernel space and flush the TLB if it was
+			 * previously allocated to the kernel.
+			 */
+			if (!TestSetPageXpfoUnmapped(page + i))
+				flush_tlb = true;
+			SetPageXpfoUser(page + i);
+		} else {
+			/* Tag the page as a non-user (kernel) page */
+			ClearPageXpfoUser(page + i);
+		}
+	}
+
+	return(flush_tlb);
+}
-- 
2.17.1

