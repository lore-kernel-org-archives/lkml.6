Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fUA5HEfQGVsROQAAmS7hNA
	; Fri, 08 Jun 2018 01:10:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D18386074D; Fri,  8 Jun 2018 01:10:32 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ygqh9NbM"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id ED521602FC;
	Fri,  8 Jun 2018 01:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED521602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752625AbeFHBK3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 21:10:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752139AbeFHBK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 21:10:28 -0400
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 596F420895;
        Fri,  8 Jun 2018 01:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528420227;
        bh=8uiuNxSr2FQJftHn494Y0eFJNxexsV+atg0XWpmfUno=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ygqh9NbMxFLotrBVnfxTaLnbDbKfe8I3rvRoEFzm+owndXQ45pLlqaCyShWT3RyDJ
         uidgw5m8pZ4gju+aomJAyE1pcSwWvfP9m6kk1yhyGN5cfofQl9qdVY2+ijxhtYPGwV
         yMon2FjUPhBEbeSMmbil90/6nm3tBOh82trtf9Fo=
Date: Fri, 8 Jun 2018 10:10:23 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: oleg@redhat.com, srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH 0/7] Uprobes: Support SDT markers having reference count
 (semaphore)
Message-Id: <20180608101023.cbf20db485026213d490cb7c@kernel.org>
In-Reply-To: <20180606083344.31320-1-ravi.bangoria@linux.ibm.com>
References: <20180606083344.31320-1-ravi.bangoria@linux.ibm.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Jun 2018 14:03:37 +0530
Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:

> Why RFC again:
> 
> This series is different from earlier versions[1]. Earlier series
> implemented this feature in trace_uprobe while this has implemented
> the logic in core uprobe. Few reasons for this:
>  1. One of the major reason was the deadlock between uprobe_lock and
>  mm->mmap inside trace_uprobe_mmap(). That deadlock was not easy to fix
>  because mm->mmap is not in control of trace_uprobe_mmap() and it has
>  to take uprobe_lock to loop over trace_uprobe list. More details can
>  be found at[2]. With this new approach, there are no deadlocks found
>  so far.
>  2. Many of the core uprobe function and data-structures needs to be
>  exported to make earlier implementation simple. With this new approach,
>  reference counter logic is been implemented in core uprobe and thus
>  no need to export anything.

I agree with you. Moreover, since uprobe_register/unregister() are
exported to modules, this enablement would better be implemented
inside uprobe so that all uprobe users benefit from this.

