Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753285AbeCFIyp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 03:54:45 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60122 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbeCFIyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 03:54:44 -0500
Date: Tue, 6 Mar 2018 09:54:36 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Song Liu <songliubraving@fb.com>
Cc: linux-kernel@vger.kernel.org, jolsa@redhat.com, kernel-team@fb.com,
        ephiepark@fb.com
Subject: Re: [PATCH] perf: correct ctx_event_type in ctx_resched()
Message-ID: <20180306085436.GA25201@hirez.programming.kicks-ass.net>
References: <20180306055504.3283731-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306055504.3283731-1-songliubraving@fb.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 09:55:04PM -0800, Song Liu wrote:
> In ctx_resched(), EVENT_FLEXIBLE should be sched_out when EVENT_PINNED is
> added. However, ctx_resched() calculates ctx_event_type before checking
> this condition. As a result, pinned events will NOT get higher priority
> than flexible events.
> 
> The following shows this issue on an Intel CPU (where ref-cycles can
> only use one hardware counter).
> 
>   1. First start:
>        perf stat -C 0 -e ref-cycles  -I 1000
>   2. Then, in the second console, run:
>        perf stat -C 0 -e ref-cycles:D -I 1000
> 
> The second perf uses pinned events, which is expected to have higher
> priority. However, because it failed in ctx_resched(). It is never
> run.
> 
> This patch fixes this by calculating ctx_event_type after re-evaluating
> event_type.
> 
> Fixes: 487f05e18aa4 ("perf/core: Optimize event rescheduling on active contexts")
> Signed-off-by: Song Liu <songliubraving@fb.com>
> Reported-by: Ephraim Park <ephiepark@fb.com>

Thanks!
