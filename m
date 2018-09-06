Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8775C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839EF2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NC38cBrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839EF2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbeIFV7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:59:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49696 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbeIFV7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q4H4brl9yqspoJNgPF8tXq7iAZCE0Tcu0AV6WT2C0M0=; b=NC38cBrI1/lqpcdNxOwVE/g8Mt
        wA0rp/y4TGifnukeIpo8N71GuIRZAfUejxpfXW6MMq6NIJ8AXp//55aIyw6xlkXGomBP5Uj2Uw2Jh
        SuUzbKjwLhATIxLXBpGr5oirxFzwscQXw/Ba1zRHb8NuRA9g4cTwBWEn9nOzcXTur3kSRArgYeg5S
        SQB1xE//dCyvZayRqSs9R1eCv5MLlbl2URKdhgUr6IaxPFexxHqgc5OANyevyFV55kcBe7NB81hMm
        lIihfU/xDaK5iiIObDZcUfEQYnZOdEoufoRtqc9S5EwGW1lziwLyx0xEyua5jq3Z01uu8grQOwHfC
        EwCUUq0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxxzi-0003ia-Ks; Thu, 06 Sep 2018 17:23:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE5BD2058B2DE; Thu,  6 Sep 2018 19:23:00 +0200 (CEST)
Date:   Thu, 6 Sep 2018 19:23:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
Message-ID: <20180906172300.GK24082@hirez.programming.kicks-ass.net>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180905185617.GC24082@hirez.programming.kicks-ass.net>
 <8D3CE999-6D3A-4984-934A-634BDD8AC25A@vmware.com>
 <6B256AB7-0158-47DF-B2D5-4C835579F3A3@vmware.com>
 <20180906081300.GF24082@hirez.programming.kicks-ass.net>
 <20180906101641.GG24142@hirez.programming.kicks-ass.net>
 <6703CD9F-2D84-4449-A423-A4DC24677673@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6703CD9F-2D84-4449-A423-A4DC24677673@vmware.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 05:01:25PM +0000, Nadav Amit wrote:
> I’ll give your patch a try once my server goes back online. I was (and still
> am) worried that interrupts would be disabled when __set_pte_vaddr() is
> called, which would make the fix more complicated.

Thing is, we only need the TLB invalidate if the previous PTE was
present and the new PTE is different. If we write the 'first' PTE, all
is fine.

The code as presented WARNs if we do __set_pte_vaddr() that needs a TLB
invalidate and we have IRQs disabled. And aside from the GHES
trainwreck, the patch as given boots and runs fine on my machine.

And no, if there is a caller that has interrupts disabled and needs TLB
invalidate, the patch still is right. Just means that caller is
terminally broken and needs fixing (like GHES).

There is no way x86 can do what needs done with IRQs disabled.
