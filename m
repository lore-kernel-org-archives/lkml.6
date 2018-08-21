Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7500C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D77520E20
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSUHNlxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D77520E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeHURw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:52:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38597 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbeHURwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:52:25 -0400
Received: by mail-ed1-f65.google.com with SMTP id q15-v6so1221877eds.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 07:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6KQbJ/ehvzhLslRbh5pUWhc24N5jVaSmzwXXeaMc0Zo=;
        b=ZSUHNlxT2LqvIN/gOnN9RFwtXBiJKKJRVwhdOai3RqGPAAwnoa08zMSgN4KdJabT1z
         qEcPEsqs1fym+8U8e/TX2MW3tM9LHa9qZ2cmP/w6OVpN4BlauqlksnI5/aHleJN4Ny5g
         qtQlXbIF+qB35wDkFHZwP+5gUdUH3uncoVLWDewlHtNC2vhdP32NJbJBR4mu9Hh6lxQe
         CPXjvfnO6xdlLiAhtCulICqJ6NhqVXaMPaK4eE0V01kRHNGatGtsXHxYl6uLJkhO2SM2
         t26FwmiF3TzZlz54nry5+uu51OmLZ72Q40HFXPRWz8fggGowUrOj2v+UkE1lX8KyIWzc
         P5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6KQbJ/ehvzhLslRbh5pUWhc24N5jVaSmzwXXeaMc0Zo=;
        b=kHfZHrXYkHwYPugi2Rd9tiyLkiLZX3Dt7MGti1bye3rX5dD4c6HkJza0HTzssjuo8j
         CFE9amWrkR0U70ocbySOjcTmWRk9hFr044D+Mea8H9QTFxd96lwraelF3LoHJlRgZLHf
         WL+7ZSJJk3LlO/9iUxr00a+EicOY4fDkH5dbPj1nlJSjocLstkVQ0V2HDLE0WGI8S0ec
         GuOKDEAX+7uqOTc1BhwYGhu7MnpwijKTel/lukq62klwxWxXZcE3O5e/qEpbSWGgWMa5
         d+8Tck/+BKhH8aRhLFZ+rS3O8/M3f+QOnhpig5dGVBAVMswM5uZ5qsA5eZUykGoNERnh
         ZHvQ==
X-Gm-Message-State: AOUpUlFjM7klvdL/XPkUnat0xhtwA8+0Ipd7FWqRSR+9Ct8o5qN8JE1f
        7aqXqteWJMwZssziumYULdtsfaw5
X-Google-Smtp-Source: AA+uWPytQN3z8SWiVxr/gR80Jzs4OGEzEmlcca0/MwhlT3i8m0ZXkjsKfZ9FaadZw3MxQ+v8e1s22w==
X-Received: by 2002:aa7:d2cd:: with SMTP id k13-v6mr61720111edr.311.1534861920560;
        Tue, 21 Aug 2018 07:32:00 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id n17-v6sm6766144edq.10.2018.08.21.07.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 07:31:59 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 3/8] mtd: maps: gpio-addr-flash: Use devm_* functions
Date:   Tue, 21 Aug 2018 16:31:47 +0200
Message-Id: <20180821143152.32293-4-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821143152.32293-1-ricardo.ribalda@gmail.com>
References: <20180821143152.32293-1-ricardo.ribalda@gmail.com>
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

