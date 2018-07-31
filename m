Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6102CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE63208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE63208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbeGaHii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 03:38:38 -0400
Received: from regular1.263xmail.com ([211.150.99.139]:33664 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbeGaHii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 03:38:38 -0400
Received: from djw?t-chip.com.cn (unknown [192.168.167.158])
        by regular1.263xmail.com (Postfix) with ESMTP id ECECE25A;
        Tue, 31 Jul 2018 13:59:51 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id E086B383;
        Tue, 31 Jul 2018 13:59:47 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: djw@t-chip.com.cn
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 14.20.128.48
X-LOGIN-NAME: djw@t-chip.com.cn
X-UNIQUE-TAG: <47a8074446db866c3d2ebdae2f70b4dc>
X-ATTACHMENT-NUM: 0
X-SENDER: djw@t-chip.com.cn
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [14.20.128.48])
        by smtp.263.net (Postfix) whith ESMTP id 28719PAH6C4;
        Tue, 31 Jul 2018 13:59:50 +0800 (CST)
From:   djw@t-chip.com.cn
To:     linux-rockchip@lists.infradead.org
Cc:     Wayne Chou <zxf@t-chip.com.cn>, Levin Du <djw@t-chip.com.cn>,
        Heiko Stuebner <heiko@sntech.de>,
        Simon Xue <xxm@rock-chips.com>, Liang Chen <cl@rock-chips.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Wu <david.wu@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Rocky Hao <rocky.hao@rock-chips.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "David S. Miller" <davem@davemloft.net>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, Joseph Chen <chenjh@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 0/4] Add sdmmc UHS support to ROC-RK3328-CC board.
Date:   Tue, 31 Jul 2018 13:59:18 +0800
Message-Id: <1533016762-5268-1-git-send-email-djw@t-chip.com.cn>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Levin Du <djw@t-chip.com.cn>


Hi all, this is an attemp to add sdmmc UHS support to the
ROC-RK3328-CC board.

This patch series adds a new compatible `rockchip,rk3328-grf-gpio` to
the gpio-syscon driver, which currently only support for the access of
the GPIO_MUTE pin in RK3328. Support for HDMI pins can be added later on
perhaps by writing a standalone driver.

A new GRF GPIO controller named `grf_gpio` is defined in rk3328.dtsi so
that all RK3328 boards has access to it.

The ROC-RK3328-CC board use the new gpio <&grf_gpio 0> in gpio-regulator
to control the signal voltage of the sdmmc. It is essential for UHS
support which requires 1.8V signal voltage.

Many thanks to the Linux people!

Changes in v4:
- Use binding of "rockchip,rk3328-grf-gpio"
- Use <&grf_gpio 0> to refer to the GPIO_MUTE pin.

Changes in v3:
- Change from general gpio-syscon to specific rk3328-gpio-mute
- Use dedicated "rockchip,rk3328-gpio-mute" driver
- Use <&gpio_mute 0> instead of <&gpio_mute 1> to refer to the GPIO_MUTE pin.

Changes in v2:
- Rename gpio_syscon10 to gpio_mute in doc
- Rename gpio_syscon10 to gpio_mute in rk3328.dtsi
- Rename gpio_syscon10 to gpio_mute in rk3328-roc-cc.dts

Changes in v1:
- Refactured for general gpio-syscon usage for Rockchip SoCs.
- Add doc rockchip,gpio-syscon.txt
- Split from V0 and add to rk3328.dtsi for general use.
- Split from V0.
- Split into small patches
- Sort dts properties in sdmmc node

Levin Du (4):
  gpio: syscon: rockchip: add GRF GPIO support for rk3328
  arm64: dts: rockchip: add GRF GPIO controller to rk3328
  arm64: dts: rockchip: add io-domain to roc-rk3328-cc
  arm64: dts: rockchip: add sdmmc UHS support for roc-rk3328-cc

 .../bindings/gpio/rockchip,rk3328-grf-gpio.txt     | 32 ++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts     | 34 ++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  6 ++++
 drivers/gpio/gpio-syscon.c                         | 31 ++++++++++++++++++++
 4 files changed, 103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.txt

-- 
2.7.4


