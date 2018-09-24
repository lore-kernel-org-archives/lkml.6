Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AC2ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCA121486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCA121486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387474AbeIXS37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:29:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57386 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730233AbeIXS36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:29:58 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 48D721018;
        Mon, 24 Sep 2018 12:28:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Golan Ben Ami <golan.ben.ami@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 026/235] iwlwifi: cancel the injective function between hw pointers to tfd entry index
Date:   Mon, 24 Sep 2018 13:50:12 +0200
Message-Id: <20180924113107.304828110@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
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

From: Golan Ben Ami <golan.ben.ami@intel.com>

[ Upstream commit f5955a6cc3862a02d46f50b723c3172d24d749a5 ]

Nowadays, the tfd queue max size is 2^8, and the reserved size in the
command header sequence field for the tfd entry index is 8 bits,
allowing an injective function from the hw pointers to the tfd entry index
in the sequence field.

In 22560 devices the tfd queue max size is 2^16, meaning that
the hw pointers are 16 bit long (allowing to point to each entry
in the tfd queue). However, the reserved space in the sequence field for
the tfd entry doesn't change, and we are limited to 8 bit.
This requires cancelling the injective function from hw pointer to
tfd entry in the sequence number.

Use iwl_pcie_get_cmd_index to wrap the hw pointer's to the n_window
size, which is maximum 256 in tx queues, and so, keep the injective
function between the window wrapped hw pointers to tfd entry index in
the sequence.

Signed-off-by: Golan Ben Ami <golan.ben.ami@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |   12 ++++++++----
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |   11 ++++++++---
 2 files changed, 16 insertions(+), 7 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -660,7 +660,7 @@ static inline void iwl_enable_fw_load_in
 	}
 }
 
-static inline u8 iwl_pcie_get_cmd_index(struct iwl_txq *q, u32 index)
+static inline u8 iwl_pcie_get_cmd_index(const struct iwl_txq *q, u32 index)
 {
 	return index & (q->n_window - 1);
 }
@@ -730,9 +730,13 @@ static inline void iwl_stop_queue(struct
 
 static inline bool iwl_queue_used(const struct iwl_txq *q, int i)
 {
-	return q->write_ptr >= q->read_ptr ?
-		(i >= q->read_ptr && i < q->write_ptr) :
-		!(i < q->read_ptr && i >= q->write_ptr);
+	int index = iwl_pcie_get_cmd_index(q, i);
+	int r = iwl_pcie_get_cmd_index(q, q->read_ptr);
+	int w = iwl_pcie_get_cmd_index(q, q->write_ptr);
+
+	return w >= r ?
+		(index >= r && index < w) :
+		!(index < r && index >= w);
 }
 
 static inline bool iwl_is_rfkill_set(struct iwl_trans *trans)
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1225,9 +1225,13 @@ static void iwl_pcie_cmdq_reclaim(struct
 	struct iwl_txq *txq = trans_pcie->txq[txq_id];
 	unsigned long flags;
 	int nfreed = 0;
+	u16 r;
 
 	lockdep_assert_held(&txq->lock);
 
+	idx = iwl_pcie_get_cmd_index(txq, idx);
+	r = iwl_pcie_get_cmd_index(txq, txq->read_ptr);
+
 	if ((idx >= TFD_QUEUE_SIZE_MAX) || (!iwl_queue_used(txq, idx))) {
 		IWL_ERR(trans,
 			"%s: Read index for DMA queue txq id (%d), index %d is out of range [0-%d] %d %d.\n",
@@ -1236,12 +1240,13 @@ static void iwl_pcie_cmdq_reclaim(struct
 		return;
 	}
 
-	for (idx = iwl_queue_inc_wrap(idx); txq->read_ptr != idx;
-	     txq->read_ptr = iwl_queue_inc_wrap(txq->read_ptr)) {
+	for (idx = iwl_queue_inc_wrap(idx); r != idx;
+	     r = iwl_queue_inc_wrap(r)) {
+		txq->read_ptr = iwl_queue_inc_wrap(txq->read_ptr);
 
 		if (nfreed++ > 0) {
 			IWL_ERR(trans, "HCMD skipped: index (%d) %d %d\n",
-				idx, txq->write_ptr, txq->read_ptr);
+				idx, txq->write_ptr, r);
 			iwl_force_nmi(trans);
 		}
 	}


