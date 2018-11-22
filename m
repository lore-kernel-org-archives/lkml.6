Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20A3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 04:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92AE320831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 04:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92AE320831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392059AbeKVPP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 10:15:56 -0500
Received: from mail5.windriver.com ([192.103.53.11]:53136 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388948AbeKVPPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 10:15:55 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wAM4XWFb012233
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 21 Nov 2018 20:33:43 -0800
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Wed, 21 Nov 2018
 20:33:22 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cory Maccarrone <darkstar6262@gmail.com>,
        Dong Aisheng <dong.aisheng@linaro.org>,
        Graeme Gregory <gg@slimlogic.co.uk>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Haojian Zhuang <haojian.zhuang@marvell.com>,
        Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mattias Nilsson <mattias.i.nilsson@stericsson.com>,
        Tony Lindgren <tony@atomide.com>, <linux-omap@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Support Opensource <support.opensource@diasemi.com>
Subject: [PATCH 00/11] mfd: simple demodularization of non-modular drivers
Date:   Wed, 21 Nov 2018 23:32:48 -0500
Message-ID: <1542861179-8941-1-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This group of MFD drivers are all controlled by "bool" Kconfig settings,
but contain traces of module infrastructure like unused/orphaned __exit
functions, use of <linux/module.h> and/or MODULE_ macros that are no-ops
in the non-modular case.

We can remove/replace all of the above.  We are trying to make driver
code consistent with the Makefiles/Kconfigs that control them.  This
means not using modular functions/macros for drivers that can never be
built as a module.  Some of the downfalls this leads to are:

 (1) it is easy to accidentally write unused module_exit and remove code
 (2) it can be misleading when reading the source, thinking it can be
     modular when the Makefile and/or Kconfig prohibit it
 (3) it requires the include of the module.h header file which in turn
     includes nearly everything else, thus adding to CPP overhead.
 (4) it gets copied/replicated into other drivers and spreads quickly.

The changes here should represent zero runtime changes.  Only the ones
with removed __exit functions will have a slightly smaller object size.
The source gets a net reduction of 100+ lines of unused code.

Build testing was done on drivers/mfd for allyesconfig on x86_64, ARM
and ARM-64.

Paul.

---

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Cory Maccarrone <darkstar6262@gmail.com>
Cc: Dong Aisheng <dong.aisheng@linaro.org>
Cc: Graeme Gregory <gg@slimlogic.co.uk>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Mattias Nilsson <mattias.i.nilsson@stericsson.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: patches@opensource.cirrus.com
Cc: Support Opensource <support.opensource@diasemi.com>

Paul Gortmaker (11):
  mfd: as3711: Make it explicitly non-modular
  mfd: da9055-core: make it explicitly non-modular
  mfd: db8500-prcmu: drop unused MODULE_ tags from non-modular code
  mfd: htc-i2cpld: Make it explicitly non-modular
  mfd: max8925-core: drop unused MODULE_ tags from non-modular code
  mfd: rc5t583: Make it explicitly non-modular
  mfd: sta2x11: drop unused MODULE_ tags from non-modular code
  mfd: syscon: Make it explicitly non-modular
  mfd: tps65910: Make it explicitly non-modular
  mfd: wm831x-core: drop unused MODULE_ tags from non-modular code
  mfd: wm8400-core: Make it explicitly non-modular

 drivers/mfd/as3711.c       | 14 --------------
 drivers/mfd/da9055-core.c  | 13 ++-----------
 drivers/mfd/db8500-prcmu.c | 10 ++++------
 drivers/mfd/htc-i2cpld.c   | 18 +-----------------
 drivers/mfd/max8925-core.c |  7 +------
 drivers/mfd/rc5t583.c      | 14 --------------
 drivers/mfd/sta2x11-mfd.c  | 10 ++++------
 drivers/mfd/syscon.c       | 12 +-----------
 drivers/mfd/tps65910.c     | 18 +-----------------
 drivers/mfd/wm831x-core.c  |  7 ++-----
 drivers/mfd/wm8400-core.c  | 18 +++---------------
 11 files changed, 19 insertions(+), 122 deletions(-)

-- 
2.7.4
