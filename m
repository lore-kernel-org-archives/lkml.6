Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3194FC64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3192146F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FeW6gnbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3192146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbeLBDGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:06:20 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45469 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbeLBDGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:06:19 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so7617268ljd.12
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 07:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Lls7K5eWZynQmqU5NrZXBxowzW5loY4n6CUGHliIq8=;
        b=FeW6gnbRXbyaMhFsZRlumaUdm7FLVYSMd/t1qOlZIaTIy/2g1u5mGlgMnAdzWfabOY
         GIiDVg3frCCe80lRDrECMG3kgcvqoxIaMqax9RcJKTq2EOKR5uYt1zUWtUkhNcGmTvb0
         XpHGcT7rsJo0bbfB0bQnOJLWQFY7FCGjH3hd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Lls7K5eWZynQmqU5NrZXBxowzW5loY4n6CUGHliIq8=;
        b=FDyXupEqNZsFQ0Hi+6lqdqZ48iFhTlCkZDyX0WDaibR3c3Nfq6XX9CN6Q4eDHIXJAZ
         XR8O4wX6DmC0KTM/sLfBtQODFWPUu29j79IuvVVqZa9LAPN6B7U4nIJ2IlZ6F7a/3gip
         ecns/Dh3fK5h9RIo4vnhTlnmNh+LMJyQO/1qV/8Ee3t4sBI12xXdcBcQNczeYjH3Zp2f
         OhzsyDZFU7Tx8OvlxIORhgQYHZ6MO8yEnJEoQ+MUfi8jfun6ktcKRaKazWTymXXP8cJe
         5SLr06ZVT1KcrHyhtH+j/M+a34/krCRjqQzkCdE5fixsrbbU+v26HJBtehAl4ToOXBDY
         uQOA==
X-Gm-Message-State: AA+aEWa4kwKftchjCiDUnUZdUi8YrNRqfEGeqMr66Pa4fpIIjKGEy2g5
        iNuhZztiXbXSbRaGIWBklmEsNKGdkID2mw==
X-Google-Smtp-Source: AFSGD/VFdl1nM26IXZiKFMIWpcmjPwFPcIo4el0RR9OZhW04EEvWqw/MKw3RER78daX5hsySUadcJQ==
X-Received: by 2002:a2e:8546:: with SMTP id u6-v6mr6163700ljj.95.1543679609033;
        Sat, 01 Dec 2018 07:53:29 -0800 (PST)
Received: from localhost.localdomain (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id 13-v6sm1365426ljj.49.2018.12.01.07.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 07:53:28 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 13/13 v2] regulator: s2mps11: Hand over GPIO to regulator core
Date:   Sat,  1 Dec 2018 16:41:51 +0100
Message-Id: <20181201154151.14890-14-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181201154151.14890-1-linus.walleij@linaro.org>
References: <20181201154151.14890-1-linus.walleij@linaro.org>
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
2.19.1

