Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89191C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C2920663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LlFnBbHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C2920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeK0BHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:07:03 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44831 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeK0BHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:07:02 -0500
Received: by mail-ed1-f67.google.com with SMTP id y56so15920149edd.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 06:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qq/PbGp799w3uYXWNREd+3JhKli+YCIiF7KMrs04i/4=;
        b=LlFnBbHrJ3bA8Wsi7gKJSePi2TaWlvcihiZJJdJx5zMtlIsUXRA59CTLLV5clkNLL0
         J3g6OgIYeHpeEiy5VKI8SknzeQraTz4P2hZrk9ajbYNSQEUmtlu4Fg/PQQO1ycQpcCDl
         nHE9r410+IP9Tb7xxzjI57sBobmz2YdTTp7CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Qq/PbGp799w3uYXWNREd+3JhKli+YCIiF7KMrs04i/4=;
        b=T/9ob/nY4rr/96o57oFVUo3VhEI1SJS9l1+LiRSmXe4pWkmgfsbWkFQwcrl/g9wGyu
         9fU/hR6HZtX5AEdvnCKruezgALT0QW9c9UlA0yr5GxOlHz7CLbggc7PDaPOqJ6E55L0F
         NcCYZtzLrdSePr4MNLyqimmK45KjX23DRgedPvLlLbaRT9RYTZ9VQDRc2/z0tZcba0T7
         VaLS/x8eaaqufkfFyqYe31o2pZRGPewmnfNSCXeKL0PIHBzgjFdRTGs9o/1TyWZFzQ6R
         F8fmOUmgtg9gTJDMkkhNDONlb1yTUoy7FDvkUR8CkVMCHsmx7RjRc13vMmQn3qBneEnp
         dO9Q==
X-Gm-Message-State: AA+aEWZGpKYOaKMVDFSIi+FYqzR4BZ6mfp0Kp7veKWS/8CX7Guucrx5M
        Go/L3nTNyt8iBq4Awo0uZ1aFOA==
X-Google-Smtp-Source: AFSGD/U/Jc/8jyRSCDI7TrwJf3w2Vo/hXk7vWhjLCq10FAlslLdKVtfIeVKdSQDJqXMaa9r+Gvua4Q==
X-Received: by 2002:a50:f489:: with SMTP id s9mr23103319edm.101.1543241565482;
        Mon, 26 Nov 2018 06:12:45 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id k13-v6sm116687ejk.50.2018.11.26.06.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 06:12:44 -0800 (PST)
Date:   Mon, 26 Nov 2018 15:12:41 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     greenfoo@gluegarage.com,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>, sean@poorly.run,
        Dave Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>, abrodkin@synopsys.com,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux+etnaviv@armlinux.org.uk,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        kieran.bingham+renesas@ideasonboard.com,
        Shawn Guo <shawnguo@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, michal.lkml@markovi.net,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        linux-doc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        virtualization@lists.linux-foundation.org,
        etnaviv@lists.freedesktop.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        cocci@systeme.lip6.fr
Subject: Re: [PATCH 0/9] drm: remove deprecated functions
Message-ID: <20181126141241.GM4266@phenom.ffwll.local>
Mail-Followup-To: Linus Walleij <linus.walleij@linaro.org>,
        greenfoo@gluegarage.com,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>, sean@poorly.run,
        Dave Airlie <airlied@linux.ie>, Jonathan Corbet <corbet@lwn.net>,
        abrodkin@synopsys.com,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Lucas Stach <l.stach@pengutronix.de>, linux+etnaviv@armlinux.org.uk,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        kieran.bingham+renesas@ideasonboard.com,
        Shawn Guo <shawnguo@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, michal.lkml@markovi.net,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        linux-doc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        virtualization@lists.linux-foundation.org,
        etnaviv@lists.freedesktop.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        cocci@systeme.lip6.fr
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
 <CACRpkdZmTSo02yQeU=qe9WyJMXEq76CNmc2kkFEHuwdo=HKPJw@mail.gmail.com>
 <20181121094233.GN4266@phenom.ffwll.local>
 <CACRpkdaXUFwSiQnMqv2WBXr2ytn7kx3CeAuamkj9ZYU1C6bpnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaXUFwSiQnMqv2WBXr2ytn7kx3CeAuamkj9ZYU1C6bpnw@mail.gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 10:17:13PM +0100, Linus Walleij wrote:
> On Wed, Nov 21, 2018 at 10:42 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Thu, Nov 15, 2018 at 11:38:35PM +0100, Linus Walleij wrote:
> > > On Thu, Nov 15, 2018 at 11:17 PM Fernando Ramos <greenfoo@gluegarage.com> wrote:
> > >
> > > > One of the things in the DRM TODO list ("Documentation/gpu/todo.rst") was to
> > > > "switch from reference/unreference to get/put". That's what this patch series is
> > > > about.
> > >
> > > The series:
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Since your reviewed it all, and there's a pile of acks for the driver
> > parts too: Want to go ahead and apply it too?
> 
> OK I did... the git was quirky, patches changes around
> under my feet and dim started to complain about problems
> with commits that weren't even mine.
> 
> It was especially scary.
> 
> But I think I managed to apply the patches and push the
> branch now.

Except when you're racing with someone else you should only see conflicts
with stuff you've just pushed. Or if someone forgot to fix up their mess.
What was the conflict? Looking at the git-rerere log I'm not exactly sure
what happened ... Looks like only one of the patches didn't apply cleanly
anymore because it was somewhat outdated. Otherwise nothing from you.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
