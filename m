Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbeAaDwJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 22:52:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:57879 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752602AbeAaDwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 22:52:07 -0500
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 free_pipe_info
To: Eric Biggers <ebiggers3@gmail.com>,
        syzbot
        <bot+5ab8ca10883711feb5930f80d18be7f8f8a732c6@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <001a1144a1ee0f02720560ad6674@google.com>
 <20180130221350.zu2i4vcymkf6at4d@gmail.com>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Message-ID: <c45874bc-3eaf-c268-efbf-61a2a35e9c5c@suse.de>
Date: Tue, 30 Jan 2018 21:52:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180130221350.zu2i4vcymkf6at4d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/30/2018 04:13 PM, Eric Biggers wrote:
> On Tue, Dec 19, 2017 at 12:39:01AM -0800, syzbot wrote:
>> Hello,
>>
>> syzkaller hit the following crash on
>> 6084b576dca2e898f5c101baef151f7bfdbb606d
>> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
>> compiler: gcc (GCC) 7.1.1 20170620
>> .config is attached
>> Raw console output is attached.
>>
>> Unfortunately, I don't have any reproducer for this bug yet.
>>
>>
>> BUG: unable to handle kernel NULL pointer dereference at 000000000000002f
>> IP: pipe_buf_release include/linux/pipe_fs_i.h:136 [inline]
>> IP: free_pipe_info+0x75/0xd0 fs/pipe.c:674
>> PGD 1e069b067 P4D 1e069b067 PUD 1e0d7f067 PMD 0
>> Oops: 0000 [#1] SMP
>> Dumping ftrace buffer:
>>    (ftrace buffer empty)
>> Modules linked in:
>> CPU: 1 PID: 11658 Comm: syz-executor4 Not tainted 4.15.0-rc3-next-20171214+
>> #67
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> RIP: 0010:pipe_buf_release include/linux/pipe_fs_i.h:136 [inline]
>> RIP: 0010:free_pipe_info+0x75/0xd0 fs/pipe.c:674
>> RSP: 0018:ffffc90000e27ba8 EFLAGS: 00010293
>> RAX: ffff8801dfa7e500 RBX: ffff8801dac70200 RCX: ffffffff81414817
>> RDX: 0000000000000000 RSI: ffff8802156b6800 RDI: ffff8801dac70200
>> RBP: ffffc90000e27bc8 R08: 0000000000000001 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>> R13: ffff8802156b6800 R14: 000000000000001f R15: ffff880213d99820
>> FS:  00007f81f5ada700(0000) GS:ffff88021fd00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 000000000000002f CR3: 00000001e05cc000 CR4: 00000000001426e0
>> Call Trace:
>>  put_pipe_info+0x65/0x80 fs/pipe.c:561
>>  pipe_release+0xda/0x110 fs/pipe.c:582
>>  __fput+0x120/0x270 fs/file_table.c:209
>>  ____fput+0x15/0x20 fs/file_table.c:243
>>  task_work_run+0xa3/0xe0 kernel/task_work.c:113
>>  exit_task_work include/linux/task_work.h:22 [inline]
>>  do_exit+0x3e6/0x1050 kernel/exit.c:869
>>  do_group_exit+0x60/0x100 kernel/exit.c:972
>>  get_signal+0x36c/0xad0 kernel/signal.c:2337
>>  do_signal+0x23/0x670 arch/x86/kernel/signal.c:809
>>  exit_to_usermode_loop+0x13c/0x160 arch/x86/entry/common.c:161
>>  prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
>>  syscall_return_slowpath+0x1b4/0x1e0 arch/x86/entry/common.c:264
>>  entry_SYSCALL_64_fastpath+0x94/0x96
>> RIP: 0033:0x452a39
>> RSP: 002b:00007f81f5ad9ce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
>> RAX: fffffffffffffe00 RBX: 00000000007581b8 RCX: 0000000000452a39
>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000007581b8
>> RBP: 00000000007581b8 R08: 000000000000001a R09: 0000000000758190
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> R13: 0000000000a6f7ff R14: 00007f81f5ada9c0 R15: 000000000000000e
>> Code: 48 8d 14 80 48 8b 83 08 01 00 00 4c 8d 2c d0 4d 8b 75 10 4d 85 f6 74
>> 17 e8 29 5b ea ff 49 c7 45 10 00 00 00 00 4c 89 ee 48 89 df <41> ff 56 10 e8
>> 12 5b ea ff 41 83 c4 01 44 39 a3 d0 00 00 00 77
>> RIP: pipe_buf_release include/linux/pipe_fs_i.h:136 [inline] RSP:
>> ffffc90000e27ba8
>> RIP: free_pipe_info+0x75/0xd0 fs/pipe.c:674 RSP: ffffc90000e27ba8
>> CR2: 000000000000002f
>> ---[ end trace 7ae396f579301f25 ]---
> 
> Invalidating this bug since it hasn't been seen again, and it was reported while
> KASAN was accidentally disabled in the syzbot kconfig due to a change to the
> kconfig menus in linux-next (so this crash was possibly caused by slab
> corruption elsewhere).
> 

This crash looks similar to the ones discussed in
https://lkml.org/lkml/2017/10/30/780

If this can be reproduced, please share how.


-- 
Goldwyn
