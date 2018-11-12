Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E12C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159452243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VKU5Kv9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159452243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbeKLWoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 17:44:16 -0500
Received: from mail-eopbgr20055.outbound.protection.outlook.com ([40.107.2.55]:29297
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727103AbeKLWoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 17:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joTIBaoxuVD8t712F+/reYOFutESdop9HyGxe3sIahw=;
 b=VKU5Kv9LWE3Y0W8HOsp0Yyl/8z2ivZoK45q08HCDa20Pu8pUSmrY1PhC5ESyBQNL5Ii4oJzpeX9njBbt5SRSP3AK1zKf+iUKUspAdD/q60ObeeMhRBTm/rGyM3kjme8J8lYBLzWsho3HSFtffgcjYqRBXIMKOo1Y5UJA4QVW32o=
Received: from DB6PR0802MB2551.eurprd08.prod.outlook.com (10.172.251.149) by
 DB6PR0802MB2455.eurprd08.prod.outlook.com (10.172.251.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Mon, 12 Nov 2018 12:51:04 +0000
Received: from DB6PR0802MB2551.eurprd08.prod.outlook.com
 ([fe80::19ca:93bb:bc0:985a]) by DB6PR0802MB2551.eurprd08.prod.outlook.com
 ([fe80::19ca:93bb:bc0:985a%7]) with mapi id 15.20.1294.028; Mon, 12 Nov 2018
 12:51:04 +0000
From:   Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/arm/malidp: Consider rotation memory requirement in
 case of AFBC framebuffer
Thread-Topic: [PATCH] drm/arm/malidp: Consider rotation memory requirement in
 case of AFBC framebuffer
Thread-Index: AQHUeBgwDmeN6yfix0edeKIT8EiTRqVMHIyA
Date:   Mon, 12 Nov 2018 12:51:04 +0000
Message-ID: <20181112125103.GA13887@e114479-lin.cambridge.arm.com>
References: <1541759832-19211-1-git-send-email-ayan.halder@arm.com>
In-Reply-To: <1541759832-19211-1-git-send-email-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0291.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::15) To DB6PR0802MB2551.eurprd08.prod.outlook.com
 (2603:10a6:4:a1::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexandru-Cosmin.Gheorghe@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.52]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0802MB2455;6:tclnjTY1BAieGp1ulsSzn+S4gptdAC/qARRLcRJGo6NQ67/rDP2d2H0JNjfnwOWwLqt4nM3fUcJBvBjMeuozhiMRroCi3fC0tEHMBx++04JfE0c8zAUoJITcfp35oL3mnexOQKu1og+dqimJ+2VVFmeEaMag6ocSa3+86SxBNH4rGgtUU1rJevjIcWkTBAx3iCRqrJC0ropbzIIoOceTry6GVk+tYx7eeM0wRna53Hg9uuYUzW1WjFaRhdIjssYqs21uM7Hl4mKI/8/+SudKFTEo3S460wI50wRU9vWgA4ktl84nhHSUwTHF+poJCREI25QODqEa5yMSz1QnrUI724q56WCkIXiYMf7UsZcg0VaveBc7+GsF8Uq3auZPHlDBaBYESoBuZ7hztYq37HYyP/o16bqLzU+5cHR90KWgBYSB3d8OcKdvJY7+hRMDT5d0RKCSgNGG3iC2t3J5t1tMBg==;5:9waxN0Fr5X4flGa/JlxdGFqJkYQGwQSexNudhwTubCHA773rXuMEN4r0wpiYRUnTZPvDD4f2jwuEPHkERsVVSX2GjT1kRfH++jMe3eJgkxuvPiP4WqLoGHCUidABvI6wCRKvVawa3oJUXqhQEAIg2lXBS2sSs0CL3/dqQxTvbUI=;7:NN1LTIXn6JWLfloPKkpEmNt7+dycaiuQElP1HU96CICeXvAJKjn5OG89l7Fky1lmOojaS+BSz0vQ5hwTD3qTtBi5HsQPsrnpsC7fg9lwbVctl4NaSxV2/tDPWBNs7V3//n0NXGBIf2JNSNqI2rHRYQ==
x-ms-office365-filtering-correlation-id: dc1d8b1a-73cf-4a20-4b6c-08d6489d818c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB6PR0802MB2455;
x-ms-traffictypediagnostic: DB6PR0802MB2455:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0802MB24553A014A21F261D31104C0BCC10@DB6PR0802MB2455.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(217544274631240)(180628864354917);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB6PR0802MB2455;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0802MB2455;
x-forefront-prvs: 0854128AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(366004)(189003)(199004)(86362001)(81166006)(8936002)(66066001)(6306002)(8676002)(305945005)(81156014)(33656002)(54906003)(2900100001)(316002)(97736004)(68736007)(6246003)(6862004)(229853002)(14444005)(7736002)(6486002)(6512007)(6436002)(53936002)(256004)(71200400001)(71190400001)(4326008)(76176011)(486006)(14454004)(11346002)(446003)(105586002)(106356001)(5660300001)(476003)(6636002)(478600001)(26005)(6506007)(6116002)(3846002)(99286004)(2906002)(102836004)(186003)(72206003)(966005)(1076002)(386003)(52116002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0802MB2455;H:DB6PR0802MB2551.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PEqfZH/6Dw7QNjPUz5N+LfwCp5se0mM7l6e111si3kcTaNNdRhPSzZGZv+RNIO4ymrGrVBR3MLXh+BL4k6aFuSNP3prtujHvRI7BX23XCa8MIAuXPy33mgBKp8rWE2KFNJPr/PoPW8ZRb9XTX+FFOITIj+RhFs/KhZtAqvRQy9RF+Ty6v3uS5FEVgHuIkqsq70GGOU7pTsLJZAJRq2Lv+QoWGMBizu0RRcpz+IHyN2wYQFjOCqEH/1r/mBjk87fT565D+8DkScDmuHzDTm01sesGtiwLoCNPWeMFS8cSQss7Ccas8TtSU9tR2GWqaRLPWo9R4+GX83NTGYfrsa8V1K/U727ArEhz49UpXDHSc/c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F71B34BC3FAAD845AEB45B9382FC7319@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1d8b1a-73cf-4a20-4b6c-08d6489d818c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2018 12:51:04.3747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ayan,

On Fri, Nov 09, 2018 at 10:37:19AM +0000, Ayan Halder wrote:
> Rotation memory for layers is shared with AFBC decoder block. Thus one ne=
eds to
> calculate rotation memory requirement in case of AFBC framebuffer. This i=
s
> used later to verify if it can be sufficed by the hardware rotation memor=
y
> availibility.
>=20
> Fixes: 66da13a ("drm/arm/malidp: Validate rotations for compressed/uncomp=
ressed framebuffers for each layer")

Reviewed-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>

> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> ---
>  drivers/gpu/drm/arm/malidp_planes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/ma=
lidp_planes.c
> index c9a6d3e..3f4dc64 100644
> --- a/drivers/gpu/drm/arm/malidp_planes.c
> +++ b/drivers/gpu/drm/arm/malidp_planes.c
> @@ -470,7 +470,7 @@ static int malidp_de_plane_check(struct drm_plane *pl=
ane,
>  	}
> =20
>  	ms->rotmem_size =3D 0;
> -	if (state->rotation & MALIDP_ROTATED_MASK) {
> +	if ((state->rotation & MALIDP_ROTATED_MASK) || fb->modifier) {
>  		int val;
> =20
>  		val =3D mp->hwdev->hw->rotmem_required(mp->hwdev, state->crtc_w,
> --=20
> 2.7.4
>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

--=20
Cheers,
Alex G
