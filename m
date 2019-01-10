Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA03C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029CE208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uhYxXSO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbfAJVLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:11:40 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57528 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731131AbfAJVLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 16:11:39 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0AL8loQ041393;
        Thu, 10 Jan 2019 21:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2018-07-02;
 bh=Hk38+nWLDl3nLi7YTCJ6Yd0tzUi3GaMmOjk//H1EH/4=;
 b=uhYxXSO/+zuWC4vaHaHuMFTavxikTbqRP/9BSmynD6o6Qfs9s/b9ru9AGepw0APjML8L
 t/zcQ5raQgd2hxnEuOIeQ3tDxSbyqTKVT6FNZFFa7ljeaVBa3CQAqtwsFUa9oJgUHMEN
 J1/5tStu0S/5soyx7I4gstQJ0JFuHXHoL4NIlQduCj46WdjUo+HRUfM3GlbCBZPjpZCP
 meRR+n3PdKItdFWjds7Pzwo05wntxRAKFMVuyxYxPHw2u2pUYySmPVsmEqcZwrgyZXTm
 Br+2+S7rp8VHwZgDUt9kxwdqx34UbClUTG1UlvtiwhHrxvZFpc1GovmwTm8BchLw/gP8 qQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2ptm0uhnvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 21:10:42 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0ALAfEu009909
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 21:10:42 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0ALAfLg023218;
        Thu, 10 Jan 2019 21:10:41 GMT
Received: from concerto.internal (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Jan 2019 13:10:41 -0800
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
Subject: [RFC PATCH v7 14/16] EXPERIMENTAL: xpfo, mm: optimize spin lock usage in xpfo_kmap
Date:   Thu, 10 Jan 2019 14:09:46 -0700
Message-Id: <7e8e17f519ae87a91fc6cbb57b8b27094c96305c.1547153058.git.khalid.aziz@oracle.com>
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

We can reduce spin lock usage in xpfo_kmap to the 0->1 transition of
the mapcount. This means that xpfo_kmap() can now race and that we
get spurious page faults.

The page fault handler helps the system make forward progress by
fixing the page table instead of allowing repeated page faults until
the right xpfo_kmap went through.

Model-checked with up to 4 concurrent callers with Spin.

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
 arch/x86/mm/fault.c  |  4 ++++
 include/linux/xpfo.h |  4 ++++
 mm/xpfo.c            | 50 +++++++++++++++++++++++++++++++++++++-------
 3 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index ba51652fbd33..207081dcd572 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -18,6 +18,7 @@
 #include <linux/uaccess.h>		/* faulthandler_disabled()	*/
 #include <linux/efi.h>			/* efi_recover_from_page_fault()*/
 #include <linux/mm_types.h>
+#include <linux/xpfo.h>
 
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
 #include <asm/traps.h>			/* dotraplinkage, ...		*/
@@ -1218,6 +1219,9 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 	if (kprobes_fault(regs))
 		return;
 
+	if (xpfo_spurious_fault(address))
+		return;
+
 	/*
 	 * Note, despite being a "bad area", there are quite a few
 	 * acceptable reasons to get here, such as erratum fixups
diff --git a/include/linux/xpfo.h b/include/linux/xpfo.h
index ea5188882f49..58dd243637d2 100644
--- a/include/linux/xpfo.h
+++ b/include/linux/xpfo.h
@@ -54,6 +54,8 @@ bool xpfo_enabled(void);
 
 phys_addr_t user_virt_to_phys(unsigned long addr);
 
+bool xpfo_spurious_fault(unsigned long addr);
+
 #else /* !CONFIG_XPFO */
 
 static inline void xpfo_init_single_page(struct page *page) { }
@@ -81,6 +83,8 @@ static inline bool xpfo_enabled(void) { return false; }
 
 static inline phys_addr_t user_virt_to_phys(unsigned long addr) { return 0; }
 
+static inline bool xpfo_spurious_fault(unsigned long addr) { return false; }
+
 #endif /* CONFIG_XPFO */
 
 #endif /* _LINUX_XPFO_H */
diff --git a/mm/xpfo.c b/mm/xpfo.c
index dbf20efb0499..85079377c91d 100644
--- a/mm/xpfo.c
+++ b/mm/xpfo.c
@@ -119,6 +119,16 @@ void xpfo_free_pages(struct page *page, int order)
 	}
 }
 
+static void xpfo_do_map(void *kaddr, struct page *page)
+{
+	spin_lock(&page->xpfo_lock);
+	if (PageXpfoUnmapped(page)) {
+		set_kpte(kaddr, page, PAGE_KERNEL);
+		ClearPageXpfoUnmapped(page);
+	}
+	spin_unlock(&page->xpfo_lock);
+}
+
 void xpfo_kmap(void *kaddr, struct page *page)
 {
 	if (!static_branch_unlikely(&xpfo_inited))
@@ -127,17 +137,12 @@ void xpfo_kmap(void *kaddr, struct page *page)
 	if (!PageXpfoUser(page))
 		return;
 
-	spin_lock(&page->xpfo_lock);
-
 	/*
 	 * The page was previously allocated to user space, so map it back
 	 * into the kernel. No TLB flush required.
 	 */
-	if ((atomic_inc_return(&page->xpfo_mapcount) == 1) &&
-	    TestClearPageXpfoUnmapped(page))
-		set_kpte(kaddr, page, PAGE_KERNEL);
-
-	spin_unlock(&page->xpfo_lock);
+	if (atomic_inc_return(&page->xpfo_mapcount) == 1)
+		xpfo_do_map(kaddr, page);
 }
 EXPORT_SYMBOL(xpfo_kmap);
 
@@ -204,3 +209,34 @@ void xpfo_temp_unmap(const void *addr, size_t size, void **mapping,
 			kunmap_atomic(mapping[i]);
 }
 EXPORT_SYMBOL(xpfo_temp_unmap);
+
+bool xpfo_spurious_fault(unsigned long addr)
+{
+	struct page *page;
+	bool spurious;
+	int mapcount;
+
+	if (!static_branch_unlikely(&xpfo_inited))
+		return false;
+
+	/* XXX Is this sufficient to guard against calling virt_to_page() on a
+	 * virtual address that has no corresponding struct page? */
+	if (!virt_addr_valid(addr))
+		return false;
+
+	page = virt_to_page(addr);
+	mapcount = atomic_read(&page->xpfo_mapcount);
+	spurious = PageXpfoUser(page) && mapcount;
+
+	/* Guarantee forward progress in case xpfo_kmap() raced. */
+	if (spurious && PageXpfoUnmapped(page)) {
+		xpfo_do_map((void *)(addr & PAGE_MASK), page);
+	}
+
+	if (unlikely(!spurious))
+		printk("XPFO non-spurious fault %lx user=%d unmapped=%d mapcount=%d\n",
+			addr, PageXpfoUser(page), PageXpfoUnmapped(page),
+			mapcount);
+
+	return spurious;
+}
-- 
2.17.1

