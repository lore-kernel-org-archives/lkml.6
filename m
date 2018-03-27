Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeC0Dgh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 23:36:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751714AbeC0Dgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 23:36:35 -0400
Subject: Re: BUG: corrupted list in remove_wait_queue
To: syzbot <syzbot+c0272972b01b872e604a@syzkaller.appspotmail.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org
References: <0000000000004822e3056827baf4@google.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3d6e49f7-2952-75bb-c58e-1ae4f935c404@redhat.com>
Date: Tue, 27 Mar 2018 11:36:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0000000000004822e3056827baf4@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年03月24日 20:32, syzbot wrote:
> syzbot has found reproducer for the following crash on upstream commit
> 99fec39e7725d091c94d1bb0242e40c8092994f6 (Fri Mar 23 22:34:18 2018 +0000)
> Merge tag 'trace-v4.16-rc4' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
> syzbot dashboard link: 
> https://syzkaller.appspot.com/bug?extid=c0272972b01b872e604a
>
> So far this crash happened 4 times on upstream.
> C reproducer is attached.
> syzkaller reproducer is attached.
> Raw console output is attached.
> .config is attached.
> compiler: gcc (GCC) 7.1.1 20170620
>
> IMPORTANT: if you fix the bug, please add the following tag to the 
> commit:
> Reported-by: syzbot+c0272972b01b872e604a@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed.
>
> list_del corruption, 0000000054a89bb5->next is LIST_POISON1 
> (00000000a63e4a19)
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:47!
> invalid opcode: 0000 [#1] SMP KASAN
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 0 PID: 4851 Comm: syzkaller762396 Not tainted 4.16.0-rc6+ #364
> Hardware name: Google Google Compute Engine/Google Compute Engine, 
> BIOS Google 01/01/2011
> RIP: 0010:__list_del_entry_valid+0xd3/0x150 lib/list_debug.c:45
> RSP: 0018:ffff8801d3ff71b8 EFLAGS: 00010086
> RAX: 000000000000004e RBX: dead000000000200 RCX: 0000000000000000
> RDX: 000000000000004e RSI: 1ffff1003a7fedec RDI: ffffed003a7fee2b
> RBP: ffff8801d3ff71d0 R08: ffff8801db227fc0 R09: 1ffff1003a7fed93
> R10: ffff8801d3ff7090 R11: 0000000000000002 R12: dead000000000100
> R13: ffff8801b6a2d458 R14: ffff8801b6a2d460 R15: ffff8801d27d1780
> FS:  0000000000000000(0000) GS:ffff8801db200000(0000) 
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000002001d000 CR3: 0000000006e22002 CR4: 00000000001606f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  __list_del_entry include/linux/list.h:117 [inline]
>  list_del include/linux/list.h:125 [inline]
>  __remove_wait_queue include/linux/wait.h:184 [inline]
>  remove_wait_queue+0x90/0x350 kernel/sched/wait.c:51
>  vhost_poll_stop+0x46/0x90 drivers/vhost/vhost.c:229
>  vhost_net_disable_vq drivers/vhost/net.c:405 [inline]
>  vhost_net_stop_vq+0x90/0x120 drivers/vhost/net.c:973
>  vhost_net_stop drivers/vhost/net.c:984 [inline]
>  vhost_net_release+0x49/0x190 drivers/vhost/net.c:1017
>  __fput+0x327/0x7e0 fs/file_table.c:209
>  ____fput+0x15/0x20 fs/file_table.c:243
>  task_work_run+0x199/0x270 kernel/task_work.c:113
>  exit_task_work include/linux/task_work.h:22 [inline]
>  do_exit+0x9bb/0x1ad0 kernel/exit.c:865
>  do_group_exit+0x149/0x400 kernel/exit.c:968
>  get_signal+0x73a/0x16d0 kernel/signal.c:2469
>  do_signal+0x90/0x1e90 arch/x86/kernel/signal.c:809
>  exit_to_usermode_loop+0x258/0x2f0 arch/x86/entry/common.c:162
>  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
>  do_syscall_64+0x6ec/0x940 arch/x86/entry/common.c:292
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x44a8e9
> RSP: 002b:00007f7ec8480da8 EFLAGS: 00000293 ORIG_RAX: 0000000000000010
> RAX: 0000000000000000 RBX: 00000000006e29e4 RCX: 000000000044a8e9
> RDX: 0000000020000340 RSI: 00000000400454ca RDI: 0000000000000005
> RBP: 00000000006e29e0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 6f68762f7665642f
> R13: 6475612f7665642f R14: 74656e2f7665642f R15: 0000000000000001
> Code: 8f 00 00 00 49 8b 54 24 08 48 39 f2 75 3b 48 83 c4 08 b8 01 00 
> 00 00 5b 41 5c 5d c3 4c 89 e2 48 c7 c7 00 80 40 86 e8 85 df fb fe <0f> 
> 0b 48 c7 c7 60 80 40 86 e8 77 df fb fe 0f 0b 48 c7 c7 c0 80
> RIP: __list_del_entry_valid+0xd3/0x150 lib/list_debug.c:45 RSP: 
> ffff8801d3ff71b8
> ---[ end trace bdcbea47fcda73ff ]---
>

This is because we do not clear poll->wqh when poll fails, then a double 
free may be triggered. Will post a patch. And I suspect we need hold vq 
mutex in vhost_dev_stop().

Thanks
