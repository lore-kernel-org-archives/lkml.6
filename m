Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeDKCN0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 22:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752295AbeDKCNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 22:13:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0126921785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Wed, 11 Apr 2018 11:13:22 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Howard McLauchlan <hmclauchlan@fb.com>, <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, <kernel-team@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] uprobe: add support for overlayfs
Message-Id: <20180411111322.14b5a21ea61ad968f8375427@kernel.org>
In-Reply-To: <20180410200059.731d87fe@gandalf.local.home>
References: <20180410231030.2720-1-hmclauchlan@fb.com>
        <20180410200059.731d87fe@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2018 20:00:59 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 10 Apr 2018 16:10:30 -0700
> Howard McLauchlan <hmclauchlan@fb.com> wrote:
> 
> > uprobes cannot successfully attach to binaries located in a directory
> > mounted with overlayfs.
> > 
> > To verify, create directories for mounting overlayfs
> > (upper,lower,work,merge), move some binary into merge/ and use readelf
> > to obtain some known instruction of the binary. I used /bin/true and the
> > entry instruction(0x13b0):
> > 
> > 	$ mount -t overlay overlay -o lowerdir=lower,upperdir=upper,workdir=work merge
> > 	$ cd /sys/kernel/debug/tracing
> > 	$ echo 'p:true_entry PATH_TO_MERGE/merge/true:0x13b0' > uprobe_events
> > 	$ echo 1 > events/uprobes/true_entry/enable
> > 
> > This returns 'bash: echo: write error: Input/output error' and dmesg
> > tells us 'event trace: Could not enable event true_entry'
> 
> I tried the above and verified that it is a problem and your patch
> solves it.
> 
> Thanks, I'll apply it and start my tests on it.

This looks good to me. 

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> -- Steve
> 
> > 
> > This change makes create_trace_uprobe() look for the real inode of a
> > dentry. In the case of normal filesystems, this simplifies to just
> > returning the inode. In the case of overlayfs(and similar fs) we will
> > obtain the underlying dentry and corresponding inode, upon which uprobes
> > can successfully register.
> > 
> > Running the example above with the patch applied, we can see that the
> > uprobe is enabled and will output to trace as expected.
> > 
> > Reviewed-by: Josef Bacik <jbacik@fb.com>
> > Signed-off-by: Howard McLauchlan <hmclauchlan@fb.com>
> > ---
> >  kernel/trace/trace_uprobe.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > index 2014f4351ae0..17c65fa4136d 100644
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -446,7 +446,7 @@ static int create_trace_uprobe(int argc, char **argv)
> >  	if (ret)
> >  		goto fail_address_parse;
> >  
> > -	inode = igrab(d_inode(path.dentry));
> > +	inode = igrab(d_real_inode(path.dentry));
> >  	path_put(&path);
> >  
> >  	if (!inode || !S_ISREG(inode->i_mode)) {
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
