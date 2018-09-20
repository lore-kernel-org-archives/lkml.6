Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F8EECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA87C21532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA87C21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbeITVlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:41:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:32772 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbeITVlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:41:06 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F3994206EE; Thu, 20 Sep 2018 17:56:55 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id C3F0620379;
        Thu, 20 Sep 2018 17:56:55 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, jason@lakedaemon.net,
        andrew@lunn.ch, sebastian.hesselbarth@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] ARM: dts: mvebu: updates and new board
References: <20180726040257.22285-1-chris.packham@alliedtelesis.co.nz>
Date:   Thu, 20 Sep 2018 17:56:56 +0200
In-Reply-To: <20180726040257.22285-1-chris.packham@alliedtelesis.co.nz> (Chris
        Packham's message of "Thu, 26 Jul 2018 16:02:53 +1200")
Message-ID: <87bm8sjh6f.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,
 
 On jeu., juil. 26 2018, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> This series updates the armada-xp-98dx3236 SoC and related boards to use the
> new style dts bindings for nand.
>
> I've also added a new db-88f6820-amc board which is an Armada-385 based
> reference board from Marvell's switch team. It's a plugin card for either the
> db-dxbc2 or db-xc3-24g4 which can be used if you disable the internal CPU on
> those platforms.
>
> Chris Packham (4):
>   ARM: dts: mvebu: 98dx3236: Rename nand controller node
>   ARM: dts: mvebu: db-dxbc2: use new style nand binding
>   ARM: dts: mvebu: db-xc3-24g4: use new style nand binding
>   ARM: dts: mvebu: Add device tree for db-88f6820-amc board

While applying this series mvebu/dt, I got few warning with "ARM: dts:
mvebu: 98dx3236: Rename nand controller node".

I fix them and also use the new partition binding, the diff is the
following:

iff --git a/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts b/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts
index d87614057e3f..dc9ccce1d4a1 100644
--- a/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts
+++ b/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts
@@ -102,9 +102,14 @@
                nand-ecc-strength = <4>;
                nand-ecc-step-size = <512>;
 
-               partition@user {
-                       reg = <0x00000000 0x40000000>;
-                       label = "user";
+               partitions {
+                       compatible = "fixed-partitions";
+                       #address-cells = <1>;
+                       #size-cells = <1>;
+                       partition@0 {
+                               reg = <0x00000000 0x40000000>;
+                               label = "user";
+                       };
                };
        };
 };
@@ -131,13 +136,18 @@
                spi-max-frequency = <50000000>;
                m25p,fast-read;
 
-               partition@u-boot {
-                       reg = <0x00000000 0x00100000>;
-                       label = "u-boot";
-               };
-               partition@u-boot-env {
-                       reg = <0x00100000 0x00040000>;
-                       label = "u-boot-env";
+               partitions {
+                       compatible = "fixed-partitions";
+                       #address-cells = <1>;
+                       #size-cells = <1>;
+                       partition@0 {
+                               reg = <0x00000000 0x00100000>;
+                               label = "u-boot";
+                       };
+                       partition@100000 {
+                               reg = <0x00100000 0x00040000>;
+                               label = "u-boot-env";
+                       };
                };
        };
 };

I amended your patch with it, but if you don't agree with it, I can
still modify it, the branch is not immutable yet.

Thanks,

Gregory

>
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/armada-385-db-88f6820-amc.dts    | 184 ++++++++++++++++++
>  arch/arm/boot/dts/armada-xp-98dx3236.dtsi     |   2 +-
>  arch/arm/boot/dts/armada-xp-db-dxbc2.dts      |  18 +-
>  arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts |  18 +-
>  5 files changed, 208 insertions(+), 15 deletions(-)
>  create mode 100644 arch/arm/boot/dts/armada-385-db-88f6820-amc.dts
>
> -- 
> 2.18.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
