Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86E6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C0B20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sDdBJYUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C0B20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbeK1T5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 14:57:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57240 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeK1T5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 14:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=df0vEj1EBWN/IFALh7y7DF0WCXc8rjpJGy3ZN5kbDG0=; b=sDdBJYUybGR1TpUsfiO6mza7x
        Xj7KNHM08mgRucnw0oxGZkVjLB3BlD/IrsDkNHk13GA8w9TO79YHaeIJB2uNQ2IOcqo5LTAeKDmeV
        kRA3Y09ejrF36Eu/kKy8B1CMXcm9hXkFbY2eu9lDLbWU+TM0AG7Q/EyYl+0oa4ZU54bnWsH/TsjXI
        h50cWWu5U3CdiL3ahWsbazAyBZFX0alsPFKlAoBOH9A4Z8b5yDuD5moXKpDg8b7hMCyoxsO7H5G/X
        0XM1l2zKMZ3u6DFk9WtsXQr/AxLmFIG9X6L1LobhLQugQ4O7NXKWzXTk6tRWJDI+TY/xQ+xbxl1it
        4ODTjJsow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRveF-0001Dp-AX; Wed, 28 Nov 2018 08:56:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6B7382029FD58; Wed, 28 Nov 2018 09:56:40 +0100 (CET)
Date:   Wed, 28 Nov 2018 09:56:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, catalin.marinas@arm.com, rml@tech9.net,
        tglx@linutronix.de, schwidefsky@de.ibm.com
Subject: Re: [PATCH 0/2] arm64: Only call into preempt_schedule() if
 need_resched()
Message-ID: <20181128085640.GX2131@hirez.programming.kicks-ass.net>
References: <1543347902-21170-1-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543347902-21170-1-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 07:45:00PM +0000, Will Deacon wrote:
> Hi all,
> 
> This pair of patches improves our preempt_enable() implementation slightly
> on arm64 by making the resulting call to preempt_schedule() conditional
> on need_resched(), which is tracked in bit 32 of the preempt count. The
> logic is inverted so that we can detect the preempt count going to zero
> and need_resched being set with a single CBZ instruction.

>   40:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
>   44:   910003fd        mov     x29, sp
>   48:   d5384101        mrs     x1, sp_el0
>   4c:   f9400820        ldr     x0, [x1, #16]

We load x0 which is a u64, right?

>   50:   d1000400        sub     x0, x0, #0x1
>   54:   b9001020        str     w0, [x1, #16]

But we store w0, which is the low u32, such as to not touch the high
word which contains the preempt bit.

>   58:   b4000060        cbz     x0, 64 <will+0x24>
>   5c:   a8c17bfd        ldp     x29, x30, [sp], #16
>   60:   d65f03c0        ret
>   64:   94000000        bl      0 <preempt_schedule>
>   68:   a8c17bfd        ldp     x29, x30, [sp], #16
>   6c:   d65f03c0        ret

Why not?

   58:   b4000060        cbnz    x0, 60 <will+0x24>
   5c:   94000000        bl      0 <preempt_schedule>
   60:   a8c17bfd        ldp     x29, x30, [sp], #16
   64:   d65f03c0        ret

which seems shorter.


So it's still early, and I haven't finished (or really even started) my
pot 'o tea, but what about:


	ldr x0, [x1, #16]	// seees the high bit set -- no preempt needed
	sub x0, x0, #1

	<interrupt>
	  ...
	  resched_curr()
	    set_tsk_need_resched();
	    set_preempt_need_resched();
	</interrupt> // sees preempt_count != 0, does not preempt

	str w0, [x1, #16] // stores preempt_count == 0
	cbnz x0, 1f // taken, we still observe the high word from before

1:	ret


Which then ends with preempt_count==0, need_resched==0 and no actual
preemption afaict.

Can you use mis-matched ll x0 / sc w0 to do this same thing and detector
the intermediate write on the high word?
