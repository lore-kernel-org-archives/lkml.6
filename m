Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCDCC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537BA20865
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="arU9WOBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537BA20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633110AbeKXDkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:40:39 -0500
Received: from mail-eopbgr20087.outbound.protection.outlook.com ([40.107.2.87]:47391
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729195AbeKXDkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWSZmG+1QfJIZmk5rMCZ/xleZlSQoFgfbd9dKaeUxnc=;
 b=arU9WOBmy2i/Xdh0E8cxLoNe7OPhg17q5WBBF/WgaH/YU7hi2jFRn07a1GPBglvMpq7v1Fegt5n1L8V5FMdMgP2meCljZNCwrau59XwYx82pkld/N0dnGJB/oberWDArNkumXZdQyZei+TpzFq6AKjZbCBCSa6licT5fsUg81ig=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3009.eurprd08.prod.outlook.com (52.134.92.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Fri, 23 Nov 2018 16:55:34 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa%5]) with mapi id 15.20.1361.018; Fri, 23 Nov 2018
 16:55:34 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-sunxi@googlegroups.com" <linux-sunxi@googlegroups.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Sean Paul <sean@poorly.run>, nd <nd@arm.com>
Subject: Re: [PATCH v2 12/43] drm/fourcc: Add format helpers for checking YUV
 sub-sampling
Thread-Topic: [PATCH v2 12/43] drm/fourcc: Add format helpers for checking YUV
 sub-sampling
Thread-Index: AQHUgw6x+GJcZGDkWU2cbV9Ru55/5qVdlJSA
Date:   Fri, 23 Nov 2018 16:55:33 +0000
Message-ID: <20181123165532.GA22326@arm.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-13-paul.kocialkowski@bootlin.com>
In-Reply-To: <20181123092515.2511-13-paul.kocialkowski@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP265CA0041.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:11::29) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.54]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3009;6:qHFK1up8ZcoN8pWhM4ZWzUAh5meQaiyB02NLc2/jkX3L2VbzWLXwUtT50GS06F5+CjryfX4t2CxljzKjd5v0biLf4M72qRRT0VIEgf63P85g/yCvMMFeOGY8Wk62+UFy8YDwfOzjx4gSKktjQDRGRfalLd8RN4ThFH1vhJJE0Jyapbb9jJKegwdva+36IDQNpg811U2YjfqM1dy7HRlSuf395G279pR8fEJIos9FU24ovXB4cx4r9zowrCClyWlJqQZk14rFyv0MpZ3WNMAsQrTPbqN2LdzjrDRt02wnelNVQd7bX5uEiKah1c59MeZ8puPokALGVKw4lvse1qKfp5apsUv91rOnrb0pFporDE2Gb5LVHsiMFXa/1iWSt7pM1xa1GaFEIawcGPF30PQydZb7M4KEZANL+hZLZipixUIwF9blxEk91p0PZyKovAThUmuTHktMSryCfIRQmkeJIg==;5:3OWpaJmsUfcPX61soo15dB8iy/TURdp+ghiVzHpd+m2V8klF0WD50+4tNsksV/y2lqF9vPD2xmOvPyyyokZeHYFvgDs8/sLgnlkqkSbvp5OFZdfFyta82PogSvhEbhTr9grelo7CiSLrRbJyfCq8V7Bi4StJJC2h9vgeSWSwKPs=;7:Qt51cRMKJEeZGrCr7MmPZexD/wMSKJ2lU5E9h9f522D0tRKc4+nP5z2x10fThrEslcLyhYDEeBY/lp89+0ZQSLBOLSr2gJ30xz98pOqHzrSOOYga9xWgEAolCUr6jyrXkKJRO9FxH81j8d6OqpXjvw==
x-ms-office365-filtering-correlation-id: ff3e7c70-4f37-44dd-4b9e-08d651647bdf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3009;
x-ms-traffictypediagnostic: AM0PR08MB3009:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB30093EADB8B5B61CC96CD3ADE4D40@AM0PR08MB3009.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3009;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3009;
x-forefront-prvs: 086597191B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(305945005)(8676002)(486006)(6436002)(44832011)(102836004)(186003)(76176011)(26005)(2900100001)(6506007)(386003)(81166006)(52116002)(8936002)(81156014)(2906002)(99286004)(54906003)(7736002)(5660300001)(33656002)(316002)(7416002)(6246003)(72206003)(68736007)(53936002)(966005)(4326008)(256004)(11346002)(446003)(6512007)(478600001)(6306002)(3846002)(6486002)(71200400001)(6116002)(71190400001)(25786009)(36756003)(1076002)(229853002)(14454004)(6916009)(86362001)(105586002)(97736004)(476003)(106356001)(66066001)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3009;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: t/ID87/ldXSFPMGLgcLLMh2iGCtYx4BT19WIBW6RohktuEILqN0Yfg5Uz4UmeyEBinhOhlvhw/PN1oO/EbqqXbz9Be35A3RXylcsBwizJb75ERPH4qiIdWsqRoSHhm3MF0Fo6wac1zQJokcFo5NpD2Wc1EN2bQDmqpEUZLhzHSM0HLsROSwdh05b0ZulFQLtqANWhHpWh+Ubpid94MoIgHXeP0l4jHGUIRlzpO8TsnTVsgm8T+OS+UjBj5wG6hc4H5Cq3BhCmWnyi3nB0TqOdVkEMBtY1ZOyXQ5d5m35mYt6KiwKtZEMvUjnWAVrSIpGs9J6ZMXqzfmIJoo6lNUDKThuJMnOUIl1KeED2tfQc8o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0AB3AA8CECED38488784F7C65BBD27BF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3e7c70-4f37-44dd-4b9e-08d651647bdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 16:55:33.9127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 10:24:44AM +0100, Paul Kocialkowski wrote:

