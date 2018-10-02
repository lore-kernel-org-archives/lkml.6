Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBECC64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1E3208D9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1E3208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbeJBULr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:11:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60948 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbeJBULq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:11:46 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 624D3266;
        Tue,  2 Oct 2018 13:28:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 108/228] spi: orion: fix CS GPIO handling again
Date:   Tue,  2 Oct 2018 06:23:25 -0700
Message-Id: <20181002132506.699823053@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kundrát <jan.kundrat@cesnet.cz>

[ Upstream commit fb9acf5f1f21f1de193523ff780bda375b4c2e21 ]

The code did not de-assert any CS GPIOs before probing slaves. This
means that several CS signals could be active at once, garbling the
communication. Whether this was actually a problem depended on the type
of the SPI device attached (so my "spidev" for userspace access worked
correctly because its probe was effectively a no-op), and on the state
of the GPIO pins at SoC's boot.

The code was already iterating through all DT children of the SPI
controller, so this change re-uses that loop for CS GPIO setup as well.
This means that this might change the number of the HW CS signal which
is picked for all GPIO CS devices. Previously, the lowest one was used,
but we now use the first one from the DT.

With this move of the code, we can also finally initialize each GPIO CS
lane before registering the SPI controller (which in turn probes for
slaves).

I tried to fix this in 544248623b95 already, but that only did it half
way by registering the GPIOs properly. That patch failed to set their
logic signals early enough, though.

Signed-off-by: Jan Kundrát <jan.kundrat@cesnet.cz>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-orion.c |   77 ++++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 37 deletions(-)

--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/clk.h>
 #include <linux/sizes.h>
 #include <linux/gpio.h>
@@ -681,9 +682,9 @@ static int orion_spi_probe(struct platfo
 		goto out_rel_axi_clk;
 	}
 
-	/* Scan all SPI devices of this controller for direct mapped devices */
 	for_each_available_child_of_node(pdev->dev.of_node, np) {
 		u32 cs;
+		int cs_gpio;
 
 		/* Get chip-select number from the "reg" property */
 		status = of_property_read_u32(np, "reg", &cs);
@@ -695,6 +696,44 @@ static int orion_spi_probe(struct platfo
 		}
 
 		/*
+		 * Initialize the CS GPIO:
+		 * - properly request the actual GPIO signal
+		 * - de-assert the logical signal so that all GPIO CS lines
+		 *   are inactive when probing for slaves
+		 * - find an unused physical CS which will be driven for any
+		 *   slave which uses a CS GPIO
+		 */
+		cs_gpio = of_get_named_gpio(pdev->dev.of_node, "cs-gpios", cs);
+		if (cs_gpio > 0) {
+			char *gpio_name;
+			int cs_flags;
+
+			if (spi->unused_hw_gpio == -1) {
+				dev_info(&pdev->dev,
+					"Selected unused HW CS#%d for any GPIO CSes\n",
+					cs);
+				spi->unused_hw_gpio = cs;
+			}
+
+			gpio_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+					"%s-CS%d", dev_name(&pdev->dev), cs);
+			if (!gpio_name) {
+				status = -ENOMEM;
+				goto out_rel_axi_clk;
+			}
+
+			cs_flags = of_property_read_bool(np, "spi-cs-high") ?
+				GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH;
+			status = devm_gpio_request_one(&pdev->dev, cs_gpio,
+					cs_flags, gpio_name);
+			if (status) {
+				dev_err(&pdev->dev,
+					"Can't request GPIO for CS %d\n", cs);
+				goto out_rel_axi_clk;
+			}
+		}
+
+		/*
 		 * Check if an address is configured for this SPI device. If
 		 * not, the MBus mapping via the 'ranges' property in the 'soc'
 		 * node is not configured and this device should not use the
@@ -740,44 +779,8 @@ static int orion_spi_probe(struct platfo
 	if (status < 0)
 		goto out_rel_pm;
 
-	if (master->cs_gpios) {
-		int i;
-		for (i = 0; i < master->num_chipselect; ++i) {
-			char *gpio_name;
-
-			if (!gpio_is_valid(master->cs_gpios[i])) {
-				continue;
-			}
-
-			gpio_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
-					"%s-CS%d", dev_name(&pdev->dev), i);
-			if (!gpio_name) {
-				status = -ENOMEM;
-				goto out_rel_master;
-			}
-
-			status = devm_gpio_request(&pdev->dev,
-					master->cs_gpios[i], gpio_name);
-			if (status) {
-				dev_err(&pdev->dev,
-					"Can't request GPIO for CS %d\n",
-					master->cs_gpios[i]);
-				goto out_rel_master;
-			}
-			if (spi->unused_hw_gpio == -1) {
-				dev_info(&pdev->dev,
-					"Selected unused HW CS#%d for any GPIO CSes\n",
-					i);
-				spi->unused_hw_gpio = i;
-			}
-		}
-	}
-
-
 	return status;
 
-out_rel_master:
-	spi_unregister_master(master);
 out_rel_pm:
 	pm_runtime_disable(&pdev->dev);
 out_rel_axi_clk:


