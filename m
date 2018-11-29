Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF92C64EB7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD6C2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jvsuz5Uu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD6C2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeK3IaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:30:07 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34920 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbeK3IaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:30:07 -0500
Received: by mail-yb1-f193.google.com with SMTP id z2-v6so1370212ybj.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 13:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YtoLozhvB0D+lgZptg5qUvSEZyHcmvewXAqhj2dfoE0=;
        b=jvsuz5Uu68fEiCCQNY6X0pt0z/EtGwn55vaHbFbVLom8SbDI2SCjQBtDpF1iyMSNQy
         LXDjDBqesWxNaJOEKQtu3viROU6ShMythG+NbhcKAIrqfDhbLKXWfr4NrP0eIjMBayT5
         b+EVE4Jr646hvzMQXmpVBiEAcx5ErfWWNiVPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YtoLozhvB0D+lgZptg5qUvSEZyHcmvewXAqhj2dfoE0=;
        b=lAywHmUwTDw/ZIrlFfSFm2mtGTG96I7fsTnf1wfiLxkpsZk+WTcCNLDv1639Wmbwjc
         nuQpHaKtfPggUa4Blya+BMUcwrnNkKdVqyyFKuEY7/dkH9fLAZvjKa/ljLaizG9Mwt0M
         pNzcoXmymljBSTWy/Kd3EUL97N/slDKVjGWGcAXbBvtStbtqGYEDFYT1AerOC17jjKpG
         PiamogdSwhS/SAIiv3AqnnM+o1FBNzbXxqBohfkch9O2AtOtIBwvb56PpK8gs5OErWUR
         BGEKG9goVIV0mxlkib1y8QNLMOCaedPpj9iyKr97fJ5YiLZI+XQrMZvPe4qw1n7GR68x
         W95w==
X-Gm-Message-State: AA+aEWZKTPOZ5QXdZswE9+8joL2C1WGrt/PCr3b7RzaUxCdavLvrkYWm
        cN3lMQeRyelPp2EelkqsShXp5hnZxYI=
X-Google-Smtp-Source: AFSGD/W4gn7flLAUWPzNVhCs0HZThA1MfwcX0dfxWrg+iDtyOOrCX5nvJYop6wFso4kUb34TTK0weA==
X-Received: by 2002:a25:2206:: with SMTP id i6-v6mr2955979ybi.151.1543526598998;
        Thu, 29 Nov 2018 13:23:18 -0800 (PST)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id w77sm1102578ywa.9.2018.11.29.13.23.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 13:23:17 -0800 (PST)
Received: by mail-yw1-f42.google.com with SMTP id y194so1402858ywg.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 13:23:17 -0800 (PST)
X-Received: by 2002:a81:2890:: with SMTP id o138mr3289037ywo.168.1543526597070;
 Thu, 29 Nov 2018 13:23:17 -0800 (PST)
MIME-Version: 1.0
References: <e7952089a66db4e5d59d2af230a324155bb018a0.1542955914.git.dongsheng.wang@hxt-semitech.com>
 <CAGXu5jKTQK2BGYefNXkW=-=svzhnqP4Pho3jK+mORAjDxgnsRA@mail.gmail.com> <19391812db6444f3bd260546acded9b7@HXTBJIDCEMVIW02.hxtcorp.net>
In-Reply-To: <19391812db6444f3bd260546acded9b7@HXTBJIDCEMVIW02.hxtcorp.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 29 Nov 2018 13:23:05 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJg+rfDi1VuiaevPSkaZidjmEC2au9yJR6n6rWJR-qcsg@mail.gmail.com>
Message-ID: <CAGXu5jJg+rfDi1VuiaevPSkaZidjmEC2au9yJR6n6rWJR-qcsg@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched/headers: fix thread_info.<first> is overwritten
 by STACK_END_MAGIC
To:     Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Cc:     David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>, yu.zheng@hxt-semitech.com,
        LKML <linux-kernel@vger.kernel.org>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 8:38 PM Wang, Dongsheng
