Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C21C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 10:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8596222DD
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 10:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xEtjjyJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbfBPKbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 05:31:01 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60128 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfBPKbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 05:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=myhR7JERoDfu2IeT6NVXGFHfmgtZTqs8HmBqII9TuUE=; b=xEtjjyJkguuIDY05HA33PEPdD
        2DY65orj8zOSvYITfGFVpDndP94CdragUz1DBQKTorMAUGwmX/fu1SNVVKys656f4VZf3gqGtfjyz
        TfBRgwf/oscnScF2fbYkpsQIsCVVhZMw3JaxLzOaRtBifPxP7yT48Mkvurt6Vqskki/RCjZfdGvYm
        gxoyQX5zgKDp0UbRd38/dtJVt9R6FxWIde+x49kgNdIZGcjFwYNNqU5YhPfgt26Us1IA0OlwnEPpT
        XrIh2AvcGVdFfuynmLoMRK00VvRY4yfPtemycBoLlrIlMWtCn7xF5mGFM63CMn2tkxA2kDgTnsQpr
        g7qtFLEsQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guxF9-0001vD-EP; Sat, 16 Feb 2019 10:30:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D712323E8CC39; Sat, 16 Feb 2019 11:30:44 +0100 (CET)
Date:   Sat, 16 Feb 2019 11:30:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     hpa@zytor.com
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
Message-ID: <20190216103044.GR32494@hirez.programming.kicks-ass.net>
References: <20190213140025.GB6346@brain-police>
 <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 08:06:56PM -0800, hpa@zytor.com wrote:
> This implies we invoke schedule -- a restricted operation (consider
> may_sleep) during execution of STAC-enabled code, but *not* as an
> exception or interrupt, since those preserve the flags.

Meet preempt_enable().

> I have serious concerns about this. This is more or less saying that
> we have left an unlimited gap and have had AC escape.

Yes; by allowing normal C in between STAC and CLAC this is so.

> Does *anyone* see a need to allow this? I got a question at LPC from
> someone about this, and what they were trying to do once all the
> layers had been unwound was so far down the wrong track for a root
> problem that actually has a very simple solution.

Have you read the rest of the thread?

All it takes for this to explode is a call to a C function that has
tracing on it in between the user_access_begin() and user_access_end()
things. That is a _very_ easy thing to do.

Heck, GCC is allowed to generate that broken code compiling
lib/strnlen_user.c; it doesn't _have_ to inline do_strnlen_user (esp.
with CONFIG_OPTIMIZE_INLINING), and making that a function call would
get us fentry hooks and ftrace and *BOOM*.

(Now, of course, its a static function with a single caller, and GCC
isn't _THAT_ stupid, but it could, if it wanted to)

Since the bar is _that_ low for mistakes, I figure we'd better fix it.
