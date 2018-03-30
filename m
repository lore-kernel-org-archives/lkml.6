Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbeC3P3F (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 11:29:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33372 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751356AbeC3P3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 11:29:02 -0400
X-Google-Smtp-Source: AIpwx4+pxCV6VPX7EYQ1Ls+Sufp4KLQ05NgeHwUfKQwXSNLr70egFznIiP2dw1H0K03VThUX/lFXzQ==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 0/8] ARM: davinci: complete the conversion to using the reset framework
Date: Fri, 30 Mar 2018 17:28:48 +0200
Message-Id: <20180330152856.12297-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series converts the only user of the handcoded, mach-specific reset
routines in the davinci platform to using the reset framework.

Patches 1-3 add necessary lookups/DT-properties.

Patches 4-6 fix issues found in the remoteproc davinci driver.

Patch 7 converts the davinci-rproc driver to the reset framework.

Patch 8 removes now dead code.

Tested both in DT and legacy modes by booting the examples from
ti-ipc-rtos recipe in meta-ti.

This series applies on top of David Lechner's common-clk-v9 branch[1]
with Philipp Zabel's reset/next branch[2] pulled in.

It can be found in my github tree as well[3].

[1] git://github.com/dlech/ev3dev-kernel.git common-clk-v9
[2] git://git.pengutronix.de/git/pza/linux reset/next
[3] git@github.com:brgl/linux.git topic/davinci-reset

v1 -> v2:
- fixed the device tree patches the descriptions of which were mixed up
- return -EPROBE_DEFER from davinci-rproc's probe() if we can't get the
  reset provider, since it's possible that the lookup table was not yet
  registered
- made the local variable naming consistent in the davinci-rproc driver
- fixed a typo in PATCH 5/8

v2 -> v3:
- modify PATCH 1/8: drop the provider argument from the function adding
  lookup entries and instead pass the provider name to the RESET_LOOKUP
  macro, return -EPROBE_DEFER if we locate a correct lookup entry but
  cannot get the corresponding reset controller
- modify the reset lookup entry in psc-da850
- don't manually return -EPROBE_DEFER from davinci-rproc, instead don't
  emit an error message if devm_reset_control_get_exclusive() returns
  this error code

v3 -> v4:
- make index the second parameter in RESET_LOOKUP() (right after the
  provider name)

v4 -> v5:
- fix a bug where the dsp_reset object correctly stored in drproc struct

Bartosz Golaszewski (8):
  ARM: davinci: dts: make psc0 a reset provider
  ARM: davinci: dts: add a reset control to the dsp node
  clk: davinci: add a reset lookup table for psc0
  remoteproc/davinci: add the missing retval check for clk_enable()
  remoteproc/davinci: prepare and unprepare the clock where needed
  remoteproc/davinci: use octal permissions for module_param()
  remoteproc/davinci: use the reset framework
  clk: davinci: kill davinci_clk_reset_assert/deassert()

 arch/arm/boot/dts/da850.dtsi               |  2 ++
 arch/arm/mach-davinci/include/mach/clock.h | 21 --------------
 drivers/clk/davinci/psc-da850.c            |  7 +++++
 drivers/clk/davinci/psc.c                  | 19 +-----------
 drivers/remoteproc/da8xx_remoteproc.c      | 46 ++++++++++++++++++++++++------
 5 files changed, 48 insertions(+), 47 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/clock.h

-- 
2.16.3
