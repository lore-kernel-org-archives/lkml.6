Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470DDC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB83220661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d3crgxRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB83220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967077AbeFSQOp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:14:45 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50927 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967048AbeFSQNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:13:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id e16-v6so1345407wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/hk81tJs0U8+gliTNmT2DEM7iWq6ptBWABuzVXdd4kw=;
        b=d3crgxRbgUJ3t1ILCZfGHJTpUuUiNfu027+yhgImA6FqQAb51J/KYErKJAULAxnEJX
         P8l8lvQNBFHNo4KWiIige6J64iUD3r0VFYO7wvacO5E/bDs1Qn0XboxbJB3oRlhFPJTz
         MgltP8Ay/yY3pmVnCgT1fs0javbG2IFuqNDJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/hk81tJs0U8+gliTNmT2DEM7iWq6ptBWABuzVXdd4kw=;
        b=CNSqBiZ4LcZi2BWNNS6QgRHS1JeZsjv/RHk9rB34Ld8+bRdiRElcJFP577zTLj7R/x
         /mEXkcGh5bx6FcB+zGBRmDzxlS7NwSkhy//wvC/GRYmZXhXuCassYwm6qCzj0ot8/DCl
         pizWZJ6hBvy7A07cWf19RT9Xi9X3YqT0EdMrJ/P2XGA/mIcgSPWEK7NTcvxeGXcdpmkS
         Tx7wvdB+rCLSOUx9kaphxJlTvRTWLn75jUUFLAwZHOiHdHqzpmFNfYlUv3cv4eSWf9Zy
         esC8ggxQt68OAW20PvH0jxECqckAIHsfEQRrhLg3UtztiLoaRfxFOKHpk5PUKt4WOMNR
         U9PQ==
X-Gm-Message-State: APt69E36ilY59zhRDCUTMOJKWfb+0SMlAGe2SQDfnj82bIexd2ulzmSl
        kr6g5NtRpDD45aYQ2I8Z36bcww==
X-Google-Smtp-Source: ADUXVKJ1EFPDj1Dxepll+6FQ2eus0I8HI9buft+8L487vDzLj7d+cNmqzxkAmHLv/vHIe8TK+wUPrA==
X-Received: by 2002:a1c:a010:: with SMTP id j16-v6mr11803065wme.61.1529424789545;
        Tue, 19 Jun 2018 09:13:09 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id r5-v6sm47248wrp.59.2018.06.19.09.13.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jun 2018 09:13:09 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     robh+dt@kernel.org, kramasub@codeaurora.org, sdharia@quicinc.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 3/5] slimbus: messaging: add slim_alloc/free_txn_tid()
Date:   Tue, 19 Jun 2018 17:12:59 +0100
Message-Id: <20180619161301.4556-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180619161301.4556-1-srinivas.kandagatla@linaro.org>
References: <20180619161301.4556-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds slim_alloc_txn_tid() and slim_free_txn_tid() api
to allow controllers like ngd to allocate tids for user specific
commands. This also cleans up the existing code to use single place
for tid allocations and free.

This patch also make the tid allocation cyclic one, its very useful
to track the transactions back during debug.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 74 +++++++++++++++++++++++++++++++--------------
 drivers/slimbus/slimbus.h   |  2 ++
 2 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index e3605ed1c459..d5879142dbef 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -29,22 +29,19 @@ void slim_msg_response(struct slim_controller *ctrl, u8 *reply, u8 tid, u8 len)
 
 	spin_lock_irqsave(&ctrl->txn_lock, flags);
 	txn = idr_find(&ctrl->tid_idr, tid);
-	if (txn == NULL) {
-		spin_unlock_irqrestore(&ctrl->txn_lock, flags);
+	spin_unlock_irqrestore(&ctrl->txn_lock, flags);
+
+	if (txn == NULL)
 		return;
-	}
 
 	msg = txn->msg;
 	if (msg == NULL || msg->rbuf == NULL) {
 		dev_err(ctrl->dev, "Got response to invalid TID:%d, len:%d\n",
 				tid, len);
-		spin_unlock_irqrestore(&ctrl->txn_lock, flags);
 		return;
 	}
 
-	idr_remove(&ctrl->tid_idr, tid);
-	spin_unlock_irqrestore(&ctrl->txn_lock, flags);
-
+	slim_free_txn_tid(ctrl, txn);
 	memcpy(msg->rbuf, reply, len);
 	if (txn->comp)
 		complete(txn->comp);
