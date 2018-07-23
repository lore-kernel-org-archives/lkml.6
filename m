Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94324ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FD320874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QIL4QrJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FD320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387952AbeGWIZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:25:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41346 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387869AbeGWIZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:25:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id j5-v6so16787300wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 00:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MF/n2xMLCWrhcUKLxt9ix7TBuP+xciXlmLqLMilLFFs=;
        b=QIL4QrJXIgTM0lTnCY/7vbUQXuN5wMsiPbhmuoJWLbU8uCooPTlnCAGIbBseFohp1+
         q0S4kF/W1WhtqBcnYmML5xlQ3biaycLGzdPRmvsu7JtTOcygheazF5SW5OrixAbUDE5M
         C3w35QHMB9dDcDMYlnM79W7uUbHstG1vcnHeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MF/n2xMLCWrhcUKLxt9ix7TBuP+xciXlmLqLMilLFFs=;
        b=qr7JcMyvG9jl/Bl881kSVOlUP0lSQBjTMvNr7JksSwpNvXLQzAD4lzUiJ0LDnJM0u3
         X6vf6QzsX9DqV9crLZ2X/6SEubbbS0E3K4Zv0NO2uc92/V3FNTYI+rZ6bnKDp3Of/N6S
         IeooWVxLzqtJCSP7Jfs3uBfCUztTfr4tKujViW/4cpUj111F8MwlmGa++f4AV04YMlB1
         w2elCdeMl1wO0jotRljOh3pPwpNsEdP8y4I/X5T9lZMD6puxxKNkyQPy6uUrXXDeJWOt
         VB1BhatGW+03Bp3hCzclrSqLZuvZH5eLXdztzqAgo06ejRwsxyRLKnIWUDClNFmXgScy
         vq4w==
X-Gm-Message-State: AOUpUlFPCwdQkiBkKcMu8GA4ow3oNw2wT838AL6HspF+PD6C3UPdPXy/
        yB3QM6ffBwLmd5d5EXWiOLl1rGlJrXo=
X-Google-Smtp-Source: AAOMgpcQS0nDquadXReCTLijOIildjBEl14t/qL+10OaKeeRlGXayRZVXAxX7eWAC7mO6BtpxY/mOw==
X-Received: by 2002:adf:bb08:: with SMTP id r8-v6mr7272879wrg.244.1532330736660;
        Mon, 23 Jul 2018 00:25:36 -0700 (PDT)
Received: from dell ([2a02:c7d:1faf:e900:9403:d00:d6f3:4419])
        by smtp.gmail.com with ESMTPSA id y11-v6sm6393525wrr.84.2018.07.23.00.25.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 00:25:35 -0700 (PDT)
Date:   Mon, 23 Jul 2018 08:25:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "patches@linaro.org" <patches@linaro.org>
Subject: Re: [PATCH] backlight: pwm_bl: Fix uninitialized variable
Message-ID: <20180723072534.GE4213@dell>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
 <20180718080913.GB4641@dell>
 <1531902119.16896.13.camel@toradex.com>
 <20180718095335.GD4641@dell>
 <20180718101227.shqf54wpt4kdrsj2@holly.lan>
 <1531918626.16896.22.camel@toradex.com>
 <20180718130853.GE4641@dell>
 <20180718134103.bgwpgk7l6joxtjoa@holly.lan>
 <20180718155544.GF4641@dell>
 <20180718163405.mnebf57apzvm276w@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180718163405.mnebf57apzvm276w@holly.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018, Daniel Thompson wrote:

> On Wed, Jul 18, 2018 at 04:55:44PM +0100, Lee Jones wrote:
> > On Wed, 18 Jul 2018, Daniel Thompson wrote:
> > 
> > > On Wed, Jul 18, 2018 at 02:08:53PM +0100, Lee Jones wrote:
> > > > > > > > No, then we are back to the initial issue of num_steps
> > > > > > > > potentially not
> > > > > > > > being initialised. We really want both of_property_read_u32() to
> > > > > > > > succeed AND num_steps to actually be set.
> > > > > > > 
> > > > > > > I also think num_steps should be pre-initialised.
> > > > > 
> > > > > Yes, I guess it definitely does not hurt.
> > > > > 
> > > > > > > Then it will only be set if of_property_read_u32() succeeds.
> > > > > 
> > > > > Yes, but we still need to check for both, the function not failing and
> > > > > num_steps to actually be non zero.
> > > > 
> > > > Why?  You don't do anything differently if it fails.
> > > 
> > > Only if you initialize num_steps...
> > > 
> > > We should either initialize to zero and not worry about the return
> > > code[1] or we check the return code and not worry about
> > > initialization[2]. I don't think both are worthwhile.
> > > 
> > > Whilst initialization can fix this specific instance we generally avoid
> > > overusing it since it messes up static analysis and, in this instance,
> > > distance from declaration to use is >25 lines, hence current patchset.
> > > 
> > > 
> > > Daniel.
> > > 
> > > 
> > > [1] https://lkml.org/lkml/2018/7/16/399
> > > [2] https://lkml.org/lkml/2018/7/16/1042
> > > 
> > > Or...
> > > 
> > > We check the return code and leave number
> > > 
> > > num_steps is uninitialized and stack allocated so it only has a valid
> > > value if of_property_read_u32() succeeds.
> > > 
> > > We can (and I originally did) fix the bug by initializing num_steps to 0
> > > but its quite some distance between declaration and use so I accepted
> > > Marcel's counter proposal to check the return code instead.
> > 
> > Only checking the return value of of_property_read_u32() is also
> > suitable.
> 
> I did think about that case... I concluded that it isn't wrong for a
> DT to set to this property to 0 (effectively meaning "no interpolated
> steps please").
> 
> If we take the branch when num_steps is zero we get a bunch of pointless
> housekeeping that amounts to no more than an extremely elaborate
> malloc/memcpy/free.

Yet in the latest patch, you do it anyway?  Or have I misread it?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
