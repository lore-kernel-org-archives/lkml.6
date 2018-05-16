Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752490AbeEPJQC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 05:16:02 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45913 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752095AbeEPJQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 05:16:00 -0400
X-Google-Smtp-Source: AB8JxZqA55hlbHCtH7USFq9YL/u6FzgCjmrj8Rj8rrbvpaxbaC/WvQiv/sZFjPifFtbuoPqQ3dMd/g==
Date: Wed, 16 May 2018 18:11:53 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yann Ylavic <ylavic.dev@gmail.com>, linux-rt-users@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [PATCH v2 14/14] tracing/selftest: Add test to test hist trigger
 between kernel event and trace_marker
Message-ID: <20180516091153.GC30309@danjae.aot.lge.com>
References: <20180514205845.017925650@goodmis.org>
 <20180514205959.393826165@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180514205959.393826165@goodmis.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 04:58:59PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Add a test that tests a trigger that is initiated by a kernel event
> (sched_waking) and compared to a write to the trace_marker.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  .../trigger/trigger-trace-marker-synthetic.tc | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
> index 8e7a043da7fb..d8cfc36f228b 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
> @@ -31,6 +31,11 @@ if [ ! -d events/ftrace/print ]; then
>      exit_unsupported
>  fi
>  
> +if [ ! -d events/sched/sched_waking ]; then
> +    echo "event sched_waking is not supported"
> +    exit_unsupported
> +fi
> +
>  if [ ! -f events/ftrace/print/trigger ]; then
>      echo "event trigger is not supported"
>      exit_unsupported
> @@ -63,4 +68,21 @@ grep 'hitcount: *1$' events/synthetic/latency/hist > /dev/null || \
>  
>  do_reset
>  
> +echo "Test histogram kernel event to trace_marker latency histogram trigger"
> +
> +echo 'latency u64 lat' > synthetic_events
> +echo 'hist:keys=pid:ts0=common_timestamp.usecs' > events/sched/sched_waking/trigger
> +echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$ts0:onmatch(ftrace.print).latency($lat)' > events/ftrace/print/trigger

Shouldn't it be "onmatch(sched.sched_waking)" ?

Thanks,
Namhyung


> +echo 'hist:keys=common_pid,lat:sort=lat' > events/synthetic/latency/trigger
> +sleep 1
> +echo "hello" > trace_marker
> +
> +grep 'hitcount: *1$' events/ftrace/print/hist > /dev/null || \
> +    fail "hist trigger did not trigger correct times on trace_marker"
> +
> +grep 'hitcount: *1$' events/synthetic/latency/hist > /dev/null || \
> +    fail "hist trigger did not trigger "
> +
> +do_reset
> +
>  exit 0
> -- 
> 2.17.0
> 
> 
