Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F248C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E5A20882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOYT2UOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E5A20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbeG2Vc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:32:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41275 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeG2Vc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:32:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id j5-v6so10493575wrr.8;
        Sun, 29 Jul 2018 13:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EIzsYNTblUGRSRBF+KQjqSRwijHZZ8m9W32BQz0Kni0=;
        b=NOYT2UOLiuzdI0w5iNITjHbZfmudWLtRGxTuhgAyZ8efe8LgP9Tqk0T5fNwb59i1tZ
         h7OkbhRW5RkbIfLwgg7WWABHuHzbCbMoS41iQZucibmksA7DoX313TITNOS+M0sKziNv
         SXdbW+xy2qU4BCFH/bQH7rnhxh5ivOPJJ2n4Rax3rQi6MNNo4puhd4TEK4YRlc4EFnpY
         qVxyy/u8UiCG9uWcM3JMo8f+p3S6P0+QCjfzdEg/yMa3A5Ox35SmWST6I793MKUOYicQ
         7hkvRDWfjmagDoVt61XdtKfdTg6XT16qlP7/fbjsPxxb69PI5xViGgCK/nz+Z7POSOPo
         dUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EIzsYNTblUGRSRBF+KQjqSRwijHZZ8m9W32BQz0Kni0=;
        b=oO80zhhp3Q+1DvEoR1JRRfowmMLfZEsZtqAQEzTqE2H5dKvkXXTIAnwXvPiWRe+k4S
         DD0xKT434OmgMULr6BaE17UIN2c01MNuAeNDlbrGJrPVB3WNyJaNGYvx+0IaU7LUtHTC
         c6q9BG30IC+yHuUQ7cHJ42Cl+idcFi6YbSUwzE/9lvRqmL2azZej5CCNHeLFFUxXUTc8
         idJZMNedvdy0eL9eKGmyST0lC7JQf4sNA1TJ9O3YZQP1P7Ei08TIaLRj/DHE6vgNFx6o
         1dFmmP7unW6/qlNjtcFAnKh01R5AokSVhcTDyee4BEWEqysQR+iLuTB4M/Fx99+mrA8G
         EbbA==
X-Gm-Message-State: AOUpUlFD0HYZCr6sWcBhwdhYWAMOltn7lu6e3Tr8RVZabi6WXn/6Dq7c
        ro71cuYCXsxUrgOShSDj6T8=
X-Google-Smtp-Source: AAOMgpcfBHmnCozN3DDcOC1iQrkMmx40PmZmFJIQVyEV2KXgZagJxW+4IClYrEbi6UMnpnfBovXmdA==
X-Received: by 2002:adf:dd07:: with SMTP id a7-v6mr14968190wrm.2.1532894477629;
        Sun, 29 Jul 2018 13:01:17 -0700 (PDT)
Received: from localhost.localdomain (p5DCFE1FB.dip0.t-ipconnect.de. [93.207.225.251])
        by smtp.gmail.com with ESMTPSA id g15-v6sm12334213wrh.48.2018.07.29.13.01.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 13:01:16 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     manivannan.sadhasivam@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v3 2/5] pinctrl: actions: define pad control configurtion to SoC specific
Date:   Sun, 29 Jul 2018 22:00:35 +0200
Message-Id: <20180729200038.11795-3-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729200038.11795-1-sravanhome@gmail.com>
References: <20180729182551.19383-1-sravanhome@gmail.com>
 <20180729200038.11795-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pad control for s900 and s700 are differs in number of
pull control configuraions
s900 has 4 pull controls - high impedence, pull up, pull down, repeater
s700, s500 has 2 pull controls - pull up and pull down

so pad control configuration has to SoC specific, moved out from pinctrl
common to s700, s900 specific.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/pinctrl/actions/pinctrl-owl.c  | 64 ++++---------------------
 drivers/pinctrl/actions/pinctrl-owl.h  | 13 +++--
 drivers/pinctrl/actions/pinctrl-s900.c | 66 +++++++++++++++++++++++++-
 3 files changed, 79 insertions(+), 64 deletions(-)

diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/pinctrl-owl.c
index 4fa9cc377b3b..004bdc66e158 100644
--- a/drivers/pinctrl/actions/pinctrl-owl.c
+++ b/drivers/pinctrl/actions/pinctrl-owl.c
@@ -246,60 +246,6 @@ static int owl_pad_pinconf_reg(const struct owl_padinfo *info,
 	return 0;
 }
 
-static int owl_pad_pinconf_arg2val(const struct owl_padinfo *info,
-				unsigned int param,
-				u32 *arg)
-{
-	switch (param) {
-	case PIN_CONFIG_BIAS_BUS_HOLD:
-		*arg = OWL_PINCONF_PULL_HOLD;
-		break;
-	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
-		*arg = OWL_PINCONF_PULL_HIZ;
-		break;
-	case PIN_CONFIG_BIAS_PULL_DOWN:
-		*arg = OWL_PINCONF_PULL_DOWN;
-		break;
-	case PIN_CONFIG_BIAS_PULL_UP:
-		*arg = OWL_PINCONF_PULL_UP;
-		break;
-	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
-		*arg = (*arg >= 1 ? 1 : 0);
-		break;
-	default:
-		return -ENOTSUPP;
-	}
-
-	return 0;
-}
-
-static int owl_pad_pinconf_val2arg(const struct owl_padinfo *padinfo,
-				unsigned int param,
-				u32 *arg)
-{
-	switch (param) {
-	case PIN_CONFIG_BIAS_BUS_HOLD:
-		*arg = *arg == OWL_PINCONF_PULL_HOLD;
-		break;
-	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
-		*arg = *arg == OWL_PINCONF_PULL_HIZ;
-		break;
-	case PIN_CONFIG_BIAS_PULL_DOWN:
-		*arg = *arg == OWL_PINCONF_PULL_DOWN;
-		break;
-	case PIN_CONFIG_BIAS_PULL_UP:
-		*arg = *arg == OWL_PINCONF_PULL_UP;
-		break;
-	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
-		*arg = *arg == 1;
-		break;
-	default:
-		return -ENOTSUPP;
-	}
-
-	return 0;
-}
-
 static int owl_pin_config_get(struct pinctrl_dev *pctrldev,
 				unsigned int pin,
 				unsigned long *config)
