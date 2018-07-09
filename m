Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5719C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7CA2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7CA2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933339AbeGIPp3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:45:29 -0400
Received: from hermes.aosc.io ([199.195.250.187]:50454 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932735AbeGIPp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:45:26 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id CB8587D83A;
        Mon,  9 Jul 2018 15:44:57 +0000 (UTC)
Date:   Mon, 09 Jul 2018 23:44:20 +0800
In-Reply-To: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
References: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2 0/4] sun8i: r40: add AHCI
To:     Corentin Labbe <clabbe@baylibre.com>, linux@armlinux.org.uk,
        mark.rutland@arm.com, maxime.ripard@free-electrons.com,
        robh+dt@kernel.org, tj@kernel.org, wens@csie.org
CC:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <EF718AB4-DD07-4D67-BE2E-1B9EBA5EB25F@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年7月9日 GMT+08:00 下午11:20:54, Corentin Labbe <clabbe@baylibre.com> 写到:
>Hello
>
>With Moeicenowy's agreement, I have take leadership ot this patchset.
>
>There are no really changes appart renaming struct quirck to variant.
>
>Since the last serie is really old, I will answer comment here.
>The two regulator (1.2 and 2.5V) are not for the PHY since:
>- nothing in the schematic said that they are for the PHY, they seems
>  only for controller
>- all other AHCI driver use 5V for the target/PHY (vs 1.2/2.5 which
>  cannot be used for target)

Target is not equal to PHY. Target means the supply
of the disk, which can be usually 5v (for 2.5" HDD) or
12v (3.5" HDD).

By reading Wikipedia articles  about SATA and LVDS, I assume
2.5V is for PHY and 1.2V is for internal digital logic (VDD-SYS
is commonly 1.2V on 40nm Allwinner SoCs; 2.5V VDD can be
used to efficiently deliver ~1.2V LVDS.)

P.S. VDD-SATA and VDD25-SATA also exist on A20, and by checking
Banana Pi M1 (the original Banana Pi) schematics, VDD-SATA
is connected to common VDD-SYS (called INTVDD on the
schematics) and VDD25-SATA is connected to an always-on
fixed LDO, maybe due to the lack of power outputs on AXP209.

>
>Furthermore, the AHCI binding support only one regulator per PHY, so
>using the "target" regulator is out of question for registring this two
>non-phy regulator.
>
>I hope this answer all comments done on last version.
>
>Regards
>
>Corentin Labbe (3):
>  ata: ahci_sunxi: add support for R40 SATA controller
>  ARM: dts: sun8i: r40: add sata node
>  ARM: dts: sun8i: sun8i-r40-bananapi-m2-ultra: enable AHCI
>
>Icenowy Zheng (1):
>  dt-bindings: add binding for Allwinner R40 SATA AHCI controller
>
> .../devicetree/bindings/ata/ahci-platform.txt      |   1 -
> .../bindings/ata/allwinner,sun4i-a10-ahci.txt      |  40 +++++++
> arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  18 +++
> arch/arm/boot/dts/sun8i-r40.dtsi                   |   9 ++
>drivers/ata/ahci_sunxi.c                           | 124
>++++++++++++++++++++-
> 5 files changed, 188 insertions(+), 4 deletions(-)
>create mode 100644
>Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.txt
