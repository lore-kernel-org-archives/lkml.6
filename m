Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B416C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D192173C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kSZohFtv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732738AbfBSBbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 20:31:44 -0500
Received: from ozlabs.org ([203.11.71.1]:53221 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfBSBbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 20:31:43 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 443NVz4CCrz9s5c;
        Tue, 19 Feb 2019 12:31:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550539900;
        bh=lYgm9kwQUpZ5vSa2hAL9Y98WCuPHMJaHQfnyLXYrwBU=;
        h=Date:From:To:Cc:Subject:From;
        b=kSZohFtvlqobNgc3K/t7sBGWm2GpWYxTeq9fqURbccDuEp4EdBq1tf1m6h+Sk1Co/
         kJQbpwBkMF0qNGm/A4Qz3BTdOv27+KdpY/UHO7XKdcproSD7TJWSaK7CA3Bpsk5fEW
         tPEu/5iHqT6SwYEP+n8y9TMFusi32EfB2bLmTMbFkmYyF4qJoHriOUpbHFWp3sSQV/
         FLZHdgSZb4UADULmdscTnUtJ6geB6Kzv/KHt24Mcixpxc9YdpC6D90EURfKIWI01kU
         AWzkFQoHWlMHGsfMrj9oo3PtnzCsrB9sKe54BVkrIt+PWaDMUFGll+m0l8TmwTQ2ml
         /6zvqp0tbQVuw==
Date:   Tue, 19 Feb 2019 12:31:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: linux-next: manual merge of the sound tree with the
 sound-asoc-fixes tree
Message-ID: <20190219123138.562ed288@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3LOfxud2Gf7cMKC7z3y582D"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3LOfxud2Gf7cMKC7z3y582D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the sound tree got a conflict in:

  sound/soc/generic/simple-card.c

between commit:

  19dd0777773a ("ASoC: simple-card: fixup refcount_t underflow")

from the sound-asoc-fixes tree and commit:

  c39291a76444 ("ASoC: simple-card: cleanup DAI link loop method - step2")

from the sound tree.

I fixed it up (I think - see below) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc sound/soc/generic/simple-card.c
index 3fe34417ec89,08df261024cf..000000000000
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@@ -401,8 -426,76 +426,76 @@@ dai_link_of_err
  	return ret;
  }
 =20
- static int asoc_simple_card_parse_aux_devs(struct device_node *node,
- 					   struct simple_card_data *priv)
+ static int simple_for_each_link(struct simple_priv *priv,
+ 			struct link_info *li,
+ 			int (*func_noml)(struct simple_priv *priv,
+ 					 struct device_node *np,
+ 					 struct device_node *codec,
+ 					 struct link_info *li, bool is_top),
+ 			int (*func_dpcm)(struct simple_priv *priv,
+ 					 struct device_node *np,
+ 					 struct device_node *codec,
+ 					 struct link_info *li, bool is_top))
+ {
+ 	struct device *dev =3D simple_priv_to_dev(priv);
+ 	struct device_node *top =3D dev->of_node;
+ 	struct device_node *node;
+ 	bool is_top =3D 0;
+=20
+ 	/* Check if it has dai-link */
+ 	node =3D of_get_child_by_name(top, PREFIX "dai-link");
+ 	if (!node) {
 -		node =3D top;
++		node =3D of_node_get(top);
+ 		is_top =3D 1;
+ 	}
+=20
+ 	/* loop for all dai-link */
+ 	do {
+ 		struct asoc_simple_card_data adata;
+ 		struct device_node *codec;
+ 		struct device_node *np;
+ 		int num =3D of_get_child_count(node);
+ 		int ret;
+=20
+ 		/* get codec */
+ 		codec =3D of_get_child_by_name(node, is_top ?
+ 					     PREFIX "codec" : "codec");
+ 		if (!codec)
+ 			return -ENODEV;
+=20
+ 		of_node_put(codec);
+=20
+ 		/* get convert-xxx property */
+ 		memset(&adata, 0, sizeof(adata));
+ 		for_each_child_of_node(node, np)
+ 			simple_get_conversion(dev, np, &adata);
+=20
+ 		/* loop for all CPU/Codec node */
+ 		for_each_child_of_node(node, np) {
+ 			/*
+ 			 * It is DPCM
+ 			 * if it has many CPUs,
+ 			 * or has convert-xxx property
+ 			 */
+ 			if (num > 2 ||
+ 			    adata.convert_rate || adata.convert_channels)
+ 				ret =3D func_dpcm(priv, np, codec, li, is_top);
+ 			/* else normal sound */
+ 			else
+ 				ret =3D func_noml(priv, np, codec, li, is_top);
+=20
+ 			if (ret < 0)
+ 				return ret;
+ 		}
+=20
+ 		node =3D of_get_next_child(top, node);
+ 	} while (!is_top && node);
+=20
+ 	return 0;
+ }
+=20
+ static int simple_parse_aux_devs(struct device_node *node,
+ 				 struct simple_priv *priv)
  {
  	struct device *dev =3D simple_priv_to_dev(priv);
  	struct device_node *aux_node;

--Sig_/3LOfxud2Gf7cMKC7z3y582D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxrXHoACgkQAVBC80lX
0GyRzwf/UFxAE3DZLTP67Y4aW8bskACiYpbbq8fmMg1ZnHXnMf7LmKgNPLPtezdX
0IK2BUJp2Kmvpw5tLopiCvzFW7tJykL8iehEwVpeyJbawaxZWCtXePtzh7ZBxjUA
1lQ0ZjJUmNOYHmXl+YCdVevEFfa9kdfX1nfX5JPghyC1Wm81D//MRqAFB3ip1XVx
6EgDgWlljBxt3ZttyxZq/whinjK4OUVk/BAs3J1FCvaBAMRXYcLpvYl0AHW8LGwt
HqljblCYjoDH2bWfiiT61iWBFOmM3GMg/ZtQ0GXfTYygDUmT2LlrEDqhBXlBHTqZ
gmy5aHucIu7Az0j0gNMzH38n2yHBwQ==
=U90/
-----END PGP SIGNATURE-----

--Sig_/3LOfxud2Gf7cMKC7z3y582D--
