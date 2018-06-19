Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC59C28D1F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CEA20652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CEA20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757424AbeFSVUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:20:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60660 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757342AbeFSVTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:19:33 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CA1EC2087B; Tue, 19 Jun 2018 23:19:31 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9E65F203B0;
        Tue, 19 Jun 2018 23:19:31 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v5 4/6] ARM: at91: Implement clocksource selection
Date:   Tue, 19 Jun 2018 23:19:27 +0200
Message-Id: <20180619211929.22908-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619211929.22908-1-alexandre.belloni@bootlin.com>
References: <20180619211929.22908-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow selecting and unselecting the PIT clocksource driver so it doesn't
have to be compile when unused.

Tested-by: Alexander Dahl <ada@thorsis.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/mach-at91/Kconfig | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 1254bf9d91b4..64f18cd220b9 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -106,6 +106,31 @@ config SOC_AT91SAM9
 	    AT91SAM9X35
 	    AT91SAM9XE
 
+comment "Clocksource driver selection"
+
+config ATMEL_CLOCKSOURCE_PIT
+	bool "Periodic Interval Timer (PIT) support"
+	depends on SOC_AT91SAM9 || SOC_SAMA5
+	default SOC_AT91SAM9 || SOC_SAMA5
+	select ATMEL_PIT
+	help
+	  Select this to get a clocksource based on the Atmel Periodic Interval
+	  Timer. It has a relatively low resolution and the TC Block clocksource
+	  should be preferred.
+
+config ATMEL_CLOCKSOURCE_TCB
+	bool "Timer Counter Blocks (TCB) support"
+	depends on SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAMA5 || COMPILE_TEST
+	default SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAMA5
+	depends on !ATMEL_TCLIB
+	select ATMEL_ARM_TCB_CLKSRC
+	help
+	  Select this to get a high precision clocksource based on a
+	  TC block with a 5+ MHz base clock rate.
+	  On platforms with 16-bit counters, two timer channels are combined
+	  to make a single 32-bit timer.
+	  It can also be used as a clock event device supporting oneshot mode.
+
 config HAVE_AT91_UTMI
 	bool
 
-- 
2.17.1

