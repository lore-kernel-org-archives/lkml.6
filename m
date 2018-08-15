Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AA1C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD42021506
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD42021506
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=david-bauer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbeHOXSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:18:55 -0400
Received: from mars.blocktrron.ovh ([51.254.112.43]:37099 "EHLO
        mail.blocktrron.ovh" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbeHOXSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:18:55 -0400
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Aug 2018 19:18:54 EDT
Received: from localhost.localdomain (p20030071CF136800381FECC4C97D924A.dip0.t-ipconnect.de [IPv6:2003:71:cf13:6800:381f:ecc4:c97d:924a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.blocktrron.ovh (Postfix) with ESMTPSA id BDDDF22C80;
        Wed, 15 Aug 2018 22:19:57 +0200 (CEST)
From:   David Bauer <mail@david-bauer.net>
Cc:     David Bauer <mail@david-bauer.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: 74x164: add lines-initial-states property
Date:   Wed, 15 Aug 2018 22:18:54 +0200
Message-Id: <20180815201855.29738-1-mail@david-bauer.net>
X-Mailer: git-send-email 2.18.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the ability to define the initial state of each output line on
device probe.

Signed-off-by: David Bauer <mail@david-bauer.net>
---
 Documentation/devicetree/bindings/gpio/gpio-74x164.txt | 5 +++++
 drivers/gpio/gpio-74x164.c                             | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-74x164.txt b/Documentation/devicetree/bindings/gpio/gpio-74x164.txt
index 2a97553d8d76..580b18065ad3 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-74x164.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-74x164.txt
@@ -14,6 +14,11 @@ Required properties:
 
 Optional properties:
 - enable-gpios: GPIO connected to the OE (Output Enable) pin.
+- lines-initial-states: Bitmask that specifies the initial state of
+  each line. When a bit is set to zero, the corresponding output line
+  is initialized LOW. When a bit is set to one, the corresponding
+  output line is initialized HIGH. In case this property is not
+  defined, all lines will be initialized as LOW.
 
 Example:
 
diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index fb7b620763a2..275310a0a538 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -150,6 +150,9 @@ static int gen_74x164_probe(struct spi_device *spi)
 	chip->gpio_chip.parent = &spi->dev;
 	chip->gpio_chip.owner = THIS_MODULE;
 
+	of_property_read_u8_array(spi->dev.of_node, "lines-initial-states",
+				  chip->buffer, chip->registers);
+
 	mutex_init(&chip->lock);
 
 	ret = __gen_74x164_write_config(chip);
-- 
2.18.0

