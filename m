Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5754C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DDE20C03
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="jy266OCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DDE20C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeHTK76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 06:59:58 -0400
Received: from mail-sn1nam01on0056.outbound.protection.outlook.com ([104.47.32.56]:60384
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726032AbeHTK75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 06:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/c5PABLzPIHhsNbPWWwKyH3C42OXZr97y57vMQHXwq8=;
 b=jy266OCxG2YQZS1F9E8RARX+Dc4vZv8v9LqnNhasQ5c3VNPov7oz7+yCnlOwUPpm1w7j/H9hGab5btzoEvN1RDrE2z5GjuWLW5f7A1HIvqmZEOmPmEQlavc04GhAAmS4zqqExttgbv/BFaFOkNFARyAa3sFoPGnTZ9hIaC69D/g=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB649.namprd06.prod.outlook.com (10.141.227.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.21; Mon, 20 Aug 2018 07:45:20 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1059.023; Mon, 20 Aug 2018
 07:45:19 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "Dziegielewski, Marcin" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: fix incorrect min_write_pgs
Thread-Topic: [PATCH] lightnvm: pblk: fix incorrect min_write_pgs
Thread-Index: AQHUNje74YTFtzQQtEOiRe2yqYm48aTIRwmA
Date:   Mon, 20 Aug 2018 07:45:19 +0000
Message-ID: <6F75B3CB-23BA-4CCD-9EA7-8B8B00BFFB9E@cnexlabs.com>
References: <20180817143637.15943-1-mb@lightnvm.io>
In-Reply-To: <20180817143637.15943-1-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB649;6:5XzFEk2lKLpujA8AaStEm0mdK3UZ/5Gmisip6k8yXdDbvFcpB/9PFqY+jZ8+2i9i9hCqkV+dO4vHcWnogAkUbgahDWXJjnDLvFzVYIPCBcpX408e5ih0vqulT8gjTeijctu2Mkqi2jY9sSojwwWtyeyWsam9vs4swKicsnlmy/W9MbYtqQ5jqMYeWVhf7S140S+jQwq8qdaBHXOWLQY3RQEggn+0oFYoavRZvARya/g1uLniRk3+3fTH7mhOROtqtRZvAo6UJGckijwMu3JI0fQa38bkkxnla/vtKM9p6B9/JRc9ruPoLtKyQ5qiuyosDcvF1gbFO4ZQFCtjhO2hkEM6J08GZ5elOFBXXK0J2HwaFN5bKOSpqSyCcazFsjW1yxT6X+tER4akjDAqP6eSpiB3G0eRpYsxAZ2fyp0s7HpBsf78eXNEu5Fzkkaq/pa1fdWDkpl/LW1SZ2HUPD5DNg==;5:WUG3YfvFjLGHlJ04YPCqpTdgbrQ6DCWTAS70r5kRsgo6H/v/LJ7TBode3VA315l8jOzr6aaA7/NGrQRl3nfQ5gKQQMsFdQBJtbz29k5SbMiECUeWX5YF4zk7+4KKLfaJ8TJRGevOWIIFA533ZgHSyJcNV7xwICBF22vqCP+8Zic=;7:2XlkWUxsxnmZNFzCZeMNhgEAgrbbkEuFO2KW0ZQnlMlx0dIMot4hiQvS8ZnrVPBKpemrWYtIyWWIZEi7EcA+G2fjfYWCH9herK+YoHIES70EmXZ3OQRw9lKprbyvOlM1Xcsgzf32vHP08UxkmwXCouiSJf2mS57uNjWqvD9uU/cledL37zcdytljth+e9126EP4SbP/QZpFcCu7kPT5WkEO5NziSr/u47jY5K9lrk9SajqYS6Sgp/wCyvlWnT9gR
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(136003)(39830400003)(396003)(199004)(189003)(26005)(2616005)(6246003)(36756003)(11346002)(446003)(476003)(486006)(8676002)(102836004)(14454004)(6506007)(305945005)(81166006)(99936001)(316002)(256004)(83716003)(14444005)(7736002)(81156014)(186003)(105586002)(8936002)(82746002)(99286004)(68736007)(106356001)(2906002)(54906003)(97736004)(33656002)(76176011)(2900100001)(66066001)(4326008)(6486002)(5250100002)(6512007)(3846002)(478600001)(6916009)(53936002)(86362001)(5660300001)(6116002)(6436002)(229853002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB649;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 45910107-923b-41b4-98d5-08d60670e0f2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB649;
x-ms-traffictypediagnostic: CO2PR06MB649:
x-microsoft-antispam-prvs: <CO2PR06MB649278534CC003B561B4BBEBA320@CO2PR06MB649.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CO2PR06MB649;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB649;
x-forefront-prvs: 0770F75EA9
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pb1GxeYVq+GgoBWcUSOaPapxP8UhxmrxIMZeTAqZ70B3Q4nR5nWU+ftrUZiho/qK1fNja5UZnYwhgDicZTwDpDmz3AbeLHQdduB1uOXyEM5D9l+l2SyYdvWf+G59KPYQuK9yUW268vlvHlpqfui/rWOhIsZ6v6iw1ZPnvj6AXChMug6FI8m81jVzyQGY1mdhVDobO0sxA4VZxntaBSAyHD6zSBlyfRdhdYjRzwgDE9dkp7KOu+mtb887ZAsnxkKekRLbs3u9PodPoElo3QAq5oMe/AwYguIuWu+uZhKVhVqwEECS7k6hMMvK7YS+CEkfNS7c0Jt+lYNYuEpkFTKXHxUQc2cKc07Wsth702v3RcA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_1AF0A1C8-ADBF-41BC-A0C1-0F6D4E82CE9F";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45910107-923b-41b4-98d5-08d60670e0f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 07:45:19.8821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB649
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_1AF0A1C8-ADBF-41BC-A0C1-0F6D4E82CE9F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 17 Aug 2018, at 16.36, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> The calculation of pblk->min_write_pgs should only use the optimal
> write size attribute provided by the drive, it does not correlate to
> the memory page size of the system, which can be smaller or larger
> than the LBA size reported.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/pblk-init.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index 9119c64d6f62..8adc8ac8b03c 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -371,7 +371,7 @@ static int pblk_core_init(struct pblk *pblk)
> 	atomic64_set(&pblk->nr_flush, 0);
> 	pblk->nr_flush_rst =3D 0;
>=20
> -	pblk->min_write_pgs =3D geo->ws_opt * (geo->csecs / PAGE_SIZE);
> +	pblk->min_write_pgs =3D geo->ws_opt;
> 	max_write_ppas =3D pblk->min_write_pgs * geo->all_luns;
> 	pblk->max_write_pgs =3D min_t(int, max_write_ppas, =
NVM_MAX_VLBA);
> 	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
> --
> 2.11.0

Looks good to me.


Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_1AF0A1C8-ADBF-41BC-A0C1-0F6D4E82CE9F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlt6cY0ACgkQIX4xUKFR
nnQNmRAAgJxwq9yBZonp9i4GgHcr9g+7wT0y06HoX1lI64UbdzdSWE5EAXxaGR37
1+0Cw53iF0gwDG79SI4grudAtdMYUxppmHeJDFdOJOedHykiybqXNlRAoCeFx5fa
iBGS9HrAiqHJpQE7Mo5Ov3gCWDPrCgWUq13u3z33vq02t+pk3FLh9Rka71v4ID6k
l9imXjKmDHBfwsqbd8MPmfYvkfLCxg49uTkQ1FAs+q7nJPrfX3fPsvUnDAdul+Q5
KYx7MZNSzyyvuaQJb/wi9sDJBDmEtMAhEJYxw6Fd3tVAMtmFcub4VPLMlm3G23xp
ZI+ili6Wn+pWJ3cbv5MFf44s/1zmtGBsOH9XUtxE40aWqEKL6EJQ/PYXO2G6iRsg
stghihRLfkqAlhEUvtUGHyyVWT4uRPQsse8bDIco4Dr+yA7XiXkPOnn87V8tseUG
PYJ9oD4o2tAtxmLwph3mynNAtErGewleU2A0JqhnY+3/T5W+jWK9OGOwtMOqLlc1
2XRtRzcQotpPzc7hhBWzBFQh5JhN6ulZzAndwftemZPLww/BxZd7dFdFVOBcDjKT
n+QDToOgN3JCmi65B2R7WNUzx15hE3DbksUZyjDEwZU/BrC0ceoD5kCYjjDNgttO
+4CNWJq2SUlktMmrZ25v3c8DzetY+GINZVfiSM0vvcebs73IN4k=
=gWWt
-----END PGP SIGNATURE-----

--Apple-Mail=_1AF0A1C8-ADBF-41BC-A0C1-0F6D4E82CE9F--
