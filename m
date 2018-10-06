Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4227CC67879
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C902F214C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C902F214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbeJIIIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 04:08:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbeJIIIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 04:08:31 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3B7B21479;
        Tue,  9 Oct 2018 00:54:09 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1g9gHo-0003Nv-9E; Mon, 08 Oct 2018 20:54:08 -0400
Message-Id: <20181006120125.376880240@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 06 Oct 2018 08:01:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Helsley <mhelsley@vmware.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>
Subject: [POC][RFC][PATCH 0/2 v2] PROOF OF CONCEPT: Dynamic Functions (jump functions)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Sending v2 because I updated quilt and it added back that stupid
  "Content-Disposition: inline; filename=$patch" line, messing up
  how the patches look in gmail. This should be better. ]

This is just a Proof Of Concept (POC), as I have done some "no no"s like
having x86 asm code in generic code paths, and it also needs a way of
working when an arch does not support this feature.

Background:

 During David Woodhouse's presentation on Spectre and Meltdown at Kernel
Recipes he talked about how retpolines are implemented. I haven't had time
to look at the details so I haven't given it much thought. But as he
demonstrated that it has a measurable overhead on indirect calls, I realized
how much this can affect tracepoints. Tracepoints are implemented with
indirect calls, where the code iterates over an array calling each callback
that has registered with the tracepoint.

I ran a test to see how much overhead this entails.

With RETPOLINE disabled (CONFIG_RETPOLINE=n):

# trace-cmd start -e all
# perf stat -r 10 /work/c/hackbench 50
Time: 29.369
Time: 28.998
Time: 28.816
Time: 28.734
Time: 29.034
Time: 28.631
Time: 28.594
Time: 28.762
Time: 28.915
Time: 28.741

 Performance counter stats for '/work/c/hackbench 50' (10 runs):

     232926.801609      task-clock (msec)         #    7.465 CPUs utilized            ( +-  0.26% )
         3,175,526      context-switches          #    0.014 M/sec                    ( +-  0.50% )
           394,920      cpu-migrations            #    0.002 M/sec                    ( +-  1.71% )
            44,273      page-faults               #    0.190 K/sec                    ( +-  1.06% )
   859,904,212,284      cycles                    #    3.692 GHz                      ( +-  0.26% )
   526,010,328,375      stalled-cycles-frontend   #   61.17% frontend cycles idle     ( +-  0.26% )
   799,414,387,443      instructions              #    0.93  insn per cycle
                                                  #    0.66  stalled cycles per insn  ( +-  0.25% )
   157,516,396,866      branches                  #  676.248 M/sec                    ( +-  0.25% )
       445,888,666      branch-misses             #    0.28% of all branches          ( +-  0.19% )

      31.201263687 seconds time elapsed                                          ( +-  0.24% )

With RETPOLINE enabled (CONFIG_RETPOLINE=y)

# trace-cmd start -e all
# perf stat -r 10 /work/c/hackbench 50
Time: 31.087
Time: 31.180
Time: 31.250
Time: 30.905
Time: 31.024
Time: 32.056
Time: 31.312
Time: 31.409
Time: 31.451
Time: 31.275

 Performance counter stats for '/work/c/hackbench 50' (10 runs):

     252893.216212      task-clock (msec)         #    7.444 CPUs utilized            ( +-  0.31% )
         3,218,524      context-switches          #    0.013 M/sec                    ( +-  0.45% )
           427,129      cpu-migrations            #    0.002 M/sec                    ( +-  1.52% )
            43,666      page-faults               #    0.173 K/sec                    ( +-  0.92% )
   933,615,337,142      cycles                    #    3.692 GHz                      ( +-  0.31% )
   593,141,521,286      stalled-cycles-frontend   #   63.53% frontend cycles idle     ( +-  0.32% )
   806,848,677,318      instructions              #    0.86  insn per cycle
                                                  #    0.74  stalled cycles per insn  ( +-  0.30% )
   161,289,933,342      branches                  #  637.779 M/sec                    ( +-  0.29% )
     2,070,719,044      branch-misses             #    1.28% of all branches          ( +-  0.25% )

      33.971942318 seconds time elapsed                                          ( +-  0.28% )


What the above represents, is running "hackbench 50" with all trace events
enabled, went from: 31.201263687 to: 33.971942318 to perform, which is an
8.9% increase!

So I thought about how to solve this, and came up with "jump_functions".
These are similar to jump_labels, but instead of having a static branch, we
would have a dynamic function. A function "dynfunc_X()" that can be assigned
any other function, just as if it was a variable, and have it call the new
function. Talking with other kernel developers at Kernel Recipes, I was told
that this feature would be useful for other subsystems in the kernel and not
just for tracing.

The first attempt created a call in inline assembly, and did macro tricks to
create the parameters, but this was overly complex, especially when one of
the trace events has 12 parameters!

Then I decided to simplify it to have the dynfunc_X() call a trampoline,
that does a direct jump. It's similar to what a retpoline does, but a
retpoline does an indirect jump. A direct jump is much more efficient.

When changing what function a dynamic function should call, text_poke_bp()
is used to modify the trampoline to call the new function.

