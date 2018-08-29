Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E339C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47F120658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="hfECBVQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47F120658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeH3ARS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:17:18 -0400
Received: from mail-eopbgr720043.outbound.protection.outlook.com ([40.107.72.43]:11881
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727392AbeH3ARS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObQjPJapf7n+Bs95wypQEuFBU4tWgUeWSMxR9FHWaO4=;
 b=hfECBVQMztwKMZ/Mm9EV33zXKn3KzV4TFwehyQmWJ47LAZi3o2uCu9xaPqO1dUMq7RpyJKpJyIIJ2LZ+Kr4ncq+FRXarrU6yGgMkYdaIennisth7Sw6BomT+SbsRN0H3LTRUPRYOSv9ROjH2YYp6WNok1zt+cskBc7/3BzwRxbM=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB618.namprd06.prod.outlook.com (10.141.228.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 20:09:40 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1080.015; Wed, 29 Aug 2018
 20:09:38 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     Hans Holmberg <hans.ml.holmberg@owltronix.com>
CC:     =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH 4/4] lightnvm: pblk: add tracing for chunk resets
Thread-Topic: [PATCH 4/4] lightnvm: pblk: add tracing for chunk resets
Thread-Index: AQHUP5Q5peEXJ8m9BE6osSkOzYSKDaTXKUCA
Date:   Wed, 29 Aug 2018 20:09:38 +0000
Message-ID: <AE72A23A-F779-466B-89A7-846A232DD9B2@cnexlabs.com>
References: <1535545877-770-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1535545877-770-5-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1535545877-770-5-git-send-email-hans.ml.holmberg@owltronix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB618;6:C6H3OMPdUmg6E/v98DF0KIYsgI/zBJHyca6e+yxU061BrKi+CX0EOFZk4ouhoN7ZvEmkUmctM078k/C4aoV7yCdBz0cjRYclUj7FXZT+YDhKLe1+JkluNV0PF2P8cYijZ/nXXQG/Mdw8ncMQ8999SUiYXLST51W+VuC17k6Kq5TZ4cxV0lmAXH5rElu+z/YzMksb37yri6rFfC3chyMY+epYOH+52ofqX5XH6YRhazk3QHUBeyRhWktA79b3vfQlxLmBY7UWQ2ZhG18eYTet264uAW9JLq4jB2SfSSsexhgsHBMCuPAjScQgaMItebnJ9TQSGHx3u5VLheW+iexF+siPahGDk1JYDJ2qP3a+7GnSlK/tr6GZ7CEdVD+58CwmZhXgO8OlSczTMMWhwynSuPVb57NcaRsRUKC5XP8jg9zdbq+Gk0epi7L41fO7pIFZVBw9905phjBX4UxspOWSTQ==;5:W5ICO3Cj18z2/cEBnwkiBsL2iTpnIlzvpFjO1fIAsMgVlTwfAui+3Sn+PJ5pm3QEIm1SWD7lxnzzZU183cNciHseHHbNtuLqKy/yvU9bJQ5U3PKggMQAVL9MTUOiR2ZKza6cHwECYHX5JfJ/wJ2Zhkb0zf5PEGBDYKXgP/0xtss=;7:2y8zuljzcYNIMnXWpnsJEeU4s5+NNMX0FK6LUrZ0/LmanJJxEpgskYRww9c+UWuwBXLBouuleTGwmoVTX78DjpvfANPMqjWeaXhPgxkPnFwNidah9b5JV2sdmo3EseOLVe6HRrne03G5JW6A6bJtECK5b9oGRvFb2LJiSTqVmcaka18dOD/zvHIIzpOk0UYVdHZfSXLL6RLEeDiWJgRhIm2eexqh+4NJbmoUieV4opqPwBrsk5Lw961EcY22Px67
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39840400004)(366004)(396003)(199004)(189003)(256004)(14444005)(99286004)(446003)(102836004)(186003)(5660300001)(478600001)(66066001)(316002)(2616005)(76176011)(476003)(81156014)(11346002)(6916009)(86362001)(2900100001)(26005)(81166006)(6506007)(54906003)(6512007)(4326008)(6246003)(2906002)(33656002)(36756003)(25786009)(107886003)(83716003)(486006)(82746002)(14454004)(305945005)(53936002)(105586002)(3846002)(99936001)(106356001)(5250100002)(97736004)(6116002)(6486002)(8936002)(68736007)(229853002)(8676002)(6436002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB618;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 9d981855-b7a8-40d0-7178-08d60deb5937
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB618;
x-ms-traffictypediagnostic: CO2PR06MB618:
x-microsoft-antispam-prvs: <CO2PR06MB6188FC1B80EB6472040E36CBA090@CO2PR06MB618.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:CO2PR06MB618;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB618;
x-forefront-prvs: 077929D941
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zuXe7OAW6Gzp/696ICpz5uOq0mcPH1RynZh6Kcffn7A9aRq/gCoFjEGYinNhAfTSdgp4fQAE1+rOgaXY16HMGJTNvaQecGPQJhiQ58ByLonfknJcGGBHd6JydAk6iDrFYcMGkv8FsJMrYjh3ot3CuMWRMcv9geiHMk8aukV+5zDAWkmnj+JcgWitYnbWHo9FBUvNXCU6vldK6FcIxlRz7oVuE1OLZIT/q5l/0sDVyntP/O3m/2Kf3GE1ueMVQOi1Nb2WfXhKDFxc1yNt2Wp+8iljmA1rAZa0tR+zyJCH8Q9i5ecPgRXkeoNm3nO0M+P5s/xDSdNnxeurugsBWSGiw6x8vf9REgdxFf5Eg/qaDzg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_CB620C91-DF80-4D28-A9CE-FA7AA977389B";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d981855-b7a8-40d0-7178-08d60deb5937
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 20:09:38.3414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB618
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_CB620C91-DF80-4D28-A9CE-FA7AA977389B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 29 Aug 2018, at 14.31, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>=20
> Trace state of chunk resets.
>=20
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> drivers/lightnvm/pblk-core.c  | 12 ++++++++++++
> drivers/lightnvm/pblk-trace.h | 31 +++++++++++++++++++++++++++++++
> drivers/lightnvm/pblk.h       |  6 ++++++
> 3 files changed, 49 insertions(+)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 566a5d3165ee..b874001d1175 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -90,9 +90,15 @@ static void __pblk_end_io_erase(struct pblk *pblk, =
struct nvm_rq *rqd)
> 	atomic_dec(&line->left_seblks);
>=20
> 	if (rqd->error) {
> +		trace_pblk_chunk_reset(pblk_disk_name(pblk),
> +				&rqd->ppa_addr, =
PBLK_CHUNK_RESET_FAILED);
> +
> 		chunk->state =3D NVM_CHK_ST_OFFLINE;
> 		pblk_mark_bb(pblk, line, rqd->ppa_addr);
> 	} else {
> +		trace_pblk_chunk_reset(pblk_disk_name(pblk),
> +				&rqd->ppa_addr, PBLK_CHUNK_RESET_DONE);
> +
> 		chunk->state =3D NVM_CHK_ST_FREE;
> 	}
>=20
> @@ -958,6 +964,9 @@ int pblk_line_erase(struct pblk *pblk, struct =
pblk_line *line)
> 		WARN_ON(test_and_set_bit(bit, line->erase_bitmap));
> 		spin_unlock(&line->lock);
>=20
> +		trace_pblk_chunk_reset(pblk_disk_name(pblk),
> +				&ppa, PBLK_CHUNK_RESET_START);
> +

Can you move this inside of pblk_blk_erase_sync() instead? I was looking
at the code now to implement a different thing and it is confusing to
see tracing inside erase_async and not in erase_sync.

Thanks,
Javier

--Apple-Mail=_CB620C91-DF80-4D28-A9CE-FA7AA977389B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluG/X8ACgkQIX4xUKFR
nnQeTg/48XG9dPgdwv6BwnYYiRWe0dxxUWZ4D3emWcY1mHgaLZMGcQBaQMVJ6kit
4e73epVxLC/12qSPVvFqT5YmJAkTafbB90IZaWzplW5BlUaMkAk633x0GV6jUx9J
ujjDXmg6N3SEPgQznUSo0gQR8R5EGDKHAo5MmEuQcj8htJEppsKmXHmJjhU2tifc
FZdi7tmNpyamLZmxZ/F+wbXRxCajEpK6TVNlYHVPSug4ygntGw+twjhEt1wvO0Fr
sqMQfytLHmMV0yTlGZJKTI47C3i8AaOx38hh9pUJidShliF7HRgAf+eAe7nu7Haa
cHya9anQjsj4aH4Qgz8wNb3ozxK+316Wsws4KUK6zRYG5ZTY+YExt069/TaFMXGt
5dg/baP7nCU2zzj/72vbdhKttxRz6/6yjzhFGn5Rqy2l5wFLaV4ncmPN7AU7dhlF
AkK52cFgvWUkLT2S4aln1Ry4dlUYYG0HzH7NdZs/fm0tthfXWXWGk9zz284HimUT
EGY4V5Bu2ldrbcotYBr2QSYbfTo7G0lABQTWs2kAaBkJzFjj7V2IVlzzCnzrSlqN
y1fIDlqRUQyX5Yg125FAn3sAwX7FPky1KF1iKPUVxt44mvXA0WUvnWHDCixA6j1s
mL311dWIqvZPiO5806djma5kgQa95fGydbILbu8AscK/NApBjA==
=QK3p
-----END PGP SIGNATURE-----

--Apple-Mail=_CB620C91-DF80-4D28-A9CE-FA7AA977389B--
