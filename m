Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A08C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D80720864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D80720864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755248AbeFRLIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:08:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:37633 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935955AbeFRLHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:07:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 04:07:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,238,1526367600"; 
   d="scan'208";a="233457951"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 18 Jun 2018 04:07:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 72A62124; Mon, 18 Jun 2018 14:07:31 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 0/5] thunderbolt: Add support for runtime PM
Date:   Mon, 18 Jun 2018 14:07:26 +0300
Message-Id: <20180618110731.57427-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

In recent PCs such as Lenovo X1 Carbon 6th generation the Thunderbolt
controller is in RTD3 mode (Runtime D3). This is different from the
previous modes because now the controller is present most of the time (it
still will be hot-removed/hot-added during NVM firmware upgrade). Because
of that we need to dynamically power it down whenever possible to save some
power.

This patch series adds Linux runtime PM support for the Thunderbolt host
controller driver using ICM firmware but it should be generic enough for
future additions to allow similar functionality for the older Apple
hardware as well (even though those system do not support full RTD3, it
still makes it possible for the host controller to go to low power state if
cable is not connected).

With these patches the driver automatically runtime suspends the host
controller after being idle for 15s. The connected Thunderbolt devices (if
any) need to support RTD3 mode as well. Typically all 3rd generation
devices (Alpine Ridge, Titan Ridge) support this.

However, while this provides some power savings, there is more work to do
in order to allow powering down the PCIe root port leading to the
Thunderbolt PCIe hierarchy. This work is still in progress.

Mika Westerberg (5):
  thunderbolt: Use 64-bit DMA mask if supported by the platform
  thunderbolt: Do not unnecessarily call ICM get route
  thunderbolt: No need to take tb->lock in domain suspend/complete
  thunderbolt: Use correct ICM commands in system suspend
  thunderbolt: Add support for runtime PM

 drivers/thunderbolt/domain.c  |  55 ++++++++---
 drivers/thunderbolt/icm.c     | 172 ++++++++++++++++++++++++++++------
 drivers/thunderbolt/nhi.c     |  46 ++++++++-
 drivers/thunderbolt/switch.c  |  65 ++++++++++++-
 drivers/thunderbolt/tb.h      |  10 ++
 drivers/thunderbolt/tb_msgs.h |   4 +
 drivers/thunderbolt/xdomain.c |  18 ++++
 7 files changed, 323 insertions(+), 47 deletions(-)

-- 
2.17.1

