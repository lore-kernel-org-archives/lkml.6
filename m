Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeCOUL3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 16:11:29 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43245 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbeCOUL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 16:11:28 -0400
X-Google-Smtp-Source: AG47ELuM6bOzsT8Z3HyjyMZ0BeMn1Yv3be+Y8BwsAQMTtuywfzTarphfa3nXaArbiJL1XhZO4MlQfHB75DATCFMP+jU=
MIME-Version: 1.0
In-Reply-To: <20180315190529.20943-15-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net> <20180315190529.20943-15-linux@dominikbrodowski.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Mar 2018 21:11:27 +0100
X-Google-Sender-Auth: lPubOkMaES21C1Ufa2rJYuPMW5o
Message-ID: <CAK8P3a2H=LoW5apWNxbqda+JAa33R=tqc7RK=2Uv7J_Xpy+bgg@mail.gmail.com>
Subject: Re: [PATCH v2 14/36] fs: add ksys_mount() helper; remove in-kernel
 calls to sys_mount()
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 8:05 PM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> Using this helper allows us to avoid the in-kernel calls to the sys_mount()
> syscall.
>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> index 50025d7959cb..4afb04686c8e 100644
> --- a/drivers/base/devtmpfs.c
> +++ b/drivers/base/devtmpfs.c
> @@ -356,7 +356,8 @@ int devtmpfs_mount(const char *mntdir)
>         if (!thread)
>                 return 0;
>
> -       err = sys_mount("devtmpfs", (char *)mntdir, "devtmpfs", MS_SILENT, NULL);
> +       err = ksys_mount("devtmpfs", (char *)mntdir, "devtmpfs", MS_SILENT,
> +                        NULL);
>         if (err)
>                 printk(KERN_INFO "devtmpfs: error mounting %i\n", err);
>         else
> @@ -382,7 +383,7 @@ static int devtmpfsd(void *p)
>         *err = sys_unshare(CLONE_NEWNS);
>         if (*err)
>                 goto out;
> -       *err = sys_mount("devtmpfs", "/", "devtmpfs", MS_SILENT, options);
> +       *err = ksys_mount("devtmpfs", "/", "devtmpfs", MS_SILENT, options);
>         if (*err)
>                 goto out;
>         sys_chdir("/.."); /* will traverse into overmounted root */

Shouldn't the callers of sys_mount just call do_mount() instead?

As I understand it, sys_mount is already a wrapper around do_mount()
that copies its arguments from user space, but we don't need that
when called from inside the kernel.

       Arnd
