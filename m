Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834FEECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8A32088F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gjTAn8lv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8A32088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbeIRFlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:41:15 -0400
Received: from ozlabs.org ([203.11.71.1]:40535 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727294AbeIRFlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:41:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Dk1R5qz2z9sBv;
        Tue, 18 Sep 2018 10:11:23 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537229484;
        bh=Xq2BnsrY+hNh9j+xEgV++sfiq0oQyxiyjTTepg6ERN0=;
        h=Date:From:To:Cc:Subject:From;
        b=gjTAn8lvurr5KMivHL33MeqoUMSk6rzobAHLlltMd/4tDw3A+LFWnAzfCTwJ7Z4h2
         pHYR0cBJvyWucAB/0tdoARbLtM9uPvGWm9s09iz+AhJQlI/YPc0/xsF065inxFtqwq
         ziOxnCf1gpYPRfvwZEuoaKUn8ChblJ4EGAHKh2ae7nZDorgvpV6ij8RwLjkm864K94
         XxKywbIwEjPbCShwimAXMLAuQ6KvJIxScInRTp9ZEBE9MQDJbTw9yFwIvuiD967zT5
         BU1JBY1Ormey/G0s1yAgYh6bE6b3t+mmSyH7Lyiw71ibCcvDixPSwVukhBOs0iZ6RD
         oTcbCCWD+XMyg==
Date:   Tue, 18 Sep 2018 10:11:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vakul Garg <vakul.garg@nxp.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20180918101107.74d8689a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gk.xrKYo+V8dzSowvoh9sfc"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gk.xrKYo+V8dzSowvoh9sfc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  tools/testing/selftests/net/tls.c

between commit:

  50c6b58a814d ("tls: fix currently broken MSG_PEEK behavior")

from the net tree and commit:

  c2ad647c6442 ("selftests/tls: Add test for recv(PEEK) spanning across mul=
tiple records")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/net/tls.c
index 8fdfeafaf8c0,96fc6fe70293..000000000000
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@@ -502,55 -502,28 +502,77 @@@ TEST_F(tls, recv_peek_multiple
  	EXPECT_EQ(memcmp(test_str, buf, send_len), 0);
  }
 =20
 +TEST_F(tls, recv_peek_multiple_records)
 +{
 +	char const *test_str =3D "test_read_peek_mult_recs";
 +	char const *test_str_first =3D "test_read_peek";
 +	char const *test_str_second =3D "_mult_recs";
 +	int len;
 +	char buf[64];
 +
 +	len =3D strlen(test_str_first);
 +	EXPECT_EQ(send(self->fd, test_str_first, len, 0), len);
 +
 +	len =3D strlen(test_str_second) + 1;
 +	EXPECT_EQ(send(self->fd, test_str_second, len, 0), len);
 +
 +	len =3D sizeof(buf);
 +	memset(buf, 0, len);
 +	EXPECT_NE(recv(self->cfd, buf, len, MSG_PEEK), -1);
 +
 +	/* MSG_PEEK can only peek into the current record. */
 +	len =3D strlen(test_str_first) + 1;
 +	EXPECT_EQ(memcmp(test_str_first, buf, len), 0);
 +
 +	len =3D sizeof(buf);
 +	memset(buf, 0, len);
 +	EXPECT_NE(recv(self->cfd, buf, len, 0), -1);
 +
 +	/* Non-MSG_PEEK will advance strparser (and therefore record)
 +	 * however.
 +	 */
 +	len =3D strlen(test_str) + 1;
 +	EXPECT_EQ(memcmp(test_str, buf, len), 0);
 +
 +	/* MSG_MORE will hold current record open, so later MSG_PEEK
 +	 * will see everything.
 +	 */
 +	len =3D strlen(test_str_first);
 +	EXPECT_EQ(send(self->fd, test_str_first, len, MSG_MORE), len);
 +
 +	len =3D strlen(test_str_second) + 1;
 +	EXPECT_EQ(send(self->fd, test_str_second, len, 0), len);
 +
 +	len =3D sizeof(buf);
 +	memset(buf, 0, len);
 +	EXPECT_NE(recv(self->cfd, buf, len, MSG_PEEK), -1);
 +
 +	len =3D strlen(test_str) + 1;
 +	EXPECT_EQ(memcmp(test_str, buf, len), 0);
 +}
 +
+ TEST_F(tls, recv_peek_large_buf_mult_recs)
+ {
+ 	char const *test_str =3D "test_read_peek_mult_recs";
+ 	char const *test_str_first =3D "test_read_peek";
+ 	char const *test_str_second =3D "_mult_recs";
+ 	int len;
+ 	char buf[64];
+=20
+ 	len =3D strlen(test_str_first);
+ 	EXPECT_EQ(send(self->fd, test_str_first, len, 0), len);
+=20
+ 	len =3D strlen(test_str_second) + 1;
+ 	EXPECT_EQ(send(self->fd, test_str_second, len, 0), len);
+=20
+ 	len =3D sizeof(buf);
+ 	memset(buf, 0, len);
+ 	EXPECT_NE(recv(self->cfd, buf, len, MSG_PEEK), -1);
+=20
+ 	len =3D strlen(test_str) + 1;
+ 	EXPECT_EQ(memcmp(test_str, buf, len), 0);
+ }
+=20
  TEST_F(tls, pollin)
  {
  	char const *test_str =3D "test_poll";

--Sig_/gk.xrKYo+V8dzSowvoh9sfc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlugQpsACgkQAVBC80lX
0Gz3EQf/UJDAfYgBYpPjUgDz82f+NRcBqrR/ekZfPvomH1PKo/d6tHibfGRW4VEX
f1BEF2Qp5z7JmKfqToq6Yv5wqBV+m3Lfk9pn5QkzhPBRLHko/35ia/RubS2GBCYw
qnyMGZtvA6nX4APzziHLhmWUDJDHrCw+2qAKA3VGWTnfI+DAFed6PdCnUX+jOYVz
J0Tp1G6JDAWLpQZqKYMjjligl0agrRaLvXbVTw36lhAtuS45BPzpv8kZb+2KK1hU
tJIAOuK+RB2bT+jl7jn75LhsdVqfkmzgpJc+cGVG2fWJQauZQYXCKym+wc3gZQCw
qSJfixe1ozp58yU1SLC8Y7Ydwtoirw==
=Mcd3
-----END PGP SIGNATURE-----

--Sig_/gk.xrKYo+V8dzSowvoh9sfc--
