Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB853ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B5B2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YJslvL3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B5B2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbeGRKaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:30:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39810 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbeGRKaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:30:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id h20-v6so2174553wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 02:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Uyel6n6uZNKwB9mKaSwJWpWIMG9GDlPkMBde/FhE8nM=;
        b=YJslvL3x/LCCRzWCV/vDnNLNLg7xlOL4gj9rxHnns9qBkAjDnZKRPJm1pfXe0rT+vN
         4W5Gga7OKsc7Liyafo6Jg0Rbg1AJWROed0KgsyxpiW8f4WvCPE0uJdnBadPoqcw0R2B7
         EMhrtv4/88mqGBOeBkz8SelNu8plEwdtqQqXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Uyel6n6uZNKwB9mKaSwJWpWIMG9GDlPkMBde/FhE8nM=;
        b=ua12e/B4mum+o/xnwuRwiXZUGm76sof21UfbEhHMEXKN9Vm0YKne4jVkX2LMbwduuY
         52dMGvd3r65QhYEfh0YuhrIC8XhlHIz3BNCwVu4Hw3PZBRIFu8nWX9YF0VGACkvLSGHV
         4QsEwbY1CcksFOExV9p2vYlpPs03V1LR5NZCwnCsVEfQM3jwnYN7AGdtdVqCZsT5jty+
         Qp4j503chz9aXc5UOQhsFgA9qJns8TlxNLmUkhBorI/JRdx4/efZQK0bXMdyo+FrImfT
         B+xgS3o723XuUpLFXaH2J1i/riit4JOj+7ZUCFjORCE9TtEbzE2ApGFngurWs3jvSI/F
         qiWA==
X-Gm-Message-State: AOUpUlHh5pBW7VwQlPRaRYOGrJKgwXs4Qw0dNVZfIARUTQCKv0g6J7T3
        /tvL+8j3AN0BTFagjUhnAVvEuA==
X-Google-Smtp-Source: AAOMgpc+zmV6afwn06jBy42ugCtecLnj36kTksXinsm7JGlG2BI2SI7btoaPGJRI/CukytlWlUKQkg==
X-Received: by 2002:a1c:910f:: with SMTP id t15-v6mr1213865wmd.51.1531907618924;
        Wed, 18 Jul 2018 02:53:38 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id z7-v6sm1814511wma.2.2018.07.18.02.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 02:53:37 -0700 (PDT)
Date:   Wed, 18 Jul 2018 10:53:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "patches@linaro.org" <patches@linaro.org>
Subject: Re: [PATCH] backlight: pwm_bl: Fix uninitialized variable
Message-ID: <20180718095335.GD4641@dell>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
 <20180718080913.GB4641@dell>
 <1531902119.16896.13.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531902119.16896.13.camel@toradex.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018, Marcel Ziswiler wrote:

> On Wed, 2018-07-18 at 09:09 +0100, Lee Jones wrote:
> > On Mon, 16 Jul 2018, Daniel Thompson wrote:
> > 
> > > Currently, if the DT does not define num-interpolated-steps then
> > > num_steps is undefined and the interpolation code will deploy
> > > randomly.
> > > Fix this.
> > > 
> > > Fixes: 573fe6d1c25c ("backlight: pwm_bl: Linear interpolation
> > > between
> > > brightness-levels")
> > > Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > 
> > This line is confusing.  Did you guys author this patch together?
> 
> Yes, I reported it and we came to a conclusion together.

It sounds like you need to have all of the tags (except this one). :)

 Reported-by:  for reporting the issue
 Suggested-by: for suggesting a resolution
 Acked-by:     for reviewing it
 Tested-by:    for testing it

Signed-off-by usually means you either wrote a significant amount of
the diffstat or you were part of the submission path.

> > My guess is that this line should be dropped and the RB and TB tags
> > should remain?  If it was reviewed too, perhaps an AB too?
> 
> I'm OK either way and do not need any explicit authorship to be
> expressed for me.

In this instance I suggest keeping Reported-by and Tested-by.

> > > Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > ---
> > >  drivers/video/backlight/pwm_bl.c | 17 ++++++++---------
> > >  1 file changed, 8 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/video/backlight/pwm_bl.c
> > > b/drivers/video/backlight/pwm_bl.c
> > > index 9ee4c1b735b2..e3c22b79fbcd 100644
> > > --- a/drivers/video/backlight/pwm_bl.c
> > > +++ b/drivers/video/backlight/pwm_bl.c
> > > @@ -299,15 +299,14 @@ static int pwm_backlight_parse_dt(struct
> > > device *dev,
> > >  		 * interpolation between each of the values of
> > > brightness levels
> > >  		 * and creates a new pre-computed table.
> > >  		 */
> > > -		of_property_read_u32(node, "num-interpolated-
> > > steps",
> > > -				     &num_steps);
> > > -
> > > -		/*
> > > -		 * Make sure that there is at least two entries in
> > > the
> > > -		 * brightness-levels table, otherwise we can't
> > > interpolate
> > > -		 * between two points.
> > > -		 */
> > > -		if (num_steps) {
> > > +		if ((of_property_read_u32(node, "num-interpolated-
> > > steps",
> > > +					  &num_steps) == 0) &&
> > > num_steps) {
> > 
> > This is pretty ugly, and isn't it suffering from over-bracketing?  My
> > suggestion would be to break out the invocation of
> > of_property_read_u32() from the if and test only the result.
> > 
> > 		of_property_read_u32(node, "num-interpolated-steps", 
> > &num_steps);
> 
> you mean:
> 
> 		ret = of_property_read_u32(node, "num-interpolated-
> steps", &num_steps);
> 
> > 		if (!ret && num_steps) {
> > 
> > I haven't checked the underling code, but is it even feasible for
> > of_property_read_u32() to not succeed AND for num_steps to be set?
> > 
> > If not, the check for !ret if superfluous and you can drop it.
> 
> No, then we are back to the initial issue of num_steps potentially not
> being initialised. We really want both of_property_read_u32() to
> succeed AND num_steps to actually be set.

I also think num_steps should be pre-initialised.

Then it will only be set if of_property_read_u32() succeeds.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
