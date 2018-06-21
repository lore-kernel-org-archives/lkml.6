Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B2EC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C90521A5E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C90521A5E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933395AbeFUS6H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:58:07 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:55086 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932879AbeFUS6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:58:05 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id 1Wy21y00H3XaVaC01Wy2Gu; Thu, 21 Jun 2018 20:58:04 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fW4mQ-0005Af-7P; Thu, 21 Jun 2018 20:58:02 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fW4mQ-0004Ww-5i; Thu, 21 Jun 2018 20:58:02 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] net: phy: Allow compile test of GPIO consumers if !GPIOLIB
Date:   Thu, 21 Jun 2018 20:58:00 +0200
Message-Id: <20180621185800.17371-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is
not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consumer
functionality only, can still be compiled if GPIOLIB is not enabled.

Relax the dependency on GPIOLIB if COMPILE_TEST is enabled, where
appropriate.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
v3:
  - Rebased,

v2:
  - Add Acked-by.
---
 drivers/net/phy/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 343989f9f9d981e2..ceede09a28459f45 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -92,7 +92,8 @@ config MDIO_CAVIUM
 
 config MDIO_GPIO
 	tristate "GPIO lib-based bitbanged MDIO buses"
-	depends on MDIO_BITBANG && GPIOLIB
+	depends on MDIO_BITBANG
+	depends on GPIOLIB || COMPILE_TEST
 	---help---
 	  Supports GPIO lib-based MDIO busses.
 
-- 
2.17.1

