Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164767AbeE1MjM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:39:12 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:35049 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938032AbeE1MjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 08:39:06 -0400
X-Google-Smtp-Source: ADUXVKImuXc4x9LDgTur+Rnl9MKHVqoaVIKs/s3R4G3NKQu0nzn9lLEgbecCEwDxDtXwZiO7TxxguymhkVillejeGo0=
MIME-Version: 1.0
In-Reply-To: <20180528100259.797799079@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org> <20180528100259.797799079@linuxfoundation.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 28 May 2018 15:39:04 +0300
Message-ID: <CAOQ4uxi9emdAqr1JPYgC_T52SjCtpAbac4pSzfZ7vqtmg6nFMg@mail.gmail.com>
Subject: Re: [PATCH 4.16 231/272] fanotify: Avoid lost events due to ENOMEM
 for unlimited queues
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Sasha Levin <alexander.levin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 1:04 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> 4.16-stable review patch.  If anyone has any objections, please let me know.
>

I do not have objections for applying this patch to stable, but AFAIK
it is a correctness patch that doesn't fix any bug and it was mainly added
as a prerequisite to memcg accounting of event allocations, which is not
yet merged and not destined for stable.

Jan? do you agree with my statements above?

Thanks,
Amir.

> ------------------
>
> From: Jan Kara <jack@suse.cz>
>
> [ Upstream commit 1f5eaa90010ed7cf0ae90a526c48657d02c6086f ]
>
> Fanotify queues of unlimited length do not expect events can be lost.
> Since these queues are used for system auditing and other security
> related tasks, loosing events can even have security implications.
> Currently, since the allocation is small (32-bytes), it cannot fail
> however when we start accounting events in memcgs, allocation can start
> failing. So avoid loosing events due to failure to allocate memory by
> making event allocation use __GFP_NOFAIL.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  fs/notify/fanotify/fanotify.c      |   19 ++++++++++++++-----
>  fs/notify/fanotify/fanotify.h      |    3 ++-
>  fs/notify/fanotify/fanotify_user.c |    2 +-
>  3 files changed, 17 insertions(+), 7 deletions(-)
>
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -135,23 +135,32 @@ static bool fanotify_should_send_event(s
>         return false;
>  }
>
> -struct fanotify_event_info *fanotify_alloc_event(struct inode *inode, u32 mask,
> +struct fanotify_event_info *fanotify_alloc_event(struct fsnotify_group *group,
> +                                                struct inode *inode, u32 mask,
>                                                  const struct path *path)
>  {
>         struct fanotify_event_info *event;
> +       gfp_t gfp = GFP_KERNEL;
> +
> +       /*
> +        * For queues with unlimited length lost events are not expected and
> +        * can possibly have security implications. Avoid losing events when
> +        * memory is short.
> +        */
> +       if (group->max_events == UINT_MAX)
> +               gfp |= __GFP_NOFAIL;
>
>         if (fanotify_is_perm_event(mask)) {
>                 struct fanotify_perm_event_info *pevent;
>
> -               pevent = kmem_cache_alloc(fanotify_perm_event_cachep,
> -                                         GFP_KERNEL);
> +               pevent = kmem_cache_alloc(fanotify_perm_event_cachep, gfp);
>                 if (!pevent)
>                         return NULL;
>                 event = &pevent->fae;
>                 pevent->response = 0;
>                 goto init;
>         }
> -       event = kmem_cache_alloc(fanotify_event_cachep, GFP_KERNEL);
> +       event = kmem_cache_alloc(fanotify_event_cachep, gfp);
>         if (!event)
>                 return NULL;
>  init: __maybe_unused
> @@ -206,7 +215,7 @@ static int fanotify_handle_event(struct
>                         return 0;
>         }
>
> -       event = fanotify_alloc_event(inode, mask, data);
> +       event = fanotify_alloc_event(group, inode, mask, data);
>         ret = -ENOMEM;
>         if (unlikely(!event))
>                 goto finish;
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -52,5 +52,6 @@ static inline struct fanotify_event_info
>         return container_of(fse, struct fanotify_event_info, fse);
>  }
>
> -struct fanotify_event_info *fanotify_alloc_event(struct inode *inode, u32 mask,
> +struct fanotify_event_info *fanotify_alloc_event(struct fsnotify_group *group,
> +                                                struct inode *inode, u32 mask,
>                                                  const struct path *path);
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -757,7 +757,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned
>         group->fanotify_data.user = user;
>         atomic_inc(&user->fanotify_listeners);
>
> -       oevent = fanotify_alloc_event(NULL, FS_Q_OVERFLOW, NULL);
> +       oevent = fanotify_alloc_event(group, NULL, FS_Q_OVERFLOW, NULL);
>         if (unlikely(!oevent)) {
>                 fd = -ENOMEM;
>                 goto out_destroy_group;
>
>
