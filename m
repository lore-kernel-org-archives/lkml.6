Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568CDC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2692064D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2692064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeI0Bav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:30:51 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:2656 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727254AbeI0B3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:29:42 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 26 Sep 2018 12:15:01 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id A3B6AB0E89;
        Wed, 26 Sep 2018 15:15:09 -0400 (EDT)
From:   Nadav Amit <namit@vmware.com>
To:     Arnd Bergmann <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>
Subject: [PATCH v3 09/20] vmw_balloon: refactor change size from vmballoon_work
Date:   Wed, 26 Sep 2018 12:13:25 -0700
Message-ID: <20180926191336.101885-10-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926191336.101885-1-namit@vmware.com>
References: <20180926191336.101885-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The required change in the balloon size is currently computed in
vmballoon_work(), vmballoon_inflate() and vmballoon_deflate(). Refactor
it to simplify the next patches.

Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 75 ++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 23 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 626abe65eddb..0d9f223d463e 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -633,6 +633,37 @@ static void vmballoon_add_page(struct vmballoon *b, int idx, struct page *p)
 		b->page = p;
 }
 
+/**
+ * vmballoon_change - retrieve the required balloon change
+ *
+ * @b: pointer for the balloon.
+ *
+ * Return: the required change for the balloon size. A positive number
+ * indicates inflation, a negative number indicates a deflation.
+ */
+static int64_t vmballoon_change(struct vmballoon *b)
+{
+	int64_t size, target;
+
+	size = b->size;
+	target = b->target;
+
+	/*
+	 * We must cast first because of int sizes
+	 * Otherwise we might get huge positives instead of negatives
+	 */
+
+	if (b->reset_required)
+		return 0;
+
+	/* consider a 2MB slack on deflate, unless the balloon is emptied */
+	if (target < size && size - target < vmballoon_page_size(true) &&
+	    target != 0)
+		return 0;
+
+	return target - size;
+}
+
 /*
  * Inflate the balloon towards its target size. Note that we try to limit
  * the rate of allocation to make sure we are not choking the rest of the
@@ -644,8 +675,6 @@ static void vmballoon_inflate(struct vmballoon *b)
 	int error = 0;
 	bool is_2m_pages;
 
-	pr_debug("%s - size: %d, target %d\n", __func__, b->size, b->target);
-
 	/*
 	 * First try NOSLEEP page allocations to inflate balloon.
 	 *
@@ -667,11 +696,8 @@ static void vmballoon_inflate(struct vmballoon *b)
 	 */
 	is_2m_pages = b->supported_page_sizes == VMW_BALLOON_NUM_PAGE_SIZES;
 
-	pr_debug("%s - goal: %d",  __func__, b->target - b->size);
-
-	while (!b->reset_required &&
-		b->size + num_pages * vmballoon_page_size(is_2m_pages)
-		< b->target) {
+	while ((int64_t)(num_pages * vmballoon_page_size(is_2m_pages)) <
+	       vmballoon_change(b)) {
 		struct page *page;
 
 		STATS_INC(b->stats.alloc[is_2m_pages]);
@@ -742,8 +768,6 @@ static void vmballoon_deflate(struct vmballoon *b)
 {
 	unsigned is_2m_pages;
 
-	pr_debug("%s - size: %d, target %d\n", __func__, b->size, b->target);
-
 	/* free pages to reach target */
 	for (is_2m_pages = 0; is_2m_pages < b->supported_page_sizes;
 			is_2m_pages++) {
@@ -753,11 +777,9 @@ static void vmballoon_deflate(struct vmballoon *b)
 				&b->page_sizes[is_2m_pages];
 
 		list_for_each_entry_safe(page, next, &page_size->pages, lru) {
-			if (b->reset_required ||
-				(b->target > 0 &&
-					b->size - num_pages
-					* vmballoon_page_size(is_2m_pages)
-				< b->target + vmballoon_page_size(true)))
+			if ((int64_t)(num_pages *
+				      vmballoon_page_size(is_2m_pages)) >=
+					-vmballoon_change(b))
 				break;
 
 			list_del(&page->lru);
@@ -921,28 +943,35 @@ static void vmballoon_reset(struct vmballoon *b)
 		pr_err("failed to send guest ID to the host\n");
 }
 
-/*
- * Balloon work function: reset protocol, if needed, get the new size and
- * adjust balloon as needed. Repeat in 1 sec.
+/**
+ * vmballoon_work - periodic balloon worker for reset, inflation and deflation.
+ *
+ * @work: pointer to the &work_struct which is provided by the workqueue.
+ *
+ * Resets the protocol if needed, gets the new size and adjusts balloon as
+ * needed. Repeat in 1 sec.
  */
 static void vmballoon_work(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
 	struct vmballoon *b = container_of(dwork, struct vmballoon, dwork);
+	int64_t change = 0;
 
 	STATS_INC(b->stats.timer);
 
 	if (b->reset_required)
 		vmballoon_reset(b);
 
-	if (!b->reset_required && vmballoon_send_get_target(b)) {
-		unsigned long target = b->target;
+	if (vmballoon_send_get_target(b))
+		change = vmballoon_change(b);
+
+	if (change != 0) {
+		pr_debug("%s - size: %u, target %u", __func__,
+			 b->size, b->target);
 
-		/* update target, adjust size */
-		if (b->size < target)
+		if (change > 0)
 			vmballoon_inflate(b);
-		else if (target == 0 ||
-				b->size > target + vmballoon_page_size(true))
+		else  /* (change < 0) */
 			vmballoon_deflate(b);
 	}
 
-- 
2.17.1

