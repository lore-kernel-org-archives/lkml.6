Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51F8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA2D222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LKU1HmOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbfBLVuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:50:35 -0500
Received: from ozlabs.org ([203.11.71.1]:52839 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729056AbfBLVuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:50:35 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43zbtb1KDbz9s4Z;
        Wed, 13 Feb 2019 08:50:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550008232;
        bh=49hqv4p3pVPvTZL4Xk70DRB9LX3EPPgatZq97oW67dc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LKU1HmOIO3epGaXa5BAbzIZu8EAwOfV1QHeshXRwkW0JS1+AKMsx8CBPPDBAzgtsa
         0MOtHYWH+f9R2ecOR1THjx1SpU51riHhA7xoOOXtcQ5MMT3JuBlgiswt2RNxh4gsqa
         lyBiuxOTxGfviQbL+taiOYZvoQf/trlqgLDySqvpwLEZPPWrCxJ8/+iFrRbCHi1cZw
         XrKCLeNORMRy6V2LwTd6c3yvMlYTP6gJAoTqB9VBIlk/PxxASF+e2snJGiZ3hGss8A
         S0Ys8e0/IX4p4TJDiKLeWru/Vglc26P4+dDwtajR3aG3mIM4W8C8LZaxTRxIyJbgLu
         4+7IaxXXuoehg==
Date:   Wed, 13 Feb 2019 08:50:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Prateek Patel <prpatel@nvidia.com>,
        DT <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RESEND PATCH v2] of: fix kmemleak crash caused by imbalance in
 early memory reservation
Message-ID: <20190213085028.6199594b@canb.auug.org.au>
In-Reply-To: <CAL_JsqKbCg-rGmLoA3mPv54=LMuQBfevfzL8f2QPVyjN-sNk8w@mail.gmail.com>
References: <d4facdc2-0581-929f-caa2-b9efa9bd8f97@arm.com>
        <CAL_JsqKFT8J6g02gxeBiTfBb_XHhp2-ZNB6DgaLPK85kNZGRig@mail.gmail.com>
        <20190121143704.GE29504@arrakis.emea.arm.com>
        <CAL_JsqKQb34zVNTzo9DLNiDwmWGxkrKezSOjwCUPAvgzUoLYjg@mail.gmail.com>
        <20190121174234.GC26461@rapoport-lnx>
        <2bb30550-435a-046c-4f45-21dd594aa695@free.fr>
        <3c886941-bf9d-f040-b568-ee7a8eba9a04@free.fr>
        <CGME20190123055509epcas3p18a6d66fa08412f2308cb2c1997328ea8@epcas3p1.samsung.com>
        <20190123055414.GA4747@rapoport-lnx>
        <78f4ea8a-996d-038e-9e33-5ff02fa2c43f@samsung.com>
        <20190123123143.GE4747@rapoport-lnx>
        <4b8f82c4-7f8f-b814-c1ec-9902e43963f6@free.fr>
        <617e0d57-342d-4162-bd21-ece18e481d87@free.fr>
        <CAL_JsqKbCg-rGmLoA3mPv54=LMuQBfevfzL8f2QPVyjN-sNk8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JPO/7kBVJB2lzUw1s4ONsFn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JPO/7kBVJB2lzUw1s4ONsFn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 12 Feb 2019 10:03:09 -0600 Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Feb 11, 2019 at 10:47 AM Marc Gonzalez <marc.w.gonzalez@free.fr> =
wrote:
> >
> > On 04/02/2019 15:37, Marc Gonzalez wrote:
> > =20
> > > Cc: stable@vger.kernel.org # 3.15+
> > > Fixes: 3f0c820664483 ("drivers: of: add initialization code for dynam=
ic reserved memory")
> > > Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Acked-by: Prateek Patel <prpatel@nvidia.com>
> > > Tested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > ---
> > > Resend with DT CCed to reach robh's patch queue
> > > I added CC: stable, Fixes, and Prateek's ack
> > > Trim recipients list to minimize inconvenience =20
> >
> > I'm confused over commit 3532b3b554a216f30edb841d29eef48521bdc592 in li=
nux-next
> > "memblock: drop __memblock_alloc_base()"
> >
> > It's definitely going to conflict with the proposed patch
> > over drivers/of/of_reserved_mem.c
> >
> > Rob, what's the next step then? =20
>=20
> Rebase it on top of what's in linux-next and apply it to the tree
> which has the above dependency. I'm guessing that is Andrew Morton's
> tree.

Yeah, that is in Andrew's "post linux-next" patch series, so if you
rebase it on top of linux-next and then send it to Andrew with some
explanation.

...

Actually, if it is intended for the stable trees, then presumably it is
intended to go to Linus for the current release?  In which case, the
patch in Andrew's tree will have to be changed to cope after your patch
appears in Linus' tree (and therefore, linux-next).

--=20
Cheers,
Stephen Rothwell

--Sig_/JPO/7kBVJB2lzUw1s4ONsFn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxjP6UACgkQAVBC80lX
0Gxd1Af/X/POcD2JFjdULDi4gafDQGdD7vHNAwxHv1cEsZya9qxI4jaizyGaa8ro
H302lo5ePJ+agKJg6ioTT1S5627lS/WDvkV2yXViIbhnyGaVHgXjGUzWViqk5vHL
jMh+fzPeo4y+3mC6Uxr7K63KtETWx5/v8vOpJqkyFi0fec9y40AcdEnJL9rjwk5X
HojKsTkCYuLVsexYnvKtxQUuS41yOQcImG95dTfXnkcSEQt7BVMnW8O9x9Dsxt9G
O6on/yAOFOfaXbkFMpUj73diBAonJDgzUH0KJHqPfzP1vTYDsVLVvTRG6FRqT0z+
K0lciMgb6B0+VFztin/cNle9sPz58A==
=/0Ru
-----END PGP SIGNATURE-----

--Sig_/JPO/7kBVJB2lzUw1s4ONsFn--
