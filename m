Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83D5C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED7D2082D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="m0ywWQcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED7D2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeJ2HVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 03:21:42 -0400
Received: from ozlabs.org ([203.11.71.1]:59991 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbeJ2HVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 03:21:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42jsy17254z9sC2;
        Mon, 29 Oct 2018 09:35:37 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1540766138;
        bh=gLPXTWGzT5eG77Hldsi2LXfEE7CCVWuyMjUbEy8Ioyk=;
        h=Date:From:To:Cc:Subject:From;
        b=m0ywWQcgbzWc5G7X0p+pQg6cJlrJFUJuCyz3qezh/v3QTQvcVNOxyr0ZCPkH7JHEL
         ooZeBzve12JO2I/dg8fSyTBrC2TKHfyUdpSPsIDjIxmywyuWg/fdNU2GWqxq+JwrBI
         jMWwlmVEds4cp7/xWKD54+dTxgQCyND7CcdrczZQs7XIjHmxROtgvNhwhiOL37ym0B
         bEtR64oVXYksHdqexqzDH6BgL8pTuOgMFcTef+9gn580oyulvXPlLXZf5mK5OSlzXG
         Q/Cx6YCVbQPbXIf+DwD7DVxvvoQp80TJM/jnBRCInnZcomCJ6IftxDJGCnnKlcaFvh
         FX+68dlZXjMCg==
Date:   Mon, 29 Oct 2018 09:35:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hangbin Liu <liuhangbin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: linux-next: build failure in Linus' tree
Message-ID: <20181029093532.38a3888e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iHyy82eJ6+rygpE93muF4IO"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iHyy82eJ6+rygpE93muF4IO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

After merging the origin tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

net/bridge/br_multicast.c: In function 'br_multicast_query_received':
net/bridge/br_multicast.c:1432:32: error: 'union <anonymous>' has no member=
 named 'ip6'; did you mean 'ip4'?
       !ipv6_addr_any(&saddr->u.ip6)))
                                ^~~
                                ip4

Caused by commit

  5a2de63fd1a5 ("bridge: do not add port to router list when receives query=
 with source 0.0.0.0")

# CONFIG_IPV6 is not set

I have just reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/iHyy82eJ6+rygpE93muF4IO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvWObQACgkQAVBC80lX
0Gx6hAf/awY7VZlqjz3PKj61F8pi04/HNge7EKzsHPliXrVEqHErqKWNnaZ5V9OM
UGKpYpGn7+/QjJrtRIERTfL9hDowu6P2ZXBN7QGfbPnxfYzjvOpzXw/s4ZxnLZGO
n4texDl55gCvn6QMQS5MEKOHie3Z4rmU4HIEyP0MNQk8LvwiL0DTvRE/WI5i+lz/
OP2024cSO67RPI1xWk2GzGmwcwgdYCbrmP1DMm2kJbd905ll3AKZNc0FBHpyktEE
rPGbmQxCDtQ7yfZUhfkMHR7mBymQEg1hJ/ij9pkdtXWVI2wjuJ1q5AeUBwvkZILw
ykdR/rVXpyN3IC6SZQZIjMHjwv4hdg==
=K7Tx
-----END PGP SIGNATURE-----

--Sig_/iHyy82eJ6+rygpE93muF4IO--
