Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933512AbeBPK3R (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 05:29:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:41107 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932082AbeBPK3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 05:29:15 -0500
Date: Fri, 16 Feb 2018 11:29:13 +0100
From: Jan Kara <jack@suse.cz>
To: t.vivek@samsung.com
Cc: jack@suse.cz, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, pankaj.m@samsung.com,
        Kunal Shubham <k.shubham@samsung.com>
Subject: Re: [PATCH] fanotify: allow freeze on suspend when waiting for
 response from userspace
Message-ID: <20180216102913.jcgvc5rhjqtzlkb6@quack2.suse.cz>
References: <CGME20180216094525epcas5p1e52ea815ed7dfb7516578384dedcf5ae@epcas5p1.samsung.com>
 <1518774280-38090-1-git-send-email-t.vivek@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518774280-38090-1-git-send-email-t.vivek@samsung.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-02-18 15:14:40, t.vivek@samsung.com wrote:
> From: Vivek Trivedi <t.vivek@samsung.com>
> 
> If fanotify userspace response server thread is frozen first,
> it may fail to send response from userspace to kernel space listener.
> In this scenario, fanotify response listener will never get response
> from userepace and fail to suspend.
> 
> Use freeze-friendly wait API to handle this issue.
> 
> Same problem was reported here:
> https://bbs.archlinux.org/viewtopic.php?id=232270
> 
> Freezing of tasks failed after 20.005 seconds
> (1 tasks refusing to freeze, wq_busy=0)
> 
> Backtrace:
> [<c0582f80>] (__schedule) from [<c05835d0>] (schedule+0x4c/0xa4)
> [<c0583584>] (schedule) from [<c01cb648>] (fanotify_handle_event+0x1c8/0x218)
> [<c01cb480>] (fanotify_handle_event) from [<c01c8238>] (fsnotify+0x17c/0x38c)
> [<c01c80bc>] (fsnotify) from [<c02676dc>] (security_file_open+0x88/0x8c)
> [<c0267654>] (security_file_open) from [<c01854b0>] (do_dentry_open+0xc0/0x338)
> [<c01853f0>] (do_dentry_open) from [<c0185a38>] (vfs_open+0x54/0x58)
> [<c01859e4>] (vfs_open) from [<c0195480>] (do_last.isra.10+0x45c/0xcf8)
> [<c0195024>] (do_last.isra.10) from [<c0196140>] (path_openat+0x424/0x600)
> [<c0195d1c>] (path_openat) from [<c0197498>] (do_filp_open+0x3c/0x98)
> [<c019745c>] (do_filp_open) from [<c0186b44>] (do_sys_open+0x120/0x1e4)
> [<c0186a24>] (do_sys_open) from [<c0186c30>] (SyS_open+0x28/0x2c)
> [<c0186c08>] (SyS_open) from [<c0010200>] (__sys_trace_return+0x0/0x20)

Yeah, good catch.

> @@ -63,7 +64,9 @@ static int fanotify_get_response(struct fsnotify_group *group,
>  
>  	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
>  
> -	wait_event(group->fanotify_data.access_waitq, event->response);
> +	while (!event->response)
> +		wait_event_freezable(group->fanotify_data.access_waitq,
> +				     event->response);

But if the process gets a signal while waiting, we will just livelock the
kernel in this loop as wait_event_freezable() will keep returning
ERESTARTSYS. So you need to be a bit more clever here...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
