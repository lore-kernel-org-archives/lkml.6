Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89875C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D75422DA8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fy9uJbZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D75422DA8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933629AbeGDKeH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:34:07 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42609 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932733AbeGDKeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:34:05 -0400
Received: by mail-wr0-f194.google.com with SMTP id p1-v6so4804932wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 03:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wXM/1Y4oEhMGVGIbLpdCVXb9LpPA5DdethSAFskiKkM=;
        b=Fy9uJbZmdBadakhzbrQ7EWhS3Z4yr8yZr1M2UKEmlhyiPz5lvmlu0k8lpiaFf8n+A0
         toKIloWzhSurJPnqxqBjYgre9sJjDfPpUK3N3jTeSLJZegKaewcJk/aBMBmvbpxFCqnK
         QVrzUEW0kWaRSavBLcBrawoYbE6Q7ehsn13to=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wXM/1Y4oEhMGVGIbLpdCVXb9LpPA5DdethSAFskiKkM=;
        b=Nt2ppRzqe+2Hpo553P2+vHBsKyiV2R08usYva560lmXgFDlEtzHcFBbQ8aV40V8UuH
         sPlGgbbPuaJHRSMOZSFlDf7v6neAh/f6tVzsqcsw+MFJF2Rjvai95vyD98qHFmeC7EtU
         EteIB7i+BD+HaMD4klLVoVFx+BGF0GFhyJf6ZZAlpnKzWYUU++7xnthSpL8dPH3yTAAk
         D/5vJNu7q+eRZG5M7bPRib1lBue1aBxYK9K3Z6ND8b8F2J9bWdNmsnPSi0vBa2d2CoEI
         C1n3bqeTMk5lp2wskFMtl4Qz5jmzVXdSIYkXHnnSGsBUjHsH4gZY4EIuL0LCdkyZTsIm
         Lm0w==
X-Gm-Message-State: APt69E1l8HbC+Pt4ynrhad15h3GdNRoMtlKdy/T6kNbniyCW3fk2eMBF
        3UWO3jVDXi91SlsH1D/JNoVMN7CCh/c=
X-Google-Smtp-Source: AAOMgpdwbog1x/UriDL2+lxFhn/U6d4wcnHdD//xIrY1+caLZSR4tUA0qmEO0MFxORH9VR1RMG0v9Q==
X-Received: by 2002:adf:ad45:: with SMTP id p63-v6mr1155991wrc.222.1530700444264;
        Wed, 04 Jul 2018 03:34:04 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id k18-v6sm1319291wrn.61.2018.07.04.03.34.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 03:34:03 -0700 (PDT)
Date:   Wed, 4 Jul 2018 11:34:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH] backlight: remove obsolete comment for ->state
Message-ID: <20180704103401.GB496@dell>
References: <20180503141517.28207-1-daniel.vetter@ffwll.ch>
 <20180704093447.GU20176@dell>
 <20180704093816.GV20176@dell>
 <20180704100506.GT3891@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180704100506.GT3891@phenom.ffwll.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Jul 2018, Daniel Vetter wrote:
> On Wed, Jul 04, 2018 at 10:38:16AM +0100, Lee Jones wrote:
> > On Wed, 04 Jul 2018, Lee Jones wrote:
> > 
> > > > Jani spotted this when reviewing my earlier patch to remove the driver
> > > > internal usage of this field in
> > > > 
> > > > commit 3cf91adaa594e8933af1727942ac560e5c7bc70e
> > > > Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > > Date:   Wed Apr 25 19:42:52 2018 +0200
> > > > 
> > > >     backlight: Nuke BL_CORE_DRIVER1
> > > 
> > > FYI, sending patches like this is not a good idea.
> > > 
> > > I'll clean it up for you this time, but in future please send patches
> > > properly and place any additional comments you may have below the
> > > '---' line.
> > 
> > Ah, I see what you've tried to do.  This hurt my eyes! :)
> > 
> > It's more conventional to reference commits like:
> > 
> >   Commit 3cf91adaa594 ("backlight: Nuke BL_CORE_DRIVER1")
> > 
> > Again, I'll make the amendment to avoid further confusion.
> 
> So the first mail doesn't even bother to explain what's
> objectionable

In the first instance it looked as though you'd copied and pasted `git
log`, which if you'd done so would have been obvious to you and would
have required no further explanation.

Also bear in mind that I took your standing within the kernel
community into consideration, so speaking to you like a n00b or going
into unnecessary detail could have been considered superfluous at best
and condescending at worst.

> the 2nd mail still says "This hurts my eyes!".

It certainly did, yes.

Usually taken to meaning that it was hard to read in these scenarios.

> Over whitespace in the commit message.

Nothing to do with white space.  It was the format by which you chose
to reference a previous commit.  Instead it looked like a patch
formatting error.  I have received patches pasted from `git log`
before, and this looked just the same.

Once I'd realised what was going on, I followed up to explain and
provided some feedback on what to do differently in future.

> This kind of stuff is why graphics people really don't enjoy contributing
> to the kernel at large. A friendly request to resend with the color choice
> adjusted would go a lot further.

I apologise if my brevity hurt your feelings.  I have 290 emails to
get though post-paternity leave before I can start to think about
getting some real/paid work done.

> > > > Cc: Jani Nikula <jani.nikula@intel.com>
> > > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > > > Cc: Lee Jones <lee.jones@linaro.org>
> > > > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > > > Cc: Jingoo Han <jingoohan1@gmail.com>
> > > > ---
> > > >  include/linux/backlight.h | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > > 
> > > > diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> > > > index 7fbf0539e14a..0b5897446dca 100644
> > > > --- a/include/linux/backlight.h
> > > > +++ b/include/linux/backlight.h
> > > > @@ -79,7 +79,6 @@ struct backlight_properties {
> > > >  	/* Backlight type */
> > > >  	enum backlight_type type;
> > > >  	/* Flags used to signal drivers of state changes */
> > > > -	/* Upper 4 bits are reserved for driver internal use */
> > > >  	unsigned int state;
> > > >  
> > > >  #define BL_CORE_SUSPENDED	(1 << 0)	/* backlight is suspended */
> > > 
> > 
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
