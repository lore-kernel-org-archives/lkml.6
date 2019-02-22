Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D691C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 01:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DF82080F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 01:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dcCcUy2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfBVBGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 20:06:49 -0500
Received: from ozlabs.org ([203.11.71.1]:34309 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfBVBGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 20:06:48 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 445Cps3DCCz9s9L;
        Fri, 22 Feb 2019 12:06:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550797605;
        bh=vCSvujgSHfKu+OxFIUjY5gdl69y9D/pw3sn/i/QJTZY=;
        h=Date:From:To:Cc:Subject:From;
        b=dcCcUy2fB7hDgw4H3UXtGqpdjuJnEElAtSS0OsVJPgBaXZd6SUzAgjBrrJ0sATWC7
         +1fQHDc4n53U/4t3Pmo32+TwpVB6FeOjAvz4dttak60c9cWb389yysOU8Aqc3KRPZh
         CBYSxPxxGyYt78ZarXC/oXu8PvYKm2oyCSNpUDW7T/5v2sJz37/u2gdsEnR3omaROq
         6x1h3yL9S/g2YmloJvY62e3vPNnr0ifCMkLYoPR5Jy/tyvOk4rxlz7WQVwrlMa0qMH
         4G6GuRadLGzBEoNP8i2lRJPw/LdRCDnAXC4kVTkFrawbbKOfLANJFfMKQQrYjhZq8n
         7D9uqVViO4Ffw==
Date:   Fri, 22 Feb 2019 12:06:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: linux-next: build warning after merge of the net-next tree
Message-ID: <20190222120644.0bdc4da8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iD/TIP7C/mu/zcBX8zXSOhU"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iD/TIP7C/mu/zcBX8zXSOhU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/net/ethernet/rocker/rocker_main.c: In function 'rocker_port_attr_se=
t':
drivers/net/ethernet/rocker/rocker_main.c:2083:9: warning: this statement m=
ay fall through [-Wimplicit-fallthrough=3D]
   err =3D rocker_world_port_attr_pre_bridge_flags_set(rocker_port,
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              attr->u.brport_flags,
              ~~~~~~~~~~~~~~~~~~~~~
              trans);
              ~~~~~~
drivers/net/ethernet/rocker/rocker_main.c:2086:2: note: here
  case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
  ^~~~

Introduced by commit

  93700458ff63 ("rocker: Check Handle PORT_PRE_BRIDGE_FLAGS")

I get this warning because I am building with -Wimplicit-fallthrough
in attempt to catch new additions early.  The gcc warning can be turned
off by adding a /* fall through */ comment at the point the fall through
happens (assuming that the fall through is intentional).

--=20
Cheers,
Stephen Rothwell

--Sig_/iD/TIP7C/mu/zcBX8zXSOhU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxvSyQACgkQAVBC80lX
0Gyyhwf/ThDtCpjEQD7WOsLHSwnY+L3DGVPLmqquMJpFN9NaTU98Y2OHfTsQw8Y4
NouV/6S7gVSublUPU29TDMKzmHqX1hRULVjmulL2Z1KJRMvCD5A12DFqijJBmc+L
KsuK4OUDbooA0vRf3vFM+1OabO8e48+/cqbvWPeD1P4arpELGf4keWpyGw6IEKRC
/SAz8EnOp4lNdkxuB3FQB1yjanA/7cvHe+CS61MWvzEx/K70kcK3yOaeCsSlnlCz
LITfZk4nwFpOiqPj10yE9MkZFvosaKO6QV0ZAL3A0plvyqmUg7Exvea+OHxt5mlN
aNXuqs88S19pkIAeijqvETy44qm/iw==
=yTtA
-----END PGP SIGNATURE-----

--Sig_/iD/TIP7C/mu/zcBX8zXSOhU--
