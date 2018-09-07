Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EDBC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E952077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9E952077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbeIGS2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:28:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbeIGS2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:28:08 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0B6C2075E;
        Fri,  7 Sep 2018 13:47:04 +0000 (UTC)
Date:   Fri, 7 Sep 2018 09:47:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] printk/tracing: Do not trace printk_nmi_enter()
Message-ID: <20180907094703.60285f8f@gandalf.local.home>
In-Reply-To: <20180907083538.GA2279@jagdpanzerIV>
References: <20180905213334.03375777@vmware.local.home>
        <20180906023151.GA749@jagdpanzerIV>
        <20180907074531.GM24106@hirez.programming.kicks-ass.net>
        <20180907082834.vjycyvt6nddpb4la@pathway.suse.cz>
        <20180907083538.GA2279@jagdpanzerIV>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Sep 2018 17:35:38 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> Should't printk_nmi_enter()/printk_nmi_exit() still be notrace?
> Like you and Steven said - it's still before ftrace_nmi_enter()
> and should be notrace regardless.

Correct. My patch fixes both issues.

The patch that Peter is posting is in case for some reason in the future
printk_nmi_enter/exit() do something with interrupts or locking.

And the printk_nmi_enter/exit() is placed where it is, in case for some
reason lockdep_off/on() does a printk.

The printk_nmi_enter/exit() and lockdep_off/on() are only changing
state variables. Neither of them should be traced by ftrace.

My patch solved the problem and was not just fixing a symptom.

It could have been solved either way, but as Petr said, the
printk_nmi_enter/exit() should have been notrace, because it was before
ftrace_nmi_enter/exit(). Lockdep actually found this bug because the
lockdep_on/off() was not first.

-- Steve
