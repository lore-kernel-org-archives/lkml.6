Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 08AEFC5CFC0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 22:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7168208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 22:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7168208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965074AbeFNWfv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 18:35:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965037AbeFNWft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 18:35:49 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4733320896;
        Thu, 14 Jun 2018 22:35:48 +0000 (UTC)
Date:   Thu, 14 Jun 2018 18:35:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: don't offload isochronous urb completions to
 ksoftirq
Message-ID: <20180614183546.7e04024c@gandalf.local.home>
In-Reply-To: <alpine.LRH.2.02.1806141809500.6435@file01.intranet.prod.int.rdu2.redhat.com>
References: <Pine.LNX.4.44L0.1806131442230.1476-100000@iolanthe.rowland.org>
        <alpine.LRH.2.02.1806131521540.26196@file01.intranet.prod.int.rdu2.redhat.com>
        <20180613183145.17564d82@gandalf.local.home>
        <alpine.LRH.2.02.1806141809500.6435@file01.intranet.prod.int.rdu2.redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2018 18:23:11 -0400 (EDT)
Mikulas Patocka <mpatocka@redhat.com> wrote:

> I don't think it's so easy. The kernel 2.4 and below did this. And the 
> problem was that if there's a storm of network packets, the softirq code 
> would cause lockup of the whole machine. In order to not lockup the 
> machine - somewhere in the 2.4 cycle - the ksoftirqd thread was 
> introduced.
> 
> If you have CONFIG_PREEMPT_RT_FULL and you call softirqs in the interrupt 
> thread, you could only stall the interrupt thread. If you do the same 
> thing without CONFIG_PREEMPT_RT_FULL, you stall the whole CPU.
> 

Note, PREEMPT_RT also uses ksoftirqd too. Although we may set it to RT
prio 1. It is triggered if the softirq itself raises a softirq of the
same kind, and then the work is passed off to the ksoftirqd.

Causing the interrupt thread to stall (or by going into a loop of
softirqs) is likely to lock up the CPU on RT too, as interrupt threads
are usually run at priority 50, which will keep normal threads from
running on that CPU.

-- Steve

