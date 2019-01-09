Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ABDC43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B2C2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbfAINmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 08:42:51 -0500
Received: from mxout017.mail.hostpoint.ch ([217.26.49.177]:42890 "EHLO
        mxout017.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731203AbfAINmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 08:42:39 -0500
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
        by mxout017.mail.hostpoint.ch with esmtp (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1ghE7h-0002Kw-EA; Wed, 09 Jan 2019 14:42:21 +0100
Received: from 252.222.41.212.static.wline.lns.sme.cust.swisscom.ch ([212.41.222.252] helo=philippe-pc.toradex.int)
        by asmtp012.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1ghE7h-0006KA-6o; Wed, 09 Jan 2019 14:42:21 +0100
X-Authenticated-Sender-Id: dev@pschenker.ch
From:   Philippe Schenker <dev@pschenker.ch>
To:     jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch
Cc:     robh@kernel.org, alexandre.torgue@st.com, shawnguo@kernel.org,
        dmitry.torokhov@gmail.com, thierry.reding@gmail.com,
        mcoquelin.stm32@gmail.com, digetx@gmail.com, lee.jones@linaro.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        linux-iio@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stefan Popa <stefan.popa@analog.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Freeman Liu <freeman.liu@spreadtrum.com>,
        linux-input@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        devicetree@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        linux-tegra@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v6 0/8] Adding support for STMPE811 ADC
Date:   Wed,  9 Jan 2019 14:41:59 +0100
Message-Id: <20190109134208.5660-1-dev@pschenker.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Hello everyone,

This patchset is adding an ADC driver for STMPE811. The STMPE811 is a
Multi-Frontend-Device that supports a touchscreen, ADC, GPIO and a
temperature sensor.

For Touchscreen and GPIO there are already existing drivers in
mainline. This patchset will add support, to read out the ADC and
temperature sensor.
This patchset is also reformatting device tree bindings, so they are
easier to read (PATCH 1/1).
To be able to add this ADC driver it is necessary to move some defines
from the touchscreen driver to the mfd device (PATCH 2/8) so they are
also accessible by mfd and adc driver.
Because the touchscreen driver is also using the internal ADC it makes
sense to put the common adc settings of stmpe-ts.c and stmpe_adc.c to
the MFD. In the MFD there is then also an initialisation for the common
settings of ADC done. The existing initialisation in touchscreen driver
is kept for backwards-compatibility. All of this MFD related changes
are in PATCH 3/8.
In PATCH 4/8 then these settings are removed from stmpe-ts and grabbed
from MFD.
PATCH 5/8 is actually adding the ADC driver that also supports the
built-in temperature sensor.
PATCH 6/8 is then adding the needed devicetree bindings.
PATCH 7/8 and 8/8 is lastly adding the stmpe_adc DT-nodes as found on
Toradex boards.

Changes in v6:
 - Added Rob's Reviewed-by
 -  Added Dmitry's ack
 - Added Rob's Reviewed-by
 - Just realized that the comment for st,norequest-mask was at the wrong
   place, fixed.
 - Just realized that the comment for st,norequest-mask was at the wrong
   place, fixed.
 - Added also tegra30-apalis-v1.1.dtsi, as I forgot that.

Changes in v5:
 - Made a one column list
 - Added lee's Acked-for-MFD
 - Changed author of commit to use correct email.
 - Changed author of commit to use correct email
 - Added Lee Jone's Ack
 - Changed author of commit. Previous patch versions author was wrong
   by mistake.
 - Changed author of commit to use correct email.
 - Removed devm_add_action_or_reset
 - Changed iio_device_register to devm_iio_device_register
 - Added Jonathan Cameron's Reviewed-by
 - Added correct author of commit, as this changed by accident
 - Made a one column list
 - Cleared note about precedence
 - Changed example to a full STMPE811 device with MFD, touchscreen, and the new
   stmpe_adc driver.
 - Added Jonathan Cameron's Reviewed-by

Changes in v4:
 - New separate precursor patch for holding reformatting
 - Added Lee Jone's Ack
 - Added Dmitry Torokhov's Ack
 - New patch: split mfd changes into this precursor patch
 - Export the added stmpe811_adc_commmon_init function
 - Disabling adc when mfd is removed
 - New patch: Split changes in stmpe-ts.c to a separate commit
 - Remove common adc settings from init and call the
   stmpe811_adc_common_init function
 - Moved MFD changes to a precursor patch
 - Moved stmpe-ts changes to a precursor patch
 - Created stmpe_read_temp and stmpe_read_voltage functions to make
   read_raw more readable
 - Added local lock instead of using indio_dev's mlock
 - Use be16_to_cpu() macro instead of bitshifting
 - Added stmpe_enable again to stmpe_adc_init_hw
 - Use devm_add_action_or_reset to get rid of the remove function
   (I tested if that actually works)
 - Put reformatting in a separate precursor patch.
 - Moved T30 devicetree settings to separate commit
 - New separate commit to hold T30 devicetree changes

Changes in v3:
 - Undo ADC-settings related code-deletions in stmpe-ts.c that the code
   is backwards-compatible to older devicetrees.
 - Removed COMPILE_TEST from dependings in Kconfig
 - Removed stmpe_adc_get_platform_info() function and integrated the
   few code lines in the other function
 - Reformatted documentation for touchscreen to use tabs and have a better
   overview of the settings.
 - Added note which adc-settings will take precedence.
 - changed typo in sample-time setting from 144 clocks to 124 clocks, as stated
   in the datasheet.
 - None

Changes in v2:
 - This is a new added commit. Separate commit for moving the defines
   out of drivers/input/touchscreen/stmpe-ts.c to overlying mfd-device
   drivers/mfd/stmpe.c
 - Pre-fix defines with STMPE_
 - Move code to setup ADC to MFD device, as it is used by both drivers
   adc and touchscreen
 - Code formatting
 - Removed unused includes
 - Defined the macro STMPE_START_ONE_TEMP_CONV with other macros.
 - Added new macro that defines the channel of the temperature sensor.
   Took new name for STMPE_MAX_ADC->STMPE_ADC_LAST_NR and used it
   throughout the code for better readability.
 - Added mutex_unlock where missing.
 - Moved the bindings for ADC to the overlying mfd.
 - Reformatted for better readability
 - Put common ADC settings in mfd

Philippe Schenker (5):
  dt-bindings: stmpe: reformatting parameter list and use tabs only
  mfd: stmpe: Move ADC related defines to header of mfd
  Input: stmpe-ts: preparations for STMPE ADC driver
  ARM: dts: Add stmpe-adc DT node to Toradex iMX6 modules
  ARM: dts: Add stmpe-adc DT node to Toradex T30 modules

Stefan Agner (3):
  mfd: stmpe: preparations for STMPE ADC driver
  iio: adc: add STMPE ADC driver using IIO framework
  iio: adc: add STMPE ADC devicetree bindings

 .../devicetree/bindings/iio/adc/stmpe-adc.txt |  21 +
 .../bindings/input/touchscreen/stmpe.txt      | 116 ++++--
 .../devicetree/bindings/mfd/stmpe.txt         |  28 +-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi         |  22 +-
 arch/arm/boot/dts/imx6qdl-colibri.dtsi        |  23 +-
 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi    |  22 +-
 arch/arm/boot/dts/tegra30-apalis.dtsi         |  22 +-
 arch/arm/boot/dts/tegra30-colibri.dtsi        |  22 +-
 drivers/iio/adc/Kconfig                       |   7 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/stmpe-adc.c                   | 363 ++++++++++++++++++
 drivers/input/touchscreen/stmpe-ts.c          |  66 +---
 drivers/mfd/Kconfig                           |   3 +-
 drivers/mfd/stmpe.c                           |  68 ++++
 include/linux/mfd/stmpe.h                     |  21 +
 15 files changed, 681 insertions(+), 124 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
 create mode 100644 drivers/iio/adc/stmpe-adc.c

-- 
2.20.1

