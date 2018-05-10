Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757159AbeEJKtF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 06:49:05 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:28001 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757119AbeEJKtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 06:49:02 -0400
X-IronPort-AV: E=Sophos;i="5.49,385,1520924400";
   d="scan'208";a="14726557"
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <jic23@kernel.org>, <ludovic.desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <dmitry.torokhov@gmail.com>, <robh@kernel.org>
CC: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v5 0/9] Add support for SAMA5D2 touchscreen
Date: Thu, 10 May 2018 13:45:05 +0300
Message-ID: <1525949114-29263-1-git-send-email-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series is a rework of my previous series named:
[PATCH 00/14] iio: triggers: add consumer support

This is the version 5 of the series, and addresses the received feedback
on the v2 series named:
[PATCH v2 00/10]  Add support for SAMA5D2 touchscreen
and the v3 series named
[PATCH v3 00/11]  Add support for SAMA5D2 touchscreen
and the v4 series named
[PATCH v4 0/9]  Add support for SAMA5D2 touchscreen

This series applies on top of fixes-togreg branch of iio.git,
specifically on top of commit:
"f0c8d1f" : iio: adc: at91-sama5d2_adc:
 fix channel configuration for differential channels

Changes in v3, v4 and v5 are presented at the end of the cover letter below.
Thanks everyone for the feedback. Below is the original v2 cover letter:

In few words, this is the implementation of splitting the functionality
of the IP block ADC device in SAMA5D2 SoC from ADC with touchscreen
support. In order to avoid having a MFD device, two separate
drivers that would work on same register base and split the IRQ,etc,
as advised on the mailing list, I created a consumer driver for the
channels, that will connect to the ADC as described in the device tree.

I have collected feedback from everyone and here is the result:
I have added a new generic resistive touchscreen driver, which acts
as a iio consumer for the given channels and will create an input
device and report the events. It uses a callback buffer to register
to the IIO device and waits for data to be pushed.
Inside the IIO device, I have kept a similar approach with the first version
of the series, except that now the driver can take multiple buffers, and
will configure the touchscreen part of the hardware device if the specific
channels are requested.

The SAMA5D2 ADC driver registers three new channels: two for the
position on the X and Y axis, and one for the touch pressure.
When channels are requested, it will check if the touchscreen channel mask
includes the requested channels (it is possible that the consumer driver
will not request pressure for example). If it's the case, it will work
in touchscreen mode, and will refuse to do usual analog-digital conversion,
because we have a single trigger and the touchscreen needs it.
When the scan mask will include only old channels, the driver will function
in the same way as before. If the scan mask somehow is a mix of the two (the
masks intersect), the driver will refuse to work whatsoever (cannot have both
in the same time).
The driver allows reading raw data for the new channels, if claim direct
mode works: no touchscreen driver requested anything. The new channels can
act like the old ones. However, when requesting these channels, the usual
trigger will not work and will not be enabled. The touchscreen channels
require special trigger and irq configuration: pen detect, no pen detect
and a periodic trigger to sample the touchscreen position and pressure.
If the user attempts to use another trigger while there is a buffer
that already requested the touchscreen channels (thus the trigger), the
driver will refuse to comply.

In order to have defines for the channel numbers, I added a bindings include
file that goes on a separate commit :
dt-bindings: iio: adc: at91-sama5d2_adc: add channel specific consumer info
This should go in the same tree with the following commits :
  ARM: dts: at91: sama5d2: add channel cells for ADC device
  ARM: dts: at91: sama5d2: Add resistive touch device

as build will break because these commits depend on the binding one
which creates the included header file.
V5 update: After discussing with Alexandre Belloni on Mailing list, the two
DTS patches are to be taken in the next version after bindings reach mainline.

Changes in v5:
 - renamed property touchscreen-threshold-pressure to touchscreen-min-pressure
 - added one return in touchscreen driver

Changes in v4:
 - removed patch for inkern module get/set kref
 - addressed feedback on both the ADC and the touchscreen driver. each
patch has a history inside the patch file for the specific changes.
 - patch that fixes the channel fix
[PATCH v3 01/11] iio: adc: at91-sama5d2_adc:
 fix channel configuration for differential channels
was accepted in fixes-togreg branch thus removed from this series.
 - added Reviewed-by for the bindings by Rob Herring

Changes in v3:
 - changed input driver name according to feedback and reworked in commits
to adapt to binding changes and new name.
 - moved channel index fix in at91-sama5d2_adc at the beginning of the series
(PATCH 01/11)
 - created a new optional binding for the touchscreen as a separate commit
and added it to the series :
 [PATCH v3 04/11] dt-bindings: input: touchscreen: add pressure
 threshold touchscreen property
 - changed at91-sama5d2_adc driver patch to address the comments. Exact changes
are in the patch file for the driver source file.

Eugen Hristev (9):
  MAINTAINERS: add generic resistive touchscreen adc
  iio: Add channel for Position Relative
  dt-bindings: input: touchscreen: add minimum pressure touchscreen
    property
  dt-bindings: input: touchscreen: resistive-adc-touch: create bindings
  iio: adc: at91-sama5d2_adc: add support for position and pressure
    channels
  input: touchscreen: resistive-adc-touch: add generic resistive ADC
    touchscreen
  dt-bindings: iio: adc: at91-sama5d2_adc: add channel specific consumer
    info
  ARM: dts: at91: sama5d2: add channel cells for ADC device
  ARM: dts: at91: sama5d2: Add resistive touch device

 Documentation/ABI/testing/sysfs-bus-iio            |  12 +
 .../bindings/iio/adc/at91-sama5d2_adc.txt          |   9 +
 .../input/touchscreen/resistive-adc-touch.txt      |  30 +
 .../bindings/input/touchscreen/touchscreen.txt     |   3 +
 MAINTAINERS                                        |   6 +
 arch/arm/boot/dts/sama5d2.dtsi                     |  12 +
 drivers/iio/adc/at91-sama5d2_adc.c                 | 609 +++++++++++++++++++--
 drivers/iio/industrialio-core.c                    |   1 +
 drivers/input/touchscreen/Kconfig                  |  13 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/resistive-adc-touch.c    | 201 +++++++
 include/dt-bindings/iio/adc/at91-sama5d2_adc.h     |  16 +
 include/uapi/linux/iio/types.h                     |   1 +
 tools/iio/iio_event_monitor.c                      |   2 +
 14 files changed, 858 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt
 create mode 100644 drivers/input/touchscreen/resistive-adc-touch.c
 create mode 100644 include/dt-bindings/iio/adc/at91-sama5d2_adc.h

-- 
2.7.4
