Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD84EC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B32E2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B32E2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964793AbeFRXLA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 19:11:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35984 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755329AbeFRXK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 19:10:58 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AFB6ED73;
        Mon, 18 Jun 2018 23:10:57 +0000 (UTC)
Date:   Mon, 18 Jun 2018 16:10:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        agk@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        shli@kernel.org, linux-raid@vger.kernel.org,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        ynorov@caviumnetworks.com, lkml <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 3/5] bitmap: Add bitmap_alloc(), bitmap_zalloc() and
 bitmap_free()
Message-Id: <20180618161056.e52efd0e8bd36211e60705a2@linux-foundation.org>
In-Reply-To: <CAKdAkRTHOORds7aEauv4rp3_=PnGi=Nv-VS3-nAb9MztJPKG=Q@mail.gmail.com>
References: <20180618131003.88110-1-andriy.shevchenko@linux.intel.com>
        <20180618131003.88110-4-andriy.shevchenko@linux.intel.com>
        <20180618141404.68124daab97bd0f3a3051544@linux-foundation.org>
        <CAKdAkRTHOORds7aEauv4rp3_=PnGi=Nv-VS3-nAb9MztJPKG=Q@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2018 15:01:43 -0700 Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> > > +unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags)
> > > +{
> > > +     return kmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned long), flags);
> > > +}
> > > +EXPORT_SYMBOL(bitmap_alloc);
> > > +
> > > +unsigned long *bitmap_zalloc(unsigned int nbits, gfp_t flags)
> > > +{
> > > +     return bitmap_alloc(nbits, flags | __GFP_ZERO);
> > > +}
> > > +EXPORT_SYMBOL(bitmap_zalloc);
> > > +
> > > +void bitmap_free(const unsigned long *bitmap)
> > > +{
> > > +     kfree(bitmap);
> > > +}
> > > +EXPORT_SYMBOL(bitmap_free);
> > > +
> >
> > I suggest these functions are small and simple enough to justify
> > inlining them.
> >
> 
> We can't as we end up including bitmap.h (by the way of cpumask.h)
> form slab.h, so we gen circular dependency.

That info should have been in the changelog, and probably a code
comment.

> Maybe if we removed memcg
> stuff from slab.h so we do not need to include workqueue.h...

Or move the basic slab API stuff out of slab.h into a new header.  Or
create a new, standalone work_struct.h - that looks pretty simple.

