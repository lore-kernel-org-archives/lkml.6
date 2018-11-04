Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFEAC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 04:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B8B20685
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 04:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g6EAFVVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B8B20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbeKDNeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 08:34:06 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43084 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728984AbeKDNeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 08:34:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id g7-v6so552522pfo.10
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 21:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=9j5uePIhij3R4NH/YyHoDCsOyA6g+d1LRJIUn2dNC+A=;
        b=g6EAFVVYtLgsxypVfZUmz/v4rGp49vpLLhaGGfsjoYWKJxNHr0UvffnVPgflH8tCh3
         7DJcWtW0ziFHb5NlG+y5hTLqGz1xoAX9FaVwGHdFdofuIZYNpI7KOrGlUlrf91xVqOV5
         QLTEt0Np51DuJVG1OcNrAwrzzjvD3csLI2TcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=9j5uePIhij3R4NH/YyHoDCsOyA6g+d1LRJIUn2dNC+A=;
        b=LBhO3TmaFLn+npCjk1Ocv/rFUsTvpUrx8x6OX/70nirbtTQJhqnW1JGwbhj7VVWAWS
         4VHBImuT3QXb4ym+YVYDuI7PmM4THLeyEqgnQlD2VFul9xNfkhrk2y/OqBJAZpgVKcFU
         eQh/8qM55j40GYcIMN99coU4PBqkAW4R+PczsNKW0Iv3Sd9bHLZrAZAOQv0RlL7KTREa
         pnpq2wT986wIFtA4KSwBm4GnmP4To4U7JQ6tmwDqrvBR5PQ0Ks9eH4O5UpDuAOkO3cbY
         btwv38IQdctuD1/9CWQiViZ5AihGuk9Aq2cuF9x+GC4hTpsj8IYhbVlP2xWscp0hQCGt
         H9QA==
X-Gm-Message-State: AGRZ1gK+lvXdkTvc9Sn9Efk5u7OKORHg/6/evAd7bm4tCh7Y0aoHxcjn
        nlcwPtXQLM8AfGjkMNQbiYMKrp51o8I=
X-Google-Smtp-Source: AJdET5cp0u/pSRoTFnr8+mFpfq/wco+IgOhtNReu5LKv12kR+PuDMdrRnvRwRP1ArB2++kiS4awQ1A==
X-Received: by 2002:aa7:858b:: with SMTP id w11-v6mr17907604pfn.77.1541305234547;
        Sat, 03 Nov 2018 21:20:34 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id r124-v6sm55846210pfr.151.2018.11.03.21.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 21:20:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <0c51a12e-38d3-2df5-4f5f-6a687727e9bf@codeaurora.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        robh@kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        evgreen@google.com
References: <1539257761-23023-1-git-send-email-tdas@codeaurora.org>
 <1539257761-23023-3-git-send-email-tdas@codeaurora.org>
 <153981915373.5275.15971019914218464179@swboyd.mtv.corp.google.com>
 <0c51a12e-38d3-2df5-4f5f-6a687727e9bf@codeaurora.org>
Message-ID: <154130523254.88331.12609105382114756048@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date:   Sat, 03 Nov 2018 21:20:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-11-02 20:06:00)
> Hello Stephen,
> =

> On 10/18/2018 5:02 AM, Stephen Boyd wrote:
> > Quoting Taniya Das (2018-10-11 04:36:01)
> >> --- a/drivers/cpufreq/Kconfig.arm
> >> +++ b/drivers/cpufreq/Kconfig.arm
> >> @@ -121,6 +121,17 @@ config ARM_QCOM_CPUFREQ_KRYO
> >>
> >>            If in doubt, say N.
> >>
> >> +config ARM_QCOM_CPUFREQ_HW
> >> +       bool "QCOM CPUFreq HW driver"
> > =

> > Is there any reason this can't be a module?
> > =

> =

> We do not have any use cases where we need to support it as module.

Ok, so it could easily be tristate then? Why not allow it?

> =

> >> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-=
cpufreq-hw.c
> >> new file mode 100644
> >> index 0000000..fe1c264
> >> --- /dev/null
> >> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> >> @@ -0,0 +1,354 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> >> + */
[...]
> >> +
> >> +static const u16 cpufreq_qcom_std_offsets[REG_ARRAY_SIZE] =3D {
> > =

> > Is this going to change in the future?
> > =

> =

> Yes, they could change and that was the reason to introduce the offsets. =

> This was discussed earlier too with Sudeep and was to add them.
> =

> >> +       [REG_ENABLE]            =3D 0x0,

This is only used once? Maybe it could be removed.

> >> +       [REG_LUT_TABLE]         =3D 0x110,

And this is only used during probe to figure out the supported
frequencies. So we definitely don't need to store around the registers
after probe in an array of iomem pointers. The only one that we need
after probe is the one below.

> >> +       [REG_PERF_STATE]        =3D 0x920,
> >> +};
> >> +
> >> +static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
> >> +
> >> +static int
> >> +qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
> >> +                            unsigned int index)
> >> +{
> >> +       struct cpufreq_qcom *c =3D policy->driver_data;
> >> +
> >> +       writel_relaxed(index, c->reg_bases[REG_PERF_STATE]);
> > =

> > Why can't we avoid the indirection here and store the perf_state pointer
> > in probe? Then we don't have to indirect through a table to perform the
> > register write.
> > =

> =

> As the offsets could change and that was the reason to add this.

With fast switching we can avoid incurring any extra instructions, so
please make another iomem pointer in the cpufreq_qcom struct just for
writing the index or if possible, just pass the iomem pointer that
points to the REG_PERF_STATE as the policy->driver_data variable here.
Then we have the address in hand without any extra load. If my
understanding is correct, we don't need to keep around anything besides
this register address anyway so we should be able to just load it and
write it immediately.

