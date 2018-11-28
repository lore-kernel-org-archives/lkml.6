Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B70C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD91D2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD91D2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbeK2D2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:28:11 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:42470 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728262AbeK2D2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:28:11 -0500
Received: (qmail 4961 invoked by uid 2102); 28 Nov 2018 11:25:58 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Nov 2018 11:25:58 -0500
Date:   Wed, 28 Nov 2018 11:25:58 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Greg KH <greg@kroah.com>
cc:     syzbot <syzbot+98881958e1410ec7e53c@syzkaller.appspotmail.com>,
        <drinkcat@chromium.org>, <jflat@chromium.org>, <joe@perches.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] USB: Fix invalid-free bug in port_over_current_notify()
In-Reply-To: <00000000000094bcc5057b92843f@google.com>
Message-ID: <Pine.LNX.4.44L0.1811281109270.1473-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot and KASAN found the following invalid-free bug in
port_over_current_notify():

--------------------------------------------------------------------------
BUG: KASAN: double-free or invalid-free in port_over_current_notify  
drivers/usb/core/hub.c:5192 [inline]
BUG: KASAN: double-free or invalid-free in port_event  
drivers/usb/core/hub.c:5241 [inline]
BUG: KASAN: double-free or invalid-free in hub_event+0xd97/0x4140  
drivers/usb/core/hub.c:5384

CPU: 1 PID: 32710 Comm: kworker/1:3 Not tainted 4.20.0-rc3+ #129
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_invalid_free+0x64/0xa0 mm/kasan/report.c:336
  __kasan_slab_free+0x13a/0x150 mm/kasan/kasan.c:501
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  port_over_current_notify drivers/usb/core/hub.c:5192 [inline]
  port_event drivers/usb/core/hub.c:5241 [inline]
  hub_event+0xd97/0x4140 drivers/usb/core/hub.c:5384
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
--------------------------------------------------------------------------

The problem is caused by use of a static array to store
environment-string pointers.  When the routine is called by multiple
threads concurrently, the pointers from one thread can overwrite those
from another.

The solution is to use an ordinary automatic array instead of a static
array.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-by: syzbot+98881958e1410ec7e53c@syzkaller.appspotmail.com

---


[as1881]


 drivers/usb/core/hub.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: usb-4.x/drivers/usb/core/hub.c
===================================================================
--- usb-4.x.orig/drivers/usb/core/hub.c
+++ usb-4.x/drivers/usb/core/hub.c
@@ -5163,7 +5163,7 @@ static void hub_port_connect_change(stru
 /* Handle notifying userspace about hub over-current events */
 static void port_over_current_notify(struct usb_port *port_dev)
 {
-	static char *envp[] = { NULL, NULL, NULL };
+	char *envp[3];
 	struct device *hub_dev;
 	char *port_dev_path;
 
@@ -5187,6 +5187,7 @@ static void port_over_current_notify(str
 	if (!envp[1])
 		goto exit;
 
+	envp[2] = NULL;
 	kobject_uevent_env(&hub_dev->kobj, KOBJ_CHANGE, envp);
 
 	kfree(envp[1]);

