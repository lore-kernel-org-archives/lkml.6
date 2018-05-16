Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751062AbeEPR7Z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 13:59:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750775AbeEPR7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 13:59:24 -0400
Date: Wed, 16 May 2018 18:59:18 +0100
From: James Hogan <jhogan@kernel.org>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>, linux-mips@linux-mips.org,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 4/7] MIPS: perf: Fix perf with MT counting other
 threads
Message-ID: <20180516175916.GA12837@jamesdev>
References: <1524219789-31241-1-git-send-email-matt.redfearn@mips.com>
 <1524219789-31241-5-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <1524219789-31241-5-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 11:23:06AM +0100, Matt Redfearn wrote:
> diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf=
_event_mipsxx.c
> index 7e2b7d38a774..fe50986e83c6 100644
> --- a/arch/mips/kernel/perf_event_mipsxx.c
> +++ b/arch/mips/kernel/perf_event_mipsxx.c
> @@ -323,7 +323,11 @@ static int mipsxx_pmu_alloc_counter(struct cpu_hw_ev=
ents *cpuc,
> =20
>  static void mipsxx_pmu_enable_event(struct hw_perf_event *evt, int idx)
>  {
> +	struct perf_event *event =3D container_of(evt, struct perf_event, hw);
>  	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> +#ifdef CONFIG_MIPS_MT_SMP
> +	unsigned int range =3D evt->event_base >> 24;
> +#endif /* CONFIG_MIPS_MT_SMP */
> =20
>  	WARN_ON(idx < 0 || idx >=3D mipspmu.num_counters);
> =20
> @@ -331,11 +335,37 @@ static void mipsxx_pmu_enable_event(struct hw_perf_=
event *evt, int idx)
>  		(evt->config_base & M_PERFCTL_CONFIG_MASK) |
>  		/* Make sure interrupt enabled. */
>  		MIPS_PERFCTRL_IE;
> -	if (IS_ENABLED(CONFIG_CPU_BMIPS5000))
> +
> +#ifdef CONFIG_CPU_BMIPS5000
> +	{
>  		/* enable the counter for the calling thread */
>  		cpuc->saved_ctrl[idx] |=3D
>  			(1 << (12 + vpe_id())) | BRCM_PERFCTRL_TC;
> +	}
> +#else
> +#ifdef CONFIG_MIPS_MT_SMP
> +	if (range > V) {
> +		/* The counter is processor wide. Set it up to count all TCs. */
> +		pr_debug("Enabling perf counter for all TCs\n");
> +		cpuc->saved_ctrl[idx] |=3D M_TC_EN_ALL;
> +	} else
> +#endif /* CONFIG_MIPS_MT_SMP */
> +	{
> +		unsigned int cpu, ctrl;
> =20
> +		/*
> +		 * Set up the counter for a particular CPU when event->cpu is
> +		 * a valid CPU number. Otherwise set up the counter for the CPU
> +		 * scheduling this thread.
> +		 */
> +		cpu =3D (event->cpu >=3D 0) ? event->cpu : smp_processor_id();
> +
> +		ctrl =3D M_PERFCTL_VPEID(cpu_vpe_id(&cpu_data[cpu]));
> +		ctrl |=3D M_TC_EN_VPE;
> +		cpuc->saved_ctrl[idx] |=3D ctrl;
> +		pr_debug("Enabling perf counter for CPU%d\n", cpu);
> +	}
> +#endif /* CONFIG_CPU_BMIPS5000 */

I'm not a huge fan of the ifdefery tbh, I don't think it makes it very
easy to read having a combination of ifs and #ifdefs. I reckon
IF_ENABLED would be better, perhaps with having the BMIPS5000 case
return to avoid too much nesting.

Otherwise the patch looks okay to me.

Thanks
James

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvxxcwAKCRA1zuSGKxAj
8kBCAP4sctSZ7Q6x87ZMki4qfpi/KV9WrytKPScE+HZ1vi4yIAEA7JVy8xtAxT5l
JtIM0hxrefKUgoOV+JDhwyIB7SKAgAM=
=EsA1
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
