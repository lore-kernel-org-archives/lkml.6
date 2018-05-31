Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755391AbeEaOVE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:21:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:56960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755274AbeEaOVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:21:02 -0400
Date: Thu, 31 May 2018 16:21:00 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] printk: drop in_nmi check from
 printk_safe_flush_on_panic()
Message-ID: <20180531142100.bwseualfb2qrxwjb@pathway.suse.cz>
References: <20180530070350.10131-1-sergey.senozhatsky@gmail.com>
 <20180530072419.jqoohtcvenlnym6h@pathway.suse.cz>
 <20180530075105.GA12230@jagdpanzerIV>
 <20180530084801.i5mzqhlw2w5o2eod@pathway.suse.cz>
 <20180530095504.GD12230@jagdpanzerIV>
 <20180530100037.GE12230@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530100037.GE12230@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-05-30 19:00:37, Sergey Senozhatsky wrote:
> On (05/30/18 18:55), Sergey Senozhatsky wrote:
> > The thing is, we, in fact, already invoke panic() in printk_safe mode.
> > Sometimes.
> > 
> > Namely,
> > 
> >   nmi_panic() -> panic()
> > 
> > is invoked while we are in printk_nmi(), so all printk()-s go
> > to the per-CPU buffers. So, at least to some extent, panic()
> > in printk_safe context is not something never seen before. Just
> > saying.
> 
> Well, we have a PRINTK_NMI_DEFERRED_CONTEXT_MASK mode for
> printk_nmi(). May be we can [if need be] come up with the same trick
> for printk_safe_panic() mode. If logbuf spin_lock is unlocked, then
> we use the main logbuf, if it is locked, we redirect printk to per-CPU
> buffers and then flush it via printk_safe_flush_on_panic(), which will
> re-init (unlock) the logbuf.

All these checks are racy. Now, I believe that it might really prevent
a deadlock in some situations but it might also cause loosing messages
in other situations (never flushed buffer). I am sorry but I am still
unable to decide if it is worth the risk.

I would want to keep it as is until anyone comes with a more detailed
analyze or until we get some bug reports.

Best Regards,
Petr
