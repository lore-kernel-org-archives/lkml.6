Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7634BC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 04:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53A220989
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 04:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samba.org header.i=@samba.org header.b="BZi75vRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53A220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=samba.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeIXKHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 06:07:45 -0400
Received: from hr2.samba.org ([144.76.82.148]:27560 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbeIXKHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 06:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42627210; h=Date:Message-ID:From:To:CC;
        bh=WK+VLOAdGLB5Vr4ln49sWjYDj03ccmTQwqX3+LNL0cg=; b=BZi75vRmSRXtR7VPJimjnmxhmm
        hPlDY3QzOZBMmCr83qjYJvhQE0Jaj5Dgdjs+D6iIK5q+BTR7Sy/QJsfz2+2ZaZyoLJORK5n1+VdyE
        +Z1fv/HAu3QmZm5JasVWpCsmSRYOZ+Sevz1H9sRQscVhnuk3t8rUqfHub4vW1QXM/L0Q=;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.2:ECDHE_ECDSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1g4I9n-0007Kp-7M; Mon, 24 Sep 2018 04:07:35 +0000
Subject: Re: [Patch v7 21/22] CIFS: SMBD: Upper layer performs SMB read via
 RDMA write through memory registration
To:     Tom Talpey <tom@talpey.com>,
        Long Li <longli@exchange.microsoft.com>,
        Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Tom Talpey <ttalpey@microsoft.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
References: <20171107085514.12693-1-longli@exchange.microsoft.com>
 <20171107085514.12693-22-longli@exchange.microsoft.com>
 <9b02dadb-d21b-7a8d-7803-910041f66047@talpey.com>
 <a7680efb-6ecf-0f70-2fde-55c2b69b534b@samba.org>
 <699de6ba-201a-fd4f-bcac-234e13f33afc@talpey.com>
 <f9c791af-28d0-5107-e41a-31eee03cbda0@samba.org>
 <de042465-e9b9-3782-00ce-38943053c7b6@talpey.com>
From:   Stefan Metzmacher <metze@samba.org>
Openpgp: id=A3D192CE44EF412517BCED646A739B025C6B98D4
Autocrypt: addr=metze@samba.org; prefer-encrypt=mutual; keydata=
 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 Ng==
Message-ID: <c418b22a-7248-4c00-7879-8b3313e12515@samba.org>
Date:   Mon, 24 Sep 2018 06:07:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <de042465-e9b9-3782-00ce-38943053c7b6@talpey.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="hbGauCvnbeqQ9Rlnq9Q6TVYvuOdzSpiDr"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hbGauCvnbeqQ9Rlnq9Q6TVYvuOdzSpiDr
Content-Type: multipart/mixed; boundary="VlgwhgtDBOfVYKcLNmV0qIkLThSRoyKiF";
 protected-headers="v1"
From: Stefan Metzmacher <metze@samba.org>
To: Tom Talpey <tom@talpey.com>, Long Li <longli@exchange.microsoft.com>,
 Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Tom Talpey <ttalpey@microsoft.com>, Matthew Wilcox <mawilcox@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>
Message-ID: <c418b22a-7248-4c00-7879-8b3313e12515@samba.org>
Subject: Re: [Patch v7 21/22] CIFS: SMBD: Upper layer performs SMB read via
 RDMA write through memory registration
References: <20171107085514.12693-1-longli@exchange.microsoft.com>
 <20171107085514.12693-22-longli@exchange.microsoft.com>
 <9b02dadb-d21b-7a8d-7803-910041f66047@talpey.com>
 <a7680efb-6ecf-0f70-2fde-55c2b69b534b@samba.org>
 <699de6ba-201a-fd4f-bcac-234e13f33afc@talpey.com>
 <f9c791af-28d0-5107-e41a-31eee03cbda0@samba.org>
 <de042465-e9b9-3782-00ce-38943053c7b6@talpey.com>
In-Reply-To: <de042465-e9b9-3782-00ce-38943053c7b6@talpey.com>

--VlgwhgtDBOfVYKcLNmV0qIkLThSRoyKiF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

> They're basically the same concept, it's a subtle difference.
>=20
> FRMR =3D Fast Register Memory Region
> FRWR =3D Fast Register Work Request
>=20
> The memory region is the mr itself, this is created early on.
>=20
> The work request is built when actually binding the physical
> pages to the region, and setting the offset, length, etc, which
> is what's happening in the routine that I made the comment on.
>=20
> So, for this discussion I chose to say FRWR. Sorry for any
> confusion!

Ah, thanks! Confusion resolved:-)

metze



--VlgwhgtDBOfVYKcLNmV0qIkLThSRoyKiF--

--hbGauCvnbeqQ9Rlnq9Q6TVYvuOdzSpiDr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEfFbGo3YXpfgryIw9DbX1YShpvVYFAluoYv0ACgkQDbX1YShp
vVaIWRAAutNfRgEZZpiedTIEmKyYRrGg7snhkmpzG0n/9lbkW+DtyvT7J+5Cx2rh
HsflIB3iGXcdnAKGX3k+VApiEvrB+2ZrH5sIEDQbpmabATbKfW+PEJyO5o27XffA
bajAScF2ctMhDfwGKi6PyATi/toDkHCtz8AGqSuxyvNOQ+Ck6lC/6antiHIzxwEa
iJBQaaYb5XFJlSvG83wpl65l095gYYkPy26HrXO8RqPBSf+AkglQxamMTZWTUd62
oDtSIspBpRbtRznqMq6VFPmUwnOlxu6YrLKLqUQixICIgbAkwxTs8OZz65ilQBrb
z89YP/t8kJzA0uK4IJ+FW4bjiHBnOuKxgAtr9P2qs1/So31pndQy4IRraD3Xbv7J
+vZCudzuOMEw2fwiJZ7C7ZbsbjEr9WagaInY36QX5/khvfvDhGEQYelrITCytzEX
Fcnny+51g32vbcaea5YcOQ1yLGJ6Dq1Z7z5MDvOAhrR4qXf/g0yV1GceYv3G5dTV
XImKO8OJpBsiwCy361OnYzFsspB+GWmMMgh77X3Sl3eibe92lMv6WoN/lvTnqE36
9d7qqRwZYs0Fx7XM/kV+hveHpvTKQIsl2J5SEKHqgHetSbhvyFfFTRuc3JPuROJj
iV1Gx48j+4JUhXgsvetHEuv+MjAFueoB612X0USqvctJvB897mo=
=m9fC
-----END PGP SIGNATURE-----

--hbGauCvnbeqQ9Rlnq9Q6TVYvuOdzSpiDr--
