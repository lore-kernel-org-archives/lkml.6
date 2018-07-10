Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321FAC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0141F208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0141F208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389449AbeGJSfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:35:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48220 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388810AbeGJSfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:35:07 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4CC83E6B;
        Tue, 10 Jul 2018 18:34:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Tatashin <pasha.tatashin@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.17 03/56] mm: teach dump_page() to correctly output poisoned struct pages
Date:   Tue, 10 Jul 2018 20:24:45 +0200
Message-Id: <20180710182503.682613167@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182503.544433950@linuxfoundation.org>
References: <20180710182503.544433950@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Tatashin <pasha.tatashin@oracle.com>

commit fc36def997cfd6cbff3eda4f82853a5c311c5466 upstream.

If struct page is poisoned, and uninitialized access is detected via
PF_POISONED_CHECK(page) dump_page() is called to output the page.  But,
the dump_page() itself accesses struct page to determine how to print
it, and therefore gets into a recursive loop.

For example:

  dump_page()
   __dump_page()
    PageSlab(page)
     PF_POISONED_CHECK(page)
      VM_BUG_ON_PGFLAGS(PagePoisoned(page), page)
       dump_page() recursion loop.

Link: http://lkml.kernel.org/r/20180702180536.2552-1-pasha.tatashin@oracle.com
Fixes: f165b378bbdf ("mm: uninitialized struct page poisoning sanity checking")
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/debug.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

--- a/mm/debug.c
+++ b/mm/debug.c
@@ -43,12 +43,25 @@ const struct trace_print_flags vmaflag_n
 
 void __dump_page(struct page *page, const char *reason)
 {
+	bool page_poisoned = PagePoisoned(page);
+	int mapcount;
+
+	/*
+	 * If struct page is poisoned don't access Page*() functions as that
+	 * leads to recursive loop. Page*() check for poisoned pages, and calls
+	 * dump_page() when detected.
+	 */
+	if (page_poisoned) {
+		pr_emerg("page:%px is uninitialized and poisoned", page);
+		goto hex_only;
+	}
+
 	/*
 	 * Avoid VM_BUG_ON() in page_mapcount().
 	 * page->_mapcount space in struct page is used by sl[aou]b pages to
 	 * encode own info.
 	 */
-	int mapcount = PageSlab(page) ? 0 : page_mapcount(page);
+	mapcount = PageSlab(page) ? 0 : page_mapcount(page);
 
 	pr_emerg("page:%px count:%d mapcount:%d mapping:%px index:%#lx",
 		  page, page_ref_count(page), mapcount,
@@ -60,6 +73,7 @@ void __dump_page(struct page *page, cons
 
 	pr_emerg("flags: %#lx(%pGp)\n", page->flags, &page->flags);
 
+hex_only:
 	print_hex_dump(KERN_ALERT, "raw: ", DUMP_PREFIX_NONE, 32,
 			sizeof(unsigned long), page,
 			sizeof(struct page), false);
@@ -68,7 +82,7 @@ void __dump_page(struct page *page, cons
 		pr_alert("page dumped because: %s\n", reason);
 
 #ifdef CONFIG_MEMCG
-	if (page->mem_cgroup)
+	if (!page_poisoned && page->mem_cgroup)
 		pr_alert("page->mem_cgroup:%px\n", page->mem_cgroup);
 #endif
 }


