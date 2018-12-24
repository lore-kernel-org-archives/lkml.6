Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAE2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A712171F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ESY3nosy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbeLXI7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 03:59:31 -0500
Received: from mail-eopbgr00062.outbound.protection.outlook.com ([40.107.0.62]:60379
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726906AbeLXI7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 03:59:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM1cU1Yos/Ennfubn3cG7DJuCjX3fte5L5sbueAwVxk=;
 b=ESY3nosypM6ktljcJwcHANlOWSqPhWhUXLJjWiyRMCZBgNtyroURKU1kqL9FSKlvu60d7Tv9Yk1i28DnSayfJCGBcyy4XuTQUF7IrCRtdorAhmbRQmmQDXXNvf7L68tX7d9EUqzi63cS8IGO2eFY/+tzYAuEw3Tz0xsqJg4Hbcs=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0184.eurprd08.prod.outlook.com (10.161.35.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Mon, 24 Dec 2018 08:59:26 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 08:59:26 +0000
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
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH 5/7] drm/komeda: Add komeda_assemble_pipelines
Thread-Topic: [PATCH 5/7] drm/komeda: Add komeda_assemble_pipelines
Thread-Index: AQHUm2b4WAv5mKZwxUeN0dlAHP+0AQ==
Date:   Mon, 24 Dec 2018 08:59:25 +0000
Message-ID: <20181224085716.2325-6-james.qian.wang@arm.com>
References: <20181224085716.2325-1-james.qian.wang@arm.com>
In-Reply-To: <20181224085716.2325-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYBPR01CA0036.ausprd01.prod.outlook.com
 (2603:10c6:10:4::24) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0184;6:pB7xh5fo0a3Y/G+mLkGg6q+GPLjPDOfLgFdjEY7sBb8r3SSQ6qxhcq23SPYcftI1fdSa74r8PEPpbI6BYTC9wiMWF9B5/hB+kxZQT3k5fBT5XJhNKouI6Z6vNKshc+aHtYUIovKDdlRFs6yM1+6snQBODvA3F5f/UcG7a595+N/53wWO+1w40HIEDY3FXBIT7t8oWMyN2nvD95P/1eSiLhH1sbvvHOfo9m+pvLA8n8yEumKnY9cffCHFr8T1K1Adj0Np4iaY6JHqn8y2ys31ASpdn0mJCg186nDWdO+j/6KJ4OTGPP0FsxWhyaREDd5jd7Mzbmo5lEc+T9R4cDFkC5B6B964jDLliDpMiJSTOqksRNmZolsJZc/4LyVv8M4aDG7HSmXOrdxwPASukKKOwrYpvp8u+alZexEEuOFwGInFO+aAzAsfL6RmXYiBfpqkY2j1MN/JTWuq8SK+QgZfcA==;5:QhW6nuOvfBxuGHaEg2klWnHQ4JS9FnurnfsftLjIxswhtBHPSSOXuf62EMhv6MoUWez8PAIQ6o6xY9tDmGGY+mq9fczBCNj47N97xQ2+/tcysVCGc2dNmnMICpqgPXaMrmHzbEnCJbPxhM7fAzrOW5zJhALU9gKjKzT7hCUv7iQ=;7:uxDKd9o4Sr9d5Rc09d7SailAyWjeYcTENO3l3r6L1ySHIUFwbuII+HI+hsaWnPvQXihWQTITPnXIIKdTWadTNjfnDb6b+qpSub7kxsGIoL3WEq6tsMnq3f3U8lCxhJPzymzC0b/96bVjlmJNTPHzSQ==
x-ms-office365-filtering-correlation-id: b6b640d5-77d9-49b7-c484-08d6697e1ab4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0184;
x-ms-traffictypediagnostic: AM3PR08MB0184:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB0184A84BB3E1C9ACB64DCE08B3BB0@AM3PR08MB0184.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0184;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0184;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(346002)(39850400004)(376002)(199004)(189003)(6862004)(11346002)(446003)(36756003)(4326008)(2616005)(99286004)(14454004)(478600001)(476003)(386003)(102836004)(76176011)(52116002)(26005)(66066001)(53936002)(6506007)(3846002)(6116002)(55236004)(186003)(106356001)(97736004)(103116003)(5660300001)(105586002)(2906002)(486006)(6636002)(256004)(305945005)(8936002)(86362001)(6436002)(575784001)(6512007)(68736007)(6486002)(81166006)(25786009)(7736002)(8676002)(71190400001)(1076003)(54906003)(81156014)(37006003)(71200400001)(316002)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0184;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9WfHwd6tBXOfAKRicLn0LEjpJBgW7Fuvb0c6XIohaS1O0k49hFx51Nht0PL1jtd1HQC8CvQwDJmwoB+v3xeGadi3grrgM6GJRzlL7uzKT59ZJwwStTCUTt68Vcl/U0oRjEvdXJNbCUlPkqQqYTFkPjE6t0z1DREz1mHpCEc7xQm7mYk6gFewlc78hCitqcrAU7+lyO+CY4ix2k8Ux6CSUbTWYkoMPExxSVbsjwCKsiyj5B/gEL2MsIEJ0usgJsFH1viLAn+6o8WfwhMlBCCntbqNl0y4NJO83QUCJ+ej1uGJvx4O3Eiulp2KUtwlHWs1
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b640d5-77d9-49b7-c484-08d6697e1ab4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 08:59:26.0198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

komeda_accemble_pipelines is for:

1. Verifing the component->supported_inputs according to the
   pipeline->avail_components.
2. Generating component->supported_outputs.

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 .../gpu/drm/arm/display/komeda/komeda_dev.c   |  6 ++
 .../drm/arm/display/komeda/komeda_pipeline.c  | 75 +++++++++++++++++++
 .../drm/arm/display/komeda/komeda_pipeline.h  |  2 +-
 3 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 2f8f4685eb62..ccadd6c23915 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -152,6 +152,12 @@ struct komeda_dev *komeda_dev_create(struct device *de=
v)
 		goto err_cleanup;
 	}
