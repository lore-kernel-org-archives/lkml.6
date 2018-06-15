Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C128BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73628208DA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73628208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965797AbeFONU0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:20:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:65337 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936212AbeFONUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:20:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 06:20:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,227,1526367600"; 
   d="scan'208";a="232854769"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 15 Jun 2018 06:20:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3AE2F29B; Fri, 15 Jun 2018 16:20:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/5] bitmap: Introduce alloc/free helpers
Date:   Fri, 15 Jun 2018 16:20:12 +0300
Message-Id: <20180615132017.23889-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of code is using allocation of bitmaps using BITS_PER_LONG() macro and
sizeof(unsigned long) operator. The readability suffers because of this.

The series introduces three helpers, i.e. bitmap_alloc(), bitmap_zalloc() and
bitmap_free(), to make it more cleaner.

Patch 1 is a preparatory to avoid namespace collisions between bitmap API and
MD bitmap. No functional changes intended.

Patch 2 is just orphaned from previous release cycle.

Patch 3 introduces new helpers.

Patches 4 and 5 is just an example how to use new helpers. Locally I have like
dozen of them against different subsystems and drivers.

Ideally it would go through Input subsystem, thus, needs an Ack from MD maintainer(s).

Since v2:
 - added namespace fix patch against MD bitmap API
 - moved functions to lib/bitmap.c to avoid circular dependencies
 - appended Dmitry's tags

Andy Shevchenko (5):
  md: Avoid namespace collision with bitmap API
  bitmap: Drop unnecessary 0 check for u32 array operations
  bitmap: Add bitmap_alloc(), bitmap_zalloc() and bitmap_free()
  Input: gpio-keys - Switch to bitmap_zalloc()
  Input: evdev - Switch to bitmap_zalloc()

 drivers/input/evdev.c                         |  16 +-
 drivers/input/keyboard/gpio_keys.c            |   8 +-
 drivers/md/dm-raid.c                          |   6 +-
 drivers/md/md-bitmap.c                        | 301 +++++++++---------
 drivers/md/md-bitmap.h                        |  46 +--
 drivers/md/md-cluster.c                       |  16 +-
 drivers/md/md.c                               |  44 +--
 .../md/persistent-data/dm-space-map-common.c  |   8 +-
 drivers/md/raid1.c                            |  20 +-
 drivers/md/raid10.c                           |  26 +-
 drivers/md/raid5-cache.c                      |   2 +-
 drivers/md/raid5.c                            |  24 +-
 include/linux/bitmap.h                        |   8 +
 lib/bitmap.c                                  |  28 +-
 14 files changed, 281 insertions(+), 272 deletions(-)

-- 
2.17.1

