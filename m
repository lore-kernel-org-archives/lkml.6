Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E40C2F3A6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B17B20855
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfAUMxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:53:01 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35255 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbfAUMxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:53:01 -0500
Received: by mail-qt1-f195.google.com with SMTP id v11so23445966qtc.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 04:53:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6mbgL886qYFJDcp5s24yrvtogetucFEpcYX5+0cdlUg=;
        b=T2JBjmtKcaEBF42LsvBeuGwMlIXeBg9iYszs4ShQTiDLS2FHoamkrTpej1ZWabGwC+
         BJSoYB4sslHhEAwX0Q2s+p4S4BbbEp7EGQLG+KklGWHcVFn6Vic7yP+xouzQfdE/NTxk
         6EJgRVdeXOBTbIQlBnE6vFUOCb3w8/xfqdFdsR8pPtgqt7+x+udUQ7LcbLLevcyPRtU4
         Aivws0rakvcfdtSGysVisDoIbShuodwuPrC3Lm3wjakuX4k7B23sZXmmWFgQpguwUFD6
         jZecXvWcquKEi0sQGOPf/wWhnQMIMspyhfiMpzxckZwM5K0F3kOpoBrJXk5wcD6y6Y4I
         4R3w==
X-Gm-Message-State: AJcUukedAVnTeIjZWbByB4NBbLfxxRQAbDAF6OIZ2u5WWo+4Zs23mz0x
        IAahlVlnjGy4vLgZQ4+P7fUFYg==
X-Google-Smtp-Source: ALg8bN52xagSbXFTWA4JwOLKrPMtv/sxp1vnisIqeIlqBKr07UIxcuYwmwIfx3/0UXymiFFu7Gg9xA==
X-Received: by 2002:ac8:3e91:: with SMTP id y17mr27701028qtf.390.1548075179543;
        Mon, 21 Jan 2019 04:52:59 -0800 (PST)
Received: from t460s.bristot.redhat.com ([177.72.25.22])
        by smtp.gmail.com with ESMTPSA id r18sm77056717qta.83.2019.01.21.04.52.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 04:52:58 -0800 (PST)
