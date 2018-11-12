Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CAFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA6B223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhropB8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA6B223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbeKMAFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 19:05:13 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45591 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeKMAFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 19:05:12 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so7705762ljd.12;
        Mon, 12 Nov 2018 06:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kNbJKObl4Tq1U1sfmTZWYIQLrVWBJAR23Hj9Dp7uhbM=;
        b=LhropB8l8dWi7ecioV/IYdDDHw/3zqktKsslRTGWMsxx5Qusxr/3Xr0qwQ9Qk9JSx8
         KGO94CGE4FIYHtrKh9gSdBxuBZVFuv9f+hANOX3ZnOq6D+jd4g3bkygl+9LWaF9mo0kp
         MMx1IA/jvqcarhARieXDHc4PNGedrzZgbww/ZhOjrMb68vTtg3TYhoqemYcTE+SHg1Ta
         /QTd18yWuFe+UfPebaJ/49lWTCI/+6tHGUorOZxXzTaBD32c3Ai37uU7TudGIl6JQ1UI
         CMNsiZPrGbV8DFeES0L72vhxHtIETkAy3TdnNySs8P8yydOD0VUJZ5ib8TNaEW5G1HTH
         Vk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=kNbJKObl4Tq1U1sfmTZWYIQLrVWBJAR23Hj9Dp7uhbM=;
        b=eApBgUK1M0w9IRLfyJb4zsf/w756daKAGMUaPG+AB2yHehvu9KeOr1g5YdQSp0PHa/
         xLGZrxgav0x9V2G62lwzglz0+U1OW1MJ2oXa32fUf3iV2xIkmEQKoimacH0lrOtvjRU7
         UEx9koLvMZSrILlhP0YzXjMHOWf+kyFIFeltakF8Gi6r5+VyzX2ukA5ofSaWbVgX70SE
         YfsE0bSj8IQbbt8ep8zjz3VNR8WdmxFz2UotBaRUc4RdO9Xbe+UdcPb2aXefmQLbVkXy
         7deW5mtSaWKY0AnwqIIekZO2KgR96IiGgbNRZ21ZLinQmRCtxemf5qL1oBBfjemwaFN5
         ykig==
X-Gm-Message-State: AGRZ1gJjsCRf149eBdc9+Jrkse3gR3rd+9PQ3Bls1RpTsQI2OHqBBObj
        HskLtKMeV4ysTr6X6i8mvfw=
X-Google-Smtp-Source: AJdET5dKOJ3ifHNggjdUH79sOvP68IEL7u9RooGVzg0Fc32XNLOL80JAMsnrn3gnAFHyqDKcQoYXHw==
X-Received: by 2002:a2e:824c:: with SMTP id j12-v6mr763690ljh.168.1542031904629;
        Mon, 12 Nov 2018 06:11:44 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id n3sm2906079lfl.44.2018.11.12.06.11.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 06:11:43 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gMCwF-0002fZ-H2; Mon, 12 Nov 2018 15:11:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] gpio: drop broken to_gpio_irq_chip() helper
Date:   Mon, 12 Nov 2018 15:10:28 +0100
Message-Id: <20181112141028.10213-1-johan@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the broken to_gpio_irq_chip() container_of() helper, which would
break the build for anyone who tries to use it.

Specifically, struct gpio_irq_chip only holds a pointer to a struct
irq_chip so using container_of() on an irq-chip pointer makes no sense.

Fixes: da80ff81a8f5 ("gpio: Move irqchip into struct gpio_irq_chip")
Cc: Thierry Reding <treding@nvidia.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/linux/gpio/driver.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 2db62b550b95..21bff1f14fde 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -166,11 +166,6 @@ struct gpio_irq_chip {
 	 */
 	void		(*irq_disable)(struct irq_data *data);
 };
-
-static inline struct gpio_irq_chip *to_gpio_irq_chip(struct irq_chip *chip)
-{
-	return container_of(chip, struct gpio_irq_chip, chip);
-}
 #endif
 
 /**
-- 
2.19.1

