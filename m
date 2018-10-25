Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C60C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926782075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjSpf7nt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926782075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbeJZFjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:39:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39761 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeJZFjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:39:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id r10-v6so9834740wrv.6;
        Thu, 25 Oct 2018 14:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2AwaJg3ngONpNy9jSyubQktbJqFicxDGbzuKdJ7aSb8=;
        b=kjSpf7ntmtb5CMVa+oZMeG3b9gcmyPvcTCU+vfLqMn9uDTY2uw6oi3z7hLb+hdIlJO
         FbuIuYwV7d+JDdnM/2QeSAhi+QgkgRItIPDGurCV5lR/udJVcyzu5lDHlr4cf/hAIhcx
         MCinldf8ZlsRQUD7gXP3USPhFEfzbUQfLlUU/qDO+BG4hSlvORCi/SacrY2ASIj6Y/Da
         1xwLMlywbWnoESxeNIWHQwR2K2atVNpf6Ohf8jXvnQ9Y1VEtgo4dcczpClptJpETwOCR
         hp/VKRb75sd5H9p4h4nIIgY8weUPr2KN8ow3DJfGhrkS0eJIfKY9TvWqwszQdsnG5y0B
         aYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2AwaJg3ngONpNy9jSyubQktbJqFicxDGbzuKdJ7aSb8=;
        b=TusTBaJ6Cr3vGVX5GZBLb85HZktO20FWFDLD28Ag+3lHZ+La6NJxeclz99A/mthLbg
         Rg3kZNpsvQ/YgP+ns3CPEwstzdkN4fErgoVV3fRk09vjORnlI2Cp045yDoBCx99sobX9
         b1hPREm2sfxXxmnB7UA11EqrtWlSAVVo7AGEkkf41OrNzg4RuMbuC1OHtUJbhAKRqxbT
         FsCfPasA+ehUT1YuWFDzWtYzUsNlCA7PCG3lK+RhPhqJC+/blSRcq2S4vXxGLBWhdcwH
         zDN0Z+ti5cL73aDx/8zGGIrM9orrPA0BAPUBWD2vDep+81IFqeyK8/3iAf4+JUGay49G
         l7Qg==
X-Gm-Message-State: AGRZ1gK07AxoqEQ4JKCivf4YuhUB2Z1Al+UrQ/t6KdcvtmaVb8Ld/DXU
        VsNW6Bv2aXMQ18r7dHxuk90=
X-Google-Smtp-Source: AJdET5eIPlIvqvjot08hMgM+G7GvL1aeLH6Cb+ofIgS5zrYUOF5LjECLwQ/BlGBCGdqg1J4FcxgISw==
X-Received: by 2002:a5d:618a:: with SMTP id j10-v6mr3612371wru.300.1540501498926;
        Thu, 25 Oct 2018 14:04:58 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id l70-v6sm4453493wma.0.2018.10.25.14.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 14:04:58 -0700 (PDT)
Date:   Thu, 25 Oct 2018 14:04:56 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: generic: Avoid several implicit enum conversions
Message-ID: <20181025210456.GA14792@flashbox>
References: <20180925061855.19557-1-natechancellor@gmail.com>
 <CACRpkdadODxsuae7uhwcfBBMQ-eZ8bvnV71fhDCuudbJEbhhYA@mail.gmail.com>
 <20180925161459.GA15840@flashbox>
 <CAKwvOdkh0rqWcw4r7Y=Ki_MNJPoJNnvm3uGp4Q726PaESxZAnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkh0rqWcw4r7Y=Ki_MNJPoJNnvm3uGp4Q726PaESxZAnQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 09:23:09AM -0700, Nick Desaulniers wrote:
> On Tue, Sep 25, 2018 at 9:15 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Tue, Sep 25, 2018 at 12:58:16PM +0200, Linus Walleij wrote:
> > > On Tue, Sep 25, 2018 at 8:19 AM Nathan Chancellor
> > > <natechancellor@gmail.com> wrote:
> > >
> > > > Clang warns when one enumerated type is implicitly converted to another,
> > > > which happens several times in the pinctrl drivers for a few reasons:
> > > >
> > > > * The PCONFDUMP macro, which sets the param member in pin_config_item.
> > > > * The pinconf_generic_params structure, which is used by drivers to
> > > >   configure their bindings, which has a param member like pin_config_item.
> > > > * The pinconf_to_config_packed, which takes either the generic enum
> > > >   pin_config_param or a specialized one.
> > > >
> > > > Drivers are allowed to extend this enumerated type because of the gap
> > > > betweem PIN_CONFIG_END and PIN_CONFIG_MAX. Make it clear to Clang that
> > > > this is allowed by changing param's type in all of these instances to
> > > > int so no conversion needs to happen.
> > > >
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/138
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > >
> > > I'm not superhappy about this because that enum is great for readability,
> > > even if the static syntax checker is unhappy.
> > >
> > > If we can't have an enum here I would argue that we can just as well
> > > remove the enum altogether and just use #define for the config
> > > parameters, would you agree?
> > >
> > > Yours,
> > > Linus Walleij
> >
> > Hi Linus,
> >
> > I see no reason to get rid of the enums. All this patch should do is
> > silence Clang's warnings because there is no other way to tell it that
> > this construct is okay except for changing the parameter/member type to
> > int (so no conversion needs to happen) or an explicit cast, which will
> > result in more noise in my opinion since this warning happens at least
> > 10-15 times in the pinctrl drivers. There's no fundamental change to
> > how the enums are used.
> >
> > See these other commits for similar fixes:
> >
> > 3eb95feac113 ("mm/zsmalloc.c: change stat type parameter to int")
> > 04fecbf51b3c ("mm: memcontrol: use int for event/state parameter in several functions")
> >
> > Cheers!
> > Nathan
> 
> That or all of the call sites should have explicit casts to the base enum.
> 

