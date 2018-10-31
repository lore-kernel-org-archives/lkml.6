Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714F1ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391AF20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSt+NlHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391AF20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbeKAILV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:11:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731520AbeKAILT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:11:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D575220840;
        Wed, 31 Oct 2018 23:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027466;
        bh=B+E1rGDKNTlp16IBohxz7IMm7juhoT0l8C5AfiFfVSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jSt+NlHA2jaR7win3rohY1RzGRHG4rcYwR9NPkFoayjf/yIdxCDvdSOI1LwxFwIIs
         ot0doSt3+oDmUXhIZs4a7jbj5hHkGKAgrLREAQJd19JcNeP779+R3c/qNcjHBnb8Hf
         KFn7wnKZhi/1slVua/vwnrkAFOtJCjP5BVER/sek=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shaul Triebitz <shaul.triebitz@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 13/48] iwlwifi: pcie: avoid empty free RB queue
Date:   Wed, 31 Oct 2018 19:10:19 -0400
Message-Id: <20181031231054.29333-13-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231054.29333-1-sashal@kernel.org>
References: <20181031231054.29333-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 32 +++++++++++++-------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 996a928142ad..e58a50d31d96 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1030,6 +1030,14 @@ void iwl_pcie_rx_free(struct iwl_trans *trans)
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
@@ -1061,9 +1069,7 @@ static void iwl_pcie_rx_reuse_rbd(struct iwl_trans *trans,
 	if ((rxq->used_count % RX_CLAIM_REQ_ALLOC) == RX_POST_REQ_ALLOC) {
 		/* Move the 2 RBDs to the allocator ownership.
 		 Allocator has another 6 from pool for the request completion*/
-		spin_lock(&rba->lock);
-		list_splice_tail_init(&rxq->rx_used, &rba->rbd_empty);
-		spin_unlock(&rba->lock);
+		iwl_pcie_rx_move_to_allocator(rxq, rba);
 
 		atomic_inc(&rba->req_pending);
 		queue_work(rba->alloc_wq, &rba->rx_alloc);
@@ -1233,10 +1239,18 @@ static void iwl_pcie_rx_handle(struct iwl_trans *trans, int queue)
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
@@ -1279,17 +1293,13 @@ static void iwl_pcie_rx_handle(struct iwl_trans *trans, int queue)
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
-- 
2.17.1

