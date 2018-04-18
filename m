Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753577AbeDROkW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:40:22 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:38510 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbeDROkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:40:20 -0400
X-Google-Smtp-Source: AIpwx48OHeywodPDkvtYOLYTzLdTorQIJpAt6XZMIy6ZHrmeUpLgIYT7qvV3TZExgqb+5nD/CWWdFwvW2ZkP5zykwQY=
MIME-Version: 1.0
X-Originating-IP: [176.63.54.97]
In-Reply-To: <20180418102504.7673a7f3@gandalf.local.home>
References: <20180418062907.3210386-1-songliubraving@fb.com>
 <CAELBmZCvrL4s+cx2cECMQLQUx0hMxVP-dv9UGBfh64AS6unaBA@mail.gmail.com> <20180418102504.7673a7f3@gandalf.local.home>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 18 Apr 2018 16:40:19 +0200
Message-ID: <CAJfpegtKsMBjqfg6Ewz3o9197GyqS6wTauuuMExj3DDZU+CPFA@mail.gmail.com>
Subject: Re: [PATCH 1/2] tracing: fix bad use of igrab in trace_uprobe.c
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Song Liu <songliubraving@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Howard McLauchlan <hmclauchlan@fb.com>, Josef Bacik <jbacik@fb.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 4:25 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 18 Apr 2018 16:03:42 +0200
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
>> > @@ -937,7 +928,8 @@ probe_event_enable(struct trace_uprobe *tu, struct trace_event_file *file,
>> >                 goto err_flags;
>> >
>> >         tu->consumer.filter = filter;
>> > -       ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
>> > +       ret = uprobe_register(d_inode(tu->path.dentry), tu->offset,
>> > +                             &tu->consumer);
>>
>> It is not entirely clear how the lifetime of uprobe relates to the
>> lifetime of trace_uprobe.  Is the uprobe object never going to survive
>> its creator trace_uprobe object?
>
> Not exactly sure what you mean here.
>
> The trace_uprobe (the probe event) is created, it doesn't do anything
> until it is enabled. This function is called when it is enabled. The
> trace_uprobe (probe event) can not be deleted while it is enabled
> (EBUSY).
>
> Are you asking what happens if the file is deleted while it has probe?
> That I don't know about (haven't tried it out). But I would hope that
> it keeps a reference to the inode, isn't that what the igrab is for?
> And is now being replaced by a reference on the path, or is that the
> problem?

No, that's not the problem.

What I don't see is how the uprobe object relates to the trace_uprobe object.

Because after the patch the uprobe object still only has a ref to the
inode, and that can lead to the same issue as with trace_uprobe.
OTOH if uprobe can't survive its creating trace_uprobe, then it
doesn't need to take a ref to the inode at all, since trace_uprobe
already holds it.   Taking an extra ref isn't incorrect, it's just
unnecessary and confusing.

So this needs to be cleared up in some way.

Thanks,
Miklos
