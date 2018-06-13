Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AB2B4C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A74B208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A74B208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935578AbeFMSS4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:18:56 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:19857 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935123AbeFMSSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:18:54 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 13 Jun 2018 11:18:50 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 8BE9C409BD;
        Wed, 13 Jun 2018 11:18:54 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH 3/7] vmw_balloon: fix inflation of 64-bit GFNs
Date:   Wed, 13 Jun 2018 04:03:55 -0700
Message-ID: <20180613110359.109033-4-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180613110359.109033-1-namit@vmware.com>
References: <20180613110359.109033-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
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

Fixes: ef0f8f112984 ("VMware balloon: partially inline
vmballoon_reserve_page.")

Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index a73b5d64403a..496607a9046a 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -448,7 +448,7 @@ static int vmballoon_send_lock_page(struct vmballoon *b, unsigned long pfn,
 
 	pfn32 = (u32)pfn;
 	if (pfn32 != pfn)
-		return -1;
+		return -EINVAL;
 
 	STATS_INC(b->stats.lock[false]);
 
@@ -458,7 +458,7 @@ static int vmballoon_send_lock_page(struct vmballoon *b, unsigned long pfn,
 
 	pr_debug("%s - ppn %lx, hv returns %ld\n", __func__, pfn, status);
 	STATS_INC(b->stats.lock_fail[false]);
-	return 1;
+	return -EIO;
 }
 
 static int vmballoon_send_batched_lock(struct vmballoon *b,
@@ -595,11 +595,12 @@ static int vmballoon_lock_page(struct vmballoon *b, unsigned int num_pages,
 
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
@@ -615,7 +616,7 @@ static int vmballoon_lock_page(struct vmballoon *b, unsigned int num_pages,
 		} else {
 			vmballoon_free_page(page, false);
 		}
-		return -EIO;
+		return locked;
 	}
 
 	/* track allocated page */
-- 
2.17.0

