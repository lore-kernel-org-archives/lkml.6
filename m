Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D7AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D92820675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392872AbfAPMuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:50:46 -0500
Received: from foss.arm.com ([217.140.101.70]:47560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390394AbfAPMup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:50:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CA4680D;
        Wed, 16 Jan 2019 04:50:45 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC9843F5AF;
        Wed, 16 Jan 2019 04:50:43 -0800 (PST)
To:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Julien Thierry <julien.thierry@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Subject: preempt_schedule_irq() loop question
Message-ID: <cc989920-a13b-d53b-db83-1584a7f53edc@arm.com>
Date:   Wed, 16 Jan 2019 12:50:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been wandering around preempt_schedule_irq() in sched/core.c, and
got curious regarding how the arch code calls it.

The main part of preempt_schedule_irq() is:

    do {
	    preempt_disable();
	    local_irq_enable();
	    __schedule(true);
	    local_irq_disable();
	    sched_preempt_enable_no_resched();
    } while (need_resched());

Yet all the arch entry.S I looked at (I stopped after arm64, arm, x86_32,
MIPS, powerpc) wrap the call to preempt_schedule_irq() in another

    do { ... } while (need_resched())

For instance, this is what's done in arm64:

    1:	bl	preempt_schedule_irq		// irq en/disable is done inside
	ldr	x0, [tsk, #TSK_TI_FLAGS]	// get new tasks TI_FLAGS
	tbnz	x0, #TIF_NEED_RESCHED, 1b	// needs rescheduling?


I naively thought this could be attributed to something like
preempt_schedule_irq() historically not having an inner loop, but it seems
to have been there since the beginning of time (or at least up to the point
where the git history stops).

I don't see why we need to have these nested loops - AFAICT the one in
preempt_schedule_irq() would suffice. What am I missing?

