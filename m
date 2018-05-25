Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965803AbeEYOig (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:38:36 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39654 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965109AbeEYOia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:38:30 -0400
X-Google-Smtp-Source: ADUXVKKzWM9FnyAXtrmCor3COAQjFzastMdjXXz1/ZMiWGgnEeosLtg+pil1C2Y6OhvRadTc5vAMpA==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 7/8] slimbus: messaging: add slim_prepare_txn() helper function
Date: Fri, 25 May 2018 15:36:17 +0100
Message-Id: <20180525143618.820-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180525143618.820-1-srinivas.kandagatla@linaro.org>
References: <20180525143618.820-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds slim_prepare_txn() to allow controllers to prepare
controller specific transaction. If not each controllers will duplicate
the same code from core.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 84 ++++++++++++++++++++++++++++++---------------
 drivers/slimbus/slimbus.h   |  2 ++
 2 files changed, 58 insertions(+), 28 deletions(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index e3605ed1c459..cfffa1dece61 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -55,6 +55,46 @@ void slim_msg_response(struct slim_controller *ctrl, u8 *reply, u8 tid, u8 len)
 }
 EXPORT_SYMBOL_GPL(slim_msg_response);
 
+/**
+ * slim_prepare_txn() - Prepare a transaction
+ *
+ * @ctrl: Controller handle
+ * @txn: transaction to be prepared
+ * @done: completion for transaction if msg does not have completion
+ * @need_tid: flag to indicate if tid is required for this txn
+ * note, user defined commands would need tid.
+ *
+ * Called by controller to prepare a transaction
+ *
+ * Return: zero on success and error code on failures.
+ */
+int slim_prepare_txn(struct slim_controller *ctrl, struct slim_msg_txn *txn,
+		     struct completion *done, bool need_tid)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	txn->need_tid = need_tid;
+	if (!need_tid)
+		return 0;
+
+	spin_lock_irqsave(&ctrl->txn_lock, flags);
+	ret = idr_alloc(&ctrl->tid_idr, txn, 0, SLIM_MAX_TIDS, GFP_ATOMIC);
+	if (ret < 0)
+		goto err;
+
+	txn->tid = ret;
+	if (!txn->msg->comp)
+		txn->comp = done;
+	else
+		txn->comp = txn->msg->comp;
+
+err:
+	spin_unlock_irqrestore(&ctrl->txn_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(slim_prepare_txn);
+
 /**
  * slim_do_transfer() - Process a SLIMbus-messaging transaction
  *
@@ -70,10 +110,9 @@ EXPORT_SYMBOL_GPL(slim_msg_response);
  */
 int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 {
-	DECLARE_COMPLETION_ONSTACK(done);
-	bool need_tid = false, clk_pause_msg = false;
+	bool clk_pause_msg = false;
 	unsigned long flags;
-	int ret, tid, timeout;
+	int ret, timeout;
 
 	/*
 	 * do not vote for runtime-PM if the transactions are part of clock
@@ -94,28 +133,8 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 		}
 	}
 
-	need_tid = slim_tid_txn(txn->mt, txn->mc);
-
-	if (need_tid) {
-		spin_lock_irqsave(&ctrl->txn_lock, flags);
-		tid = idr_alloc(&ctrl->tid_idr, txn, 0,
-				SLIM_MAX_TIDS, GFP_ATOMIC);
-		txn->tid = tid;
-
-		if (!txn->msg->comp)
-			txn->comp = &done;
-		else
-			txn->comp = txn->comp;
-
-		spin_unlock_irqrestore(&ctrl->txn_lock, flags);
-
-		if (tid < 0)
-			return tid;
-	}
-
 	ret = ctrl->xfer_msg(ctrl, txn);
-
-	if (ret && need_tid && !txn->msg->comp) {
+	if (!ret && txn->need_tid && !txn->msg->comp) {
 		unsigned long ms = txn->rl + HZ;
 
 		timeout = wait_for_completion_timeout(txn->comp,
@@ -123,7 +142,7 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 		if (!timeout) {
 			ret = -ETIMEDOUT;
 			spin_lock_irqsave(&ctrl->txn_lock, flags);
-			idr_remove(&ctrl->tid_idr, tid);
+			idr_remove(&ctrl->tid_idr, txn->tid);
 			spin_unlock_irqrestore(&ctrl->txn_lock, flags);
 		}
 	}
@@ -133,13 +152,14 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 			txn->mt, txn->mc, txn->la, ret);
 
 slim_xfer_err:
-	if (!clk_pause_msg && (!need_tid  || ret == -ETIMEDOUT)) {
+	if (!clk_pause_msg && (!txn->need_tid  || ret == -ETIMEDOUT)) {
 		/*
 		 * remove runtime-pm vote if this was TX only, or
 		 * if there was error during this transaction
 		 */
 		pm_runtime_mark_last_busy(ctrl->dev);
 		pm_runtime_put_autosuspend(ctrl->dev);
+
 	}
 	return ret;
 }
@@ -205,6 +225,8 @@ int slim_xfer_msg(struct slim_device *sbdev, struct slim_val_inf *msg,
 	DEFINE_SLIM_LDEST_TXN(txn_stack, mc, 6, sbdev->laddr, msg);
 	struct slim_msg_txn *txn = &txn_stack;
 	struct slim_controller *ctrl = sbdev->ctrl;
+	DECLARE_COMPLETION_ONSTACK(done);
+	bool need_tid = false;
 	int ret;
 	u16 sl;
 
@@ -232,10 +254,16 @@ int slim_xfer_msg(struct slim_device *sbdev, struct slim_val_inf *msg,
 		break;
 	}
 
-	if (slim_tid_txn(txn->mt, txn->mc))
+	if (slim_tid_txn(txn->mt, txn->mc)) {
 		txn->rl++;
+		need_tid = true;
+	}
 
-	return slim_do_transfer(ctrl, txn);
+	ret = slim_prepare_txn(ctrl, txn, &done, need_tid);
+	if (!ret)
+		return slim_do_transfer(ctrl, txn);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(slim_xfer_msg);
 
diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
index 3ec5a85fba8e..8266e53535cb 100644
--- a/drivers/slimbus/slimbus.h
+++ b/drivers/slimbus/slimbus.h
@@ -242,6 +242,8 @@ int slim_unregister_controller(struct slim_controller *ctrl);
 void slim_msg_response(struct slim_controller *ctrl, u8 *reply, u8 tid, u8 l);
 int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn);
 int slim_ctrl_clk_pause(struct slim_controller *ctrl, bool wakeup, u8 restart);
+int slim_prepare_txn(struct slim_controller *ctrl, struct slim_msg_txn *txn,
+		     struct completion *done, bool need_tid);
 
 static inline bool slim_tid_txn(u8 mt, u8 mc)
 {
-- 
2.16.2
