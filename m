Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAD7C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603E32081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsdhbVK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603E32081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbeKBAc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:32:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39486 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbeKBAc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:32:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id u13-v6so1667365wmc.4;
        Thu, 01 Nov 2018 08:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qkip5qLR+KvGv/K81heC6OjvVKGGVTkT71nBtb3m2EQ=;
        b=bsdhbVK8tHZZL1HekUZN/e3ntRkbYnIctluvVobWGLSb7Yf+tRzK5W4Z/fN9mSe4bC
         XxcIPVpB/agtHCgqMN/2htZIx4oGzIMtH4hztwYEJOXLNPufhLLsEXWVVtefNLU8q/W+
         Is7P4dy2YCSfCptlDzPwEINPktLnWiDTJlaU0Egq8bK1QHQ11IuOG3rM+QR/JK3OwJqy
         WrBMIgX86uKryqHoXpmRhXb4DO0dkZ0befCpB2bSLPcu3N1fp2shu6ICWhnr6vxCiVNM
         EImZCfoobUNd4luSS90wy67f2xtGj7jV3l8uDmG4Xw9yVBOxKtStfUgFW3T6TkIKhfn0
         yn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qkip5qLR+KvGv/K81heC6OjvVKGGVTkT71nBtb3m2EQ=;
        b=TfjpsKMrQcAn946AmyfczdRdPkt9KpML7wU5IEgDraJv9FojP/+K3HErZfTrt9j0Go
         5fUYfeZGEWMaymiZb9ieQbliIr9dOWO9AmXukkuIWnF0FqAbIH4BOouumIF2tNxxRrOs
         GXW/PchX659EJL7UCSfWYDrsk352gyxuEBov5z8QuzW1hHZoc6Xp0XThsRQ7NlAgvCQd
         zIOGlVTYTv3M4cGUwICgwwyAq9IFJS3xI72zb1CAeFuIWca5DC3p3yJsJ2NlwnkMCzvQ
         ckDWcA2qNAi27SN8HZsaX1h9mqGcfSqtx78hfhiT6gX7HxBx2VGOJtr9LdNUlAgEBY3U
         M9Qw==
X-Gm-Message-State: AGRZ1gKMdyIp/uWLcDuo3v+CVd/EP9zlfMCH1Byjl1IV1mqRvPLBmnM3
        beqU4hNVr4FSBBFOJQvgerQE8C1IxIxYlA==
X-Google-Smtp-Source: AJdET5fS1tX/zdU9CcyK/rSpNX7qzy0VrSV3qyFOnI3lgTf5QzVfdfQrJbqCuW3KDzXqh5LZuFTp4w==
X-Received: by 2002:a1c:1c0c:: with SMTP id c12-v6mr5676716wmc.18.1541086168373;
        Thu, 01 Nov 2018 08:29:28 -0700 (PDT)
Received: from picard ([194.207.103.1])
        by smtp.gmail.com with ESMTPSA id c14-v6sm24289844wmh.44.2018.11.01.08.29.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 08:29:26 -0700 (PDT)
Date:   Thu, 1 Nov 2018 15:29:25 +0000
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
Message-ID: <20181101152925.gdmscgg7275md3km@picard>
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
Ok Hans, I tried your patch on top of the quirk, and sound is
immediately garbled (daleks again), and switching pulseuadio profiles
or inserting headphones doesn't make it correct itself, whereas before
sound would be fine, UNTIL, I did something like insert earphone etc.

-Dean
