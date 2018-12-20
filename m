Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F131C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1406E217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OAt5atSd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732858AbeLTOJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:09:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43337 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731255AbeLTOJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 09:09:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so1897129wrs.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 06:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MXCduRLidV5Y2s88Gyg/N4BgSVPqPJlaFtjfZoolwFI=;
        b=OAt5atSd5KMTOh+hCSw3lA8Vm1wj2zZPhIuXG3JC6DUfIw9JUEo+wUF0yRm4k6UKI1
         PwGV9lU1Sb4sdg1g2lK1AugYY5l+/UXO/+i1YCMMcRvcrGWVzEieae2kYF7tlGBmT6ZU
         q5XNVY9yCn0YyOyux//IJPou4zxCN9TDqwpJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MXCduRLidV5Y2s88Gyg/N4BgSVPqPJlaFtjfZoolwFI=;
        b=d12UfyOmd9TkNkTnEKR1w/Re+Vyg5M99Sr6t3bRtPLaLURRiWaR5OBVehZHAtRrqhh
         Wx2lBiGvI43g1W/I5lb6FJpYUNgrWPoj1GsIlqENW8GbLx3BAO92IHWkVeAk9nJfODte
         Aqp9Em7AEhwPKz8KOC7pGUucIFShGerQJeznTRQV11tMuJX+EKpe6rNRkd4AanizGXTq
         nRfBPvv/XGp72z5ruf+cngsIVs4C0q7OUveK8cSN1fSMQqsQfsfCRsf3duuRBBz/EXM0
         4Pc+MGFHxsblXuzAx+x7jozAbifR7OuD8zKaRMJBxyuHcEg7/rkw9rRZhr3pu/8D7VCn
         XvYw==
X-Gm-Message-State: AA+aEWakgHZlGmrYLfAydsH2FaMDjuDZGwLb7hQOmCv/P3sBUM2u4+DL
        DVdgPKNduiIc8lfJ70L3yJa94GN0mLo=
X-Google-Smtp-Source: AFSGD/W5+DNc3zSbSwCRnIPAvaohoz/ozEuusdKpfnYt1uD9X08g8RQESQ4F3STvJRH1ivydEeOojA==
X-Received: by 2002:adf:900f:: with SMTP id h15mr22696475wrh.18.1545314941239;
        Thu, 20 Dec 2018 06:09:01 -0800 (PST)
Received: from [192.168.0.40] (55.183.88.92.rev.sfr.net. [92.88.183.55])
        by smtp.googlemail.com with ESMTPSA id c15sm1207011wml.27.2018.12.20.06.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 06:09:00 -0800 (PST)
Subject: Re: [PATCH v10 16/27] drivers: firmware: psci: Prepare to use OS
 initiated suspend mode
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc:     "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-17-ulf.hansson@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <20e1c04b-870f-3213-835d-28724ef4f530@linaro.org>
Date:   Thu, 20 Dec 2018 15:08:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129174700.16585-17-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2018 18:46, Ulf Hansson wrote:
> To enable the OS initiated mode, the CPU topology needs to be described
> using the hierarchical model in DT. When used, the idle state bits for the
> CPU are created by ORing the bits for PM domain's idle state.
> 
> Let's prepare the PSCI driver to deal with this, via introducing a per CPU
> variable called domain_state and by adding internal helpers to read/write
> the value of the variable.

What are the domain states ? What values can they have ?

> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v10:
> 	- Use __this_cpu_read|write() rather than this_cpu_read|write().
> 
> ---
>  drivers/firmware/psci/psci.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 4f0cbc95e41b..8dbcdecc2ae4 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -87,8 +87,19 @@ static u32 psci_function_id[PSCI_FN_MAX];
>  				(PSCI_1_0_EXT_POWER_STATE_ID_MASK | \
>  				PSCI_1_0_EXT_POWER_STATE_TYPE_MASK)
>  
> +static DEFINE_PER_CPU(u32, domain_state);
>  static u32 psci_cpu_suspend_feature;
>  
> +static inline u32 psci_get_domain_state(void)
> +{
> +	return __this_cpu_read(domain_state);
> +}
> +
> +static inline void psci_set_domain_state(u32 state)
> +{
> +	__this_cpu_write(domain_state, state);
> +}
> +
>  static inline bool psci_has_ext_power_state(void)
>  {
>  	return psci_cpu_suspend_feature &
> @@ -187,6 +198,8 @@ static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
>  
>  	fn = psci_function_id[PSCI_FN_CPU_ON];
>  	err = invoke_psci_fn(fn, cpuid, entry_point, 0);
> +	/* Clear the domain state to start fresh. */
> +	psci_set_domain_state(0);
>  	return psci_to_linux_errno(err);

I think this change is ambiguous:

 - if it is a change of the state because of the cpu_on, then I was
expecting a similar change in cpu_off and the change only if
invoke_psci_fn() succeeds.

 - if it is a change to take opportunity of the code path to initialize
the domain state, I suggest to remove it from there and make it very
explicit with static DEFINE_PER_CPU(u32, domain_state) = { 0 };


>  }
>  
> @@ -409,15 +422,17 @@ int psci_cpu_init_idle(struct cpuidle_driver *drv, unsigned int cpu)
>  static int psci_suspend_finisher(unsigned long index)
>  {
>  	u32 *state = __this_cpu_read(psci_power_state);
> +	u32 composite_state = state[index - 1] | psci_get_domain_state();
>  
> -	return psci_ops.cpu_suspend(state[index - 1],
> -				    __pa_symbol(cpu_resume));
> +	return psci_ops.cpu_suspend(composite_state, __pa_symbol(cpu_resume));
>  }
>  
>  int psci_cpu_suspend_enter(unsigned long index)
>  {
>  	int ret;
>  	u32 *state = __this_cpu_read(psci_power_state);
> +	u32 composite_state = state[index - 1] | psci_get_domain_state();
> +
>  	/*
>  	 * idle state index 0 corresponds to wfi, should never be called
>  	 * from the cpu_suspend operations
> @@ -425,11 +440,14 @@ int psci_cpu_suspend_enter(unsigned long index)
>  	if (WARN_ON_ONCE(!index))
>  		return -EINVAL;
>  
> -	if (!psci_power_state_loses_context(state[index - 1]))
> -		ret = psci_ops.cpu_suspend(state[index - 1], 0);
> +	if (!psci_power_state_loses_context(composite_state))
> +		ret = psci_ops.cpu_suspend(composite_state, 0);
>  	else
>  		ret = cpu_suspend(index, psci_suspend_finisher);
>  
> +	/* Clear the domain state to start fresh when back from idle. */
> +	psci_set_domain_state(0);
> +
>  	return ret;
>  }
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

