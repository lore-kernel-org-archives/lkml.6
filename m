Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5697DC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058BE20847
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ErjKLl3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058BE20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934430AbeGDMKz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:10:55 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38324 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933407AbeGDMKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:10:53 -0400
Received: by mail-wr0-f194.google.com with SMTP id j33-v6so5104520wrj.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 05:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PtHGKOmeNRGf+C9+MfTwb0BYvxZqRL3+S1ZqRafqefY=;
        b=ErjKLl3+bdpM/At/BgiMHeXXbleEizIJ/R+0EQQzNPfHmUKxblfpv8fVerjwqpStyz
         SJbsnHh5VHoui/XRGOVVaBCYb2JjDxF/7rODP80axFxQF71dn8ElYZEbI+tAK9f2UKmQ
         ksH6Hhpx8Qj0iTvBZk7X0b/JnccddY+uet3c0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PtHGKOmeNRGf+C9+MfTwb0BYvxZqRL3+S1ZqRafqefY=;
        b=ap9lFPDqncI5ZUNIwSsXsiITJQLANfZghS9f+VNKqzgf1vGZ/bDyQOMxjVEfhs9mtF
         B5K4jfy0seJbz9DQlNQdHtTaTJTZubqRC6WNjdnB26QO9c3xm6eDmc2eBnwHRKoVUQpj
         oH8CCBw6ETrZJVTE/EsCQ+bP1eLbOlhJtfilutOsuNmzNLg9v8UL3KYyJbPxfCK+6Qqb
         T3E5BwpiyzvV1o0dc0/Rx2Te/pensmzQamrvXrK2nTV98FZUGOAOSaMODux65Rz/N5XV
         vLAqwEptZ0GMvr2+L+J0kgAAhtDjT3ZJE2Ih1jA14tDra0YyvPjBLfayjkwMfHfnfLmi
         eypQ==
X-Gm-Message-State: APt69E2A2ekpr2bXwE5W5e/EZXKs8KqSsByMExjStz+b+TP+cAwquDyM
        yixogL/d84KqI94FY3ZKUUr32A==
X-Google-Smtp-Source: AAOMgpeyV0cCMhZyhjfUKmm/4j5W6NFih3kGCPnk7CMLOY+awUfXRy3uoiRC2k/DF/Xew4pEwON+VQ==
X-Received: by 2002:adf:a6e2:: with SMTP id t89-v6mr1528378wrc.231.1530706252273;
        Wed, 04 Jul 2018 05:10:52 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id c10-v6sm5644849wrh.44.2018.07.04.05.10.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 05:10:51 -0700 (PDT)
Date:   Wed, 4 Jul 2018 13:10:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH] backlight: remove obsolete comment for ->state
Message-ID: <20180704121049.GE496@dell>
References: <20180503141517.28207-1-daniel.vetter@ffwll.ch>
 <20180704093447.GU20176@dell>
 <20180704093816.GV20176@dell>
 <20180704100506.GT3891@phenom.ffwll.local>
 <20180704103401.GB496@dell>
 <CAKMK7uHwKOzf9wxPd_5YcWD06C+aSyL3hkoLNidTGdMPEEVwQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKMK7uHwKOzf9wxPd_5YcWD06C+aSyL3hkoLNidTGdMPEEVwQw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Jul 2018, Daniel Vetter wrote:

> Hi Lee,
> 
> On Wed, Jul 4, 2018 at 12:34 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Wed, 04 Jul 2018, Daniel Vetter wrote:
> >> On Wed, Jul 04, 2018 at 10:38:16AM +0100, Lee Jones wrote:
> >> > On Wed, 04 Jul 2018, Lee Jones wrote:
> >> >
> >> > > > Jani spotted this when reviewing my earlier patch to remove the driver
> >> > > > internal usage of this field in
> >> > > >
> >> > > > commit 3cf91adaa594e8933af1727942ac560e5c7bc70e
> >> > > > Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> >> > > > Date:   Wed Apr 25 19:42:52 2018 +0200
> >> > > >
> >> > > >     backlight: Nuke BL_CORE_DRIVER1
> >> > >
> >> > > FYI, sending patches like this is not a good idea.
> >> > >
> >> > > I'll clean it up for you this time, but in future please send patches
> >> > > properly and place any additional comments you may have below the
> >> > > '---' line.
> >> >
> >> > Ah, I see what you've tried to do.  This hurt my eyes! :)
> >> >
> >> > It's more conventional to reference commits like:
> >> >
> >> >   Commit 3cf91adaa594 ("backlight: Nuke BL_CORE_DRIVER1")
> >> >
> >> > Again, I'll make the amendment to avoid further confusion.
> >>
> >> So the first mail doesn't even bother to explain what's
> >> objectionable
> >
> > In the first instance it looked as though you'd copied and pasted `git
> > log`, which if you'd done so would have been obvious to you and would
> > have required no further explanation.
> >
> > Also bear in mind that I took your standing within the kernel
> > community into consideration, so speaking to you like a n00b or going
> > into unnecessary detail could have been considered superfluous at best
> > and condescending at worst.
> 
> Unfortunately minute details like this aren't consistent across the
> kernel at all, and white space and layout issues are the number 1
> reason I get shot at for random patches I'm sending out. So maybe
> there are people who learned all these local expectations (Arnd
> perhaps, or Kees?), it's definitely not me. Not after 10 years for
> sure.
> 
> >> the 2nd mail still says "This hurts my eyes!".
> >
> > It certainly did, yes.
> >
> > Usually taken to meaning that it was hard to read in these scenarios.
> >
> >> Over whitespace in the commit message.
> >
> > Nothing to do with white space.  It was the format by which you chose
> > to reference a previous commit.  Instead it looked like a patch
> > formatting error.  I have received patches pasted from `git log`
> > before, and this looked just the same.
> >
> > Once I'd realised what was going on, I followed up to explain and
> > provided some feedback on what to do differently in future.
> >
> >> This kind of stuff is why graphics people really don't enjoy contributing
> >> to the kernel at large. A friendly request to resend with the color choice
> >> adjusted would go a lot further.
> >
> > I apologise if my brevity hurt your feelings.  I have 290 emails to
> > get though post-paternity leave before I can start to think about
> > getting some real/paid work done.
> 
> This ain't about my feelings, but working together efficiently and in
> a constructive environment.
> 
> Also, failing to have adequate maintainer coverage over absence, or
> generally being overloaded, is never a valid excuse for how you deal
> with contributors. It takes some effort and a bit of time, but group
> maintainership in one form or another can take care of this very well.
> Brevity justified as efficient communication tends to torpedo that,
> since at least in my experience it just drive prospective volunteers
> away to more welcoming places.

I'm unsure of the foundations which this scenario builds upon.  Maybe
you've had some bad experiences with other Maintainers in the past
which have made you uber-sensitive, but FWIW I think you're
over-reacting to what were perfectly adequate review comments provided
from one Maintainer to another.

There wasn't any malice or harshness in my recommendations to you nor
did I make any unreasonable requests of you.  Merely an innocent
misunderstanding in the first instance and some gentle advice in the
second.  If constructive feedback isn't something that you deal with
well, perhaps life as a contributor (outside of your own domain at
least) isn't for you.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
