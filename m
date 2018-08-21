Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD24C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA35721502
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA35721502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbeHUFMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 01:12:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43848 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725732AbeHUFMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 01:12:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3F377A9;
        Mon, 20 Aug 2018 18:54:18 -0700 (PDT)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF2763F739;
        Mon, 20 Aug 2018 18:54:17 -0700 (PDT)
Date:   Tue, 21 Aug 2018 02:54:15 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking: Remove an insn from spin and write locks
Message-ID: <20180821015413.GD1758@brain-police>
References: <20180820162639.GC25153@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820162639.GC25153@bombadil.infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 09:26:39AM -0700, Matthew Wilcox wrote:
> On Mon, Aug 20, 2018 at 05:56:50PM +0200, Peter Zijlstra wrote:
> > Yeah, _acquire should be retained; sorry about loosing that. I'm neck
> > deep into tlb invalidate stuff and wrote this without much thinking
> > involved.
> 
> NP.  Here's the current version I've got, with some updated likely()
> hints.
> 
> From 337298a88266f7b21492f893c2bf05409a5392c8 Mon Sep 17 00:00:00 2001
> From: Matthew Wilcox <willy@infradead.org>
> Date: Mon, 20 Aug 2018 10:19:14 -0400
> Subject: [PATCH] locking: Remove an insn from spin and write locks
> 
> Both spin locks and write locks currently do:
> 
>  f0 0f b1 17             lock cmpxchg %edx,(%rdi)
>  85 c0                   test   %eax,%eax
>  75 05                   jne    [slowpath]
> 
> This 'test' insn is superfluous; the cmpxchg insn sets the Z flag
> appropriately.  Peter pointed out that using atomic_try_cmpxchg_acquire()
> will let the compiler know this is true.  Comparing before/after
> disassemblies show the only effect is to remove this insn.
> 
> Take this opportunity to make the spin & write lock code resemble each
> other more closely and have similar likely() hints.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> ---
>  include/asm-generic/qrwlock.h   |  7 ++++---
>  include/asm-generic/qspinlock.h | 17 ++++++++++-------
>  2 files changed, 14 insertions(+), 10 deletions(-)

Shouldn't make any difference on arm64, so:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
