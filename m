Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CFFC67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC93D20866
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC93D20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbeJSJy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 05:54:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbeJSJy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 05:54:29 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 057C620644;
        Fri, 19 Oct 2018 01:50:36 +0000 (UTC)
Date:   Thu, 18 Oct 2018 21:50:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH RFC] doc: rcu: remove obsolete (non-)requirement about
 disabling preemption
Message-ID: <20181018215035.5e8ff553@vmware.local.home>
In-Reply-To: <20181019012645.GC89903@joelaf.mtv.corp.google.com>
References: <20181015210856.GE2674@linux.ibm.com>
        <20181016112611.GA27405@linux.ibm.com>
        <20181016204122.GA8176@joelaf.mtv.corp.google.com>
        <20181017161100.GP2674@linux.ibm.com>
        <20181017181505.GC107185@joelaf.mtv.corp.google.com>
        <20181017203324.GS2674@linux.ibm.com>
        <20181018020751.GB99677@joelaf.mtv.corp.google.com>
        <20181018144637.GD2674@linux.ibm.com>
        <20181019000350.GB89903@joelaf.mtv.corp.google.com>
        <20181019001932.GR2674@linux.ibm.com>
        <20181019012645.GC89903@joelaf.mtv.corp.google.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 18:26:45 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:

> Yes, local_irq_restore is light weight, and does not check for reschedules.
> 
> I was thinking of case where ksoftirqd is woken up, but does not run unless
> we set the NEED_RESCHED flag. But that should get set anyway since probably
> ksoftirqd is of high enough priority than the currently running task..
> 
> Roughly speaking the scenario could be something like:
> 
> rcu_read_lock();
>                  <-- IPI comes in for the expedited GP, sets exp_hint
> local_irq_disable();
> // do a bunch of stuff
> rcu_read_unlock();   <-- This calls the rcu_read_unlock_special which raises
>                          the soft irq, and wakesup softirqd.

If softirqd is of higher priority than the current running task, then
the try_to_wake_up() will set NEED_RESCHED of the current task here.

-- Steve

> local_irq_enable();
> 
> // Now ksoftirqd is ready to run but we don't switch into the
> // scheduler for sometime because tif_need_resched() returns false and
> // any cond_resched calls do nothing. So we potentially spend lots of
> // time before the next scheduling event.
> 
> You think this should not be an issue?

