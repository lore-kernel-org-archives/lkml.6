Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D39C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C7E2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C7E2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbeLAFaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:30:13 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:38582 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeLAFaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:30:13 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gSnOP-0000GL-3K; Fri, 30 Nov 2018 19:19:57 +0100
Date:   Fri, 30 Nov 2018 19:19:57 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     He Zhe <zhe.he@windriver.com>
Cc:     catalin.marinas@arm.com, tglx@linutronix.de, rostedt@goodmis.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] kmemleak: Turn kmemleak_lock to raw spinlock on RT
Message-ID: <20181130181956.eewrlaabtceekzyu@linutronix.de>
References: <1542877459-144382-1-git-send-email-zhe.he@windriver.com>
 <20181123095314.hervxkxtqoixovro@linutronix.de>
 <40a63aa5-edb6-4673-b4cc-1bc10e7b3953@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40a63aa5-edb6-4673-b4cc-1bc10e7b3953@windriver.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-24 22:26:46 [+0800], He Zhe wrote:
> On latest v4.19.1-rt3, both of the call traces can be reproduced with kmemleak
> enabied. And none can be reproduced with kmemleak disabled.
okay. So it needs attention.

> On latest mainline tree, none can be reproduced no matter kmemleak is enabled
> or disabled.
> 
> I don't get why kfree from a preempt-disabled section should cause a warning
> without kmemleak, since kfree can't sleep.

it might. It will acquire a sleeping lock if it has go down to the
memory allocator to actually give memory back.

> If I understand correctly, the call trace above is caused by trying to schedule
> after preemption is disabled, which cannot be reached in mainline kernel. So
> we might need to turn to use raw lock to keep preemption disabled.

The buddy-allocator runs with spin locks so it is okay on !RT. So you
can use kfree() with disabled preemption or disabled interrupts.
I don't think that we want to use raw-locks in the buddy-allocator.

> >From what I reached above, this is RT-only and happens on v4.18 and v4.19.
> 
> The call trace above is caused by grabbing kmemleak_lock and then getting
> scheduled and then re-grabbing kmemleak_lock. Using raw lock can also solve
> this problem.

But this is a reader / writer lock. And if I understand the other part
of the thread then it needs multiple readers.
Couldn't we just get rid of that kfree() or move it somewhere else?
I mean if the free() memory on CPU-down and allocate it again CPU-up
then we could skip that, rigth? Just allocate it and don't free it
because the CPU will likely get up again.

> Thanks,
> Zhe

Sebastian
