Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DC0C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290B7205C9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549124324;
	bh=shzg39CZU4jnforxg8SFLQxTC4AB0dpy1Lr2gsuDTfg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=hSpEE9fjvLyvOa2ofIZpg8PM66mfG6QCy1LjepZWtYqH7rgw1EzFQwz7juJYJF4PE
	 MTOCMD+YXap4n2qWtvMxiGteePEJfZaM3sFi36TcSRBsKjZTgPSDNkMUbwfb7cE5ul
	 4AWpcVzOjW/DnVnflCFfMP9u/7qjZmDBDoQPhPPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfBBQSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 11:18:42 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50656 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbfBBQSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 11:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=M+588QZl9gYlBbB3hP8aU6s0YSltnPXtHGZxTHdQ3zU=; b=tb8zMhAn9zVJ
        1ZvArm7JpgPfke8vrIUJrYOKDf6781mgvexBHYeEgJ7ageP7U6iB+imUnndHWa9jbgWvccJvR05oq
        v6tTJIcWiS0wQmUHi1yx4Id+CA55I97ud/779TSb4yLP0aSqwj4aewI8PU9SzlDvgrZGNrwgKZ+9s
        y9a8A=;
Received: from [151.216.140.106] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gpy03-0007dj-Vq; Sat, 02 Feb 2019 16:18:36 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id B2A7E440082; Sat,  2 Feb 2019 16:18:35 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: uniphier: Fix probe error handling" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190202161835.B2A7E440082@finisterre.ee.mobilebroadband>
Date:   Sat,  2 Feb 2019 16:18:35 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: uniphier: Fix probe error handling

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

From 33cd870c4bf148163e8b7c6e3bac2a44658a04e4 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 30 Jan 2019 15:11:09 +0800
Subject: [PATCH] regulator: uniphier: Fix probe error handling

Ensure unwind all resources if probe fails.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/uniphier-regulator.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/uniphier-regulator.c b/drivers/regulator/uniphier-regulator.c
index abf22acbd13e..6ba0ae405f2b 100644
--- a/drivers/regulator/uniphier-regulator.c
+++ b/drivers/regulator/uniphier-regulator.c
@@ -87,8 +87,10 @@ static int uniphier_regulator_probe(struct platform_device *pdev)
 	}
 
 	regmap = devm_regmap_init_mmio(dev, base, priv->data->regconf);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		goto out_rst_assert;
+	}
 
 	config.dev = dev;
 	config.driver_data = priv;
-- 
2.20.1

