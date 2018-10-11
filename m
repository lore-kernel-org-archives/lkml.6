Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E53C4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B0E20659
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vZdmGouN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B0E20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbeJKSMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:12:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48412 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbeJKSMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ntNd9yrDF8Ey2829b2yM8TOv37pgHv9BteT6UXaq7f4=; b=vZdmGouN2rQeOI42JmeOGvMHc
        BjtmxDJ1pA6sYgjWdsQe3BIZNU1mjwuOWScU/PQIMJRL1z6ucbTg32gCDuYsLR/UpeC9zdTbPiboo
        27M9AI4dkphr1SEfkcGVGeADXNCTX5Tew9mLhG3i+N/BItCSZlrRqX+hGEO92JWYqWyBnw/Tiy9m6
        odn0fr+DAsWwBOGryGz739SjQ/HE9o8t/BXXmp3aGhDSaP741s7JEVGv/G1AfmXbkiTf7ivFVXzkF
        2vk0QPynNVh4Rrik0a/i6MtSRJ9US/9VfmsvbFMxL2zj4SPt/PXLG/dD48vsP8rvOpEuLdpAVpNNu
        ZrgTvUkog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAYSs-00034i-4J; Thu, 11 Oct 2018 10:45:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8F65620298568; Thu, 11 Oct 2018 12:45:07 +0200 (CEST)
Message-ID: <20181011103825.023036082@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 11 Oct 2018 12:38:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, edumazet@google.com,
        eric.dumazet@gmail.com, bp@alien8.de, peterz@infradead.org
Subject: [PATCH 0/2] x86/tsc: Fix native_sched_clock()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric reported that native_sched_clock() gets miscompiled; we loose a seqcount
loop. These patches cure that.

After these patches:

native_sched_clock:
	pushq   %rbp    #
	movq    %rsp, %rbp      #,

	... jump label ...

	rdtsc
	salq    $32, %rdx       #, tmp110
	orq     %rax, %rdx      # low, tmp110
	movq    %rdx, %r10      # tmp110, _23
	movq    $cyc2ns, %r9    #, tmp136
.L235:
	movl %gs:cyc2ns+32(%rip),%eax   # cyc2ns.seq.sequence, pfo_ret__
	movl    %eax, %ecx      # pfo_ret__, idx
	andl    $1, %ecx        #, idx
	salq    $4, %rcx        #, tmp116
	addq    %r9, %rcx       # tmp136, tmp117
	movq %gs:8(%rcx),%rdi   # cyc2ns.data[idx_14].cyc2ns_offset, pfo_ret__
	movl %gs:(%rcx),%esi    # cyc2ns.data[idx_14].cyc2ns_mul, pfo_ret__
	movl %gs:4(%rcx),%ecx   # cyc2ns.data[idx_14].cyc2ns_shift, pfo_ret__
	movl %gs:cyc2ns+32(%rip),%r8d   # cyc2ns.seq.sequence, pfo_ret__
	cmpl    %r8d, %eax      # pfo_ret__, pfo_ret__
	jne     .L235   #,
	movl    %esi, %esi      # pfo_ret__, pfo_ret__
	movq    %rsi, %rax      # pfo_ret__, tmp133
	mulq    %r10    # _23
	shrdq   %rdx, %rax      # pfo_ret__,, tmp134
	shrq    %cl, %rdx       # pfo_ret__,
	testb   $64, %cl        #, pfo_ret__
	cmovne  %rdx, %rax      #,, tmp134
	addq    %rdi, %rax      # pfo_ret__, <retval>
	popq    %rbp    #
	ret

