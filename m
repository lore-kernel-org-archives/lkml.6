Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6890AFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3D820671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XX+MEKuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3D820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeINVgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:36:01 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:51553 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbeINVgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:36:01 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 0b5ec985;
        Fri, 14 Sep 2018 16:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=mail; bh=2BM4AahMtlNuHnmkXOxU0Sr3/
        kY=; b=XX+MEKuokFjPiwSEpkKDc7cyx3Xq1XvhF0HHzBju35gsrcrO9DPs1Nocb
        0BYorMhI6qypmp9LpCFnOv4h9KTK4f14pmMRfzTD2CpCWSfkE+XqfNZ/PVSZ+dEs
        83lpQGkt8i3ijCnSTT19jwV0Py6vk5fCkoqlACn71BgFXeoX2Kbwlx9x5RTZ052l
        y2GegsO/ddhvTlNzvBe3d7CYZxsAAYMvBevWZNNBJPqhAQR5zORj7QUo39Naztwa
        H/GxG/5Wn+ZUkvjiyEIXPws9/Gg4V8R3tkGzWXOqFb9LPI0cft8/S9AxkwDWsfhw
        LebrpjHKFki7qcVEA/5zQ/uofvaYQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f615f54a (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 14 Sep 2018 16:03:43 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next v4 00/20] WireGuard: Secure Network Tunnel
Date:   Fri, 14 Sep 2018 18:19:34 +0200
Message-Id: <20180914161954.7325-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes v3->v4:
  - Remove mistaken double 07/17 patch.
  - Fix whitespace issues in blake2s assembly.
  - It's not possible to put compound literals into __initconst, so
    we now instead just use boring fixed size struct members.
  - Move away from makefile ifdef maze and instead prefer kconfig values,
    which also makes the design a bit more modular too, which could help
    in the future.
  - Port old crypto API implementations (ChaCha20 and Poly1305) to Zinc.
  - Port security/keys/big_key to Zinc as second example of a good usage of
    Zinc.
  - Document precisely what is different between the kernel code and
    CRYPTOGAMS code when the CRYPTOGAMS code is used.
  - Move changelog to top of 00/20 message so that people can
    actually find it.

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
