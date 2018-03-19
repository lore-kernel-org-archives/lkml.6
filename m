Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967320AbeCSQrK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 12:47:10 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:41955 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964999AbeCSQpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 12:45:55 -0400
X-Google-Smtp-Source: AG47ELsTjNf6OKrKcCi9ymDFDYgkI9cEjx+qy5acvo6ycX6BGbHmv7QNC93nW3LEzrCm1fjfP3mMZGqMCQ82LiTL6Xg=
MIME-Version: 1.0
In-Reply-To: <20180315123202.365696346@infradead.org>
References: <20180315121902.942902000@infradead.org> <20180315123202.365696346@infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 19 Mar 2018 09:45:54 -0700
Message-ID: <CAPcyv4hu+6-dO+ncM0U4EHwUW_TyoNu1zngVzne0x8rVEa0p2w@mail.gmail.com>
Subject: Re: [PATCH 01/11] sched/wait: Introduce wait_var_event()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Chris Mason <clm@fb.com>, Anna Schumaker <anna.schumaker@netapp.com>,
        Joel Becker <jlbec@evilplan.org>, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        George Spelvin <linux@sciencehorizons.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 5:19 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> As a replacement for the wait_on_atomic_t() API provide the
> wait_var_event() API.
>
> The wait_var_event() API is based on the very same hashed-waitqueue
> idea, but doesn't care about the type (atomic_t) or the specific
> condition (atomic_read() == 0). IOW. it's much more widely
> applicable/flexible.
>
> It shares all the benefits/disadvantages of a hashed-waitqueue
> approach with the existing wait_on_atomic_t/wait_on_bit() APIs.
>
> The API is modeled after the existing wait_event() API, but instead of
> taking a wait_queue_head, it takes an address. This addresses is
> hashed to obtain a wait_queue_head from the bit_wait_table.
>
> Similar to the wait_event() API, it takes a condition expression as
> second argument and will wait until this expression becomes true.
>
> The following are (mostly) identical replacements:
>
>   wait_on_atomic_t(&my_atomic, atomic_t_wait, TASK_UNINTERRUPTIBLE);
>   wake_up_atomic_t(&my_atomic);
>
>   wait_var_event(&my_atomic, !atomic_read(&my_atomic));
>   wake_up_var(&my_atomic);
>
> The only difference is that wake_up_var() is an unconditional wakeup
> and doesn't check the previously hard-coded (atomic_read() == 0)
> condition here. This is of little concequence, since most callers are
> already conditional on atomic_dec_and_test() and the ones that are
> not, are trivial to make so.
>
> Cc: David Howells <dhowells@redhat.com>
> Tested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/wait_bit.h |   70 +++++++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/wait_bit.c  |   48 ++++++++++++++++++++++++++++++++
>  2 files changed, 118 insertions(+)

Hi Peter,

Is this commit ready to hit tip/sched/core? I'm looking for an
immutable branch that I can use as a basis for the "dax vs dma vs
truncate" fix series.

Thanks in advance.
