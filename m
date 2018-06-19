Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCD2C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DED20652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KjT0DtmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DED20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966655AbeFSPej (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:34:39 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40468 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966078AbeFSPeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:34:36 -0400
Received: by mail-qk0-f196.google.com with SMTP id r66-v6so64938qkr.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 08:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=OcYE8modkORbxN9aUplwftmCXbn8u5A1sykZQ63PoKQ=;
        b=KjT0DtmPL2gXg9H9AR6yJqK8rOcyd264rEzETnBOxBD3Ru5cAQeTj2oGW5EVrMSkyZ
         4hYNKuplxTtNa+QDwQzbuMmhrbxsBGjDsOCRCaKTOkS1V/qMUN5xKOz7UHrwZxcl9cMm
         pfa53yc/FhhGhRoXClhk1XeXHW2vPdoeyWQgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=OcYE8modkORbxN9aUplwftmCXbn8u5A1sykZQ63PoKQ=;
        b=K3XK27RjZQ63dCz31GSjaAFjn2x1M9NTWidqTdfbqksW5P7x4atlFkZc3szyFwMlv0
         CUW+rK54i/Is6o+E/HrTFhmP4np3crvl0DYFoJxGO9LXvZyS0iS0nqKk9q3w37EvSO+0
         2kwaVBomLsc2i0RKD/9feHP3kodxkUZM7hqkDDR5/p5q3/e+iRrw2R2U97G8ltsbDrof
         iQ9q/eBIJp42ibcNV4G40FOXG2mTD6g2AdICyUk/t0Fj13+qCfN7EXtvY7JPZpkkJq7J
         xLmDzy4Nh4geC+yLz4PhrlCP1J8d/l+8uR3sjWtebbW7aDmfX7aO3kvVWVaRyY+c+vd5
         dZcA==
X-Gm-Message-State: APt69E2U+eqMMha+G1D7cFRL1n79ebIx64FVH3rIFNzFrrh/6xcGIIoJ
        m2pU4SQ3WXPcAWNzF70vSILa/g==
X-Google-Smtp-Source: ADUXVKLLCkWiN2LycQs9G04gQUKMcA8TSfEAWdQbEne+Rwn8HPrmXymqwEyPTwZYm2Eyk/qfKFNpKw==
X-Received: by 2002:a37:9984:: with SMTP id b126-v6mr13808758qke.307.1529422475952;
        Tue, 19 Jun 2018 08:34:35 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id f99-v6sm14943340qkh.85.2018.06.19.08.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 08:34:35 -0700 (PDT)
Date:   Tue, 19 Jun 2018 11:34:34 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Adam Borowski <kilobyte@angband.pl>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] have the vt console preserve unicode characters
In-Reply-To: <20180619130953.bxil552igfkckjmr@angband.pl>
Message-ID: <nycvar.YSQ.7.76.1806191047070.16670@knanqh.ubzr>
References: <20180617190706.14614-1-nicolas.pitre@linaro.org> <20180619130953.bxil552igfkckjmr@angband.pl>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2018, Adam Borowski wrote:

> On Sun, Jun 17, 2018 at 03:07:02PM -0400, Nicolas Pitre wrote:
> > The vt code translates UTF-8 strings into glyph index values and stores
> > those glyph values directly in the screen buffer. Because there can only
> > be at most 512 glyphs, it is impossible to represent most unicode
> > characters, in which case a default glyph (often '?') is displayed
> > instead. The original unicode value is then lost.
> > 
> > The 512-glyph limitation is inherent to VGA displays, but users of
> > /dev/vcs* shouldn't have to be restricted to a narrow unicode space from
> > lossy screen content because of that. This is especially true for
> > accessibility applications such as BRLTTY that rely on /dev/vcs to rander
> > screen content onto braille terminals.
> 
> You're thinking small.  That 256 possible values for Braille are easily
> encodable within the 512-glyph space (256 char + stolen fg brightness bit,
> another CGA peculiarity). 

Braille is not just about 256 possible patterns. It is often the case 
that a single print character is transcoded into a sequence of braille 
characters given that there is more than 256 possible print characters. 
And there are different transcoding rules for different languages, and 
even different rules across different countries with the same language. 
This may get complicated very quickly and you really don't want that 
processing to live in the kernel.