<dongsheng.wang@hxt-semitech.com> wrote:
>
> Hello Kees,
>
> On 2018/11/28 6:38, Kees Cook wrote:
> > On Thu, Nov 22, 2018 at 11:54 PM, Wang Dongsheng
> > <dongsheng.wang@hxt-semitech.com> wrote:
> >> When select ARCH_TASK_STRUCT_ON_STACK the first of thread_info variable
> >> is overwritten by STACK_END_MAGIC. In fact, the ARCH_TASK_STRUCT_ON_STACK
> >> is not a real task on stack, it's only init_task on init_stack.
> >>
> >> Commit 0500871f21b2 ("Construct init thread stack in the linker script
> >> rather than by union") added this macro and put task_strcut into
> >> thread_union. This brings us the following possibilities:
> >>     TASK_ON_STACK    THREAD_INFO_IN_TASK    STACK
> >>                                             ----- <-- thread_info & stack
> >>         N                    N             |     |     --- <-- task
> >>                                            |     |    |   |
> >>                                             -----      ---
> >>
> >>                                             ----- <-- stack
> >>         N                    Y             |     |     --- <-- task(Including thread_info)
> >>                                            |     |    |   |
> >>                                             -----      ---
> >>
> >>                                             ----- <-- stack & task & thread_info
> >>         Y                    N             |     |
> >>                                            |     |
> >>                                             -----
> >>
> >>                                             ----- <-- stack & task(Including thread_info)
> >>         Y                    Y             |     |
> >>                                            |     |
> >>                                             -----
> >> The kernel has handled the first two cases correctly.
> >>
> >> For the third case:
> >> TASK_ON_STACK: Y. THREAD_INFO_IN_TASK: N. this case
> >> should never happen, because the task and thread_info will overlap. So
> >> when TASK_ON_STACK is selected, THREAD_INFO_IN_TASK must be selected too.
> >>
> >> For the fourth case:
> >> When task on stack, the end of stack should add a sizeof(task_struct) offset.
> >>
> >> This patch handled with the third and fourth case.
> >>
> >> Fixes: 0500871f21b2 ("Construct init thread stack in the linker ...")
> >>
> >> Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
> >> Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> >> ---
> >>  arch/Kconfig                     | 1 +
> >>  include/linux/sched/task_stack.h | 5 ++++-
> >>  2 files changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/Kconfig b/arch/Kconfig
> >> index e1e540ffa979..0a2c73e73195 100644
> >> --- a/arch/Kconfig
> >> +++ b/arch/Kconfig
> >> @@ -251,6 +251,7 @@ config ARCH_HAS_SET_MEMORY
> >>  # Select if arch init_task must go in the __init_task_data section
> >>  config ARCH_TASK_STRUCT_ON_STACK
> >>         bool
> >> +       depends on THREAD_INFO_IN_TASK || IA64
> > The "IA64" part shouldn't be needed since IA64 already selects it.
> >
> > Since it's selected, it also can't have a depends, IIUC.
>
> Since the IA64 thread_info including task_struct, it doesn't need to
> select THREAD_INFO_IN_TASK.
> So we need to allow IA64 select ARCH_TASK_STRUCT_ON_STACK without
> THREAD_INFO.

Okay.

> >>  # Select if arch has its private alloc_task_struct() function
> >>  config ARCH_TASK_STRUCT_ALLOCATOR
> >> diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
> >> index 6a841929073f..624c48defb9e 100644
> >> --- a/include/linux/sched/task_stack.h
> >> +++ b/include/linux/sched/task_stack.h
> >> @@ -7,6 +7,7 @@
> >>   */
> >>
> >>  #include <linux/sched.h>
> >> +#include <linux/sched/task.h>
> >>  #include <linux/magic.h>
> >>
> >>  #ifdef CONFIG_THREAD_INFO_IN_TASK
> >> @@ -25,7 +26,9 @@ static inline void *task_stack_page(const struct task_struct *task)
> >>
> >>  static inline unsigned long *end_of_stack(const struct task_struct *task)
> >>  {
> >> -       return task->stack;
> >> +       if (!IS_ENABLED(CONFIG_ARCH_TASK_STRUCT_ON_STACK) || task != &init_task)
> >> +               return task->stack;
> >> +       return (unsigned long *)(task + 1);
> >>  }
> > This seems like a strange place for the change. It feels more like
> > init_task has been defined incorrectly.
>
> The init_task will put into init_stack when ARCH_TASK_STRUCT_ON_STACK is
> selected.
> include/asm-generic/vmlinux.lds.h:
> #define INIT_TASK_DATA(align)                        \
>     . = ALIGN(align);                        \
>     __start_init_task = .;                        \
>     init_thread_union = .;                        \
>     init_stack = .;                            \
>     KEEP(*(.data..init_task))                    \
>     KEEP(*(.data..init_thread_info))                \
>     . = __start_init_task + THREAD_SIZE;                \
>     __end_init_task = .;
>
> So we need end_of_stack to offset sizeof(task_struct).

Well, I guess I mean I'd rather the end_of_stack() code not be
special-cased in the if. The default should be how it was. Perhaps:

if (IS_ENABLED(CONFIG_ARCH_TASK_STRUCT_ON_STACK) && task == &init_task)
    return (unsigned long *)(task + 1);
return task->stack;

But it still feels strange: why can't task->stack point to the correct
place in this special case?

-- 
Kees Cook
