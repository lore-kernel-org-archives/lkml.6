Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA25C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1A421934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WaU/UsWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404250AbfBMWV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:21:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729530AbfBMWVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:21:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8oVuLoDVnj2tb2XL5dON4xuyr7XcMyQKTfgiYjWaLHI=; b=WaU/UsWieX2GCqS8xoDxOCDm1f
        iQHN6byeGNnfFjJLrEs2yJmo3QvTchGtaPZXX/LXgjvGUpeqfzaWd3N1MkGc4H/nYV4rnmDlQGAvm
        rQHFvd/ZKor/yOLH/uM+/07qmI7okCZgL4zbClCoJ0JYuwPZo8A/GboNM5v26jpVO1fSsOBKizDyx
        a7EK7YyOgKNvG88TPOat8cDOVa+eCRb2OnLWzlo6lVYKjrIMiwho5XtVVFjfc4oVATccuH6d1Y4z5
        HVERuxqUbeHmEX1iu1bobz83z149fAksgGCgSH8vcpk7j6KWzmmhxfu7xhP/59GqHF0PFN7UXiFY+
        9mCDnpaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gu2ua-0006DD-Qd; Wed, 13 Feb 2019 22:21:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CECC425E3DE45; Wed, 13 Feb 2019 23:21:46 +0100 (CET)
Date:   Wed, 13 Feb 2019 23:21:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        catalin.marinas@arm.com, james.morse@arm.com, hpa@zytor.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com,
        torvalds@linux-foundation.org, tglx@linutronix.de
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
Message-ID: <20190213222146.GC32494@hirez.programming.kicks-ass.net>
References: <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
 <20190213103553.GO32494@hirez.programming.kicks-ass.net>
 <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
 <20190213131720.GU32494@hirez.programming.kicks-ass.net>
 <20190213140025.GB6346@brain-police>
 <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 10:51:24AM -0800, Andy Lutomirski wrote:
> > On Feb 13, 2019, at 7:45 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> > Which I suppose means that GCC generates the PUSHF/POPF to preserve the
> > EFLAGS, since we mark those explicitly clobbered.
> > 
> 
> Not quite.  A flags clobber doesn’t save the control bits like AC
> except on certain rather buggy llvm compilers. The change you’re
> looking for is:
> 
> http://git.kernel.org/tip/2c7577a7583747c9b71f26dced7f696b739da745

Indeed, failed to find that.

> > For a little bit of context; it turns out that user_access_begin() /
> > user_access_end() sets EFLAGS.AC and scheduling in between there wrecks
> > that because we're apparently not saving that anymore.
> 
> But only explicit scheduling — preemption and sleepy page faults are
> fine because the interrupt frame saves flags.

No, like pointed out elsewhere in this thread, anything that does
preempt_disable() is utterly broken with this.

Because at that point the IRQ return path doesn't reschedule but
preempt_enable() will, and that doesn't preserve EFLAGS again.

> > Now, I'm tempted to add the PUSHF / POPF right back because of this, but
> > first I suppose we need to figure out if that change was on purpose and
> > why that went missing from the Changelog.
> 
> That’s certainly the easy solution. Or we could teach the might_sleep
> checks about this, but that could be a mess.

That's not enough, we'd have to teach preempt_disable(), but worse,
preempt_disable_notrace().

Anything that lands in ftrace, which _will_ use
preempt_disable_notrace(), will screw this thing up.
