Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeEGAqV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 20:46:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33704 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbeEGAqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 20:46:18 -0400
X-Google-Smtp-Source: AB8JxZrfR8Ftip8/oVlm2g4IBj4lhE+QWFTYyEK5Y56/0COYNbGFSHp9vzcVEDf7tHGwBaUTG0beNAM60frzdoVI0xM=
MIME-Version: 1.0
References: <1525634395-23380-1-git-send-email-frederic@kernel.org> <1525634395-23380-9-git-send-email-frederic@kernel.org>
In-Reply-To: <1525634395-23380-9-git-send-email-frederic@kernel.org>
From: Joel Fernandes <joel.opensrc@gmail.com>
Date: Mon, 07 May 2018 00:46:06 +0000
Message-ID: <CAEi0qNkSUig2i92qEpPekO1Z0kDTVB+95UKbJy5b+9YKQHfciA@mail.gmail.com>
Subject: Re: [PATCH 8/9] perf/breakpoint: Split breakpoint "check" and "commit"
To: frederic@kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jolsa@redhat.com, namhyung@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, torvalds@linux-foundation.org,
        ysato@users.sourceforge.jp, benh@kernel.crashing.org,
        Catalin Marinas <catalin.marinas@arm.com>, chris@zankel.net,
        paulus@samba.org, Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, mpe@ellerman.id.au, dalias@libc.org,
        Ingo Molnar <mingo@kernel.org>, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, luto@kernel.org, acme@kernel.org,
        jcmvbkbc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 6, 2018 at 12:22 PM Frederic Weisbecker <frederic@kernel.org>
wrote:

> arch_validate_hwbkpt_settings() mixes up attribute check and commit into
> a single code entity. Therefore the validation may return an error due to
> incorrect atributes while still leaving halfway modified architecture
> breakpoint struct.

> Now that we have split its logic on all archs, we can remove this
> misdesigned function and call directly the arch check and commit
> functions instead. This allows us to later avoid commiting
> a breakpoint to architecture when its slot couldn't be allocated.

[...]
> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 6e28d28..6896ceeb 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -402,11 +402,12 @@ int dbg_release_bp_slot(struct perf_event *bp)

>   static int validate_hw_breakpoint(struct perf_event *bp)
>   {
> -       int ret;
> +       int err;

> -       ret = arch_validate_hwbkpt_settings(bp);
> -       if (ret)
> -               return ret;
> +       err = hw_breakpoint_arch_check(bp, &bp->attr);
> +       if (err)
> +               return err;
> +       hw_breakpoint_arch_commit(bp);

minor nit:
To preserve bisectability, shouldn't this be the following in this and
earlier patches?

        err = hw_breakpoint_arch_check(bp, &bp->attr);
        hw_breakpoint_arch_commit(bp);
        if (err)
                return err;

And then in patch 9/9 you can fix it the right way?

thanks,

- Joel
