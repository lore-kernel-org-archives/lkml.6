Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51924C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9972087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="efKXHqc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9972087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeILX1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:27:41 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36835 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbeILX1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:27:41 -0400
Received: by mail-it0-f65.google.com with SMTP id u13-v6so4384618iti.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 11:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=F5etB/1CHk5msEDSy26RnpHD7tD4coVQSklM3jfv9dE=;
        b=efKXHqc8SlwNpfr1JYI2LjOiwbqCE/in5kPbwqjNm/xSd4TRrYriRgW3E7Rar8BRyV
         u3vRr4V/UHKLS4put7SGEghVHVFbQiH+xDvsfYoQxUnPnw8FW1Y8fbgGij0mSE83OwvN
         qJ/guUliNbPFgnD+EmkBOThJigna96LsyqUYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=F5etB/1CHk5msEDSy26RnpHD7tD4coVQSklM3jfv9dE=;
        b=fpqjhV4Tzz/bMMgUbPnkmm3MPaLkn+C+9dH8zwBr55O0EIth70OpaiXLSMbcmCSqjj
         qmlPEbrqDxR3rDN6Mb1Pxi6JoydfglpWZ4uPV2bfoX6kwhavrx9WkQqhxdsQZwm0sMct
         EXojPTddqboX6ccVxrkt3ZxDyXQ/5bQlOwXQDs+EWXnXY1a3Qv2GV4lRXrWg0YTj7u+q
         YofED/5dXlhe4rvjjnRYPcIeUpgJVi5zWTm3bFG7IAxWEDJmb+6PPCOAbooWaKDK4fEP
         z6wb3IqmmsKo4Wj3VmvdLsfHaBpQJI74ltLIxIJCh/QZOCLSt/EH2B2mDDfU9D7jTrGe
         UNnw==
X-Gm-Message-State: APzg51CbVltf0WIm4py8bVGVRx2zKk421/IdLfY3m4iT3mQfzih7EkSQ
        6Q7Wl03dEbglISRxBbMJXUrJajmFiLy7sLuFtpXZqQ==
X-Google-Smtp-Source: ANB0VdYu47d+0MpcyocVoyo7LimnLj1Mn68JoiRvAJfallmPpeKWSPrX2y7kMLCDh+v/lIl+XA+z1+clBxh0pxseuLs=
X-Received: by 2002:a24:3507:: with SMTP id k7-v6mr3164914ita.13.1536776517148;
 Wed, 12 Sep 2018 11:21:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:bf05:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 11:21:56
 -0700 (PDT)
X-Originating-IP: [2a02:168:569e:0:3106:d637:d723:e855]
In-Reply-To: <20180912135206.GA21008@DESKTOP-E1NTVVP.localdomain>
References: <20180823152343.6474-1-brian.starkey@arm.com> <20180823152343.6474-2-brian.starkey@arm.com>
 <20180831081730.GM21634@phenom.ffwll.local> <20180907124535.GA3461@DESKTOP-E1NTVVP.localdomain>
 <20180907192626.GA7176@phenom.ffwll.local> <20180910085003.GA36@DESKTOP-E1NTVVP.localdomain>
 <20180910195325.GC19774@phenom.ffwll.local> <20180912135206.GA21008@DESKTOP-E1NTVVP.localdomain>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 12 Sep 2018 20:21:56 +0200
X-Google-Sender-Auth: ZQI3y66XGzoo2nDaFmZbnTbO9RA
Message-ID: <CAKMK7uF8HHZtej7ZW0MP2RvBW7CJPZ2Xg8PbKEQ+vZLRDOM64w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] drm/fourcc: Add 'bpp' field for formats with
 non-integer bytes-per-pixel
To:     Brian Starkey <brian.starkey@arm.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Stone <daniel@fooishbar.org>,
        Dave Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandru-Cosmin Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Ayan Kumar Halder <ayan.halder@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        "Kristian H . Kristensen" <hoegsberg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 3:52 PM, Brian Starkey <brian.starkey@arm.com> wrote:
