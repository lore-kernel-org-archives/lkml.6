Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB99C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640992184B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="G4qxDRMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389352AbfAKPT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:19:27 -0500
Received: from mail-eopbgr70093.outbound.protection.outlook.com ([40.107.7.93]:61900
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387562AbfAKPTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:19:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vttgkot6py7X0umJ7OFAEroIqmztlJ7OqxP40/0h054=;
 b=G4qxDRMwUPVjb7vYmyc60HtZK21US4x2zWYBrin0KYaeZkoiqEGRlo3V0iPs2oO7s0DmU3yUYvM0sZ73Ttnxsx0pTP2My9f9/R2aTdFX7iWJ0zCTznyyYCIPhQvmyEd7kLRXYP0B9Ne1F82MSoavu24nSX3HJkvQrogIf7O/DqY=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB3735.eurprd02.prod.outlook.com (52.134.113.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Fri, 11 Jan 2019 15:19:17 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 15:19:17 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v4 5/5] drm/bridge: lvds-encoder: add powerdown-gpios support
Thread-Topic: [PATCH v4 5/5] drm/bridge: lvds-encoder: add powerdown-gpios
 support
Thread-Index: AQHUqcEEETjnMRW/6keq9Pzr1i6FMg==
Date:   Fri, 11 Jan 2019 15:19:17 +0000
Message-ID: <20190111151843.11114-6-peda@axentia.se>
References: <20190111151843.11114-1-peda@axentia.se>
In-Reply-To: <20190111151843.11114-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR07CA0035.eurprd07.prod.outlook.com
 (2603:10a6:7:66::21) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR02MB3735;6:1FrQwai4gvl2zrnbKqLlJK+HjqWmtivxgjuDebElDeglXPWTsREix8CuAX3rOS+G1tZJzJKf6zkH94SLZ6jZre3KhFNe7oVLpt34wHP/si1syGwa3uyj28Fcy17n53Kexg1wJvW2B95ZJBMIeMQ2m3sSQyy6WBoQZIRjOjR55Dmc8wgPOVIhB0PS3Yq3o0KlmCIoHmHFpFpttGGkiWkIfnOI/oVnTP5awRirHSVTlOk7gXOHqlEh/IN0+F/snaK1FNhNM70TAXY2eWWpRMVoAwcHyJ305iPqTDSad/qF+7c0UiOcaaL4pK42NgseLX9lkcTK6JA1JNLzCejAmduWT1QrhsHYreT4vW73YA3j2yE+/W6+zcMrVutNU2Bf6+xNybfVtfKev3Io3GjNRPDAcsgnszfSQI4520/zqkNWTWdpxsEn+DPxX1P800+J1hCk7AXRy+0cbbDDoFhY486/Og==;5:ILar9w64CeYz/QDsYUCyIH7sKH1gjOFbJtDgZ6yLGvWzBSQ/Z4ESDmAOsdGlybISbbIx9OWLlZyaVeaalAp+PxF59tJ5YdKtCsqwLSnm9u8bH1JxRXTIk3J05xrHczI902T3zPhfafD8UnzpiGEop/+w1X2gAv5Pozp1L2lZFvDO5EsA/hJqTb5fQblkAu0n10oO+EPgVv1DxUesPpfRTg==;7:gEuZJsU0BiBSoGWJ1eabQBXxBcTCiCh7F4zeLomqZHClPm9O+8Zqgi1rZHO6ToGSujGuIrt0pv5OZmqYlkxK0fIOmDd7cE8VvM0bsaHX5Q/hzKEcMpLmg/wi//mKrTS/7e3yMpo1k9WYQSf6QQvgGw==
x-ms-office365-filtering-correlation-id: 0459a46b-9908-483e-2e63-08d677d826f8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR02MB3735;
x-ms-traffictypediagnostic: AM6PR02MB3735:
x-microsoft-antispam-prvs: <AM6PR02MB373519591C941EAFF92CFC6DBC850@AM6PR02MB3735.eurprd02.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39830400003)(189003)(199004)(2501003)(1076003)(14454004)(99286004)(54906003)(508600001)(5640700003)(68736007)(6436002)(97736004)(2906002)(71190400001)(2351001)(106356001)(6486002)(316002)(105586002)(71200400001)(86362001)(386003)(6506007)(102836004)(66066001)(6116002)(52116002)(76176011)(3846002)(6512007)(53936002)(2616005)(11346002)(476003)(446003)(74482002)(8676002)(81156014)(81166006)(186003)(486006)(5024004)(256004)(26005)(50226002)(8936002)(14444005)(305945005)(7736002)(5660300001)(6916009)(25786009)(4326008)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB3735;H:AM6PR02MB4470.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mNV1DamDWVm7AH2/WvNgPu+ciYXqa0yztcF6t++JX8YwA5SIuShZwt/0ZBmBflzRQksjhgK+o7F4fl1kSt4wED9gLoaKbMcI+7DLBk4B9qjVBFjxpoXFu4yDxU71fxlN9MiT/27LpnB/bk7ojOq8ns963DCcEC81Delw1w3fUlbnnTE5zFYGYd5y28EpOTJJhTondY2RfBnbMyySQs0/FrARY6u1Gte7sVDBjheiQaRXcvKNzxzQyD+1pilmg4K9WxKR0yT+BUfqIn+0Ybvzs0Bccb0eKoiTHwf78NmG49rMy+jbp6JeGGKrOHi/YszBYCsuDaktUgQAmVGXUJwbDjcE3dGX9Jss9YndvhZTzZ4fPRSmL8sesD+5cTK2WmvQd0UcLoXKnEkRgyHLXNOvIlMvbyZYHZV4r1gRkuXFVoE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 0459a46b-9908-483e-2e63-08d677d826f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 15:19:16.3639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB3735
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optionally power down the LVDS-encoder when it is not in use.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/lvds-encoder.c | 34 +++++++++++++++++++++++++++++++=
+++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/bridge/lvds-encoder.c b/drivers/gpu/drm/bridge=
/lvds-encoder.c
index f6770e83d49d..36d8557bc097 100644
--- a/drivers/gpu/drm/bridge/lvds-encoder.c
+++ b/drivers/gpu/drm/bridge/lvds-encoder.c
@@ -11,11 +11,13 @@
 #include <drm/drm_bridge.h>
 #include <drm/drm_panel.h>
