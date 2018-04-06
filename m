Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbeDFTNj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 15:13:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750807AbeDFTNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 15:13:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0798520CAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180406190854.875810797@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 06 Apr 2018 15:08:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Subject: [PATCH 0/4 v2] init, tracing: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A while ago we had a boot tracer. But it was eventually removed:
 commit 30dbb20e68e6f ("tracing: Remove boot tracer").

The rationale was because there is already a initcall_debug boot option
that causes printk()s of all the initcall functions.

The problem with the initcall_debug option is that printk() is awfully slow,
and makes it difficult to see the real impact of initcalls. Mainly because
a single printk() is usually slower than most initcall functions.
Yes the timings are done within the printks, but it slows down the
boot up tremendously. Tracing can do the same without needing to
slow down boot up.

Instead of bringing back the boot tracer, adding trace events around the
initcall functions, and even one to denote which level the initcall
functions are being called from, adds the necessary information to
analyze the initcalls without the high overhead of printk()s, that
can substantially slow down the boot process.

Another positive, is that the console initcall functions themselves
can also be traced. The timestamps are not operational at that time
but you can see which consoles are being registered. I saw this on
one of my test boxes:

<idle>-0     [000] ...1     0.000000: initcall_level: level=console
<idle>-0     [000] ...1     0.000000: initcall_start: func=con_init+0x0/0x224
<idle>-0     [000] ...1     0.000000: initcall_finish: func=con_init+0x0/0x224 ret=0
<idle>-0     [000] ...1     0.000000: initcall_start: func=hvc_console_init+0x0/0x19
<idle>-0     [000] ...1     0.000000: initcall_finish: func=hvc_console_init+0x0/0x19 ret=0
<idle>-0     [000] ...1     0.000000: initcall_start: func=xen_cons_init+0x0/0x60
<idle>-0     [000] ...1     0.000000: initcall_finish: func=xen_cons_init+0x0/0x60 ret=0
<idle>-0     [000] ...1     0.000000: initcall_start: func=univ8250_console_init+0x0/0x2d
<idle>-0     [000] ...1     0.000000: initcall_finish: func=univ8250_console_init+0x0/0x2d ret=0

I didn't even realize that I had some of those consoles configured.

Anyone have any issues with me adding this?

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
ftrace/core

Head SHA1: 7af49b07cb525d36a916b841dc9329c187789e1f


Abderrahmane Benbachir (1):
      init, tracing: instrument security and console initcall trace events

Steven Rostedt (VMware) (3):
      init, tracing: Add initcall trace events
      init, tracing: Have printk come through the trace events for initcall_debug
      init: Have initcall_debug still work without CONFIG_TRACEPOINTS

----
Changes since v1:

  Added the last patch that makes initcall_debug work even when
  TRACEPOINTS is not configured. It just goes back to the old
  method (with if statements, instead of hooking into trace_events).

 include/trace/events/initcall.h | 66 ++++++++++++++++++++++++++++++++++
 init/main.c                     | 78 ++++++++++++++++++++++++++++++++---------
 kernel/printk/printk.c          |  7 +++-
 security/security.c             |  8 ++++-
 4 files changed, 141 insertions(+), 18 deletions(-)
 create mode 100644 include/trace/events/initcall.h
