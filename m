Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD15AC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C672082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C672082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbeLKIcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:32:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:57860 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbeLKIcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:32:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1929CAF09;
        Tue, 11 Dec 2018 08:32:31 +0000 (UTC)
Date:   Tue, 11 Dec 2018 09:32:30 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>, stable@kernel.org
Subject: Re: [PATCH v4] panic: Avoid the extra noise dmesg
Message-ID: <20181211083230.x6s44wsgfgijl4ws@pathway.suse.cz>
References: <1544176279-77828-1-git-send-email-feng.tang@intel.com>
 <20181210131729.04b8e0d3@gandalf.local.home>
 <CAGXu5jJrC5J7YNJ24JNNkNTRr7qRfQa+x+dePC0OOrpcEJFwaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJrC5J7YNJ24JNNkNTRr7qRfQa+x+dePC0OOrpcEJFwaA@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-12-10 10:49:22, Kees Cook wrote:
> On Mon, Dec 10, 2018 at 10:17 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Fri,  7 Dec 2018 17:51:19 +0800
> > Feng Tang <feng.tang@intel.com> wrote:
> >
> > > When kernel panic happens, it will first print the panic call stack,
> > > then the ending msg like:
> > >
> > > [   35.743249] ---[ end Kernel panic - not syncing: Fatal exception
> > > [   35.749975] ------------[ cut here ]------------
> > >
> > > The above message are very useful for debugging.
> > >
> > > But if system is configured to not reboot on panic, say the "panic_timeout"
> > > parameter equals 0, it will likely print out many noisy message like
> > > WARN() call stack for each and every CPU except the panic one, messages
> > > like below:
> >
> >
> > > Keeping the interrupt disabled will avoid the noisy message.
> > >
> > > When code runs to this point, it means user has chosed to not reboot, or
> > > do any special handling by using the panic notifier method, the only reason
> > > to enable the interrupt may be sysrq migic key and panic_blink function
> > > (though may not work even with irq enabled).
> > >
> > > So make the irq disabled by default and add a cmdline parameter
> > > "panic_keep_irq_on" to turn it on when needed.
> > >
> > > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > >
> >
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> I'm fine with the new boot param, but I think we need to leave it how
> it was by default: systems that want to see the blinking aren't going
> to have a screen to read about what boot param they need to add.
> Currently, we'll blink and spew extra warnings. With this patch we'll
> not blink and not spew: a headless machine will have no indication
> that a panic happened.

Just to be sure, in case, you did not follow the other long
discussion.

I had an alternative approach to switch printk() into nop at
this panic() stage. It can be restored when sysrq is triggered.
This approach allows to keep blinking and sysrq working. People
debugging the blinking would need to block this change but it
should be rare.

I do not resist on my solution. It looks a bit hacky. But it
is simple and rather straightforward.

Best Regards,
Petr
