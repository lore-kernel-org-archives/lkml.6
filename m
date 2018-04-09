Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeDILst (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:48:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40866 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeDILss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 07:48:48 -0400
Date: Mon, 9 Apr 2018 13:48:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
Cc: Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/core: fix use-after-free in uprobe_perf_close
Message-ID: <20180409114845.GX4082@hirez.programming.kicks-ass.net>
References: <20180409100346.6416-1-bhole_prashant_q7@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409100346.6416-1-bhole_prashant_q7@lab.ntt.co.jp>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 07:03:46PM +0900, Prashant Bhole wrote:
> A use-after-free bug was caught by KASAN while running usdt related
> code. (BCC project. bcc/tests/python/test_usdt2.py)
> 
<snip>
> 
> Allocated by task 870:
>  kasan_kmalloc+0xa0/0xd0
>  kmem_cache_alloc_node+0x11a/0x430
>  copy_process.part.19+0x11a0/0x41c0
>  _do_fork+0x1be/0xa20
>  do_syscall_64+0x198/0x490
>  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> 
> Freed by task 0:
>  __kasan_slab_free+0x12e/0x180
>  kmem_cache_free+0x102/0x4d0
>  free_task+0xfe/0x160
>  __put_task_struct+0x189/0x290
>  delayed_put_task_struct+0x119/0x250
>  rcu_process_callbacks+0xa6c/0x1b60
>  __do_softirq+0x238/0x7ae
> 
> The buggy address belongs to the object at ffff880384f9b480
>  which belongs to the cache task_struct of size 12928
> 
> It occurs because task_struct is freed before perf_event which refers
> to the task and task flags are checked while teardown of the event.
> perf_event_alloc() assigns task_struct to hw.target of perf_event,
> but there is no reference counting for it.
> 
> As a fix we get_task_struct() in perf_event_alloc() at above mentioned
> assignment and put_task_struct() in _free_event().
> 
> Signed-off-by: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Ingo, can you make this happen, probably with a Cc-stable as well.
