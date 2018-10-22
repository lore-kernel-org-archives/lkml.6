Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337A0C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF06D208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF06D208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbeJVSk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:40:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44624 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728604AbeJVSk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:40:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1660780D;
        Mon, 22 Oct 2018 03:23:02 -0700 (PDT)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4D4F3F6A8;
        Mon, 22 Oct 2018 03:23:00 -0700 (PDT)
Date:   Mon, 22 Oct 2018 11:22:55 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, tipbuild@zytor.com,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [tip:locking/core 6/10] arch/x86/include/asm/rmwcc.h:23:17:
 error: jump into statement expression
Message-ID: <20181022102254.GA5999@brain-police>
References: <201810201105.YsnXEXTU%fengguang.wu@intel.com>
 <20181022100830.GK4931@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022100830.GK4931@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 12:08:30PM +0200, Peter Zijlstra wrote:
> ARGH; so, this:
> 
> #define __GEN_RMWcc(fullop, _var, cc, clobbers, ...)			\
> ({									\
> 	bool c = false;							\
> 	asm_volatile_goto (fullop "; j" #cc " %l[cc_label]"		\
> 			: : [var] "m" (_var), ## __VA_ARGS__		\
> 			: clobbers : cc_label);				\
> 	if (0) {							\
> cc_label:	c = true;						\
> 	}								\
> 	c;								\
> })
> 
> static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lock)
> {
> 	u32 val = 0;
> 
> 	if (GEN_BINARY_RMWcc(LOCK_PREFIX "btsl", lock->val.counter, c,
> 			     "I", _Q_PENDING_OFFSET))
> 		val |= _Q_PENDING_VAL;
> 
> 	val |= atomic_read(&lock->val) & ~_Q_PENDING_MASK;
> 
> 	return val;
> }
> 
> fails to compile when combined with this:
> 
> #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )

Rosteeeedt!

> #define __trace_if(cond) \
> 	if (__builtin_constant_p(!!(cond)) ? !!(cond) :			\
> 	({								\
> 		int ______r;						\
> 		static struct ftrace_branch_data			\
> 			__attribute__((__aligned__(4)))			\
> 			__attribute__((section("_ftrace_branch")))	\
> 			______f = {					\
> 				.func = __func__,			\
> 				.file = __FILE__,			\
> 				.line = __LINE__,			\
> 			};						\
> 		______r = !!(cond);					\
> 		______f.miss_hit[______r]++;				\
> 		______r;						\
> 	}))
> 
> Because that moves the __GEN_RMWcc into a statement expression and GCC
> apparently doesn't like labels inside statement expressions.
> 
> If we avoid if() and rewrite queued_fetch_set_pending_acquire() like so:
> 
> static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lock)
> {
> 	bool pending;
> 	u32 val;
> 
> 	pending = GEN_BINARY_RMWcc(LOCK_PREFIX "btsl", lock->val.counter, c,
> 				   "I", _Q_PENDING_OFFSET);
> 
> 	val = pending * _Q_PENDING_VAL;
> 	val |= atomic_read(&lock->val) & ~_Q_PENDING_MASK;
> 
> 	return val;
> }
> 
> then it compiles again; but urgh.
> 
> Anybody see a better solution?

No, that looks about right to me, but please throw in a comment so that we
don't "fix" this in the future.

Will
