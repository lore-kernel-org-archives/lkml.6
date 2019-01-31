Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CABC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612F8218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cNqAgXRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfAaRaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:30:10 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35326 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfAaRaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:30:09 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so1649175pgs.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 09:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=N1TyQHj6pdO8zdfHOnph0MwaydyivV1NXjwR/LUXizo=;
        b=cNqAgXRd/8i9g0UWadD8iE65xT93UjPY0BFb7BaCGIok9F45hcfpHjgu6bmpuJ4TYO
         Mot1hfRqEazLstxQFhB0aI4lhogb/clvqvJknGc97QL5GQGkojY4vjJ1dGNVkVr+xWft
         ppqgMoQF2ICWHOJBm5h55dSFb7TCbmHQHHFRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N1TyQHj6pdO8zdfHOnph0MwaydyivV1NXjwR/LUXizo=;
        b=PoUcxUdMZkY+kcyeD3vHOgkgxUZSvMM/Fz8McYDWUDbgxvV/XI/Wq6lhSfqyPRZEJb
         +5vSi8NGjCLo4BnHuxweH0FXs/JwGdwCPITiZlWKbr4OZY5Qdn4liELL3aKh7MG7rf9W
         xhnVlry+mlAj0s89n8LilQZCV1l9HRduHNdCvjU3WGjJPcXuEWDKqP0qlIR39EDwuOsu
         FZ6yR5znJBIiX5phAe30amuQGSsNBj6Zjw9ugLEuJ6xpY/yt4u9di9+Say8COXwzk1tI
         s5zBKaFz5MMLvtJTUUCscRc/Q3iabrjkEp5CNVPSjBjC1uQW7dn3vsjIQSW3pNs6XdTb
         fa1g==
X-Gm-Message-State: AHQUAuZmmh+rDKP3qppBsPVdUd47E3Rr79wz561eXH/ao8C4xZzKulSh
        LHARxkJONGLZhjXr7LV5itTLKg==
X-Google-Smtp-Source: AHgI3IadKAr3PoQzMnJpcF71wBK1OyIIw1BMjiYlXOAhSQjK4wqFPQTHsDcL8hhUmgP0sTVI1F10DQ==
X-Received: by 2002:a62:8a57:: with SMTP id y84mr4681345pfd.197.1548955808945;
        Thu, 31 Jan 2019 09:30:08 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l85sm13662645pfg.161.2019.01.31.09.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 09:30:08 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] pinctrl: qcom: qcs404: Correct SDC tile
Date:   Thu, 31 Jan 2019 09:29:53 -0800
Message-Id: <20190131172953.27339-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDC controls live in the south tile, not the north one. Correct this
so that we program the right registers.

Cc: stable@vger.kernel.org
Fixes: 22eb8301dbc1 ("pinctrl: qcom: Add qcs404 pinctrl driver")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-qcs404.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-qcs404.c b/drivers/pinctrl/qcom/pinctrl-qcs404.c
index 7aae52a09ff0..4ffd56ff809e 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcs404.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcs404.c
@@ -79,7 +79,7 @@ enum {
 		.intr_cfg_reg = 0,			\
 		.intr_status_reg = 0,			\
 		.intr_target_reg = 0,			\
-		.tile = NORTH,				\
+		.tile = SOUTH,				\
 		.mux_bit = -1,				\
 		.pull_bit = pull,			\
 		.drv_bit = drv,				\
-- 
2.18.0

