Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932687AbeCOUo2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 16:44:28 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42198 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932620AbeCOUoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 16:44:25 -0400
X-Google-Smtp-Source: AG47ELuNm4Kvp/IKPudvE54/D5MKy+xioyWrfC797nDwvkGrmG/Sro2MNgM/0BzntQvvvMGO4vbEVDZUp7wSn/0Cg6U=
MIME-Version: 1.0
In-Reply-To: <20180315190529.20943-18-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net> <20180315190529.20943-18-linux@dominikbrodowski.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Mar 2018 21:44:24 +0100
X-Google-Sender-Auth: 36KxHAMucgPvBiRE9yOzJfQBfZc
Message-ID: <CAK8P3a2s2YsttKSjZfc8xW+kjv8M1hFDCg1E9nHPjq_KRvik2Q@mail.gmail.com>
Subject: Re: [PATCH v2 17/36] fs: add ksys_chroot() helper; remove-in kernel
 calls to sys_chroot()
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
> Using this helper allows us to avoid the in-kernel calls to the sys_chroot()
> syscall.
>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> ---
>  drivers/base/devtmpfs.c  | 2 +-
>  fs/open.c                | 7 ++++++-
>  include/linux/syscalls.h | 1 +
>  init/do_mounts.c         | 2 +-
>  init/do_mounts_initrd.c  | 4 ++--
>  5 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> index 4afb04686c8e..5743f04014ca 100644
> --- a/drivers/base/devtmpfs.c
> +++ b/drivers/base/devtmpfs.c
> @@ -387,7 +387,7 @@ static int devtmpfsd(void *p)
>         if (*err)
>                 goto out;
>         sys_chdir("/.."); /* will traverse into overmounted root */
> -       sys_chroot(".");
> +       ksys_chroot(".");
>         complete(&setup_done);
>         while (1) {
>                 spin_lock(&req_lock);

Could this be done using kern_path()/set_fs_root() instead so we
avoid the __user pointer?

       Arnd
