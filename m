Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90E4C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 16:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B34224C8C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 16:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B34224C8C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeFWQvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 12:51:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43821 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbeFWQvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 12:51:03 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWljo-0007A8-68; Sat, 23 Jun 2018 18:50:12 +0200
Date:   Sat, 23 Jun 2018 18:50:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com,
        pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
In-Reply-To: <20180621212518.19914-10-pasha.tatashin@oracle.com>
Message-ID: <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com> <20180621212518.19914-10-pasha.tatashin@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018, Pavel Tatashin wrote:
> We will change sched_clock() to be called early.

Why is this relevant? Does the issue only appear with that change?

> But, during boot sched_clock() changes its output without notifying us
> about the change of clock source.

Why would the sched clock change notify _US_?

Can you please try to write your changelog in factual technical terms
without impersonating the system/code?

> This happens in tsc_init(), when static_branch_enable(&__use_tsc) is
> called.
> 
> native_sched_clock() changes from outputing jiffies to reading tsc, but
> sched is not notified in anyway. So, to preserve the continoutity in this

sched? -EMAKESNOSENSE

There is no notification mechanism and it's not required.  

> place we add the offset of sched_clock() to the calculation of cyc2ns.

s/we//

See Documentation/process/submitting-patches.rst

  Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy to
  do frotz", as if you are giving orders to the codebase to change its
  behaviour.

> Without this change, the output would look like this:

Would? It looks exactly like this or why would you try to fix it?

> 
> [    0.004000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.009000] tsc: Fast TSC calibration using PIT
> [    0.010000] tsc: Detected 3192.137 MHz processor
> [    0.011000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2e03465ceb2,    max_idle_ns: 440795259855 ns
> 
> static_branch_enable(__use_tsc) is called, and timestamps became precise
> but reduced:
> 
> [    0.002233] Calibrating delay loop (skipped), value calculated using timer frequency..     6384.27 BogoMIPS (lpj=3192137)
> [    0.002516] pid_max: default: 32768 minimum: 301

Let me give you an example:

  When tsc_init() enables the usage of TSC for sched_clock() the
  initialization of the tsc sched clock conversion data starts from zero
  and not from the current jiffies based sched_clock() value. This makes
  the timestamps jump backwards:

  [    0.010000] tsc: Detected 3192.137 MHz processor
  [    0.011000] clocksource: tsc-early: mask:  ... 
  [    0.002233] Calibrating delay loop (skipped), ....

  To address this, extend set_cyc2ns_scale() with an argument to base the
  cyc2ns offset on the current sched_clock() value. During run time this
  offset is 0 as the cyc2ns offset is based on the TSC sched_clock()
  itself.

See? Precise and pure technical. No we/us/would/ and no irrelevant
information.

> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  arch/x86/kernel/tsc.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 186395041725..654a01cc0358 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -133,7 +133,9 @@ static inline unsigned long long cycles_2_ns(unsigned long long cyc)
>  	return ns;
>  }
>  
> -static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
> +static void set_cyc2ns_scale(unsigned long khz, int cpu,
> +			     unsigned long long tsc_now,
> +			     unsigned long long sched_now)

sched_now is not a real good name for this as it's only used at
initialization time. So the argument name should reflect this otherwise you
wonder yourself when looking at that code 6 month from now, why it's 0 on
all the run time call sites. init_offset or some other sensible name which
makes the purpose entirely clear.

>  void __init tsc_init(void)
>  {
> -	u64 lpj, cyc;
> +	u64 lpj, cyc, sch;

sch? what's wrong with sched_now or now? It's not that there is a 3 letter
limit.

>  	int cpu;
>  
>  	if (!boot_cpu_has(X86_FEATURE_TSC)) {
> @@ -1403,9 +1405,10 @@ void __init tsc_init(void)
>  	 * up if their speed diverges)
>  	 */
>  	cyc = rdtsc();
> +	sch = local_clock();
>  	for_each_possible_cpu(cpu) {
>  		cyc2ns_init(cpu);
> -		set_cyc2ns_scale(tsc_khz, cpu, cyc);
> +		set_cyc2ns_scale(tsc_khz, cpu, cyc, sch);
>  	}

Thanks,

	tglx
