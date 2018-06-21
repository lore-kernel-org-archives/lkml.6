Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF59C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68CF21A58
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68CF21A58
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933091AbeFUSyr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:54:47 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:34088 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932795AbeFUSyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:54:46 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id 1Wuj1y00l3XaVaC01WujuM; Thu, 21 Jun 2018 20:54:45 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fW4jD-00058p-KR; Thu, 21 Jun 2018 20:54:43 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fW4jD-0004SJ-IE; Thu, 21 Jun 2018 20:54:43 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] w1: Allow compile test of GPIO consumers if !GPIOLIB
Date:   Thu, 21 Jun 2018 20:54:42 +0200
Message-Id: <20180621185442.17086-1-geert@linux-m68k.org>
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
Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
---
v3:
  - Add Acked-by,

v2:
  - Add Acked-by.
---
 drivers/w1/masters/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/masters/Kconfig b/drivers/w1/masters/Kconfig
index 1708b2300c7a9ca2..00827d2897b534bc 100644
--- a/drivers/w1/masters/Kconfig
+++ b/drivers/w1/masters/Kconfig
@@ -49,7 +49,7 @@ config W1_MASTER_DS1WM
 
 config W1_MASTER_GPIO
 	tristate "GPIO 1-wire busmaster"
-	depends on GPIOLIB
+	depends on GPIOLIB || COMPILE_TEST
 	help
 	  Say Y here if you want to communicate with your 1-wire devices using
 	  GPIO pins. This driver uses the GPIO API to control the wire.
-- 
2.17.1

