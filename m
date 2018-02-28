Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752251AbeB1JXl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 04:23:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44286 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751954AbeB1JXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 04:23:38 -0500
Date: Wed, 28 Feb 2018 10:23:35 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Wang Nan <wangnan0@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix trigger class trigger_on()
Message-ID: <20180228092335.GA31021@krava>
References: <1519807144-30694-1-git-send-email-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519807144-30694-1-git-send-email-adrian.hunter@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 10:39:04AM +0200, Adrian Hunter wrote:
> trigger_on() means that the trigger is available but not ready, however
> trigger_on() was making it ready. That can segfault if the signal comes
> before trigger_ready(). e.g. (USR2 signal delivery not shown)
> 
>   $ perf record -e intel_pt//u -S sleep 1
>   perf: Segmentation fault
>   Obtained 16 stack frames.
>   /home/ahunter/bin/perf(sighandler_dump_stack+0x40) [0x4ec550]
>   /lib/x86_64-linux-gnu/libc.so.6(+0x36caf) [0x7fa76411acaf]
>   /home/ahunter/bin/perf(perf_evsel__disable+0x26) [0x4b9dd6]
>   /home/ahunter/bin/perf() [0x43a45b]
>   /lib/x86_64-linux-gnu/libc.so.6(+0x36caf) [0x7fa76411acaf]
>   /lib/x86_64-linux-gnu/libc.so.6(__xstat64+0x15) [0x7fa7641d2cc5]
>   /home/ahunter/bin/perf() [0x4ec6c9]
>   /home/ahunter/bin/perf() [0x4ec73b]
>   /home/ahunter/bin/perf() [0x4ec73b]
>   /home/ahunter/bin/perf() [0x4ec73b]
>   /home/ahunter/bin/perf() [0x4eca15]
>   /home/ahunter/bin/perf(machine__create_kernel_maps+0x257) [0x4f0b77]
>   /home/ahunter/bin/perf(perf_session__new+0xc0) [0x4f86f0]
>   /home/ahunter/bin/perf(cmd_record+0x722) [0x43c132]
>   /home/ahunter/bin/perf() [0x4a11ae]
>   /home/ahunter/bin/perf(main+0x5d4) [0x427fb4]
> 
> Note, for testing purposes, this is hard to hit unless you add some sleep()
> in builtin-record.c before record__open().
> 
> Fixes: 3dcc4436fa6f ("perf tools: Introduce trigger class")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/trigger.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/trigger.h b/tools/perf/util/trigger.h
> index 370138e7e35c..88223bc7c82b 100644
> --- a/tools/perf/util/trigger.h
> +++ b/tools/perf/util/trigger.h
> @@ -12,7 +12,7 @@
>   * States and transits:
>   *
>   *
> - *  OFF--(on)--> READY --(hit)--> HIT
> + *  OFF--> ON --> READY --(hit)--> HIT
>   *                 ^               |
>   *                 |            (ready)
>   *                 |               |
> @@ -27,8 +27,9 @@ struct trigger {
>  	volatile enum {
>  		TRIGGER_ERROR		= -2,
>  		TRIGGER_OFF		= -1,
> -		TRIGGER_READY		= 0,
> -		TRIGGER_HIT		= 1,
> +		TRIGGER_ON		= 0,
> +		TRIGGER_READY		= 1,
> +		TRIGGER_HIT		= 2,
>  	} state;
>  	const char *name;
>  };
> @@ -50,7 +51,7 @@ static inline bool trigger_is_error(struct trigger *t)
>  static inline void trigger_on(struct trigger *t)
>  {
>  	TRIGGER_WARN_ONCE(t, TRIGGER_OFF);
> -	t->state = TRIGGER_READY;
> +	t->state = TRIGGER_ON;
>  }
>  
>  static inline void trigger_ready(struct trigger *t)
> -- 
> 1.9.1
> 
