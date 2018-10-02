Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BF1C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882EE206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882EE206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbeJBUN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:13:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33610 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730508AbeJBUN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:13:58 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0FE49C4E;
        Tue,  2 Oct 2018 13:30:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.18 165/228] IB/hfi1: Fix destroy_qp hang after a link down
Date:   Tue,  2 Oct 2018 06:24:22 -0700
Message-Id: <20181002132509.926011723@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael J. Ruhl <michael.j.ruhl@intel.com>

commit b4a4957d3d1c328b733fce783b7264996f866ad2 upstream.

rvt_destroy_qp() cannot complete until all in process packets have
been released from the underlying hardware.  If a link down event
occurs, an application can hang with a kernel stack similar to:

cat /proc/<app PID>/stack
 quiesce_qp+0x178/0x250 [hfi1]
 rvt_reset_qp+0x23d/0x400 [rdmavt]
 rvt_destroy_qp+0x69/0x210 [rdmavt]
 ib_destroy_qp+0xba/0x1c0 [ib_core]
 nvme_rdma_destroy_queue_ib+0x46/0x80 [nvme_rdma]
 nvme_rdma_free_queue+0x3c/0xd0 [nvme_rdma]
 nvme_rdma_destroy_io_queues+0x88/0xd0 [nvme_rdma]
 nvme_rdma_error_recovery_work+0x52/0xf0 [nvme_rdma]
 process_one_work+0x17a/0x440
 worker_thread+0x126/0x3c0
 kthread+0xcf/0xe0
 ret_from_fork+0x58/0x90
 0xffffffffffffffff

quiesce_qp() waits until all outstanding packets have been freed.
This wait should be momentary.  During a link down event, the cleanup
handling does not ensure that all packets caught by the link down are
flushed properly.

This is caused by the fact that the freeze path and the link down
event is handled the same.  This is not correct.  The freeze path
waits until the HFI is unfrozen and then restarts PIO.  A link down
is not a freeze event.  The link down path cannot restart the PIO
until link is restored.  If the PIO path is restarted before the link
comes up, the application (QP) using the PIO path will hang (until
link is restored).

Fix by separating the linkdown path from the freeze path and use the
link down path for link down events.

Close a race condition sc_disable() by acquiring both the progress
and release locks.

Close a race condition in sc_stop() by moving the setting of the flag
bits under the alloc lock.

Cc: <stable@vger.kernel.org> # 4.9.x+
Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/hfi1/chip.c |    6 ++++-
 drivers/infiniband/hw/hfi1/pio.c  |   42 ++++++++++++++++++++++++++++++--------
 drivers/infiniband/hw/hfi1/pio.h  |    2 +
 3 files changed, 41 insertions(+), 9 deletions(-)

