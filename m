Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268E2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAEF222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406810AbfBNKzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:55:02 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44746 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfBNKzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:55:01 -0500
Received: by mail-ua1-f65.google.com with SMTP id v9so1851925uar.11;
        Thu, 14 Feb 2019 02:55:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0FVphaqkdujewH8xkqyrrOZQTGaRwWmRxSe5PedLOc8=;
        b=ApYz43ByVofkEJWVfKYyk4mg/Hem48JeMOp0K1FrY6011sgPSwT1KcTNuZqFKJKrBw
         Bsinxsz5Ci/BeC5nPX3xTlIfYS9+crpLBE6j+mr3pEpAVhjHr/9r23hFiaPP69kgUAqc
         uZRlR0YhtBuePPAqVn/bXl12oOnV+9YV+8zNPvDm6TFMEc4VNPX+mu6ZEjhUOj41Mghv
         8eiAJ43tzmB3XZ7OkOaTfxh8BxeS+/cyay1b+GwTk1SWVASYYsxQWFs6XQwq0ks1iybT
         uZ/7PIGzcv3tLNXX5EPBXgP0EeamNy9BSuaOA8sekru2j/tZlfToCkK6bioRA5YPdwqy
         mNgA==
X-Gm-Message-State: AHQUAubkNxFKl5hZ2Vaa8JTysdtdBdznb0W2d+q/l2bf9Zd6dXHR2UqM
        B83TDzlO+m9XWOpftQCwppQqjFWsmVtZwQm35G5gF8fz
X-Google-Smtp-Source: AHgI3IbzhzuzEySYHwSbJTqDaXLapQMTOW53oPTxOn4RxgH5lrV4tpWGJZxYzqt5buLzgH3+IW1GydrsaXAApWWXHYU=
X-Received: by 2002:a9f:2726:: with SMTP id a35mr1587802uaa.75.1550141699426;
 Thu, 14 Feb 2019 02:54:59 -0800 (PST)
MIME-Version: 1.0
References: <1550095217-12047-1-git-send-email-longman@redhat.com> <1550095217-12047-3-git-send-email-longman@redhat.com>
In-Reply-To: <1550095217-12047-3-git-send-email-longman@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Feb 2019 11:54:47 +0100
Message-ID: <CAMuHMdVe9J4LmbLz8nHsW2JSVt8EQHTKswtc+-53pD-DBxgwSw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] locking/rwsem: Remove rwsem-spinlock.c & use
 rwsem-xadd.c for all archs
To:     Waiman Long <longman@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-mips@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-c6x-dev@linux-c6x.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
        linux-um@lists.infradead.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        nios2-dev@lists.rocketboards.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 11:01 PM Waiman Long <longman@redhat.com> wrote:
> Currently, we have two different implementation of rwsem:
>  1) CONFIG_RWSEM_GENERIC_SPINLOCK (rwsem-spinlock.c)
>  2) CONFIG_RWSEM_XCHGADD_ALGORITHM (rwsem-xadd.c)
>
> As we are going to use a single generic implementation for rwsem-xadd.c
> and no architecture-specific code will be needed, there is no point
> in keeping two different implementations of rwsem. In most cases, the
> performance of rwsem-spinlock.c will be worse. It also doesn't get all
> the performance tuning and optimizations that had been implemented in
> rwsem-xadd.c over the years.
>
> For simplication, we are going to remove rwsem-spinlock.c and make all
> architectures use a single implementation of rwsem - rwsem-xadd.c.
>
> All references to RWSEM_GENERIC_SPINLOCK and RWSEM_XCHGADD_ALGORITHM
> in the code are removed.
>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Waiman Long <longman@redhat.com>

Note that this conflicts with "[PATCH 03/11] kernel/locks: consolidate
RWSEM_GENERIC_* options"
https://lore.kernel.org/lkml/20190213174005.28785-4-hch@lst.de/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
