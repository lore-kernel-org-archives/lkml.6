Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF86C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F3E205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9WNOSG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F3E205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbeK1Vp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:45:28 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45593 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbeK1Vp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:45:27 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so18953315lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 02:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hQwrbOX6jWVhS2xXND6mp6kD61Itg1CrwK7UbFAIOVk=;
        b=S9WNOSG03IE7X5xnnj7NI1JR1pvp3focVQkkb+B92qtxxF46HE4HtXk666CL9U6FV4
         l/knRppcviKlsAIuZP938PhblJ0MYGUBJorly1o1esaVcTu0P9xhphSBJC72KMQg/NwA
         9Ejf0J0UEVydxS2VUeyIKW0SonhMCFurYqLFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hQwrbOX6jWVhS2xXND6mp6kD61Itg1CrwK7UbFAIOVk=;
        b=MLl6Y6KkeAityWtBkfmGAJ1nTDiyVtDaFbCjNapywnNBvbuRl0QzlAHUmKudlD8cUc
         /vn2+HSAkZQxPcEKKwUfrN1niEX2fymPynDI1c16tv087/1DNPSsVN/pj/bxxZOS/oJm
         jFE6T4E9/QRWFa8FwWyZnTfxsOZD66zftOqNlip+LU4DvGaLo+Iw26jhqxZWi6uziluX
         Te5YYvwOiMnS+TeBNWE87BE28WKiWHhb7ezAnjECO6j6NB8UlnCxKjCW86VwErCBUpyh
         aBC17dX2h0T4DaZxL0k6QIbNWZ5SCLrHBWsCPzh4M+5F5Smf0ToDF2Rr3HGPYHpETZnw
         xNGw==
X-Gm-Message-State: AA+aEWYOC1pVFAEsFzlzCMxD2RwTyMP0GR9uF7SbYwXe8rUshSqHh2A5
        2JBevNZzsKC96jxyeADbrPD+QA==
X-Google-Smtp-Source: AFSGD/W1q7QC3xwZzMaldRO1ld+uaks+WFGxMyIedleT3uT7KBUj1DBViJQ9BrohU3HZdWVhnbqLUA==
X-Received: by 2002:a19:c115:: with SMTP id r21mr2302710lff.144.1543401852268;
        Wed, 28 Nov 2018 02:44:12 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id c20sm1095101lfj.67.2018.11.28.02.44.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 02:44:11 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 08/10] regulator: max77686: Let core handle GPIO descriptor
Date:   Wed, 28 Nov 2018 11:43:48 +0100
Message-Id: <20181128104350.31902-9-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181128104350.31902-1-linus.walleij@linaro.org>
References: <20181128104350.31902-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the gpiod_get_from_of_node() rather than the devm_*
version so that the regulator core can handle the lifecycle
of these descriptors.

Fixes: 96392c3d8ca4 ("regulator: max77686: Pass descriptor instead of GPIO number")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/max77686-regulator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/regulator/max77686-regulator.c b/drivers/regulator/max77686-regulator.c
index f5cee1775905..236cd42002f0 100644
--- a/drivers/regulator/max77686-regulator.c
+++ b/drivers/regulator/max77686-regulator.c
@@ -255,8 +255,7 @@ static int max77686_of_parse_cb(struct device_node *np,
 	case MAX77686_BUCK8:
 	case MAX77686_BUCK9:
 	case MAX77686_LDO20 ... MAX77686_LDO22:
-		config->ena_gpiod = devm_gpiod_get_from_of_node(max77686->dev,
-				np,
+		config->ena_gpiod = gpiod_get_from_of_node(np,
 				"maxim,ena",
 				0,
 				GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
-- 
2.19.1

