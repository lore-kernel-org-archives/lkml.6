Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4053EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3DE23E70
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="A+og+X/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3DE23E70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933891AbeGDJSo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:18:44 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37213 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932439AbeGDJSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:18:41 -0400
Received: by mail-ed1-f65.google.com with SMTP id v22-v6so3548217edq.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 02:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=N91dGUim0rDZiIMmhDhrGnwPAL4TDwRnc9ws7bINH4M=;
        b=A+og+X/zOWroYnGWVacbHFFMLYzeFohuAbXbR3wg4P8xd8pecTuSF77U0PQ6fL7piI
         bi0d+4MbMpu1v+W5tynQsoXsdqne3au+f86P17CN2neWkLp141ggZRIM068CotALuDDh
         4EYxxgdhEX78FqqZ0+3pG6ZARKogXPO6UnmsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=N91dGUim0rDZiIMmhDhrGnwPAL4TDwRnc9ws7bINH4M=;
        b=CH7/Gs/YTAaF9VNUUJnkT/VKij+tVgrwejBWvQxU11Y/PbH5gJ3IQZSrNXAdf2sdlR
         kh4H9aF0DKC5MTn7dNSsSl53sZRuZnvVcd2g6exdSUyasZCg1Qm54ySmHSDq+bRVzi5+
         7MEmYlFD4++Xshy4K1JidSnrQFbUrtwAY6TlOxIp2EdIGbTaImfwY0FyJ8+Bk1s8xl4A
         MVl0x+f0CwaYm4KTRB7oMDc444UI99dsdCump/7n+S+Qprf/GoKvzuw4nUFdHuxrpm3U
         HBonBu3fyYCsuIU5gO3PYN4rCzfGq6zjYeJp6TbwAOXSlKtTloM/f4cCqKHxQoJ7kKcy
         g6cw==
X-Gm-Message-State: APt69E2GbrMDUXunXEzuC5Zee8pDC8vLCu+Xr3xsekHc5FZEyLV2pvlO
        aY0ng/XYhPkyOKXCo1/2cN6amg==
X-Google-Smtp-Source: AAOMgpefa6/qSWF84Uc8UAWRgAlZAWK992ugKNlx559ba3plukwSEmV/pcrNTuS7g4M2lKyY0bcSOQ==
X-Received: by 2002:a50:82c7:: with SMTP id 65-v6mr1854573edg.114.1530695919864;
        Wed, 04 Jul 2018 02:18:39 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id t20-v6sm1745924edd.93.2018.07.04.02.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 02:18:38 -0700 (PDT)
Date:   Wed, 4 Jul 2018 11:18:36 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH] backlight: remove obsolete comment for ->state
Message-ID: <20180704091836.GP3891@phenom.ffwll.local>
Mail-Followup-To: Daniel Thompson <daniel.thompson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>
References: <20180503141517.28207-1-daniel.vetter@ffwll.ch>
 <20180503143238.lfxacqos7t6xuays@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503143238.lfxacqos7t6xuays@holly.lan>
X-Operating-System: Linux phenom 4.16.0-2-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 03:32:38PM +0100, Daniel Thompson wrote:
> On Thu, May 03, 2018 at 04:15:17PM +0200, Daniel Vetter wrote:
> > Jani spotted this when reviewing my earlier patch to remove the driver
> > internal usage of this field in
> > 
> > commit 3cf91adaa594e8933af1727942ac560e5c7bc70e
> > Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Date:   Wed Apr 25 19:42:52 2018 +0200
> > 
> >     backlight: Nuke BL_CORE_DRIVER1
> > 
> > Cc: Jani Nikula <jani.nikula@intel.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> 
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

I don't see this yet in linux-next ... should I stuff it into drm-misc or
will it show up?

Thanks, Daniel
> 
> > ---
> >  include/linux/backlight.h | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> > index 7fbf0539e14a..0b5897446dca 100644
> > --- a/include/linux/backlight.h
> > +++ b/include/linux/backlight.h
> > @@ -79,7 +79,6 @@ struct backlight_properties {
> >  	/* Backlight type */
> >  	enum backlight_type type;
> >  	/* Flags used to signal drivers of state changes */
> > -	/* Upper 4 bits are reserved for driver internal use */
> >  	unsigned int state;
> >  
> >  #define BL_CORE_SUSPENDED	(1 << 0)	/* backlight is suspended */
> > -- 
> > 2.17.0
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
