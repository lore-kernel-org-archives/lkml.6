Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6F3C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E5F208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WNHoEypw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c9S71m7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E5F208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934834AbeFRNh4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:37:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42340 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933569AbeFRNhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:37:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C4B2D60227; Mon, 18 Jun 2018 13:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529329071;
        bh=kHRZ7ft/r6oshUK0ah65du67Qyyb3LebaU14Uuvoueo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WNHoEypws5Ta7IZ4gScp7XDHeNqOMmDvc2jXO98LGWvv+QMvAzu7dcH61UFQbvQfk
         8u1RlwILTcoEgsr7AO15V1By6fgOcGIq3JWEJUIyRmux5VnbaXy/hXf4KCj+IuRnwM
         dFym9HXAZ12bhTMLF0cRVyL9tHjV/lBDKLA5mwlA=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4ADC960B16;
        Mon, 18 Jun 2018 13:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529329070;
        bh=kHRZ7ft/r6oshUK0ah65du67Qyyb3LebaU14Uuvoueo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c9S71m7ubBPMELDO1YUypzp5eF1g655X/6Lu4rfNznOmH5vu9QPaiG6Ev2znLgmr1
         BIVCYm724qsAIqMSDk38g4HkiD0BYwlLRYTKREfA1MAftmdXXhkrE+tvyNrPv8+k6r
         sAMK00ZHBLZWvCODdc423tMzACk6/WKtWGddsmbw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4ADC960B16
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   Raju P L S S S N <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v11 05/10] drivers: qcom: rpmh-rsc: write sleep/wake requests to TCS
Date:   Mon, 18 Jun 2018 19:07:15 +0530
Message-Id: <1529329040-2606-6-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529329040-2606-1-git-send-email-rplsssn@codeaurora.org>
References: <1529329040-2606-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <ilina@codeaurora.org>

Sleep and wake requests are sent when the application processor
subsystem of the SoC is entering deep sleep states like in suspend.
These requests help lower the system power requirements when the
resources are not in use.

Sleep and wake requests are written to the TCS slots but are not
triggered at the time of writing. The TCS are triggered by the firmware
after the last of the CPUs has executed its WFI. Since these requests
may come in different batches of requests, it is the job of this
controller driver to find and arrange the requests into the available
TCSes.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

---
Changes in v9:
        - Bounds check in find_match()
        - Bounds check in find_slots()
        - Fix comment in tcs_ctrl_write()
        - Remove EXPORT_SYMBOL

Changes in v8:
	- Bounds check in find_match()

Changes in v7:
	- Bug fix in find_match()
---
 drivers/soc/qcom/rpmh-internal.h |   8 +++
 drivers/soc/qcom/rpmh-rsc.c      | 121 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index f8e0f2a..a464db4 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -14,6 +14,7 @@
 #define MAX_CMDS_PER_TCS		16
 #define MAX_TCS_PER_TYPE		3
 #define MAX_TCS_NR			(MAX_TCS_PER_TYPE * TCS_TYPE_NR)
+#define MAX_TCS_SLOTS			(MAX_CMDS_PER_TCS * MAX_TCS_PER_TYPE)
 
 struct rsc_drv;
 
@@ -29,6 +30,8 @@
  * @ncpt:      number of commands in each TCS
  * @lock:      lock for synchronizing this TCS writes
  * @req:       requests that are sent from the TCS
