Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04C9C1B0F7
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A27A20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A27A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754097AbeFTGPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 02:15:23 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:14595 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752785AbeFTGPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 02:15:16 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 19 Jun 2018 23:14:41 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 87745B0C08;
        Tue, 19 Jun 2018 23:15:15 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>, <stable@vger.kernel.org>
Subject: [PATCH v3 1/7] vmw_balloon: fix inflation of 64-bit GFNs
Date:   Tue, 19 Jun 2018 16:00:24 -0700
Message-ID: <20180619230030.112906-2-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180619230030.112906-1-namit@vmware.com>
References: <20180619230030.112906-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When balloon batching is not supported by the hypervisor, the guest
frame number (GFN) must fit in 32-bit. However, due to a bug, this check
was mistakenly ignored. In practice, when total RAM is greater than
16TB, the balloon does not work currently, making this bug unlikely to
happen.

Fixes: ef0f8f112984 ("VMware balloon: partially inline vmballoon_reserve_page.")
Cc: stable@vger.kernel.org
Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index efd733472a35..28e77ab1e136 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -450,7 +450,7 @@ static int vmballoon_send_lock_page(struct vmballoon *b, unsigned long pfn,
 
 	pfn32 = (u32)pfn;
 	if (pfn32 != pfn)
-		return -1;
+		return -EINVAL;
 
 	STATS_INC(b->stats.lock[false]);
 
@@ -460,7 +460,7 @@ static int vmballoon_send_lock_page(struct vmballoon *b, unsigned long pfn,
 
 	pr_debug("%s - ppn %lx, hv returns %ld\n", __func__, pfn, status);
 	STATS_INC(b->stats.lock_fail[false]);
-	return 1;
+	return -EIO;
 }
 
 static int vmballoon_send_batched_lock(struct vmballoon *b,
@@ -597,11 +597,12 @@ static int vmballoon_lock_page(struct vmballoon *b, unsigned int num_pages,
 
 	locked = vmballoon_send_lock_page(b, page_to_pfn(page), &hv_status,
 								target);
-	if (locked > 0) {
+	if (locked) {
 		STATS_INC(b->stats.refused_alloc[false]);
 
-		if (hv_status == VMW_BALLOON_ERROR_RESET ||
-				hv_status == VMW_BALLOON_ERROR_PPN_NOTNEEDED) {
+		if (locked == -EIO &&
+		    (hv_status == VMW_BALLOON_ERROR_RESET ||
+		     hv_status == VMW_BALLOON_ERROR_PPN_NOTNEEDED)) {
 			vmballoon_free_page(page, false);
 			return -EIO;
 		}
@@ -617,7 +618,7 @@ static int vmballoon_lock_page(struct vmballoon *b, unsigned int num_pages,
 		} else {
 			vmballoon_free_page(page, false);
 		}
-		return -EIO;
+		return locked;
 	}
 
 	/* track allocated page */
-- 
2.17.0