Hi Paul,

> This introduces new format helpers that use the previously-introduced
> format info helpers for checking YUV sub-sampling.
>=20
> Only the format fourcc is required by these helpers and the formats are
> iterated from the list.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/drm_fourcc.c | 105 +++++++++++++++++++++++++++++++++++
>  include/drm/drm_fourcc.h     |   5 ++
>  2 files changed, 110 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> index b56e773f9f63..6d395c586ad5 100644
> --- a/drivers/gpu/drm/drm_fourcc.c
> +++ b/drivers/gpu/drm/drm_fourcc.c
> @@ -492,6 +492,111 @@ bool drm_format_is_yuv_planar(uint32_t format)
>  }
>  EXPORT_SYMBOL(drm_format_is_yuv_planar);
> =20
> +/**
> + * drm_format_is_yuv_sampling_410 - check that the format is a YUV forma=
t with
> + * 4:1:0 sub-sampling
> + * @format: pixel format
> + *
> + * Returns:
> + * A boolean indicating whether the format is a YUV format with 4:1:0
> + * sub-sampling.
> + */
> +bool drm_format_is_yuv_sampling_410(uint32_t format)
> +{
> +	const struct drm_format_info *info;
> +
> +	info =3D drm_format_info(format);
> +	if (!info)
> +		return false;
> +
> +	return drm_format_info_is_yuv_sampling_410(info);
> +}
> +EXPORT_SYMBOL(drm_format_is_yuv_sampling_410);
> +
> +/**
> + * drm_format_is_yuv_sampling_411 - check that the format is a YUV forma=
t with
> + * 4:1:1 sub-sampling
> + * @format: pixel format
> + *
> + * Returns:
> + * A boolean indicating whether the format is a YUV format with 4:1:1
> + * sub-sampling.
> + */
> +bool drm_format_is_yuv_sampling_411(uint32_t format)
> +{
> +	const struct drm_format_info *info;
> +
> +	info =3D drm_format_info(format);
> +	if (!info)
> +		return false;
> +
> +	return drm_format_info_is_yuv_sampling_411(info);
> +}
> +EXPORT_SYMBOL(drm_format_is_yuv_sampling_411);
> +
> +/**
> + * drm_format_is_yuv_sampling_420 - check that the format is a YUV forma=
t with
> + * 4:2:0 sub-sampling
> + * @format: pixel format
> + *
> + * Returns:
> + * A boolean indicating whether the format is a YUV format with 4:2:0
> + * sub-sampling.
> + */
> +bool drm_format_is_yuv_sampling_420(uint32_t format)
> +{
> +	const struct drm_format_info *info;
> +
> +	info =3D drm_format_info(format);
> +	if (!info)
> +		return false;
> +
> +	return drm_format_info_is_yuv_sampling_420(info);
> +}
> +EXPORT_SYMBOL(drm_format_is_yuv_sampling_420);
> +
> +/**
> + * drm_format_is_yuv_sampling_422 - check that the format is a YUV forma=
t with
> + * 4:2:2 sub-sampling
> + * @format: pixel format
> + *
> + * Returns:
> + * A boolean indicating whether the format is a YUV format with 4:2:2
> + * sub-sampling.
> + */
> +bool drm_format_is_yuv_sampling_422(uint32_t format)
> +{
> +	const struct drm_format_info *info;
> +
> +	info =3D drm_format_info(format);
> +	if (!info)
> +		return false;
> +
> +	return drm_format_info_is_yuv_sampling_422(info);
> +}
> +EXPORT_SYMBOL(drm_format_is_yuv_sampling_422);
> +
> +/**
> + * drm_format_is_yuv_sampling_444 - check that the format is a YUV forma=
t with
> + * 4:4:4 sub-sampling
> + * @format: pixel format
> + *
> + * Returns:
> + * A boolean indicating whether the format is a YUV format with 4:4:4
> + * sub-sampling.
> + */
> +bool drm_format_is_yuv_sampling_444(uint32_t format)
> +{
> +	const struct drm_format_info *info;
> +
> +	info =3D drm_format_info(format);
> +	if (!info)
> +		return false;
> +
> +	return drm_format_info_is_yuv_sampling_444(info);
> +}
> +EXPORT_SYMBOL(drm_format_is_yuv_sampling_444);
> +
>  /**
>   * drm_format_info_block_width - width in pixels of block.
>   * @info: pixel format info
> diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
> index d170b7b323f7..cf082d8b6ad4 100644
> --- a/include/drm/drm_fourcc.h
> +++ b/include/drm/drm_fourcc.h
> @@ -278,6 +278,11 @@ bool drm_format_is_yuv(uint32_t format);
>  bool drm_format_is_yuv_packed(uint32_t format);
>  bool drm_format_is_yuv_semiplanar(uint32_t format);
>  bool drm_format_is_yuv_planar(uint32_t format);
> +bool drm_format_is_yuv_sampling_410(uint32_t format);
> +bool drm_format_is_yuv_sampling_411(uint32_t format);
> +bool drm_format_is_yuv_sampling_420(uint32_t format);
> +bool drm_format_is_yuv_sampling_422(uint32_t format);
> +bool drm_format_is_yuv_sampling_444(uint32_t format);
>  unsigned int drm_format_info_block_width(const struct drm_format_info *i=
nfo,
>  					 int plane);
>  unsigned int drm_format_info_block_height(const struct drm_format_info *=
info,
> --=20
> 2.19.1
>=20
From patches [PATCH v2 08/43] till [PATCH v2 12/43], looks good to me.

How about clubbing all the drm_format_helper functions together in a
separate file (call it drm_fourcc_helper.c)? This way, we could
keep the __drm_format_info[] only drm_fourcc.c.

> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
