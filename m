Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A18DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52AC22086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXgzFDyK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52AC22086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbeKTBhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:37:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729554AbeKTBhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:37:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA7B020831;
        Mon, 19 Nov 2018 15:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542640393;
        bh=gio2I3O1hAFb7nVINuclbgJ1W6fbk3FRlykPh+9qQbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GXgzFDyKk/pZlxNICunKEb4Sdaya9sGOXSfsqUvD4+qQyntAHiXyQAztQEtHNGV0D
         YRlPmoYaRmW91cYkyi5eWTtqQiw9PrUpTuen8cEDYNV3fTlUstRErK5kv9RtiVIgsG
         KCdy0+7wsq+nI+3MHZNt5Yaz17hS8F8c4jxlNIiM=
Date:   Mon, 19 Nov 2018 16:13:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        Andrew Morton <akpm@osdl.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] sched: Do not bug in __sched_setscheduler() when pi is
 not used
Message-ID: <20181119151311.GA5340@kroah.com>
References: <20170309101842.1449d49a@gandalf.local.home>
 <46a07263-3327-94b6-f6b8-a0a17ae7bfee@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46a07263-3327-94b6-f6b8-a0a17ae7bfee@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 12:55:20PM -0800, Florian Fainelli wrote:
> On 3/9/17 7:18 AM, Steven Rostedt wrote:
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > 
> > When priority inheritance was added back in 2.6.18 to sched_setscheduler, it
> > added a path to taking an rt-mutex wait_lock, which is not IRQ safe. As PI
> > is not a common occurrence, lockdep will likely never trigger if
> > sched_setscheduler was called from interrupt context. A BUG_ON() was added
> > to trigger if __sched_setscheduler() was ever called from interrupt context
> > because there was a possibility to take the wait_lock.
> > 
> > Today the wait_lock is irq safe, but the path to taking it in
> > sched_setscheduler() is the same as the path to taking it from normal
> > context. The wait_lock is taken with raw_spin_lock_irq() and released with
> > raw_spin_unlock_irq() which will indiscriminately enable interrupts,
> > which would be bad in interrupt context.
> > 
> > The problem is that normalize_rt_tasks, which is called by triggering the
> > sysrq nice-all-RT-tasks was changed to call __sched_setscheduler(), and this
> > is done from interrupt context!
> > 
> > Now __sched_setscheduler() takes a "pi" parameter that is used to know if
> > the priority inheritance should be called or not. As the BUG_ON() only cares
> > about calling the PI code, it should only bug if called from interrupt
> > context with the "pi" parameter set to true.
> > 
> > Link: http://lkml.kernel.org/r/20170308124654.10e598f2@gandalf.local.home
> > 
> > Reported-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> > Tested-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> > Fixes: dbc7f069b93a ("sched: Use replace normalize_task() with __sched_setscheduler()")
> > Cc: Andrew Morton <akpm@osdl.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@elte.hu>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Can this patch also be applied to the stable trees? The offending commit
> was first introduced in 4.2.

What is the git commit id of this patch in Linus's tree?

thanks,

greg k-h
