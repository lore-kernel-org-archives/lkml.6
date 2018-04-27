Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933457AbeD0PYs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:24:48 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35149 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933317AbeD0PYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 11:24:45 -0400
X-Google-Smtp-Source: AB8JxZooPYI52BhQh8ZAHEs0yiJY1vhTr/ViixvYtJrdaFVRE4wvNjbXOwOVmZgmwy2vXsNznGR73cGckK6T9awnsxo=
MIME-Version: 1.0
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 27 Apr 2018 17:24:24 +0200
Message-ID: <CACT4Y+Ys9bKFNaBm7YuCvk04jcZ2SnLiDSxgCojZMwtb2PKVBg@mail.gmail.com>
Subject: stack out-of-bounds write in mce-inject.c
To: tony.luck@intel.com, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-edac@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Opening /sys/kernel/debug/mce-inject/flags overwrites stack:

==================================================================
BUG: KASAN: stack-out-of-bounds in vsnprintf+0x1b23/0x1b40 lib/vsprintf.c:2365
Write of size 1 at addr ffff8800627b7abb by task egrep/4309

CPU: 3 PID: 4309 Comm: egrep Not tainted 4.17.0-rc2+ #179
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1b9/0x294 lib/dump_stack.c:113
 print_address_description+0x6c/0x20b mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:366 [inline]
 kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:424
 __asan_report_store1_noabort+0x17/0x20 mm/kasan/report.c:447
 vsnprintf+0x1b23/0x1b40 lib/vsprintf.c:2365
 sprintf+0xa7/0xd0 lib/vsprintf.c:2494
 flags_read+0xa3/0xf0 arch/x86/kernel/cpu/mcheck/mce-inject.c:345
 full_proxy_read+0x125/0x190 fs/debugfs/file.c:195
 __vfs_read+0x10f/0xa50 fs/read_write.c:416
 vfs_read+0x17f/0x3d0 fs/read_write.c:452
 ksys_read+0xf9/0x250 fs/read_write.c:578
 __do_sys_read fs/read_write.c:588 [inline]
 __se_sys_read fs/read_write.c:586 [inline]
 __x64_sys_read+0x73/0xb0 fs/read_write.c:586
 do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7fb17c6c3310
RSP: 002b:00007ffca98af8e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000001d72000 RCX: 00007fb17c6c3310
RDX: 0000000000008000 RSI: 0000000001d72000 RDI: 0000000000000005
RBP: 0000000000001000 R08: 0000000001d72000 R09: 00007fb17c979e90
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000008000 R14: 0000000000000000 R15: 0000000000000003

The buggy address belongs to the page:
page:ffffea000189edc0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x1fffc0000000000()
raw: 01fffc0000000000 0000000000000000 0000000000000000 00000000ffffffff
raw: 0000000000000000 ffffea0001890101 0000000000000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8800627b7980: f3 f3 f3 f3 00 00 00 00 00 00 00 f1 f1 f1 f1 00
 ffff8800627b7a00: 00 00 f2 f3 f3 f3 f3 00 00 00 00 00 00 00 00 00
>ffff8800627b7a80: 00 00 00 f1 f1 f1 f1 03 f2 f2 f2 f3 f3 f3 f3 00
                                        ^
 ffff8800627b7b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8800627b7b80: 00 00 00 00 00 f1 f1 f1 f1 00 00 f2 f2 f2 f2 f2
==================================================================

On upstream commit 0644f186fc9d77bb5bd198369e59fb28927a3692.
