Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED659C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B672089C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="izpYiRZJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WLZSXJB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B672089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389401AbeG0L0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:26:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45790 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730583AbeG0L0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:26:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 176F3605BD; Fri, 27 Jul 2018 10:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532685923;
        bh=OYwO4O5rh9WnYpi/3ZUQMm8Dx9PKKJlPkbG76fpXTe0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=izpYiRZJKlXt/+N2lCoBcmdJERI++ubCVe0O0p9oj0WYnGNGK3JxyDE7Y2AAkQjkQ
         kmUIrV76HJ9Xbu9klYdCer+gNyMB0LpETB6XOwUiUyUN+8ZpkNhqUh+lR1INjheUbs
         IMG4apZYXdpmxRSX0XSwSxKPcDtP8WKI3ixK05os=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B7D460B81;
        Fri, 27 Jul 2018 10:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532685921;
        bh=OYwO4O5rh9WnYpi/3ZUQMm8Dx9PKKJlPkbG76fpXTe0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WLZSXJB2PUwk5U66DHanaWTuhHwdfmDm5zYjSTxdeMH/eDpaYiyX3JoQ1+FBNKbFF
         7m5IZYjGXSlXOmCWqKKxLGz29ouJlQem8orlbtC77VPXzFgucjhRl76IQrG+eHWbJ3
         uSMeE0rBMIAnAae5wsbs4UyCKy9ULIk53xUNrYyQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B7D460B81
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   Raju P L S S S N <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v2 6/6] drivers: qcom: rpmh: write PDC data
Date:   Fri, 27 Jul 2018 15:34:49 +0530
Message-Id: <1532685889-31345-7-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532685889-31345-1-git-send-email-rplsssn@codeaurora.org>
References: <1532685889-31345-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <ilina@codeaurora.org>

In addition to requests that are send to the remote processor, the
controller may allow certain data to be written to the controller for
use in specific cases like wakeup value when entering idle states.
Allow a pass through to write PDC data.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/rpmh.c | 28 ++++++++++++++++++++++++++++
 include/soc/qcom/rpmh.h |  6 ++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 0d276fd..f81488b 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -472,6 +472,34 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 }
 EXPORT_SYMBOL(rpmh_write_batch);
 
+/**
+ * rpmh_write_pdc_data: Write PDC data to the controller
+ *
+ * @dev: the device making the request
+ * @cmd: The payload data
+ * @n: The number of elements in payload
+ *
+ * Write PDC data to the controller. The messages are always sent async.
+ *
+ * May be called from atomic contexts.
+ */
+int rpmh_write_pdc_data(const struct device *dev,
+			const struct tcs_cmd *cmd, u32 n)
+{
+	DEFINE_RPMH_MSG_ONSTACK(dev, 0, NULL, rpm_msg);
+	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
+
+	if (!n || n > MAX_RPMH_PAYLOAD)
+		return -EINVAL;
+
+	memcpy(rpm_msg.cmd, cmd, n * sizeof(*cmd));
+	rpm_msg.msg.num_cmds = n;
+	rpm_msg.msg.wait_for_compl = false;
+
+	return rpmh_rsc_write_pdc_data(ctrlr_to_drv(ctrlr), &rpm_msg.msg);
+}
+EXPORT_SYMBOL(rpmh_write_pdc_data);
+
 static int is_req_valid(struct cache_req *req)
 {
 	return (req->sleep_val != UINT_MAX &&
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
index 018788d..d5e736e 100644
--- a/include/soc/qcom/rpmh.h
+++ b/include/soc/qcom/rpmh.h
@@ -28,6 +28,9 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 
 int rpmh_mode_solver_set(const struct device *dev, bool enable);
 
+int rpmh_write_pdc_data(const struct device *dev,
+			const struct tcs_cmd *cmd, u32 n);
+
 #else
 
 static inline int rpmh_write(const struct device *dev, enum rpmh_state state,
@@ -56,6 +59,9 @@ static inline int rpmh_ctrlr_idle(const struct device *dev)
 static inline int rpmh_mode_solver_set(const struct device *dev, bool enable)
 { return -ENODEV; }
 
+static inline int rpmh_write_pdc_data(const struct device *dev,
+				      const struct tcs_cmd *cmd, u32 n)
+{ return -ENODEV; }
 #endif /* CONFIG_QCOM_RPMH */
 
 #endif /* __SOC_QCOM_RPMH_H__ */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

