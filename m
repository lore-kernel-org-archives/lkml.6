Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0406BC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97779245DA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="qUCgRcDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97779245DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964963AbeF1Hhm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:37:42 -0400
Received: from mail-by2nam03on0088.outbound.protection.outlook.com ([104.47.42.88]:55568
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933094AbeF1Hhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZIVTOx5GgC5M9XtSwZ6PZDnsmErDQxljT+TB49tnqY=;
 b=qUCgRcDWO2fpEcLbC0bSftQMdRT6OY+EQ4ymmwdC40k6aiRkCvWGzFwd1iXK+1ilALllnxxZ3vo/3nEJVvNgWNVpIUuCf2QpSpOCKFlQlx/BjE3aVUSTzQCfud/ygos/sRKOaW5bscB/A/foqzXKpmX1u3GjV3oywvKogRsXDBo=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB617.namprd06.prod.outlook.com (10.141.228.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.23; Thu, 28 Jun 2018 07:37:33 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::bd6c:9a47:d344:bbc3]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::bd6c:9a47:d344:bbc3%2]) with mapi id 15.20.0884.025; Thu, 28 Jun 2018
 07:37:31 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: fix read_bitmap for 32bit archs
Thread-Topic: [PATCH] lightnvm: pblk: fix read_bitmap for 32bit archs
Thread-Index: AQHUDk7/o/IsYoKStkeSRGa3HR3pbKR1SRUA
Date:   Thu, 28 Jun 2018 07:37:30 +0000
Message-ID: <53E32769-D1CC-4EDF-BCB7-4D53DBD6A5A2@cnexlabs.com>
References: <20180627194206.30384-1-mb@lightnvm.io>
In-Reply-To: <20180627194206.30384-1-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB617;7:O8ObdDLmMe633g4WflTYb300Q6rRv4VdBDLl3T1iak3s0cjUi5lp8rcSTUk5v9S9q7v45ctWKxysEcotFvbYGa4e56p3YIEUImpk9+HCZEG/h3rSlOLfsrmIGPkcGU0AhJxAFm8Qql241MY7V+ufoo1G126feNZZ6ypg6vow3jov1RcU53G5mqVasTdMzP78XWvmay5sY7mxrNNMAwfna6AKQrRFL3wDihcM5zH2pWpEvBoLKJrA5ZLi/70rG80Y
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(366004)(39840400004)(189003)(199004)(76176011)(6436002)(229853002)(6486002)(5250100002)(2900100001)(33656002)(105586002)(102836004)(6506007)(26005)(186003)(478600001)(6512007)(256004)(6916009)(99936001)(83716003)(36756003)(8936002)(82746002)(2906002)(5660300001)(2616005)(68736007)(14444005)(106356001)(66066001)(97736004)(305945005)(7736002)(54906003)(6246003)(86362001)(3846002)(6116002)(11346002)(486006)(316002)(446003)(53936002)(8676002)(99286004)(81156014)(4326008)(81166006)(476003)(25786009)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB617;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: d5e40a56-b424-47a0-1fad-08d5dcca019c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB617;
x-ms-traffictypediagnostic: CO2PR06MB617:
x-microsoft-antispam-prvs: <CO2PR06MB617524B4A23E2AACED6D78EBA4F0@CO2PR06MB617.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB617;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB617;
x-forefront-prvs: 0717E25089
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KumKL96MNu8bF5T63qheRD5HpEF3iPwcnR+j4/e4UFTPrbA5R2YyUtNqROhpHlWhbHGwhXrSZYoI1pBh70jhm90pzQyhIPS3Ywgn6kGZYiwmI2J5fqwddpGHMCHAb/rdy3f2YOQ6jU/iPC383tqMRtesOgCoNEJ1bgiX1pXFSAMQDr46xqc+1UNzi0Oq6IH+S/cYM3uXVVvxpaml4uwQ5URp3wZz7johGaHMGFklsQ51ziP6z5vK6vtp/Mvr6SsFoR5Gr8369GPBoO6VrFLh+S/geCX8Ml1UYSXcL6Xcyx3uYWfDqNiIcFKve1Tacis/a4WpI4Nky4+1jpG/6aXIeOoAu9k5IwYkmhXN9txY2ro=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_4CEFB2F5-A288-43FC-8858-94EFF19D6FBC";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e40a56-b424-47a0-1fad-08d5dcca019c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2018 07:37:30.9665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB617
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_4CEFB2F5-A288-43FC-8858-94EFF19D6FBC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 27 Jun 2018, at 21.42, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> If using pblk on a 32bit architecture, and there is a need to
> perform a partial read, the partial read bitmap will only have
> allocated 32 entries, where as 64 are needed.
>=20
> Make sure that the read_bitmap is initialized to 64bits on 32bit
> architectures as well.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/pblk-read.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index 6e93c489ce57..671635275d56 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -401,7 +401,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio =
*bio)
> 	struct pblk_g_ctx *r_ctx;
> 	struct nvm_rq *rqd;
> 	unsigned int bio_init_idx;
> -	unsigned long read_bitmap; /* Max 64 ppas per request */
> +	DECLARE_BITMAP(read_bitmap, 64); /* Max 64 ppas per request */

