Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34ECC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF64208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k7fixKtt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF64208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbeK2DnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:43:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54758 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbeK2DnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+RH2erZxXJZ+nQeiepvK06YGU+32pR06pf02XIpuQiM=; b=k7fixKttSnkI8/8VCQmGBCegU
        YX2cfbQaaYqUP/Rtp5wZwYKuZid6NQ7xttPp5g7aS9tArGOtg476KZcicW6N1tROSKPIVsCin4u8O
        VPcFW1wHCOFAW3s7ST+c953fl+4MKw3joc3ZURIaoSaozu3vMzw2duPI9UD5mipKKWTJXL8D5di6J
        FcfjRtHza57Fq6bRhRbkYzGiyA0yME5WNNXUVfiPsp/0wEHwdSlcDjhhspWAEB2fM4d9MK4oINHVp
        5w85LqgYD52e72pCQf09WudoewFeLNmp/UNkp45ZTYBkjGzKOd09E4ZvjpOWileYobqW+pyxYckPb
        uUvtJjQXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gS2tY-0001Hk-To; Wed, 28 Nov 2018 16:41:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CCAAB2029FD58; Wed, 28 Nov 2018 17:40:58 +0100 (CET)
Date:   Wed, 28 Nov 2018 17:40:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, rml@tech9.net,
        Thomas Gleixner <tglx@linutronix.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 2/2] arm64: preempt: Provide our own implementation of
 asm/preempt.h
Message-ID: <20181128164058.GB2131@hirez.programming.kicks-ass.net>
References: <1543347902-21170-1-git-send-email-will.deacon@arm.com>
 <1543347902-21170-3-git-send-email-will.deacon@arm.com>
 <CAKv+Gu9s-=M-mU+249-X1jQ7_Z60vWO1cXK1AP0CwKCmaQQSdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9s-=M-mU+249-X1jQ7_Z60vWO1cXK1AP0CwKCmaQQSdg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 04:35:42PM +0100, Ard Biesheuvel wrote:
> On Tue, 27 Nov 2018 at 20:44, Will Deacon <will.deacon@arm.com> wrote:
> >
> > The asm-generic/preempt.h implementation doesn't make use of the
> > PREEMPT_NEED_RESCHED flag, since this can interact badly with load/store
> > architectures which rely on the preempt_count word being unchanged across
> > an interrupt.
> >
> > However, since we're a 64-bit architecture and the preempt count is
> > only 32 bits wide, we can simply pack it next to the resched flag and
> > load the whole thing in one go, so that a dec-and-test operation doesn't
> > need to load twice.
> >
> 
> Since the actual preempt count is a lot narrower than 32 bits, x86
> just uses bit 31.
> 
> So what is the reason for using two different words?

See commit:

  ba1f14fbe709 ("sched: Remove PREEMPT_NEED_RESCHED from generic code")
