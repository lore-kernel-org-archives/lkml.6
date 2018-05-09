Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935545AbeEIRI0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:08:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935512AbeEIRIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:08:24 -0400
Date: Wed, 9 May 2018 14:08:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH RFC 06/19] perf tools: Fix kernel_start for KPTI on x86_64
Message-ID: <20180509170809.GJ13491@kernel.org>
References: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
 <1525866228-30321-7-git-send-email-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525866228-30321-7-git-send-email-adrian.hunter@intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 09, 2018 at 02:43:35PM +0300, Adrian Hunter escreveu:
> On x86_64, KPTI entry trampolines are less than the start of kernel text,
> but still above 2^63. So leave kernel_start = 1ULL << 63 for x86_64.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/machine.c | 16 +++++++++++++++-
>  tools/perf/util/machine.h |  2 ++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 72a351613d85..22047ff3cf2a 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2296,6 +2296,15 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
>  	return 0;
>  }
>  
> +/*
> + * Compares the raw arch string. N.B. see instead perf_env__arch() if a
> + * normalized arch is needed.
> + */
> +bool machine__is(struct machine *machine, const char *arch)
> +{
> +	return machine->env && !strcmp(machine->env->arch, arch);
> +}
> +

Please make machine__is(NULL) return false, to reduce boilerplate in
callers:

bool machine__is(struct machine *machine, const char *arch)
{
	return machine && machine->env && !strcmp(machine->env->arch, arch);
}


>  int machine__get_kernel_start(struct machine *machine)
>  {
>  	struct map *map = machine__kernel_map(machine);
> @@ -2312,7 +2321,12 @@ int machine__get_kernel_start(struct machine *machine)
>  	machine->kernel_start = 1ULL << 63;
>  	if (map) {
>  		err = map__load(map);
> -		if (!err)
> +		/*
> +		 * On x86_64, KPTI entry trampolines are less than the
> +		 * start of kernel text, but still above 2^63. So leave
> +		 * kernel_start = 1ULL << 63 for x86_64.
> +		 */
> +		if (!err && !machine__is(machine, "x86_64"))
>  			machine->kernel_start = map->start;
>  	}
>  	return err;
> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> index 388fb4741c54..b31d33b5aa2a 100644
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -188,6 +188,8 @@ static inline bool machine__is_host(struct machine *machine)
>  	return machine ? machine->pid == HOST_KERNEL_ID : false;
>  }
>  
> +bool machine__is(struct machine *machine, const char *arch);
> +
>  struct thread *__machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
>  struct thread *machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
>  
> -- 
> 1.9.1
