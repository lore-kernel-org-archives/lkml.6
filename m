Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F75C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174D720835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083573;
	bh=xThc1wH+BBUrkdOT5afZonwptNLqtqr+KapDHZsIpdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MblZzUZWWNnZIWJidOBIKBEnF4Jzd7sk7+kX3jyYgvw+Q7NBuZ+HT8rrV1LfJIdnm
	 NUv+ntoCgxhs7Y8hQnKr4/R3H99+LvpLTlnjH9jUuG3oq2f9s9ibG2IrdG3SMjeC1n
	 oUArdAtcoG9AVag3/DJP/YicrAbY4on7/0oDg2VA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbfBMSqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:46:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:44746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406378AbfBMSqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:46:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E86D0222D1;
        Wed, 13 Feb 2019 18:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083567;
        bh=xThc1wH+BBUrkdOT5afZonwptNLqtqr+KapDHZsIpdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BZxHI9yfFVvNFjxHBFqikcuieCq6hokCyyttzrSxD1/wCuReieqD5LlLmQ0pYfopR
         tBtO51FKW3rsV391LkXQqWI5sAGdB3vO2nHdhNcBkGZ0sT7AcYWsUPeM7nyhVM70xt
         QbliMQCQxbYnwg/YbRYOX26LvHLm/KbeZqQ/vM9Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 4.20 35/50] mic: vop: Fix use-after-free on remove
Date:   Wed, 13 Feb 2019 19:38:40 +0100
Message-Id: <20190213183658.511611212@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vincent Whitchurch <vincent.whitchurch@axis.com>

commit 70ed7148dadb812f2f7c9927e98ef3cf4869dfa9 upstream.

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
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/mic/vop/vop_main.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -568,6 +568,8 @@ static int _vop_remove_device(struct mic
 	int ret = -1;
 
 	if (ioread8(&dc->config_change) == MIC_VIRTIO_PARAM_DEV_REMOVE) {
+		struct device *dev = get_device(&vdev->vdev.dev);
+
 		dev_dbg(&vpdev->dev,
 			"%s %d config_change %d type %d vdev %p\n",
 			__func__, __LINE__,
@@ -579,7 +581,7 @@ static int _vop_remove_device(struct mic
 		iowrite8(-1, &dc->h2c_vdev_db);
 		if (status & VIRTIO_CONFIG_S_DRIVER_OK)
 			wait_for_completion(&vdev->reset_done);
-		put_device(&vdev->vdev.dev);
+		put_device(dev);
 		iowrite8(1, &dc->guest_ack);
 		dev_dbg(&vpdev->dev, "%s %d guest_ack %d\n",
 			__func__, __LINE__, ioread8(&dc->guest_ack));


