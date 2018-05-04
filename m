Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbeEDFiE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 01:38:04 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36363 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbeEDFiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 01:38:02 -0400
X-Google-Smtp-Source: AB8JxZpLr0F2DepjMkIQfodKhKmy/et88mWQ+/OXCq5NXvASApuO8sZb/mYYIGBsYNpc0f5jJCZSxYqfDjLqw0UaOmw=
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZExFQ553u__PVrPNSQgMtrcDNnupqrC4-B5MtXYkx8dQ@mail.gmail.com>
References: <000000000000bebc7d056acdcb7b@google.com> <CACT4Y+ZExFQ553u__PVrPNSQgMtrcDNnupqrC4-B5MtXYkx8dQ@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 4 May 2018 07:37:41 +0200
Message-ID: <CACT4Y+aqXo3zVpVaEOO2gx_OwfdVR6zfTc0t+3Vak2wMaNoroA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in process_preds
To: syzbot <syzbot+b6fc33dcecb65cd8ff80@syzkaller.appspotmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 5:19 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Fri, Apr 27, 2018 at 7:30 AM, syzbot
> <syzbot+b6fc33dcecb65cd8ff80@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot hit the following crash on bpf-next commit
>> 5d1365940a68dd57b031b6e3c07d7d451cd69daf (Thu Apr 12 18:09:05 2018 +0000)
>> Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
>> syzbot dashboard link:
>> https://syzkaller.appspot.com/bug?extid=b6fc33dcecb65cd8ff80
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>> Raw console output:
>> https://syzkaller.appspot.com/x/log.txt?id=4606019153952768
>> Kernel config:
>> https://syzkaller.appspot.com/x/.config?id=-5947642240294114534
>> compiler: gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+b6fc33dcecb65cd8ff80@syzkaller.appspotmail.com
>> It will help syzbot understand when the bug is fixed. See footer for
>> details.
>> If you forward the report, please keep this part and the footer.
>>
>> ==================================================================
>> BUG: KASAN: use-after-free in predicate_parse
>> kernel/trace/trace_events_filter.c:563 [inline]
>> BUG: KASAN: use-after-free in process_preds+0x197f/0x19b0
>> kernel/trace/trace_events_filter.c:1505
>> Read of size 4 at addr ffff8801b9832ce4 by task syz-executor0/28463
>>
>> CPU: 0 PID: 28463 Comm: syz-executor0 Not tainted 4.16.0+ #2
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>>  kasan_report_error mm/kasan/report.c:354 [inline]
>>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>>  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
>>  predicate_parse kernel/trace/trace_events_filter.c:563 [inline]
>>  process_preds+0x197f/0x19b0 kernel/trace/trace_events_filter.c:1505
>>  create_filter+0x1a8/0x370 kernel/trace/trace_events_filter.c:1714
>>  ftrace_profile_set_filter+0x109/0x2b0
>> kernel/trace/trace_events_filter.c:2042
>>  perf_event_set_filter+0x248/0x1230 kernel/events/core.c:9064
>>  _perf_ioctl+0x84c/0x15e0 kernel/events/core.c:5056
>>  perf_ioctl+0x59/0x80 kernel/events/core.c:5107
>>  vfs_ioctl fs/ioctl.c:46 [inline]
>>  file_ioctl fs/ioctl.c:500 [inline]
>>  do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
>>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
>>  SYSC_ioctl fs/ioctl.c:708 [inline]
>>  SyS_ioctl+0x24/0x30 fs/ioctl.c:706
>>  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
>>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
>> RIP: 0033:0x455329
>> RSP: 002b:00007f14b2c73c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>> RAX: ffffffffffffffda RBX: 00007f14b2c746d4 RCX: 0000000000455329
>> RDX: 0000000020000040 RSI: 0000000040082406 RDI: 0000000000000013
>> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
>> R13: 0000000000000291 R14: 00000000006f6e38 R15: 0000000000000000
>>
>> Allocated by task 2370:
>>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>>  set_track mm/kasan/kasan.c:460 [inline]
>>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>>  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
>>  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
>>  getname_flags+0xd0/0x5a0 fs/namei.c:140
>>  getname+0x19/0x20 fs/namei.c:211
>>  do_sys_open+0x39a/0x740 fs/open.c:1087
>>  SYSC_open fs/open.c:1111 [inline]
>>  SyS_open+0x2d/0x40 fs/open.c:1106
>>  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
>>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
>>
>> Freed by task 2370:
>>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>>  set_track mm/kasan/kasan.c:460 [inline]
>>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>>  __cache_free mm/slab.c:3498 [inline]
>>  kmem_cache_free+0x86/0x2d0 mm/slab.c:3756
>>  putname+0xf2/0x130 fs/namei.c:261
>>  do_sys_open+0x554/0x740 fs/open.c:1102
>>  SYSC_open fs/open.c:1111 [inline]
>>  SyS_open+0x2d/0x40 fs/open.c:1106
>>  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
>>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
>>
>> The buggy address belongs to the object at ffff8801b9832340
>>  which belongs to the cache names_cache of size 4096
>> The buggy address is located 2468 bytes inside of
>>  4096-byte region [ffff8801b9832340, ffff8801b9833340)
>> The buggy address belongs to the page:
>> page:ffffea0006e60c80 count:1 mapcount:0 mapping:ffff8801b9832340 index:0x0
>> compound_mapcount: 0
>> flags: 0x2fffc0000008100(slab|head)
>> raw: 02fffc0000008100 ffff8801b9832340 0000000000000000 0000000100000001
>> raw: ffffea000743eca0 ffffea0006628f20 ffff8801dad86dc0 0000000000000000
>> page dumped because: kasan: bad access detected
>>
>> Memory state around the buggy address:
>>  ffff8801b9832b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>  ffff8801b9832c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>>
>>> ffff8801b9832c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>
>>                                                        ^
>>  ffff8801b9832d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>  ffff8801b9832d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ==================================================================
>
> Here is a repro:
>
> // autogenerated by syzkaller (http://github.com/google/syzkaller)
>
> #define _GNU_SOURCE
> #include <endian.h>
> #include <stdint.h>
> #include <string.h>
> #include <sys/syscall.h>
> #include <unistd.h>
>
> #define BITMASK_LEN(type, bf_len) (type)((1ull << (bf_len)) - 1)
>
> #define BITMASK_LEN_OFF(type, bf_off, bf_len)                                  \
>   (type)(BITMASK_LEN(type, (bf_len)) << (bf_off))
>
> #define STORE_BY_BITMASK(type, addr, val, bf_off, bf_len)                      \
>   if ((bf_off) == 0 && (bf_len) == 0) {                                        \
>     *(type*)(addr) = (type)(val);                                              \
>   } else {                                                                     \
>     type new_val = *(type*)(addr);                                             \
>     new_val &= ~BITMASK_LEN_OFF(type, (bf_off), (bf_len));                     \
>     new_val |= ((type)(val)&BITMASK_LEN(type, (bf_len))) << (bf_off);          \
>     *(type*)(addr) = new_val;                                                  \
>   }
>
> uint64_t r[1] = {0xffffffffffffffff};
> void loop()
> {
>   long res = 0;
>   *(uint32_t*)0x2025c000 = 2;
>   *(uint32_t*)0x2025c004 = 0x78;
>   *(uint8_t*)0x2025c008 = 0xe2;
>   *(uint8_t*)0x2025c009 = 0;
>   *(uint8_t*)0x2025c00a = 0;
>   *(uint8_t*)0x2025c00b = 0;
>   *(uint32_t*)0x2025c00c = 0;
>   *(uint64_t*)0x2025c010 = 0;
>   *(uint64_t*)0x2025c018 = 0;
>   *(uint64_t*)0x2025c020 = 0;
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 0, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 1, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 2, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 3, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 4, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 5, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 6, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 7, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 8, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 9, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 10, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 11, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 12, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 13, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 14, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 15, 2);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 17, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 18, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 19, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 20, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 21, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 22, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 23, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 24, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 25, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 26, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 27, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 28, 1);
>   STORE_BY_BITMASK(uint64_t, 0x2025c028, 0, 29, 35);
>   *(uint32_t*)0x2025c030 = 0;
>   *(uint32_t*)0x2025c034 = 0;
>   *(uint64_t*)0x2025c038 = 0x20000000;
>   *(uint64_t*)0x2025c040 = 0;
>   *(uint64_t*)0x2025c048 = 0;
>   *(uint64_t*)0x2025c050 = 0;
>   *(uint32_t*)0x2025c058 = 0;
>   *(uint32_t*)0x2025c05c = 0;
>   *(uint64_t*)0x2025c060 = 0;
>   *(uint32_t*)0x2025c068 = 0;
>   *(uint16_t*)0x2025c06c = 0;
>   *(uint16_t*)0x2025c06e = 0;
>   res = syscall(__NR_perf_event_open, 0x2025c000, 0, -1, -1, 0);
>   if (res != -1)
>     r[0] = res;
>   memcpy((void*)0x20000100, "!", 2);
>   syscall(__NR_ioctl, r[0], 0x40082406, 0x20000100);
> }
>
> int main()
> {
>   syscall(__NR_mmap, 0x20000000, 0x1000000, 3, 0x32, -1, 0);
>   loop();
>   return 0;
> }


This looks similar to the old crash with reproducer:

#syz dup: KASAN: slab-out-of-bounds Write in process_preds

https://syzkaller.appspot.com/bug?id=e84ebd53b11608595ca4fd595d48ae9ddce9cf11
