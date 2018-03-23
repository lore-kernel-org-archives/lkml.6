Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeCWQYG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:24:06 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:39326 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeCWQYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:24:04 -0400
X-Google-Smtp-Source: AG47ELtiCIy5odHjN490ihKdZ1U5H+907PCOHBcw9p3ReqdimcAw1BAMj4Lw74QJ2FxaGWVnKQPhEYIqXFMHJS1eh54=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1803231004130.4625@nanos.tec.linutronix.de>
References: <CAJWu+oo1mnS=2v_SbnDCDih6AyystU2aXVCUEa5k0W0q0Ovk6w@mail.gmail.com>
 <alpine.DEB.2.21.1803231004130.4625@nanos.tec.linutronix.de>
From: Joel Fernandes <joelaf@google.com>
Date: Fri, 23 Mar 2018 09:24:02 -0700
Message-ID: <CAJWu+ooHzLpJZxsFq7hifmaEh7fOdYsExKz6pGLgSPQUxAB4Nw@mail.gmail.com>
Subject: Re: syzbot rcu/debugobjects warning
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Todd Poynor <toddpoynor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 2:11 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 22 Mar 2018, Joel Fernandes wrote:
>
>> Hi Paul, Thomas,
>>
>> I received a crash report from syzbot on the android 4.9 kernel and I
>> am looking into it, it seems the debugobjects subsystem is warning
>> that a certain RCU structure is not allocated on the stack, but is
>> annotated to be.
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 1 PID: 0 at lib/debugobjects.c:300
>> debug_object_is_on_stack lib/debugobjects.c:300 [inline]
>> WARNING: CPU: 1 PID: 0 at lib/debugobjects.c:300
>> __debug_object_init+0x526/0xc40 lib/debugobjects.c:326
>> [...]
>>  <IRQ> [  150.631700]  [<ffffffff81d96069>] dump_stack+0xc1/0x128
>> lib/dump_stack.c:51
>>  [<ffffffff8142fbd1>] panic+0x1bc/0x3a8 kernel/panic.c:179
>>  [<ffffffff81131894>] __warn+0x1c4/0x1e0 kernel/panic.c:542
>>  [<ffffffff81131afc>] warn_slowpath_null+0x2c/0x40 kernel/panic.c:585
>>  [<ffffffff81dfefb6>] debug_object_is_on_stack lib/debugobjects.c:300 [inline]
>>  [<ffffffff81dfefb6>] __debug_object_init+0x526/0xc40 lib/debugobjects.c:326
>>  [<ffffffff81dff709>] debug_object_init_on_stack+0x19/0x20
>> lib/debugobjects.c:378
>>  [<ffffffff81287a93>] init_rcu_head_on_stack kernel/rcu/update.c:403 [inline]
>>  [<ffffffff81287a93>] __wait_rcu_gp+0x93/0x1b0 kernel/rcu/update.c:358
>>  [<ffffffff81290251>] synchronize_rcu.part.65+0x101/0x110
>> kernel/rcu/tree_plugin.h:678
>>  [<ffffffff81290287>] synchronize_rcu+0x27/0x90 kernel/rcu/tree_plugin.h:679
>>  [<ffffffff83588b35>] __l2tp_session_unhash+0x3d5/0x550
>> net/l2tp/l2tp_core.c:1792
>>
>> The full report is here:
>> https://syzkaller.appspot.com/bug?extid=e6a19b585ab2dba3eee8
>
> This is beyond useless. That brings me to a google 'Sign in' page. Please
> use accessible storage. That information is hardly secrit.

Sorry. Here is the raw crash log: https://pastebin.com/raw/puvh0cXE
(The kernel logs are toward the end with the above).

>
>> It seems as per the code that the structure is on the stack so its
>> weird why debugobjects thinks its not.
>> The object in question is allocated on the stack by the __wait_rcu_gp
>> macro when its called from synchronize_rcu:
>>
>> #define _wait_rcu_gp(checktiny, ...) \
>> do {                                                                    \
>>         call_rcu_func_t __crcu_array[] = { __VA_ARGS__ };               \
>>         struct rcu_synchronize __rs_array[ARRAY_SIZE(__crcu_array)];    \
>>         __wait_rcu_gp(checktiny, ARRAY_SIZE(__crcu_array),              \
>>                         __crcu_array, __rs_array);                      \
>> } while (0)
>>
>>
>> Any debug ideas or thoughts about it?
>
> I assume it emitted:
>      pr_warn("object is not on stack, but annotated\n");
>

Yes that is the warning.

> before dumping the WARN_ON(). Right? If so, then you might have run into a
> stack corruption. But hard to tell. Please add something like this:
>
>      pr_warn("object %p is not on stack %p, but annotated\n", obj,
>              task_stack_page(current));

Sounds good, I will make this change into android-4.9 kernel for debug
purpose and hopefully the bot hits it soon (that's likely since its
been reported many times). Will let you know once we hit it.

Thanks a lot for the ideas,

- Joel
