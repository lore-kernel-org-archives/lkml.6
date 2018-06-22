Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A8BC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14197248DB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14197248DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933651AbeFVVAq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 17:00:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754184AbeFVVAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 17:00:46 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C380248DA;
        Fri, 22 Jun 2018 21:00:44 +0000 (UTC)
Date:   Fri, 22 Jun 2018 17:00:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com, luto@kernel.org
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Message-ID: <20180622170042.4adfbe21@gandalf.local.home>
In-Reply-To: <20180622205813.GV3593@linux.vnet.ibm.com>
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
        <1529484440-20634-2-git-send-email-byungchul.park@lge.com>
        <20180620145814.GQ3593@linux.vnet.ibm.com>
        <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
        <20180620164902.GW3593@linux.vnet.ibm.com>
        <20180622055659.GA255098@joelaf.mtv.corp.google.com>
        <20180622132843.GN3593@linux.vnet.ibm.com>
        <20180622181916.GA13628@joelaf.mtv.corp.google.com>
        <20180622205813.GV3593@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 13:58:13 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> Something like this:
> 
> 	IRQ entered
> 
> And never exited.  Ever.  I actually saw this in 2011.

I still believe this was actually a bug. And perhaps you made the RCU
code robust enough to handle this bug ;-)

> 
> Or something like this:
> 
> 	IRQ exited
> 
> Without a corresponding IRQ enter.
> 
> The current code handles both of these situations, at least assuming
> that the interrupt entry/exit happens during a non-idle period.
> 
> > > So why this function-call structure?  Well, you see, NMI handlers can
> > > take what appear to RCU to be normal interrupts...
> > > 
> > > (And I just added that fun fact to Requirements.html.)  
> > 
> > Yes, I'll definitely go through all the interrupt requirements in the doc and
> > thanks for referring me to it.  
> 
> My concern may well be obsolete.  It would be good if it was!  ;-)

I'd love to mandate that irq_enter() must be paired with irq_exit(). I
don't really see any rationale for it to be otherwise. If there is a
case, perhaps it needs to be fixed.

-- Steve
