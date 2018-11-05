Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B43CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE08C2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYc1p43/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE08C2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387784AbeKFDRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:17:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:57474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbeKFDRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:17:33 -0500
Received: from jouet.infradead.org (unknown [189.40.101.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A79F20866;
        Mon,  5 Nov 2018 17:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541440602;
        bh=E0s3DP5uM3esENGjrj/vK0CJnuqHpup3xTvFh2ewmfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EYc1p43/yqZ05hiExAgKJWrn1roLlQFUO8hc1pfWNg+qL2dzWV6XEN9VnEZLdyNna
         SwsCnQvD1J3aNKb8LCxZDcxBUMvvfCL4e/1NWUvHAK9OASF1MwHPTwOd/wFgqdzTcA
         E47fuxgfprEBL0ZGzunKieGJl/UD22rfQEe5/nf0=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id EF8B6143058; Mon,  5 Nov 2018 14:29:46 -0300 (-03)
Date:   Mon, 5 Nov 2018 14:29:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org, leo.yan@linaro.org,
        David Miller <davem@davemloft.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 1/5] perf tools: Add fallback functions for cases where
 cpumode is insufficient
Message-ID: <20181105172946.GH11147@kernel.org>
References: <20181031091043.23465-1-adrian.hunter@intel.com>
 <20181031091043.23465-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031091043.23465-2-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 31, 2018 at 11:10:39AM +0200, Adrian Hunter escreveu:
> For branch stacks or branch samples, the sample cpumode might not be
> correct because it applies only to the sample 'ip' and not necessary to
> 'addr' or branch stack addresses. Add fallback functions that can be used
> to deal with those cases
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: stable@vger.kernel.org # 4.19
> ---
>  tools/perf/util/event.c   | 27 ++++++++++++++++++++++++++
>  tools/perf/util/machine.c | 40 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/machine.h |  2 ++
>  tools/perf/util/thread.h  |  4 ++++
>  4 files changed, 73 insertions(+)
> 
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index bc646185f8d9..52b24b8ce29e 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -1576,6 +1576,24 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
>  	return al->map;
>  }
>  
> +/*
> + * For branch stacks or branch samples, the sample cpumode might not be correct
> + * because it applies only to the sample 'ip' and not necessary to 'addr' or
> + * branch stack addresses. If possible, use a fallback to deal with those cases.
> + */
> +struct map *thread__find_map_fallback(struct thread *thread, u8 cpumode,
> +				      u64 addr, struct addr_location *al)
> +{

You named one as _fallback...

> +	struct map *map = thread__find_map(thread, cpumode, addr, al);
> +	struct machine *machine = thread->mg->machine;
> +	u8 addr_cpumode = machine__addr_cpumode(machine, cpumode, addr);
> +
> +	if (map || addr_cpumode == cpumode)
> +		return map;
> +
> +	return thread__find_map(thread, addr_cpumode, addr, al);
> +}
> +
>  struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
>  				   u64 addr, struct addr_location *al)
>  {
> @@ -1585,6 +1603,15 @@ struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
>  	return al->sym;
>  }
>  
> +struct symbol *thread__find_symbol_fb(struct thread *thread, u8 cpumode,
> +				      u64 addr, struct addr_location *al)

... and the other as _fb, make it consistent, please.

> +{
> +	al->sym = NULL;
> +	if (thread__find_map_fallback(thread, cpumode, addr, al))
> +		al->sym = map__find_symbol(al->map, al->addr);
> +	return al->sym;
> +}
> +
>  /*
>   * Callers need to drop the reference to al->thread, obtained in
>   * machine__findnew_thread()
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 111ae858cbcb..04edc0eac376 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2542,6 +2542,46 @@ int machine__get_kernel_start(struct machine *machine)
>  	return err;
>  }
>  
> +/*
> + * machine__single_ku_as - Machine has same address space for kernel and user.
> + * @machine: machine object
> + *
> + * Some architectures have a single address space for kernel and user addresses,
> + * which makes it possible to determine if an address is in kernel space or user
> + * space.
> + */
> +static bool machine__single_ku_as(struct machine *machine)
> +{
> +	return strcmp(perf_env__arch(machine->env), "sparc");
> +}

Can we avoid having this strcmp be done repeatedly? I.e. just make this
a boolean initialized at session start, when machine->env is setup, so
we'd have:

   machine->single_address_space

Instead of a function?

Also have you considered making this fallback to be performed only from
code that is that arch specific?

I.e. the code that supports branch samples/stacks is x86_86 specific at
this point and thus only in that case we would call the routines that
perform the fallback, which, in turn, wouldn't need to check for
"sparc"?

> +
> +u8 machine__addr_cpumode(struct machine *machine, u8 cpumode, u64 addr)
> +{
> +	u8 addr_cpumode = cpumode;
> +	bool kernel_ip;
> +
> +	if (!machine__single_ku_as(machine))
> +		goto out;
> +
> +	kernel_ip = machine__kernel_ip(machine, addr);
> +	switch (cpumode) {
> +	case PERF_RECORD_MISC_KERNEL:
> +	case PERF_RECORD_MISC_USER:
> +		addr_cpumode = kernel_ip ? PERF_RECORD_MISC_KERNEL :
> +					   PERF_RECORD_MISC_USER;
> +		break;
> +	case PERF_RECORD_MISC_GUEST_KERNEL:
> +	case PERF_RECORD_MISC_GUEST_USER:
> +		addr_cpumode = kernel_ip ? PERF_RECORD_MISC_GUEST_KERNEL :
> +					   PERF_RECORD_MISC_GUEST_USER;
> +		break;
> +	default:
> +		break;
> +	}
> +out:
> +	return addr_cpumode;
> +}
> +
>  struct dso *machine__findnew_dso(struct machine *machine, const char *filename)
>  {
>  	return dsos__findnew(&machine->dsos, filename);
> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> index d856b85862e2..20d464135ed1 100644
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -99,6 +99,8 @@ static inline bool machine__kernel_ip(struct machine *machine, u64 ip)
>  	return ip >= kernel_start;
>  }
>  
> +u8 machine__addr_cpumode(struct machine *machine, u8 cpumode, u64 addr);
> +
>  struct thread *machine__find_thread(struct machine *machine, pid_t pid,
>  				    pid_t tid);
>  struct comm *machine__thread_exec_comm(struct machine *machine,
> diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> index 36c09a9904e6..e28f9dc1110a 100644
> --- a/tools/perf/util/thread.h
> +++ b/tools/perf/util/thread.h
> @@ -96,9 +96,13 @@ struct thread *thread__main_thread(struct machine *machine, struct thread *threa
>  
>  struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
>  			     struct addr_location *al);
> +struct map *thread__find_map_fallback(struct thread *thread, u8 cpumode,
> +				      u64 addr, struct addr_location *al);
>  
>  struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
>  				   u64 addr, struct addr_location *al);
> +struct symbol *thread__find_symbol_fb(struct thread *thread, u8 cpumode,
> +				      u64 addr, struct addr_location *al);
>  
>  void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
>  					struct addr_location *al);
> -- 
> 2.17.1
