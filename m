Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD49C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D172077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D172077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbeJNXi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:38:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37572 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727563AbeJNXi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:38:27 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiMK-0004cZ-4e; Sun, 14 Oct 2018 16:31:12 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLN-0000AL-R0; Sun, 14 Oct 2018 16:30:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Sudhir Sreedharan" <ssreedharan@mvista.com>,
        "Kalle Valo" <kvalo@codeaurora.org>
Date:   Sun, 14 Oct 2018 16:25:40 +0100
Message-ID: <lsq.1539530740.862581052@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 024/366] rtl8187: Fix NULL pointer dereference in
 priv->conf_mutex
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sudhir Sreedharan <ssreedharan@mvista.com>

commit 7972326a26b5bf8dc2adac575c4e03ee7e9d193a upstream.

This can be reproduced by bind/unbind the driver multiple times
in AM3517 board.

Analysis revealed that rtl8187_start() was invoked before probe
finishes(ie. before the mutex is initialized).

 INFO: trying to register non-static key.
 the code is fine but needs lockdep annotation.
 turning off the locking correctness validator.
 CPU: 0 PID: 821 Comm: wpa_supplicant Not tainted 4.9.80-dirty #250
 Hardware name: Generic AM3517 (Flattened Device Tree)
 [<c010e0d8>] (unwind_backtrace) from [<c010beac>] (show_stack+0x10/0x14)
 [<c010beac>] (show_stack) from [<c017401c>] (register_lock_class+0x4f4/0x55c)
 [<c017401c>] (register_lock_class) from [<c0176fe0>] (__lock_acquire+0x74/0x1938)
 [<c0176fe0>] (__lock_acquire) from [<c0178cfc>] (lock_acquire+0xfc/0x23c)
 [<c0178cfc>] (lock_acquire) from [<c08aa2f8>] (mutex_lock_nested+0x50/0x3b0)
 [<c08aa2f8>] (mutex_lock_nested) from [<c05f5bf8>] (rtl8187_start+0x2c/0xd54)
 [<c05f5bf8>] (rtl8187_start) from [<c082dea0>] (drv_start+0xa8/0x320)
 [<c082dea0>] (drv_start) from [<c084d1d4>] (ieee80211_do_open+0x2bc/0x8e4)
 [<c084d1d4>] (ieee80211_do_open) from [<c069be94>] (__dev_open+0xb8/0x120)
 [<c069be94>] (__dev_open) from [<c069c11c>] (__dev_change_flags+0x88/0x14c)
 [<c069c11c>] (__dev_change_flags) from [<c069c1f8>] (dev_change_flags+0x18/0x48)
 [<c069c1f8>] (dev_change_flags) from [<c0710b08>] (devinet_ioctl+0x738/0x840)
 [<c0710b08>] (devinet_ioctl) from [<c067925c>] (sock_ioctl+0x164/0x2f4)
 [<c067925c>] (sock_ioctl) from [<c02883f8>] (do_vfs_ioctl+0x8c/0x9d0)
 [<c02883f8>] (do_vfs_ioctl) from [<c0288da8>] (SyS_ioctl+0x6c/0x7c)
 [<c0288da8>] (SyS_ioctl) from [<c0107760>] (ret_fast_syscall+0x0/0x1c)
 Unable to handle kernel NULL pointer dereference at virtual address 00000000
 pgd = cd1ec000
 [00000000] *pgd=8d1de831, *pte=00000000, *ppte=00000000
 Internal error: Oops: 817 [#1] PREEMPT ARM
 Modules linked in:
 CPU: 0 PID: 821 Comm: wpa_supplicant Not tainted 4.9.80-dirty #250
 Hardware name: Generic AM3517 (Flattened Device Tree)
 task: ce73eec0 task.stack: cd1ea000
 PC is at mutex_lock_nested+0xe8/0x3b0
 LR is at mutex_lock_nested+0xd0/0x3b0

Signed-off-by: Sudhir Sreedharan <ssreedharan@mvista.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/wireless/rtl818x/rtl8187/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/rtl818x/rtl8187/dev.c
+++ b/drivers/net/wireless/rtl818x/rtl8187/dev.c
@@ -1454,6 +1454,7 @@ static int rtl8187_probe(struct usb_inte
 		goto err_free_dev;
 	}
 	mutex_init(&priv->io_mutex);
+	mutex_init(&priv->conf_mutex);
 
 	SET_IEEE80211_DEV(dev, &intf->dev);
 	usb_set_intfdata(intf, dev);
@@ -1627,7 +1628,6 @@ static int rtl8187_probe(struct usb_inte
 		printk(KERN_ERR "rtl8187: Cannot register device\n");
 		goto err_free_dmabuf;
 	}
-	mutex_init(&priv->conf_mutex);
 	skb_queue_head_init(&priv->b_tx_status.queue);
 
 	wiphy_info(dev->wiphy, "hwaddr %pM, %s V%d + %s, rfkill mask %d\n",

