Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2928C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B0720874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B0720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937402AbeFSHwX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:52:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:60280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937201AbeFSHwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:52:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4A903AD02;
        Tue, 19 Jun 2018 07:52:20 +0000 (UTC)
Date:   Tue, 19 Jun 2018 09:52:19 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org, "4 . 13+" <stable@vger.kernel.org>
Subject: Re: [PATCH] printk/nmi: Prevent deadlock when serializing NMI
 backtraces
Message-ID: <20180619075219.iq7ztwu43bn4uua7@pathway.suse.cz>
References: <20180517143903.19339-1-pmladek@suse.com>
 <20180605124729.3vix5nlkjpjzdljx@pathway.suse.cz>
 <20180606051029.GA19211@tigerII.localdomain>
 <20180606103356.GB19211@tigerII.localdomain>
 <20180608104825.e7xoxteelaxnwx66@pathway.suse.cz>
 <20180618063738.GC27996@jagdpanzerIV>
 <20180618093917.qeaatnlqh5if6t3r@pathway.suse.cz>
 <20180618100718.GA555@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618100718.GA555@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-06-18 19:07:18, Sergey Senozhatsky wrote:
> On (06/18/18 11:39), Petr Mladek wrote:
> [..]
> > > >  extern void printk_nmi_enter(void);
> > > >  extern void printk_nmi_exit(void);
> > > > +extern void printk_nmi_direct_enter(void);
> > > > +extern void printk_nmi_direct_exit(void);
> > > >  #else
> > > >  static inline void printk_nmi_enter(void) { }
> > > >  static inline void printk_nmi_exit(void) { }
> > > > +static void printk_nmi_direct_enter(void) { }
> > > > +static void printk_nmi_direct_exit(void) { }
> > > 
> > > Can we have better names may be? Since direct printk_nmi is not
> > > in fact always `direct'.
> > 
> > What about printk_chatty_nmi_enter(), printk_large_nmi_enter()
> > or something similar?
> 
> Hmm. Can't answer right now :)

Please, let me know what name you would like ;-)


> > > > +#ifdef CONFIG_PRINTK_NMI
> > > > +__printf(1, 0) int vprintk_nmi(const char *fmt, va_list args);
> > > > +#else
> > > > +__printf(1, 0) int vprintk_nmi(const char *fmt, va_list args) { return 0; }
> > > > +#endif
> > > 
> > > Hmm, printk_safe.c knows about printk.c, printk.c knows about
> > > printk_safe.c.
> 
> Just wanted to suggest to keep printk_safe/printk_nmi stuff in printk_safe.c.
> We already have everything we need there, so let's just add the vprintk_nmi()
> fallback, avoiding spreading printk_safe/printk_nmi logic and details across
> printk.c and printk_safe.c

This won't be needed in v2 where the decision will be made in vprintk_func().


> > > OK... Can we do this in vprintk_func()? The race window should be super
> > > tiny [if matters at all], but in exchange we don't have to mix nmi, printk,
> > > printk_mni, etc.
> > 
> > You are right that it would still solve the main risk (NMI comes
> > inside logbuf_lock critical section).
> > 
> > In fact, the only real risk would be another lock serializing NMIs
> > and printk() called with that lock. This patch removes one in
> > nmi_backtrace() and I am not aware of any other.
> > 
> > The less hairy code really might be worth the rather theoretical risk.
> 
> Does this mean that we agreed to handle the printk_nmi per-CPU buffer
> fallback in printk_safe.c?

Yes, I feel persuaded.

Best Regards,
Petr