When we removed max_hx_sect we added a constant (NVM_MAX_VLBA). Use this
instead? Now I see Igor already commented on this...

> 	int ret =3D NVM_IO_ERR;
>=20
> 	/* logic error: lba out-of-bounds. Ignore read request */
> @@ -413,7 +413,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio =
*bio)
>=20
> 	generic_start_io_acct(q, READ, bio_sectors(bio), =
&pblk->disk->part0);
>=20
> -	bitmap_zero(&read_bitmap, nr_secs);
> +	bitmap_zero(read_bitmap, nr_secs);
>=20
> 	rqd =3D pblk_alloc_rqd(pblk, PBLK_READ);
>=20
> @@ -444,19 +444,19 @@ int pblk_submit_read(struct pblk *pblk, struct =
bio *bio)
> 		rqd->ppa_list =3D rqd->meta_list + pblk_dma_meta_size;
> 		rqd->dma_ppa_list =3D rqd->dma_meta_list + =
pblk_dma_meta_size;
>=20
> -		pblk_read_ppalist_rq(pblk, rqd, bio, blba, =
&read_bitmap);
> +		pblk_read_ppalist_rq(pblk, rqd, bio, blba, read_bitmap);
> 	} else {
> -		pblk_read_rq(pblk, rqd, bio, blba, &read_bitmap);
> +		pblk_read_rq(pblk, rqd, bio, blba, read_bitmap);
> 	}
>=20
> -	if (bitmap_full(&read_bitmap, nr_secs)) {
> +	if (bitmap_full(read_bitmap, nr_secs)) {
> 		atomic_inc(&pblk->inflight_io);
> 		__pblk_end_io_read(pblk, rqd, false);
> 		return NVM_IO_DONE;
> 	}
>=20
> 	/* All sectors are to be read from the device */
> -	if (bitmap_empty(&read_bitmap, rqd->nr_ppas)) {
> +	if (bitmap_empty(read_bitmap, rqd->nr_ppas)) {
> 		struct bio *int_bio =3D NULL;
>=20
> 		/* Clone read bio to deal with read errors internally */
> @@ -480,7 +480,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio =
*bio)
> 	/* The read bio request could be partially filled by the write =
buffer,
> 	 * but there are some holes that need to be read from the drive.
> 	 */
> -	return pblk_partial_read(pblk, rqd, bio, bio_init_idx, =
&read_bitmap);
> +	return pblk_partial_read(pblk, rqd, bio, bio_init_idx, =
read_bitmap);
>=20
> fail_rqd_free:
> 	pblk_free_rqd(pblk, rqd, PBLK_READ);
> --
> 2.11.0

Thanks for fixing it.


Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_4CEFB2F5-A288-43FC-8858-94EFF19D6FBC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAls0kDIACgkQIX4xUKFR
nnRM8A/+NhRiFYOLmzpZ8YWr9s6KsYoHqF6zL3alzgsjn2MQFSd11tNJzDXE/miW
nRXr2NRjMx48rCxR4QM9CpeG7TVIY1JSsdZ0g28rA/wYGloc8abCpssl9NZAG2hU
d+7dDvE+//JChMddYKYhr/autIB+AUg1w1R0oJXiVFQ5bLc/MrzNbEOcKOUqi+Zq
G9hixFNHnRqtxPfp4myFlydKokh9vnaGq7bANCUCjmJ+Tnr7Ma+12FiN7busqNjK
NlOKmy+XlyfJNI4bFKFgmNllnT04Np7s1hmxEMyMEsMT07vtgfnIv9myGZGsf50g
KOUmpExV1tPWtzpjJ259uq3VPVA5v5I8ipsh0vHwh28aJ3t0AK0xfYxgC6qdpfnO
h8hHtpMUNZInvqiCU0oKw8HlSDiPuJGYv8CbxQAxnKT3BZQH1sM5M22mLKIc/eZ6
3Mh0ITK0nM5iLd7Mx5on+nwfKy9ps+EVHHM/di+wAAF8tq0YzcJ5J5VhHk+aJJqO
aDbi7/JvYBucI/2gpjM8ehc/eOgsBnwIfaLneE5V8sN8gg0AmFDqBsWjVfUNjGCd
TWMKiFE3zPOAdWmwbXMTmYk0KOKPAOh5wbfjPStjeHCdUKH3rWGj/vVRecgKAA/1
LsHGDye+wEf81GamVRkgFGELqaFYduWRErupDR3+1doSlYSEETY=
=doTg
-----END PGP SIGNATURE-----

--Apple-Mail=_4CEFB2F5-A288-43FC-8858-94EFF19D6FBC--
