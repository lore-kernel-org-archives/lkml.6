Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D571FC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A46325845
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A46325845
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934647AbeFZLNv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:13:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:10184 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933592AbeFZLNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:13:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 04:13:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="51982655"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 26 Jun 2018 04:13:43 -0700
Message-ID: <c5756465375e091a528b8c68fae3d8f3061454bf.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/5] bitmap: Add bitmap_alloc(), bitmap_zalloc() and
 bitmap_free()
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, agk@redhat.com,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        shli@kernel.org, linux-raid@vger.kernel.org,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Joe Perches <joe@perches.com>
Date:   Tue, 26 Jun 2018 14:13:42 +0300
In-Reply-To: <20180622184613.GC92912@dtor-ws>
References: <20180618131003.88110-1-andriy.shevchenko@linux.intel.com>
         <20180618131003.88110-4-andriy.shevchenko@linux.intel.com>
         <20180618141404.68124daab97bd0f3a3051544@linux-foundation.org>
         <CAKdAkRTHOORds7aEauv4rp3_=PnGi=Nv-VS3-nAb9MztJPKG=Q@mail.gmail.com>
         <20180618161056.e52efd0e8bd36211e60705a2@linux-foundation.org>
         <CAHp75Vei2_V7h4oKAU+uoCG2gUJH6uXtg9zVqQ_vnyr5KEmNYw@mail.gmail.com>
         <20180622184613.GC92912@dtor-ws>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-22 at 11:46 -0700, Dmitry Torokhov wrote:
> On Thu, Jun 21, 2018 at 05:13:39AM +0300, Andy Shevchenko wrote:
> > On Tue, Jun 19, 2018 at 2:10 AM, Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> > > On Mon, 18 Jun 2018 15:01:43 -0700 Dmitry Torokhov <dmitry.torokho
> > > v@gmail.com> wrote:
> > > > We can't as we end up including bitmap.h (by the way of
> > > > cpumask.h)
> > > > form slab.h, so we gen circular dependency.
> > 
> > It's not just so easy. See below.
> > 
> > > That info should have been in the changelog, and probably a code
> > > comment.
> > > 
> > > > Maybe if we removed memcg
> > > > stuff from slab.h so we do not need to include workqueue.h...
> > > 
> > > Or move the basic slab API stuff out of slab.h into a new
> > > header.  Or
> > > create a new, standalone work_struct.h - that looks pretty simple.
> > 
> > I tried to move out work_struct, it didn't help. There are actually
> > several circular dependencies that ends in bitmap.h either way or
> > another.
> > 
> > First one is
> > 
> > slab.h -> gfp.h -> mmzone.h -> nodemask.h -> bitmap.h
> > 
> > And so on...
> > 
> > Splitting out kXalloc stuff to a separate header won't help, I
> > think,
> > because of the above.
> > Splitting out struct work_struct is just a tip of an iceberg.
> > Splitting out memcg stuff won't help in the similar way.
> > 
> > I'm all ears for (a better) solution.
> 
> I think ultimately we'd want to untangle this, but allocating bitmaps
> is
> not in any hot paths so having them as non-inlined functions should
> not
> hurt us that much for time being.

Perhaps I can elaborate a bit in a commit message.

Thanks for review!

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
