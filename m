Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E762CC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14D721470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14D721470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeJDP2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:28:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:46746 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726808AbeJDP2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:28:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DEB8FAD82;
        Thu,  4 Oct 2018 08:36:10 +0000 (UTC)
Date:   Thu, 4 Oct 2018 10:36:09 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Daniel Wang <wonderfly@google.com>, rostedt@goodmis.org,
        stable@vger.kernel.org, Alexander.Levin@microsoft.com,
        akpm@linux-foundation.org, byungchul.park@lge.com,
        dave.hansen@intel.com, hannes@cmpxchg.org, jack@suse.cz,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mel Gorman <mgorman@suse.de>, mhocko@kernel.org, pavel@ucw.cz,
        penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org,
        tj@kernel.org, torvalds@linux-foundation.org, vbabka@suse.cz,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: 4.14 backport request for dbdda842fe96f: "printk: Add console
 owner and waiter logic to load balance console writes"
Message-ID: <20181004083609.kcziz2ynwi2w7lcm@pathway.suse.cz>
References: <20181001152324.72a20bea@gandalf.local.home>
 <CAJmjG29Jwn_1E5zexcm8eXTG=cTWyEr1gjSfSAS2fueB_V0tfg@mail.gmail.com>
 <20181002084225.6z2b74qem3mywukx@pathway.suse.cz>
 <CAJmjG2-RrG5XKeW1-+rN3C=F6bZ-L3=YKhCiQ_muENDTzm_Ofg@mail.gmail.com>
 <20181002212327.7aab0b79@vmware.local.home>
 <20181003091400.rgdjpjeaoinnrysx@pathway.suse.cz>
 <CAJmjG2_4JFA=qL-d2Pb9umUEcPt9h13w-g40JQMbdKsZTRSZww@mail.gmail.com>
 <20181003133704.43a58cf5@gandalf.local.home>
 <CAJmjG291w2ZPRiAevSzxGNcuR6vTuqyk6z4SG3xRsbaQh5U3zQ@mail.gmail.com>
 <20181004074442.GA12879@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004074442.GA12879@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-10-04 16:44:42, Sergey Senozhatsky wrote:
> On (10/03/18 11:37), Daniel Wang wrote:
> > When `softlockup_panic` is set (which is what my original repro had and
> > what we use in production), without the backport patch, the expected panic
> > would hit a seemingly deadlock. So even when the machine is configured
> > to reboot immediately after the panic (kernel.panic=-1), it just hangs there
> > with an incomplete backtrace. With your patch, the deadlock doesn't happen
> > and the machine reboots successfully.
> > 
> > This was and still is the issue this thread is trying to fix. The last
> > log snippet
> > was from an "experiment" that I did in order to understand what's really
> > happening. So far the speculation has been that the panic path was trying
> > to get a lock held by a backtrace dumping thread, but there is not enough
> > evidence which thread is holding the lock and how it uses it. So I set
> > `softlockup_panic` to 0, to get panic out of the equation. Then I saw that one
> > CPU was indeed holding the console lock, trying to write something out. If
> > the panic was to hit while it's doing that, we might get a deadlock.
> 
> Hmm, console_sem state is ignored when we flush logbuf, so it's OK to
> have it locked when we declare panic():
> 
> void console_flush_on_panic(void)
> {
> 	/*
> 	 * If someone else is holding the console lock, trylock will fail
> 	 * and may_schedule may be set.  Ignore and proceed to unlock so
> 	 * that messages are flushed out.  As this can be called from any
> 	 * context and we don't want to get preempted while flushing,
> 	 * ensure may_schedule is cleared.
> 	 */
> 	console_trylock();
> 	console_may_schedule = 0;
> 	console_unlock();
> }
> 
> Things are not so simple with uart_port lock. Generally speaking we
> should deadlock when we NMI panic() kills the system while one of the
> CPUs holds uart_port lock.

This looks like a reasonable explanation of what is happening here.
It also explains why the console owner logic helped.


> 8250 has sort of a workaround for this scenario:
> 
> serial8250_console_write()
> {
> 	if (port->sysrq)
> 		locked = 0;
> 	else if (oops_in_progress)
> 		locked = spin_trylock_irqsave(&port->lock, flags);
> 	else
> 		spin_lock_irqsave(&port->lock, flags);
> 
> 	...
> 	uart_console_write(port, s, count, serial8250_console_putchar);
> 	...
> 
> 	if (locked)
> 		spin_unlock_irqrestore(&port->lock, flags);
> }
> 
> Now... the problem. A theory, in fact.
> panic() sets oops_in_progress back to zero - bust_spinlocks(0) -  too soon.

I see your point. I am just a bit scared of this way. Ignoring locks
is a dangerous and painful approach in general.

Best Regards,
Petr
