Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBB1ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2020720664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qegaXVJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2020720664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732188AbeKAIQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:16:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730815AbeKAIL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:11:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A63E420866;
        Wed, 31 Oct 2018 23:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027507;
        bh=Cju/D3RxbTH6ZqqwWGQO2KVmVRK5Bbg6zlXLa/iyMQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qegaXVJjoUx/Hih1eaKWMq4HmxOHc6wZ0fnXktxnOcGvqQQOLVmbJjB46KhB3j9zt
         /arFLTESH4ePWD91IRzhFNXf++AK5bs38kEDTUjEtKORoE+y4IeDyG7qRkDd71ejBW
         w/Um/9CzTkHSDFLakYdo9Yd+yHvXudD9ZDsh91/8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 10/32] regulator: fixed: Default enable high on DT regulators
Date:   Wed, 31 Oct 2018 19:11:15 -0400
Message-Id: <20181031231137.29429-10-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231137.29429-1-sashal@kernel.org>
References: <20181031231137.29429-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 28be5f15df2ee6882b0a122693159c96a28203c7 ]

commit efdfeb079cc3
("regulator: fixed: Convert to use GPIO descriptor only")
switched to use gpiod_get() to look up the regulator from the
gpiolib core whether that is device tree or boardfile.

This meant that we activate the code in
a603a2b8d86e ("gpio: of: Add special quirk to parse regulator flags")
which means the descriptors coming from the device tree already
have the right inversion and open drain semantics set up from
the gpiolib core.

As the fixed regulator was inspected again we got the
inverted inversion and things broke.

Fix it by ignoring the config in the device tree for now: the
later patches in the series will push all inversion handling
over to the gpiolib core and set it up properly in the
boardfiles for legacy devices, but I did not finish that
for this kernel cycle.

Fixes: commit efdfeb079cc3 ("regulator: fixed: Convert to use GPIO descriptor only")
Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
Reported-by: Fabio Estevam <festevam@gmail.com>
Reported-by: John Stultz <john.stultz@linaro.org>
Reported-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/fixed.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index ff62d69ba0be..24ad5e6832df 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -94,9 +94,14 @@ of_get_fixed_voltage_config(struct device *dev,
 
 	of_property_read_u32(np, "startup-delay-us", &config->startup_delay);
 
-	config->enable_high = of_property_read_bool(np, "enable-active-high");
-	config->gpio_is_open_drain = of_property_read_bool(np,
-							   "gpio-open-drain");
+	/*
+	 * FIXME: we pulled active low/high and open drain handling into
+	 * gpiolib so it will be handled there. Delete this in the second
+	 * step when we also remove the custom inversion handling for all
+	 * legacy boardfiles.
+	 */
+	config->enable_high = 1;
+	config->gpio_is_open_drain = 0;
 
 	if (of_find_property(np, "vin-supply", NULL))
 		config->input_supply = "vin";
-- 
2.17.1

