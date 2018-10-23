Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3DFC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A0E2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="sfsiuFYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A0E2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbeJXDSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:18:45 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:45744 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbeJXDSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:18:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 9DA431F99B;
        Tue, 23 Oct 2018 20:54:03 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        x-mailer:message-id:date:date:subject:subject:from:from:received
        :received; s=dkim; t=1540320842; x=1542912843; bh=dLKEcdkQFQP0oB
        7Ik7mNLcEwf/JVBJZXJTobmbQgcV8=; b=sfsiuFYs50ByKX9aX/ZHT7jdBC7cxw
        UX3420uES2T/A2j/Xz2eCvdVkFTAAQTz2j1xghAl5RPvwhUs2Sd3+rMjV5cJ08Qc
        7FehyMumeYpfpK3aC8vhIXh3SE4zFrslrLhgB/gfFMpnwEx6y1Pb+54muV262gTz
        0pLNS02denJga6moAKP9fZqBixExzRgC4m9Gp0UQCahrCQJOwRL/T6BZMO6BjDod
        0667pNu6KN1DNRFS/d0I1kZ15+roP850LevgKYJ7OGQpv/39AHCPxezQgWPvucno
        0cFP4ixGDGjJI1eHeVzlm8uE9Mfw/r8fMxIDHMW5BE6OAIZvDO37pyjf+oaiHr+X
        SGOcIF6Lf4ZtARLu/OK0TjqECeuUC5BfynV+PsRotdw+vvlFb+/mfGkdOfNL0x9B
        uFjjRUuva1fBGCUyhUDX77u+Kjc7B89zjcXhsh+w895fV2+r3oPlH19YQ7dRQKIH
        nG2NHLZR/CQwhhvsuFHQO5WLvKjsuWajx7MeQbrPeKyjI3avuEKhxiaRRk3M8MZ7
        O0zRDM3nDRWo8PDL3kRBMuUJdUYiaABfuaSmM1jV7ilLSdeEQ4eWRGH1e1P10x7o
        NetYQZFBQTjfY5++5/sj4YdkePEIeRBQI6K2tgFXIbIO7o96iAezUcR+acOrYUeb
        xA+AuMWBFGM3M=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id GVxYQSJfi7SO; Tue, 23 Oct 2018 20:54:02 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 110F41F984;
        Tue, 23 Oct 2018 20:54:02 +0200 (CEST)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v5 00/11] AXP8x3 AC and battery power supply support
Date:   Tue, 23 Oct 2018 21:53:19 +0300
Message-Id: <20181023185330.10472-1-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AXP813 AC power supply support with input current and
voltage limiting support.

AXP803 AC and battery power supply support.

Changes in v5:
* Return correct input current limit for values 0x6 and 0x7
* Add specific compatibles for AXP803
* Change commit messages
* Add Vasily Khoruzhick Pinebook DTS patch

Changes in v4:
* Change order of axp20x-gpio in axp20x.c
* Fix indentation and spaces to tabs in axp20x.c

Changes in v3:
* Reorder ac_power_supply DT node
* Rename axp20x_ac_power_set_property function
* Split mfd commit 

Changes in v2:
* Reuse axp813 compatibles for axp803
* Refactor axp20x_ac_power.c

Oskari Lemmela (10):
  dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
  dt-bindings: power: supply: axp20x: add AXP803 power bindings
  dt-bindings: gpio: gpio-axp209: add AXP803 GPIO bindings
  dt-bindings: iio: adc: add AXP803 ADC bindings
  ARM: dts: axp81x: add AC power supply subnode
  arm64: dts: allwinner: axp803: add AC and battery power supplies
  arm64: dts: allwinner: a64: sopine-baseboard: enable power supplies
  power: supply: add AC power supply driver for AXP813
  mfd: axp20x: Add AC power supply cell for AXP813
  mfd: axp20x: Add supported cells for AXP803

Vasily Khoruzhick (1):
  arm64: dts: allwinner: a64: pinebook: enable power supplies

 .../devicetree/bindings/gpio/gpio-axp209.txt  |  2 +
 .../bindings/iio/adc/axp20x_adc.txt           |  2 +
 .../bindings/power/supply/axp20x_ac_power.txt |  4 +
 .../bindings/power/supply/axp20x_battery.txt  |  1 +
 arch/arm/boot/dts/axp81x.dtsi                 |  5 +
 arch/arm64/boot/dts/allwinner/axp803.dtsi     | 33 +++++++
 .../dts/allwinner/sun50i-a64-pinebook.dts     |  8 ++
 .../allwinner/sun50i-a64-sopine-baseboard.dts |  8 ++
 drivers/mfd/axp20x.c                          | 20 ++++
 drivers/power/supply/axp20x_ac_power.c        | 94 +++++++++++++++++++
 include/linux/mfd/axp20x.h                    |  1 +
 11 files changed, 178 insertions(+)

-- 
2.17.1

