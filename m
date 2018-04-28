Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933237AbeD1DFT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 23:05:19 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:42316 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759316AbeD1DFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 23:05:18 -0400
X-Google-Smtp-Source: AB8JxZpxpHGSZCpzeRv9m+sZfjUqPr/IaqyCLN32Z8rUFS4JnQiXahLBgWMx6MjSs222UqSOD8h+30QOCRJHf694aXY=
MIME-Version: 1.0
In-Reply-To: <1524866145-20337-1-git-send-email-jhugo@codeaurora.org>
References: <1524866145-20337-1-git-send-email-jhugo@codeaurora.org>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 27 Apr 2018 20:05:16 -0700
X-Google-Sender-Auth: yHprDh0MSGo7eE3_dbCof1L1yzo
Message-ID: <CAGXu5jKL2AqVhQ7ghVuBTVh9aWBbu8iWn0GPf=nhKi8_QbwTkw@mail.gmail.com>
Subject: Re: [PATCH v2] init: Fix false positives in W+X checking
To: Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jan Glauber <jan.glauber@caviumnetworks.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Laura Abbott <labbott@redhat.com>,
        Timur Tabi <timur@codeaurora.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 2:55 PM, Jeffrey Hugo <jhugo@codeaurora.org> wrote:
> load_module() creates W+X mappings via __vmalloc_node_range() (from
> layout_and_allocate()->move_module()->module_alloc()) by using
> PAGE_KERNEL_EXEC.  These mappings are later cleaned up via
> "call_rcu_sched(&freeinit->rcu, do_free_init)" from do_init_module().
>
> This is a problem because call_rcu_sched() queues work, which can be run
> after debug_checkwx() is run, resulting in a race condition.  If hit, the
> race results in a nasty splat about insecure W+X mappings, which results
> in a poor user experience as these are not the mappings that
> debug_checkwx() is intended to catch.
>
> This issue is observed on multiple arm64 platforms, and has been
> artificially triggered on an x86 platform.
>
> Address the race by flushing the queued work before running the
> arch-defined mark_rodata_ro() which then calls debug_checkwx().
>
> Reported-by: Timur Tabi <timur@codeaurora.org>
> Reported-by: Jan Glauber <jan.glauber@caviumnetworks.com>
> Fixes: e1a58320a38d ("x86/mm: Warn on W^X mappings")
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>
> v1:
> -was "arm64: mm: Fix false positives in W+X checking" (see [1])
> -moved to common code based on review and confirmation of issue on x86
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/573776.html
>
>  init/main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/init/main.c b/init/main.c
> index b795aa3..499d957 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1034,6 +1034,13 @@ static int __init set_debug_rodata(char *str)
>  static void mark_readonly(void)
>  {
>         if (rodata_enabled) {
> +               /*
> +                * load_module() results in W+X mappings, which are cleaned up
> +                * with call_rcu_sched().  Let's make sure that queued work is
> +                * flushed so that we don't hit false positives looking for
> +                * insecure pages which are W+X.
> +                */
> +               rcu_barrier_sched();
>                 mark_rodata_ro();
>                 rodata_test();
>         } else
> --
> Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
>



-- 
Kees Cook
Pixel Security
