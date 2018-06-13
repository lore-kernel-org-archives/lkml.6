Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0A3EDC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF18208D8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF18208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935857AbeFMWbt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 18:31:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935256AbeFMWbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 18:31:48 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F4562087E;
        Wed, 13 Jun 2018 22:31:47 +0000 (UTC)
Date:   Wed, 13 Jun 2018 18:31:45 -0400
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
Message-ID: <20180613183145.17564d82@gandalf.local.home>
In-Reply-To: <alpine.LRH.2.02.1806131521540.26196@file01.intranet.prod.int.rdu2.redhat.com>
References: <Pine.LNX.4.44L0.1806131442230.1476-100000@iolanthe.rowland.org>
        <alpine.LRH.2.02.1806131521540.26196@file01.intranet.prod.int.rdu2.redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018 15:30:31 -0400 (EDT)
Mikulas Patocka <mpatocka@redhat.com> wrote:

> On Wed, 13 Jun 2018, Alan Stern wrote:
> 
> > [Steve: Sorry for dumping you into the middle of this discussion.  
> > Please see especially the last two paragraphs below.  Mikulas is
> > getting dropouts with USB audio because part of the processing uses a
> > tasklet.]  
> 
> The problem is this:
> 
> I have a single core machine with a usb2 sound card. When I increase the 
> priority of a music player, the audio starts skipping.
> 
> The reason for the skipping is that the ehci usb driver is offloading urb 
> callbacks using tasklet_hi_schedule, the callbacks end up being offloaded 
> to the ksoftirqd thread (that has priority 0), the music player with 
> elevated priority preempts ksoftirqd and causes delays in the urb 
> callbacks.
> 
> Is this some deficiency in the softirq subsystem? (should we perhaps treat 
> tasklet_hi specially and not offload it as much as the others?) Or should 
> the ehci driver be fixed not to use tasklets?
> 

What we do for softirqs in the RT patch is to have whoever raised the
softirq run the softirq. If local_bh_disabled() is active (bh is
disabled) then a bit is set in the current task struct, where when
local_bh_enable() is called, it will then execute the softirqs that it
raised while bh was disabled.

Perhaps try out the PREEMPT_RT patch and see if the problem goes away.
Hopefully this softirq work may make it into the kernel soon. We could
even enabled it without full PREEMPT_RT.

 https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/4.16/patch-4.16.12-rt5.patch.xz

-- Steve
