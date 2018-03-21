Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeCUQl5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 12:41:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753158AbeCUQlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 12:41:51 -0400
Date: Wed, 21 Mar 2018 17:41:48 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] perf report: extend raw dump (-D) out with switch
 out event type
Message-ID: <20180321164148.GC2707@krava>
References: <4857e3ba-a42f-a9a2-2668-91ca9b44727c@linux.intel.com>
 <86313484-3601-b218-48b8-1f54843e52de@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86313484-3601-b218-48b8-1f54843e52de@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 04:05:17PM +0300, Alexey Budankov wrote:
> Print additional 'yield' tag for PERF_RECORD_SWITCH[_CPU_WIDE] OUT records when
> event header misc field contains PERF_RECORD_MISC_SWITCH_OUT_YIELD bit set 
> designating synchronization context switch out event:
> 
> perf report -D -i system-wide.perf: 
> 
> 0x1b9c50 [0x30]: event: 15
> .
> . ... raw event: size 48 bytes
> .  0000:  0f 00 00 00 00 20 30 00 01 1e 00 00 01 1e 00 00  ..... 0.........
> .  0010:  00 00 00 00 00 00 00 00 85 ae d4 e3 3e 0e 00 00  ............>...
> .  0020:  54 00 00 00 00 00 00 00 05 00 00 00 00 00 00 00  T...............
> 
> 5 15663273127557 0x1b9c50 [0x30]: PERF_RECORD_SWITCH_CPU_WIDE OUT  next pid/tid:  7681/7681 
> 
> 0x2646c0 [0x30]: event: 15
> .
> . ... raw event: size 48 bytes
> .  0000:  0f 00 00 00 00 60 30 00 00 00 00 00 00 00 00 00  .....`0.........
> .  0010:  00 1e 00 00 00 1e 00 00 29 1e d5 e3 3e 0e 00 00  ........)...>...
> .  0020:  56 00 00 00 00 00 00 00 07 00 00 00 00 00 00 00  V...............
> 
> 7 15663273156137 0x2646c0 [0x30]: PERF_RECORD_SWITCH_CPU_WIDE OUT yield  next pid/tid:     0/0
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/util/event.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index f0a6cbd033cc..af5a85d56446 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -1421,7 +1421,9 @@ size_t perf_event__fprintf_itrace_start(union perf_event *event, FILE *fp)
>  size_t perf_event__fprintf_switch(union perf_event *event, FILE *fp)
>  {
>  	bool out = event->header.misc & PERF_RECORD_MISC_SWITCH_OUT;
> -	const char *in_out = out ? "OUT" : "IN ";
> +	const char *in_out = !out ? "IN " :
> +		!(event->header.misc & PERF_RECORD_MISC_SWITCH_OUT_YIELD) ?
> +				"OUT" : "OUT yield";

I'm getting:

       rcu_sched     9 [004] Sy     1303.392349: PERF_RECORD_SWITCH_CPU_WIDE OUT yield  next pid/tid:     0/0
         swapper     0 [004]        1303.392350: PERF_RECORD_SWITCH_CPU_WIDE IN   prev pid/tid:     9/9

could you plase format the 'OUT yield' line so the rest of the
fields are in line with 'IN' and 'OUT' lines like:

       rcu_sched     9 [004] Sy     1303.392349: PERF_RECORD_SWITCH_CPU_WIDE OUT yield  next pid/tid:     0/0
         swapper     0 [004]        1303.392350: PERF_RECORD_SWITCH_CPU_WIDE IN         prev pid/tid:     9/9

thanks,
jirka