I don't know why I never replied to this...

In my opinion, there are enough of these warnings to warrant changing
the type of param globally (arm64 allyesconfig):

drivers/pinctrl/bcm/pinctrl-bcm2835.c:707:40: warning: implicit conversion from enumeration type 'enum bcm2835_pinconf_param' to different enumeration type 'enum pin_config_param' [-Wenum-conversion]
drivers/pinctrl/sprd/pinctrl-sprd.c:845:19: warning: implicit conversion from enumeration type 'enum sprd_pinconf_params' to different enumeration type 'enum pin_config_param' [-Wenum-conversion]
drivers/pinctrl/sprd/pinctrl-sprd.c:846:22: warning: implicit conversion from enumeration type 'enum sprd_pinconf_params' to different enumeration type 'enum pin_config_param' [-Wenum-conversion]
drivers/pinctrl/sprd/pinctrl-sprd.c:851:12: warning: implicit conversion from enumeration type 'enum sprd_pinconf_params' to different enumeration type 'enum pin_config_param' [-Wenum-conversion]
drivers/pinctrl/sprd/pinctrl-sprd.c:852:12: warning: implicit conversion from enumeration type 'enum sprd_pinconf_params' to different enumeration type 'enum pin_config_param' [-Wenum-conversion]
drivers/pinctrl/pinctrl-max77620.c:56:12: warning: implicit conversion from enumeration type 'enum max77620_pinconf_param' to different enumeration type 'enum pin_config_param' [-Wenum-conversion]
drivers/pinctrl/pinctrl-max77620.c:59:12: warning: implicit conversion from enumeration type 'enum max77620_pinconf_param' to different enumeration type 'enum pin_config_param' [-Wenum-conversion]
drivers/pinctrl/pinctrl-max77620.c:62:12: warning: implicit conversion from enumeration type 'enum max77620_pinconf_param' to different enumeration type 'enum pin_config_param' [-Wenum-conversion]
drivers/pinctrl/pinctrl-max77620.c:65:12: warning: implicit conversion from enumeration type 'enum max77620_pinconf_param' to different enumeration type 'enum pin_config_param' [-Wenum-conversion]
drivers/pinctrl/pinctrl-max77620.c:68:12: warning: implicit conversion from enumeration type 'enum max77620_pinconf_param' to different enumeration type 'enum pin_config_param' [-Wenum-conversion]
drivers/pinctrl/pinctrl-max77620.c:71:12: warning: implicit conversion from enumeration type 'enum max77620_pinconf_param' to different enumeration type 'enum pin_config_param' [-Wenum-conversion]
drivers/pinctrl/pinctrl-lpc18xx.c:643:29: warning: implicit conversion from enumeration type 'enum lpc18xx_pin_config_param' to different enumeration type 'enum pin_config_param' [-Wenum-conversion]
drivers/pinctrl/pinctrl-lpc18xx.c:648:12: warning: implicit conversion from enumeration type 'enum lpc18xx_pin_config_param' to different enumeration type 'enum pin_config_param' [-Wenum-conversion]
drivers/rtc/rtc-omap.c:574:21: warning: implicit conversion from enumeration type 'enum rtc_pin_config_param' to different enumeration type 'enum pin_config_param' [-Wenum-conversion]
drivers/rtc/rtc-omap.c:579:12: warning: implicit conversion from enumeration type 'enum rtc_pin_config_param' to different enumeration type 'enum pin_config_param' [-Wenum-conversion]

The construct of extending pin_config_param with another enumerated type
is something that could be added in new drivers so there would be upkeep
of adding explicit casts if that happens, at least until something like
0day can add support for Clang so driver authors get alerted of these
warnings. Even that doesn't sound like a particularly welcoming model
to me.

Linus, did you have any other objections to this patch given my
reasoning in these past couple of emails or would you like me to try
adding explicit casts to all of these call sites? For example, changing
pinctrl-sprd.c would look something like the diff below (I personally
think this looks kind of ugly but I'm willing to do whatever the
maintainer is comfortable with in order to fix these warnings).

Let me know what you think,
Nathan

======================================================================================

diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.c b/drivers/pinctrl/sprd/pinctrl-sprd.c
index 4537b5453996..9c82ba4dceff 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd.c
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.c
@@ -842,14 +842,14 @@ static const struct pinconf_ops sprd_pinconf_ops = {
 };
 
 static const struct pinconf_generic_params sprd_dt_params[] = {
-       {"sprd,control", SPRD_PIN_CONFIG_CONTROL, 0},
-       {"sprd,sleep-mode", SPRD_PIN_CONFIG_SLEEP_MODE, 0},
+       {"sprd,control", (enum pin_config_param)SPRD_PIN_CONFIG_CONTROL, 0},
+       {"sprd,sleep-mode", (enum pin_config_param)SPRD_PIN_CONFIG_SLEEP_MODE, 0},
 };
 
 #ifdef CONFIG_DEBUG_FS
 static const struct pin_config_item sprd_conf_items[] = {
-       PCONFDUMP(SPRD_PIN_CONFIG_CONTROL, "global control", NULL, true),
-       PCONFDUMP(SPRD_PIN_CONFIG_SLEEP_MODE, "sleep mode", NULL, true),
+       PCONFDUMP((enum pin_config_param)SPRD_PIN_CONFIG_CONTROL, "global control", NULL, true),
+       PCONFDUMP((enum pin_config_param)SPRD_PIN_CONFIG_SLEEP_MODE, "sleep mode", NULL, true),
 };
 #endif
 
> -- 
> Thanks,
> ~Nick Desaulniers
