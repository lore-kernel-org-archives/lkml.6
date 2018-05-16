Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526470754; cv=none;
        d=google.com; s=arc-20160816;
        b=R0khg7iepFA7gepiZUPgyEcFN+3ZEB169S5AYP2I7ZLZA/xuMh4shUOz19xIiBSTUg
         wPLEdBffcGTyrmJYHi00iICyrTFcCTAz90dRxXfwSaC8qR+8dzpI1Rg6X/8782e4yZ4U
         JwZGCrAjvYr6gMry7VYiZgT6yR0WKt7/07/Tlqp61XIunbR5A7KMOOxTvGPeEO1r02Xy
         JI+sfLht/1nB++G1FEB7rc36BQ8oMpWjTi3LZtv+cBwfgbb+Lyay0jHhjcEx/AOr12Et
         LPTyZzyX76N444l+XToDGRJBnTryzcpe8jhGNv2JssA4SvKH1vKUqiYOkAUjrkCayHFA
         ZGnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=h+yKZBsymFyOLdBuFEX4Ykm1mvdtJ0VJ4kvjsob+kQI=;
        b=yoYuInQ6b3VBnJ3sU8fVLUD+G2olGuWWBbG7ws6SGB10Mq1ljNIsa0rtpeKyTpEvs3
         cyWdYEcdBkywWabJKcCMic3x2febZhbf+oL+Z6fNYbiE+FDJ5wsDyzEUdse4ZtUSfqto
         3NYtbkS7P4zn6Wd37b2Spc+ntFF2dCW/wGTGZGDVNUlTpMCdPJ8ACz7m7ZkHLztVwa4P
         CM2PiEg652ieksQkTlYCPI4S6vpNyap251eXO/DRCBK1LXcPja/mBbLBnLc37Cmonf+E
         NVBBo3ARCp5aAk0Jzb4tfIe9T2j1X4alXdmAZtjbWJDvgzEfZlybq2g/XHN2qOOwePgL
         3k1g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Mxuqsvkb;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Mxuqsvkb;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpJCrfTC6quQStMFvhb1zcClL5tOHCHaKifsWKF8KbXDqxPgZcX7nHI8MpU3M9tiMbHHCKZ+g==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6/7] slimbus: messaging: add slim_prepare_txn() helper function
Date: Wed, 16 May 2018 12:36:41 +0100
Message-Id: <20180516113642.28136-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180516113642.28136-1-srinivas.kandagatla@linaro.org>
References: <20180516113642.28136-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600620597707971162?=
X-GMAIL-MSGID: =?utf-8?q?1600620597707971162?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
index ffb46f915334..0783fb11c702 100644
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
index c0450f469e07..67e774b2b2dd 100644
--- a/drivers/slimbus/slimbus.h
+++ b/drivers/slimbus/slimbus.h
@@ -241,6 +241,8 @@ int slim_unregister_controller(struct slim_controller *ctrl);
 void slim_msg_response(struct slim_controller *ctrl, u8 *reply, u8 tid, u8 l);
 int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn);
 int slim_ctrl_clk_pause(struct slim_controller *ctrl, bool wakeup, u8 restart);
+int slim_prepare_txn(struct slim_controller *ctrl, struct slim_msg_txn *txn,
+		     struct completion *done, bool need_tid);
 
 static inline bool slim_tid_txn(u8 mt, u8 mc)
 {
-- 
2.16.2
