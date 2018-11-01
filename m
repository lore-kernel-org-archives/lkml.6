Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADFCC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADDE2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLaxYRBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADDE2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbeKBAnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:43:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51675 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbeKBAnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:43:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id w7-v6so1759655wmc.1;
        Thu, 01 Nov 2018 08:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=994nws7XqAPQMnBp8iw4F+ibLwdYGKQMyKbbMdgAhZY=;
        b=eLaxYRBOk5sH26c3P8K1mZ/RpggIwtaZWY4u54UlLS3HrZuk/slW6yyaVwqVcU/WWp
         xomW17Sel2jFusxGQbX72RCEde8sfFEWYqkRxSANNkL7Jd9nRdOlPWuiNPwSZieqfliZ
         NmZ+DI1HbdDGrMp3EcmRduFcYzsCykOQuhGrvqIZKf2eZxBqs52z0d+8DeM9zCaO6fL7
         qUWAjFwGf/ur1zbrbsJ+g4lMxc/CeSVQPyYRhb2WGfG4sVbh+594BARbdRbwEJfxCgaR
         syY/TcntdHtLeeUATYzn0abDy0NYnXUlisMwtKtGP/4btfl3cjFOVy5v1byOr3B2aQlc
         9PPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=994nws7XqAPQMnBp8iw4F+ibLwdYGKQMyKbbMdgAhZY=;
        b=Zpyqp8cyf7KCb0NgaPLR30bv+Rl4b8as80nVQOgChdwk5AS0CID2FPM62YGxOPaGZk
         Xqrg3i+A3decsiPqk3cIGLh+S96kjN28yV6f8ioQsqxX45bCXnIrCDHaMwBCefe1OhVT
         8GgunjNiJDT/8cao2PJisyCQwjWKPhkPgsMrBAFvEDISCV1wd+yhehguPhd9lfHiuZOD
         e0Hhw+0QhrnR1nudPpi5KV4QTyI3xntbjvynsFGHvwoQlgTf8zw095OKHogf6gBB/tZC
         kQp7YfayiNYaDAtrZqPcD/p1ULR/dYg6mLgIzKdJ4cdHU3Sehh0sgQebCTkiCCLZQzY2
         1R5g==
X-Gm-Message-State: AGRZ1gKwH/FxRvOuujp9VrIQy7BMOwMRiyyFi7B+NKwxgHwYf8NyXzIR
        LCWdiFLOq5spQ5PpX38fK6I=
X-Google-Smtp-Source: AJdET5ehuW01N8whU3S2uXJiBsqDqEJOL0oPJNQ5n+0g7e8hWJ51Okf7LtKE4sZA4zMWZD+KmEb8sA==
X-Received: by 2002:a1c:a90:: with SMTP id 138-v6mr5707494wmk.89.1541086787513;
        Thu, 01 Nov 2018 08:39:47 -0700 (PDT)
Received: from picard ([194.207.103.1])
        by smtp.gmail.com with ESMTPSA id o15-v6sm5979997wrw.47.2018.11.01.08.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 08:39:46 -0700 (PDT)
Date:   Thu, 1 Nov 2018 15:39:45 +0000
From:   Dean Wallace <duffydack73@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mogens Jensen <mogens-jensen@protonmail.com>
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
Message-ID: <20181101153945.tngxh2k2irtlsvdo@picard>
References: <d00df762-e4fc-06c5-701e-d5100bfd0e35@redhat.com>
 <e48696f0-aa3e-e20e-d038-9d8dda9cbfce@redhat.com>
 <20181030161534.wk5cf7nxbwhp2far@picard>
 <307c2074-d268-a87a-6040-1240a2091a4d@redhat.com>
 <20181031200709.xrmu6wsdel7dtcjq@picard>
 <da025116-580d-e442-d96f-875282306f1b@linux.intel.com>
 <20181101103705.ay36te4qr5pxtgop@picard>
 <37e44480-44d3-9355-6119-ae46bb38678a@redhat.com>
 <20181101142859.oxtuhbwtt44h2u3r@picard>
 <67a7d54b-49cc-aa4e-fe47-bb6277f02bc8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67a7d54b-49cc-aa4e-fe47-bb6277f02bc8@redhat.com>
X-Info: Keep It Simple, Stupid.
X-Operating-System: Linux, kernel 4.19.0-arch1-1-ARCH-dirty
X-Message-Flag: WARNING!! Outlook sucks
User-Agent: Every email client sucks, this one just sucks less.
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-11-18, Hans de Goede wrote:
> Hi,
> 
> On 01-11-18 15:28, Dean Wallace wrote:
> > On 01-11-18, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 01-11-18 11:37, Dean Wallace wrote:
> > > > On 31-10-18, Pierre-Louis Bossart wrote:
> > > > > 
> > > > > > Just thought it worth mentioning, this new patch that fixes sound
> > > > > > again, seems to have ressurected an old issue with PLL unlock.  I'm
> > > > > > seeing journal entries after fresh boot ......
> > > > > > 
> > > > > > ```
> > > > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > > > picard systemd[462]: Started Sound Service.
> > > > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > > > picard kernel: max98090_pll_work: 141 callbacks suppressed
> > > > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > > > ```
> > > > > > 
> > > > > > sound is ok, but sometimes plugging in headphones spams journal with
> > > > > > those PLL messages, and sound turns into "daleks", and I have to
> > > > > > remove/insert headphones few times or stop/start audio to fix it.
> > > > > > It's a very old issue, maybe you'd know more about it.
> > > > > 
> > > > > I noticed this error on my Orco device used for tests many moons ago, but I
> > > > > could never find out what led to this error case, it wasn't deterministic
> > > > > and didn't impact the audio quality. All I could do is rate_limit it... If
> > > > > we have an A vs. B situation it'd be really helpful to diagnose further.
> > > > > 
> > > > > Is there really a causality between the changes from Hans and this PLL
> > > > > unlock error? Are you 100% sure this was not present in the previous install
> > > > > you used (4.18.14 as mentioned earlier in the thread)?
> > > > > 
> > > > > Thanks
> > > > > 
> > > > > -Pierre
> > > > > 
> > > > Well, numerous boots, kernels, headphone inserting - no PLL or
> > > > 'Daleks'.  My laptop must have been haunted that day (halloween).
> > > > I'll put it to bed.
> > > 
> > > So you can no longer reproduce. Bummer. Note this might be caused by
> > > the temperature of the laptop when you were running the tests...
> > > 
> > > Anyways if you hit this again and you can reproduce it, please
> > > give adding a msleep(10) after code mucking with the clk a try.
> > > 
> > > Regards,
> > > 
> > > Hans
> > > 
> > Right then, I can make it unlock and 'daleks' by going into
> > pavucontrol and switching the Profile back and forth from Stereo
> > Output to Stereo Output+Analog Mono Input, which is actually something
> > I've done to make it correct itself as well.  I don't use the mic or
> > anything so I've had it set to Stereo Ouput only which I 'think' has
> > somehow made it more stable for me.  With all my playing around, one
> > of the things I did was clean out my .config/pulse folder which meant
> > by default the 'Profile' in pavucontrol was set to Output+Input, which
> > seems to help trigger the PLL issue when inserting headphones.
> > 
> > So what would you like me to do, as I can trigger it on demand it
> > seems.
> 
> Please give the attached patch a try (on top of my patch for the clk quirk)
> and let us know if that fixes these errors.
> 
> Regards,
> 
> Hans
> 
This is weird, now sound is ok on boot, until I plug in earphones,
like before.  Still get spammed with errors until I fool around with
pulse profile switching (it's hit and miss).

-Dean
