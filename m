Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5397FC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01AA920657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cB0kjaMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01AA920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeKCGyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 02:54:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42032 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbeKCGyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 02:54:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id t6-v6so1569671plo.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 14:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IpjGYI017Uw4/g661hwo8OEcZ5+umgzP90a+AYk8Kow=;
        b=cB0kjaMWaAna9R/UMxebWit7dvPEY2CStOs7YON2z7xeTCZf+vdbv4vXBx+7srk4PL
         jfI4ySBt1GlhsEx44lk1nYRoU8MA7/eR3ukXA1oYACv3edW41ptuet3uNEK2aNqhNQlX
         K98lvBGccWKTNMlbNnR6wz9p7YEuU0ld0HUg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IpjGYI017Uw4/g661hwo8OEcZ5+umgzP90a+AYk8Kow=;
        b=tVO5HDsnAcolotkGPa7Ge85viII+f15piYJ6lp3x6UBKD2bk5ItanemyT8RSHXf/Jq
         hozWoXL2vz5xH0H0EQFXmyJWug8zsOVidS8jLMCJR2+b49vQjoBhgiC3NPKe+pfugbkw
         4ORZAJV86ugsivU33G8/fjz770g6L7pDijbbbP/T3uqm/ruSAjkqZRfAXQZrFLgO6m+Q
         UcNnrFEi1t94bxrtNGt0uQxDau/jC5wy02B02A+uYZEzsXEQ5VsZD6PwcIyJd90rqDKA
         nPJ8N488xSRCEFiCU5zrJt41BxHRvorc3oL3XaIeINO4K93Zt3araw6sgd18A0Q8h/1m
         3J5Q==
X-Gm-Message-State: AGRZ1gIlq1v0i6pPbwzrbT4xTnPaRd3SRuGcqQmXoqmdw3UnyT4U207v
        jj/GzySOeAnNyYyIR2rM17gn9w==
X-Google-Smtp-Source: AJdET5eExMX6CUYOEm4v8C7BzMEx/3g2dtKpaSSwWe4Fi9RnQHrhTo0vYggJKm08abjpxUnJmE29tw==
X-Received: by 2002:a17:902:4683:: with SMTP id p3-v6mr13398776pld.215.1541195155698;
        Fri, 02 Nov 2018 14:45:55 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id q25-v6sm58332871pfk.154.2018.11.02.14.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 14:45:55 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/2] drm/msm/dsi: Get PHY ref clock from the DT
Date:   Fri,  2 Nov 2018 14:45:34 -0700
Message-Id: <20181102214534.184593-2-mka@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181102214534.184593-1-mka@chromium.org>
References: <20181102214534.184593-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get the PHY ref clock from the device tree instead of hardcoding
its name and rate.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
index 4c03f0b7343ed..1016eb50df8f5 100644
--- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
+++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
@@ -91,6 +91,8 @@ struct dsi_pll_10nm {
 	void __iomem *phy_cmn_mmio;
 	void __iomem *mmio;
 
+	struct clk *vco_ref_clk;
+
 	u64 vco_ref_clk_rate;
 	u64 vco_current_rate;
 
@@ -630,7 +632,8 @@ static int pll_10nm_register(struct dsi_pll_10nm *pll_10nm)
 	char clk_name[32], parent[32], vco_name[32];
 	char parent2[32], parent3[32], parent4[32];
 	struct clk_init_data vco_init = {
-		.parent_names = (const char *[]){ "xo" },
+		.parent_names = (const char *[]){
+			__clk_get_name(pll_10nm->vco_ref_clk) },
 		.num_parents = 1,
 		.name = vco_name,
 		.flags = CLK_IGNORE_UNUSED,
@@ -786,6 +789,12 @@ struct msm_dsi_pll *msm_dsi_pll_10nm_init(struct platform_device *pdev, int id)
 	pll_10nm->id = id;
 	pll_10nm_list[id] = pll_10nm;
 
+	pll_10nm->vco_ref_clk = devm_clk_get(&pdev->dev, "ref");
+	if (IS_ERR(pll_10nm->vco_ref_clk)) {
+		dev_err(&pdev->dev, "couldn't get 'ref' clock\n");
+		return (void *)pll_10nm->vco_ref_clk;
+	}
+
 	pll_10nm->phy_cmn_mmio = msm_ioremap(pdev, "dsi_phy", "DSI_PHY");
 	if (IS_ERR_OR_NULL(pll_10nm->phy_cmn_mmio)) {
 		dev_err(&pdev->dev, "failed to map CMN PHY base\n");
-- 
2.19.1.930.g4563a0d9d0-goog

