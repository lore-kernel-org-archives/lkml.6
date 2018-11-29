Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E4DC64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D6820863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mOatvf8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D6820863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeK3JVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:21:50 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40993 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeK3JVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:21:49 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so1720881plm.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 14:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EO7ihF7n2bMGlK8SofFmGFu/hpPVR0zNtU43Ep46OZs=;
        b=mOatvf8SehG/Q3q5N5A3GQ4zschqCVf25vsPplLqg+v8m0UG8V0hcMa0PY9cMdJo1g
         lhnLDBc/ZAkqsxp2rk5b151vcbGuEsJy49cE7eOaeIvuhjocJXSdR66itwigwBUs3mDL
         kbg5ghJkqHOc4vSJraRLxWOC/NjNSjEhvw3ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EO7ihF7n2bMGlK8SofFmGFu/hpPVR0zNtU43Ep46OZs=;
        b=GXSlYlXyKllRswrR3dzeMri0gLxD9ohGSJAp8nxPnkMB57ez1g/ov9oEDshr2HFucX
         5czN1gNcgLUmlDbKBA0sy5WrZBfmJv/QyrJeI5zU51S+9x4sfSlGH4kytUxZD8UXolZz
         fwk/Ze/O3GwvVwAoRCtq97Iv6jd2mOVhe/KR78QiRNUJ2u4tXoeEnaxG/oO9Is1rhbQ9
         K4MUKYfMBiXO+jUc27+ptIwSqTdYADaL9qjSrjpmBpyJCbh73HuJacuTGBakubvtSF9P
         BNC8ElkE5yIXLeJodqq+VJ9HJ7fCaE50XVB/V+Wm3wGT7i3IeN5k5ZHF5teznHneMXKj
         A/Sg==
X-Gm-Message-State: AA+aEWasVqk1kiOC82J3aRE0Qb2s/oFVkHIGGp6Au9/41GMiMo7zd2r0
        kiRmPmghjRdlsos5H9NudxjjzA==
X-Google-Smtp-Source: AFSGD/X1C/z6YMgz1tiuumY4GL/PM4pj90qJuODIFNW6yEXcqRbNf1wkQ0OtBo+DhvU818sDF9cwbA==
X-Received: by 2002:a17:902:bd86:: with SMTP id q6mr3124699pls.16.1543529690279;
        Thu, 29 Nov 2018 14:14:50 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id c67sm4697690pfg.170.2018.11.29.14.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 14:14:49 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh@kernel.org>, Can Guo <cang@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>
Subject: [PATCH v1 4/4] phy: qcom-qmp: Expose provided clocks to DT
Date:   Thu, 29 Nov 2018 14:13:57 -0800
Message-Id: <20181129221357.67417-5-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181129221357.67417-1-evgreen@chromium.org>
References: <20181129221357.67417-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register a simple clock provider for the PHY pipe clock sources so that
device tree users can point at these clocks via phandles to the lane
nodes.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 drivers/phy/qualcomm/phy-qcom-qmp.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 8204d55e2d650..b4006818e1b65 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -1542,6 +1542,11 @@ static int qcom_qmp_phy_clk_init(struct device *dev)
 	return devm_clk_bulk_get(dev, num, qmp->clks);
 }
 
+static void phy_pipe_clk_release_provider(void *res)
+{
+	of_clk_del_provider(res);
+}
+
 /*
  * Register a fixed rate pipe clock.
  *
@@ -1588,7 +1593,23 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
 	fixed->fixed_rate = 125000000;
 	fixed->hw.init = &init;
 
-	return devm_clk_hw_register(qmp->dev, &fixed->hw);
+	ret = devm_clk_hw_register(qmp->dev, &fixed->hw);
+	if (ret)
+		return ret;
+
+	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, &fixed->hw);
+	if (ret)
+		return ret;
+
+	/*
+	 * Roll a devm action because the clock provider is the child node, but
+	 * the child node is not actually a device.
+	 */
+	ret = devm_add_action(qmp->dev, phy_pipe_clk_release_provider, np);
+	if (ret)
+		phy_pipe_clk_release_provider(np);
+
+	return ret;
 }
 
 static const struct phy_ops qcom_qmp_phy_gen_ops = {
-- 
2.18.1

