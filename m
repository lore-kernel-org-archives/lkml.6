Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45B6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFAA2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbfB0JfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:35:20 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:12449 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725881AbfB0JfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:35:20 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1R9XfS2000430;
        Wed, 27 Feb 2019 10:35:09 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qtv6cx2wu-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 27 Feb 2019 10:35:09 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8CFE434;
        Wed, 27 Feb 2019 09:35:08 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 31EE1275F;
        Wed, 27 Feb 2019 09:35:07 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 27 Feb
 2019 10:35:07 +0100
Received: from localhost (10.201.20.5) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 27 Feb 2019 10:35:06 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v4 0/9] Introduce STMFX I2C Multi-Function eXpander
Date:   Wed, 27 Feb 2019 10:34:45 +0100
Message-ID: <1551260094-32570-1-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for STMicroelectronics Multi-Function eXpander
(STMFX), used on some STM32 discovery and evaluation boards.

STMFX is an STM32L152 slave controller whose firmware embeds the following
features:
- I/O expander (16 GPIOs + 8 extra if the other features are not enabled),
- resistive touchscreen controller,
- IDD measurement.

I2C stuff and chip initialization is based on an MFD parent driver, which
registers STMFX features MFD children.

---
Changes in v4:
- mfd: move registers #define into the header
- mfd: merge stmfx and stmfx_ddata structures into one stmfx structure
- mfd: change stmfx_chip_init/exit and stmfx_irq_init/exit args: use
  i2c_client struct and i2c_get_clientdata
- mfd: fix typos
- mfd: add MFD cells for IDD and TS features
- pinctrl: rework registers #define
- dts: add STMFX support on stm32mp157c-ev1
Changes in v3:
- fix MFD interrupt bindings
- fix drivers/mfd/stmfx.c:103:8: warning: 'mask' may be used uninitialized
  in this function
Changes in v2:
- move to MFD parent driver for i2c stuff and chip initialization
- improve regmap configuration
- take advantage of the use of gpio-ranges

Amelie Delaunay (9):
  dt-bindings: mfd: Add ST Multi-Function eXpander (STMFX) core bindings
  mfd: Add ST Multi-Function eXpander (STMFX) core driver
  dt-bindings: pinctrl: document the STMFX pinctrl bindings
  pinctrl: Add STMFX GPIO expander Pinctrl/GPIO driver
  ARM: dts: stm32: add STMFX support on stm32746g-eval
  ARM: dts: stm32: add joystick support on stm32746g-eval
  ARM: dts: stm32: add orange and blue leds on stm32746g-eval
  ARM: dts: stm32: add STMFX support on stm32mp157c-ev1
  ARM: dts: stm32: add joystick support on stm32mp157c-ev1

 Documentation/devicetree/bindings/mfd/stmfx.txt    |  28 +
 .../devicetree/bindings/pinctrl/pinctrl-stmfx.txt  | 116 +++
 arch/arm/boot/dts/stm32746g-eval.dts               |  66 ++
 arch/arm/boot/dts/stm32mp157c-ev1.dts              |  60 ++
 drivers/mfd/Kconfig                                |  13 +
 drivers/mfd/Makefile                               |   2 +-
 drivers/mfd/stmfx.c                                | 568 ++++++++++++++
 drivers/pinctrl/Kconfig                            |  12 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-stmfx.c                    | 820 +++++++++++++++++++++
 include/linux/mfd/stmfx.h                          | 123 ++++
 11 files changed, 1808 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/stmfx.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt
 create mode 100644 drivers/mfd/stmfx.c
 create mode 100644 drivers/pinctrl/pinctrl-stmfx.c
 create mode 100644 include/linux/mfd/stmfx.h

-- 
2.7.4

