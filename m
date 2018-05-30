Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968614AbeE3B4r (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 21:56:47 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34140 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968467AbeE3B4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 21:56:46 -0400
X-Google-Smtp-Source: ADUXVKLuclENvYOkZgi5hsvXD7E3RafJu6vwrPJ/lhGsQQHo90ZfLUin6m2EwhGUqaSF6bskgDga2tP9LlcVcggPlSY=
MIME-Version: 1.0
In-Reply-To: <1527575868-4156-1-git-send-email-nick.desaulniers@gmail.com>
References: <1527575868-4156-1-git-send-email-nick.desaulniers@gmail.com>
From: Nick Desaulniers <nick.desaulniers@gmail.com>
Date: Tue, 29 May 2018 18:56:44 -0700
Message-ID: <CAH7mPvjt8WwgZbAV2kK=Yq4SN+t+QSTZZFd6QyCMQ7XL4n_XCw@mail.gmail.com>
Subject: Re: [PATCH] writeback: tracing: prefer strlcpy to strncpy
To: "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc: Nick Desaulniers <nick.desaulniers@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>, Shaohua Li <shli@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ebiggers@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 11:37 PM, Nick Desaulniers
<nick.desaulniers@gmail.com> wrote:
> Fixes a stringop-truncation warning from gcc-8.
>
> Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> ---
>  include/trace/events/writeback.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index 32db72c..cfaf57d 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -66,7 +66,7 @@ TRACE_EVENT(writeback_dirty_page,
>         ),
>
>         TP_fast_assign(
> -               strncpy(__entry->name,
> +               strlcpy(__entry->name,
>                         mapping ? dev_name(inode_to_bdi(mapping->host)->dev) : "(unknown)", 32);
>                 __entry->ino = mapping ? mapping->host->i_ino : 0;
>                 __entry->index = page->index;
> @@ -96,7 +96,7 @@ DECLARE_EVENT_CLASS(writeback_dirty_inode_template,
>                 struct backing_dev_info *bdi = inode_to_bdi(inode);
>
>                 /* may be called for files on pseudo FSes w/ unregistered bdi */
> -               strncpy(__entry->name,
> +               strlcpy(__entry->name,
>                         bdi->dev ? dev_name(bdi->dev) : "(unknown)", 32);
>                 __entry->ino            = inode->i_ino;
>                 __entry->state          = inode->i_state;
> @@ -176,7 +176,7 @@ DECLARE_EVENT_CLASS(writeback_write_inode_template,
>         ),
>
>         TP_fast_assign(
> -               strncpy(__entry->name,
> +               strlcpy(__entry->name,
>                         dev_name(inode_to_bdi(inode)->dev), 32);
>                 __entry->ino            = inode->i_ino;
>                 __entry->sync_mode      = wbc->sync_mode;
> @@ -220,7 +220,7 @@ DECLARE_EVENT_CLASS(writeback_work_class,
>                 __field(unsigned int, cgroup_ino)
>         ),
>         TP_fast_assign(
> -               strncpy(__entry->name,
> +               strlcpy(__entry->name,
>                         wb->bdi->dev ? dev_name(wb->bdi->dev) : "(unknown)", 32);
>                 __entry->nr_pages = work->nr_pages;
>                 __entry->sb_dev = work->sb ? work->sb->s_dev : 0;
> @@ -274,7 +274,7 @@ DECLARE_EVENT_CLASS(writeback_class,
>                 __field(unsigned int, cgroup_ino)
>         ),
>         TP_fast_assign(
> -               strncpy(__entry->name, dev_name(wb->bdi->dev), 32);
> +               strlcpy(__entry->name, dev_name(wb->bdi->dev), 32);
>                 __entry->cgroup_ino = __trace_wb_assign_cgroup(wb);
>         ),
>         TP_printk("bdi %s: cgroup_ino=%u",
> @@ -296,7 +296,7 @@ TRACE_EVENT(writeback_bdi_register,
>                 __array(char, name, 32)
>         ),
>         TP_fast_assign(
> -               strncpy(__entry->name, dev_name(bdi->dev), 32);
> +               strlcpy(__entry->name, dev_name(bdi->dev), 32);
>         ),
>         TP_printk("bdi %s",
>                 __entry->name
> @@ -321,7 +321,7 @@ DECLARE_EVENT_CLASS(wbc_class,
>         ),
>
>         TP_fast_assign(
> -               strncpy(__entry->name, dev_name(bdi->dev), 32);
> +               strlcpy(__entry->name, dev_name(bdi->dev), 32);
>                 __entry->nr_to_write    = wbc->nr_to_write;
>                 __entry->pages_skipped  = wbc->pages_skipped;
>                 __entry->sync_mode      = wbc->sync_mode;
> @@ -372,7 +372,7 @@ TRACE_EVENT(writeback_queue_io,
>         ),
>         TP_fast_assign(
>                 unsigned long *older_than_this = work->older_than_this;
> -               strncpy(__entry->name, dev_name(wb->bdi->dev), 32);
> +               strlcpy(__entry->name, dev_name(wb->bdi->dev), 32);
>                 __entry->older  = older_than_this ?  *older_than_this : 0;
>                 __entry->age    = older_than_this ?
>                                   (jiffies - *older_than_this) * 1000 / HZ : -1;
> @@ -583,7 +583,7 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
>         ),
>
>         TP_fast_assign(
> -               strncpy(__entry->name,
> +               strlcpy(__entry->name,
>                         dev_name(inode_to_bdi(inode)->dev), 32);
>                 __entry->ino            = inode->i_ino;
>                 __entry->state          = inode->i_state;
> @@ -657,7 +657,7 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
>         ),
>
>         TP_fast_assign(
> -               strncpy(__entry->name,
> +               strlcpy(__entry->name,
>                         dev_name(inode_to_bdi(inode)->dev), 32);
>                 __entry->ino            = inode->i_ino;
>                 __entry->state          = inode->i_state;
> --
> 2.7.4
>

Eric points out this wont initialize the rest of the dest if src if
less than size.
