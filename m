Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC46C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 00:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5B82084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 00:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fm2Nl5HA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbeLQAbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 19:31:09 -0500
Received: from ozlabs.org ([203.11.71.1]:39303 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730788AbeLQAbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 19:31:09 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43J2Bf6ykLz9sBh;
        Mon, 17 Dec 2018 11:31:06 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545006667;
        bh=TE5Hqn45H4blPSTWCHPSS5TkqpjH1M73YHebFxB6V5Q=;
        h=Date:From:To:Cc:Subject:From;
        b=fm2Nl5HAe+RDtkREBqjN7aUGX5qsezqmX4R3MHgad+DbVF42L2F/sQ/YHdsC0GIHP
         v5/o0+CZMBEUvZtrHjb8SLNPpA1q1wvtovyOCypb3CkGrEISmXUbX2fCHCPSUJWmrf
         FLO+5Mxs6mUPRRvuvJhpmGq5fcvgkubhpolQrUKV86XnIeOBFMkr4Rr9TP3HDYQCXL
         RQjotOBcBlmiuAfYKDUmTmC/Eiyn6kljTBe7MwAVFDgZFxwTKv2XmQkDTvWGuDNdNK
         8n0JZLD6cnnhFceOkkjzd2Ooa+ypexctQAgEplqOOZoiRh3zIsoylLqkkZ89I2I5MN
         VrEXRItnT7HlQ==
Date:   Mon, 17 Dec 2018 11:31:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Ido Schimmel <idosch@mellanox.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20181217113106.32d98f30@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UrkNE1PzDhRILSpE4niyV_7"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UrkNE1PzDhRILSpE4niyV_7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/ipv6/ip6_output.c

between commit:

  8203e2d844d3 ("net: clear skb->tstamp in forwarding paths")

from the net tree and commit:

  f839a6c92504 ("net: Do not route unicast IP packets twice")

from the net-next tree.

I fixed it up (I was not quite sure of the correct ordering - see below)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/ipv6/ip6_output.c
index 4591ca4bdbe8,9d55ee33b7f9..000000000000
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@@ -378,7 -378,13 +378,14 @@@ static inline int ip6_forward_finish(st
  	__IP6_INC_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTFORWDATAGRAMS);
  	__IP6_ADD_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTOCTETS, skb->len);
 =20
+ #ifdef CONFIG_NET_SWITCHDEV
+ 	if (skb->offload_l3_fwd_mark) {
+ 		consume_skb(skb);
+ 		return 0;
+ 	}
+ #endif
+=20
 +	skb->tstamp =3D 0;
  	return dst_output(net, sk, skb);
  }
 =20

--Sig_/UrkNE1PzDhRILSpE4niyV_7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwW7koACgkQAVBC80lX
0GwsRQf/Zo4pSnTD1qLwVq9c5uBt1AZ5RXjROYnaw2aeRk1lghGABzLO09uw77qz
sVns/6NXKeYdJtn5fzCJUupKRzUveNMiYjE5xjpnnNHskBRyuo06b58kAsdtNPgj
VH1z+ZKtkMyOLUslkB+t5loPT0vwshkfFSZLMRlmiUoDFw6tlxF/+gO7Q11NsRbr
eFTEx+YIB9upwebZ+l9+c29Kl4MKSxi9QRQhG7YGfgKERGnPHFhM9jzfA8jndDvT
PNdcgcqKnEXqtl9ebXJZ2uFya0Kjnhn8SQt+kMaktb2Yp01Gn3+QlQqy/R+HVpUs
jWJPo+WLLc3ow/oe85MG1S3+FyDJIQ==
=9zHY
-----END PGP SIGNATURE-----

--Sig_/UrkNE1PzDhRILSpE4niyV_7--
