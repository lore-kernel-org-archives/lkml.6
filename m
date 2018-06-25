Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A83C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDE826061
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="COPPGyEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDE826061
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755652AbeFYTPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:15:53 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33384 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755542AbeFYTPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:15:52 -0400
Received: by mail-pg0-f65.google.com with SMTP id e11-v6so6488407pgq.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 12:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=M+Ub4V/M0QnK05YQQGgAbYNYcyCqXYjaC+TkjBzX3Sw=;
        b=COPPGyEGJhe6oOTSTT97e3fPcMzFggmzMp5Ev8PuK5+7CVExvepNSm38uKAFvEq9UC
         H9/23u5RrgrN49HgFTosnoUO9SEmffc3gRndZZpzwvpE/Qf33Vh9HX1Ksit7RXFU8cf1
         EkH408dUgS5dZNmpLn9K0yEi/Qcz/EzcLGkSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=M+Ub4V/M0QnK05YQQGgAbYNYcyCqXYjaC+TkjBzX3Sw=;
        b=bVF4iFux8fx54tCpDRMWTYYPGrys2a95xb/hPJZNkUYhbDU1GedHI3REQR2c+KXy3K
         AwJDLcTgHrRphdJlj+u4wO8aew7GURKqD92v3I6oQCjOa9M72pE1TTTRYujA+qZ3l76k
         7oXYL2N9VdHgOTH5YdDk6hh/L04XKAKDOwrAFi8O+1Oajl8/5MqCvYgy+kCInQ16k7Yh
         tfvjJPQ5108omlrrj+rVlnw/thjIazj6yiPdrFJ19IhDe6LiU2E112JkLTJfj87ynWMt
         xBxkJltamFpWjlOztZClOCbBoEKyLfH5v5oVUBtBlle0TfdloO/526bI4Y9EMb/g5e9H
         j2Pg==
X-Gm-Message-State: APt69E0Z2xmzSVqhiAoJglb1MrRrkwzgFAgAOsw9caE6miqoGwULiSAj
        7FSqNZwrJL2i0V8oDha4Iy/4tw==
X-Google-Smtp-Source: ADUXVKJA5yoynZRLpTf6naijU1Wqs9TxvCCC+NmYuPliI5ZxnsfnT/K+w5CT9Nz+pkgqx+AYQ+SOYA==
X-Received: by 2002:a62:b90f:: with SMTP id z15-v6mr14392187pfe.254.1529954151844;
        Mon, 25 Jun 2018 12:15:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id l11-v6sm19024684pgp.56.2018.06.25.12.15.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 12:15:51 -0700 (PDT)
Date:   Mon, 25 Jun 2018 12:15:50 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com, luto@kernel.org
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Message-ID: <20180625191550.GA109433@joelaf.mtv.corp.google.com>
References: <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
 <20180620164902.GW3593@linux.vnet.ibm.com>
 <20180622055659.GA255098@joelaf.mtv.corp.google.com>
 <20180622132843.GN3593@linux.vnet.ibm.com>
 <20180622181916.GA13628@joelaf.mtv.corp.google.com>
 <20180622143247.781028b1@gandalf.local.home>
 <20180622200548.GA114655@joelaf.mtv.corp.google.com>
 <20180625082824.GB21377@X58A-UD3R>
 <20180625163951.GA52646@joelaf.mtv.corp.google.com>
 <20180625171920.GR3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180625171920.GR3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thanks a lot for your comments, my replies inline:

On Mon, Jun 25, 2018 at 10:19:20AM -0700, Paul E. McKenney wrote:
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> 	When I traced rdtp->dynticks_nesting, I could only find its
> 	value to be either a 0 or a 1. However looking back at old kernel
> 	sources, it appears that these can be nested becaues of so called
> 	“half-interrupts”. I believe these are basically interrupts
> 	that cause a transition to usermode due to usermode upcalls
> 	(usermode helper subsystem). So a nesting situation could be
> 	something like: 1. Transition from idle to process context which
> 	makes dynticks_nesting == 1. Next, an interrupt comes in which
> 	makes a usermode upcall. This usermode call now makes a system
> 	call causing entry back into process context, which increments
> 	the dynticks_nesting counter to 2. Such a crazy situation is
> 	perhaps possible.
> 
> The half-interrupts can instead cause ->dynticks_nmi_nesting to either
> fail to return to zero or to go negative, depending on which half of

