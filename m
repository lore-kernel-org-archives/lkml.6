Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49BDC71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F99120835
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="hng6VaMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F99120835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbeJMPpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 11:45:47 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:44290 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbeJMPpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 11:45:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 6C8BC20791;
        Sat, 13 Oct 2018 10:09:32 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        x-mailer:message-id:date:date:subject:subject:from:from:received
        :received; s=dkim; t=1539418171; x=1542010172; bh=d8uqPPAjchSr0S
        h8qYYzNZ2Ao3SfWGdINL0s0qLP/34=; b=hng6VaMsqnxe6OtSW0+5UFW2stny2C
        Ng4OaTkAYeShYhYXFNFCl+vKU8jiAHEqkik42ua/3GdonV9lTl++jAWVleqrHoyx
        dAuEKBHDzxcc23x+dp2L9zpwy16bAHi3xKU4QYmgRg9AAPzPJ2/QaVvuaCPE4Uez
        AoGtyIMitzCbPZzk5J+0aCXWMxYeEzUIixqviW/jWXf694EYD9UP+Vu1U875SkTJ
        iVe/KBAb8MjyQX7RlEvhGlh3cBW3vOgL78DScsvim7F/kr+kcmjQSYVvdUJUQWvI
        h390OYzc5fjfI8UF+wWFnFnchLLE3xvEgBbuC6YTJcQ/eLZArDNr40jvqO2uoIcx
        HiKI9Z8W5dpfcaVpHHIp3Ubc8Iq3kh7SrqNHcaiQ5CVnOJaqZob+YCKTblptMjDX
        NIm/vicCi/9HuyP62mjZ+6oa2wXAdG9sf1IC9mQwmPLU4qDN+Sf+3zwNZyQE1NPp
        GsO0k3OqScQsaV17QQfoluEcZQWUF04wjnRI7FUlJ2s4tMxMWspfI9kHZtOZAuao
        DeulSR2D+XVfnmZfQWa5hRa/l10XGei7Hq2AO8csOoW5tuIryo4hRHph5H9IgnFt
        gICcVy2iS7enDJ9cQ1bFQgt8IlxG3apoqe3TNM2+RNVlaT3Q5QYMlKaAOKdAIuN0
        2S4ADU0J/vEBA=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 2o8M62vFNCPC; Sat, 13 Oct 2018 10:09:31 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 379301F99A;
        Sat, 13 Oct 2018 10:09:31 +0200 (CEST)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/7] AXP8x3 AC and battery power supply support
Date:   Sat, 13 Oct 2018 11:08:41 +0300
Message-Id: <20181013080848.29894-1-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AXP813 AC power supply support with input current and
voltage limiting support.

AXP803 AC and battery power supply support.

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

Oskari Lemmela (7):
  dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
  ARM: dts: axp81x: add AC power supply subnode
  arm64: dts: allwinner: axp803: add AC and battery power supplies
  arm64: dts: allwinner: a64: sopine: enable power supplies
  power: supply: add AC power supply driver for AXP813
  mfd: axp20x: Add AC power supply cell for AXP813
  mfd: axp20x: Add supported cells for AXP803

 .../bindings/power/supply/axp20x_ac_power.txt |  3 +
 arch/arm/boot/dts/axp81x.dtsi                 |  5 +
 arch/arm64/boot/dts/allwinner/axp803.dtsi     | 31 +++++++
 .../allwinner/sun50i-a64-sopine-baseboard.dts |  8 ++
 drivers/mfd/axp20x.c                          | 20 ++++
 drivers/power/supply/axp20x_ac_power.c        | 92 +++++++++++++++++++
 include/linux/mfd/axp20x.h                    |  1 +
 7 files changed, 160 insertions(+)

-- 
2.17.1

