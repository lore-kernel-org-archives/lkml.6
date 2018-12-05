Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48620C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F149208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mR12I0Wg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F149208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbeLERmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:42:18 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37075 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeLERmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:42:15 -0500
Received: by mail-pg1-f195.google.com with SMTP id 80so9338471pge.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 09:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=H82VOLH32FQsGyx2BnmP11meBb7aRxjVMwmR5I4yftQ=;
        b=mR12I0WgDkJJk9doQzmB5CI33SvEW0wmcF1ZxUAeOImCl+7uM65cv5mpJasfv4Kw78
         5PzNV0naYFDJSQQiAUenHvkYN3vmjqhtZ1vdAqr0Xi87AwSbU0JKtcxWW+Jtr6aBluxK
         WrzJZAUa/m7NkA609kvLKDQ038DKX+sZyE53k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=H82VOLH32FQsGyx2BnmP11meBb7aRxjVMwmR5I4yftQ=;
        b=SXy2vyloUC9J2GOhtWqTrh1VLMsmnM05Kxe8039sdy8f1a7Dqlu68x82MPpfvrRMG2
         VUBDHcEIA26iYpg9u2K6LXxb8/CmM7GTnVxaOAoVUPgJGwxknkRtL9Be6TMkM/mfJG4I
         jHMNNpUQYoHGe10AuvYw3vzcPw16s4i9jVnwqtVWnC4yHZL4GylzJcOgj+lA9mFiMil8
         YOnqo3hjAb4Y+n58UlLcB+Ah0LqlOJH3gwfKHMKS+WtaZbM3fPOg4SPMX37upbK2BGN8
         yMAxtdpr3OtBg+bpFK0iTHP64tJzcHn4ILQlg+7QrxGWUFTNaw/y+BWgtER+9EC2ZvFX
         /lkg==
X-Gm-Message-State: AA+aEWYfOqhW+HnmWhCzYWpn6TOqR5G98Syg437PrqdbIm4Uf2C1q4uy
        xfsj1t1OqtrWNLnT5SrqFSA7bA==
X-Google-Smtp-Source: AFSGD/Vya30S7Xoif9HN5bgrX0P/yaC6sJypQyj6h1u0MMLshTlK1kv74VJG/+5PyCQq7ftlVWWx2Q==
X-Received: by 2002:a62:3241:: with SMTP id y62mr25246550pfy.178.1544031734383;
        Wed, 05 Dec 2018 09:42:14 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id g11sm26168194pfo.139.2018.12.05.09.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 09:42:13 -0800 (PST)
Date:   Wed, 5 Dec 2018 09:42:11 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: Allow driver to be shutdown on reboot/kexec
Message-ID: <20181205174209.GA224281@google.com>
References: <20180805124807.18169-1-marc.zyngier@arm.com>
 <20181205030127.GA200921@google.com>
 <1693737.bVF0dcvACY@diego>
 <dd1777ad-fe3e-a661-a27f-8ba418064b40@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd1777ad-fe3e-a661-a27f-8ba418064b40@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 05, 2018 at 02:28:48PM +0000, Marc Zyngier wrote:
> On 05/12/2018 14:11, Heiko Stübner wrote:
> > Am Mittwoch, 5. Dezember 2018, 04:01:34 CET schrieb Brian Norris:
> >> On Sun, Aug 05, 2018 at 01:48:07PM +0100, Marc Zyngier wrote:
> >>> Leaving the DRM driver enabled on reboot or kexec has the annoying
> >>> effect of leaving the display generating transactions whilst the
> >>> IOMMU has been shut down.
> >>>
> >>> In turn, the IOMMU driver (which shares its interrupt line with
> >>> the VOP) starts warning either on shutdown or when entering the
> >>> secondary kernel in the kexec case (nothing is expected on that
> >>> front).
> >>>
> >>> A cheap way of ensuring that things are nicely shut down is to
> >>> register a shutdown callback in the platform driver.
> >>>
> >>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >>> ---
> >>
> >> This patch made it into 4.20-rc1 as well as -stable, and it has caused
> >> regressions for me, on the Kevin and Scarlet [1] RK3399 platforms.
> >>
> >> On
> >> shutdown/reboot, I see this:
> >>
> >> [   94.742559] WARNING: CPU: 4 PID: 2035 at
> >> drivers/gpu/drm/drm_mode_config.c:477 drm_mode_config_cleanup+0x1c4/0x294
> >> ...
...
> >> Anyway, the above warnings occur on v4.20-rc, which I think is
> >> justification enough for a revert.
> > 
> > That's strange. I remember testing quite a number of shutdown/reboot
> > cycles before applying that patch. And for good measure did the same
> > again right now.
> > 
> > - Kevin, with netboot firmware, booting into Debian+console only
> > - Bob, with stock firmware, booting into Debian+KDE Plasma
> > - Scarlet, with stock firmware, booting into Debian+KDE Plasma
> > 
> > With some random number of reboot and shutdowns on each I didn't
> > see any warnings at all.
> 
> And I've been using this very patch for quite a while now.
> 
> Before suggesting a revert, I'd rather we understand what is going on,
> and why is the DRM layer crapping itself that badly for a legitimate
> operation (it is certainly better to have a shutdown than to let the VOP
> scan out crap once the IOMMU has been shut down). In short, don't shoot
> the messenger.

I honestly don't know much at all about DRM. But I do see this problem
on 4.19.y also (and probably 4.14.y), now that this patch was included
there.

I'm fine with trying to "fix forward" in mainline, but unfortunately,
it's usually quite difficult to get Greg to drop things from -stable,
especially when the regression is already pushed to a release. That's
why I'd propose a revert first, which can be sent back to -stable while
things are figured out.

I'm also willing to test any updates, if you have better suggestions.

> >> I plan to submit a revert which I hope can go to 4.20 as well as
> >> -stable. I'd hope the remove()/shutdown() paths should be fixed before
> >> this gets applied again, and that it does not get shipped to -stable
> >> kernels.
> > 
> > But judging by the fact that the warning indicates that somthing is still
> > holding onto a framebuffer and a rmmod rockchipdrm is not possible
> > at runrtime for likely the same reason, I guess we really might be creating
> > a problem with that shutdown.
> 
> That's a potential root cause.
> 
> > 
> > Can you maybe give "drm/rockchip: shutdown drm subsystem on shutdown" [2]
> > a try? When the underlying issue of rebooting surfaced we had 2 competing 
> > solutions, so we at least don't reopen the issue, that people have problems
> > rebooting?

I'll try to give that a spin.

> kexec working is certainly something I need. And I'd like to understand
> why Brian sees this and nobody else.

For one, I'm actually running Chrome OS. My tests currently don't have
the full Chrome UI working, since Chrome OS has some basic graphics API
requirements and there's no Mali GPU driver upstream (so I get relegated
to our splash screen and console manager, frecon, instead). But some
people have a software-rendered llvmpipe backend working, and they
likely would see the same problem.

Maybe common Linux distros treat "no GPU" too simplistically and don't
really exercise the DRM framework much. I dunno.

Brian
