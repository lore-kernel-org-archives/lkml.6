Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D571C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F672080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F672080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbeKLF4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:56:17 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52026 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727449AbeKLF4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:56:16 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsv-0000l8-C7; Sun, 11 Nov 2018 19:59:05 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsV-0001eq-1l; Sun, 11 Nov 2018 19:58:39 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Julian Wiedmann" <jwi@linux.ibm.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.242214680@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 214/366] s390/qeth: don't clobber buffer on async TX
 completion
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.ibm.com>

commit ce28867fd20c23cd769e78b4d619c4755bf71a1c upstream.

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
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/s390/net/qeth_core.h      | 11 +++++++++++
 drivers/s390/net/qeth_core_main.c | 22 ++++++++++++++++------
 2 files changed, 27 insertions(+), 6 deletions(-)

--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -844,6 +844,17 @@ struct qeth_trap_id {
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
 static inline struct qeth_card *CARD_FROM_CDEV(struct ccw_device *cdev)
 {
 	struct qeth_card *card = dev_get_drvdata(&((struct ccwgroup_device *)
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -65,9 +65,6 @@ static void qeth_notify_skbs(struct qeth
 		struct qeth_qdio_out_buffer *buf,
 		enum iucv_tx_notify notification);
 static void qeth_release_skbs(struct qeth_qdio_out_buffer *buf);
-static void qeth_clear_output_buffer(struct qeth_qdio_out_q *queue,
-		struct qeth_qdio_out_buffer *buf,
-		enum qeth_qdio_buffer_states newbufstate);
 static int qeth_init_qdio_out_buf(struct qeth_qdio_out_q *, int);
 
 struct workqueue_struct *qeth_wq;
@@ -451,6 +448,7 @@ static inline void qeth_qdio_handle_aob(
 	struct qaob *aob;
 	struct qeth_qdio_out_buffer *buffer;
 	enum iucv_tx_notify notification;
+	unsigned int i;
 
 	aob = (struct qaob *) phys_to_virt(phys_aob_addr);
 	QETH_CARD_TEXT(card, 5, "haob");
@@ -475,10 +473,18 @@ static inline void qeth_qdio_handle_aob(
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
 
@@ -3635,6 +3641,10 @@ void qeth_qdio_output_handler(struct ccw
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

