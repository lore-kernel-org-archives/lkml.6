Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6A0C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31D62084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n60ltEir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31D62084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388680AbeKLJYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:24:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388417AbeKLIUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:11 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2588721707;
        Sun, 11 Nov 2018 22:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975414;
        bh=BMLa2PooLHBl+wU0Nn80e/xOWHzmcI0OHLORUbRQxqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n60ltEirknJ2X01ltkt68FxzoiMKDXml4VUPfTJtv+yW+OpzuT3geboPhz8zQ/HAm
         JnHTR1bfMOFqgnTNPL06dIkN/PktIlq6xcWAVqKhPpSdr5w1y/JKG2j8Dr8qDyUbPy
         XINKgfD9kuCsggncVb9ZPrizrDK09JD9obRkI5qI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shaul Triebitz <shaul.triebitz@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 086/350] iwlwifi: pcie: avoid empty free RB queue
Date:   Sun, 11 Nov 2018 14:19:10 -0800
Message-Id: <20181111221710.715055534@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

From: Shaul Triebitz <shaul.triebitz@intel.com>

[ Upstream commit 868a1e863f95183f00809363fefba6d4f5bcd116 ]

If all free RB queues are empty, the driver will never restock the
free RB queue.  That's because the restocking happens in the Rx flow,
and if the free queue is empty there will be no Rx.

Although there's a background worker (a.k.a. allocator) allocating
memory for RBs so that the Rx handler can restock them, the worker may
run only after the free queue has become empty (and then it is too
late for restocking as explained above).

There is a solution for that called 'emergency': If the number of used
RB's reaches half the amount of all RB's, the Rx handler will not wait
for the allocator but immediately allocate memory for the used RB's
and restock the free queue.

But, since the used RB's is per queue, it may happen that the used
RB's are spread between the queues such that the emergency check will
fail for each of the queues
(and still run out of RBs, causing the above symptom).

To fix it, move to emergency mode if the sum of *all* used RBs (for
all Rx queues) reaches half the amount of all RB's

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c |   32 +++++++++++++++++----------
 1 file changed, 21 insertions(+), 11 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1050,6 +1050,14 @@ void iwl_pcie_rx_free(struct iwl_trans *
 	kfree(trans_pcie->rxq);
 }
 
+static void iwl_pcie_rx_move_to_allocator(struct iwl_rxq *rxq,
+					  struct iwl_rb_allocator *rba)
+{
+	spin_lock(&rba->lock);
+	list_splice_tail_init(&rxq->rx_used, &rba->rbd_empty);
+	spin_unlock(&rba->lock);
+}
+
 /*
  * iwl_pcie_rx_reuse_rbd - Recycle used RBDs
  *
@@ -1081,9 +1089,7 @@ static void iwl_pcie_rx_reuse_rbd(struct
 	if ((rxq->used_count % RX_CLAIM_REQ_ALLOC) == RX_POST_REQ_ALLOC) {
 		/* Move the 2 RBDs to the allocator ownership.
 		 Allocator has another 6 from pool for the request completion*/
-		spin_lock(&rba->lock);
-		list_splice_tail_init(&rxq->rx_used, &rba->rbd_empty);
-		spin_unlock(&rba->lock);
+		iwl_pcie_rx_move_to_allocator(rxq, rba);
 
 		atomic_inc(&rba->req_pending);
 		queue_work(rba->alloc_wq, &rba->rx_alloc);
@@ -1261,10 +1267,18 @@ restart:
 		IWL_DEBUG_RX(trans, "Q %d: HW = SW = %d\n", rxq->id, r);
 
 	while (i != r) {
+		struct iwl_rb_allocator *rba = &trans_pcie->rba;
 		struct iwl_rx_mem_buffer *rxb;
-
-		if (unlikely(rxq->used_count == rxq->queue_size / 2))
+		/* number of RBDs still waiting for page allocation */
+		u32 rb_pending_alloc =
+			atomic_read(&trans_pcie->rba.req_pending) *
+			RX_CLAIM_REQ_ALLOC;
+
+		if (unlikely(rb_pending_alloc >= rxq->queue_size / 2 &&
+			     !emergency)) {
+			iwl_pcie_rx_move_to_allocator(rxq, rba);
 			emergency = true;
+		}
 
 		if (trans->cfg->mq_rx_supported) {
 			/*
@@ -1307,17 +1321,13 @@ restart:
 			iwl_pcie_rx_allocator_get(trans, rxq);
 
 		if (rxq->used_count % RX_CLAIM_REQ_ALLOC == 0 && !emergency) {
-			struct iwl_rb_allocator *rba = &trans_pcie->rba;
-
 			/* Add the remaining empty RBDs for allocator use */
-			spin_lock(&rba->lock);
-			list_splice_tail_init(&rxq->rx_used, &rba->rbd_empty);
-			spin_unlock(&rba->lock);
+			iwl_pcie_rx_move_to_allocator(rxq, rba);
 		} else if (emergency) {
 			count++;
 			if (count == 8) {
 				count = 0;
-				if (rxq->used_count < rxq->queue_size / 3)
+				if (rb_pending_alloc < rxq->queue_size / 3)
 					emergency = false;
 
 				rxq->read = i;


