Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25EEECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC22208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="geDXQntL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC22208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbeKIHec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:34:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:50984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727718AbeKIHeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:34:31 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C20A2089A;
        Thu,  8 Nov 2018 21:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714223;
        bh=Ggj6f/P8T54wKOokNQcoJvF/syivmro+iADNLmm5rk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=geDXQntLu5IIqg5K4nuUsM9sLVDihDDsos0N4SBKRZNe++GkLjAVbiAbGnq4oP0JX
         L61gYSXlUihpgcZHS8AJrwAiFd/ib8HztPyyKJRpc2zQU5/ZqSpURQpWu9zICOWf21
         4Z4ZDosWziYW6XnaLrqlBW1DmljRjuVzg+ETo7SE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felipe Balbi <balbi@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 102/144] mtd: blkdevs: fix potential deadlock + lockdep warnings
Date:   Thu,  8 Nov 2018 13:51:13 -0800
Message-Id: <20181108215105.154209594@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit f3c63795e90f0c6238306883b6c72f14d5355721 ]

Commit 073db4a51ee4 ("mtd: fix: avoid race condition when accessing
mtd->usecount") fixed a race condition but due to poor ordering of the
mutex acquisition, introduced a potential deadlock.

The deadlock can occur, for example, when rmmod'ing the m25p80 module, which
will delete one or more MTDs, along with any corresponding mtdblock
devices. This could potentially race with an acquisition of the block
device as follows.

 -> blktrans_open()
    ->  mutex_lock(&dev->lock);
    ->  mutex_lock(&mtd_table_mutex);

 -> del_mtd_device()
    ->  mutex_lock(&mtd_table_mutex);
    ->  blktrans_notify_remove() -> del_mtd_blktrans_dev()
       ->  mutex_lock(&dev->lock);

This is a classic (potential) ABBA deadlock, which can be fixed by
making the A->B ordering consistent everywhere. There was no real
purpose to the ordering in the original patch, AFAIR, so this shouldn't
be a problem. This ordering was actually already present in
del_mtd_blktrans_dev(), for one, where the function tried to ensure that
its caller already held mtd_table_mutex before it acquired &dev->lock:

        if (mutex_trylock(&mtd_table_mutex)) {
                mutex_unlock(&mtd_table_mutex);
                BUG();
        }

So, reverse the ordering of acquisition of &dev->lock and &mtd_table_mutex so
we always acquire mtd_table_mutex first.

Snippets of the lockdep output follow:

  # modprobe -r m25p80
  [   53.419251]
  [   53.420838] ======================================================
  [   53.427300] [ INFO: possible circular locking dependency detected ]
  [   53.433865] 4.3.0-rc6 #96 Not tainted
  [   53.437686] -------------------------------------------------------
  [   53.444220] modprobe/372 is trying to acquire lock:
  [   53.449320]  (&new->lock){+.+...}, at: [<c043fe4c>] del_mtd_blktrans_dev+0x80/0xdc
  [   53.457271]
  [   53.457271] but task is already holding lock:
  [   53.463372]  (mtd_table_mutex){+.+.+.}, at: [<c0439994>] del_mtd_device+0x18/0x100
  [   53.471321]
  [   53.471321] which lock already depends on the new lock.
  [   53.471321]
  [   53.479856]
  [   53.479856] the existing dependency chain (in reverse order) is:
  [   53.487660]
  -> #1 (mtd_table_mutex){+.+.+.}:
  [   53.492331]        [<c043fc5c>] blktrans_open+0x34/0x1a4
  [   53.497879]        [<c01afce0>] __blkdev_get+0xc4/0x3b0
  [   53.503364]        [<c01b0bb8>] blkdev_get+0x108/0x320
  [   53.508743]        [<c01713c0>] do_dentry_open+0x218/0x314
  [   53.514496]        [<c0180454>] path_openat+0x4c0/0xf9c
  [   53.519959]        [<c0182044>] do_filp_open+0x5c/0xc0
  [   53.525336]        [<c0172758>] do_sys_open+0xfc/0x1cc
  [   53.530716]        [<c000f740>] ret_fast_syscall+0x0/0x1c
  [   53.536375]
  -> #0 (&new->lock){+.+...}:
  [   53.540587]        [<c063f124>] mutex_lock_nested+0x38/0x3cc
  [   53.546504]        [<c043fe4c>] del_mtd_blktrans_dev+0x80/0xdc
  [   53.552606]        [<c043f164>] blktrans_notify_remove+0x7c/0x84
  [   53.558891]        [<c04399f0>] del_mtd_device+0x74/0x100
  [   53.564544]        [<c043c670>] del_mtd_partitions+0x80/0xc8
  [   53.570451]        [<c0439aa0>] mtd_device_unregister+0x24/0x48
  [   53.576637]        [<c046ce6c>] spi_drv_remove+0x1c/0x34
  [   53.582207]        [<c03de0f0>] __device_release_driver+0x88/0x114
  [   53.588663]        [<c03de19c>] device_release_driver+0x20/0x2c
  [   53.594843]        [<c03dd9e8>] bus_remove_device+0xd8/0x108
  [   53.600748]        [<c03dacc0>] device_del+0x10c/0x210
  [   53.606127]        [<c03dadd0>] device_unregister+0xc/0x20
  [   53.611849]        [<c046d878>] __unregister+0x10/0x20
  [   53.617211]        [<c03da868>] device_for_each_child+0x50/0x7c
  [   53.623387]        [<c046eae8>] spi_unregister_master+0x58/0x8c
  [   53.629578]        [<c03e12f0>] release_nodes+0x15c/0x1c8
  [   53.635223]        [<c03de0f8>] __device_release_driver+0x90/0x114
  [   53.641689]        [<c03de900>] driver_detach+0xb4/0xb8
  [   53.647147]        [<c03ddc78>] bus_remove_driver+0x4c/0xa0
  [   53.652970]        [<c00cab50>] SyS_delete_module+0x11c/0x1e4
  [   53.658976]        [<c000f740>] ret_fast_syscall+0x0/0x1c
  [   53.664621]
  [   53.664621] other info that might help us debug this:
  [   53.664621]
  [   53.672979]  Possible unsafe locking scenario:
  [   53.672979]
  [   53.679169]        CPU0                    CPU1
  [   53.683900]        ----                    ----
  [   53.688633]   lock(mtd_table_mutex);
  [   53.692383]                                lock(&new->lock);
  [   53.698306]                                lock(mtd_table_mutex);
  [   53.704658]   lock(&new->lock);
  [   53.707946]
  [   53.707946]  *** DEADLOCK ***

Fixes: 073db4a51ee4 ("mtd: fix: avoid race condition when accessing mtd->usecount")
Reported-by: Felipe Balbi <balbi@ti.com>
Tested-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/mtd_blkdevs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 3e3aa17ee3bd..6368300f3fbe 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -195,8 +195,8 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
 	if (!dev)
 		return -ERESTARTSYS; /* FIXME: busy loop! -arnd*/
 
-	mutex_lock(&dev->lock);
 	mutex_lock(&mtd_table_mutex);
+	mutex_lock(&dev->lock);
 
 	if (dev->open)
 		goto unlock;
@@ -220,8 +220,8 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
 
 unlock:
 	dev->open++;
-	mutex_unlock(&mtd_table_mutex);
 	mutex_unlock(&dev->lock);
+	mutex_unlock(&mtd_table_mutex);
 	blktrans_dev_put(dev);
 	return ret;
 
@@ -231,8 +231,8 @@ error_release:
 error_put:
 	module_put(dev->tr->owner);
 	kref_put(&dev->ref, blktrans_dev_release);
-	mutex_unlock(&mtd_table_mutex);
 	mutex_unlock(&dev->lock);
+	mutex_unlock(&mtd_table_mutex);
 	blktrans_dev_put(dev);
 	return ret;
 }
@@ -244,8 +244,8 @@ static void blktrans_release(struct gendisk *disk, fmode_t mode)
 	if (!dev)
 		return;
 
-	mutex_lock(&dev->lock);
 	mutex_lock(&mtd_table_mutex);
+	mutex_lock(&dev->lock);
 
 	if (--dev->open)
 		goto unlock;
@@ -259,8 +259,8 @@ static void blktrans_release(struct gendisk *disk, fmode_t mode)
 		__put_mtd_device(dev->mtd);
 	}
 unlock:
-	mutex_unlock(&mtd_table_mutex);
 	mutex_unlock(&dev->lock);
+	mutex_unlock(&mtd_table_mutex);
 	blktrans_dev_put(dev);
 }
 
-- 
2.17.1