The first "no change log" patch implements the dynamic function (poorly, as
its just a proof of concept), and the second "no change log" patch
implements a way that tracepoints can take advantage of it.

The tracepoints creates a "default" function that does the iteration over
the tracepoint array like it currently does. But if only a single callback
is attached to the tracepoint (the most common case), it changes the dynamic
function to call the callback directly, without any iteration over the list.

After implementing this, running the above test produced:

# trace-cmd start -e all
# perf stat -r 10 /work/c/hackbench 50
Time: 29.927
Time: 29.504
Time: 29.761
Time: 29.693
Time: 29.430
Time: 29.999
Time: 29.389
Time: 29.404
Time: 29.871
Time: 29.335

 Performance counter stats for '/work/c/hackbench 50' (10 runs):

     239377.553785      task-clock (msec)         #    7.447 CPUs utilized            ( +-  0.27% )
         3,203,640      context-switches          #    0.013 M/sec                    ( +-  0.36% )
           417,511      cpu-migrations            #    0.002 M/sec                    ( +-  1.56% )
            43,462      page-faults               #    0.182 K/sec                    ( +-  0.98% )
   883,720,553,554      cycles                    #    3.692 GHz                      ( +-  0.27% )
   553,115,449,444      stalled-cycles-frontend   #   62.59% frontend cycles idle     ( +-  0.27% )
   792,603,930,472      instructions              #    0.90  insn per cycle
                                                  #    0.70  stalled cycles per insn  ( +-  0.27% )
   159,390,986,499      branches                  #  665.856 M/sec                    ( +-  0.27% )
     1,310,355,667      branch-misses             #    0.82% of all branches          ( +-  0.18% )

      32.146081513 seconds time elapsed                                          ( +-  0.25% )

We didn't get back 100% of performance. I didn't expect to, as retpolines
will cause overhead in other areas than just tracing. But we went from
33.971942318 to 32.146081513. Instead of being 8.9% slower with retpoline
enabled, we are now just 3% slower.

I tried this patch set without RETPOLINE and had this:

# trace-cmd start -e all
# perf stat -r 10 /work/c/hackbench 50
Time: 28.830
Time: 28.457
Time: 29.078
Time: 28.606
Time: 28.377
Time: 28.629
Time: 28.642
Time: 29.005
Time: 28.513
Time: 28.357

 Performance counter stats for '/work/c/hackbench 50' (10 runs):

     231452.110483      task-clock (msec)         #    7.466 CPUs utilized            ( +-  0.28% )
         3,181,305      context-switches          #    0.014 M/sec                    ( +-  0.44% )
           393,496      cpu-migrations            #    0.002 M/sec                    ( +-  1.20% )
            43,673      page-faults               #    0.189 K/sec                    ( +-  0.61% )
   854,481,304,821      cycles                    #    3.692 GHz                      ( +-  0.28% )
   528,175,627,905      stalled-cycles-frontend   #   61.81% frontend cycles idle     ( +-  0.28% )
   787,765,717,278      instructions              #    0.92  insn per cycle
                                                  #    0.67  stalled cycles per insn  ( +-  0.28% )
   157,169,268,775      branches                  #  679.057 M/sec                    ( +-  0.27% )
       366,443,397      branch-misses             #    0.23% of all branches          ( +-  0.15% )

      31.002540109 seconds time elapsed 

Which  went from 31.201263687 to 31.002540109 which is a 0.6% speed up.
Not great, but not bad either.

Notice, there's also test code that creates some files in the debugfs
directory. There's files called: func0, func1, func2 and func3, where each
has a dynamic function associated to it with the number of parameters that
is the same as the number in the name of the file. There's three functions
that each of these dynamic functions can be change to, and echoing in "0",
"1" or "2" will update the dynamic function. Reading from the function
causes the called functions to printk() to the console to see how it worked.

Now what?

OK, for the TODO, if nobody has any issues with this, I was going to hand
this off to Matt Helsley to make this into something thats actually
presentable for inclusion.

1) We need to move the x86 specific code into x86 specific locations.

2) We need to have this work without doing the dynamic updates (for archs
that don't have this implemented). Basically, the dynamic function is going
to probably be a macro with a function pointer that does an indirect jump to
the code that is assigned to the dynamic function.

3) Write up proper change logs ;-)

And I'm sure there's more to do.

Enjoy,

-- Steve



  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
ftrace/jump_function

Head SHA1: 1a2e530e7534d82b95eaa9ddc5218c5652a60d49


Steven Rostedt (VMware) (2):
      jump_function: Addition of new feature "jump_function"
      tracepoints: Implement it with dynamic functions

----
 include/asm-generic/vmlinux.lds.h |   4 +
 include/linux/jump_function.h     |  93 ++++++++++
 include/linux/tracepoint-defs.h   |   3 +
 include/linux/tracepoint.h        |  65 ++++---
 include/trace/define_trace.h      |  14 +-
 kernel/Makefile                   |   2 +-
 kernel/jump_function.c            | 368 ++++++++++++++++++++++++++++++++++++++
 kernel/tracepoint.c               |  29 ++-
 8 files changed, 545 insertions(+), 33 deletions(-)
 create mode 100644 include/linux/jump_function.h
 create mode 100644 kernel/jump_function.c
