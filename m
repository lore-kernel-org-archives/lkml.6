Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbeECN0U (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 09:26:20 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:55861 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbeECN0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 09:26:15 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
CC: Yixun Lan <yixun.lan@amlogic.com>, Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v8 0/5] clk: meson-axg: Add AO Cloclk and Reset driver
Date: Thu, 3 May 2018 21:26:19 +0800
Message-ID: <20180503132624.78453-1-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.235]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This patch try to add AO clock and Reset driver for Amlogic's
Meson-AXG SoC.

 patch 1: factor the common code into a dedicated file
 patch 2-4: add the aoclk driver for AXG SoC
 patch 5: drop unnecessary clock flags

changes since v7 at [8]: 
 - drop the 'drop CLK_IGNORE_UNUSED flag' patch
   to avoid circle dependencies
 - fix Philip's Ack on patch 3

changes since v6 at [7]: 
 - fix over 80 chars chechpatch error
 - add Philip's Ack on patch 5
 - drop extra end of newline

changes since v5 at [6]: 
 - drop unnecessary header files
 - add 'axg_aoclk' prefix to clk driver, make them more consistent
 - add missing end new line..

changes since v4 at [5]: 
 - fix return err
 - introduce CONFIG_COMMON_CLK_MESON_AO
 - format/style minor fix

changes since v3 at [4]: 
 - add 'const' contraint to the read-only data
 - switch to devm_of_clk_add_hw_provider API
 - check return value of devm_reset_controller_register

changes since v2 at [2]: 
 - rework meson_aoclkc_probe() which leverage the of_match_data
 - merge patch 5-6 into this series
 - seperate DTS patch, will send to Kevin Hilman independently
 
changes since v1 at [0]: 
 - rebase to clk-meson's branch 'next/drivers' [1]
 - fix license, update to BSD-3-Clause
 - drop un-used include header file

[0] https://lkml.kernel.org/r/20180209070026.193879-1-yixun.lan@amlogic.com
[1] git://github.com/BayLibre/clk-meson.git branch: next-drivers
[2] https://lkml.kernel.org/r/20180323143816.200573-1-yixun.lan@amlogic.com
[3] https://lkml.kernel.org/r/20180326081809.49493-4-yixun.lan@amlogic.com
[4] https://lkml.kernel.org/r/20180328025050.221585-1-yixun.lan@amlogic.com
[5] https://lkml.kernel.org/r/20180408031938.153474-1-yixun.lan@amlogic.com
[6] https://lkml.kernel.org/r/20180409143749.71197-1-yixun.lan@amlogic.com
[7] https://lkml.kernel.org/r/20180419135426.155794-1-yixun.lan@amlogic.com
[8] https://lkml.kernel.org/r/20180426084437.192394-1-yixun.lan@amlogic.com


Qiufang Dai (1):
  clk: meson-axg: Add AO Clock and Reset controller driver

Yixun Lan (4):
  clk: meson: aoclk: refactor common code into dedicated file
  dt-bindings: clock: axg-aoclkc: New binding for Meson-AXG SoC
  dt-bindings: clock: reset: Add AXG AO Clock and Reset Bindings
  clk: meson: drop CLK_SET_RATE_PARENT flag

 .../bindings/clock/amlogic,gxbb-aoclkc.txt    |   1 +
 drivers/clk/meson/Kconfig                     |   8 +
 drivers/clk/meson/Makefile                    |   3 +-
 drivers/clk/meson/axg-aoclk.c                 | 164 ++++++++++++++++++
 drivers/clk/meson/axg-aoclk.h                 |  29 ++++
 drivers/clk/meson/gxbb-aoclk.c                |  96 ++++------
 drivers/clk/meson/gxbb-aoclk.h                |   5 +
 drivers/clk/meson/meson-aoclk.c               |  81 +++++++++
 drivers/clk/meson/meson-aoclk.h               |  34 ++++
 include/dt-bindings/clock/axg-aoclkc.h        |  26 +++
 include/dt-bindings/reset/axg-aoclkc.h        |  20 +++
 11 files changed, 403 insertions(+), 64 deletions(-)
 create mode 100644 drivers/clk/meson/axg-aoclk.c
 create mode 100644 drivers/clk/meson/axg-aoclk.h
 create mode 100644 drivers/clk/meson/meson-aoclk.c
 create mode 100644 drivers/clk/meson/meson-aoclk.h
 create mode 100644 include/dt-bindings/clock/axg-aoclkc.h
 create mode 100644 include/dt-bindings/reset/axg-aoclkc.h

-- 
2.17.0
