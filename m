Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD23C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F198220657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LGgNHTLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbfAONhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:37:19 -0500
Received: from mail-it1-f170.google.com ([209.85.166.170]:36739 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729756AbfAONhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:37:19 -0500
Received: by mail-it1-f170.google.com with SMTP id c9so4367847itj.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 05:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q75/BgjnCKDq715ObJO/0NrB2mY1JCPwIFKGtNjh1GM=;
        b=LGgNHTLzuXHtlpxodCJkjW1MlQ4ZEY0EFdBzWZlfG5F3DXHy47VRrMEcJeBgOUMPqT
         fIxFnKVuTPAuyFnV4tshaVkK7T4bFhis9bbEh2Wv098ecrUBiaL+XJLtzEYs4p7MLY/y
         1+JiTYO8Yz4zcEKJd3OeYSzOOvtKuVvbn+SFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q75/BgjnCKDq715ObJO/0NrB2mY1JCPwIFKGtNjh1GM=;
        b=VKPxqhV3MZPY2QsRu4aUn0i4O4cyIE+BHYteXhbb7bMkA7SC44oPIIFHvV4zmSBly3
         gMphhOSqAOkWLW7Ha5Q6ssGgxq3PPWMz2A6yQZ1K4Mt0/4TJ+z8Fr91UFMGENvKT83iL
         bE01HGdAC3n1u6PGM0bi+IcUx4vG9Pn2iriAIgqKpT1wcg+EeUiKOJ5OE2SIqQ1S2c1s
         LglSSNGE8mxCPti6o5eK+qofGT+w093zhThUL3QEZW6cJW+PSIPVug2gYL7w8ChigNgw
         ELUuGFJy0Bf7WsSeIo8ZCrMUGIuoZmPuFAkDk++p1EmJIOT574PiNUkzHCdXSfE+KYpS
         6uIg==
X-Gm-Message-State: AJcUukdBaXVqD7M6HNE8cmGzu2j9hbCYKpdGUw/HKU2wi5PzwqE4QLeq
        aAuH2PeGqNCPctQbwt3mvHdIB1aq2phpSq48GbeKQkGv
X-Google-Smtp-Source: ALg8bN586WKD7+xi0XROl0s72Y1TakYZrln/MEFPvJXZwwPeXBVKvfVRTLFWunb3DViOANRgCSp0P7/8zs12jSO7ePM=
X-Received: by 2002:a05:660c:344:: with SMTP id b4mr2470520itl.51.1547559438150;
 Tue, 15 Jan 2019 05:37:18 -0800 (PST)
MIME-Version: 1.0
References: <20190115104619.516be4b9@canb.auug.org.au> <20190115101219.GP20661@e110455-lin.cambridge.arm.com>
 <20190115214725.360798cf@canb.auug.org.au> <20190115105102.GQ20661@e110455-lin.cambridge.arm.com>
 <20190115120836.GN10517@phenom.ffwll.local> <20190115122313.GR20661@e110455-lin.cambridge.arm.com>
In-Reply-To: <20190115122313.GR20661@e110455-lin.cambridge.arm.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 15 Jan 2019 14:37:06 +0100
Message-ID: <CAKMK7uGZovo8O90XAgQnkub04ORVDZWGW6T-H2gsLtPYdc8ULw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the mali-dp tree
To:     Liviu Dudau <Liviu.Dudau@arm.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "James Qian Wang (Arm Technology China)" <james.qian.wang@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 1:23 PM Liviu Dudau <Liviu.Dudau@arm.com> wrote:
>
> On Tue, Jan 15, 2019 at 01:08:36PM +0100, Daniel Vetter wrote:
> > On Tue, Jan 15, 2019 at 10:51:02AM +0000, Liviu Dudau wrote:
> > > On Tue, Jan 15, 2019 at 09:47:25PM +1100, Stephen Rothwell wrote:
> > > > Hi Liviu,
> > > >
> > > > On Tue, 15 Jan 2019 10:12:19 +0000 Liviu Dudau <Liviu.Dudau@arm.com=
> wrote:
> > > > >
> > > > > That looks like the right fix, thank you for that!
> > > >
> > > > Thanks for your verification.
> > > >
> > > > > I will roll your patch into my tree.
> > > >
> > > > You can only do that when your tree is merged with the drm tree (an=
d
> > > > it should be part of the merge resolution).
> > >
> > > I can also rebase on top of the latest drm-next tree, that should not=
 be
> > > a problem.
> >
> > If you have a lot of patches already rebasing is kinda discouraged. The=
re
> > might be other stuff that's conflicting and then making your entire tre=
e
> > non-bisectable (maybe just on one platform that you missed in testing).
>
> My tree has always been "unstable", I have been rebasing it on top of
> latest drm or drm-next in preparation for sending pull requests. I've hop=
ed
> that people don't depend on the linearity of my tree anyway and it hasn't
> been an issue so far.

"Don't unecessarily rebase" isn't only about screwing up people who
base their own stuff on your tree, it's also about invalidating
testing. E.g. if there's a silent conflict with latest drm-next, and
you rebase before sending out your pull request, but then don't notice
that new issue, then all these commit won't work in a bisect for a 2nd
issue.

But if you don't rebase, then only the merge commit will be broken
(until the bugfix was commit, which is hopefully not too long), and
all the commits on your branch still work.

So summary is that if you regularly rebase your pile of "ready for
linux-next" patches, then you're doing something wrong. And the bigger
your team (and hence the amount of work going on) the more wrong this
becomes. Ime you can rebase to squash in bugfixes with a bigger team
still, but rebasing to change the baseline stops being a good idea
pretty quickly.
-Daniel

> TBH, I should've based the latest update of my tree on drm-next anyway, I
> just started at the time when it was at v5.0-rc1 so I thought it will not
> matter.
>
> Best regards,
> Liviu
>
> >
> > In that case just send out a pull for drm-next and include the merge
> > resolution in the pull request so Dave/I can double-check we did it rig=
ht.
> > -Daniel
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
>
> --
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     =C2=AF\_(=E3=83=84)_/=C2=AF
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
