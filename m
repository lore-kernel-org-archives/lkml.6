Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C878AC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6193C2154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="L2hmysCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6193C2154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeHTP5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:57:53 -0400
Received: from mail-bl2nam02on0046.outbound.protection.outlook.com ([104.47.38.46]:59296
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726197AbeHTP5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3CLbtYxYwaJTmiqfO/dQ5FnpVAF94sLmceQbOkzOU0=;
 b=L2hmysChwOnB1ekjrFOlDRC6d8u/Zsgq97C+vB3p21UH2FgtxzA456VVpfAqGL2fm52eVt6ICdEw1n2db8WkcAgqoVeX+00O0bS+7KEaUX1yozFrB16Lh5oAAvROUx+CECdkC9MuDqhhR9dLqB968/QvZqYnoUj3qvP531VEte0=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB457.namprd06.prod.outlook.com (10.141.196.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.20; Mon, 20 Aug 2018 12:38:27 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1059.023; Mon, 20 Aug 2018
 12:38:26 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: introduce nvm_rq_to_ppa_list
Thread-Topic: [PATCH] lightnvm: introduce nvm_rq_to_ppa_list
Thread-Index: AQHUOH8QdhXyueLbXEGQ5C79k1Lnp6TIlF+A
Date:   Mon, 20 Aug 2018 12:38:26 +0000
Message-ID: <DA2F1D94-23DC-4739-9056-351992D972EE@cnexlabs.com>
References: <20180820121217.11393-1-mb@lightnvm.io>
In-Reply-To: <20180820121217.11393-1-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB457;6:tRfxR9DaX9hpiltpTEmH6zohkF/m2utmmdLfmDYqCRBN8od5P19Ychjg61M8/6n7lZkKOcjpZwsFo/nEfMNZEbAl0zP6ic+g8YiRHC6mt/Pp8psjRzxTkRe6lVbghO/BEh3zdKpyN4sK7sseMOfALH7rTcBY4QNYy22bgujzPpG56ItRc0D9c6agsffj4vZaXRldwz2UeIqEiLSz3rflr8FFrQGlLnGaBCeDthy2BCYmh5t66aC3KLL/JNSd7KC+VUOrVQaT/HdorXMJ6etZi5CENd7nU8aTtPU9WlFUCewKMK/YllR9zjYtiveuFrqUqRQS1H0aX3Z8jp9OuVuEMLU8lZNhKA2CN518GCnhzSO/Ef/KOLiKFf0DElBjquu4gqyueI66XAXAGOkReN3IxJ9WOAFPAJn2M+2aFs4MFe+bYjN1dgTuYcRK3+kDchmdy6cqfW5SdC20hazYfRpGWg==;5:0j1ZnW8xrZOIHrKdosWM90rz9kMQaGImug/ZrB9Hd5MjKBRyp7DjbEDbDpulmp7YyjO5lkdbsLEns1JEhJx/PHVMbAbAOmW2X5TyLvjuFqgrnxK58bpmzqvPMQt+4OXy1/Zmp8Fue0H5kBxvTUCUUpP3EaiQacbNLiysUA1gE0U=;7:YDMsTUls1AYfe6DtfdIf7C9HnxijQbelyUU0x6j0oNZRM3y/Ap4H0iASuZa+zzVhSWimYzsVgME254vIsFBjKBcO43tSpq6W+FN8xR3w/WBbhDwEIpg4HplOsmEd3eOtkbjgHyp/ey7tl0eAes4GnkeZBo91K6vTsf8foZhw71yEKEU9o0FRE/XKFbzJiHyOkNOZBs/evPk1igaotIPL+RSvMnrzwdYlIgcFUPdNYJ3KtSyWImn4cKXMI7ldVwwX
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(39830400003)(136003)(366004)(346002)(376002)(199004)(189003)(6486002)(33656002)(229853002)(6916009)(97736004)(305945005)(99936001)(6506007)(81156014)(81166006)(36756003)(8676002)(83716003)(5660300001)(82746002)(105586002)(106356001)(7736002)(5250100002)(6246003)(2906002)(25786009)(4326008)(8936002)(14454004)(478600001)(486006)(2900100001)(2616005)(476003)(66066001)(6306002)(11346002)(54906003)(966005)(446003)(26005)(186003)(99286004)(68736007)(102836004)(6436002)(14444005)(76176011)(86362001)(3846002)(6116002)(256004)(53936002)(575784001)(316002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB457;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: a06b6ca0-a19c-4fd4-1dae-08d60699d337
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB457;
x-ms-traffictypediagnostic: CO2PR06MB457:
x-microsoft-antispam-prvs: <CO2PR06MB457DBD87D5C0070DDB68329BA320@CO2PR06MB457.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:CO2PR06MB457;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB457;
x-forefront-prvs: 0770F75EA9
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cgrq/Jh/8ThTj4RMDFRRBwu5QYWpbIwwNce8QU4Z+4SU3A9BaxPzUW3Za0ikAELT1lLcAyDOwNlHnYzhWe3i659MQ+R27jUqJge0c2xDlASS8MldqlUy3huXNhEv/N5DHH5m9prHznsIC6qK6Nd3y3nU4eB6SKMJHLVAD8TSguAvIoCuVrgnjoUzGUbdmAXfixZdZvsY+PM/CJBX020qD0u6yubwNAoXkvTTSIjW8iImjOx9B3anbuchYcfRzWFBESXx7GkFlayfbnoRzPkaoTHJi6McWrAfR2fzwuKYAa/djcI4/iQn4wCphR+MgV/UVXzNqgDQI6onf3Z0nnWjSSQNwjSArhQmezyhBQi/wsM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_9A359065-B7DB-422C-90E9-FD0D027ADBE3";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a06b6ca0-a19c-4fd4-1dae-08d60699d337
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 12:38:26.1308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB457
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_9A359065-B7DB-422C-90E9-FD0D027ADBE3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 20 Aug 2018, at 14.12, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> There is a number of places in the lightnvm subsystem where the user
> iterates over the ppa list. Before iterating, the user must know if it
> is a single or multiple LBAs due to vector commands using either the
> nvm_rq ->ppa_addr or ->ppa_list fields on command submission, which
> leads to open-coding the if/else statement.
>=20
> Instead of having multiple if/else's, move it into a function that can
> be called by its users.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/pblk-read.c  | 4 +---
> drivers/lightnvm/pblk-write.c | 5 +----
> drivers/lightnvm/pblk.h       | 4 +---
> include/linux/lightnvm.h      | 5 +++++
> 4 files changed, 8 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index f275c7e5abe4..696d3a9c9cf0 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -175,11 +175,9 @@ static void __pblk_read_put_line(struct pblk =
*pblk, struct ppa_addr ppa)
>=20
> static void pblk_read_put_line(struct pblk *pblk, struct nvm_rq *rqd)
> {
> -	struct ppa_addr *ppa_list;
> +	struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
> 	int i;
>=20
> -	ppa_list =3D (rqd->nr_ppas > 1) ? rqd->ppa_list : =
&rqd->ppa_addr;
> -
> 	for (i =3D 0; i < rqd->nr_ppas; i++)
> 		__pblk_read_put_line(pblk, ppa_list[i]);
> }
> diff --git a/drivers/lightnvm/pblk-write.c =
b/drivers/lightnvm/pblk-write.c
> index df99c45778d4..a92450ec7698 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -212,10 +212,7 @@ static void pblk_submit_rec(struct work_struct =
*work)
>=20
> 	pblk_log_write_err(pblk, rqd);
>=20
> -	if (rqd->nr_ppas =3D=3D 1)
> -		ppa_list =3D &rqd->ppa_addr;
> -	else
> -		ppa_list =3D rqd->ppa_list;
> +	ppa_list =3D nvm_rq_to_ppa_list(rqd);
>=20
> 	pblk_map_remaining(pblk, ppa_list);
> 	pblk_queue_resubmit(pblk, c_ctx);
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 64ae0c7ed3bb..bda098c7cc3b 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -1335,9 +1335,7 @@ static inline int =
pblk_boundary_ppa_checks(struct nvm_tgt_dev *tgt_dev,
> static inline int pblk_check_io(struct pblk *pblk, struct nvm_rq *rqd)
> {
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> -	struct ppa_addr *ppa_list;
> -
> -	ppa_list =3D (rqd->nr_ppas > 1) ? rqd->ppa_list : =
&rqd->ppa_addr;
> +	struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
>=20
> 	if (pblk_boundary_ppa_checks(dev, ppa_list, rqd->nr_ppas)) {
> 		WARN_ON(1);
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 0106984400bc..1497e275f90f 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -487,6 +487,11 @@ static inline struct ppa_addr =
dev_to_generic_addr(struct nvm_dev *dev,
> 	return l;
> }
>=20
> +static inline struct ppa_addr *nvm_rq_to_ppa_list(struct nvm_rq *rqd)
> +{
> +	return (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
> +}
> +
> typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct =
bio *);
> typedef sector_t (nvm_tgt_capacity_fn)(void *);
> typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk =
*,
> --
> 2.11.0

Hans made a similar patch some time ago. There are a number of places
where you want to use this helper too, also outside of pblk. You can
look at it here [1]

[1] https://github.com/OpenChannelSSD/linux/commits/for-4.20/pblk

   fdd88185bfed
   17609afb2db9

Javier

--Apple-Mail=_9A359065-B7DB-422C-90E9-FD0D027ADBE3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlt6tj8ACgkQIX4xUKFR
nnT1rxAAjxwQ8y0Bmk6XvXQDkGSEQ6jDv010l8Fpx6NcvjL/i1TXw7R9+xUHFtOu
3RqmYlmndmx5D0qjxOyVLQ/G3dGB0yEpK5vE/4al/RDhMRaM4vHMGLioESVuOYN1
jyXVE28XBiumKGD7zkFl/vybxgXxIcHlssi0MaMXFdkaDK2EFdvHEGF7FgihWKam
9oiC0rVMvjVHWM9hg7q8wLSNBjB/OabIWqMPye/WW4cVh3o4mWiU5nATdnwxUPaI
C+EdzwjpUo+5MIIwTtNNutMBdxPFxm9TqjUvCL79DJSWLRRv1Tpi/0LL/hsZykh3
FhWLTWUn/IhqKfirplpsHtDteVv7dIb3rcYJb/GyJkYkVM/OEwRyafTRrM16Os7O
LhOQzD+oi5sQquWkkNtc2f5cYhA9h164HEz030t+55wo5UOAdNhNVN/6oMilMMat
C0afBRp8S0wsa+FMUcZOQ0ooOaZVqrIbpBpQMEwmmL0UFZJod1FMFXqoy9tvjevI
V1L/vKf+yM5H9JgtNE/f/xBuk3A8eHwCHLDjxMefJfkt5SEyOYUtK06vQtRAWbu2
1d2kB2asx/429GDLbA/oHERh5KWcuiq1HfoM8YtkeJ2gaepfi5xGWkD6Ox4ZF3Pi
6/u9ksfgOncEJExgizwgLdI92A85Mr3+0T+FshCP0Q4+mZo+yEg=
=x6bS
-----END PGP SIGNATURE-----

--Apple-Mail=_9A359065-B7DB-422C-90E9-FD0D027ADBE3--