Actually in the above paragraph I was referring to a "half interrupt" messing
up dynticks_nesting, not dynticks_nmi_nesting. I know that the latter can be
messed up too but I wasn't referring to dynticks_nmi_nesting in this part of
the article.

I was thinking more in terms of the comment in:
https://elixir.bootlin.com/linux/v3.19.8/source/kernel/rcu/rcu.h#L34
/*
 * Process-level increment to ->dynticks_nesting field.  This allows for
 * architectures that use half-interrupts and half-exceptions from
 * process context.
  ... */

 In my hypothetical example above that you quoted from my notes, I was trying
 to reason about how taking a half-interrupt in process context can cause
 dynticks_nesting to increase to 2. Thinking some more though, I am not sure
 how the above hypothetical example I mentioned can cause this ;) since the
 transition to usermode from the half-interrupt should have corrected the
 dynticks_nesting counter due to the callchain: rcu_user_enter->rcu_eqs_enter ?

> the interrupt was present.  I don't immediately recall the reason for
> allowing nested process-level entry/exit.  Might be another place to
> put a WARN_ON_ONCE(), as eliminating this capability would save another
> conditional branch.

Sure, sounds good to me.

> 
> 	Any time the rdtp->dynticks counter’s second-lowest most bit
> 	is not set, we are in an EQS, and if its set, then we are not
> 	(second lowest because lowest is reserved for something else as
> 	of v4.18-rc1). This function is not useful to check if we’re
> 	in an EQS from a timer tick though, because its possible the
> 	timer tick interrupt entry caused an EQS exit which updated
> 	the counter. IOW, the ‘dynticks’ counter is not capable of
> 	checking if we had already exited the EQS before. To check if
> 	we were in an EQS or not from the timer tick, we instead must
> 	use dynticks_nesting counter. More on that later. The above
> 	function is probably just useful to make sure that interrupt
> 	entry/exit is properly updating the dynticks counter, and also
> 	to make sure from non-interrupt context that RCU is in an EQS
> 	(see rcu_gp_fqs function).
> 
> You lost me on this one.  There is rcu_is_cpu_rrupt_from_idle(), but
> I am not sure what you are trying to achieve here, so I am not sure
> whether this function does what you want.

Sorry about that. Let me try to explain in detail about why I wrote the above
paragraph when talking about rdtp->dynticks.

I was trying to determine how the RCU code determines if the CPU is idle. It
appears from the code that there are 2 ways it does so:

1. By calling rcu_is_cpu_rrupt_from_idle() which checks for the
dynticks_nesting counter. If the counter is 0, then CPU was idle at the time
of the check. This is how rcu_check_callbacks knows that the CPU was idle.

2. By checking for evenness of the dynticks counter. If its even we were idle
(or perhaps in usermode, but I think that extra inference doesn't hurt). This
is done in rcu_dynticks_curr_cpu_in_eqs.

So basically, there are 2 different counters that seem to serve the same
purpose as far as determining if we're in an idle EQS state goes. Right?

Then I was trying to see why we can't just use method 2. in
rcu_check_callbacks to determine if the "timer interrupt was taken while the
CPU was idle".  rcu_check_callbacks could simply call
rcu_dynticks_curr_cpu_in_eqs() from rcu_check_callbacks(). I was trying to
convince myself why that wouldn't work.

I concluded that that wouldn't work because the timer interrupt that led to
the rcu_check_callbacks() call would have tainted the dynticks counter
because of it would have called rcu_nmi_enter() during interrupt entry. So
there's no way to know if the CPU was really idle at the time of the
interrupt if we were to rely on rcu_dynticks_curr_cpu_in_eqs for that. Hence
we would need to rely on method 1 for the "did I take an interrupt while I
was idle" in rcu_check_callbacks() function which uses the dynticks_nesting
counter for this determination. Does that make sense?

> 
> 	When dynticks_nesting is decremented to 0 (the outermost
> 	process-context nesting level exit causes an eqs-entry), the
> 	dynticks_nmi_nesting is reset to
> 
> I think you want "0." at the end of this sentence.  Or maybe my browser
> is messing things up.

Yes the 0. was on the next line, but I moved it back to the previous line so
its easier to read. Thanks for letting me know.

Thanks!

 - Joel

