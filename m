Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5328C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6DD21EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="xJEh2knv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6DD21EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeHJALj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 20:11:39 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:55736 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbeHJALf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 20:11:35 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v6 01/24] mfd: Add ingenic-tcu.h header
Date:   Thu,  9 Aug 2018 23:43:51 +0200
Message-Id: <20180809214414.20905-2-paul@crapouillou.net>
In-Reply-To: <20180809214414.20905-1-paul@crapouillou.net>
References: <20180809214414.20905-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1533851087; bh=nyIzzP1aZboV8EpKEre3H/ZvYsdFlH2f6oVr9m4ehUU=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=xJEh2knvGp4U7u8nxN8MdodBM6fEDcSoVGd9XAesA8WubAI9ix8T0tJaVk/G1cWQTP6WG21abFgX4JM+vchc5mX0Ks+KTid5OkAb7HskLEVao4PfBBtsVVk+eg90Br2zQxdM5zLx6EvcmZjaVIhwffH6mKt0V/oNILrZ8KdXBac=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header contains macros for the registers that are present in the
regmap shared by all the drivers related to the TCU (Timer Counter Unit)
of the Ingenic JZ47xx SoCs.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/mfd/ingenic-tcu.h | 56 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 include/linux/mfd/ingenic-tcu.h

 v2: Use SPDX identifier for the license

 v3: - Use macros instead of enum
     - Add 'TCU_' at the beginning of each macro
	 - Remove useless include <linux/regmap.h>

 v4: No change

 v5: No change

 v6: Rename barrier macro from __LINUX_CLK_INGENIC_TCU_H__ to
     __LINUX_MFD_INGENIC_TCU_H__

diff --git a/include/linux/mfd/ingenic-tcu.h b/include/linux/mfd/ingenic-tcu.h
new file mode 100644
index 000000000000..3d85f075d2db
--- /dev/null
+++ b/include/linux/mfd/ingenic-tcu.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header file for the Ingenic JZ47xx TCU driver
+ */
+#ifndef __LINUX_MFD_INGENIC_TCU_H_
+#define __LINUX_MFD_INGENIC_TCU_H_
+
+#include <linux/bitops.h>
+
+#define TCU_REG_WDT_TDR		0x00
+#define TCU_REG_WDT_TCER	0x04
+#define TCU_REG_WDT_TCNT	0x08
+#define TCU_REG_WDT_TCSR	0x0c
+#define TCU_REG_TER		0x10
+#define TCU_REG_TESR		0x14
+#define TCU_REG_TECR		0x18
+#define TCU_REG_TSR		0x1c
+#define TCU_REG_TFR		0x20
+#define TCU_REG_TFSR		0x24
+#define TCU_REG_TFCR		0x28
+#define TCU_REG_TSSR		0x2c
+#define TCU_REG_TMR		0x30
+#define TCU_REG_TMSR		0x34
+#define TCU_REG_TMCR		0x38
+#define TCU_REG_TSCR		0x3c
+#define TCU_REG_TDFR0		0x40
+#define TCU_REG_TDHR0		0x44
+#define TCU_REG_TCNT0		0x48
+#define TCU_REG_TCSR0		0x4c
+#define TCU_REG_OST_DR		0xe0
+#define TCU_REG_OST_CNTL	0xe4
+#define TCU_REG_OST_CNTH	0xe8
+#define TCU_REG_OST_TCSR	0xec
+#define TCU_REG_TSTR		0xf0
+#define TCU_REG_TSTSR		0xf4
+#define TCU_REG_TSTCR		0xf8
+#define TCU_REG_OST_CNTHBUF	0xfc
+
+#define TCU_TCSR_RESERVED_BITS		0x3f
+#define TCU_TCSR_PARENT_CLOCK_MASK	0x07
+#define TCU_TCSR_PRESCALE_LSB		3
+#define TCU_TCSR_PRESCALE_MASK		0x38
+
+#define TCU_TCSR_PWM_SD		BIT(9)	/* 0: Shutdown abruptly 1: gracefully */
+#define TCU_TCSR_PWM_INITL_HIGH	BIT(8)	/* Sets the initial output level */
+#define TCU_TCSR_PWM_EN		BIT(7)	/* PWM pin output enable */
+
+#define TCU_WDT_TCER_TCEN	BIT(0)	/* Watchdog timer enable */
+
+#define TCU_CHANNEL_STRIDE	0x10
+#define TCU_REG_TDFRc(c)	(TCU_REG_TDFR0 + ((c) * TCU_CHANNEL_STRIDE))
+#define TCU_REG_TDHRc(c)	(TCU_REG_TDHR0 + ((c) * TCU_CHANNEL_STRIDE))
+#define TCU_REG_TCNTc(c)	(TCU_REG_TCNT0 + ((c) * TCU_CHANNEL_STRIDE))
+#define TCU_REG_TCSRc(c)	(TCU_REG_TCSR0 + ((c) * TCU_CHANNEL_STRIDE))
+
+#endif /* __LINUX_MFD_INGENIC_TCU_H_ */
-- 
2.11.0

