Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ABAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDFE82084C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uXPkKOSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDFE82084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbeKLKon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:44:43 -0500
Received: from ozlabs.org ([203.11.71.1]:56365 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729500AbeKLKon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 05:44:43 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42tXMG06mqz9s8F;
        Mon, 12 Nov 2018 11:54:01 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1541984042;
        bh=7Y0ljGPlTrXTvmWxCpMsaxkc5pJOTLWzqviuIBi3/RU=;
        h=Date:From:To:Cc:Subject:From;
        b=uXPkKOSFgnh2Rz/Cmn37Wc+hV82uMeNXu+OPqDffiLRNJgZRot1x7RUEeNVaH7tuh
         WKcIYyfmLwfp4KdL72s8qNGzofmXE8xJpiu3+RNZb8n+Dk+Z+Ua/MK+wQl+vPPkQqK
         2swyL9tqpMX1f8NfZ6vknh1/djGQPyFH2B2koKiihL9eZZU1SGHGC2B8v61uIK0Ni9
         Nl8FKdSoP70mJEeWXZlJ1h/0hdRj4EfkO0MoDCv01vTU6FMRqyMaUaz1xTzRsJZG4d
         BIsEjg47HiPd1MkztmtvkdHTJDkzgn8Z540mnHE6HzbQTteM8ivU+Wx1doNqiMiZni
         Bpnq9eAhXgaqQ==
Date:   Mon, 12 Nov 2018 11:54:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrey Ignatov <rdna@fb.com>,
        Nitin Hande <nitin.hande@gmail.com>
Subject: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <20181112115400.46bdc84b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iAnKRWPNKIlT9TOuqgclQHH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iAnKRWPNKIlT9TOuqgclQHH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  net/core/filter.c

between commit:

  b13b8787c95c ("bpf: Fix IPv6 dport byte order in bpf_sk_lookup_udp")

from the bpf tree and commit:

  c8123ead13a5 ("bpf: Extend the sk_lookup() helper to XDP hookpoint.")

from the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/core/filter.c
index 9a1327eb25fa,53d50fb75ea1..000000000000
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@@ -4852,19 -4867,19 +4867,18 @@@ static struct sock *sk_lookup(struct ne
  	} else {
  		struct in6_addr *src6 =3D (struct in6_addr *)&tuple->ipv6.saddr;
  		struct in6_addr *dst6 =3D (struct in6_addr *)&tuple->ipv6.daddr;
- 		int sdif =3D inet6_sdif(skb);
 -		u16 hnum =3D ntohs(tuple->ipv6.dport);
 =20
  		if (proto =3D=3D IPPROTO_TCP)
- 			sk =3D __inet6_lookup(net, &tcp_hashinfo, skb, 0,
+ 			sk =3D __inet6_lookup(net, &tcp_hashinfo, NULL, 0,
  					    src6, tuple->ipv6.sport,
 -					    dst6, hnum,
 +					    dst6, ntohs(tuple->ipv6.dport),
  					    dif, sdif, &refcounted);
  		else if (likely(ipv6_bpf_stub))
  			sk =3D ipv6_bpf_stub->udp6_lib_lookup(net,
  							    src6, tuple->ipv6.sport,
 -							    dst6, hnum,
 +							    dst6, tuple->ipv6.dport,
  							    dif, sdif,
- 							    &udp_table, skb);
+ 							    &udp_table, NULL);
  #endif
  	}
 =20

--Sig_/iAnKRWPNKIlT9TOuqgclQHH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvozygACgkQAVBC80lX
0GzeKgf9Hkh5jfduCO5Pp8IQA+ZasnRv99RzoszuLhSr94PRHUWTOrajDpv7y/+r
V2DBu2ndRKqqVFx2q69ViMON2dXWOBHZVTRRwNzl3WCacIOlQDGkZ1199N0XBqr7
bTr4UCSk0eAdtnHQmVwiQdDtaruE37EwulxKgOoPw3ce/aRA5RW1owhnMRutFkbi
M65EMdj/4zIBx4dBccLUQAR3Z15Y5dtycApvIAzI2UkE6kUC8coqto5fCqwE5Fpt
XhVJByBsp4rB5l5066t20CClHAOPBn/Do/W9yn77R4Sc5a+LkPO6H668/MeOh9D/
UOHI/q2GrMQqnYuUVfFIdmMLTV40rQ==
=8kmV
-----END PGP SIGNATURE-----

--Sig_/iAnKRWPNKIlT9TOuqgclQHH--
