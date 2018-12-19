Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC61EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90896217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbeLSQsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:48:36 -0500
Received: from sauhun.de ([88.99.104.3]:55824 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbeLSQsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:48:36 -0500
Received: from localhost (p54B333DA.dip0.t-ipconnect.de [84.179.51.218])
        by pokefinder.org (Postfix) with ESMTPSA id 7E6BA2E3542;
        Wed, 19 Dec 2018 17:48:33 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH 00/10] i2c: move handling of suspended adapters to the core
Date:   Wed, 19 Dec 2018 17:48:16 +0100
Message-Id: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finally, here is the implementation Hans and I agreed on. Plus, all potential
users I could spot already converted. Renesas R-Car driver was added on top.
This series was tested on a Renesas Lager board (R-Car H2). I had to hack some
error cases into the code to verify the workings. Thanks for all the tests so
far. Of course, more testing never hurts ;)

Please comment, review, test... a branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/core-pm-helpers

Thanks,

   Wolfram

Changes since RFC:

* don't use bitfields anymore but an unsigned long flags variable which is only
  meant for flags to be changed when the adapter lock is held

* split the genereic accessor into _mark_suspended() and _mark_resumed()

* added kerneldoc and noted that using these helpers is optional

* documented -ESHUTDOWN as the error code when trying to transfer using an
  already suspended adapter

* added acks from last series. Changes were minor enough to keep them. Please let
  me know if you disagree.


Wolfram Sang (10):
  i2c: add suspended flag and accessors for i2c adapters
  i2c: reject new transfers when adapters are suspended
  i2c: synquacer: remove unused is_suspended flag
  i2c: brcmstb: use core helper to mark adapter suspended
  i2c: zx2967: use core helper to mark adapter suspended
  i2c: sprd: don't use pdev as variable name for struct device *
  i2c: sprd: use core helper to mark adapter suspended
  i2c: exynos5: use core helper to mark adapter suspended
  i2c: s3c2410: use core helper to mark adapter suspended
  i2c: rcar: add suspend/resume support

 Documentation/i2c/fault-codes      |  4 ++++
 drivers/i2c/busses/i2c-brcmstb.c   | 13 ++-----------
 drivers/i2c/busses/i2c-exynos5.c   | 11 ++---------
 drivers/i2c/busses/i2c-rcar.c      | 25 +++++++++++++++++++++++++
 drivers/i2c/busses/i2c-s3c2410.c   |  8 ++------
 drivers/i2c/busses/i2c-sprd.c      | 34 ++++++++++++----------------------
 drivers/i2c/busses/i2c-synquacer.c |  5 -----
 drivers/i2c/busses/i2c-zx2967.c    |  8 ++------
 drivers/i2c/i2c-core-base.c        |  3 +++
 include/linux/i2c.h                | 34 ++++++++++++++++++++++++++++++++++
 10 files changed, 86 insertions(+), 59 deletions(-)

-- 
2.11.0

