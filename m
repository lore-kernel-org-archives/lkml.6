Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FC8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3F620878
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jPNiiHQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3F620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbeGJHxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 03:53:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45946 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeGJHxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 03:53:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id i20-v6so2847134eds.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 00:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hTAwo5f13X0AVHgDkikonMQq8IDqiiwRkLwuPngPA3A=;
        b=jPNiiHQSRFx5zYvsd+wYm/YfTWK8pbyy5OcbyEkpLEIDbQ6pH2c524/0FNGka1Bx21
         G7mRVo6Ty0yh5EIbsLWOmSL3hnj2xOTPartNuQOc+F25SsSp/cxGZ7rkfFNspalqhq4H
         bSjt020ESofA+FWCaNRR5e+KUj0zPP84LETgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=hTAwo5f13X0AVHgDkikonMQq8IDqiiwRkLwuPngPA3A=;
        b=cpFxf/Z1sPjucXqrRG+9OmmakIcniGOblFkLRBRrGa5xkLtpUtmUdF+5GhU8GttzNv
         zSrO5q12Czxhi76OuRnZdLBbFNxADWdVE1/e99m7M27caCf/U9sdEdhKk6+Ls2g8ANyH
         8JHMhX6nzwPfF8xRzPjjAP8c2dIN3/0ZlX1oOl/7rgjFOfgNXKyeFGOvTB6lHhcEbkgT
         J0pbqthRvREpBBySs6ATL0migH9mrL646a5OErIN9eM8AKtZ8nvV/LnIuv+MLZEA9jwp
         0tF5P4491332r69VubxMqXw3PiYpT8QO2E88oV9FukKQfp1/C8i2ZlfAXN6RbqQOzuki
         IPwQ==
X-Gm-Message-State: APt69E20eP9BHZGVDSKNJoL8cmV2k5lVkXJscHlBL79NO13TkHg5X7wL
        hN3BSkrjMEBl71Hs6vjFRSAJSw==
X-Google-Smtp-Source: AAOMgpeyC2U6ccyTqD2r4c1iLdyF0IUWoKqs4fvAQVQAGKLN5a4Y6rpiveJaN0JVr4aZK+KrDPVetg==
X-Received: by 2002:a50:9dcb:: with SMTP id l11-v6mr9503893edk.234.1531209211454;
        Tue, 10 Jul 2018 00:53:31 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id r5-v6sm7710388edp.60.2018.07.10.00.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 00:53:30 -0700 (PDT)
Date:   Tue, 10 Jul 2018 09:53:28 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        NeilBrown <neilb@suse.com>, Wei Wang <wvw@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Andrei Vagin <avagin@openvz.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yisheng Xie <ysxie@foxmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] kernel.h: Add for_each_if()
Message-ID: <20180710075328.GG3008@phenom.ffwll.local>
Mail-Followup-To: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        NeilBrown <neilb@suse.com>, Wei Wang <wvw@google.com>,
        Stefan Agner <stefan@agner.ch>, Andrei Vagin <avagin@openvz.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yisheng Xie <ysxie@foxmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709162509.29343-1-daniel.vetter@ffwll.ch>
 <20180709163001.8fb8148223a57bc46a13fbda@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709163001.8fb8148223a57bc46a13fbda@linux-foundation.org>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 04:30:01PM -0700, Andrew Morton wrote:
> On Mon,  9 Jul 2018 18:25:09 +0200 Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> 
> > To avoid compilers complainig about ambigious else blocks when putting
> > an if condition into a for_each macro one needs to invert the
> > condition and add a dummy else. We have a nice little convenience
> > macro for that in drm headers, let's move it out. Subsequent patches
> > will roll it out to other places.
> > 
> > The issue the compilers complain about are nested if with an else
> > block and no {} to disambiguate which if the else belongs to. The C
> > standard is clear, but in practice people forget:
> > 
> > if (foo)
> > 	if (bar)
> > 		/* something */
> > 	else
> > 		/* something else
> 
> um, yeah, don't do that.  Kernel coding style is very much to do
> 
> 	if (foo) {
> 		if (bar)
> 			/* something */
> 		else
> 			/* something else
> 	}
> 
> And if not doing that generates a warning then, well, do that.
> 
> > The same can happen in a for_each macro when it also contains an if
> > condition at the end, except the compiler message is now really
> > confusing since there's only 1 if:
> > 
> > for_each_something()
> > 	if (bar)
> > 		/* something */
> > 	else
> > 		/* something else
> > 
> > The for_each_if() macro, by inverting the condition and adding an
> > else, avoids the compiler warning.
> 
> Ditto.
> 
> > Motivated by a discussion with Andy and Yisheng, who want to add
> > another for_each_macro which would benefit from for_each_if() instead
> > of hand-rolling it.
> 
> Ditto.
> 
> > v2: Explain a bit better what this is good for, after the discussion
> > with Peter Z.
> 
> Presumably the above was discussed in whatever-thread-that-was.

So there's a bunch of open coded versions of this already in kernel
headers (at least the ones I've found). Not counting the big pile of
existing users in drm. They are all wrong and should be reverted to a
plain if? That why there's a bunch more patches in this series.

And yes I made it clear in the discussion that if you sprinkle enough {}
there's no warning, should have probably captured this here.

Aka a formal Nack-pls-keep-your-stuff-in-drm: would be appreciated so I
can stop bothering with this.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
