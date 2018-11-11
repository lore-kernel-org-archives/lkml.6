Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059A8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24CF21707
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w8ATPwa7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24CF21707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404911AbeKLIZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:25:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:60786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731220AbeKLIZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:25:04 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEA392154B;
        Sun, 11 Nov 2018 22:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975705;
        bh=/GenvhklQ+k8Z6V9ZOJ7VgLyWHFayNO8/uqfD2aKdQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w8ATPwa7XwgfrI09603Zpe1+mySv/kGCoqhrqWp7s2HJEO7iFDG7QoKVgpDflYYh6
         vyElzKQXshcTvNktfTuCua961L9xKHDaE7JSTIwP6eKohBvMgGXiLseMv/N77Zhu2/
         SD2OSnIHneHUIypT7TdYANL6HKbDY1I6iR+aP3Mc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 066/141] driver/dma/ioat: Call del_timer_sync() without holding prep_lock
Date:   Sun, 11 Nov 2018 14:25:25 -0800
Message-Id: <20181111221636.985001667@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/ioat/init.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -1210,8 +1210,15 @@ static void ioat_shutdown(struct pci_dev
 
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