> 
> Description:
> 
> Userspace Statically Defined Tracepoints[3] are dtrace style markers
> inside userspace applications. Applications like PostgreSQL, MySQL,
> Pthread, Perl, Python, Java, Ruby, Node.js, libvirt, QEMU, glib etc
> have these markers embedded in them. These markers are added by developer
> at important places in the code. Each marker source expands to a single
> nop instruction in the compiled code but there may be additional
> overhead for computing the marker arguments which expands to couple of
> instructions. In case the overhead is more, execution of it can be
> omitted by runtime if() condition when no one is tracing on the marker:
> 
>     if (reference_counter > 0) {
>         Execute marker instructions;
>     }
> 
> Default value of reference counter is 0. Tracer has to increment the 
> reference counter before tracing on a marker and decrement it when
> done with the tracing.
> 
> Currently, perf tool has limited supports for SDT markers. I.e. it
> can not trace markers surrounded by reference counter. Also, it's
> not easy to add reference counter logic in userspace tool like perf,
> so basic idea for this patchset is to add reference counter logic in
> the trace_uprobe infrastructure. Ex,[4]
> 
>   # cat tick.c
>     ... 
>     for (i = 0; i < 100; i++) {
> 	DTRACE_PROBE1(tick, loop1, i);
>         if (TICK_LOOP2_ENABLED()) {
>             DTRACE_PROBE1(tick, loop2, i); 
>         }
>         printf("hi: %d\n", i); 
>         sleep(1);
>     }   
>     ... 
> 
> Here tick:loop1 is marker without reference counter where as tick:loop2
> is surrounded by reference counter condition.
> 
>   # perf buildid-cache --add /tmp/tick
>   # perf probe sdt_tick:loop1
>   # perf probe sdt_tick:loop2
> 
>   # perf stat -e sdt_tick:loop1,sdt_tick:loop2 -- /tmp/tick
>   hi: 0
>   hi: 1
>   hi: 2
>   ^C
>   Performance counter stats for '/tmp/tick':
>              3      sdt_tick:loop1
>              0      sdt_tick:loop2
>      2.747086086 seconds time elapsed
> 
> Perf failed to record data for tick:loop2. Same experiment with this
> patch series:
> 
>   # ./perf buildid-cache --add /tmp/tick
>   # ./perf probe sdt_tick:loop2
>   # ./perf stat -e sdt_tick:loop2 /tmp/tick
>     hi: 0
>     hi: 1
>     hi: 2
>     ^C  
>      Performance counter stats for '/tmp/tick':
>                  3      sdt_tick:loop2
>        2.561851452 seconds time elapsed
> 
> 
> Note:
>  - 'reference counter' is called as 'semaphore' in original Dtrace
>    (or Systemtap, bcc and even in ELF) documentation and code. But the 
>    term 'semaphore' is misleading in this context. This is just a counter
>    used to hold number of tracers tracing on a marker. This is not haeally
>    used for any synchronization. So we are referring it as 'reference
>    counter' in kernel / perf code.

+1. I like this "reference counter" term :)

>  - This patches still has one issue. If there are multiple instances of
>    same application running and user wants to trace any particular
>    instance, trace_uprobe is updating reference counter in all instances.
>    This is not a problem on user side because instruction is not replaced
>    with trap/int3 and thus user will only see samples from his interested
>    process. But still this is more of a correctness issue. I'm working on
>    a fix for this.

Hmm, it sounds like not a correctness issue, but there maybe a performace
tradeoff. Tracing one particulear instance, other instances also will get
a performance loss (Only if the parameter preparation block is heavy,
because the heaviest part of probing - trap/int3 and recording data - isn't
executed.)

BTW, why this happens? I thought the refcounter part is just a data which
is not shared among processes...

Thank you,


> 
> [1] https://lkml.org/lkml/2018/4/17/23
> [2] https://lkml.org/lkml/2018/5/25/111
> [3] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
> [4] https://github.com/iovisor/bcc/issues/327#issuecomment-200576506
> 
> Ravi Bangoria (7):
>   Uprobes: Simplify uprobe_register() body
>   Uprobes: Support SDT markers having reference count (semaphore)
>   Uprobes/sdt: Fix multiple update of same reference counter
>   trace_uprobe/sdt: Prevent multiple reference counter for same uprobe
>   Uprobes/sdt: Prevent multiple reference counter for same uprobe
>   Uprobes/sdt: Document about reference counter
>   perf probe: Support SDT markers having reference counter (semaphore)
> 
>  Documentation/trace/uprobetracer.rst |  16 +-
>  include/linux/uprobes.h              |   5 +
>  kernel/events/uprobes.c              | 502 +++++++++++++++++++++++++++++++----
>  kernel/trace/trace.c                 |   2 +-
>  kernel/trace/trace_uprobe.c          |  74 +++++-
>  tools/perf/util/probe-event.c        |  39 ++-
>  tools/perf/util/probe-event.h        |   1 +
>  tools/perf/util/probe-file.c         |  34 ++-
>  tools/perf/util/probe-file.h         |   1 +
>  tools/perf/util/symbol-elf.c         |  46 +++-
>  tools/perf/util/symbol.h             |   7 +
>  11 files changed, 643 insertions(+), 84 deletions(-)
> 
> -- 
> 1.8.3.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
