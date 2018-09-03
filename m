Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDF7C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 03:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE2B2075E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 03:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qfXXCB49"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE2B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeICHeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 03:34:11 -0400
Received: from ozlabs.org ([203.11.71.1]:55151 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbeICHeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 03:34:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 423ZqM2pLfz9ryn;
        Mon,  3 Sep 2018 13:15:59 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535944559;
        bh=9kW81LkgZFxpI4ok7PWkE8hHULnnv09l1SkoeQ/ZzRs=;
        h=Date:From:To:Cc:Subject:From;
        b=qfXXCB49WNlRlKoWiRbcwTuJCzbXuYA2YmNl7A1ffdSvN6Zc/pu+lZ/Gwmtd9mfTO
         Rp3isplgP+ozp5U9uGyTKk/SuHGaoP46I/JjTJcyB8UtfpV+MoxTEcKZSEcopP2SFb
         Vh7+39noQSUo9R+9XgwZ0NZAcuzf5eq6JVEPQlsZ+8nhwoYEq2nytFoOjRGiQA7pvv
         tWnPNKcGh7jBXCPKHP1ZWp6nIBvSSrpM/Lvc5aDfiNHRHKzcRmVwgYtlSL0oFI7BW+
         lr/Pmy/2pIEwK6nC+I36xYtyOK6JGBGRzbkCleKtE75ePXet2SMMig3Q0W9j3B0lZV
         s3PxRVdZH5I2g==
Date:   Mon, 3 Sep 2018 13:15:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <sfrench@samba.org>
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        Linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/cifs: suppress a string overflow warning
Message-ID: <20180903131558.21cdeb35@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bxKFgXwdVx5Emd=Or=/qrWf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bxKFgXwdVx5Emd=Or=/qrWf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

A powerpc build of cifs with gcc v8.2.0 produces this warning:

fs/cifs/cifssmb.c: In function =E2=80=98CIFSSMBNegotiate=E2=80=99:
fs/cifs/cifssmb.c:605:3: warning: =E2=80=98strncpy=E2=80=99 writing 16 byte=
s into a region of size 1 overflows the destination [-Wstringop-overflow=3D]
   strncpy(pSMB->DialectsArray+count, protocols[i].name, 16);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Since we are already doing a strlen() on the source, change the strncpy
to a memcpy().

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/cifs/cifssmb.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index dc2f4cf08fe9..dcf939cb9d2f 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -601,10 +601,14 @@ CIFSSMBNegotiate(const unsigned int xid, struct cifs_=
ses *ses)
 	}
=20
 	count =3D 0;
+	/*
+	 * We know that all the name entries in the protocols array
+	 * are short (< 16 bytes anyway) and are NUL terminated.
+	 */
 	for (i =3D 0; i < CIFS_NUM_PROT; i++) {
-		strncpy(pSMB->DialectsArray+count, protocols[i].name, 16);
-		count +=3D strlen(protocols[i].name) + 1;
-		/* null at end of source and target buffers anyway */
+		size_t len =3D strlen(protocols[i].name) + 1;
+		memcpy(pSMB->DialectsArray+count, protocols[i].name, len);
+		count +=3D len;
 	}
 	inc_rfc1001_len(pSMB, count);
 	pSMB->ByteCount =3D cpu_to_le16(count);
--=20
2.19.0.rc1

--=20
Cheers,
Stephen Rothwell

--Sig_/bxKFgXwdVx5Emd=Or=/qrWf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluMp24ACgkQAVBC80lX
0GzYjgf+IJhS302zpGn7gwv3y5UBrsWcFA58Ke1DJPbZArJOIC+51Ueuuep5MKWL
d/fQhR/gPmzQYOlN/MYMvZcCePB0mwQzKvavLdC8RzBvRWpuG7MJHHxXxYN26oYc
Lys7BFxAhM4TzDMM8oPkiSkCtP8pLZ46WHNBUlZ1vvCDevKBFKzc9bgc/fwQ3MQX
xkcokPifqUg5Rq/iGCvZdqa6Sxbg4mpMubg7BZjyI2CWWSFNt8ieUwMR0TjjHnWQ
W+7WDPnYHi0qa7QBvga9KhHwvoLcJO6V8thsHDyoIXht6wBAyulcufPwann63XQI
eKPr6o/ypEbYsSyS2oevowhdbYM7cA==
=y+fl
-----END PGP SIGNATURE-----

--Sig_/bxKFgXwdVx5Emd=Or=/qrWf--
