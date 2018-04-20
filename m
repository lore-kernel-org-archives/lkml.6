Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753905AbeDTSaM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 14:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753587AbeDTSaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 14:30:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78F5217AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 20 Apr 2018 14:30:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Song Liu <songliubraving@fb.com>
Cc: <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Ingo Molnar <mingo@redhat.com>, Howard McLauchlan <hmclauchlan@fb.com>,
        Josef Bacik <jbacik@fb.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v3 1/2] tracing: fix bad use of igrab in trace_uprobe.c
Message-ID: <20180420143008.19959743@gandalf.local.home>
In-Reply-To: <20180420165625.129593-1-songliubraving@fb.com>
References: <20180420165625.129593-1-songliubraving@fb.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018 09:56:24 -0700
Song Liu <songliubraving@fb.com> wrote:

> s Miklos reported and suggested:
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

Can I get an Acked-by or Reviewed-by from someone?

Thanks!

-- Steve
