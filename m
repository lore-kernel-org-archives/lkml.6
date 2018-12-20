Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F4FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD4E20815
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="I3eW2JQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbeLTGfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 01:35:02 -0500
Received: from ozlabs.org ([203.11.71.1]:40073 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbeLTGfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 01:35:01 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43L2763d8Jz9s8r;
        Thu, 20 Dec 2018 17:34:58 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545287699;
        bh=BkDg1SZ/rpKAXSL1UJG+K7a6kujdjUvxPy0bpbEdXHo=;
        h=Date:From:To:Cc:Subject:From;
        b=I3eW2JQqmOuXbd4VqsrFWEs0WqvUH3CIuS6gdj1UHfayv0jYYVnNt09d1QO6jKpPu
         6Ndk/QkUVY5tE7zu2v4HAra+y9Fsx19CvPiYZ8YU1VSISKSnOdXB3hQ5iU1mRvNdc2
         5v+MGskgbMQxbHaEBPxVv2kQYkg93Pls8Pqd5BP0DZaMnJg2IrvnhXO1QZxkuFIKSF
         zFHMDq40PSaHbPfnRPgsI8nEwtmK+R7ygvzPWHjybgX/6odpiVpvi0JbSqnglwDOTB
         vFbK6kV1zLnxGUKI9Lgn48tToXcJNJMnNN+m+NVEbY7Vwv0odSpDT8rfHzbymTmHfp
         gLyzxGFid5oFg==
Date:   Thu, 20 Dec 2018 17:34:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Carroll <david.carroll@microsemi.com>,
        Kees Cook <keescook@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: linux-next: build warning after merge of the scsi-mkp tree
Message-ID: <20181220173457.66c83c0f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/H0LAdbIO0_=hHQZK7vD+B+u"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/H0LAdbIO0_=hHQZK7vD+B+u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the scsi-mkp tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/scsi/smartpqi/smartpqi_init.c: In function 'pqi_build_raid_path_req=
uest':
drivers/scsi/smartpqi/smartpqi_init.c:478:14: warning: this statement may f=
all through [-Wimplicit-fallthrough=3D]
   cdb_length =3D 0;
   ~~~~~~~~~~~^~~
drivers/scsi/smartpqi/smartpqi_init.c:479:2: note: here
  case BMIC_IDENTIFY_CONTROLLER:
  ^~~~
drivers/scsi/smartpqi/smartpqi_init.c:487:14: warning: this statement may f=
all through [-Wimplicit-fallthrough=3D]
   cdb_length =3D 0;
   ~~~~~~~~~~~^~~
drivers/scsi/smartpqi/smartpqi_init.c:488:2: note: here
  case BMIC_WRITE_HOST_WELLNESS:
  ^~~~

Introduced by commit

  171c28653a2d ("scsi: smartpqi: turn off lun data caching for ptraid")

This due to my use of -Wimplicit-fallthrough for Kees Cook.  This is
new code.  The warning can be suppressed by adding a comment like

  /* fall through */

just above the following "case" or "default" to indicate that the
fallthrough is intended.

--=20
Cheers,
Stephen Rothwell

--Sig_/H0LAdbIO0_=hHQZK7vD+B+u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwbOBEACgkQAVBC80lX
0GyXGAf/fH+35bQsUAb8scL5DoD5Wcdir4zL8vov+SOSYxKm3Hii4wR/sf52o4QM
ayLMmH9IZjb2cNb0NHJnYODClquFRwxkmXgckjrieAp0Dao6RxXXq5/lCuQV4NRQ
M3yySxokn7WmtqZ1hp1cWj9cU/atw2Zwu3PBAc3+1aBHi3jP0sB8KM7KU+92mlRw
HSKdlG/jVxYgmBmn6NY2UNYskwjKWgI/bn6yKdtIcg3tW/r71AWqWVUIkEyAMRB2
ZrvZkXnWLLpbJ13Oncgu1fu5mjayL4dPFNwn0B6FHyS2ceMcqrg7mjaHxZVzWdPS
R0CVqCGXiICYTAvT7jU+Nymz8W5DXg==
=UTwG
-----END PGP SIGNATURE-----

--Sig_/H0LAdbIO0_=hHQZK7vD+B+u--
