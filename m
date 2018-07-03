Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BDFC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F2E24D63
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hd5R6ie6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F2E24D63
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932910AbeGCIPj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:15:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753560AbeGCIPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZrYoh/t/fLnf5vc0rVVajIBxjuDvZDIvPUWILNmluxs=; b=hd5R6ie65m1//9JGU7bo1R8hR
        AX4x563kgxD7Ipq34WRyZLOwxNMN66ipPsrxq7xPdq1IkIJ04h/Z8mIVVJ/lSeY7EI1/Q48blvhK9
        9T0VXmNCHUNbLJ7ULCsFa1kTnK4pAA801GqSds9Z8Wo1UYKx3t2QcjiSXZNCp51km38UYTgNpf8HH
        KCmm574Vsfu23TDwIS4M74DoWOa2x9VFIrT/Jo3vIVLfNM4OKP4/qndX/7BXIG/iNj97CWy8fe4gF
        LwgaMJquEcboVNMYer1RcZeNpfDe1LXmUHXJup6+WJ+M74CBM33VcfNtY+Iery/E8WlZRraUWE/os
        fBxWDM7dQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faGSa-000844-1l; Tue, 03 Jul 2018 08:14:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A21212028932F; Tue,  3 Jul 2018 10:14:49 +0200 (CEST)
Date:   Tue, 3 Jul 2018 10:14:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>, michal.simek@xilinx.com
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields,
 validate user inputs
Message-ID: <20180703081449.GT2494@hirez.programming.kicks-ass.net>
References: <20180702223143.4663-1-mathieu.desnoyers@efficios.com>
 <CA+55aFzZYOatOtjrm7fD7878_SzCAmEoEu74n0+pgd7faH-sTQ@mail.gmail.com>
 <825871008.10839.1530573419561.JavaMail.zimbra@efficios.com>
 <1959930320.10843.1530573742647.JavaMail.zimbra@efficios.com>
 <8B2E4CEB-3080-4602-8B62-774E400892EB@amacapital.net>
 <459661281.10865.1530580742205.JavaMail.zimbra@efficios.com>
 <858886246.10882.1530583291379.JavaMail.zimbra@efficios.com>
 <CA+55aFxWMjwx-4TGBHt0H6bh6FXC3NKMsjp=eKGw5cgA4wMBUA@mail.gmail.com>
 <1776351430.10902.1530585009519.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1776351430.10902.1530585009519.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 10:30:09PM -0400, Mathieu Desnoyers wrote:
> > Use "get_user()". It works for 64-bit objects too, and it will be
> > atomic in the 32-bit sub-parts on a 32-bit architecture.
> 
> Is it really ? Last time we had this discussion, not all architectures
> guaranteed that reading a 64-bit integer would happen in two atomic
> 32-bit sub-parts. This was the main motivation for the LINUX_FIELD_u32_u64()
> macro as it stands today (rather than using a union).

Just state, as a requirement for supporting rseq, that the arch
{get,put}_user(u64) on 32bit targets must be exactly 2 u32 loads/stores.

We're piece-wise enabling rseq across architectures anyway, and when the
relevant maintains do this, they can have a look at their
{get,put}_user() implementations and fix them.

If you rely on get_user(u64) working, that means microblaze is already
broken, but I suppose it already was, since their rseq enablement patch
is extremely dodgy. Michal?
