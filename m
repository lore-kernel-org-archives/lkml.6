Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DDFC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA94218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfAYS6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:58:44 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38402 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfAYS6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:58:43 -0500
Received: by mail-vs1-f68.google.com with SMTP id x64so6282352vsa.5;
        Fri, 25 Jan 2019 10:58:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N6RKkHGUj8bJmjQqZYjUAS/y/wKQvr/C0iGdIoMKGek=;
        b=GFBc6NKcfybaEa/dK/cqMOZQNvh9iAZ+YfJw2XqgvJa676ulDyxlboe5omHGRF4byK
         zZFgm10gp4TWuxFtGo+4L18Bwuh6wwI33IgC5U9REeD2Ba1KTe+zzqXRL6xvj9ZFEnhn
         FzJKsLp+FI9ZgHm7/JohdSnGhHbK7Oswr+OvyvPiAGXIjZr4Hg+WYcuujOEgX1GzSv31
         4HFDpLxjxGpSj+bSa4XEdRnX6wXtXU2mQHk0xko04ZvLGGqq/ShYosZUuC2kBMDTsqkt
         5DnVUf8GMAFWXFjW7oY0QKdVee+IeqMMxxHSXdgCuSzI4+8t4EuZjaSwsE0IVYUHvnaZ
         5FgQ==
X-Gm-Message-State: AJcUuke+x+k74xr4XVQm3nLdaNqzSfXqkEgHOvYm+Eih3d20CyYTuc95
        vyEqeN/VTF9SITr/Wbt3c6hng+9SbK9aWjJH85k=
X-Google-Smtp-Source: ALg8bN5p/mLZaI4qCk1gB8MidmeaEaomOboVpVI9gZVQbXdR+7xMr5K5f/c6Ea2n79Dp6qjW5cAU8u1SQMGEKP48DSI=
X-Received: by 2002:a67:f43:: with SMTP id 64mr5082621vsp.166.1548442722430;
 Fri, 25 Jan 2019 10:58:42 -0800 (PST)
MIME-Version: 1.0
References: <20190125184640.5174-1-jcmvbkbc@gmail.com>
In-Reply-To: <20190125184640.5174-1-jcmvbkbc@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 25 Jan 2019 19:58:30 +0100
Message-ID: <CAMuHMdUYDPrtnj++C3JZYuGqn1xoc=ZG8i8rp2HAdqXe7H7XjA@mail.gmail.com>
Subject: Re: [PATCH v2] treewide: get rid of HAVE_FUTEX_CMPXCHG
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

On Fri, Jan 25, 2019 at 7:47 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
> CONFIG_HAVE_FUTEX_CMPXCHG is currently used to determine if
> atomic_inatomic is always working or must be probed. For most
> architectures it is either selected, or it is known that they always
> have futex_atomic_cmpxchg_inatomic working.
>
> Drop HAVE_FUTEX_CMPXCHG from the Kconfig and let architectures that may
> not have it working define macro arch_have_futex_cmpxchg that probes
> whether futex_atomic_cmpxchg_inatomic is working, otherwise assume that
> it is working.
>
> Implement arch_have_futex_cmpxchg for MIPS, Xtensa and for the users of
> asm-generic/futex.h.
>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v1->v2:
> - fix #ifdef/#ifndef logic in kernel/futex.c

Thanks for the update!

>  arch/m68k/Kconfig               |  1 -

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
