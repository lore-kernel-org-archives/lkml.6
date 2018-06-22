Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7890C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6200E24720
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vCiNYMgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6200E24720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934054AbeFVSTU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:19:20 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44203 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933691AbeFVSTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:19:19 -0400
Received: by mail-pl0-f67.google.com with SMTP id z9-v6so3855418plk.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 11:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N6w/C3eeYoLAa2v/BhFfHURLHlMISlkJH+8ytQR2BXY=;
        b=vCiNYMgSLjLA2jkDHIS1pPVxdcIDpsKpV5eg3DnaFBTqbWG8sXxm9EJjl3EsVYkRkt
         DSTpGyjnZ3M9gYb2IHj48d8ocd6rKj1ENHCZK2fcJ3/2fjq8oLhABCA8wTEeFY4bf1cd
         IrKDoCv8lz9zLmZ6N7XgtPpJiWvDnfpYJGTDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N6w/C3eeYoLAa2v/BhFfHURLHlMISlkJH+8ytQR2BXY=;
        b=ga2oNbeoTbf61syVhXkmnw/f5HPapLUkYl3oKSEeNrdrJ0Upn5NnQnx/vjTn362OsF
         6RJAVl4NJfJRUjVFqLgxsKKdaY8qm8TelHORZomdykrFtSR8o/CX0v/zAl01NQuw6XpT
         Gc5d9Xn0eINkhzsTxyl127/A8tfS1qd2BaUlqkcsALt77iYbPian2gnLlK7dkHZcxUnF
         xulhUyuSu8o2+5qYKMEoHYjUT79pb8UAmTAwUpe8H8w/70/a4UBZYu6z3m8DF3wqSKM+
         l404/0TroEfFko3tlBHOPAft6jmy9UXifKNz1dChe+qQn+gm/UAov4zqdITHn3OD4/ce
         sz7Q==
X-Gm-Message-State: APt69E2G3YydEEkaBoR2JXyijZ7S/ykmG6fS2oUToY9BzmIrxPFsNezL
        z/F5Kx0iaIeiefqxRIWFLh9peQ==
X-Google-Smtp-Source: ADUXVKJWV7Miwk/7tvPQN1Viz41S7EWQjVsu9TCBuemMaQ4VWsfvAZl1sojHSMFUGgePgXHn5bpkrQ==
X-Received: by 2002:a17:902:7d89:: with SMTP id a9-v6mr2754107plm.238.1529691558494;
        Fri, 22 Jun 2018 11:19:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id y14-v6sm9781941pgv.37.2018.06.22.11.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 11:19:17 -0700 (PDT)
Date:   Fri, 22 Jun 2018 11:19:16 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Byungchul Park <max.byungchul.park@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com, luto@kernel.org
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Message-ID: <20180622181916.GA13628@joelaf.mtv.corp.google.com>
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
 <1529484440-20634-2-git-send-email-byungchul.park@lge.com>
 <20180620145814.GQ3593@linux.vnet.ibm.com>
 <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
 <20180620164902.GW3593@linux.vnet.ibm.com>
 <20180622055659.GA255098@joelaf.mtv.corp.google.com>
 <20180622132843.GN3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622132843.GN3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 06:28:43AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 21, 2018 at 10:56:59PM -0700, Joel Fernandes wrote:
