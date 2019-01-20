Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D437C282E6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5842084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aysO0v1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfAUHx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:53:26 -0500
Received: from ozlabs.org ([203.11.71.1]:34299 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbfAUHxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:53:25 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43jWKw2QGGz9sLw;
        Mon, 21 Jan 2019 10:36:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548027414;
        bh=nok9NsEALwOgfalHKqYvUouWFMWNI07EpBqMG5JgqQA=;
        h=Date:From:To:Cc:Subject:From;
        b=aysO0v1sFz00rfJvK4OtENMLjuMuvbO6eH8MNp/p17a6BXjen0jRZMrhMAety9qDH
         bjfnyPfs5xjFxg6IG2aczZTBm3n5rwRJiTKn/69LMxhkYjwjx3MQOgO/o8TBxy0dS5
         AEFkDwjj1nCacV53crrIIldO0gM+EO+AZxFPvBSnY6c8IPttDrJ1IwWT9iTSM6vDnm
         wdNVVqZGKef44Q49I5Tu8lHJqmMGu2Nn9HsdNdA3cB40HSLNpgFTwIqnQdx/LSUS7x
         jWoDjm/3xGf67up63Dh3+28ETLLcd/zST7cES1BJPHuh+ns583OezVIc+JNtkHvW9P
         6BhaBvbTGe4FQ==
Date:   Mon, 21 Jan 2019 10:36:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Westphal <fw@strlen.de>
Subject: linux-next: build failure after merge of the netfilter-next tree
Message-ID: <20190121103645.0b35e3e4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/39TvkDYx5Z=SJAGKDz/nWJl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/39TvkDYx5Z=SJAGKDz/nWJl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the netfilter-next tree, today's linux-next build
(powerpc ppc64_defconfig) failed like this:

ERROR: ".nf_conntrack_invert_icmpv6_tuple" [net/netfilter/nf_conntrack.ko] =
undefined!
ERROR: ".nf_conntrack_icmpv6_packet" [net/netfilter/nf_conntrack.ko] undefi=
ned!
ERROR: ".nf_conntrack_icmpv6_init_net" [net/netfilter/nf_conntrack.ko] unde=
fined!
ERROR: ".icmpv6_pkt_to_tuple" [net/netfilter/nf_conntrack.ko] undefined!
ERROR: ".nf_ct_gre_keymap_destroy" [net/netfilter/nf_conntrack.ko] undefine=
d!

Caused by commit

  a47c54048162 ("netfilter: conntrack: handle builtin l4proto packet functi=
ons via direct calls")
  e2e48b471634 ("netfilter: conntrack: handle icmp pkt_to_tuple helper via =
direct calls")
  197c4300aec0 ("netfilter: conntrack: remove invert_tuple callback")
  2a389de86e4a ("netfilter: conntrack: remove l4proto init and get_net call=
backs")
  e56894356f60 ("netfilter: conntrack: remove l4proto destroy hook")

I have used the netfilter-next tree from next-20190118 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/39TvkDYx5Z=SJAGKDz/nWJl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxFBg0ACgkQAVBC80lX
0GzwxggAlD/QHSO46gzZjvAbjO5ybAOhCBZ3zslZVI0wx2mmfRC/OkusnwmEjRZz
yF6uLhAvoP3gg+ivv5t1jaHdIGztgZFLIMrTnAs9yaleriUI6l4Hv04MtlywOD8Y
pBqzKymgVsy9TFV/ceAJ0HgbQjxOcquHt1FwWnDZnsN/MbHgwk+fo6QOtN07BnPx
eekr82oPoPI1z7KeZs+nFT/GjeL3zJOgTUuHLUnl8ulQDmjs4U17y1NiTeNtTsI8
xXhfkKz8sUVm+VYzlCnlgIzcCFte1vWrnPxPq0DkJuBjKvr8Yeg09V+TxrFBEPSP
ig043THL9MP7rj4tymRgQIsDdgTCFw==
=glZA
-----END PGP SIGNATURE-----

--Sig_/39TvkDYx5Z=SJAGKDz/nWJl--
