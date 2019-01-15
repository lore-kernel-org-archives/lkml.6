Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C92C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A331E2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QvxA6KP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfAOHxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 02:53:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36111 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbfAOHxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 02:53:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so930450pfc.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 23:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=N3BRL5c8XBWaHt94edkG7ztQOznUJvJUETVY/zaF1Hk=;
        b=QvxA6KP0VrWDNTFRdKBAUi/zKB8s2K2cvFYgQc396xIej/UqG3aiLPXhN/VAYPEfXa
         xlOy69j9Y/VtbtsDYhmTt4O74WhNV6i+JtDOSf+y+hFpyESy21MVa2QVEi4XhWh52uCn
         2bI36K5far3IFA/zcx/n/9esZ8W/K5k45U3MM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N3BRL5c8XBWaHt94edkG7ztQOznUJvJUETVY/zaF1Hk=;
        b=YxAsRV6WWSfQzrT3yAsXfuXJO2PkNUsUXXj8ryAO2rI7z3BDc06X9XyU7qW2qrSCvj
         R+so1Hb4georosB9g3FLxg6+Vn79UV/Lf6wMGThcTnQ60qFGMeqaQa0SGlIUgBxPU0NE
         2kWYtLX7TUqQB1wLGKYiVd0r/8Sc6Lq4YI07NgCfeA9QokdvMSLSEd4ZYYu3s0hYqsfa
         zvhb9ox+46B1ZxojICU1hzMhrLukN/Ue4GN5CDZZges5Orb7H2vsDNxPskSGWR3Hs/cG
         6vjfhPcCtRtlgMWPG6YLBfmG/bQNDBFmGBTeiHIPSRUvfWCdzmN8bqdffPaCs9EaEiBQ
         qnvA==
X-Gm-Message-State: AJcUukfunfZiAun6ztJKok3DIE1DkPWT771boDvOkMbfFg2CCND8BT82
        5uGo8J5Fxsg3RfaWSEH7LYekdw==
X-Google-Smtp-Source: ALg8bN4MJGXqQF4OJighKk/wed9kN1zTu9VJXTB8ZTq9alVh3G3fWi90qLnRqO2emhVZc3uVKVIu3A==
X-Received: by 2002:a63:4566:: with SMTP id u38mr2653482pgk.4.1547538818114;
        Mon, 14 Jan 2019 23:53:38 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id g3sm4340093pfe.37.2019.01.14.23.53.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jan 2019 23:53:37 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     baolin.wang@linaro.org, neo.hou@unisoc.com, broonie@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] gpio: sprd: Fix the incorrect data register
Date:   Tue, 15 Jan 2019 15:52:58 +0800
Message-Id: <732ea4f8ff1bf3ad28bda543ae8e1727c78f8b3b.1547538574.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neo Hou <neo.hou@unisoc.com>

Since differnt type EICs have its own data register to read, thus fix the
incorrect data register.

Signed-off-by: Neo Hou <neo.hou@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/gpio/gpio-eic-sprd.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index e0d6a0a..257df59 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -180,7 +180,18 @@ static void sprd_eic_free(struct gpio_chip *chip, unsigned int offset)
 
 static int sprd_eic_get(struct gpio_chip *chip, unsigned int offset)
 {
-	return sprd_eic_read(chip, offset, SPRD_EIC_DBNC_DATA);
+	struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
+
+	switch (sprd_eic->type) {
+	case SPRD_EIC_DEBOUNCE:
+		return sprd_eic_read(chip, offset, SPRD_EIC_DBNC_DATA);
+	case SPRD_EIC_ASYNC:
+		return sprd_eic_read(chip, offset, SPRD_EIC_ASYNC_DATA);
+	case SPRD_EIC_SYNC:
+		return sprd_eic_read(chip, offset, SPRD_EIC_SYNC_DATA);
+	default:
+		return -ENOTSUPP;
+	}
 }
 
 static int sprd_eic_direction_input(struct gpio_chip *chip, unsigned int offset)
-- 
1.7.9.5