> > Hi Paul,
> > 
> > On Wed, Jun 20, 2018 at 09:49:02AM -0700, Paul E. McKenney wrote:
> > > On Thu, Jun 21, 2018 at 01:05:22AM +0900, Byungchul Park wrote:
> > > > On Wed, Jun 20, 2018 at 11:58 PM, Paul E. McKenney
> > > > <paulmck@linux.vnet.ibm.com> wrote:
> > > > > On Wed, Jun 20, 2018 at 05:47:20PM +0900, Byungchul Park wrote:
> > > > >> Hello folks,
> > > > >>
> > > > >> I'm careful in saying that ->dynticks_nmi_nesting can be removed but I
> > > > >> think it's possible since the only thing we are interested in with
> > > > >> regard to ->dynticks_nesting or ->dynticks_nmi_nesting is whether rcu is
> > > > >> idle or not.
> > > > >
> > > > > Please keep in mind that NMIs cannot be masked, which means that the
> > > > > rcu_nmi_enter() and rcu_nmi_exit() pair can be invoked at any point in
> > > > > the process, between any consecutive pair of instructions.  The saving
> > > 
> > > And yes, I should have looked at this patch more closely before replying.
> > > But please see below.
> > > 
> > > > I believe I understand what NMI is and why you introduced
> > > > ->dynticks_nmi_nesting. Or am I missing something?
> > > 
> > > Perhaps the fact that there are architectures that can enter interrupt
> > > handlers and never leave them when the CPU is non-idle.  One example of
> > > this is the usermode upcalls in the comment that you removed.
> > 
> > I spent some time tonight and last night trying to understand this concept of
> > never leaving an interrupt, I hope you don't mind me asking this dumb
> > question... perhaps I will learn something : Could you let me know how is it
> > possible that an interrupt never exits?
> > 
> > Typically an interrupt never exiting sounds like a hard-lockup. This is how
> > hardlock detector works: Since regular interrupts in linux can't nest, the
> > hardlockup detector checks if hrtimer interrupts are being handled and if
> > not, then it throws a splat, panics the kernel etc. So I am a bit troubled by
> > this interrupt never exiting concept..
> > 
> > Further since an interrupt is an atomic context, it cannot sleep or schedule
> > into usermode so how are these upcalls handled from the interrupt?
> 
> It has been some years since I traced the code flow, but what happened

No problem, thanks for the discussion. :)

> back then is that it switches itself from an interrupt handler to not
> without actually returning from the interrupt.  This can only happen when
> interrupting a non-idle process, thankfully, and RCU's dyntick-idle code
> relies on this restriction.  If I remember correctly, the code ends up
> executing in the context of the interrupted process, but it has been some
> years, so please apply appropriate skepticism.

Sure. So in a later thread you mentioned "usermode helpers". I took a closer
look at that subsystem, and it seems you can execute usermode helpers from
atomic sections with help of UMH_NO_WAIT flag.

Then I checked where this flag is used and it turns out its from the
mce_work_trigger function in x86/kernel/cpu/mcheck/dev-mcelog.c which can be
called infact from an interrupt context (mce_notify_irq).

Is this the usecase you remember causing this weird transitions to userspace?

> Please take a look at the "Interrupts and NMIs" section of the file
> Documentation/RCU/Design/Requirements/Requirements.html for a bit
> more information.

Sure, thanks for the pointer.

> > Lastly, can you point me to an example how the rcu_nmi_enter/exit() pair can go
> > out sync? That is they aren't paired and nested properly? In my mind they
> > always should be but I may be missing the usecase. I'm happy to try and
> > reproduce and trace this if you can let me know how to so that I can study
> > it better. 
> 
> I have never seen NMIs be unpaired or improperly nested.  However,
> given that rcu_irq_enter() invokes rcu_nmi_enter() and rcu_irq_exit()
> invokes rcu_nmi_exit(), it is definitely the case that rcu_nmi_enter()
> and rcu_nmi_exit() need to deal with unpaired and improperly nested
> invocations.

Just wondering how would the fact that rcu_irq_enter calls into rcu_nmi_enter
cause an improper nesting?

Just to define what "improper nesting" means, if we can go through an
example. Do you mean a scenario like?

rcu_nmi_enter (called because of NMI)
rcu_nmi_enter (called because of IRQ)
rcu_nmi_exit (called because of NMI)
rcu_nmi_exit (called because of IRQ)

Such scenario seems impossible to me because the IRQ can't be entered after
the NMI entered.

On the other hand, if you meant that when IRQ is being handled, an NMI fires
just before the rcu_irq_enter calls rcu_nmi_enter, then the worst that could
happen seems to be that the rcu_nmi_enter/exit pairs will not be nested
within the outer rcu_nmi_enter/exit pair even though the NMI interrupted the
IRQ. So it'll be something like:

rcu_nmi_enter (called because of NMI)
rcu_nmi_exit (called because of NMI)
rcu_nmi_enter (called because of IRQ)
rcu_nmi_exit (called because of IRQ)

Even though what really happened in the real world is:

IRQ entered
NMI entered
NMI exited
IRQ exited

This also seems reasonable to me, but is this what you meant by improper
nesting of the rcu_nmi_enter/exit? If yes, what makes it unreasonable?

> So why this function-call structure?  Well, you see, NMI handlers can
> take what appear to RCU to be normal interrupts...
> 
> (And I just added that fun fact to Requirements.html.)

Yes, I'll definitely go through all the interrupt requirements in the doc and
thanks for referring me to it.

thanks,

 - Joel