=20
+#include <linux/gpio/consumer.h>
 #include <linux/of_graph.h>
=20
 struct lvds_encoder {
 	struct drm_bridge bridge;
 	struct drm_bridge *panel_bridge;
+	struct gpio_desc *powerdown_gpio;
 };
=20
 static int lvds_encoder_attach(struct drm_bridge *bridge)
@@ -28,8 +30,30 @@ static int lvds_encoder_attach(struct drm_bridge *bridge=
)
 				 bridge);
 }
=20
+static void lvds_encoder_enable(struct drm_bridge *bridge)
+{
+	struct lvds_encoder *lvds_encoder =3D container_of(bridge,
+							 struct lvds_encoder,
+							 bridge);
+
+	if (lvds_encoder->powerdown_gpio)
+		gpiod_set_value_cansleep(lvds_encoder->powerdown_gpio, 0);
+}
+
+static void lvds_encoder_disable(struct drm_bridge *bridge)
+{
+	struct lvds_encoder *lvds_encoder =3D container_of(bridge,
+							 struct lvds_encoder,
+							 bridge);
+
+	if (lvds_encoder->powerdown_gpio)
+		gpiod_set_value_cansleep(lvds_encoder->powerdown_gpio, 1);
+}
+
 static struct drm_bridge_funcs funcs =3D {
 	.attach =3D lvds_encoder_attach,
+	.enable =3D lvds_encoder_enable,
+	.disable =3D lvds_encoder_disable,
 };
=20
 static int lvds_encoder_probe(struct platform_device *pdev)
@@ -45,6 +69,16 @@ static int lvds_encoder_probe(struct platform_device *pd=
ev)
 	if (!lvds_encoder)
 		return -ENOMEM;
=20
+	lvds_encoder->powerdown_gpio =3D devm_gpiod_get_optional(dev, "powerdown"=
,
+							       GPIOD_OUT_HIGH);
+	if (IS_ERR(lvds_encoder->powerdown_gpio)) {
+		int err =3D PTR_ERR(lvds_encoder->powerdown_gpio);
+
+		if (err !=3D -EPROBE_DEFER)
+			dev_err(dev, "powerdown GPIO failure: %d\n", err);
+		return err;
+	}
+
 	/* Locate the panel DT node. */
 	port =3D of_graph_get_port_by_id(dev->of_node, 1);
 	if (!port) {
--=20
2.11.0

