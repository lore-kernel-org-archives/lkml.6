Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB617C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 15:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3208421A13
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 15:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3208421A13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeHKR41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 13:56:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727324AbeHKR40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 13:56:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8E8A24219DA8;
        Sat, 11 Aug 2018 15:21:54 +0000 (UTC)
Received: from localhost.redhat.com (ovpn-12-58.pek2.redhat.com [10.72.12.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C0A5416873;
        Sat, 11 Aug 2018 15:21:50 +0000 (UTC)
From:   Xiao Liang <xiliang@redhat.com>
To:     netdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        davem@davemloft.net, jgross@suse.com, boris.ostrovsky@oracle.com
Cc:     linux-kernel@vger.kernel.org, Xiao Liang <xiliang@redhat.com>
Subject: [PATCH v2] xen-netfront: fix warn message as irq device name has '/'
Date:   Sat, 11 Aug 2018 23:21:37 +0800
Message-Id: <20180811152137.3627-1-xiliang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sat, 11 Aug 2018 15:21:54 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sat, 11 Aug 2018 15:21:54 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'xiliang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a call trace generated after commit 2d408c0d4574b01b9ed45e02516888bf925e11a9(
xen-netfront: fix queue name setting). There is no 'device/vif/xx-q0-tx' file found
under /proc/irq/xx/.

This patch only picks up device type and id as its name.

With the patch, now /proc/interrupts looks like below and the warning message gone:
 70:         21          0          0          0   xen-dyn    -event     vif0-q0-tx
 71:         15          0          0          0   xen-dyn    -event     vif0-q0-rx
 72:         14          0          0          0   xen-dyn    -event     vif0-q1-tx
 73:         33          0          0          0   xen-dyn    -event     vif0-q1-rx
 74:         12          0          0          0   xen-dyn    -event     vif0-q2-tx
 75:         24          0          0          0   xen-dyn    -event     vif0-q2-rx
 76:         19          0          0          0   xen-dyn    -event     vif0-q3-tx
 77:         21          0          0          0   xen-dyn    -event     vif0-q3-rx

Below is call trace information without this patch:

name 'device/vif/0-q0-tx'
WARNING: CPU: 2 PID: 37 at fs/proc/generic.c:174 __xlate_proc_name+0x85/0xa0
RIP: 0010:__xlate_proc_name+0x85/0xa0
RSP: 0018:ffffb85c40473c18 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000006 RCX: 0000000000000006
RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff984c7f516930
RBP: ffffb85c40473cb8 R08: 000000000000002c R09: 0000000000000229
R10: 0000000000000000 R11: 0000000000000001 R12: ffffb85c40473c98
R13: ffffb85c40473cb8 R14: ffffb85c40473c50 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff984c7f500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f69b6899038 CR3: 000000001c20a006 CR4: 00000000001606e0
Call Trace:
__proc_create+0x45/0x230
? snprintf+0x49/0x60
proc_mkdir_data+0x35/0x90
register_handler_proc+0xef/0x110
? proc_register+0xfc/0x110
? proc_create_data+0x70/0xb0
__setup_irq+0x39b/0x660
? request_threaded_irq+0xad/0x160
request_threaded_irq+0xf5/0x160
? xennet_tx_buf_gc+0x1d0/0x1d0 [xen_netfront]
bind_evtchn_to_irqhandler+0x3d/0x70
? xenbus_alloc_evtchn+0x41/0xa0
netback_changed+0xa46/0xcda [xen_netfront]
? find_watch+0x40/0x40
xenwatch_thread+0xc5/0x160
? finish_wait+0x80/0x80
kthread+0x112/0x130
? kthread_create_worker_on_cpu+0x70/0x70
ret_from_fork+0x35/0x40
Code: 81 5c 00 48 85 c0 75 cc 5b 49 89 2e 31 c0 5d 4d 89 3c 24 41 5c 41 5d 41 5e 41 5f c3 4c 89 ee 48 c7 c7 40 4f 0e b4 e8 65 ea d8 ff <0f> 0b b8 fe ff ff ff 5b 5d 41 5c 41 5d 41 5e 41 5f c3 66 0f 1f
---[ end trace 650e5561b0caab3a ]---

Signed-off-by: Xiao Liang <xiliang@redhat.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
 drivers/net/xen-netfront.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 799cba4624a5..02f46237cfc6 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1604,14 +1604,16 @@ static int xennet_init_queue(struct netfront_queue *queue)
 {
 	unsigned short i;
 	int err = 0;
+	int devid = 0;
 
 	spin_lock_init(&queue->tx_lock);
 	spin_lock_init(&queue->rx_lock);
 
 	timer_setup(&queue->rx_refill_timer, rx_refill_timeout, 0);
 
-	snprintf(queue->name, sizeof(queue->name), "%s-q%u",
-		 queue->info->xbdev->nodename, queue->id);
+	kstrtoint(strrchr(queue->info->xbdev->nodename, '/') + 1, 10, &devid);
+	snprintf(queue->name, sizeof(queue->name), "vif%d-q%u",
+		 devid, queue->id);
 
 	/* Initialise tx_skbs as a free chain containing every entry. */
 	queue->tx_skb_freelist = 0;
-- 
2.17.1

