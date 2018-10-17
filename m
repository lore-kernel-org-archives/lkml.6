Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C31C5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D233D2148D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGy1Obor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D233D2148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeJQITF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 04:19:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbeJQITF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 04:19:05 -0400
Received: from localhost (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58F582148C;
        Wed, 17 Oct 2018 00:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539735964;
        bh=FduHjmQooEV2vCqYnmR6Cl+aw9zw6SLSs+5137FFO7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rGy1OborMMG7YGQZFqereRTPe8r+PJ7NpkJLMAJgVNc2rgyj/ex5omfGxrPjX6CT8
         8+7EDuHzhi8CE+US06dnt5eFBOJNPIrllv1n2E0H/G2QFt/aoCWBbBDIALn/1Y/pdk
         rBl5rsXXnaQs2dfUZahe5lDRhSpJVzZWHCaMXGyw=
Date:   Wed, 17 Oct 2018 02:26:02 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [RFC PATCH 29/30] softirq: Make softirq processing
 softinterruptible
Message-ID: <20181017002601.GB12996@lenoir>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
 <1539213137-13953-30-git-send-email-frederic@kernel.org>
 <20181016041552.GA27587@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016041552.GA27587@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavan,

On Tue, Oct 16, 2018 at 09:45:52AM +0530, Pavan Kondeti wrote:
> Hi Frederic,
> 
> On Thu, Oct 11, 2018 at 01:12:16AM +0200, Frederic Weisbecker wrote:
> > From: Frederic Weisbecker <fweisbec@gmail.com>
> > 
> > Make do_softirq() re-entrant and allow a vector, being either processed
> > or disabled, to be interrupted by another vector. This way a vector
> > won't be able to monopolize the CPU for a long while at the expense of
> > the others that may rely on some predictable latency, especially on
> > softirq disabled sections that used to disable all vectors.
> > 
> I understand that a long running softirq can be preempted/interrupted by
> other softirqs which is not possible today. I have few questions on your
> patches.
> 
> (1) When softirq processing is pushed to ksoftirqd, then the long running
> softirq can still block other softirqs (not in SOFTIRQ_NOW_MASK) for a while.
> correct?

No, Ksoftirqd is treated the same as IRQ tail processing here: a vector can
interrupt another. So for example, a NET_RX softirq running in Ksoftirqd can
be interrupted by a TIMER softirq running in hardirq tail.

> 
> (2) When softirqs processing happens asynchronously, a particular softirq
> like TASKLET can keep interrupting an already running softirq like TIMER/NET_RX,
> correct? In worse case scenario, a long running softirq like NET_RX interrupt
> a TIMER softirq. But I guess this is something expected with this. i.e
> each softirq is independent and whichever comes recent gets to interrupt the
> previously running softirqs.

Exactly, and that's inherent with interrupts in general. The only way to work
around that is to thread each vector independantly but that's a whole different
dimension :-)

Thanks!
