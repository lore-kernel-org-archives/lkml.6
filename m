Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B04DC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B86208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B86208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966145AbeFOQlM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:41:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964992AbeFOQlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:41:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA80C7D858;
        Fri, 15 Jun 2018 16:41:10 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87B5920284D6;
        Fri, 15 Jun 2018 16:41:10 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w5FGfAYl008755;
        Fri, 15 Jun 2018 12:41:10 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w5FGfAOO008751;
        Fri, 15 Jun 2018 12:41:10 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 15 Jun 2018 12:41:10 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     Alan Stern <stern@rowland.harvard.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: don't offload isochronous urb completions to
 ksoftirq
In-Reply-To: <20180614183546.7e04024c@gandalf.local.home>
Message-ID: <alpine.LRH.2.02.1806151222200.5648@file01.intranet.prod.int.rdu2.redhat.com>
References: <Pine.LNX.4.44L0.1806131442230.1476-100000@iolanthe.rowland.org> <alpine.LRH.2.02.1806131521540.26196@file01.intranet.prod.int.rdu2.redhat.com> <20180613183145.17564d82@gandalf.local.home> <alpine.LRH.2.02.1806141809500.6435@file01.intranet.prod.int.rdu2.redhat.com>
 <20180614183546.7e04024c@gandalf.local.home>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 15 Jun 2018 16:41:10 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 15 Jun 2018 16:41:10 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Jun 2018, Steven Rostedt wrote:

> On Thu, 14 Jun 2018 18:23:11 -0400 (EDT)
> Mikulas Patocka <mpatocka@redhat.com> wrote:
> 
> > I don't think it's so easy. The kernel 2.4 and below did this. And the 
> > problem was that if there's a storm of network packets, the softirq code 
> > would cause lockup of the whole machine. In order to not lockup the 
> > machine - somewhere in the 2.4 cycle - the ksoftirqd thread was 
> > introduced.
> > 
> > If you have CONFIG_PREEMPT_RT_FULL and you call softirqs in the interrupt 
> > thread, you could only stall the interrupt thread. If you do the same 
> > thing without CONFIG_PREEMPT_RT_FULL, you stall the whole CPU.
> > 
> 
> Note, PREEMPT_RT also uses ksoftirqd too. Although we may set it to RT
> prio 1. It is triggered if the softirq itself raises a softirq of the
> same kind, and then the work is passed off to the ksoftirqd.

I think the major problem (in the upstream kernel) with softirq latency is 
this:
static inline void invoke_softirq(void)
{
        if (ksoftirqd_running())
                return;

It means that if any piece of code kicks ksoftirq, no tasklets are 
processed in the irq context at all.

So, the ehci callbacks will be offloaded to ksoftirqd (no matter how small 
they are) and this causes audio skipping. Could this be changed, so that 
it processes tasklets submitted with "tasklet_hi_schedule" in irq context 
even if ksoftirqd is running?

It's not easy - __do_softirq lacks any locking - so it can't run 
concurrently in process context and in irq context.

> Causing the interrupt thread to stall (or by going into a loop of
> softirqs) is likely to lock up the CPU on RT too, as interrupt threads
> are usually run at priority 50, which will keep normal threads from
> running on that CPU.
> 
> -- Steve

BTW. when I subject the machine to a ping flood (ping -f), the 
non-realtime kernel (with the patch to avoid offloading ehci urb 
callbacks) performs better than the real-time kernel.

With the real-time kernel, all the networking work is done in the thread 
"irq/12-eth0", that has (by default) priority -51, it consumes 30% CPU 
time and causes sound skipping. I can avoid the skipping by lowering the 
priority of "irq/12-eth0".

With non-realtime kernel, no such problem during ping flood exists.

Mikulas
