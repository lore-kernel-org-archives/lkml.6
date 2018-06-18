Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5244AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8132086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8132086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934464AbeFRNLm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:11:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:57985 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933009AbeFRNKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:10:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 06:10:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,239,1526367600"; 
   d="scan'208";a="58194695"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Jun 2018 06:10:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5DECEFA; Mon, 18 Jun 2018 16:10:04 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
        Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/5] bitmap: Introduce alloc/free helpers
Date:   Mon, 18 Jun 2018 16:09:58 +0300
Message-Id: <20180618131003.88110-1-andriy.shevchenko@linux.intel.com>
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
- fix compilation issue in MD bitmap code
- elaborate changes in commit message of patch 5

Since v1:
- added namespace fix patch against MD bitmap API
- moved functions to lib/bitmap.c to avoid circular dependencies
- appended Dmitry's tags

Andy Shevchenko (5):
  md: Avoid namespace collision with bitmap API
  bitmap: Drop unnecessary 0 check for u32 array operations
  bitmap: Add bitmap_alloc(), bitmap_zalloc() and bitmap_free()
  Input: gpio-keys - Switch to bitmap_zalloc()
  Input: evdev - Switch to bitmap API

 drivers/input/evdev.c                         |  16 +-
 drivers/input/keyboard/gpio_keys.c            |   8 +-
 drivers/md/dm-raid.c                          |   6 +-
 drivers/md/md-bitmap.c                        | 301 +++++++++---------
 drivers/md/md-bitmap.h                        |  46 +--
 drivers/md/md-cluster.c                       |  16 +-
 drivers/md/md.c                               |  44 +--
 .../md/persistent-data/dm-space-map-common.c  |  12 +-
 drivers/md/raid1.c                            |  20 +-
 drivers/md/raid10.c                           |  26 +-
 drivers/md/raid5-cache.c                      |   2 +-
 drivers/md/raid5.c                            |  24 +-
 include/linux/bitmap.h                        |   8 +
 lib/bitmap.c                                  |  28 +-
 14 files changed, 283 insertions(+), 274 deletions(-)

-- 
2.17.1

