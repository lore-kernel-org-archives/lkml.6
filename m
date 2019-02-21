Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA052C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1142084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="j/Fcpk1s";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AmfzzBdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfBUMSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:18:50 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49238 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbfBUMSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:18:50 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 747B36071B; Thu, 21 Feb 2019 12:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550751528;
        bh=OWUNzgyouFxhFBiGGEvQ7p+ITWRRxqtqoCXolfWC338=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j/Fcpk1s20bo5qP10Y9V48Ly8ZG4EVjnpO5z+ijv+iq2CZUFxTuVgCRfaz7EyALiK
         MHo6Z/8JPOEXJsyIz4aRakByzjGr/zd96DOwSUKkGC9w02BTyGPSJWy8Tby+4BeD4w
         6phYfdxSqKYNIFRqBuVDQ6ALn+MbezZXR3EIBBfI=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A3C72608D4;
        Thu, 21 Feb 2019 12:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550751526;
        bh=OWUNzgyouFxhFBiGGEvQ7p+ITWRRxqtqoCXolfWC338=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AmfzzBdUxg8CoMIdBhG/equcHEji+yT+UZBoBQjrs+UfVlvazgnMGGKcxQfJVSjj5
         Ew6XuWJinOQI1SwniJpp2xnEl8+wUap1ljOLWtZd2YFUOl6z5Igu/o9igh08Aie6BV
         VgBxIcJbq6V0OzPreo4MsDVzCRC9z13/dspk5huo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A3C72608D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org,
        mka@chromium.org, ilina@codeaurora.org,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>
Subject: [PATCH RESEND v3 2/3] drivers: qcom: rpmh-rsc: return if the controller is idle
Date:   Thu, 21 Feb 2019 17:48:26 +0530
Message-Id: <20190221121827.32427-3-rplsssn@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221121827.32427-1-rplsssn@codeaurora.org>
References: <20190221121827.32427-1-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <ilina@codeaurora.org>

Allow the controller status be queried. The controller is busy if it is
actively processing request. Also allow the controller state be read by
platform drivers. This is useful for PM drivers which can choose to
disallow idle modes when the controller is busy.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/rpmh-internal.h |  1 +
 drivers/soc/qcom/rpmh-rsc.c      | 24 ++++++++++++++++++++++++
 drivers/soc/qcom/rpmh.c          | 13 +++++++++++++
 include/soc/qcom/rpmh.h          |  5 +++++
 4 files changed, 43 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 2e3ffcdf220e..4b891c23b4cd 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -109,6 +109,7 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
 			     const struct tcs_request *msg);
 int rpmh_rsc_invalidate(struct rsc_drv *drv);
 int rpmh_rsc_write_pdc_data(struct rsc_drv *drv, const struct tcs_request *msg);
+bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv);
 void rpmh_tx_done(const struct tcs_request *msg, int r);
 
 #endif /* __RPM_INTERNAL_H__ */
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index d6b834eeeb37..9cc303e88a06 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -524,6 +524,30 @@ static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
 	return ret;
 }
 
+/**
+ *  rpmh_rsc_ctrlr_is_idle: Check if any of the AMCs are busy.
+ *
+ *  @drv: The controller
+ *
+ *  Returns true if the TCSes are engaged in handling requests.
+ */
+bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv)
+{
+	int m;
+	struct tcs_group *tcs = get_tcs_of_type(drv, ACTIVE_TCS);
+
+	spin_lock(&drv->lock);
+	for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
+		if (!tcs_is_free(drv, m)) {
+			spin_unlock(&drv->lock);
+			return false;
+		}
+	}
+	spin_unlock(&drv->lock);
+
+	return true;
+}
+
 /**
  * rpmh_rsc_write_ctrl_data: Write request to the controller
  *
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 297d6cc4e395..43eb9816041a 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -535,3 +535,16 @@ int rpmh_invalidate(const struct device *dev)
 	return ret;
 }
 EXPORT_SYMBOL(rpmh_invalidate);
+
+/**
+ * rpmh_ctrlr_idle: Return the controller idle status
+ *
+ * @dev: the device making the request
+ */
+int rpmh_ctrlr_idle(const struct device *dev)
+{
+	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
+
+	return rpmh_rsc_ctrlr_is_idle(ctrlr_to_drv(ctrlr));
+}
+EXPORT_SYMBOL(rpmh_ctrlr_idle);
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
index b05e31aaf047..4c4b013f0226 100644
--- a/include/soc/qcom/rpmh.h
+++ b/include/soc/qcom/rpmh.h
@@ -27,6 +27,8 @@ int rpmh_invalidate(const struct device *dev);
 int rpmh_write_pdc_data(const struct device *dev,
 			const struct tcs_cmd *cmd, u32 n);
 
+int rpmh_ctrlr_idle(const struct device *dev);
+
 #else
 
 static inline int rpmh_write(const struct device *dev, enum rpmh_state state,
@@ -53,6 +55,9 @@ static inline int rpmh_write_pdc_data(const struct device *dev,
 				      const struct tcs_cmd *cmd, u32 n)
 { return -ENODEV; }
 
+static inline int rpmh_ctrlr_idle(const struct device *dev)
+{ return -ENODEV; }
+
 #endif /* CONFIG_QCOM_RPMH */
 
 #endif /* __SOC_QCOM_RPMH_H__ */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

