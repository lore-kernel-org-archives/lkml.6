Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1BBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610F221848
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfAJQIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:08:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:58954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728213AbfAJQIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:08:42 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0491A206B7;
        Thu, 10 Jan 2019 16:08:40 +0000 (UTC)
Date:   Thu, 10 Jan 2019 11:08:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Possible use of RCU while in extended QS: idle vs RCU read-side
 in interrupt vs rcu_eqs_exit
Message-ID: <20190110110839.7daeef3d@gandalf.local.home>
In-Reply-To: <2103471967.794.1547084331086.JavaMail.zimbra@efficios.com>
References: <2103471967.794.1547084331086.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019 20:38:51 -0500 (EST)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Hi Paul,
> 
> I've had a user report that trace_sched_waking() appears to be
> invoked while !rcu_is_watching() in some situation, so I started
> digging into the scheduler idle code.

I'm wondering if this isn't a bug. Do you have the backtrace for where
trace_sched_waking() was called without rcu watching?

-- Steve

> 
> It appears that interrupts are re-enabled before rcu_eqs_exit() is
> invoked when exiting idle code from the scheduler.
> 
> I wonder what happens if an interrupt handler (including scheduler code)
> happens to issue a RCU read-side critical section before rcu_eqs_exit()
> is called ? Is there some code on interrupt entry that ensures rcu eqs
> state is exited in such scenario ?
> 
> Thanks,
> 
> Mathieu
> 

