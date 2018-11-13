Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62494C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107F9223D0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pv5B675g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107F9223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbeKMQfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 11:35:50 -0500
Received: from mail-eopbgr140043.outbound.protection.outlook.com ([40.107.14.43]:65310
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726173AbeKMQfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 11:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3ZeVjK2z8NmXFX6t9Mw1AEc9Tb6N9xOhnOE5WjOc+I=;
 b=pv5B675g96OHW9xbCsOKNfrIlLQH5D+VmiCfrD6C9IrLNdBRAQgiePjNLj0n5yzTFBAat2fQ3sUXAz0DFsfq+Jv0glW08RP9fQk7WB968l0t5LuSHOhocyhFPGUAuIlpZflYBqyfjFMjPjnQDj0oJ7fvYpLmaIWgtpK0cNQf+54=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4350.eurprd04.prod.outlook.com (52.134.122.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Tue, 13 Nov 2018 06:39:07 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::297b:bb50:9b83:48e1]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::297b:bb50:9b83:48e1%4]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 06:39:07 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Huijin Park <huijin.park@samsung.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bbanghj.park@gmail.com" <bbanghj.park@gmail.com>
Subject: RE: [PATCH] mtd: spi-nor: cast to u64 to avoid uint overflows
Thread-Topic: [PATCH] mtd: spi-nor: cast to u64 to avoid uint overflows
Thread-Index: AQHUexBqbt0eeQqRQEukLqVsw8VKuqVNQClw
Date:   Tue, 13 Nov 2018 06:39:07 +0000
Message-ID: <VI1PR04MB5726AC01619141A6135280A499C20@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <CGME20181113051847eucas1p1fb080ea1727b8be444bf3bf6aeb746f0@eucas1p1.samsung.com>
 <1542086318-18416-1-git-send-email-huijin.park@samsung.com>
In-Reply-To: <1542086318-18416-1-git-send-email-huijin.park@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4350;6:Z2Ja35w9mzG8GxWXJabZdS4AwKMHq9r9U3e5ciEjdA3bTjcPy+k6hY5aKaOH0b0ARV9+6dD2gsDTFFU3ABrVscltg490hy1aWi2Y2bTbBxCRgUO7Gx+gQ5/pq8paYC7axSgl4StQHz6UFAVRsIX23SLLQPZq1N2skd5XbTrzRNJYXNH79X0eekI48G9NsLyJg+XEN8vcN5oReY7+gMlmHvmRDU/x0HZOJDScF2U+pOTDwAOax+qfO1O6bYRxeBq1hRDf72Xt4pp3NaeZc1K/x5WlBw9/I8H5sZW3JSevXuD/8dn3vx9MiouvAg+i94VuoRkCoL9H3uv+IH14sfDE+zZ+ia3uWEgZ4+/kNnn7k4Syb+XRv28Xehrk68+UiD/mNVZIcU6O7bZfLcwFQdSQ+5c2PB1LNaJ98D9wt3olB18BOwXpLfSEZGrXV/dEjKOmypzUgTJvEhNH26ZqdtBscQ==;5:74zdDUu4LiMUQzK31Yhj3f3vEFAOoLT4Q9CjxQAIKtGJqbsxNDtGvycbEjR5ueGLBwt9QNkbDU/reiIJx++YL8qXWT3p6HnyuYUfFZFsBUblL6QI3WHWZTnjJJmxHlF2nF+mjfyfYIK8pYa8m/bC/NutcLzr+plZibZQ1aj2qs8=;7:M05AybEGVAQNggWqsl0VAesizA2IE6V1NIIo8sB2G1Z48hyzB39drga/E39SnfQ7z6z28PC48AgxUHaa6d2596khq9/wk1SEhqcse3eh5On17tod7C7zwvtj7O8ZMPM1V8kQe8f+05K1gMwmu/qCPQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9846f058-ec1d-478d-01fd-08d64932b63c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4350;
x-ms-traffictypediagnostic: VI1PR04MB4350:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-microsoft-antispam-prvs: <VI1PR04MB435001D0F0D9D9DC0A54795C99C20@VI1PR04MB4350.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(9452136761055)(85827821059158)(45079756050767)(189930954265078)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231406)(944501410)(4982022)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4350;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4350;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(346002)(136003)(396003)(13464003)(189003)(199004)(8676002)(26005)(8936002)(2900100001)(33656002)(6506007)(97736004)(14454004)(102836004)(53546011)(81166006)(81156014)(55236004)(256004)(14444005)(316002)(54906003)(110136005)(99286004)(4326008)(7696005)(39060400002)(68736007)(66066001)(2906002)(25786009)(6306002)(45080400002)(6436002)(9686003)(55016002)(966005)(76176011)(6246003)(53936002)(5660300001)(86362001)(6116002)(3846002)(186003)(11346002)(476003)(446003)(229853002)(486006)(478600001)(78486014)(105586002)(74316002)(7736002)(305945005)(106356001)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4350;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: p3czO+/x2aL5paJXnJJYpmLXuRbLqBsjY7rkRCE8Mo5uNVf/CjxQ2AqPiKkdysk3QTaQJrFvX1oC+6tm6pJEjIIueIYvfDWmfUDq6t3ZFCXo+FFvCjze+MrMMSYqWd0QOmpU0y44X7Oi3yfEoMbpIlZs8zFPg6Kod1mRinxeAR2237wPXmHRxLiAScj2Idd9NTVamvjlvk5gGmQ9YC9Yw9bIhPRcYbhoXiuzrtqdWWQbCCpaPnc4NB8N/zBqZ+1I1LJjAmryq9+czoYRpOmmrcqsGAL2xGmSKrE3i9Bv00NPN5CyxTiwP2mmNG6jTNKKEj/NgKWjDtJma2HyIDbdWrt1S4ZeZi9E1/yfO5sNyRE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9846f058-ec1d-478d-01fd-08d64932b63c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 06:39:07.2911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4350
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huijin,

