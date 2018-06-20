Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4F7C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2436020652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2436020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753266AbeFTGKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 02:10:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:49663 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751327AbeFTGKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 02:10:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3846FAC55;
        Wed, 20 Jun 2018 06:10:00 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id DC322A1081; Wed, 20 Jun 2018 08:09:59 +0200 (CEST)
Date:   Wed, 20 Jun 2018 08:09:59 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] proc: add missing '\0' back to /proc/$pid/cmdline
Message-ID: <20180620060959.upeetkzaz7jpd57a@unicorn.suse.cz>
References: <20180619092254.kmww3fpqjqcsjrna@unicorn.suse.cz>
 <20180619162411.B2B7AA1081@unicorn.suse.cz>
 <CA+55aFwa-mxOFKGiLmbxyJ+LyEjOG07fuYOmcWaYf-SJntneuw@mail.gmail.com>
 <20180620050824.hwijqfhzuu3ip4wo@unicorn.suse.cz>
 <CA+55aFwnXSmB_Xn+-wC1fhnAVSa5KQABah-d2_zt3iNL0Cpwvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwnXSmB_Xn+-wC1fhnAVSa5KQABah-d2_zt3iNL0Cpwvw@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 02:51:23PM +0900, Linus Torvalds wrote:
> On Wed, Jun 20, 2018 at 2:08 PM Michal Kubecek <mkubecek@suse.cz> wrote:
> >
> >
> > > @@ -254,10 +258,19 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
> > >       while (count) {
> > >               int got;
> > >               size_t size = min_t(size_t, PAGE_SIZE, count);
> >
> > We limit size to be at most PAGE_SIZE here.
> >
> > > +             long offset;
> > >
> > > -             got = access_remote_vm(mm, pos, page, size, FOLL_ANON);
> > > -             if (got <= 0)
> > > +             /*
> > > +              * Are we already starting past the official end?
> > > +              * We always include the last byte that is *supposed*
> > > +              * to be NUL
> > > +              */
> > > +             offset = (pos >= arg_end) ? pos - arg_end + 1 : 0;
> > > +
> > > +             got = access_remote_vm(mm, pos - offset, page, size + offset, FOLL_ANON);
> >
> > But here we read (size + offset) bytes which may be more than PAGE_SIZE.
> 
> Actually, no. We limit size not just to PAGE_SIZE, but to count as well.
> 
> And there's *another* limit on 'count' that you missed, namely this part:
> 
>         /* .. and limit it to a maximum of one page of slop */
>         if (env_end >= arg_end + PAGE_SIZE)
>                 env_end = arg_end + PAGE_SIZE - 1;
> 
> coupled with
> 
>         /* .. and we never go past env_end */
>         if (env_end - pos < count)
>                 count = env_end - pos;
> 
> so we know that "pos + size" can never be larger than "arg_end + PAGE_SIZE - 1"
> 
> And then:
> 
>                 offset = (pos >= arg_end) ? pos - arg_end + 1 : 0;
> 
> means that "offset" will be bigger than zero only if "pos > arg_end-1".
> 
> So let's ignore all other cases, and just say that we care about that
> case where 'offset' can be non-zero.
> 
> So we have
> 
>    offset = pos - arg_end +1
> 
> (from the above initialization of offset), but we also know that
> 
>    pos + count <= end_end
> 
> and since we've limited end_end to "arg_end + PAGE_SIZE -1" we have
> 
>    pos + count <= arg_end + PAGE_SIZE -1
> 
> agreed?
> 
> Now, we can do some math on the above. Re-write that "offset = .." equation as
> 
>    pos = arg_end + offset - 1
> 
> And the same time we can  take that "pos + count" inequality, and
> replacing "pos", we get
> 
>    arg_end + offset - 1 + count <= arg_end + PAGE_SIZE -1
> 
> and then we can remove "arg_end - 1" from both sides, and get
> 
>    offset+count <= PAGE_SIZE
> 
> agreed?

Right... I missed the trick where env_end is no longer real env_end when
it's used to limit count.

And the tests look good too so

Reviewed-by: Michal Kubecek <mkubecek@suse.cz>
Tested-by: Michal Kubecek <mkubecek@suse.cz>

Michal Kubecek

