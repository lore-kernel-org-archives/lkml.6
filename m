Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbeBFTH4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 14:07:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37296 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752702AbeBFTHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 14:07:48 -0500
Date: Tue, 6 Feb 2018 19:59:51 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 01/17] perf report: Ask ordered events for --tasks option
Message-ID: <20180206185951.GB28396@krava>
References: <20180206181813.10943-1-jolsa@kernel.org>
 <20180206181813.10943-2-jolsa@kernel.org>
 <20180206184820.GB3451@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206184820.GB3451@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 03:48:20PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Feb 06, 2018 at 07:17:57PM +0100, Jiri Olsa escreveu:
> > If we have the time in, keep the events in time order.
> 
> Try to be more verbose, what actual effect this will have in this particular
> case?
> 
> So, I had to try it to see the effects and explain them:
> 
> --- /tmp/before 2018-02-06 15:40:29.536411625 -0300
> +++ /tmp/after  2018-02-06 15:40:51.963403599 -0300
> @@ -5,34 +5,34 @@
>        2540     2540     1818 |   gnome-terminal-
>        3489     3489     2540 |    bash
>       32433    32433     3489 |     perf
> -     32434    32434    32433 |      perf
> +     32434    32434    32433 |      make
>       32441    32441    32434 |       make
>       32514    32514    32441 |        make
>         511      511    32514 |         sh
> -       512      512      511 |          sh
> +       512      512      511 |          install
> 
> We don't have perf calling perf calling make, etc, the second perf actually is
> 'make', i.e.  there was reordering of PERF_RECORD_COMM/PERF_RECORD_FORK:
> 
> Look for FORK and COMM meta events, for those tids:
> 
> [root@jouet acme]# perf report -D | egrep 'PERF_RECORD_(FORK|COMM)' | egrep '3243[34]'
> 0 14774650990679 0x1a3cd8 [0x38]: PERF_RECORD_FORK(32433:32433):(3489:3489)
> 1 14774652080381 0x1d6568 [0x30]: PERF_RECORD_COMM exec: perf:32433/32433
> 1 14774742473340 0x1dbb48 [0x38]: PERF_RECORD_FORK(32434:32434):(32433:32433)
> 0 14774752005779 0x1a4af8 [0x30]: PERF_RECORD_COMM exec: make:32434/32434
> 0 14774753997960 0x1a5578 [0x38]: PERF_RECORD_FORK(32435:32435):(32434:32434)
> 0 14774756070782 0x1a5618 [0x38]: PERF_RECORD_FORK(32438:32438):(32434:32434)
> 0 14774757772939 0x1a5680 [0x38]: PERF_RECORD_FORK(32440:32440):(32434:32434)
> 0 14774758230600 0x1a56e8 [0x38]: PERF_RECORD_FORK(32441:32441):(32434:32434)
> [root@jouet acme]#
> 
> So they are on different CPUs, thus ring buffers, and when we don't use
> ordered_events, we end up mixing that up, right?

right ;-) time sorted is always better..

thanks,
jirka
