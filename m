Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318CCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CBA222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5c4qlL79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393550AbfBNAFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:05:22 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50312 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393416AbfBNAFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 19:05:22 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1DNwfsg100210;
        Thu, 14 Feb 2019 00:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2018-07-02;
 bh=MZqi6ournax3KQmG8JyBwhw5kF/1WOYT8qIrSyRL3+o=;
 b=5c4qlL7951pylpPk/LYjHCqBaQh+OE07SNEncySbv9VpXjItDk191jRy8R2qAS/Si7wk
 5azy3SAjL1y5ZU+ayiqvpGeYyYPej1QFoowA8i7hY6LnuqWwGRdVeXP9R8NT7EnzXbG6
 VmTdJcDS8tsN+qApiiulm6FgWZxe8R1C9yy4gLDgnBMg2ET8uYg5u30QJc9jnecDxXLZ
 Ws9u2vhvaPb5ONbVL/qJNVAlo/vUy0Ks8iSwt4n7n8NmKRBZtbPL12yeMBe53Z6nM1Be
 It7bqaU0WEZ+yaRGwGM5y3xEn/ALsicHwZUxBoSgDXDN78jBld75C6noZszpY4wmUtbI 7A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2qhre5n3uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 00:02:10 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1E024xT025641
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 00:02:04 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1E024Xu018660;
        Thu, 14 Feb 2019 00:02:04 GMT
Received: from concerto.internal (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 16:02:04 -0800
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de,
        ak@linux.intel.com, torvalds@linux-foundation.org,
        liran.alon@oracle.com, keescook@google.com,
        akpm@linux-foundation.org, mhocko@suse.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jmorris@namei.org,
        konrad.wilk@oracle.com
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, kanth.ghatraju@oracle.com,
        oao.m.martins@oracle.com, jmattson@google.com,
        pradeep.vincent@oracle.com, john.haxby@oracle.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hch@lst.de,
        steven.sistare@oracle.com, labbott@redhat.com, luto@kernel.org,
        dave.hansen@intel.com, peterz@infradead.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tycho Andersen <tycho@docker.com>
Subject: [RFC PATCH v8 04/14] swiotlb: Map the buffer if it was unmapped by XPFO
Date:   Wed, 13 Feb 2019 17:01:27 -0700
Message-Id: <b595ffb3231dfef3c6b6c896a8e1cba0e838978c.1550088114.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1550088114.git.khalid.aziz@oracle.com>
References: <cover.1550088114.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1550088114.git.khalid.aziz@oracle.com>
References: <cover.1550088114.git.khalid.aziz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=845 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902130157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juerg Haefliger <juerg.haefliger@canonical.com>

v6: * guard against lookup_xpfo() returning NULL

CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Signed-off-by: Tycho Andersen <tycho@docker.com>
Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 include/linux/xpfo.h |  4 ++++
 kernel/dma/swiotlb.c |  3 ++-
 mm/xpfo.c            | 15 +++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/xpfo.h b/include/linux/xpfo.h
index b15234745fb4..cba37ffb09b1 100644
--- a/include/linux/xpfo.h
+++ b/include/linux/xpfo.h
@@ -36,6 +36,8 @@ void xpfo_kunmap(void *kaddr, struct page *page);
 void xpfo_alloc_pages(struct page *page, int order, gfp_t gfp);
 void xpfo_free_pages(struct page *page, int order);
 
+bool xpfo_page_is_unmapped(struct page *page);
+
 #else /* !CONFIG_XPFO */
 
 static inline void xpfo_kmap(void *kaddr, struct page *page) { }
@@ -43,6 +45,8 @@ static inline void xpfo_kunmap(void *kaddr, struct page *page) { }
 static inline void xpfo_alloc_pages(struct page *page, int order, gfp_t gfp) { }
 static inline void xpfo_free_pages(struct page *page, int order) { }
 
+static inline bool xpfo_page_is_unmapped(struct page *page) { return false; }
+
 #endif /* CONFIG_XPFO */
 
 #endif /* _LINUX_XPFO_H */
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 045930e32c0e..820a54b57491 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -396,8 +396,9 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
 {
 	unsigned long pfn = PFN_DOWN(orig_addr);
 	unsigned char *vaddr = phys_to_virt(tlb_addr);
+	struct page *page = pfn_to_page(pfn);
 
-	if (PageHighMem(pfn_to_page(pfn))) {
+	if (PageHighMem(page) || xpfo_page_is_unmapped(page)) {
 		/* The buffer does not have a mapping.  Map it in and copy */
 		unsigned int offset = orig_addr & ~PAGE_MASK;
 		char *buffer;
diff --git a/mm/xpfo.c b/mm/xpfo.c
index 24b33d3c20cb..67884736bebe 100644
--- a/mm/xpfo.c
+++ b/mm/xpfo.c
@@ -221,3 +221,18 @@ void xpfo_kunmap(void *kaddr, struct page *page)
 	spin_unlock(&xpfo->maplock);
 }
 EXPORT_SYMBOL(xpfo_kunmap);
+
+bool xpfo_page_is_unmapped(struct page *page)
+{
+	struct xpfo *xpfo;
+
+	if (!static_branch_unlikely(&xpfo_inited))
+		return false;
+
+	xpfo = lookup_xpfo(page);
+	if (unlikely(!xpfo) && !xpfo->inited)
+		return false;
+
+	return test_bit(XPFO_PAGE_UNMAPPED, &xpfo->flags);
+}
+EXPORT_SYMBOL(xpfo_page_is_unmapped);
-- 
2.17.1

