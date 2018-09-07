Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C9CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A860520844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A860520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbeIHCQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:16:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51842 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeIHCQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:16:46 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7305CF4A;
        Fri,  7 Sep 2018 21:33:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xavier Deguillard <xdeguillard@vmware.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH 4.9 24/63] vmw_balloon: fix inflation of 64-bit GFNs
Date:   Fri,  7 Sep 2018 23:09:55 +0200
Message-Id: <20180907211014.311640123@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907211012.965501324@linuxfoundation.org>
References: <20180907211012.965501324@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nadav Amit <namit@vmware.com>

commit 09755690c6b7c1eabdc4651eb3b276f8feb1e447 upstream.

When balloon batching is not supported by the hypervisor, the guest
frame number (GFN) must fit in 32-bit. However, due to a bug, this check
was mistakenly ignored. In practice, when total RAM is greater than
16TB, the balloon does not work currently, making this bug unlikely to
happen.

Fixes: ef0f8f112984 ("VMware balloon: partially inline vmballoon_reserve_page.")
Cc: stable@vger.kernel.org
Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/vmw_balloon.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -450,7 +450,7 @@ static int vmballoon_send_lock_page(stru
 
 	pfn32 = (u32)pfn;
 	if (pfn32 != pfn)
-		return -1;
+		return -EINVAL;
 
 	STATS_INC(b->stats.lock[false]);
 
@@ -460,7 +460,7 @@ static int vmballoon_send_lock_page(stru
 
 	pr_debug("%s - ppn %lx, hv returns %ld\n", __func__, pfn, status);
 	STATS_INC(b->stats.lock_fail[false]);
-	return 1;
+	return -EIO;
 }
 
 static int vmballoon_send_batched_lock(struct vmballoon *b,
@@ -597,11 +597,12 @@ static int vmballoon_lock_page(struct vm
 
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
@@ -617,7 +618,7 @@ static int vmballoon_lock_page(struct vm
 		} else {
 			vmballoon_free_page(page, false);
 		}
-		return -EIO;
+		return locked;
 	}
 
 	/* track allocated page */


