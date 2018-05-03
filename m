Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbeECW4T (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 18:56:19 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33791 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbeECW4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 18:56:16 -0400
X-Google-Smtp-Source: AB8JxZpxyorJRs6f7SLdm+qWbfe7pWMErC8JPWArkHsNthuHhLxeSQg4jC85my06HMz3RnsNltNMmQ==
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
Subject: [PATCH v2 0/4] Restore ULPI USB on Tegra20
Date: Fri,  4 May 2018 01:55:32 +0300
Message-Id: <20180503225537.20748-1-digetx@gmail.com>
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

Changelog:

v2:
	- Added new patch "Add quirk for getting CDEV1/2 clocks", assuring
	  that clk user won't get CDEV1/2 clocks until parent clk muxes
	  are available, i.e. resolves potential issue with CDEV-user driver
	  vs pinctrl driver probe order.

	- Factored out "pinctrl" patch from the patchset as was requested by
	  Linus Walleij.

	- Addressed v1 review comments: fixed swapped DEV1/2 clk div bits,
	  made DEV1/2 divs read-only, etc minor changes.

Dmitry Osipenko (4):
  clk: tegra20: Add DEV1/DEV2 OSC dividers
  clk: tegra20: Correct parents of CDEV1/2 clocks
  clk: tegra: Add quirk for getting CDEV1/2 clocks
  ARM: dts: tegra20: Revert "Fix ULPI regression on Tegra20"

 arch/arm/boot/dts/tegra20.dtsi  |  2 +-
 drivers/clk/tegra/clk-tegra20.c | 20 +++++++++++++++----
 drivers/clk/tegra/clk.c         | 34 ++++++++++++++++++++++++++++++++-
 3 files changed, 50 insertions(+), 6 deletions(-)

-- 
2.17.0
