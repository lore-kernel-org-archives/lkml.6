Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751E4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3279F21019
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DRuIpGSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3279F21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388957AbeKPKdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:33:47 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33455 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbeKPKdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 05:33:46 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so7127652pgu.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 16:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kABr4LOmderNfm7hGeJECPBW9QN6kSCARGOhfgODUQE=;
        b=DRuIpGSnUACY01JGhfLQRY89r4fZFt3VNwQlaWVNr/C1VopmmxGIuzWP5sE4q2OGrJ
         w0beBhfhNMNGr2ZOTvVZvzCpYwJIP8SIq3IjzPRucjU9P5Om9+9bhfNoA/oXit86/ijn
         xO3ro3ejJcKUfWFQ2kTaCDCOBXqGrhcTtvwDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kABr4LOmderNfm7hGeJECPBW9QN6kSCARGOhfgODUQE=;
        b=bhGGNBoAz5pKYwjA4qKsPUR/5h+sA7jKvEvK3o0Gb9a83d+UrwTMaSiQBZYfqWQiqH
         XYHOm+AaB/IUZxYriN3CYxw9lHdJyZ/tkuBMEhMAxf/WHe4zo/38Ci/mq25TNb1yoUZA
         fI+BL0v6dXNGqHi7a4CICJDXhAFbUyynDDprBSxCxav80zpCHRjEIPqWK+O0aggJiK9S
         KTb1kFigLnORn2BbksskRc6O9VXfUzn0V3id/YMGRyTr0WEC7Ndq4XvwWwRc54NMQT04
         S2d4y7+I6JVdMjQjSYrzBj23ug0Kl1HcRuD+Hl0wZ/Vm+ycAHe2AtKj8zyiNOnoqsr+s
         vflA==
X-Gm-Message-State: AGRZ1gK+3yiSezm+iO8RLuFz/gTNZ/wubbHm3cmhBKxEiaUJk/nzqXm1
        xLpLxmcwUxpnKhJx78pSFdINZQ==
X-Google-Smtp-Source: AJdET5fB0E9rBnYm5UysuUEUsVcuh5RGugp3NS+QCfSabhtF1Xv/ILM5zsDmHLFB1sEAiVbtpyzxtg==
X-Received: by 2002:a62:fb14:: with SMTP id x20-v6mr8674641pfm.71.1542327818856;
        Thu, 15 Nov 2018 16:23:38 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id c14-v6sm32280215pfc.92.2018.11.15.16.23.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 16:23:38 -0800 (PST)
Date:   Thu, 15 Nov 2018 16:23:37 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        amit.kucheria@linaro.org, evgreen@google.com
Subject: Re: [PATCH 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
Message-ID: <20181116002337.GP22824@google.com>
References: <1539257761-23023-1-git-send-email-tdas@codeaurora.org>
 <1539257761-23023-3-git-send-email-tdas@codeaurora.org>
 <153981915373.5275.15971019914218464179@swboyd.mtv.corp.google.com>
 <0c51a12e-38d3-2df5-4f5f-6a687727e9bf@codeaurora.org>
 <154130523254.88331.12609105382114756048@swboyd.mtv.corp.google.com>
 <3aa7b871-9cf9-9626-11fe-b9aa6009b477@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3aa7b871-9cf9-9626-11fe-b9aa6009b477@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 06:12:29PM +0530, Taniya Das wrote:
> Hello Stephen,
> 
> Thanks for your comments.
> 
> On 11/4/2018 9:50 AM, Stephen Boyd wrote:
> > Quoting Taniya Das (2018-11-02 20:06:00)
> > > Hello Stephen,
> > > 
> > > On 10/18/2018 5:02 AM, Stephen Boyd wrote:
> > > > Quoting Taniya Das (2018-10-11 04:36:01)
> > > > > --- a/drivers/cpufreq/Kconfig.arm
> > > > > +++ b/drivers/cpufreq/Kconfig.arm
> > > > > @@ -121,6 +121,17 @@ config ARM_QCOM_CPUFREQ_KRYO
> > > > > 
> > > > >             If in doubt, say N.
> > > > > 
> > > > > +config ARM_QCOM_CPUFREQ_HW
> > > > > +       bool "QCOM CPUFreq HW driver"
> > > > 
> > > > Is there any reason this can't be a module?
> > > > 
> > > 
> > > We do not have any use cases where we need to support it as module.
> > 
> > Ok, so it could easily be tristate then? Why not allow it?
> > 
> 
> I have checked other vendors CPUfreq drivers and those too support only
> "bool".

That's not entirely correct. Most drivers in Kconfig are 'tristate'
and about 50% of those in KConfig.arm are. I'd say make it 'tristate'
unless there are good reasons not to do so.

> > > > > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> > > > > new file mode 100644
> > > > > index 0000000..fe1c264
> > > > > --- /dev/null
> > > > > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > > > > @@ -0,0 +1,354 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> > > > > + */
> > [...]
> > > > > +
> > > > > +static const u16 cpufreq_qcom_std_offsets[REG_ARRAY_SIZE] = {
> > > > 
> > > > Is this going to change in the future?
> > > > 
> > > 
> > > Yes, they could change and that was the reason to introduce the offsets.
> > > This was discussed earlier too with Sudeep and was to add them.
> > > 
> > > > > +       [REG_ENABLE]            = 0x0,
> > 
> > This is only used once? Maybe it could be removed.
> > 
> > > > > +       [REG_LUT_TABLE]         = 0x110,
> > 
> > And this is only used during probe to figure out the supported
> > frequencies. So we definitely don't need to store around the registers
> > after probe in an array of iomem pointers. The only one that we need
> > after probe is the one below.
> > 
> > > > > +       [REG_PERF_STATE]        = 0x920,
> > > > > +};
> > > > > +
> 
> As these address offsets could change, so I am of the opinion to leave them
> as it is.

As of now there is only one set of offsets. Let's just keep the code
simple while this is the case and address different offsets when it is
actually needed, as suggested by Stephen and Sudeep.

> > > > > +static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
> > > > > +
> > > > > +static int
> > > > > +qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
> > > > > +                            unsigned int index)
> > > > > +{
> > > > > +       struct cpufreq_qcom *c = policy->driver_data;
> > > > > +
> > > > > +       writel_relaxed(index, c->reg_bases[REG_PERF_STATE]);
> > > > 
> > > > Why can't we avoid the indirection here and store the perf_state pointer
> > > > in probe? Then we don't have to indirect through a table to perform the
> > > > register write.
> > > > 
> > > 
> > > As the offsets could change and that was the reason to add this.
> > 
> > With fast switching we can avoid incurring any extra instructions, so
> > please make another iomem pointer in the cpufreq_qcom struct just for
> > writing the index or if possible, just pass the iomem pointer that
> > points to the REG_PERF_STATE as the policy->driver_data variable here.
> > Then we have the address in hand without any extra load. If my
> > understanding is correct, we don't need to keep around anything besides
> > this register address anyway so we should be able to just load it and
> > write it immediately.
> > 
> 
> The c->reg_bases[] is just an index to the updated bases addresses. I am not
> clear as to why it would incur an extra instruction.
> 
> The below code would already take care of it.
> 
> +	for (i = REG_ENABLE; i < REG_ARRAY_SIZE; i++)
> +		c->reg_bases[i] = base + offsets[i];
> +

From a performance point of view using a direct iomem pointer
seems like a micro-optimization that probably doesn't have a
measurable impact. However I think the code shouldn't be more complex
than necessary, and at this point the indirection isn't needed.

Cheers

Matthias
