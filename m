Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E118C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253CD20652
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfADKba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:31:30 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45494 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfADKba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 05:31:30 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so32036869ljd.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 02:31:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lM5pvkUWtdBGBf295DNJav2rv4tKoFpjI+CoLPP6ETU=;
        b=YcvOz8cWXWZ59BQQpgoFDbPyeRr3o6oFXzozhWQ0lg7G5nXgADiH2x+3EhCuBJyqpI
         Ac0nqVZDu8V9aUK5WCK+GpfsqieHYnB/MiXCxb85TZTzMLpJGye+M+cxk4nXGszIu94e
         FMTKj2Pe8qM8OD0OlJjQ3zcAm+S+qwRpBxl6hoal9cpIr+b6c6FuSYEwqFC61UrKgKoM
         6REA1IUfw1VXrxIsOa7cA0s/URxhtGbCK+pTcpvkYJXa8kn5fHQ4M4J/Bx1mk7a9x4za
         oZemrF9kwXVnBL3h7LzsPVstHqeFkn+OxIoNA5VD3+CXxySH/5zB0Ha7G9mQrzLL11Gd
         wPjA==
X-Gm-Message-State: AJcUukf6vml6F4uqnYRdDxcwps3keOK9VB4RHHrnTW1Fjyg5SPkn+iZ/
        h4Z/Dcz/OgD6urvodZDzFgM=
X-Google-Smtp-Source: ALg8bN5zeEU2IJ4m1rxVsYAojZCMYA9sVGIESrXhq6ransrAluBkTywJpkcZcjzceV4yFgdvmXIRLw==
X-Received: by 2002:a2e:612:: with SMTP id 18-v6mr27757671ljg.125.1546597888308;
        Fri, 04 Jan 2019 02:31:28 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id y24-v6sm12217917ljd.20.2019.01.04.02.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 02:31:27 -0800 (PST)
Date:   Fri, 4 Jan 2019 12:31:15 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        ckeepax@opensource.cirrus.com
Subject: [PATCH] regmap: regmap-irq: Make irq-type callbak optional
Message-ID: <20190104103115.GA10043@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not register type setting callback if HW does not support
setting the irq type. IRQ core can then handle cases where
type setting is not supported and no regmap-irq specific handling
is required.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/base/regmap/regmap-irq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index d2d0014b0d23..a387ee499b5c 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -322,7 +322,6 @@ static const struct irq_chip regmap_irq_chip = {
 	.irq_bus_sync_unlock	= regmap_irq_sync_unlock,
 	.irq_disable		= regmap_irq_disable,
 	.irq_enable		= regmap_irq_enable,
-	.irq_set_type		= regmap_irq_set_type,
 	.irq_set_wake		= regmap_irq_set_wake,
 };
 
@@ -560,6 +559,9 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 	d->chip = chip;
 	d->irq_base = irq_base;
 
+	if (num_type_reg)
+		d->irq_chip.irq_set_type = regmap_irq_set_type;
+
 	if (chip->irq_reg_stride)
 		d->irq_reg_stride = chip->irq_reg_stride;
 	else
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
