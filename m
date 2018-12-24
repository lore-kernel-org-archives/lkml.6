Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401D5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036912173C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="lzcLc2XL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbeLXJ0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:26:02 -0500
Received: from mail-eopbgr150085.outbound.protection.outlook.com ([40.107.15.85]:46872
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725294AbeLXJ0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SukNybEVP+ndTttNc6aBbi4Ihrv9RWD+ZNjF5C/OqXI=;
 b=lzcLc2XLOW/dNlx8iKpGAlyEfkuZTOJQjdaJzmrqiToAsxLdVgXTa1Bz2hZNLpPhj1GgmoBEmTw8PIiKA9IYscfrEkTahpdQJFQSy3qSYNyOoWmVf4HOE1mdOHUsuOMeBZyIy4z67F9vMCCDEkWbqtrrz+JxAuGNSTlwarYVGws=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0262.eurprd08.prod.outlook.com (10.161.35.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Mon, 24 Dec 2018 09:25:58 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 09:25:58 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH 04/11] drm/komeda: Add komeda_crtc_mode_valid/fixup
Thread-Topic: [PATCH 04/11] drm/komeda: Add komeda_crtc_mode_valid/fixup
Thread-Index: AQHUm2qtO4uAfkpXZkCldalRPnu4xg==
Date:   Mon, 24 Dec 2018 09:25:58 +0000
Message-ID: <20181224092435.2792-5-james.qian.wang@arm.com>
References: <20181224092435.2792-1-james.qian.wang@arm.com>
In-Reply-To: <20181224092435.2792-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYXPR01CA0099.ausprd01.prod.outlook.com
 (2603:10c6:0:2e::32) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0262;6:Pub9X1a2JJN6G9G1MO06+nQpM/gsggMZAZpw62iwiJFei041ic/8YtOZ5qiQvhyHf2t/OKyajIRUYAzrTnXw1dIzqRKJynyBuO1xhSTXvKG/tYcp+A6ojDKvMH0lJA6fC2mPmJ47yE40ua2O8v3jQtx78Yo6Lr4qDrikm6aiYh7WUOEtU8w89FhhhQJWzU6OkFlTTsRhX2Q9tU493JSW8yeVbLnvu/+h+qhp9o34Ge30TlnZt4LGyQGfau8S2uoZWDp8kZBAeNw2XDL0BPZiuZwWYn2tsDsbaay/82SkBfAE2fQjb9PFUHfJSqtly9xTL20HU7l0D2332CWDTp6GuBVsAnxwTPjNLGsLbcvEXssdWKelnsAjuOFv22DWNorrPBetTTKlb8598PMG7oQDQJkj/AqA7lAynkobQXRK1tELWgQLrTmzqisI7a/2QlSm4JFfzgYvNyRLPv/w3086CQ==;5:k+pPKfH0xA1QmDAMHEZ4Ozw3v/ZcIY6q7d/0XjV1qU4WotQ4tY1BQq8WoNhTqXU4VT7UYKGTKqjwBEeUpdIYV3AMQXBW7zQOe+PAFn30RsQsv/ggkI2HlR11VCvgdCYeuiFVAFw8GSSR7ql1OOMMxsOv3/7upPMFWUhb+sZddLs=;7:Dn++/DwZbFFN6LcWy0m+J0goQ9L0uawfihNI1hmi4/QYwuAIyuRJMud/wa4r68gzPbICVqxHlEsL7Zo/2uex8BytugAPo/sCwCPMOaqstqUNR27jkv+FsBA+MY1TmnVu4d5m5Xlk1wJQnB2oVDJUXg==
x-ms-office365-filtering-correlation-id: b472da53-efa7-4aa2-3614-08d66981cfca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0262;
x-ms-traffictypediagnostic: AM3PR08MB0262:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB0262AAAE9A1EC6386EF7F772B3BB0@AM3PR08MB0262.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0262;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0262;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(39850400004)(346002)(199004)(189003)(4326008)(256004)(305945005)(53936002)(6862004)(71190400001)(71200400001)(486006)(7736002)(97736004)(446003)(2906002)(52116002)(6116002)(76176011)(1076003)(6436002)(86362001)(6512007)(5660300001)(11346002)(186003)(26005)(68736007)(3846002)(2616005)(476003)(55236004)(386003)(102836004)(6506007)(25786009)(103116003)(14454004)(105586002)(99286004)(54906003)(37006003)(6486002)(106356001)(316002)(8676002)(81166006)(81156014)(8936002)(6636002)(36756003)(478600001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0262;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O9zJ4TENreE3pEvVLF6mKtyutEHLW6EtiNwSJe4+my0BrQNw/nVZDyE7uUsc2vyilZluQS2Ys4u1VCwKWKfXlBJCTw1R8eJ8HRmnXki3hhHMlF5M5Nv1dUwYt5qoPvLgyGrBX5zGxTzpgUM6leKkdIpS1KpVzTXqd6/8h+niEUafITrX4g4bOFuoBfmFEVblaidaleF+FPb44W2p4dC3g8NS2hDW1EjUSGXwxT9QKg9ih2436Iq7kQvacQGgBnkm1cUWA6k6zT5Ox4iN3JVb1rGPj2vHxHzggY71x6ibIvd9b/HR74PXxlJvlzQWNaqP
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b472da53-efa7-4aa2-3614-08d66981cfca
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 09:25:58.2581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

komeda_crtc_mode_valid compares the input mode->clk with main engine clk
and AXI clk, and reject the mode if the required pixel clk can not be
satisfied by main engine clk and AXI-clk.

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index b4640971e47e..05bdff137e50 100644
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

