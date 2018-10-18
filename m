Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98257C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1F92098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bXhxNWgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1F92098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeJRW65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 18:58:57 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:46347 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbeJRW65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 18:58:57 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 22d6653d;
        Thu, 18 Oct 2018 14:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=mail; bh=sbzpnrsLr6BDTQn0FnaV6LGTh
        Qk=; b=bXhxNWgpMWFqDEdiWXXYdHFpxj5jwZc8BQrdCu7huFwEqifePHbaZA00o
        hIYcskpPh1S5hVxqg3j3FwB9TimJgMdcv28i/tByoNIktuVMhatEQ+XWjKBIuJJI
        f94x+s7XZY/bl6GEwDBBEE//CX7P13nDNmPW8jnCZjdnGh78iPm+ibj9SrkJwnn/
        S9qJe8vep3nFjYFMhuYDEHvFpros7no4oGg5S0T0QO9UcXbXM8Lltx5/YigRrWVd
        7VlsS4cUllj/oXgzEFHtk8OjKYIi74FRWWnirqHIpFBbKRugd1Mf06GKpiovIIHK
        Z/41y1RwxdupCGVwnl8tZTijFYf/g==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 068d587a (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Thu, 18 Oct 2018 14:55:31 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next v8 00/28] WireGuard: Secure Network Tunnel
Date:   Thu, 18 Oct 2018 16:56:44 +0200
Message-Id: <20181018145712.7538-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes v7->v8, along with who suggested it.
--------------------------------------------
- Implementations that fail the selftests are now disabled, after a warning
  is printed. This way users don't make wrong calculations, even in the face
  of a rather grave bug.
- [Sultan Alsawaf] When assigning to a boolean, prefer "BIT(i) & a" to "(a >>
  i) & 1".
- [Andrew Lunn] Avoid control statements inside macros.
- [Jiri Pirko] Prefix functions used in callbacks with wg_.
- [Jiri Pirko] Rename struct wireguard_peer and struct wireguard_device to
  struct wg_peer and struct wg_device.
- [Eugene Syromiatnikov] Do not use nla type field as an index, and actually
  don't use an index at all, because it has no meaning or relevance at all.
- [Joe Perches] Do not place a space between for_each iterators and
  parentheses.
- Enumerable style cleanups and nits.
- [Arnd Bergmann] Swap endianness in allowedips early on in case optimizer is
  able to look a bit further in but not too far, resulting in a warning from
  -Wmaybe-uninitialized.
- [Jiri Pirko] Use textual error labels instead of numerical ones.
- [Jiri Pirko] Better module description string.
- [Eric Biggers] In poly1305 port to crypto API, account for short inputs in
  final function, in which case -ENOKEY should be returned.

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
