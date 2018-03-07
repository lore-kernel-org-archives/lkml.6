Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754106AbeCGCb3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 21:31:29 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40997 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753904AbeCGCb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 21:31:28 -0500
X-Google-Smtp-Source: AG47ELvp5zpa8mcyGkqY31HWW4S23/XduSBwlbWWnXYBT1Dm2OgOnb8f1xw5d2UOU6OJHCZS4Ca3rQ==
Date: Wed, 7 Mar 2018 11:31:23 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrea Parri <parri.andrea@gmail.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Question] printk_safe: Do you want synch./barriers in
 raw_spin_is_locked()
Message-ID: <20180307023123.GC802@jagdpanzerIV>
References: <20180306145845.GA15389@andrea>
 <20180306172115.752d5c1f@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306172115.752d5c1f@vmware.local.home>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'll Cc linux-kernel

On (03/06/18 17:21), Steven Rostedt wrote:
> On Tue, 6 Mar 2018 15:58:46 +0100
> Andrea Parri <parri.andrea@gmail.com> wrote:
> 
> > Dear PRINTK maintainers,
> > 
> > Following a recent discussion on LKML[1], I started auditing callsites
> > of spin_is_locked() and the "implicit" assumptions these sites made on
> > the memory ordering enforced by this primitive (not a first attempt[2],
> > FWIW).  As it turns out, this primitive is mostly used (40+ calls) for
> > debugging purposes (WARN_ON(!spin_is_locked()) or such), but the calls
> > to raw_spin_is_locked() in printk_safe seem to escape this usage.
> > 
> > Which assumptions are you relying on (if any) for raw_spin_is_locked()
> > enforced memory ordering?
> 
> We don't care about other CPUs. The use case here is to make sure that
> the printk in an NMI does not take the lock when the current CPU has
> it. Memory ordering is fine when dealing with only one CPU. If other
> CPUs mess with the result, then the worse that will happen is that we
> go to the "safe" mode when we didn't have to.

Right, thanks Steven.

A side note,
I think the only reason we have that raw_spin_is_locked() is because we
call console drivers in printk-safe mode, so we don't have a 1:1 mapping:

		printk-safe == raw_spin_is_locked(logbuf)

I sort of think we can stop calling console drivers in printk-safe,
there seems to be no real reasons to do so (kind of). And then we will
have that missing printk-safe == raw_spin_is_locked(logbuf) so we will
be able to drop raw_spin_is_locked() from printk-safe and make logbuf
spin_lock static again.

> BTW, next time when asking a question, don't do it off list. This may
> be something others would like to know. I usually don't answer
> questions like this when they don't include a Cc to a mailing list.

Agreed.

	-ss
