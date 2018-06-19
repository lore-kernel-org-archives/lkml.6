Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6C3C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2A82083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2A82083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756426AbeFSIER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:04:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:34174 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756384AbeFSIEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:04:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0DD49AF81;
        Tue, 19 Jun 2018 08:04:13 +0000 (UTC)
Date:   Tue, 19 Jun 2018 10:04:12 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: possible deadlock in console_unlock
Message-ID: <20180619080412.zkdanx6bmq5qm3dz@pathway.suse.cz>
References: <00000000000087008b056df8fbb3@google.com>
 <20180607051019.GA10406@jagdpanzerIV>
 <20180607110034.qrkencwsr4stv6xp@pathway.suse.cz>
 <20180607140100.GA398@tigerII.localdomain>
 <20180608081855.ctqakvwmg27aydby@pathway.suse.cz>
 <20180615083804.GB8964@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615083804.GB8964@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-06-15 17:38:04, Sergey Senozhatsky wrote:
> On (06/08/18 10:18), Petr Mladek wrote:
> [..]
> > > Could be.
> > > The good thing about printk_safe is that printk_safe sections can nest.
> > > I suspect there might be locks/printk_safe sections nesting at some
> > > point. In any case, switching to a new flavor of printk_safe will be
> > > pretty easy - just replace printk_safe_enter() with printk_foo_enter()
> > > and the same for printk_save_exit().
> > 
> > We could allow nesting. It is just a matter of how many bits we
> > reserve for it in printk_context variable.
> [..]
> > In each case, I would like to keep the printk_safe context usage
> > at minimum. It has its own problems caused by limited per-cpu buffers
> > and the need to flush them.
> 
> May be. Every new printk_safe flavour comes with increasing memory
> usage.

This must be a misunderstanding. My intention was to introduce
printk_deferred() context. Where any printk() called in this
context would behave like printk_deferred(). It does not need
any extra buffers.

IMHO, this problem is similar to the problems that we solve
in scheduler and timer code. The cure might be the same.
I just suggest to introduce a context to make our life easier.


> > It is basically needed only to prevent deadlocks related to logbuf_lock.
> 
> I wouldn't say that we need printk_safe for logbuf_lock only.
> printk_safe helps us to avoid deadlocks on:
> 
> - logbuf_lock spin_lock

logbuf_lock is already guarded by printk_safe context everywhere.


> - console_sem ->lock spin_lock
> - console_owner spin_lock
> - scheduler ->pi_lock spin_lock
> - and probably something else.

printk_deferred should be enough for others. Or do I miss anything?

Best Regards,
Petr
