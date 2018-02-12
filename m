Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932554AbeBLWsS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:48:18 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37510 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932153AbeBLWsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:16 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 00/45] RTC: nvmem improvements
Date: Mon, 12 Feb 2018 23:47:14 +0100
Message-Id: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series makes some change to the RTC nvmem API to simplify drivers
and clean the way the nvmem_config is used.

The main issue was the different lifecycle of the struct nvmem_config
(only needed at probe time) and rtc_device (needed for the lifetime of
the driver).

Then, it converts the remaining drivers (except ds1685) to the API. A
few other improvements are also made along the way.

Alexandre Belloni (45):
  rtc: documentation: correct nvmem date and version
  rtc: nvmem: pass nvmem_config to rtc_nvmem_register()
  rtc: nvmem: return error values
  rtc: nvmem: disallow registering nvmem more than once
  rtc: export rtc_nvmem_register() to drivers
  rtc: ds1305: call rtc_nvmem_register()
  rtc: ds1305: put ds1305_nvmem_cfg on the stack
  rtc: ds1307: call rtc_nvmem_register()
  rtc: ds1307: put struct nvmem_config on the stack
  rtc: ds1511: call rtc_nvmem_register()
  rtc: ds1511: put ds1511_nvmem_cfg on the stack
  rtc: m48t86: call rtc_nvmem_register()
  rtc: m48t86: put m48t86_nvmem_cfg on the stack
  rtc: omap: call rtc_nvmem_register()
  rtc: pcf85363: call rtc_nvmem_register()
  rtc: pcf85363: put struct nvmem_config on the stack
  rtc: rv8803: call rtc_nvmem_register()
  rtc: rv8803: put struct nvmem_config on the stack
  rtc: rv8803: fix possible race condition
  rtc: remove nvmem_config
  rtc: ds1343: simplify regmap initialization
  rtc: ds1343: switch to rtc_register_device
  rtc: ds1343: remove undocumented and useless sysfs files
  rtc: ds1343: use generic nvmem
  rtc: m48t59: switch to rtc_register_device
  rtc: m48t59: use generic nvmem
  rtc: sirfsoc: remove useless sirfsoc_rtc_ioctl
  rtc: ds1553: switch to rtc_register_device
  rtc: ds1553: use generic nvmem
  rtc: ds1553: make alarms useful
  rtc: cmos: fix possible race condition
  rtc: cmos: use generic nvmem
  rtc: ds1742: switch to rtc_register_device
  rtc: ds1742: use generic nvmem
  rtc: rp5c01: fix possible race condition
  rtc: rp5c01: use generic nvmem
  rtc: stk17ta8: make alarms useful
  rtc: stk17ta8: switch to rtc_register_device
  rtc: stk17ta8: fix possible race condition
  rtc: stk17ta8: use generic nvmem
  rtc: tx4939: remove arch/mips dependency
  rtc: tx4939: extend test coverage
  rtc: tx4939: switch to rtc_register_device
  rtc: tx4939: fix possible race condition
  rtc: tx4939: use generic nvmem

 Documentation/ABI/testing/sysfs-class-rtc |   4 +-
 drivers/rtc/Kconfig                       |   2 +-
 drivers/rtc/class.c                       |   2 -
 drivers/rtc/nvmem.c                       |  29 +++--
 drivers/rtc/rtc-cmos.c                    |  75 ++++++------
 drivers/rtc/rtc-core.h                    |   8 --
 drivers/rtc/rtc-ds1305.c                  |  21 ++--
 drivers/rtc/rtc-ds1307.c                  |  29 ++---
 drivers/rtc/rtc-ds1343.c                  | 183 +++++-------------------------
 drivers/rtc/rtc-ds1511.c                  |  22 ++--
 drivers/rtc/rtc-ds1553.c                  |  74 +++++-------
 drivers/rtc/rtc-ds1742.c                  |  73 ++++++------
 drivers/rtc/rtc-m48t59.c                  |  57 +++++-----
 drivers/rtc/rtc-m48t86.c                  |  23 ++--
 drivers/rtc/rtc-omap.c                    |   3 +-
 drivers/rtc/rtc-pcf85363.c                |  25 ++--
 drivers/rtc/rtc-rp5c01.c                  |  63 +++++-----
 drivers/rtc/rtc-rv8803.c                  |  33 +++---
 drivers/rtc/rtc-sirfsoc.c                 |  18 ---
 drivers/rtc/rtc-stk17ta8.c                |  70 +++++-------
 drivers/rtc/rtc-tx4939.c                  |  87 +++++++++-----
 include/linux/rtc.h                       |  14 ++-
 22 files changed, 380 insertions(+), 535 deletions(-)

-- 
2.16.1
