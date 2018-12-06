Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0E9C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448F820892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ACbcqWTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448F820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbeLFMoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:44:55 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41162 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbeLFMo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:44:27 -0500
Received: by mail-lf1-f65.google.com with SMTP id c16so231548lfj.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyagLHp/sFfdrPUwP8QrUjF5aczl7hYJlH6LPWav89U=;
        b=ACbcqWTZu4q1jZsuA2mpyfmQGyAZoHlMQQIMiFP7co3YT9RQXoeUfxzdeEZ33JThn1
         p4NmIPn1kdMpUX68Qdxj6ZWsm/sbdMMDY44qUrU30Erz3WqktKdt/RXJvd2D95hWurjb
         t0PZwrZY24g32YAmjf/Ox/kHurhjEfz/zvp0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyagLHp/sFfdrPUwP8QrUjF5aczl7hYJlH6LPWav89U=;
        b=LYIqdPufLxzlLEpkvuWGcBjqegwSMF/tauDHGCyEX2qvG0E9erqIemYEVmPAPdmeCj
         9kra3DuwdplFt9DvRnqduE8DwvpxnbJ1d9tsiPLDkFtdq3Tu5XsZMrFtAnrJEdPJBlia
         Ai7+R1RotOIzWHUA4CaFE2C04AiXd0HKY+OCCkZg0apQmpXgqiDNNNSbZrqGb1Z17ZT2
         xyfFvdBpGeOwyUyqc9Rq0i6jIuzK19QmTEofQCGq+hCVeUWSjDsLqRw7eyRAOt76GcZT
         gu2zNmORo5CF2kCi7hhI9LBS+LX7/SB/ORukZMHIK2THZkyn89Z2LQ4MhNScPw/XN/hl
         20qw==
X-Gm-Message-State: AA+aEWZ/m3jCjZ8x5w9gGiLacGI6Pvk4YiSxFHpkGRScZfOKHQQ+45Jr
        PPVOgl3KdraYyj+jtDdOGvCkUQ==
X-Google-Smtp-Source: AFSGD/Vdpxb24NQaAohDKxZ7N5SthD4hxz8seZVj2ToA494FiygREJVc/q65PGtT1PeIJeQ63dHykQ==
X-Received: by 2002:a19:c014:: with SMTP id q20mr15686432lff.16.1544100265323;
        Thu, 06 Dec 2018 04:44:25 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id j25-v6sm44071lji.77.2018.12.06.04.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 04:44:24 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 12/15 v4] regulator: da9211: Hand over GPIO to regulator core
Date:   Thu,  6 Dec 2018 13:43:48 +0100
Message-Id: <20181206124351.10155-13-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206124351.10155-1-linus.walleij@linaro.org>
References: <20181206124351.10155-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO descriptors used by the DA9211 driver are retrieved
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
 drivers/regulator/da9211-regulator.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index 8f68c7a05d27..109ee12d4362 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -389,6 +389,12 @@ static int da9211_regulator_init(struct da9211 *chip)
 		else
 			config.ena_gpiod = NULL;
 
+		/*
+		 * Hand the GPIO descriptor management over to the regulator
+		 * core, remove it from GPIO devres management.
+		 */
+		if (config.ena_gpiod)
+			devm_gpiod_unhinge(chip->dev, config.ena_gpiod);
 		chip->rdev[i] = devm_regulator_register(chip->dev,
 			&da9211_regulators[i], &config);
 		if (IS_ERR(chip->rdev[i])) {
-- 
2.19.2

