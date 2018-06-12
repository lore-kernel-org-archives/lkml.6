Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 47B06C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4567208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="mWuoLAYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4567208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934095AbeFLOgs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:36:48 -0400
Received: from mail-sn1nam01on0060.outbound.protection.outlook.com ([104.47.32.60]:44032
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753979AbeFLOgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4arxaihXhxrNbQItsn9XqFSDSzHSXplwRLuj14IxTJw=;
 b=mWuoLAYCuymKBAWEK9oMExSxNAYosSTn8FjslfO5XrSoxZ74wjpHEO3Eb+d/TJlb8lECZe6Pw52RXqvbc20/nuURT8bbnC8PAxQ5MYhG6vSOmfy6OyEOieucJLf5cChJUJs7Mblp+ZNt0reniiMZN5WWvKZKkqvoGhB8j2Dcrug=
Received: from DM2PR06MB544.namprd06.prod.outlook.com (10.141.157.151) by
 DM2PR06MB846.namprd06.prod.outlook.com (10.141.101.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Tue, 12 Jun 2018 14:36:43 +0000
Received: from DM2PR06MB544.namprd06.prod.outlook.com
 ([fe80::214e:f707:ab4d:55b1]) by DM2PR06MB544.namprd06.prod.outlook.com
 ([fe80::214e:f707:ab4d:55b1%7]) with mapi id 15.20.0841.019; Tue, 12 Jun 2018
 14:36:42 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        Marcin Dziegielewski <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: limit get chk meta request size
Thread-Topic: [PATCH] lightnvm: pblk: limit get chk meta request size
Thread-Index: AQHUAjhrzIKvgNFbA0Op4IduTQuotKRcsRqA
Date:   Tue, 12 Jun 2018 14:36:42 +0000
Message-ID: <D7A9D9EC-6182-421C-9A74-C03598483F16@cnexlabs.com>
References: <20180612103008.19436-1-mb@lightnvm.io>
In-Reply-To: <20180612103008.19436-1-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [216.243.17.15]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR06MB846;7:IFCGEWjsrLYhSF+5NzsaTqOWYXLFiLJT/IYTkhKuCo8Y2DCFiMdoPnpSGgLr+qyXUZK1yZmHpoG7o3seYgqPn0Nzwh3NlVQgAgFwPt71w3iR84+/OUaDLq9S26jMhbW7FxI7Ue9M1F8CdoMAHrfuQjN0s9yUJOH9ki+2rpRF+vewsrseTURpcu0qgWhrjnDL6gNqWx3G3G3fyBS/H+PBBzkkEQfgCTfTV4l3MJopclVGDY9em9aA425q0Tpazvus
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39380400002)(376002)(366004)(346002)(39840400004)(396003)(199004)(189003)(97736004)(59450400001)(66066001)(76176011)(3846002)(6116002)(316002)(186003)(14454004)(6506007)(99286004)(575784001)(86362001)(102836004)(54906003)(26005)(68736007)(229853002)(6486002)(7736002)(99936001)(305945005)(105586002)(106356001)(82746002)(36756003)(8936002)(81166006)(81156014)(8676002)(6436002)(6512007)(5250100002)(486006)(33656002)(4326008)(25786009)(53936002)(446003)(83716003)(2616005)(6916009)(2900100001)(5660300001)(478600001)(11346002)(2906002)(6246003)(3660700001)(476003)(3280700002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR06MB846;H:DM2PR06MB544.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(49563074)(7193020);SRVR:DM2PR06MB846;
x-ms-traffictypediagnostic: DM2PR06MB846:
x-microsoft-antispam-prvs: <DM2PR06MB846476E34A4D65DFC12D6F6BA7F0@DM2PR06MB846.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM2PR06MB846;BCL:0;PCL:0;RULEID:;SRVR:DM2PR06MB846;
x-forefront-prvs: 07013D7479
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ujgvifl/eViMeh7irgAs+0BQrEy7zPe+JyiXoe+TG0bkteM65wHHXq1tgB/apBydV5VR2UKrN0/QTQHe/7y4ux4CPY/5moIYIetmNoq4iRi0vr2GvJuA6vj2/Bae3+ZXmfC88cwSPNbjfEZ+edLEbj9H3H8Yl1H6RG3OQnE28EBCuxwXrwtIJf7Pg5G/zgm2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_A3A1AA09-F5B8-4F74-94DB-61857C4BD37B";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: cb0d3bbe-2dc7-472c-fc66-08d5d071ea2f
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0d3bbe-2dc7-472c-fc66-08d5d071ea2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2018 14:36:42.0447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR06MB846
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_A3A1AA09-F5B8-4F74-94DB-61857C4BD37B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 12 Jun 2018, at 03.30, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> For devices that does not specify a limit on its transfer size, the
> get_chk_meta command may send down a single I/O retrieving the full
> chunk metadata table. Resulting in large 2-4MB I/O requests. Instead,
> split up the I/Os to a maximum of 256KB and issue them separately to
> improve I/O latency.
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

Looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_A3A1AA09-F5B8-4F74-94DB-61857C4BD37B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlsf2ncACgkQIX4xUKFR
nnR53BAArw+N/V/M+tkKTo/6nwccBX3v3xjUfluFb0KZpHgjbnCcL7/zQVZAsaXY
hjRqshku+3hOiil7JZewDis6YvKcdJdKUBYiDZ0dh1YeNJ8yPjFqavwI4JtNZZQ2
B+gAuUBghcZ8C5dcWK6KK7FCJjuB8PCzp2zCdtD4L3USGtgAW+vv3faTsIb+YL58
xf7V4ekdwr+9UFXNTXqLA+YWjaI38s/JyYHNbJ8Jn2UAm4XCisCTA0HLWoc9JDyR
DwmZtomzwT73GvFb4GpuHI1Vu2uA8+zJ6dDFcPt61cxuuE7rywCBupNt9ROX5SjG
5uiwq+obXOlEaFfs+qVe5TAgvQ8K9011aBItCfdpqbAwWPHuvptr2spZWMRklqX9
hdsE8K70RxGKGWmIJVScjyZCrjuU30d0ipcn8GngpEwNAQTQ6GC+kvJeGw4e+e6U
Mg5UXxoJnhgThL/PZ/5hnpnnIF39M6N7qKItgc1wOuleLRXDjJCb6LXPeuUEW4G6
0V3z/rZG1T0r2TmS/6UPgjajwZZNnC8++EdcWk/pJC+HnJ4ZWxVQd+iolXf6l16r
TIHj6sOQwn5z9H2SlrUiu6Eid3t7ZkB1rQuwsdFhSMKcKwxHQT2J7JpdegY6B1xi
OvQne/sQiY7A/8vFq+9vIfrVCKmsvJESG9KgVv9W10NsQl1llZs=
=Dw7H
-----END PGP SIGNATURE-----

--Apple-Mail=_A3A1AA09-F5B8-4F74-94DB-61857C4BD37B--
