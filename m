Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754592AbeDWJ4H (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:56:07 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41479 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754327AbeDWJ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:56:06 -0400
X-Google-Smtp-Source: AIpwx497+73GqlQk2SgqTjvEsXQXHzgxukDc9jeECUcRJs4o2zN+bT2GkahfD9W5Fvk0H5gdWb/HcxB4D5iz7jv4zyk=
MIME-Version: 1.0
X-Originating-IP: [176.63.54.97]
In-Reply-To: <20180420165625.129593-1-songliubraving@fb.com>
References: <20180420165625.129593-1-songliubraving@fb.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 23 Apr 2018 11:56:04 +0200
Message-ID: <CAJfpegtT2Vfk4G6fiwb5V7PPHpzESmC85Ppk4+1J23J8+0KRiA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] tracing: fix bad use of igrab in trace_uprobe.c
To: Song Liu <songliubraving@fb.com>
Cc: linux-kernel@vger.kernel.org, kernel-team <kernel-team@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Howard McLauchlan <hmclauchlan@fb.com>, Josef Bacik <jbacik@fb.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 6:56 PM, Song Liu <songliubraving@fb.com> wrote:
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
> This patch fixes two instances in trace_uprobe.c. struct path is added to
> struct trace_uprobe to keep the inode and containing mount point
> referenced.
>
> Fixes: f3f096cfedf8 ("tracing: Provide trace events interface for uprobes")
> Fixes: 33ea4b24277b ("perf/core: Implement the 'perf_uprobe' PMU")
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Howard McLauchlan <hmclauchlan@fb.com>
> Cc: Josef Bacik <jbacik@fb.com>
> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Reported-by: Miklos Szeredi <miklos@szeredi.hu>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  kernel/trace/trace_uprobe.c | 55 +++++++++++++++++++--------------------------
>  1 file changed, 23 insertions(+), 32 deletions(-)
>
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 34fd0e0..e7ffb5e 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -55,6 +55,7 @@ struct trace_uprobe {
>         struct list_head                list;
>         struct trace_uprobe_filter      filter;
>         struct uprobe_consumer          consumer;
> +       struct path                     path;
>         struct inode                    *inode;
>         char                            *filename;
>         unsigned long                   offset;
> @@ -289,7 +290,7 @@ static void free_trace_uprobe(struct trace_uprobe *tu)
>         for (i = 0; i < tu->tp.nr_args; i++)
>                 traceprobe_free_probe_arg(&tu->tp.args[i]);
>
> -       iput(tu->inode);
> +       path_put(&tu->path);
>         kfree(tu->tp.call.class->system);
>         kfree(tu->tp.call.name);
>         kfree(tu->filename);
> @@ -363,7 +364,6 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
>  static int create_trace_uprobe(int argc, char **argv)
>  {
>         struct trace_uprobe *tu;
> -       struct inode *inode;
>         char *arg, *event, *group, *filename;
>         char buf[MAX_EVENT_NAME_LEN];
>         struct path path;
> @@ -371,7 +371,6 @@ static int create_trace_uprobe(int argc, char **argv)
>         bool is_delete, is_return;
>         int i, ret;
>
> -       inode = NULL;
>         ret = 0;
>         is_delete = false;
>         is_return = false;
> @@ -437,24 +436,14 @@ static int create_trace_uprobe(int argc, char **argv)
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

You probably should test for positive regular file here.  You can use
d_is_reg(path.dentry) for that, which actually checks both the above
conditions and ensures that latter you don't even need to test and
error out on the !inode case because that is simply impossible.

> -               ret = -EINVAL;
> -               goto fail_address_parse;
> -       }
> +               return ret;
>
>         ret = kstrtoul(arg, 0, &offset);
>         if (ret)
> @@ -490,7 +479,7 @@ static int create_trace_uprobe(int argc, char **argv)
>                 goto fail_address_parse;
>         }
>         tu->offset = offset;
> -       tu->inode = inode;
> +       tu->path = path;
>         tu->filename = kstrdup(filename, GFP_KERNEL);
>
>         if (!tu->filename) {
> @@ -558,7 +547,7 @@ static int create_trace_uprobe(int argc, char **argv)
>         return ret;
>
>  fail_address_parse:
> -       iput(inode);
> +       path_put(&path);
>
>         pr_info("Failed to parse address or file.\n");
>
> @@ -922,7 +911,14 @@ probe_event_enable(struct trace_uprobe *tu, struct trace_event_file *file,
>                 goto err_flags;
>
>         tu->consumer.filter = filter;
> -       ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
> +       tu->inode = d_real_inode(tu->path.dentry);
> +       if (!tu->inode || !S_ISREG(tu->inode->i_mode)) {
> +               tu->inode = NULL;
> +               ret = -EINVAL;
> +               goto err_buffer;
> +       }
> +       ret = uprobe_register(tu->inode, tu->offset,
> +                             &tu->consumer);

So this just becomes:
+       tu->inode = d_real_inode(tu->path.dentry);

No more changes necessary.


>         if (ret)
>                 goto err_buffer;
>
> @@ -966,7 +962,8 @@ probe_event_disable(struct trace_uprobe *tu, struct trace_event_file *file)
>
>         WARN_ON(!uprobe_filter_is_empty(&tu->filter));
>
> -       uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
> +       uprobe_unregister(d_inode(tu->path.dentry), tu->offset, &tu->consumer);

Huh?  This should also be using tu->inode.  Othewise what's the point
in storing it?

> +       tu->inode = NULL;
>         tu->tp.flags &= file ? ~TP_FLAG_TRACE : ~TP_FLAG_PROFILE;
>
>         uprobe_buffer_disable();
> @@ -1041,7 +1038,8 @@ static int uprobe_perf_close(struct trace_uprobe *tu, struct perf_event *event)
>         write_unlock(&tu->filter.rwlock);
>
>         if (!done)
> -               return uprobe_apply(tu->inode, tu->offset, &tu->consumer, false);
> +               return uprobe_apply(d_inode(tu->path.dentry), tu->offset,
> +                                   &tu->consumer, false);

And here.

>
>         return 0;
>  }
> @@ -1073,7 +1071,8 @@ static int uprobe_perf_open(struct trace_uprobe *tu, struct perf_event *event)
>
>         err = 0;
>         if (!done) {
> -               err = uprobe_apply(tu->inode, tu->offset, &tu->consumer, true);
> +               err = uprobe_apply(d_inode(tu->path.dentry),
> +                                  tu->offset, &tu->consumer, true);

And here.

Just drop these hunks completely.  Using tu->inode is fine.

>                 if (err)
>                         uprobe_perf_close(tu, event);
>         }
> @@ -1337,7 +1336,6 @@ struct trace_event_call *
>  create_local_trace_uprobe(char *name, unsigned long offs, bool is_return)
>  {
>         struct trace_uprobe *tu;
> -       struct inode *inode;
>         struct path path;
>         int ret;
>
> @@ -1345,14 +1343,6 @@ create_local_trace_uprobe(char *name, unsigned long offs, bool is_return)
>         if (ret)
>                 return ERR_PTR(ret);
>
> -       inode = igrab(d_inode(path.dentry));
> -       path_put(&path);
> -
> -       if (!inode || !S_ISREG(inode->i_mode)) {
> -               iput(inode);
> -               return ERR_PTR(-EINVAL);
> -       }

And again, the test for being a regular file can stay here.

> -
>         /*
>          * local trace_kprobes are not added to probe_list, so they are never
>          * searched in find_trace_kprobe(). Therefore, there is no concern of
> @@ -1364,11 +1354,12 @@ create_local_trace_uprobe(char *name, unsigned long offs, bool is_return)
>         if (IS_ERR(tu)) {
>                 pr_info("Failed to allocate trace_uprobe.(%d)\n",
>                         (int)PTR_ERR(tu));
> +               path_put(&path);
>                 return ERR_CAST(tu);
>         }
>
>         tu->offset = offs;
> -       tu->inode = inode;
> +       tu->path = path;
>         tu->filename = kstrdup(name, GFP_KERNEL);
>         init_trace_event_call(tu, &tu->tp.call);
>
> --
> 2.9.5
>
