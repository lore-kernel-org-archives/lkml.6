Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3AEC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998CC2064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998CC2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733240AbeJBUZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:25:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36082 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731744AbeJBUTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:19:34 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3B9C29D9;
        Tue,  2 Oct 2018 13:36:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guoqing Jiang <gqjiang@suse.com>,
        NeilBrown <neilb@suse.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 14/94] md-cluster: clear another nodes suspend_area after the copy is finished
Date:   Tue,  2 Oct 2018 06:24:28 -0700
Message-Id: <20181002132501.463739455@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
References: <20181002132500.494838053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guoqing Jiang <gqjiang@suse.com>

[ Upstream commit 010228e4a932ca1e8365e3b58c8e1e44c16ff793 ]

When one node leaves cluster or stops the resyncing
(resync or recovery) array, then other nodes need to
call recover_bitmaps to continue the unfinished task.

But we need to clear suspend_area later after other
nodes copy the resync information to their bitmap
(by call bitmap_copy_from_slot). Otherwise, all nodes
could write to the suspend_area even the suspend_area
is not handled by any node, because area_resyncing
returns 0 at the beginning of raid1_write_request.
Which means one node could write suspend_area while
another node is resyncing the same area, then data
could be inconsistent.

So let's clear suspend_area later to avoid above issue
with the protection of bm lock. Also it is straightforward
to clear suspend_area after nodes have copied the resync
info to bitmap.

Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
Reviewed-by: NeilBrown <neilb@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/md-cluster.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -302,15 +302,6 @@ static void recover_bitmaps(struct md_th
 	while (cinfo->recovery_map) {
 		slot = fls64((u64)cinfo->recovery_map) - 1;
 
-		/* Clear suspend_area associated with the bitmap */
-		spin_lock_irq(&cinfo->suspend_lock);
-		list_for_each_entry_safe(s, tmp, &cinfo->suspend_list, list)
-			if (slot == s->slot) {
-				list_del(&s->list);
-				kfree(s);
-			}
-		spin_unlock_irq(&cinfo->suspend_lock);
-
 		snprintf(str, 64, "bitmap%04d", slot);
 		bm_lockres = lockres_init(mddev, str, NULL, 1);
 		if (!bm_lockres) {
@@ -329,6 +320,16 @@ static void recover_bitmaps(struct md_th
 			pr_err("md-cluster: Could not copy data from bitmap %d\n", slot);
 			goto clear_bit;
 		}
+
+		/* Clear suspend_area associated with the bitmap */
+		spin_lock_irq(&cinfo->suspend_lock);
+		list_for_each_entry_safe(s, tmp, &cinfo->suspend_list, list)
+			if (slot == s->slot) {
+				list_del(&s->list);
+				kfree(s);
+			}
+		spin_unlock_irq(&cinfo->suspend_lock);
+
 		if (hi > 0) {
 			if (lo < mddev->recovery_cp)
 				mddev->recovery_cp = lo;


