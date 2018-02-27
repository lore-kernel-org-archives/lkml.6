Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeB0W7g (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:59:36 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:45401 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751813AbeB0W7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:59:34 -0500
X-Google-Smtp-Source: AG47ELu7qJrsLq9QGIaq9XnX9r8yYJTZJjYkve5jRaSHhnP0lJjHqhHPgyB+iQbEENELn7pSJYdnDlv7eao6lg2Tqco=
MIME-Version: 1.0
In-Reply-To: <20180227224358.12672-2-danilokrummrich@dk-develop.de>
References: <20180227224358.12672-1-danilokrummrich@dk-develop.de> <20180227224358.12672-2-danilokrummrich@dk-develop.de>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Feb 2018 14:59:33 -0800
X-Google-Sender-Auth: qOjt6uQjPknF1zSKXzmSKbL6QeQ
Message-ID: <CAGXu5jKpmw2qEqL7dnELS5h45pq9AZf=0nEXox52qEbP6pz4CA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs/sysctl: remove redundant link check in proc_sys_link_fill_cache()
To: Danilo Krummrich <danilokrummrich@dk-develop.de>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 2:43 PM, Danilo Krummrich
<danilokrummrich@dk-develop.de> wrote:
> proc_sys_link_fill_cache() does not need to check whether we're
> called for a link - it's already done by scan().
>
> Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
> ---
>  fs/proc/proc_sysctl.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index a0b6c647835e..7e7d9facb842 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -707,17 +707,16 @@ static bool proc_sys_link_fill_cache(struct file *file,
>                                     struct ctl_table *table)
>  {
>         bool ret = true;
> +       int err = 0;
>         head = sysctl_head_grab(head);
>
>         if (IS_ERR(head))
>                 return false;
>
> -       if (S_ISLNK(table->mode)) {
> -               /* It is not an error if we can not follow the link ignore it */
> -               int err = sysctl_follow_link(&head, &table);
> -               if (err)
> -                       goto out;
> -       }
> +       /* It is not an error if we can not follow the link ignore it */
> +       sysctl_follow_link(&head, &table);

Shouldn't this be err = sysctl_follow_link... ? Otherwise I don't see
where err is used.

-Kees

> +       if (err)
> +               goto out;
>
>         ret = proc_sys_fill_cache(file, ctx, head, table);
>  out:
> --
> 2.14.1
>



-- 
Kees Cook
Pixel Security
