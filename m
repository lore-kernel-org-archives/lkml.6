Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ED8C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 15:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350D724C55
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 15:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="J47pcLjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350D724C55
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751794AbeFWPsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 11:48:43 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35346 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbeFWPsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 11:48:41 -0400
Received: by mail-pg0-f66.google.com with SMTP id i7-v6so4240181pgp.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 08:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YuPLt/7/oh+wOiwqa+nGoDs/Jhwjt7xxdRIM7rzj8zI=;
        b=J47pcLjPPuu1tL16hC9UblggMXssIMTeetbq9KE8o7WkiF5zujnFQpZC7HkBsXK6Gm
         7oKlRCF0qn57Do9Nqf/3wv8TcSEBfAy2+hUecRz5BYcv8LtyK4/0Re7xCIYNlEjKU2GB
         WndWO3rVx+1t5QJLIopWHz93fpjFsF/442Xj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YuPLt/7/oh+wOiwqa+nGoDs/Jhwjt7xxdRIM7rzj8zI=;
        b=f5/ZcOsyTBOSB8IO7ajHS2S+2pe/IHAB9CnP9eCN2YMpFRz6D+R+PL/Ullc+d37EOz
         QM2ajz0gmGEdSssVyaf6Tn2PsHpI+T28Q/zk+3fL0ayOSw1Md10HjK+s9dmfgjkIxkI7
         mnTzBVLxs85z8GkfziGCQUJz0OKP9twnRIYzhH2GP9dtk8phvmVSc6tAJIpu5jx/s/vx
         9RUWj8mtWRQfUGMvH6xH0rjOv9D+XV91QJtC8No3zKkDQI50HZnxP1JpVe7yer0QPwFf
         ZHaIw/ZXfWVM+ht3AaXG08e3Jn2lv3LXPq6raXZ6BdFjLBdNpRNaJBrl+bFwqowYDnAd
         nw/Q==
X-Gm-Message-State: APt69E0DChBm5kgwLMYylgl7qjrsrIL1mkMazdASb0wjGPgT4KPiRpx5
        qwHeBgbKv5A+xxZhctMH2A/H7094elY=
X-Google-Smtp-Source: ADUXVKL2gham7aWSkQqsA67S7RmW9QnP1AAPfhcqxLr94ljqr+UAbcqrDSlWVgStnuPsbQy/Ha+MlQ==
X-Received: by 2002:a65:5cc8:: with SMTP id b8-v6mr5198869pgt.85.1529768920899;
        Sat, 23 Jun 2018 08:48:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id e5-v6sm6252531pgf.0.2018.06.23.08.48.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Jun 2018 08:48:40 -0700 (PDT)
Date:   Sat, 23 Jun 2018 08:48:39 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com, luto@kernel.org
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Message-ID: <20180623154839.GA12939@joelaf.mtv.corp.google.com>
References: <1529484440-20634-2-git-send-email-byungchul.park@lge.com>
 <20180620145814.GQ3593@linux.vnet.ibm.com>
 <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
 <20180620164902.GW3593@linux.vnet.ibm.com>
 <20180622055659.GA255098@joelaf.mtv.corp.google.com>
 <20180622132843.GN3593@linux.vnet.ibm.com>
 <20180622181916.GA13628@joelaf.mtv.corp.google.com>
 <20180622205813.GV3593@linux.vnet.ibm.com>
 <20180622170042.4adfbe21@gandalf.local.home>
 <20180622211600.GX3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622211600.GX3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 02:16:00PM -0700, Paul E. McKenney wrote:
> On Fri, Jun 22, 2018 at 05:00:42PM -0400, Steven Rostedt wrote:
> > On Fri, 22 Jun 2018 13:58:13 -0700
> > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > 
> > > Something like this:
> > > 
> > > 	IRQ entered
> > > 
> > > And never exited.  Ever.  I actually saw this in 2011.
> > 
> > I still believe this was actually a bug. And perhaps you made the RCU
> > code robust enough to handle this bug ;-)
> 
> Welcome to my world!
> 
> But I recall it being used in several places, so if it was a bug, it
> was an intentional bug.  Probably the worst kind.
> 
> Sort of like nested NMIs and interrupts within NMI handlers.  ;-)
> 
> > > Or something like this:
> > > 
> > > 	IRQ exited
> > > 
> > > Without a corresponding IRQ enter.
> > > 
> > > The current code handles both of these situations, at least assuming
> > > that the interrupt entry/exit happens during a non-idle period.
> > > 
> > > > > So why this function-call structure?  Well, you see, NMI handlers can
> > > > > take what appear to RCU to be normal interrupts...
> > > > > 
> > > > > (And I just added that fun fact to Requirements.html.)  
> > > > 
> > > > Yes, I'll definitely go through all the interrupt requirements in the doc and
> > > > thanks for referring me to it.  
> > > 
> > > My concern may well be obsolete.  It would be good if it was!  ;-)
> > 
> > I'd love to mandate that irq_enter() must be paired with irq_exit(). I
> > don't really see any rationale for it to be otherwise. If there is a
> > case, perhaps it needs to be fixed.
> 
> Given that the usermode helpers now look to be common code using
> workqueues, kthreads, and calls to do_execve(), it might well be that
> the days of half-interrupts are behind us.
> 
> But how to actually validate this?  My offer of adding a WARN_ON_ONCE()
> and waiting a few years still stands, but perhaps you have a better
> approach.

Hi Paul, I am Ok with adding a warning for a couple of releases if you and
others are Ok with it, how about something like this? Feel free to use the
diff as a starting point or a different approach if you/others prefer
something else. Thanks.

---8<-----------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8788ddbc0d13..176de74f5027 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -767,6 +767,21 @@ void rcu_idle_enter(void)
  */
 void rcu_user_enter(void)
 {
+	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
+
+	/*
+	 * Add warning to ensure: no known instances of entering userspace from
+	 * IRQ/NMI handlers exist today. Currently special crowbarring of the
+	 * dynticks_nmi_nesting and maintaining of this separate counter when
+	 * dynticks_nesting exists, is done in order to handle entering of
+	 * userspace from an IRQ context and never returning. Lets track it for
+	 * a couple of kernel releases and then if the warning doesn't occur,
+	 * we can try to simplify the code and combine/eliminate the counters.
+	 * See: http://lkml.kernel.org/r/20180622181422.GT3593@linux.vnet.ibm.com
+	 */
+	WARN_ON_ONCE(rdtp->dynticks_nmi_nesting &&
+		     rdtp->dynticks_nmi_nesting != DYNTICK_IRQ_NONIDLE);
+
 	lockdep_assert_irqs_disabled();
 	rcu_eqs_enter(true);
 }
