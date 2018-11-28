Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3415C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF8E20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EI0hnTpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF8E20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbeK2AxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:53:03 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38073 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbeK2AxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:53:03 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so9546527pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 05:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I50nFMd9URCppMyU0fPjpiiOmYaN9MjB3/vOqwqOX2s=;
        b=EI0hnTpU9X9vZw8Ik6X/3OhI0Zjsqa3tNIZnJX5VsDh2U5EuCb5FZhkg8meAZSKM0q
         Men+WDGiLJNZiNk2z3ffxQz6eXfGLhOTjqkKWEN1feKK/TSuuGu8h1JgojI/QpyEzcvm
         1qGPGj9DDsu7uWIS9P3tz71RKJOLbgYhNz5nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I50nFMd9URCppMyU0fPjpiiOmYaN9MjB3/vOqwqOX2s=;
        b=nfGtiR5Vb/MwxkDTCdYwWz7wQ8SyTl3OZ3OtXKVj0cwwTdBO71SiKEM8/5eyVY17kl
         aTLoT+c2Req3kxoEy55ysXGLaS4BUjideZe19ZNKaYhfkClVCPkBb0JhT5LPY0AGDDcU
         Bb5iN6K/efz22yzG9a7FeWBG3N37jbX3JzTyQobI0iO1+3CdB6Ui33z9Vj0Qh/Xatn4x
         tCqKY2IeUrrO5Hyq5mgpgthunvSYNHBEkRQm5NXFbrtJdW9yOCfsio3yVQgElvbl18Sw
         wNJ4WhuBLL9pjdPijBnJG6t3sIvx8nCzL7yvN4cI+J+urDlvkvRYUz7HlVugD0W0v2qc
         SMOA==
X-Gm-Message-State: AGRZ1gIGYqSbCRVB25dHNEL/47/xRpKcRf7stgYltU7Ukcu7Yf33nV4l
        MmMxAjklN7FgU1e/LhqjXtBt
X-Google-Smtp-Source: AJdET5fppzS/IuffI5mPsTCvcOYocwD6xN0jHLsOTlcAee1FkzeE2C57o/pbj2AGeG7XA3SpR0SQWg==
X-Received: by 2002:a62:2606:: with SMTP id m6mr36686869pfm.133.1543413079570;
        Wed, 28 Nov 2018 05:51:19 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:90a:a93f:b481:6fae:6692:c3ee])
        by smtp.gmail.com with ESMTPSA id c4sm22049854pfm.151.2018.11.28.05.51.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:51:18 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     afaerber@suse.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        overseas.sales@unisoc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 00/15] Add initial RDA8810PL SoC and Orange Pi boards support
Date:   Wed, 28 Nov 2018 19:20:51 +0530
Message-Id: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds initial RDA8810PL SoC and Orange Pi boards (2G IoT and
i96) support. RDA8810PL is an ARM Cortex A5 based SoC with Vivante's GC860
GPU. The SoC has been added as a new ARM sub architecture with myself
and Andreas as the maintainers.

More information about the boards can be found in below links:

1. Orange Pi 2G-IoT - http://www.orangepi.org/OrangePi2GIOT/
2. Orange Pi i96 - https://www.96boards.org/product/orangepi-i96/

This patchset is based on the initial revision sent out by Andreas long
back (http://lists.infradead.org/pipermail/linux-arm-kernel/2017-June/515951.html).

I have extended his patchset with proper irqchip and UART drivers. Now,
boards can boot into initramfs with console at UART2.

Thanks,
Mani

Changes in v3:

As per Marc's review:

* Removed unused header and defines from irqchip driver.
* Removed setting flow handlers from set_type callback.
* Minor code cleanups.

As per Arnd's review:

* Modified the UART indexes to start from 1 to match the SoC numbering
* Enabled exposed UARTs (all 3 on both boards)
* Modified the serial aliases as per board numbering

* Added Greg's Reviewed-by tag for serial driver.

Changes in v2:

* Used readl/writel_relaxed calls for both irqchip and timer drivers as
  per Marc's review.
* Implemented the logic to prevent counter wrapping during read as
  suggested by Marc.
* Used the timer-of API as per Daniel's suggestion.
* Added description about the timer in both commit log and driver.
* Changed the Vendor name for RDA to Unisoc Communications Inc.
* Removed the soc node level and cleaned up devicetrees as per Rob's
  review.
* Merged interrupt controller DT patch to SoC.
* Moved aliases to board dts as per Arnd's suggestion.
* Removed RDA Micro support mail address and used Unisoc one and added
  my missing signed off by tag as per Andreas's comments.

Andreas Färber (4):
  dt-bindings: Add RDA Micro vendor prefix
  dt-bindings: arm: Document RDA8810PL and reference boards
  ARM: Prepare RDA8810PL SoC
  dt-bindings: serial: Document RDA Micro UART

Manivannan Sadhasivam (11):
  dt-bindings: interrupt-controller: Document RDA8810PL intc
  arm: dts: Add devicetree for RDA8810PL SoC
  arm: dts: Add devicetree for OrangePi 2G IoT board
  arm: dts: Add devicetree for OrangePi i96 board
  irqchip: Add RDA8810PL interrupt driver
  dt-bindings: timer: Document RDA8810PL SoC timer
  arm: dts: rda8810pl: Add timer support
  clocksource: Add clock driver for RDA8810PL SoC
  arm: dts: rda8810pl: Add interrupt support for UART
  tty: serial: Add RDA8810PL UART driver
  MAINTAINERS: Add entry for RDA Micro SoC architecture

 .../admin-guide/kernel-parameters.txt         |   6 +
 Documentation/devicetree/bindings/arm/rda.txt |  17 +
 .../interrupt-controller/rda,8810pl-intc.txt  |  61 ++
 .../bindings/serial/rda,8810pl-uart.txt       |  15 +
 .../bindings/timer/rda,8810pl-timer.txt       |  21 +
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 MAINTAINERS                                   |  14 +
 arch/arm/Kconfig                              |   2 +
 arch/arm/Makefile                             |   1 +
 arch/arm/boot/dts/Makefile                    |   3 +
 .../boot/dts/rda8810pl-orangepi-2g-iot.dts    |  50 ++
 arch/arm/boot/dts/rda8810pl-orangepi-i96.dts  |  50 ++
 arch/arm/boot/dts/rda8810pl.dtsi              |  99 +++
 arch/arm/mach-rda/Kconfig                     |   9 +
 arch/arm/mach-rda/Makefile                    |   1 +
 drivers/clocksource/Kconfig                   |   8 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-rda.c               | 195 ++++
 drivers/irqchip/Kconfig                       |   4 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-rda-intc.c                | 107 +++
 drivers/tty/serial/Kconfig                    |  19 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/rda-uart.c                 | 831 ++++++++++++++++++
 include/uapi/linux/serial_core.h              |   3 +
 25 files changed, 1520 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/rda.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
 create mode 100644 Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
 create mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
 create mode 100644 arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts
 create mode 100644 arch/arm/boot/dts/rda8810pl-orangepi-i96.dts
 create mode 100644 arch/arm/boot/dts/rda8810pl.dtsi
 create mode 100644 arch/arm/mach-rda/Kconfig
 create mode 100644 arch/arm/mach-rda/Makefile
 create mode 100644 drivers/clocksource/timer-rda.c
 create mode 100644 drivers/irqchip/irq-rda-intc.c
 create mode 100644 drivers/tty/serial/rda-uart.c

-- 
2.17.1

