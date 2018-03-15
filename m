Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752808AbeCOUbA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 16:31:00 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45890 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbeCOUa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 16:30:59 -0400
X-Google-Smtp-Source: AG47ELu3o3f21R3nUUUc71LkMjAu9HKgblbSaAqTtUSWUqb1AtI98l/6hzDDYFprzzQvz1o+gitiYAy4SdDSae60gKw=
MIME-Version: 1.0
In-Reply-To: <20180315190529.20943-31-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net> <20180315190529.20943-31-linux@dominikbrodowski.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Mar 2018 21:30:58 +0100
X-Google-Sender-Auth: MUEfoaERIl4hIbik-rEVKiO3JeY
Message-ID: <CAK8P3a0zyzZkH43oW5mMEX5QDm1RdRWMgtjPprFK9iRrNpy5qQ@mail.gmail.com>
Subject: Re: [PATCH v2 30/36] fs: add do_linkat() helper and ksys_link()
 wrapper; remove in-kernel calls to syscall
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
>
>   */
> -SYSCALL_DEFINE5(linkat, int, olddfd, const char __user *, oldname,
> -               int, newdfd, const char __user *, newname, int, flags)
> +int do_linkat(int olddfd, const char __user *oldname, int newdfd,
> +             const char __user *newname, int flags)
>  {
>         struct dentry *new_dentry;
>         struct path old_path, new_path;

For consistency with other do_*() functions, I think it would be nice
to make this one not take a __user pointer either. However, I
have no idea how to do that without making the common case worse.

> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -306,7 +306,7 @@ static int __init maybe_link(void)
>         if (nlink >= 2) {
>                 char *old = find_link(major, minor, ino, mode, collected);
>                 if (old)
> -                       return (sys_link(old, collected) < 0) ? -1 : 1;
> +                       return (ksys_link(old, collected) < 0) ? -1 : 1;
>         }
>         return 0;
>  }

Since this is the only caller outside of fs/namei.c, maybe it can be
changed to use vfs_link() instead? That might still be a larger rework
than you want to do.

        Arnd
