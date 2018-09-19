Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B47ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D3A20858
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JIf3I/M/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D3A20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732828AbeITDeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:34:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32943 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbeITDeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:34:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id y18-v6so65171pge.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 14:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hmh+QTPeuke9Rh/Rj3r9TNvtmhqLMVnnlBeCUVVtZTs=;
        b=JIf3I/M/kmmtdQyA2Q8/i4lQ5UCNGeuaEg1hWNg7QPb+XcSJbSXMn9GsC/tL9HD7oR
         zIlZOSo/caJpubsCf2pbZuLxA62xg3ktWpx8KSmI0zRRXmS/BAawApxtL1ijIUgVw+6/
         Imk6mxmCsLnBc7Y8GwBweC0xtbmXYO7r+LPBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hmh+QTPeuke9Rh/Rj3r9TNvtmhqLMVnnlBeCUVVtZTs=;
        b=KMHCgGK6c4TJCboBqucyonkJ/6iNVvYibFEy0zNqkbwbJH8kWMb+1oz0+fpQy+azds
         aN9zxiSP91GoNZD8RY3OKxAf9Ilw8Uewegw77xdDdY/jZlRWOPdeJhHUmsP0ZiXD8yFN
         y3iDQelzkHn9WYhuSVBtwWzIvuQBQelBrwQrQXC2Ih+TyXd5C+VvcWC4+5zZq8Kw2UXd
         530VwISNes3KEy6hYS6tL0BqwcrUd8ctNKWbSTdTQ//LAUhlYfHe45vX2KSPaD08+pLx
         jwnorH+WX+3h9tJwFYHchyVlimAZZV3zeDHdy0OPiCBKkZOS1ubD7QkXg7VTGDfdkYfY
         bNRQ==
X-Gm-Message-State: APzg51CTjDW77/jBXGkliQ2dA+gIKMn6bzIibSIJMCLUxLyf0mg4pqiS
        06OfHdhfxYi8gd+lJUxGqu7G/A==
X-Google-Smtp-Source: ANB0VdZKXBQkXk7x2gGpBLetHVw3zWhNB53d9HpMaVZXb1uQTaYo5btaf+nUbWngXNXgFfc32D59SQ==
X-Received: by 2002:a63:2c01:: with SMTP id s1-v6mr31795370pgs.367.1537394059374;
        Wed, 19 Sep 2018 14:54:19 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id r23-v6sm46496664pfj.5.2018.09.19.14.54.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 14:54:18 -0700 (PDT)
Date:   Wed, 19 Sep 2018 14:54:18 -0700
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>, ilia.lin@gmail.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cpufreq: qcom-kryo: Fix section mismatch warning
Message-ID: <20180919215418.y2jsrsj73vy3dudd@vireshk-mac-ubuntu>
References: <20180919182247.1101-1-natechancellor@gmail.com>
 <CAKwvOdnW8p4Tj2n+Y4XyMMVdD7W90W4NTLkJHKhZ6604ah4fnw@mail.gmail.com>
 <20180919215039.mb7prmmfs5jek3aj@vireshk-mac-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919215039.mb7prmmfs5jek3aj@vireshk-mac-ubuntu>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-09-18, 14:50, Viresh Kumar wrote:
> On 19-09-18, 14:45, Nick Desaulniers wrote:
> > On Wed, Sep 19, 2018 at 11:22 AM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > WARNING: vmlinux.o(.text+0x8aa424): Section mismatch in reference from
> > > the function qcom_cpufreq_kryo_probe() to the function
> > > .init.text:qcom_cpufreq_kryo_get_msm_id()
> > > The function qcom_cpufreq_kryo_probe() references
> > > the function __init qcom_cpufreq_kryo_get_msm_id().
> > > This is often because qcom_cpufreq_kryo_probe lacks a __init
> > > annotation or the annotation of qcom_cpufreq_kryo_get_msm_id is wrong.
> > >
> > > Add the '__init' annotation to qcom_cpufreq_kryo_probe so that there is
> > > no more mismatch warning.
> > 
> > I wonder why this driver has an exit function marked __init rather
> > than __exit?
> 
> I think it was just a mistake.
> 
> > Does that mean it gets cleaned up after kernel init, and
> > so on unloading of the driver, the kernel jumps to unmapped memory?
> 
> The __init/exit sections are only useful when the driver is builtin
> and so there is no unloading. Yeah, if you would have tried to call
> shutdown for the kernel, it may have crashed or something. I don't
> know.
> 
> > Does this patch now produce a warning for `qcom_cpufreq_kryo_driver`
> > referencing `qcom_cpufreq_kryo_probe`?
> 
> Why should it ? It doesn't though.

I thought you replied to my commit where I marked the exit routine
with __exit and realised just now that it wasn't the case. I haven't
build-tested this thing, but the question still stands. Why should it
?

-- 
viresh
