Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAB5C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1722075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="tEEE8/lC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1722075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbeIFRxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:53:49 -0400
Received: from mail-dm3nam03on0068.outbound.protection.outlook.com ([104.47.41.68]:27005
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727708AbeIFRxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnDn67+ysHP5rnNEMa29gznUOGMHp7Iuil6gwU4ryq8=;
 b=tEEE8/lCM3OvOwR1uMEemPYbn9cY5iyrkMlfAbN4Wo3kwtMuwcwuRAGMomVpZP35KIiA7g0sx+OYquypRWPQDcxJO1N9Q5L1V2klLBrbKkkoXrPd6e2pxSS8eTCMvR6NzuFnG3eMpyfRJtqbh0pJhXv/wQltN+95RhU90foDh1I=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB698.namprd06.prod.outlook.com (10.141.226.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.15; Thu, 6 Sep 2018 13:18:15 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1101.016; Thu, 6 Sep 2018
 13:18:15 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
CC:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] lightnvm: pblk-recovery: lightnvm: pblk: Fix two
 sleep-in-atomic-context bugs
Thread-Topic: [PATCH v2] lightnvm: pblk-recovery: lightnvm: pblk: Fix two
 sleep-in-atomic-context bugs
Thread-Index: AQHURPQaxpk4kdQJu02c2mK8W4ZtVaTjPkMA
Date:   Thu, 6 Sep 2018 13:18:15 +0000
Message-ID: <4FEA8984-5E08-44E1-9E5C-03A6516AF7F6@cnexlabs.com>
References: <20180905084017.27593-1-baijiaju1990@gmail.com>
In-Reply-To: <20180905084017.27593-1-baijiaju1990@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [24.5.37.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB698;6:i2T2fnVhZ+Ro46i9ahfZ+ogkPqxjSADgunXiUVT4JjT2XjMOI0arGqhi+yPHIIviGexEmCAhE9OOpFfhg/jiZoXZb/dktgiBAlsRgFMfI6++V1PwGclPf6nrSyirkZPKtXSr+RC+9jsv6nPCRFK1LePJWI89eLMLoAhdjIAn815Bv1IUeYy5MxxQFFPHLwenFMRdEs9L0CP/2seaQk8lK2ie9AxTKcyGihN96lRRB96GHO96L11738ifSMwkw8KIE6Lx4jbkYwn6QIfPTTHXqVZYvRGi3KCndOugTbtqkwcH9gICCQ88SnmNhuPgalde9GnOKROiW9fs27rkqp3QUpyRafLhhp7jdctbCav4sia/wIFjUEUiq86Ei8legNQyh2enUrUQBiANKb5Cu46jZVXkyvrWG25rTOMEdXC4ofhs8KNi4Msd01FdhqmjzWtkOqINtDW2HkAddC8RT/rx+w==;5:AFATfkb5XcAU1COqZbdHsSAV9fpQ2lBqq2tDUMrHI0XPBMI2SIhmoM+vA/ISLiTgbwimo1+5KmliMJZNlYou7J+syfdB50vzvAx6tEqwv9s+4VgXUFQAG+W9kM2ACgCWx4csibChpO2qUGXFDgjj0cGV7m59zCvbWLeUOhknPbY=;7:7hERoTvHIotRSITVy3fjb2PF1riHIa/GkYrqOVJaeM9XcUw69WGSWieaYuIZFYVk4RAVpouIKkzmm7birbAnyeigaKhRrNMEqECCVGE8xrdfomaJ1Z5GBFrHnT9uRvY6GNo9oTbtb1CE6OVU9szSj0340orGdYbum7Hn/Ml8BgCwAv4lM/kalnf++c8PI/RsiJeI6f/eBAgVoiGz8JjXEGYfMRDeP+4oSwZUyazsd7e+vMKTeyM8JNIRXm8XORxi
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7ee5028d-4707-4260-09e9-08d613fb347a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB698;
x-ms-traffictypediagnostic: CO2PR06MB698:
x-microsoft-antispam-prvs: <CO2PR06MB6989BFE38A2EA88063BD668BA010@CO2PR06MB698.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:CO2PR06MB698;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB698;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39840400004)(136003)(366004)(346002)(396003)(199004)(189003)(99286004)(25786009)(446003)(5250100002)(33656002)(39060400002)(68736007)(4326008)(5660300001)(97736004)(6916009)(1411001)(8936002)(14454004)(229853002)(105586002)(8676002)(81156014)(478600001)(81166006)(6486002)(99936001)(11346002)(53936002)(7736002)(83716003)(3846002)(305945005)(6116002)(2616005)(6512007)(6436002)(6246003)(6506007)(76176011)(316002)(36756003)(54906003)(106356001)(2906002)(476003)(26005)(86362001)(82746002)(66066001)(486006)(102836004)(14444005)(256004)(2900100001)(186003)(31853002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB698;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pBTbGJ4Z6/Wfy4F/4L9GqdXH8NLFpPs5ZBUBM3cb8mXOlE4Dj6I6FhR9AhWAt6Sf0rkt05qC7koLz76Mby6emFt71267XLKKUbhJDaOfF2603kuuRH4gkGYxg+1GOQdlr2GP+aSiEb4ofurgDRqsIG6H9yd1+1b4/hwgxd4ZAAAkyK54IBkffe2GnJO65Zo7pE2g+QHz3ZkNnhDXRwGZ/LBpMaecfZ5qp5N8wzlmsAjBaIkl98UBJBNJGv2LJ//SrqM9jv5oCj1LekOliTFnnviB8qleQjeQdqKHGFeSj+EcFdx32N9yhPJT7T0goLpIT13v/qizXwfRlKPrkU+Tffr21THeEjhOJrnrzWnKHLA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_C094016C-30C4-4EC1-BC7A-5E402DAB2C9A";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee5028d-4707-4260-09e9-08d613fb347a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 13:18:15.6635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB698
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_C094016C-30C4-4EC1-BC7A-5E402DAB2C9A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 5 Sep 2018, at 01.40, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>=20
> The driver may sleep with holding a spinlock.
>=20
> The function call paths (from bottom to top) in Linux-4.16 are:
>=20
> [FUNC] nvm_dev_dma_alloc(GFP_KERNEL)
> drivers/lightnvm/pblk-core.c, 754:
> 	nvm_dev_dma_alloc in pblk_line_submit_smeta_io
> drivers/lightnvm/pblk-core.c, 1048:
> 	pblk_line_submit_smeta_io in pblk_line_init_bb
> drivers/lightnvm/pblk-core.c, 1434:
> 	pblk_line_init_bb in pblk_line_replace_data
> drivers/lightnvm/pblk-recovery.c, 980:
> 	pblk_line_replace_data in pblk_recov_l2p
> drivers/lightnvm/pblk-recovery.c, 976:
> 	spin_lock in pblk_recov_l2p
>=20
> [FUNC] bio_map_kern(GFP_KERNEL)
> drivers/lightnvm/pblk-core.c, 762:
> 	bio_map_kern in pblk_line_submit_smeta_io
> drivers/lightnvm/pblk-core.c, 1048:
> 	pblk_line_submit_smeta_io in pblk_line_init_bb
> drivers/lightnvm/pblk-core.c, 1434:
> 	pblk_line_init_bb in pblk_line_replace_data
> drivers/lightnvm/pblk-recovery.c, 980:
> 	pblk_line_replace_data in pblk_recov_l2p
> drivers/lightnvm/pblk-recovery.c, 976:
> 	spin_lock in pblk_recov_l2p
>=20
> To fix these bugs, the call to pblk_line_replace_data()
> is moved out of the spinlock protection.
>=20
> These bugs are found by my static analysis tool DSAC.
>=20
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
> v2:
> * Move the call to pblk_line_replace_data() out of the spinlock
>  protection, instead of v1 that changes GFP_KERNEL to GFP_ATOMIC in
>  the calls to bio_map_kern() and nvm_dev_dma_alloc().
>  Thanks Javier for good advice.
> ---
> drivers/lightnvm/pblk-recovery.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 3a5069183859..5fde414d78bb 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -955,12 +955,14 @@ struct pblk_line *pblk_recov_l2p(struct pblk =
*pblk)
> 		}
> 	}
>=20
> -	spin_lock(&l_mg->free_lock);
> 	if (!open_lines) {
> +		spin_lock(&l_mg->free_lock);
> 		WARN_ON_ONCE(!test_and_clear_bit(meta_line,
> 							=
&l_mg->meta_bitmap));
> +		spin_unlock(&l_mg->free_lock);
> 		pblk_line_replace_data(pblk);
> 	} else {
> +		spin_lock(&l_mg->free_lock);
> 		/* Allocate next line for preparation */
> 		l_mg->data_next =3D pblk_line_get(pblk);
> 		if (l_mg->data_next) {
> @@ -968,8 +970,8 @@ struct pblk_line *pblk_recov_l2p(struct pblk =
*pblk)
> 			l_mg->data_next->type =3D PBLK_LINETYPE_DATA;
> 			is_next =3D 1;
> 		}
> +		spin_unlock(&l_mg->free_lock);
> 	}
> -	spin_unlock(&l_mg->free_lock);
>=20
> 	if (is_next)
> 		pblk_line_erase(pblk, l_mg->data_next);
> --
> 2.17.0

