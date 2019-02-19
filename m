Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6A3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2542021848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="k21QWivp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbfBSAap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 19:30:45 -0500
Received: from ozlabs.org ([203.11.71.1]:49577 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbfBSAao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 19:30:44 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 443M8f1PH6z9s6w;
        Tue, 19 Feb 2019 11:30:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550536242;
        bh=a465LHsDNmSaR6xgZ3/ZT+J4+ALAxXNnonMuodeftQ0=;
        h=Date:From:To:Cc:Subject:From;
        b=k21QWivpaXPHxcthjFF1m8miONZiSpsRjPU1CkZ+WorRKtNq0CN7wWhDVvlUjIhYg
         vP+dzgzWQPSnfpgLrRbFSTfStRKS6rb70ATY+xnscqqFpJicw2AaPkbsDCgGYHghM8
         g4EjT6nxNeXhmra78P8Y3yELC9reF2vDHAP9YvRyJcxEvCrsIgWY0PemtdF2qEYQ/E
         x88ecgLQu4Dx/pdnis301X14Tq2Sd78PmzJsEbBgeG2vWaoutj8CrtOnaw+F9vfZPc
         fwpC9pSJFUfehMPdInqu36ff+I7pcchWMlpMe6NGroWcLOplEY3rAbRKeTVudYno7j
         bqsBr+7SmrFgw==
Date:   Tue, 19 Feb 2019 11:30:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20190219113041.14ac62ec@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5ElCMpKabLiTj9k5rBR2gWg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5ElCMpKabLiTj9k5rBR2gWg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/ipv4/tcp.c

between commit:

  04c03114be82 ("tcp: clear icsk_backoff in tcp_write_queue_purge()")

from the net tree and commit:

  3a9a57f63794 ("tcp: move snd_cwnd & snd_cwnd_cnt init to tcp_disconnect()=
")

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

diff --cc net/ipv4/tcp.c
index cf3c5095c10e,cab6b2f2f61d..000000000000
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@@ -2577,9 -2595,11 +2596,10 @@@ int tcp_disconnect(struct sock *sk, in
  	tp->write_seq +=3D tp->max_window + 2;
  	if (tp->write_seq =3D=3D 0)
  		tp->write_seq =3D 1;
- 	tp->snd_cwnd =3D 2;
 -	icsk->icsk_backoff =3D 0;
  	icsk->icsk_probes_out =3D 0;
+ 	icsk->icsk_rto =3D TCP_TIMEOUT_INIT;
  	tp->snd_ssthresh =3D TCP_INFINITE_SSTHRESH;
+ 	tp->snd_cwnd =3D TCP_INIT_CWND;
  	tp->snd_cwnd_cnt =3D 0;
  	tp->window_clamp =3D 0;
  	tp->delivered_ce =3D 0;

--Sig_/5ElCMpKabLiTj9k5rBR2gWg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxrTjEACgkQAVBC80lX
0GykxQgAhmkUZF9T2XBiTBPoNGpQddPNWswwqQNAdux7QXADtx8d/PxYr2WIwyp2
5yHeL9px085+nHv743KIIqX2kiEwQfGpz++HRD4oKnGdSp7GpW6ENbFa/iFqf6Ph
XFoayY07RU0nXhW7FsxrcGeLR+6kR2xLf1QzUwLm9nFPkVqcJhTrHWtWpjSOrdSl
JC6z/r2E+5EZa93aD65T8oIAXtp7YdKD2px5tpNykzmlpVR6GhyXSsmNQM4RdUm0
uxBVsDWuekxPvFoFsWt4+49Zb4/G1U8oDzcQ7I0nqu7J7kyNRYmj8KtHDEaYlDZ6
lCvica66mdZu66Z2KMDAGvZbPIY4rg==
=j0KX
-----END PGP SIGNATURE-----

--Sig_/5ElCMpKabLiTj9k5rBR2gWg--
