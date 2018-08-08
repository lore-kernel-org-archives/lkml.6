Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816A4C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3836A21797
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CXnUqElU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3836A21797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbeHHWZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 18:25:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43871 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbeHHWZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 18:25:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id j26-v6so1650460pfi.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 13:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M3PYr0Ny239sUumS+JpiJ82+3/QvRlvmpkhvkz2kdsU=;
        b=CXnUqElU5z7thPvs7YThlqnfzBFbf8ZPKWOBSJ0Q9bWD5Msbp/AQrsr1Y1/s0is0tF
         XF2FBm/73ZJj5Wh0LVqfQuk3S7pGLuvs/iNeuoUdk8TFQyCHEiI8lOBVSaM2SgJM12eX
         RBzia9X2NxpVCS4OKasbctgIfqtV2doAfhKSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M3PYr0Ny239sUumS+JpiJ82+3/QvRlvmpkhvkz2kdsU=;
        b=o4WQNmIuNUWeF6/VgeWmCIUkxzlBYiDsPeChSIuUmuX8HFLBQbsg9fBZfozYTl6RSC
         dqGuCF8jzdAo+01J+swvxTbJ9xXqTYjgXFwmUkxRBwl9cVxkrwQE8b+tFi0r2lyBKXTR
         tZK7EqwdORPzWaWvNwdxzcTwPIZ8EtXH+AiYBRcf6JIrhey4Vlj37Mxqw8wiKW9S7+AE
         sSmZHWZIl/qsoCJ5gM1UnkYnFRGkl7JrY7zDU8g0yM8wEPtVMLYfT4JJQ3FRyfXTD/HG
         culesGoeXXj3mCoYthx93IRyeeGQZfNOQNlj7m4e+KN9qqohghNW/+Q9tIu4mFYeeWmy
         Lpkg==
X-Gm-Message-State: AOUpUlHloftvCXe1Ofup+BGjPj7B0sxQKirFmv8W/Ti6RrsKqnX1Bklf
        +ubX6LqIFufwmyWQ39QjUkjv1SuhJ7o=
X-Google-Smtp-Source: AA+uWPxZagZm5s66vRQ4/VsYvVGyyYe0uAX8xIh+Czsd8p6/l1WpfA68PuT3OL6ulhHatwwdC+A3bw==
X-Received: by 2002:a63:c44a:: with SMTP id m10-v6mr3852891pgg.416.1533758641359;
        Wed, 08 Aug 2018 13:04:01 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w5-v6sm6332541pfn.44.2018.08.08.13.04.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 13:04:00 -0700 (PDT)
Date:   Wed, 8 Aug 2018 13:02:02 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sibis@codeaurora.org,
        ulf.hansson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: q6v5: Add support to vote for rpmh power
 domains
Message-ID: <20180808200202.GS30024@minitux>
References: <20180629102035.2757-1-rnayak@codeaurora.org>
 <20180806164848.GA21235@tuxbook-pro>
 <025ed13c-0b6c-4401-276e-ce2a1cccc67a@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <025ed13c-0b6c-4401-276e-ce2a1cccc67a@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08 Aug 09:20 PDT 2018, Rajendra Nayak wrote:
> On 8/6/2018 10:18 PM, Bjorn Andersson wrote:
> > On Fri 29 Jun 03:20 PDT 2018, Rajendra Nayak wrote:
[..]
> > > +static int q6v5_powerdomain_enable(struct device *dev, struct device **devs,
> > > +				   int count)
> > > +{
> > > +	int i;
> > > +
> > > +	if (!count)
> > > +		return 0;
> > > +
> > > +	if (count > 1)
> > > +		for (i = 0; i < count; i++)
> > > +			dev_pm_genpd_set_performance_state(devs[i], INT_MAX);
> > > +	else
> > > +		dev_pm_genpd_set_performance_state(dev, INT_MAX);
> > 
> > I would prefer if we could just set the performance state during
> > initialization, but I see that we only aggregate the state during
> > dev_pm_genpd_set_performance_state().
> > 
> > As such you need to also reduce the votes in the disable path; or we
> > will just max out any shared corners from the first time we boot this
> > remoteproc.
> 
> Right, I need to drop the votes along with doing a runtime suspend of the
> device.
> 
> > 
> > 
> > For this to work I believe _genpd_power_o{n,ff}() would need to
> > aggregate the performance state of all enabled consumers, something that
> > would make the interface more convenient to use.
> 
> This isn't done today. There was some discussion in another thread on *if*
> we should do this and what could be the implications [1]
> 

Thanks for the pointer, so let's start by explicitly setting the
performance state during both enable and disable and then we can discuss
adding this logic to the core separately.

[..]
> > > +	pm_runtime_enable(dev);
> > 
> > Don't you need a call to something like pm_suspend_ignore_children()
> > here as well, to prevent a pm_runtime_get_sync() in a child device to
> > power on our rails at runtime?
> 
> Are there any child nodes of remoteproc which do runtime control of
> resources via runtime pm?
> 

Srinivas does that in the audio drivers.

Regards,
Bjorn
