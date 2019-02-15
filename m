Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD0EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B76921924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393886AbfBOK0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:26:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:51094 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388855AbfBOK0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:26:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4EEE4AE8F;
        Fri, 15 Feb 2019 10:26:36 +0000 (UTC)
Date:   Fri, 15 Feb 2019 11:26:35 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 02/25] printk-rb: add prb locking functions
Message-ID: <20190215102635.kdo4yxifh5dt2yj7@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-3-john.ogness@linutronix.de>
 <20190213154541.wvft64nf352vghou@pathway.suse.cz>
 <87pnrvs707.fsf@linutronix.de>
 <20190214103324.viexpifsyons5qya@pathway.suse.cz>
 <87y36ih8p7.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y36ih8p7.fsf@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-02-14 13:10:28, John Ogness wrote:
> On 2019-02-14, Petr Mladek <pmladek@suse.com> wrote:
> >>> cpu_store looks like an implementation detail. The caller
> >>> needs to remember it to handle the nesting properly.
> >>> 
> >>> We could achieve the same with a recursion counter hidden
> >>> in struct prb_lock.
> >
> > The atomic operations are tricky. I feel other lost in them.
> > Well, I still think that it might easier to detect nesting
> > on the same CPU, see below.
> >
> > Also there is no need to store irq flags in per-CPU variable.
> > Only the first owner of the lock need to store the flags. The others
> > are spinning or nested.
> >
> > struct prb_cpulock {
> > 	atomic_t		owner;
> > 	unsigned int		flags;
> > 	int			nesting; /* intialized to 0 */
> > };
> >
> > void prb_lock(struct prb_cpulock *cpu_lock)
> > {
> > 	unsigned int flags;
> > 	int cpu;
> 
> I added an explicit preempt_disable here:
> 
>         cpu = get_cpu();

It is superfluous. Preemption is not possible when interrupts
are disabled.


> It looks great. I've run my stress tests on it and everything is running
> well.

I am glad to read this.
 
> Thanks for simplifying this!

You are welcome.

Best Regards,
Petr
