Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752665AbeDRPTU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751204AbeDRPTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:19:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B072178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 18 Apr 2018 11:19:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Song Liu <songliubraving@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Howard McLauchlan <hmclauchlan@fb.com>, Josef Bacik <jbacik@fb.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] tracing: fix bad use of igrab in trace_uprobe.c
Message-ID: <20180418111916.2325bf9c@gandalf.local.home>
In-Reply-To: <CAJfpegtKsMBjqfg6Ewz3o9197GyqS6wTauuuMExj3DDZU+CPFA@mail.gmail.com>
References: <20180418062907.3210386-1-songliubraving@fb.com>
        <CAELBmZCvrL4s+cx2cECMQLQUx0hMxVP-dv9UGBfh64AS6unaBA@mail.gmail.com>
        <20180418102504.7673a7f3@gandalf.local.home>
        <CAJfpegtKsMBjqfg6Ewz3o9197GyqS6wTauuuMExj3DDZU+CPFA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2018 16:40:19 +0200
Miklos Szeredi <miklos@szeredi.hu> wrote:


> > The trace_uprobe (the probe event) is created, it doesn't do anything
> > until it is enabled. This function is called when it is enabled. The
> > trace_uprobe (probe event) can not be deleted while it is enabled
> > (EBUSY).
> >
> > Are you asking what happens if the file is deleted while it has probe?
> > That I don't know about (haven't tried it out). But I would hope that
> > it keeps a reference to the inode, isn't that what the igrab is for?
> > And is now being replaced by a reference on the path, or is that the
> > problem?  
> 
> No, that's not the problem.
> 
> What I don't see is how the uprobe object relates to the trace_uprobe object.
> 
> Because after the patch the uprobe object still only has a ref to the
> inode, and that can lead to the same issue as with trace_uprobe.
> OTOH if uprobe can't survive its creating trace_uprobe, then it
> doesn't need to take a ref to the inode at all, since trace_uprobe
> already holds it.   Taking an extra ref isn't incorrect, it's just
> unnecessary and confusing.
> 
> So this needs to be cleared up in some way.

The uprobe created by the trace_uprobe creation must be deleted before
the trace_uprobe can be deleted. Basically we have this:

 # cd /sys/kernel/tracing
 # echo "uprobe creation text" > uprobe_events

The trace_uprobe is created (but not the uprobe itself). This is what
calls create_trace_uprobe().

 # echo 1 > events/uprobes/enable

This enables all the trace uprobe events, which creates the uprobes.
This is the action that calls probe_event_enable(), which creates
uprobes.

At this point, any write to uprobe_events that would destroy the trace
uprobes would return with -EBUSY, and the trace uprobes will not be
deleted.

 # echo 0 > events/uprobes/enable

This will call the probe_event_disable() which will call
uprobe_unregister() which will destroy the uprobe.

Now we can delete the trace uprobe.

Does that answer your question? A uprobe created for trace uprobes can
not survive the trace uprobe itself.

-- Steve
