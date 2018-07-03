Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAABC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9072486C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHHvVIeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9072486C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752715AbeGCTxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:53:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39853 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeGCTxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:53:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id t7-v6so2490874ljj.6;
        Tue, 03 Jul 2018 12:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=DBl8ZZ3jKyxW9JF20MoCLLu1inet27gXEVzWPwxl3qY=;
        b=AHHvVIeHWybCTOrSu4JG7qG02YpmX0CVF11vByQ1wdbsO9kr+Npc4HXcvy/yZH9GR1
         PtKNzOBiICrZ8cB2oHDF0TpGtNBdZ9IKBTx3IRppqlAIQdwekUMlNnPKHfaRYyY0TKkr
         Yj82wvLNT1lq9sjrw/bpqW/XbliQyz83sgZRrXQzP8TLcYVO79FHjm0yJiLdjCLnUice
         Kjf29NTkibmwl9VtflYOK7UHS4hUWfcEN6hYRp0q0B5Ff6RZN71TOzPvqGV4vPHzDVrk
         53jMb3jgttoMcMEcLz9Tx8WkKjyOAe8i3KBus4XGv2YtgLuS5DIw5taN9M26MQD8cNZI
         cJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=DBl8ZZ3jKyxW9JF20MoCLLu1inet27gXEVzWPwxl3qY=;
        b=GFjt8UKUQhFrHZLGp3VTSCAH5JM9U0AdeJNH43vIFU3iUdT3gaEKPYT/0HUNLCa+Xl
         WK6s32RjfCB2bt/aOVwITxiRABy+a6P0sd+NJgcS+9ZCK7Duyr0k//0FfzMAJv+tO7fS
         KujNHnByJ+S04bU+eujHKD2PoAde25mE+TvaAm8j7UcRkbGpIJPgRQKefv7gQqNSmiGu
         xGOr+m0KGUWp+kxL+47NRkeNnOsbavCDkdbrrmqVYKA0UaYa6IPMXjQtqzeRa1Fjy1EM
         u1pEJofi8LZZFjMjk9Ul+TDq3j9g5yHW9GCTwX2FMi2o6e8byZyyh0sLK0UOtyiei6PX
         IH5Q==
X-Gm-Message-State: APt69E2VZkOM4H8xrvGqDpZylZcXfjkH00UJQDAcQAJ8SGYlGexCau3Q
        dmfzZLG3592jRXQLryikupR4Wn46TKXO/pcOscM=
X-Google-Smtp-Source: AAOMgpfj7kDM+qazUHy7Qz2/Zjb7ldPBQeCSf/xhV9u0LQ+XVhNjhzMGnL4DzE+9b6XReswVxptV35lvDM+WWZTCnxE=
X-Received: by 2002:a2e:9599:: with SMTP id w25-v6mr3666743ljh.6.1530647629007;
 Tue, 03 Jul 2018 12:53:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 12:53:48 -0700 (PDT)
In-Reply-To: <1005fef6031efbee4b5041ee286c053dd97670e6.1530465326.git.ren_guo@c-sky.com>
References: <cover.1530465325.git.ren_guo@c-sky.com> <1005fef6031efbee4b5041ee286c053dd97670e6.1530465326.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 Jul 2018 21:53:48 +0200
X-Google-Sender-Auth: BGtLlUePIZu5vyk73NdX_e5gW1o
Message-ID: <CAK8P3a3djWfXAKBL6WnJb4t5C2bcYGE-JT+zCoefLBUnksduXw@mail.gmail.com>
Subject: Re: [PATCH V2 05/19] csky: System Call
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org,
        Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 1, 2018 at 7:30 PM, Guo Ren <ren_guo@c-sky.com> wrote:
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>

We really need all new architectures to use the generic syscall ABI,
see below for the details.

