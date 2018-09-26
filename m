Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0451C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57C621537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57C621537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbeI0B3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:29:34 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:2656 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726422AbeI0B3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:29:34 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 26 Sep 2018 12:15:00 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 654DAB0E89;
        Wed, 26 Sep 2018 15:15:09 -0400 (EDT)
From:   Nadav Amit <namit@vmware.com>
To:     Arnd Bergmann <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>
Subject: [PATCH v3 03/20] vmw_balloon: merge send_lock and send_unlock path
Date:   Wed, 26 Sep 2018 12:13:19 -0700
Message-ID: <20180926191336.101885-4-namit@vmware.com>
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

The lock and unlock code paths are very similar, so avoid the duplicate
code by merging them together.

Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 62 +++++++++++++-------------------------
 1 file changed, 21 insertions(+), 41 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 2ed4875319c8..5e5f61f207f4 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -420,16 +420,18 @@ static bool vmballoon_send_get_target(struct vmballoon *b)
  * check the return value and maybe submit a different page.
  */
 static int vmballoon_send_lock_page(struct vmballoon *b, unsigned long pfn,
-				    unsigned int *hv_status)
+				    unsigned int *hv_status, bool lock)
 {
-	unsigned long status;
+	unsigned long status, cmd;
 	u32 pfn32;
 
 	pfn32 = (u32)pfn;
 	if (pfn32 != pfn)
 		return -EINVAL;
 
-	*hv_status = status = vmballoon_cmd(b, VMW_BALLOON_CMD_LOCK, pfn, 0);
+	cmd = lock ? VMW_BALLOON_CMD_LOCK : VMW_BALLOON_CMD_UNLOCK;
+
+	*hv_status = status = vmballoon_cmd(b, cmd, pfn, 0);
 
 	if (status == VMW_BALLOON_SUCCESS)
 		return 0;
@@ -438,13 +440,18 @@ static int vmballoon_send_lock_page(struct vmballoon *b, unsigned long pfn,
 }
 
 static int vmballoon_send_batched_lock(struct vmballoon *b,
-				       unsigned int num_pages, bool is_2m_pages)
+				       unsigned int num_pages, bool is_2m_pages,
+				       bool lock)
 {
 	unsigned long pfn = PHYS_PFN(virt_to_phys(b->batch_page));
 	unsigned long status, cmd;
 
-	cmd = is_2m_pages ? VMW_BALLOON_CMD_BATCHED_2M_LOCK :
-			    VMW_BALLOON_CMD_BATCHED_LOCK;
+	if (lock)
+		cmd = is_2m_pages ? VMW_BALLOON_CMD_BATCHED_2M_LOCK :
+				    VMW_BALLOON_CMD_BATCHED_LOCK;
+	else
+		cmd = is_2m_pages ? VMW_BALLOON_CMD_BATCHED_2M_UNLOCK :
+				    VMW_BALLOON_CMD_BATCHED_UNLOCK;
 
 	status = vmballoon_cmd(b, cmd, pfn, num_pages);
 
@@ -454,37 +461,6 @@ static int vmballoon_send_batched_lock(struct vmballoon *b,
 	return 1;
 }
 
-/*
- * Notify the host that guest intends to release given page back into
- * the pool of available (to the guest) pages.
- */
-static bool vmballoon_send_unlock_page(struct vmballoon *b, unsigned long pfn)
-{
-	unsigned long status;
-	u32 pfn32;
-
-	pfn32 = (u32)pfn;
-	if (pfn32 != pfn)
-		return false;
-
-	status = vmballoon_cmd(b, VMW_BALLOON_CMD_UNLOCK, pfn, 0);
-	return status == VMW_BALLOON_SUCCESS;
-}
-
-static bool vmballoon_send_batched_unlock(struct vmballoon *b,
-		unsigned int num_pages, bool is_2m_pages)
-{
-	unsigned long pfn = PHYS_PFN(virt_to_phys(b->batch_page));
-	unsigned long status, cmd;
-
-	cmd = is_2m_pages ? VMW_BALLOON_CMD_BATCHED_2M_UNLOCK :
-			    VMW_BALLOON_CMD_BATCHED_UNLOCK;
-
-	status = vmballoon_cmd(b, cmd, pfn, num_pages);
-
-	return status == VMW_BALLOON_SUCCESS;
-}
-
 static struct page *vmballoon_alloc_page(gfp_t flags, bool is_2m_page)
 {
 	if (is_2m_page)
@@ -546,7 +522,8 @@ static int vmballoon_lock_page(struct vmballoon *b, unsigned int num_pages,
 
 	/* is_2m_pages can never happen as 2m pages support implies batching */
 
-	locked = vmballoon_send_lock_page(b, page_to_pfn(page), &hv_status);
+	locked = vmballoon_send_lock_page(b, page_to_pfn(page), &hv_status,
+					  true);
 
 	if (locked) {
 		STATS_INC(b->stats.refused_alloc[false]);
@@ -587,7 +564,7 @@ static int vmballoon_lock_batched_page(struct vmballoon *b,
 	int locked, i;
 	u16 size_per_page = vmballoon_page_size(is_2m_pages);
 
-	locked = vmballoon_send_batched_lock(b, num_pages, is_2m_pages);
+	locked = vmballoon_send_batched_lock(b, num_pages, is_2m_pages, true);
 
 	if (locked > 0) {
 		for (i = 0; i < num_pages; i++) {
@@ -645,10 +622,12 @@ static int vmballoon_unlock_page(struct vmballoon *b, unsigned int num_pages,
 {
 	struct page *page = b->page;
 	struct vmballoon_page_size *page_size = &b->page_sizes[false];
+	unsigned int hv_status;
 
 	/* is_2m_pages can never happen as 2m pages support implies batching */
 
-	if (!vmballoon_send_unlock_page(b, page_to_pfn(page))) {
+	if (!vmballoon_send_lock_page(b, page_to_pfn(page), &hv_status,
+				      false)) {
 		list_add(&page->lru, &page_size->pages);
 		return -EIO;
 	}
@@ -670,7 +649,8 @@ static int vmballoon_unlock_batched_page(struct vmballoon *b,
 	bool hv_success;
 	u16 size_per_page = vmballoon_page_size(is_2m_pages);
 
-	hv_success = vmballoon_send_batched_unlock(b, num_pages, is_2m_pages);
+	hv_success = vmballoon_send_batched_lock(b, num_pages, is_2m_pages,
+						 false);
 
 	if (!hv_success)
 		ret = -EIO;
-- 
2.17.1

