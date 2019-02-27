Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE0CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E8920661
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IVLxtn8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfB0OIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:08:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfB0OIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8uxU4O0qMrd91M9+QkNAd1ddLIQJ0JgzzCihjuoyzrk=; b=IVLxtn8Be4ivrLZe+AcZYnWBw
        NXDsDiDJzI8Jfhtgb0a7CkGq8DINi4kRir8XL3+QDvEJtjE4UFEQml5CEPPNKFL64CN7EV7S06YZK
        o1jSKpD0/xU3Gl6PWVNf9iKXn4xGvTDeD9G//rm0lW/4k6/o0rcgcqQFn6unmphYjoAkSuzZWYixM
        dEKJ66LbbSLmWkmHxZkO815wekfwCf63wuwD6kH3M2bvKiGkfyhjgt5Mqm8d1PH/apHwbTbpCNu92
        fiHYica5300vs018gOUL5V9r+/0cYtQCFWyAfjSES7DDu+/Hsd18nILtYMW2sUh3BG08f1i0V0//x
        k344VXshw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyzsv-0005zF-Mx; Wed, 27 Feb 2019 14:08:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9CB552392B800; Wed, 27 Feb 2019 15:08:30 +0100 (CET)
Date:   Wed, 27 Feb 2019 15:08:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, aryabinin@virtuozzo.com,
        glider@google.com, dvyukov@google.com
Subject: Re: [PATCH 5/6] objtool: Add UACCESS validation
Message-ID: <20190227140830.GP32494@hirez.programming.kicks-ass.net>
References: <20190225124330.613028745@infradead.org>
 <20190225125232.191698923@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225125232.191698923@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 01:43:35PM +0100, Peter Zijlstra wrote:
> It is important that UACCESS regions are as small as possible;
> furthermore the UACCESS state is not scheduled, so doing anything that
> might directly call into the scheduler will cause random code to be
> ran with UACCESS enabled.
> 
> Teach objtool too track UACCESS state and warn about any CALL made
> while UACCESS is enabled. This very much includes the __fentry__()
> tracing calls and __preempt_schedule() calls.
> 
> Note that exceptions _do_ save/restore the UACCESS state, and therefore
> they can drive preemption. This also means that all exception handlers
> must have an otherwise dedundant UACCESS disable instruction;
> therefore ignore this warning for !STT_FUNC code (exception handlers
> are not normal functions).
> 
> It also provides a UACCESS_SAFE() annotation which allows explicit
> annotation. This is meant to be used for future things like:
> unsafe_copy_{to,from}_user().
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

So KASAN is wildly unhappy..

I can't actually find any definitions of those functions, so I can't
very well mark the safe, even if we wanted to.

---

>> arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0x59: call to __asan_store8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0x6a: call to __asan_store8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0x7b: call to __asan_store8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0x8f: call to __asan_store8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0xa3: call to __asan_store8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0xb4: call to __asan_store8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0xc5: call to __asan_store8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0xdc: call to __asan_store8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0xf0: call to __asan_store8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0x101: call to __asan_store8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0x112: call to __asan_store8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0x123: call to __asan_store8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0x134: call to __asan_store8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0x145: call to __asan_store8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0x156: call to __asan_store8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0x167: call to __asan_store8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0x177: call to __asan_store8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0x192: call to __asan_store8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0x1bc: call to __asan_store8_noabort() with UACCESS enabled
>> arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0x1f2: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0x212: call to __asan_store8_noabort() with UACCESS enabled
>> arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0x1d8: call to force_valid_ss.isra.0() with UACCESS enabled
>> arch/x86/kernel/signal.o: warning: objtool: setup_sigcontext()+0x3f: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: setup_sigcontext()+0x50: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: setup_sigcontext()+0x61: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: setup_sigcontext()+0x75: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: setup_sigcontext()+0x89: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: setup_sigcontext()+0x9a: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: setup_sigcontext()+0xab: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: setup_sigcontext()+0xbc: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: setup_sigcontext()+0xcd: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: setup_sigcontext()+0xde: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: setup_sigcontext()+0xef: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: setup_sigcontext()+0x100: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: setup_sigcontext()+0x111: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: setup_sigcontext()+0x122: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: setup_sigcontext()+0x133: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: setup_sigcontext()+0x143: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: setup_sigcontext()+0x157: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: setup_sigcontext()+0x173: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: setup_sigcontext()+0x18e: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: setup_sigcontext()+0x1a8: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: setup_sigcontext()+0x1c2: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: setup_sigcontext()+0x1ee: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: setup_sigcontext()+0x217: call to __asan_load8_noabort() with UACCESS enabled
>> arch/x86/kernel/signal.o: warning: objtool: do_signal()+0x618: call to __asan_load8_noabort() with UACCESS enabled
>> arch/x86/kernel/signal.o: warning: objtool: do_signal()+0x630: call to __asan_loadN_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: do_signal()+0x681: call to __asan_load8_noabort() with UACCESS enabled
>> arch/x86/kernel/signal.o: warning: objtool: do_signal()+0x6a0: call to __asan_load4_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: do_signal()+0x6bd: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: do_signal()+0x7cb: call to __asan_load8_noabort() with UACCESS enabled
>> arch/x86/kernel/signal.o: warning: objtool: do_signal()+0x6dd: call to __asan_store8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: do_signal()+0x6f0: call to __asan_store8_noabort() with UACCESS enabled
>> arch/x86/kernel/signal.o: warning: objtool: do_signal()+0x707: call to __asan_store4_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: do_signal()+0x2c6: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: do_signal()+0x2e3: call to __asan_loadN_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: do_signal()+0x334: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: do_signal()+0x352: call to __asan_load4_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: do_signal()+0x374: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: do_signal()+0x49d: call to __asan_load8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: do_signal()+0x393: call to __asan_store8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: do_signal()+0x3aa: call to __asan_store8_noabort() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: do_signal()+0x3c1: call to __asan_store4_noabort() with UACCESS enabled
