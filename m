Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE18C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95582147A
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95582147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbeKUII5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:08:57 -0500
Received: from anholt.net ([50.246.234.109]:52702 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbeKUIIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 03:08:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 91B1F10A1633;
        Tue, 20 Nov 2018 13:37:06 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id T53cbQ4ZWmNW; Tue, 20 Nov 2018 13:37:04 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 959B910A0B73;
        Tue, 20 Nov 2018 13:37:03 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 7D2CA2FE1FE6; Tue, 20 Nov 2018 13:37:02 -0800 (PST)
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
Subject: [PATCH v2 0/5] BCM2835 PM driver (MFD version)
Date:   Tue, 20 Nov 2018 13:36:57 -0800
Message-Id: <20181120213702.27958-1-eric@anholt.net>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck and Stefan Wahren both wanted a MFD-style driver to
cover the PM node that lets WDT and soc/bcm2835-power both attach to
it.  I think this is an ugly solution because it bloats this feature
addition by 25% more lines for all the boilerplate, but here it is.
Tested with V3D powering on, haven't double-checked the reset
controller.

Eric Anholt (5):
  dt-bindings: soc: Add a new binding for the BCM2835 PM node.
  bcm2835-pm: Move bcm2835-watchdog's DT probe to an MFD.
  soc: bcm: bcm2835-pm: Add support for power domains under a new
    binding.
  ARM: bcm283x: Extend the WDT DT node out to cover the whole PM block.
  ARM: bcm283x: Switch V3D over to using the PM driver instead of
    firmware.

 .../bindings/soc/bcm/brcm,bcm2835-pm.txt      |  42 ++
 arch/arm/boot/dts/bcm2835-rpi.dtsi            |   4 -
 arch/arm/boot/dts/bcm283x.dtsi                |  16 +-
 arch/arm/mach-bcm/Kconfig                     |   1 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/bcm2835-pm.c                      |  98 +++
 drivers/soc/bcm/Kconfig                       |  11 +
 drivers/soc/bcm/Makefile                      |   1 +
 drivers/soc/bcm/bcm2835-power.c               | 661 ++++++++++++++++++
 drivers/watchdog/bcm2835_wdt.c                |  30 +-
 include/dt-bindings/soc/bcm2835-pm.h          |  28 +
 include/linux/mfd/bcm2835-pm.h                |  14 +
 12 files changed, 882 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
 create mode 100644 drivers/mfd/bcm2835-pm.c
 create mode 100644 drivers/soc/bcm/bcm2835-power.c
 create mode 100644 include/dt-bindings/soc/bcm2835-pm.h
 create mode 100644 include/linux/mfd/bcm2835-pm.h

-- 
2.19.1

