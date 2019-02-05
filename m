Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20F8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD44E20815
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HPUpUChr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfBEDWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 22:22:21 -0500
Received: from ozlabs.org ([203.11.71.1]:56709 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfBEDWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 22:22:20 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43tqd60kbvz9sN9;
        Tue,  5 Feb 2019 14:22:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549336938;
        bh=vBron79rAxPWKeIoKOGQ7wFCFfAj5Ak9e37x+TzI8js=;
        h=Date:From:To:Cc:Subject:From;
        b=HPUpUChrjVUOljQP2ARWpYRaO4SVQUBx+WIOV1e/vIyS6PKJobTYGmmT5ENcUbFsG
         0XpW0umHkPDEDLhBGPdYZYghSlNP1JR+5bXGaG1XaEVIbVzGxZZYn2Pmsgi3FXZphp
         kQl74KSEhQ3r6qn0hb/YRaVRHFgwl3+QieySsVnNyPqcEs1cTuCzBs+Vnl51SNdHsa
         PnGo6YK1UWI6WmhUCKid0NZI/mjoSfRfNkFo+S9XZvUcY0BLubh3+/DkR60eF5RtbM
         BIa0mEJx+Wgop2ZbsKS2GxXsN/YVWqbejuvT0Lyy66ygTcJEWtcJGEJax4SBsJApW7
         whyNO2tpMxtGg==
Date:   Tue, 5 Feb 2019 14:22:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: linux-next: build warnings after merge of the staging tree
Message-ID: <20190205142217.0c9ecabf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EQ1.i=fuU3alADHDwrjr6wj"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EQ1.i=fuU3alADHDwrjr6wj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

After merging the staging tree, today's linux-next build (x86_64
allmodconfig) produced these warnings:

drivers/iio/chemical/sps30.c: In function 'sps30_read_raw':
drivers/iio/chemical/sps30.c:289:4: warning: this statement may fall throug=
h [-Wimplicit-fallthrough=3D]
    switch (chan->channel2) {
    ^~~~~~
drivers/iio/chemical/sps30.c:299:3: note: here
   default:
   ^~~~~~~
drivers/iio/chemical/sps30.c: In function 'sps30_do_cmd':
drivers/iio/chemical/sps30.c:120:10: warning: this statement may fall throu=
gh [-Wimplicit-fallthrough=3D]
   buf[1] =3D (u8)SPS30_AUTO_CLEANING_PERIOD;
          ^
drivers/iio/chemical/sps30.c:121:2: note: here
  case SPS30_READ_DATA_READY_FLAG:
  ^~~~

Introduced by commits

  232e0f6ddeae ("iio: chemical: add support for Sensirion SPS30 sensor")
  62129a0849d2 ("iio: chemical: sps30: allow changing self cleaning period")

I get this warning because I am building with -Wimplicit-fallthrough
in attempt to catch new additions early.  The gcc warning can be turned
off by adding a /* fall through */ comment at the point the fall through
happens (assuming that the fall through is intentional).

--=20
Cheers,
Stephen Rothwell

--Sig_/EQ1.i=fuU3alADHDwrjr6wj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxZAWkACgkQAVBC80lX
0GxotQgAjjtxzjNI5j2QdRHhEKudzsyMoPybYe7Q6cZ08k80wARqQwUWJZY1zRwL
W2MRlTp9RYnJCA8B7FS5pk6ifc1AvK2Wd+2d823ZT/1tS2K8m/YvNvP8YyBryeCP
C0YCWY+gZSsavK9CBVrCJ4R05v8e5N5IMRT8iKyaYBLggGQDd3dGGPR4+Q8a9Cia
Q0rx5vXM2cS0lfeJRgMKBbKDz5/8302fzUtQWSNMOSJ0amKAxZFoDGPucdCiYLSS
YRqF+iAYBpmU9ZcbDlYd1qX0eDwPWAeq+kFRQ6Le3YYahMGE07EUH/PrmEoGcptV
KlFkXCe8ZfTdyw1zENp2fCTfD/Yeog==
=p4Jf
-----END PGP SIGNATURE-----

--Sig_/EQ1.i=fuU3alADHDwrjr6wj--
