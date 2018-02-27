Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbeB0XjZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 18:39:25 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:35076 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeB0XjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 18:39:24 -0500
X-Google-Smtp-Source: AG47ELv6MydhnME+qcKI7UOQnMmWUgSBEhTS7PEAN1YExFrNERRaje/nEB7MKnGV6FxjATjhM8hUoAy3dAI4P/Pw8Ys=
MIME-Version: 1.0
In-Reply-To: <20180227233156.29826-1-danilokrummrich@dk-develop.de>
References: <20180227233156.29826-1-danilokrummrich@dk-develop.de>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Feb 2018 15:39:22 -0800
X-Google-Sender-Auth: F7EXXKBvnoxIJtY47cpHDsPUL1U
Message-ID: <CAGXu5jLL8GP7uVRqfnMKf5G=WYE1YZ14cdBMfqwP9+iT2A1bNw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fs/sysctl: fix potential page fault while
 unregistering sysctl table
To: Danilo Krummrich <danilokrummrich@dk-develop.de>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 3:31 PM, Danilo Krummrich
<danilokrummrich@dk-develop.de> wrote:
> proc_sys_link_fill_cache() does not take currently unregistering
> sysctl tables into account, which might result into a page fault in
> sysctl_follow_link() - add a check to fix it.
>
> Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>

Acked-by: Kees Cook <keescook@chromium.org>

> ---
> v2: removed empty line between between sysctl_head_grab and IS_ERR

Thanks!

-Kees

> ---
>  fs/proc/proc_sysctl.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index c5cbbdff3c3d..82ac5f682b73 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -707,7 +707,10 @@ static bool proc_sys_link_fill_cache(struct file *file,
>                                     struct ctl_table *table)
>  {
>         bool ret = true;
> +
>         head = sysctl_head_grab(head);
> +       if (IS_ERR(head))
> +               return false;
>
>         if (S_ISLNK(table->mode)) {
>                 /* It is not an error if we can not follow the link ignore it */
> --
> 2.14.1
>



-- 
Kees Cook
Pixel Security
