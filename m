Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756699AbeDZQ2U (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:28:20 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:43032 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754553AbeDZQ2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:28:19 -0400
X-Google-Smtp-Source: AIpwx488iuu0Bxjtz7ndbUPstpquKdD3Wfa2WLYAJzHtYPcMvcjBPyU8xYhZjCIIk5ulLol+BCMcuw==
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: jannh@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: random: GFP_KERNEL from irq context
Message-ID: <c10e7248-4463-59d4-a977-1e4433c7231f@kernel.dk>
Date: Thu, 26 Apr 2018 10:28:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

Just triggered this on my test box:

[   16.992068] BUG: sleeping function called from invalid context at mm/slab.h:421
[   17.001136] in_atomic(): 1, irqs_disabled(): 1, pid: 0, name: swapper/30
[   17.009116] CPU: 30 PID: 0 Comm: swapper/30 Not tainted 4.17.0-rc2+ #665
[   17.017092] Hardware name: Dell Inc. PowerEdge T630/0NT78X, BIOS 2.3.4 11/09/2016
[   17.026354] Call Trace:
[   17.029573]  <IRQ>
[   17.032318]  dump_stack+0x46/0x5b
[   17.036509]  ___might_sleep+0xd5/0x110
[   17.041189]  __kmalloc+0x166/0x1f0
[   17.045486]  crng_reseed+0x10c/0x2f0
[   17.049965]  ? add_interrupt_randomness+0x161/0x1e0
[   17.055903]  credit_entropy_bits+0x272/0x280
[   17.061163]  add_interrupt_randomness+0x161/0x1e0
[   17.066905]  handle_irq_event_percpu+0x2e/0x50
[   17.072362]  handle_irq_event+0x34/0x60
[   17.077222]  handle_edge_irq+0x71/0x180
[   17.081996]  handle_irq+0xa5/0x110
[   17.086286]  do_IRQ+0x41/0xc0
[   17.090091]  common_interrupt+0xf/0xf
[   17.094670]  </IRQ>
[   17.097501] RIP: 0010:cpuidle_enter_state+0x9f/0x2d0
[   17.103533] RSP: 0018:ffff880101747ed0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffde
[   17.112900] RAX: ffff881fffbe0f80 RBX: 00000003f4cdab59 RCX: 000000000000001f
[   17.121364] RDX: 20c49ba5e353f7cf RSI: 000000003a3fcf2c RDI: 0000000000000000
[   17.129829] RBP: 0000000000000002 R08: 0000000000000e7d R09: 0000004d7a7575c0
[   17.138292] R10: ffff880101747eb8 R11: 000000000000002d R12: ffff883ffb1e2c00
[   17.146760] R13: ffffffff820cc818 R14: 0000000000000000 R15: 00000003d7b784fc
[   17.155227]  do_idle+0x1b6/0x200
[   17.159321]  cpu_startup_entry+0x19/0x20
[   17.164191]  secondary_startup_64+0xa5/0xb0
[   17.169382] random: crng init done

during boot. We end up doing the numa_crng_init() from interrupt context, which
makes things unhappy since you do GFP_KERNEL | __GFP_NOFAIL allocations from
there. This was caused by:

commit 8ef35c866f8862df074a49a93b0309725812dea8
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Wed Apr 11 15:23:56 2018 -0400

    random: set up the NUMA crng instances after the CRNG is fully initialized
    
I was going to send the trivial GFP_KERNEL -> GFP_ATOMIC patch, but with the
__GFP_NOFAIL, that's kind of tricky. We can't feasibly do init from when we
add randomness, if you want it to be a NOFAIL kind of thing.

-- 
Jens Axboe
