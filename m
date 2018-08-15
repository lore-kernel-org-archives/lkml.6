Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A3CC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7FD2152C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWerUz8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7FD2152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbeHOWvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:51:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbeHOWvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:51:10 -0400
Received: from gmail.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 347572150A;
        Wed, 15 Aug 2018 19:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534363056;
        bh=oyGw7qkIYky+8mNnTGjsA2a1ydvnVbvy2xchP9Cm2wc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IWerUz8iIQ/FDt7GQIP8Eovte69L/7NVuolkEpTx3UW3im6SDv3ic8tALCHX7URle
         k9EpmCc1YvU/laq4zVrR0UFiZV8UDuN80V9KJ9cvoTtCe9N6DFCMyi5rfwRjYC0roI
         ZLCgT9QhEY+YHOf5wMSJ8VUpVc05kVKFJCgZy0Yg=
Date:   Wed, 15 Aug 2018 12:57:33 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "D. J. Bernstein" <djb@cr.yp.to>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers3@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Tanja Lange <tanja@hyperelliptic.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Karthikeyan Bhargavan <karthik.bhargavan@gmail.com>
Subject: Re: [PATCH v1 2/3] zinc: Introduce minimal cryptography library
Message-ID: <20180815195732.GA79500@gmail.com>
References: <20180801072246.GA15677@sol.localdomain>
 <CAHmME9pbwj0RaX4YM9epGOSgDRNUt=GA4UzO_iKcW=Md7kG6JQ@mail.gmail.com>
 <20180814211229.GB24575@gmail.com>
 <20180815162819.22765.qmail@cr.yp.to>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815162819.22765.qmail@cr.yp.to>
User-Agent: Mutt/1.10.1+60 (20b17ca5) (2018-08-02)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 04:28:19PM -0000, D. J. Bernstein wrote:
> Eric Biggers writes:
> > I've also written a scalar ChaCha20 implementation (no NEON instructions!) that
> > is 12.2 cpb on one block at a time on Cortex-A7, taking advantage of the free
> > rotates; that would be useful for the single permutation used to compute
> > XChaCha's subkey, and also for the ends of messages.
> 
> This is also how ends of messages are handled in the 2012 implementation
> crypto_stream/salsa20/armneon6 (see "mainloop1") inside the SUPERCOP
> benchmarking framework:
> 
>    https://bench.cr.yp.to/supercop.html
> 
> This code is marginally different from Eric's new code because the
> occasional loads and stores are scheduled for the Cortex-A8 rather than
> the Cortex-A7, and because it's Salsa20 rather than ChaCha20.
> 
> The bigger picture is that there are 63 implementations of Salsa20 and
> ChaCha20 in SUPERCOP from 10 authors showing various implementation
> techniques, including all the techniques that have been mentioned in
> this thread; and centralized benchmarks on (e.g.)
> 
>    https://bench.cr.yp.to/results-stream.html#amd64-kizomba
>    https://bench.cr.yp.to/web-impl/amd64-kizomba-crypto_stream-salsa20.html
> 
> showing what's fastest on various platforms, using well-developed
> benchmarking tools that produce repeatable, meaningful measurements.
> There are also various papers explaining the main techniques.
> 
> Of course it's possible that new code will do better, especially on
> platforms with different performance characteristics from the platforms
> previously targeted. Contributing new implementations to SUPERCOP is
> easy---which is why SUPERCOP already has thousands of implementations of
> hundreds of cryptographic functions---and is a more effective way to
> advertise speedups than adding code merely to (e.g.) the Linux kernel.
> Infrastructure is centralized in SUPERCOP to minimize per-implementation
> work. There's no risk of being rejected on the basis of cryptographic
> concerns (MD5, Speck, and RSA-512 are included in the benchmarks) or
> code-style concerns. Users can then decide which implementations best
> meet their requirements.
> 
> "Do better" seems to be what's happened for the Cortex-A7. The best
> SUPERCOP speeds (from code targeting the Cortex-A8 etc.) are 13.42
> cycles/byte for 4096 bytes for ChaCha20; 12.2, 11.9, and 11.3 sound
> noticeably better. The Cortex-A7 is an interesting case because it's
> simultaneously (1) widely deployed---more than a billion units sold---
> but (2) poorly documented. If you want to know, e.g., which instructions
> can dual-issue with loads/FPU moves/..., then you won't be able to find
> anything from ARM giving the answer. I've started building an automated
> tool to compute the full CPU pipeline structure from benchmarks, but
> this isn't ready yet.
> 

Hi Dan, are you saying I should contribute my scalar ChaCha implementation,
and/or the Linux kernel's ChaCha NEON implementation, to SUPERCOP?  Just a few
comments: there doesn't appear to be an official git repository for SUPERCOP,
nor is there any mention of how to send patches, nor is there any COPYING or
LICENSE file, nor even a README file.  So, while I'm interested, from my
perspective SUPERCOP doesn't seem friendly to contributions.  You'd probably
attract more contributors if you followed established open source conventions.

Another issue is that the ChaCha code in SUPERCOP is duplicated for each number
of rounds: 8, 12, and 20.  So if anyone adds a new ChaCha implementation, they'd
apparently have to add 3 copies of it, which isn't very maintainable.

There are actually only two ARM NEON implementations of ChaCha20 in SUPERCOP:
(1) the one in crypto_stream/chacha20/moon/neon/32/chacha.S which looks like an
'objdump' output as it has no comments or anything that would make it readable
like macros and register aliases; and (2) the one in
crypto_stream/chacha20/dolbeau/arm-neon/, which uses a method similar to the
Linux implementation but it uses GCC intrinsics, so its performance will heavily
depend on how the compiler assigns and spills registers, which can vary greatly
depending on the compiler version and options.

I understand that Salsa20 is similar to ChaCha, and that ideas from Salsa20
implementations often apply to ChaCha too.  But it's not always obvious what
carries over and what doesn't; the rotation amounts can matter a lot, for
example, as different rotations can be implemented in different ways.  Nor is it
always obvious which ideas from SSE2 or AVX2 implementations (for example) carry
over to NEON implementations, as these instruction sets are different enough
that each has its own unique quirks and optimizations.

Previously I also found that OpenSSL's ARM NEON implementation of Poly1305 is
much faster than the implementations in SUPERCOP, as well as more
understandable.  (I don't know the 'qhasm' language, for example.)  So from my
perspective, I've had more luck with OpenSSL than SUPERCOP when looking for fast
implementations of crypto algorithms.  Have you considered adding the OpenSSL
implementations to SUPERCOP?

In the end though, both Linux and OpenSSL don't need every implementation under
the sun, but rather a small number of implementations that provide "good"
performance on nearly all CPUs, while not necessarily being optimal on every CPU
out there.  I.e., some tradeoffs are necessary and acceptable.  So for
ChaCha{12,20} on ARM we should choose which 2-3 implementations are most
valuable to have and make them as generally well optimized as possible.  Based
on the research I've seen and done, I think they're likely to be:

	- a 1x_scalar implementation
	- a 3x_NEON+1x_scalar implementation like OpenSSL's
	- a 4x_NEON implementation like Linux's current one

Currently my main argument is just that having the 3x_NEON+1x_scalar method be
the only NEON implementation is probably insufficient, as there are important
CPUs where the 4x_NEON method is significantly faster.

Thanks,

Eric
