Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BCFC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 10:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0203222E3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 10:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfBPKnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 05:43:55 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45866 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725966AbfBPKny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 05:43:54 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BE32B65275DF4D01F647;
        Sat, 16 Feb 2019 18:43:49 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.210) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Sat, 16 Feb 2019
 18:43:41 +0800
Subject: Re: KASAN: use-after-free Write in _free_event
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        syzbot <syzbot+a24c397a29ad22d86c98@syzkaller.appspotmail.com>,
        <acme@kernel.org>, <jolsa@redhat.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <syzkaller-bugs@googlegroups.com>
References: <000000000000ccdf0605708a9ccc@google.com>
 <87y3ekafcw.fsf@ashishki-desk.ger.corp.intel.com>
CC:     Cheng Jian <cj.chengjian@huawei.com>,
        Li Bin <huawei.libin@huawei.com>,
        wangxuefeng <wxf.wang@hisilicon.com>,
        Xie XiuQi <xiexiuqi@huawei.com>
From:   Xie XiuQi <xiexiuqi@huawei.com>
Message-ID: <278ac311-d8f3-2832-5fa1-522471c8c31c@huawei.com>
Date:   Sat, 16 Feb 2019 18:43:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <87y3ekafcw.fsf@ashishki-desk.ger.corp.intel.com>
Content-Type: multipart/mixed;
        boundary="------------4119686705AC7F68500688C8"
X-Originating-IP: [10.177.19.210]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------4119686705AC7F68500688C8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi everyone,

I meet this bug two times, does anyone has idea to fix this issue ? (See attachments)

==================================================================
BUG: KASAN: use-after-free in atomic_dec_and_test include/asm-generic/atomic-instrumented.h:259 [inline]
BUG: KASAN: use-after-free in put_task_struct include/linux/sched/task.h:95 [inline]
BUG: KASAN: use-after-free in _free_event+0x2c4/0xfe0 kernel/events/core.c:4452
Write of size 4 at addr ffff8883780cd0a0 by task syz-executor0/9553

CPU: 3 PID: 9553 Comm: syz-executor0 Not tainted 4.19.18-514.55.6.9.x86_64+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xca/0x13e lib/dump_stack.c:113
 print_address_description+0x79/0x330 mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report+0x18a/0x2e0 mm/kasan/report.c:412
 atomic_dec_and_test include/asm-generic/atomic-instrumented.h:259 [inline]
 put_task_struct include/linux/sched/task.h:95 [inline]
 _free_event+0x2c4/0xfe0 kernel/events/core.c:4452
 free_event+0x41/0xa0 kernel/events/core.c:4473
 perf_event_release_kernel+0x43b/0xc70 kernel/events/core.c:4634
 perf_release+0x33/0x40 kernel/events/core.c:4648
 __fput+0x27f/0x7f0 fs/file_table.c:278
 task_work_run+0x136/0x1b0 kernel/task_work.c:113
 exit_task_work include/linux/task_work.h:22 [inline]
 do_exit+0x850/0x2b90 kernel/exit.c:867
 do_group_exit+0x106/0x2f0 kernel/exit.c:970
 get_signal+0x62b/0x1740 kernel/signal.c:2513
 do_signal+0x94/0x16a0 arch/x86/kernel/signal.c:816
 exit_to_usermode_loop+0x108/0x1d0 arch/x86/entry/common.c:162
 prepare_exit_to_usermode+0x27b/0x2f0 arch/x86/entry/common.c:197
 retint_user+0x8/0x18
RIP: 0033:0x4021b7
Code: Bad RIP value.
RSP: 002b:00007fa7cb40cb30 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 000000000000000b RCX: 0000000000462589
RDX: 00007fa7cb40cb40 RSI: ffffffffffffffb8 RDI: 000000000000000b
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000004bc4cd R14: 00000000006f4c70 R15: 00000000ffffffff

