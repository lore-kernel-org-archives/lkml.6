Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27C2ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F4920652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F4920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389818AbeGTN2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:28:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50370 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389044AbeGTN2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:28:48 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5F6C1C93;
        Fri, 20 Jul 2018 12:37:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 039/101] s390/qeth: dont clobber buffer on async TX completion
Date:   Fri, 20 Jul 2018 14:13:45 +0200
Message-Id: <20180720121424.643443631@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
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

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit ce28867fd20c23cd769e78b4d619c4755bf71a1c ]

If qeth_qdio_output_handler() detects that a transmit requires async
completion, it replaces the pending buffer's metadata object
(qeth_qdio_out_buffer) so that this queue buffer can be re-used while
the data is pending completion.

Later when the CQ indicates async completion of such a metadata object,
qeth_qdio_cq_handler() tries to free any data associated with this
object (since HW has now completed the transfer). By calling
qeth_clear_output_buffer(), it erronously operates on the queue buffer
that _previously_ belonged to this transfer ... but which has been
potentially re-used several times by now.
This results in double-free's of the buffer's data, and failing
transmits as the buffer descriptor is scrubbed in mid-air.

The correct way of handling this situation is to
1. scrub the queue buffer when it is prepared for re-use, and
2. later obtain the data addresses from the async-completion notifier
   (ie. the AOB), instead of the queue buffer.

All this only affects qeth devices used for af_iucv HiperTransport.

Fixes: 0da9581ddb0f ("qeth: exploit asynchronous delivery of storage blocks")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core.h      |   11 +++++++++++
 drivers/s390/net/qeth_core_main.c |   22 ++++++++++++++++------
 2 files changed, 27 insertions(+), 6 deletions(-)

--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -831,6 +831,17 @@ struct qeth_trap_id {
 /*some helper functions*/
 #define QETH_CARD_IFNAME(card) (((card)->dev)? (card)->dev->name : "")
 
+static inline void qeth_scrub_qdio_buffer(struct qdio_buffer *buf,
+					  unsigned int elements)
+{
+	unsigned int i;
+
+	for (i = 0; i < elements; i++)
+		memset(&buf->element[i], 0, sizeof(struct qdio_buffer_element));
+	buf->element[14].sflags = 0;
+	buf->element[15].sflags = 0;
+}
+
 /**
  * qeth_get_elements_for_range() -	find number of SBALEs to cover range.
  * @start:				Start of the address range.
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -73,9 +73,6 @@ static void qeth_notify_skbs(struct qeth
 		struct qeth_qdio_out_buffer *buf,
 		enum iucv_tx_notify notification);
 static void qeth_release_skbs(struct qeth_qdio_out_buffer *buf);
-static void qeth_clear_output_buffer(struct qeth_qdio_out_q *queue,
-		struct qeth_qdio_out_buffer *buf,
-		enum qeth_qdio_buffer_states newbufstate);
 static int qeth_init_qdio_out_buf(struct qeth_qdio_out_q *, int);
 
 struct workqueue_struct *qeth_wq;
@@ -488,6 +485,7 @@ static void qeth_qdio_handle_aob(struct
 	struct qaob *aob;
 	struct qeth_qdio_out_buffer *buffer;
 	enum iucv_tx_notify notification;
+	unsigned int i;
 
 	aob = (struct qaob *) phys_to_virt(phys_aob_addr);
 	QETH_CARD_TEXT(card, 5, "haob");
@@ -512,10 +510,18 @@ static void qeth_qdio_handle_aob(struct
 	qeth_notify_skbs(buffer->q, buffer, notification);
 
 	buffer->aob = NULL;
-	qeth_clear_output_buffer(buffer->q, buffer,
-				 QETH_QDIO_BUF_HANDLED_DELAYED);
+	/* Free dangling allocations. The attached skbs are handled by
+	 * qeth_cleanup_handled_pending().
+	 */
+	for (i = 0;
+	     i < aob->sb_count && i < QETH_MAX_BUFFER_ELEMENTS(card);
+	     i++) {
+		if (aob->sba[i] && buffer->is_header[i])
+			kmem_cache_free(qeth_core_header_cache,
+					(void *) aob->sba[i]);
+	}
+	atomic_set(&buffer->state, QETH_QDIO_BUF_HANDLED_DELAYED);
 
-	/* from here on: do not touch buffer anymore */
 	qdio_release_aob(aob);
 }
 
@@ -3759,6 +3765,10 @@ void qeth_qdio_output_handler(struct ccw
 			QETH_CARD_TEXT(queue->card, 5, "aob");
 			QETH_CARD_TEXT_(queue->card, 5, "%lx",
 					virt_to_phys(buffer->aob));
+
+			/* prepare the queue slot for re-use: */
+			qeth_scrub_qdio_buffer(buffer->buffer,
+					       QETH_MAX_BUFFER_ELEMENTS(card));
 			if (qeth_init_qdio_out_buf(queue, bidx)) {
 				QETH_CARD_TEXT(card, 2, "outofbuf");
 				qeth_schedule_recovery(card);


