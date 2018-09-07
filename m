Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8250CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E2B20869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E2B20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbeIGSmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbeIGSmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:42:36 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15F7E2083D;
        Fri,  7 Sep 2018 14:01:30 +0000 (UTC)
Date:   Fri, 7 Sep 2018 10:01:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] printk/tracing: Do not trace printk_nmi_enter()
Message-ID: <20180907100128.64e08130@gandalf.local.home>
In-Reply-To: <20180907095533.5b5febc2@gandalf.local.home>
References: <20180905213334.03375777@vmware.local.home>
        <20180907073448.GL24106@hirez.programming.kicks-ass.net>
        <20180907094148.2444acc6@gandalf.local.home>
        <20180907134532.GD24106@hirez.programming.kicks-ass.net>
        <20180907095533.5b5febc2@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Sep 2018 09:55:33 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 7 Sep 2018 15:45:32 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Yes really, we should not muck with the IRQ state from NMI context.  
> 
> Right, and we didn't. Your patch didn't change anything, but allow for
> printk_nmi_enter/exit() to be traced by ftrace, but that's wrong to
> begin with because it ftrace_nmi_enter() hasn't been called yet.
> 

I would even argue that placing printk_nmi_enter() between
lockdep_off() and ftrace_nmi_enter() is wrong because if in the future
printk_nmi_enter() were to do any ftrace tracing, it wont be caught, as
it was by having it before lockdep_off().

printk_nmi_enter() should not muck with IRQ state, nor should it do any
ftrace tracing. Since ftrace mucks with IRQ state when it gets enabled
or disabled, it will screw up lockdep, and lockdep will complain. That
way we can use lockdep not being off to catch this bug.

-- Steve
