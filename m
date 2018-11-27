Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B6CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8292081C
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OK1IWfnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8292081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbeK1JjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:39:01 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:45546 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeK1JjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 04:39:01 -0500
Received: by mail-yb1-f194.google.com with SMTP id f6-v6so8364695ybg.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 14:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NxITfNr4WDj4p/Blz329SZtDaO7tLUgklUW4qMDW1Wo=;
        b=OK1IWfnZpSIB1TV2W+OSxc1gkr9sJB5O0vosQxLnm5n56rZmXbqHenav8wOvLkLTln
         ptTVDv5uo0IP6YjcUjmX1V3NawC1oR7fF0KpKFU0CN1HLHH/Ef2IaXQp07FccY+D/mrV
         xWTnIgkOtx++B61iqlEh9YepEM9o0KRstQgB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NxITfNr4WDj4p/Blz329SZtDaO7tLUgklUW4qMDW1Wo=;
        b=bQF/vIBBvKPsiCijiyHSRspYBy7McbAK6xOXEjRJ/k5veQt6Fl8aIyHnRdPXb5OudL
         R78MMLN1jCk95qPzz1X9TJRR3NICYYnDY/W7nmfPVxh8l6Q5yrQylpBVNvbLm5CQZb9K
         S9ZuCFoSYANCOBU81JcjSuWzRYfMqu/eLOprvGsJSCrya9GCrvQQbtL2XfYFR2dd358i
         lrW44IJ2kKekrYNu4GXQY4WB78LnJMv5I+m+vfGXIktZUQfnAxOIPt3YUD4K6RrNdsDa
         z4XcxPsJP9vxp/LFJhGCZPEyLxGhxguAdd+53pglRa6vQC7kBFGMOrFEakbHW4V6lb7/
         JyUA==
X-Gm-Message-State: AGRZ1gLu2+JVP2LutaBTV7vCaTMQ0USbwTRt1dG0iUXX98cEfMYyadkA
        1SLLEy/y5gVO2LbwKsw1lH7r7iSCwj4=
X-Google-Smtp-Source: AFSGD/VyufwwezGqNExaEb/a8W7+NMjJOlXl9X2NgjkcKslMyfSyFDK/9T5Hyu7JfSrfi9Ms9s7SGQ==
X-Received: by 2002:a25:b7d0:: with SMTP id u16-v6mr36603096ybj.353.1543358376236;
        Tue, 27 Nov 2018 14:39:36 -0800 (PST)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id b190-v6sm1325801ywf.57.2018.11.27.14.39.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 14:39:34 -0800 (PST)
Received: by mail-yw1-f51.google.com with SMTP id x2so9875289ywc.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 14:39:33 -0800 (PST)
X-Received: by 2002:a81:29cc:: with SMTP id p195mr31858042ywp.407.1543358372781;
 Tue, 27 Nov 2018 14:39:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Tue, 27 Nov 2018 14:39:32
 -0800 (PST)
In-Reply-To: <e7952089a66db4e5d59d2af230a324155bb018a0.1542955914.git.dongsheng.wang@hxt-semitech.com>
References: <e7952089a66db4e5d59d2af230a324155bb018a0.1542955914.git.dongsheng.wang@hxt-semitech.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 27 Nov 2018 14:39:32 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKTQK2BGYefNXkW=-=svzhnqP4Pho3jK+mORAjDxgnsRA@mail.gmail.com>
Message-ID: <CAGXu5jKTQK2BGYefNXkW=-=svzhnqP4Pho3jK+mORAjDxgnsRA@mail.gmail.com>
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
        Shunyong Yang <shunyong.yang@hxt-semitech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 11:54 PM, Wang Dongsheng
<dongsheng.wang@hxt-semitech.com> wrote:
> When select ARCH_TASK_STRUCT_ON_STACK the first of thread_info variable
> is overwritten by STACK_END_MAGIC. In fact, the ARCH_TASK_STRUCT_ON_STACK
> is not a real task on stack, it's only init_task on init_stack.
>
> Commit 0500871f21b2 ("Construct init thread stack in the linker script
> rather than by union") added this macro and put task_strcut into
> thread_union. This brings us the following possibilities:
>     TASK_ON_STACK    THREAD_INFO_IN_TASK    STACK
>                                             ----- <-- thread_info & stack
>         N                    N             |     |     --- <-- task
>                                            |     |    |   |
>                                             -----      ---
>
>                                             ----- <-- stack
>         N                    Y             |     |     --- <-- task(Including thread_info)
>                                            |     |    |   |
>                                             -----      ---
>
>                                             ----- <-- stack & task & thread_info
>         Y                    N             |     |
>                                            |     |
>                                             -----
>
>                                             ----- <-- stack & task(Including thread_info)
>         Y                    Y             |     |
>                                            |     |
>                                             -----
> The kernel has handled the first two cases correctly.
>
> For the third case:
> TASK_ON_STACK: Y. THREAD_INFO_IN_TASK: N. this case
> should never happen, because the task and thread_info will overlap. So
> when TASK_ON_STACK is selected, THREAD_INFO_IN_TASK must be selected too.
>
> For the fourth case:
> When task on stack, the end of stack should add a sizeof(task_struct) offset.
>
> This patch handled with the third and fourth case.
>
> Fixes: 0500871f21b2 ("Construct init thread stack in the linker ...")
>
> Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
> Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> ---
>  arch/Kconfig                     | 1 +
>  include/linux/sched/task_stack.h | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index e1e540ffa979..0a2c73e73195 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -251,6 +251,7 @@ config ARCH_HAS_SET_MEMORY
>  # Select if arch init_task must go in the __init_task_data section
>  config ARCH_TASK_STRUCT_ON_STACK
>         bool
> +       depends on THREAD_INFO_IN_TASK || IA64

The "IA64" part shouldn't be needed since IA64 already selects it.

Since it's selected, it also can't have a depends, IIUC.

>
>  # Select if arch has its private alloc_task_struct() function
>  config ARCH_TASK_STRUCT_ALLOCATOR
> diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
> index 6a841929073f..624c48defb9e 100644
> --- a/include/linux/sched/task_stack.h
> +++ b/include/linux/sched/task_stack.h
> @@ -7,6 +7,7 @@
>   */
>
>  #include <linux/sched.h>
> +#include <linux/sched/task.h>
>  #include <linux/magic.h>
>
>  #ifdef CONFIG_THREAD_INFO_IN_TASK
> @@ -25,7 +26,9 @@ static inline void *task_stack_page(const struct task_struct *task)
>
>  static inline unsigned long *end_of_stack(const struct task_struct *task)
>  {
> -       return task->stack;
> +       if (!IS_ENABLED(CONFIG_ARCH_TASK_STRUCT_ON_STACK) || task != &init_task)
> +               return task->stack;
> +       return (unsigned long *)(task + 1);
>  }

This seems like a strange place for the change. It feels more like
init_task has been defined incorrectly.

-Kees

>
>  #elif !defined(__HAVE_THREAD_FUNCTIONS)
> --
> 2.19.1
>



-- 
Kees Cook
