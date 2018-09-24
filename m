Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7EAECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C1B2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qYgDR/l5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C1B2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbeIXUp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:45:57 -0400
Received: from mail-eopbgr20052.outbound.protection.outlook.com ([40.107.2.52]:50336
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727337AbeIXUp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixJEVEyxrgQNuuYs8+oEKabxaVvoQ6yx8vKEYqEPs18=;
 b=qYgDR/l5MeIc4K8Dzjcp0d0C0Z735g7NwbXWkCNoqlClKXfZoQOAflMDXDFGtCBkfrm7WEDyDhNnGQSlEtPkv8N7eDgDSQnhNH7mNoMn4noAD6wllAzfJVj2DL97f7jkC4eaqjLpqtXti/ZYc+XtwD2x+uEtIgcqz3QR2WHwgKM=
Received: from DB6PR0801MB1384.eurprd08.prod.outlook.com (10.168.11.148) by
 DB6PR0801MB2039.eurprd08.prod.outlook.com (10.168.86.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 24 Sep 2018 14:40:15 +0000
Received: from DB6PR0801MB1384.eurprd08.prod.outlook.com
 ([fe80::f8ca:8dc3:7287:765e]) by DB6PR0801MB1384.eurprd08.prod.outlook.com
 ([fe80::f8ca:8dc3:7287:765e%3]) with mapi id 15.20.1164.024; Mon, 24 Sep 2018
 14:40:15 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
CC:     Brian Starkey <Brian.Starkey@arm.com>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, nd <nd@arm.com>
Subject: Re: [PATCH v2] drm/arm/malidp: Validate rotations for
 compressed/uncompressed framebuffers for each layer
Thread-Topic: [PATCH v2] drm/arm/malidp: Validate rotations for
 compressed/uncompressed framebuffers for each layer
Thread-Index: AQHUUbghrE/rpwjmx0OuPkF+J5DYRaT/hY8A
Date:   Mon, 24 Sep 2018 14:40:15 +0000
Message-ID: <20180924144012.GA7942@arm.com>
References: <20180615124654.GD15072@e110455-lin.cambridge.arm.com>
 <20180921143353.15943-1-Liviu.Dudau@arm.com>
In-Reply-To: <20180921143353.15943-1-Liviu.Dudau@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR04CA0031.eurprd04.prod.outlook.com
 (2603:10a6:206:1::44) To DB6PR0801MB1384.eurprd08.prod.outlook.com
 (2603:10a6:4:b::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.55]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB2039;6:+P4rIJyzy0SFHg8P2NCWP89QDCEJr//6iXGl2RJRXJNnLwOBSppWt478NAHI84k7IumjLMcn9JG0U2ae3KfSGAxE0c5+HiHuf2sTdeMLeswPE+YxY7uFxIz4wzdf7H1JyGB84c7CRZXmYFNovhDnxnUZCskhB9W6K5QhjbwFzGTtAmgb3wuPgjg9KGg7W3dzbK+m02af/HD8kKHeOrkJTWen/A83CxRYaUwxj0DXrAiGNYkIVnE6V/wh6JgI7mY1Yz2wrOVyvaJpmzNnBcnVZ3jV5G8Q/zdbQYsdVHSz7BjxtsW4Y/EuhKWGoGPp0aMg0q0G11FS+uH3jkx3xTa3Yz7wFCAT4YPnwT7EveqEHiZR5laIJcUdz1Rj3HlyHykQThRju5SBD+zz8b9nb8fqtlcnOJLphW8M67tGnzJhxnRN8GKSziz+/l6Q9cd48HcE3zpmmC4jTxRBZplia7vdeg==;5:asTCHF2sgsZyaPa7xFOeJgEn4Wq5stG8kYCZGIQMMB7xMpEezAGFi1C4EqjslJstHZQq6POtmHpplNhuIXLjvYTSgGZi+u8RAwJQQrM2tD7J8alFtruArHIxazHiKQ4cXnsq8sgHXD6EGZ4hD3P3bSY60/TzsAgbVGYKH450tEE=;7:my8p9eKvJj8IHGxsWlUvMpaCSHl0ATCLBNqHTIbvIIGgQFkCO41lwlp9DTwT+jI9I1IF2/bnZyTost2FowdcfKoqirSbZeV4uzdrtYdXLkxdRMXaW6hde4qUuJ1Xl5TZOZuKV5uMllYFj8YVOSj9tcg0WW0hCAkbrAXgPmWUFIv90Wxcu1nv2wp0oIoedtg28jFeLfLQDuZhvUPmNWsUrJpEyEuggvs1XsNaBF+OOeUH3nuBey95zyOd6kcsYn0R
x-ms-office365-filtering-correlation-id: d9053a03-2a44-4c7f-4109-08d6222ba392
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2039;
x-ms-traffictypediagnostic: DB6PR0801MB2039:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB20390A3F922549DD1861496BE4170@DB6PR0801MB2039.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(105169848403564)(180628864354917);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:DB6PR0801MB2039;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB2039;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(189003)(199004)(2616005)(446003)(66066001)(68736007)(256004)(53936002)(316002)(37006003)(25786009)(5250100002)(5660300001)(76176011)(52116002)(15650500001)(6116002)(102836004)(6636002)(81166006)(54906003)(105586002)(81156014)(99286004)(6486002)(6506007)(14454004)(8936002)(6246003)(386003)(6436002)(478600001)(44832011)(2900100001)(2906002)(7736002)(305945005)(6862004)(106356001)(11346002)(4326008)(486006)(97736004)(3846002)(229853002)(72206003)(575784001)(8676002)(476003)(6512007)(14444005)(1076002)(36756003)(26005)(86362001)(71190400001)(33656002)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB2039;H:DB6PR0801MB1384.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: i8KQFdNL1blgP34s+1gKsuAlyJ4bNphCT14lSk8V/j/x0WYi9OAazjlR7PlNjJPks4GbIH4VFITp+KHKDp5BhDA2K6YdcLkWz2/iAqZ0JWaEj4WVM7fdpSo6Rnwie42Ir78qX7tIKcJS42kUoLAdA9RkGdNmmvnHQph9IUPyup1kZnAsp8yz4aXhqlgQNHVtGAQv31W/tAA1m85sppulO4QBvAyvjoJ46rUo654GdF18t+5e39B8eYqUAU8HSrZh/RrYrmrsC+SEoBGVIojp6TwtG3z7RhJlFgUfhyNiOLPrGjyLucgRQsEMQWIrUjQFahxAh82/5n3JHJf/EyxdND21epuWYGNvQqR2VDk51Hc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2DDE65B9883B15478A1103C7A9AB8FD9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9053a03-2a44-4c7f-4109-08d6222ba392
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:40:15.2090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liviu,

On Fri, Sep 21, 2018 at 03:33:53PM +0100, Liviu Dudau wrote:
> From: Ayan Kumar Halder <ayan.halder@arm.com>
>=20
> Add support for compressed framebuffers that are described using
> the framebuffer's modifier field. Mali DP uses the rotation memory for
> the decompressor of the format, so we need to check for space when
> the modifiers are present.
>=20
> Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
> Reviewed-by: Brian Starkey <brian.starkey@arm.com>
> [re-worded commit, rebased, cleaned up duplicated checks for
>  RGB888 and BGR888 and removed additional parameter for
>  rotmem_required function hook]
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> ---
>  drivers/gpu/drm/arm/malidp_crtc.c   | 28 ++++++++++++---------
>  drivers/gpu/drm/arm/malidp_hw.c     | 38 ++++++++++++-----------------
>  drivers/gpu/drm/arm/malidp_hw.h     |  7 ++++++
>  drivers/gpu/drm/arm/malidp_planes.c | 19 +++++++++++----
>  4 files changed, 53 insertions(+), 39 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/mali=
dp_crtc.c
> index ef44202fb43f8..e1b72782848c3 100644
> --- a/drivers/gpu/drm/arm/malidp_crtc.c
> +++ b/drivers/gpu/drm/arm/malidp_crtc.c
> @@ -348,19 +348,20 @@ static int malidp_crtc_atomic_check(struct drm_crtc=
 *crtc,
> =20
>  	/*
>  	 * check if there is enough rotation memory available for planes
> -	 * that need 90?? and 270?? rotation. Each plane has set its required
> -	 * memory size in the ->plane_check() callback, here we only make
> -	 * sure that the sums are less that the total usable memory.
> +	 * that need 90?? and 270?? rotion or planes that are compressed.
> +	 * Each plane has set its required memory size in the ->plane_check()
> +	 * callback, here we only make sure that the sums are less that the
> +	 * total usable memory.
>  	 *
>  	 * The rotation memory allocation algorithm (for each plane):
> -	 *  a. If no more rotated planes exist, all remaining rotate
> -	 *     memory in the bank is available for use by the plane.
> -	 *  b. If other rotated planes exist, and plane's layer ID is
> -	 *     DE_VIDEO1, it can use all the memory from first bank if
> -	 *     secondary rotation memory bank is available, otherwise it can
> +	 *  a. If no more rotated or compressed planes exist, all remaining
> +	 *     rotate memory in the bank is available for use by the plane.
> +	 *  b. If other rotated or compressed planes exist, and plane's
> +	 *     layer ID is DE_VIDEO1, it can use all the memory from first bank
> +	 *     if secondary rotation memory bank is available, otherwise it can
>  	 *     use up to half the bank's memory.
> -	 *  c. If other rotated planes exist, and plane's layer ID is not
> -	 *     DE_VIDEO1, it can use half of the available memory
> +	 *  c. If other rotated or compressed planes exist, and plane's layer I=
D
> +	 *     is not DE_VIDEO1, it can use half of the available memory.
>  	 *
>  	 * Note: this algorithm assumes that the order in which the planes are
>  	 * checked always has DE_VIDEO1 plane first in the list if it is
> @@ -372,7 +373,9 @@ static int malidp_crtc_atomic_check(struct drm_crtc *=
crtc,
> =20
>  	/* first count the number of rotated planes */
>  	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, state) {
> -		if (pstate->rotation & MALIDP_ROTATED_MASK)
> +		struct drm_framebuffer *fb =3D pstate->fb;
> +
> +		if ((pstate->rotation & MALIDP_ROTATED_MASK) || fb->modifier)
>  			rotated_planes++;
>  	}
> =20
> @@ -388,8 +391,9 @@ static int malidp_crtc_atomic_check(struct drm_crtc *=
crtc,
>  	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, state) {
>  		struct malidp_plane *mp =3D to_malidp_plane(plane);
>  		struct malidp_plane_state *ms =3D to_malidp_plane_state(pstate);
> +		struct drm_framebuffer *fb =3D pstate->fb;
> =20
> -		if (pstate->rotation & MALIDP_ROTATED_MASK) {
> +		if ((pstate->rotation & MALIDP_ROTATED_MASK) || fb->modifier) {
>  			/* process current plane */
>  			rotated_planes--;
> =20
> diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp=
_hw.c
> index b33000634a4ee..5549092e6c36a 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.c
> +++ b/drivers/gpu/drm/arm/malidp_hw.c
> @@ -85,41 +85,43 @@ static const struct malidp_format_id malidp550_de_for=
mats[] =3D {
> =20
>  static const struct malidp_layer malidp500_layers[] =3D {
>  	/*  id, base address, fb pointer address base, stride offset,
> -		yuv2rgb matrix offset, mmu control register offset */
> +	    yuv2rgb matrix offset, mmu control register offset, rotation_featur=
es */
>  	{ DE_VIDEO1, MALIDP500_DE_LV_BASE, MALIDP500_DE_LV_PTR_BASE,
> -		MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB, 0 },
> +		MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB, 0, ROTATE_ANY },
>  	{ DE_GRAPHICS1, MALIDP500_DE_LG1_BASE, MALIDP500_DE_LG1_PTR_BASE,
> -		MALIDP_DE_LG_STRIDE, 0, 0 },
> +		MALIDP_DE_LG_STRIDE, 0, 0, ROTATE_ANY },
>  	{ DE_GRAPHICS2, MALIDP500_DE_LG2_BASE, MALIDP500_DE_LG2_PTR_BASE,
> -		MALIDP_DE_LG_STRIDE, 0, 0 },
> +		MALIDP_DE_LG_STRIDE, 0, 0, ROTATE_ANY },
>  };
> =20
>  static const struct malidp_layer malidp550_layers[] =3D {
>  	/*  id, base address, fb pointer address base, stride offset,
> -		yuv2rgb matrix offset, mmu control register offset */
> +		yuv2rgb matrix offset, mmu control register offset, rotation_features =
*/
>  	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
> -		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, 0 },
> +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, 0, ROTATE_ANY },
>  	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
> -		MALIDP_DE_LG_STRIDE, 0, 0 },
> +		MALIDP_DE_LG_STRIDE, 0, 0, ROTATE_ANY },
>  	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
> -		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, 0 },
> +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, 0, ROTATE_ANY },
>  	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
> -		MALIDP550_DE_LS_R1_STRIDE, 0, 0 },
> +		MALIDP550_DE_LS_R1_STRIDE, 0, 0, ROTATE_NONE },
>  };
> =20
>  static const struct malidp_layer malidp650_layers[] =3D {
>  	/*  id, base address, fb pointer address base, stride offset,
> -		yuv2rgb matrix offset, mmu control register offset */
> +		yuv2rgb matrix offset, mmu control register offset, rotation_features =
*/
>  	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
>  		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB,
> -		MALIDP650_DE_LV_MMU_CTRL },
> +		MALIDP650_DE_LV_MMU_CTRL, ROTATE_ANY },
>  	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
> -		MALIDP_DE_LG_STRIDE, 0, MALIDP650_DE_LG_MMU_CTRL },
> +		MALIDP_DE_LG_STRIDE, 0, MALIDP650_DE_LG_MMU_CTRL,
> +		ROTATE_COMPRESSED },
>  	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
>  		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB,
> -		MALIDP650_DE_LV_MMU_CTRL },
> +		MALIDP650_DE_LV_MMU_CTRL, ROTATE_ANY },
>  	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
> -		MALIDP550_DE_LS_R1_STRIDE, 0, MALIDP650_DE_LS_MMU_CTRL },
> +		MALIDP550_DE_LS_R1_STRIDE, 0, MALIDP650_DE_LS_MMU_CTRL,
> +		ROTATE_NONE },
>  };
> =20
>  #define SE_N_SCALING_COEFFS	96
> @@ -314,10 +316,6 @@ static void malidp500_modeset(struct malidp_hw_devic=
e *hwdev, struct videomode *
> =20
>  static int malidp500_rotmem_required(struct malidp_hw_device *hwdev, u16=
 w, u16 h, u32 fmt)
>  {
> -	/* RGB888 or BGR888 can't be rotated */
> -	if ((fmt =3D=3D DRM_FORMAT_RGB888) || (fmt =3D=3D DRM_FORMAT_BGR888))
> -		return -EINVAL;
> -
>  	/*
>  	 * Each layer needs enough rotation memory to fit 8 lines
>  	 * worth of pixel data. Required size is then:
> @@ -605,10 +603,6 @@ static int malidp550_rotmem_required(struct malidp_h=
w_device *hwdev, u16 w, u16
>  {
>  	u32 bytes_per_col;
> =20
> -	/* raw RGB888 or BGR888 can't be rotated */
> -	if ((fmt =3D=3D DRM_FORMAT_RGB888) || (fmt =3D=3D DRM_FORMAT_BGR888))
> -		return -EINVAL;
> -
>  	switch (fmt) {
>  	/* 8 lines at 4 bytes per pixel */
>  	case DRM_FORMAT_ARGB2101010:
> diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp=
_hw.h
> index 0d7f9ea0ade89..3ab133d49bbad 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.h
> +++ b/drivers/gpu/drm/arm/malidp_hw.h
> @@ -36,6 +36,12 @@ enum {
>  	SE_MEMWRITE =3D BIT(5),
>  };
> =20
> +enum rotation_features {
> +	ROTATE_NONE,		/* does not support rotation at all */
> +	ROTATE_ANY,		/* supports rotation on any buffers */
> +	ROTATE_COMPRESSED,	/* supports rotation only on compressed buffers */
> +};
> +
>  struct malidp_format_id {
>  	u32 format;		/* DRM fourcc */
>  	u8 layer;		/* bitmask of layers supporting it */
> @@ -63,6 +69,7 @@ struct malidp_layer {
>  	u16 stride_offset;	/* offset to the first stride register. */
>  	s16 yuv2rgb_offset;	/* offset to the YUV->RGB matrix entries */
>  	u16 mmu_ctrl_offset;    /* offset to the MMU control register */
> +	enum rotation_features rot;	/* type of rotation supported */
>  };
> =20
>  enum malidp_scaling_coeff_set {
> diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/ma=
lidp_planes.c
> index c21b44effa5a7..36d2952774b22 100644
> --- a/drivers/gpu/drm/arm/malidp_planes.c
> +++ b/drivers/gpu/drm/arm/malidp_planes.c
> @@ -433,11 +433,20 @@ static int malidp_de_plane_check(struct drm_plane *=
plane,
>  	if (ret)
>  		return ret;
> =20
> -	/* packed RGB888 / BGR888 can't be rotated or flipped */
> -	if (state->rotation !=3D DRM_MODE_ROTATE_0 &&
> -	    (fb->format->format =3D=3D DRM_FORMAT_RGB888 ||
> -	     fb->format->format =3D=3D DRM_FORMAT_BGR888))
> -		return -EINVAL;
> +	/* validate the rotation constraints for each layer */
> +	if (state->rotation !=3D DRM_MODE_ROTATE_0) {
> +		if (mp->layer->rot =3D=3D ROTATE_NONE)
> +			return -EINVAL;
> +		if ((mp->layer->rot =3D=3D ROTATE_COMPRESSED) && !!(fb->modifier))
This should be !(fb->modifier) because the driver should return EINVAL
when the layer supports only compressed rotation and no framebuffer
modifiers (which denotes compression) have been provided.
> +			return -EINVAL;
> +		/*
> +		 * packed RGB888 / BGR888 can't be rotated or flipped
> +		 * unless they are stored in a compressed way
> +		 */
> +		if ((fb->format->format =3D=3D DRM_FORMAT_RGB888 ||
> +		     fb->format->format =3D=3D DRM_FORMAT_BGR888) && !!(fb->modifier))
This should also be !(fb->modifier)
> +			return -EINVAL;
> +	}
> =20
>  	ms->rotmem_size =3D 0;
>  	if (state->rotation & MALIDP_ROTATED_MASK) {
> --=20
> 2.18.0
