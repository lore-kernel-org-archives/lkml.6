Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B084DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7714F21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeLRQrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:47:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbeLRQrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:47:09 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B3BC267DB;
        Tue, 18 Dec 2018 16:47:08 +0000 (UTC)
Received: from f28server.default (ovpn-116-118.phx2.redhat.com [10.3.116.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BA0A6596E;
        Tue, 18 Dec 2018 16:46:40 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Zhou Chengming <zhouchengming1@huawei.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: [PATCH V2 0/9] x86/jump_label: Bound IPIs sent when updating a static key
Date:   Tue, 18 Dec 2018 17:46:29 +0100
Message-Id: <cover.1545149539.git.bristot@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 18 Dec 2018 16:47:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While tuning a system with CPUs isolated as much as possible, we've
noticed that isolated CPUs were receiving bursts of 12 IPIs, periodically.
Tracing the functions that emit IPIs, we saw chronyd - an unprivileged
process -  generating the IPIs when changing a static key, enabling
network timestaping on sockets.

For instance, the trace pointed:

# trace-cmd record --func-stack -p function -l smp_call_function_single -e irq_vectors -f 'vector == 251'...
# trace-cmde report...
[...]
         chronyd-858   [000]   433.286406: function:             smp_call_function_single
         chronyd-858   [000]   433.286408: kernel_stack:         <stack trace>
=> smp_call_function_many (ffffffffbc10ab22)
=> smp_call_function (ffffffffbc10abaa)
=> on_each_cpu (ffffffffbc10ac0b)
=> text_poke_bp (ffffffffbc02436a)
=> arch_jump_label_transform (ffffffffbc020ec8)
=> __jump_label_update (ffffffffbc1b300f)
=> jump_label_update (ffffffffbc1b30ed)
=> static_key_slow_inc (ffffffffbc1b334d)
=> net_enable_timestamp (ffffffffbc625c44)
=> sock_enable_timestamp (ffffffffbc6127d5)
=> sock_setsockopt (ffffffffbc612d2f)
=> SyS_setsockopt (ffffffffbc60d5e6)
=> tracesys (ffffffffbc7681c5)
          <idle>-0     [001]   433.286416: call_function_single_entry: vector=251
          <idle>-0     [001]   433.286419: call_function_single_exit: vector=251
  
[... The IPI takes place 12 times]

The static key in case was the netstamp_needed_key. A static key
change from enabled->disabled/disabled->enabled causes the code to be
changed, and this is done in three steps:

-- Pseudo-code #1 - Current implementation ---
For each key to be updated:
	1) add an int3 trap to the address that will be patched
	    sync cores (send IPI to all other CPUs)
	2) update all but the first byte of the patched range
	    sync cores (send IPI to all other CPUs)
	3) replace the first byte (int3) by the first byte of replacing opcode 
	    sync cores (send IPI to all other CPUs)
-- Pseudo-code #1 ---

As the static key netstamp_needed_key has four entries (used in for
places in the code) in our kernel, 3 IPIs were generated for each
entry, resulting in 12 IPIs. The number of IPIs then is linear with
regard to the number 'n' of entries of a key: O(n*3), which is O(n).

This algorithm works fine for the update of a single key. But we think
it is possible to optimize the case in which a static key has more than
one entry. For instance, the sched_schedstats jump label has 56 entries
in my (updated) fedora kernel, resulting in 168 IPIs for each CPU in
which the thread that is enabling is _not_ running.

In this patch, rather than doing each updated at once, it is possible to
queue all updates first, and the, apply all updates at once, rewriting
the pseudo-code #1 in this way:

-- Pseudo-code #2 - This patch  ---
1)  for each key in the queue:
        add an int3 trap to the address that will be patched
    sync cores (send IPI to all other CPUs)

2)  for each key in the queue:
        update all but the first byte of the patched range
    sync cores (send IPI to all other CPUs)

3)  for each key in the queue:
        replace the first byte (int3) by the first byte of replacing opcode 
    sync cores (send IPI to all other CPUs)
-- Pseudo-code #2 - This patch  ---

Doing the update in this way, the number of IPI becomes O(3) with regard
to the number of keys, which is O(1).

Currently, the jump label of a static key is transformed via the arch
specific function:

    void arch_jump_label_transform(struct jump_entry *entry,
                                   enum jump_label_type type)

The new approach (batch mode) uses two arch functions, the first has the
same arguments of the arch_jump_label_transform(), and is the function:

    void arch_jump_label_transform_queue(struct jump_entry *entry,
                         enum jump_label_type type)

