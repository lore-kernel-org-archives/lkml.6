Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86759C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B032083F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cgUd8G3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B032083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeJECRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:17:51 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44847 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeJECRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:17:51 -0400
Received: by mail-io1-f65.google.com with SMTP id x26-v6so8819086iog.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 12:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nlrq1wY4htdJ96iZaAUaPDo1c6DZ3dmNnCNeqWYsfUM=;
        b=cgUd8G3+LJdJn4VMXwSazsKQUJ0Ul+QsIVk3Bhu0/TrtFEjq9gehcqoaMmw06Ghc08
         GH3IvOZ/ifhiaZzijxWMpIqlYSbG0ZOw7kISfYT78dX+TYuYahJcNPyvU9N8DZONcNVP
         FcKl01NFl1MwuseDkI3FDZB8CnwrPkFIn/4xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nlrq1wY4htdJ96iZaAUaPDo1c6DZ3dmNnCNeqWYsfUM=;
        b=LsH7GYpBeB3B7tR1wbAbw4W2mwU2IVmn3cEOSZa+iDxgDHLLrWvG527jorvgdN/GVv
         UhMKtNRDip2gKvlNXgDb7eVJcLkVPVzWq7lIQw9RMFuQwGuZB10GIiIsRoH6nT7K/OhO
         BX/DnReNHoGNAYur5C6Z3W6MYm325P98LoeAs+OvJFhBDnaSnqcjhrvD4TnqbUkwQnKa
         JX/UXsbOSahoZyROgdKEgCxb7/caCNXSELPj8hQEXzEV8kQZWkWVTRZvYEPjL1nHjMgJ
         ElKd4niHv8mME4EQLQhIAq4trwNwOor5VjWfWq1d1N4XpGuaH2dQz3cDAu2Xx9Ojvw1a
         PrDw==
X-Gm-Message-State: ABuFfogwTWY9BlM7zIr0LcM/Hu/Vj3g9mfb+gWmKv+AvxRoBR4/BiVR/
        YBBQ80vhOOrAPuaJXu9NE714O3OBspZWEe9zfPu1rg==
X-Google-Smtp-Source: ACcGV60wKgNJ7JVcXgNva+e6OPZjv5aCzgYzKx4BXzB6HklzJiDGusWb4OtK6fhOJZbV/Jgo3tyfLYad9U4NSAb28OU=
X-Received: by 2002:a6b:f40a:: with SMTP id i10-v6mr5539437iog.278.1538680991037;
 Thu, 04 Oct 2018 12:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181003222715.28667-1-robh@kernel.org> <CAKMK7uHYnOVJBn57M0yxgXWAxrkg79+rz0zX+7XRHt8KwgvOuw@mail.gmail.com>
 <CAL_Jsq+DpM5Cea-y08MXDP-AKUE07KpwUoCbiRgH_iSkZU6cSA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+DpM5Cea-y08MXDP-AKUE07KpwUoCbiRgH_iSkZU6cSA@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 4 Oct 2018 21:22:59 +0200
Message-ID: <CAKMK7uF74Sw8P0-2V76utPKoxfBk+13_Po+eW_Mgu+RZq9uEvQ@mail.gmail.com>
Subject: Re: [PATCH] Add a skeleton Travis-CI config
To:     Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 9:11 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Oct 4, 2018 at 3:33 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> >
> > On Thu, Oct 4, 2018 at 12:27 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > It's convenient to use Travis-CI for doing kernel builds. Doing so
> > > requires a github repo, Travis-CI enabled for that repo, and a
> > > .travis.yml file in the repository. This commit addresses the last part.
> > > Each repository branch must have a .travis.yml file in order to run
> > > Travis-CI jobs.
> > >
> > > Obviously, we can't create a single configuration that works for
> > > everyone as every developer will want to run different configs and
> > > build targets. Therefore, this only adds a skeleton .travis.yml file.
> > > With this a user can either set $CONFIG and $TARGET in their Travis-CI
> > > environment or customized builds can be triggered remotely.
> > >
> > > Here's an example of setting up a matrix build of different
> > > architectures:
> > >
> > > body='{
> > >   "request": {
> > >     "branch": "master",
> > >     "config" : {
> > >       "env": {
> > >         "global": "CONFIG=defconfig TARGET=all",
> > >         "matrix": [
> > >           "ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-",
> > >           "ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-",
> > >           "ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-"
> > >         ]
> > >       }
> > >     }
> > >   }
> > > }'
> > >
> > > curl -s -X POST \
> > >    -H "Content-Type: application/json" \
> > >    -H "Accept: application/json" \
> > >    -H "Travis-API-Version: 3" \
> > >    -H "Authorization: token $TOKEN" \
> > >    -d "$body" \
> > >    https://api.travis-ci.org/repo/robherring%2Flinux/requests
> > >
> > > Additionally, it is possible to override 'scripts' or any other part of
> > > the config as well.
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > > I'm wondering if there's other interest in this. If so, please chime in.
> > >
> > > Maybe I should be looking at Gitlab CI instead, but Travis I know
> > > already and Gitlab just seems to be the shiniest new thing. In any case,
> > > both could coexist.
> >
> > So I haven't looked in-depth at the travis+github combo, but on gitlab
> > you can set the path for your .gitlab-ci.yaml file per-repo. Which
> > means each maintainer group can have their own thing, without
> > trampling on each another's feet.
>
> Yes, that's a nice feature.
>
> > I guess if gitlab+travis can't do that then a dispatcher like you
> > propose here would be good. Personally I have reservations with gitlab
>
> You mean github here?

Yup.

> > though, since it's proprietary infrastructure not under out control.
> > That's a big reason for why fd.o opted for gitlab, and the handful of
> > graphics projects that tried out a gitlab+travis workflow all plan to
> > move back to gitlab.fd.o. Gitlab definitely works - there's enough
> > projects out there to prove that :-) But in the kernel we've already
> > seen how that can go all wrong with bitkeeper.
>
> The difference here is this is all auxiliary tools on top of the main
> workflow, not a core tool everyone relies on.
>
> It would be nice if there was some standardization of CI config files
> then moving CI providers would be trivial.

Ime moving CI providers is pretty far from trivial. E.g. gitlab uses
docker images for its builders, and it's very much recommended you
build a specific docker images so your builds don't first have to
install a bunch of packages and set up a few things. travis otoh knows
much more about what you need, and does all the build env caching on
the server side automatically. Really not all that easy to flip
between the two.

Plus then all the hand-rolled CI setups running on private maintainer machines.

The other bit is that if your CI isnt' part of your workflow, then it
won't work. The "continuous" part is really the key.

Anyway, definitely don't want to stop this effort, just figured I'll
drop my take on this. I'm pretty sure I'll submit a
drivers/gpu/.gitlab-ci.yaml as soon as we've moved to gitlab.fd.o :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
