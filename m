Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AC4C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B92820818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="np4ucDB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B92820818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbeKIHnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:43:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731701AbeKIHnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:04 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EAA1214DA;
        Thu,  8 Nov 2018 22:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714734;
        bh=FkMiRXPiytHYfjJlFfwx5fUjhYWSWn6uXB2bP9W6I/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=np4ucDB9/1/AW8MMzY4kI8fbaI90gvfIibdQch1iwgUeXtLDx51QvegEuoDqAKe7f
         6ISitDgjwCfTpc0D6ghPT17S4m9ELZUbUJOojNAvs9ODsuW6ymuhFDCVqTsVBaDwvs
         lU3LvxZ7IQXkbhO8f+4KLmQBG2vcZ3/84+v1igiI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Vesker <valex@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 094/171] IB/ipoib: Fix lockdep issue found on ipoib_ib_dev_heavy_flush
Date:   Thu,  8 Nov 2018 13:51:04 -0800
Message-Id: <20181108215134.307913529@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
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

[ Upstream commit 1f80bd6a6cc8358b81194e1f5fc16449947396ec ]

The locking order of vlan_rwsem (LOCK A) and then rtnl (LOCK B),
contradicts other flows such as ipoib_open possibly causing a deadlock.
To prevent this deadlock heavy flush is called with RTNL locked and
only then tries to acquire vlan_rwsem.
This deadlock is possible only when there are child interfaces.

[  140.941758] ======================================================
[  140.946276] WARNING: possible circular locking dependency detected
[  140.950950] 4.15.0-rc1+ #9 Tainted: G           O
[  140.954797] ------------------------------------------------------
[  140.959424] kworker/u32:1/146 is trying to acquire lock:
[  140.963450]  (rtnl_mutex){+.+.}, at: [<ffffffffc083516a>] __ipoib_ib_dev_flush+0x2da/0x4e0 [ib_ipoib]
[  140.970006]
but task is already holding lock:
[  140.975141]  (&priv->vlan_rwsem){++++}, at: [<ffffffffc0834ee1>] __ipoib_ib_dev_flush+0x51/0x4e0 [ib_ipoib]
[  140.982105]
which lock already depends on the new lock.
[  140.990023]
the existing dependency chain (in reverse order) is:
[  140.998650]
-> #1 (&priv->vlan_rwsem){++++}:
[  141.005276]        down_read+0x4d/0xb0
[  141.009560]        ipoib_open+0xad/0x120 [ib_ipoib]
[  141.014400]        __dev_open+0xcb/0x140
[  141.017919]        __dev_change_flags+0x1a4/0x1e0
[  141.022133]        dev_change_flags+0x23/0x60
[  141.025695]        devinet_ioctl+0x704/0x7d0
[  141.029156]        sock_do_ioctl+0x20/0x50
[  141.032526]        sock_ioctl+0x221/0x300
[  141.036079]        do_vfs_ioctl+0xa6/0x6d0
[  141.039656]        SyS_ioctl+0x74/0x80
[  141.042811]        entry_SYSCALL_64_fastpath+0x1f/0x96
[  141.046891]
-> #0 (rtnl_mutex){+.+.}:
[  141.051701]        lock_acquire+0xd4/0x220
[  141.055212]        __mutex_lock+0x88/0x970
[  141.058631]        __ipoib_ib_dev_flush+0x2da/0x4e0 [ib_ipoib]
[  141.063160]        __ipoib_ib_dev_flush+0x71/0x4e0 [ib_ipoib]
[  141.067648]        process_one_work+0x1f5/0x610
[  141.071429]        worker_thread+0x4a/0x3f0
[  141.074890]        kthread+0x141/0x180
[  141.078085]        ret_from_fork+0x24/0x30
[  141.081559]

other info that might help us debug this:
[  141.088967]  Possible unsafe locking scenario:
[  141.094280]        CPU0                    CPU1
[  141.097953]        ----                    ----
[  141.101640]   lock(&priv->vlan_rwsem);
[  141.104771]                                lock(rtnl_mutex);
[  141.109207]                                lock(&priv->vlan_rwsem);
[  141.114032]   lock(rtnl_mutex);
[  141.116800]
 *** DEADLOCK ***

Fixes: b4b678b06f6e ("IB/ipoib: Grab rtnl lock on heavy flush when calling ndo_open/stop")
Signed-off-by: Alex Vesker <valex@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/ipoib/ipoib_ib.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
index 34122c96522b..3dd5bf6c6c7a 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -1190,13 +1190,10 @@ static void __ipoib_ib_dev_flush(struct ipoib_dev_priv *priv,
 		ipoib_ib_dev_down(dev);
 
 	if (level == IPOIB_FLUSH_HEAVY) {
-		rtnl_lock();
 		if (test_bit(IPOIB_FLAG_INITIALIZED, &priv->flags))
 			ipoib_ib_dev_stop(dev);
 
-		result = ipoib_ib_dev_open(dev);
-		rtnl_unlock();
-		if (result)
+		if (ipoib_ib_dev_open(dev))
 			return;
 
 		if (netif_queue_stopped(dev))
@@ -1236,7 +1233,9 @@ void ipoib_ib_dev_flush_heavy(struct work_struct *work)
 	struct ipoib_dev_priv *priv =
 		container_of(work, struct ipoib_dev_priv, flush_heavy);
 
+	rtnl_lock();
 	__ipoib_ib_dev_flush(priv, IPOIB_FLUSH_HEAVY, 0);
+	rtnl_unlock();
 }
 
 void ipoib_ib_dev_cleanup(struct net_device *dev)
-- 
2.17.1



