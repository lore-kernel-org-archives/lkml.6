Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937466AbeE1Nwa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162657AbeE1Kly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:41:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.14 019/496] IB/hfi1: Use after free race condition in send context error path
Date: Mon, 28 May 2018 11:56:44 +0200
Message-Id: <20180528100320.394362528@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael J. Ruhl <michael.j.ruhl@intel.com>

commit f9e76ca3771bf23d2142a81a88ddd8f31f5c4c03 upstream.

A pio send egress error can occur when the PSM library attempts to
to send a bad packet.  That issue is still being investigated.

The pio error interrupt handler then attempts to progress the recovery
of the errored pio send context.

Code inspection reveals that the handling lacks the necessary locking
if that recovery interleaves with a PSM close of the "context" object
contains the pio send context.

The lack of the locking can cause the recovery to access the already
freed pio send context object and incorrectly deduce that the pio
send context is actually a kernel pio send context as shown by the
NULL deref stack below:

[<ffffffff8143d78c>] _dev_info+0x6c/0x90
[<ffffffffc0613230>] sc_restart+0x70/0x1f0 [hfi1]
[<ffffffff816ab124>] ? __schedule+0x424/0x9b0
[<ffffffffc06133c5>] sc_halted+0x15/0x20 [hfi1]
[<ffffffff810aa3ba>] process_one_work+0x17a/0x440
[<ffffffff810ab086>] worker_thread+0x126/0x3c0
[<ffffffff810aaf60>] ? manage_workers.isra.24+0x2a0/0x2a0
[<ffffffff810b252f>] kthread+0xcf/0xe0
[<ffffffff810b2460>] ? insert_kthread_work+0x40/0x40
[<ffffffff816b8798>] ret_from_fork+0x58/0x90
[<ffffffff810b2460>] ? insert_kthread_work+0x40/0x40

This is the best case scenario and other scenarios can corrupt the
already freed memory.

Fix by adding the necessary locking in the pio send context error
handler.

Cc: <stable@vger.kernel.org> # 4.9.x
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/hfi1/chip.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -5945,6 +5945,7 @@ static void is_sendctxt_err_int(struct h
 	u64 status;
 	u32 sw_index;
 	int i = 0;
+	unsigned long irq_flags;
 
 	sw_index = dd->hw_to_sw[hw_context];
 	if (sw_index >= dd->num_send_contexts) {
@@ -5954,10 +5955,12 @@ static void is_sendctxt_err_int(struct h
 		return;
 	}
 	sci = &dd->send_contexts[sw_index];
+	spin_lock_irqsave(&dd->sc_lock, irq_flags);
 	sc = sci->sc;
 	if (!sc) {
 		dd_dev_err(dd, "%s: context %u(%u): no sc?\n", __func__,
 			   sw_index, hw_context);
+		spin_unlock_irqrestore(&dd->sc_lock, irq_flags);
 		return;
 	}
 
@@ -5979,6 +5982,7 @@ static void is_sendctxt_err_int(struct h
 	 */
 	if (sc->type != SC_USER)
 		queue_work(dd->pport->hfi1_wq, &sc->halt_work);
+	spin_unlock_irqrestore(&dd->sc_lock, irq_flags);
 
 	/*
 	 * Update the counters for the corresponding status bits.
