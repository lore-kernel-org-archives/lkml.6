Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752795AbeCOUVm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 16:21:42 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45505 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752262AbeCOUVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 16:21:40 -0400
X-Google-Smtp-Source: AG47ELvM92EbSWIQphJJ4bmNdVYsGDK4mvpKiZdgy2rPflFCwwrmXeY6ymtuwAqrTuerhhGUbt6xwJG0n+VOslg81Tg=
MIME-Version: 1.0
In-Reply-To: <20180315190529.20943-25-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net> <20180315190529.20943-25-linux@dominikbrodowski.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Mar 2018 21:21:39 +0100
X-Google-Sender-Auth: 1fiihXSHVl2SfgTHN9zO0ud--EI
Message-ID: <CAK8P3a2+ACGXyVAjHW+UQukL5Oam9pJHmYRVGUbJ7QskPoj=qQ@mail.gmail.com>
Subject: Re: [PATCH v2 24/36] fs: add ksys_unlink() wrapper; remove in-kernel
 calls to sys_unlink()
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
> Using this wrapper allows us to avoid the in-kernel calls to the
> sys_unlink() syscall.
>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> ---
>  include/linux/syscalls.h | 11 +++++++++++
>  init/do_mounts.h         |  2 +-
>  init/do_mounts_initrd.c  |  4 ++--
>  init/do_mounts_rd.c      |  2 +-
>  init/initramfs.c         |  4 ++--
>  5 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 8f0f99702e7a..31aea3873de7 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -971,4 +971,15 @@ int ksys_chdir(const char __user *filename);
>  int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
>                          unsigned int flags);
>
> +/*
> + * The following kernel syscall equivalents are just wrappers to fs-internal
> + * functions. Therefore, provide stubs to be inlined at the callsites.
> + */
> +extern long do_unlinkat(int dfd, struct filename *name);
> +
> +static inline long ksys_unlink(const char __user *pathname)
> +{
> +       return do_unlinkat(AT_FDCWD, getname(pathname));
> +}

Why does this take a __user pointer?

>  static inline int create_dev(char *name, dev_t dev)
>  {
> -       sys_unlink(name);
> +       ksys_unlink(name);
>         return sys_mknod(name, S_IFBLK|0600, new_encode_dev(dev));
>  }
>
> diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
> index c19d9070134e..784576b633fd 100644
> --- a/init/do_mounts_initrd.c
> +++ b/init/do_mounts_initrd.c
> @@ -128,11 +128,11 @@ bool __init initrd_load(void)
>                  * mounted in the normal path.
>                  */
>                 if (rd_load_image("/initrd.image") && ROOT_DEV != Root_RAM0) {
> -                       sys_unlink("/initrd.image");
> +                       ksys_unlink("/initrd.image");
>                         handle_initrd();
>                         return true;
>                 }
>         }
> -       sys_unlink("/initrd.image");
> +       ksys_unlink("/initrd.image");
>         return false;

In all callers we seem to have regular kernel strings, so I think
you should skip the getname() and change the argument to
a regular pointer.

      Arnd
