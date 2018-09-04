Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C051EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFD420652
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X/U/W8+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFD420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeIDL2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:28:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51140 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbeIDL2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=D2aoXR/Ac/hTtrQpFFGMsP7+fceZXwGFVxxEiP4uLh4=; b=X/U/W8+tHOEbygl1nc2Bu1YHf
        8bB88RtAmtaj695vJIodj7ai9TVMQq4bY9FfnseTvvNfR34Fkbb1RVeoggvHIMkt7anybLiMPLI1h
        7UmZfrLBvdJkydDqqAy7hePeL2zrKOWaoDYegCDKkd89JDWHIsr4t1wtlE8SkXwzFxJPGnuRk7/b4
        0UmE4T/Hyol/Hhy6yK5OpXExgTUelYR/J+f1rnW5YIpz57mTmKYWRe3Vc0wenccD7jxaydGK8QbHq
        bb34sMCu1bTcWsFDX2zrprbCBuyLqo4cUALlxsMrv0D+sIHHfjuB+kqwiKd8F2gD2CehFWuchHA1f
        NNM9oiXtQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fx5OU-0001Q1-6y; Tue, 04 Sep 2018 07:04:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B51E52018FA29; Tue,  4 Sep 2018 09:04:55 +0200 (CEST)
Date:   Tue, 4 Sep 2018 09:04:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 3/3] x86/pti/64: Remove the SYSCALL64 entry trampoline
Message-ID: <20180904070455.GX24124@hirez.programming.kicks-ass.net>
References: <cover.1536015544.git.luto@kernel.org>
 <8c7c6e483612c3e4e10ca89495dc160b1aa66878.1536015544.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c7c6e483612c3e4e10ca89495dc160b1aa66878.1536015544.git.luto@kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 03:59:44PM -0700, Andy Lutomirski wrote:
> The SYSCALL64 trampoline has a couple of nice properties:
> 
>  - The usual sequence of SWAPGS followed by two GS-relative accesses to
>    set up RSP is somewhat slow because the GS-relative accesses need
>    to wait for SWAPGS to finish.  The trampoline approach allows
>    RIP-relative accesses to set up RSP, which avoids the stall.
> 
>  - The trampoline avoids any percpu access before CR3 is set up,
>    which means that no percpu memory needs to be mapped in the user
>    page tables.  This prevents using Meltdown to read any percpu memory
>    outside the cpu_entry_area and prevents using timing leaks
>    to directly locate the percpu areas.
> 
> The downsides of using a trampoline may outweigh the upsides, however.
> It adds an extra non-contiguous I$ cache line to system calls, and it
> forces an indirect jump to transfer control back to the normal kernel
> text after CR3 is set up.  The latter is because x86 lacks a 64-bit
> direct jump instruction that could jump from the trampoline to the entry
> text.  With retpolines enabled, the indirect jump is extremely slow.
> 
> This patch changes the code to map the percpu TSS into the user page
> tables to allow the non-trampoline SYSCALL64 path to work under PTI.
> This does not add a new direct information leak, since the TSS is
> readable by Meltdown from the cpu_entry_area alias regardless.  It
> does allow a timing attack to locate the percpu area, but KASLR is
> more or less a lost cause against local attack on CPUs vulnerable to
> Meltdown regardless.  As far as I'm concerned, on current hardware,
> KASLR is only useful to mitigate remote attacks that try to attack
> the kernel without first gaining RCE against a vulnerable user
> process.
> 
> On Skylake, with CONFIG_RETPOLINE=y and KPTI on, this reduces
> syscall overhead from ~237ns to ~228ns.
> 
> There is a possible alternative approach: we could instead move the
> trampoline within 2G of the entry text and make a separate copy for
> each CPU.  Then we could use a direct jump to rejoin the normal
> entry path.

Can we have a few words on why this solution and not this alternative? I
mean, you raise the possibility, but then surely you chose not to
implement that. Might as well share that with us.
