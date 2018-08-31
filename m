Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EA1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B634A2083D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tN/d3jNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B634A2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeHaXWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:22:22 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35834 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbeHaXWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:22:21 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VJDTFl107882;
        Fri, 31 Aug 2018 14:13:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535742809;
        bh=uUQ2iDEix+p4lGC9u/N1yIBg24pApNYwSziUcOLwIas=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tN/d3jNxSbWIN/+jyPJ1C7R6RcL8UaENsuqKosmnpr4JkOUnP+sdxS3DEFOsbwyEu
         pJp9wQQ5wRY5yDTHSM3xgR9HyXNL7cup9sjpxA2OCfDle+R+YrTyqB8XL4T5TiKbvZ
         f5c8T69f5N/SVwwVdEK62xye46YomEQFk+GYydEs=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJDTbi014452;
        Fri, 31 Aug 2018 14:13:29 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 14:13:28 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 14:13:29 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJDTPw004137;
        Fri, 31 Aug 2018 14:13:29 -0500
Received: from localhost (uda0226330.dhcp.ti.com [172.22.167.21])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w7VJDSx13203;
        Fri, 31 Aug 2018 14:13:28 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 3/5] gpio: davinci: Allocate the correct amount of memory for controller
Date:   Fri, 31 Aug 2018 14:13:24 -0500
Message-ID: <20180831191326.25106-3-afd@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831191326.25106-1-afd@ti.com>
References: <20180831191326.25106-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously we created a controller structure per bank of GPIO pins. This
has since been changed to one per controller, but the allocation size
was not changed. Fix this here.

This also leaves the variable 'nbank' unused, instead of removing it,
move it down and use it to clean up a loop. For loops with multiple
initializers and/or iteration expressions, especially ones that don't
use those loop counters are quite hard to follow, fix this.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/gpio/gpio-davinci.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 14d1729927d3..121a7948f785 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -165,7 +165,7 @@ davinci_gpio_get_pdata(struct platform_device *pdev)
 
 static int davinci_gpio_probe(struct platform_device *pdev)
 {
-	int gpio, bank, i, ret = 0;
+	int bank, i, ret = 0;
 	unsigned int ngpio, nbank, nirq;
 	struct davinci_gpio_controller *chips;
 	struct davinci_gpio_platform_data *pdata;
@@ -204,10 +204,7 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	else
 		nirq = DIV_ROUND_UP(ngpio, 16);
 
-	nbank = DIV_ROUND_UP(ngpio, 32);
-	chips = devm_kcalloc(dev,
-			     nbank, sizeof(struct davinci_gpio_controller),
-			     GFP_KERNEL);
+	chips = devm_kzalloc(dev, sizeof(*chips), GFP_KERNEL);
 	if (!chips)
 		return -ENOMEM;
 
@@ -247,7 +244,8 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 #endif
 	spin_lock_init(&chips->lock);
 
-	for (gpio = 0, bank = 0; gpio < ngpio; gpio += 32, bank++)
+	nbank = DIV_ROUND_UP(ngpio, 32);
+	for (bank = 0; bank < nbank; bank++)
 		chips->regs[bank] = gpio_base + offset_array[bank];
 
 	ret = devm_gpiochip_add_data(dev, &chips->chip, chips);
-- 
2.18.0

