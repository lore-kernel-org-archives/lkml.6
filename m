Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B94C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F73E20989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OTei0WA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F73E20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeK1VpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:45:25 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33253 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbeK1VpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:45:24 -0500
Received: by mail-lf1-f66.google.com with SMTP id i26so18981323lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 02:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qj9cUi+6gOc4BrcoirROwJkL8i1x0/qXXxenGaYp240=;
        b=OTei0WA3qfzGmNXPR3XuoQKPZLjzXRefTJ2Tk31d9PYPDSSk1N0bdc6Ajoy1oSNhH6
         5eu7YJSbSbCWKXP/Su9QydV4Raw7CJ6jBqJleOUfwhHyq2E1AVnybFJCuOqVmeebovcK
         DKfbYeyKEVhr4ajup+HMSJW18keAtNx18+BUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qj9cUi+6gOc4BrcoirROwJkL8i1x0/qXXxenGaYp240=;
        b=NoF4Y/GQz4SX+tooWLq/x0+/Icla/FzVVYezOHG+zAXlFZJp9iRM6uNzJiQzCtWATs
         Zusgn1vxcB8F9cYhVR11zinfaObqHLzrLr4NZcDs0piuUw6rMQ0a9xuzaTXefZUCV5Zk
         sZa2Tsm/+/VmINInO855b9rz5OSDodNlFqPO6tFwwlwTu5PU+DJHaTuzRR2qeKKgbZC5
         ryH4FW+DjF7RREH3Lh+sgJ00ZEaU384lunw/zKe9PJw4k41Z05IrlBhYZrOB4+NdzZ/D
         ZZLSKuHUM8KkYy7jawTlVzGI6mo3No1mgkYm61o+l3/hYrT/KoaW/NUvLQ2gF9omOmGt
         RogQ==
X-Gm-Message-State: AGRZ1gKP9c8DJiIE/FGrOI21KFvRwC/aCFrTHIwW9CqJMox0vpOJnRgM
        1ocGjpZdHsddGabD0Y4cU6HW4Q==
X-Google-Smtp-Source: AJdET5f08hEvgJ1QMawWev0NGNRfBbcjpcNI/jKAStWblVfXI3D6ZhhWkKmRRi4b0bup7DVgFosLug==
X-Received: by 2002:a19:54d7:: with SMTP id b84mr20234596lfl.131.1543401850175;
        Wed, 28 Nov 2018 02:44:10 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id c20sm1095101lfj.67.2018.11.28.02.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 02:44:09 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 07/10] regulator: da9211: Let core handle GPIO descriptors
Date:   Wed, 28 Nov 2018 11:43:47 +0100
Message-Id: <20181128104350.31902-8-linus.walleij@linaro.org>
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

This patch requires "gpio: Export gpiod_get_from_of_node()"
to be applied first.

Fixes: 11da04af0d3b ("regulator: da9211: Pass descriptors instead of GPIO numbers")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/da9211-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index 8f68c7a05d27..bfdead356526 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -293,8 +293,8 @@ static struct da9211_pdata *da9211_parse_regulators_dt(
 
 		pdata->init_data[n] = da9211_matches[i].init_data;
 		pdata->reg_node[n] = da9211_matches[i].of_node;
-		pdata->gpiod_ren[n] = devm_gpiod_get_from_of_node(dev,
-				  da9211_matches[i].of_node,
+		pdata->gpiod_ren[n] =
+			gpiod_get_from_of_node(da9211_matches[i].of_node,
 				  "enable",
 				  0,
 				  GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
-- 
2.19.1

