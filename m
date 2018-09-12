Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8295C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0F420854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0F420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeILS4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:56:51 -0400
Received: from foss.arm.com ([217.140.101.70]:59938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbeILS4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:56:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E144280D;
        Wed, 12 Sep 2018 06:52:13 -0700 (PDT)
Received: from DESKTOP-E1NTVVP.localdomain (desktop-e1ntvvp.cambridge.arm.com [10.1.34.160])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5C743F703;
        Wed, 12 Sep 2018 06:52:11 -0700 (PDT)
Date:   Wed, 12 Sep 2018 14:52:07 +0100
From:   Brian Starkey <brian.starkey@arm.com>
To:     dri-devel@lists.freedesktop.org, daniel@fooishbar.org,
        airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        linux-kernel@vger.kernel.org, alexandru-cosmin.gheorghe@arm.com,
        liviu.dudau@arm.com, ayan.halder@arm.com, tfiga@chromium.org,
        hoegsberg@chromium.org
Subject: Re: [RFC PATCH v2 1/3] drm/fourcc: Add 'bpp' field for formats with
 non-integer bytes-per-pixel
Message-ID: <20180912135206.GA21008@DESKTOP-E1NTVVP.localdomain>
References: <20180823152343.6474-1-brian.starkey@arm.com>
 <20180823152343.6474-2-brian.starkey@arm.com>
 <20180831081730.GM21634@phenom.ffwll.local>
 <20180907124535.GA3461@DESKTOP-E1NTVVP.localdomain>
 <20180907192626.GA7176@phenom.ffwll.local>
 <20180910085003.GA36@DESKTOP-E1NTVVP.localdomain>
 <20180910195325.GC19774@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180910195325.GC19774@phenom.ffwll.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 09:53:25PM +0200, Daniel Vetter wrote:
>On Mon, Sep 10, 2018 at 09:50:03AM +0100, Brian Starkey wrote:
>> Hi,
>>
>> On Fri, Sep 07, 2018 at 09:28:44PM +0200, Daniel Vetter wrote:
>> > On Fri, Sep 07, 2018 at 01:45:36PM +0100, Brian Starkey wrote:
>> > > Hi Daniel,
>> > >
>> > > On Fri, Aug 31, 2018 at 10:17:30AM +0200, Daniel Vetter wrote:
>> > > > On Thu, Aug 23, 2018 at 04:23:41PM +0100, Brian Starkey wrote:
>> > > > > Some formats have a non-integer number of bytes per pixel, which can't
>> > > > > be handled with the existing 'cpp' field in drm_format_info. To handle
>> > > > > these formats, add a 'bpp' field, which is only used if cpp[0] == 0.
>> > > > >
>> > > > > This updates all the users of format->cpp in the core DRM code,
>> > > > > converting them to use a new function to get the bits-per-pixel for any
>> > > > > format.
>> > > > >
>> > > > > It's assumed that drivers will use the 'bpp' field when they add support
>> > > > > for pixel formats with non-integer bytes-per-pixel.
>> > > > >
>> > > > > Signed-off-by: Brian Starkey <brian.starkey@arm.com>
>> > > >
>> > > > I assume you still require that stuff is eventually aligned to bytes? In
>> > > > that case, can we subsume this into the tile work Alex is doing? It's
>> > > > essentially just another special case of having storage-size units
>> > > > measured in bytes which span more than 1x1 pixel. And I kinda don't want a
>> > > > metric pile of special cases here in the format code, because that just
>> > > > means every driver handles a different subset, with different bugs.
>> > > > -Daniel
>> > >
>> > > Sorry for the delay, been struggling to free some cycles to think
>> > > about this.
>> > >
>> > > I'm not sure how to pull this in with the tiling stuff. In the AFBC
>> > > case then our AFBC superblocks are always nice round numbers (256
>> > > pixels), and so it does end up being a multiple of bytes.
>> > >
>> > > However, AFBC supports different superblock sizes, so picking just one
>> > > doesn't really work out, and putting AFBC in the core format table
>> > > which reflects AFBC doesn't seem good.
>> > >
>> > > We could make something up (e.g. call these formats "tiled" with 2x4
>> > > tiles, which guarantees a multiple of 8), but it would be an
>> > > arbitrarily-selected lie, which often seems to spell trouble. If we
>> > > did do that, would you re-define cpp as "bytes-per-tile"? Otherwise
>> > > we still need to add a new field anyway.
>> > >
>> > > What's the pile of special cases you're worried about? The helper I've
>> > > added here means that drivers which need to care can use one API and
>> > > not implement their own bugs.
>> >
>> > I'm confused ... the new bits-per-pixel stuff you're adding here is for
>> > yuv formats, not afbc. I'm just suggesting we have only 1 way of
>> > describing such formats that need more descriptive power than cpp, whether
>> > they have some kind of pixel-groups or small tiles.
>>
>> Well, not really. The three formats which have non-integer cpp are:
>> DRM_FORMAT_VUY101010, DRM_FORMAT_YUV420_8BIT and
>> DRM_FORMAT_YUV420_10BIT. These formats are only valid with non-linear
>> modifiers (no linear encoding is defined). Mali only supports them
>> with AFBC.
>>
>> The formats themselves have no notion of tiling or grouping - the
>> modifier adds that. I'm not aware of any non-AFBC uses of these
>> formats, so I don't want to "make up" a small-tile layout restriction
>> for them.
>
>Ah, I missed that.
>
>> > For very special stuff like afbc you need to validate in the driver
>> > anyway, too complicated. So I have no idea why you bring this up here?
>>
>> Sure, we can just let drivers provide their own format_info's for
>> these, if that's what you prefer. The core format checking code can
>> error out if it ever encounters them.
>
>It's format_info we're talking about. What I mean is that you just set all
>these to 0 and let the format_info code ignore it. And then having a
>bespoke drm_format_check_afbc helper function or similar, which checks all
>the layout restrictions of afbc.
>
>I still maintain that bpp and tile_size are equavalent, and we really
>don't need both. Both are defacto a form of numerator/denumerator. If you
>don't like that you have to introduce "fake" tiles for afbc, then we can
>rename tile_size to numerator and tile_h/w to denumerator_h/w. Doesn't
>change one bit of the math. bpp simply hardcodes a denumerator of 8, and I
>don't see why we need that special case. Except if you love to write
>redundant self tests for all the math :-)
>
>So two options that I think are reasonable:
>- one common numerator/denumerator. I don't care how you call that
>  bikeshed.

Sorry for being dense, but I'm still struggling to get my head around
what you're suggesting. In particular "bpp simply hardcodes a
denumerator of 8" didn't make any sense to me. Could you give concrete
examples for how you think this would look for e.g.

 - DRM_FORMAT_VUY101010. 30-bits per pixel, no tiling.
 - DRM_FORMAT_Y0L2. 16-bits per pixel, 2x2 pixel tiles

I think we need two things:
 - The size, in bits, of a tile
 - The width and height, in pixels, of a tile (currently implicitly
   1x1)

Do you disagree? Are you just saying that instead of adding .bpp I
should be replacing .cpp with .bpp wholesale?

>- don't check afbc using format_info, have your own helper that does that
>  using custom code.

We can do this, no problem.

Thanks,
-Brian

