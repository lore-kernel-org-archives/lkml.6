Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7431EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429A920855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cSv7Xj/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfARKCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:02:50 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57338 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfARKCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:02:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y8SFnvpQ1X5/n+mwf0ouHSHPbPa7IoIoSjKOs9RppOY=; b=cSv7Xj/GvzBZBWRtCA/znDHoL
        Klv7FvbYaBLQxKFpYzcA8xuTW1N3WJSyV4kUEoZF96CiIytGIKnwgZFI6kfBWEp5UP9qYkehTyTOC
        vqK7dCXECKaoZVMfwJTqu1m9Jf1mbUtI0aBk5cG+Q0pa605sViUDkfCJvtnCW4f/TMKC6pe9gUxub
        YLeHoHu5UP84EA7+ul1Qop9KPWi5Gc4VuRr7KsC++K5FDO0ZcJqsNB/evbxXw+jFe1wfIWSCjaR+D
        NKOnq14b4r/OBhFqPOH0bVAytxkh3HIoXXPSRWNkbVmaCn3qnkMqIyYFNQjINYZcO5BwQgSg2cbEf
        dyyvAhcDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gkQyu-0001Zq-8j; Fri, 18 Jan 2019 10:02:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2C54B20578D1E; Fri, 18 Jan 2019 11:02:29 +0100 (CET)
Date:   Fri, 18 Jan 2019 11:02:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     James Morse <james.morse@arm.com>
Cc:     Waiman Long <longman@redhat.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        SRINIVAS <srinivas.eeda@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Question about qspinlock nest
Message-ID: <20190118100229.GB27931@hirez.programming.kicks-ass.net>
References: <e784a592-5dec-b0b3-6c70-d9ef775621d5@oracle.com>
 <910e9fb6-d0df-4711-fe2b-244b3c20eb82@redhat.com>
 <d06126a1-1db8-f937-2084-2c1234b6f56f@arm.com>
 <20190110201217.GH2861@worktop.programming.kicks-ass.net>
 <a270215d-ec5a-8b8a-3786-c0480b640abc@arm.com>
 <20190114131613.GB10486@hirez.programming.kicks-ass.net>
 <830db851-d5cb-4081-8d72-e3f3a0a282df@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <830db851-d5cb-4081-8d72-e3f3a0a282df@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 01:54:49PM +0000, James Morse wrote:
> On 14/01/2019 13:16, Peter Zijlstra wrote:

> > What avoids the trivial self-recursion:
> > 
> >   spin_lock(&)
> >   <NMI>
> >     spin_lock(&x)
> >      ... wait forever more ...
> >   </NMI>
> >   spin_unlock(&x)
> > 
> > ?
> 
> If its trying to take the same lock, I agree its deadlocked.
> If the sequence above started with <NMI>, I agree its deadlocked.
> 
> APEI/GHES is doing neither of these things. It take a lock that is only ever
> taken in_nmi(). nmi_enter()s BUG_ON(in_nmi()) means these never become re-entrant.

Urgh.. yes. I abhor that spinlock usage, but you're correct. If they're
only ever used in the NMI then it ought to work.

/me digs around... Bugger we have more like that :/

> What is the lock doing? Protecting the 'NMI' fixmap slot in the unlikely case
> that two CPUs end up in here at the same time.
> 
> (I though x86's NMI masked NMI until the next iret?)

Correct; x86 has his 'feature' where IRET will unmask the NMI, so we
have something quite terrible to deal with that, don't ask and I shall
not have to explain :-)

> This is murkier on arm64 as we have multiple things that behave like this, but
> there is an order to them, and none of them can interrupt themselves.

Well, x86 too has multiple non-maskable vectors, and afaik only the
actual NMI vector is covered in tricky. But our MCE vector is
non-maskable too (and I have vague memories of there being more).

Boris, Rostedt, WTH happens if our MCE code goes and hits a #BP ? (not
unlikely with this proliferation of self-modifying code)

Anyway, the idea is that they can indeed not interrupt themselves, but I
would not be surprised if the whole MCE thing is riddled with fail (on
x86).

> e.g. We can't take an SError during the SError handler.
> 
> But we can take this SError/NMI on another CPU while the first one is still
> running the handler.
> 
> These multiple NMIlike notifications mean having multiple locks/fixmap-slots,
> one per notification. This is where the qspinlock node limit comes in, as we
> could have more than 4 contexts.

Right; so Waiman was going to do a patch that reverts to test-and-set or
something along those lines once we hit the queue limit, which seems
like a good way out. Actually hitting that nesting level should be
exceedingly rare.
