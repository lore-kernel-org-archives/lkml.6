Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0727FC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF453218E2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863999;
	bh=pP6hb9A13E/UpzViz3OCPKObvmNPMcAEWslKKvarim8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=UlIH8LaufNScjE9ORRX9lMpUtK2F+Px35pZN1QuL4FL6g5bbLWnxM+wlpxknGYgjF
	 IG3BnRQX5hKtXJv35jX50eaVGwyvwIfOgEZDFBbnNMp/XV2eJDfNqhhvzvzW6RDNOQ
	 53nnxfGLpyZ16RzfiyiQtwKfc3Aj93n3cHXpdn9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbeLZWj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:39:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:39994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728029AbeLZWj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:39:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADD812054F;
        Wed, 26 Dec 2018 22:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863997;
        bh=pP6hb9A13E/UpzViz3OCPKObvmNPMcAEWslKKvarim8=;
        h=From:To:Cc:Subject:Date:From;
        b=VV+YmzOf7j/RA7SE9/aEnyiPnzeWMf3v1ggHZ5nCB5A0e0VXQdDhrYqSSw1EDNs3y
         u/9K1BwbTWL0k9Y7swK7k4xGCig5yn8TYPHuANhgr0BeBW1Hgd6rG+h6VWomc/p0L6
         bp3bPbyQXwoGbME9bcQelvyQoocek9sK+tOkogV8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 01/59] pinctrl: meson: fix pull enable register calculation
Date:   Wed, 26 Dec 2018 17:37:41 -0500
Message-Id: <20181226223839.150262-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 614b1868a125a0ba24be08f3a7fa832ddcde6bca ]

We just changed the code so we apply bias disable on the correct
register but forgot to align the register calculation. The result
is that we apply the change on the correct register, but possibly
at the incorrect offset/bit

This went undetected because offsets tends to be the same between
REG_PULL and REG_PULLEN for a given pin the EE controller. This
is not true for the AO controller.

Fixes: e39f9dd8206a ("pinctrl: meson: fix pinconf bias disable")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/meson/pinctrl-meson.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 6c43322dbb97..2998941fdeca 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -272,7 +272,8 @@ static int meson_pinconf_set(struct pinctrl_dev *pcdev, unsigned int pin,
 		case PIN_CONFIG_BIAS_DISABLE:
 			dev_dbg(pc->dev, "pin %u: disable bias\n", pin);
 
-			meson_calc_reg_and_bit(bank, pin, REG_PULL, &reg, &bit);
+			meson_calc_reg_and_bit(bank, pin, REG_PULLEN, &reg,
+					       &bit);
 			ret = regmap_update_bits(pc->reg_pullen, reg,
 						 BIT(bit), 0);
 			if (ret)
-- 
2.19.1