I guess this is the v2 of previously send patch [1], please follow version =
information in patch submission.

--
Regards
Yogesh Gaur
[1] https://patchwork.ozlabs.org/patch/961197/


> -----Original Message-----
> From: linux-mtd [mailto:linux-mtd-bounces@lists.infradead.org] On Behalf =
Of
> Huijin Park
> Sent: Tuesday, November 13, 2018 10:49 AM
> To: Boris Brezillon <boris.brezillon@bootlin.com>
> Cc: Marek Vasut <marek.vasut@gmail.com>; linux-mtd@lists.infradead.org;
> linux-kernel@vger.kernel.org; bbanghj.park@gmail.com; Huijin Park
> <huijin.park@samsung.com>
> Subject: [PATCH] mtd: spi-nor: cast to u64 to avoid uint overflows
>=20
> From: "huijin.park" <huijin.park@samsung.com>
>=20
> The "params->size" is defined as "u64".
> And "info->sector_size" and "info->n_sectors" are defined as unsigned int=
 and
> u16.
> Thus, u64 data might have strange data(loss data) if the result overflows=
 an
> unsigned int.
> This patch casts "info->sector_size" and "info->n_sectors" to an u64.
>=20
> Signed-off-by: huijin.park <huijin.park@samsung.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.=
c index
> d9c368c..527f281 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2459,7 +2459,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
>  	memset(params, 0, sizeof(*params));
>=20
>  	/* Set SPI NOR sizes. */
> -	params->size =3D info->sector_size * info->n_sectors;
> +	params->size =3D (u64)info->sector_size * (u64)info->n_sectors;
>  	params->page_size =3D info->page_size;
>=20
>  	/* (Fast) Read settings. */
> --
> 1.7.9.5
>=20
>=20
> ______________________________________________________
> Linux MTD discussion mailing list
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flists=
.infr
> adead.org%2Fmailman%2Flistinfo%2Flinux-
> mtd%2F&amp;data=3D02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C5efd964
> 86c7244f430b408d649278b65%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> 7C1%7C636776831529836639&amp;sdata=3DA7hiJMpfxXKTyT6yacIougPRGdHg2o
> pL492y3sVtQek%3D&amp;reserved=3D0
