Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1A1C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC582148C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Vy112zEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC582148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeJQHju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:39:50 -0400
Received: from ozlabs.org ([203.11.71.1]:38127 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbeJQHju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:39:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42ZX5x0h9Hz9s8F;
        Wed, 17 Oct 2018 10:47:00 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539733621;
        bh=436XRDCBPoaFIQh9MBLN7D5drdmuI/ucqFnuDsBfnxY=;
        h=Date:From:To:Cc:Subject:From;
        b=Vy112zEwj+CSyv2bzi/eLjQTG7LrJEp+Rg4sVraJAsq0Erz88XaCYBLhYFfwUt8ZV
         o4FdYR2jMDLfGVIkPD1jIhltWpSwHc3fkpPWUh0D7jGw/lshkGiz2Okodq5usUJUBc
         eUzQPpcE9K6PlRpWPCYozFF/Ddk4rSVvGg41n8+y2YGrYlM4vC7DyT1FabTy5Buexb
         CDKNgLUqCEJ/0usXiT1at4VPebAOITMxlffpJrKm43+aWLw5bdhC8kNxnHVD5hIZEG
         o7grtXu0mvY2sy1NTeEEUviIJAQ8n98ZvMcH+gLiOrSydbDBByvgeqZBRJdOkRqeqT
         GUq1nt2TBmwLA==
Date:   Wed, 17 Oct 2018 10:46:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davide Caratti <dcaratti@redhat.com>,
        David Ahern <dsahern@gmail.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20181017104642.40d37d05@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ig8Rxox_Ru14hlzWqD3VREN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ig8Rxox_Ru14hlzWqD3VREN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/sched/cls_api.c

between commit:

  e331473fee3d ("net/sched: cls_api: add missing validation of netlink attr=
ibutes")

from the net tree and commit:

  dac9c9790e54 ("net: Add extack to nlmsg_parse")

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

diff --cc net/sched/cls_api.c
index 70f144ac5e1d,43c8559aca56..000000000000
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@@ -1951,8 -2055,8 +2057,8 @@@ static int tc_dump_chain(struct sk_buf
  	if (nlmsg_len(cb->nlh) < sizeof(*tcm))
  		return skb->len;
 =20
 -	err =3D nlmsg_parse(cb->nlh, sizeof(*tcm), tca, TCA_MAX, NULL,
 +	err =3D nlmsg_parse(cb->nlh, sizeof(*tcm), tca, TCA_MAX, rtm_tca_policy,
- 			  NULL);
+ 			  cb->extack);
  	if (err)
  		return err;
 =20

--Sig_/ig8Rxox_Ru14hlzWqD3VREN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvGeGIACgkQAVBC80lX
0Gwipwf9FqVC/wokTOmwv2KJ3oSYm/q3NrEFLt43Ib5oyotPln8zMbGkbQ1DBzEI
VIqUTK6Sj2V98uCuUY9ABZ/CFCGPPn7aGb6nJ2+vOG4NTHHizK18z4TvY3QH7lSA
X9zrTeuI1NCsAm+xvq34EDL8BZ7jzwMwV5x7RE4aT8ZVeK/+z0gxWu1RR2GQ+L6A
hgonqUY/yfI8+ORBq72JGvdfQUbCR4L409uxKN731BYJZW/tgyXOrz3MTMwE3sa7
/iLnziESd4X//d5RugDA8Lha993FNLLU9mCczsqAOA6qaJSMs3C6KtT1kLNOWEpT
9w9hIy7XKLVqEE6Cv5IVLbm2HwOQCQ==
=R+Vg
-----END PGP SIGNATURE-----

--Sig_/ig8Rxox_Ru14hlzWqD3VREN--
