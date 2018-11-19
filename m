Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EF2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31D3214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrNx6IVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31D3214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404937AbeKTDXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:23:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403980AbeKTDXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:23:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2E35214C4;
        Mon, 19 Nov 2018 16:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646727;
        bh=S6MOT+VWNCk/zUMH+63BS83Ye4WlYhgIwdaFYpzq7EQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YrNx6IVdok/CbRXcRolcbr2oFuPtkirjM9m1pRcuZiB4TLLz+1KkwKj6QoEFJNrKF
         S3TNGQrcyNjElMCioG3tLL7Uo/XHha8wX3nBVhZLOIG+rWXJ977gnnlzBve21GawUz
         0k4lqZIyhEcfpXv4oK0jNegpnIoM4KC7Ff/w/UDg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 030/160] pinctrl: ssbi-gpio: Fix pm8xxx_pin_config_get() to be compliant
Date:   Mon, 19 Nov 2018 17:27:49 +0100
Message-Id: <20181119162633.756232836@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit b432414b996d32a1bd9afe2bd595bd5729c1477f ]

If you look at "pinconf-groups" in debugfs for ssbi-gpio you'll notice
it looks like nonsense.

The problem is fairly well described in commit 1cf86bc21257 ("pinctrl:
qcom: spmi-gpio: Fix pmic_gpio_config_get() to be compliant") and
commit 05e0c828955c ("pinctrl: msm: Fix msm_config_group_get() to be
compliant"), but it was pointed out that ssbi-gpio has the same
problem.  Let's fix it there too.

Fixes: b4c45fe974bc ("pinctrl: qcom: ssbi: Family A gpio & mpp drivers")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c |   28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

--- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
@@ -259,22 +259,32 @@ static int pm8xxx_pin_config_get(struct
 
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
-		arg = pin->bias == PM8XXX_GPIO_BIAS_NP;
+		if (pin->bias != PM8XXX_GPIO_BIAS_NP)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		arg = pin->bias == PM8XXX_GPIO_BIAS_PD;
+		if (pin->bias != PM8XXX_GPIO_BIAS_PD)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
-		arg = pin->bias <= PM8XXX_GPIO_BIAS_PU_1P5_30;
+		if (pin->bias > PM8XXX_GPIO_BIAS_PU_1P5_30)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PM8XXX_QCOM_PULL_UP_STRENGTH:
 		arg = pin->pull_up_strength;
 		break;
 	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
-		arg = pin->disable;
+		if (!pin->disable)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_INPUT_ENABLE:
-		arg = pin->mode == PM8XXX_GPIO_MODE_INPUT;
+		if (pin->mode != PM8XXX_GPIO_MODE_INPUT)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_OUTPUT:
 		if (pin->mode & PM8XXX_GPIO_MODE_OUTPUT)
@@ -289,10 +299,14 @@ static int pm8xxx_pin_config_get(struct
 		arg = pin->output_strength;
 		break;
 	case PIN_CONFIG_DRIVE_PUSH_PULL:
-		arg = !pin->open_drain;
+		if (pin->open_drain)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
-		arg = pin->open_drain;
+		if (!pin->open_drain)
+			return -EINVAL;
+		arg = 1;
 		break;
 	default:
 		return -EINVAL;


