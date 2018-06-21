Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19846C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD5E21A6C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD5E21A6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933370AbeFUTAU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:00:20 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:58578 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932795AbeFUTAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:00:19 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id 1X0H1y00e3XaVaC01X0Hh8; Thu, 21 Jun 2018 21:00:18 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fW4ob-0005CZ-Ts; Thu, 21 Jun 2018 21:00:17 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fW4ob-0004am-Ra; Thu, 21 Jun 2018 21:00:17 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] misc: ti-st: Allow compile test of GPIO consumers if !GPIOLIB
Date:   Thu, 21 Jun 2018 21:00:16 +0200
Message-Id: <20180621190016.17611-1-geert@linux-m68k.org>
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
 drivers/misc/ti-st/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/ti-st/Kconfig b/drivers/misc/ti-st/Kconfig
index f34dcc51473052cf..5bb92698bc80f450 100644
--- a/drivers/misc/ti-st/Kconfig
+++ b/drivers/misc/ti-st/Kconfig
@@ -5,7 +5,8 @@
 menu "Texas Instruments shared transport line discipline"
 config TI_ST
 	tristate "Shared transport core driver"
-	depends on NET && GPIOLIB && TTY
+	depends on NET && TTY
+	depends on GPIOLIB || COMPILE_TEST
 	select FW_LOADER
 	help
 	  This enables the shared transport core driver for TI
-- 
2.17.1

