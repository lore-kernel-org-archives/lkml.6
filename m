Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E34C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6117620652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6117620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeJBJ7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 05:59:51 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:49728 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbeJBJ7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 05:59:51 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g7BD0-0004xy-Py; Tue, 02 Oct 2018 11:18:50 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g7BCy-0002Hl-QJ; Tue, 02 Oct 2018 11:18:48 +0800
Date:   Tue, 2 Oct 2018 11:18:48 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jason@zx2c4.com, sneves@dei.uc.pt,
        luto@kernel.org, jeanphilippe.aumasson@gmail.com,
        appro@openssl.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org
Subject: Re: [PATCH net-next v6 04/23] zinc: ChaCha20 x86_64 implementation
Message-ID: <20181002031848.lyxrergyyxyc5cwi@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925145622.29959-5-Jason@zx2c4.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> This provides SSSE3, AVX-2, AVX-512F, and AVX-512VL implementations for
> ChaCha20. The AVX-512F implementation is disabled on Skylake, due to
> throttling, and the VL ymm implementation is used instead. These come
> from Andy Polyakov's implementation, with the following modifications
> from Samuel Neves:
> 
>  - Some cosmetic changes, like renaming labels to .Lname, constants,
>    and other Linux conventions.
> 
>  - CPU feature checking is done in C by the glue code, so that has been
>    removed from the assembly.
> 
>  - Eliminate translating certain instructions, such as pshufb, palignr,
>    vprotd, etc, to .byte directives. This is meant for compatibility
>    with ancient toolchains, but presumably it is unnecessary here,
>    since the build system already does checks on what GNU as can
>    assemble.
> 
>  - When aligning the stack, the original code was saving %rsp to %r9.
>    To keep objtool happy, we use instead the DRAP idiom to save %rsp
>    to %r10:
> 
>      leaq    8(%rsp),%r10
>      ... code here ...
>      leaq    -8(%r10),%rsp
> 
>  - The original code assumes the stack comes aligned to 16 bytes. This
>    is not necessarily the case, and to avoid crashes,
>    `andq $-alignment, %rsp` was added in the prolog of a few functions.
> 
>  - The original hardcodes returns as .byte 0xf3,0xc3, aka "rep ret".
>    We replace this by "ret". "rep ret" was meant to help with AMD K8
>    chips, cf. http://repzret.org/p/repzret. It makes no sense to
>    continue to use this kludge for code that won't even run on ancient
>    AMD chips.
> 
> While this is CRYPTOGAMS code, the originating code for this happens to
> be the same as OpenSSL's commit cded951378069a478391843f5f8653c1eb5128da
> 
> Cycle counts on a Core i7 6700HQ using the AVX-2 codepath:
> 
> size    old     new
> ----    ----    ----
> 0       62      52

What is the old column? Is it the existing x86-64 implementation
in the kernel or something else? This needs to be made clear in the
patch description.

The same comment from the previous patch also stands here.  Please
ensure that we only have one copy of chacha x86-64 code in the kernel.
Either replace the existing one right here or in a follow-up patch
in the same series.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
