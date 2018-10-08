Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC77AC676D2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720A62085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720A62085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbeJHUE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:04:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44048 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbeJHUE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:04:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 01397307D84C;
        Mon,  8 Oct 2018 12:53:23 +0000 (UTC)
Received: from f28server.default (ovpn-116-135.phx2.redhat.com [10.3.116.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A6796530E;
        Mon,  8 Oct 2018 12:53:19 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
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
        Clark Williams <williams@redhat.com>
Subject: [RFC PATCH 0/6] x86/jump_label: Bound IPIs sent when updating a static key
Date:   Mon,  8 Oct 2018 14:52:59 +0200
Message-Id: <cover.1539001620.git.bristot@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 08 Oct 2018 12:53:23 +0000 (UTC)
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

Although the motivation of this patch is to reduce the noise on threads
that are *not* causing the enabling/disabling of the static key,
counter-intuitively, this patch also improves the performance of the
enabling/disabling (slow) path of the thread that is actually doing the
change. The reason being is that the costs of allocating memory/
list manipulation/freeing memory are smaller than sending IPIs.
For example, in a system with 24 CPUs, the current cost of enabling the
schedstats key is 170000-ish us, while with this patch, it decreases to
2200 -ish us.

This is an RFC, so comments and critics about things I am missing are
more than welcome.

The batch of operations was suggested by Scott Wood <swood@redhat.com>.

Daniel Bristot de Oliveira (6):
  jump_label: Add for_each_label_entry helper
  jump_label: Add the jump_label_can_update_check() helper
  x86/jump_label: Move checking code away from __jump_label_transform()
  x86/jump_label: Add __jump_label_set_jump_code() helper
  x86/alternative: Split text_poke_bp() into tree steps
  x86/jump_label,x86/alternatives: Batch jump label transformations

 arch/x86/include/asm/jump_label.h    |   2 +
 arch/x86/include/asm/text-patching.h |   9 ++
 arch/x86/kernel/alternative.c        | 115 ++++++++++++++++---
 arch/x86/kernel/jump_label.c         | 161 ++++++++++++++++++++-------
 include/linux/jump_label.h           |   8 ++
 kernel/jump_label.c                  |  46 ++++++--
 6 files changed, 273 insertions(+), 68 deletions(-)

-- 
2.17.1

