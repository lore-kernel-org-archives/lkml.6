Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE251C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DAE2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSP1lB2r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DAE2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbeJKXOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:14:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbeJKXOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:14:45 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D89072098A;
        Thu, 11 Oct 2018 15:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272819;
        bh=rrC7dPBwSyL2825PAm8CUP+rWhwCwR+TxP72PhRB2p4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iSP1lB2rXO/u9IjwYsmDJD2jxl2+vOTHSLUSRUeZTA2vdrEFQtxwqxuaRrx1nMpGk
         FrnYU0Y0Wxb66rEIagKfKQy0NP0HscmpL5W+1grAcxVczKNQsbtk2auvLxtKBlgCuL
         m7aVeF3LRTAmHQMSrnnSlH88m+ufLPe7MPAdlCa0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Michal Hocko <mhocko@suse.com>,
        Wei Wang <wei.w.wang@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 43/45] virtio_balloon: fix deadlock on OOM
Date:   Thu, 11 Oct 2018 17:40:10 +0200
Message-Id: <20181011152510.807351989@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152508.885515042@linuxfoundation.org>
References: <20181011152508.885515042@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael S. Tsirkin <mst@redhat.com>

commit c7cdff0e864713a089d7cb3a2b1136ba9a54881a upstream.

fill_balloon doing memory allocations under balloon_lock
can cause a deadlock when leak_balloon is called from
virtballoon_oom_notify and tries to take same lock.

To fix, split page allocation and enqueue and do allocations outside the lock.

Here's a detailed analysis of the deadlock by Tetsuo Handa:

In leak_balloon(), mutex_lock(&vb->balloon_lock) is called in order to
serialize against fill_balloon(). But in fill_balloon(),
alloc_page(GFP_HIGHUSER[_MOVABLE] | __GFP_NOMEMALLOC | __GFP_NORETRY) is
called with vb->balloon_lock mutex held. Since GFP_HIGHUSER[_MOVABLE]
implies __GFP_DIRECT_RECLAIM | __GFP_IO | __GFP_FS, despite __GFP_NORETRY
is specified, this allocation attempt might indirectly depend on somebody
else's __GFP_DIRECT_RECLAIM memory allocation. And such indirect
__GFP_DIRECT_RECLAIM memory allocation might call leak_balloon() via
virtballoon_oom_notify() via blocking_notifier_call_chain() callback via
out_of_memory() when it reached __alloc_pages_may_oom() and held oom_lock
mutex. Since vb->balloon_lock mutex is already held by fill_balloon(), it
will cause OOM lockup.

  Thread1                                       Thread2
    fill_balloon()
      takes a balloon_lock
      balloon_page_enqueue()
        alloc_page(GFP_HIGHUSER_MOVABLE)
          direct reclaim (__GFP_FS context)       takes a fs lock
            waits for that fs lock                  alloc_page(GFP_NOFS)
                                                      __alloc_pages_may_oom()
                                                        takes the oom_lock
                                                        out_of_memory()
                                                          blocking_notifier_call_chain()
                                                            leak_balloon()
                                                              tries to take that balloon_lock and deadlocks

Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/virtio/virtio_balloon.c    |   24 +++++++++++++++++++-----
 include/linux/balloon_compaction.h |   35 ++++++++++++++++++++++++++++++++++-
 mm/balloon_compaction.c            |   28 +++++++++++++++++++++-------
 3 files changed, 74 insertions(+), 13 deletions(-)

