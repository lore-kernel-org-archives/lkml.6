Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B34C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7207922459
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7207922459
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030639AbeF1TD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:03:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:40842 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030606AbeF1TDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:03:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4AC46AD88;
        Thu, 28 Jun 2018 19:03:52 +0000 (UTC)
Date:   Thu, 28 Jun 2018 11:41:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] printk/nmi: Prevent deadlock when accessing the
 main log buffer in NMI
Message-ID: <20180628094125.cq5qunckjyxhbovb@pathway.suse.cz>
References: <20180627140817.27764-1-pmladek@suse.com>
 <20180627142028.11259-1-pmladek@suse.com>
 <20180628022507.GD481@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628022507.GD481@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-06-28 11:25:07, Sergey Senozhatsky wrote:
> On (06/27/18 16:20), Petr Mladek wrote:
> > +/*
> > + * Marks a code that might produce many messages in NMI context
> > + * and the risk of losing them is more critical than eventual
> > + * reordering.
> > + *
> > + * It has effect only when called in NMI context. Then printk()
> > + * will try to store the messages into the main logbuf directly
> > + * and use the per-CPU buffers only as a fallback when the lock
> > + * is not available.
> > + */
> > +void printk_nmi_direct_enter(void)
> > +{
> > +	if (this_cpu_read(printk_context) & PRINTK_NMI_CONTEXT_MASK)
> > +		this_cpu_or(printk_context, PRINTK_NMI_DIRECT_CONTEXT_MASK);
> > +}
> 
> A side note: This nesting also handles recursive printk-s for us.
> 
> NMI:
> 	printk_nmi_enter
> 	ftrace_dump
> 	 printk_nmi_direct_enter
> 	  vprintk_func
> 	   spin_lock(logbuf_lock)
> 	    vprintk_store
> 	     vsprintf
> 	      WARN_ON
> 	       vprintk_func
> 	        vprintk_nmi

Uff, it seems that the current design is "good" at lest from some
points of view.

> >  __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
> >  {
> > +	/*
> > +	 * Try to use the main logbuf even in NMI. But avoid calling console
> > +	 * drivers that might have their own locks.
> > +	 */
> > +	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK) &&
> > +	    raw_spin_trylock(&logbuf_lock)) {
> > +		int len;
> > +
> > +		len = vprintk_store(0, LOGLEVEL_DEFAULT, NULL, 0, fmt, args);
> > +		raw_spin_unlock(&logbuf_lock);
> > +		defer_console();
> > +		return len;
> > +	}
> 
> So, maybe, something a bit better than defer_console().

I am not super happy with the name either. But wakeup_console(),
schedule_console(), or queue_console() looked confusing.

Also I thought about poke_console() but I guess that I already suggested
this name in the past and people did not like it.

Feel free to suggest anything.


> Otherwise,
> Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Anyway, thanks a lot for review.

Best Regards,
Petr
