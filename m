Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AD8C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8B5208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ktqeeb5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8B5208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbeLFMok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:44:40 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43421 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729778AbeLFMod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:44:33 -0500
Received: by mail-lj1-f195.google.com with SMTP id 83-v6so258638ljf.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oKAz9vRWrhcJiPEjNMOm6R3Q3uTXzg6siwroEfHHagQ=;
        b=Ktqeeb5ahv6w7WsxGlX9ficcZonMkHkUSX3y6h8JQbWBgbxCEyoUWhzMQnSfcnWdHg
         clj0NZdLA2ufjwYQXwVIytvZdSs1peFUgOw5MCUw0mRGUPfuc6cdlQ0ev+kcGKcD7t9z
         Q85XnfFi/KdI5kYfk+cxJa7Mv3p4rkk/63eIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oKAz9vRWrhcJiPEjNMOm6R3Q3uTXzg6siwroEfHHagQ=;
        b=EAdaWdhDMou2E5oPxNZkjuOnIzul4vE22XM5dJlSm+GP9IqV9nP8fV4Xz1kD2aPzd4
         Eg7v9FH/tUkUq2JlcYDNTLvpoVK2fT0aQK7V4q0yiX04OZVbv3+bhUrKWZobjaS88f3G
         bZvlesyqpJ2zT7UIdOxTYfISyCD1pf0PQwLcRoLnQJ7fKDURL7ZZ0mPAyoP0MUEQUDp5
         2qXD9ccBzq5MwcxE6c640hoqDslUC6lQctGOwdCPaVMYXoop99X1PhcEzCh9ejpLn4gW
         I1G443Vv5U+14j+SzzAhpFBs3leWk3WIr4lWqSM2mqH25k0rgFL8eUdUYAOA/tPScNgi
         p+4g==
X-Gm-Message-State: AA+aEWZ4Q5gxF4vuv+TUhntL+VEJhN6gWtwmPfo5Ls8ztwMzi84qV/TE
        1cj9g0eus2vfamJV/pJTIZ0+7w==
X-Google-Smtp-Source: AFSGD/UY0+E5Hz2raDrD6O/oHc52AwHqYoLbzeiKSClSsI7RtkUEoGS1wwkrJs6Z8myE3Cg5NG22yQ==
X-Received: by 2002:a2e:55d3:: with SMTP id g80-v6mr20109433lje.78.1544100271217;
        Thu, 06 Dec 2018 04:44:31 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id j25-v6sm44071lji.77.2018.12.06.04.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 04:44:30 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 15/15 v4] regulator: s2mps11: Hand over GPIO to regulator core
Date:   Thu,  6 Dec 2018 13:43:51 +0100
Message-Id: <20181206124351.10155-16-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206124351.10155-1-linus.walleij@linaro.org>
References: <20181206124351.10155-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO descriptors used by the S2MPS11 driver are retrieved
during probe() and it is really helpful to have those under
devres management because of all the errorpaths in the
intialization.

Using the new dev_gpiod_unhinge() call we can remove the
devres management of the descriptor right before handing
it over to the regulators core.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Resending.
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- New patch handling this drivers GPIO descriptors properly.
---
 drivers/regulator/s2mps11.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index 63e66f485cc0..ee4a23ab0663 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -1178,7 +1178,12 @@ static int s2mps11_pmic_probe(struct platform_device *pdev)
 			config.of_node = rdata[i].of_node;
 		}
 		config.ena_gpiod = s2mps11->ext_control_gpiod[i];
-
+		/*
+		 * Hand the GPIO descriptor management over to the regulator
+		 * core, remove it from devres management.
+		 */
+		if (config.ena_gpiod)
+			devm_gpiod_unhinge(&pdev->dev, config.ena_gpiod);
 		regulator = devm_regulator_register(&pdev->dev,
 						&regulators[i], &config);
 		if (IS_ERR(regulator)) {
-- 
2.19.2