--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -143,16 +143,17 @@ static void set_page_pfns(struct virtio_
 
 static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
 {
-	struct balloon_dev_info *vb_dev_info = &vb->vb_dev_info;
 	unsigned num_allocated_pages;
+	unsigned num_pfns;
+	struct page *page;
+	LIST_HEAD(pages);
 
 	/* We can only do one array worth at a time. */
 	num = min(num, ARRAY_SIZE(vb->pfns));
 
-	mutex_lock(&vb->balloon_lock);
-	for (vb->num_pfns = 0; vb->num_pfns < num;
-	     vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
-		struct page *page = balloon_page_enqueue(vb_dev_info);
+	for (num_pfns = 0; num_pfns < num;
+	     num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
+		struct page *page = balloon_page_alloc();
 
 		if (!page) {
 			dev_info_ratelimited(&vb->vdev->dev,
@@ -162,6 +163,19 @@ static unsigned fill_balloon(struct virt
 			msleep(200);
 			break;
 		}
+
+		balloon_page_push(&pages, page);
+	}
+
+	mutex_lock(&vb->balloon_lock);
+
+	vb->num_pfns = 0;
+
+	while ((page = balloon_page_pop(&pages))) {
+		balloon_page_enqueue(&vb->vb_dev_info, page);
+
+		vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE;
+
 		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
 		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
 		if (!virtio_has_feature(vb->vdev,
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -50,6 +50,7 @@
 #include <linux/gfp.h>
 #include <linux/err.h>
 #include <linux/fs.h>
+#include <linux/list.h>
 
 /*
  * Balloon device information descriptor.
@@ -67,7 +68,9 @@ struct balloon_dev_info {
 	struct inode *inode;
 };
 
-extern struct page *balloon_page_enqueue(struct balloon_dev_info *b_dev_info);
+extern struct page *balloon_page_alloc(void);
+extern void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
+				 struct page *page);
 extern struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info);
 
 static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
@@ -193,4 +196,34 @@ static inline gfp_t balloon_mapping_gfp_
 }
 
 #endif /* CONFIG_BALLOON_COMPACTION */
+
+/*
+ * balloon_page_push - insert a page into a page list.
+ * @head : pointer to list
+ * @page : page to be added
+ *
+ * Caller must ensure the page is private and protect the list.
+ */
+static inline void balloon_page_push(struct list_head *pages, struct page *page)
+{
+	list_add(&page->lru, pages);
+}
+
+/*
+ * balloon_page_pop - remove a page from a page list.
+ * @head : pointer to list
+ * @page : page to be added
+ *
+ * Caller must ensure the page is private and protect the list.
+ */
+static inline struct page *balloon_page_pop(struct list_head *pages)
+{
+	struct page *page = list_first_entry_or_null(pages, struct page, lru);
+
+	if (!page)
+		return NULL;
+
+	list_del(&page->lru);
+	return page;
+}
 #endif /* _LINUX_BALLOON_COMPACTION_H */
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -11,22 +11,37 @@
 #include <linux/balloon_compaction.h>
 
 /*
+ * balloon_page_alloc - allocates a new page for insertion into the balloon
+ *			  page list.
+ *
+ * Driver must call it to properly allocate a new enlisted balloon page.
+ * Driver must call balloon_page_enqueue before definitively removing it from
+ * the guest system.  This function returns the page address for the recently
+ * allocated page or NULL in the case we fail to allocate a new page this turn.
+ */
+struct page *balloon_page_alloc(void)
+{
+	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
+				       __GFP_NOMEMALLOC | __GFP_NORETRY);
+	return page;
+}
+EXPORT_SYMBOL_GPL(balloon_page_alloc);
+
+/*
  * balloon_page_enqueue - allocates a new page and inserts it into the balloon
  *			  page list.
  * @b_dev_info: balloon device descriptor where we will insert a new page to
+ * @page: new page to enqueue - allocated using balloon_page_alloc.
  *
- * Driver must call it to properly allocate a new enlisted balloon page
+ * Driver must call it to properly enqueue a new allocated balloon page
  * before definitively removing it from the guest system.
  * This function returns the page address for the recently enqueued page or
  * NULL in the case we fail to allocate a new page this turn.
  */
-struct page *balloon_page_enqueue(struct balloon_dev_info *b_dev_info)
+void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
+			  struct page *page)
 {
 	unsigned long flags;
-	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
-				       __GFP_NOMEMALLOC | __GFP_NORETRY);
-	if (!page)
-		return NULL;
 
 	/*
 	 * Block others from accessing the 'page' when we get around to
@@ -39,7 +54,6 @@ struct page *balloon_page_enqueue(struct
 	__count_vm_event(BALLOON_INFLATE);
 	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
 	unlock_page(page);
-	return page;
 }
 EXPORT_SYMBOL_GPL(balloon_page_enqueue);
 


