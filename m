Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70D1C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611F2218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TBuKOZkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfAYR1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:27:15 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37327 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAYR1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:27:15 -0500
Received: by mail-oi1-f195.google.com with SMTP id y23so8230385oia.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 09:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=EQCV8aRXmohpkV9kIJ2uzkgquup2/7cTQhSfWbB/EwU=;
        b=TBuKOZkwB6qsx9KpPyPX7zlHZtRdmQFjnRn8xDzejgMBB7/HB/uXSLcQlc2E4uKxP9
         YAMsp3qKZSWLO21AaVcYwbiDNRJsMc2/XyDQiw9X9vMSFy1TeoXk+y46VJp6II+9lHOZ
         Pg2EuYRGGGmYgE83iIl+z4zrYQDwywF87EAdo7fkeyfwtyK7BAE3v6EXl8/PFVu2RYpF
         mkGcCbiZRHnbqCatcFUBTCmUe8aJLJKSXENSio0RvMwRwYKkCfgN2N/x8lVu04SP/9FY
         VQHJZ3YNXkpA1iU1y+/9MgRxvEDrgR51+fzQwvxGIeXhBr605JuSwri8ZI//w6Vmk/3C
         2SaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EQCV8aRXmohpkV9kIJ2uzkgquup2/7cTQhSfWbB/EwU=;
        b=T9HhIl1LWMd4m3gwqrUWCtU1WFFj3bB3iz3tB5WLn0cd5Egfsu/dLEhvqmmjKEPrMG
         /6ZfqrRSTFO8dVG43LNGTlQ0tDZveyMpZ9I4Y3cSJk8aur94pTb+n2lEPdVulBgJAwGh
         cGFUSRPmZqEPvV9MTccgS/CDcdTspp2dfKh98vXrgKfJdEQ/Dubu9WHEo5Kt9lEC9zFt
         p10KKRcUEGQCIZeQC5qiVdXz2axXjmr422aGbe6kiSz8LWnj7hNkKnHGLjEL6dj1zqVw
         1nPPcWHi3itiXxETcZg0SszarQtWGRcCMSwYwemS7uyVDRiXE/aLcQ4HXrQUvG0UeiWF
         y2aQ==
X-Gm-Message-State: AJcUukfVSvc9+SO2JmzPLj1bxbn/wNjrLUWM7QZtGLhge0EBjtxXcedd
        9+SEHeXPK2xwO6tKohigaAwb/PpTaLrVKcufIKTz7g==
X-Google-Smtp-Source: ALg8bN4aVMEPey2/GG9uy2cyV039ZrH4+kN9FYv/ulJfXviAolOGtAXmaWsVMjQZj/adF28pUatPObbFd7t4lmOigMY=
X-Received: by 2002:aca:e003:: with SMTP id x3mr1951400oig.39.1548437233412;
 Fri, 25 Jan 2019 09:27:13 -0800 (PST)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Fri, 25 Jan 2019 18:26:47 +0100
Message-ID: <CAG48ez2G8ctF8dHS42TF37pThfr3y0RNOOYTmxvACm4u8Yu3cw@mail.gmail.com>
Subject: [BUG] racy access to p->mm in membarrier_global_expedited()
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

