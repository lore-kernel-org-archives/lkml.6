Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EDEC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B102086C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEa+lTEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B102086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbeKET4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:56:10 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34686 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbeKET4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:56:09 -0500
Received: by mail-lj1-f193.google.com with SMTP id u6-v6so7551969ljd.1;
        Mon, 05 Nov 2018 02:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qaZQEoMW2c8ekIzYdfknMh8zhDWr1ixwxJ5V8tHMJDA=;
        b=CEa+lTEf69oXfbo/KY0Wi04vDhT/9bHb7gDs++7sRu3v9FlONhxL/LTDjwINgHfPs7
         Oq/kWqUf53MW4Oe7JQqVtdvDF/ZnqOYryQwyOggdKVgQZ38ozAmu5Mt0FFtTrJ5p+034
         sOiLsirqjZH7IHWV2VfEzVhhu9ZMNxVJzKeaEb7zkoK3PWDgVx9L2u+PtFG/vCXKtlt5
         Qg1R/6/rRK33lea5EGwS81MXRjWN+cevxBXjqfnQl1Rej/Qmd6+FfhVbRvJed/StfzHS
         iQVB4MYctAuvz/7mlJY7CtqbpueV3djqbXBhDX0JsPEXx/ln4vGlOUsJ0tFi/aAfwNEw
         E+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qaZQEoMW2c8ekIzYdfknMh8zhDWr1ixwxJ5V8tHMJDA=;
        b=CMgxjiIQZHuy47/S7ohJDXTmXCpGhwMyAml7Sb1uPGR0bXCeTodL7YUkb0nGbFYCVg
         YUese3XGwcTUAfdRS5P0uQoQxHr2Iul8SD8d0tWgNN4ILlO4vLJm9DMpfKYJsWvPD0t4
         A2dH4GJ2tVP1WYd0GO2rc0XT+brq1HaCglilHGzNZVBJqCRyam51giZEWnr03fnwfUdc
         qRAah+SZQ3xEkVHOya12tlrw/ScfQ4Vvmzin5MLzzLEJUr0Fpflo3Dbz9+hoAIJVWpTJ
         z+sj80h871+MhUCwhoSZW1BVZnVAoeGp437QtNqUV6bwNQvEyyunpSmfxfhRmj6P7fo3
         tdpw==
X-Gm-Message-State: AGRZ1gJj9Nqi3JemqpZ9qTdsLdCgMVJF6WmXfemgYpQ1oPqjfVvIcw1F
        3eG37Ty/npS91Ci+9tk9Ew==
X-Google-Smtp-Source: AJdET5fg+jXX66gG0ldzsayPLBD4EkoOzUKW4Pk07QRA/qTAKRebqfnt3xdtlXsFPYjIi/nDRyZcFA==
X-Received: by 2002:a2e:8546:: with SMTP id u6-v6mr1062576ljj.95.1541414224890;
        Mon, 05 Nov 2018 02:37:04 -0800 (PST)
Received: from localhost.localdomain (89-64-7-227.dynamic.chello.pl. [89.64.7.227])
        by smtp.gmail.com with ESMTPSA id h140-v6sm5413605lfg.4.2018.11.05.02.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 02:37:04 -0800 (PST)
From:   Piotr Bugalski <bugalski.piotr@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <bugalski.piotr@gmail.com>
Subject: [PATCH v3 1/6] mtd: spi-nor: atmel-quaspi: Typo fix
Date:   Mon,  5 Nov 2018 11:36:20 +0100
Message-Id: <20181105103625.9644-2-bugalski.piotr@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181105103625.9644-1-bugalski.piotr@gmail.com>
References: <20181105103625.9644-1-bugalski.piotr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just minor typo fix. Fixed in preparation of new driver.

Signed-off: Piotr Bugalski <bugalski.piotr@gmail.com>
---
 drivers/mtd/spi-nor/atmel-quadspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/atmel-quadspi.c b/drivers/mtd/spi-nor/atmel-quadspi.c
index 820048726b4f..1c5ba8feaa5e 100644
--- a/drivers/mtd/spi-nor/atmel-quadspi.c
+++ b/drivers/mtd/spi-nor/atmel-quadspi.c
@@ -67,7 +67,7 @@
 #define QSPI_CR_LASTXFER                BIT(24)
 
 /* Bitfields in QSPI_MR (Mode Register) */
-#define QSPI_MR_SSM                     BIT(0)
+#define QSPI_MR_SMM                     BIT(0)
 #define QSPI_MR_LLB                     BIT(1)
 #define QSPI_MR_WDRBT                   BIT(2)
 #define QSPI_MR_SMRM                    BIT(3)
@@ -563,7 +563,7 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
 	qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
 
 	/* Set the QSPI controller in Serial Memory Mode */
-	mr = QSPI_MR_NBBITS(8) | QSPI_MR_SSM;
+	mr = QSPI_MR_NBBITS(8) | QSPI_MR_SMM;
 	qspi_writel(aq, QSPI_MR, mr);
 
 	src_rate = clk_get_rate(aq->clk);
-- 
2.11.0

