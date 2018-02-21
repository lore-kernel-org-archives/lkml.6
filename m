Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935145AbeBUOpP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:45:15 -0500
Received: from mout.gmx.net ([212.227.17.20]:52743 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932639AbeBUOpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:45:14 -0500
Date: Wed, 21 Feb 2018 15:44:10 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: christophe leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org,
        Joel Stanley <joel@jms.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/6] powerpc/mm/32: Use pfn_valid to check if pointer is
 in RAM
Message-ID: <20180221144410.ckm4m366scrgk2rm@latitude>
References: <20180220161424.5421-1-j.neuschaefer@gmx.net>
 <20180220161424.5421-2-j.neuschaefer@gmx.net>
 <0d14cb2c-dd00-d258-cb15-302b2a9d684f@c-s.fr>
 <20180221135119.d3qgvdck5yruomi7@latitude>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fphdnp5fz5oqdxfs"
Content-Disposition: inline
In-Reply-To: <20180221135119.d3qgvdck5yruomi7@latitude>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K0:ac994PAmcl2wrTMaDfwezMjVQo4p/TKxdZvtptydIM7hzmdWXR8
 KCsYMl1iPrsHT3J/+Af/ub79IjM+0lTo64R+9Iizq1hYvymYWC7jC5N4pZTVxLJe8+0Vbh2
 aOzD9Hgx2BC0zvXM5ibA6dtaQVrAqs/pIPTljmlZa7FPtLS6UEVisRj4VhbYHL6FmU1Z1l3
 0dSVU57uQ40m9sMj8VhSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JAFoGgN/qhg=:a62T0XYHiTUIxkksWreuRy
 OKZtwFsNCfnDOXJCntOU2j6Mdz30x56OVXDkONJzV8F+A9Dxh6ypNIUEnyRN3n8SAjh1SA+AH
 vjHqntOkXjB8xC2dzO6d8pgI5NpIBB79A+EWwwaoAs386VgOfrPr36ZBsrAAYMh9qA7CTQxCD
 FWB4yrZCeVKfmV+RKa2RxY4DscVwelQ9rMD3/Fnqu0d0ii6QEZvY/59neDKdAxQQrHrEwSoqX
 U1TF353Alwjo8mZ2HBSM1FWxqgLTDDwdjYs8eJrk5UdAhDanlyNSOchwqb+iiRNC+prcuII2N
 niMqNiuZZwU0S1GsHiAcpRUMEeAJhAbvtBbky1F7Hg15ogfQxxHsSOAzreQmpqDv6BoV45+8N
 UjA1luo/o1OvcpK5wOhlU+EiBDjW/VTf2VeYwxUQznWKYSGZvgApPgbSGLEznWLx88lDC1IDR
 J86ACFm/XdfXObQK8HpAw3EbMCIzXu2nd1PmlljgqlNoXM+Sjo6TS61yrvBePvFaxHXGhUUUR
 Yg8P0kzH8bTRmzR/L3SDnunExeoazvku27BUMNLyYTy5bZmecP/C0SGYe/ZQJLpISvOLkIvZU
 By+8gk8kaEX0Zfiyuo8LUmd6a6To8QnEqEi79k4tXwRcA4vJmdS6IUsQ0ATQ5RUs/bq5jtXXI
 GYrbH/aq4RRvqGuTaQ+kC+xomMnH26Usx1a28VaQZDYQ2JrwusUJixTNUxtW8QrsggToPvi9B
 noRkqOGjQkhV5ZXEZpRfefIJoMw/5eH49mAIbA85QDUmuuYQeZKmDHeKb3ZTEt7EHVCQbxxir
 WSAG+qvoP8gwVrT2Wc/k7BD6ntRzQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fphdnp5fz5oqdxfs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2018 at 02:51:19PM +0100, Jonathan Neusch=C3=A4fer wrote:
[...]
> While looking through arch/powerpc/mm, I noticed that there's a
> page_is_ram function, which simply uses the memblocks directly, on
> PPC32.

Oops, I misread the code here. memblock is used on PPC64.

> It seems like a good candidate for the RAM check in
> __ioremap_caller, except that there's this code, which apparently
> trashes memblock 0 completely on non-CONFIG_NEED_MULTIPLE_NODES:
>=20
>   https://elixir.bootlin.com/linux/v4.16-rc2/source/arch/powerpc/mm/mem.c=
#L223
>=20
>=20
> Thanks,
> Jonathan Neusch=C3=A4fer



--fphdnp5fz5oqdxfs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJajYW6AAoJEAgwRJqO81/bFD4P/jXB4GtqWaVXyc+1KcLnz2dz
y1sAXcvxMgvHA+saHWsoUzMD1T8QR+7Q5N5PKUFmeWPDLAjAJq8LyuVt/oxsey5f
EnBNlLGohqO4uF934qHvrDnfyopqesJWAx/v3/ioMAc34b5LX7wRH234hV1H/dyf
U85qSkTHTpH4bRxZyXwddsJFtEfKkE34oupi4YU4AX5VctNzCuW9eR4GE2BpJ6Iw
ibMaw/9U3hOO6ok2Wa3h6GgcqcNH0uD9TFLnvLbjCZJzCsGjCui/TGTb5tysLsoM
4qhJsJwSo0GAAzxtrrKevrV6qEezwFUIGk/certOiAz8BGhmOYqDFoItiYpYpf0K
aHrDj9MoviIaqfIdCfZCGp0t6fnt1cJb7a/wkbkORfqrsTjjZb0UTwvEgCIhrcy5
L9MEh7p2HLgwlRzW6nlZI6RdpuJK65RnVfIYN0Y+VVt4riBkMRBSiRs/wMFNI2YM
I41aDYtkpSl9ve0V+h+gUS/vjqaE8MkZlNobTt1TW+qmPPmquaHvLekeC27dGtwu
PlfOjWYMceMyqRd4iIcRZ2eQEUvslg9g94Yyl0FmFDMQLCJM1f6PW8FEKlA8pGSL
h+BwphnRhFAABKHC+0AaKpaBOWM9OVwL+LWkeeQifRao1IpL1Ml+E26Xl7icqIFE
4uM02EJ0azFFfpUdczVu
=K2aT
-----END PGP SIGNATURE-----

--fphdnp5fz5oqdxfs--
