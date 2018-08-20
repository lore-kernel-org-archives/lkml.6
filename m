Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89128C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBED2154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="UBAB3LNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBED2154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeHTQsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:48:51 -0400
Received: from mail-by2nam03on0086.outbound.protection.outlook.com ([104.47.42.86]:23293
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726705AbeHTQsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOSS/uc677qw0ml1gKRooCP1Haq3lm6TWFh+ZsTy9FY=;
 b=UBAB3LNWllzvxFcP1cT1DlnDNEizEyTDmawLL48JMDnwqQd9afCL6E+ywUaDrMepk7GcjWyiKRAiBnhbl3eskNM9TxPrkb7HcrNOvoC+qCSXX2QlwL8nJvxtbPUXMaMgpIJfRZ8IVFpM0AzHzXPLn0Cswbr/dTc2ICEmBOrz394=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB650.namprd06.prod.outlook.com (10.141.227.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.20; Mon, 20 Aug 2018 13:31:28 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1059.023; Mon, 20 Aug 2018
 13:31:27 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: remove size and out of bounds read check
Thread-Topic: [PATCH] lightnvm: pblk: remove size and out of bounds read check
Thread-Index: AQHUOIW3rFyfpikJeUu2Y5xWw1mtgqTIoyIA
Date:   Mon, 20 Aug 2018 13:31:27 +0000
Message-ID: <7A5BC594-414A-4851-9F16-A47A98CA0201@cnexlabs.com>
References: <20180820125953.15364-1-mb@lightnvm.io>
In-Reply-To: <20180820125953.15364-1-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB650;6:+Ceuc0QovNTTIxpb2IySBXcCM05ZPpS30/OJveq+SEwdZ+qGmes3Ye2xeQHdi/7qmGiHGCUjuLyG567+lGcfzv5W9AAc6bWZQYkUyEfis4XOCR92R2Af43ypEaWhjRd2bNZWhA7/LPuHmTWS190AyCNDU9S2yyzrD/Hu2947by3m7Z+N3BKaqtQ7ZzFgxufc6fOWNlw7iKY8zE3Pk35YWNGWoddpXQ08W5YpohsO8vMpZmaBmLtPy60tne60mihdOxe9Ln8sdraDlVtOmEr4iF1tTHkcQ3Om5ziog/OuheZTkmRMeOIRpq0+MO5zh8at23FyNYKpBncvwKdgp1nirW49KraDrt+VNfvjqDvEi2Fpef10LpQuqbumLro1+3jcudFfQbgF2L5hvYoYD2Uq8C3N29T2UI8vE5CGdmMz0pAgljmZOWagTX11B0n8sUyP/zzxdaqSjgxYvbaZqsHDnw==;5:sFWQJtIbJIzbnf6+c7FOwsAMiY9IVA+dmp2cz9V1Z8qgoR6pu+busjvwdG38yMOYHaUSwQC5kxfdYEPtETRMPfBHWRwbaJ5qVB5eIDuML7kkcn+9DBCmy8nLGCeXzN/PrcAe6lPRyHOlG0Q1P7c70CLDGpKYw/L1nGwgrWS+TBY=;7:mJOyD/kIQfhGUCTYZTCz/rCSsjufk17CbW6ENJV4JFkzBJ/SOJerK9QAhkj5msdfoY8aiOPt7TWx8FAU5Kdn10BAqlhn2jMIBCgMQaKLlPRDMvvjmiq8bV0wPMHa7mzPSltws73CvtcwWmFkaHUVgcRaKYZhEypTmnA2RTBrnYNDR/iR2zH+T6FqBwOE8J300ZS5iKDhEejqFNMJ9uJ5X4WeIh80AuWYDeustZA3ZNi1m34esJDkPqfojYCzfBXL
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(136003)(39830400003)(189003)(199004)(2616005)(476003)(66066001)(2900100001)(446003)(486006)(54906003)(11346002)(14454004)(478600001)(76176011)(256004)(14444005)(3846002)(6116002)(53936002)(316002)(575784001)(6512007)(102836004)(6436002)(26005)(186003)(86362001)(68736007)(99286004)(36756003)(8676002)(81156014)(81166006)(83716003)(5660300001)(229853002)(6916009)(6486002)(99936001)(97736004)(6506007)(305945005)(2906002)(4326008)(105586002)(82746002)(5250100002)(25786009)(7736002)(106356001)(6246003)(33656002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB650;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 756bc691-d597-4207-cc63-08d606a13b9c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB650;
x-ms-traffictypediagnostic: CO2PR06MB650:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-microsoft-antispam-prvs: <CO2PR06MB65008B6E15E4246DA276D3CBA320@CO2PR06MB650.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:CO2PR06MB650;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB650;
x-forefront-prvs: 0770F75EA9
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yuzSaqA2QU2IRZ5jmuSu3Qfos985as995EjFdoRr8OIdoeLYwNF8B91wjuOB4sU+4MLVH47Np3hdphYDANeRcGxR6KGHiDzRZi/d/UnC8C9MX2pqLtcDlTnNkTf1Gij0rKdssVr1AmP1HBirXIPWD5tG18QJwZPBZFgoy4FGAzt1FLHjVx51q24TLCOZSrLgcCQg8ppj+893ZCKix3m/acBYZYOKWXqaRuHeTDD39vrwo04tbxbcB4e7vqgkeq6M4wKn6Gmj4o0YELnQ8kJ6jMEQJF8cS/yrgW10DdfR4gkBs5YKoDLyotRSmvKbAO5meQ9tUXnwvsO199R64ji/T7EV1w6/NtBjPjqJFXJKJzg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_66145121-FE60-49A2-BF8E-5FD9CABC3192";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 756bc691-d597-4207-cc63-08d606a13b9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 13:31:27.7730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB650
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_66145121-FE60-49A2-BF8E-5FD9CABC3192
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 20 Aug 2018, at 14.59, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> The I/O size and capacity check are already done by the block layer.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/pblk-read.c | 7 -------
> 1 file changed, 7 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index f275c7e5abe4..d0fbd50ecc90 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -452,13 +452,6 @@ int pblk_submit_read(struct pblk *pblk, struct =
bio *bio)
> 	DECLARE_BITMAP(read_bitmap, NVM_MAX_VLBA);
> 	int ret =3D NVM_IO_ERR;
>=20
> -	/* logic error: lba out-of-bounds. Ignore read request */
> -	if (blba >=3D pblk->rl.nr_secs || nr_secs > NVM_MAX_VLBA) {
> -		WARN(1, "pblk: read lba out of bounds (lba:%llu, =
nr:%d)\n",
> -					(unsigned long long)blba, =
nr_secs);
> -		return NVM_IO_ERR;
> -	}
> -
> 	generic_start_io_acct(q, READ, bio_sectors(bio), =
&pblk->disk->part0);
>=20
> 	bitmap_zero(read_bitmap, nr_secs);
> --
> 2.11.0


Looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_66145121-FE60-49A2-BF8E-5FD9CABC3192
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlt6wqwACgkQIX4xUKFR
nnS/iw//QyPjLp7FtuILvIvh9ok+FLTOI3sR5cANLvQhxxjyfaNOdHm/ZW2pGCCD
yEL7cFM2rOl0zfZn7cL/k/p1XWvC8ELYZoKdFOFwGmPZFdWKnROkI+I6cVDvUeJw
4VcG1HA3PdfgXoXSN7vEoKeeGEZUlb4Mn0visHa6sgE5kv695+z7Ne89EeMlUYNb
eqUzc2HF2feVdaoSRqteEgaeAYH54uVIUSCUiUXGVB2L/cEV/BIw+Uwp+eBXmDn7
touB3TscIs3aY6LwE5o3ArQCh3MKBi/NisDfz+r35r9seNoVMvBJn0tPTutkpRdh
0X7JTtGD6t6SXVtvVEni/E3QMW9UPrrMKUlLgFtyZkq9Vua9sM2DP25zEJ5PEshV
yrqzVDbPGyUPAns/Q/9C6Kmlb9kzo1QFddVjH8ZJAnMP4a/oo2mR//6wiSeFIPOO
SZO2b/XVo6WrWCze1N/56s3vvERvYzaGFk4s//uDCGTuAn5jwrle4IVJuqurPQZX
0lHJD4jmPrn32usnHcb0U/TfaDE+oi0sZmu2IwMQCu+TQblCtiK3l3U2b3Sy/P8g
EbylLEB/KnHjujAUf72MVAYNQRXzWE7iB4MD18bm8qq4Gu5f4i1qe6MtjaxmcYqJ
gtFzn6zRyE9D94llrRb9zEpH6Q7PKfrktqOKJwjlNoWcnZM6c+s=
=5YAX
-----END PGP SIGNATURE-----

--Apple-Mail=_66145121-FE60-49A2-BF8E-5FD9CABC3192--