It looks good to me. Thanks Jia-Ju.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_C094016C-30C4-4EC1-BC7A-5E402DAB2C9A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluRKR8ACgkQIX4xUKFR
nnQFkhAAvP4midbMvRza2U1VfCsqQCUNa8O5AEblpZ3G4SJiU4N9Z9E+I5BMS+N3
5w7Ajku9kBkycCcGV36SOyIgVaSoOEa78c7UJat/+Gj+ZvNsDRlILCcDvNl+ek0g
TqyG7SPXSz5iBL/sDqWw1ZSEpkEQBLhF44WS8Mt/mxIUZNDufz6/9UZpBOaCmo41
a2fRHmTpmKMVG2GOAVM18O1PAyNarS0pcPYKVoFMO6wpIoCd8dF9bOf4RUh+qLwJ
5T1m3Buv1QYW89o+dhjnrq6baRt4r581SBAw3GU1WQRd5HA6BJvqNLcd2Z9S8NJe
+HJymfNoKGstFTH5blP3OsuxedG4OnLODEIFTTOZNE8Y3AFpmTR0xxrbN+I8x1qA
jgEh6QvFwpZ4VW7HuvvfyOjmNcULd0IdSZGcO4XW8vOblA4CPAPLuubsPxvcaL49
gbPM18zpYe8WQXyhvEQoWrNfE0DH3wUm3UUBU+y+i6RDlACjqmgVzTg96z6wAkYz
fwkvtEsjYsRiDpbDf22SZ2DPb7bipoGM5guRwYBhE2FsKvodhpiMKo8lR1PEwOlF
nd2DYjUiYMURTyl7t3BmJeiw1bH2ip2IWwPNi3MgnPpxoWF7djauF/rc6mugVHUI
0riBqh+Z4+/RiBpqSFlhxubD+2DGH50wR7fFfvDpCfOSCbU6BgI=
=R6h9
-----END PGP SIGNATURE-----

--Apple-Mail=_C094016C-30C4-4EC1-BC7A-5E402DAB2C9A--
