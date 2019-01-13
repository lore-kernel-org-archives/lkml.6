Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AD4C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B2920873
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfAMUAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 15:00:11 -0500
Received: from mail1.windriver.com ([147.11.146.13]:50247 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfAMUAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 15:00:09 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x0DIb0TF026179
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 13 Jan 2019 10:37:00 -0800 (PST)
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 13 Jan 2019
 10:37:00 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Alessandro Rubini <rubini@gnudd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Cory Maccarrone <darkstar6262@gmail.com>,
        Davide Ciminaghi <ciminaghi@gnudd.com>,
        Dong Aisheng <dong.aisheng@linaro.org>,
        Graeme Gregory <gg@slimlogic.co.uk>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Haojian Zhuang <haojian.zhuang@marvell.com>,
        Jin Park <jinyoungp@nvidia.com>,
        Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Mattias Nilsson <mattias.i.nilsson@stericsson.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Tony Lindgren <tony@atomide.com>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        <linux-omap@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH v5 00/18] mfd: demodularization of non-modular drivers
Date:   Sun, 13 Jan 2019 13:36:31 -0500
Message-ID: <1547404609-14161-1-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[v4 --> v5: add more acks, re-do build tests on newest linux-next after
the 5.0 merge window closed.]

[v3 --> v4: delete now unused exit fcn from wm835x core; add more acks
 now all in chrono order, re-test.]

[v2 --> v3: drop diasemi commits as they will be modularized; delete
 now unused exit fcn from wm831x core; add more acks; re-test.]

[v1 --> v2: add some more commits as requested by Lee (MFD maintainer),
 update the 00/NN text; re-do build and link testing on new linux-next. ]

This group of MFD drivers are all controlled by "bool" Kconfig settings,
but contain various amounts of largely pointless uses of infrastructure
related to modular operations, even though they can't be built modular.

We can easily remove/replace all of it.  We are trying to make driver
code consistent with the Makefiles/Kconfigs that control them.  This
means not using modular functions/macros for drivers that can never be
built as a module.  Some of the downfalls this oversight leads to are:

 (1) it is easy to accidentally write unused module_exit and remove code
 (2) it can be misleading when reading the source, thinking it can be
     modular when the Makefile and/or Kconfig prohibit it
 (3) it requires the include of the module.h header file which in turn
     includes nearly everything else, thus adding a lot of CPP overhead.
 (4) it gets copied/replicated into other drivers and spreads quickly.

What we see in current drivers falls into one or more of the following
categories:

1) include of <linux/module.h> when it simply isn't needed

2) Use of MODULE_LICENSE, MODULE_DEVICE_TABLE,  MODULE_AUTHOR etc. 
   macros that are no-ops for non-modular drivers.

3) Creation of a module_exit() function that will be compiled and
   linked in but never actually called for non-modular drivers.

4) Addition of a platform_driver ".remove" function that is bound
   into the struct but will never be called for non-module use cases.

Solution to #1 --> #3 is simple ; we just delete the related code.

The solution to #4 is similar - we delete the ".remove" function and
the binding into the platform_driver struct.  However, since the same
".remove" function could also be triggered by an "unbind" (such as for
pass-through of a device to a guest instance)  - so we also explicitly
disable any unbind for the driver.

The unbind mask allows us to ensure we will see if there was some odd
corner case out there that was relying on it.  Typically it would be a
multi-port ethernet card passing a port through to a guest, so a
sensible use case in MFD drivers seems highly unlikely.  This same
solution has already been used in multiple other mainline subsystems.

Build testing was done on drivers/mfd for allyesconfig on x86_64, ARM
and ARM-64 on a recent linux-next checkout.

Paul.

---

Cc: Alessandro Rubini <rubini@gnudd.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Cory Maccarrone <darkstar6262@gmail.com>
Cc: Davide Ciminaghi <ciminaghi@gnudd.com>
Cc: Dong Aisheng <dong.aisheng@linaro.org>
Cc: Graeme Gregory <gg@slimlogic.co.uk>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Jin Park <jinyoungp@nvidia.com>
Cc: Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Mattias Nilsson <mattias.i.nilsson@stericsson.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Venu Byravarasu <vbyravarasu@nvidia.com>
Cc: linux-omap@vger.kernel.org
Cc: patches@opensource.cirrus.com

Paul Gortmaker (18):
  mfd: aat2870-core: Make it explicitly non-modular
  mfd: adp5520: Make it explicitly non-modular
  mfd: as3711: Make it explicitly non-modular
  mfd: db8500-prcmu: drop unused MODULE_ tags from non-modular code
  mfd: htc-i2cpld: Make it explicitly non-modular
  mfd: max8925-core: drop unused MODULE_ tags from non-modular code
  mfd: rc5t583: Make it explicitly non-modular
  mfd: sta2x11: drop unused MODULE_ tags from non-modular code
  mfd: syscon: Make it explicitly non-modular
  mfd: tps65090: Make it explicitly non-modular
  mfd: tps65910: Make it explicitly non-modular
  mfd: tps80031: Make it explicitly non-modular
  mfd: wm831x-spi: Make it explicitly non-modular
  mfd: wm831x-i2c: Make it explicitly non-modular
  mfd: wm831x-core: drop unused module infrastructure from non-modular code
  mfd: wm8350-i2c: Make it explicitly non-modular
  mfd: wm8350-core: drop unused module infrastructure from non-modular code
  mfd: wm8400-core: Make it explicitly non-modular

 drivers/mfd/aat2870-core.c      | 40 +++-------------------------------------
 drivers/mfd/adp5520.c           | 30 +++++++-----------------------
 drivers/mfd/as3711.c            | 14 --------------
 drivers/mfd/db8500-prcmu.c      | 10 ++++------
 drivers/mfd/htc-i2cpld.c        | 18 +-----------------
 drivers/mfd/max8925-core.c      |  7 +------
 drivers/mfd/rc5t583.c           | 14 --------------
 drivers/mfd/sta2x11-mfd.c       | 10 ++++------
 drivers/mfd/syscon.c            | 12 +-----------
 drivers/mfd/tps65090.c          | 30 +++++-------------------------
 drivers/mfd/tps65910.c          | 18 +-----------------
 drivers/mfd/tps80031.c          | 37 ++-----------------------------------
 drivers/mfd/wm831x-core.c       | 15 ++-------------
 drivers/mfd/wm831x-i2c.c        | 20 ++------------------
 drivers/mfd/wm831x-spi.c        | 24 ++----------------------
 drivers/mfd/wm8350-core.c       | 30 ++----------------------------
 drivers/mfd/wm8350-i2c.c        | 24 +-----------------------
 drivers/mfd/wm8400-core.c       | 18 +++---------------
 include/linux/mfd/wm831x/core.h |  1 -
 include/linux/mfd/wm8350/core.h |  1 -
 20 files changed, 41 insertions(+), 332 deletions(-)

-- 
2.7.4