--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -6733,6 +6733,7 @@ void start_freeze_handling(struct hfi1_p
 	struct hfi1_devdata *dd = ppd->dd;
 	struct send_context *sc;
 	int i;
+	int sc_flags;
 
 	if (flags & FREEZE_SELF)
 		write_csr(dd, CCE_CTRL, CCE_CTRL_SPC_FREEZE_SMASK);
@@ -6743,11 +6744,13 @@ void start_freeze_handling(struct hfi1_p
 	/* notify all SDMA engines that they are going into a freeze */
 	sdma_freeze_notify(dd, !!(flags & FREEZE_LINK_DOWN));
 
+	sc_flags = SCF_FROZEN | SCF_HALTED | (flags & FREEZE_LINK_DOWN ?
+					      SCF_LINK_DOWN : 0);
 	/* do halt pre-handling on all enabled send contexts */
 	for (i = 0; i < dd->num_send_contexts; i++) {
 		sc = dd->send_contexts[i].sc;
 		if (sc && (sc->flags & SCF_ENABLED))
-			sc_stop(sc, SCF_FROZEN | SCF_HALTED);
+			sc_stop(sc, sc_flags);
 	}
 
 	/* Send context are frozen. Notify user space */
@@ -10665,6 +10668,7 @@ int set_link_state(struct hfi1_pportdata
 		add_rcvctrl(dd, RCV_CTRL_RCV_PORT_ENABLE_SMASK);
 
 		handle_linkup_change(dd, 1);
+		pio_kernel_linkup(dd);
 
 		/*
 		 * After link up, a new link width will have been set.
--- a/drivers/infiniband/hw/hfi1/pio.c
+++ b/drivers/infiniband/hw/hfi1/pio.c
@@ -926,20 +926,18 @@ void sc_free(struct send_context *sc)
 void sc_disable(struct send_context *sc)
 {
 	u64 reg;
-	unsigned long flags;
 	struct pio_buf *pbuf;
 
 	if (!sc)
 		return;
 
 	/* do all steps, even if already disabled */
-	spin_lock_irqsave(&sc->alloc_lock, flags);
+	spin_lock_irq(&sc->alloc_lock);
 	reg = read_kctxt_csr(sc->dd, sc->hw_context, SC(CTRL));
 	reg &= ~SC(CTRL_CTXT_ENABLE_SMASK);
 	sc->flags &= ~SCF_ENABLED;
 	sc_wait_for_packet_egress(sc, 1);
 	write_kctxt_csr(sc->dd, sc->hw_context, SC(CTRL), reg);
-	spin_unlock_irqrestore(&sc->alloc_lock, flags);
 
 	/*
 	 * Flush any waiters.  Once the context is disabled,
@@ -949,7 +947,7 @@ void sc_disable(struct send_context *sc)
 	 * proceed with the flush.
 	 */
 	udelay(1);
-	spin_lock_irqsave(&sc->release_lock, flags);
+	spin_lock(&sc->release_lock);
 	if (sc->sr) {	/* this context has a shadow ring */
 		while (sc->sr_tail != sc->sr_head) {
 			pbuf = &sc->sr[sc->sr_tail].pbuf;
@@ -960,7 +958,8 @@ void sc_disable(struct send_context *sc)
 				sc->sr_tail = 0;
 		}
 	}
-	spin_unlock_irqrestore(&sc->release_lock, flags);
+	spin_unlock(&sc->release_lock);
+	spin_unlock_irq(&sc->alloc_lock);
 }
 
 /* return SendEgressCtxtStatus.PacketOccupancy */
@@ -1183,11 +1182,39 @@ void pio_kernel_unfreeze(struct hfi1_dev
 		sc = dd->send_contexts[i].sc;
 		if (!sc || !(sc->flags & SCF_FROZEN) || sc->type == SC_USER)
 			continue;
+		if (sc->flags & SCF_LINK_DOWN)
+			continue;
 
 		sc_enable(sc);	/* will clear the sc frozen flag */
 	}
 }
 
+/**
+ * pio_kernel_linkup() - Re-enable send contexts after linkup event
+ * @dd: valid devive data
+ *
+ * When the link goes down, the freeze path is taken.  However, a link down
+ * event is different from a freeze because if the send context is re-enabled
+ * whowever is sending data will start sending data again, which will hang
+ * any QP that is sending data.
+ *
+ * The freeze path now looks at the type of event that occurs and takes this
+ * path for link down event.
+ */
+void pio_kernel_linkup(struct hfi1_devdata *dd)
+{
+	struct send_context *sc;
+	int i;
+
+	for (i = 0; i < dd->num_send_contexts; i++) {
+		sc = dd->send_contexts[i].sc;
+		if (!sc || !(sc->flags & SCF_LINK_DOWN) || sc->type == SC_USER)
+			continue;
+
+		sc_enable(sc);	/* will clear the sc link down flag */
+	}
+}
+
 /*
  * Wait for the SendPioInitCtxt.PioInitInProgress bit to clear.
  * Returns:
@@ -1387,11 +1414,10 @@ void sc_stop(struct send_context *sc, in
 {
 	unsigned long flags;
 
-	/* mark the context */
-	sc->flags |= flag;
-
 	/* stop buffer allocations */
 	spin_lock_irqsave(&sc->alloc_lock, flags);
+	/* mark the context */
+	sc->flags |= flag;
 	sc->flags &= ~SCF_ENABLED;
 	spin_unlock_irqrestore(&sc->alloc_lock, flags);
 	wake_up(&sc->halt_wait);
--- a/drivers/infiniband/hw/hfi1/pio.h
+++ b/drivers/infiniband/hw/hfi1/pio.h
@@ -139,6 +139,7 @@ struct send_context {
 #define SCF_IN_FREE 0x02
 #define SCF_HALTED  0x04
 #define SCF_FROZEN  0x08
+#define SCF_LINK_DOWN 0x10
 
 struct send_context_info {
 	struct send_context *sc;	/* allocated working context */
@@ -306,6 +307,7 @@ void set_pio_integrity(struct send_conte
 void pio_reset_all(struct hfi1_devdata *dd);
 void pio_freeze(struct hfi1_devdata *dd);
 void pio_kernel_unfreeze(struct hfi1_devdata *dd);
+void pio_kernel_linkup(struct hfi1_devdata *dd);
 
 /* global PIO send control operations */
 #define PSC_GLOBAL_ENABLE 0


