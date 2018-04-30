Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbeD3IZU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 04:25:20 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42778 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbeD3IZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 04:25:19 -0400
X-Google-Smtp-Source: AB8JxZprX2aBItz735HnaXdsUCGyMtMsAhchmsSjYPPoSrTJy1YTQ+lYvKNu/T/yYf9/+rqYMLZGMg==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>, Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 00/12] mtd: nand: davinci: stop using pdev->id as chipselect
Date: Mon, 30 Apr 2018 10:24:41 +0200
Message-Id: <20180430082453.8091-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We have the 'ti,davinci-chipselect' property in the device tree, but
when using platform data the driver silently uses the id field of
struct platform_device as the chipselect. This is confusing and we
almost broke the nand support again recently after converting the
platform to common clock framework (which changed the device id in the
clock lookup - the problem is gone now that we no longer acquire the
clock in the nand driver.

This series adds a new field to davinci-nand platform data, then makes
all board use it and finally modifies the two drivers that make use of
it.

Bartosz Golaszewski (12):
  mtd: nand: davinci: store the core chipselect number in platform data
  ARM: davinci: da830-evm: specify the chipselect in davinci_nand_pdata
  ARM: davinci: da850-evm: specify the chipselect in davinci_nand_pdata
  ARM: davinci: dm355-evm: specify the chipselect in davinci_nand_pdata
  ARM: davinci: dm355-leopard: specify the chipselect in
    davinci_nand_pdata
  ARM: davinci: dm365-evm: specify the chipselect in davinci_nand_pdata
  ARM: davinci: dm644x-evm: specify the chipselect in davinci_nand_pdata
  ARM: davinci: mityomapl138: specify the chipselect in
    davinci_nand_pdata
  ARM: davinci: dm646x-evm: specify the chipselect in davinci_nand_pdata
  ARM: davinci: neuros-osd2: specify the chipselect in
    davinci_nand_pdata
  mtd: nand: davinci: stop using pdev->id as chipselect
  ARM: davinci: aemif: stop using pdev->id as nand chipselect

 arch/arm/mach-davinci/aemif.c               | 8 ++++----
 arch/arm/mach-davinci/board-da830-evm.c     | 1 +
 arch/arm/mach-davinci/board-da850-evm.c     | 1 +
 arch/arm/mach-davinci/board-dm355-evm.c     | 1 +
 arch/arm/mach-davinci/board-dm355-leopard.c | 1 +
 arch/arm/mach-davinci/board-dm365-evm.c     | 1 +
 arch/arm/mach-davinci/board-dm644x-evm.c    | 1 +
 arch/arm/mach-davinci/board-dm646x-evm.c    | 1 +
 arch/arm/mach-davinci/board-mityomapl138.c  | 1 +
 arch/arm/mach-davinci/board-neuros-osd2.c   | 1 +
 drivers/mtd/nand/raw/davinci_nand.c         | 6 +++---
 include/linux/platform_data/mtd-davinci.h   | 2 ++
 12 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.17.0
