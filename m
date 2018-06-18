Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB2BC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FF82086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74FF82086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933596AbeFRN5r (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:57:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:22295 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754315AbeFRN5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:57:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 06:57:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,239,1526367600"; 
   d="scan'208";a="50228685"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga008.jf.intel.com with ESMTP; 18 Jun 2018 06:57:42 -0700
Message-ID: <49e96a4ecb3566139bef0b36093143077ceafd3f.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/5] md: Avoid namespace collision with bitmap API
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
        Joe Perches <joe@perches.com>
Date:   Mon, 18 Jun 2018 16:57:41 +0300
In-Reply-To: <20180618134454.GA25547@redhat.com>
References: <20180618131003.88110-1-andriy.shevchenko@linux.intel.com>
         <20180618131003.88110-2-andriy.shevchenko@linux.intel.com>
         <20180618134454.GA25547@redhat.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-18 at 09:44 -0400, Mike Snitzer wrote:
> On Mon, Jun 18 2018 at  9:09am -0400,
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > bitmap API (include/linux/bitmap.h) has 'bitmap' prefix for its
> > methods.
> > 
> > On the other hand MD bitmap API is special case.
> > Adding 'md' prefix to it to avoid name space collision.
> > 
> > No functional changes intended.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
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
> >  10 files changed, 244 insertions(+), 253 deletions(-)
> 
> Seems my previous mail just missed your v3 cutoff but...
> 
> <snip>
> 
> All of these drivers/md/persistent-data/dm-space-map-common.c renames
> are wrong.

So, let me understand this clear, the naming problem appears in one file
only. The rest is fine. Correct?

>   DM is the only consumer (it is confusing because all DM and
> MD code lives in drivers/md/ despite only sharing a bit of MD code).
> 
> Anyway, please rename bitmap methods in this file to have a
> "dm_bitmap"
> prefix instead.  Thanks.

Ah, okay, will do this in v4 later this week.

Thanks for review!

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
