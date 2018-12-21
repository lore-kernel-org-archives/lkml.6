Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20CBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4E621906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="o4IJeJdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389187AbeLUKAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:00:00 -0500
Received: from mail-eopbgr60069.outbound.protection.outlook.com ([40.107.6.69]:22326
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729268AbeLUJ7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92UZkqWHclV/Uto+etihjeN/lekW+MZ90Day1/phJZI=;
 b=o4IJeJdP9d9MH7MdysXhoUU5DLLXnMTriH3a3k+fU21PJiPOCvuTG+3qpZyObsl9onHcL23c8gcMShZxpW8d0uonNDoOQeCijR3wG4pMuSAAZdwnKh5LbzxqAKJfdMENiu5kvGMF1aVA41yMuvJHiRIoNPDELvnuXhLmTqoIatI=
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com (20.179.35.149) by
 AM0PR08MB3187.eurprd08.prod.outlook.com (52.134.93.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Fri, 21 Dec 2018 09:59:45 +0000
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::1dff:434f:5905:45db]) by AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::1dff:434f:5905:45db%5]) with mapi id 15.20.1446.020; Fri, 21 Dec 2018
 09:59:45 +0000
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
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v3 4/9] drm/komeda: Add DT parsing
Thread-Topic: [PATCH v3 4/9] drm/komeda: Add DT parsing
Thread-Index: AQHUmRPmFz/CSM3MT0ypNcL64pQHzA==
Date:   Fri, 21 Dec 2018 09:59:44 +0000
Message-ID: <20181221095757.15510-5-james.qian.wang@arm.com>
References: <20181221095757.15510-1-james.qian.wang@arm.com>
In-Reply-To: <20181221095757.15510-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SY3PR01CA0099.ausprd01.prod.outlook.com
 (2603:10c6:0:19::32) To AM0PR08MB4483.eurprd08.prod.outlook.com
 (2603:10a6:208:145::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3187;6:cZdF15ti26ZlgG3P4R9/eHg+VP4zVBqnCJ1weDckeMyaDnedGeuL5rPjmQT7noBZtng+bHAnzwlguJHRo+5jOMCcuolF4w6XsMaqE629SGoavm32Gk2Ti592xGxKDNsWLI+6Akh5qMzxLmTMW/3LWTst4fjpnR4C4plbF586cMF0gi9mD0CyHNjjC4FIquMJsn6SwkYcY1XoVc2dpVHTeA6Vb/K0V5o3siwkDr24kbGP4BYI5QJNsNvaMoHmdzLyVzAU8qig/OKtsf5JuVYavRnqoZEk1s0jvkh1tPl0CTP/qWQsRbri2BwGVoRBxtGJNlB1u5AK7Pp2PYk7umMF8bNc5Wtve714bX5Fo6qO0KnrQDPcidSksrVV6JOC5xYqmJKR7z5fVQRtwg7lBB6nTezTIuI2+ZHFn+7O3huj4mw2XdMgDS0uVBGwecCpRa0ieli6cBxlWHgM1HLKFUqG3g==;5:jFKPjzz0jMMia0NiguEO4wKMO49MrVP5dVIF+qXSEH/9VsE+1mDpExxKGUjxt5Jeu9tnlXvZJ9h4Rs6QfpfztsyBsshOe5ivzDT2P/fBq4HeL5/wINQ0943N3yTF8zxFJVpoHYfKPLtgJfpS8QY/ke6Cmen1THkVy/vO3zJDy/o=;7:KK7VFm2vdTZf4NWfM1c+9TiiKDr8KED2mU5vrgGpdtNqjTEnyHUDFZCl7QeLX8tqD3b2mOSj7mSQid38IF6pFubLiivJtnnUoBPf0uXOeWDAGwSF/c3jsXgHx0rYlnlDe+1XMAdrzCbHyNFrHaZFHg==
x-ms-office365-filtering-correlation-id: b0944e13-e296-4fca-3c80-08d6672b089b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3187;
x-ms-traffictypediagnostic: AM0PR08MB3187:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3187E3D05C40FA9B8FDF8F18B3B80@AM0PR08MB3187.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3187;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3187;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(376002)(136003)(366004)(189003)(199004)(71200400001)(97736004)(575784001)(71190400001)(103116003)(86362001)(14454004)(2906002)(5660300001)(106356001)(6116002)(105586002)(66066001)(54906003)(6636002)(3846002)(37006003)(99286004)(68736007)(478600001)(25786009)(6486002)(7736002)(36756003)(6436002)(76176011)(316002)(186003)(386003)(6506007)(55236004)(1076003)(26005)(6512007)(256004)(6862004)(52116002)(81156014)(476003)(486006)(81166006)(7416002)(102836004)(8676002)(305945005)(2616005)(8936002)(53936002)(4326008)(446003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3187;H:AM0PR08MB4483.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: szQTx3CyNle52ZpaDzkxeQ4zHZACKy55JDv0yTLVmiEJsOCFCXkYYckmXbif5eNXrnQqwsz/S/zmDjnWVygtv7bLX7iidhBCa4BtHvShHC9Zglwb8XHtjxfdWYlKyf2/AwQ5d8G/AlOl5+OIJc/7lNLfLshieEixU9NgZnYQI1/w1xbkM1Br1Xd/OtNj0Fa1qzQeL/S1GHg1/7oE1rXBqxGF/Ll+BirI8Aov8iikQVYmLCaRjHRnUDf1gvIuDTsdFTcmOGXMYHUZPHO25NoDDKw/6qS1P4lr7bPqfyAu+5mxF2nQ3im0oTM4ka1HfqZP
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0944e13-e296-4fca-3c80-08d6672b089b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 09:59:44.8652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse DT and initialize corresponding dev/pipeline attributes.

Changes in v3:
- Fixed style problem found by checkpatch.pl --strict.

Changes in v2:
- Unified abbreviation of "pipeline" to "pipe".

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 .../gpu/drm/arm/display/komeda/komeda_dev.c   | 76 +++++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |  3 +
 .../drm/arm/display/komeda/komeda_pipeline.c  |  4 +
 .../drm/arm/display/komeda/komeda_pipeline.h  |  7 ++
 4 files changed, 90 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 887a17005367..d0cc4f758077 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -12,6 +12,76 @@
 #include <linux/version.h>
 #include "komeda_dev.h"
=20
+static int komeda_parse_pipe_dt(struct komeda_dev *mdev, struct device_nod=
e *np)
+{
+	struct komeda_pipeline *pipe;
+	struct clk *clk;
+	u32 pipe_id;
+	int ret =3D 0;
+
+	ret =3D of_property_read_u32(np, "reg", &pipe_id);
+	if (ret !=3D 0 || pipe_id >=3D mdev->n_pipelines)
+		return -EINVAL;
+
+	pipe =3D mdev->pipelines[pipe_id];
+
+	clk =3D of_clk_get_by_name(np, "aclk");
+	if (IS_ERR(clk)) {
+		DRM_ERROR("get aclk for pipeline %d failed!\n", pipe_id);
+		return PTR_ERR(clk);
+	}
+	pipe->aclk =3D clk;
+
+	clk =3D of_clk_get_by_name(np, "pxclk");
+	if (IS_ERR(clk)) {
+		DRM_ERROR("get pxclk for pipeline %d failed!\n", pipe_id);
+		return PTR_ERR(clk);
+	}
+	pipe->pxlclk =3D clk;
+
+	/* enum ports */
+	pipe->of_output_dev =3D
+		of_graph_get_remote_node(np, KOMEDA_OF_PORT_OUTPUT, 0);
+	pipe->of_output_port =3D
+		of_graph_get_port_by_id(np, KOMEDA_OF_PORT_OUTPUT);
+
+	pipe->of_node =3D np;
+
+	return 0;
+}
+
+static int komeda_parse_dt(struct device *dev, struct komeda_dev *mdev)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct device_node *child, *np =3D dev->of_node;
+	struct clk *clk;
+	int ret;
+
+	clk =3D devm_clk_get(dev, "mclk");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	mdev->mclk =3D clk;
+	mdev->irq  =3D platform_get_irq(pdev, 0);
+	if (mdev->irq < 0) {
+		DRM_ERROR("could not get IRQ number.\n");
+		return mdev->irq;
+	}
+
+	for_each_available_child_of_node(np, child) {
+		if (of_node_cmp(child->name, "pipeline") =3D=3D 0) {
+			ret =3D komeda_parse_pipe_dt(mdev, child);
+			if (ret) {
+				DRM_ERROR("parse pipeline dt error!\n");
+				of_node_put(child);
+				break;
+			}
+		}
+	}
+
+	return ret;
+}
+
 struct komeda_dev *komeda_dev_create(struct device *dev)
 {
 	struct platform_device *pdev =3D to_platform_device(dev);
@@ -74,6 +144,12 @@ struct komeda_dev *komeda_dev_create(struct device *dev=
)
 		goto err_cleanup;
 	}
=20
+	err =3D komeda_parse_dt(dev, mdev);
+	if (err) {
+		DRM_ERROR("parse device tree failed.\n");
+		goto err_cleanup;
+	}
+
 	return mdev;
=20
 err_cleanup:
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index 680e3e2cf100..4a27a44e2ec6 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -72,6 +72,9 @@ struct komeda_dev {
 	/** @mck: HW main engine clk */
 	struct clk *mclk;
=20
+	/** @irq: irq number */
+	u32 irq;
+
 	int n_pipelines;
 	struct komeda_pipeline *pipelines[KOMEDA_MAX_PIPELINES];
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.c
index 9293598b0533..e731b2a85c3a 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
@@ -55,6 +55,10 @@ void komeda_pipeline_destroy(struct komeda_dev *mdev,
 	clk_put(pipe->pxlclk);
 	clk_put(pipe->aclk);
=20
+	of_node_put(pipe->of_output_dev);
+	of_node_put(pipe->of_output_port);
+	of_node_put(pipe->of_node);
+
 	devm_kfree(mdev->dev, pipe);
 }
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index 2174796d47c5..d1e0c1140273 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -290,6 +290,13 @@ struct komeda_pipeline {
 	struct komeda_improc *improc;
 	struct komeda_timing_ctrlr *ctrlr;
 	struct komeda_pipeline_funcs *funcs; /* private pipeline functions */
+
+	/** @of_node: pipeline dt node */
+	struct device_node *of_node;
+	/** @of_output_port: pipeline output port */
+	struct device_node *of_output_port;
+	/** @of_output_dev: output connector device node */
+	struct device_node *of_output_dev;
 };
=20
 /**
--=20
2.17.1

