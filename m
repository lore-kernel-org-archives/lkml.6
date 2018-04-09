Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbeDIKkO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:40:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750886AbeDIKkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:40:13 -0400
Date: Mon, 9 Apr 2018 12:40:10 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: uprobes/perf: KASAN: use-after-free in uprobe_perf_close
Message-ID: <20180409104010.GA22993@redhat.com>
References: <4da123ee-1ad1-fbd3-d5c0-bd9f5ed26434@lab.ntt.co.jp>
 <20180222163715.GA1485@redhat.com>
 <20180222170427.GQ25181@hirez.programming.kicks-ass.net>
 <20180222170947.GW25235@hirez.programming.kicks-ass.net>
 <20180222174041.GA2802@redhat.com>
 <35f890f7-1194-4509-a1e4-d63d1c7d22ab@lab.ntt.co.jp>
 <20180409073827.GS4082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409073827.GS4082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09, Peter Zijlstra wrote:
>
> On Tue, Mar 06, 2018 at 06:49:10PM +0900, Prashant Bhole wrote:
> > Sorry for late reply. I tried these changes. It didn't fix the problem. With
>
> He, sorry for completely forgetting about this one :/

me too, sorry Prashant,

> > these changes, the use-after-free access of task_struct occurs at
> > _free_event() for the last remaining event.

Heh, I didn't even try to compile the "patch" I sent, I am not surprised it is
not correct. But unless I forget again, I'll try to make the working version.

> > In your changes, I tried keeping get/put_task_struct() in
> > perf_alloc_context()/put_ctx() intact and The problem did not occur. Change
> > are mentioned below.
>
> Yes, I think you're right in that this is the cleanest solution; it add
> reference counting to the exact pointer we're using.

OK, agreed, lets make the minimal fix for now.

But I still think that we should (try to) remove put_task_struct() from put_ctx().

Quite possibly I missed something, but I think it only adds some confusion. Once
again, even if ctx can't go away you can't use ctx->task without TASK_TOMBSTONE
check, exactly because this task can exit. So why perf_event_context should add
another reference?

Oleg.
