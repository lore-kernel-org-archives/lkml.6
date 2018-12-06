Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBDCC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E019020892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UwaP5cZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E019020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbeLFMof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:44:35 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43416 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729369AbeLFMob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:44:31 -0500
Received: by mail-lj1-f194.google.com with SMTP id 83-v6so258543ljf.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IltXzK2ZK9ZHKfiax7WiboCIbWrRkEm6SH9GClgJw54=;
        b=UwaP5cZ669Dbom7ZVrBTTqZdxfNr5vdfG0h8GBbULJ0pwa9g2JVOAOFClMYPId9u3N
         xfD0mt3KE+HQn11PRhKXdbO+54gkHXSFuWlAAWe/jfSTIx1pL6I7hi3yA3fJw9HN55kJ
         1nqFC4yeiZ2xlL3n4v6ZVsmWwb08WEOIIw6ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IltXzK2ZK9ZHKfiax7WiboCIbWrRkEm6SH9GClgJw54=;
        b=DRGFqDFOwcrltAhYXjoTcZa6xsUaeAprnDOIWBGncy9NnAdrpu4X1TOt3cPJPIm38E
         zZxDSF3X6jW11l7geoIvpNg98lPLlSQFnSs3lPUZeQLOkNyvTyKVVIc0qDB53hYa1B5Y
         v2LjugasHxmpGxs+C0Y0Vbsyy6J8J2CKQWhF+r5Xi2CNRx40ZDAKr1sj7xp1vKxLNJou
         vKWS/j+vH6BZXTWMLl9Ty0Mr65+sIPOwIeA4cDl2h+GiYl+C8OiGpUsftajbukWiZZmv
         jnbQlUeE7v38QDzjWnoaI1tRTuwM75BznOjOA+8UqK8JPlq77vVpiLxvslMVOTqcD9SX
         ax4A==
X-Gm-Message-State: AA+aEWZQq1vGZZoPt0F3g7wps/VoOFvb0gcpyRP9b59dJvQy+3VFlguQ
        oTJ8/Yv8KOZh0THmBYP2t6rchA==
X-Google-Smtp-Source: AFSGD/UwfRxHggfiqfjcrxuoA3rl4cKQU5o/uWlPDdYntBmx2PSZbljnYpI75ue+/J87IEbiwnz7ug==
X-Received: by 2002:a2e:4503:: with SMTP id s3-v6mr18556920lja.44.1544100269257;
        Thu, 06 Dec 2018 04:44:29 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id j25-v6sm44071lji.77.2018.12.06.04.44.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 04:44:28 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 14/15 v4] regulator: tps65090: Hand over GPIO to regulator core
Date:   Thu,  6 Dec 2018 13:43:50 +0100
Message-Id: <20181206124351.10155-15-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206124351.10155-1-linus.walleij@linaro.org>
References: <20181206124351.10155-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO descriptors used by the TPS65090 driver are retrieved
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
 drivers/regulator/tps65090-regulator.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/tps65090-regulator.c b/drivers/regulator/tps65090-regulator.c
index db714d5edafc..0614551796a1 100644
--- a/drivers/regulator/tps65090-regulator.c
+++ b/drivers/regulator/tps65090-regulator.c
@@ -480,6 +480,12 @@ static int tps65090_regulator_probe(struct platform_device *pdev)
 		else
 			config.of_node = NULL;
 
+		/*
+		 * Hand the GPIO descriptor management over to the regulator
+		 * core, remove it from devres management.
+		 */
+		if (config.ena_gpiod)
+			devm_gpiod_unhinge(&pdev->dev, config.ena_gpiod);
 		rdev = devm_regulator_register(&pdev->dev, ri->desc, &config);
 		if (IS_ERR(rdev)) {
 			dev_err(&pdev->dev, "failed to register regulator %s\n",
-- 
2.19.2

