Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E13C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4512D2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XnhEqIi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4512D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeLJRgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:36:06 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44680 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeLJRgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:36:05 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so5712918pfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oVFI+a5VxncvrDx3DKy4gV2ZPQGt8Io6Cyg8FauMb9Q=;
        b=XnhEqIi3dTHQRieAwJ648DoBXJ3tZyzncVEexwZ/6j/ik3oOZm9f1K8I0u6LBraqGe
         HVFZLyDIQ89GPRZvMmX5F8hixHLsBLgestq0+SbQzzKWLDkVm1lCQamndgZEIIxSwMGu
         KWV88/ir+02arZt0i60RWdWhiseCurJYB35bY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oVFI+a5VxncvrDx3DKy4gV2ZPQGt8Io6Cyg8FauMb9Q=;
        b=PY2xszt2oJNLIPjpoYpLvr5zK9Rz/pKnVK3aiGBvZdr2m8pE88A2/zH07koMoNuzok
         WncUuo6GHsu3VbRDmezzXZLUiun2MvvenNhqPEyfgJWcjnaT3WtdqSxeE4j59xsldCXa
         SJMyylZLIRzEV1QhkHTKskUvh56oJxpFUxv/JN+waVlP3aozmrRdqdBt3YPQvJ40MC7i
         Tk0V57wy+jtOumb0RAVvKe/9NpHCU8RtLXlORwkWxHT8iHoN/wiVB5WUxnIgOoKtti18
         y2JK7SZtV1F5U1P2fsZK0/h9k/R+00Iu+PDroOOci8Ah0Cq4wxzmQCKUcXHpZUVbBZRK
         TBRw==
X-Gm-Message-State: AA+aEWay1bEbMIPwwnFEasLyEJe2QWH9bik/MbpBvyOMEqtMUKBO2q1x
        CiQ4M0Edd2w69+Ae/u8pjarI
X-Google-Smtp-Source: AFSGD/UzB0Z6N+2yadfKqmUgOSGUrkkl3rkXvBRLAOCb0nyrEWn3KApCRVq2XRNm8KMTH8qtSF3yKQ==
X-Received: by 2002:a62:e201:: with SMTP id a1mr12874637pfi.75.1544463364297;
        Mon, 10 Dec 2018 09:36:04 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
        by smtp.gmail.com with ESMTPSA id q1sm15998396pfb.96.2018.12.10.09.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 09:36:03 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 00/15] Add initial RDA8810PL SoC and Orange Pi boards support
Date:   Mon, 10 Dec 2018 23:05:35 +0530
Message-Id: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
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

Changes in v4:

* Added Rob's Reviewed-by tags for vendor and SoC patches.
* Moved platform Kconfig changes from timer and irqchip drivers to
  SoC support patch.
* Added Marc's Reviewed-by tag for irqchip driver.
* Addressed Rob's review comments for bindings patches.
* Added the newly created linux-unisoc mailing list to MAINTAINERS
  entry.
* Dropped overseas.sales@unisoc.com mail address as it is bouncing back.
* Modified the DTS subject prefix to ARM: from arm:

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
  ARM: dts: Add devicetree for RDA8810PL SoC
  ARM: dts: Add devicetree for OrangePi 2G IoT board
  ARM: dts: Add devicetree for OrangePi i96 board
  irqchip: Add RDA8810PL interrupt driver
  dt-bindings: timer: Document RDA8810PL SoC timer
  ARM: dts: rda8810pl: Add timer support
  clocksource: Add clock driver for RDA8810PL SoC
  ARM: dts: rda8810pl: Add interrupt support for UART
  tty: serial: Add RDA8810PL UART driver
  MAINTAINERS: Add entry for RDA Micro SoC architecture

 .../admin-guide/kernel-parameters.txt         |   6 +
 Documentation/devicetree/bindings/arm/rda.txt |  17 +
 .../interrupt-controller/rda,8810pl-intc.txt  |  61 ++
 .../bindings/serial/rda,8810pl-uart.txt       |  17 +
 .../bindings/timer/rda,8810pl-timer.txt       |  20 +
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 MAINTAINERS                                   |  15 +
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
 25 files changed, 1522 insertions(+)
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

