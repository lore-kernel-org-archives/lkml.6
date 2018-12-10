Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7797FC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF9F2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ljG7Ys+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF9F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbeLJTch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:32:37 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43131 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbeLJTcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:32:35 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so5701036plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 11:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qADK9GQx6vRp2yv9jWtZGFtdosmaQAYb7K8M9lg60NY=;
        b=ljG7Ys+5X7rmTz3m5k8OoelmNBtVUpvkPIHTvRd2Xii7LkEMMYusYIknI9qjFR1MO5
         DBx6vm7DB+m1I0T4MQfgEfKO3CrfJi0fjMcrUGWAT8USw4dO0zkVgNbSZzXpqcqwnVLN
         /EZHiZCkFLAx175EQQj5ezORgX1HcnRGxguiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qADK9GQx6vRp2yv9jWtZGFtdosmaQAYb7K8M9lg60NY=;
        b=jlP2XeM5X1rTgNa7rcDpXTYaHF/Ryylre8XXgXTtFVs3VYbhKHNzSlfviuSdg5JTwB
         FnXI6CXgUk7wvvQz3aM8wRBZtu06FGEHLR894UeyfFPGpjYsLvB7cPnf6xlZnNaZkUUA
         eIBCbRj+d67kXU5FiYrp1PeYLyxFxAxrTffApAeQhbZcK5xedZnEbPMJRIBWfVbQBM0i
         gnyJqGcf9FttE+/CqfWjTDZ/uKmowbmIdKUD0SwC2VA2+pzpritsI+dEOg/f4X6mOYVf
         BrA6KJT/wT+Q5kazWaTX7FY/LaexCoUyN47VXL2ApcqH2/wnwgjGQncQNdlkabLbXDDT
         ppEA==
X-Gm-Message-State: AA+aEWaBPHOD1nNhbBKN1oW4Nq+isrslUA/mDz6E7EoGMEIP3rhtgalb
        TPCXnz5bR4787km0v/5BkX6kEQ==
X-Google-Smtp-Source: AFSGD/USSaq4Gj5UaoyY6ea1xXzPOCuixelQhC7n1Z2cJbjfz6MBECrB65UUQGmqudJkmvSg+v2zug==
X-Received: by 2002:a17:902:4464:: with SMTP id k91mr13407149pld.13.1544470354360;
        Mon, 10 Dec 2018 11:32:34 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id v5sm23737875pgn.5.2018.12.10.11.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 11:32:33 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Gross <andy.gross@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Can Guo <cang@codeaurora.org>, linux-kernel@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>
Subject: [PATCH v2 4/4] phy: qcom-qmp: Expose provided clocks to DT
Date:   Mon, 10 Dec 2018 11:32:07 -0800
Message-Id: <20181210193207.242080-5-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181210193207.242080-1-evgreen@chromium.org>
References: <20181210193207.242080-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register a simple clock provider for the PHY pipe clock sources so that
device tree users can point at these clocks via phandles to the lane
nodes.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Vivek Gautam <vivek.gautam@codeaurora.org>

---

Changes in v2:
 - Rebased onto phy/next

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

