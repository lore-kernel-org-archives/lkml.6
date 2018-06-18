Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342B8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6BA208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6BA208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935104AbeFRMC2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:02:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:30401 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933575AbeFRMCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:02:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 05:02:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,239,1526367600"; 
   d="scan'208";a="67873583"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga002.jf.intel.com with ESMTP; 18 Jun 2018 05:02:20 -0700
Message-ID: <8cfbdf809f531f8aa315fe1679c3273858038f41.camel@linux.intel.com>
Subject: Re: [PATCH v2 5/5] Input: evdev - Switch to bitmap_zalloc()
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Yury Norov <ynorov@caviumnetworks.com>
Cc:     agk@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, shli@kernel.org, linux-raid@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Date:   Mon, 18 Jun 2018 15:02:20 +0300
In-Reply-To: <0a3d86d7746792a2f848cef386941fc182653515.camel@perches.com>
References: <20180615132017.23889-1-andriy.shevchenko@linux.intel.com>
         <20180615132017.23889-6-andriy.shevchenko@linux.intel.com>
         <20180615214231.GA371@yury-thinkpad>
         <CAHp75VcxYPCLYq1J8qqjPdgDdQnWDgZKkavmyEWD8GNxcW2mWg@mail.gmail.com>
         <0a3d86d7746792a2f848cef386941fc182653515.camel@perches.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-06-16 at 12:16 -0700, Joe Perches wrote:
> On Sat, 2018-06-16 at 21:45 +0300, Andy Shevchenko wrote:
> > On Sat, Jun 16, 2018 at 12:46 AM Yury Norov <ynorov@caviumnetworks.c
> > om> wrote:
> > > On Fri, Jun 15, 2018 at 04:20:17PM +0300, Andy Shevchenko wrote:
> > > > Switch to bitmap_zalloc() to show clearly what we are
> > > > allocating.
> > > > Besides that it returns pointer of bitmap type instead of opaque
> > > > void *.
> > 
> > 
> > > > +       mem = bitmap_alloc(maxbit, GFP_KERNEL);
> > > >         if (!mem)
> > > >                 return -ENOMEM;
> > > 
> > > But in commit message you say you switch to bitmap_zalloc(). IIUC
> > > bitmap_alloc() is OK here. But could you please update comment to
> > > avoid confusing.
> > 
> > There are two places, one with alloc, another with zalloc.
> > I will clarify this in commit message of next version.
> > 
> > > > +       mask = bitmap_zalloc(cnt, GFP_KERNEL);
> > > >         if (!mask)
> > > >                 return -ENOMEM;
> > > > 
> > > >         error = bits_from_user(mask, cnt - 1, codes_size, codes,
> > > > compat);
> > > 
> > > If my understanding of bits_from_user() correct, here you can also
> > > use
> > > bitmap_alloc(), true?
> 
> Also it might be useful to have a separate bitmap_from_user
> to alloc and copy.

Maybe. I didn't check if there are such users except this driver.

Anyway, it's out of scope of the series.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
