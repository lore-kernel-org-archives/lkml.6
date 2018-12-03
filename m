Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE302C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9488920851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Dx0gfsbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9488920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeLCKQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:16:23 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55883 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLCKQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:16:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so5094665wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Q2u/tsrKoFDIiu0ywRZGBRmyE9C0XxC7FQu/e+jYmo=;
        b=Dx0gfsblRMX9FXRsJeWDOVVS1Ou2kN17Ghlg+jFLYYBX1w5e0bAAchVy7BVj//q8Bl
         u26+f7NuhTrm7wYMrohRpsoahmqOft/uwXZBGESohEAcWfmGGeUnar/iqFeV2UiJ8DOP
         gP+wX804ilnrQPaEE8Lwd2aK7l8A9QAQ+AZB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Q2u/tsrKoFDIiu0ywRZGBRmyE9C0XxC7FQu/e+jYmo=;
        b=cowKzqpU2ZbU6Nd0dWn6RrNZ1EF4szs2tUGflwX3JgOymw7jXb+DqiAToEfiWAbTsJ
         A7JRk8lwEM0atI4fomPWKobEIE/FH5eFWLrx8UZQfjR9wjH8FK0PutZzUQWyCv02vtd2
         yRrywaDO5PbWZzeGglkrx/G5P1SNOw/PSCu+xEXbi8E22NO2W2tLurqciZEaau/E8Xmf
         vxQScjVOrbT7y/Xohbc7xwRSl7UTybum+IFsoJ5yoBdh+/yI7yCJiK9Q6NrAtjUKtdj3
         Zay1nnxZaX97ktT/gDGjjLrh8X2xdb14myvqj4l6dkSmZf+g9Jl+9M2uZImbZQ2c1e4g
         495A==
X-Gm-Message-State: AA+aEWZcmVNDXM+aVw3eZKAUKDeMJb6ZBrtwkze6qDQoENL68nlTGin7
        rFxqXrdT7CxBKCCe9nhX2r2LAJ3nm9E=
X-Google-Smtp-Source: AFSGD/Xkb2Xg2dWYgiGc5OJlhI2rqzN65UM2OiIMep0FsUPJ+jjr+tORjc21oDot04SvQjaILZV0KA==
X-Received: by 2002:a1c:13d1:: with SMTP id 200mr4440209wmt.4.1543832156825;
        Mon, 03 Dec 2018 02:15:56 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com. [2.228.78.71])
        by smtp.gmail.com with ESMTPSA id f192sm5832158wmd.12.2018.12.03.02.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:15:56 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 2/9] mfd: axp20x: Add GPIO/pinctrl support for AXP803
Date:   Mon,  3 Dec 2018 15:45:40 +0530
Message-Id: <20181203101547.16835-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181203101547.16835-1-jagan@amarulasolutions.com>
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GPIO/pinctrl support for AXP803.

This will reuse the similar compatible to that of AXP813,
since both PMIC GPIO's are same.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/mfd/axp20x.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 0be511dd93d0..bc705ba49c3f 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -731,8 +731,12 @@ static const struct mfd_cell axp803_cells[] = {
 		.name			= "axp221-pek",
 		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
 		.resources		= axp803_pek_resources,
+	}, {
+		.name			= "axp20x-regulator",
+	}, {
+		.name			= "axp20x-gpio",
+		.of_compatible		= "x-powers,axp813-gpio",
 	},
-	{	.name			= "axp20x-regulator" },
 };
 
 static const struct mfd_cell axp806_self_working_cells[] = {
-- 
2.18.0.321.gffc6fa0e3

