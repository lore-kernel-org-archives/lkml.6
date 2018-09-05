Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FA1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2DD420857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FG9cVbRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2DD420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbeIETH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:07:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33507 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeIETH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:07:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id d8-v6so6302538edv.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 07:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6KQbJ/ehvzhLslRbh5pUWhc24N5jVaSmzwXXeaMc0Zo=;
        b=FG9cVbRmQGuNVU960LtLOeeUXIzZ31PxXbqhAfYgsXZ8FUnzB/1o5O6z2X7Bvr6PtY
         V/99EMnnfMFWo85D0HWFM5JIEbN9UXQQ2FWMK1F+CHaXKOryWlyihhYwNcwuo4UJuABU
         qsoT5e5sS4sMjgwbFI7Ol5W01LIAYNClFBbd9ig8mxJHfCKZXAwc2I1vdGbLBkVnCJrb
         xtBWgomYYPP/ZLLrgUmN7eFrN9LfC+j0X+VdrDBkChZP3E0jYDN+fFuKYqLybArXAj20
         +7QO43nGcGZLKSoe/0wvAvJhC5j48LNfBaNXf33zYAYXksHE+cPqji4i7FLoJDVa9MdU
         jYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6KQbJ/ehvzhLslRbh5pUWhc24N5jVaSmzwXXeaMc0Zo=;
        b=cGh0P6BjUvmoW21HAFn9InYeAA04lVFTW1FNejFOn6K+PbuyZiYzcg+TUqfztyHVhJ
         V05UeKGOEUOcu8PEZbyN0NyvTaP5u04flk71KVnRgeFm3HU7xA8VqvXjlqakMkcn8BXS
         7M11cYYPxtrs+0Q+u6LAgW5uIcdUhv9EExYKumZBax8pvLpiYE9rVob6Tv+0V42L/mUK
         Z5T9jnKWff0R8b7ywwDSV0Rb9EF+OyCNwtblWOM5tn9h4Vek2rl/JL42dEtUQknnC4OP
         sjNq9DoffanUWGjfaecx+YsNDxbE2paDXJxoWAuhl64JZvg4zrkRUnpFkg4IZ3rZpwSr
         Ef0A==
X-Gm-Message-State: APzg51DMbAVI5+z/VVbihmHF/+Wi662OAVTi+jR1kEU2ECuvZx3k2eiw
        De9hHvmYtOop8k86O1+MRmw=
X-Google-Smtp-Source: ANB0VdYqNWYZtv/CIqpe/44X41ywyTNecyRMQw79g5FzmFJhp08cvJuo+H4XxR2omlo7CJP2qhRoWw==
X-Received: by 2002:a50:c201:: with SMTP id n1-v6mr42670279edf.11.1536158216658;
        Wed, 05 Sep 2018 07:36:56 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id u53-v6sm1556413edm.51.2018.09.05.07.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:36:55 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org (open list)
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 3/8] mtd: maps: gpio-addr-flash: Use devm_* functions
Date:   Wed,  5 Sep 2018 16:36:38 +0200
Message-Id: <20180905143643.9871-4-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
References: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By using devm functions we can make the code cleaner.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/mtd/maps/gpio-addr-flash.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
index 6de16e81994c..54a0d7d2365a 100644
--- a/drivers/mtd/maps/gpio-addr-flash.c
+++ b/drivers/mtd/maps/gpio-addr-flash.c
@@ -213,7 +213,7 @@ static int gpio_flash_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	arr_size = sizeof(int) * gpios->end;
-	state = kzalloc(sizeof(*state) + arr_size, GFP_KERNEL);
+	state = devm_kzalloc(&pdev->dev, sizeof(*state) + arr_size, GFP_KERNEL);
 	if (!state)
 		return -ENOMEM;
 
@@ -234,9 +234,11 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	state->map.copy_to    = gf_copy_to;
 	state->map.bankwidth  = pdata->width;
 	state->map.size       = state->win_size * (1 << state->gpio_count);
-	state->map.virt       = ioremap_nocache(memory->start, state->win_size);
-	if (!state->map.virt)
-		return -ENOMEM;
+	state->map.virt	      = devm_ioremap_resource(&pdev->dev, memory);
+	if (IS_ERR(state->map.virt)) {
+		dev_err(&pdev->dev, "failed to map memory\n");
+		return PTR_ERR(state->map.virt);
+	}
 
 	state->map.phys       = NO_XIP;
 	state->map.map_priv_1 = (unsigned long)state;
@@ -245,12 +247,10 @@ static int gpio_flash_probe(struct platform_device *pdev)
 
 	i = 0;
 	do {
-		if (gpio_request(state->gpio_addrs[i], DRIVER_NAME)) {
+		if (devm_gpio_request(&pdev->dev, state->gpio_addrs[i],
+				      DRIVER_NAME)) {
 			dev_err(&pdev->dev, "failed to request gpio %d\n",
 				state->gpio_addrs[i]);
-			while (i--)
-				gpio_free(state->gpio_addrs[i]);
-			kfree(state);
 			return -EBUSY;
 		}
 		gpio_direction_output(state->gpio_addrs[i], 0);
@@ -259,12 +259,8 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	dev_notice(&pdev->dev, "probing %d-bit flash bus\n",
 		   state->map.bankwidth * 8);
 	state->mtd = do_map_probe(memory->name, &state->map);
-	if (!state->mtd) {
-		for (i = 0; i < state->gpio_count; ++i)
-			gpio_free(state->gpio_addrs[i]);
-		kfree(state);
+	if (!state->mtd)
 		return -ENXIO;
-	}
 	state->mtd->dev.parent = &pdev->dev;
 
 	mtd_device_parse_register(state->mtd, part_probe_types, NULL,
@@ -276,13 +272,9 @@ static int gpio_flash_probe(struct platform_device *pdev)
 static int gpio_flash_remove(struct platform_device *pdev)
 {
 	struct async_state *state = platform_get_drvdata(pdev);
-	size_t i = 0;
-	do {
-		gpio_free(state->gpio_addrs[i]);
-	} while (++i < state->gpio_count);
+
 	mtd_device_unregister(state->mtd);
 	map_destroy(state->mtd);
-	kfree(state);
 	return 0;
 }
 
-- 
2.18.0

