Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5425DC41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCAA22087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:20:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCAA22087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbeKUDuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:50:17 -0500
Received: from anholt.net ([50.246.234.109]:50630 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730415AbeKUDuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:50:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id F03D310A1757;
        Tue, 20 Nov 2018 09:20:03 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id g9VorqpWc3N6; Tue, 20 Nov 2018 09:20:01 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 310D010A0AE6;
        Tue, 20 Nov 2018 09:20:01 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 0848E2FE1FE6; Tue, 20 Nov 2018 09:20:00 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 0/8] BCM2835 PM driver
Date:   Tue, 20 Nov 2018 09:19:52 -0800
Message-Id: <20181120172000.15102-1-eric@anholt.net>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series moves the BCM2835 WDT driver that controls a fraction of
the PM block out to soc/ and adds most of the rest of its
functionality.  My motivation has been to have V3D be functional
without firmware calls, probably improve its interactivity (since
we'll be able to power on/off without RPC to the firmware that may be
busy with other tasks), and (in a patch not submitted in this series)
extend its binding to use the reset controller instead of trying to
reset by toggling its power domain.

I've tested V3D with a few hours of running a V3D test, sleep(1) (to
trigger PM domain off); running a GPU hang job (to trigger reset);
sleep(1).  The non-hanging success-case job always passed, and dmesg
had no complaints from bcm2835-pm.  The other power domains are not
tested, but I've done my best.

This series will probably also be of interest to the
https://github.com/christinaa/rpi-open-firmware project for enabling USB.

Eric Anholt (8):
  watchdog: bcm2835: Move the driver to the soc/ directory.
  soc: bcm: bcm2835-pm: Rename the driver to its new "PM" name.
  soc: bcm: bcm2835-pm: Stop using _relaxed mmio accessors.
  soc: bcm: bcm2835-pm: Make some little accessor macros for the mmio
    area.
  dt-bindings: soc: Add a new binding for the BCM2835 PM node.
  soc: bcm: bcm2835-pm: Add support for power domains under a new
    binding.
  ARM: bcm283x: Extend the WDT DT node out to cover the whole PM block.
  ARM: bcm283x: Switch V3D over to using the PM driver instead of
    firmware.

 .../bindings/soc/bcm/brcm,bcm2835-pm.txt      |  42 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi            |   4 -
 arch/arm/boot/dts/bcm283x.dtsi                |  16 +-
 arch/arm/mach-bcm/Kconfig                     |   1 +
 drivers/soc/bcm/Makefile                      |   1 +
 drivers/soc/bcm/bcm2835-pm.c                  | 866 ++++++++++++++++++
 drivers/watchdog/Kconfig                      |  11 -
 drivers/watchdog/Makefile                     |   1 -
 drivers/watchdog/bcm2835_wdt.c                | 254 -----
 include/dt-bindings/soc/bcm2835-pm.h          |  28 +
 10 files changed, 951 insertions(+), 273 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
 create mode 100644 drivers/soc/bcm/bcm2835-pm.c
 delete mode 100644 drivers/watchdog/bcm2835_wdt.c
 create mode 100644 include/dt-bindings/soc/bcm2835-pm.h

-- 
2.19.1

