Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB9BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787102148E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fKp4iaSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787102148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405697AbeKTDfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:35:06 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37714 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406694AbeKTDfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:35:06 -0500
Received: by mail-pf1-f194.google.com with SMTP id u3-v6so12472466pfm.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qCZivCgaYoODtSXyMh3z9hNOSS+exlqJP9yjA/wGX9E=;
        b=fKp4iaSff4+HLHN8BH5+saBSjXnbHoXnF4KwePYxpsKBbDKQ8+x71i7dTD3NWO3Uxm
         cpoIfWs0tIa93P6cRV3MfpKGmRBZUSAPLSLNXYkyagjOhpcOhDwAE9ZsIu3+PeGgh4ao
         jf5/mXJ6+clQTgUNAkcgwFWboPTaTl7EOXhOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qCZivCgaYoODtSXyMh3z9hNOSS+exlqJP9yjA/wGX9E=;
        b=e0qd52dd357RWpNrWFWXgn69opcmKDYHy0Kmef9Exb6/wv7t2az/FlYOxIERaBntdX
         9x1S3KlAMjBsQXZfMYBhXMEr8Z48pdTjoTkDGH92/09QaOF9/IVL6sBYX4graHXEfnVz
         vi+M/8TpzEYq3nSrlH/euZIzqNgZXDYC5LBQKyUZnVJqF/148I7GI/KgS3WUo+xp4C4C
         fV8RBQEseGj0MUR8cwdDKSYM6Kpsj602OThfjKm9Dz12d0qKo+77hOjCQiVjf/5vieBt
         +W0jPbVBWlVWKC7rXRzwTWr/AkiowuXUTyha16buqODbQf1HFLnpsGDlQ1jraaN8/FgO
         JYuw==
X-Gm-Message-State: AGRZ1gKP2xt+xSWRxKgkG5OmVh59o4JU+xl2AOWRDOcthVnLo0r5Kvga
        aqULQId3B1BRlmnvGE+cTR9X
X-Google-Smtp-Source: AJdET5eV3RogFfbMUb7hFcy6axqtFrUsZK9hX6UfsuRobKUo1hTyEndALqoiC4Zo6CuOEKnMp+Tkxg==
X-Received: by 2002:a63:d547:: with SMTP id v7mr20500295pgi.339.1542647446477;
        Mon, 19 Nov 2018 09:10:46 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:631b:44eb:3905:6402:e2fb:2d7])
        by smtp.gmail.com with ESMTPSA id 186-v6sm46175458pfe.39.2018.11.19.09.10.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:10:45 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        service@rdamicro.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 00/16] Add initial RDA8810PL SoC and Orange Pi boards support
Date:   Mon, 19 Nov 2018 22:39:23 +0530
Message-Id: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
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

Andreas Färber (4):
  dt-bindings: Add RDA Micro vendor prefix
  dt-bindings: arm: Document RDA8810PL and reference boards
  ARM: Prepare RDA8810PL SoC
  dt-bindings: serial: Document RDA Micro UART

Manivannan Sadhasivam (12):
  arm: dts: Add devicetree for RDA8810PL SoC
  arm: dts: Add devicetree for OrangePi 2G IoT board
  arm: dts: Add devicetree for OrangePi i96 board
  dt-bindings: interrupt-controller: Document RDA8810PL intc
  arm: dts: rda8810pl: Add interrupt controller support
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
 .../boot/dts/rda8810pl-orangepi-2g-iot.dts    |  35 +
 arch/arm/boot/dts/rda8810pl-orangepi-i96.dts  |  35 +
 arch/arm/boot/dts/rda8810pl.dtsi              | 116 +++
 arch/arm/mach-rda/Kconfig                     |   9 +
 arch/arm/mach-rda/Makefile                    |   1 +
 drivers/clocksource/Kconfig                   |   7 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-rda.c               | 187 ++++
 drivers/irqchip/Kconfig                       |   4 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-rda-intc.c                | 116 +++
 drivers/tty/serial/Kconfig                    |  19 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/rda-uart.c                 | 831 ++++++++++++++++++
 include/uapi/linux/serial_core.h              |   3 +
 25 files changed, 1507 insertions(+)
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

