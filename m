Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9D9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269D320840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ThhjCLKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfAPFGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 00:06:54 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37179 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfAPFGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 00:06:53 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so2443811pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 21:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UjqyiLdS2ob09b2Z4ip9zepqiphUB4pWHb9KKE6913I=;
        b=ThhjCLKbGB0aSJW/dfx7GDmmMjs+HqUjfVC9s3V3R52RXV40o/ovlKQmtYLZ/y9IcU
         feWB6vn2ww4djoUEwWaCXSIroLwcN6aMlTqkMjTMuf7mTLAjUoH/JP4vwdzSRZI+em75
         Hw2WJeB8ucObmZaNuqOxfn7+J9v/MyYVrVTQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UjqyiLdS2ob09b2Z4ip9zepqiphUB4pWHb9KKE6913I=;
        b=ZjW3q0F1jxpEcQl6Hv6USc3Kw018Q56/rsneKB8i1bcpYSZF4HtXZ91+5vlNpSLOUZ
         nL9oyNaM9oQQanWMW0TpeZJjdoKbU2yUjJdFG99iy9Z5seofpjfS/WZYft4acGkRztYk
         Pw4q8pHJyTmoSFvLiexjYdm9RVuMO8DqBnjXJrmlf9uBGb/cQvhl4KHsbFpD3Lm8Dy7Y
         FO8OHpTxBs7XaVhxgr0cWwEqwUzrPlMIZuuxq534hTjqCOHRh+FnJkwusDF7sfdRLccf
         iiwH3h5VUd5bx+lCGFSg02mm72FcIBkZkqi2UNjxBvPXh0O02WtX2ok0APqeUIf9a8fB
         rReQ==
X-Gm-Message-State: AJcUukc69YRIClN1PJj/V8kqdEFMNaFwv1NvvQfkph6udtFSZbtceKvK
        Oz5SfJrqLi/8SPgrFdbdMvrZgg==
X-Google-Smtp-Source: ALg8bN7ZYPHuERBQK3YfmymcTl1jgDYbH7JrsarhpNmiXpRibteZf4TA7Mjx+ovCyc6trZcmhs5WXQ==
X-Received: by 2002:a63:1f1c:: with SMTP id f28mr7139149pgf.193.1547615212701;
        Tue, 15 Jan 2019 21:06:52 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id m20sm4784888pgv.93.2019.01.15.21.06.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jan 2019 21:06:51 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org,
        neo.hou@unisoc.com, broonie@kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] gpio: sprd: Fix the incorrect data register
Date:   Wed, 16 Jan 2019 13:06:13 +0800
Message-Id: <24594f8799f6aabdeaad3935fe36d832fb465148.1547615070.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neo Hou <neo.hou@unisoc.com>

Since differnt type EICs have its own data register to read, thus fix the
incorrect data register.

Fixes: 25518e024e3a ("gpio: Add Spreadtrum EIC driver support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Neo Hou <neo.hou@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - Add fix tag and CC stable.
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

