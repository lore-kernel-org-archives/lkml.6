Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbeBLRAV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:00:21 -0500
Received: from www62.your-server.de ([213.133.104.62]:45130 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbeBLRAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:00:19 -0500
Subject: Re: lost connection to test machine (4)
To: dennisszhou@gmail.com
Cc: Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+adb03f3f0bb57ce3acda@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com,
        tj@kernel.org
References: <001a113f8734783e94056505f8fd@google.com>
 <CACT4Y+ZBHw7VZBFOeqLmrpmzgn4owW88qvP5v=xnr9966hbM_Q@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <00c45ca8-305d-1818-e974-a9903c8494b8@iogearbox.net>
Date: Mon, 12 Feb 2018 18:00:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZBHw7VZBFOeqLmrpmzgn4owW88qvP5v=xnr9966hbM_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018 05:03 PM, Dmitry Vyukov wrote:
> On Mon, Feb 12, 2018 at 5:00 PM, syzbot
> <syzbot+adb03f3f0bb57ce3acda@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot hit the following crash on bpf-next commit
>> 617aebe6a97efa539cc4b8a52adccd89596e6be0 (Sun Feb 4 00:25:42 2018 +0000)
>> Merge tag 'usercopy-v4.16-rc1' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
>>
>> So far this crash happened 898 times on bpf-next, net-next, upstream.
>> C reproducer is attached.
>> syzkaller reproducer is attached.
>> Raw console output is attached.
>> compiler: gcc (GCC) 7.1.1 20170620
>> .config is attached.
> 
> The reproducer first causes several tasks spending minutes at this stack:
> 
> [  110.762189] NMI backtrace for cpu 2
> [  110.762206] CPU: 2 PID: 3760 Comm: syz-executor Not tainted 4.15.0+ #96
> [  110.762210] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS Bochs 01/01/2011
> [  110.762224] RIP: 0010:mutex_spin_on_owner+0x303/0x420
> [  110.762232] INFO: NMI handler (nmi_cpu_backtrace_handler) took too
> long to run: 1.103 msecs
> [  110.762237] RSP: 0018:ffff88005be470e8 EFLAGS: 00000246
> [  110.762268] RAX: ffff88006ca00000 RBX: 0000000000000000 RCX: ffffffff81554165
> [  110.762275] RDX: 0000000000000001 RSI: 1ffffffff0d97884 RDI: 0000000000000000
> [  110.762281] RBP: ffff88005be47210 R08: dffffc0000000001 R09: fffffbfff0db2b75
> [  110.762286] R10: fffffbfff0db2b74 R11: ffffffff86d95ba7 R12: ffffffff86d95ba0
> [  110.762292] R13: ffffed000b7c8e25 R14: dffffc0000000000 R15: ffff880064691040
> [  110.762300] FS:  00007f84ed029700(0000) GS:ffff88006cb00000(0000)
> knlGS:0000000000000000
> [  110.762305] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  110.762311] CR2: 00007fd565f7b1b0 CR3: 000000005bddf002 CR4: 00000000001606e0
> [  110.762316] Call Trace:
> [  110.762383]  __mutex_lock.isra.1+0x97d/0x1440
> [  110.762659]  __mutex_lock_slowpath+0xe/0x10
> [  110.762668]  mutex_lock+0x3e/0x50
> [  110.762677]  pcpu_alloc+0x846/0xfe0
> [  110.762778]  __alloc_percpu_gfp+0x27/0x30
> [  110.762801]  array_map_alloc+0x484/0x690
> [  110.762832]  SyS_bpf+0xa27/0x4770
> [  110.763190]  do_syscall_64+0x297/0x760
> [  110.763260]  entry_SYSCALL_64_after_hwframe+0x21/0x86
> 
> and later machine dies with:
> 
> [  191.484308] Kernel panic - not syncing: Out of memory and no
> killable processes...
> [  191.484308]
> [  191.485740] CPU: 3 PID: 746 Comm: kworker/3:1 Not tainted 4.15.0+ #96
> [  191.486761] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS Bochs 01/01/2011
> [  191.488071] Workqueue: events pcpu_balance_workfn
> [  191.488821] Call Trace:
> [  191.489299]  dump_stack+0x175/0x225
> [  191.490590]  panic+0x22a/0x4be
> [  191.493061]  out_of_memory.cold.31+0x20/0x21
> [  191.496380]  __alloc_pages_slowpath+0x1d98/0x28a0
> [  191.503616]  __alloc_pages_nodemask+0x89c/0xc60
> [  191.507876]  pcpu_populate_chunk+0x1fd/0x9b0
> [  191.510114]  pcpu_balance_workfn+0x1019/0x1450
> [  191.517804]  process_one_work+0x9d5/0x1460
> [  191.522714]  worker_thread+0x1cc/0x1410
> [  191.529319]  kthread+0x304/0x3c0
> 
> The original message with attachments is here:
> https://groups.google.com/d/msg/syzkaller-bugs/Km3xEZu9zzU/rO-7XuwZAgAJ

[ +Dennis, +Tejun ]

Looks like we're stuck in percpu allocator with key/value size of 4 bytes
each and large number of entries (max_entries) in the reproducer in above
link.

Could we have some __GFP_NORETRY semantics and let allocations fail instead
of triggering OOM killer?
