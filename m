Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E86C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D74213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4VnAA4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D74213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388891AbeK3BgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:36:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:38584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388288AbeK3BgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:36:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDBF0213A2;
        Thu, 29 Nov 2018 14:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501844;
        bh=WGOdbdODmIqUefV1fob7eKqZrMot0i4SRBn4v41BZ6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r4VnAA4YRPnIr5FC4N3xjzvIIBbXFEakDypC3h0pEwTVo9xG02n36A9QGSdwy/fgc
         7u+Cuw+UY9UTNrRiUcZn7EfJbyvC0Xo/dhA5x+nx7GuK8+LSkgOt1+pFturrnwkt6S
         V7P16lbzmVSGQtpF59EVCKJXFEI6mhveR78bDWPU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 065/110] pinctrl: meson: fix pinconf bias disable
Date:   Thu, 29 Nov 2018 15:12:36 +0100
Message-Id: <20181129135923.881035539@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



