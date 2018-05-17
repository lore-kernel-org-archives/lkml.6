Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeEQJBI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:01:08 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40413 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbeEQJBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:01:03 -0400
X-Google-Smtp-Source: AB8JxZqCtv0mWH3ErDvBQgE9x1v68WqwLmduUGr5tlgcnMVI9ZrGqM3h/O/cnW+oR9xkTkXDpkiokQ==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        srinivas.kandagatla@linaro.org
Subject: [PATCH v2 6/8] slimbus: messaging: add slim_prepare_txn() helper function
Date: Thu, 17 May 2018 09:58:48 +0100
Message-Id: <20180517085850.14276-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180517085850.14276-1-srinivas.kandagatla@linaro.org>
References: <20180517085850.14276-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds slim_prepare_txn() to allow controllers to prepare
controller specific transaction. If not each controllers will duplicate
the same code from core.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 89 ++++++++++++++++++++++++++++++---------------
 drivers/slimbus/qcom-ctrl.c |  7 +++-
 drivers/slimbus/slimbus.h   |  2 +
 3 files changed, 68 insertions(+), 30 deletions(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 1c57b631031a..fd0788019357 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -55,6 +55,50 @@ void slim_msg_response(struct slim_controller *ctrl, u8 *reply, u8 tid, u8 len)
 }
 EXPORT_SYMBOL_GPL(slim_msg_response);
 
+/**
+ * slim_prepare_txn() - Prepare a transaction
+ *
+ * @ctrl: Controller handle
+ * @txn: transaction to be prepared
+ * @done: completion for transaction
+ * @need_tid: flag to indicate if tid is required for this txn
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
+	spin_lock_irqsave(&ctrl->txn_lock, flags);
+
+	if (need_tid) {
+		ret = idr_alloc(&ctrl->tid_idr, txn, 0, SLIM_MAX_TIDS,
+				GFP_ATOMIC);
+		if (ret < 0) {
+			spin_unlock_irqrestore(&ctrl->txn_lock, flags);
+			return ret;
+		}
+		txn->tid = ret;
+		txn->need_tid = true;
+	} else {
+		txn->need_tid = false;
+	}
+
+	if (!txn->msg->comp)
+		txn->comp = done;
+	else
+		txn->comp = txn->msg->comp;
+
+	spin_unlock_irqrestore(&ctrl->txn_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(slim_prepare_txn);
+
 /**
  * slim_do_transfer() - Process a SLIMbus-messaging transaction
  *
@@ -70,10 +114,9 @@ EXPORT_SYMBOL_GPL(slim_msg_response);
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
@@ -94,28 +137,8 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
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
@@ -123,7 +146,7 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 		if (!timeout) {
 			ret = -ETIMEDOUT;
 			spin_lock_irqsave(&ctrl->txn_lock, flags);
-			idr_remove(&ctrl->tid_idr, tid);
+			idr_remove(&ctrl->tid_idr, txn->tid);
 			spin_unlock_irqrestore(&ctrl->txn_lock, flags);
 		}
 	}
@@ -133,13 +156,12 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 			txn->mt, txn->mc, txn->la, ret);
 
 slim_xfer_err:
-	if (!clk_pause_msg && (!need_tid  || ret == -ETIMEDOUT)) {
+	if (!clk_pause_msg && (!txn->need_tid  || ret == -ETIMEDOUT)) {
 		/*
 		 * remove runtime-pm vote if this was TX only, or
 		 * if there was error during this transaction
 		 */
 		pm_runtime_mark_last_busy(ctrl->dev);
-		pm_runtime_put_autosuspend(ctrl->dev);
 	}
 	return ret;
 }
@@ -169,6 +191,7 @@ static int slim_val_inf_sanity(struct slim_controller *ctrl,
 		if (msg->rbuf != NULL && msg->wbuf != NULL)
 			return 0;
 		break;
+
 	}
 reterr:
 	if (msg)
@@ -205,6 +228,8 @@ int slim_xfer_msg(struct slim_device *sbdev, struct slim_val_inf *msg,
 	DEFINE_SLIM_LDEST_TXN(txn_stack, mc, 6, sbdev->laddr, msg);
 	struct slim_msg_txn *txn = &txn_stack;
 	struct slim_controller *ctrl = sbdev->ctrl;
+	DECLARE_COMPLETION_ONSTACK(done);
+	bool need_tid = false;
 	int ret;
 	u16 sl;
 
@@ -232,10 +257,16 @@ int slim_xfer_msg(struct slim_device *sbdev, struct slim_val_inf *msg,
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
 
diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index bb36a8fbc9b1..412a60a314b1 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -397,6 +397,7 @@ static int qcom_set_laddr(struct slim_controller *sctrl,
 		u8 instance;
 		u8 laddr;
 	} __packed p;
+	DECLARE_COMPLETION_ONSTACK(done);
 	struct slim_val_inf msg = {0};
 	DEFINE_SLIM_EDEST_TXN(txn, SLIM_MSG_MC_ASSIGN_LOGICAL_ADDRESS,
 			      10, laddr, &msg);
@@ -410,7 +411,11 @@ static int qcom_set_laddr(struct slim_controller *sctrl,
 
 	msg.wbuf = (void *)&p;
 	msg.num_bytes = 7;
-	ret = slim_do_transfer(&ctrl->ctrl, &txn);
+
+	ret = slim_prepare_txn(&ctrl->ctrl, &txn, &done,
+			       slim_tid_txn(txn.mt, txn.mc));
+	if (!ret)
+		ret = slim_do_transfer(&ctrl->ctrl, &txn);
 
 	if (ret)
 		dev_err(ctrl->dev, "set LA:0x%x failed:ret:%d\n",
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
