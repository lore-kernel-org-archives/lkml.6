Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbeCWPN1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:13:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751479AbeCWPNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:13:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75EBC21839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180323150241.878778199@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 23 Mar 2018 11:02:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>,
        =?ISO-8859-15?q?Am=C3=A9rico=20Wang?= <xiyou.wangcong@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/3] [RFC] init, tracing: Add initcall trace events
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A while ago we had a boot tracer. But it was eventually removed:
 commit 30dbb20e68e6f ("tracing: Remove boot tracer").

The rational was because there is already a initcall_debug boot option
that causes printk()s of all the initcall functions.

The problem with the initcall_debug option is that printk() is awfully slow,
and makes it difficult to see the real impact of initcalls. Mainly because
a single printk() is usually slower than most initcall functions.

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

-- Steve
 

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
ftrace/initcall

Head SHA1: d79328aaa2173bc72c938fa6f33ff6142ad79336


Abderrahmane Benbachir (1):
      init, tracing: instrument security and console initcall trace events

Steven Rostedt (VMware) (2):
      init: Fix initcall0 name as it is "pure" not "early"
      init, tracing: Add initcall trace events

----
 include/trace/events/initcall.h | 66 +++++++++++++++++++++++++++++++++++++++++
 init/main.c                     |  9 +++++-
 kernel/printk/printk.c          |  7 ++++-
 security/security.c             |  8 ++++-
 4 files changed, 87 insertions(+), 3 deletions(-)
 create mode 100644 include/trace/events/initcall.h
