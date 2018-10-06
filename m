Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EF7C00449
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 02:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593D32075C
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 02:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="K3nHiaD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593D32075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbeJFJ7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 05:59:02 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:50073 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbeJFJ7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 05:59:02 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id c9a5bbbc;
        Sat, 6 Oct 2018 02:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=mail; bh=MaRY6xZjgS196G5hsTw0A/I3O
        2Q=; b=K3nHiaD5kAeEQr77LbAPvlEQ4eOc1Yae9n7NXsD1mBYa1z363uw2KgHUs
        CzztvQnpq3v8dE13KBvxlOya/G1hS//qBLLMosLZJBfSZn7Nk3+H7NwqSVE/HtI1
        QTPkVnAcaTdG51vSvNmtn4JqFVilq1efWqUY1oLItTGqXdEjj8z/2xDLqvV6tC4B
        oaBSo272cpWhJezw/pPZUcnAh7ktPx1Sr6aHGrvecHTOLhU77st6eDX/mUkRy1C7
        K70jZlvasJGYU/v/8XnNiZIBCyDJTmraECpm9wb4IjyZXS0iRKHnyVHywp8fnEX4
        tYR7Ouw/JaLLsFRjN1DpvhJn04q6A==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ae8eaee1 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Sat, 6 Oct 2018 02:56:58 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next v7 00/28] WireGuard: Secure Network Tunnel
