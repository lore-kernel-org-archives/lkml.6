Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CBEC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A602150E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fjB9ZGEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A602150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932908AbeGDKFM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:05:12 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38692 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753046AbeGDKFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:05:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id a5-v6so3646862edt.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 03:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=d7Jdobzbf7/ccSMaZPyPa60GMgwgb4smlMAjHg7690Y=;
        b=fjB9ZGEh9YeWCLbLOTrUlatwKvMWZWiXVVClA1nZMwolGPaXoQIx006pRrR12nkouh
         YpiA3CY3G359kO2miSSKX/Ssc1/PcGZdA1D0Ybb14ZaQ8yrQwF/soTL2iSvAAGqQ3V3U
         PGC3HC6I32z/2vtN8yNdpTn4uzMgzHXoA3TA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=d7Jdobzbf7/ccSMaZPyPa60GMgwgb4smlMAjHg7690Y=;
        b=NPWcPoyv94VJviJPuku1KeK4I7Fo+ErSjPyFlGfTYIUAcvZmSrH7b6otYJYMTISKah
         yfXtser/bmHiHJ4xfuvQqW6y7QuY2ZYS4WK38mpceWgI2HYCXDSK1EX5Q372SmTPfDT8
         lJSqYDgSVN3+c/SmLI2+WgiUgKVtX5meV70u31lmQgM/n0oNf7pKAYmBCrLoBRcUjfxy
         TqeQ0AyMhlI8gaRYXBsWxXWg3LRH+pCPpC+FuBH1gZvHHtt6oxC+pTQmz4z3Do3DOzLD
         8Fr+5TkX1iJfC/5JdLu3edKEUFKT7wUr5I8v2X8E1JG52xVJ5ccO3qg8EqJFNualMGim
         XfCQ==
X-Gm-Message-State: APt69E2Jszu1yAt75DCNBPccwOj4zQreVyuJb3FcOS85hLTAQDyKK5Hy
        +RssNAn14+HL4UdVZ4M5/u8gaQ==
X-Google-Smtp-Source: AAOMgpf2a90zGQ/FN17g8Z/TORJqexYp1KMc2vi2g8pq5p6E+13n06AXy3w+n4M2GkNKiZNXKhxhbw==
X-Received: by 2002:a50:a2e5:: with SMTP id 92-v6mr176994edm.106.1530698709534;
        Wed, 04 Jul 2018 03:05:09 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id l5-v6sm1498118edn.18.2018.07.04.03.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 03:05:08 -0700 (PDT)
Date:   Wed, 4 Jul 2018 12:05:06 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH] backlight: remove obsolete comment for ->state
Message-ID: <20180704100506.GT3891@phenom.ffwll.local>
Mail-Followup-To: Lee Jones <lee.jones@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
References: <20180503141517.28207-1-daniel.vetter@ffwll.ch>
 <20180704093447.GU20176@dell>
 <20180704093816.GV20176@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180704093816.GV20176@dell>
X-Operating-System: Linux phenom 4.16.0-2-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 10:38:16AM +0100, Lee Jones wrote:
> On Wed, 04 Jul 2018, Lee Jones wrote:
> 
> > > Jani spotted this when reviewing my earlier patch to remove the driver
> > > internal usage of this field in
> > > 
> > > commit 3cf91adaa594e8933af1727942ac560e5c7bc70e
> > > Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > Date:   Wed Apr 25 19:42:52 2018 +0200
> > > 
> > >     backlight: Nuke BL_CORE_DRIVER1
> > 
> > FYI, sending patches like this is not a good idea.
> > 
> > I'll clean it up for you this time, but in future please send patches
> > properly and place any additional comments you may have below the
> > '---' line.
> 
> Ah, I see what you've tried to do.  This hurt my eyes! :)
> 
> It's more conventional to reference commits like:
> 
>   Commit 3cf91adaa594 ("backlight: Nuke BL_CORE_DRIVER1")
> 
> Again, I'll make the amendment to avoid further confusion.

So the first mail doesn't even bother to explain what's objectionable and
the 2nd mail still says "This hurts my eyes!".

Over whitespace in the commit message.

This kind of stuff is why graphics people really don't enjoy contributing
to the kernel at large. A friendly request to resend with the color choice
adjusted would go a lot further.

Thanks, Daniel

> 
> > > Cc: Jani Nikula <jani.nikula@intel.com>
> > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > > Cc: Lee Jones <lee.jones@linaro.org>
> > > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > > Cc: Jingoo Han <jingoohan1@gmail.com>
> > > ---
> > >  include/linux/backlight.h | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> > > index 7fbf0539e14a..0b5897446dca 100644
> > > --- a/include/linux/backlight.h
> > > +++ b/include/linux/backlight.h
> > > @@ -79,7 +79,6 @@ struct backlight_properties {
> > >  	/* Backlight type */
> > >  	enum backlight_type type;
> > >  	/* Flags used to signal drivers of state changes */
> > > -	/* Upper 4 bits are reserved for driver internal use */
> > >  	unsigned int state;
> > >  
> > >  #define BL_CORE_SUSPENDED	(1 << 0)	/* backlight is suspended */
> > 
> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
