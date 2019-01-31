Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C273EC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BF92086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfAaTMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:12:31 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32966 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfAaTMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:12:31 -0500
Received: by mail-ot1-f66.google.com with SMTP id i20so3852590otl.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:12:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CMyV8YTcqQtuy8vYIRwxDVYyl6IsbSnSK07RzyMR6r4=;
        b=Xc48gAamVh9A6lInuCofDTE1k5mqKsmpWnXaq4WNVtSAhXiEQp9/wb93YOAEGXAo8A
         imse/49xzagROW303N0AcaLsMiJt/pBrBcim8yaoOM1mZ/whb14D1kF0VbGy6D2FMTTC
         8rwGxeMGDx3CfFHluSBitu/ptp91sdja1U09KrvxWu7tycPJWhLyPHOPTHG0O09TncE8
         SeBa/Y6dWlVCgiCi1bv9FuC6Tbc6AV+il3tKrlWTTvcnj6BsMldYHQu6YXEG7ygpOL/w
         KorH3vtV/y1kLuetmBRffCTvgxX0Z2+XfAlar5XuBMb0NJkCxj7albN1SxDtGHNDok9Z
         wssw==
X-Gm-Message-State: AJcUukeR/BsMr/cuH1ZqISDzDjCLD06/+MyWDRgeOla5bj9mwSp/3f0u
        V3iPzJeaOZeD+l8JpbdGEYod0zSqPFHmJ3neqwtoNg==
X-Google-Smtp-Source: ALg8bN5y+YVgYw2NG0GTA7ZL+ephcNhLEpHngMlD389bDP2YMmD3BYdM+V63Fb5xz5ESBUGip4rPHStYKVMGWCfPLQs=
X-Received: by 2002:a05:6830:1004:: with SMTP id a4mr25306530otp.254.1548961950367;
 Thu, 31 Jan 2019 11:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20190130203036.11220-1-agruenba@redhat.com> <CAHk-=wg87Y=39-_caKv6apLx4dfyC3ZdaoLvd3xz5zjONbw_Nw@mail.gmail.com>
In-Reply-To: <CAHk-=wg87Y=39-_caKv6apLx4dfyC3ZdaoLvd3xz5zjONbw_Nw@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 31 Jan 2019 20:12:18 +0100
Message-ID: <CAHc6FU5smDjaQpwhyZrJBQwE5doPAcbNUfFxOSWk0jbUEG2URA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Revert "Fix loop in gfs2_rbm_find"
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019 at 19:41, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Jan 30, 2019 at 12:30 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > This reverts commit 2d29f6b96d8f80322ed2dd895bca590491c38d34.
> >
> > It turns out that the fix can lead to a ~20 percent performance regression
> > in initial writes to the page cache according to iozone.  Let's revert this
> > for now to have more time for a proper fix.
>
> Ugh. I think part of the problem is that the
>
>         n += (rbm->bii - initial_bii);
>
> doesn't make any sense when we just set rbm->bii to 0 a couple of
> lines earlier. So it's basically a really odd way to write
>
>         n -= initial_bii;
>
> which in turn really doesn't make any sense _either_.

Right, that code clearly doesn't make sense. The only positive about
it is that it hasn't caused any obvious issues so far.

> So I'l all for reverting the commit because it caused a performance
> regression, but the end result really is all kinds of odd.
>
> Is the bug as simple as "we incremented the iterator counter twice"?
> Because in the -E2BIG case, we first increment it by the difference in
> bii, but then we *also* increment it in res_covered_end_of_rgrp()
> (which we do *not* do for the "ret > 0" case, which goes to
> next_iter).

In the "ret > 0" case, rbm->bii should have already been incremented
in gfs2_reservation_check_and_update.

> So if somebody can run the performance test again, how does it look if
> *instead* of the revert, we do what looks at least _slightly_ more
> sensible, and move the "increment iteration count" up to the
> next-bitmap case instead?
>
> At that point, it will actually match the bii updates (because
> next_bitmap also updates rbm->bii). Hmm?
>
> Something like the whitespace-damaged thinig below. Completely
> untested. But *if* this works, it would make more sense than the
> revert..
>
> Hmm?

My idea was to fix that whole loop properly as in this patch instead:

  https://www.redhat.com/archives/cluster-devel/2019-January/msg00111.html

That patch just hasn't seen enough testing to make me comfortable
sending it yet. We're testing it right now, and my plan was to get it
into the next merge window. I don't think an intermediate workaround
would make much sense. Does that sound acceptable? Would you rather
have that fix sent to you sometime next week instead?

Thanks a lot,
Andreas
