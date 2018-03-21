Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbeCUMIb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 08:08:31 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45872 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbeCUMIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 08:08:25 -0400
X-Google-Smtp-Source: AG47ELuoDslTI27abxWqj5MaR4XMM0CA1/0oJcN7Sz0EDuWvd058Dc03M0RmzhhmP+DQ8jWlBmuqyA==
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
Subject: [PATCH 0/8] ARM: davinci: complete the conversion to using the reset framework
Date: Wed, 21 Mar 2018 13:07:59 +0100
Message-Id: <20180321120807.18032-1-brgl@bgdev.pl>
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

Bartosz Golaszewski (8):
  reset: modify the way reset lookup works for board files
  ARM: davinci: dts: make psc0 a reset provider
  ARM: davinci: dts: add a reset control to the dsp node
  clk: davinci: add a reset lookup table for psc0
  remoteproc: da8xx: add the missing checke for clk_enable()
  remoteproc: da8xx: prepare and unprepare the clock where needed
  remoteproc: da8xx: use the reset framework
  clk: davinci: kill davinci_clk_reset_assert/deassert()

 arch/arm/boot/dts/da850.dtsi               |  2 ++
 arch/arm/mach-davinci/include/mach/clock.h | 21 ----------------
 drivers/clk/davinci/psc-da850.c            |  8 ++++++
 drivers/clk/davinci/psc.c                  | 19 +-------------
 drivers/remoteproc/da8xx_remoteproc.c      | 40 ++++++++++++++++++++++++------
 drivers/reset/core.c                       | 33 +++++++++++++++++++++---
 include/linux/reset-controller.h           |  8 +++---
 7 files changed, 78 insertions(+), 53 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/clock.h

-- 
2.16.1
