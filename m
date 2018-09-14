Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7186C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFA620881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FFA620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbeIOAJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 20:09:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbeIOAJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 20:09:31 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F94481DED;
        Fri, 14 Sep 2018 18:53:45 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 640652010CBA;
        Fri, 14 Sep 2018 18:53:42 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] driver/dma/ioat: Call del_timer_sync() without holding prep_lock
Date:   Fri, 14 Sep 2018 14:53:32 -0400
Message-Id: <1536951212-18050-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 14 Sep 2018 18:53:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following lockdep splat was observed:

[ 1222.241750] ======================================================
[ 1222.271301] WARNING: possible circular locking dependency detected
[ 1222.301060] 4.16.0-10.el8+5.x86_64+debug #1 Not tainted
[ 1222.326659] ------------------------------------------------------
[ 1222.356565] systemd-shutdow/1 is trying to acquire lock:
[ 1222.382660]  ((&ioat_chan->timer)){+.-.}, at: [<00000000f71e1a28>] del_timer_sync+0x5/0xf0
[ 1222.422928]
[ 1222.422928] but task is already holding lock:
[ 1222.451743]  (&(&ioat_chan->prep_lock)->rlock){+.-.}, at: [<000000008ea98b12>] ioat_shutdown+0x86/0x100 [ioatdma]
   :
[ 1223.524987] Chain exists of:
[ 1223.524987]   (&ioat_chan->timer) --> &(&ioat_chan->cleanup_lock)->rlock --> &(&ioat_chan->prep_lock)->rlock
[ 1223.524987]
[ 1223.594082]  Possible unsafe locking scenario:
[ 1223.594082]
[ 1223.622630]        CPU0                    CPU1
[ 1223.645080]        ----                    ----
[ 1223.667404]   lock(&(&ioat_chan->prep_lock)->rlock);
[ 1223.691535]                                lock(&(&ioat_chan->cleanup_lock)->rlock);
[ 1223.728657]                                lock(&(&ioat_chan->prep_lock)->rlock);
[ 1223.765122]   lock((&ioat_chan->timer));
[ 1223.784095]
[ 1223.784095]  *** DEADLOCK ***
[ 1223.784095]
[ 1223.813492] 4 locks held by systemd-shutdow/1:
[ 1223.834677]  #0:  (reboot_mutex){+.+.}, at: [<0000000056d33456>] SYSC_reboot+0x10f/0x300
[ 1223.873310]  #1:  (&dev->mutex){....}, at: [<00000000258dfdd7>] device_shutdown+0x1c8/0x660
[ 1223.913604]  #2:  (&dev->mutex){....}, at: [<0000000068331147>] device_shutdown+0x1d6/0x660
[ 1223.954000]  #3:  (&(&ioat_chan->prep_lock)->rlock){+.-.}, at: [<000000008ea98b12>] ioat_shutdown+0x86/0x100 [ioatdma]

In the ioat_shutdown() function:

	spin_lock_bh(&ioat_chan->prep_lock);
	set_bit(IOAT_CHAN_DOWN, &ioat_chan->state);
	del_timer_sync(&ioat_chan->timer);
	spin_unlock_bh(&ioat_chan->prep_lock);

According to the synchronization rule for the del_timer_sync() function,
the caller must not hold locks which would prevent completion of the
timer's handler.

The timer structure has its own lock that manages its synchronization.
Setting the IOAT_CHAN_DOWN bit should prevent other CPUs from
trying to use that device anyway, there is probably no need to call
del_timer_sync() while holding the prep_lock. So the del_timer_sync()
call is now moved outside of the prep_lock critical section to prevent
the circular lock dependency.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 drivers/dma/ioat/init.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 4fa4c06..21a5708 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -1205,8 +1205,15 @@ static void ioat_shutdown(struct pci_dev *pdev)
 
 		spin_lock_bh(&ioat_chan->prep_lock);
 		set_bit(IOAT_CHAN_DOWN, &ioat_chan->state);
-		del_timer_sync(&ioat_chan->timer);
 		spin_unlock_bh(&ioat_chan->prep_lock);
+		/*
+		 * Synchronization rule for del_timer_sync():
+		 *  - The caller must not hold locks which would prevent
+		 *    completion of the timer's handler.
+		 * So prep_lock cannot be held before calling it.
+		 */
+		del_timer_sync(&ioat_chan->timer);
+
 		/* this should quiesce then reset */
 		ioat_reset_hw(ioat_chan);
 	}
-- 
1.8.3.1

