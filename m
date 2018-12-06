Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B704C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E0120892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WyzqRLE0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E0120892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbeLFMoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:44:15 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44524 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729596AbeLFMoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:44:10 -0500
Received: by mail-lf1-f67.google.com with SMTP id z13so218800lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pL3UIbDRXGJXlxTb/OqBWSX/UpAtCHnsGG4EwMeQdvI=;
        b=WyzqRLE0v9z8tUxdFVxS+i+eOALl7dl3FF9/qTkz1/Yi6jbfr2nSgpSnhDu/CFzljn
         JyrIpgpdfRVV8ubR7yEOB6LxStlCgsN2B9YZ45brsond4LJcNuz+x8rwgs1k5ccGh+tB
         2UcaP8TZJKLDfZ883kJRQDslfQ90JMozG5eC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pL3UIbDRXGJXlxTb/OqBWSX/UpAtCHnsGG4EwMeQdvI=;
        b=FTo1SbYhZ+f/NNSVf1TDrYPkZ4VRIuzmB17xKynqG1xGOp7kAt5AWBT088zfZJBaw0
         I7056fBZTCFy4yscfqDlidGYQzDTRFl4MeNdTD/OaC7REleP9DK1xv2/YrDvRxH3opmU
         bzwt4pr83b3vM679pmNw8xYFF4CjyffidJptv9N6NTjEMr46SQ7KIc/UfB0yEKrMpZeN
         uDesNxzqQNWdLrjtwZm8BD6LxLsMFx+JvlUYZ2txJIQMbVDdmQsqZP5V9iTPGE6PKCx/
         h/uD5VxfSIhoCsHwSS1IKbWBytMlBca2hjGzf9+3QiQLmghg9Uovf/XIEfC5pmTfWybb
         PaaA==
X-Gm-Message-State: AA+aEWaOnp4DQp78iOnf6kU264V3qKvZS337xKD8kj5cvBPR9rACebl5
        8PosgHB8C/ChgLkCwgbJHxNdzLu0sidA8g==
X-Google-Smtp-Source: AFSGD/WWBOPDl3bvZAwcybwKjrUDXR2aOCl6R3ShZycBiPH0fIBgV3zU5Cnqjg+SKDWW4ct2uVdcyw==
X-Received: by 2002:a19:f813:: with SMTP id a19mr16137149lff.67.1544100248276;
        Thu, 06 Dec 2018 04:44:08 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id j25-v6sm44071lji.77.2018.12.06.04.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 04:44:07 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 04/15 v4] regulator: lp8788-ldo: Let core handle GPIO descriptor
Date:   Thu,  6 Dec 2018 13:43:40 +0100
Message-Id: <20181206124351.10155-5-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206124351.10155-1-linus.walleij@linaro.org>
References: <20181206124351.10155-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the gpiod_get() rather than the devm_* version so that the
regulator core can handle the lifecycle of these descriptors.

Fixes: 2468f0d51548 ("regulator: lp8788-ldo: Pass descriptor instead of GPIO number")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Resending.
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Drop the gpiod_put() on the errorpath after devm_regulator_register()
  as this will be handled by the regulator core.
- Put a comment in the code so maintainers knows not to
  use managed resources (devm*)
---
 drivers/regulator/lp8788-ldo.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/lp8788-ldo.c b/drivers/regulator/lp8788-ldo.c
index 553b4790050f..2ee22e7ea675 100644
--- a/drivers/regulator/lp8788-ldo.c
+++ b/drivers/regulator/lp8788-ldo.c
@@ -501,8 +501,12 @@ static int lp8788_config_ldo_enable_mode(struct platform_device *pdev,
 		return 0;
 	}
 
-	/* FIXME: check default mode for GPIO here: high or low? */
-	ldo->ena_gpiod = devm_gpiod_get_index_optional(&pdev->dev,
+	/*
+	 * Do not use devm* here: the regulator core takes over the
+	 * lifecycle management of the GPIO descriptor.
+	 * FIXME: check default mode for GPIO here: high or low?
+	 */
+	ldo->ena_gpiod = gpiod_get_index_optional(&pdev->dev,
 					       "enable",
 					       enable_id,
 					       GPIOD_OUT_HIGH |
-- 
2.19.2

