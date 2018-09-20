Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F919ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007AF21533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="YT6ErJQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007AF21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733131AbeITXVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:21:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51880 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbeITXVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=+DJr5pbL2nKPALEQuizWxJ/Chx9mo3cHZB/Mo6nqsxo=; b=YT6ErJQuUbpa
        G8dWao/9+TaGdSWQUmpscGaczXRQa9mo4/P11r8bUs4h8gQUeW4r5WFMTmunvpKqXuODZHoi5qLcg
        WDazZepSJ9lKGm0VjvgPYHZrQmvdd7g1K4ZNvH8CzePvg1VtuMhQ+9w7dmH8Zo+y5w4ei+fnn170M
        oXsq0=;
Received: from [209.121.128.187] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g32sM-0007Ef-RR; Thu, 20 Sep 2018 17:36:27 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 9C29D440079; Thu, 20 Sep 2018 18:36:24 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: fix crash caused by null driver data" to the regulator tree
In-Reply-To: 
Message-Id: <20180920173624.9C29D440079@finisterre.ee.mobilebroadband>
Date:   Thu, 20 Sep 2018 18:36:24 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: fix crash caused by null driver data

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

From fb6de923ca3358a91525552b4907d4cb38730bdd Mon Sep 17 00:00:00 2001
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 19 Sep 2018 15:30:51 -0600
Subject: [PATCH] regulator: fix crash caused by null driver data

dev_set_drvdata() needs to be called before device_register()
exposes device to userspace. Otherwise kernel crashes after it
gets null pointer from dev_get_drvdata() when userspace tries
to access sysfs entries.

[Removed backtrace for length -- broonie]

Signed-off-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 90215f57270f..9577d8941846 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4395,13 +4395,13 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	    !rdev->desc->fixed_uV)
 		rdev->is_switch = true;
 
+	dev_set_drvdata(&rdev->dev, rdev);
 	ret = device_register(&rdev->dev);
 	if (ret != 0) {
 		put_device(&rdev->dev);
 		goto unset_supplies;
 	}
 
-	dev_set_drvdata(&rdev->dev, rdev);
 	rdev_init_debugfs(rdev);
 
 	/* try to resolve regulators supply since a new one was registered */
-- 
2.19.0

