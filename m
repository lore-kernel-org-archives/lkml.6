Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2409EC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDC120836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDDC120836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752951AbeFTKQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:16:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:55164 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750902AbeFTKQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:16:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 03:16:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,246,1526367600"; 
   d="scan'208";a="60754641"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga003.jf.intel.com with ESMTP; 20 Jun 2018 03:16:17 -0700
Message-ID: <cb3ad166233d0b0e8ecc8fbc3bdf37fbb7a4c74e.camel@linux.intel.com>
Subject: Re: [PATCH v3 0/5] bitmap: Introduce alloc/free helpers
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <ynorov@caviumnetworks.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
        Joe Perches <joe@perches.com>
Date:   Wed, 20 Jun 2018 13:16:16 +0300
In-Reply-To: <20180620072721.GA19364@yury-thinkpad>
References: <20180618131003.88110-1-andriy.shevchenko@linux.intel.com>
         <20180620072721.GA19364@yury-thinkpad>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-20 at 10:33 +0300, Yury Norov wrote:
> On Mon, Jun 18, 2018 at 04:09:58PM +0300, Andy Shevchenko wrote:
> > External Email
> > 
> > A lot of code is using allocation of bitmaps using BITS_PER_LONG()
> > macro and
> > sizeof(unsigned long) operator. The readability suffers because of
> > this.
> > 
> > The series introduces three helpers, i.e. bitmap_alloc(),
> > bitmap_zalloc() and
> > bitmap_free(), to make it more cleaner.
> 

> tools/include/linux/bitmap.h already has bitmap_alloc(),

TBH, I don't give a crap about tools. They invented something that might
or might not follow kernel APIs. At the end, it's a user space.

> and it corresponds to bitmap_zalloc() in this patch. It may 
> cause problems in future if people will copy functions that
> use bitmap_alloc between kernel code and tools. So I think
> we have to propagate this API to tools and update existing
> users of bitmap_alloc() in tools.

Propose a patch then. Perhaps I need to inform tools people about new
API coming, but that's all what I can do. Existing something in tools/
does not and should not prevent extending / changing kernel internal
APIs.

> What about code that calls specific alloc functions, like
> memblock_virt_alloc() and pcpu_mem_zalloc() in mm/percpu.c,

What about it? It's not in scope of this API for sure. The above
mentioned functions have a very limited area of usage.
Your example also a bit complicated, since it's not allocating _just_ a
bitmap, but a structure _with_ embedded bitmap.

> or devm_kcalloc() in drivers/dma/edma.c?

There is no such file in the tree. You perhaps referred to
drivers/dma/ti/edma.c.

Yes, this is a candidate to convert later on if anyone wants to do it
(with introducing devm_bitmap_alloc() / devm_bitmap_zalloc() helpers).

>  If we are going to
> unify bitmap allocations in kernel, we should think about
> unification of that cases too. Should it be additional
> flag or optional pointer to the exact allocator in
> bitmap_{,z}alloc()?

So, I prefer one step at a time. Especially taking into consideration
the problems I have to solve now with those simplest helpers I proposed.

> 
> Yury
>  
> > Patch 1 is a preparatory to avoid namespace collisions between
> > bitmap API and
> > MD bitmap. No functional changes intended.
> > 
> > Patch 2 is just orphaned from previous release cycle.
> > 
> > Patch 3 introduces new helpers.
> > 
> > Patches 4 and 5 is just an example how to use new helpers. Locally I
> > have like
> > dozen of them against different subsystems and drivers.
> > 
> > Ideally it would go through Input subsystem, thus, needs an Ack from
> > MD maintainer(s).
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
> >   md: Avoid namespace collision with bitmap API
> >   bitmap: Drop unnecessary 0 check for u32 array operations
> >   bitmap: Add bitmap_alloc(), bitmap_zalloc() and bitmap_free()
> >   Input: gpio-keys - Switch to bitmap_zalloc()
> >   Input: evdev - Switch to bitmap API
> > 
> >  drivers/input/evdev.c                         |  16 +-
> >  drivers/input/keyboard/gpio_keys.c            |   8 +-
> >  drivers/md/dm-raid.c                          |   6 +-
> >  drivers/md/md-bitmap.c                        | 301 +++++++++----
> > -----
> >  drivers/md/md-bitmap.h                        |  46 +--
> >  drivers/md/md-cluster.c                       |  16 +-
> >  drivers/md/md.c                               |  44 +--
> >  .../md/persistent-data/dm-space-map-common.c  |  12 +-
> >  drivers/md/raid1.c                            |  20 +-
> >  drivers/md/raid10.c                           |  26 +-
> >  drivers/md/raid5-cache.c                      |   2 +-
> >  drivers/md/raid5.c                            |  24 +-
> >  include/linux/bitmap.h                        |   8 +
> >  lib/bitmap.c                                  |  28 +-
> >  14 files changed, 283 insertions(+), 274 deletions(-)
> > 
> > --
> > 2.17.1

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
