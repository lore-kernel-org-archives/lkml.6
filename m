Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AA2C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43C62098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Q9d/Pqe+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43C62098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbeIYVEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:04:23 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:58261 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729224AbeIYVEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:04:22 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 038c713d;
        Tue, 25 Sep 2018 14:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=mail; bh=Do2XsmcdeJvk+cT4WYoe7fBlu
        n0=; b=Q9d/Pqe+HwR7GOWLdlTh2+imC9IZyI2dbygvxGxTKTiE0lbpvbwp9LJuJ
        GiSi83CEv4BFLYi0g78OeqbEsrIG55qsA4m10+BapxH4RFLiAZPhQcAoksYt4d2G
        ThJEepeEeKhsEJH7jmSqFpNB4BsrZ5p7d2aja10lfzJhq6asMGeXw7OfYqJbDSxb
        XzR/8GvdbVIghqG3FpONbWvlPt/v6iCVNtOM+yiDo7Sje9EFLz82Sr00SpcPChzt
        7esusRFfk75CrEV3tYIek7lBXQPe5Y2FN++HxS9g9na99+y0ohqqOhEliqCHcYTG
        HuEdi8GImMivFDG48M0IafQbRv+iA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ff4b8060 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 25 Sep 2018 14:38:02 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next v6 00/23] WireGuard: Secure Network Tunnel
Date:   Tue, 25 Sep 2018 16:55:59 +0200
Message-Id: <20180925145622.29959-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes v5->v6, along with who suggested it.
--------------------------------------------
  - [Eric Biggers] Cleaner and more efficient blake2s_final function.
  - [Eric Biggers] Remove modulo trick that was working around a gcc 8.1 bug.
  - [Eric Biggers] Use crypto_xor_cpy to avoid a memmove in chacha20.
  - In the unlikely condition that we transition from SIMD back to scalar
    instructions for Poly1305, it's important that we also convert back
    from base 2^26 to 2^64. This is super rare and weird, and it's hard
    to imagine somebody actually doing this for whatever bad reason, but
    it is a possibility, so we shouldn't calculate things wrong in that
    instance.
  - [Andrew Lunn] Change BUG_ON to WARN_ON in choice places.
  - [Thomas Gleixner] Explicitly dual license files under X where X≠GPL2
    to be under X && GPL2.
  - [Andy Lutomirski] Use separate symbols for selftests that are of
    variable length, so that we neither waste space on disk nor waste space
    in memory (via __initconst).
  - [Thomas Gleixner] Make SPDX headers a standalone comment, and use the
    // commenting style in .h files, per the kernel style guide.
  - [Paul Burton] Allow assembler to fill branch delay slots on MIPS32r2,
    so that the implementation is more future-proof.
  - [Eric Biggers] Use Eric's scalar implementation for ChaCha20 ARM, which
    performs very well for Cortex-A7,5 and ARMv6, while using Andy
    Polyakov's NEON implementation for other ARMv7.
  - [Ard Biesheuvel] Reduce optimization from -O3 to -O2.
  - [Arn?d Bi?e(rgmann|shuvel)] Make sure stack frames stay inside 1024
    bytes on 32-bit and 1280 bytes on 64-bit.
  - [Ard Biesheuvel] CRYPTOGAMS-related commit messages now have the
    corresponding OpenSSL commit written in them.
  - [Eric Biggers] Keep HChaCha20 key in native endian, since in some
    cases it can trivially be passed into the ChaCha20 block later.
  - Make constants follow a consistent naming scheme.
  - Workaround gcc 8 stack mis-optimization on m68k.
  - [Arnd Bergmann] Workaround gcc 8 stack mis-optimization with KASAN.

Many of the above ARM changes are a result of discussions between Ard,
Eric, AndyL, AndyP, Samuel, and me. These discussions are ongoing, and so
it's possible we'll do another revision with further ARM tweaks. But perhaps
this one will be sufficient for merging now, and we can continue to refine
later in the cycle.

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
than later", hence this patchset. A decision is still waiting from the
Linux Plumbers Conference, but an update on these topics may be presented
in Vancouver in a few months. Prior presentations:

  * https://www.wireguard.com/presentations/
  * https://www.wireguard.com/papers/wireguard-netdev22.pdf

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
DaveM's net-next tree, while Zinc patches will go through Greg KH's tree.

Enjoy,
Jason
