Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7367C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917B02175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfBGGq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 01:46:27 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:34026 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbfBGGpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 01:45:45 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 96D3D5FA80; Thu,  7 Feb 2019 14:45:39 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [RFT PATCH 0/9] ARM: sun8i: a83t: Enable USB OTG
Date:   Thu,  7 Feb 2019 14:45:26 +0800
Message-Id: <20190207064535.9226-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This series enables USB OTG on the A83T boards. The AXP813/AXP818 PMICs
used with the A83T have the same behavior as the AXP221 and AXP223,
where if the N_VBUSEN pin is driven high, the VBUS sensing interrupts
stop working. In the past Hans made a polling workaround in the USB PHY
driver. In this series polling is added to the power supply driver.

The power supply driver work was started by Quentin, and shared with me
when I expressed interest in getting USB OTG to work some time ago.
Neither of us got around to finishing it, until now that is.

Patch 1 adds a new compatible string for the AXP813 VBUS power supply
part.

Patch 2 is a bit of cleanup work for the driver.

Patch 3 allows disabling VBUS input current limiting on the AXP20x /
AXP22x PMICs. While not strictly related to this series, I found it
easier to just send everything together. This patch depends on the
previous one.

Patch 4 adds the VBUS status polling feature. This is enabled on AXP221
and all later PMICs.

Patch 5 factors out code to read out the configured input current limit
for the AXP20x and AXP22x PMICs. As the AXP813 uses different values,
factoring out the code based on model will make the main function more
readable.

Patch 6 adds support for the AXP813 VBUS power supply. checkpatch.pl
reports a few warnings for this patch:

    WARNING: Possible switch case/default not preceded by break or
    fallthrough comment
    #100: FILE: drivers/power/supply/axp20x_usb_power.c:306:
    +       case 1500000:

    WARNING: Possible switch case/default not preceded by break or
    fallthrough comment
    #101: FILE: drivers/power/supply/axp20x_usb_power.c:307:
    +       case 2000000:

    WARNING: Possible switch case/default not preceded by break or
    fallthrough comment
    #102: FILE: drivers/power/supply/axp20x_usb_power.c:308:
    +       case 2500000:

However they seem to be a false positive. The preceding line of the
reported lines is a return statement, which is definitely not a
fallthrough.

Patch 7 adds an mfd cell for the newly supported VBUS power supply.

Patch 8 adds a device node for the VBUS power supply to the common
axp81x dtsi file.

Patch 9 enables USB OTG on the Cubietruck Plus and Bananapi M3.

Please have a look, and also test it on boards you have, and don't
limit it to just the A83T ones. As mentioned above, the polling feature
affects all boards that have an AXP221 or newer PMIC.

I haven't removed the polling workaround from the USB PHY driver yet.
That would be the next step after this series is merged, and preferrably
a release has passed.


Regards
ChenYu


Chen-Yu Tsai (5):
  dt-bindings: power: supply: axp20x_usb_power: add axp813 compatible
  power: supply: axp20x_usb_power: Fix typo in VBUS current limit macros
  power: supply: axp20x_usb_power: allow disabling input current
    limiting
  power: supply: axp20x_usb_power: use polling to detect vbus status
    change
  ARM: dts: sun8i: a83t: Enable USB OTG controller on some boards

Quentin Schulz (4):
  power: supply: axp20x_usb_power: add function to get max current
  power: supply: axp20x_usb_power: add support for AXP813
  mfd: axp20x: add USB power supply mfd cell to AXP813
  ARM: dtsi: axp81x: add USB power supply node

 .../power/supply/axp20x_usb_power.txt         |   1 +
 arch/arm/boot/dts/axp81x.dtsi                 |   4 +
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts  |  12 ++
 .../boot/dts/sun8i-a83t-cubietruck-plus.dts   |  12 ++
 drivers/mfd/axp20x.c                          |  11 ++
 drivers/power/supply/axp20x_usb_power.c       | 184 +++++++++++++++---
 6 files changed, 197 insertions(+), 27 deletions(-)

-- 
2.20.1

