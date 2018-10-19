Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6183EECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115A92083E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Luan0h6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115A92083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbeJSQim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:38:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44786 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeJSQim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o2G6WDZAv/yeYAhsszjv0cpfYRF5jy6YHhhlaNX8luY=; b=Luan0h6MhcNd7IoRoXEVkYEWA
        eRYJxUpf13q2Pn54dL4kPKEkKIlnTWURFh+l2RDQe4vjeHxT8kuym8X5/MOHu93lbHZ7AVRU0eJ4w
        K92jEXsf9p2f1+DfKgUkcoVbXB11BjwuF/ZVKmiG3AyLa3nuF7EyS/EoJC7cKOsTrqPsCyCAQixk8
        3HdCO72J1Vdpdpbw454EsyyiCrU//EMU2V/gf6BNza1sOBr7y7+MkXfY17NZwGtMR4DHgEWgzdkI6
        QMeOiIEWjsreFK7zssoMTtkfAp2G3UMRcGRLRor/3qpK84VCxyZeI43PNvxKpZrYgAKQlHQ1pNxDA
        OfCrCJa0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDQDn-0003i4-0b; Fri, 19 Oct 2018 08:33:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F8972029856B; Fri, 19 Oct 2018 10:33:25 +0200 (CEST)
Date:   Fri, 19 Oct 2018 10:33:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [RFC PATCH 1/5] x86: introduce preemption disable prefix
Message-ID: <20181019083325.GC3121@hirez.programming.kicks-ass.net>
References: <20181018005420.82993-1-namit@vmware.com>
 <20181018005420.82993-2-namit@vmware.com>
 <D247AB7C-2890-49CE-B102-163E5B368FC2@amacapital.net>
 <07255D2B-0243-4254-B62A-37050C44207E@vmware.com>
 <CALCETrXEG8OrMpB3VBS9RF41O_MwtPmXBazkdSGE0ohZmXDcBw@mail.gmail.com>
 <925F22EA-F8CB-4194-B96B-378409ED7918@vmware.com>
 <2626124E-7344-42F3-AD07-0BB34D62A9EE@amacapital.net>
 <6F1FD9DA-5E86-42A2-8EAF-05F5D70FE2EF@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6F1FD9DA-5E86-42A2-8EAF-05F5D70FE2EF@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 01:08:23AM +0000, Nadav Amit wrote:
> Consider for example do_int3(), and see my inlined comments:
> 
> dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
> {
> 	...
> 	ist_enter(regs); 		// => preempt_disable()
> 	cond_local_irq_enable(regs);	// => assume it enables IRQs
> 
> 	...
> 	// resched irq can be delivered here. It will not caused rescheduling
> 	// since preemption is disabled
> 
> 	cond_local_irq_disable(regs);	// => assume it disables IRQs
> 	ist_exit(regs);			// => preempt_enable_no_resched()
> }
> 
> At this point resched will not happen for unbounded length of time (unless
> there is another point when exiting the trap handler that checks if
> preemption should take place).
> 
> Another example is __BPF_PROG_RUN_ARRAY(), which also uses
> preempt_enable_no_resched().
> 
> Am I missing something?

Would not the interrupt return then check for TIF_NEED_RESCHED and call
schedule() ?

I think (and this certainly wants a comment) is that the ist_exit()
thing hard relies on the interrupt-return path doing the reschedule.
