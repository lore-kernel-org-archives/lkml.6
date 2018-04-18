Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753706AbeDROZJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752659AbeDROZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:25:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF394204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 18 Apr 2018 10:25:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Song Liu <songliubraving@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Howard McLauchlan <hmclauchlan@fb.com>, Josef Bacik <jbacik@fb.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] tracing: fix bad use of igrab in trace_uprobe.c
Message-ID: <20180418102504.7673a7f3@gandalf.local.home>
In-Reply-To: <CAELBmZCvrL4s+cx2cECMQLQUx0hMxVP-dv9UGBfh64AS6unaBA@mail.gmail.com>
References: <20180418062907.3210386-1-songliubraving@fb.com>
        <CAELBmZCvrL4s+cx2cECMQLQUx0hMxVP-dv9UGBfh64AS6unaBA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2018 16:03:42 +0200
Miklos Szeredi <miklos@szeredi.hu> wrote:

> > @@ -937,7 +928,8 @@ probe_event_enable(struct trace_uprobe *tu, struct trace_event_file *file,
> >                 goto err_flags;
> >
> >         tu->consumer.filter = filter;
> > -       ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
> > +       ret = uprobe_register(d_inode(tu->path.dentry), tu->offset,
> > +                             &tu->consumer);  
> 
> It is not entirely clear how the lifetime of uprobe relates to the
> lifetime of trace_uprobe.  Is the uprobe object never going to survive
> its creator trace_uprobe object?

Not exactly sure what you mean here.

The trace_uprobe (the probe event) is created, it doesn't do anything
until it is enabled. This function is called when it is enabled. The
trace_uprobe (probe event) can not be deleted while it is enabled
(EBUSY).

Are you asking what happens if the file is deleted while it has probe?
That I don't know about (haven't tried it out). But I would hope that
it keeps a reference to the inode, isn't that what the igrab is for?
And is now being replaced by a reference on the path, or is that the
problem?

-- Steve


> 
> If that's the case, it warrants a comment.  If that's not the case,
> then the path would need to be passed to uprobe_resister() which would
> need to obtain its own reference.
> 
> >         if (ret)
> >                 goto err_buffer;
> >
