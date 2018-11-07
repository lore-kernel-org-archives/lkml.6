Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DCAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E352086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SG+jkJ+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E352086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbeKHCDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:03:50 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34400 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbeKHCDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:03:50 -0500
Received: by mail-io1-f67.google.com with SMTP id d80-v6so12369368iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 08:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WBFvOupRtJvP9d+lO+uiIRlm/XREZlArppdVF/CCLec=;
        b=SG+jkJ+ZQb9ksUQxgtYyFPRAQ4iM22ndXSCDIbmWAY8C4eSfa3edOi02BsrnA+qa8w
         eBBxi1NrEwwKdYangu9OG9F+5LFLEEBvBKrd4UfsdloHn8wrJM78s8YADyYOL7HahdkX
         UnzHgBtiY6LsqO/HrJCyJ/rXIjM40JHTm5QY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WBFvOupRtJvP9d+lO+uiIRlm/XREZlArppdVF/CCLec=;
        b=ET6iF2S6Y5cPONEDpltv45veP//pfem3hDwc7bI1MAFo+rjzk8O/zSZdepLhfT6dP3
         xEfjJFjOhs0PFkWf/1lqgU/uncZDuYFKEO6PT7gJQN032nhAZlmBVCG8FmNz7Kf7hWuy
         RdT/ql7G6WQj7NuEAJneHt2OoQUCbqX2mX8Ye6s25uvZ+ZLNhxSWFvt83hSqdsD/sIjh
         3AQ1e3chiri0y7yudlXRmUnEiFkHgUTQoCiRmy3hcj62VW73xbQ2bdejKjmjKeCus3GJ
         h0UZVYj1IveJXjGNthMroVZzBqvawsCUS69xMVI1cSX8xzulYcgTP5S3KAPCCq0fPiYv
         iZpg==
X-Gm-Message-State: AGRZ1gJg6TRT3uqhPppPoYPSdq/xBhBn7rUX24MFFQxqN21TkLaxuC3c
        NYxUWEYMS1sKujX9aZ249j9lZatNst2WVTRSYKcg8A==
X-Google-Smtp-Source: AJdET5cd4m3B4EKGHZb6Vgo1k6hSI0gJPQE54D9gkM6hupiHaFJ1R27xchlBw4wV9FVgiF745W7rUBKJAAWtVb13NpA=
X-Received: by 2002:a6b:244:: with SMTP id 65-v6mr730571ioc.183.1541608363484;
 Wed, 07 Nov 2018 08:32:43 -0800 (PST)
MIME-Version: 1.0
References: <20181016101513.26919-1-quentin.perret@arm.com> <20181016101513.26919-4-quentin.perret@arm.com>
In-Reply-To: <20181016101513.26919-4-quentin.perret@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 7 Nov 2018 17:32:32 +0100
Message-ID: <CAKfTPtBN3HpNMrztcmAwkGuW9uHaKBi9KoqdvBEHuxf7=078NA@mail.gmail.com>
Subject: Re: [PATCH v8 03/15] PM: Introduce an Energy Model management framework
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Cc: Steve Muckle" <smuckle@google.com>, adharmap@codeaurora.org,
        Saravana Kannan <skannan@codeaurora.org>,
        pkondeti@codeaurora.org, Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Tue, 16 Oct 2018 at 12:15, Quentin Perret <quentin.perret@arm.com> wrote:
>

> +
> +/**
> + * em_pd_energy() - Estimates the energy consumed by the CPUs of a perf. domain
> + * @pd         : performance domain for which energy has to be estimated
> + * @max_util   : highest utilization among CPUs of the domain
> + * @sum_util   : sum of the utilization of all CPUs in the domain
> + *
> + * Return: the sum of the energy consumed by the CPUs of the domain assuming
> + * a capacity state satisfying the max utilization of the domain.
> + */
> +static inline unsigned long em_pd_energy(struct em_perf_domain *pd,
> +                               unsigned long max_util, unsigned long sum_util)
> +{
> +       unsigned long freq, scale_cpu;
> +       struct em_cap_state *cs;
> +       int i, cpu;
> +
> +       /*
> +        * In order to predict the capacity state, map the utilization of the
> +        * most utilized CPU of the performance domain to a requested frequency,
> +        * like schedutil.
> +        */
> +       cpu = cpumask_first(to_cpumask(pd->cpus));
> +       scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
> +       cs = &pd->table[pd->nr_cap_states - 1];
> +       freq = map_util_freq(max_util, cs->frequency, scale_cpu);
> +
> +       /*
> +        * Find the lowest capacity state of the Energy Model above the
> +        * requested frequency.
> +        */
> +       for (i = 0; i < pd->nr_cap_states; i++) {
> +               cs = &pd->table[i];
> +               if (cs->frequency >= freq)
> +                       break;
> +       }
> +
> +       /*
> +        * The capacity of a CPU in the domain at that capacity state (cs)
> +        * can be computed as:
> +        *
> +        *             cs->freq * scale_cpu
> +        *   cs->cap = --------------------                          (1)
> +        *                 cpu_max_freq
> +        *
> +        * So, ignoring the costs of idle states (which are not available in
> +        * the EM), the energy consumed by this CPU at that capacity state is
> +        * estimated as:
> +        *
> +        *             cs->power * cpu_util
> +        *   cpu_nrg = --------------------                          (2)
> +        *                   cs->cap
> +        *
> +        * since 'cpu_util / cs->cap' represents its percentage of busy time.
> +        *
> +        *   NOTE: Although the result of this computation actually is in
> +        *         units of power, it can be manipulated as an energy value
> +        *         over a scheduling period, since it is assumed to be
> +        *         constant during that interval.
> +        *
> +        * By injecting (1) in (2), 'cpu_nrg' can be re-expressed as a product
> +        * of two terms:
> +        *
> +        *             cs->power * cpu_max_freq   cpu_util
> +        *   cpu_nrg = ------------------------ * ---------          (3)
> +        *                    cs->freq            scale_cpu
> +        *
> +        * The first term is static, and is stored in the em_cap_state struct
> +        * as 'cs->cost'.
> +        *
> +        * Since all CPUs of the domain have the same micro-architecture, they
> +        * share the same 'cs->cost', and the same CPU capacity. Hence, the
> +        * total energy of the domain (which is the simple sum of the energy of
> +        * all of its CPUs) can be factorized as:
> +        *
> +        *            cs->cost * \Sum cpu_util
> +        *   pd_nrg = ------------------------                       (4)
> +        *                  scale_cpu
> +        */
> +       return cs->cost * sum_util / scale_cpu;

Why do you need to keep scale_cpu outside the cs->cost ? do you expect
arch_scale_cpu_capacity() to change at runtime ?

If the returned value of arch_scale_cpu_capacity() changes, we will
have to rebuild several others things and we can include the update of
cs->cost
