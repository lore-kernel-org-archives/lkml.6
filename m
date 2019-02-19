Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DFAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D312146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ky8ytGJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfBSJo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:44:59 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54788 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfBSJo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BSKboyCAOkwlTQlKVtpuNo+zZmTvDQywmdcs6fHkXqM=; b=ky8ytGJOQ04HHG8DhPq+zcPu4
        sa6f0/O8OTIaEJ0B5ryEF+9jsjEetVerBJeHnW+nL+jC1g5ZGd6lA+xmXVwPFQPrmM/dtGtJi17iY
        RqyTToWoJNxrssViqpibcJLFJbohBjqeCOxOpzKooJlr6Wfp1RjrOk4dLxV3zw+ew3FsHpit1dv5h
        WYxd/P1VpAuVIvSNzp2Bw2XM7i57Y1CYbTumuQ4Ad2oj1+Pwndw2lq6jllr9IoQH44GW3eXETsgLb
        pjguJ02CbPrSN9yEeq6/AaRWShX9fG/WG+lPzuo8Ye0/PMDstZBT3lUs8zNEiDKbMY9tR1+rOL+qm
        orgUlOptA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gw1xB-0008TD-VJ; Tue, 19 Feb 2019 09:44:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 03AD4285202CC; Tue, 19 Feb 2019 10:44:39 +0100 (CET)
Date:   Tue, 19 Feb 2019 10:44:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com,
        torvalds@linux-foundation.org, tglx@linutronix.de
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
Message-ID: <20190219094438.GV32534@hirez.programming.kicks-ass.net>
References: <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219090409.GW32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 10:04:09AM +0100, Peter Zijlstra wrote:
> > Does that make more sense?
> 
> It appears to me you're going about it backwards.

So how about you do a GCC plugin that verifies limits on code-gen
between user_access_begin/user_access_end() ?

 - No CALL/RET
   - implies user_access_end() happens
   - implies no fentry hooks
 - No __preempt_count frobbing
 - No tracepoints
 - ...

That way you put the burden on the special code, not on the rest of the
kernel.

