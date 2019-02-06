Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7C0C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32FC218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZZwa+5hP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbfBFL2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:28:41 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52535 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729778AbfBFL2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:28:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549452521; x=1580988521;
  h=from:to:cc:subject:date:message-id;
  bh=MD0RpfSJyPYnPMaLg3A2LN6EW2fPmTxLI420Z4nlS7A=;
  b=ZZwa+5hPCxEemMTHxwoLGP2/MRPOyjUTV8s/wAMQV08t+8UzTh15f5B+
   sxMfmDC9SbkvUQ+4o/LT2RI2qlzJSKsDul3WcOiUwTgRbOgVIdrcLHyth
   Ni55Ung4JUPbxNRBT0e32VXCCnPWfq9gozb8t6x7n0AscpyB/X7uG/Wnd
   wMbmHHI+tmLokbgdWNCuo+tPY5OPCpZcGR8r9kMfkgpQnJBNGl+IZPPh/
   MJW+ou6VDpiLQJMkJsQUSDsXuMezqXifH/490adS4P6B88XRUvpxiyyT8
   n1S5cD6Q2lt0dVoGFg2FxhyPquZl2bPOIzMoyS3z/pj/+93mrNqPz2sRX
   A==;
X-IronPort-AV: E=Sophos;i="5.56,564,1539619200"; 
   d="scan'208";a="105601449"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2019 19:28:40 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 06 Feb 2019 03:09:26 -0800
Received: from kfae422988.sdcorp.global.sandisk.com ([10.0.230.227])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2019 03:28:37 -0800
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 0/3] mmc: core: Add SD Discard support
Date:   Wed,  6 Feb 2019 13:28:04 +0200
Message-Id: <1549452487-17193-1-git-send-email-avri.altman@wdc.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SD spec v5.1 adds discard support. The flows and commands matches those
in eMMC, Which leaves to set the appropriate discard arg in CMD38 if
DISCARD_SUPPORT (b313) is set in the SD_STATUS register.

We set this arg on card init: not in mmc_init_erase as one might expect
but arbitrarily once the card indicated its discard support.  This is
because unlike erase, it doesn't really involve any logic, and we want
to avoid the unnecessary complication.

V1->v2:
In the first patch, assign the discard arg for SD cards as well to keep
the code consistent. Rename "discard_arg" to "erase_arg", and elaborate
the change log.


Avri Altman (3):
  mmc: core: Calculate the discard arg only once
  mmc: core: Indicate SD specs higher than 4.0
  mmc: core: Add discard support to sd

 drivers/mmc/core/block.c | 12 +++---------
 drivers/mmc/core/core.c  |  8 ++++++--
 drivers/mmc/core/mmc.c   |  8 ++++++++
 drivers/mmc/core/sd.c    | 15 +++++++++++++++
 include/linux/mmc/card.h |  3 +++
 include/linux/mmc/sd.h   |  6 ++++++
 6 files changed, 41 insertions(+), 11 deletions(-)

-- 
1.9.1