@@ -318,7 +264,10 @@ static int owl_pin_config_get(struct pinctrl_dev *pctrldev,
 
 	arg = owl_read_field(pctrl, reg, bit, width);
 
-	ret = owl_pad_pinconf_val2arg(info, param, &arg);
+	if (!pctrl->soc->padctl_val2arg)
+		return -ENOTSUPP;
+
+	ret = pctrl->soc->padctl_val2arg(info, param, &arg);
 	if (ret)
 		return ret;
 
@@ -349,7 +298,10 @@ static int owl_pin_config_set(struct pinctrl_dev *pctrldev,
 		if (ret)
 			return ret;
 
-		ret = owl_pad_pinconf_arg2val(info, param, &arg);
+		if (!pctrl->soc->padctl_arg2val)
+			return -ENOTSUPP;
+
+		ret = pctrl->soc->padctl_arg2val(info, param, &arg);
 		if (ret)
 			return ret;
 
diff --git a/drivers/pinctrl/actions/pinctrl-owl.h b/drivers/pinctrl/actions/pinctrl-owl.h
index 31cc33d7c4a5..dae2e8363fd5 100644
--- a/drivers/pinctrl/actions/pinctrl-owl.h
+++ b/drivers/pinctrl/actions/pinctrl-owl.h
@@ -145,13 +145,6 @@
 		.shared_ctl_offset = _share,			\
 	}
 
-enum owl_pinconf_pull {
-	OWL_PINCONF_PULL_HIZ,
-	OWL_PINCONF_PULL_DOWN,
-	OWL_PINCONF_PULL_UP,
-	OWL_PINCONF_PULL_HOLD,
-};
-
 enum owl_pinconf_drv {
 	OWL_PINCONF_DRV_2MA,
 	OWL_PINCONF_DRV_4MA,
@@ -305,6 +298,12 @@ struct owl_pinctrl_soc_data {
 	unsigned int ngpios;
 	const struct owl_gpio_port *ports;
 	unsigned int nports;
+	int (*padctl_val2arg)(const struct owl_padinfo *padinfo,
+				unsigned int param,
+				u32 *arg);
+	int (*padctl_arg2val)(const struct owl_padinfo *info,
+				unsigned int param,
+				u32 *arg);
 };
 
 int owl_pinctrl_probe(struct platform_device *pdev,
diff --git a/drivers/pinctrl/actions/pinctrl-s900.c b/drivers/pinctrl/actions/pinctrl-s900.c
index 0597009d8369..2e19fecbe5e9 100644
--- a/drivers/pinctrl/actions/pinctrl-s900.c
+++ b/drivers/pinctrl/actions/pinctrl-s900.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include "pinctrl-owl.h"
 
 /* Pinctrl registers offset */
@@ -1717,6 +1718,67 @@ static const struct owl_gpio_port s900_gpio_ports[] = {
 	OWL_GPIO_PORT(F, 0x00F0, 8, 0x0, 0x4, 0x8, 0x460, 0x140, 0x144, 0x178, 0)
 };
 
+enum owl_pinconf_pull {
+	OWL_PINCONF_PULL_HIZ,
+	OWL_PINCONF_PULL_DOWN,
+	OWL_PINCONF_PULL_UP,
+	OWL_PINCONF_PULL_HOLD,
+};
+
+static int s900_pad_pinconf_arg2val(const struct owl_padinfo *info,
+				unsigned int param,
+				u32 *arg)
+{
+	switch (param) {
+	case PIN_CONFIG_BIAS_BUS_HOLD:
+		*arg = OWL_PINCONF_PULL_HOLD;
+		break;
+	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
+		*arg = OWL_PINCONF_PULL_HIZ;
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		*arg = OWL_PINCONF_PULL_DOWN;
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		*arg = OWL_PINCONF_PULL_UP;
+		break;
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		*arg = (*arg >= 1 ? 1 : 0);
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	return 0;
+}
+
+static int s900_pad_pinconf_val2arg(const struct owl_padinfo *padinfo,
+				unsigned int param,
+				u32 *arg)
+{
+	switch (param) {
+	case PIN_CONFIG_BIAS_BUS_HOLD:
+		*arg = *arg == OWL_PINCONF_PULL_HOLD;
+		break;
+	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
+		*arg = *arg == OWL_PINCONF_PULL_HIZ;
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		*arg = *arg == OWL_PINCONF_PULL_DOWN;
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		*arg = *arg == OWL_PINCONF_PULL_UP;
+		break;
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		*arg = *arg == 1;
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	return 0;
+}
+
 static struct owl_pinctrl_soc_data s900_pinctrl_data = {
 	.padinfo = s900_padinfo,
 	.pins = (const struct pinctrl_pin_desc *)s900_pads,
@@ -1727,7 +1789,9 @@ static struct owl_pinctrl_soc_data s900_pinctrl_data = {
 	.ngroups = ARRAY_SIZE(s900_groups),
 	.ngpios = NUM_GPIOS,
 	.ports = s900_gpio_ports,
-	.nports = ARRAY_SIZE(s900_gpio_ports)
+	.nports = ARRAY_SIZE(s900_gpio_ports),
+	.padctl_arg2val = s900_pad_pinconf_arg2val,
+	.padctl_val2arg = s900_pad_pinconf_val2arg,
 };
 
 static int s900_pinctrl_probe(struct platform_device *pdev)
-- 
2.18.0