The point is not to have a font that displays braille but to let user 
space access the actual unicode character that corresponds to a given 
screen position.

> Your patchset, though, can be used for proper
> Unicode support for the rest of us.

Absolutely. I think it is generic enough so that display drivers that 
would benefit from it may do so already. My patchset introduces one 
user: vc_screen. The selection code could be yet another easy convert. 
Beyond that it is a matter of extending the kernel interface for larger 
font definitions, etc. But being sight impaired myself I won't play with 
actual display driver code.

> The 256/512 value limitation applies only to CGA-compatible hardware; these
> days this means vgacon.  But most people use other drivers.  Nouveau forces
> graphical console, on arm* there's no such thing as VGA[1], etc.

I do agree with you.

> Thus, it'd be nice to use the structure you add to implement full Unicode
> range for the vast majority of people.  This includes even U+2800..FF.  :)

Be my guest if you want to use this structure. As for U+2800..FF, like I 
said earlier, this is not what most people use when communicating, so it 
is of little interest even to blind users except for displaying native 
braille documents, or showing off. ;-)

> > This patch series introduces unicode support to /dev/vcs* devices,
> > allowing full unicode access from userspace to the vt console which
> > can, amongst other purposes, appropriately translate actual unicode
> > screen content into braille. Memory is allocated, and possible CPU
> > overhead introduced, only if /dev/vcsu is read at least once.
> 
> What about doing so if any updated console driver is loaded?  Possibly, once
> the vt in question has been switched to (>99% people never see anything but
> tty1 during boot-up, all others showing nothing but getty).  Or perhaps the
> moment any non-ASCII character is output to the given vt.

Right now it is activated only when an actual user manifests itself. I 
think this is the right thing to do. If an updated console driver is 
loaded then it will activate unicode handling right away as you say.

> If memory usage is a concern, it's possible to drop the old structure and
> convert back only in the rare case the driver is unloaded; reads of old-
> style /dev/vc{s,sa}\d* are not speed-critical thus can use conversion on the
> fuly.  Unicode takes only 21 bits out of 32 you allocate, that's plenty of
> space for attributes: they currently take 8 bits; naive way gives us free 3
> bits that could be used for additional attributes.

If the core console code makes the switch to full unicode then yes, that 
would be the way to go to maintain backward compatibility. However 
vgacon users would see a performance drop when switching between VT's 
and we used to brag about how fast the Linux console used to be 20 years 
ago. Does it still matter today?

> > I'm a prime user of this feature, as well as the BRLTTY maintainer Dave Mielke
> > who implemented support for this in BRLTTY. There is therefore a vested
> > interest in maintaining this feature as necessary. And this received
> > extensive testing as well at this point.
> 
> So, you care only about people with faulty wetware.  Thus, it sounds like
> work that benefits sighted people would need to be done by people other than
> you. 

Hard for me to contribute more if I can't enjoy the result.

> So I'm only mentioning possible changes; they could possibly go after
> your patchset goes in:
> 
> A) if memory is considered to be at premium, what about storing only one
>    32-bit value, masked 21 bits char 11 bits attr?  On non-vgacon, there's
>    no reason to keep the old structures.

Absolutely. As soon as vgacon is officially relegated to second class 
citizen i.e. perform the glyph translation each time it requires 
a refresh instead of dictating how the core console code works then the 
central glyph buffer can go.

> B) if being this frugal wrt memory is ridiculous today, what about instead
>    going for 32 bits char (wasteful) 32 bits attr?  This would be much nicer
>    15 bit fg color + 15 bit bg color + underline + CJK or something.
> You already triple memory use; variant A) above would reduce that to 2x,
> variant B) to 4x.
> 
> Considering that modern machines can draw complex scenes of several
> megapixels 60 times a second, it could be reasonable to drop the complexity
> of two structures even on vgacon: converting characters on the fly during vt
> switch is beyond notice on any hardware Linux can run.

You certainly won't find any objections from me.

In the mean time, both systems may work in parallel for a smooth 
transition.


Nicolas
