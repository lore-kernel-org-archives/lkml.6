Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FEFC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4ECD205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mzNwJCqd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VUao7bMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4ECD205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeJVQ3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:29:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43360 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbeJVQ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 12:29:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2001F6079C; Mon, 22 Oct 2018 08:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540195929;
        bh=X0sOQCQB1Fln9Y0FF3k39QbT/jgVQSlmXRzck4TMMJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mzNwJCqdEB9N4z/k0A6mTA4Z1Xx9qViA7XgJgZbR6/JzjhsHtuVJrljrYbEhBM6CB
         cxVKm6iRIu7jRmf+9M3I1zqxNYnzn1NN+6Ir/9+hawacsTv9xfarK2JMJEmYoKkel0
         n1Dd+aNXC3BKmlHG1EJ3oi0brYIlZK3uRS8owgfE=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 34FDC6050D;
        Mon, 22 Oct 2018 08:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540195928;
        bh=X0sOQCQB1Fln9Y0FF3k39QbT/jgVQSlmXRzck4TMMJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VUao7bMiGonGBjEKY9NirUGV1cJIVZNXLtkR0sDAZcwRt3LnF3DPe1Y42xZNCR88a
         qtILSGBKVSaeyf+qBe8sWBp2cYtjzFHGNWbvALKyjjfSUFI78O2Cdg0hKxXzndLjIX
         qibOV33/Z1YLZRISHB4enKoYka9tFUEPxh2k/84Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34FDC6050D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Mon, 22 Oct 2018 13:42:00 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Frederic Weisbecker <frederic@kernel.org>
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
Message-ID: <20181022081200.GB27587@codeaurora.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
 <1539213137-13953-30-git-send-email-frederic@kernel.org>
 <20181016041552.GA27587@codeaurora.org>
 <20181017002601.GB12996@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017002601.GB12996@lenoir>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic,

On Wed, Oct 17, 2018 at 02:26:02AM +0200, Frederic Weisbecker wrote:
> Hi Pavan,
> 
> On Tue, Oct 16, 2018 at 09:45:52AM +0530, Pavan Kondeti wrote:
> > Hi Frederic,
> > 
> > On Thu, Oct 11, 2018 at 01:12:16AM +0200, Frederic Weisbecker wrote:
> > > From: Frederic Weisbecker <fweisbec@gmail.com>
> > > 
> > > Make do_softirq() re-entrant and allow a vector, being either processed
> > > or disabled, to be interrupted by another vector. This way a vector
> > > won't be able to monopolize the CPU for a long while at the expense of
> > > the others that may rely on some predictable latency, especially on
> > > softirq disabled sections that used to disable all vectors.
> > > 
> > I understand that a long running softirq can be preempted/interrupted by
> > other softirqs which is not possible today. I have few questions on your
> > patches.
> > 
> > (1) When softirq processing is pushed to ksoftirqd, then the long running
> > softirq can still block other softirqs (not in SOFTIRQ_NOW_MASK) for a while.
> > correct?
> 
> No, Ksoftirqd is treated the same as IRQ tail processing here: a vector can
> interrupt another. So for example, a NET_RX softirq running in Ksoftirqd can
> be interrupted by a TIMER softirq running in hardirq tail.
> 
When ksoftirqd is running, we are only allowing softirqs in SOFTIRQ_NOW_MASK
to run after serving an interrupt. So I don't see how TIMER which is not
in SOFTIRQ_NOW_MASK can interrupt a NET_RX softirq running in ksoftirqd
context.

> > 
> > (2) When softirqs processing happens asynchronously, a particular softirq
> > like TASKLET can keep interrupting an already running softirq like TIMER/NET_RX,
> > correct? In worse case scenario, a long running softirq like NET_RX interrupt
> > a TIMER softirq. But I guess this is something expected with this. i.e
> > each softirq is independent and whichever comes recent gets to interrupt the
> > previously running softirqs.
> 
> Exactly, and that's inherent with interrupts in general. The only way to work
> around that is to thread each vector independantly but that's a whole different
> dimension :-)
> 
Right.

Assigning a thread for each vector also may not solve this problem because
preemption would be disabled while a softirq vector is running in its own
thread.

I guess there is no hard priorities among softirq vectors. Earlier
it was like first come first serve, now it is not. If we had priorities
defined, (don't know how :-)) we could disable the lower prio vectors while a
higher prio vector is being handled. This way we could gaurantee that TIMER
softirq or HI-TASKLET won't be starved while a long running softirq like
NET_RX/NET_TX/RCU is running.

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

