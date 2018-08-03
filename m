Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED05BC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D15821759
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="CLG4dPq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D15821759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbeHCOV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:21:29 -0400
Received: from mail-sn1nam02on0066.outbound.protection.outlook.com ([104.47.36.66]:2272
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727540AbeHCOV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWCewmMV0e3gffh2FAVLyCwpBto4Iw78oGi4Jk8IlfI=;
 b=CLG4dPq7dnoxtmyy+jKSSYHChyRj8h0xURrPuIcAredg9/Vk1JJm1FK3O7UmXV4iO0nDUk4RU9ldGWS2t9iIsc9f1/zPXu6xr9l3QRnGJnVLLeSuaP7L7l+LU4tndkggEsGzIF67E7ZLnKx4m2L0/vxUif2BvLJ74iHYEXOSUlo=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB521.namprd06.prod.outlook.com (10.141.198.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 3 Aug 2018 12:25:18 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287%8]) with mapi id 15.20.1017.010; Fri, 3 Aug 2018
 12:25:17 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: fix rqd.error return value in
 pblk_blk_erase_sync
Thread-Topic: [PATCH] lightnvm: pblk: fix rqd.error return value in
 pblk_blk_erase_sync
Thread-Index: AQHUKqJ7213aOTW+NES0Fo6wM3pZaqSt9MoA
Date:   Fri, 3 Aug 2018 12:25:17 +0000
Message-ID: <A68E3E50-F18C-464D-8596-A6E269568B1B@cnexlabs.com>
References: <20180802205023.29094-1-mb@lightnvm.io>
In-Reply-To: <20180802205023.29094-1-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB521;6:WomW0a2GKTC6EaZQ6TlRgViUz4HwuRm57IdYhKkndXt0DU2OiitsWQzuWMCxb5eamj0a3UvhK0kFgx3RuNsQVupq5HO/uwLyVu6gsaHC3f8nlNRUTGiIbZx0f6ugnJVoCAZEo2G5bfOtCAYaldj0+69XzFMfbvDQmIIApWBWw3+8CTYCPQnXzw7xbQ0g9ZtSGF87VzavXxz/ZqAZVUwc+BIW/Adi9klzLuuuHxX10RTgszjoalkUFYBZMKM+wDauXIqyjhDuWQ5mHQNZHqCiWkXN+69X/LOr1VApN/HFXgbez8UltodSzulyd5jVehHqQntKUcjZ4W+oIwd9QE/dDngOcdrcNTyqc5XJ+43nuUZHY5MRbD3cNjhDJnY0WlrthYwhFVjMBOwfGEOWtFs9wcPkk2J8EYbX8coli86qLKUW84oqbZh3FXWIEZpcyCH4ipLsNLwASKw+j3xBG7Ip+g==;5:tkdqQk5bba1GbxP2plfzrPXyInIHqVpVRH7qnPlyYJViVXJxlNr+aFIhtVUq3ttay4LBGEd9wLx9XAh9eroeD4Iy6ZeKiL7L+qWILL6ANOTwrSVruGAbyofy+/ROQvgvyqFGNjYYVgQWQDTbKp66YmlV9AFQC3QblWdp83dqhao=;7:E8TkCl3rA/MIxyyQxmYq/zUf0KQohJglpPmH3my1Ixx7+PIsq5QbLO209RV3ugwwJ9takjJHJQUGGCjAx4rB1zd8DsIOhMUUlZy1a27UM+idWjqWGqyt5QKGNA4hIfGMVmVMXbfF405WXzWd8cU5B6bos6nXjW6v/2obK/Ym0Ace6N7lmNEUrRcTiCn6xgeO6bdZY/O8YX/3sRlWc8eypIpnE3gtLqQOKuTMrDkJ67ErGQc24G41gSZ/7DyyCeuw
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(199004)(189003)(305945005)(99936001)(14454004)(99286004)(54906003)(7736002)(105586002)(86362001)(68736007)(2906002)(498600001)(106356001)(97736004)(82746002)(83716003)(6916009)(446003)(33656002)(6512007)(81156014)(8936002)(6506007)(81166006)(476003)(186003)(76176011)(4326008)(6116002)(3846002)(5660300001)(256004)(14444005)(25786009)(486006)(8676002)(66066001)(2616005)(102836004)(26005)(229853002)(5250100002)(6246003)(6486002)(6436002)(53936002)(36756003)(11346002)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB521;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 6b0be359-62dc-4c75-e4a1-08d5f93c2c1e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB521;
x-ms-traffictypediagnostic: CO2PR06MB521:
x-microsoft-antispam-prvs: <CO2PR06MB5218415C7D86A2637D3AF5EBA230@CO2PR06MB521.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201703061421075)(201703161042150)(20161123558120)(20161123562045)(20161123560045)(6072148)(6042181)(201708071742011)(7699016);SRVR:CO2PR06MB521;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB521;
x-forefront-prvs: 0753EA505A
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: deIYwT11BW6j4rWTS4JqMdUNs62/UlYFpIOgDS42TZWfpp9QAZSaXnc3cBE8fd+Itoyohq7TTZzYuzQ7vHZ+t+6JgpxcNwoXdfzsOcF/cU+W+f48kQbLGvzHIBb5vPrzm4hEuKVDxP/DCo42rMWnbL0OFGwt+DsRo9T2cDc7pGln980hU1HkkqOSAeZsecvnqIg2+aoV5udQoeInl7ZxBKJFLMTrF4akk2Mrz0/XRa4XYdZXp7CGXBOp+QOugOoxrOeCCHNPkgZEv19ioAXxJhOVt9bVFFgslimznUXbvZ1ZCa6BKNcS1H0TEROao/IKHOjmSMj3f4H3Dj/rZb8lwiaOUDtBVHdisECV0FGrZJM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_6CFDE94B-5740-495F-915C-065BDBC33459";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0be359-62dc-4c75-e4a1-08d5f93c2c1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2018 12:25:17.4317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB521
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_6CFDE94B-5740-495F-915C-065BDBC33459
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 2 Aug 2018, at 22.50, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> rqd.error is masked by the return value of pblk_submit_io_sync.
> The rqd structure is then passed on to the end_io function, which
> assumes that any error should lead to a chunk being marked
> offline/bad. Since the pblk_submit_io_sync can fail before the
> command is issued to the device, the error value maybe not correspond
> to a media failure, leading to chunks being immaturely retired.
>=20
> Also, the pblk_blk_erase_sync function prints an error message in case
> the erase fails. Since the caller prints an error message by itself,
> remove the error message in this function.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/pblk-core.c | 19 ++-----------------
> 1 file changed, 2 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 72acf2f6dbd6..814204d22a2e 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -886,10 +886,8 @@ static void pblk_setup_e_rq(struct pblk *pblk, =
struct nvm_rq *rqd,
>=20
> static int pblk_blk_erase_sync(struct pblk *pblk, struct ppa_addr ppa)
> {
> -	struct nvm_rq rqd;
> -	int ret =3D 0;
> -
> -	memset(&rqd, 0, sizeof(struct nvm_rq));
> +	struct nvm_rq rqd =3D {0};

This is a matter of taste, but if you want to squeeze it in here, it is
fine by me. There are other places with the same pattern; if you feel
strongly about this then please send a patch changing it in all the
places.

> +	int ret;
>=20
> 	pblk_setup_e_rq(pblk, &rqd, ppa);
>=20
> @@ -897,19 +895,6 @@ static int pblk_blk_erase_sync(struct pblk *pblk, =
struct ppa_addr ppa)
> 	 * with writes. Thus, there is no need to take the LUN =
semaphore.
> 	 */
> 	ret =3D pblk_submit_io_sync(pblk, &rqd);
> -	if (ret) {
> -		struct nvm_tgt_dev *dev =3D pblk->dev;
> -		struct nvm_geo *geo =3D &dev->geo;
> -
> -		pblk_err(pblk, "could not sync erase line:%d,blk:%d\n",
> -					pblk_ppa_to_line(ppa),
> -					pblk_ppa_to_pos(geo, ppa));
> -
> -		rqd.error =3D ret;
> -		goto out;
> -	}
> -
> -out:
> 	rqd.private =3D pblk;
> 	__pblk_end_io_erase(pblk, &rqd);
>=20
> --
> 2.11.0

Otherwise, it looks like a good cleanup. Thanks.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_6CFDE94B-5740-495F-915C-065BDBC33459
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltkSaoACgkQIX4xUKFR
nnR+DA/9EySYmNcWyZ0WN+88lnj2G6a8ZH56shSoGUVA7umVerp5JrnXupTx8ajx
WpiTYEVl3ubRZJKekqQw8jGjx/kSUJS7DvnuQiWQF3feWV/y3ExpjSALGEUEkPqR
F1an979L35HFQ3tBs9xDgp5uGiMb9VhK7+7jxGUiPXab0EY8wz/ZbwlA83A1Qu+d
DD+Nw0Zmn+8218R7/Gwvoj/+I8L6Ppiti7JbRsH+/RqBwZcIhfsGs4Q+epvonR67
Zowtn3gYWaMG3AglktyCN0Vo/bar+UNG2wOlO51NiFeMC+1DBUcMGuFXVPNR2M8O
8L+Y9YHxDNGH1sKMQ65cY3rlmcgOcr2b7cDa01XPsosv1PY4wt0cUb6I1zTepMtA
hY2ztQcr5JU5J9ONQpBHEah63SqKz9M7ILY5t8K79b0dKC18Teu5LpCXg6OrTebI
nItG3nAx2mrPrBq2zmbNkLSC2ExRTEnaFwVk8V7qcLL1bRRyyUTEEJhiRq15d9ca
vJ//8XrYoFY3Isc4q4g1bniBmcFR17DJBjP9iU2VejWoBHDUKyFff7ePS1FrINfc
5MrxVsbB6oMtxeuqjn0Fkhsrsakdz4RRqDIYIwbBE+5591d3fsh+FL6wxqFloUWu
FuhUx1SMbUxzwwe+TrzdD+g7Sy7y5TJyu3mY49ndQEfP2UF4nDk=
=0sX2
-----END PGP SIGNATURE-----

--Apple-Mail=_6CFDE94B-5740-495F-915C-065BDBC33459--
