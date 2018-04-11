Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeDKABE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 20:01:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751960AbeDKABD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 20:01:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6DFE21722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 10 Apr 2018 20:00:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Howard McLauchlan <hmclauchlan@fb.com>
Cc: <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        <kernel-team@fb.com>, Masami Hiramatsu <mhiramat@kernel.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] uprobe: add support for overlayfs
Message-ID: <20180410200059.731d87fe@gandalf.local.home>
In-Reply-To: <20180410231030.2720-1-hmclauchlan@fb.com>
References: <20180410231030.2720-1-hmclauchlan@fb.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2018 16:10:30 -0700
Howard McLauchlan <hmclauchlan@fb.com> wrote:

> uprobes cannot successfully attach to binaries located in a directory
> mounted with overlayfs.
> 
> To verify, create directories for mounting overlayfs
> (upper,lower,work,merge), move some binary into merge/ and use readelf
> to obtain some known instruction of the binary. I used /bin/true and the
> entry instruction(0x13b0):
> 
> 	$ mount -t overlay overlay -o lowerdir=lower,upperdir=upper,workdir=work merge
> 	$ cd /sys/kernel/debug/tracing
> 	$ echo 'p:true_entry PATH_TO_MERGE/merge/true:0x13b0' > uprobe_events
> 	$ echo 1 > events/uprobes/true_entry/enable
> 
> This returns 'bash: echo: write error: Input/output error' and dmesg
> tells us 'event trace: Could not enable event true_entry'

I tried the above and verified that it is a problem and your patch
solves it.

Thanks, I'll apply it and start my tests on it.

-- Steve

> 
> This change makes create_trace_uprobe() look for the real inode of a
> dentry. In the case of normal filesystems, this simplifies to just
> returning the inode. In the case of overlayfs(and similar fs) we will
> obtain the underlying dentry and corresponding inode, upon which uprobes
> can successfully register.
> 
> Running the example above with the patch applied, we can see that the
> uprobe is enabled and will output to trace as expected.
> 
> Reviewed-by: Josef Bacik <jbacik@fb.com>
> Signed-off-by: Howard McLauchlan <hmclauchlan@fb.com>
> ---
>  kernel/trace/trace_uprobe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 2014f4351ae0..17c65fa4136d 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -446,7 +446,7 @@ static int create_trace_uprobe(int argc, char **argv)
>  	if (ret)
>  		goto fail_address_parse;
>  
> -	inode = igrab(d_inode(path.dentry));
> +	inode = igrab(d_real_inode(path.dentry));
>  	path_put(&path);
>  
>  	if (!inode || !S_ISREG(inode->i_mode)) {
