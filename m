Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757195AbeDZX67 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 19:58:59 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33237 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbeDZX64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 19:58:56 -0400
X-Google-Smtp-Source: AB8JxZrFWXeKnAps6CBZiOfKEfLYVHdWNYAvKggn3mbMjoqPdt2bWk9rKOpHIP9/+v/6roaoI4hORQ==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marcel Ziswiler <marcel@ziswiler.com>, Marc Dietrich <marvin24@gmx.de>
Cc: linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] Restore ULPI USB on Tegra20
Date: Fri, 27 Apr 2018 02:58:14 +0300
Message-Id: <20180426235818.10018-1-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series of patches fixes ULPI USB on Tegra20. The original problem
was reported by Marcel Ziswiler, he found that "ulpi-link" clock was
incorrectly set to CDEV2 instead of PLL_P_OUT4. Marcel made a patch
that changed the "ulpi-link" clock to PLL_P_OUT4 and that fixed issue
with the USB for the devices that have CDEV2 being enabled by bootloader.
The patch got into the kernel and later Marc Dietrich found that USB
stopped working on the "paz00" Tegra20 board. After a bit of discussion
was revealed that PLL_P_OUT4 is the parent clock of the CDEV2 and clock
driver was setting CDEV2's parent incorrectly. The parent clock is actually
determined by the pinmuxing config of CDEV2 pingroup. This patchset fixes
the parent of CDEV2 clock by making Tegra's pinctrl driver a clock provider,
providing CDEV1/2 clock muxes (thanks to Peter De Schrijver for the
suggestion), and then setting these clock muxes as parents for the CDEV1/2
clocks. In the end Marcel's CDEV2->PLL_P_OUT4 change is reverted since CDEV2
(aka MCLK2) is the actual clock source for "ulpi-link".

Dmitry Osipenko (4):
  clk: tegra20: Add DEV1/DEV2 OSC dividers
  pinctrl: tegra20: Provide CDEV1/2 clock muxes
  clk: tegra20: Set correct parents for CDEV1/2 clocks
  ARM: dts: tegra20: Revert "Fix ULPI regression on Tegra20"

 arch/arm/boot/dts/tegra20.dtsi          |  2 +-
 drivers/clk/tegra/clk-tegra20.c         | 18 +++++++++++----
 drivers/pinctrl/tegra/pinctrl-tegra.c   | 11 ---------
 drivers/pinctrl/tegra/pinctrl-tegra.h   | 11 +++++++++
 drivers/pinctrl/tegra/pinctrl-tegra20.c | 30 ++++++++++++++++++++++++-
 5 files changed, 55 insertions(+), 17 deletions(-)

-- 
2.17.0
