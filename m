Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CE0C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B9221709
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I63en7JU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B9221709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbeHNBS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:18:58 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38391 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbeHNBS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:18:57 -0400
Received: by mail-lj1-f194.google.com with SMTP id p6-v6so13830999ljc.5;
        Mon, 13 Aug 2018 15:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b2SdvcCWvKUHXYoc18v3gflYdo3rK03xrds2t38Pw+o=;
        b=I63en7JUaNTgxV8FI2WFzD6wAlVmktuXrNtMgvRQOLakFX+2L/JsMaUQSa3ialIX8i
         t89YBkKNPnlPeCm+g9b08bYHVqXdurk8llgXfbGti//vodwCm5xp9sBs7iNy03Awxswg
         K9rM+C13Hi5bQyxMIjDKnNw7hrySQshX9doiA3Ug2fx5APA1JeDKSaKSz17Vr8KKB1pe
         kHrC1w+C1S+obq2jjmmE9YPwJAG0AuoAl0tSe/7ItMUeyaRTeC2zIvFjtF9PYY+TJJ0L
         EN0/bdkXbvjV8QTcLOnGJjpqGeM6YBfpDHp6495Dk8jZ6zQFPLUs6/gONG9vUgJNaiKB
         iJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b2SdvcCWvKUHXYoc18v3gflYdo3rK03xrds2t38Pw+o=;
        b=dJbEBJG3lMQq1cp+EniokgS+tlOnKHSOpba/UgW5h4djREb+6RXmrtGGEVsCXHGNqm
         MRmM0KhCbavoFe6DclV1+ZbRHJvFays3XhdvOzZJzUhW1USfSrvau/iMI1TGi3mPxY1X
         gwKK34tJLBZp7959Ueh07dgESrIq2bj46yoN1g8NHVgIP6cMOs4VTXfFbo+fNmPNS3lE
         UzOUENfytLlJf6ERnhmWoGizQTWt9qQd1yB6ZhHoFSjwA5rOwoKPetr9JIEvG3yfcFXe
         xcHV4MiiYXjfYflFJr+R1EsSsAx3LmoPGUOvil5W4kXxm4moFYLJMM2LcjbCZeFuW2oK
         0eag==
X-Gm-Message-State: AOUpUlFY65ZmDVm2kEgOek4U4n8NRxHuvHMEHdWzHsAIDF1h62Nk8SfW
        Jl9IdbBbuAbsefefKAL39FPq1T++2eCcUg==
X-Google-Smtp-Source: AA+uWPyp/o2aXnNMyr3Oy9nMJmN23OVRMJ1SZaWObPJc3Qf3fejcc1yO0vjS0rIftTYgjnCq0bG5DQ==
X-Received: by 2002:a2e:9599:: with SMTP id w25-v6mr9877719ljh.6.1534199681289;
        Mon, 13 Aug 2018 15:34:41 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id f136-v6sm3572702lfe.71.2018.08.13.15.34.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 15:34:40 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v3 3/7] ARM: OMAP1: ams-delta: Provide GPIO lookup table for NAND data port
Date:   Tue, 14 Aug 2018 00:34:44 +0200
Message-Id: <20180813223448.21316-4-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180813223448.21316-1-jmkrzyszt@gmail.com>
References: <20180806222918.12644-1-jmkrzyszt@gmail.com>
 <20180813223448.21316-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Data port used by Amstrad Delta NAND driver is actually an OMAP MPUIO
device, already under control of gpio-omap driver.  The NAND driver
gets access to the port by ioremapping it and performs read/write
operations.  That is done without any proteciton from other users
legally manipulating the port pins over GPIO API.

The plan is to convert the driver to access the port over GPIO consumer
API.  Before that is implemented, the driver can already obtain
exclusive access to the port by requesting an array of its GPIO
descriptors.

Add respective entries to the NAND GPIO lookup table.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-omap1/board-ams-delta.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index eedacdfe9725..16f7bbe47607 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -337,7 +337,8 @@ static struct platform_device ams_delta_nand_device = {
 	.resource	= ams_delta_nand_resources,
 };
 
-#define OMAP_GPIO_LABEL	"gpio-0-15"
+#define OMAP_GPIO_LABEL		"gpio-0-15"
+#define OMAP_MPUIO_LABEL	"mpuio"
 
 static struct gpiod_lookup_table ams_delta_nand_gpio_table = {
 	.table = {
@@ -349,6 +350,14 @@ static struct gpiod_lookup_table ams_delta_nand_gpio_table = {
 		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_NWE, "nwe", 0),
 		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_ALE, "ale", 0),
 		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_CLE, "cle", 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 0, "data", 0, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 1, "data", 1, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 2, "data", 2, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 3, "data", 3, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 4, "data", 4, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 5, "data", 5, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 6, "data", 6, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 7, "data", 7, 0),
 		{ },
 	},
 };
-- 
2.16.4