Date:   Sat,  6 Oct 2018 04:56:41 +0200
Message-Id: <20181006025709.4019-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes v6->v7, along with who suggested it.
--------------------------------------------
  - Account for big-endian 2^26 conversion in Poly1305.
  - Account for big-endian NEON in Curve25519.
  - Fix macros in big-endian AArch64 code so that this will actually run
    there at all.
  - [Ard Biesheuvel] Prefer if (IS_ENABLED(...)) over ifdef mazes when
    possible.
  - [Ard Biesheuvel] Call simd_relax() within any preempt-disabling glue
    code every once in a while so as not to increase latency if folks
    pass in super long buffers.
  - [Andy Polyakov] Prefer compiler-defined architecture macros in
    assembly code, which puts us in closer alignment with upstream
    CRYPTOGAMS code, and is cleaner.
  - [Andrew Lunn] Non-static symbols are prefixed with wg_ to avoid
    polluting the global namespace.
  - [Ard Biesheuvel] Return a bool from simd_relax() indicating whether
    or not we were rescheduled.
  - [Ard Biesheuvel] Reflect the proper simd conditions on arm.
  - [Ard Biesheuvel] Do not reorder lines in Kbuild files for the simd
    asm-generic addition, since we don't want to cause merge conflicts.
  - [Ard Biesheuvel] WARN() if the selftests fail in Zinc, since if this
    is an initcall, it won't block module loading, so we want to be loud.
  - [Ard Biesheuvel] Document some interdependencies beside include
    statements.
  - [Ard Biesheuvel] Remove HAVE_*_ARCH_IMPLEMENTATION in intermediate
    commits.
  - Add missing static statement to fpu init functions.
  - Use union in chacha to access state words as a flat matrix, instead
    of casting a struct to a u8 and hoping all goes well. Then, by passing
    around that array as a struct for as long as possible, we can update
    counter[0] instead of state[12] in the generic blocks, which makes it
    clearer what's happening.
  - [Ard Biesheuvel] Remove __aligned(32) for chacha20_ctx since we no
    longer use vmovdqa on x86, and the other implementations do not require
    that kind of alignment either.
  - Submit patch to ARM tree for adjusting RiscPC's cflags to be -march=armv3
    so that we can build code that uses umull.
  - [Ard Biesheuvel] Allow CONFIG_ARM[64] to imply [!]CONFIG_64BIT, and use
    zinc arch config variables consistently throughout.
  - [Eric Biggers] Document rationale for the 2^26->2^64/32 conversion in
    code comments.
  - [Andrew Lunn] Convert all of remaining BUG_ON to WARN_ON.
  - [Eric Biggers] Include the Z3 proof of 2^26 conversion correctness in
    commit message for curosity of others (https://xn--4db.cc/ltPtHCKN/py).
  - [Ard Biesheuvel] Show importing of Andy Polyakov's code always in a
    separate commit for all architectures.
  - [Herbert Xu] Make more clear what "old" and "new" columns refer to in
    benchmarks.
  - [Ard Biesheuvel] Replace `bxeq lr` with `reteq lr` in ARM assembler to be
    compatible with old ISAs via the macro in <asm/assembler.h>.
  - [Eric Biggers] Account for multiple threads accessing the same tfm in the
    port of the current crypto API to Zinc.
  - [Ard Biesheuvel] Do not allow WireGuard to be a built-in if IPv6 is a
    module.
  - [Ard Biesheuvel] As neat as it is to have `default m`, nothing else in
    drivers/net has that, so we remove it, alas.
  - [Ard Biesheuvel] Writeback the base register and reorder multiplications
    in the NEON x25519 implementation.
  - Try all combinations of different implementations in selftests, so that
    potential bugs are more immediately unearthed.
  - The selftest infrastructure now generally prefers IS_ENABLED(..) over
    ifdefs, since the compiler is more than capable of trimming unused
    functions and static variables.
  - [Sultan Alsawaf] Self tests and SIMD glue code work with #include,
    which lets the compiler optimize these. Previously these files were .h,
    because they were included, but a simple grep of the kernel tree shows
    259 other files that carry out this same pattern. Only they prefer to
    instead name the files with a .c instead of a .h, so we now follow the
    convention.

-----------------------------------------------------------

This patchset is available on git.kernel.org in this branch, where it may be
pulled directly for inclusion into net-next:

  * https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git/log/?h=jd/wireguard

-----------------------------------------------------------

WireGuard is a secure network tunnel written especially for Linux, which
has faced around three years of serious development, deployment, and
scrutiny. It delivers excellent performance and is extremely easy to
use and configure. It has been designed with the primary goal of being
both easy to audit by virtue of being small and highly secure from a
cryptography and systems security perspective. WireGuard is used by some
massive companies pushing enormous amounts of traffic, and likely
already today you've consumed bytes that at some point transited through
a WireGuard tunnel. Even as an out-of-tree module, WireGuard has been
integrated into various userspace tools, Linux distributions, mobile
phones, and data centers. There are ports in several languages to
several operating systems, and even commercial hardware and services
sold integrating WireGuard. It is time, therefore, for WireGuard to be
properly integrated into Linux.

Ample information, including documentation, installation instructions,
and project details, is available at:

  * https://www.wireguard.com/
  * https://www.wireguard.com/papers/wireguard.pdf

As it is currently an out-of-tree module, it lives in its own git repo
and has its own mailing list, and every commit for the module is tested
against every stable kernel since 3.10 on a variety of architectures
using an extensive test suite:

  * https://git.zx2c4.com/WireGuard
    https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/WireGuard.git/
  * https://lists.zx2c4.com/mailman/listinfo/wireguard
  * https://www.wireguard.com/build-status/

The project has been broadly discussed at conferences, and was presented
to the Netdev developers in Seoul last November, where a paper was
released detailing some interesting aspects of the project. Dave asked
me after the talk if I would consider sending in a v1 "sooner rather
than later", hence this patchset. Zinc was presented at Kernel Recipes
in September, and a video is available online. Both Zinc and WireGuard
will be presented at the conference in Vancouver in November.

  * https://www.wireguard.com/presentations/
  * https://www.wireguard.com/papers/wireguard-netdev22.pdf
  * Zinc talk: https://www.youtube.com/watch?v=bFhdln8aJ_U
  * Netdev talk: https://www.youtube.com/watch?v=54orFwtQ1XY

The cryptography in the protocol itself has been formally verified by
several independent academic teams with positive results, and I know of
two additional efforts on their way to further corroborate those
findings. The version 1 protocol is "complete", and so the purpose of
this review is to assess the implementation of the protocol. However, it
still may be of interest to know that the thing you're reviewing uses a
protocol with various nice security properties:

  * https://www.wireguard.com/formal-verification/

This patchset is divided into four segments. The first introduces a very
simple helper for working with the FPU state for the purposes of amortizing
SIMD operations. The second segment is a small collection of cryptographic
primitives, split up into several commits by primitive and by hardware. The
third shows usage of Zinc within the existing crypto API and as a replacement
to the existing crypto API. The last is WireGuard itself, presented as an
unintrusive and self-contained virtual network driver.

It is intended that this entire patch series enter the kernel through
DaveM's net-next tree. Subsequently, WireGuard patches will go through
DaveM's net-next tree, while Zinc patches will go through Greg KH's tree in
cases when an entire development cycle has no relationships with existing code
in crypto/; however, if there are any relationships with code in crypto/, then
pull requests will be sent to Herbert instead in case there are merge
conflicts.

Enjoy,
Jason
