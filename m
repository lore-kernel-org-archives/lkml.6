Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753237AbeBFTJL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 14:09:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752688AbeBFTJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 14:09:04 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15423214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 6 Feb 2018 16:09:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 07/17] perf tools: Free root_dir in machine__init error
 path
Message-ID: <20180206190902.GF3451@kernel.org>
References: <20180206181813.10943-1-jolsa@kernel.org>
 <20180206181813.10943-8-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206181813.10943-8-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 06, 2018 at 07:18:03PM +0100, Jiri Olsa escreveu:
> Freeing root_dir in machine__init error path.
> 
> Link: http://lkml.kernel.org/n/tip-ng92slsanexqw7h1d6sadnj7@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/machine.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index b05a67464c03..e300a643f65b 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -50,6 +50,8 @@ static void machine__threads_init(struct machine *machine)
>  
>  int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
>  {
> +	int err = -ENOMEM;
> +
>  	memset(machine, 0, sizeof(*machine));
>  	map_groups__init(&machine->kmaps, machine);
>  	RB_CLEAR_NODE(&machine->rb_node);
> @@ -79,7 +81,7 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
>  		char comm[64];
>  
>  		if (thread == NULL)
> -			return -ENOMEM;
> +			goto out;
>  
>  		snprintf(comm, sizeof(comm), "[guest/%d]", pid);
>  		thread__set_comm(thread, comm, 0);
> @@ -87,7 +89,11 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
>  	}
>  
>  	machine->current_tid = NULL;
> +	err = 0;
>  
> +out:
> +	if (err)
> +		free(machine->root_dir);

In these cases, i.e. freeing something inside some other struct, its
better to use:

		zfree(&machine->root_dir);

>  	return 0;
>  }
>  
> -- 
> 2.13.6
