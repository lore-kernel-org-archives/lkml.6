Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeB0XCf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 18:02:35 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:32943 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbeB0XCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 18:02:33 -0500
X-Google-Smtp-Source: AG47ELvZ7Ye+AvGxBxPUiY6OClKiErqTr4Fu+rMdf8yWk90GIH4dNd4trXoUnKk1qu/CL7UoJVJ7lX+ckfqyMgorqfA=
MIME-Version: 1.0
In-Reply-To: <20180227224358.12672-1-danilokrummrich@dk-develop.de>
References: <20180227224358.12672-1-danilokrummrich@dk-develop.de>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Feb 2018 15:02:32 -0800
X-Google-Sender-Auth: 26Zb3ZA6sAJZ5X8wP1zC5ue7VCo
Message-ID: <CAGXu5j+geUKNMu8W-+CYUD0_d_LBv+78TE5QbKx2EBeCx_oP9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/sysctl: fix potential page fault while
 unregistering sysctl table
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
> proc_sys_link_fill_cache() does not take currently unregistering
> sysctl tables into account, which might result into a page fault in
> sysctl_follow_link() - add a check to fix it.
>
> Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
> ---
>  fs/proc/proc_sysctl.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index c5cbbdff3c3d..a0b6c647835e 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -709,6 +709,9 @@ static bool proc_sys_link_fill_cache(struct file *file,
>         bool ret = true;

Nothing appears to actually change "ret" in this function. It should
likely be dropped too.

>         head = sysctl_head_grab(head);
>
> +       if (IS_ERR(head))
> +               return false;
> +

This looks sensible. I'd drop the blank line between sysctl_head_grab
and the IS_ERR, though.

How are you testing this change?

Thanks!

-Kees

>         if (S_ISLNK(table->mode)) {
>                 /* It is not an error if we can not follow the link ignore it */
>                 int err = sysctl_follow_link(&head, &table);
> --
> 2.14.1
>



-- 
Kees Cook
Pixel Security
