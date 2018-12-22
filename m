Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B84C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 20:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2832195D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 20:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392829AbeLVU0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 15:26:34 -0500
Received: from sauhun.de ([88.99.104.3]:52634 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730988AbeLVU0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 15:26:33 -0500
Received: from localhost (p54B67A8B.dip0.t-ipconnect.de [84.182.122.139])
        by pokefinder.org (Postfix) with ESMTPSA id 208C22E3542;
        Sat, 22 Dec 2018 21:26:30 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 0/9] i2c: move handling of suspended adapters to the core
Date:   Sat, 22 Dec 2018 21:26:14 +0100
Message-Id: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the new version without specific I2C helpers but using the
'is_suspended' flag from the PM core. I didn't like messing with the
flag directly, so I did a helper in patch 1. So far, I like the
approach. The diffstat looks nice, and i2c-rcar.c and i2c-sh_mobile.c
rejected rightfully too later transfers without further modifications.
Tested on a Renesas Lager board (R-Car H2).

I dropped a few Tested-by tags because I think this approach is too
different from V1 to keep them. I hope you guys can have a look again.
Thanks for all the testing, so far!

A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/reject-when-suspended

If this series is acceptable, I'd suggest to take it via my i2c tree
after rc1. And then I'll provide an immutable branch for the PM tree to
pick. Let me know if this works for you.

And thanks to Renesas for funding this work!

Thanks and kind regards,

   Wolfram

Wolfram Sang (9):
  PM / core: add helper to return suspend status of a device
  i2c: reject new transfers when adapters are suspended
  i2c: synquacer: remove unused is_suspended flag
  i2c: brcmstb: don't open code to reject transfers when suspended
  i2c: zx2967: don't open code to reject transfers when suspended
  i2c: sprd: don't use pdev as variable name for struct device *
  i2c: sprd: don't open code to reject transfers when suspended
  i2c: exynos5: don't open code to reject transfers when suspended
  i2c: s3c2410: don't open code to reject transfers when suspended

 Documentation/i2c/fault-codes      |  4 ++++
 drivers/i2c/busses/i2c-brcmstb.c   | 22 +-------------------
 drivers/i2c/busses/i2c-exynos5.c   | 10 ----------
 drivers/i2c/busses/i2c-s3c2410.c   |  7 -------
 drivers/i2c/busses/i2c-sprd.c      | 32 ++++++++++--------------------
 drivers/i2c/busses/i2c-synquacer.c |  5 -----
 drivers/i2c/busses/i2c-zx2967.c    |  8 --------
 drivers/i2c/i2c-core-base.c        |  3 +++
 drivers/i2c/i2c-core-smbus.c       |  4 ++++
 include/linux/device.h             |  5 +++++
 10 files changed, 27 insertions(+), 73 deletions(-)

-- 
2.19.1