+ * @cmd_cache: flattened cache of cmds in sleep/wake TCS
+ * @slots:     indicates which of @cmd_addr are occupied
  */
 struct tcs_group {
 	struct rsc_drv *drv;
@@ -39,6 +42,8 @@ struct tcs_group {
 	int ncpt;
 	spinlock_t lock;
 	const struct tcs_request *req[MAX_TCS_PER_TYPE];
+	u32 *cmd_cache;
+	DECLARE_BITMAP(slots, MAX_TCS_SLOTS);
 };
 
 /**
@@ -92,6 +97,9 @@ struct rsc_drv {
 };
 
 int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg);
+int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
+			     const struct tcs_request *msg);
+int rpmh_rsc_invalidate(struct rsc_drv *drv);
 
 void rpmh_tx_done(const struct tcs_request *msg, int r);
 
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 59fa41f..b87f9b0 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -110,6 +110,12 @@ static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
 	case RPMH_ACTIVE_ONLY_STATE:
 		type = ACTIVE_TCS;
 		break;
+	case RPMH_WAKE_ONLY_STATE:
+		type = WAKE_TCS;
+		break;
+	case RPMH_SLEEP_STATE:
+		type = SLEEP_TCS;
+		break;
 	default:
 		return ERR_PTR(-EINVAL);
 	}
@@ -349,6 +355,108 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 	return ret;
 }
 
+static int find_match(const struct tcs_group *tcs, const struct tcs_cmd *cmd,
+		      int len)
+{
+	int i, j;
+
+	/* Check for already cached commands */
+	for_each_set_bit(i, tcs->slots, MAX_TCS_SLOTS) {
+		if (tcs->cmd_cache[i] != cmd[0].addr)
+			continue;
+		if (i + len >= tcs->num_tcs * tcs->ncpt)
+			goto seq_err;
+		for (j = 0; j < len; j++) {
+			if (tcs->cmd_cache[i + j] != cmd[j].addr)
+				goto seq_err;
+		}
+		return i;
+	}
+
+	return -ENODATA;
+
+seq_err:
+	WARN(1, "Message does not match previous sequence.\n");
+	return -EINVAL;
+}
+
+static int find_slots(struct tcs_group *tcs, const struct tcs_request *msg,
+		      int *tcs_id, int *cmd_id)
+{
+	int slot, offset;
+	int i = 0;
+
+	/* Find if we already have the msg in our TCS */
+	slot = find_match(tcs, msg->cmds, msg->num_cmds);
+	if (slot >= 0)
+		goto copy_data;
+
+	/* Do over, until we can fit the full payload in a TCS */
+	do {
+		slot = bitmap_find_next_zero_area(tcs->slots, MAX_TCS_SLOTS,
+						  i, msg->num_cmds, 0);
+		if (slot == tcs->num_tcs * tcs->ncpt)
+			return -ENOMEM;
+		i += tcs->ncpt;
+	} while (slot + msg->num_cmds - 1 >= i);
+
+copy_data:
+	bitmap_set(tcs->slots, slot, msg->num_cmds);
+	/* Copy the addresses of the resources over to the slots */
+	for (i = 0; i < msg->num_cmds; i++)
+		tcs->cmd_cache[slot + i] = msg->cmds[i].addr;
+
+	offset = slot / tcs->ncpt;
+	*tcs_id = offset + tcs->offset;
+	*cmd_id = slot % tcs->ncpt;
+
+	return 0;
+}
+
+static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
+{
+	struct tcs_group *tcs;
+	int tcs_id = 0, cmd_id = 0;
+	unsigned long flags;
+	int ret;
+
+	tcs = get_tcs_for_msg(drv, msg);
+	if (IS_ERR(tcs))
+		return PTR_ERR(tcs);
+
+	spin_lock_irqsave(&tcs->lock, flags);
+	/* find the TCS id and the command in the TCS to write to */
+	ret = find_slots(tcs, msg, &tcs_id, &cmd_id);
+	if (!ret)
+		__tcs_buffer_write(drv, tcs_id, cmd_id, msg);
+	spin_unlock_irqrestore(&tcs->lock, flags);
+
+	return ret;
+}
+
+/**
+ * rpmh_rsc_write_ctrl_data: Write request to the controller
+ *
+ * @drv: the controller
+ * @msg: the data to be written to the controller
+ *
+ * There is no response returned for writing the request to the controller.
+ */
+int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, const struct tcs_request *msg)
+{
+	if (!msg || !msg->cmds || !msg->num_cmds ||
+	    msg->num_cmds > MAX_RPMH_PAYLOAD) {
+		pr_err("Payload error\n");
+		return -EINVAL;
+	}
+
+	/* Data sent to this API will not be sent immediately */
+	if (msg->state == RPMH_ACTIVE_ONLY_STATE)
+		return -EINVAL;
+
+	return tcs_ctrl_write(drv, msg);
+}
+
 static int rpmh_probe_tcs_config(struct platform_device *pdev,
 				 struct rsc_drv *drv)
 {
@@ -424,6 +532,19 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev,
 		tcs->mask = ((1 << tcs->num_tcs) - 1) << st;
 		tcs->offset = st;
 		st += tcs->num_tcs;
+
+		/*
+		 * Allocate memory to cache sleep and wake requests to
+		 * avoid reading TCS register memory.
+		 */
+		if (tcs->type == ACTIVE_TCS)
+			continue;
+
+		tcs->cmd_cache = devm_kcalloc(&pdev->dev,
+					      tcs->num_tcs * ncpt, sizeof(u32),
+					      GFP_KERNEL);
+		if (!tcs->cmd_cache)
+			return -ENOMEM;
 	}
 
 	drv->num_tcs = st;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

