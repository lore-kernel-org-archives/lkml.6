Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeDKXbM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 19:31:12 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:36016 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeDKXbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 19:31:11 -0400
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Thu, 12 Apr 2018 08:31:09 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Kim Phillips <kim.phillips@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, kernel-team@lge.com
Subject: Re: [PATCH] Revert "perf machine: Fix paranoid check in
 machine__set_kernel_mmap()"
Message-ID: <20180411233109.GA6320@sejong>
References: <20180215122635.24029-1-jolsa@kernel.org>
 <20180215122635.24029-7-jolsa@kernel.org>
 <20180219022036.GB1583@sejong>
 <20180219100140.GA17630@krava>
 <20180219101936.GD1583@sejong>
 <20180219104917.GA19365@krava>
 <20180219121817.GC14978@kernel.org>
 <20180411180752.b64c4d105222fb22c159b852@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180411180752.b64c4d105222fb22c159b852@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Apr 11, 2018 at 06:07:52PM -0500, Kim Phillips wrote:
> perf test 1 is failing on an arm64 box (that has a kernel module
> loaded fwiw).  Running bisect resulted in commit 1d12cec6ce99 "perf
> machine: Fix paranoid check in machine__set_kernel_mmap()" being the
> first bad commit.  Reverting it fixes symbol resolution:
> 
>  # ./perf.bad record true; ./perf.bad --no-pager report --stdio --quiet
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.001 MB perf.data (10 samples) ]
>      64.34%  true     [unknown]         [k] 0xffff20000809ffb8
>      32.12%  true     [unknown]         [k] 0xffff20000869f400
>       3.24%  true     [unknown]         [k] 0xffff20000868d924
>       0.28%  perf.ba  [unknown]         [k] 0xffff200008598b34
>       0.03%  perf.ba  [unknown]         [k] 0xffff200008598a94
> 
>  # ./perf.good record true; ./perf.good --no-pager report --stdio --quiet
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.001 MB perf.data (9 samples) ]
>      91.71%  true     [kernel.kallsyms]  [k] restore_nameidata
>       7.60%  true     [kernel.kallsyms]  [k] perf_iterate_ctx.constprop.38
>       0.69%  perf.go  [kernel.kallsyms]  [k] perf_event_exec
> 
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: <kernel-team@lge.com>
> Fixes: 1d12cec6ce99 ("perf machine: Fix paranoid check in machine__set_kernel_mmap()")
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
> It's not clear to me what the specific intent of the original commit
> was, thus the revert.

Hmm.. maybe your kernel map has non-zero start and zero end.  I
thought it was just from an old or invalid data.  But now I think that
overflow can create it..  could you please show me the mmap event?

  $ perf script --show-mmap-events

Thanks,
Namhyung


> 
>  tools/perf/util/machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 2eca8478e24f..089399139778 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1224,7 +1224,7 @@ static void machine__set_kernel_mmap(struct machine *machine,
>  		 * Be a bit paranoid here, some perf.data file came with
>  		 * a zero sized synthesized MMAP event for the kernel.
>  		 */
> -		if (start == 0 && end == 0)
> +		if (machine->vmlinux_maps[i]->end == 0)
>  			machine->vmlinux_maps[i]->end = ~0ULL;
>  	}
>  }
> -- 
> 2.17.0
> 
