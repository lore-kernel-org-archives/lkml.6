Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbeBASA3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:00:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:50640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbeBASA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:00:28 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9271B21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 1 Feb 2018 13:00:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] printk: do not flush printk_safe from irq_work
Message-ID: <20180201130025.38fa70e0@gandalf.local.home>
In-Reply-To: <20180129022918.GA24497@jagdpanzerIV>
References: <20180124093723.1300-1-sergey.senozhatsky@gmail.com>
        <20180126152613.7mko26ulk24hzjlp@pathway.suse.cz>
        <20180129022918.GA24497@jagdpanzerIV>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2018 11:29:18 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> On (01/26/18 16:26), Petr Mladek wrote:
> [..]
> > First, this delays showing eventually valuable information until
> > the preemption is enabled. It might never happen if the system
> > is in big troubles. In each case, it might be much longer delay
> > than it was before.  
> 
> If the system is in "big troubles" then what makes irq_work more
> possible? Local IRQs can stay disabled, just like preemption. I
> guess when the troubles are really big our strategy is the same
> for both wq and irq_work solutions - we keep the printk_safe buffer
> and wait for panic()->flush.

Working on the RT kernel, I would tell you there's a huge difference
getting an irq_work to trigger than to expect something to schedule.

It takes much less to disable the systems scheduling than it does to
disable interrupts. If interrupts are disabled, then so is scheduling.
But if scheduling is disabled, interrupts may still trigger.

But if printk_safe() is just for recursion protection, how important is
it to get out?

-- Steve
