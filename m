Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42532C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBE220863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfBAJDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:03:18 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:53184 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfBAJDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:03:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 90D2D18398;
        Fri,  1 Feb 2019 10:03:15 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id VzNq7Jb21NCN; Fri,  1 Feb 2019 10:03:14 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id 02B6D18652;
        Fri,  1 Feb 2019 10:03:14 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCBDD1E092;
        Fri,  1 Feb 2019 10:03:13 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D02101E091;
        Fri,  1 Feb 2019 10:03:13 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Fri,  1 Feb 2019 10:03:13 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id C32BB26ED;
        Fri,  1 Feb 2019 10:03:13 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id BF83580C3C; Fri,  1 Feb 2019 10:03:13 +0100 (CET)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        zhangweiping@didichuxing.com, Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH] mic: vop: Fix use-after-free on remove
Date:   Fri,  1 Feb 2019 10:03:12 +0100
Message-Id: <20190201090312.16603-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN detects a use-after-free when vop devices are removed.

This problem was introduced by commit 0063e8bbd2b62d136 ("virtio_vop:
don't kfree device on register failure").  That patch moved the freeing
of the struct _vop_vdev to the release function, but failed to ensure
that vop holds a reference to the device when it doesn't want it to go
away.  A kfree() was replaced with a put_device() in the unregistration
path, but the last reference to the device is already dropped in
unregister_virtio_device() so the struct is freed before vop is done
with it.

Fix it by holding a reference until cleanup is done.  This is similar to
the fix in virtio_pci in commit 2989be09a8a9d6 ("virtio_pci: fix use
after free on release").

 ==================================================================
 BUG: KASAN: use-after-free in vop_scan_devices+0xc6c/0xe50 [vop]
 Read of size 8 at addr ffff88800da18580 by task kworker/0:1/12

 CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.0.0-rc4+ #53
 Workqueue: events vop_hotplug_devices [vop]
 Call Trace:
  dump_stack+0x74/0xbb
  print_address_description+0x5d/0x2b0
  ? vop_scan_devices+0xc6c/0xe50 [vop]
  kasan_report+0x152/0x1aa
  ? vop_scan_devices+0xc6c/0xe50 [vop]
  ? vop_scan_devices+0xc6c/0xe50 [vop]
  vop_scan_devices+0xc6c/0xe50 [vop]
  ? vop_loopback_free_irq+0x160/0x160 [vop_loopback]
  process_one_work+0x7c0/0x14b0
  ? pwq_dec_nr_in_flight+0x2d0/0x2d0
  ? do_raw_spin_lock+0x120/0x280
  worker_thread+0x8f/0xbf0
  ? __kthread_parkme+0x78/0xf0
  ? process_one_work+0x14b0/0x14b0
  kthread+0x2ae/0x3a0
  ? kthread_park+0x120/0x120
  ret_from_fork+0x3a/0x50

 Allocated by task 12:
  kmem_cache_alloc_trace+0x13a/0x2a0
  vop_scan_devices+0x473/0xe50 [vop]
  process_one_work+0x7c0/0x14b0
  worker_thread+0x8f/0xbf0
  kthread+0x2ae/0x3a0
  ret_from_fork+0x3a/0x50

 Freed by task 12:
  kfree+0x104/0x310
  device_release+0x73/0x1d0
  kobject_put+0x14f/0x420
  unregister_virtio_device+0x32/0x50
  vop_scan_devices+0x19d/0xe50 [vop]
  process_one_work+0x7c0/0x14b0
  worker_thread+0x8f/0xbf0
  kthread+0x2ae/0x3a0
  ret_from_fork+0x3a/0x50

 The buggy address belongs to the object at ffff88800da18008
  which belongs to the cache kmalloc-2k of size 2048
 The buggy address is located 1400 bytes inside of
  2048-byte region [ffff88800da18008, ffff88800da18808)
 The buggy address belongs to the page:
 page:ffffea0000368600 count:1 mapcount:0 mapping:ffff88801440dbc0 index:0x0 compound_mapcount: 0
 flags: 0x4000000000010200(slab|head)
 raw: 4000000000010200 ffffea0000378608 ffffea000037a008 ffff88801440dbc0
 raw: 0000000000000000 00000000000d000d 00000001ffffffff 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ffff88800da18480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88800da18500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 >ffff88800da18580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                    ^
  ffff88800da18600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88800da18680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ==================================================================

Fixes: 0063e8bbd2b62d136 ("virtio_vop: don't kfree device on register failure")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/misc/mic/vop/vop_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index 6606e704b832..c4517703dc1d 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -598,6 +598,8 @@ static int _vop_remove_device(struct mic_device_desc __iomem *d,
 	int ret = -1;
 
 	if (ioread8(&dc->config_change) == MIC_VIRTIO_PARAM_DEV_REMOVE) {
+		struct device *dev = get_device(&vdev->vdev.dev);
+
 		dev_dbg(&vpdev->dev,
 			"%s %d config_change %d type %d vdev %p\n",
 			__func__, __LINE__,
@@ -609,7 +611,7 @@ static int _vop_remove_device(struct mic_device_desc __iomem *d,
 		iowrite8(-1, &dc->h2c_vdev_db);
 		if (status & VIRTIO_CONFIG_S_DRIVER_OK)
 			wait_for_completion(&vdev->reset_done);
-		put_device(&vdev->vdev.dev);
+		put_device(dev);
 		iowrite8(1, &dc->guest_ack);
 		dev_dbg(&vpdev->dev, "%s %d guest_ack %d\n",
 			__func__, __LINE__, ioread8(&dc->guest_ack));
-- 
2.20.0

