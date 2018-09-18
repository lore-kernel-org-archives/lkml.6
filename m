Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B93ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9962086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9962086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbeIRMLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 08:11:32 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36971 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728850AbeIRMLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 08:11:31 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 17 Sep 2018 23:39:55 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id AA7914084F;
        Mon, 17 Sep 2018 23:40:19 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 04/19] vmw_balloon: simplifying batch access
Date:   Mon, 17 Sep 2018 23:38:38 -0700
Message-ID: <20180918063853.198332-5-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180918063853.198332-1-namit@vmware.com>
References: <20180918063853.198332-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <nadav.amit@gmail.com>

The use of accessors for batch entries complicates the code and makes it
less readable. Remove it an instead use bit-fields.

Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <nadav.amit@gmail.com>
---
 drivers/misc/vmw_balloon.c | 81 ++++++++++++++------------------------
 1 file changed, 30 insertions(+), 51 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 5e5f61f207f4..7af70fc988b9 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -121,24 +121,6 @@ enum vmwballoon_capabilities {
 
 #define VMW_BALLOON_SUCCESS_WITH_CAPABILITIES	(0x03000000)
 
-/* Batch page description */
-
-/*
- * Layout of a page in the batch page:
- *
- * +-------------+----------+--------+
- * |             |          |        |
- * | Page number | Reserved | Status |
- * |             |          |        |
- * +-------------+----------+--------+
- * 64  PAGE_SHIFT          6         0
- *
- * The reserved field should be set to 0.
- */
-#define VMW_BALLOON_BATCH_MAX_PAGES	(PAGE_SIZE / sizeof(u64))
-#define VMW_BALLOON_BATCH_STATUS_MASK	((1UL << 5) - 1)
-#define VMW_BALLOON_BATCH_PAGE_MASK	(~((1UL << PAGE_SHIFT) - 1))
-
 #define VMW_BALLOON_CMD_WITH_TARGET_MASK			\
 	((1UL << VMW_BALLOON_CMD_GET_TARGET)		|	\
 	 (1UL << VMW_BALLOON_CMD_LOCK)			|	\
@@ -161,27 +143,6 @@ static const char * const vmballoon_cmd_names[] = {
 	[VMW_BALLOON_CMD_VMCI_DOORBELL_SET]	= "doorbellSet"
 };
 
-struct vmballoon_batch_page {
-	u64 pages[VMW_BALLOON_BATCH_MAX_PAGES];
-};
-
-static u64 vmballoon_batch_get_pa(struct vmballoon_batch_page *batch, int idx)
-{
-	return batch->pages[idx] & VMW_BALLOON_BATCH_PAGE_MASK;
-}
-
-static int vmballoon_batch_get_status(struct vmballoon_batch_page *batch,
-				int idx)
-{
-	return (int)(batch->pages[idx] & VMW_BALLOON_BATCH_STATUS_MASK);
-}
-
-static void vmballoon_batch_set_pa(struct vmballoon_batch_page *batch, int idx,
-				u64 pa)
-{
-	batch->pages[idx] = pa;
-}
-
 #ifdef CONFIG_DEBUG_FS
 struct vmballoon_stats {
 	unsigned int timer;
@@ -225,6 +186,19 @@ struct vmballoon_page_size {
 	unsigned int n_refused_pages;
 };
 
+/**
+ * struct vmballoon_batch_entry - a batch entry for lock or unlock.
+ *
+ * @status: the status of the operation, which is written by the hypervisor.
+ * @reserved: reserved for future use. Must be set to zero.
+ * @pfn: the physical frame number of the page to be locked or unlocked.
+ */
+struct vmballoon_batch_entry {
+	u64 status : 5;
+	u64 reserved : PAGE_SHIFT - 5;
+	u64 pfn : 52;
+} __packed;
+
 struct vmballoon {
 	struct vmballoon_page_size page_sizes[VMW_BALLOON_NUM_PAGE_SIZES];
 
@@ -240,7 +214,14 @@ struct vmballoon {
 
 	unsigned long capabilities;
 
-	struct vmballoon_batch_page *batch_page;
+	/**
+	 * @batch_page: pointer to communication batch page.
+	 *
+	 * When batching is used, batch_page points to a page, which holds up to
+	 * %VMW_BALLOON_BATCH_MAX_PAGES entries for locking or unlocking.
+	 */
+	struct vmballoon_batch_entry *batch_page;
+
 	unsigned int batch_max_pages;
 	struct page *page;
 
@@ -568,8 +549,7 @@ static int vmballoon_lock_batched_page(struct vmballoon *b,
 
 	if (locked > 0) {
 		for (i = 0; i < num_pages; i++) {
-			u64 pa = vmballoon_batch_get_pa(b->batch_page, i);
-			struct page *p = pfn_to_page(pa >> PAGE_SHIFT);
+			struct page *p = pfn_to_page(b->batch_page[i].pfn);
 
 			vmballoon_free_page(p, is_2m_pages);
 		}
@@ -578,12 +558,11 @@ static int vmballoon_lock_batched_page(struct vmballoon *b,
 	}
 
 	for (i = 0; i < num_pages; i++) {
-		u64 pa = vmballoon_batch_get_pa(b->batch_page, i);
-		struct page *p = pfn_to_page(pa >> PAGE_SHIFT);
+		struct page *p = pfn_to_page(b->batch_page[i].pfn);
 		struct vmballoon_page_size *page_size =
 				&b->page_sizes[is_2m_pages];
 
-		locked = vmballoon_batch_get_status(b->batch_page, i);
+		locked = b->batch_page[i].status;
 
 		switch (locked) {
 		case VMW_BALLOON_SUCCESS:
@@ -656,12 +635,11 @@ static int vmballoon_unlock_batched_page(struct vmballoon *b,
 		ret = -EIO;
 
 	for (i = 0; i < num_pages; i++) {
-		u64 pa = vmballoon_batch_get_pa(b->batch_page, i);
-		struct page *p = pfn_to_page(pa >> PAGE_SHIFT);
+		struct page *p = pfn_to_page(b->batch_page[i].pfn);
 		struct vmballoon_page_size *page_size =
 				&b->page_sizes[is_2m_pages];
 
-		locked = vmballoon_batch_get_status(b->batch_page, i);
+		locked = b->batch_page[i].status;
 		if (!hv_success || locked != VMW_BALLOON_SUCCESS) {
 			/*
 			 * That page wasn't successfully unlocked by the
@@ -710,8 +688,8 @@ static void vmballoon_add_page(struct vmballoon *b, int idx, struct page *p)
 static void vmballoon_add_batched_page(struct vmballoon *b, int idx,
 				struct page *p)
 {
-	vmballoon_batch_set_pa(b->batch_page, idx,
-			(u64)page_to_pfn(p) << PAGE_SHIFT);
+	b->batch_page[idx] = (struct vmballoon_batch_entry)
+					{ .pfn = page_to_pfn(p) };
 }
 
 /*
@@ -967,7 +945,8 @@ static void vmballoon_reset(struct vmballoon *b)
 
 	if ((b->capabilities & VMW_BALLOON_BATCHED_CMDS) != 0) {
 		b->ops = &vmballoon_batched_ops;
-		b->batch_max_pages = VMW_BALLOON_BATCH_MAX_PAGES;
+		b->batch_max_pages = PAGE_SIZE / sizeof(struct
+							vmballoon_batch_entry);
 		if (!vmballoon_init_batching(b)) {
 			/*
 			 * We failed to initialize batching, inform the monitor
-- 
2.17.1

