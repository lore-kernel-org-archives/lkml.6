Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350D4C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE009206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o9nd7nhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE009206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbeJEU5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:57:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38472 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbeJEU5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=icoPfttjeff5yY2o/Haqd75W+rJ7k66AdEgbHZsvZdQ=; b=o9nd7nhh2WiVbQs1DdQiuYphs
        seUdvLWCxp4QN3r6XTlPbH0TjUKivXKBEUMzDpwh/YP5vR42vfXOs3h1R6wQ1jtnbtNAgx7OkQMa7
        GOHyGIdJ82TTwSAlMhLjzS9lLT3uJ2kDTQQvYsAf/1XBRYK6AakQt2f6AmnIuA/M0nCkjFXshEJcC
        xZYvI5Gi8JZ6zug3fkgvbZIwSfTsbQn8Lb6O7VA8ksT/5hUuoMbrt3Qe6BhrGLYCs3HdhwYwgQx2v
        dZD4beQj8LOKRgzhaxS/Tff68AGvofZjxmEZoFdmuWX+uxXnebDdwCh3g7wdn/JNi7mwh5frOfRXC
        JhOY3goog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g8Qbi-0005pU-Pi; Fri, 05 Oct 2018 13:57:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5078A202631DA; Fri,  5 Oct 2018 15:57:28 +0200 (CEST)
Date:   Fri, 5 Oct 2018 15:57:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 1/9] kernel: add support for patchable function
 pointers
Message-ID: <20181005135728.GR19272@hirez.programming.kicks-ass.net>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005081333.15018-2-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005081333.15018-2-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 10:13:25AM +0200, Ard Biesheuvel wrote:
> Add a function pointer abstraction that can be implemented by the arch
> in a manner that avoids the downsides of function pointers, i.e., the
> fact that they are typically located in a writable data section, and
> their vulnerability to Spectre like defects.
> 
> The FFP (or fast function pointer) is callable as a function, since
> the generic incarnation is simply that. However, due to the fact that
> C does not distinguish between functions and function pointers at the
> call site, the architecture can instead emit it as a patchable sequence
> of instructions consisting of ordinary branches.

This is basically a static_key, except for indirection function calls?
So why not call the thing static_func or static_call or something like
that?
