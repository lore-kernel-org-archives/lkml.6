Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762C8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494EA21019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494EA21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeK3Hgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 02:36:53 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39518 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeK3Hgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 02:36:53 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 17311AE7;
        Thu, 29 Nov 2018 20:30:13 +0000 (UTC)
Date:   Thu, 29 Nov 2018 12:30:12 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     d17103513@gmail.com
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        David Howells <dhowells@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Cheng Yang <chengyang@xiaomi.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Security: Handle hidepid option correctly
Message-Id: <20181129123012.18da0fd4ed647b6a6de4cb3b@linux-foundation.org>
In-Reply-To: <9da18eb4cb3701bd2da933e8e096c1ea6e9a44c1.1543472629.git.chengyang@xiaomi.com>
References: <cover.1543472629.git.chengyang@xiaomi.com>
        <9da18eb4cb3701bd2da933e8e096c1ea6e9a44c1.1543472629.git.chengyang@xiaomi.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> [PATCH] Security: Handle hidepid option correctly

Why is this considered to be security sensitive?  I can guess, but I'd
like to know your reasoning.

On Thu, 29 Nov 2018 19:08:21 +0800 d17103513@gmail.com wrote:

> From: Cheng Yang <chengyang@xiaomi.com>
> 
> The proc_parse_options() call from proc_mount() runs only once at boot
> time.  So on any later mount attempt, any mount options are ignored
> because ->s_root is already initialized.
> As a consequence, "mount -o <options>" will ignore the options.  The
> only way to change mount options is "mount -o remount,<options>".
> To fix this, parse the mount options unconditionally.
> 
> --- a/fs/proc/inode.c
> +++ b/fs/proc/inode.c
> @@ -493,13 +493,9 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
>  
>  int proc_fill_super(struct super_block *s, void *data, int silent)
>  {
> -	struct pid_namespace *ns = get_pid_ns(s->s_fs_info);
>  	struct inode *root_inode;
>  	int ret;
>  
> -	if (!proc_parse_options(data, ns))
> -		return -EINVAL;
> -
>  	/* User space would break if executables or devices appear on proc */
>  	s->s_iflags |= SB_I_USERNS_VISIBLE | SB_I_NOEXEC | SB_I_NODEV;
>  	s->s_flags |= SB_NODIRATIME | SB_NOSUID | SB_NOEXEC;
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index f4b1a9d..f5f3bf3 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -98,6 +98,9 @@ static struct dentry *proc_mount(struct file_system_type *fs_type,
>  		ns = task_active_pid_ns(current);
>  	}
>  
> +	if (!proc_parse_options(data, ns))
> +		return ERR_PTR(-EINVAL);
> +
>  	return mount_ns(fs_type, flags, data, ns, ns->user_ns, proc_fill_super);
>  }

Other filesystems parse the options from fill_super().  Is proc special
in some fashion?

