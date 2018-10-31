Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70178ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C33204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qr0hXBk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C33204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbeKAIMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:12:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732094AbeKAIMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:12:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 891F821019;
        Wed, 31 Oct 2018 23:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027522;
        bh=W1w1iQvZ7j6HJ5IJbqYkXuYQvyiwMiBc7e2AeWQIl+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qr0hXBk+pYMR4JG8TDx8MNumcQtJDNafzGWA13rezSOArCZIlc9f6A8cAai6JkjaQ
         0cPkB1nPOSnMEPSdmrVuIVWpDdkdNVEIoPOPDLS2+m1zcQw8B1uDAzzvpERlCe78gn
         GGAJq/dVl3i5eyV7pY2dfPngP+vrMSHJsgUMMSus=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Waiman Long <longman@redhat.com>, Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 27/32] driver/dma/ioat: Call del_timer_sync() without holding prep_lock
Date:   Wed, 31 Oct 2018 19:11:32 -0400
Message-Id: <20181031231137.29429-27-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231137.29429-1-sashal@kernel.org>
References: <20181031231137.29429-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Waiman Long <longman@redhat.com>

[ Upstream commit cfb03be6c7e8a1591285849c361d67b09f5149f7 ]

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
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/ioat/init.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index ac8c28968422..106fa9b327d9 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -1210,8 +1210,15 @@ static void ioat_shutdown(struct pci_dev *pdev)
 
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
2.17.1

