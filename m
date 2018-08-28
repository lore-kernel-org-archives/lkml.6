Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CECFC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B4C208DA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B4C208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbeH1Fm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:42:27 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40281 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbeH1Fm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:42:27 -0400
Received: by mail-oi0-f67.google.com with SMTP id l202-v6so1436oig.7;
        Mon, 27 Aug 2018 18:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9ySqF6IiXDdirqBkKtalXkzw16PKSeO5DJ9duLXJb/w=;
        b=nVQDwzfcLVghXhkBQar3k1FEzR6k2qIlTUm5mtSf5hYXL9lC29zne78f8IBzVjh6Ya
         +KsAAbCbWZqHuYuVVLemEKjjtviwqnyUA9G9V/Yd8cV/fqgmObDVTOGN8ZQE/u6S1C8/
         5N6apYHGnuVZWr3Oc6xdYUPfRqBaPr14EDPnuUCCxOASo7kxv0FYmSA/jITUGyzqE9wj
         402wT9x0GsqXaEcZx1XbpCELPXRxmmlEVehJTj4P1PNm5vhjRwMB+TIVUqh3fyHlao+R
         gf6HVrQAcO4ncwELOttsjbDCnG6JYHm1oQeHgSCte/rmErqj8JR8dEYnqa2tRJiupOyN
         UttQ==
X-Gm-Message-State: APzg51BuBOoIQHhn+jiHbg4Ygxj2v0PyaG7vXHnXPV2TV/yzGwhMQ0Yl
        zv5QCP40ipAM2/rfqGTgvdXnjgs=
X-Google-Smtp-Source: ANB0VdZRkC9ZCBya5CSmNtORyFypUUSOwZfWbAq4pll2gQzcChGUIB9Ab6ugkkT1BqklYKSmpTmpTA==
X-Received: by 2002:aca:3882:: with SMTP id f124-v6mr1126564oia.195.1535421191708;
        Mon, 27 Aug 2018 18:53:11 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:53:11 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Subject: [PATCH] gpio: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:19 -0500
Message-Id: <20180828015252.28511-18-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/gpio/gpiolib-of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index a4f1157d6aa0..089783b11e87 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -348,8 +348,8 @@ static struct gpio_desc *of_parse_own_gpio(struct device_node *np,
 	else if (of_property_read_bool(np, "output-high"))
 		*dflags |= GPIOD_OUT_HIGH;
 	else {
-		pr_warn("GPIO line %d (%s): no hogging state specified, bailing out\n",
-			desc_to_gpio(desc), np->name);
+		pr_warn("GPIO line %d (%pOFn): no hogging state specified, bailing out\n",
+			desc_to_gpio(desc), np);
 		return ERR_PTR(-EINVAL);
 	}
 
-- 
2.17.1

