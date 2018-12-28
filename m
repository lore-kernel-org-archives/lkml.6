Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5474DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7942087F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fhXOmjvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeL1MCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:02:09 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34425 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeL1MCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:02:08 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so17427386ede.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 04:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ce0rj6CYDpN4dT4IO3V4JGJB7shOpKg7d+MOJatLcZA=;
        b=fhXOmjvxFmS337N0fKx6Q96P7X9Ewg3A2ton6zSP0SAfBco3/4+48kWznE2pTXWP7N
         nzGSRSO2VAAEtgc3MRN1vqNPpeKN6IRJIyZP2wu0Mc6Fd9BdXGTmniDVZXtOpQwhUJ+W
         1t8AHB+YMY0i7cJeFwmCjzRgfuGODOKg4EqVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Ce0rj6CYDpN4dT4IO3V4JGJB7shOpKg7d+MOJatLcZA=;
        b=E17f7V1c8Wl6ZWu9L8tHTZw7bb90SZ/KK8nhwfB1ED6Ehp9qzXHG5UHww+7+Ue4V+l
         h1X95LRr9OY5SNeoSXNr66AbI6zCzKvxmTCW0IgxiXHFbqatUBsrvwrlehK+clyozELO
         j4rs7EMA6iAP37tvl/G8Z9tZATp5nbjjbTXzxh9+PgFS3iPszIW8B4VCbxElYD2m34Ll
         +9s/Vci/sDayWwxjg+1iRspQDTva4EATBmpdibfunRxiifuLPuAhawskREFZwnw/9MPx
         HtI2XZ+envSnSb5LjAApHN6fUUpDx5hpa996zQn9XcQPyrnj/xQhYTCqFIxbW+dtB5Gt
         0syw==
X-Gm-Message-State: AA+aEWYZRn9cjnCDluohK/kQTT0Z+q937IZWAlOXM9y+NAs9qQqbO4DE
        btI/gRElsMXN85QuEylgaVHCRA==
X-Google-Smtp-Source: AFSGD/Wo3nbtVrhiVS55vXL+WSozpnwfja0QOfG1/ihODdMTZDVfZDh7OgjusoenhLJGmF83lW/lEA==
X-Received: by 2002:a50:b6d2:: with SMTP id f18mr21912520ede.263.1545998526708;
        Fri, 28 Dec 2018 04:02:06 -0800 (PST)
Received: from dvetter-linux.ger.corp.intel.com ([194.230.159.220])
        by smtp.gmail.com with ESMTPSA id a17-v6sm5103167ejr.55.2018.12.28.04.02.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 04:02:05 -0800 (PST)
Date:   Fri, 28 Dec 2018 13:02:03 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Ivan Mironov <mironov.ivan@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        saahriktu <mail@saahriktu.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: Re: [RFC PATCH 1/2] drm/fb-helper: Bring back workaround for bugs of
 SDL 1.2
Message-ID: <20181228120203.GQ9058@dvetter-linux.ger.corp.intel.com>
Mail-Followup-To: Ivan Mironov <mironov.ivan@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        saahriktu <mail@saahriktu.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
References: <20181226121124.1632-1-mironov.ivan@gmail.com>
 <20181226121124.1632-2-mironov.ivan@gmail.com>
 <20181227120046.GC9058@dvetter-linux.ger.corp.intel.com>
 <00547df7d87c7fe6d8c842d5b29a0cd6809cdf5d.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00547df7d87c7fe6d8c842d5b29a0cd6809cdf5d.camel@gmail.com>
X-Operating-System: Linux dvetter-linux.ger.corp.intel.com
 4.19.10-200.fc28.x86_64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 04:26:56AM +0500, Ivan Mironov wrote:
> On Thu, 2018-12-27 at 13:00 +0100, Daniel Vetter wrote: 
> > > +	/*
> > > +	 * Workaround for SDL 1.2, which is known to be setting all pixel format
> > > +	 * fields values to zero in some cases. We treat this situation as a
> > > +	 * kind of "use some reasonable autodetected values".
> > > +	 */
> > > +	if (!var->red.offset     && !var->green.offset    &&
> > > +	    !var->blue.offset    && !var->transp.offset   &&
> > > +	    !var->red.length     && !var->green.length    &&
> > > +	    !var->blue.length    && !var->transp.length   &&
> > > +	    !var->red.msb_right  && !var->green.msb_right &&
> > > +	    !var->blue.msb_right && !var->transp.msb_right) {
> > > +		u8 depth;
> > > +
> > > +		/*
> > > +		 * There is no way to guess the right value for depth when
> > > +		 * bpp is 16 or 32. So we just restore the behaviour previously
> > > +		 * introduced here by commit 785b93ef8c309. In fact, this was
> > > +		 * implemented even earlier in various device drivers.
> > > +		 */
> > > +		switch (var->bits_per_pixel) {
> > > +		case 16:
> > > +			depth = 15;
> > > +			break;
> > > +		case 32:
> > > +			depth = 24;
> > > +			break;
> > > +		default:
> > > +			depth = var->bits_per_pixel;
> > > +			break;
> > > +		}
> > 
> > The guesswork here looks fishy. We should still have the drm-side format,
> > and should use that.
> 
> This existed for a very long time until problematic commit was applied.
> And there is a clear evidence that it was actually used by
> applications.

I'm not against guessing this stuff, but we know have much better format
handling code than when this code was originally written. I just want to
use that (like it's used everywhere else in this file now). fb->format
gives you the right depth, no guessing needed at all.

And if you guess wrong here, you'll fail in these format checks later on.
-Daniel
> 
> > Otherwise the patches look good I think, but they
> > need a Fixes: tag and cc: stable so backporters know what to do with
> > these.
> > 
> 
> I added "cc: stable" into the regression fix. Also added more info into
> the commit messages. See the PATCH v1 in the mailing list.
> 
> Thanks.
> 
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
