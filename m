Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B055C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230E520870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="eYRC1QNX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfAVLLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:11:02 -0500
Received: from mail-eopbgr40075.outbound.protection.outlook.com ([40.107.4.75]:12480
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728202AbfAVLLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9OBHNY7zwpQwYuEwsu+YAKMvdoxGpSJd2/UBIuRGg4=;
 b=eYRC1QNXtjwMkqZ7zVim/Pr1JfSrVTCC9vCyB79hncNSm9uUfB03ShmT98BeEqOPk5NQW56AEPpMvyjSDsMO+l5CtG5aP/k/dvrjrePCQR2PliqVM8VFhfn+0O8Lpd7duxbcYXkrrXH/OiOWQnnuNPnavPuSoH7Yon+ujPyqERY=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1286.eurprd08.prod.outlook.com (10.168.11.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 11:10:57 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 11:10:57 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v2 04/11] drm/komeda: Add komeda_crtc_mode_valid/fixup
Thread-Topic: [PATCH v2 04/11] drm/komeda: Add komeda_crtc_mode_valid/fixup
Thread-Index: AQHUskMmWTg7S2cYP0a9LrR/RJ11Ug==
Date:   Tue, 22 Jan 2019 11:10:57 +0000
Message-ID: <20190122110932.5138-5-james.qian.wang@arm.com>
References: <20190122110932.5138-1-james.qian.wang@arm.com>
In-Reply-To: <20190122110932.5138-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYAPR01CA0034.ausprd01.prod.outlook.com (2603:10c6:1:1::22)
 To DB6PR0801MB1990.eurprd08.prod.outlook.com (2603:10a6:4:6c::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB1286;6:yULRSjLGStma5ET2jziled8ERXH7tmeAjuQm2UzcUtNffM54c8e+Tm9S0lycuYdYe7OmbIra0Z2HsUCLww8iFmi5nfnU7eiqAtnhK6jx89bGbqWBjLzyQDii4iUAHQ7z2IFRb7ob85RTcyCiTE+PImqTmKrXbMED3/LdR0YvgHrv5HwAozr654wNwu+m89MBu4s1SGdsw0ufYmgqv6dC1S7sz8ZfjBP4HAarJSpy8LE+dOwY0stHELhUdZAJTvm2fgWmmmFCAC47yEtXFcUuSDWBUxLO9if797KLkQI6nuIH53/OvnF/kPCtW/tCcuWYmo4UTelMfg10SkvFV2wczibfLGJ2WXjfJkHq28dJBStKSiFTcfq9jlrCx2gW8gzyqTueKC6Zt8Zc02sLUuovberG9fJGaeQ6NNhviqKJ/8roMDC6xlmVeao6A+VHr/Bs8PlEjm4mmz1uedH42lYSFg==;5:3M93RZ93lzJxW1ixq+H2RM0JHV2KNTBXdpGdBDVkH/7YRU6NP3ul02VF0rGXkIJ8L7xqbXU1p+b+C0MF59va5ujRvyXLkGeb8UV/K41mz8Us/RLd9fGAiTIlbtQ3GF8/1rxnRXRAi794Y7YNgTjSoPz4YeOlkdEMQ8n7VuDWuKiPkhovUQIYq/AO31VWsyKsWb4uFcpaY0caFuT1h//ZCQ==;7:pbLzuCEnSW2MQ3BE5hY/huIJhjNNfOs0/7T4bxkFgG0su5yXFj0uVBRvfNw2V5qoN0Y36Ke695LbaAdcwmmeZRsWQQx2qBK5/qG/b08X5BFJN5jJFt8+8Mnx/MGxpX9RWspdXyuDAttan+idiV2rkw==
x-ms-office365-filtering-correlation-id: f5dcabc7-f13e-4db2-9377-08d6805a488f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1286;
x-ms-traffictypediagnostic: DB6PR0801MB1286:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB1286BBBE5FA543CA25404C9FB3980@DB6PR0801MB1286.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(2906002)(25786009)(86362001)(36756003)(6116002)(3846002)(4326008)(6636002)(6486002)(103116003)(66066001)(105586002)(106356001)(6512007)(2501003)(53936002)(97736004)(6436002)(446003)(68736007)(81166006)(476003)(50226002)(8676002)(71200400001)(71190400001)(316002)(6506007)(52116002)(81156014)(486006)(11346002)(110136005)(54906003)(99286004)(305945005)(102836004)(14454004)(7736002)(26005)(76176011)(386003)(55236004)(1076003)(8936002)(478600001)(2616005)(186003)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1286;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: niViQqI5vYOF6chKBy4NI43hJnzKy9aoRzOlw4GUOAsfzOnHTH8/B6kH3VxBhLu18j2JMdWZXiRWE2OhiAUjmNsv5MxRpZJBvTBO1unzZHiQbICYHhO7p2Og6WL3CaowyiLMRFhksyMy9l/SiarucXz+RK5GFO1ANu8W+1tDimXrM8KkmxmpAspV/hgVfmYHbbiiAZJ0QKAvgTQ0sakcV3DlEilXFx5RIJK/sh1ZSNRL/9RXJynKfH7lOtHGYMJUdu2YmvWmdx+qXS8inecr21ur0ATjurOKLLjHd9lvXhCj062YG1W++GxGysb9ivGqhi8rGkqlyaHD3qHhDuGYlvKJfqb/KjtEcSTu2e/t4Q33Dw/eGaD8RNE6EBWo2jRQjczg3NPdFK6UNy5TBR6ZwSNyv3ToA8e93ws+cfG5i80=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5dcabc7-f13e-4db2-9377-08d6805a488f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 11:10:49.1346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1286
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

komeda_crtc_mode_valid compares the input mode->clk with main engine clk
and AXI clk, and reject the mode if the required pixel clk can not be
satisfied by main engine clk and AXI-clk.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 95d8f2bcd523..7e0bf78da733 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -90,9 +90,61 @@ komeda_crtc_atomic_flush(struct drm_crtc *crtc,
 	komeda_crtc_do_flush(crtc, old);
 }
=20
+static enum drm_mode_status
+komeda_crtc_mode_valid(struct drm_crtc *crtc, const struct drm_display_mod=
e *m)
+{
+	struct komeda_dev *mdev =3D crtc->dev->dev_private;
+	struct komeda_crtc *kcrtc =3D to_kcrtc(crtc);
+	struct komeda_pipeline *master =3D kcrtc->master;
+	long mode_clk, pxlclk;
+
+	if (m->flags & DRM_MODE_FLAG_INTERLACE)
+		return MODE_NO_INTERLACE;
+
+	/* main clock/AXI clk must be faster than pxlclk*/
+	mode_clk =3D m->clock * 1000;
+	pxlclk =3D clk_round_rate(master->pxlclk, mode_clk);
+	if (pxlclk !=3D mode_clk) {
+		DRM_DEBUG_ATOMIC("pxlclk doesn't support %ld Hz\n", mode_clk);
+
+		return MODE_NOCLOCK;
+	}
+
+	if (clk_round_rate(mdev->mclk, mode_clk) < pxlclk) {
+		DRM_DEBUG_ATOMIC("mclk can't satisfy the requirement of %s-clk: %ld.\n",
+				 m->name, pxlclk);
+
+		return MODE_CLOCK_HIGH;
+	}
+
+	if (clk_round_rate(master->aclk, mode_clk) < pxlclk) {
+		DRM_DEBUG_ATOMIC("aclk can't satisfy the requirement of %s-clk: %ld.\n",
+				 m->name, pxlclk);
+
+		return MODE_CLOCK_HIGH;
+	}
+
+	return MODE_OK;
+}
+
+static bool komeda_crtc_mode_fixup(struct drm_crtc *crtc,
+				   const struct drm_display_mode *m,
+				   struct drm_display_mode *adjusted_mode)
+{
+	struct komeda_crtc *kcrtc =3D to_kcrtc(crtc);
+	struct komeda_pipeline *master =3D kcrtc->master;
+	long mode_clk =3D m->clock * 1000;
+
+	adjusted_mode->clock =3D clk_round_rate(master->pxlclk, mode_clk) / 1000;
+
+	return true;
+}
+
 struct drm_crtc_helper_funcs komeda_crtc_helper_funcs =3D {
 	.atomic_check	=3D komeda_crtc_atomic_check,
 	.atomic_flush	=3D komeda_crtc_atomic_flush,
+	.mode_valid	=3D komeda_crtc_mode_valid,
+	.mode_fixup	=3D komeda_crtc_mode_fixup,
 };
=20
 static const struct drm_crtc_funcs komeda_crtc_funcs =3D {
--=20
2.17.1

