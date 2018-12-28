Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9476C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6411D218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999294;
	bh=L74ABvKWZd7EIxGYt30fRsSeWbRKwgTjnJh3bMLvedA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iXP86DajGiqRXH99FBnkYF7TP2+euJWBbMtB2DyIaeDUoMu6VBqkMvJZf0eCl6GTm
	 CcQmN477b1P7xqCZIj4TGk7dqpfP9zZVdrFbKYZu5iBG7u4xjIgSIO42c8x+9k4Wr7
	 hz9OoBbp9OwI0J/9hExtKrZyDNtd1IVbunlXyPoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbeL1MOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:14:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:33776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731293AbeL1MOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:14:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A4E32148E;
        Fri, 28 Dec 2018 12:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999289;
        bh=L74ABvKWZd7EIxGYt30fRsSeWbRKwgTjnJh3bMLvedA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ps1hKoUiVbJHj8iTWogmXZ9j9plRvioRlBkia5ePBAyIWAWAtdllkf+wX3qiymj78
         M2Gc/WW/rTqW+Pn0o9vNayxouAN8x9aAB8+KeN+AD7U6f7Zc48F1bOmDOpZGgl8B66
         CtQh602oq+QMVELfShFyIZgJTpJZgyAmt/I1aEXU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ganapathi Bhat <gbhat@marvell.com>,
        Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.19 37/46] Revert "mwifiex: restructure rx_reorder_tbl_lock usage"
Date:   Fri, 28 Dec 2018 12:52:31 +0100
Message-Id: <20181228113127.030447868@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brian Norris <briannorris@chromium.org>

commit 1aa48f088615ebfa5e139951a0d3e7dc2c2af4ec upstream.

This reverts commit 5188d5453bc9380ccd4ae1086138dd485d13aef2, because it
introduced lock recursion:

  BUG: spinlock recursion on CPU#2, kworker/u13:1/395
   lock: 0xffffffc0e28a47f0, .magic: dead4ead, .owner: kworker/u13:1/395, .owner_cpu: 2
  CPU: 2 PID: 395 Comm: kworker/u13:1 Not tainted 4.20.0-rc4+ #2
  Hardware name: Google Kevin (DT)
  Workqueue: MWIFIEX_RX_WORK_QUEUE mwifiex_rx_work_queue [mwifiex]
  Call trace:
   dump_backtrace+0x0/0x140
   show_stack+0x20/0x28
   dump_stack+0x84/0xa4
   spin_bug+0x98/0xa4
   do_raw_spin_lock+0x5c/0xdc
   _raw_spin_lock_irqsave+0x38/0x48
   mwifiex_flush_data+0x2c/0xa4 [mwifiex]
   call_timer_fn+0xcc/0x1c4
   run_timer_softirq+0x264/0x4f0
   __do_softirq+0x1a8/0x35c
   do_softirq+0x54/0x64
   netif_rx_ni+0xe8/0x120
   mwifiex_recv_packet+0xfc/0x10c [mwifiex]
   mwifiex_process_rx_packet+0x1d4/0x238 [mwifiex]
   mwifiex_11n_dispatch_pkt+0x190/0x1ac [mwifiex]
   mwifiex_11n_rx_reorder_pkt+0x28c/0x354 [mwifiex]
   mwifiex_process_sta_rx_packet+0x204/0x26c [mwifiex]
   mwifiex_handle_rx_packet+0x15c/0x16c [mwifiex]
   mwifiex_rx_work_queue+0x104/0x134 [mwifiex]
   worker_thread+0x4cc/0x72c
   kthread+0x134/0x13c
   ret_from_fork+0x10/0x18

This was clearly not tested well at all. I simply performed 'wget' in a
loop and it fell over within a few seconds.

Fixes: 5188d5453bc9 ("mwifiex: restructure rx_reorder_tbl_lock usage")
Cc: <stable@vger.kernel.org>
Cc: Ganapathi Bhat <gbhat@marvell.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/marvell/mwifiex/11n.c           |    5 
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c |   96 +++++++++----------
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c      |    3 
 3 files changed, 51 insertions(+), 53 deletions(-)

--- a/drivers/net/wireless/marvell/mwifiex/11n.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n.c
@@ -696,11 +696,10 @@ void mwifiex_11n_delba(struct mwifiex_pr
 				"Send delba to tid=%d, %pM\n",
 				tid, rx_reor_tbl_ptr->ta);
 			mwifiex_send_delba(priv, tid, rx_reor_tbl_ptr->ta, 0);
-			spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock,
-					       flags);
-			return;
+			goto exit;
 		}
 	}
