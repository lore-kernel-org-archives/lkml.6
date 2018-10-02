Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE97C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C6720666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ohGOHcXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C6720666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbeJBVm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:42:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42128 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbeJBVm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Ku114yTtpeDG3vo40RRxUMchh2h2CK2DZsfiQZ0po9E=; b=ohGOHcXhouQ7
        EGdDEjtlMe5pEdlPuyEvWcHeyVgl2Z6001aYnmQrnAwjyQd+rQyrrS8biuqkZJJJuGAcirj0BeYwS
        qKUnF6plW6ednleEed3Y93U2fWayrhxsJBmzWyUlwKcf9VMVDpNeyh0JWohM85VGzd7BQf7n7JtqA
        uov5g=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g7M8d-00022p-Kk; Tue, 02 Oct 2018 14:59:03 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5DA961121A41; Tue,  2 Oct 2018 15:59:03 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: fixed: Default enable high on DT regulators" to the regulator tree
In-Reply-To: 
Message-Id: <20181002145903.5DA961121A41@debutante.sirena.org.uk>
Date:   Tue,  2 Oct 2018 15:59:03 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: fixed: Default enable high on DT regulators

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 28be5f15df2ee6882b0a122693159c96a28203c7 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 1 Oct 2018 22:43:46 +0200
Subject: [PATCH] regulator: fixed: Default enable high on DT regulators

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
---
 drivers/regulator/fixed.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 1142f195529b..7d639ad953b6 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -79,9 +79,14 @@ of_get_fixed_voltage_config(struct device *dev,
 
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
2.19.0.rc2

