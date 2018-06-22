Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283D8C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D157024386
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbbC6z9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D157024386
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933189AbeFVOT2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752027AbeFVOT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:19:27 -0400
Received: from mail-wr0-f171.google.com (mail-wr0-f171.google.com [209.85.128.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB2132438B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 14:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529677167;
        bh=XGU5MKu0RuEQpnWkuo0edRwUFsjyq9kfc6UNh/QSO7Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kbbC6z9m1VR7y+Fvv60xhnTusCI83Ua3YowTCf0zRSue0Lu9V7W9GgBAwNJX/SLhG
         Kzp0c98QQPUZvlhF2RJ1gWfZNBzhsFu3lbaqXJ/eWmXNmyxj5hvhW6ow9/FbT+KsIs
         /BWUJROjK6YoXAp1TVegY3VeJiyMhReUbV97L7KQ=
Received: by mail-wr0-f171.google.com with SMTP id l14-v6so1818860wrq.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 07:19:26 -0700 (PDT)
X-Gm-Message-State: APt69E2wPPAQCK9Nc2z8exibTNeCrij9Gnr3qvWTnQOgRzwN2/TvLdVt
        mJbL3fGjyQpHSOtDWpjVuuZnfRgMEwGQsL0A3Pr9Ew==
X-Google-Smtp-Source: ADUXVKJuhQ6RbK2OBUwOjB0CaE3qWn6AigrCg26GwJ/v3nypnCAThnV0umqntW4CjYvcy53G1Fa84wKH024w2fP98NM=
X-Received: by 2002:adf:85ec:: with SMTP id 41-v6mr1798202wru.120.1529677165422;
 Fri, 22 Jun 2018 07:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
 <1529484440-20634-2-git-send-email-byungchul.park@lge.com>
 <20180620145814.GQ3593@linux.vnet.ibm.com> <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
 <20180620164902.GW3593@linux.vnet.ibm.com> <20180622055659.GA255098@joelaf.mtv.corp.google.com>
 <20180622132843.GN3593@linux.vnet.ibm.com>
In-Reply-To: <20180622132843.GN3593@linux.vnet.ibm.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 22 Jun 2018 07:19:13 -0700
X-Gmail-Original-Message-ID: <CALCETrXgubD2BBx9Xe2PALbStgPYc=_GTNkoH03469rpN5JwZw@mail.gmail.com>
Message-ID: <CALCETrXgubD2BBx9Xe2PALbStgPYc=_GTNkoH03469rpN5JwZw@mail.gmail.com>
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct rcu_dynticks
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     joel@joelfernandes.org, max.byungchul.park@gmail.com,
        Byungchul Park <byungchul.park@lge.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 6:26 AM Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>
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
> back then is that it switches itself from an interrupt handler to not
> without actually returning from the interrupt.  This can only happen when
> interrupting a non-idle process, thankfully, and RCU's dyntick-idle code
> relies on this restriction.  If I remember correctly, the code ends up
> executing in the context of the interrupted process, but it has been some
> years, so please apply appropriate skepticism.

...

>
> I have never seen NMIs be unpaired or improperly nested.  However,
> given that rcu_irq_enter() invokes rcu_nmi_enter() and rcu_irq_exit()
> invokes rcu_nmi_exit(), it is definitely the case that rcu_nmi_enter()
> and rcu_nmi_exit() need to deal with unpaired and improperly nested
> invocations.

This is very strange.  There are certainly cases in x86 where an
interrupt-ish code path can become less interrupt-ish without
returning (killing a task that overflows a kernel stack is an
example), but the RCU calls should still nest correctly.  Do you know
the history of this requirement?
