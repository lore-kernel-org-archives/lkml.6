Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A620C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311A3213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bL9oPMTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311A3213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeJJEhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:37:31 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37550 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbeJJEhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:37:31 -0400
Received: by mail-vs1-f65.google.com with SMTP id r83so3023364vsc.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 14:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v5ciEMf+aCSnmC9e0ONNg/Tz2rbqR3jUBoCkBZshx30=;
        b=bL9oPMTOBpeALiLaJnFVBx7FpQKX562+IRDjrfpeR2yxqmbIIagfvkMSrtka/oyWJS
         0Q7E+F9B8YuWBKAyLlLRWuPHeD2PFi4dVdakjRVUnHvv14b+e/N9e9hvLnCAli9jniW/
         50LRxqUoMpn0+blZVG3KRAMVVoSEg+TbNncUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v5ciEMf+aCSnmC9e0ONNg/Tz2rbqR3jUBoCkBZshx30=;
        b=g+V2fiqahUAQ/0lrz4ieZK3TTZKzJbTkHG67MUBBmj5YE6wn+sNGHK2f/gl2XXwcM1
         EkjLO9i7w27k3alYQ4UCzIHT69gkapkVrJVOEqRr3ie94ZdnUxgTzf3l8DsYQviOUKDc
         pgbAOf9NPE6P4FZaVuTsh4VvWIqOcv/KBI6POYFd7tEaP2nWW5TE0wWSeAU0FshM4teH
         PZEPtbq2IhADLxR7fC5hGekgaHAFuXf6OiIUF9JqbqVIZJ/eY1JXVc+Vbp833B6CifwL
         uQAhGecUFzNmn13xIBtbgkG933l5peeTrP8R8vM4qYK0Qwu7DqsxqTzvwJ6t+SwPHRcG
         fYlw==
X-Gm-Message-State: ABuFfojZXV1Df1GikynH3hXh1oTW7OvbGrioyH2HWJ//5HmSqiEXcET+
        kkV/1XkRrUZcIU//2gaq+6255cVC+ig=
X-Google-Smtp-Source: ACcGV62XgTkZPiVxZYUBsYqSwVNyJTOdjmfRL8r4axdE7wSNm1FuEI3iTbjlmLEsw/HCySQuOFAPtQ==
X-Received: by 2002:a67:3bc9:: with SMTP id l70mr8297287vsi.44.1539119919223;
        Tue, 09 Oct 2018 14:18:39 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id e79sm2692757vsd.1.2018.10.09.14.18.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 14:18:37 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id w1so3012516vsj.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 14:18:37 -0700 (PDT)
X-Received: by 2002:a67:8316:: with SMTP id f22mr7634218vsd.6.1539119917355;
 Tue, 09 Oct 2018 14:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <1538574265-30235-1-git-send-email-alokc@codeaurora.org>
 <1538574265-30235-4-git-send-email-alokc@codeaurora.org> <153904219713.119890.7463642233895152532@swboyd.mtv.corp.google.com>
 <CAD=FV=XnYucy4JmgATrB89RYHTbzRC_GaouaRjHAocD4-H0ncg@mail.gmail.com>
 <153910152600.119890.14820584405992384926@swboyd.mtv.corp.google.com>
 <CAD=FV=U-ZZQhFKR9kxYnw=F1j+dExrsgFvjabYJ8AVmBDM4eXA@mail.gmail.com> <153911433511.119890.17831207059115471972@swboyd.mtv.corp.google.com>
In-Reply-To: <153911433511.119890.17831207059115471972@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 9 Oct 2018 14:18:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UAfF2rcqdJv30Vd6WXz1qciNVKj2aGq6YTO3+NLVE7yA@mail.gmail.com>
Message-ID: <CAD=FV=UAfF2rcqdJv30Vd6WXz1qciNVKj2aGq6YTO3+NLVE7yA@mail.gmail.com>
Subject: Re: [PATCH V5 3/3] spi: spi-geni-qcom: Add SPI driver support for
 GENI based QUP
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     alokc@codeaurora.org, Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, Oct 9, 2018 at 12:45 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Doug Anderson (2018-10-09 10:48:55)
> >
> > Ah, you're suggesting separating the platform_get_irq() and the
> > request_irq() so that we call platform_get_irq() as the first thing in
> > the function but don't do the request_irq() until later.  Yeah, that
> > could be done and I guess if you feel strongly about it I wouldn't
> > object to the change, but I don't feel it buys us a lot and I kind of
> > like keeping the two next to each other.  Specifically why I don't
> > think it buys us a lot:
> >
> > 1. You still need the "dev_err" print, right?  platform_get_irq()
> > doesn't automatically print errors for you I think.
>
> I usually leave it out. Who cares? Maybe we should throw a dev_err()
> into platform_get_irq() on failure so we can keep drivers cleaner and
> reduce a bunch of "can't find my IRQ" messages throughout the kernel.

Yeah, all the boilerplate code is annoying.  ...of course by hoisting
it up then you get a whole bunch of people that have "optional" IRQs
suddenly getting error messages spewed which is also no good.  IMO the
convention of Linux drivers I've always reviewed is to print errors
like this, so unless that changes my vote is to follow convention.


> > 2. You now need a local variable "irq".  By putting the
> > platform_get_irq() before the memory allocation you now can't store it
> > directly in mas->irq.  We could try using "ret" as a temporary
> > variable but that seems worse in this case since it'd be a bit
> > fragile.
> >
> > 3. You don't get rid of any error labels / error handling so we don't
> > really save any code
> >
> > When I tried this my diffstat says 8 lines added and 7 removed, so a
> > net increase in LOC FWIW.  I'm relying in gmail so my patch will be
> > whitespace-damaged (sigh), but you can find a clean one at:
> >
> > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/e0325d618e209c22379e3a4269c14627b19243a8%5E%21/#F0
> >
> > ...the basic idea is this though:
> >
>
> Thanks! Here's an updated patch that I haven't compile tested in any way
> that hoists up the IO mapping part too, which shows that the 'se' local
> variable is almost entirely useless.

Yeah, I'd be all for getting rid of "se".  I'm still not really seeing
the benefit of hoisting all the rest of the stuff up.  Do you feel
strongly about it?

In any case I think we've both said that all of our comments so far
are just nits and could be addressed in a followup patch.  Unless Mark
Brown wants these nits fixed ahead of time or has other changes he'd
like, I don't think we're expecting another spin of this patch from
Alok or Dilip, right?  We'd just expect them to post some follow-up
patches after Mark lands it?


-Doug