+exit:
 	spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
 }
 
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -103,8 +103,6 @@ static int mwifiex_11n_dispatch_pkt(stru
  * There could be holes in the buffer, which are skipped by the function.
  * Since the buffer is linear, the function uses rotation to simulate
  * circular buffer.
- *
- * The caller must hold rx_reorder_tbl_lock spinlock.
  */
 static void
 mwifiex_11n_dispatch_pkt_until_start_win(struct mwifiex_private *priv,
@@ -113,21 +111,25 @@ mwifiex_11n_dispatch_pkt_until_start_win
 {
 	int pkt_to_send, i;
 	void *rx_tmp_ptr;
+	unsigned long flags;
 
 	pkt_to_send = (start_win > tbl->start_win) ?
 		      min((start_win - tbl->start_win), tbl->win_size) :
 		      tbl->win_size;
 
 	for (i = 0; i < pkt_to_send; ++i) {
+		spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
 		rx_tmp_ptr = NULL;
 		if (tbl->rx_reorder_ptr[i]) {
 			rx_tmp_ptr = tbl->rx_reorder_ptr[i];
 			tbl->rx_reorder_ptr[i] = NULL;
 		}
+		spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
 		if (rx_tmp_ptr)
 			mwifiex_11n_dispatch_pkt(priv, rx_tmp_ptr);
 	}
 
+	spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
 	/*
 	 * We don't have a circular buffer, hence use rotation to simulate
 	 * circular buffer
@@ -138,6 +140,7 @@ mwifiex_11n_dispatch_pkt_until_start_win
 	}
 
 	tbl->start_win = start_win;
+	spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
 }
 
 /*
@@ -147,8 +150,6 @@ mwifiex_11n_dispatch_pkt_until_start_win
  * The start window is adjusted automatically when a hole is located.
  * Since the buffer is linear, the function uses rotation to simulate
  * circular buffer.
- *
- * The caller must hold rx_reorder_tbl_lock spinlock.
  */
 static void
 mwifiex_11n_scan_and_dispatch(struct mwifiex_private *priv,
@@ -156,15 +157,22 @@ mwifiex_11n_scan_and_dispatch(struct mwi
 {
 	int i, j, xchg;
 	void *rx_tmp_ptr;
+	unsigned long flags;
 
 	for (i = 0; i < tbl->win_size; ++i) {
-		if (!tbl->rx_reorder_ptr[i])
+		spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
+		if (!tbl->rx_reorder_ptr[i]) {
+			spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock,
+					       flags);
 			break;
+		}
 		rx_tmp_ptr = tbl->rx_reorder_ptr[i];
 		tbl->rx_reorder_ptr[i] = NULL;
+		spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
 		mwifiex_11n_dispatch_pkt(priv, rx_tmp_ptr);
 	}
 
+	spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
 	/*
 	 * We don't have a circular buffer, hence use rotation to simulate
 	 * circular buffer
@@ -177,6 +185,7 @@ mwifiex_11n_scan_and_dispatch(struct mwi
 		}
 	}
 	tbl->start_win = (tbl->start_win + i) & (MAX_TID_VALUE - 1);
+	spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
 }
 
 /*
@@ -184,8 +193,6 @@ mwifiex_11n_scan_and_dispatch(struct mwi
  *
  * The function stops the associated timer and dispatches all the
  * pending packets in the Rx reorder table before deletion.
- *
- * The caller must hold rx_reorder_tbl_lock spinlock.
  */
 static void
 mwifiex_del_rx_reorder_entry(struct mwifiex_private *priv,
@@ -211,7 +218,11 @@ mwifiex_del_rx_reorder_entry(struct mwif
 
 	del_timer_sync(&tbl->timer_context.timer);
 	tbl->timer_context.timer_is_set = false;
+
+	spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
 	list_del(&tbl->list);
+	spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
+
 	kfree(tbl->rx_reorder_ptr);
 	kfree(tbl);
 
@@ -224,17 +235,22 @@ mwifiex_del_rx_reorder_entry(struct mwif
 /*
  * This function returns the pointer to an entry in Rx reordering
  * table which matches the given TA/TID pair.
- *
- * The caller must hold rx_reorder_tbl_lock spinlock.
  */
 struct mwifiex_rx_reorder_tbl *
 mwifiex_11n_get_rx_reorder_tbl(struct mwifiex_private *priv, int tid, u8 *ta)
 {
 	struct mwifiex_rx_reorder_tbl *tbl;
+	unsigned long flags;
 
-	list_for_each_entry(tbl, &priv->rx_reorder_tbl_ptr, list)
-		if (!memcmp(tbl->ta, ta, ETH_ALEN) && tbl->tid == tid)
+	spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
+	list_for_each_entry(tbl, &priv->rx_reorder_tbl_ptr, list) {
+		if (!memcmp(tbl->ta, ta, ETH_ALEN) && tbl->tid == tid) {
+			spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock,
+					       flags);
 			return tbl;
+		}
+	}
+	spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
 
 	return NULL;
 }
@@ -251,9 +267,14 @@ void mwifiex_11n_del_rx_reorder_tbl_by_t
 		return;
 
 	spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
-	list_for_each_entry_safe(tbl, tmp, &priv->rx_reorder_tbl_ptr, list)
-		if (!memcmp(tbl->ta, ta, ETH_ALEN))
+	list_for_each_entry_safe(tbl, tmp, &priv->rx_reorder_tbl_ptr, list) {
+		if (!memcmp(tbl->ta, ta, ETH_ALEN)) {
+			spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock,
+					       flags);
 			mwifiex_del_rx_reorder_entry(priv, tbl);
+			spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
+		}
+	}
 	spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
 
 	return;
@@ -262,18 +283,24 @@ void mwifiex_11n_del_rx_reorder_tbl_by_t
 /*
  * This function finds the last sequence number used in the packets
  * buffered in Rx reordering table.
- *
- * The caller must hold rx_reorder_tbl_lock spinlock.
  */
 static int
 mwifiex_11n_find_last_seq_num(struct reorder_tmr_cnxt *ctx)
 {
 	struct mwifiex_rx_reorder_tbl *rx_reorder_tbl_ptr = ctx->ptr;
+	struct mwifiex_private *priv = ctx->priv;
+	unsigned long flags;
 	int i;
 
-	for (i = rx_reorder_tbl_ptr->win_size - 1; i >= 0; --i)
-		if (rx_reorder_tbl_ptr->rx_reorder_ptr[i])
+	spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
+	for (i = rx_reorder_tbl_ptr->win_size - 1; i >= 0; --i) {
+		if (rx_reorder_tbl_ptr->rx_reorder_ptr[i]) {
+			spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock,
+					       flags);
 			return i;
+		}
+	}
+	spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
 
 	return -1;
 }
@@ -291,22 +318,17 @@ mwifiex_flush_data(struct timer_list *t)
 	struct reorder_tmr_cnxt *ctx =
 		from_timer(ctx, t, timer);
 	int start_win, seq_num;
-	unsigned long flags;
 
 	ctx->timer_is_set = false;
-	spin_lock_irqsave(&ctx->priv->rx_reorder_tbl_lock, flags);
 	seq_num = mwifiex_11n_find_last_seq_num(ctx);
 
-	if (seq_num < 0) {
-		spin_unlock_irqrestore(&ctx->priv->rx_reorder_tbl_lock, flags);
+	if (seq_num < 0)
 		return;
-	}
 
 	mwifiex_dbg(ctx->priv->adapter, INFO, "info: flush data %d\n", seq_num);
 	start_win = (ctx->ptr->start_win + seq_num + 1) & (MAX_TID_VALUE - 1);
 	mwifiex_11n_dispatch_pkt_until_start_win(ctx->priv, ctx->ptr,
 						 start_win);
-	spin_unlock_irqrestore(&ctx->priv->rx_reorder_tbl_lock, flags);
 }
 
 /*
@@ -333,14 +355,11 @@ mwifiex_11n_create_rx_reorder_tbl(struct
 	 * If we get a TID, ta pair which is already present dispatch all the
 	 * the packets and move the window size until the ssn
 	 */
-	spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
 	tbl = mwifiex_11n_get_rx_reorder_tbl(priv, tid, ta);
 	if (tbl) {
 		mwifiex_11n_dispatch_pkt_until_start_win(priv, tbl, seq_num);
-		spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
 		return;
 	}
-	spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
 	/* if !tbl then create one */
 	new_node = kzalloc(sizeof(struct mwifiex_rx_reorder_tbl), GFP_KERNEL);
 	if (!new_node)
@@ -551,20 +570,16 @@ int mwifiex_11n_rx_reorder_pkt(struct mw
 	int prev_start_win, start_win, end_win, win_size;
 	u16 pkt_index;
 	bool init_window_shift = false;
-	unsigned long flags;
 	int ret = 0;
 
-	spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
 	tbl = mwifiex_11n_get_rx_reorder_tbl(priv, tid, ta);
 	if (!tbl) {
-		spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
 		if (pkt_type != PKT_TYPE_BAR)
 			mwifiex_11n_dispatch_pkt(priv, payload);
 		return ret;
 	}
 
 	if ((pkt_type == PKT_TYPE_AMSDU) && !tbl->amsdu) {
-		spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
 		mwifiex_11n_dispatch_pkt(priv, payload);
 		return ret;
 	}
@@ -651,8 +666,6 @@ done:
 	if (!tbl->timer_context.timer_is_set ||
 	    prev_start_win != tbl->start_win)
 		mwifiex_11n_rxreorder_timer_restart(tbl);
-
-	spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
 	return ret;
 }
 
@@ -681,18 +694,14 @@ mwifiex_del_ba_tbl(struct mwifiex_privat
 		    peer_mac, tid, initiator);
 
 	if (cleanup_rx_reorder_tbl) {
-		spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
 		tbl = mwifiex_11n_get_rx_reorder_tbl(priv, tid,
 								 peer_mac);
 		if (!tbl) {
-			spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock,
-					       flags);
 			mwifiex_dbg(priv->adapter, EVENT,
 				    "event: TID, TA not found in table\n");
 			return;
 		}
 		mwifiex_del_rx_reorder_entry(priv, tbl);
-		spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
 	} else {
 		ptx_tbl = mwifiex_get_ba_tbl(priv, tid, peer_mac);
 		if (!ptx_tbl) {
@@ -726,7 +735,6 @@ int mwifiex_ret_11n_addba_resp(struct mw
 	int tid, win_size;
 	struct mwifiex_rx_reorder_tbl *tbl;
 	uint16_t block_ack_param_set;
-	unsigned long flags;
 
 	block_ack_param_set = le16_to_cpu(add_ba_rsp->block_ack_param_set);
 
@@ -740,20 +748,17 @@ int mwifiex_ret_11n_addba_resp(struct mw
 		mwifiex_dbg(priv->adapter, ERROR, "ADDBA RSP: failed %pM tid=%d)\n",
 			    add_ba_rsp->peer_mac_addr, tid);
 
-		spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
 		tbl = mwifiex_11n_get_rx_reorder_tbl(priv, tid,
 						     add_ba_rsp->peer_mac_addr);
 		if (tbl)
 			mwifiex_del_rx_reorder_entry(priv, tbl);
 
-		spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
 		return 0;
 	}
 
 	win_size = (block_ack_param_set & IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK)
 		    >> BLOCKACKPARAM_WINSIZE_POS;
 
-	spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
 	tbl = mwifiex_11n_get_rx_reorder_tbl(priv, tid,
 					     add_ba_rsp->peer_mac_addr);
 	if (tbl) {
@@ -764,7 +769,6 @@ int mwifiex_ret_11n_addba_resp(struct mw
 		else
 			tbl->amsdu = false;
 	}
-	spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
 
 	mwifiex_dbg(priv->adapter, CMD,
 		    "cmd: ADDBA RSP: %pM tid=%d ssn=%d win_size=%d\n",
@@ -804,8 +808,11 @@ void mwifiex_11n_cleanup_reorder_tbl(str
 
 	spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
 	list_for_each_entry_safe(del_tbl_ptr, tmp_node,
-				 &priv->rx_reorder_tbl_ptr, list)
+				 &priv->rx_reorder_tbl_ptr, list) {
+		spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
 		mwifiex_del_rx_reorder_entry(priv, del_tbl_ptr);
+		spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
+	}
 	INIT_LIST_HEAD(&priv->rx_reorder_tbl_ptr);
 	spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
 
@@ -929,7 +936,6 @@ void mwifiex_11n_rxba_sync_event(struct
 	int tlv_buf_left = len;
 	int ret;
 	u8 *tmp;
-	unsigned long flags;
 
 	mwifiex_dbg_dump(priv->adapter, EVT_D, "RXBA_SYNC event:",
 			 event_buf, len);
@@ -949,18 +955,14 @@ void mwifiex_11n_rxba_sync_event(struct
 			    tlv_rxba->mac, tlv_rxba->tid, tlv_seq_num,
 			    tlv_bitmap_len);
 
-		spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
 		rx_reor_tbl_ptr =
 			mwifiex_11n_get_rx_reorder_tbl(priv, tlv_rxba->tid,
 						       tlv_rxba->mac);
 		if (!rx_reor_tbl_ptr) {
-			spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock,
-					       flags);
 			mwifiex_dbg(priv->adapter, ERROR,
 				    "Can not find rx_reorder_tbl!");
 			return;
 		}
-		spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
 
 		for (i = 0; i < tlv_bitmap_len; i++) {
 			for (j = 0 ; j < 8; j++) {
--- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
@@ -421,15 +421,12 @@ int mwifiex_process_uap_rx_packet(struct
 		spin_unlock_irqrestore(&priv->sta_list_spinlock, flags);
 	}
 
-	spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
 	if (!priv->ap_11n_enabled ||
 	    (!mwifiex_11n_get_rx_reorder_tbl(priv, uap_rx_pd->priority, ta) &&
 	    (le16_to_cpu(uap_rx_pd->rx_pkt_type) != PKT_TYPE_AMSDU))) {
 		ret = mwifiex_handle_uap_rx_forward(priv, skb);
-		spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
 		return ret;
 	}
-	spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
 
 	/* Reorder and send to kernel */
 	pkt_type = (u8)le16_to_cpu(uap_rx_pd->rx_pkt_type);