> On Mon, Sep 10, 2018 at 09:53:25PM +0200, Daniel Vetter wrote:
>>
>> On Mon, Sep 10, 2018 at 09:50:03AM +0100, Brian Starkey wrote:
>>>
>>> Hi,
>>>
>>> On Fri, Sep 07, 2018 at 09:28:44PM +0200, Daniel Vetter wrote:
>>> > On Fri, Sep 07, 2018 at 01:45:36PM +0100, Brian Starkey wrote:
>>> > > Hi Daniel,
>>> > >
>>> > > On Fri, Aug 31, 2018 at 10:17:30AM +0200, Daniel Vetter wrote:
>>> > > > On Thu, Aug 23, 2018 at 04:23:41PM +0100, Brian Starkey wrote:
>>> > > > > Some formats have a non-integer number of bytes per pixel, which
>>> > > > > can't
>>> > > > > be handled with the existing 'cpp' field in drm_format_info. To
>>> > > > > handle
>>> > > > > these formats, add a 'bpp' field, which is only used if cpp[0] ==
>>> > > > > 0.
>>> > > > >
>>> > > > > This updates all the users of format->cpp in the core DRM code,
>>> > > > > converting them to use a new function to get the bits-per-pixel
>>> > > > > for any
>>> > > > > format.
>>> > > > >
>>> > > > > It's assumed that drivers will use the 'bpp' field when they add
>>> > > > > support
>>> > > > > for pixel formats with non-integer bytes-per-pixel.
>>> > > > >
>>> > > > > Signed-off-by: Brian Starkey <brian.starkey@arm.com>
>>> > > >
>>> > > > I assume you still require that stuff is eventually aligned to
>>> > > > bytes? In
>>> > > > that case, can we subsume this into the tile work Alex is doing?
>>> > > > It's
>>> > > > essentially just another special case of having storage-size units
>>> > > > measured in bytes which span more than 1x1 pixel. And I kinda don't
>>> > > > want a
>>> > > > metric pile of special cases here in the format code, because that
>>> > > > just
>>> > > > means every driver handles a different subset, with different bugs.
>>> > > > -Daniel
>>> > >
>>> > > Sorry for the delay, been struggling to free some cycles to think
>>> > > about this.
>>> > >
>>> > > I'm not sure how to pull this in with the tiling stuff. In the AFBC
>>> > > case then our AFBC superblocks are always nice round numbers (256
>>> > > pixels), and so it does end up being a multiple of bytes.
>>> > >
>>> > > However, AFBC supports different superblock sizes, so picking just
>>> > > one
>>> > > doesn't really work out, and putting AFBC in the core format table
>>> > > which reflects AFBC doesn't seem good.
>>> > >
>>> > > We could make something up (e.g. call these formats "tiled" with 2x4
>>> > > tiles, which guarantees a multiple of 8), but it would be an
>>> > > arbitrarily-selected lie, which often seems to spell trouble. If we
>>> > > did do that, would you re-define cpp as "bytes-per-tile"? Otherwise
>>> > > we still need to add a new field anyway.
>>> > >
>>> > > What's the pile of special cases you're worried about? The helper
>>> > > I've
>>> > > added here means that drivers which need to care can use one API and
>>> > > not implement their own bugs.
>>> >
>>> > I'm confused ... the new bits-per-pixel stuff you're adding here is for
>>> > yuv formats, not afbc. I'm just suggesting we have only 1 way of
>>> > describing such formats that need more descriptive power than cpp,
>>> > whether
>>> > they have some kind of pixel-groups or small tiles.
>>>
>>> Well, not really. The three formats which have non-integer cpp are:
>>> DRM_FORMAT_VUY101010, DRM_FORMAT_YUV420_8BIT and
>>> DRM_FORMAT_YUV420_10BIT. These formats are only valid with non-linear
>>> modifiers (no linear encoding is defined). Mali only supports them
>>> with AFBC.
>>>
>>> The formats themselves have no notion of tiling or grouping - the
>>> modifier adds that. I'm not aware of any non-AFBC uses of these
>>> formats, so I don't want to "make up" a small-tile layout restriction
>>> for them.
>>
>>
>> Ah, I missed that.
>>
>>> > For very special stuff like afbc you need to validate in the driver
>>> > anyway, too complicated. So I have no idea why you bring this up here?
>>>
>>> Sure, we can just let drivers provide their own format_info's for
>>> these, if that's what you prefer. The core format checking code can
>>> error out if it ever encounters them.
>>
>>
>> It's format_info we're talking about. What I mean is that you just set all
>> these to 0 and let the format_info code ignore it. And then having a
>> bespoke drm_format_check_afbc helper function or similar, which checks all
>> the layout restrictions of afbc.
>>
>> I still maintain that bpp and tile_size are equavalent, and we really
>> don't need both. Both are defacto a form of numerator/denumerator. If you
>> don't like that you have to introduce "fake" tiles for afbc, then we can
>> rename tile_size to numerator and tile_h/w to denumerator_h/w. Doesn't
>> change one bit of the math. bpp simply hardcodes a denumerator of 8, and I
>> don't see why we need that special case. Except if you love to write
>> redundant self tests for all the math :-)
>>
>> So two options that I think are reasonable:
>> - one common numerator/denumerator. I don't care how you call that
>>  bikeshed.
>
>
> Sorry for being dense, but I'm still struggling to get my head around
> what you're suggesting. In particular "bpp simply hardcodes a
> denumerator of 8" didn't make any sense to me. Could you give concrete
> examples for how you think this would look for e.g.
>
> - DRM_FORMAT_VUY101010. 30-bits per pixel, no tiling.
> - DRM_FORMAT_Y0L2. 16-bits per pixel, 2x2 pixel tiles

Ok, a few examples:

4 cpp: tile_size = 4, tile_h/w = 1

30 bpp: In cpp that's 30 / 8 = 15 / 4. So would be a tile_size = 15,
tile_w = 4, tile_h = 1. If you check the math, this matches exactly
all the same addfb values as what you have in your bpp computation
(but only if you simplify the quotient).

16 bpp, 2x2 tiles: No real math needed here, tile_size = 2 * 2 * 2 =
8, tile_h/w = 2.


> I think we need two things:
> - The size, in bits, of a tile

Nope, you only need it in bytes, because in the end all buffers must
align to bytes. The generic formula is:

X bpp: tile_size = X / gcd(X, 8), tile_w = 8 / gcd(X, 8), tile_h = 1.

No bits needed anywhere.

> - The width and height, in pixels, of a tile (currently implicitly
>   1x1)

Yeah, but only if you use the cpp thing. We could even throw that out,
and entirely replace it with tile_size, with the rule that if tile_h/w
= 0, then you assume they're both 1.

> Do you disagree? Are you just saying that instead of adding .bpp I
> should be replacing .cpp with .bpp wholesale?

Hopefully the above explains what I mean, and demonstrates that you
can express any bpp in terms of tile_size/tile_w. Because bpp is just
a special quotient, with a fixed 8 divisor.
-Daniel

>> - don't check afbc using format_info, have your own helper that does that
>>  using custom code.
>
>
> We can do this, no problem.
>
> Thanks,
> -Brian
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
