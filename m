Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F329C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51AAD20865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HZj7dR/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51AAD20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390157AbeKVT6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:58:06 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36854 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390125AbeKVT6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1Gxs3rKiQIBvv2Qkjj5RD9D8Gl7V3TppblkvZgrFFuw=; b=HZj7dR/xz9pW9AJb+jnnQllSH
        nOOHTA0wFfTEBrAUEKugPCWKzjugNZBkVUCiIJBeiyLBZVpM1/nzTXBhxm5ohn8aY7xJT10ZlyMfz
        vVgHchRKZ+3mNJQy3USlw+LFaM1BHOmiRlOrL/Vs8a54PhhdGHQ4NYtDYwxBudp2nV5TR+yWwYQp0
        1EyVliHnJyspaqoaQMUma5Cf9rnG8I2Ll1NaMNcHpbJlxBV5lDhyR2+IPZNu79Y1jBRHQuag6IWmu
        mR/AX0FBCEPBHp2rpS71AhJJYNoIkBO9Wxn/dDGtnXCtGhOIxWRMHhwQdbdeNfMp+K3qfB2rffkVP
        1G6OnK2cA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPl8a-0008ER-DP; Thu, 22 Nov 2018 09:19:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 850552029FD58; Thu, 22 Nov 2018 10:18:58 +0100 (CET)
Date:   Thu, 22 Nov 2018 10:18:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 15/24] x86/speculation: Add command line control for
 indirect branch speculation
Message-ID: <20181122091858.GJ2131@hirez.programming.kicks-ass.net>
References: <20181121201430.559770965@linutronix.de>
 <20181121201723.764150349@linutronix.de>
 <20181121234312.GI27559@zn.tnic>
 <alpine.DEB.2.21.1811220048080.1665@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1811220048080.1665@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 09:14:47AM +0100, Thomas Gleixner wrote:
> On Thu, 22 Nov 2018, Borislav Petkov wrote:
> > > +
> > > +	/* Initialize Indirect Branch Prediction Barrier */
> > > +	if (boot_cpu_has(X86_FEATURE_IBPB)) {
> > > +		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
> > > +		pr_info("Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier\n");
> > > +	}
> > 
> > So AFAICT, if coming in here with AUTO, we won't enable IBPB and I
> > *think* AMD wants IBPB enabled. At least the whitepaper says:
> > 
> > "IBPB combined with Reptoline software support is the AMD recommended
> > setting for Linux mitigation of Google Project Zero Variant 2
> > (Spectre)."
> 
> Ok. That's indeed a step backwards, because we don't do IBPB in KVM
> anymore. I'll fix that tomorrow morning when brain is more awake.
> 
> IBPB on context switch is controlled separately anyway now, so that's a
> nobrainer to sort out.
> 
> Though I wait for Toms answer whether we really want IBPB on context switch
> for AMD by default.

Right; that retpoline + IBPB case is one that came up earlier when we
talked about this stuff. The IBPB also helps against app2app BTB ASLR
attacks. So even if you have userspace retpoline, you might still want
IBPB.

But yes, this should be relatively straight forward to allow/fix with
the proposed code.
