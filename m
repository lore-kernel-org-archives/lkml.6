Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35E1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0A52133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbeLSIuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:50:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:49258 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725294AbeLSIuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:50:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 20BB1AEF5;
        Wed, 19 Dec 2018 08:50:18 +0000 (UTC)
Date:   Wed, 19 Dec 2018 09:50:16 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] printk: increase devkmsg write() ratelimit
Message-ID: <20181219085016.kvb6o7e4pz2hkjna@pathway.suse.cz>
References: <20181218114709.GF7485@zn.tnic>
 <20181218130750.GA665@tigerII.localdomain>
 <20181218142623.GH7485@zn.tnic>
 <20181218145558.GD665@tigerII.localdomain>
 <20181218150313.GI7485@zn.tnic>
 <20181218151455.GE665@tigerII.localdomain>
 <20181218152413.GJ7485@zn.tnic>
 <20181218165217.GA534@tigerII.localdomain>
 <20181218172109.GK15430@hirez.programming.kicks-ass.net>
 <20181218123748.3aadd16c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218123748.3aadd16c@gandalf.local.home>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-12-18 12:37:48, Steven Rostedt wrote:
> On Tue, 18 Dec 2018 18:21:09 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, Dec 19, 2018 at 01:52:17AM +0900, Sergey Senozhatsky wrote:
> > > On (12/18/18 16:24), Borislav Petkov wrote:  
> > > > On Wed, Dec 19, 2018 at 12:14:55AM +0900, Sergey Senozhatsky wrote:  
> > > > > Right, but unlike log_buf_len, devkmsg is a bit close to a "binary" knob:
> > > > > either all messages or none;  
> > > > 
> > > > ... which is perfectly fine for a debugging session.  
> > > 
> > > But devkmsg ratelimits systemd errors, so one does not even know that
> > > "some debugging is required". For instance from my x86 box:
> > > 
> > >  Unmounting /home...
> > >  [..]
> > >  home.mount: Mount process exited, code=exited status=32
> > >  Failed unmounting /home.
> > > 
> > > I don't want to debug systemd, I want to know that something didn't
> > > work out. 10 messages max and 5 seconds interval looks a bit too strict.  
> > 
> > Again, complain to system-doofus for printing so much crap to somewhere
> > it should not print to begin with.
> 
> I've been saying that it would be good to make the kmsg be a separate
> buffer that just gets interleaved with the kernel buffer. Userspace
> processes should never be able to overwrite messages from the kernel.

There was a proposal for this few years ago, see
https://lkml.kernel.org/r/1435920595-30879-1-git-send-email-m.niesluchow@samsung.com

Honestly, I got scared. It proposed an interface for dynamically adding
separate /dev/kmsg devices and related log buffers. This smells with
huge amount of messages that might fight for console throughput and
complicate printk code.

Best Regards,
Petr
