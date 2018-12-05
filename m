Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BD2C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B89F20878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e+4YGpI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B89F20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbeLELav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:30:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52300 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeLELau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:30:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id r11-v6so12812213wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 03:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BuCkRfwygrQH3LnOQtzA+p3LPNzbvUkkHjB/zAUVP3Q=;
        b=e+4YGpI8snHy1WAk6jiots/pgJP2doZjKceFY2T/OfEp850j27PwK6tU7QMSeuFlQW
         nOWaR5Op/3Yhdx+Kp6H/Ba+eWUUyKcGnCPhYlD+MlVwO0jIqbU/SkH2jXe3tLAO31+fU
         OlucoWOC6ImAbx1CubmPfRFBQWPxBoocYW5GE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BuCkRfwygrQH3LnOQtzA+p3LPNzbvUkkHjB/zAUVP3Q=;
        b=nB4yXB0Eug66yq9nIIJSdQyWJR3h8x3DF9Az2tD6nLEaDnzGaralkhmKEXlmp+n6H5
         I8xR3cKhZ0uhjSE9E+SZfQDpx/VYF4ZubYij979gbyxd1wY9RGZlgXOkZQv+nRgnNc+z
         5LLucWjGmRyrLnRMUIQQCgOY0GorgRg77aIy21cGdlj8E/zvstK/whuXDyYhJSwyX7yK
         5QED48e6+7S6E/nIunSG5MiJcaRdrax0SDUClkdzOHfM990BAWvu926lx8ZwYYVU5WYz
         SFCPDdmAi4mM/LJpSpqKxg4jvknSpaDOvtPiqxRXDRI7FB0aDr3KjDfxciCvo5C5BObd
         NCxg==
X-Gm-Message-State: AA+aEWYFLrwp8GTZu06sKuqGC4uOwzR9Qp60kNUAUc7DVLcwFbUIemDA
        rFiF9aGlOqIt05iQQQCV4Wl5TA==
X-Google-Smtp-Source: AFSGD/XYQPosiNV4EeUjLLqGqw+CDkplr/pjqXD2TYEVS2JWzjWk9CjTcmZMBgOzojPH9R1FL7tE3Q==
X-Received: by 2002:a1c:2981:: with SMTP id p123mr15450113wmp.19.1544009448366;
        Wed, 05 Dec 2018 03:30:48 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id l202sm12390280wma.33.2018.12.05.03.30.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 03:30:47 -0800 (PST)
Date:   Wed, 5 Dec 2018 11:30:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Cheng-yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>,
        tzungbi@chromium.org, rohitkr@codeaurora.org
Subject: Re: [PATCH 1/3] mfd: cros_ec: Add commands to control codec
Message-ID: <20181205113045.GD26661@dell>
References: <20181127120041.90759-1-cychiang@chromium.org>
 <20181128093411.GC4272@dell>
 <20181203111919.GL26661@dell>
 <CAFv8NwLEQ7EUSTRfAf42w2BY0aEPi_pjcMkPzzCNb=17pfzQXw@mail.gmail.com>
 <CAFv8NwLZc7YmCbFi-4nCOG5GUwrRbc+JdXLBKv2JA8d6eC3SDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFv8NwLZc7YmCbFi-4nCOG5GUwrRbc+JdXLBKv2JA8d6eC3SDg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Dec 2018, Cheng-yi Chiang wrote:

> Hi Lee,
> 
> I tried to apply this patch based on
> for-mfd-next branch of mfd tree (
> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git )
> Then, I tried to compile all modules by
> 
>  ARCH=x86_64 make allyesconfig
>  ARCH=x86_64 make -j64
> 
> There was no error.
> Could you please let me know what was the error when you failed to
> apply this patch ?

Doesn't work for me.

lee@host:~/projects/kernel [for-mfd-next]$ formfdnext
Applying: mfd: cros_ec: Add commands to control codec
error: sha1 information is lacking or useless (include/linux/mfd/cros_ec_commands.h).
error: could not build fake ancestor
Patch failed at 0001 mfd: cros_ec: Add commands to control codec
Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

> On Tue, Dec 4, 2018 at 9:46 AM Cheng-yi Chiang <cychiang@chromium.org> wrote:
> >
> > On Mon, Dec 3, 2018 at 7:19 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Wed, 28 Nov 2018, Lee Jones wrote:
> > >
> > > > On Tue, 27 Nov 2018, Cheng-Yi Chiang wrote:
> > > >
> > > > > Add EC host commands to control codec on EC.
> > > > >
> > > > > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > > > > ---
> > > > >  include/linux/mfd/cros_ec_commands.h | 94 ++++++++++++++++++++++++++++
> > > > >  1 file changed, 94 insertions(+)
> > > >
> > > > Applied, thanks.
> > >
> > > Turns out that this does not actually apply.
> > >
> > > What is it based on?
> >
> > Hi Lee,
> > I am sorry about that!
> > The patch series was based on Mark Brown's tree (
> > https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git )
> > for-next branch.
> > I will rebase it on upstream master branch in v2 when I address other
> > comments in codec driver.
> > Thanks!
> >
> > >

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
