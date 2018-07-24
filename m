Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F232CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B5A20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B5A20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbeGXMmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:42:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:52808 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388172AbeGXMmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:42:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 04:35:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,397,1526367600"; 
   d="scan'208";a="77378535"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga002.jf.intel.com with ESMTP; 24 Jul 2018 04:35:53 -0700
Message-ID: <2310fa540b9e5db3b94f4917ecae76dce2a2ca65.camel@linux.intel.com>
Subject: Re: [PATCH v4 0/5] bitmap: Introduce alloc/free helpers
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Joe Perches <joe@perches.com>
Date:   Tue, 24 Jul 2018 14:35:53 +0300
In-Reply-To: <CAHp75Vd9RSxVsYrbiAFJKLPL4wNzAtS9qAPjCNJJ4E=QbeTP8A@mail.gmail.com>
References: <20180630201750.2588-1-andriy.shevchenko@linux.intel.com>
         <CAHp75Vd9RSxVsYrbiAFJKLPL4wNzAtS9qAPjCNJJ4E=QbeTP8A@mail.gmail.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-05 at 00:30 +0300, Andy Shevchenko wrote:
> On Sat, Jun 30, 2018 at 11:17 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > A lot of code is using allocation of bitmaps using BITS_PER_LONG()
> > macro and
> > sizeof(unsigned long) operator. The readability suffers because of
> > this.
> > 
> > The series introduces three helpers, i.e. bitmap_alloc(),
> > bitmap_zalloc() and
> > bitmap_free(), to make it more cleaner.
> > 
> 
> Dmitry, it seems we are all set now and if you have no objections
> against this version, it would be nice to see it in your tree followed
> by upstream.

Gentle ping!

> 
> > Patches 1 and 2 are preparatory to avoid namespace collisions
> > between
> > bitmap API and DM / MD bitmap. No functional changes intended.
> > 
> > Patch 3 introduces new helpers.
> > 
> > Patches 4 and 5 is just an example how to use new helpers. Locally I
> > have
> > like dozen of them against different subsystems and drivers.
> > 
> > Taking above into consideration it might make sense to have
> > an immutable branch for this cycle.
> > 
> > Ideally it would go through Input subsystem, thus, needs an Ack
> > from MD / DM maintainer(s).
> > 
> > Since v3:
> > - split DM part and do rename accordingly (Mike)
> > - explain better in the commit message why we can't make helpers as
> >   inliners (Dmitry, Andrew)
> > - drop applied orphaned patch
> > 
> > Since v2:
> > - fix compilation issue in MD bitmap code
> > - elaborate changes in commit message of patch 5
> > 
> > Since v1:
> > - added namespace fix patch against MD bitmap API
> > - moved functions to lib/bitmap.c to avoid circular dependencies
> > - appended Dmitry's tags
> > 
> > Andy Shevchenko (5):
> >   dm: Avoid namespace collision with bitmap API
> >   md: Avoid namespace collision with bitmap API
> >   bitmap: Add bitmap_alloc(), bitmap_zalloc() and bitmap_free()
> >   Input: gpio-keys - Switch to bitmap_zalloc()
> >   Input: evdev - Switch to bitmap API
> > 
> >  drivers/input/evdev.c                         |  16 +-
> >  drivers/input/keyboard/gpio_keys.c            |   8 +-
> >  drivers/md/dm-raid.c                          |   6 +-
> >  drivers/md/md-bitmap.c                        | 305 +++++++++----
> > -----
> >  drivers/md/md-bitmap.h                        |  60 ++--
> >  drivers/md/md-cluster.c                       |  18 +-
> >  drivers/md/md.c                               |  44 +--
> >  .../md/persistent-data/dm-space-map-common.c  |  20 +-
> >  drivers/md/raid1.c                            |  35 +-
> >  drivers/md/raid10.c                           |  52 ++-
> >  drivers/md/raid5-cache.c                      |   8 +-
> >  drivers/md/raid5.c                            |  44 +--
> >  include/linux/bitmap.h                        |   8 +
> >  lib/bitmap.c                                  |  19 ++
> >  14 files changed, 326 insertions(+), 317 deletions(-)
> > 
> > --
> > 2.18.0
> > 
> 
> 
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
