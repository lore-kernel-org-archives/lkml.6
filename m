Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E2EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8633E21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeLRRhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:37:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbeLRRhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:37:51 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3BDA20578;
        Tue, 18 Dec 2018 17:37:49 +0000 (UTC)
Date:   Tue, 18 Dec 2018 12:37:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] printk: increase devkmsg write() ratelimit
Message-ID: <20181218123748.3aadd16c@gandalf.local.home>
In-Reply-To: <20181218172109.GK15430@hirez.programming.kicks-ass.net>
References: <20181218104812.GC15430@hirez.programming.kicks-ass.net>
        <20181218111701.GA32522@jagdpanzerIV>
        <20181218114709.GF7485@zn.tnic>
        <20181218130750.GA665@tigerII.localdomain>
        <20181218142623.GH7485@zn.tnic>
        <20181218145558.GD665@tigerII.localdomain>
        <20181218150313.GI7485@zn.tnic>
        <20181218151455.GE665@tigerII.localdomain>
        <20181218152413.GJ7485@zn.tnic>
        <20181218165217.GA534@tigerII.localdomain>
        <20181218172109.GK15430@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 18:21:09 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Dec 19, 2018 at 01:52:17AM +0900, Sergey Senozhatsky wrote:
> > On (12/18/18 16:24), Borislav Petkov wrote:  
> > > On Wed, Dec 19, 2018 at 12:14:55AM +0900, Sergey Senozhatsky wrote:  
> > > > Right, but unlike log_buf_len, devkmsg is a bit close to a "binary" knob:
> > > > either all messages or none;  
> > > 
> > > ... which is perfectly fine for a debugging session.  
> > 
> > But devkmsg ratelimits systemd errors, so one does not even know that
> > "some debugging is required". For instance from my x86 box:
> > 
> >  Unmounting /home...
> >  [..]
> >  home.mount: Mount process exited, code=exited status=32
> >  Failed unmounting /home.
> > 
> > I don't want to debug systemd, I want to know that something didn't
> > work out. 10 messages max and 5 seconds interval looks a bit too strict.  
> 
> Again, complain to system-doofus for printing so much crap to somewhere
> it should not print to begin with.

I've been saying that it would be good to make the kmsg be a separate
buffer that just gets interleaved with the kernel buffer. Userspace
processes should never be able to overwrite messages from the kernel.

-- Steve
