Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556A0C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083982082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083982082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbeLJVDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:03:16 -0500
Received: from sauhun.de ([88.99.104.3]:36666 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727728AbeLJVDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:03:15 -0500
Received: from localhost (p54B335CF.dip0.t-ipconnect.de [84.179.53.207])
        by pokefinder.org (Postfix) with ESMTPSA id 0103B4C200E;
        Mon, 10 Dec 2018 22:03:12 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [RFC/RFT 00/10] i2c: move handling of suspended adapters to the core
Date:   Mon, 10 Dec 2018 22:02:58 +0100
Message-Id: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finally, here is the implementation Hans and I agreed on. Plus, all potential
users I could spot already converted. Renesas R-Car driver was added on top.
This series was tested on a Renesas Lager board (R-Car H2). I had to hack some
error cases into the code to verify the workings. I couldn't create an error
case otherwise, this is why further testing with more complex setups is very
welcome.

For my taste, there is still too much boilerplate code for drivers left. Plus,
it is also too easy to put it too early or too late. But I haven't come up with
a better idea yet. And it is time to get this somehow forward.

Please comment, review, test... a branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/core-pm-helpers

Thanks,

   Wolfram

Wolfram Sang (10):
  i2c: add 'is_suspended' flag for i2c adapters
  i2c: reject new transfers when adapters are suspended
  i2c: synquacer: remove unused is_suspended flag
  i2c: brcmstb: use core helper to mark adapter suspended
  i2c: zx2967: use core helper to mark adapter suspended
  i2c: sprd: don't use pdev as variable name for struct device *
  i2c: sprd: use core helper to mark adapter suspended
  i2c: exynos5: use core helper to mark adapter suspended
  i2c: s3c2410: use core helper to mark adapter suspended
  i2c: rcar: add suspend/resume support

 drivers/i2c/busses/i2c-brcmstb.c   | 13 ++-----------
 drivers/i2c/busses/i2c-exynos5.c   | 11 ++---------
 drivers/i2c/busses/i2c-rcar.c      | 25 +++++++++++++++++++++++++
 drivers/i2c/busses/i2c-s3c2410.c   |  8 ++------
 drivers/i2c/busses/i2c-sprd.c      | 34 ++++++++++++----------------------
 drivers/i2c/busses/i2c-synquacer.c |  5 -----
 drivers/i2c/busses/i2c-zx2967.c    |  8 ++------
 drivers/i2c/i2c-core-base.c        |  3 +++
 include/linux/i2c.h                |  9 +++++++++
 9 files changed, 57 insertions(+), 59 deletions(-)

-- 
2.11.0

