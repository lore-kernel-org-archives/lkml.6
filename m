Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BE7C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864C2218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHpYfEo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731463AbfAaJhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:37:08 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39424 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbfAaJhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:37:08 -0500
Received: by mail-pg1-f194.google.com with SMTP id r11so1126068pgp.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 01:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tes1xOM6xvBzoz8vsWFdl1gZjnjCSAWcQcV+Fxh9rh0=;
        b=KHpYfEo+JXhEzb5TasA5pOp9S+aIFFPYLGJHwRpBUswT0iYZkgrcdkoscHx5pg5gMr
         mcKXhsiShR1L2+X4aEDQO27j8kystnfPz2s8XUw8ENWPU/cIuUOenALlkSXCgS0oGtID
         RWYFSq4fh7dqffmWHl3ORJzflARyxUqVXjgrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tes1xOM6xvBzoz8vsWFdl1gZjnjCSAWcQcV+Fxh9rh0=;
        b=H6Y14834sSvFCyut3SzQuKPpgeKzkQ1LbRzD/Q5uH/I+Ka+89sBL/MveU2YKm4hIBn
         fYKpimqcXeW0QcG3zPeGBYsIPDVqGmKOTPw4bJXMJXMqUsikoMYANpKLLTH6tykrRsSs
         UlB7uahPNKST24wHNlw79p03wi0/hksw1wzjOzCX3hST1nBNRVxJutuuC+rnBYaWcFX8
         zn6AsoakManM1x5Z0bCMjMnP06cH9dRF4Cyx74vJ20thy/S22/r7TQbsvRA53DrBh0iN
         NNzc2j+XRX13EIidWwd/+NEu0UWLRgG5wEKX/QaXJV1DdKfSCdAaOxNa3KQoMg2iMmGQ
         AYoQ==
X-Gm-Message-State: AJcUukcKVNd3IDPePtUotdXrKydn8qozM45CiIooDty5dY/yap9+4geN
        UJQhzq0+5FrqWCfv335AxfJTfg==
X-Google-Smtp-Source: ALg8bN4Vd5QYGg/Bxhw0luhjSWJkPM/Xaw3w69itzt67uTY5Cq3rzivScoP4tcIwt7y0RPQwrasJhA==
X-Received: by 2002:a63:e302:: with SMTP id f2mr31139128pgh.320.1548927427539;
        Thu, 31 Jan 2019 01:37:07 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id x3sm9769773pgt.45.2019.01.31.01.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 01:37:06 -0800 (PST)
Date:   Thu, 31 Jan 2019 15:07:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>, sudeep.holla@arm.com,
        rjw@rjwysocki.net, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 1/5] PM / OPP: Introduce a power estimation helper
Message-ID: <20190131093704.43wzrwshscvdtoj2@vireshk-i7>
References: <20190130170506.20450-1-quentin.perret@arm.com>
 <20190130170506.20450-2-quentin.perret@arm.com>
 <20190130190703.GM81583@google.com>
 <20190131072209.nhbgid3cystvr2p5@vireshk-i7>
 <20190131093418.umsbh4eevgod42sh@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131093418.umsbh4eevgod42sh@queper01-lin>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-01-19, 09:34, Quentin Perret wrote:
> On Thursday 31 Jan 2019 at 12:52:09 (+0530), Viresh Kumar wrote:
> > On 30-01-19, 11:07, Matthias Kaehlcke wrote:
> > > On Wed, Jan 30, 2019 at 05:05:02PM +0000, Quentin Perret wrote:
> > > > +static int __maybe_unused _get_cpu_power(unsigned long *mW, unsigned long *kHz,
> > > > +					 int cpu)
> > > 
> > > why __maybe_unused?
> > 
> > Yeah, it isn't required I think. He probably added it for the case
> > where CONFIG_ENERGY_MODEL=n, but even then an inline routine is
> > defined which will accept it as argument and wouldn't do anything with
> > it. Had it been a macro, we would have required __maybe_unused but not
> > now.
> 
> The thing is, the EM_DATA_CB() macro _is_ stubbed for
> CONFIG_ENERGY_MODEL=n:
> 
> https://elixir.bootlin.com/linux/v5.0-rc4/source/include/linux/energy_model.h#L165
> 
> So, without __maybe_unused you get do get a compiler warning.

Yeah, I almost got to it and still missed it :)

-- 
viresh
