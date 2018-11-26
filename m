Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FD9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDC8208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="myQmNhsa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BDC8208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeK0K0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:26:04 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40752 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbeK0K0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:26:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so7354572pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 15:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MVDFD/oDzIbAiupD5Utj9/vJuIOZ0hoGY+Fsnfe5aWU=;
        b=myQmNhsaU/xoSLgpHrx6Bt1TXxldFHmGrzFPmeRxhxC+ca6jg1HmspiAgYeVKYIdtQ
         0gByzDqUxyIipwSEmn8TI93ujGnb1cMJhJ8lPnFYWoFkrggBOIVv4Yh/ynJNLwWQyF6M
         SFAkWSDzbXjFykXvMsZQObU82ejJ78VG0LOCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MVDFD/oDzIbAiupD5Utj9/vJuIOZ0hoGY+Fsnfe5aWU=;
        b=YI+pGc9f/kzGq4zudfxS7RPhpTPKef8tsqVWf5tnr7Z3VNux7G72M9aJ173qN5pRTo
         b3a3+L3w3iEPooXmFMP0HlRWxkkeSiMEK5FBkOR1HsR/p1uBR2VeEacoeqR/BABEDqwM
         EmOLvj/nniihzxyAB2ZIBWwCs//JSbvlcodhDVJFcCQKvWnqu0XxY15g8Rt6r0Gmzw20
         FrdXjrF0QRdqWflrEgtp8mxy8oxT0ivt13YDRPJhxDx9SVuaU+SDfnEYLnxZAZ5urdAV
         VdNuTLn1kFiwlgRgHtIqKDnwj5ZRFxbBo0Ur5Ynq5YwG7koevsa7rM2DgdIMIRS+HtCr
         Iewg==
X-Gm-Message-State: AA+aEWazxuHNi0rcwYuSZ8Waeav8dBkFHeVOr/kTys6U1cvnRoFvHnhw
        PVrweeWc2QbwcRQyGlSa6P2FlbBabeE=
X-Google-Smtp-Source: AFSGD/XXuFhoDXxfxHr6sVNWvyPLe7S/rpy6voWMQi/oovGToCbaoxFWbC/GGoUV12jCfM1zWuYmmw==
X-Received: by 2002:a63:5122:: with SMTP id f34mr25886250pgb.218.1543275017130;
        Mon, 26 Nov 2018 15:30:17 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id h129sm2008423pfb.110.2018.11.26.15.30.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 15:30:16 -0800 (PST)
Date:   Mon, 26 Nov 2018 15:30:15 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Taniya Das <tdas@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        amit.kucheria@linaro.org, evgreen@google.com
Subject: Re: [PATCH v10 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq
 HW driver
Message-ID: <20181126233015.GX22824@google.com>
References: <1542796967-5949-1-git-send-email-tdas@codeaurora.org>
 <1542796967-5949-3-git-send-email-tdas@codeaurora.org>
 <20181121220614.GU22824@google.com>
 <20181122050708.zictqzfne6odsywu@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181122050708.zictqzfne6odsywu@vireshk-i7>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 10:37:08AM +0530, Viresh Kumar wrote:
> On 21-11-18, 14:06, Matthias Kaehlcke wrote:
> > On Wed, Nov 21, 2018 at 04:12:47PM +0530, Taniya Das wrote:
> > > +	.boost_enabled	= true,
> > 
> > I have no real expertise with cpufreq boost, but after reading a bit
> > through cpufreq code this seems wrong. Boost is enabled statically,
> > however the driver has neither a ->set_boost function nor does it call
> > cpufreq_enable_boost_support() which would use a default
> > implementation for ->set_boost. As a result boost support is
> > effectively disabled:
> > 
> > static bool cpufreq_boost_supported(void)
> > {
> >         return likely(cpufreq_driver) && cpufreq_driver->set_boost;
> > }
> > 
> > The driver should probably do the same as cpufreq-dt.c and call
> > cpufreq_enable_boost_support() if boost frequencies are available,
> > instead of 'enabling' boost statically.
> 
> Feels like I have written the boost support in cpufreq core few decades back as
> I don't remember any of it :)
> 
> But reading through the code this is what I understood.

Thanks for digging into it!

> There are two parts of boosting.
> 
> - Sysfs file available or not to enable/disable boost frequencies on the go.
>   This file gets created only when cpufreq_enable_boost_support() gets called.
> 
> - Will cpufreq core consider boost frequencies or not while checking target
>   frequency again, this is governed by cpufreq_driver->boost field, which can be
>   set from driver or using the sysfs file mentioned above.
> 
> In this driver, all we have done is to set the cpufreq_driver->boost field to
> true, which would allow cpufreq core to use boost frequencies as well. But that
> isn't any better than making them all normal frequencies and getting rid of
> boost stuff. The boosting stuff will be useful only if you want to disable some
> of them at runtime, based on heating, etc. And that is possible only after you
> create a sysfs file.

That matches what Amit reported (and I confirmed) about the CPU
frequency "being stuck" at the boost frequency
(https://lore.kernel.org/patchwork/patch/998335/#1186701) on a loaded
system.

Taniya: I wonder if it would make sense to drop boost support for now
in order to land a first working version of the driver soon, instead
of keeping respinning this series. Boost support could be added as a
separate feature, just like cooling devices. If you have a working
quick fix now that's also fine, otherwise I'd suggest the iterative
approach, I'm sure you also want to see this landing ;-)

Cheers

Matthias
