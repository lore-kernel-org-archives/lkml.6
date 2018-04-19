Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751147AbeDSI6N (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 04:58:13 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:35721 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeDSI6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 04:58:10 -0400
X-Google-Smtp-Source: AIpwx4+dh8FJHxVIiPLBvsazX6pywVafWObeZimpu/xaLUw2h4cD0JSdTUlfEgFPzMX/hMkbWbLVKA==
MIME-Version: 1.0
In-Reply-To: <20180418174014.1592871-1-songliubraving@fb.com>
References: <20180418174014.1592871-1-songliubraving@fb.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 19 Apr 2018 10:58:07 +0200
X-Gmail-Original-Message-ID: <CAELBmZB2XX=qEOLAdvGG4cPx4GEntcSnWQquJLUK1ongRj35cA@mail.gmail.com>
Message-ID: <CAELBmZB2XX=qEOLAdvGG4cPx4GEntcSnWQquJLUK1ongRj35cA@mail.gmail.com>
Subject: Re: [PATCH v2] tracing: fix bad use of igrab in trace_uprobe.c
To: Song Liu <songliubraving@fb.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-team <kernel-team@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Howard McLauchlan <hmclauchlan@fb.com>, Josef Bacik <jbacik@fb.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 7:40 PM, Song Liu <songliubraving@fb.com> wrote:
> As Miklos reported and suggested:
>
>   This pattern repeats two times in trace_uprobe.c and in
>   kernel/events/core.c as well:
>
>       ret = kern_path(filename, LOOKUP_FOLLOW, &path);
>       if (ret)
>           goto fail_address_parse;
>
>       inode = igrab(d_inode(path.dentry));
>       path_put(&path);
>
>   And it's wrong.  You can only hold a reference to the inode if you
>   have an active ref to the superblock as well (which is normally
>   through path.mnt) or holding s_umount.
>
>   This way unmounting the containing filesystem while the tracepoint is
>   active will give you the "VFS: Busy inodes after unmount..." message
>   and a crash when the inode is finally put.
>
>   Solution: store path instead of inode.
>
> This patch fixes two instances in trace_uprobe.c.
>
> Fixes: f3f096cfedf8 ("tracing: Provide trace events interface for uprobes")
> Fixes: 33ea4b24277b ("perf/core: Implement the 'perf_uprobe' PMU")
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Howard McLauchlan <hmclauchlan@fb.com>
> Cc: Josef Bacik <jbacik@fb.com>
> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Reported-by: Miklos Szeredi <miklos@szeredi.hu>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  kernel/trace/trace_uprobe.c | 49 +++++++++++++++------------------------------
>  1 file changed, 16 insertions(+), 33 deletions(-)
>
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 34fd0e0..d9ee522c 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -55,7 +55,7 @@ struct trace_uprobe {
>         struct list_head                list;
>         struct trace_uprobe_filter      filter;
>         struct uprobe_consumer          consumer;
> -       struct inode                    *inode;
> +       struct path                     path;
>         char                            *filename;
>         unsigned long                   offset;
>         unsigned long                   nhit;
> @@ -289,7 +289,7 @@ static void free_trace_uprobe(struct trace_uprobe *tu)
>         for (i = 0; i < tu->tp.nr_args; i++)
>                 traceprobe_free_probe_arg(&tu->tp.args[i]);
>
> -       iput(tu->inode);
> +       path_put(&tu->path);
>         kfree(tu->tp.call.class->system);
>         kfree(tu->tp.call.name);
>         kfree(tu->filename);
> @@ -363,7 +363,6 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
>  static int create_trace_uprobe(int argc, char **argv)
>  {
>         struct trace_uprobe *tu;
> -       struct inode *inode;
>         char *arg, *event, *group, *filename;
>         char buf[MAX_EVENT_NAME_LEN];
>         struct path path;
> @@ -371,7 +370,6 @@ static int create_trace_uprobe(int argc, char **argv)
>         bool is_delete, is_return;
>         int i, ret;
>
> -       inode = NULL;
>         ret = 0;
>         is_delete = false;
>         is_return = false;
> @@ -437,24 +435,14 @@ static int create_trace_uprobe(int argc, char **argv)
>         }
>         /* Find the last occurrence, in case the path contains ':' too. */
>         arg = strrchr(argv[1], ':');
> -       if (!arg) {
> -               ret = -EINVAL;
> -               goto fail_address_parse;
> -       }
> +       if (!arg)
> +               return -EINVAL;
>
>         *arg++ = '\0';
>         filename = argv[1];
>         ret = kern_path(filename, LOOKUP_FOLLOW, &path);
>         if (ret)
> -               goto fail_address_parse;
> -
> -       inode = igrab(d_real_inode(path.dentry));
> -       path_put(&path);
> -
> -       if (!inode || !S_ISREG(inode->i_mode)) {

Where has the S_ISREG check gone?

> -               ret = -EINVAL;
> -               goto fail_address_parse;
> -       }
> +               return ret;
>
>         ret = kstrtoul(arg, 0, &offset);
>         if (ret)
> @@ -490,7 +478,7 @@ static int create_trace_uprobe(int argc, char **argv)
>                 goto fail_address_parse;
>         }
>         tu->offset = offset;
> -       tu->inode = inode;
> +       tu->path = path;
>         tu->filename = kstrdup(filename, GFP_KERNEL);
>
>         if (!tu->filename) {
> @@ -558,7 +546,7 @@ static int create_trace_uprobe(int argc, char **argv)
>         return ret;
>
>  fail_address_parse:
> -       iput(inode);
> +       path_put(&path);
>
>         pr_info("Failed to parse address or file.\n");
>
> @@ -922,7 +910,8 @@ probe_event_enable(struct trace_uprobe *tu, struct trace_event_file *file,
>                 goto err_flags;
>
>         tu->consumer.filter = filter;
> -       ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
> +       ret = uprobe_register(d_inode(tu->path.dentry), tu->offset,
> +                             &tu->consumer);
>         if (ret)
>                 goto err_buffer;
>
> @@ -966,7 +955,7 @@ probe_event_disable(struct trace_uprobe *tu, struct trace_event_file *file)
>
>         WARN_ON(!uprobe_filter_is_empty(&tu->filter));
>
> -       uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
> +       uprobe_unregister(d_inode(tu->path.dentry), tu->offset, &tu->consumer);
>         tu->tp.flags &= file ? ~TP_FLAG_TRACE : ~TP_FLAG_PROFILE;
>
>         uprobe_buffer_disable();
> @@ -1041,7 +1030,8 @@ static int uprobe_perf_close(struct trace_uprobe *tu, struct perf_event *event)
>         write_unlock(&tu->filter.rwlock);
>
>         if (!done)
> -               return uprobe_apply(tu->inode, tu->offset, &tu->consumer, false);
> +               return uprobe_apply(d_inode(tu->path.dentry), tu->offset,
> +                                   &tu->consumer, false);
>
>         return 0;
>  }
> @@ -1073,7 +1063,8 @@ static int uprobe_perf_open(struct trace_uprobe *tu, struct perf_event *event)
>
>         err = 0;
>         if (!done) {
> -               err = uprobe_apply(tu->inode, tu->offset, &tu->consumer, true);
> +               err = uprobe_apply(d_inode(tu->path.dentry),
> +                                  tu->offset, &tu->consumer, true);
>                 if (err)
>                         uprobe_perf_close(tu, event);
>         }
> @@ -1337,7 +1328,6 @@ struct trace_event_call *
>  create_local_trace_uprobe(char *name, unsigned long offs, bool is_return)
>  {
>         struct trace_uprobe *tu;
> -       struct inode *inode;
>         struct path path;
>         int ret;
>
> @@ -1345,14 +1335,6 @@ create_local_trace_uprobe(char *name, unsigned long offs, bool is_return)
>         if (ret)
>                 return ERR_PTR(ret);
>
> -       inode = igrab(d_inode(path.dentry));
> -       path_put(&path);
> -
> -       if (!inode || !S_ISREG(inode->i_mode)) {

And here, again.

Otherwise ACK.

Also please create a separate patch that removes igrab/iput calls from
kernel/events/uprobes.c and adds a comment to the effect that the
caller is required to keep the inode (and the containing mount)
referenced.

Thanks,
Miklos