@@ -55,6 +52,48 @@ void slim_msg_response(struct slim_controller *ctrl, u8 *reply, u8 tid, u8 len)
 }
 EXPORT_SYMBOL_GPL(slim_msg_response);
 
+/**
+ * slim_alloc_txn_tid() - Allocate a tid to txn
+ *
+ * @ctrl: Controller handle
+ * @txn: transaction to be allocated with tid.
+ *
+ * Return: zero on success with valid txn->tid and error code on failures.
+ */
+int slim_alloc_txn_tid(struct slim_controller *ctrl, struct slim_msg_txn *txn)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&ctrl->txn_lock, flags);
+	ret = idr_alloc_cyclic(&ctrl->tid_idr, txn, 0,
+				SLIM_MAX_TIDS, GFP_ATOMIC);
+	if (ret < 0) {
+		spin_unlock_irqrestore(&ctrl->txn_lock, flags);
+		return ret;
+	}
+	txn->tid = ret;
+	spin_unlock_irqrestore(&ctrl->txn_lock, flags);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(slim_alloc_txn_tid);
+
+/**
+ * slim_free_txn_tid() - Freee tid of txn
+ *
+ * @ctrl: Controller handle
+ * @txn: transaction whose tid should be freed
+ */
+void slim_free_txn_tid(struct slim_controller *ctrl, struct slim_msg_txn *txn)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctrl->txn_lock, flags);
+	idr_remove(&ctrl->tid_idr, txn->tid);
+	spin_unlock_irqrestore(&ctrl->txn_lock, flags);
+}
+EXPORT_SYMBOL_GPL(slim_free_txn_tid);
+
 /**
  * slim_do_transfer() - Process a SLIMbus-messaging transaction
  *
@@ -72,8 +111,7 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
 	bool need_tid = false, clk_pause_msg = false;
-	unsigned long flags;
-	int ret, tid, timeout;
+	int ret, timeout;
 
 	/*
 	 * do not vote for runtime-PM if the transactions are part of clock
@@ -97,34 +135,26 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 	need_tid = slim_tid_txn(txn->mt, txn->mc);
 
 	if (need_tid) {
-		spin_lock_irqsave(&ctrl->txn_lock, flags);
-		tid = idr_alloc(&ctrl->tid_idr, txn, 0,
-				SLIM_MAX_TIDS, GFP_ATOMIC);
-		txn->tid = tid;
+		ret = slim_alloc_txn_tid(ctrl, txn);
+		if (ret)
+			return ret;
 
 		if (!txn->msg->comp)
 			txn->comp = &done;
 		else
 			txn->comp = txn->comp;
-
-		spin_unlock_irqrestore(&ctrl->txn_lock, flags);
-
-		if (tid < 0)
-			return tid;
 	}
 
 	ret = ctrl->xfer_msg(ctrl, txn);
 
-	if (ret && need_tid && !txn->msg->comp) {
+	if (!ret && need_tid && !txn->msg->comp) {
 		unsigned long ms = txn->rl + HZ;
 
 		timeout = wait_for_completion_timeout(txn->comp,
 						      msecs_to_jiffies(ms));
 		if (!timeout) {
 			ret = -ETIMEDOUT;
-			spin_lock_irqsave(&ctrl->txn_lock, flags);
-			idr_remove(&ctrl->tid_idr, tid);
-			spin_unlock_irqrestore(&ctrl->txn_lock, flags);
+			slim_free_txn_tid(ctrl, txn);
 		}
 	}
 
diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
index 79f8e05d92dd..2ba6545fa716 100644
--- a/drivers/slimbus/slimbus.h
+++ b/drivers/slimbus/slimbus.h
@@ -240,6 +240,8 @@ int slim_unregister_controller(struct slim_controller *ctrl);
 void slim_msg_response(struct slim_controller *ctrl, u8 *reply, u8 tid, u8 l);
 int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn);
 int slim_ctrl_clk_pause(struct slim_controller *ctrl, bool wakeup, u8 restart);
+int slim_alloc_txn_tid(struct slim_controller *ctrl, struct slim_msg_txn *txn);
+void slim_free_txn_tid(struct slim_controller *ctrl, struct slim_msg_txn *txn);
 
 static inline bool slim_tid_txn(u8 mt, u8 mc)
 {
-- 
2.16.2