=20
+	err =3D komeda_assemble_pipelines(mdev);
+	if (err) {
+		DRM_ERROR("assemble display pipelines failed.\n");
+		goto err_cleanup;
+	}
+
 	return mdev;
=20
 err_cleanup:
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.c
index 65b35495d3b7..d0f2d556fc6a 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
@@ -200,3 +200,78 @@ void komeda_component_destroy(struct komeda_dev *mdev,
 {
 	devm_kfree(mdev->dev, c);
 }
+
+static void komeda_component_dump(struct komeda_component *c)
+{
+	if (!c)
+		return;
+
+	DRM_INFO("	%s: ID %d-0x%08lx.\n",
+		 c->name, c->id, BIT(c->id));
+	DRM_INFO("		max_active_inputs:%d, supported_inputs: 0x%08x.\n",
+		 c->max_active_inputs, c->supported_inputs);
+	DRM_INFO("		max_active_outputs:%d, supported_outputs: 0x%08x.\n",
+		 c->max_active_outputs, c->supported_outputs);
+}
+
+static void komeda_pipeline_dump(struct komeda_pipeline *pipe)
+{
+	struct komeda_component *c;
+	int id;
+
+	DRM_INFO("Pipeline-%d: n_layers: %d, n_scalers: %d, output: %s\n",
+		 pipe->id, pipe->n_layers, pipe->n_scalers,
+		 pipe->of_output_dev ? pipe->of_output_dev->full_name : "none");
+
+	dp_for_each_set_bit(id, pipe->avail_comps) {
+		c =3D komeda_pipeline_get_component(pipe, id);
+
+		komeda_component_dump(c);
+	}
+}
+
+static void komeda_component_verify_inputs(struct komeda_component *c)
+{
+	struct komeda_pipeline *pipe =3D c->pipeline;
+	struct komeda_component *input;
+	int id;
+
+	dp_for_each_set_bit(id, c->supported_inputs) {
+		input =3D komeda_pipeline_get_component(pipe, id);
+		if (!input) {
+			c->supported_inputs &=3D ~(BIT(id));
+			DRM_WARN("Can not find input(ID-%d) for component: %s.\n",
+				 id, c->name);
+			continue;
+		}
+
+		input->supported_outputs |=3D BIT(c->id);
+	}
+}
+
+static void komeda_pipeline_assemble(struct komeda_pipeline *pipe)
+{
+	struct komeda_component *c;
+	int id;
+
+	dp_for_each_set_bit(id, pipe->avail_comps) {
+		c =3D komeda_pipeline_get_component(pipe, id);
+
+		komeda_component_verify_inputs(c);
+	}
+}
+
+int komeda_assemble_pipelines(struct komeda_dev *mdev)
+{
+	struct komeda_pipeline *pipe;
+	int i;
+
+	for (i =3D 0; i < mdev->n_pipelines; i++) {
+		pipe =3D mdev->pipelines[i];
+
+		komeda_pipeline_assemble(pipe);
+		komeda_pipeline_dump(pipe);
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index b2bd6ab282cb..df82f986f9c9 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -365,7 +365,7 @@ komeda_pipeline_add(struct komeda_dev *mdev, size_t siz=
e,
 		    struct komeda_pipeline_funcs *funcs);
 void komeda_pipeline_destroy(struct komeda_dev *mdev,
 			     struct komeda_pipeline *pipe);
-
+int komeda_assemble_pipelines(struct komeda_dev *mdev);
 struct komeda_component *
 komeda_pipeline_get_component(struct komeda_pipeline *pipe, int id);
=20
--=20
2.17.1

