Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeDYJel (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:34:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:13791 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751591AbeDYJdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:33:10 -0400
X-UUID: 8de0c26095b04ee1b357dec5444e1e84-20180425
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <matthias.bgg@gmail.com>,
        <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Sean Wang" <sean.wang@mediatek.com>
Subject: [PATCH v2 00/17] Add support to MT6323 RTC and its power device
Date: Wed, 25 Apr 2018 17:32:26 +0800
Message-ID: <cover.1524646231.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

v2:

- The changes must be relative to the below tree since one critial patch
  for the rtc-mt6397.c the series depends on was being applied into
  the tree. Otherwise, for example, if the series are applied on the top
  of [1], a build error must happen due to an implicit declaration of
  function 'irq_create_mapping' as kbuild test robot was reporting in [2].
  
  tree    : https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
  branch  : mfd/ib-mfd-input-rtc-4.18

- changes since v1:
  * Define the power controller as a function of MT6323 MFD.
  * Refine the whole series commit message and title.
  * Add tag Reviewed-by and Acked-by got from v1 result.
  * Reuse use the DEFINE_RES_* helpers in mfd driver.
  * Remove an overdone patch rtc: mediatek: remove unnecessary parentheses.
  * Use devm_rtc_allocate_device() and rtc_register_device instead of
    devm_rtc_device_register.
  * Have an improvement according to the license rule the SPDX notation
    for C header file.
  * Move a file from include/linux/rtc/mt6397.h to include/linux/mfd/mt6397/rtc.h
  * Refine include/linux/mfd/mt6397/rtc.h

[1] https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git
[2] http://lists.infradead.org/pipermail/linux-mediatek/2018-March/012548.html

v1:

Hi,

The series keeps to extend the capability of BPI-R2 board with MT7623 and
the result can as well bring benefits into the other MediaTek PMICs such
as MT6397 or SoCs.

The series sent across mfd, rtc, pm, dt-binding sub-system is for hoping
to let people have a simple cross-reference to know the exact dependency
and why those patches are being split in that way between each one.

Patch 1-3: Add dt-binding to the related devices newly or already
	   supported.
Patch 4-5: Extend driver with the functionality of MT6323 RTC device.
Patch 6-9 and 12-13: Add a few of trivial fixups, cleanups and
	  improvements.
Patch 10-11: It's a preparation for Patch 14 adding a new driver.
Patch 14: Add a new driver for a power-off driver.
Patch 15-16: Update MAINTAINERS with these new files being added.

	Sean

Sean Wang (17):
  dt-bindings: power: reset: mt6323: add bindings for MT6323 power
    controller
  dt-bindings: rtc: mt6397: add bindings for MediaTek PMIC based RTC
  dt-bindings: mfd: mt6397: add a description for MT6323 RTC
  dt-bindings: mfd: mt6397: add a description for MT6323 power
    controller
  mfd: mt6397: add MT6323 RTC support into MT6397 driver
  mfd: mt6397: add support for MT6323 power controller into MT6397
    driver
  mfd: mt6397: reuse DEFINE_RES_* helpers
  rtc: mt6397: add MT6323 support to RTC driver
  rtc: mt6397: replace a poll with regmap_read_poll_timeout
  rtc: mt6397: remove unnecessary irq_dispose_mapping
  rtc: mt6397: convert to use device managed functions
  rtc: mt6397: move the declaration into a globally visible header file
  rtc: mt6397: cleanup header files to include
  rtc: mt6397: update license converting to using SPDX identifiers
  power: reset: mt6323: add a driver for MT6323 power controller
  MAINTAINERS: update entry for ARM/Mediatek RTC DRIVER
  MAINTAINERS: add an entry for MediaTek board level shutdown driver

 Documentation/devicetree/bindings/mfd/mt6397.txt   |  10 +-
 .../bindings/power/reset/mt6323-poweroff.txt       |  20 +++
 .../devicetree/bindings/rtc/rtc-mt6397.txt         |  29 ++++
 MAINTAINERS                                        |   9 ++
 drivers/mfd/mt6397-core.c                          |  40 ++++--
 drivers/power/reset/Kconfig                        |  10 ++
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/mt6323-poweroff.c              |  97 ++++++++++++++
 drivers/rtc/rtc-mt6397.c                           | 146 +++++----------------
 include/linux/mfd/mt6397/rtc.h                     |  71 ++++++++++
 10 files changed, 308 insertions(+), 125 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
 create mode 100644 drivers/power/reset/mt6323-poweroff.c
 create mode 100644 include/linux/mfd/mt6397/rtc.h

-- 
2.7.4
