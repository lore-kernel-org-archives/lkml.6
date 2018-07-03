Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FBDC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFA524972
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="V9NTP/aQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AFA524972
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934656AbeGCTKt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:10:49 -0400
Received: from mail-co1nam03on0058.outbound.protection.outlook.com ([104.47.40.58]:7305
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934471AbeGCTKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jqysh64xV8eo8ptpKr+Wi0Kga/zoAfZg39/EP6NXmE4=;
 b=V9NTP/aQNmyinmc2v3jV+OGiJk71IXDgVkce13d9c0bJ3s5FldYHV061C5D6305fnAyciTIbtoZd7fDJmisUkshhODHu2xVC6pRQf+0sBjylQjrGSOeTG6ojlqGSWOm8xIQPZzeWHURsNsr/nDFz6utuachGgY7ZMMA9lL5JLSs=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB474.namprd06.prod.outlook.com (10.141.197.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Tue, 3 Jul 2018 19:10:44 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::f168:d301:338d:cdc2]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::f168:d301:338d:cdc2%5]) with mapi id 15.20.0906.026; Tue, 3 Jul 2018
 19:10:41 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        Marcin Dziegielewski <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: limit get chunk meta request size
Thread-Topic: [PATCH] lightnvm: limit get chunk meta request size
Thread-Index: AQHUEdsSzTW28Ywxt0+HVRJbpGneyqR931SA
Date:   Tue, 3 Jul 2018 19:10:41 +0000
Message-ID: <C0B26672-CFD1-4058-A979-48341CD40F8D@cnexlabs.com>
References: <20180702080223.13214-1-mb@lightnvm.io>
In-Reply-To: <20180702080223.13214-1-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [84.127.177.10]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB474;7:+8yPVmUExFLKuCYYn4hg9zZeGNuOS0/3UYIXkf68e52a+4kuza/ZP5VV60/z9sQYc3aZ4zpGYqhh3R3zfaD82FsncpepIKjRDAG/Gyb5BWV1sYOgqILK6hRHYWbUb63GZZ40GSNU3bRYLkk4wdaPAQKd0dyw4RT4LeXkwwTMBMvtVhz2qUfK7oYRCnAKMcHUIsYLypgPe4dQLuRm/pcxgRePN0CAib6epkmpv3CobeRrg3iTi/x0oQrldv6kUL8Z
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(136003)(39840400004)(396003)(366004)(376002)(189003)(199004)(3846002)(446003)(6116002)(36756003)(4326008)(53936002)(99286004)(2906002)(476003)(6306002)(5250100002)(83716003)(6506007)(14444005)(575784001)(54906003)(68736007)(5660300001)(2900100001)(6512007)(97736004)(86362001)(11346002)(102836004)(316002)(256004)(66066001)(6486002)(25786009)(486006)(8676002)(8936002)(81166006)(305945005)(478600001)(7736002)(2616005)(26005)(99936001)(6436002)(966005)(33656002)(81156014)(6916009)(6246003)(105586002)(76176011)(82746002)(186003)(14454004)(229853002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB474;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 94f036e7-f46a-4968-8f3a-08d5e118ab92
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB474;
x-ms-traffictypediagnostic: CO2PR06MB474:
x-microsoft-antispam-prvs: <CO2PR06MB47496E4516AE7D00D2D3B21BA420@CO2PR06MB474.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB474;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB474;
x-forefront-prvs: 0722981D2A
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: p0rYC5LMAKkKZDbLgytVUo7gCywz4zM7LZLLajpeQ8PARuU2DIfoVqgfFeDWYsoXAr6pvpmAiBI6ihFXt97J4EchMkwk28rVk10j2LH9TBh6XNMWmYdjtrO+eOXggZYmv9ZDzmRfHuWP/9bV4ibSVluqF9evaDcCRTCBh9l7+uCZxmIdMDOQwSD0kkq+nySFXtI1ZDgxe+NoILgdN2kEl9CiGLw14LA9tc98z4xE/mKHJEX8ccHDZnFBClEtDOkYpnqD6BF3BYtZe6fYpsHMkENTg/Djkdls9+lfnZmyKmap9f5ZEFkPRHlg8pFsttGCG/C6KVySPOnNRY8bG5HTy48wIHlZtQnL9bHSQcXAs1Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_59F92423-0367-4A59-A1D7-ED3645C2C1A5";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f036e7-f46a-4968-8f3a-08d5e118ab92
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2018 19:10:41.4735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB474
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_59F92423-0367-4A59-A1D7-ED3645C2C1A5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 2 Jul 2018, at 10.02, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> For devices that does not specify a limit on its transfer size, the
> get_chk_meta command may send down a single I/O retrieving the full
> chunk metadata table. Resulting in large 2-4MB I/O requests. Instead,
> split up the I/Os to a maximum of 256KB and issue them separately to
> reduce memory requirements.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/nvme/host/lightnvm.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
> index b9989717418d..3b644b0e9713 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -583,7 +583,13 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev =
*ndev,
> 	struct ppa_addr ppa;
> 	size_t left =3D nchks * sizeof(struct nvme_nvm_chk_meta);
> 	size_t log_pos, offset, len;
> -	int ret, i;
> +	int ret, i, max_len;
> +
> +	/*
> +	 * limit requests to maximum 256K to avoid issuing arbitrary =
large
> +	 * requests when the device does not specific a maximum transfer =
size.
> +	 */
> +	max_len =3D min_t(unsigned int, ctrl->max_hw_sectors << 9, 256 * =
1024);
>=20
> 	/* Normalize lba address space to obtain log offset */
> 	ppa.ppa =3D slba;
> @@ -596,7 +602,7 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev =
*ndev,
> 	offset =3D log_pos * sizeof(struct nvme_nvm_chk_meta);
>=20
> 	while (left) {
> -		len =3D min_t(unsigned int, left, ctrl->max_hw_sectors =
<< 9);
> +		len =3D min_t(unsigned int, left, max_len);
>=20
> 		ret =3D nvme_get_log_ext(ctrl, ns, =
NVME_NVM_LOG_REPORT_CHUNK,
> 				dev_meta, len, offset);
> --
> 2.11.0

Is this a v2? I remember seeing this patch being posted before [1]. It
still looks good to me :)


[1] https://lkml.org/lkml/2018/6/12/466


Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_59F92423-0367-4A59-A1D7-ED3645C2C1A5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAls7yisACgkQIX4xUKFR
nnRDDA/+KbFS+nGNrqgPl/LT0WTpGRc92+NWgN0znZZgOoDEQdDIs+AQV32/stx1
79ZKS3Jize5l3Le4oiJYoG9KXfwpr0t2Ev11QgvDU66vO3vUJNLIl59onY/6WiWX
e8mfBZOJ7RlzjFESrw+8SUF6mImthK9zCZAujmw/GOKwu/ziRYLXl34sCnKECFr0
7OaaPmw9cOuu7im7x7YAS8wJddIxYS3a74+mvSPSfs3aXkuGGNuVlTQwFUQlnPu7
yI75XROVMny21stk5BqBIGz73ELDwOxHxVG3jVR88RQGyIbiPZpLa7dRdIURsxAL
k2z1zYEBB/8HaB5+WWYYChbf9ykeYfCv5SulBAsZDxwWSSqvlpuKmtlQ8YG/C1Su
bKgqU2aNOjdbaMzxkrr0OTXULUt5jLe73eHaNY54LojcEypY2smgevWqs2EYcPiN
3XSN82WXbVTMSNy28BfT4QDyE3pLEM7V25qhEhNuLaT6eZqTgHD7gxWugLNsLQ3z
JwDRXGNmPfXaFOvP88ld1E4nVd9Sc0SqF0Z1KEVVaIHaLUVTneyRSvNdjIXm9d5A
iSVePj1wtcI8AihErf02V9Q+jo9bWZl/w5R9o9fBgtTSclFFIZ2TyOCX0hp1ZeVx
oPYiCpkZcduavLl0O87Z0ACjj2jR+PaP1MNbTXmOydivmmAo6QU=
=SBoZ
-----END PGP SIGNATURE-----

--Apple-Mail=_59F92423-0367-4A59-A1D7-ED3645C2C1A5--