Allocated by task 9552:
 set_track mm/kasan/kasan.c:460 [inline]
 kasan_kmalloc+0xa0/0xd0 mm/kasan/kasan.c:553
 slab_post_alloc_hook mm/slab.h:444 [inline]
 slab_alloc_node mm/slub.c:2706 [inline]
 kmem_cache_alloc_node+0xe3/0x2e0 mm/slub.c:2742
 alloc_task_struct_node kernel/fork.c:157 [inline]
 dup_task_struct kernel/fork.c:802 [inline]
 copy_process.part.26+0x1a98/0x6c70 kernel/fork.c:1707
 copy_process kernel/fork.c:1664 [inline]
 _do_fork+0x1c6/0xe60 kernel/fork.c:2175
 do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 9552:
 set_track mm/kasan/kasan.c:460 [inline]
 __kasan_slab_free+0x12e/0x180 mm/kasan/kasan.c:521
 slab_free_hook mm/slub.c:1371 [inline]
 slab_free_freelist_hook mm/slub.c:1398 [inline]
 slab_free mm/slub.c:2953 [inline]
 kmem_cache_free+0xbd/0x320 mm/slub.c:2969
 copy_process.part.26+0x18d9/0x6c70 kernel/fork.c:2107
 copy_process kernel/fork.c:1664 [inline]
 _do_fork+0x1c6/0xe60 kernel/fork.c:2175
 do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8883780cd080
 which belongs to the cache task_struct of size 9992
The buggy address is located 32 bytes inside of
 9992-byte region [ffff8883780cd080, ffff8883780cf788)
The buggy address belongs to the page:
page:ffffea000de03200 count:1 mapcount:0 mapping:ffff888107d07a00 index:0x0 compound_mapcount: 0
flags: 0x2fffff80008100(slab|head)
raw: 002fffff80008100 dead000000000100 dead000000000200 ffff888107d07a00
raw: 0000000000000000 0000000080030003 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8883780ccf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8883780cd000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8883780cd080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff8883780cd100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8883780cd180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


On 2018/7/9 18:11, Alexander Shishkin wrote:
> syzbot <syzbot+a24c397a29ad22d86c98@syzkaller.appspotmail.com> writes:
> 
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    b2d44d145d2a Merge tag '4.18-rc3-smb3fixes' of git://git.s..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=178cf50c400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
>> dashboard link: https://syzkaller.appspot.com/bug?extid=a24c397a29ad22d86c98
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
> 
> Is there a chance of getting a reproducer for this one?
> 
> Thanks,
> --
> Alex
> 
> .
> 

-- 
Thanks,
Xie XiuQi

--------------4119686705AC7F68500688C8
Content-Type: text/plain; charset="UTF-8"; name="errorlog-1.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="errorlog-1.txt"

PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09DQpCVUc6IEtBU0FOOiB1c2UtYWZ0ZXItZnJlZSBpbiBhdG9taWNfZGVj
X2FuZF90ZXN0IGluY2x1ZGUvYXNtLWdlbmVyaWMvYXRvbWljLWluc3RydW1lbnRlZC5oOjI1
OSBbaW5saW5lXQ0KQlVHOiBLQVNBTjogdXNlLWFmdGVyLWZyZWUgaW4gcHV0X3Rhc2tfc3Ry
dWN0IGluY2x1ZGUvbGludXgvc2NoZWQvdGFzay5oOjk1IFtpbmxpbmVdDQpCVUc6IEtBU0FO
OiB1c2UtYWZ0ZXItZnJlZSBpbiBfZnJlZV9ldmVudCsweDJjNC8weGZlMCBrZXJuZWwvZXZl
bnRzL2NvcmUuYzo0NDUyDQpXcml0ZSBvZiBzaXplIDQgYXQgYWRkciBmZmZmODg4M2Q4ZDgw
MDIwIGJ5IHRhc2sgc3l6LWV4ZWN1dG9yMC8yODYyMA0KDQpDUFU6IDEgUElEOiAyODYyMCBD
b21tOiBzeXotZXhlY3V0b3IwIE5vdCB0YWludGVkIDQuMTkuMTgtNTE0LjU1LjYuOS54ODZf
NjQrICMxDQpIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlY
LCAxOTk2KSwgQklPUyAxLjEwLjItMXVidW50dTEgMDQvMDEvMjAxNA0KQ2FsbCBUcmFjZToN
CiBfX2R1bXBfc3RhY2sgbGliL2R1bXBfc3RhY2suYzo3NyBbaW5saW5lXQ0KIGR1bXBfc3Rh
Y2srMHhjYS8weDEzZSBsaWIvZHVtcF9zdGFjay5jOjExMw0KIHByaW50X2FkZHJlc3NfZGVz
Y3JpcHRpb24rMHg3OS8weDMzMCBtbS9rYXNhbi9yZXBvcnQuYzoyNTYNCiBrYXNhbl9yZXBv
cnRfZXJyb3IgbW0va2FzYW4vcmVwb3J0LmM6MzU0IFtpbmxpbmVdDQoga2FzYW5fcmVwb3J0
KzB4MThhLzB4MmUwIG1tL2thc2FuL3JlcG9ydC5jOjQxMg0KIGF0b21pY19kZWNfYW5kX3Rl
c3QgaW5jbHVkZS9hc20tZ2VuZXJpYy9hdG9taWMtaW5zdHJ1bWVudGVkLmg6MjU5IFtpbmxp
bmVdDQogcHV0X3Rhc2tfc3RydWN0IGluY2x1ZGUvbGludXgvc2NoZWQvdGFzay5oOjk1IFtp
bmxpbmVdDQogX2ZyZWVfZXZlbnQrMHgyYzQvMHhmZTAga2VybmVsL2V2ZW50cy9jb3JlLmM6
NDQ1Mg0KIGZyZWVfZXZlbnQrMHg0MS8weGEwIGtlcm5lbC9ldmVudHMvY29yZS5jOjQ0NzMN
CiBwZXJmX2V2ZW50X3JlbGVhc2Vfa2VybmVsKzB4NDNiLzB4YzcwIGtlcm5lbC9ldmVudHMv
Y29yZS5jOjQ2MzQNCiBwZXJmX3JlbGVhc2UrMHgzMy8weDQwIGtlcm5lbC9ldmVudHMvY29y
ZS5jOjQ2NDgNCiBfX2ZwdXQrMHgyN2YvMHg3ZjAgZnMvZmlsZV90YWJsZS5jOjI3OA0KIHRh
c2tfd29ya19ydW4rMHgxMzYvMHgxYjAga2VybmVsL3Rhc2tfd29yay5jOjExMw0KIHRyYWNl
aG9va19ub3RpZnlfcmVzdW1lIGluY2x1ZGUvbGludXgvdHJhY2Vob29rLmg6MTkzIFtpbmxp
bmVdDQogZXhpdF90b191c2VybW9kZV9sb29wKzB4MWE3LzB4MWQwIGFyY2gveDg2L2VudHJ5
L2NvbW1vbi5jOjE2Ng0KIHByZXBhcmVfZXhpdF90b191c2VybW9kZSBhcmNoL3g4Ni9lbnRy
eS9jb21tb24uYzoxOTcgW2lubGluZV0NCiBzeXNjYWxsX3JldHVybl9zbG93cGF0aCBhcmNo
L3g4Ni9lbnRyeS9jb21tb24uYzoyNjggW2lubGluZV0NCiBkb19zeXNjYWxsXzY0KzB4NDYx
LzB4NTgwIGFyY2gveDg2L2VudHJ5L2NvbW1vbi5jOjI5Mw0KIGVudHJ5X1NZU0NBTExfNjRf
YWZ0ZXJfaHdmcmFtZSsweDQ5LzB4YmUNClJJUDogMDAzMzoweDQxMTVmNw0KQ29kZTogMDAg
MDAgMGYgMDUgNDggM2QgMDAgZjAgZmYgZmYgNzcgM2YgZjMgYzMgMGYgMWYgNDQgMDAgMDAg
NTMgODkgZmIgNDggODMgZWMgMTAgZTggZjQgZmIgZmYgZmYgODkgZGYgODkgYzIgYjggMDMg
MDAgMDAgMDAgMGYgMDUgPDQ4PiAzZCAwMCBmMCBmZiBmZiA3NyAyYiA4OSBkNyA4OSA0NCAy
NCAwYyBlOCAzNiBmYyBmZiBmZiA4YiA0NCAyNA0KUlNQOiAwMDJiOjAwMDA3ZmZlMjRkMGJh
ODAgRUZMQUdTOiAwMDAwMDI5MyBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDAwMw0KUkFYOiAw
MDAwMDAwMDAwMDAwMDAwIFJCWDogMDAwMDAwMDAwMDAwMDAwNSBSQ1g6IDAwMDAwMDAwMDA0
MTE1ZjcNClJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAwMDA3MzBmMzAgUkRJ
OiAwMDAwMDAwMDAwMDAwMDA1DQpSQlA6IDAwMDA3ZmZlMjRkMGJhZWMgUjA4OiAwMDAwN2Zm
ZTI0ZDBiOWIwIFIwOTogMDAwMDdmZmUyNGQwYjliMA0KUjEwOiAwMDAwN2ZmZTI0ZDBiOWMw
IFIxMTogMDAwMDAwMDAwMDAwMDI5MyBSMTI6IDAwMDAwMDAwMDAwMDAwMDENClIxMzogMDAw
MDAwMDAwMDAwMDAwMSBSMTQ6IDAwMDAwMDAwMDAwMDAwMDAgUjE1OiAwMDAwMDAwMDAwMDAw
MDAwDQoNCkFsbG9jYXRlZCBieSB0YXNrIDI4NjI0Og0KIHNldF90cmFjayBtbS9rYXNhbi9r
YXNhbi5jOjQ2MCBbaW5saW5lXQ0KIGthc2FuX2ttYWxsb2MrMHhhMC8weGQwIG1tL2thc2Fu
L2thc2FuLmM6NTUzDQogc2xhYl9wb3N0X2FsbG9jX2hvb2sgbW0vc2xhYi5oOjQ0NCBbaW5s
aW5lXQ0KIHNsYWJfYWxsb2Nfbm9kZSBtbS9zbHViLmM6MjcwNiBbaW5saW5lXQ0KIGttZW1f
Y2FjaGVfYWxsb2Nfbm9kZSsweGUzLzB4MmUwIG1tL3NsdWIuYzoyNzQyDQogYWxsb2NfdGFz
a19zdHJ1Y3Rfbm9kZSBrZXJuZWwvZm9yay5jOjE1NyBbaW5saW5lXQ0KIGR1cF90YXNrX3N0
cnVjdCBrZXJuZWwvZm9yay5jOjgwMiBbaW5saW5lXQ0KIGNvcHlfcHJvY2Vzcy5wYXJ0LjI2
KzB4MWE5OC8weDZjNzAga2VybmVsL2ZvcmsuYzoxNzA3DQogY29weV9wcm9jZXNzIGtlcm5l
bC9mb3JrLmM6MTY2NCBbaW5saW5lXQ0KIF9kb19mb3JrKzB4MWM2LzB4ZTYwIGtlcm5lbC9m
b3JrLmM6MjE3NQ0KIGRvX3N5c2NhbGxfNjQrMHhjOC8weDU4MCBhcmNoL3g4Ni9lbnRyeS9j
b21tb24uYzoyOTANCiBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0OS8weGJl
DQoNCkZyZWVkIGJ5IHRhc2sgMjg2MjQ6DQogc2V0X3RyYWNrIG1tL2thc2FuL2thc2FuLmM6
NDYwIFtpbmxpbmVdDQogX19rYXNhbl9zbGFiX2ZyZWUrMHgxMmUvMHgxODAgbW0va2FzYW4v
a2FzYW4uYzo1MjENCiBzbGFiX2ZyZWVfaG9vayBtbS9zbHViLmM6MTM3MSBbaW5saW5lXQ0K
IHNsYWJfZnJlZV9mcmVlbGlzdF9ob29rIG1tL3NsdWIuYzoxMzk4IFtpbmxpbmVdDQogc2xh
Yl9mcmVlIG1tL3NsdWIuYzoyOTUzIFtpbmxpbmVdDQoga21lbV9jYWNoZV9mcmVlKzB4YmQv
MHgzMjAgbW0vc2x1Yi5jOjI5NjkNCiBjb3B5X3Byb2Nlc3MucGFydC4yNisweDE4ZDkvMHg2
YzcwIGtlcm5lbC9mb3JrLmM6MjEwNw0KIGNvcHlfcHJvY2VzcyBrZXJuZWwvZm9yay5jOjE2
NjQgW2lubGluZV0NCiBfZG9fZm9yaysweDFjNi8weGU2MCBrZXJuZWwvZm9yay5jOjIxNzUN
CiBkb19zeXNjYWxsXzY0KzB4YzgvMHg1ODAgYXJjaC94ODYvZW50cnkvY29tbW9uLmM6Mjkw
DQogZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NDkvMHhiZQ0KDQpUaGUgYnVn
Z3kgYWRkcmVzcyBiZWxvbmdzIHRvIHRoZSBvYmplY3QgYXQgZmZmZjg4ODNkOGQ4MDAwMA0K
IHdoaWNoIGJlbG9uZ3MgdG8gdGhlIGNhY2hlIHRhc2tfc3RydWN0IG9mIHNpemUgOTk5Mg0K
VGhlIGJ1Z2d5IGFkZHJlc3MgaXMgbG9jYXRlZCAzMiBieXRlcyBpbnNpZGUgb2YNCiA5OTky
LWJ5dGUgcmVnaW9uIFtmZmZmODg4M2Q4ZDgwMDAwLCBmZmZmODg4M2Q4ZDgyNzA4KQ0KVGhl
IGJ1Z2d5IGFkZHJlc3MgYmVsb25ncyB0byB0aGUgcGFnZToNCnBhZ2U6ZmZmZmVhMDAwZjYz
NjAwMCBjb3VudDoxIG1hcGNvdW50OjAgbWFwcGluZzpmZmZmODg4MTA3ZDA3YTAwIGluZGV4
OjB4MCBjb21wb3VuZF9tYXBjb3VudDogMA0KZmxhZ3M6IDB4MmZmZmZmODAwMDgxMDAoc2xh
YnxoZWFkKQ0KcmF3OiAwMDJmZmZmZjgwMDA4MTAwIDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAw
MDIwMDAwMDAwMSBmZmZmODg4MTA3ZDA3YTAwDQpyYXc6IDAwMDAwMDAwMDAwMDAwMDAgMDAw
MDAwMDA4MDAzMDAwMyAwMDAwMDAwMWZmZmZmZmZmIDAwMDAwMDAwMDAwMDAwMDANCnBhZ2Ug
ZHVtcGVkIGJlY2F1c2U6IGthc2FuOiBiYWQgYWNjZXNzIGRldGVjdGVkDQoNCk1lbW9yeSBz
dGF0ZSBhcm91bmQgdGhlIGJ1Z2d5IGFkZHJlc3M6DQogZmZmZjg4ODNkOGQ3ZmYwMDogMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCiBmZmZmODg4
M2Q4ZDdmZjgwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMA0KPmZmZmY4ODgzZDhkODAwMDA6IGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZi
IGZiIGZiIGZiIGZiIGZiIGZiDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0K
IGZmZmY4ODgzZDhkODAwODA6IGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZi
IGZiIGZiIGZiIGZiDQogZmZmZjg4ODNkOGQ4MDEwMDogZmIgZmIgZmIgZmIgZmIgZmIgZmIg
ZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmINCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ==
--------------4119686705AC7F68500688C8
Content-Type: text/plain; charset="UTF-8"; name="errorlog-2.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="errorlog-2.txt"

PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09DQpCVUc6IEtBU0FOOiB1c2UtYWZ0ZXItZnJlZSBpbiBhdG9taWNfZGVj
X2FuZF90ZXN0IGluY2x1ZGUvYXNtLWdlbmVyaWMvYXRvbWljLWluc3RydW1lbnRlZC5oOjI1
OSBbaW5saW5lXQ0KQlVHOiBLQVNBTjogdXNlLWFmdGVyLWZyZWUgaW4gcHV0X3Rhc2tfc3Ry
dWN0IGluY2x1ZGUvbGludXgvc2NoZWQvdGFzay5oOjk1IFtpbmxpbmVdDQpCVUc6IEtBU0FO
OiB1c2UtYWZ0ZXItZnJlZSBpbiBfZnJlZV9ldmVudCsweDJjNC8weGZlMCBrZXJuZWwvZXZl
bnRzL2NvcmUuYzo0NDUyDQpXcml0ZSBvZiBzaXplIDQgYXQgYWRkciBmZmZmODg4Mzc4MGNk
MGEwIGJ5IHRhc2sgc3l6LWV4ZWN1dG9yMC85NTUzDQoNCkNQVTogMyBQSUQ6IDk1NTMgQ29t
bTogc3l6LWV4ZWN1dG9yMCBOb3QgdGFpbnRlZCA0LjE5LjE4LTUxNC41NS42LjkueDg2XzY0
KyAjMQ0KSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwg
MTk5NiksIEJJT1MgMS4xMC4yLTF1YnVudHUxIDA0LzAxLzIwMTQNCkNhbGwgVHJhY2U6DQog
X19kdW1wX3N0YWNrIGxpYi9kdW1wX3N0YWNrLmM6NzcgW2lubGluZV0NCiBkdW1wX3N0YWNr
KzB4Y2EvMHgxM2UgbGliL2R1bXBfc3RhY2suYzoxMTMNCiBwcmludF9hZGRyZXNzX2Rlc2Ny
aXB0aW9uKzB4NzkvMHgzMzAgbW0va2FzYW4vcmVwb3J0LmM6MjU2DQoga2FzYW5fcmVwb3J0
X2Vycm9yIG1tL2thc2FuL3JlcG9ydC5jOjM1NCBbaW5saW5lXQ0KIGthc2FuX3JlcG9ydCsw
eDE4YS8weDJlMCBtbS9rYXNhbi9yZXBvcnQuYzo0MTINCiBhdG9taWNfZGVjX2FuZF90ZXN0
IGluY2x1ZGUvYXNtLWdlbmVyaWMvYXRvbWljLWluc3RydW1lbnRlZC5oOjI1OSBbaW5saW5l
XQ0KIHB1dF90YXNrX3N0cnVjdCBpbmNsdWRlL2xpbnV4L3NjaGVkL3Rhc2suaDo5NSBbaW5s
aW5lXQ0KIF9mcmVlX2V2ZW50KzB4MmM0LzB4ZmUwIGtlcm5lbC9ldmVudHMvY29yZS5jOjQ0
NTINCiBmcmVlX2V2ZW50KzB4NDEvMHhhMCBrZXJuZWwvZXZlbnRzL2NvcmUuYzo0NDczDQog
cGVyZl9ldmVudF9yZWxlYXNlX2tlcm5lbCsweDQzYi8weGM3MCBrZXJuZWwvZXZlbnRzL2Nv
cmUuYzo0NjM0DQogcGVyZl9yZWxlYXNlKzB4MzMvMHg0MCBrZXJuZWwvZXZlbnRzL2NvcmUu
Yzo0NjQ4DQogX19mcHV0KzB4MjdmLzB4N2YwIGZzL2ZpbGVfdGFibGUuYzoyNzgNCiB0YXNr
X3dvcmtfcnVuKzB4MTM2LzB4MWIwIGtlcm5lbC90YXNrX3dvcmsuYzoxMTMNCiBleGl0X3Rh
c2tfd29yayBpbmNsdWRlL2xpbnV4L3Rhc2tfd29yay5oOjIyIFtpbmxpbmVdDQogZG9fZXhp
dCsweDg1MC8weDJiOTAga2VybmVsL2V4aXQuYzo4NjcNCiBkb19ncm91cF9leGl0KzB4MTA2
LzB4MmYwIGtlcm5lbC9leGl0LmM6OTcwDQogZ2V0X3NpZ25hbCsweDYyYi8weDE3NDAga2Vy
bmVsL3NpZ25hbC5jOjI1MTMNCiBkb19zaWduYWwrMHg5NC8weDE2YTAgYXJjaC94ODYva2Vy
bmVsL3NpZ25hbC5jOjgxNg0KIGV4aXRfdG9fdXNlcm1vZGVfbG9vcCsweDEwOC8weDFkMCBh
cmNoL3g4Ni9lbnRyeS9jb21tb24uYzoxNjINCiBwcmVwYXJlX2V4aXRfdG9fdXNlcm1vZGUr
MHgyN2IvMHgyZjAgYXJjaC94ODYvZW50cnkvY29tbW9uLmM6MTk3DQogcmV0aW50X3VzZXIr
MHg4LzB4MTgNClJJUDogMDAzMzoweDQwMjFiNw0KQ29kZTogQmFkIFJJUCB2YWx1ZS4NClJT
UDogMDAyYjowMDAwN2ZhN2NiNDBjYjMwIEVGTEFHUzogMDAwMTAyMDINClJBWDogMDAwMDAw
MDAwMDAwMDAwMCBSQlg6IDAwMDAwMDAwMDAwMDAwMGIgUkNYOiAwMDAwMDAwMDAwNDYyNTg5
DQpSRFg6IDAwMDA3ZmE3Y2I0MGNiNDAgUlNJOiBmZmZmZmZmZmZmZmZmZmI4IFJESTogMDAw
MDAwMDAwMDAwMDAwYg0KUkJQOiAwMDAwMDAwMDAwMDAwMDAwIFIwODogMDAwMDAwMDAwMDAw
MDAwMCBSMDk6IDAwMDAwMDAwMDAwMDAwMDANClIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6
IDAwMDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAwMDAwMDAwMDAwMDAwDQpSMTM6IDAwMDAwMDAw
MDA0YmM0Y2QgUjE0OiAwMDAwMDAwMDAwNmY0YzcwIFIxNTogMDAwMDAwMDBmZmZmZmZmZg0K
DQpBbGxvY2F0ZWQgYnkgdGFzayA5NTUyOg0KIHNldF90cmFjayBtbS9rYXNhbi9rYXNhbi5j
OjQ2MCBbaW5saW5lXQ0KIGthc2FuX2ttYWxsb2MrMHhhMC8weGQwIG1tL2thc2FuL2thc2Fu
LmM6NTUzDQogc2xhYl9wb3N0X2FsbG9jX2hvb2sgbW0vc2xhYi5oOjQ0NCBbaW5saW5lXQ0K
IHNsYWJfYWxsb2Nfbm9kZSBtbS9zbHViLmM6MjcwNiBbaW5saW5lXQ0KIGttZW1fY2FjaGVf
YWxsb2Nfbm9kZSsweGUzLzB4MmUwIG1tL3NsdWIuYzoyNzQyDQogYWxsb2NfdGFza19zdHJ1
Y3Rfbm9kZSBrZXJuZWwvZm9yay5jOjE1NyBbaW5saW5lXQ0KIGR1cF90YXNrX3N0cnVjdCBr
ZXJuZWwvZm9yay5jOjgwMiBbaW5saW5lXQ0KIGNvcHlfcHJvY2Vzcy5wYXJ0LjI2KzB4MWE5
OC8weDZjNzAga2VybmVsL2ZvcmsuYzoxNzA3DQogY29weV9wcm9jZXNzIGtlcm5lbC9mb3Jr
LmM6MTY2NCBbaW5saW5lXQ0KIF9kb19mb3JrKzB4MWM2LzB4ZTYwIGtlcm5lbC9mb3JrLmM6
MjE3NQ0KIGRvX3N5c2NhbGxfNjQrMHhjOC8weDU4MCBhcmNoL3g4Ni9lbnRyeS9jb21tb24u
YzoyOTANCiBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0OS8weGJlDQoNCkZy
ZWVkIGJ5IHRhc2sgOTU1MjoNCiBzZXRfdHJhY2sgbW0va2FzYW4va2FzYW4uYzo0NjAgW2lu
bGluZV0NCiBfX2thc2FuX3NsYWJfZnJlZSsweDEyZS8weDE4MCBtbS9rYXNhbi9rYXNhbi5j
OjUyMQ0KIHNsYWJfZnJlZV9ob29rIG1tL3NsdWIuYzoxMzcxIFtpbmxpbmVdDQogc2xhYl9m
cmVlX2ZyZWVsaXN0X2hvb2sgbW0vc2x1Yi5jOjEzOTggW2lubGluZV0NCiBzbGFiX2ZyZWUg
bW0vc2x1Yi5jOjI5NTMgW2lubGluZV0NCiBrbWVtX2NhY2hlX2ZyZWUrMHhiZC8weDMyMCBt
bS9zbHViLmM6Mjk2OQ0KIGNvcHlfcHJvY2Vzcy5wYXJ0LjI2KzB4MThkOS8weDZjNzAga2Vy
bmVsL2ZvcmsuYzoyMTA3DQogY29weV9wcm9jZXNzIGtlcm5lbC9mb3JrLmM6MTY2NCBbaW5s
aW5lXQ0KIF9kb19mb3JrKzB4MWM2LzB4ZTYwIGtlcm5lbC9mb3JrLmM6MjE3NQ0KIGRvX3N5
c2NhbGxfNjQrMHhjOC8weDU4MCBhcmNoL3g4Ni9lbnRyeS9jb21tb24uYzoyOTANCiBlbnRy
eV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0OS8weGJlDQoNClRoZSBidWdneSBhZGRy
ZXNzIGJlbG9uZ3MgdG8gdGhlIG9iamVjdCBhdCBmZmZmODg4Mzc4MGNkMDgwDQogd2hpY2gg
YmVsb25ncyB0byB0aGUgY2FjaGUgdGFza19zdHJ1Y3Qgb2Ygc2l6ZSA5OTkyDQpUaGUgYnVn
Z3kgYWRkcmVzcyBpcyBsb2NhdGVkIDMyIGJ5dGVzIGluc2lkZSBvZg0KIDk5OTItYnl0ZSBy
ZWdpb24gW2ZmZmY4ODgzNzgwY2QwODAsIGZmZmY4ODgzNzgwY2Y3ODgpDQpUaGUgYnVnZ3kg
YWRkcmVzcyBiZWxvbmdzIHRvIHRoZSBwYWdlOg0KcGFnZTpmZmZmZWEwMDBkZTAzMjAwIGNv
dW50OjEgbWFwY291bnQ6MCBtYXBwaW5nOmZmZmY4ODgxMDdkMDdhMDAgaW5kZXg6MHgwIGNv
bXBvdW5kX21hcGNvdW50OiAwDQpmbGFnczogMHgyZmZmZmY4MDAwODEwMChzbGFifGhlYWQp
DQpyYXc6IDAwMmZmZmZmODAwMDgxMDAgZGVhZDAwMDAwMDAwMDEwMCBkZWFkMDAwMDAwMDAw
MjAwIGZmZmY4ODgxMDdkMDdhMDANCnJhdzogMDAwMDAwMDAwMDAwMDAwMCAwMDAwMDAwMDgw
MDMwMDAzIDAwMDAwMDAxZmZmZmZmZmYgMDAwMDAwMDAwMDAwMDAwMA0KcGFnZSBkdW1wZWQg
YmVjYXVzZToga2FzYW46IGJhZCBhY2Nlc3MgZGV0ZWN0ZWQNCg0KTWVtb3J5IHN0YXRlIGFy
b3VuZCB0aGUgYnVnZ3kgYWRkcmVzczoNCiBmZmZmODg4Mzc4MGNjZjgwOiBmYyBmYyBmYyBm
YyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYw0KIGZmZmY4ODgzNzgwY2Qw
MDA6IGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjDQo+
ZmZmZjg4ODM3ODBjZDA4MDogZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIg
ZmIgZmIgZmIgZmINCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQogZmZmZjg4
ODM3ODBjZDEwMDogZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIg
ZmIgZmINCiBmZmZmODg4Mzc4MGNkMTgwOiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBm
YiBmYiBmYiBmYiBmYiBmYiBmYg0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
--------------4119686705AC7F68500688C8--
