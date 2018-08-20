Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6FCC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142EE21581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="VBuE35yi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142EE21581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeHTPEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:04:44 -0400
Received: from mail-by2nam01on0086.outbound.protection.outlook.com ([104.47.34.86]:51544
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726026AbeHTPEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Brs2IwLR5T22EAb6rZmIxLXuxtCu3zqTfo/hXB2nKE=;
 b=VBuE35yiz1ZMlh3tH2XzKJ42c+T3UTuD65OPgiNnf9EGjtkKqbffc4s0Ej5+ZoN3p6KrcsJMijmzA9ORwHrKgE6IH6qry4eBP5ZbkZCQCwB+31uWHy6amaauz5PXMffXqscUbi1D6BgPe+s3uGTgyfTDHET6mJEX58zIlYVBmpY=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB458.namprd06.prod.outlook.com (10.141.196.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.19; Mon, 20 Aug 2018 11:49:18 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1059.023; Mon, 20 Aug 2018
 11:49:17 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: refactor put line fn on read completion
Thread-Topic: [PATCH] lightnvm: pblk: refactor put line fn on read completion
Thread-Index: AQHUOHsK7wqiRWKke0qd7QLJkFpvj6TIhqqA
Date:   Mon, 20 Aug 2018 11:49:16 +0000
Message-ID: <3799720A-6EEC-44BC-A29E-5082659B9F39@cnexlabs.com>
References: <20180820114320.3764-1-mb@lightnvm.io>
In-Reply-To: <20180820114320.3764-1-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB458;6:qfzJXPasXYQLrTUpHcXb6pPKOToQOAqSNrz9YQ4XCzA5GbbLq5mY1PMmVzBu7MmLc/xBvi9mV9b+K5aAt9DWs2C7xo1yerCH1GwWk3wE4/zI2HkkAQILf1TOJtg1ZF5SLXyGUaLSPAUdh/JDNlRukvzoM2Z8vszVPzL0bNoN7oI7ZdmSSTdR5BzxuT3SP/qUKIwJYApd/Cw2S5H0JmYyjHgyirnswnmu1y6puK5BSRFGximUHNIsiAFV7unge3VCcI8g63r3F3QNo/ca9cNxlz8XGZBZbXj10fW2P5usCACcucBJOjY2pSLqF4fYQV91SD+0gzmJ1mmNLP0hr6itf4KvYPYlJQ7Rzz+tdTQ/J7fiypKO5mIaDmy0vycY+srG2hIHbW+1o1VInUGh8jDByx0yovvz1ijkbFlp9VSNFYvFQcpKeip4iyJPd+90whqjQAug951IOZP13Qonbu15YA==;5:fBttHdhNkv0iNlGA8ISupEG5GxSoO+FFIuIEZ6TKYwY9KXGfZ57nwJ6LPnu/pPJDM8zYvp0C2HANLvdYCUULKCYVV25Z3aEiOWqvMqiD+YLgytesiCIIPwuGKSrl5hivc1oRGOWpiM1N5tY1aYE8XtZh6DaTStOEZEw1ianMChY=;7:0Yj49uzo0Kll54kc28SYGwtYpcHYrXkNptck7kArBRd1XsjibRARNXbvMkbdGBPk0FRkgq03F8mMiXuIXx8p1jTBQTWMY5oQi6NHFGqOnankAAAMM4VbwJ2oEAI0igxBoD7TJvy9i4jY5kuuOMUkNcLXmLri58TdKg9eCO1SkqwZistgB3lR3PNoAr7vUCIv73Q4a72VTu32w56xAia6mMPuBduf3gwD2PtMTcil92B26kw+MELaBMOP3dL9tmsZ
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(39830400003)(136003)(376002)(396003)(366004)(199004)(189003)(26005)(2616005)(14454004)(86362001)(305945005)(7736002)(106356001)(105586002)(33656002)(6916009)(186003)(446003)(6246003)(99286004)(256004)(4326008)(99936001)(14444005)(66066001)(76176011)(476003)(6512007)(11346002)(3846002)(6436002)(25786009)(2906002)(68736007)(54906003)(36756003)(316002)(6506007)(6486002)(2900100001)(6116002)(8936002)(83716003)(5250100002)(5660300001)(97736004)(478600001)(486006)(81156014)(82746002)(8676002)(102836004)(81166006)(53936002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB458;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 236a819e-3eec-4f71-6f0b-08d60692f57a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB458;
x-ms-traffictypediagnostic: CO2PR06MB458:
x-microsoft-antispam-prvs: <CO2PR06MB458217F5A07D9471F90AA76BA320@CO2PR06MB458.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:CO2PR06MB458;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB458;
x-forefront-prvs: 0770F75EA9
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: n+BvoW1iL7jM06SQYW8zcu19Rp/KH0ctwDGMxce8uj2eYDRzuP9gxGL8A65oceMNFw+scxNMlgVPO2VGYNWWpsAlh1DfWUGvaqOni3cLvxEJGWyyaPU05qbNax9idLLDoUgxr/uCKTiKT+F08lk93eKTrZAIZESuwlObIK6SrLzfMjKIr0s+eyWxQz0iXsMu+XkOL/iSdVuy5wIP4cOLxEoaHEnZs2Z+eMXgP3FyRgzpsX0vMwtKYTNyet6EI2AzhTJmukmdJgYzDzNQTKJ4keFJGuI26kTnIsov9QlLoxLZwhD4DiysWKcC2xinlkuUGwajOPbg0ZSwdTe4slRskM/JadP2aM1V0EKV7i316WA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_C2EF244C-8587-4DA2-AAC4-DCEA20AF1951";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 236a819e-3eec-4f71-6f0b-08d60692f57a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 11:49:17.0906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB458
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_C2EF244C-8587-4DA2-AAC4-DCEA20AF1951
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 20 Aug 2018, at 13.43, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> The read completion path uses the put_line variable to decide whether
> the reference on a line should be released. The function name used for
> that is pblk_read_put_rqd_kref, which could lead one to believe that =
it
> is the rqd that is releasing the reference, while it is the line
> reference that is put.
>=20
> Rename and also split the function in two to account for either rqd or
> single ppa callers.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/pblk-read.c | 23 +++++++++++++----------
> 1 file changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index cd2f61eed6a0..16858eaf694a 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -165,20 +165,23 @@ static void pblk_read_check_rand(struct pblk =
*pblk, struct nvm_rq *rqd,
> 	WARN_ONCE(j !=3D rqd->nr_ppas, "pblk: corrupted random =
request\n");
> }
>=20
> -static void pblk_read_put_rqd_kref(struct pblk *pblk, struct nvm_rq =
*rqd)
> +static void __pblk_read_put_line(struct pblk *pblk, struct ppa_addr =
ppa)
> {
> -	struct ppa_addr *ppa_list;
> -	int i;
> -
> -	ppa_list =3D (rqd->nr_ppas > 1) ? rqd->ppa_list : =
&rqd->ppa_addr;
> -
> -	for (i =3D 0; i < rqd->nr_ppas; i++) {
> -		struct ppa_addr ppa =3D ppa_list[i];
> 		struct pblk_line *line;
>=20
> 		line =3D &pblk->lines[pblk_ppa_to_line(ppa)];
> 		kref_put(&line->ref, pblk_line_put_wq);
> -	}
> +}
> +
> +static void pblk_read_put_line(struct pblk *pblk, struct nvm_rq *rqd)
> +{
> +	struct ppa_addr *ppa_list;
> +	int i;
> +
> +	ppa_list =3D (rqd->nr_ppas > 1) ? rqd->ppa_list : =
&rqd->ppa_addr;
> +
> +	for (i =3D 0; i < rqd->nr_ppas; i++)
> +		__pblk_read_put_line(pblk, ppa_list[i]);
> }
>=20
> static void pblk_end_user_read(struct bio *bio)
> @@ -208,7 +211,7 @@ static void __pblk_end_io_read(struct pblk *pblk, =
struct nvm_rq *rqd,
> 		bio_put(int_bio);
>=20
> 	if (put_line)
> -		pblk_read_put_rqd_kref(pblk, rqd);
> +		pblk_read_put_line(pblk, rqd);
>=20
> #ifdef CONFIG_NVM_PBLK_DEBUG
> 	atomic_long_add(rqd->nr_ppas, &pblk->sync_reads);
> --
> 2.11.0

Looks good to me

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_C2EF244C-8587-4DA2-AAC4-DCEA20AF1951
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlt6qrkACgkQIX4xUKFR
nnQgkA/7ByvFT6fbi2MayWh8oOGNGPnh07DsmkRFamR1KFHFd0zwNkCDZ00fDXHO
ei7w97fPbI56EziYPMN7vqRRtrCUyyqbiCDsZxttslHFShiV5v8pH+we/Z6OVE/0
GXcASdantM/Bdhd1rmZjOToEtxYqGSbUyeJkI2oBTtBwqJIrGKr5s5CeVrb9yPrd
6dyebJNvNdzzSa/rYt1rIqTveFA3GOr++6yGOnDvHgUMtpc66XQAiaC7Wxh6hwkG
GBpGWWnZKhvTCLVY4zJrcercFR5yAAGvJ3RdMX3qrM/F3yEqeqoOqzeGqeehVP/h
HyhOtvDvUu/KOKNsJX86eI2u0K6lw6rH1wWNHqPZFtPVnDbRuO8GlGttC9OwEFz/
PSdi4WWJLdfY9a4hZUrzfNXSysnIkClEUtxpmGBsjN2HKD0JG7LqAaX/n2lFbsag
rdeVpXvuVVLcSUJZdRzA6AEuasSYxU14cnFUDFj4Wn0sOP/WsJ8tiz2uK/WGFbiW
Da5u0SgynGGQtUpNUWDFAtheSEIFaK1pAAXSoI9envFC13awvQVKxbTifF82UGKI
Kh9989mZDE4naDbEYnCLX8RrRpMsaWoHca5DWbUzZt5Rril/HbMz6hTKIGrMSS4G
wk6IlUFCFhfsvNsUOeeBl6BLTE9uk0rhaoIMBQuNgZh7TvVGNZU=
=2BpG
-----END PGP SIGNATURE-----

--Apple-Mail=_C2EF244C-8587-4DA2-AAC4-DCEA20AF1951--
