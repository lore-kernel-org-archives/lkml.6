Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98EFC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A26020897
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bcCP75tI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Y8DIM4+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A26020897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389377AbeG0L00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:26:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45576 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730717AbeG0L0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:26:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BCF2860B73; Fri, 27 Jul 2018 10:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532685914;
        bh=Ysj2qPcfLbjvsDV1B+2zCcWTDLL3kMdQk9mUedzAAok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bcCP75tIJF0n7tCAXQ+4HpEHtEh9VGuf9KSgNcT3WYrbOyuM1CpxFWxl9u7W8vunY
         n9fZpuXTSTtKhrWU+A3fM8kFMiCKFplcsWHrbdOUtp1n/ry+jIGWA7aXp3y3L3d6ob
         CpB/HlmmGisAjwwMD4cg5y9Zwr8UJh4/PKjdD99k=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0019860B7E;
        Fri, 27 Jul 2018 10:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532685913;
        bh=Ysj2qPcfLbjvsDV1B+2zCcWTDLL3kMdQk9mUedzAAok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y8DIM4+rTZp3JI9bXUo79AeXpbsqBJMhzqIVpEPk5gGkDBZrhZqvKMQTpbOM1cP7U
         93OjUpOQw6OfdxT3aHti6UTgQ/W7QqQkI3FgCoJozQ34/x8a5r3xWXzCfcJDLDcvqx
         LavBt+Xm/8YL27yb8X0SC7D9+phC1C7CPn7TzrcY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0019860B7E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   Raju P L S S S N <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v2 4/6] drivers: qcom: rpmh-rsc: clear active mode configuration for waketcs
Date:   Fri, 27 Jul 2018 15:34:47 +0530
Message-Id: <1532685889-31345-5-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532685889-31345-1-git-send-email-rplsssn@codeaurora.org>
References: <1532685889-31345-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>

For RSCs that have sleep & wake TCS but no dedicated active TCS, wake
TCS can be re-purposed to send active requests. Once the active requests
are sent and response is received, the active mode configuration needs
to be cleared so that controller can use wake TCS for sending wake
requests in 'solver' state while executing low power modes.

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 77 +++++++++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 23 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 42d0041..19616c9 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -199,6 +199,42 @@ static const struct tcs_request *get_req_from_tcs(struct rsc_drv *drv,
 	return NULL;
 }
 
+static void __tcs_trigger(struct rsc_drv *drv, int tcs_id, bool trigger)
+{
+	u32 enable;
+
+	/*
+	 * HW req: Clear the DRV_CONTROL and enable TCS again
+	 * While clearing ensure that the AMC mode trigger is cleared
+	 * and then the mode enable is cleared.
+	 */
+	enable = read_tcs_reg(drv, RSC_DRV_CONTROL, tcs_id, 0);
+	enable &= ~TCS_AMC_MODE_TRIGGER;
+	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
+	enable &= ~TCS_AMC_MODE_ENABLE;
+	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
+
+	if (trigger) {
+		/* Enable the AMC mode on the TCS and then trigger the TCS */
+		enable = TCS_AMC_MODE_ENABLE;
+		write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
+		enable |= TCS_AMC_MODE_TRIGGER;
+		write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
+	}
+}
+
+static inline void enable_tcs_irq(struct rsc_drv *drv, int tcs_id, bool enable)
+{
+	u32 data;
+
+	data = read_tcs_reg(drv, RSC_DRV_IRQ_ENABLE, 0, 0);
+	if (enable)
+		data |= BIT(tcs_id);
+	else
+		data &= ~BIT(tcs_id);
+	write_tcs_reg(drv, RSC_DRV_IRQ_ENABLE, 0, data);
+}
+
 /**
  * tcs_tx_done: TX Done interrupt handler
  */
@@ -235,6 +271,21 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 		}
 
 		trace_rpmh_tx_done(drv, i, req, err);
+
+		/*
+		 * if wake tcs was re-purposed for sending active
+		 * votes, clear AMC trigger & enable modes and
+		 * disable interrupt for this TCS
+		 */
+		if (!drv->tcs[ACTIVE_TCS].num_tcs) {
+			__tcs_trigger(drv, i, false);
+			/*
+			 * Disable interrupt for this TCS to avoid being
+			 * spammed with interrupts coming when the solver
+			 * sends its wake votes.
+			 */
+			enable_tcs_irq(drv, i, false);
+		}
 skip:
 		/* Reclaim the TCS */
 		write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, i, 0);
@@ -282,28 +333,6 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
 	write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, tcs_id, cmd_enable);
 }
 
-static void __tcs_trigger(struct rsc_drv *drv, int tcs_id)
-{
-	u32 enable;
-
-	/*
-	 * HW req: Clear the DRV_CONTROL and enable TCS again
-	 * While clearing ensure that the AMC mode trigger is cleared
-	 * and then the mode enable is cleared.
-	 */
-	enable = read_tcs_reg(drv, RSC_DRV_CONTROL, tcs_id, 0);
-	enable &= ~TCS_AMC_MODE_TRIGGER;
-	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
-	enable &= ~TCS_AMC_MODE_ENABLE;
-	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
-
-	/* Enable the AMC mode on the TCS and then trigger the TCS */
-	enable = TCS_AMC_MODE_ENABLE;
-	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
-	enable |= TCS_AMC_MODE_TRIGGER;
-	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
-}
-
 static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
 				  const struct tcs_request *msg)
 {
@@ -374,10 +403,12 @@ static int tcs_write(struct rsc_drv *drv, const struct tcs_request *msg)
 
 	tcs->req[tcs_id - tcs->offset] = msg;
 	set_bit(tcs_id, drv->tcs_in_use);
+	if (msg->state == RPMH_ACTIVE_ONLY_STATE && tcs->type != ACTIVE_TCS)
+		enable_tcs_irq(drv, tcs_id, true);
 	spin_unlock(&drv->lock);
 
 	__tcs_buffer_write(drv, tcs_id, 0, msg);
-	__tcs_trigger(drv, tcs_id);
+	__tcs_trigger(drv, tcs_id, true);
 
 done_write:
 	spin_unlock_irqrestore(&tcs->lock, flags);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