Rather than transforming the code, it adds the jump_entry in a queue of
entries to be updated.

After queuing all jump_entries, the function:
  
    void arch_jump_label_transform_apply(void)

Applies the changes in the queue.

One easy way to see the benefits of this patch is switching the
schedstats on and off. For instance:

-------------------------- %< ---------------------------- 
#!/bin/bash

while [ true ]; do 
    sysctl -w kernel.sched_schedstats=1
    sleep 2
    sysctl -w kernel.sched_schedstats=0
    sleep 2
done
-------------------------- >% ----------------------------

while watching the IPI count:

-------------------------- %< ---------------------------- 
# watch -n1 "cat /proc/interrupts | grep Function"
-------------------------- >% ----------------------------

With the current mode, it is possible to see +- 168 IPIs each 2 seconds,
while with this patch the number of IPIs goes to 3 each 2 seconds.

Regarding the performance impact of this patch set, I made two measurements:

    The time to update a key (the task that is causing the change)
    The time to run the int3 handler (the side effect on a thread that
                                      hits the code being changed)

The schedstats static key was chosen as the key to being switched on and off.
The reason being is that it is used in more than 56 places, in a hot path. The
change in the schedstats static key will be done with the following command:

while [ true ]; do
    sysctl -w kernel.sched_schedstats=1
    usleep 500000
    sysctl -w kernel.sched_schedstats=0
    usleep 500000
done

In this way, they key will be updated twice per second. To force the hit of the
int3 handler, the system will also run a kernel compilation with two jobs per
CPU. The test machine is a two nodes/24 CPUs box with an Intel Xeon processor
@2.27GHz.

Regarding the update part, on average, the regular kernel takes 57 ms to update
the schedstats key, while the kernel with the batch updates takes just 1.4 ms
on average. Although it seems to be too good to be true, it makes sense: the
schedstats key is used in 56 places, so it was expected that it would take
around 56 times to update the keys with the current implementation, as the
IPIs are the most expensive part of the update.

Regarding the int3 handler, the non-batch handler takes 45 ns on average, while
the batch version takes around 180 ns. At first glance, it seems to be a high
value. But it is not, considering that it is doing 56 updates, rather than one!
It is taking four times more, only. This gain is possible because the patch
uses a binary search in the vector: log2(56)=5.8. So, it was expected to have
an overhead within four times.

(voice of tv propaganda) But, that is not all! As the int3 handler keeps on for
a shorter period (because the update part is on for a shorter time), the number
of hits in the int3 handler decreased by 10%.

The question then is: Is it worth paying the price of "135 ns" more in the int3
handler?

Considering that, in this test case, we are saving the handling of 53 IPIs,
that takes more than these 135 ns, it seems to be a meager price to be paid.
Moreover, the test case was forcing the hit of the int3, in practice, it
does not take that often. While the IPI takes place on all CPUs, hitting
the int3 handler or not!

For instance, in an isolated CPU with a process running in user-space
(nohz_full use-case), the chances of hitting the int3 handler is barely zero,
while there is no way to avoid the IPIs. By bounding the IPIs, we are improving
a lot this scenario.

Changes from v1:
- Split the patch in jump-label/x86-jump-label/alternative (Jason Baron)
- Use bserach in the int3 handler (Steven Rostedt)
- Use a pre-allocated page to store the vector (Jason/Steven)
- Do performance tests in the int3 handler (peterz)

Daniel Bristot de Oliveira (9):
  jump_label: Add for_each_label_entry helper
  jump_label: Add the jump_label_can_update_check() helper
  x86/jump_label: Move checking code away from __jump_label_transform()
  x86/jump_label: Add __jump_label_set_jump_code() helper
  x86/alternative: Split text_poke_bp() into tree steps
  jump_label: Sort entries of the same key by the code
  x86/alternative: Batch of patch operations
  x86/jump_label: Batch jump label updates
  jump_label: Batch updates if arch supports it

 arch/x86/include/asm/jump_label.h    |   2 +
 arch/x86/include/asm/text-patching.h |  15 +++
 arch/x86/kernel/alternative.c        | 140 ++++++++++++++++++---
 arch/x86/kernel/jump_label.c         | 174 ++++++++++++++++++++++-----
 include/linux/jump_label.h           |   6 +
 kernel/jump_label.c                  |  73 +++++++++--
 6 files changed, 359 insertions(+), 51 deletions(-)

-- 
2.17.1

