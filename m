Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A5CC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F08208D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F08208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934349AbeGFFvd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:51:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33354 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934326AbeGFFva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:51:30 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0FFF586A;
        Fri,  6 Jul 2018 05:51:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Shaohua Li <shli@fb.com>,
        Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.14 38/61] md: allow metadata update while suspending.
Date:   Fri,  6 Jul 2018 07:47:02 +0200
Message-Id: <20180706054713.797576051@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
References: <20180706054712.332416244@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.com>

commit 35bfc52187f6df8779d0f1cebdb52b7f797baf4e upstream.

There are various deadlocks that can occur
when a thread holds reconfig_mutex and calls
->quiesce(mddev, 1).
As some write request block waiting for
metadata to be updated (e.g. to record device
failure), and as the md thread updates the metadata
while the reconfig mutex is held, holding the mutex
can stop write requests completing, and this prevents
->quiesce(mddev, 1) from completing.

->quiesce() is now usually called from mddev_suspend(),
and it is always called with reconfig_mutex held.  So
at this time it is safe for the thread to update metadata
without explicitly taking the lock.

So add 2 new flags, one which says the unlocked updates is
allowed, and one which ways it is happening.  Then allow it
while the quiesce completes, and then wait for it to finish.

Reported-and-tested-by: Xiao Ni <xni@redhat.com>
Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/md.c |   14 ++++++++++++++
 drivers/md/md.h |    6 ++++++
 2 files changed, 20 insertions(+)

--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -364,8 +364,12 @@ void mddev_suspend(struct mddev *mddev)
 		return;
 	synchronize_rcu();
 	wake_up(&mddev->sb_wait);
+	set_bit(MD_ALLOW_SB_UPDATE, &mddev->flags);
+	smp_mb__after_atomic();
 	wait_event(mddev->sb_wait, atomic_read(&mddev->active_io) == 0);
 	mddev->pers->quiesce(mddev, 1);
+	clear_bit_unlock(MD_ALLOW_SB_UPDATE, &mddev->flags);
+	wait_event(mddev->sb_wait, !test_bit(MD_UPDATING_SB, &mddev->flags));
 
 	del_timer_sync(&mddev->safemode_timer);
 }
@@ -8882,6 +8886,16 @@ void md_check_recovery(struct mddev *mdd
 	unlock:
 		wake_up(&mddev->sb_wait);
 		mddev_unlock(mddev);
+	} else if (test_bit(MD_ALLOW_SB_UPDATE, &mddev->flags) && mddev->sb_flags) {
+		/* Write superblock - thread that called mddev_suspend()
+		 * holds reconfig_mutex for us.
+		 */
+		set_bit(MD_UPDATING_SB, &mddev->flags);
+		smp_mb__after_atomic();
+		if (test_bit(MD_ALLOW_SB_UPDATE, &mddev->flags))
+			md_update_sb(mddev, 0);
+		clear_bit_unlock(MD_UPDATING_SB, &mddev->flags);
+		wake_up(&mddev->sb_wait);
 	}
 }
 EXPORT_SYMBOL(md_check_recovery);
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -237,6 +237,12 @@ enum mddev_flags {
 				 */
 	MD_HAS_PPL,		/* The raid array has PPL feature set */
 	MD_HAS_MULTIPLE_PPLS,	/* The raid array has multiple PPLs feature set */
+	MD_ALLOW_SB_UPDATE,	/* md_check_recovery is allowed to update
+				 * the metadata without taking reconfig_mutex.
+				 */
+	MD_UPDATING_SB,		/* md_check_recovery is updating the metadata
+				 * without explicitly holding reconfig_mutex.
+				 */
 };
 
 enum mddev_sb_flags {


