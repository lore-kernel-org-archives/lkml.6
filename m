Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5774C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF0E27B85
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF0E27B85
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933060AbeF2HZL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:25:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:45962 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932331AbeF2HZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:25:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 47686AD52;
        Fri, 29 Jun 2018 07:25:08 +0000 (UTC)
Date:   Fri, 29 Jun 2018 09:25:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] printk/nmi: Prevent deadlock when accessing the
 main log buffer in NMI
Message-ID: <20180629072507.lroaj34gxl2d5bze@pathway.suse.cz>
References: <20180627140817.27764-1-pmladek@suse.com>
 <20180627142028.11259-1-pmladek@suse.com>
 <20180628022507.GD481@jagdpanzerIV>
 <20180628094125.cq5qunckjyxhbovb@pathway.suse.cz>
 <20180629014703.GA614@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629014703.GA614@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-06-29 10:47:03, Sergey Senozhatsky wrote:
> On (06/28/18 11:41), Petr Mladek wrote:
> > > 
> > > A side note: This nesting also handles recursive printk-s for us.
> > > 
> > > NMI:
> > > 	printk_nmi_enter
> > > 	ftrace_dump
> > > 	 printk_nmi_direct_enter
> > > 	  vprintk_func
> > > 	   spin_lock(logbuf_lock)
> > > 	    vprintk_store
> > > 	     vsprintf
> > > 	      WARN_ON
> > > 	       vprintk_func
> > > 	        vprintk_nmi
> > 
> > Uff, it seems that the current design is "good" at lest from some
> > points of view.
> 
> yep yep
> 
> > > > +		len = vprintk_store(0, LOGLEVEL_DEFAULT, NULL, 0, fmt, args);
> > > > +		raw_spin_unlock(&logbuf_lock);
> > > > +		defer_console();
> > > > +		return len;
> > > > +	}
> > > 
> > > So, maybe, something a bit better than defer_console().
> > 
> > I am not super happy with the name either. But wakeup_console(),
> > schedule_console(), or queue_console() looked confusing.
> 
> Hmm. defer_console() makes me think that we are dealing with that
> fbcon=nodefer and deferred console takeover thing here.
> 
> 
> So I summon Mr. Rostedt!
> 
> Does schedule_console_output() look bad?
> What about defer_console_output()?

I am fine with both. I slightly prefer defer_console_output()
because I have "schedule" associated with deadlocks in this
code path (context) ;-)

Best Regards,
Petr
