Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39210C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5FE251BD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5FE251BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965482AbeGAQ1R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:27:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34046 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965463AbeGAQ1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:27:13 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E2C4F92B;
        Sun,  1 Jul 2018 16:27:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>, Shaohua Li <shli@fb.com>
Subject: [PATCH 4.9 066/101] md: fix two problems with setting the "re-add" device state.
Date:   Sun,  1 Jul 2018 18:21:52 +0200
Message-Id: <20180701160759.803610690@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160757.138608453@linuxfoundation.org>
References: <20180701160757.138608453@linuxfoundation.org>
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

From: NeilBrown <neilb@suse.com>

commit 011abdc9df559ec75779bb7c53a744c69b2a94c6 upstream.

If "re-add" is written to the "state" file for a device
which is faulty, this has an effect similar to removing
and re-adding the device.  It should take up the
same slot in the array that it previously had, and
an accelerated (e.g. bitmap-based) rebuild should happen.

The slot that "it previously had" is determined by
rdev->saved_raid_disk.
However this is not set when a device fails (only when a device
is added), and it is cleared when resync completes.
This means that "re-add" will normally work once, but may not work a
second time.

This patch includes two fixes.
1/ when a device fails, record the ->raid_disk value in
    ->saved_raid_disk before clearing ->raid_disk
2/ when "re-add" is written to a device for which
    ->saved_raid_disk is not set, fail.

I think this is suitable for stable as it can
cause re-adding a device to be forced to do a full
resync which takes a lot longer and so puts data at
more risk.

Cc: <stable@vger.kernel.org> (v4.1)
Fixes: 97f6cd39da22 ("md-cluster: re-add capabilities")
Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/md.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2694,7 +2694,8 @@ state_store(struct md_rdev *rdev, const
 			err = 0;
 		}
 	} else if (cmd_match(buf, "re-add")) {
-		if (test_bit(Faulty, &rdev->flags) && (rdev->raid_disk == -1)) {
+		if (test_bit(Faulty, &rdev->flags) && (rdev->raid_disk == -1) &&
+			rdev->saved_raid_disk >= 0) {
 			/* clear_bit is performed _after_ all the devices
 			 * have their local Faulty bit cleared. If any writes
 			 * happen in the meantime in the local node, they
@@ -8272,6 +8273,7 @@ static int remove_and_add_spares(struct
 			if (mddev->pers->hot_remove_disk(
 				    mddev, rdev) == 0) {
 				sysfs_unlink_rdev(mddev, rdev);
+				rdev->saved_raid_disk = rdev->raid_disk;
 				rdev->raid_disk = -1;
 				removed++;
 			}


