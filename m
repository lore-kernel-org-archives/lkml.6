Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D74ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28FC2147E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HLcVJB86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28FC2147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387890AbeGMBAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 21:00:07 -0400
Received: from ozlabs.org ([203.11.71.1]:53735 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387827AbeGMBAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 21:00:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41RZ0b38JYz9rxx;
        Fri, 13 Jul 2018 10:47:59 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531442880;
        bh=yfX6+OPA8s3en/0n4QiF5B3pyffx8/HntpBk3nJQ5+c=;
        h=Date:From:To:Cc:Subject:From;
        b=HLcVJB86JOgWTo6FfEF0eusZBWGuU43CE7J+ebNNOCxo1/PHx7YwDdXozayxkOUXB
         Wu0i2nnXXyF0kZ2I6iKZ01+y0EQQjNcYDIK4upwhvkcHslWES8ACAAMD1V/r2AZJOM
         oOJn9JmltZjxIRLX6Sm3tyGvWWIenS+CQa00CZk7j4ZYuePO5/x0T8zCVI4EazXOMW
         YKvrY4/IO0KkUODB/lMlTmd0OosAWHlT/VWSdOrVV8b1cca0oGUoAYWp/W/R9yu3LY
         rsrZwzsCq0Z01RwWhESZSq3ZPm5Z0Ycd8ig1AVaYejAyS3du2nv88w35RKDbEwmW3d
         0r2JcHaROuNVA==
Date:   Fri, 13 Jul 2018 10:47:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Baranoff <sbaranoff@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Dumazet <edumazet@google.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20180713104752.697563af@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/j/4oXbMF2CmrDxFIlsDjrKF"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j/4oXbMF2CmrDxFIlsDjrKF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/ipv4/tcp_ipv4.c

between commit:

  21684dc46c59 ("tcp: fix sequence numbers for repaired sockets re-using TI=
ME-WAIT sockets")

from the net tree and commit:

  cca9bab1b72c ("tcp: use monotonic timestamps for PAWS")

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

diff --cc net/ipv4/tcp_ipv4.c
index 3b2711e33e4c,dc415c66a33a..000000000000
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@@ -155,25 -155,13 +155,26 @@@ int tcp_twsk_unique(struct sock *sk, st
  	   and use initial timestamp retrieved from peer table.
  	 */
  	if (tcptw->tw_ts_recent_stamp &&
- 	    (!twp || (reuse && get_seconds() - tcptw->tw_ts_recent_stamp > 1))) {
+ 	    (!twp || (reuse && time_after32(ktime_get_seconds(),
+ 					    tcptw->tw_ts_recent_stamp)))) {
 -		tp->write_seq =3D tcptw->tw_snd_nxt + 65535 + 2;
 -		if (tp->write_seq =3D=3D 0)
 -			tp->write_seq =3D 1;
 -		tp->rx_opt.ts_recent	   =3D tcptw->tw_ts_recent;
 -		tp->rx_opt.ts_recent_stamp =3D tcptw->tw_ts_recent_stamp;
 +		/* In case of repair and re-using TIME-WAIT sockets we still
 +		 * want to be sure that it is safe as above but honor the
 +		 * sequence numbers and time stamps set as part of the repair
 +		 * process.
 +		 *
 +		 * Without this check re-using a TIME-WAIT socket with TCP
 +		 * repair would accumulate a -1 on the repair assigned
 +		 * sequence number. The first time it is reused the sequence
 +		 * is -1, the second time -2, etc. This fixes that issue
 +		 * without appearing to create any others.
 +		 */
 +		if (likely(!tp->repair)) {
 +			tp->write_seq =3D tcptw->tw_snd_nxt + 65535 + 2;
 +			if (tp->write_seq =3D=3D 0)
 +				tp->write_seq =3D 1;
 +			tp->rx_opt.ts_recent	   =3D tcptw->tw_ts_recent;
 +			tp->rx_opt.ts_recent_stamp =3D tcptw->tw_ts_recent_stamp;
 +		}
  		sock_hold(sktw);
  		return 1;
  	}

--Sig_/j/4oXbMF2CmrDxFIlsDjrKF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltH9rgACgkQAVBC80lX
0GzWNwf+NKiB5ZCGsvvZ2WrAeWiMa6P10qyeJbC+pUHP2OGhTHxzn7kugQzxG5rA
lQSw1A23lv/Wcn0jNMocuZC3gAErhv3zbW00dj+CfszDtjZq++WhfXBQ5OSBJI0F
caIvgWCqnEtgiJ9R+kFI7nulcaKUfq+AepoQOq6+8v+QmMtiQ+Iyh8JQZbrdWnQt
0CgRxgTe9GIhkbqFu2hWHbLB4J53lemXEdNTCu0DD37rZlZW1HQn2ESMVGQAaa3W
CYXTt/a7zGGpLOPOCoMUaYO5PilZjWWyrx3i5Fu1qyhla04pzey3H4uO+TkcJrMp
uhVKY1CwfExkWiVTKpQzv5qAmVd6TA==
=scmK
-----END PGP SIGNATURE-----

--Sig_/j/4oXbMF2CmrDxFIlsDjrKF--
