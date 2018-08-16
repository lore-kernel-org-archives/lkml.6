Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32C7C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B27C21473
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AURecagf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B27C21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbeHPXH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:07:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45564 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbeHPXHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:07:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id f1-v6so2528934pgq.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 13:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NV6/vcFg/jcSYYSg0yJsaWgzVmwAkbB2HjRIb3vdI3c=;
        b=AURecagfFN5dIe26lIB4aWciGBgGjtG+PrIPDzj2Rry2W2KxHU+a9s20CfaHL8Re6e
         snCNwrCslFca/s9lFBokVwCJLrRXkX1qrLMxVSjFdMHCLdMwg76rE2lbtlS/xsCrofyd
         TfOOkcuqEN70Qu53HmcZ7e8FguCwusE/xbing=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NV6/vcFg/jcSYYSg0yJsaWgzVmwAkbB2HjRIb3vdI3c=;
        b=g/0iOOhZS87SNL4f8ow1tr8uzmm5OeDoYiN2+F6Qynjdn5h5LySh8wi1dyWP6r3V2S
         zEhbzsDsObMUwwQVtKBDvp/YrrMLoaR0osgvUWNlRzDxQQRkizQ7sVA6sKh6xKiHhIQO
         O2kcV9jHLX7xCn3zAaap3xOgeV8ZLTUIutCJDo3jEz7yL0FiY1QUt4ijEP/ahgGQgJVh
         r9FBdwjx3wiVvlpjl0Ct6YSljWJJ0PSwUazjrsqer+873w0fH8gFqCD4PoCp0eI0EQ46
         qn+FazHcGuEmjuhDU6vWILf1gsD2TaHAGXFrrCgGMR0bop0YdsSeFFf/TUdk4aR4oDdD
         reuw==
X-Gm-Message-State: AOUpUlGCN515TP0Whq8b/7GPd8puC5FhJRREPeC+T4iWL1hd6FPSEPe/
        zMEJe+pdARrGZfbJ0XPmlEIhFg==
X-Google-Smtp-Source: AA+uWPzZn9ysXQv9DDV/iXtVKTORHTLddnfsGUQzJyJTSHyDPO66oTNlHv1rOFrvObdi9rdpcql8pA==
X-Received: by 2002:a65:658d:: with SMTP id u13-v6mr30556076pgv.20.1534450011651;
        Thu, 16 Aug 2018 13:06:51 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id v6-v6sm234958pfa.28.2018.08.16.13.06.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 13:06:51 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH v3 2/3] pinctrl: msm: Mux out gpio function with gpio_request()
Date:   Thu, 16 Aug 2018 13:06:47 -0700
Message-Id: <20180816200648.90458-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
In-Reply-To: <20180816200648.90458-1-swboyd@chromium.org>
References: <20180816200648.90458-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We rely on devices to use pinmuxing configurations in DT to select the
GPIO function (function 0) if they're going to use the gpio in GPIO
mode. Let's simplify things for driver authors by implementing
gpio_request_enable() for this pinctrl driver to mux out the GPIO
function when the gpio is use from gpiolib.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 5d72ffad32c2..793504057ad0 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -176,11 +176,27 @@ static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+static int msm_pinmux_request_gpio(struct pinctrl_dev *pctldev,
+				   struct pinctrl_gpio_range *range,
+				   unsigned offset)
+{
+	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+	const struct msm_pingroup *g = &pctrl->soc->groups[offset];
+
+	/* No funcs? Probably ACPI so can't do anything here */
+	if (!g->nfuncs)
+		return 0;
+
+	/* For now assume function 0 is GPIO because it always is */
+	return msm_pinmux_set_mux(pctldev, 0, offset);
+}
+
 static const struct pinmux_ops msm_pinmux_ops = {
 	.request		= msm_pinmux_request,
 	.get_functions_count	= msm_get_functions_count,
 	.get_function_name	= msm_get_function_name,
 	.get_function_groups	= msm_get_function_groups,
+	.gpio_request_enable	= msm_pinmux_request_gpio,
 	.set_mux		= msm_pinmux_set_mux,
 };
 
-- 
Sent by a computer through tubes

