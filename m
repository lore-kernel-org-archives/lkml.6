Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A08C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C249C20855
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QwY2ClQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfBCIuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 03:50:52 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:15409 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfBCIuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 03:50:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549183852; x=1580719852;
  h=from:to:cc:subject:date:message-id;
  bh=6c/3Naq/+s4XBGq5QNQtJjin63v2a5rmbaKk9XMLyKg=;
  b=QwY2ClQNSCWu8IwJ59wGh4bbJTL6C1tcoBiG/tzmUuKBkeNplDdmUVt5
   LLGWfZ7dAJDZWUi8RpgWQ5lViLqqFD1dUc8Hl/BmYEod1xiM/DJDSbKzV
   6WzWoRprNzODkY7sG6uLNpa4B08JownVVMwA/jelKeyp3HlhmHLaAuFZw
   eZn/z/5GHkxynhUS6HbALDTdt9c8ilR20TrhB81h63UkilBzWK1DTwqAR
   ADGj9CXfu+nCMLH0x3FSBhLkfBBBNBxnBhQ/Y9Y8EisoDbeTewExLe8JT
   uMjrxMwcAorjLvBf617qgW/UBsD3wwW10L5hTQ/ZUfeJiRk6ekhtOysdt
   A==;
X-IronPort-AV: E=Sophos;i="5.56,555,1539619200"; 
   d="scan'208";a="105387539"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2019 16:50:51 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 03 Feb 2019 00:29:42 -0800
Received: from kfae422988.sdcorp.global.sandisk.com ([10.0.230.227])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Feb 2019 00:50:48 -0800
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 0/3] mmc: core: Add SD Discard support
Date:   Sun,  3 Feb 2019 10:50:25 +0200
Message-Id: <1549183828-17316-1-git-send-email-avri.altman@wdc.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D spec v5.1 adds discard support. The flows and commands matches those
in eMMC, Which leaves to set the appropriate discard arg in CMD38 if
DISCARD_SUPPORT (b313) is set in the SD_STATUS register.

We set this arg on card init: not in mmc_init_erase as one might expect
but arbitrarily once the card indicated its discard support.  This is
because unlike erase, it doesn't really involve any logic, and we want
to avoid the unnecessary complication.

Avri Altman (3):
  mmc: core: Calculate the discard arg only once
  mmc: core: Indicate SD specs higher than 4.0
  mmc: core: Add discard support to sd

 drivers/mmc/core/block.c | 12 +++---------
 drivers/mmc/core/core.c  |  6 +++++-
 drivers/mmc/core/mmc.c   |  8 ++++++++
 drivers/mmc/core/sd.c    | 15 +++++++++++++++
 include/linux/mmc/card.h |  4 ++++
 include/linux/mmc/sd.h   |  6 ++++++
 6 files changed, 41 insertions(+), 10 deletions(-)

-- 
1.9.1

