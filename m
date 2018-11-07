Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D83DC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389D0208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389D0208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbeKHCdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:33:44 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54594 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbeKHCdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:33:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B58D1A78;
        Wed,  7 Nov 2018 09:02:29 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD7703F5BD;
        Wed,  7 Nov 2018 09:02:20 -0800 (PST)
Date:   Wed, 7 Nov 2018 17:02:16 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
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
Subject: Re: [PATCH v8 03/15] PM: Introduce an Energy Model management
 framework
Message-ID: <20181107170213.yapun7nk5rrjdf55@queper01-lin>
References: <20181016101513.26919-1-quentin.perret@arm.com>
 <20181016101513.26919-4-quentin.perret@arm.com>
 <CAKfTPtBN3HpNMrztcmAwkGuW9uHaKBi9KoqdvBEHuxf7=078NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBN3HpNMrztcmAwkGuW9uHaKBi9KoqdvBEHuxf7=078NA@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Wednesday 07 Nov 2018 at 17:32:32 (+0100), Vincent Guittot wrote:
> Hi Quentin,
> 
> On Tue, 16 Oct 2018 at 12:15, Quentin Perret <quentin.perret@arm.com> wrote:
> >
> 
> > +
> > +/**
> > + * em_pd_energy() - Estimates the energy consumed by the CPUs of a perf. domain
> > + * @pd         : performance domain for which energy has to be estimated
> > + * @max_util   : highest utilization among CPUs of the domain
> > + * @sum_util   : sum of the utilization of all CPUs in the domain
> > + *
> > + * Return: the sum of the energy consumed by the CPUs of the domain assuming
> > + * a capacity state satisfying the max utilization of the domain.
> > + */
> > +static inline unsigned long em_pd_energy(struct em_perf_domain *pd,
> > +                               unsigned long max_util, unsigned long sum_util)
> > +{
> > +       unsigned long freq, scale_cpu;
> > +       struct em_cap_state *cs;
> > +       int i, cpu;
> > +
> > +       /*
> > +        * In order to predict the capacity state, map the utilization of the
> > +        * most utilized CPU of the performance domain to a requested frequency,
> > +        * like schedutil.
> > +        */
> > +       cpu = cpumask_first(to_cpumask(pd->cpus));
> > +       scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
> > +       cs = &pd->table[pd->nr_cap_states - 1];
> > +       freq = map_util_freq(max_util, cs->frequency, scale_cpu);
> > +
> > +       /*
> > +        * Find the lowest capacity state of the Energy Model above the
> > +        * requested frequency.
> > +        */
> > +       for (i = 0; i < pd->nr_cap_states; i++) {
> > +               cs = &pd->table[i];
> > +               if (cs->frequency >= freq)
> > +                       break;
> > +       }
> > +
> > +       /*
> > +        * The capacity of a CPU in the domain at that capacity state (cs)
> > +        * can be computed as:
> > +        *
> > +        *             cs->freq * scale_cpu
> > +        *   cs->cap = --------------------                          (1)
> > +        *                 cpu_max_freq
> > +        *
> > +        * So, ignoring the costs of idle states (which are not available in
> > +        * the EM), the energy consumed by this CPU at that capacity state is
> > +        * estimated as:
> > +        *
> > +        *             cs->power * cpu_util
> > +        *   cpu_nrg = --------------------                          (2)
> > +        *                   cs->cap
> > +        *
> > +        * since 'cpu_util / cs->cap' represents its percentage of busy time.
> > +        *
> > +        *   NOTE: Although the result of this computation actually is in
> > +        *         units of power, it can be manipulated as an energy value
> > +        *         over a scheduling period, since it is assumed to be
> > +        *         constant during that interval.
> > +        *
> > +        * By injecting (1) in (2), 'cpu_nrg' can be re-expressed as a product
> > +        * of two terms:
> > +        *
> > +        *             cs->power * cpu_max_freq   cpu_util
> > +        *   cpu_nrg = ------------------------ * ---------          (3)
> > +        *                    cs->freq            scale_cpu
> > +        *
> > +        * The first term is static, and is stored in the em_cap_state struct
> > +        * as 'cs->cost'.
> > +        *
> > +        * Since all CPUs of the domain have the same micro-architecture, they
> > +        * share the same 'cs->cost', and the same CPU capacity. Hence, the
> > +        * total energy of the domain (which is the simple sum of the energy of
> > +        * all of its CPUs) can be factorized as:
> > +        *
> > +        *            cs->cost * \Sum cpu_util
> > +        *   pd_nrg = ------------------------                       (4)
> > +        *                  scale_cpu
> > +        */
> > +       return cs->cost * sum_util / scale_cpu;
> 
> Why do you need to keep scale_cpu outside the cs->cost ? do you expect
> arch_scale_cpu_capacity() to change at runtime ?

Unfortunately yes, it can. It'll change at least during boot on arm64,
for example (see drivers/base/arch_topology.c). And also, userspace can
actually set that value via sysfs ...

> If the returned value of arch_scale_cpu_capacity() changes, we will
> have to rebuild several others things and we can include the update of
> cs->cost

Yeah, that was the original approach I had actually. Some of the older
versions of this patch set were doing just that. The only issue is that,
in order to make the cs->cost updatable are run time, you need to
introduce some level of protection around that data structure (RCU or
something). And that would make it a bit harder for IPA (for example) to
access the data -- it doesn't need any kind of RCU to access it's EM at
the moment.

We can probably do something a bit smarter and introduce RCU protection
only for the 'cost' field or something, but I was hoping that we could
keep things simple for now and do that kind of small optimization a bit
later :-)

Thanks,
Quentin
