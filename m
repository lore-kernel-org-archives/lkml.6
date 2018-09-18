Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818E4ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14BF52086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lauizwT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BF52086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbeIRVuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:50:23 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:57805 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728065AbeIRVuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:50:23 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id adc64ed9;
        Tue, 18 Sep 2018 15:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=mail; bh=otEXAi8i8SNmUs1pvx/0JJOzL
        58=; b=lauizwT7W7K9M6QFTl5aIIaKKSbJPnFLUci0VoB8OhaVdWY0HrwxZ5PjS
        lwCdqQKJ6Pu7ruK7hfjMa3emuge/iVVnTkEB2gDz9ZrDJH/czZPerYQJspL9Ooer
        kIlhHzEuu9fcdC6JRxNN4/xUbJs2TWdz1eStiuZNHhDwmqV2RMylWDutlltxlN73
        dm82m9KbKFdLVmMulzDyOVlSB2V5cQQ8lRm7Dz7NrzAtPkcBMEtO/nxA/o9qkWH+
        /FUFzVrqqI+ZxLuSb8GWaNHzSRubNpSeOkdNZeozODxcXpofspIXKRCA4MWjXF7A
        SXieI8WBXhY6DrqzEjvP4zPq2J5yQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 89be886a (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 18 Sep 2018 15:59:27 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next v5 00/20] WireGuard: Secure Network Tunnel
Date:   Tue, 18 Sep 2018 18:16:26 +0200
Message-Id: <20180918161646.19105-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5 has the most comprehensive set of changes yet, and I think should
finally address all of the relevant issues brought up on the mailing
list. In particular, this feedback has come from:

  - Andy Lutomirski
  - Eric Biggers
  - Ard Biesheuvel
  - Kevin Easton
  - Andrew Lunn
  - Martin Willi

Changes v4->v5:
---------------
  - Use fewer inlines, except when measured as necessary.
  - Reduce size of scattergather array to fit within stack on
    small systems.
  - Account for larger stack frames with KASAN.
  - The x86_64 implementations are selected according to input length.
  - Avoid using simd for small blocks on x86_64.
  - The simd_get/put API is now pass by reference, so that the user
    can lazily use the context based on whether or not it's needed.
    See the description again in the first commit for this.
  - Add cycle counts for different sizes for x86_64 commit messages.
  - Relax simd during chapoly sg loop.
  - Replace -include with #if defined(...)
  - Saner and simpler Kconfig.
  - Split into separate modules instead of one monolithic zinc.
  - The combination of these three last items means that there no
    longer are any conditionals in our Makefile.
  - Martin showed a performance regression using tcrypt in v4. This
    has been triaged and fixed, and now the Zinc code runs faster
    than the previous code.
  - While I initially wasn't going to do this for the initial
    patchset, it was just so simple to do: now there's a nosimd
    module parameter that can be used to disable simd instructions
    for debugging and testing, or on weird systems.

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