Subject: Re: [PATCH V3 0/9] x86/jump_label: Bound IPIs sent when updating a
 static key
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
References: <cover.1545228276.git.bristot@redhat.com>
Message-ID: <83a1647b-bdcb-80e6-87ea-1919b41be8b2@redhat.com>
Date:   Mon, 21 Jan 2019 13:52:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <cover.1545228276.git.bristot@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/18 11:27 AM, Daniel Bristot de Oliveira wrote:
> While tuning a system with CPUs isolated as much as possible, we've
> noticed that isolated CPUs were receiving bursts of 12 IPIs, periodically.
> Tracing the functions that emit IPIs, we saw chronyd - an unprivileged
> process -  generating the IPIs when changing a static key, enabling
> network timestaping on sockets.
> 
> For instance, the trace pointed:
> 
> # trace-cmd record --func-stack -p function -l smp_call_function_single -e irq_vectors -f 'vector == 251'...
> # trace-cmde report...
> [...]
>          chronyd-858   [000]   433.286406: function:             smp_call_function_single
>          chronyd-858   [000]   433.286408: kernel_stack:         <stack trace>
> => smp_call_function_many (ffffffffbc10ab22)
> => smp_call_function (ffffffffbc10abaa)
> => on_each_cpu (ffffffffbc10ac0b)
> => text_poke_bp (ffffffffbc02436a)
> => arch_jump_label_transform (ffffffffbc020ec8)
> => __jump_label_update (ffffffffbc1b300f)
> => jump_label_update (ffffffffbc1b30ed)
> => static_key_slow_inc (ffffffffbc1b334d)
> => net_enable_timestamp (ffffffffbc625c44)
> => sock_enable_timestamp (ffffffffbc6127d5)
> => sock_setsockopt (ffffffffbc612d2f)
> => SyS_setsockopt (ffffffffbc60d5e6)
> => tracesys (ffffffffbc7681c5)
>           <idle>-0     [001]   433.286416: call_function_single_entry: vector=251
>           <idle>-0     [001]   433.286419: call_function_single_exit: vector=251
>   
> [... The IPI takes place 12 times]
> 
> The static key in case was the netstamp_needed_key. A static key
> change from enabled->disabled/disabled->enabled causes the code to be
> patched, and this is done in three steps:
> 
> -- Pseudo-code #1 - Current implementation ---
> For each key to be updated:
> 	1) add an int3 trap to the address that will be patched
> 	    sync cores (send IPI to all other CPUs)
> 	2) update all but the first byte of the patched range
> 	    sync cores (send IPI to all other CPUs)
> 	3) replace the first byte (int3) by the first byte of replacing opcode 
> 	    sync cores (send IPI to all other CPUs)
> -- Pseudo-code #1 ---
> 
> As the static key netstamp_needed_key has four entries (used in for
> places in the code) in our kernel, 3 IPIs were generated for each
> entry, resulting in 12 IPIs. The number of IPIs then is linear with
> regard to the number 'n' of entries of a key: O(n*3), which is O(n).
> 
> This algorithm works fine for the update of a single key. But we think
> it is possible to optimize the case in which a static key has more than
> one entry. For instance, the sched_schedstats jump label has 56 entries
> in my (updated) fedora kernel, resulting in 168 IPIs for each CPU in
> which the thread that is enabling is _not_ running.
> 
> Rather than doing each updated at once, it is possible to queue all updates
> first, and then apply all updates at once, rewriting the pseudo-code #1
> in this way:
> 
> -- Pseudo-code #2 - proposal  ---
> 1)  for each key in the queue:
>         add an int3 trap to the address that will be patched
>     sync cores (send IPI to all other CPUs)
> 
> 2)  for each key in the queue:
>         update all but the first byte of the patched range
>     sync cores (send IPI to all other CPUs)
> 
> 3)  for each key in the queue:
>         replace the first byte (int3) by the first byte of replacing opcode 
>     sync cores (send IPI to all other CPUs)
> -- Pseudo-code #2 - proposal  ---
> 
> Doing the update in this way, the number of IPI becomes O(3) with regard
> to the number of keys, which is O(1).
> 
> Currently, the jump label of a static key is transformed via the arch
> specific function:
> 
>     void arch_jump_label_transform(struct jump_entry *entry,
>                                    enum jump_label_type type)
> 
> The new approach (batch mode) uses two arch functions, the first has the
> same arguments of the arch_jump_label_transform(), and is the function:
> 
>     void arch_jump_label_transform_queue(struct jump_entry *entry,
>                          enum jump_label_type type)
> 
> Rather than transforming the code, it adds the jump_entry in a queue of
> entries to be updated.
> 
> After queuing all jump_entries, the function:
>   
>     void arch_jump_label_transform_apply(void)
> 
> Applies the changes in the queue.
> 
> One easy way to see the benefits of this patch is switching the
> schedstats on and off. For instance:
> 
> -------------------------- %< ---------------------------- 
> #!/bin/bash
> 
> while [ true ]; do 
>     sysctl -w kernel.sched_schedstats=1
>     sleep 2
>     sysctl -w kernel.sched_schedstats=0
>     sleep 2
> done
> -------------------------- >% ----------------------------
> 
> while watching the IPI count:
> 
> -------------------------- %< ---------------------------- 
> # watch -n1 "cat /proc/interrupts | grep Function"
> -------------------------- >% ----------------------------
> 
> With the current mode, it is possible to see +- 168 IPIs each 2 seconds,
> while with the batch mode the number of IPIs goes to 3 each 2 seconds.
> 
> Regarding the performance impact of this patch set, I made two measurements:
> 
>     The time to update a key (the task that is causing the change)
>     The time to run the int3 handler (the side effect on a thread that
>                                       hits the code being changed)
> 
> The sched_schedstats static key was chosen as the key to being switched on and
> off. The reason being is that it is used in more than 56 places, in a hot path.
> The change in the schedstats static key will be done with the following
> command:
> 
> while [ true ]; do
>     sysctl -w kernel.sched_schedstats=1
>     usleep 500000
>     sysctl -w kernel.sched_schedstats=0
>     usleep 500000
> done
> 
> In this way, they key will be updated twice per second. To force the hit of the
> int3 handler, the system will also run a kernel compilation with two jobs per
> CPU. The test machine is a two nodes/24 CPUs box with an Intel Xeon processor
> @2.27GHz.
> 
> Regarding the update part, on average, the regular kernel takes 57 ms to update
> the static key, while the kernel with the batch updates takes just 1.4 ms on
> average. Although it seems to be too good to be true, it makes sense: the
> sched_schedstats key is used in 56 places, so it was expected that it would take
> around 56 times to update the keys with the current implementation, as the
> IPIs are the most expensive part of the update.
> 
> Regarding the int3 handler, the non-batch handler takes 45 ns on average, while
> the batch version takes around 180 ns. At first glance, it seems to be a high
> value. But it is not, considering that it is doing 56 updates, rather than one!
> It is taking four times more, only. This gain is possible because the patch
> uses a binary search in the vector: log2(56)=5.8. So, it was expected to have
> an overhead within four times.
> 
> (voice of tv propaganda) But, that is not all! As the int3 handler keeps on for
> a shorter period (because the update part is on for a shorter time), the number
> of hits in the int3 handler decreased by 10%.
> 
> The question then is: Is it worth paying the price of "135 ns" more in the int3
> handler?
> 
> Considering that, in this test case, we are saving the handling of 53 IPIs,
> that takes more than these 135 ns, it seems to be a meager price to be paid.
> Moreover, the test case was forcing the hit of the int3, in practice, it
> does not take that often. While the IPI takes place on all CPUs, hitting
> the int3 handler or not!
> 
> For instance, in an isolated CPU with a process running in user-space
> (nohz_full use-case), the chances of hitting the int3 handler is barely zero,
> while there is no way to avoid the IPIs. By bounding the IPIs, we are improving
> this scenario a lot.
> 
> Changes from v2:
>   - Switch the order of patches 8 and 9 (Steven Rostedt)
>   - Fallback in the case of failure in the batch mode (Steven Rostedt)
>   - Fix a pointer in patch 7 (Steven Rostedt)
>   - Adjust the commit log of the patch 1 (Borislav Petkov)
>   - Adjust the commit log of the patch 3 (Jiri Kosina/Thomas Gleixner)
> Changes from v1:
>   - Split the patch in jump-label/x86-jump-label/alternative (Jason Baron)
>   - Use bserach in the int3 handler (Steven Rostedt)
>   - Use a pre-allocated page to store the vector (Jason/Steven)
>   - Do performance tests in the int3 handler (peterz)
> 
> Daniel Bristot de Oliveira (9):
>   jump_label: Add for_each_label_entry helper
>   jump_label: Add the jump_label_can_update_check() helper
>   x86/jump_label: Move checking code away from __jump_label_transform()
>   x86/jump_label: Add __jump_label_set_jump_code() helper
>   x86/alternative: Split text_poke_bp() into tree steps
>   jump_label: Sort entries of the same key by the code
>   x86/alternative: Batch of patch operations
>   jump_label: Batch updates if arch supports it
>   x86/jump_label: Batch jump label updates
> 
>  arch/x86/include/asm/jump_label.h    |   2 +
>  arch/x86/include/asm/text-patching.h |  15 +++
>  arch/x86/kernel/alternative.c        | 140 ++++++++++++++++++---
>  arch/x86/kernel/jump_label.c         | 174 ++++++++++++++++++++++-----
>  include/linux/jump_label.h           |   6 +
>  kernel/jump_label.c                  |  73 +++++++++--
>  6 files changed, 359 insertions(+), 51 deletions(-)
> 

Hi,

This is just a gentle ping...  Any thoughts about this patch series?

Thanks!
-- Daniel