membarrier_global_expedited() runs the following code (introduced in
commit c5f58bd58f43), protected only by an RCU read-side critical
section and the cpu_hotplug_lock:

        p = task_rcu_dereference(&cpu_rq(cpu)->curr);
        if (p && p->mm && (atomic_read(&p->mm->membarrier_state) &
                           MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
                if (!fallback)
                        __cpumask_set_cpu(cpu, tmpmask);
                else
                        smp_call_function_single(cpu, ipi_mb, NULL, 1);
        }

p->mm is not protected by either lock. This means that in theory, the
following races could occur:

1. If the compiler emitted two separate reads of ->mm, the second read
of p->mm could return a NULL pointer and crash.
2. If the mm is deallocated directly before the atomic_read() occurs,
the atomic_read() could access a freed pointer (I think?).

Neither of these are particularly likely - looking at the assembly of
a normal build, the first race doesn't exist because the compiler
optimizes the second read away, and the second race isn't going to
cause anything particularly interesting. Still, this should probably
be fixed...

As far as I can tell, you'll have to either take the task_lock()
around the "p->mm && (atomic_read(&p->mm->membarrier_state)" or add
RCU to the lifetime of mm_struct. I'm not entirely sure what the
better fix is... probably task_lock() makes more sense?


To test the bug, I patched an extra delay into the code:

====================
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 3cd8a3a795d2..69cc52039576 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -14,6 +14,7 @@
  * GNU General Public License for more details.
  */
 #include "sched.h"
+#include <linux/delay.h>

 /*
  * Bitmask made from a "or" of all commands within enum membarrier_cmd,
@@ -81,7 +82,7 @@ static int membarrier_global_expedited(void)

                rcu_read_lock();
                p = task_rcu_dereference(&cpu_rq(cpu)->curr);
-               if (p && p->mm && (atomic_read(&p->mm->membarrier_state) &
+               if (p && p->mm && (mdelay(100), 1) &&
(atomic_read(&p->mm->membarrier_state) &
                                   MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
                        if (!fallback)
                                __cpumask_set_cpu(cpu, tmpmask);
====================

On a kernel with that patch applied, I ran this test code:

====================
#define _GNU_SOURCE
#include <unistd.h>
#include <sys/syscall.h>
#include <stdio.h>
#include <linux/membarrier.h>
#include <err.h>

int main(void) {
  while (1) {
    printf("executing global expedited barrier...\n");
    int res = syscall(__NR_membarrier, MEMBARRIER_CMD_GLOBAL_EXPEDITED, 0);
    if (res) err(1, "barrier");
  }
}
====================

That resulted in this splat:

[  212.697681] ==================================================================
[  212.700582] BUG: KASAN: null-ptr-deref in
membarrier_global_expedited+0x15f/0x220
[  212.703346] Read of size 4 at addr 0000000000000378 by task barrier/1177

[  212.706384] CPU: 1 PID: 1177 Comm: barrier Not tainted 5.0.0-rc3+ #246
[  212.708925] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[  212.712263] Call Trace:
[  212.713177]  dump_stack+0x71/0xab
[  212.714375]  ? membarrier_global_expedited+0x15f/0x220
[  212.716236]  ? membarrier_global_expedited+0x15f/0x220
[  212.718099]  kasan_report+0x176/0x192
[  212.719445]  ? finish_task_switch+0x340/0x3d0
[  212.721057]  ? membarrier_global_expedited+0x15f/0x220
[  212.722921]  membarrier_global_expedited+0x15f/0x220
[  212.724696]  ? ipi_mb+0x10/0x10
[  212.725816]  ? vfs_write+0x120/0x230
[  212.727113]  ? __ia32_sys_read+0x50/0x50
[  212.728596]  __x64_sys_membarrier+0x85/0xf0
[  212.730056]  do_syscall_64+0x73/0x160
[  212.731428]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  212.733236] RIP: 0033:0x7fbe8747e229
[  212.734540] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 3f 4c 2b 00 f7 d8 64 89
01 48
[  212.741109] RSP: 002b:00007fffcb62a7c8 EFLAGS: 00000202 ORIG_RAX:
0000000000000144
[  212.743831] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fbe8747e229
[  212.746335] RDX: 00007fbe87475730 RSI: 0000000000000000 RDI: 0000000000000002
[  212.748855] RBP: 00007fffcb62a7e0 R08: 00007fffcb62a8c0 R09: 00007fffcb62a8c0
[  212.751374] R10: 00007fbe8793c700 R11: 0000000000000202 R12: 0000563ee2ac9610
[  212.753842] R13: 00007fffcb62a8c0 R14: 0000000000000000 R15: 0000000000000000
[  212.756305] ==================================================================
