Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897F4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A70520658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A70520658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbeH3RPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:15:08 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:20049 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728273AbeH3RPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:15:08 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie2.idc.renesas.com with ESMTP; 30 Aug 2018 22:13:01 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id F2F8783399;
        Thu, 30 Aug 2018 22:13:00 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,306,1531753200"; 
   d="scan'208";a="289528115"
Received: from unknown (HELO vbox.ree.adwin.renesas.com) ([10.226.37.67])
  by relmlii1.idc.renesas.com with ESMTP; 30 Aug 2018 22:12:58 +0900
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Simon Horman <horms@verge.net.au>, linux-gpio@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH v2 0/3] Renesas R9A06G032 PINCTRL Driver 
Date:   Thu, 30 Aug 2018 14:12:52 +0100
Message-Id: <1535634775-19365-1-git-send-email-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements the pinctrl driver for the RZ/N1 family of devices, including
the R9A06G032 (RZ/N1D) device.

One area that is likely to be contentious is the use of 'virtual pins' for the 
MDIO pinmuxing. The driver uses two pins (170 and 171) that don't exist on the 
device to configure the MDIO source within the RZ/N1 devices. On these devices, 
there are two Ethernet MACs, a 5-Port Switch, numerous industrial Ethernet 
peripherals, any of which can be the MDIO source. Configuring the MDIO source 
could be done without the virtual pins, e.g. by extending the functions to 
cover all MDIO variants (a total of 32 additional functions), but this would 
allow users to misconfigure individual MDIO pins, rather than assign all MDIO 
pins to a MDIO source. The choice of how to implement this will affect the
DT bindings.

This series was originally written by Michel Pollet whilst at Renesas, and I
have taken over this work.

One point from Michel's v1 series:
"Note, I used renesas,rzn1-pinmux node to specify the pinmux constants,
and I also don't use some of the properties documented in
pinctrl-bindings.txt on purpose, as they are too limited for my use
(I need to be able to set, clear, ignore or reset level, pull up/down
and function as the pinmux might be set by another OS/core running
concurently)."

Patch 0003 should really be applied after patch:
 "ARM: dts: r9a06g032: Correct UART and add all other UARTs", see
 https://www.spinics.net/lists/arm-kernel/msg673525.html

Main changes:
v2:
 - Change to generic rzn1 family driver, instead of device specific.
 - Review comments fixed.
 - Fix error handling during probe

Phil Edworthy (3):
  dt-bindings: pinctrl: renesas,rzn1-pinctrl: documentation
  pinctrl: renesas: Renesas RZ/N1 pinctrl driver
  ARM: dts: r9a06g032: Add pinctrl node

 .../bindings/pinctrl/renesas,rzn1-pinctrl.txt      |  97 +++
 arch/arm/boot/dts/r9a06g032.dtsi                   |   8 +
 drivers/pinctrl/Kconfig                            |  10 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-rzn1.c                     | 844 +++++++++++++++++++++
 include/dt-bindings/pinctrl/rzn1-pinctrl.h         | 191 +++++
 6 files changed, 1151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.txt
 create mode 100644 drivers/pinctrl/pinctrl-rzn1.c
 create mode 100644 include/dt-bindings/pinctrl/rzn1-pinctrl.h

-- 
2.7.4

