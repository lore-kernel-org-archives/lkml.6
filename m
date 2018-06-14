Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 46193C5CFC0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 22:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D2F208BA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 22:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D2F208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936142AbeFNWXN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 18:23:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936073AbeFNWXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 18:23:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A497D40122A1;
        Thu, 14 Jun 2018 22:23:11 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87241201E8ED;
        Thu, 14 Jun 2018 22:23:11 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w5EMNBFU008525;
        Thu, 14 Jun 2018 18:23:11 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w5EMNB67008521;
        Thu, 14 Jun 2018 18:23:11 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 14 Jun 2018 18:23:11 -0400 (EDT)
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
In-Reply-To: <20180613183145.17564d82@gandalf.local.home>
Message-ID: <alpine.LRH.2.02.1806141809500.6435@file01.intranet.prod.int.rdu2.redhat.com>
References: <Pine.LNX.4.44L0.1806131442230.1476-100000@iolanthe.rowland.org> <alpine.LRH.2.02.1806131521540.26196@file01.intranet.prod.int.rdu2.redhat.com> <20180613183145.17564d82@gandalf.local.home>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 14 Jun 2018 22:23:11 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 14 Jun 2018 22:23:11 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Jun 2018, Steven Rostedt wrote:

> On Wed, 13 Jun 2018 15:30:31 -0400 (EDT)
> Mikulas Patocka <mpatocka@redhat.com> wrote:
> 
> > On Wed, 13 Jun 2018, Alan Stern wrote:
> > 
> > > [Steve: Sorry for dumping you into the middle of this discussion.  
> > > Please see especially the last two paragraphs below.  Mikulas is
> > > getting dropouts with USB audio because part of the processing uses a
> > > tasklet.]  
> > 
> > The problem is this:
> > 
> > I have a single core machine with a usb2 sound card. When I increase the 
> > priority of a music player, the audio starts skipping.
> > 
> > The reason for the skipping is that the ehci usb driver is offloading urb 
> > callbacks using tasklet_hi_schedule, the callbacks end up being offloaded 
> > to the ksoftirqd thread (that has priority 0), the music player with 
> > elevated priority preempts ksoftirqd and causes delays in the urb 
> > callbacks.
> > 
> > Is this some deficiency in the softirq subsystem? (should we perhaps treat 
> > tasklet_hi specially and not offload it as much as the others?) Or should 
> > the ehci driver be fixed not to use tasklets?
> > 
> 
> What we do for softirqs in the RT patch is to have whoever raised the
> softirq run the softirq. If local_bh_disabled() is active (bh is
> disabled) then a bit is set in the current task struct, where when
> local_bh_enable() is called, it will then execute the softirqs that it
> raised while bh was disabled.
> 
> Perhaps try out the PREEMPT_RT patch and see if the problem goes away.

I tried the realtime patch with CONFIG_PREEMPT_RT_FULL and it plays well.

> Hopefully this softirq work may make it into the kernel soon. We could
> even enabled it without full PREEMPT_RT.

I don't think it's so easy. The kernel 2.4 and below did this. And the 
problem was that if there's a storm of network packets, the softirq code 
would cause lockup of the whole machine. In order to not lockup the 
machine - somewhere in the 2.4 cycle - the ksoftirqd thread was 
introduced.

If you have CONFIG_PREEMPT_RT_FULL and you call softirqs in the interrupt 
thread, you could only stall the interrupt thread. If you do the same 
thing without CONFIG_PREEMPT_RT_FULL, you stall the whole CPU.

Mikulas

>  https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/4.16/patch-4.16.12-rt5.patch.xz
> 
> -- Steve
> 
