Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3A6C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D042087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D042087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388205AbeITXQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:16:37 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:8434 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726582AbeITXQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:16:37 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 20 Sep 2018 10:31:47 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 8B6E540691;
        Thu, 20 Sep 2018 10:31:48 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>,
        Xavier Deguillard <xdeguillard@vmware.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v2 20/20] vmw_balloon: split refused pages
Date:   Thu, 20 Sep 2018 10:30:26 -0700
Message-ID: <20180920173026.141333-21-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920173026.141333-1-namit@vmware.com>
References: <20180920173026.141333-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hypervisor might refuse to inflate pages. While the balloon driver
handles this scenario correctly, a refusal to inflate a 2MB pages might
cause the same page to be allocated again later just for its inflation
to be refused again. This wastes energy and time.

To avoid this situation we split the 2MB page to 4KB pages, and then try
to inflate each one individually. Most of the 4KB pages out of the 2MB
should be inflated successfully, and we are likely to prevent the
scenario of repeated refused inflation.

Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 63 +++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 75407be8ddbc..34fceb82fe85 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -233,6 +233,7 @@ static DEFINE_STATIC_KEY_FALSE(balloon_stat_enabled);
 struct vmballoon_ctl {
 	struct list_head pages;
 	struct list_head refused_pages;
+	struct list_head prealloc_pages;
 	unsigned int n_refused_pages;
 	unsigned int n_pages;
 	enum vmballoon_page_size_type page_size;
@@ -632,15 +633,25 @@ static int vmballoon_alloc_page_list(struct vmballoon *b,
 	unsigned int i;
 
 	for (i = 0; i < req_n_pages; i++) {
-		if (ctl->page_size == VMW_BALLOON_2M_PAGE)
-			page = alloc_pages(__GFP_HIGHMEM|__GFP_NOWARN|
+		/*
+		 * First check if we happen to have pages that were allocated
+		 * before. This happens when 2MB page rejected during inflation
+		 * by the hypervisor, and then split into 4KB pages.
+		 */
+		if (!list_empty(&ctl->prealloc_pages)) {
+			page = list_first_entry(&ctl->prealloc_pages,
+						struct page, lru);
+			list_del(&page->lru);
+		} else {
+			if (ctl->page_size == VMW_BALLOON_2M_PAGE)
+				page = alloc_pages(__GFP_HIGHMEM|__GFP_NOWARN|
 					__GFP_NOMEMALLOC, VMW_BALLOON_2M_ORDER);
-		else
-			page = balloon_page_alloc();
+			else
+				page = balloon_page_alloc();
 
-		/* Update statistics */
-		vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_ALLOC,
-					 ctl->page_size);
+			vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_ALLOC,
+						 ctl->page_size);
+		}
 
 		if (page) {
 			/* Success. Add the page to the list and continue. */
@@ -884,7 +895,8 @@ static void vmballoon_release_page_list(struct list_head *page_list,
 		__free_pages(page, vmballoon_page_order(page_size));
 	}
 
-	*n_pages = 0;
+	if (n_pages)
+		*n_pages = 0;
 }
 
 
@@ -1016,6 +1028,32 @@ static void vmballoon_dequeue_page_list(struct vmballoon *b,
 	*n_pages = i;
 }
 
+/**
+ * vmballoon_split_refused_pages() - Split the 2MB refused pages to 4k.
+ *
+ * If inflation of 2MB pages was denied by the hypervisor, it is likely to be
+ * due to one or few 4KB pages. These 2MB pages may keep being allocated and
+ * then being refused. To prevent this case, this function splits the refused
+ * pages into 4KB pages and adds them into @prealloc_pages list.
+ *
+ * @ctl: pointer for the %struct vmballoon_ctl, which defines the operation.
+ */
+static void vmballoon_split_refused_pages(struct vmballoon_ctl *ctl)
+{
+	struct page *page, *tmp;
+	unsigned int i, order;
+
+	order = vmballoon_page_order(ctl->page_size);
+
+	list_for_each_entry_safe(page, tmp, &ctl->refused_pages, lru) {
+		list_del(&page->lru);
+		split_page(page, order);
+		for (i = 0; i < (1 << order); i++)
+			list_add(&page[i].lru, &ctl->prealloc_pages);
+	}
+	ctl->n_refused_pages = 0;
+}
+
 /**
  * vmballoon_inflate() - Inflate the balloon towards its target size.
  *
@@ -1027,6 +1065,7 @@ static void vmballoon_inflate(struct vmballoon *b)
 	struct vmballoon_ctl ctl = {
 		.pages = LIST_HEAD_INIT(ctl.pages),
 		.refused_pages = LIST_HEAD_INIT(ctl.refused_pages),
+		.prealloc_pages = LIST_HEAD_INIT(ctl.prealloc_pages),
 		.page_size = b->max_page_size,
 		.op = VMW_BALLOON_INFLATE
 	};
@@ -1074,10 +1113,10 @@ static void vmballoon_inflate(struct vmballoon *b)
 				break;
 
 			/*
-			 * Ignore errors from locking as we now switch to 4k
-			 * pages and we might get different errors.
+			 * Split the refused pages to 4k. This will also empty
+			 * the refused pages list.
 			 */
-			vmballoon_release_refused_pages(b, &ctl);
+			vmballoon_split_refused_pages(&ctl);
 			ctl.page_size--;
 		}
 
@@ -1091,6 +1130,8 @@ static void vmballoon_inflate(struct vmballoon *b)
 	 */
 	if (ctl.n_refused_pages != 0)
 		vmballoon_release_refused_pages(b, &ctl);
+
+	vmballoon_release_page_list(&ctl.prealloc_pages, NULL, ctl.page_size);
 }
 
 /**
-- 
2.17.1

