Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BB3C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 23:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2412148E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 23:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="o3lNqPWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfBCXod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 18:44:33 -0500
Received: from ozlabs.org ([203.11.71.1]:59077 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbfBCXod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 18:44:33 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43t6rF46fwz9s4V;
        Mon,  4 Feb 2019 10:44:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549237470;
        bh=jHS+tX2o1CZgn4nODfggUsDgyJ0dK1WtiduVnaqK0Bw=;
        h=Date:From:To:Cc:Subject:From;
        b=o3lNqPWMJLCnB8hCsxs1SKfoBMeiJPKURSz2h4v/mJJiZrLka3xYasH3h1PeQH0aK
         5lODOdEdZH8XIPiJKJdBqmoOoSA2w3aoZa+se2zwa/Tyvad1AF8mw6iZA/5EjwTexJ
         58nf1FCem1rLm4Hi/jtXmh0pyAiiZp2C4l0btEYnnPpGQJ922HS94sd/tmIHVtVX+3
         qskTo72pkrQkUOHoDZo1kA4ydLu5TS08wtQfBjeupHUnyBFtAdvibB4uMM/0nTQMPZ
         xFVrv12fG3WWZTN6R5W0c6MCFAj3Wy3rtWbw9tiNjvdMuewKrEzJiJpjDqtPPz2jcH
         5fSAtT2dWr5PQ==
Date:   Mon, 4 Feb 2019 10:44:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: linux-next: build warning after merge of the net-next tree
Message-ID: <20190204104427.0c0da12d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/C9aL6jcq7mIw1XNb2++WJs3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/C9aL6jcq7mIw1XNb2++WJs3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

net/core/sock.c: In function 'sock_setsockopt':
net/core/sock.c:914:3: warning: this statement may fall through [-Wimplicit=
-fallthrough=3D]
   sock_set_flag(sk, SOCK_TSTAMP_NEW);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
net/core/sock.c:915:2: note: here
  case SO_TIMESTAMPING_OLD:
  ^~~~

Introduced by commit

  9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW")

I get this warning because I am building with -Wimplicit-fallthrough
in attempt to catch new additions early.  The gcc warning can be turned
off by adding a /* fall through */ comment at the point the fall through
happens (assuming that the fall through is intentional).

--=20
Cheers,
Stephen Rothwell

--Sig_/C9aL6jcq7mIw1XNb2++WJs3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxXfNsACgkQAVBC80lX
0Gz0Uwf9FnoKSsHxIa47p9mNaxkWAOdMvaoCj4Ug9JusbzXgaM7Y5WVePkXrrYmx
TOPQila3eDKRURwlfJiZoQVPC9ZqRTuY8+3/EnN+FV+B8i19BN7NESITZoCoTSgm
ACFDqjDCW42YpEJQ/Anv2p0yEbGVc0V681XmKnlhUzShndsuhacKtG70hgUOJano
O2fsmzaX+9ttYGW8vIUbqucrD2M52THSZBWTkmZHz+HkJNOh4+MzBdfGijILxqvO
cAXOGR3O8gfAzsV1tc6f+C2BEz9SXFAgGZhIV3+uSVllpb48yltOuVTP2wF7EGc3
BI9w0nRZWxu92MC3WmfEgTuQzlEmsQ==
=NpVH
-----END PGP SIGNATURE-----

--Sig_/C9aL6jcq7mIw1XNb2++WJs3--
