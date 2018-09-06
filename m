Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B295FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D09206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D09206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbeIFSqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:46:50 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34829 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbeIFSqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:46:50 -0400
Received: by mail-qt0-f193.google.com with SMTP id j7-v6so12404782qtp.2;
        Thu, 06 Sep 2018 07:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z3oM06lmWNJgiB/R5oFcZh9AMqGJwo4dOOsATyJhVGo=;
        b=qQlekQPG3q/l3XGdG0Av0YcGCsRtNXqozObYMGZGDV9dnlQcbNQYWdJ2D5Oag3Q8Lj
         ii+iwWoAVqhgHzM6dsSdeFJSFdWXyqD2y63jAgZ6mBOnXarqVS+fykFwZsyjuftgvumq
         BWynF7f7sEczOo6PfflJcHdbyoTYT/o4v3qMN67HVY46ink798hmEUTrh2dvAWkDVJYk
         rDw5SlvK9HAOY3KnzoOWHiWQW1hgQ2j8wOuUkjGLPi++W2BxrgMKRmXjOwJ82WIoYfUL
         Upp0FElAJ8dxdRWfng8wveJdwjUGGq8vl0GCQJkCVDDRtVTh0VLG49McwgwOfzDvPf/c
         O4TQ==
X-Gm-Message-State: APzg51AEAz3iFIVXZYcmt2BmpH2J2bwZCVo4PUsqopOYlMH3/5grr2Ud
        3oJcY02z2kTvDlqkSz27fhaINLBwxMsyZ8FzqzwGhILa
X-Google-Smtp-Source: ANB0Vdac+IiqzzY55VNt+/qlwznXAGJV8LuUQAjo8EYwtwjoiWf/z6VT/W6JkehgvRtIhqmjAFvt6PJFOWP/YpA6W6U=
X-Received: by 2002:a0c:885b:: with SMTP id 27-v6mr2188732qvm.115.1536243065551;
 Thu, 06 Sep 2018 07:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536138304.git.ren_guo@c-sky.com> <bff609c9d2c5f0085448cc7d4227614ab7b7116a.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <bff609c9d2c5f0085448cc7d4227614ab7b7116a.1536138304.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Sep 2018 16:10:49 +0200
Message-ID: <CAK8P3a1W5yvymAHKLTP5EwLm_usUqVBBE_86pRp0TmxrTiTfjA@mail.gmail.com>
Subject: Re: [PATCH V3 05/26] csky: System Call
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:

> +SYSCALL_DEFINE6(mmap2,
> +       unsigned long, addr,
> +       unsigned long, len,
> +       unsigned long, prot,
> +       unsigned long, flags,
> +       unsigned long, fd,
> +       off_t, offset)
> +{
> +       if (unlikely(offset & (~PAGE_MASK >> 12)))
> +               return -EINVAL;
> +       return sys_mmap_pgoff(addr, len, prot, flags, fd,
> +               offset >> (PAGE_SHIFT - 12));
> +}

Please call ksys_mmap_pgoff() instead of sys_mmap_pgoff() here.

The prototype in include/asm-generic/syscalls.h uses 'unsigned long'
for the last argument as well, not off_t.

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

Something is still wrong here, there should be no way to
call sys_mmap(), since it's not in the syscall table.

> +/*
> + * for abiv1 the 64bits args should be even th, So we need mov the advice forward.
> + */
> +SYSCALL_DEFINE4(csky_fadvise64_64,
> +       int, fd,
> +       int, advice,
> +       loff_t, offset,
> +       loff_t, len)
> +{
> +       return sys_fadvise64_64(fd, offset, len, advice);
> +}

And call ksys_fadvise64_64() here.

> +#undef __SYSCALL
> +#define __SYSCALL(nr, call) [nr] = (call),
> +
> +#define sys_fadvise64_64 sys_csky_fadvise64_64
> +void * const sys_call_table[__NR_syscalls] __page_aligned_data = {
> +       [0 ... __NR_syscalls - 1] = sys_ni_syscall,
> +#include <asm/unistd.h>
> +};

This looks good now.

       Arnd
