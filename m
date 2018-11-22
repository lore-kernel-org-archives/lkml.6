Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445D5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA16A20838
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5vQiEqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA16A20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406741AbeKWGdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:33:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:60928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389357AbeKWGdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:33:37 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F58620645;
        Thu, 22 Nov 2018 19:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542916366;
        bh=IkFzYftPQ5tYhMLnR6c4WhjzNhqWDlZCM7SgKeBafnc=;
        h=From:To:Cc:Subject:Date:From;
        b=E5vQiEqZPcrBaM+2Ie1Ygwwqf2jBIj4X3licXhVZyug0wd60evxWOYL813gMBClAc
         nqHAOQhCeYnfR4NUdL0W56cjJkBuYfpGhbhrNt5XpEdHCUhQFZeFhHVmmGAK+nXFS3
         P5t67MYSIBuUFUwOnOTSsQXL275QZEjt3ebHd3DA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 01/36] pinctrl: meson: fix pinconf bias disable
Date:   Thu, 22 Nov 2018 14:52:05 -0500
Message-Id: <20181122195240.13123-1-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit e39f9dd8206ad66992ac0e6218ef1ba746f2cce9 ]

If a bias is enabled on a pin of an Amlogic SoC, calling .pin_config_set()
with PIN_CONFIG_BIAS_DISABLE will not disable the bias. Instead it will
force a pull-down bias on the pin.

Instead of the pull type register bank, the driver should access the pull
enable register bank.

Fixes: 6ac730951104 ("pinctrl: add driver for Amlogic Meson SoCs")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/meson/pinctrl-meson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 29a458da78db..4f3ab18636a3 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -192,7 +192,7 @@ static int meson_pinconf_set(struct pinctrl_dev *pcdev, unsigned int pin,
 			dev_dbg(pc->dev, "pin %u: disable bias\n", pin);
 
 			meson_calc_reg_and_bit(bank, pin, REG_PULL, &reg, &bit);
-			ret = regmap_update_bits(pc->reg_pull, reg,
+			ret = regmap_update_bits(pc->reg_pullen, reg,
 						 BIT(bit), 0);
 			if (ret)
 				return ret;
-- 
2.17.1

