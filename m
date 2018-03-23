Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754699AbeCWLrR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 07:47:17 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36946 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754346AbeCWLrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 07:47:13 -0400
X-Google-Smtp-Source: AG47ELsnenhqaPEncTYEORHLDUp8eQlgNyPvTHJkWZzL9WzrkME87LH4Qhuye3EGGTxO4ut8Dt5OJA==
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
Subject: [PATCH v3 0/8] ARM: davinci: complete the conversion to using the reset framework
Date: Fri, 23 Mar 2018 12:47:01 +0100
Message-Id: <20180323114709.20330-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series converts the only user of the handcoded, mach-specific reset
routines in the davinci platform to using the reset framework.

Patch 1 modifies the way lookup entries are registered with the reset
framework.

Patches 2-4 add necessary lookups/DT-properties.

Patches 5-7 convert the davinci-rproc driver to the reset framework.

Patch 8 removes now dead code.

Philipp: it turned out that it's indeed better to use the reset
controller's device name for the entry lookup.

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

Bartosz Golaszewski (8):
  reset: modify the way reset lookup works for board files
  ARM: davinci: dts: make psc0 a reset provider
  ARM: davinci: dts: add a reset control to the dsp node
  clk: davinci: add a reset lookup table for psc0
  remoteproc: da8xx: add the missing retval check for clk_enable()
  remoteproc: da8xx: prepare and unprepare the clock where needed
  remoteproc: da8xx: use the reset framework
  clk: davinci: kill davinci_clk_reset_assert/deassert()

 arch/arm/boot/dts/da850.dtsi               |  2 ++
 arch/arm/mach-davinci/include/mach/clock.h | 21 ---------------
 drivers/clk/davinci/psc-da850.c            |  7 +++++
 drivers/clk/davinci/psc.c                  | 19 +-------------
 drivers/remoteproc/da8xx_remoteproc.c      | 42 +++++++++++++++++++++++++-----
 drivers/reset/core.c                       | 38 ++++++++++++++++++++++-----
 include/linux/reset-controller.h           | 12 +++++----
 7 files changed, 83 insertions(+), 58 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/clock.h

-- 
2.16.1
