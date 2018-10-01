Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3749EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31D52145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HxgL1m8V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31D52145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeJBE27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:28:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36131 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbeJBE27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:28:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id f18-v6so6882962pgv.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 14:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ei10IMDTH9p7ZNfD8xEmYEMq7A1+pvhdDRd1zGw788U=;
        b=HxgL1m8V0/yiK2g6wuzWbeSx9bV7dCYP0GOyp3bzaCftTGsCV3YAboTnIk2C9vC4I8
         DPH3aiFUAq42F7ltfWOs8NCw/tSoxGQDOI0DpznF7K6yR42CYK1Gv6D+BzjA/0Bv6jrU
         D8vncwGl0f6fdpw8eDjHIJnSNEJZjsU+ydnRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ei10IMDTH9p7ZNfD8xEmYEMq7A1+pvhdDRd1zGw788U=;
        b=nGa3V7UAbjUSsso5jwXgmkqv5Qf65m8PWScL9eHCaIkhjJf67/ydxD3dE1TnELdGmj
         dKqwcYqNVmaYRLKgIUSEL2VS8L5HRts/mI5giZMsRgjMCKYFwLrfW4RoIyZ6E5bYjr1d
         Grk0Ietqn1zFkdviFp0xHBEHTvu/qW8I9KpFoW/KBTrQcBkk7W2FOeJCCPHIk8GBKZ6e
         xiX9idVA2ncnr36HJNdusIctRimyDu0gh4CGRvt2o8wZ5Rz1GpKuLXSIDD+atfi+PCUn
         E4gzYzlttQrRBnjauKUj3uyyDqjPKzAjOWWrntIx7FfODNGdtk+RzUJN8eMfgw+BAoSO
         wgEA==
X-Gm-Message-State: ABuFfoi2U+SSj8LGGviJho8m4PJN52X+kLK+rsq1XzfnlMIlnR03PERg
        8zGdPtvINV0fFE09R5SqEzp+uw==
X-Google-Smtp-Source: ACcGV60jjmbUzmpk5/aScoNEuZJyQBvAeMw/nbwNmMfvzeHomOHXUr5ixO2O6xGG0VccbDqEu7pxSg==
X-Received: by 2002:a17:902:a9c9:: with SMTP id b9-v6mr13020814plr.225.1538430547028;
        Mon, 01 Oct 2018 14:49:07 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id g88-v6sm27159070pfd.181.2018.10.01.14.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 14:49:06 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: [PATCH] pinctrl: msm: Actually use function 0 for gpio selection
Date:   Mon,  1 Oct 2018 14:49:05 -0700
Message-Id: <20181001214905.12149-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code needs to select function #0, which is the first int in the
array of functions, not the number 0 which may or may not be the
function for "GPIO mode" per the enum mapping. We were getting lucky on
SDM845, where this was tested, because the function 0 matched the enum
value for "GPIO mode". On other platforms, e.g. MSM8996, the gpio enum
value is the last one in the list so this code doesn't work and we see a
warning at boot. Fix it by grabbing the first element out of the array
of functions.

Cc: Doug Anderson <dianders@chromium.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Niklas Cassel <niklas.cassel@linaro.org>
Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
Fixes: 1de7ddb3a15c ("pinctrl: msm: Mux out gpio function with gpio_request()")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 1684b2da09d5..b925b8feac95 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -188,7 +188,7 @@ static int msm_pinmux_request_gpio(struct pinctrl_dev *pctldev,
 		return 0;
 
 	/* For now assume function 0 is GPIO because it always is */
-	return msm_pinmux_set_mux(pctldev, 0, offset);
+	return msm_pinmux_set_mux(pctldev, g->funcs[0], offset);
 }
 
 static const struct pinmux_ops msm_pinmux_ops = {
-- 
Sent by a computer through tubes

