Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371D3C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEC0240A9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECEC0240A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934537AbeGFFwT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:52:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33772 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933713AbeGFFwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:52:17 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 44247B14;
        Fri,  6 Jul 2018 05:52:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.14 08/61] xhci: Fix kernel oops in trace_xhci_free_virt_device
Date:   Fri,  6 Jul 2018 07:46:32 +0200
Message-Id: <20180706054712.649838840@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
References: <20180706054712.332416244@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

commit d850c1658328e757635a46763783c6fd56390dcb upstream.

commit 44a182b9d177 ("xhci: Fix use-after-free in xhci_free_virt_device")
set dev->udev pointer to NULL in xhci_free_dev(), it will cause kernel
panic in trace_xhci_free_virt_device. This patch reimplement the trace
function trace_xhci_free_virt_device, remove dev->udev dereference and
added more useful parameters to show in the trace function,it also makes
sure dev->udev is not NULL before calling trace_xhci_free_virt_device.
This issue happened when xhci-hcd trace is enabled and USB devices hot
plug test. Original use-after-free patch went to stable so this needs so
be applied there as well.

[ 1092.022457] usb 2-4: USB disconnect, device number 6
[ 1092.092772] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[ 1092.101694] PGD 0 P4D 0
[ 1092.104601] Oops: 0000 [#1] SMP
[ 1092.207734] Workqueue: usb_hub_wq hub_event
[ 1092.212507] RIP: 0010:trace_event_raw_event_xhci_log_virt_dev+0x6c/0xf0
[ 1092.220050] RSP: 0018:ffff8c252e883d28 EFLAGS: 00010086
[ 1092.226024] RAX: ffff8c24af86fa84 RBX: 0000000000000003 RCX: ffff8c25255c2a01
[ 1092.234130] RDX: 0000000000000000 RSI: 00000000aef55009 RDI: ffff8c252e883d28
[ 1092.242242] RBP: ffff8c252550e2c0 R08: ffff8c24af86fa84 R09: 0000000000000a70
[ 1092.250364] R10: 0000000000000a70 R11: 0000000000000000 R12: ffff8c251f21a000
[ 1092.258468] R13: 000000000000000c R14: ffff8c251f21a000 R15: ffff8c251f432f60
[ 1092.266572] FS:  0000000000000000(0000) GS:ffff8c252e880000(0000) knlGS:0000000000000000
[ 1092.275757] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1092.282281] CR2: 0000000000000000 CR3: 0000000154209001 CR4: 00000000003606e0
[ 1092.290384] Call Trace:
[ 1092.293156]  <IRQ>
[ 1092.295439]  xhci_free_virt_device.part.34+0x182/0x1a0
[ 1092.301288]  handle_cmd_completion+0x7ac/0xfa0
[ 1092.306336]  ? trace_event_raw_event_xhci_log_trb+0x6e/0xa0
[ 1092.312661]  xhci_irq+0x3e8/0x1f60
[ 1092.316524]  __handle_irq_event_percpu+0x75/0x180
[ 1092.321876]  handle_irq_event_percpu+0x20/0x50
[ 1092.326922]  handle_irq_event+0x36/0x60
[ 1092.331273]  handle_edge_irq+0x6d/0x180
[ 1092.335644]  handle_irq+0x16/0x20
[ 1092.339417]  do_IRQ+0x41/0xc0
[ 1092.342782]  common_interrupt+0xf/0xf
[ 1092.346955]  </IRQ>

Fixes: 44a182b9d177 ("xhci: Fix use-after-free in xhci_free_virt_device")
Cc: <stable@vger.kernel.org>
Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-mem.c   |    4 ++--
 drivers/usb/host/xhci-trace.h |   36 +++++++++++++++++++++++++++++++-----
 2 files changed, 33 insertions(+), 7 deletions(-)

--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -891,12 +891,12 @@ void xhci_free_virt_device(struct xhci_h
 
 	dev = xhci->devs[slot_id];
 
-	trace_xhci_free_virt_device(dev);
-
 	xhci->dcbaa->dev_context_ptrs[slot_id] = 0;
 	if (!dev)
 		return;
 
+	trace_xhci_free_virt_device(dev);
+
 	if (dev->tt_info)
 		old_active_eps = dev->tt_info->active_eps;
 
--- a/drivers/usb/host/xhci-trace.h
+++ b/drivers/usb/host/xhci-trace.h
@@ -158,6 +158,37 @@ DEFINE_EVENT(xhci_log_trb, xhci_queue_tr
 	TP_ARGS(ring, trb)
 );
 
+DECLARE_EVENT_CLASS(xhci_log_free_virt_dev,
+	TP_PROTO(struct xhci_virt_device *vdev),
+	TP_ARGS(vdev),
+	TP_STRUCT__entry(
+		__field(void *, vdev)
+		__field(unsigned long long, out_ctx)
+		__field(unsigned long long, in_ctx)
+		__field(u8, fake_port)
+		__field(u8, real_port)
+		__field(u16, current_mel)
+
+	),
+	TP_fast_assign(
+		__entry->vdev = vdev;
+		__entry->in_ctx = (unsigned long long) vdev->in_ctx->dma;
+		__entry->out_ctx = (unsigned long long) vdev->out_ctx->dma;
+		__entry->fake_port = (u8) vdev->fake_port;
+		__entry->real_port = (u8) vdev->real_port;
+		__entry->current_mel = (u16) vdev->current_mel;
+		),
+	TP_printk("vdev %p ctx %llx | %llx fake_port %d real_port %d current_mel %d",
+		__entry->vdev, __entry->in_ctx, __entry->out_ctx,
+		__entry->fake_port, __entry->real_port, __entry->current_mel
+	)
+);
+
+DEFINE_EVENT(xhci_log_free_virt_dev, xhci_free_virt_device,
+	TP_PROTO(struct xhci_virt_device *vdev),
+	TP_ARGS(vdev)
+);
+
 DECLARE_EVENT_CLASS(xhci_log_virt_dev,
 	TP_PROTO(struct xhci_virt_device *vdev),
 	TP_ARGS(vdev),
@@ -194,11 +225,6 @@ DEFINE_EVENT(xhci_log_virt_dev, xhci_all
 	TP_PROTO(struct xhci_virt_device *vdev),
 	TP_ARGS(vdev)
 );
-
-DEFINE_EVENT(xhci_log_virt_dev, xhci_free_virt_device,
-	TP_PROTO(struct xhci_virt_device *vdev),
-	TP_ARGS(vdev)
-);
 
 DEFINE_EVENT(xhci_log_virt_dev, xhci_setup_device,
 	TP_PROTO(struct xhci_virt_device *vdev),


