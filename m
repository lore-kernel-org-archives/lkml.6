Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DED0C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 20:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB212150E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 20:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB212150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeF3USL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 16:18:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:22935 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751874AbeF3USA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 16:18:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jun 2018 13:17:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,291,1526367600"; 
   d="scan'208";a="212458009"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2018 13:17:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 376A4CB; Sat, 30 Jun 2018 23:17:50 +0300 (EEST)
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
Subject: [PATCH v4 0/5] bitmap: Introduce alloc/free helpers
Date:   Sat, 30 Jun 2018 23:17:45 +0300
Message-Id: <20180630201750.2588-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of code is using allocation of bitmaps using BITS_PER_LONG() macro and
sizeof(unsigned long) operator. The readability suffers because of this.

The series introduces three helpers, i.e. bitmap_alloc(), bitmap_zalloc() and
bitmap_free(), to make it more cleaner.

Patches 1 and 2 are preparatory to avoid namespace collisions between
bitmap API and DM / MD bitmap. No functional changes intended.

Patch 3 introduces new helpers.

Patches 4 and 5 is just an example how to use new helpers. Locally I have
like dozen of them against different subsystems and drivers.

Taking above into consideration it might make sense to have
an immutable branch for this cycle.

Ideally it would go through Input subsystem, thus, needs an Ack
from MD / DM maintainer(s).

Since v3:
- split DM part and do rename accordingly (Mike)
- explain better in the commit message why we can't make helpers as
  inliners (Dmitry, Andrew)
- drop applied orphaned patch

Since v2:
- fix compilation issue in MD bitmap code
- elaborate changes in commit message of patch 5

Since v1:
- added namespace fix patch against MD bitmap API
- moved functions to lib/bitmap.c to avoid circular dependencies
- appended Dmitry's tags

Andy Shevchenko (5):
  dm: Avoid namespace collision with bitmap API
  md: Avoid namespace collision with bitmap API
  bitmap: Add bitmap_alloc(), bitmap_zalloc() and bitmap_free()
  Input: gpio-keys - Switch to bitmap_zalloc()
  Input: evdev - Switch to bitmap API

 drivers/input/evdev.c                         |  16 +-
 drivers/input/keyboard/gpio_keys.c            |   8 +-
 drivers/md/dm-raid.c                          |   6 +-
 drivers/md/md-bitmap.c                        | 305 +++++++++---------
 drivers/md/md-bitmap.h                        |  60 ++--
 drivers/md/md-cluster.c                       |  18 +-
 drivers/md/md.c                               |  44 +--
 .../md/persistent-data/dm-space-map-common.c  |  20 +-
 drivers/md/raid1.c                            |  35 +-
 drivers/md/raid10.c                           |  52 ++-
 drivers/md/raid5-cache.c                      |   8 +-
 drivers/md/raid5.c                            |  44 +--
 include/linux/bitmap.h                        |   8 +
 lib/bitmap.c                                  |  19 ++
 14 files changed, 326 insertions(+), 317 deletions(-)

-- 
2.18.0

