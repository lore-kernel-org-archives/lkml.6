Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeDFPk1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:40:27 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34622 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbeDFPkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 11:40:22 -0400
X-Google-Smtp-Source: AIpwx48wzLZiPoVGLP5MJ31v2nQdWgNlEFx9r+NdH7+vd3eiLZzFrrx7f6HM809RD/d0zHDr3xSp8kqmcuNMN+lLHMg=
MIME-Version: 1.0
In-Reply-To: <20180406153633.lex32dujz747ycm5@treble>
References: <94eb2c05611408a11a056922c4cb@google.com> <20180406153633.lex32dujz747ycm5@treble>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 6 Apr 2018 17:40:01 +0200
Message-ID: <CACT4Y+Zi3cBfjao_VE6ugOXosuCXWoJ58PfuZdYbckfOLzN09A@mail.gmail.com>
Subject: Re: KASAN: alloca-out-of-bounds Read in unwind_next_frame
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: syzbot <syzbot+9d1d9866b0b8ee6e0a8c@syzkaller.appspotmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 6, 2018 at 5:36 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Thu, Apr 05, 2018 at 05:02:02PM -0700, syzbot wrote:
>> Hello,
>>
>> syzbot hit the following crash on upstream commit
>> 06dd3dfeea60e2a6457a6aedf97afc8e6d2ba497 (Thu Apr 5 03:07:20 2018 +0000)
>> Merge tag 'char-misc-4.17-rc1' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
>> syzbot dashboard link:
>> https://syzkaller.appspot.com/bug?extid=9d1d9866b0b8ee6e0a8c
>>
>> syzkaller reproducer:
>> https://syzkaller.appspot.com/x/repro.syz?id=6478299081474048
>> Raw console output:
>> https://syzkaller.appspot.com/x/log.txt?id=5324218015154176
>> Kernel config: https://syzkaller.appspot.com/x/.config?id=216543573824217049
>> compiler: gcc (GCC) 8.0.1 20180301 (experimental)
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+9d1d9866b0b8ee6e0a8c@syzkaller.appspotmail.com
>> It will help syzbot understand when the bug is fixed. See footer for
>> details.
>> If you forward the report, please keep this part and the footer.
>>
>> ==================================================================
>> BUG: KASAN: alloca-out-of-bounds in __read_once_size
>> include/linux/compiler.h:188 [inline]
>> BUG: KASAN: alloca-out-of-bounds in unwind_next_frame.part.7+0x7ce/0x9c0
>> arch/x86/kernel/unwind_frame.c:326
>> Read of size 8 at addr ffff8801b05e67f8 by task syz-executor2/11326
>
> This looks like a KASAN bug.
>
> The FP unwinder was unwinding from an interrupt which hit while running
> in kasan_unpoison_shadow():
>
>> RIP: 0010:kasan_unpoison_shadow+0x1/0x50 mm/kasan/kasan.c:68
>> RSP: 0018:ffff8801b05e67e8 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
>> RAX: ffff8801c1b24100 RBX: 0000000000000000 RCX: ffffffff859d4219
>> RDX: 0000000000000000 RSI: 00000000000000a8 RDI: ffff8801b05e6760
>> RBP: ffff8801b05e67f8 R08: ffff8801c1b24100 R09: ffffed003b6046c2
>> R10: ffffed003b6046c2 R11: ffff8801db023613 R12: 0000000000000015
>> R13: 0000000000000001 R14: 0000000000000016 R15: dffffc0000000000
>
> So at first glance it seemed like a race condition.  However, the
> unwinder was only trying to dereference the frame pointer (RBP:
> ffff8801b05e67f8), which should have never been poisoned in the first
> place.
>
> So it looks like a bug in the KASAN alloca poisoning.

Hi Josh,

You seen my previous message, right? Or was it lost somehow?

https://groups.google.com/d/msg/syzkaller-bugs/IcKqxHzhmQc/KAL6o7tOCAAJ
