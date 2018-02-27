Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751851AbeB0Xlo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 18:41:44 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33132 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751811AbeB0Xlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 18:41:42 -0500
X-Google-Smtp-Source: AG47ELvm4NZfWYt2jKckDfwvHcr2qn5AnxaDAhXBnKVQbfhlNJlNA9BpMm2emORKltx8t6rtjNQ12La3WLwf/3rcxDk=
MIME-Version: 1.0
In-Reply-To: <20180227233156.29826-2-danilokrummrich@dk-develop.de>
References: <20180227233156.29826-1-danilokrummrich@dk-develop.de> <20180227233156.29826-2-danilokrummrich@dk-develop.de>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Feb 2018 15:41:40 -0800
X-Google-Sender-Auth: C1oJux1kjRdyHwnt1WbU2UfdjE0
Message-ID: <CAGXu5jLs2Fu+0yUNE4v6+xkfLXdEBs2QY=HctVFGfd__vNPW1g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fs/sysctl: remove redundant link check in proc_sys_link_fill_cache()
To: Danilo Krummrich <danilokrummrich@dk-develop.de>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 3:31 PM, Danilo Krummrich
<danilokrummrich@dk-develop.de> wrote:
> proc_sys_link_fill_cache() does not need to check whether we're
> called for a link - it's already done by scan().
>
> Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>

Acked-by: Kees Cook <keescook@chromium.org>

> ---
> v2: removed 'err' as it's only used for sysctl_follow_link()

Thanks :)

Luis, do you have a tree for sysctl, or should these just go via -mm?

-Kees

> ---
>  fs/proc/proc_sysctl.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 82ac5f682b73..d36ef667c0a8 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -712,12 +712,9 @@ static bool proc_sys_link_fill_cache(struct file *file,
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
> +       if (sysctl_follow_link(&head, &table))
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
