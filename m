Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B49C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F155B2098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="REWr8bte";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NsM1GuOi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F155B2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbeJCQoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 12:44:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58798 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725746AbeJCQo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 12:44:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3D33A60C67; Wed,  3 Oct 2018 09:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538560609;
        bh=Zb1BDeDMzPO6PFG2EEGJgomfN06TTE0wBcGgP/4g40g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=REWr8bteprvF8j1s3T2eqMIRMS/pXOmjb75D6SPtSEpWZPE/NIY9crvRZQHIXBeQR
         EYTmeWdAnb4lgZlqJaOCA1yFygNVmc7H76OBmq4ZH24F80idfsyU+pFb8AEnADNjCH
         iMCU4i4e8qEiF9OxTv30fRx0QaBVQqx8YWWMt3jw=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EC439602F1;
        Wed,  3 Oct 2018 09:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538560608;
        bh=Zb1BDeDMzPO6PFG2EEGJgomfN06TTE0wBcGgP/4g40g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NsM1GuOiDR2qPwYPbCDg6bltdJ2fEKrv5yg4dAHTCITPEYp2hyfX6XyPac4giDvKh
         u+9BDKWXxAtkzNxn3iN6Gk+jCU9POCqu9gG6QNvB0iw+yGyWBuQKtrW+aIsZzYDEKJ
         /JoyQT1XsuagCOPHY1nltVb1yCEole+j/Km1xC5A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC439602F1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org,
        mka@chromium.org, ilina@codeaurora.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v1 1/2] drivers: qcom: rpmh-rsc: clear active mode configuration for wake TCS
Date:   Wed,  3 Oct 2018 15:26:34 +0530
Message-Id: <1538560595-6275-2-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538560595-6275-1-git-send-email-rplsssn@codeaurora.org>
References: <1538560595-6275-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For RSCs that have sleep & wake TCS but no dedicated active TCS, wake
TCS can be re-purposed to send active requests. Once the active requests
are sent and response is received, the active mode configuration needs
to be cleared so that controller can use wake TCS for sending wake
requests.

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 77 +++++++++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 23 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 75bd9a8..6cc7f21 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -201,6 +201,42 @@ static const struct tcs_request *get_req_from_tcs(struct rsc_drv *drv,
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
@@ -237,6 +273,21 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
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
@@ -285,28 +336,6 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
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
@@ -377,10 +406,12 @@ static int tcs_write(struct rsc_drv *drv, const struct tcs_request *msg)
 
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
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

