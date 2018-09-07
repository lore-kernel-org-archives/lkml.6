Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49529C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C98206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yUBPsglc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C98206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbeIGOLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:11:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53808 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbeIGOLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3zQM+JXz2y+mlIlHL2G40e8Am5zuZKcR14IU/2xjl/Y=; b=yUBPsglckJd9unYDuzN0pPs85
        ZTq5NhE6jfHmlhqkAWXohd8k3km8mtRdWWeTkuClitymdowXBovIHmJgaBLu5pRgQp1LtUii2wWfe
        JHA5PY6E4ZmoXCpwD+y0640hW3Xli0EcfDqnAWPN3u59lFWgYKc4vW7pbYb9AqD1DkH/X34YXJHV9
        AosRsHtkOd9O9N3Cg7uReLH8dujW9MhR43pitd7ipkz2/d1x8H73zVrnCIVVcxIKD6+RczuOj5WLj
        kBsKhpU85s1gCfWRxIEysLtk8rurc+MiTyQELHbdsR1KpqaHTiCg+ZZB74xTR5XXLa9e2cEBkNjcj
        nS4ObKoRA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyD6S-0000Iq-ID; Fri, 07 Sep 2018 09:31:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB57E201F9C46; Fri,  7 Sep 2018 11:30:55 +0200 (CEST)
Date:   Fri, 7 Sep 2018 11:30:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] printk/tracing: Do not trace printk_nmi_enter()
Message-ID: <20180907093055.GL24082@hirez.programming.kicks-ass.net>
References: <20180905213334.03375777@vmware.local.home>
 <20180906023151.GA749@jagdpanzerIV>
 <20180907074531.GM24106@hirez.programming.kicks-ass.net>
 <20180907082834.vjycyvt6nddpb4la@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907082834.vjycyvt6nddpb4la@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 10:28:34AM +0200, Petr Mladek wrote:
> On Fri 2018-09-07 09:45:31, Peter Zijlstra wrote:
> > On Thu, Sep 06, 2018 at 11:31:51AM +0900, Sergey Senozhatsky wrote:
> > > An alternative option, thus, could be re-instating back the rule that
> > > lockdep_off/on should be the first and the last thing we do in
> > > nmi_enter/nmi_exit. E.g.
> > > 
> > > nmi_enter()
> > > 	lockdep_off();
> > > 	printk_nmi_enter();
> > > 
> > > nmi_exit()
> > > 	printk_nmi_exit();
> > > 	lockdep_on();
> > 
> > Yes that. Also, those should probably be inline functions.
> > 
> > ---
> > Subject: locking/lockdep: Fix NMI handling
> > 
> > Someone put code in the NMI handler before lockdep_off(). Since lockdep
> > is not NMI safe, this wrecks stuff.
> 
> My view is that nmi_enter() has to switch several features into
> NMI-safe mode. The code must not trigger the other features when
> they are still in the unsafe mode.
> 
> It is a chicken&egg problem. And it is hard to completely prevent
> regressions caused by future changes.

Sure, not bothered too much about the regression, that happens.

> I though that printk_nmi_enter() should never need any lockdep-related
> code. On the other hand, people might want to printk debug messages
> when lockdep_off() is called. This is why I put it in the current order.

Nah, that'd be broken. Or rather, if you want to debug NMI stuff, you
had better know wth you're doing. Printk, as per mainline, is utterly
useless for that -- I still carry those force_early_printk patches
locally.

Because even if the core printk code were to be NMI safe (possible I
think, all we need is a lockless ring-buffer), then none of the console
drivers are :/

(I really hate this current printk-nmi mess)

> That said, I am not against this change. Especially the inlining
> is a good move. Note that lockdep_off()/lockdep_on() must not
> be traced as well.

Hard to trace an inline funcion; we could make it __always_inline to
feel better.

