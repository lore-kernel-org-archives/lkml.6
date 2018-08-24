Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C9FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAC72151C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A3AKMkGi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XTr65F2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EAC72151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeHXXnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:43:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52996 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeHXXni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:43:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BF8D0606FC; Fri, 24 Aug 2018 20:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535141251;
        bh=2pUngEnHBN1J4AcObU7DUsOatC9KhAECsI7uSrU7Trk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A3AKMkGixxDTZ25OTblouGfBarK+FQ3zNnD8Jq02xd7u4q4DaphizFzkUiM/3q65u
         nIRWmGR1HjdQoipQAgAB0Mme6z3/HZSg0sU69nRFHFFs9zGFdM/z9OMenvM5Hthfir
         vx9zIawcsLuoJt1q/cCNH7johAtF2CHKxXzi2UY4=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6F814605A5;
        Fri, 24 Aug 2018 20:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535141248;
        bh=2pUngEnHBN1J4AcObU7DUsOatC9KhAECsI7uSrU7Trk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XTr65F2RJweZ7fgaiZYCVlBFMRDdbJ2EwMPNdHd0s8It377nTT7xyzQmow6Lb1i5W
         PTvJuVbrcohL5Y7Mcdac6+e1thrisSVGfEeQlBFeeHfyv+WyeeI5flmNk2/6FIo+xF
         AM8hXnflsRYE6eq1br34tuNUcBHI0Faz8jqZwQEA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6F814605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com,
        rafael@kernel.org, drake@endlessm.com, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC 5/6] drivers: qcom: rpmh: force flush new sleep/wake requests during suspend
Date:   Sat, 25 Aug 2018 01:36:27 +0530
Message-Id: <1535141188-29731-6-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535141188-29731-1-git-send-email-rplsssn@codeaurora.org>
References: <1535141188-29731-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During pm suspend, newer sleep/wake requests may come as it can't be
guaranteed that system PM device suspend will be called only in the end.
After system PM does rpmh_flush, the suspend_in_progress flag is set to
enable rpmh controller to manage new sleep/wake requests if any.

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/rpmh-internal.h |  1 +
 drivers/soc/qcom/rpmh.c          | 17 +++++++++++++++++
 include/soc/qcom/rpmh.h          |  5 +++++
 3 files changed, 23 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index f5359be..45bab3b 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -80,6 +80,7 @@ struct rpmh_ctrlr {
 	bool dirty;
 	struct list_head batch_cache;
 	bool in_solver_mode;
+	bool suspend_in_progress;
 };
 
 /**
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 390e779..a9bd1a0 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -237,6 +237,8 @@ static int __rpmh_write(const struct device *dev, enum rpmh_state state,
 		WARN_ON(irqs_disabled());
 		ret = rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msg->msg);
 	} else {
+		if (ctrlr->suspend_in_progress)
+			rpmh_flush(dev);
 		/* Clean up our call by spoofing tx_done */
 		ret = 0;
 		rpmh_tx_done(&rpm_msg->msg, ret);
@@ -434,6 +436,8 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 
 	if (state != RPMH_ACTIVE_ONLY_STATE) {
 		cache_batch(ctrlr, req);
+		if (ctrlr->suspend_in_progress)
+			rpmh_flush(dev);
 		return 0;
 	}
 
@@ -610,3 +614,16 @@ int rpmh_ctrlr_idle(const struct device *dev)
 	return rpmh_rsc_ctrlr_is_idle(ctrlr_to_drv(ctrlr));
 }
 EXPORT_SYMBOL(rpmh_ctrlr_idle);
+
+/**
+ * rpmh_notify_suspend: Set suspend in progress flag
+ *
+ * @suspend: boolean to indicate the supend mode
+ */
+void rpmh_notify_suspend(const struct device *dev, bool suspend)
+{
+	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
+
+	ctrlr->suspend_in_progress = suspend;
+}
+EXPORT_SYMBOL(rpmh_notify_suspend);
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
index d5e736e..2e79bee 100644
--- a/include/soc/qcom/rpmh.h
+++ b/include/soc/qcom/rpmh.h
@@ -31,6 +31,8 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 int rpmh_write_pdc_data(const struct device *dev,
 			const struct tcs_cmd *cmd, u32 n);
 
+void rpmh_notify_suspend(const struct device *dev, bool suspend);
+
 #else
 
 static inline int rpmh_write(const struct device *dev, enum rpmh_state state,
@@ -62,6 +64,9 @@ static inline int rpmh_mode_solver_set(const struct device *dev, bool enable)
 static inline int rpmh_write_pdc_data(const struct device *dev,
 				      const struct tcs_cmd *cmd, u32 n)
 { return -ENODEV; }
+
+static inline void rpmh_notify_suspend(const struct device *dev, bool suspend)
+{ }
 #endif /* CONFIG_QCOM_RPMH */
 
 #endif /* __SOC_QCOM_RPMH_H__ */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.

