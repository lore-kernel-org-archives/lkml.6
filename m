Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F1AECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52E020824
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52E020824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeJYRBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 13:01:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:38388 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726538AbeJYRBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 13:01:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6D66DAFF5;
        Thu, 25 Oct 2018 08:29:49 +0000 (UTC)
Date:   Thu, 25 Oct 2018 10:29:47 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCHv2 1/4] panic: avoid deadlocks in re-entrant console
 drivers
Message-ID: <20181025082947.gznv5roj3zxzlw3t@pathway.suse.cz>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
 <20181023110751.un2u67bc7dpo4ska@pathway.suse.cz>
 <20181023115433.GA10251@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023115433.GA10251@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-10-23 20:54:33, Sergey Senozhatsky wrote:
> On (10/23/18 13:07), Petr Mladek wrote:
> > Though this looks a bit weird.
> > 
> > I have just realized that console_unblank() is called by
> > bust_spinlocks(0) and does basically the same as
> > console_flush_on_panic(). Also it does not make much
> > sense wake_up_klogd() there. Finally, it seems to be
> > too late to disable lockdep there.
> 
> So I did look at what lib/bust_spinlocks.c does; and I agree that waking
> up klogd makes little sense, on the other hand it just sets per-cpu
> pending bit, so not a big deal. console_unlock() should do there the
> same thing as console_flush_on_panic().

Yes, klogd is not a big deal. I just think that the bust_spinlocks()
ping-pong would just confuse the code. It might be better to keep
the spinlocks busted and make sure that we do not cause regressions
by not calling bust_spinlocks(0).

It tried to solve this by calling the important actions from
bust_spinlocks(0) directly in panic(). I wanted to omit anything
that does not make sense in panic().


> >  void __attribute__((weak)) bust_spinlocks(int yes)
> >  {
> >  	if (yes) {
> > +		/*
> > +		 * Some locks might get ignored in the Oops situation
> > +		 * to get an important work done. Locks debug should
> > +		 * be disabled to avoid reporting bad unlock balance.
> > +		 */
> > +		debug_locks_off();
> >  		++oops_in_progress;
> 
> Hmm, I don't think I've seen any reports because of this. From printk/console
> POV the locks which are not taken under oops_in_progress are not released.

Fair enough. Let's keep debug_locks_off() in panic().

Best Regards,
Petr