> diff --git a/arch/csky/include/uapi/asm/unistd.h b/arch/csky/include/uapi/asm/unistd.h
> new file mode 100644
> index 0000000..0ea9b5a
> --- /dev/null
> +++ b/arch/csky/include/uapi/asm/unistd.h
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +#define __ARCH_WANT_OLD_READDIR
> +#define __ARCH_WANT_RENAMEAT
> +#define __ARCH_WANT_STAT64
> +#define __ARCH_WANT_SYS_ALARM
> +#define __ARCH_WANT_SYS_CLONE
> +#define __ARCH_WANT_SYS_FORK
> +#define __ARCH_WANT_SYS_GETHOSTNAME
> +#define __ARCH_WANT_SYS_GETPGRP
> +#define __ARCH_WANT_SYS_IPC
> +#define __ARCH_WANT_SYS_LLSEEK
> +#define __ARCH_WANT_SYS_NICE
> +#define __ARCH_WANT_SYS_OLD_GETRLIMIT
> +#define __ARCH_WANT_SYS_OLDUMOUNT
> +#define __ARCH_WANT_SYS_PAUSE
> +#define __ARCH_WANT_SYS_SIGNAL
> +#define __ARCH_WANT_SYS_SIGPENDING
> +#define __ARCH_WANT_SYS_SIGPROCMASK
> +#define __ARCH_WANT_SYS_SOCKETCALL
> +#define __ARCH_WANT_SYS_TIME
> +#define __ARCH_WANT_SYS_UTIME
> +#define __ARCH_WANT_SYS_VFORK
> +#define __ARCH_WANT_SYS_WAITPID

I think these all need to be removed, with the exception of
__ARCH_WANT_SYS_CLONE. It would be nice though to change
the imlpementation in the kernel so we no longer need to set that
either.

> +#define __NR_set_thread_area   (__NR_arch_specific_syscall + 0)
> +__SYSCALL(__NR_set_thread_area, sys_set_thread_area)
> +#define __NR_ipc               (__NR_arch_specific_syscall + 1)
> +__SYSCALL(__NR_ipc, sys_ipc)
> +#define __NR_socketcall                (__NR_arch_specific_syscall + 2)
> +__SYSCALL(__NR_socketcall, sys_socketcall)
> +#define __NR_ugetrlimit                (__NR_arch_specific_syscall + 3)
> +__SYSCALL(__NR_ugetrlimit, sys_getrlimit)
> +#define __NR_cacheflush                (__NR_arch_specific_syscall + 4)
> +__SYSCALL(__NR_cacheflush, sys_cacheflush)
> +#define __NR_sysfs             (__NR_arch_specific_syscall + 5)
> +__SYSCALL(__NR_sysfs, sys_sysfs)
> +
> +__SYSCALL(__NR_fadvise64_64, sys_csky_fadvise64_64)

We definitely don't want ipc, socketcall, ugetrlimit, or sysfs.

cacheflush is probbably needed.

For fadvise64_64, please redefine the symbol name so the
table points at the right entry.

I'm not completely sure about set_thread_area, can you explain
what you need that for?

> +#define __NR_setgroups32       __NR_setgroups
> +#define __NR_getgid32          __NR_getgid
> +#define __NR_getgroups32       __NR_getgroups
> +#define __NR_setuid32          __NR_setuid
> +#define __NR_setgid32          __NR_setgid
> +#define __NR_getresgid32       __NR_getresgid
> +#define __NR_setfsuid32                __NR_setfsuid
> +#define __NR_setfsgid32                __NR_setfsgid
> +#define __NR_fchown32          __NR_fchown
> +#define __NR_geteuid32         __NR_geteuid
> +#define __NR_getegid32         __NR_getegid
> +#define __NR_getresuid32       __NR_getresuid
> +#define __NR_setresuid32       __NR_setresuid
> +#define __NR_setresgid32       __NR_setresgid
> +#define __NR_setreuid32                __NR_setreuid
> +#define __NR_setregid32                __NR_setregid
> +#define __NR__llseek           __NR_llseek

These should also get removed.

> +struct mmap_arg_struct {
> +       unsigned long addr;
> +       unsigned long len;
> +       unsigned long prot;
> +       unsigned long flags;
> +       unsigned long fd;
> +       unsigned long offset;
> +};
> +
> +SYSCALL_DEFINE1(mmap,
> +       struct mmap_arg_struct *, arg)
> +{
> +       struct mmap_arg_struct a;
> +
> +       if (copy_from_user(&a, arg, sizeof(a)))
> +               return -EINVAL;
> +
> +       if (unlikely(a.offset & ~PAGE_MASK))
> +               return -EINVAL;
> +
> +       return sys_mmap_pgoff(a.addr, a.len, a.prot, a.flags, a.fd, a.offset >> PAGE_SHIFT);
> +}

This can be removed since there is mmap2()

       Arnd
