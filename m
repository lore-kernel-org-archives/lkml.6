Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEB5C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A283820897
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QRNGi+4g";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YOaTm4dU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A283820897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389311AbeG0L0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:26:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45348 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730717AbeG0L0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:26:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 12C1E60B77; Fri, 27 Jul 2018 10:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532685907;
        bh=5QeO4p7JnfaRVjRzsqyJ7ke318vLCKCr53a1pr5g8fY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QRNGi+4gSx2PJdpIizbXigsVBq8Xzoj0Gxg9sEZxIiusDGJmoKpyA2N/bcSJsX4FN
         RPDDI531c3+dRu6+IlnPnnTSLXL1IXavV7wVU3MwBviuK2VgdLl/tr2dgsrrTLEbjs
         zzzjHX+jIz5ru8kcpSqUYsZNs806GfteQBbpEUVo=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 38FE8607B9;
        Fri, 27 Jul 2018 10:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532685905;
        bh=5QeO4p7JnfaRVjRzsqyJ7ke318vLCKCr53a1pr5g8fY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YOaTm4dUn0TeoAzWT5sQabIahC+gVxyRCoXz+6BLeSvo3KFTGs8de6zYeFa1BZuuu
         y29e7Dh86DerUmC9WJXGbTWU+p021lTOIp5axAxsDeLM66srMbePC0Nvv/4l6Ygo3N
         S99Z/83HHegCRu2OFZEK9ji37QfhWSc0STdYIMog=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 38FE8607B9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   Raju P L S S S N <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v2 2/6] drivers: qcom: rpmh: export controller idle status
Date:   Fri, 27 Jul 2018 15:34:45 +0530
Message-Id: <1532685889-31345-3-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532685889-31345-1-git-send-email-rplsssn@codeaurora.org>
References: <1532685889-31345-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <ilina@codeaurora.org>

Allow the controller state be read by platform drivers. This is useful
for PM drivers which can choose to disallow idle modes when the
controller is busy.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/rpmh.c | 13 +++++++++++++
 include/soc/qcom/rpmh.h |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index c7beb68..2382276 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -511,3 +511,16 @@ int rpmh_invalidate(const struct device *dev)
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
index 619e07c..d445322 100644
--- a/include/soc/qcom/rpmh.h
+++ b/include/soc/qcom/rpmh.h
@@ -24,6 +24,8 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 
 int rpmh_invalidate(const struct device *dev);
 
+int rpmh_ctrlr_idle(const struct device *dev);
+
 #else
 
 static inline int rpmh_write(const struct device *dev, enum rpmh_state state,
@@ -46,6 +48,9 @@ static inline int rpmh_flush(const struct device *dev)
 static inline int rpmh_invalidate(const struct device *dev)
 { return -ENODEV; }
 
+static inline int rpmh_ctrlr_idle(const struct device *dev)
+{ return -ENODEV; }
+
 #endif /* CONFIG_QCOM_RPMH */
 
 #endif /* __SOC_QCOM_RPMH_H__ */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

