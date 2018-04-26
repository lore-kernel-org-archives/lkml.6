Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756172AbeDZNY6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:24:58 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45077 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754516AbeDZNY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:24:56 -0400
X-Google-Smtp-Source: AIpwx483BctVWJenwLypQKquXabFyqDwLh3IPgB8ujGVObmr32/HCPQVv6vxY/+WhGj3CmhzjGg32Rkwe4Tl01CSayM=
MIME-Version: 1.0
X-Originating-IP: [176.63.54.97]
In-Reply-To: <20180423172135.4050588-1-songliubraving@fb.com>
References: <20180423172135.4050588-1-songliubraving@fb.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 26 Apr 2018 15:24:55 +0200
Message-ID: <CAJfpegv807ktfv+tjYE65Yr_TbGnjds6ZCtoYX_yQTg_1wodzQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] tracing: fix bad use of igrab in trace_uprobe.c
To: Song Liu <songliubraving@fb.com>
Cc: linux-kernel@vger.kernel.org, kernel-team <kernel-team@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Howard McLauchlan <hmclauchlan@fb.com>, Josef Bacik <jbacik@fb.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 7:21 PM, Song Liu <songliubraving@fb.com> wrote:
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

Acked-by: Miklos Szeredi <mszeredi@redhat.com>
