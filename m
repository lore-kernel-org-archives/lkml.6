Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BE5B7C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 05:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5AA2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 05:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q0kur97M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5AA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754490AbeFMFqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 01:46:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40105 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754450AbeFMFqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 01:46:03 -0400
Received: by mail-wm0-f65.google.com with SMTP id n5-v6so2787234wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 22:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GvlI1WX9QswuujW/klK2YGFota0JOWMQIOWaiMKExhw=;
        b=Q0kur97MxozXWrvd+q/hB90Aw5lSSFA4KdQ9BVc1SG6Qw1Sx6yf1eUGnkhvKfbiasp
         4DJcrtDODVQOU1beRrKPJuuBfDH7PbqNsxcnKkNdfMNYCNJi+W4xas0ETIYlyItP25IO
         3hjdFyU/b/UG1uiNpWDz2C3IW33yXa92qaM24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GvlI1WX9QswuujW/klK2YGFota0JOWMQIOWaiMKExhw=;
        b=ohquneMVKR4l0WaTJI87dt8oBNkc8UAIBxuc0Sqyz7g4cxoifZ+CL9B65hHlMXvN3y
         wuK0ULYsaOHStU4GJibevhMC7szhiG8eRx8eJAAureT1nkbawesPUsjYIfmw2E22NrPb
         tA4iIU6UhDOg72njTSxXY5kQ0ZImYHI/NDWwufWTyRxBj1dzkK+escFgO9PqtHmxOc+q
         ThuUizA164Dp7GpQBWMVME4cRo+joKj3tG2uS9UwAKS4snIYTtuh3tqOeJJlHBRJgzvb
         ozlawPpeJEQOgzY9IirwYYJfPS/QTpceHZDiVqnAcGIqcpnEPIrrfRlF15+XLR4lQnMY
         BEBQ==
X-Gm-Message-State: APt69E1tGlhNSjlK9vzqKZ8ohyFmhCYet4zLAX822wiJZEIyq2Vup0jC
        /XspJ1bJJshsnZrTWmqdtqfJtQ==
X-Google-Smtp-Source: ADUXVKI8O1JLtmQBv9b/QcpmY+sfT8npN2mbj5BTP8dco+KqBus7EMECAuVrY3ZXAryg8kvm008XKw==
X-Received: by 2002:a1c:dcd:: with SMTP id 196-v6mr2487471wmn.131.1528868762153;
        Tue, 12 Jun 2018 22:46:02 -0700 (PDT)
Received: from dell ([95.149.160.78])
        by smtp.gmail.com with ESMTPSA id t17-v6sm2205854wrr.82.2018.06.12.22.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 22:46:01 -0700 (PDT)
Date:   Wed, 13 Jun 2018 06:45:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Benson Leung <bleung@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: cros_ec: remove unused __remove function
Message-ID: <20180613054559.GG5278@dell>
References: <20180608144834.3003465-1-arnd@arndb.de>
 <20180608181956.GA110395@decatoncale.mtv.corp.google.com>
 <20180611060819.GD5278@dell>
 <CAMHSBOU-f4oxR9kBkgYXOunRSUKx+cP3mJzmVKHnYJXfAzgHKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMHSBOU-f4oxR9kBkgYXOunRSUKx+cP3mJzmVKHnYJXfAzgHKQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2018, Gwendal Grignou wrote:

> On Sun, Jun 10, 2018 at 11:08 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Fri, 08 Jun 2018, Benson Leung wrote:
> >
> > >
> > > On Fri, Jun 08, 2018 at 04:48:06PM +0200, Arnd Bergmann wrote:
> > > > This function is no longer called, so we get a harmless
> > > > warning until it is removed as well:
> > > >
> > > > drivers/mfd/cros_ec_dev.c:265:13: error: '__remove' defined but not used [-Werror=unused-function]
> > > >
> > > > Fixes: 3aa2177e4787 ("mfd: cros_ec: Use devm_kzalloc for private data")
> > >
> > > Gwendal, in PATCH v2 of https://patchwork.kernel.org/patch/10439449/
> > > you mentioned that you readded the __remove to avoid a warning when built
> > > as a module. Can you explain what's going on?
> >
> > Yes please, and quickly.  I'm going to sent the patch-set today.  If I
> > don't hear from you promptly, I'll probably pull the patch!
> I readded it because when cros_ec_dev is loaded as module, I get a
> warning on dmesg when unloading:
> 
> """Device 'cros_pd' [or 'cros_ec'] does not have a release() function,
> it is broken and must be fixed."""
> 
> The warning comes from device_release(). Given I get a warning when I
> remove the release function or when I leave it empty. Let's pull the
> patch.

I already did.  It's in Mainline. :)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
