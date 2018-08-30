Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137B8C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B418520837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B418520837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeH3Wju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:39:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbeH3Wju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:39:50 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A85420835;
        Thu, 30 Aug 2018 18:36:19 +0000 (UTC)
Date:   Thu, 30 Aug 2018 14:36:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH tip/core/rcu 3/3] srcu: Make early-boot call_srcu()
 reuse workqueue lists
Message-ID: <20180830143617.2fb85e23@gandalf.local.home>
In-Reply-To: <20180830173742.GA17677@linux.vnet.ibm.com>
References: <20180829212036.GA22033@linux.vnet.ibm.com>
        <20180829212313.22903-3-paulmck@linux.vnet.ibm.com>
        <20180829215616.1c10e476@vmware.local.home>
        <20180830020701.GE4225@linux.vnet.ibm.com>
        <20180829224609.5ffdc9ec@vmware.local.home>
        <20180830032315.GG4225@linux.vnet.ibm.com>
        <20180830124444.6bb9faac@gandalf.local.home>
        <20180830173509.GL4225@linux.vnet.ibm.com>
        <20180830173742.GA17677@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 10:37:42 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:


> > > But still triggered the following:
> > > 
> > >  WARNING: CPU: 0 PID: 0 at /work/git/linux-trace.git/kernel/rcu/srcutree.c:242 check_init_srcu_struct+0x85/0x90  
> > 
> > Gah!!!  I needed to have removed that WARN_ON_ONCE(), didn't I?
> > In fact, I should have removed that once I started using workqueues,
> > quite some time back.  
> 
> As in the below patch.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 75571ff09c62..a8846ed7f352 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -239,7 +239,6 @@ static void check_init_srcu_struct(struct srcu_struct *sp)
>  {
>  	unsigned long flags;
>  
> -	WARN_ON_ONCE(rcu_scheduler_active == RCU_SCHEDULER_INIT);

Well it boots without warning ;-)

Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

>  	/* The smp_load_acquire() pairs with the smp_store_release(). */
>  	if (!rcu_seq_state(smp_load_acquire(&sp->srcu_gp_seq_needed))) /*^^^*/
>  		return; /* Already initialized. */

