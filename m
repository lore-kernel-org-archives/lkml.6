Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F42C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E24208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E24208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936375AbeFORRs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:17:48 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46868 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S936136AbeFORRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:17:46 -0400
Received: (qmail 4388 invoked by uid 2102); 15 Jun 2018 13:17:45 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Jun 2018 13:17:45 -0400
Date:   Fri, 15 Jun 2018 13:17:45 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Mikulas Patocka <mpatocka@redhat.com>
cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: High-priority softirqs [was: [PATCH] usb: don't offload isochronous
 urb completions to ksoftirq]
In-Reply-To: <alpine.LRH.2.02.1806151222200.5648@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <Pine.LNX.4.44L0.1806151308310.1387-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2018, Mikulas Patocka wrote:

> I think the major problem (in the upstream kernel) with softirq latency is 
> this:
> static inline void invoke_softirq(void)
> {
>         if (ksoftirqd_running())
>                 return;
> 
> It means that if any piece of code kicks ksoftirq, no tasklets are 
> processed in the irq context at all.
> 
> So, the ehci callbacks will be offloaded to ksoftirqd (no matter how small 
> they are) and this causes audio skipping. Could this be changed, so that 
> it processes tasklets submitted with "tasklet_hi_schedule" in irq context 
> even if ksoftirqd is running?

That's a great question.  Basically you're asking to have the HI 
softirq always handled in the bottom half, never in ksoftirqd, right?  

Or maybe to have more than one softirq thread, to handle different 
softirq levels, so that they can be assigned differing priorities.

> It's not easy - __do_softirq lacks any locking - so it can't run 
> concurrently in process context and in irq context.

I have no idea.  Maybe someone with a better understanding of this part
of the kernel can help.

Alan Stern

