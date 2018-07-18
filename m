Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92247ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E6F20693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Enqyesqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E6F20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbeGRBfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 21:35:24 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38823 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731492AbeGRBfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 21:35:24 -0400
Received: by mail-qt0-f194.google.com with SMTP id y19-v6so2650964qto.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 18:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=rKWWvqr4cxMXVLm0gybOjFfTfp/ZwNWw7784lzBuK9U=;
        b=Enqyesqn21m+hDxu6t6Uj+IKAZYSPY1O7vCrol63SQFnvHx/Eu4319U5ABt2xqu2ML
         rg0nL1lrGfUjQWAYF01h51sbg8p3Cmifbpuk5xOEK/GuOS1W3HmT2Fcz9tnd7rXGdKqZ
         GiGGlKIlL7HbhFCJvKKsykLIRGmAgr1FDPtzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=rKWWvqr4cxMXVLm0gybOjFfTfp/ZwNWw7784lzBuK9U=;
        b=MWml40lHnyRs8YbKj7KfQ2NBSlKpAB8rHXKdLo2/iOVCEdPjw5woedsdNWnXWrGGeu
         mXC4aKQpxL8du9nHx9z+uGDPmUylDqjzKvfry+L0aGlrefQkuPqMy9cX/7+KexcRAu3/
         CsM4BEvyOPeoOZduu615YDLV9nl7cEuHBpZvhBAY8fBW+dK5rTuTxPrUs01Mv8132cEL
         26oyZwS4bCI00GPSLaUcLxwg359SNueMeoUvLStDPhHy+aEx57/h0PGuTACwJG50Q+9g
         a3CrXro+4WpHhPP9shrz558UG3Jt8hFdZ8w1Ft38yLpSajtyruicWekW7KbOC7vNWohg
         b9bg==
X-Gm-Message-State: AOUpUlHsigqaK20KBOFh1xpI8xZRZqvcLjuj/xlueq+w1ycQa+ExifU3
        DxgEvyWeOpS0hW1oj71pBlk4GQ==
X-Google-Smtp-Source: AAOMgpdojMR3ObH8CMPqhp0xVDP23T/Jrw8/zNet3OAlaHLi+BKTkCbnVoXLzelEmAqEm8qHV7Q2mA==
X-Received: by 2002:a0c:9aef:: with SMTP id k47-v6mr4295607qvf.134.1531875610375;
        Tue, 17 Jul 2018 18:00:10 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id c93-v6sm2598760qkh.90.2018.07.17.18.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 18:00:09 -0700 (PDT)
Date:   Tue, 17 Jul 2018 21:00:08 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, linux-console@vger.kernel.org
Subject: Re: [PATCH v3 0/3] have the vt console preserve unicode characters
In-Reply-To: <20180628123803.GA22045@kroah.com>
Message-ID: <nycvar.YSQ.7.76.1807172055140.11681@knanqh.ubzr>
References: <20180627035642.8561-1-nicolas.pitre@linaro.org> <20180628123803.GA22045@kroah.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2018, Greg Kroah-Hartman wrote:

> On Tue, Jun 26, 2018 at 11:56:39PM -0400, Nicolas Pitre wrote:
> > The vt code translates UTF-8 strings into glyph index values and stores 
> > those glyph values in the screen buffer. Because there can only be at 
> > most 512 glyphs at the moment, it is impossible to represent most 
> > unicode characters, in which case a default glyph (often '?') is 
> > displayed instead. The original unicode value is then lost.
> > 
> > The 512-glyph limitation is inherent to text-mode VGA displays after 
> > which the core console code was modelled. This also means that the 
> > /dev/vcs* devices only provide user space with glyph index values, and 
> > then user applications must get hold of the unicode-to-glyph table the 
> > kernel is using in order to back-translate those into actual characters. 
> > It is not possible to get back the original unicode value when multiple 
> > unicode characters map to the same glyph, especially for the vast 
> > majority that maps to the default replacement glyph.
> > 
> > Users of /dev/vcs* shouldn't have to be restricted to a narrow unicode 
> > space from lossy screen content because of that. This is especially true 
> > for accessibility applications such as BRLTTY that rely on /dev/vcs to 
> > render screen content onto braille terminals.
> > 
> > It was also argued that the VGA-centric glyph buffer should eventually 
> > go entirely. The current design made sense when hardware was slow and 
> > managing the screen directly into the VGA memory made a difference (i.e. 
> > 25 years ago). Modern console display drivers no longer have to be 
> >    limited to 512 glyphs.
> > Quoting Alan Cox:
> > 
> > |The only driver that it suits is the VGA text mode driver, which at 
> > |2GHz+ is going to be fast enough whatever format you convert from. We 
> > |have the memory, the processor power and the fact almost all our 
> > |displays are bitmapped (or more complex still) all in favour of 
> > |throwing away that limit.
> > 
> > This patch series introduces unicode screen support to the core console 
> > code with /dev/vcs* as a first user. Memory is allocated, and possible 
> > CPU overhead introduced, only if /dev/vcsu is read at least once. For 
> > now both the glyph and unicode buffers are maintained in parallel to 
> > allow for a smooth transition.
> > 
> > I'm a prime user of this new /dev/vcsu interface, as well as the BRLTTY 
> > maintainer Dave Mielke who implemented support for this in BRLTTY. There 
> > is therefore a vested interest in maintaining this feature as necessary. 
> > And this received extensive testing as well at this point.
> > 
> > This is also available on top of v4.18-rc2 here:
> > 
> >   git://git.linaro.org/people/nicolas.pitre/linux vt-unicode
> > 
> > Changes from v2:
> > 
> > - Dropped patch #4 as it was useful only for initial debugging and it 
> >   attracted all the review comments so far -- actually more than the 
> >   patch is worth.
> 
> If you want this "feature" back, I'll be glad to take it, as odds are it
> will help when any future person wants to test any changes in the code.
> 
> So feel free to resend it, I have no objection to it as-is.
> 
> And I've queued the other 3 up now, nice job.

Thanks!

I'm about to send 3 more patches to put on top of what you already have: 
patch #1 is that debugging code (still disabled by default), patch #2 
removes the VLA, and patch #3 updates devices.txt.


Nicolas
