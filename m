Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DEDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 01:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8852084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 01:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="keqihky/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbeLQBgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 20:36:49 -0500
Received: from ozlabs.org ([203.11.71.1]:56907 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730788AbeLQBgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 20:36:49 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43J3fQ2xwhz9s2P;
        Mon, 17 Dec 2018 12:36:45 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545010606;
        bh=PkWyKHeNqGBFYDMk/F6OEWelyFgWRENtF/W5ngYGAkU=;
        h=Date:From:To:Cc:Subject:From;
        b=keqihky/EndE/Kjo9Oy0A1/IicrdChrwzWB2Mm3yEp7FO+DOZOWQppIQTp/D4lger
         FLl9lKOQ156kERkMxQCS8w9qjeFf7YLPGCc76BztiXxrkiMS0C1als5KLT4w/GVKag
         aBdHhAAPpvoDWTmSGVDqRXf20RZq8bhYMJ2pShb/Zv3upeo9aH9HbRWWd7lW5w4N+D
         lzpX0Fhvr8ovPqxhO7sKjM0PshdnJ+v288s9GpwZLuWX4qnSv0qrFj6PZoxIhWc4Jg
         SaYGwhs8SbtTP3oFoe8zmJ3hRWTqGt6CqROw38TkGPNdnYtbKQpp68U57P8vYFfYd0
         8dGtSEj9QnfbQ==
Date:   Mon, 17 Dec 2018 12:36:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: linux-next: build failure after merge of the net-next tree
Message-ID: <20181217123645.42a20fe5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/s=EaVckg9P7Zmf7rCq4zdV0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/s=EaVckg9P7Zmf7rCq4zdV0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

In file included from net/core/dev.c:148:
net/core/dev.c: In function 'napi_gro_complete':
net/core/dev.c:5364:26: error: 'inet_gro_complete' undeclared (first use in=
 this function); did you mean 'eth_gro_complete'?
       ipv6_gro_complete, inet_gro_complete,
                          ^~~~~~~~~~~~~~~~~
include/linux/indirect_call_wrapper.h:32:41: note: in definition of macro '=
INDIRECT_CALL_2'
 #define INDIRECT_CALL_2(f, name, ...) f(__VA_ARGS__)
                                         ^~~~~~~~~~~

and on ....

Caused by commit

  aaa5d90b395a ("net: use indirect call wrappers at GRO network layer")

inet_gro_complete() is declared in include/net/inet_comon.h which is
not directly included in net/core/dev.c.

I have used the net-next tree from next-20181214 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/s=EaVckg9P7Zmf7rCq4zdV0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwW/a0ACgkQAVBC80lX
0Gw64Af9HyQT8f8aIe1lmDy05kk3qwbejdAIXwmJh1Xw173EzceuvagX7OuXnYqX
6b8hXsf4h9ldDl/doUnicY4YTZZHiwak/NEE8rVmEhTU+PfnZ1qsQ3wP5XqT20I0
1PWHwEusWInGrzebADxrjexZwXn0H2FVv3DTTHd0zcV8auIZTJAWPuNrMeUzSKeT
76umWywR7dE7AeBUWUQtThLvf5VmDokcNWFDk/ShKP3h3Hj4+G3XiRNUMGgl6bbK
cRMcZeQ/15kLHdf0CxN3vPv6H1K7QBZEm0bxManwKkcbNhS98bu2ApZ9/UVu3jg8
GMlQgywVAQC+dL3YUmq86jMc+RFIXA==
=LG2H
-----END PGP SIGNATURE-----

--Sig_/s=EaVckg9P7Zmf7rCq4zdV0--
