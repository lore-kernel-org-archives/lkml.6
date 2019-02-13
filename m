Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C234C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA1C222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nANY/kzs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbfBMORV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:17:21 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43938 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfBMORV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g/rY88dwSNgbI6IugayxPvzdNhP0vcbds2CwH0My2R8=; b=nANY/kzsxnA2sMgFWRcxl84RF
        n7xpk9vO/3NldWgY6XbNt8qNpFT8U9qnKo/hD3V2vL++wJsjG1mTc2ZFsOI73xnvi7tMJgw0acaXn
        N+xjP/EJSRPnpP3eVbEAvRWvvotZ/hnKgZdo8M9HofQY9pZJcxZaK63Pm/WIrIi8Q0jMU3eIN4Rco
        EhkwKvV3rdI0Ha7Jd7N7VbmS6oC3VwRqFzJDNH/mbbfTy9I4oZXrIXFuLK5//zxw5eEjQjm9RjT5F
        WNYOAO4dm6SFvdjr72bsQJc0LLxQIki3QARfvTaTWx5fnq6XBAkiB7ft4khObn2FIlJfXWKpx6Xcr
        obAwfKlkA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtvLf-00012z-Vt; Wed, 13 Feb 2019 14:17:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E50C520F51B0C; Wed, 13 Feb 2019 15:17:12 +0100 (CET)
Date:   Wed, 13 Feb 2019 15:17:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Julien Thierry <julien.thierry@arm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        catalin.marinas@arm.com, james.morse@arm.com, hpa@zytor.com,
        valentin.schneider@arm.com
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
Message-ID: <20190213141712.GV32494@hirez.programming.kicks-ass.net>
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
 <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
 <20190211134527.GA121589@gmail.com>
 <20190211135159.GC32511@hirez.programming.kicks-ass.net>
 <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
 <20190213103553.GO32494@hirez.programming.kicks-ass.net>
 <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
 <20190213131720.GU32494@hirez.programming.kicks-ass.net>
 <20190213140025.GB6346@brain-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213140025.GB6346@brain-police>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 02:00:26PM +0000, Will Deacon wrote:
> > This; how is getting preempted fundamentally different from scheduling
> > ourselves?
> 
> The difference is because getting preempted in the sequence above is
> triggered off the back of an interrupt. On arm64, and I think also on x86,
> the user access state (SMAP or PAN) is saved and restored across exceptions
> but not across context switch. Consequently, taking an irq in a
> user_access_{begin,end} section and then scheduling is fine, but calling
> schedule directly within such a section is not.

So how's this then:

	if (user_access_begin()) {

		preempt_disable();

		<IRQ>
			set_need_resched();
		</IRQ no preempt>

		preempt_enable()
		  __schedule();

		user_access_end();
	}

That _should_ work just fine but explodes with the proposed nonsense.
