Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEE8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F4B20657
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JNUIA0Zi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfAJVNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:13:38 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:41948 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfAJVNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 16:13:38 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0AL9qN7187636;
        Thu, 10 Jan 2019 21:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2018-07-02;
 bh=/IFEDzhdI0x1IZkLHUorzjqe46w6d+OUBpCZ00v5/kI=;
 b=JNUIA0ZiLYSbjyCwAVK6/QyBmq8FL72dUceoNqR3YqbxV3KpfLrJ4/o4shwgV/QQkpbT
 i+JrwBLXO2mzCBJzNUIf2RhgKPu2jg5XHRABDtU+LXQqrUZ6aGpK2NvIydlwKaJppCdP
 j+wdmrhR7TDmOqvKgoKXVAWk8vUVI1gtKEbYePfC6zugyaJRhLJtLxHH13kyG9h5AdLz
 qJSxuJEXRAMb7+qsXPG8fmHl/+VvjCI0MtbqDIbPMADcIhXDIUSs7Ix3Av5qePZBrkqB
 7GL2jlWfvCsYjC3WOY/uiO9bWQO8zEc6KoJZ/k+sNM/QF+DyHlfh3pKl8iF6Z2h4GVQH Fw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2ptj3e9thg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 21:10:35 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0ALAZgD012185
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 21:10:35 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0ALAYF0023487;
        Thu, 10 Jan 2019 21:10:34 GMT
Received: from concerto.internal (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Jan 2019 13:10:34 -0800
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de,
        ak@linux.intel.com, torvalds@linux-foundation.org,
        liran.alon@oracle.com, keescook@google.com, konrad.wilk@oracle.com
Cc:     deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, kanth.ghatraju@oracle.com,
        joao.m.martins@oracle.com, jmattson@google.com,
        pradeep.vincent@oracle.com, john.haxby@oracle.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hch@lst.de,
        steven.sistare@oracle.com, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        "Vasileios P . Kemerlis" <vpk@cs.columbia.edu>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Tycho Andersen <tycho@docker.com>,
        Marco Benatto <marco.antonio.780@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Khalid Aziz <khalid.aziz@oracle.com>
Subject: [RFC PATCH v7 11/16] mm, x86: omit TLB flushing by default for XPFO page table modifications
Date:   Thu, 10 Jan 2019 14:09:43 -0700
Message-Id: <4e51a5d4409b54116968b8c0501f6d82c4eb9cb5.1547153058.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547153058.git.khalid.aziz@oracle.com>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1547153058.git.khalid.aziz@oracle.com>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9132 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901100164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Stecklina <jsteckli@amazon.de>

XPFO carries a large performance overhead. In my tests, I saw >40%
overhead for compiling a Linux kernel with XPFO enabled. The
frequent TLB flushes that XPFO performs are the root cause of much
of this overhead.

TLB flushing is required for full paranoia mode where we don't want
TLB entries of physmap pages to stick around potentially
indefinitely. In reality, though, these TLB entries are going to be
evicted pretty rapidly even without explicit flushing. That means
omitting TLB flushes only marginally lowers the security benefits of
XPFO. For kernel compile, omitting TLB flushes pushes the overhead
below 3%.

Change the default in XPFO to not flush TLBs unless the user
explicitly requests to do so using a kernel parameter.

Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
Cc: x86@kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: Vasileios P. Kemerlis <vpk@cs.columbia.edu>
Cc: Juerg Haefliger <juerg.haefliger@canonical.com>
Cc: Tycho Andersen <tycho@docker.com>
Cc: Marco Benatto <marco.antonio.780@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 mm/xpfo.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/mm/xpfo.c b/mm/xpfo.c
index 25fba05d01bd..e80374b0c78e 100644
--- a/mm/xpfo.c
+++ b/mm/xpfo.c
@@ -36,6 +36,7 @@ struct xpfo {
 };
 
 DEFINE_STATIC_KEY_FALSE(xpfo_inited);
+DEFINE_STATIC_KEY_FALSE(xpfo_do_tlb_flush);
 
 static bool xpfo_disabled __initdata;
 
@@ -46,7 +47,15 @@ static int __init noxpfo_param(char *str)
 	return 0;
 }
 
+static int __init xpfotlbflush_param(char *str)
+{
+	static_branch_enable(&xpfo_do_tlb_flush);
+
+	return 0;
+}
+
 early_param("noxpfo", noxpfo_param);
+early_param("xpfotlbflush", xpfotlbflush_param);
 
 static bool __init need_xpfo(void)
 {
@@ -76,6 +85,13 @@ bool __init xpfo_enabled(void)
 }
 EXPORT_SYMBOL(xpfo_enabled);
 
+
+static void xpfo_cond_flush_kernel_tlb(struct page *page, int order)
+{
+	if (static_branch_unlikely(&xpfo_do_tlb_flush))
+		xpfo_flush_kernel_tlb(page, order);
+}
+
 static inline struct xpfo *lookup_xpfo(struct page *page)
 {
 	struct page_ext *page_ext = lookup_page_ext(page);
@@ -114,12 +130,17 @@ void xpfo_alloc_pages(struct page *page, int order, gfp_t gfp)
 		     "xpfo: already mapped page being allocated\n");
 
 		if ((gfp & GFP_HIGHUSER) == GFP_HIGHUSER) {
-			/*
-			 * Tag the page as a user page and flush the TLB if it
-			 * was previously allocated to the kernel.
-			 */
-			if (!test_and_set_bit(XPFO_PAGE_USER, &xpfo->flags))
-				flush_tlb = 1;
+			if (static_branch_unlikely(&xpfo_do_tlb_flush)) {
+				/*
+				 * Tag the page as a user page and flush the TLB if it
+				 * was previously allocated to the kernel.
+				 */
+				if (!test_and_set_bit(XPFO_PAGE_USER, &xpfo->flags))
+					flush_tlb = 1;
+			} else {
+				set_bit(XPFO_PAGE_USER, &xpfo->flags);
+			}
+
 		} else {
 			/* Tag the page as a non-user (kernel) page */
 			clear_bit(XPFO_PAGE_USER, &xpfo->flags);
@@ -127,7 +148,7 @@ void xpfo_alloc_pages(struct page *page, int order, gfp_t gfp)
 	}
 
 	if (flush_tlb)
-		xpfo_flush_kernel_tlb(page, order);
+		xpfo_cond_flush_kernel_tlb(page, order);
 }
 
 void xpfo_free_pages(struct page *page, int order)
@@ -221,7 +242,7 @@ void xpfo_kunmap(void *kaddr, struct page *page)
 		     "xpfo: unmapping already unmapped page\n");
 		set_bit(XPFO_PAGE_UNMAPPED, &xpfo->flags);
 		set_kpte(kaddr, page, __pgprot(0));
-		xpfo_flush_kernel_tlb(page, 0);
+		xpfo_cond_flush_kernel_tlb(page, 0);
 	}
 
 	spin_unlock(&xpfo->maplock);
-- 
2.17.1

