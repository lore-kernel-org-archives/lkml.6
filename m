Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753364AbeBFSsa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:48:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753047AbeBFSsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:48:23 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B57208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 6 Feb 2018 15:48:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 01/17] perf report: Ask ordered events for --tasks option
Message-ID: <20180206184820.GB3451@kernel.org>
References: <20180206181813.10943-1-jolsa@kernel.org>
 <20180206181813.10943-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206181813.10943-2-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 06, 2018 at 07:17:57PM +0100, Jiri Olsa escreveu:
> If we have the time in, keep the events in time order.

Try to be more verbose, what actual effect this will have in this particular
case?

So, I had to try it to see the effects and explain them:

--- /tmp/before 2018-02-06 15:40:29.536411625 -0300
+++ /tmp/after  2018-02-06 15:40:51.963403599 -0300
@@ -5,34 +5,34 @@
       2540     2540     1818 |   gnome-terminal-
       3489     3489     2540 |    bash
      32433    32433     3489 |     perf
-     32434    32434    32433 |      perf
+     32434    32434    32433 |      make
      32441    32441    32434 |       make
      32514    32514    32441 |        make
        511      511    32514 |         sh
-       512      512      511 |          sh
+       512      512      511 |          install

We don't have perf calling perf calling make, etc, the second perf actually is
'make', i.e.  there was reordering of PERF_RECORD_COMM/PERF_RECORD_FORK:

Look for FORK and COMM meta events, for those tids:

[root@jouet acme]# perf report -D | egrep 'PERF_RECORD_(FORK|COMM)' | egrep '3243[34]'
0 14774650990679 0x1a3cd8 [0x38]: PERF_RECORD_FORK(32433:32433):(3489:3489)
1 14774652080381 0x1d6568 [0x30]: PERF_RECORD_COMM exec: perf:32433/32433
1 14774742473340 0x1dbb48 [0x38]: PERF_RECORD_FORK(32434:32434):(32433:32433)
0 14774752005779 0x1a4af8 [0x30]: PERF_RECORD_COMM exec: make:32434/32434
0 14774753997960 0x1a5578 [0x38]: PERF_RECORD_FORK(32435:32435):(32434:32434)
0 14774756070782 0x1a5618 [0x38]: PERF_RECORD_FORK(32438:32438):(32434:32434)
0 14774757772939 0x1a5680 [0x38]: PERF_RECORD_FORK(32440:32440):(32434:32434)
0 14774758230600 0x1a56e8 [0x38]: PERF_RECORD_FORK(32441:32441):(32434:32434)
[root@jouet acme]#

So they are on different CPUs, thus ring buffers, and when we don't use
ordered_events, we end up mixing that up, right?

- Arnaldo
 
> Link: http://lkml.kernel.org/n/tip-3wcrngoibk5l96nqyhp0nbkm@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-report.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 4ad5dc649716..8ef71669e7a0 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -614,6 +614,7 @@ static int stats_print(struct report *rep)
>  static void tasks_setup(struct report *rep)
>  {
>  	memset(&rep->tool, 0, sizeof(rep->tool));
> +	rep->tool.ordered_events = true;
>  	if (rep->mmaps_mode) {
>  		rep->tool.mmap = perf_event__process_mmap;
>  		rep->tool.mmap2 = perf_event__process_mmap2;
> -- 
> 2.13.6
