Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6ED0C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC6E2232C
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfAEUAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 15:00:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:39366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfAEUAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 15:00:16 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBF8421915;
        Sat,  5 Jan 2019 20:00:13 +0000 (UTC)
Date:   Sat, 5 Jan 2019 15:00:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Torsten Duwe <duwe@lst.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v6] arm64: implement ftrace with regs
Message-ID: <20190105150011.6062d818@gandalf.local.home>
In-Reply-To: <20190105110543.GA4298@lst.de>
References: <20190104141053.360F768D93@newverein.lst.de>
        <20190104175017.GA7157@lakrids.cambridge.arm.com>
        <20190104130648.02657f3f@gandalf.local.home>
        <20190104224145.GA28236@lst.de>
        <20190105110543.GA4298@lst.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jan 2019 12:05:43 +0100
Torsten Duwe <duwe@lst.de> wrote:

> > My point is: those 2 insn will _never_ be split by any alignment
> > boundary > 8; does that mean anything, have you considered this?  
> 
> Forget that. Steve mentioned the keyword *interrupt*, which creates a
> completely different situation. In short, only the instruction pointer
> will be saved; and i-cache and pipeline will be freshly reloaded on return,
> so this threat is highly unlikely (interrupt taken exactly after 1st nop),
> but not impossible. "Puking horses..." as we say in German.

Correct.

> 
> > > > I wonder if we could solve that by patching the kernel at build-time, to
> > > > add the MOV X9, X30 in place of the first NOP. If we were to do that, we
> > > > could also update the addresses to pooint at the second NOP, simplifying
> > > > the changes to the runtime code.  
> > > 
> > > You can also patch it at boot up when there's only one CPU running, and
> > > interrupts are disabled.  
> > 
> > May I remind about possible performance hits? Even the NOPs had a tiny impact
> > on certain in-order implementations. I'd rather switch between the mov and
> > a "b +2".  
> 
> This one however still holds.

Now, if you can add one of the changes, do a synchronization to make
sure that all tasks are not preempted there, and see that first change,
then make the other change to complete the transaction, there may be a
solution: synchronize_rcu_tasks()!

	convert all first nops to "MOV X9, X30"
	synchronize_rcu_tasks();
	convert all second nops to "BL ftrace_regs_caller"

That would work. What synchronize_rcu_tasks() does, is that it wont
return until all tasks have either called schedule voluntarily (not
preempted), goes into user space, or goes idle.

Tasks that are idle (not preempted) are not counted.

Then you are guaranteed that no task was preempted at the first nop and
will come back and call "BL ftrace_regs_caller".

The only caveat is that synchronize_rcu_tasks() can take some time to
complete (seconds even) if something was preempted and is starved from
the CPU for some time. This is why you would need to group the
conversions together, by changing all the first nops for all the
functions you want to trace before calling the synchronization routine.

-- Steve
