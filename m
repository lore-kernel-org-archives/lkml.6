Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4E991C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D439208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D439208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755187AbeFNLFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:05:23 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:15754 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755180AbeFNLFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:05:20 -0400
Received: from unknown (HELO relmlir1.idc.renesas.com) ([10.200.68.151])
  by relmlie3.idc.renesas.com with ESMTP; 14 Jun 2018 20:05:19 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir1.idc.renesas.com (Postfix) with ESMTP id 106287549B;
        Thu, 14 Jun 2018 20:05:19 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,222,1526310000"; 
   d="scan'208";a="282525840"
Received: from unknown (HELO be1yocto.ree.adwin.renesas.com) ([172.29.43.62])
  by relmlii1.idc.renesas.com with ESMTP; 14 Jun 2018 20:05:16 +0900
From:   Michel Pollet <michel.pollet@bp.renesas.com>
To:     linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>
Cc:     phil.edworthy@renesas.com,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] Renesas R9A06G032 PINCTRL Driver
Date:   Thu, 14 Jun 2018 12:00:16 +0100
Message-Id: <1528974029-29617-1-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*WARNING* -- this requires:
+ R9A06G032 base patch v9
+ R9A06G032 SMP patch v5

This implements the pinctrl driver for the R9A06G032. Apart from
the file names, I had to keep using RZN1_ as the headers etc are
already extensively in use -- u-boot, vmworks, cm3 code and threadx
use these constants and the base support to implement pinmux on this
SoC.

Also, there is an existing pretty extensive webapp that allows
configuring the pinmux externally that generates either source
code (for non DT based OSes) or an included .dtsi file for board
specific configs.

Note, I used renesas,rzn1-pinmux node to specify the pinmux constants,
and I also don't use some of the properties documented in
pinctrl-bindings.txt on purpose, as they are too limited for my use
(I need to be able to set, clear, ignore or reset level, pull up/down
and function as the pinmux might be set by another OS/core running
concurently).

v1
 + Just supports fhe UART0 on the DB board.

Michel Pollet (5):
  dt-bindings: Add the r9a06g032-pinctrl.h file
  dt-bindings: clock: renesas,r9a06g032-pinctrl: documentation
  pinctrl: renesas: Renesas R9A06G032 pinctrl driver
  ARM: dts: Renesas R9A06G032 pinctrl node
  ARM: dts: Renesas RZN1D-DB Board: Add UART0 pinmux node

 .../bindings/pinctrl/renesas,r9a06g032-pinctrl.txt | 124 +++
 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts        |  13 +
 arch/arm/boot/dts/r9a06g032.dtsi                   |   8 +
 drivers/pinctrl/Kconfig                            |  10 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-r9a06g032.c                | 890 +++++++++++++++++++++
 include/dt-bindings/pinctrl/r9a06g032-pinctrl.h    | 191 +++++
 7 files changed, 1237 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,r9a06g032-pinctrl.txt
 create mode 100644 drivers/pinctrl/pinctrl-r9a06g032.c
 create mode 100644 include/dt-bindings/pinctrl/r9a06g032-pinctrl.h

-- 
2.7.4

