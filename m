Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbeCTDMM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 23:12:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46052 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbeCTDMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 23:12:09 -0400
Date: Mon, 19 Mar 2018 20:12:02 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] autofs4: Use wait_event_killable
Message-ID: <20180320031202.GA22556@bombadil.infradead.org>
References: <20180319191609.23880-1-willy@infradead.org>
 <7dae3cc8-bad1-ec18-bcf1-ae91a87f74fa@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dae3cc8-bad1-ec18-bcf1-ae91a87f74fa@themaw.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 09:58:59AM +0800, Ian Kent wrote:
> On 20/03/18 03:16, Matthew Wilcox wrote:
> > From: Matthew Wilcox <mawilcox@microsoft.com>
> > This playing with signals to allow only fatal signals appears to predate
> > the introduction of wait_event_killable(), and I'm fairly sure that
> > wait_event_killable is what was meant to happen here.
> 
> Predates is an understatement, this is really, really old code.
> Do I need to forward this to Al or Andrew?

Looks like Andrew usually picks these up directly.  Here's the line
he'll want:

Link: http://lkml.kernel.org/r/20180319191609.23880-1-willy@infradead.org

> > Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> Signed-off-by: Ian Kent <raven@themaw.net>


> > +	wait_event_killable(wq->queue, wq->name.name == NULL);
> 
> The wait event code looks like this will wake up on most any unmasked signal.
> But my assumption is that TASK_KILLABLE tasks are only forwarded specific
> signals ...
> 
> Is that right or am I missing something?

The signal code is gnarly.  As far as I can decipher it, a fatal
signal is always turned into SIGKILL (in complete_signal()), and the
task is woken.  For a task sleeping in TASK_KILLABLE, signal_wake_up()
passes TASK_WAKEKILL to signal_wake_up_state() if the signal is SIGKILL.
TASK_KILLABLE sets (TASK_WAKEKILL | TASK_UNINTERRUPTIBLE) so it will be
woken in order to die.

If the signal being sent isn't sig_fatal(), then we don't wake the task.
The signal will still be in the pending set, so it can notice when
exiting to userspace, but it won't be woken.
