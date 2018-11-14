Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7446AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA862145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="HDJLzDm1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA862145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbeKOIzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:55:37 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38748 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbeKOIzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:55:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=fRiM6IOnBIQBZ23X06B7cGcwM+azYTA0HNgCC5CCPF8=; b=HDJLzDm12tvJ
        5qZfdVzzJUsUdguqxyGZUu/XyNo+InkXRIYx0SM/8KT4reky+J8l0jpmECMqoi6qxHiF4shbolW4c
        v+JjQxjLxenz7fkUKZBKbq0Q+TqsbhamoV8mosLSseWLJK1pEcZLkkeY4W0eaOqgt5i949N0sdazx
        Wxgow=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gN3Oq-0004ZH-1r; Wed, 14 Nov 2018 22:12:40 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 2F1A9440078; Wed, 14 Nov 2018 22:12:34 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Mark Brown <broonie@kernel.org>, openbmc@lists.ozlabs.org,
        linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: npcm: fix u32 csgpio being checked for less than zero" to the spi tree
In-Reply-To:  <20181114214246.15591-1-colin.king@canonical.com>
Message-Id: <20181114221234.2F1A9440078@finisterre.ee.mobilebroadband>
Date:   Wed, 14 Nov 2018 22:12:34 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: npcm: fix u32 csgpio being checked for less than zero

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From 757ec116c9bce4278fa4423039736c832cc63b6f Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 14 Nov 2018 21:42:46 +0000
Subject: [PATCH] spi: npcm: fix u32 csgpio being checked for less than zero

The u32 variable csgpio is being checked for an error return
from the call to of_get_named_gpio, however, since this is unsigned
this comparison will always be false. Fix this by making csgpio an
int and fix up the %u format specifiers to %d accordingly.

Detected by CoverityScan, CID#1475476 ("Unsigned compared against 0")

Fixes: 2a22f1b30cee ("spi: npcm: add NPCM PSPI controller driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-npcm-pspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index 51777515c83f..6dae91091143 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -329,7 +329,7 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 	unsigned long clk_hz;
 	struct device_node *np = pdev->dev.of_node;
 	int num_cs, i;
-	u32 csgpio;
+	int csgpio;
 	int irq;
 	int ret;
 
@@ -417,12 +417,12 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "failed to get csgpio#%u\n", i);
 			goto out_disable_clk;
 		}
-		dev_dbg(&pdev->dev, "csgpio#%u = %u\n", i, csgpio);
+		dev_dbg(&pdev->dev, "csgpio#%u = %d\n", i, csgpio);
 		ret = devm_gpio_request_one(&pdev->dev, csgpio,
 					    GPIOF_OUT_INIT_HIGH, DRIVER_NAME);
 		if (ret < 0) {
 			dev_err(&pdev->dev,
-				"failed to configure csgpio#%u %u\n"
+				"failed to configure csgpio#%u %d\n"
 				, i, csgpio);
 			goto out_disable_clk;
 		}
-- 
2.19.1

