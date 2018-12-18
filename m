Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760C3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438A1218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbeLRXuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:50:17 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:44702 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbeLRXuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:50:15 -0500
Received: from marcel-macpro.fritz.box (p4FF9F1DE.dip0.t-ipconnect.de [79.249.241.222])
        by mail.holtmann.org (Postfix) with ESMTPSA id 003B4CEE81;
        Wed, 19 Dec 2018 00:57:52 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v3 00/15] ARM: sunxi: Enable Broadcom-based Bluetooth
 controllers
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181217040449.31437-1-wens@csie.org>
Date:   Wed, 19 Dec 2018 00:50:13 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Loic Poulain <loic.poulain@gmail.com>,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <ADDC30F6-9C86-4D59-A28E-A3007C9D478D@holtmann.org>
References: <20181217040449.31437-1-wens@csie.org>
To:     Chen-Yu Tsai <wens@csie.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

> This is v3 of my Broadcom-based Bluetooth controllers on Allwinner SoC-
> based SBCs series. v2 was sent on 11/15, with a follow up ping on 11/28.
> No response from either Bluetooth maintainer. Would the maintainers
> acknowledge or provide feedback so we can move forward? WiFi for the
> Broadcom chips has been supported and enabled for many years. Bluetooth
> on the other hand has required userspace trickery to get it working.
> With serdev support, this now requires minimal interaction from
> users to get working.
> 
> 
> Changes since v2:
> 
>  - Collected tags from Ondrej for applicable patches
> 
> Changes since v1:
> 
>  - Collected tags
>  - Re-organize dt binding clocks and clock-names properties
>  - Simplify check for deferred probe when getting clocks
>  - Add explanation of Cubietruck's clk_out_a pinmux setting placement
>    to commit message.
>  - Add missing "uart-has-rtscts" property to Cubietruck device tree
> 
> Original cover letter follows.
> 
> 
> On many Allwinner SBCs / developer boards, there is a WiFi+BT combo
> module from AMPAK. Inside is either one or two Broadcom chips, depending
> on the model. This series enables the Bluetooth controllers for AMPAK
> AP6210, AP6212, and AP6330 found on several boards. More will come later
> as other SoCs require changes to some other parts. I did not cover the
> SCO PCM connections from the controller to the SoC's I2S interface. It
> seems no one is actually doing this, so I was not sure how to proceed.
> Any suggestions?
> 
> I deliberately left out the netdev mailing list and Dave Miller, as the
> only thing that is under net is the binding document. Maybe we should
> move that out of Documentation/devicetree/bindings/net/ ?
> 
> Also, I'm not subscribed to the linux-bluetooth ML, so please CC me for
> any discussions.
> 
> Patches 1 through 4 are device tree binding changes:
> 
> 1 - Make the external clock name unambiguous, and add a second entry for
>    the LPO clock.
> 
> 2 - Add regulator supply properties for the VBAT and VDDIO power pins.
> 
> 3 - Add a compatible string for BCM20702A1.
> 
> 4 - Add a compatible string for BCM4330.
> 
> Patches 5 through 13 are changes to the driver, either improvements,
> or updates to handle the updated device tree binding.
> 
> 5 - Make the driver handle deferred probing for the external clock.
> 
> 6 - Simplify clock error checking for subsequent clk API calls.
> 
> 7 - Handle clock-names for the main external clock.
> 
> 8 - Support a new external clock, the LPO.
> 
> 9 - Support regulator supplies.
> 
> 10 - Wait a small amount of time after toggling the GPIO for the device
>     to settle.
> 
> 11 - Add support for BCM20702A1, including its default address.
> 
> 12 - Add BCM4330 compatible string to the driver.
> 
> 13 - Handle default address for BCM43430A0.
> 
> 14 - Enable Broadcom-based serdev Bluetooth for multiple Allwinner ARMv7
>     boards.
> 
> 15 - Enable Broadcom-based serdev Bluetooth for the Bananapi M64.
> 
> checkpatch reports an error for both patch 11 and patch 13:
> 
>    ERROR: space required after that close brace '}'
> 
> I followed the existing code's style. If this is undesirable, I can send
> a follow-up patch fixing the entire code block.
> 
> The first 13 patches should go through the Bluetooth tree, while we, the
> sunxi maintainers, will take the last 2.
> 
> 
> Thanks
> ChenYu
> 
> Chen-Yu Tsai (14):
>  dt-bindings: net: broadcom-bluetooth: Fix external clock names
>  dt-bindings: net: broadcom-bluetooth: Add VBAT and VDDIO supplies
>  dt-bindings: net: broadcom-bluetooth: Add BCM20702A1 compatible string
>  dt-bindings: net: broadcom-bluetooth: Add BCM4330 compatible string
>  Bluetooth: hci_bcm: Handle deferred probing for the clock supply
>  Bluetooth: hci_bcm: Simplify clk_get error handling
>  Bluetooth: hci_bcm: Use "txco" and "extclk" to get clock reference
>  Bluetooth: hci_bcm: Add support for LPO clock
>  Bluetooth: hci_bcm: Add support for regulator supplies
>  Bluetooth: hci_bcm: Wait for device to come out of reset after power
>    on
>  Bluetooth: hci_bcm: Add compatible string for BCM4330
>  Bluetooth: btbcm: Add default address for BCM43430A0
>  ARM: dts: sunxi: Enable Broadcom-based Bluetooth for multiple boards
>  arm64: dts: allwinner: a64: bananapi-m64: Add Bluetooth device node
> 
> Maxime Ripard (1):
>  Bluetooth: hci_bcm: Add BCM20702A1 variant
> 
> .../bindings/net/broadcom-bluetooth.txt       |  11 +-
> arch/arm/boot/dts/sun7i-a20-cubietruck.dts    |  25 ++++
> arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts  |  18 +++
> .../boot/dts/sun8i-a83t-cubietruck-plus.dts   |  18 +++
> arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts  |  14 +++
> .../dts/allwinner/sun50i-a64-bananapi-m64.dts |  14 +++
> drivers/bluetooth/btbcm.c                     |  13 +-
> drivers/bluetooth/hci_bcm.c                   | 112 +++++++++++++++---
> 8 files changed, 208 insertions(+), 17 deletions(-)

patches 1-13 have been applied to bluetooth-next tree.

Regards

Marcel

