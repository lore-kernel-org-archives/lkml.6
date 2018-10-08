Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC25CC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9293820C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oh0CSZ9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9293820C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeJIBpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:45:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbeJIBpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:45:52 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F2602087D;
        Mon,  8 Oct 2018 18:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023570;
        bh=sfDcnVu8XfsGX/eMrsiLVl46oLmxdsg8FIx2B7NgxqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oh0CSZ9ot9co26T1LVRsom+i3HKLl0Taay27S792wBoDrTHX07xTXPATeWmD8iKX7
         6XdfTkyWoZSZc2AlBwOB1z33wtdjs4kSqIxKAjDCP02Aw/1zRD9+htKPkEfmhHbkjl
         JqHjcBMZQdOGk7c9HabgNoCRFRh2XVP3tx+4Ev2U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guoqing Jiang <gqjiang@suse.com>,
        NeilBrown <neilb@suse.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 011/113] md-cluster: clear another nodes suspend_area after the copy is finished
Date:   Mon,  8 Oct 2018 20:30:12 +0200
Message-Id: <20181008175531.394633401@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -239,15 +239,6 @@ static void recover_bitmaps(struct md_th
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
@@ -266,6 +257,16 @@ static void recover_bitmaps(struct md_th
 			pr_err("md-cluster: Could not copy data from bitmap %d\n", slot);
 			goto dlm_unlock;
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
 			/* TODO:Wait for current resync to get over */
 			set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);


