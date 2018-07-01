Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F99C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CE9253A0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CE9253A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031540AbeGAQkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:40:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37242 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031642AbeGAQkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:40:46 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A1128AA6;
        Sun,  1 Jul 2018 16:40:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mitko Haralanov <mitko.haralanov@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.17 092/220] IB/hfi1: Reorder incorrect send context disable
Date:   Sun,  1 Jul 2018 18:21:56 +0200
Message-Id: <20180701160912.254730412@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael J. Ruhl <michael.j.ruhl@intel.com>

commit a93a0a31111231bb1949f4a83b17238f0fa32d6a upstream.

User send context integrity bits are cleared before the context is
disabled.  If the send context is still processing data, any packets
that need those integrity bits will cause an error and halt the send
context.

During the disable handling, the driver waits for the context to drain.
If the context is halted, the driver will eventually timeout because
the context won't drain and then incorrectly bounce the link.

Reorder the bit clearing and the context disable.

Examine the software state and send context status as well as the
egress status to determine if a send context is in the halted state.

Promote the check macros to static functions for consistency with the
new check and to follow kernel style.

Remove an unused define that refers to the egress timeout.

Cc: <stable@vger.kernel.org> # 4.9.x
Reviewed-by: Mitko Haralanov <mitko.haralanov@intel.com>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/hfi1/file_ops.c |    2 -
 drivers/infiniband/hw/hfi1/pio.c      |   44 ++++++++++++++++++++++++++--------
 2 files changed, 35 insertions(+), 11 deletions(-)

--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -689,8 +689,8 @@ static int hfi1_file_close(struct inode
 	 * checks to default and disable the send context.
 	 */
 	if (uctxt->sc) {
-		set_pio_integrity(uctxt->sc);
 		sc_disable(uctxt->sc);
+		set_pio_integrity(uctxt->sc);
 	}
 
 	hfi1_free_ctxt_rcv_groups(uctxt);
--- a/drivers/infiniband/hw/hfi1/pio.c
+++ b/drivers/infiniband/hw/hfi1/pio.c
@@ -50,8 +50,6 @@
 #include "qp.h"
 #include "trace.h"
 
-#define SC_CTXT_PACKET_EGRESS_TIMEOUT 350 /* in chip cycles */
-
 #define SC(name) SEND_CTXT_##name
 /*
  * Send Context functions
@@ -961,15 +959,40 @@ void sc_disable(struct send_context *sc)
 }
 
 /* return SendEgressCtxtStatus.PacketOccupancy */
-#define packet_occupancy(r) \
-	(((r) & SEND_EGRESS_CTXT_STATUS_CTXT_EGRESS_PACKET_OCCUPANCY_SMASK)\
-	>> SEND_EGRESS_CTXT_STATUS_CTXT_EGRESS_PACKET_OCCUPANCY_SHIFT)
+static u64 packet_occupancy(u64 reg)
+{
+	return (reg &
+		SEND_EGRESS_CTXT_STATUS_CTXT_EGRESS_PACKET_OCCUPANCY_SMASK)
+		>> SEND_EGRESS_CTXT_STATUS_CTXT_EGRESS_PACKET_OCCUPANCY_SHIFT;
+}
 
 /* is egress halted on the context? */
-#define egress_halted(r) \
-	((r) & SEND_EGRESS_CTXT_STATUS_CTXT_EGRESS_HALT_STATUS_SMASK)
+static bool egress_halted(u64 reg)
+{
+	return !!(reg & SEND_EGRESS_CTXT_STATUS_CTXT_EGRESS_HALT_STATUS_SMASK);
+}
+
+/* is the send context halted? */
+static bool is_sc_halted(struct hfi1_devdata *dd, u32 hw_context)
+{
+	return !!(read_kctxt_csr(dd, hw_context, SC(STATUS)) &
+		  SC(STATUS_CTXT_HALTED_SMASK));
+}
 
-/* wait for packet egress, optionally pause for credit return  */
+/**
+ * sc_wait_for_packet_egress
+ * @sc: valid send context
+ * @pause: wait for credit return
+ *
+ * Wait for packet egress, optionally pause for credit return
+ *
+ * Egress halt and Context halt are not necessarily the same thing, so
+ * check for both.
+ *
+ * NOTE: The context halt bit may not be set immediately.  Because of this,
+ * it is necessary to check the SW SFC_HALTED bit (set in the IRQ) and the HW
+ * context bit to determine if the context is halted.
+ */
 static void sc_wait_for_packet_egress(struct send_context *sc, int pause)
 {
 	struct hfi1_devdata *dd = sc->dd;
@@ -981,8 +1004,9 @@ static void sc_wait_for_packet_egress(st
 		reg_prev = reg;
 		reg = read_csr(dd, sc->hw_context * 8 +
 			       SEND_EGRESS_CTXT_STATUS);
-		/* done if egress is stopped */
-		if (egress_halted(reg))
+		/* done if any halt bits, SW or HW are set */
+		if (sc->flags & SCF_HALTED ||
+		    is_sc_halted(dd, sc->hw_context) || egress_halted(reg))
 			break;
 		reg = packet_occupancy(reg);
 		if (reg == 0)


