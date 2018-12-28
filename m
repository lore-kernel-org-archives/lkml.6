Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF24C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF43820873
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BpnVVQnd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbeL1MIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:08:54 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:36479 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbeL1MIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:08:53 -0500
Received: by mail-ed1-f52.google.com with SMTP id f23so17406355edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 04:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=M8S1HVCdMP1m/zFz/bhrdrAltTFQQ8fOlInvLRCFOqk=;
        b=BpnVVQndCg3unIlBe0HVcHAhQToY2CKMtY1ie6MTbvkGSo2OeVNzfXMVn5dOzdBYgq
         6XfVb3MgZ/0QOrWKhyCzKlrA9YZLZ++66rEA6IEzuT/HegJgOdOIs5vkgoz4iOiKGN7m
         Fq0BPvGvSgHplabR8upkibJZgjrGyShX+HI/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=M8S1HVCdMP1m/zFz/bhrdrAltTFQQ8fOlInvLRCFOqk=;
        b=ZgOTlUqb2Ge0p2gDYTl5lCb+pT6M7fQ++QT1FfV4/FHtR51dr8XUZ28Y7wiwQtGTb7
         1CCBN9hxWaofXRxz82DjBAEmH5dsYI7J+k7TDXkbzCtjLxg0fmJLttXpozMZwq8nrYrn
         XEF9GIwP2F5oNNdeExngixtvpYlF2kqHg8bq0uUO/2btyzmwIdbCaUsVklC0AOXJojIU
         mN3jp4GybQmojqzlgwCLIw4UarVJqwoa5hetYIDXe7H6TmSuZjva+JkwHhSqM77ASX+m
         F+Hrue5xzKHFxzQSovbk/ZyHx9frhJTISu4E8H3absFQmOPgMX7jWphD8XO/jHRLQ88u
         uMCg==
X-Gm-Message-State: AA+aEWZM7r26PRK2v11ZWISG6X03vJXa1v+IwwAMSjGc0IlHou/JEDNd
        ffxWXLurtqInJFzrKTSmqH8uXgwpgrc27w==
X-Google-Smtp-Source: AFSGD/WyUPP5ukWPm+vpTZ1CblKWSoRbI8hnTvBwFoKK6usxmhJrP8WQNRdDeMiDJl6SX3dG+UQxww==
X-Received: by 2002:a17:906:f2c6:: with SMTP id gz6-v6mr18930795ejb.211.1545998931600;
        Fri, 28 Dec 2018 04:08:51 -0800 (PST)
Received: from dvetter-linux.ger.corp.intel.com ([194.230.159.220])
        by smtp.gmail.com with ESMTPSA id dc5-v6sm6735383ejb.53.2018.12.28.04.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 04:08:50 -0800 (PST)
Date:   Fri, 28 Dec 2018 13:08:48 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Eric Anholt <eric@anholt.net>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>
Subject: Re: [PATCH] drm/vc4: Allow fb modifiers early enough to fill
 IN_FORMATS property
Message-ID: <20181228120848.GS9058@dvetter-linux.ger.corp.intel.com>
Mail-Followup-To: Eric Anholt <eric@anholt.net>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>
References: <20181224122551.9912-1-paul.kocialkowski@bootlin.com>
 <878t0amtjf.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878t0amtjf.fsf@anholt.net>
X-Operating-System: Linux dvetter-linux.ger.corp.intel.com
 4.19.10-200.fc28.x86_64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 03:36:20PM -0800, Eric Anholt wrote:
> Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
> 
> > The KMS mode_config elements are currently configured in vc4_kms_load,
> > that is called after all components are binded (component_bind_all).
> > However, the CRTC component (for the Pixel Valve) needs to access the
> > allow_fb_modifiers element at bind time, when initializing its planes
> > through drm_universal_plane_init.
> >
> > This helpers checks allow_fb_modifiers to decide whether to fill the
> > IN_FORMATS property. Because allow_fb_modifiers is still set to false
> > at this point, the property is never filled and userspace cannot
> > retrieve the combination of supported formats and modifiers.
> >
> > Fix this by setting allow_fb_modifiers right after calling
> > drm_mode_config_init (which initializes the structure), before binding
> > the components of the driver.
> 
> This makes me wonder if the flag could be removed and replaced with "did
> non-NULL modifiers get supplied to plane init?"  I think I've tripped
> over this flag in other KMS hacking, too.

Sounds like a good idea to me. Just setting it in plane_init should work I
think ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
