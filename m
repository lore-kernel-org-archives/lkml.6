Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20496ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75392084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oO9QeK56";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oO9QeK56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75392084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbeGSKCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:02:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40130 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbeGSKCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:02:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D61A860B10; Thu, 19 Jul 2018 09:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531991994;
        bh=5QeO4p7JnfaRVjRzsqyJ7ke318vLCKCr53a1pr5g8fY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oO9QeK564j+Iqh83flz81Bz5+PaW84szeWkKEtS8rQP6N0Tasv77A0ZtMSi5q3sHf
         f5QzxP4mMx4NMySrijaMd3wPVcdXYUGjMypaFGayzdTyJtTLFlyyCZGkpSyjN9UPj7
         S+OzgS+FivHheUXj2Cd6v9oHtBA06q8uLx60Zyxs=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7C2BE607C6;
        Thu, 19 Jul 2018 09:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531991994;
        bh=5QeO4p7JnfaRVjRzsqyJ7ke318vLCKCr53a1pr5g8fY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oO9QeK564j+Iqh83flz81Bz5+PaW84szeWkKEtS8rQP6N0Tasv77A0ZtMSi5q3sHf
         f5QzxP4mMx4NMySrijaMd3wPVcdXYUGjMypaFGayzdTyJtTLFlyyCZGkpSyjN9UPj7
         S+OzgS+FivHheUXj2Cd6v9oHtBA06q8uLx60Zyxs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C2BE607C6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   Raju P L S S S N <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH 2/6] drivers: qcom: rpmh: export controller idle status
Date:   Thu, 19 Jul 2018 14:49:31 +0530
Message-Id: <1531991975-23665-3-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531991975-23665-1-git-send-email-rplsssn@codeaurora.org>
References: <1531991975-23665-1-git-send-email-rplsssn@codeaurora.org>
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

