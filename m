Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28E9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963E62084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfBYJCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 04:02:04 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40225 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfBYJCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 04:02:04 -0500
Received: by mail-qt1-f196.google.com with SMTP id j36so9572114qta.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 01:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rRdZb8cJTcFYLFAEEDDZDp2BVgzzQ1jv5NyCWR1kpT4=;
        b=H98DuragftgiTZTHHXmEQgN7npNrLQa7AUPMH2IT0+fttr1CvmRQgy+VIxtQD3seI9
         2DqH+BewGwujMjB1BodQfMV3cR8Y0KiqfVTHBeMB/6nSixhsOuqJY98w1mezA+M3WzaZ
         mjkj5QtNl9+GBR/ts1kMCz/lzHPx8CIjYZUz00EWUugFgzoCeyycIMBIl3pI29HOL9J/
         1qNi5E3yUlEOfgcuuoUCRgqXV0RUxm9Ym2PK74juTqgLeBgU4YyZgy65RTOZVIWyYiC/
         WAHeN5CCJmL2nUbrL/Vd8ztO0KfUbr+9TjX8rJq8d9AwoTq5GeoGix+5mJ6e+7jF3rZg
         nz/Q==
X-Gm-Message-State: AHQUAuZFQSXn8n1bkUGemyHbb7BgeIeUJu29gblLYVf7C4YpGaDKAWwQ
        7IpaKOnno9+e60OqFX3k3lqCLmn9ZHjcPQ0Xpn4=
X-Google-Smtp-Source: AHgI3IbQ0D/4iMCMZ6TzBn/taVzkzXmgdn1rHTy8g8laMYrqw+yWzxWB/JoXVpzLU0/QbcXXLqsh3ZVDeK8W+2PNsK0=
X-Received: by 2002:ac8:3251:: with SMTP id y17mr7415452qta.152.1551085322843;
 Mon, 25 Feb 2019 01:02:02 -0800 (PST)
MIME-Version: 1.0
References: <20190225032619.17070-1-yaohongbo@huawei.com> <CABeXuvqOEqN7fRa1pkLKNhNckoUpCoyxKRdieD+UE8DFt+yQ+g@mail.gmail.com>
In-Reply-To: <CABeXuvqOEqN7fRa1pkLKNhNckoUpCoyxKRdieD+UE8DFt+yQ+g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Feb 2019 10:01:46 +0100
Message-ID: <CAK8P3a0N7BpMwXfGtVcH3L40VqmPypvemPUC8_SEwSUinG-B8A@mail.gmail.com>
Subject: Re: [PATCH] time64: Avoid undefined behaviour in timespec64_add()
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Hongbo Yao <yaohongbo@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 5:53 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> On Sun, Feb 24, 2019 at 7:13 PM Hongbo Yao <yaohongbo@huawei.com> wrote:
> >
> > I ran into this:
> >         =========================================================================
> >         UBSAN: Undefined behaviour in ./include/linux/time64.h:70:2
> >         signed integer overflow:
> >         1551059291 + 9223372036854775807 cannot be represented in type 'long
> >         long int'
> >         CPU: 5 PID: 20064 Comm: syz-executor.2 Not tainted 4.19.24 #4
> >         Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> >         1.10.2-1ubuntu1 04/01/2014
> >         Call Trace:
> >          __dump_stack lib/dump_stack.c:77 [inline]
> >          dump_stack+0xca/0x13e lib/dump_stack.c:113
> >          ubsan_epilogue+0xe/0x81 lib/ubsan.c:159
> >          handle_overflow+0x193/0x1e2 lib/ubsan.c:190
> >          timespec64_add include/linux/time64.h:70 [inline]
...
> > Since lhs.tv_sec and rhs.tv_sec are both time64_t, this is a signed
> > addition which will cause undefined behaviour on overflow.

I wonder if we should treat this as undefined behavior in the kernel or not:
The kernel is build with -fno-strict-overflow, so signed integer overflow
is supposed to behave the same way as unsigned, and assume
two's-complement arithmetic.

> > @@ -67,7 +67,7 @@ static inline struct timespec64 timespec64_add(struct timespec64 lhs,
> >                                                 struct timespec64 rhs)
> >  {
> >         struct timespec64 ts_delta;
> > -       set_normalized_timespec64(&ts_delta, lhs.tv_sec + rhs.tv_sec,
> > +       set_normalized_timespec64(&ts_delta, (timeu64_t)lhs.tv_sec + rhs.tv_sec,
> >                                 lhs.tv_nsec + rhs.tv_nsec);
> >         return ts_delta;
> >  }
>
> There is already a timespec64_add_safe() to account for such
> overflows. That assumes both the timespec64 values are positive.
> But, timekeeping_inject_offset() cannot use that as one of the values
> can be negative.

We could perhaps extend timespec64_add_safe() to handle both
overflow and underflow, and allow negative arguments. It would
have to use some extra checks then. There are actually only
a very small number of callers to timespec64_add():

arch/arm/xen/enlighten.c:       *ts = timespec64_add(now, ts_monotonic);
arch/arm/xen/enlighten.c:       system_time = timespec64_add(now,
tk->wall_to_monotonic);
drivers/net/ethernet/cadence/macb_ptp.c:                now =
timespec64_add(now, then);
drivers/net/ethernet/intel/igb/igb_main.c:              ts =
timespec64_add(adapter->perout[0].start,
drivers/net/ethernet/intel/igb/igb_main.c:              ts =
timespec64_add(adapter->perout[1].start,
drivers/net/ethernet/intel/igb/igb_ptp.c:       now = timespec64_add(now, then);
fs/cifs/dfs_cache.c:    return timespec64_add(now, ts);
include/linux/rtc.h:    *to_set = timespec64_add(*now, delay);
include/linux/time64.h:static inline struct timespec64
timespec64_add(struct timespec64 lhs,
kernel/time/timekeeping.c:      tmp = timespec64_add(tk_xtime(tk), *ts);
kernel/time/timekeeping.c:
timespec64_add(timekeeping_suspend_time, delta_delta);
net/ceph/messenger.c:           ts =
timespec64_add(con->last_keepalive_ack, ts);

It looks like an actual overflow would be really bad in most of these,
regardless
of the undefined behavior.

> Are you running some kind of a fuzzer that would cause a overflow?
> You seem to be adding INT64_MAX here. Maybe the right thing to do is
> to add a check at the syscall interface rather than here.

Returning an error from the syscall here sounds like a good idea. I'm
not sure what we should do about the time32 version of adjtimex though
if we decide we want that. Should we just reject any times there that
result in a time outside of the 1970..2038 range?

      Arnd
