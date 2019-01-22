Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4511BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043B7218D9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="b08p4+o4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfAVJYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:24:24 -0500
Received: from mail-eopbgr20056.outbound.protection.outlook.com ([40.107.2.56]:36575
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727509AbfAVJYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jj3sKy1CbV1WMSJ/t0ce9CVbMK6fi2LP4uZcT0YrSgg=;
 b=b08p4+o42XteigVl+5g3UHavWKBlTEiRc5P3z8fEQYTQAWD7lmIy9hnGdLrv2H1iEJZD5DJ8/u0FPGvAU71kWAc64QcaxOLq26kRegNqgYV78SiOuuQNCkRH1F8L9nwzXt1LfE0VV8FS90qsPogMM6B/2hHwxqpTqehcMPtGBoM=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1928.eurprd08.prod.outlook.com (10.168.83.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.28; Tue, 22 Jan 2019 09:24:16 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 09:24:16 +0000
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
Subject: [PATCH v2 5/7] drm/komeda: Add komeda_assemble_pipelines
Thread-Topic: [PATCH v2 5/7] drm/komeda: Add komeda_assemble_pipelines
Thread-Index: AQHUsjQ/Nq97cGQwxkylK1+kQFwnzw==
Date:   Tue, 22 Jan 2019 09:24:16 +0000
Message-ID: <20190122092243.21226-6-james.qian.wang@arm.com>
References: <20190122092243.21226-1-james.qian.wang@arm.com>
In-Reply-To: <20190122092243.21226-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYCPR01CA0039.ausprd01.prod.outlook.com
 (2603:10c6:10:e::27) To DB6PR0801MB1990.eurprd08.prod.outlook.com
 (2603:10a6:4:6c::21)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB1928;6:RKdPFOHFjTiQ9dGc7Qvf6w8SPR6dBOxXL/2eQzjHMNlVfGNE0IYD4glqiHLfTE55dflCXO1RPrUuBSXPmjb6r2Z+jGrdRd5MLpXZEt+/fQWfyfaC05TpCciYPtG9g6Gkn9lpsG43Iv1/VY2U9QDBpvlqBlSF8V57gpk9dWhnsfYhVklkh3QuaJd4KRrOlWMmc12z+UdPtoHxFQK1RUmGA7Gz/BE4zfDzoifW8+DAmJDOH/qh5zZG/Np307FVZb95T05byXtkBSJabNRQhyg9L5iGEQ5KKlFCNdaxVvUjalCmR327miTQbhuSFfGvWfsDYEaA19F3mKinKtsPvvMxzwar+vFQNIIvICNlvAi7iZ7pJWkqv8Z+TfeXG3ZQmMviBWlC+X3N7/3LkL2S3WL0RqgiH7Hn0OK6wh40bggD5NTvM6y77gogKObdvSPpLzLl6NE6b5Kxj6/A4qMk6NebGQ==;5:WpwlrVKNk024bfbRRuo5E1Skr7pm6cDiCE+293NFTrVvL9I3M8Jx+sfhVPertULw6iCalc8EBqHu3yZrh1apBQ5nzmeamcNYWXDDL8Pv+Ugb8+H/XHi3ROrNSMHCYMbWtam/+p5bxDIk80v1bLd558BUt9JEFg1WeKR5g04pxurtRAQ+YU3nc/GQDmGp3nEzPx+jDERbXEAQxHiEjn8N2A==;7:1UNsp5Ohxe47Kc3cJg6bXY1NRjcA9dM5iFvy00DEpJH0PW7/AxQ9zt2HBZGbQ7iUQ0ZgXeQ32CkAIU8e+ISOYRU4BG77hvFyaFSjwjrIDY9UylRgNtQzDxpJeev3vxeM0h5sWtxE+5sHfTSLqSbhCw==
x-ms-office365-filtering-correlation-id: 00a25407-4158-45bc-2ff4-08d6804b6154
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1928;
x-ms-traffictypediagnostic: DB6PR0801MB1928:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB19280FF339BA8990FF5245D8B3980@DB6PR0801MB1928.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(396003)(136003)(199004)(189003)(3846002)(76176011)(99286004)(26005)(486006)(6116002)(71200400001)(110136005)(2906002)(71190400001)(316002)(103116003)(256004)(305945005)(14444005)(7736002)(53936002)(81166006)(8676002)(81156014)(54906003)(6436002)(6486002)(50226002)(2501003)(66066001)(68736007)(6512007)(106356001)(105586002)(52116002)(6346003)(8936002)(1076003)(4326008)(6636002)(476003)(97736004)(2616005)(478600001)(446003)(86362001)(102836004)(11346002)(14454004)(6506007)(386003)(186003)(55236004)(36756003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1928;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: upueNz9gqvfgmcb0OJ2JH0jqvNtu7pKQ2VSptJgSU/SpleCFDvGvyghCRzvmEUp5Ez5th/6WF7Vo6nmGCWLitIG3YV05Hx28a47nk5BJw96Te6lSZ9ElXeIdeESxkvD8fkH/ZP0bm+bcSKArBGX5JfEve0Y2TcLF0Y9Ei3huTKvg0ZJCVl2oC7cLD1SwFitF6NYMjBsEb0AP331ZZwWoapfDCikyI+vTSdfaJItJ7cP/8hrPDrTDhEmBl1AGFXYDoAQcA3ZGglQT6xFvebQIBWF4MKDrqCh+6TbKDQTBS4XPqwAw6qpoS/K7PvPTu5ft9kdx8mHT4FsxdWQYrTlzvo2FqjFxvvq0gJa8WwuFTfe1Bl3nG0rucOb2ev9OxNwWOd2hLAQTUqBC9NJgY5f2u9oEJPHfaID/+39ailEd11E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a25407-4158-45bc-2ff4-08d6804b6154
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 09:24:08.2219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1928
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

komeda_accemble_pipelines is for:

1. Verifing the component->supported_inputs according to the
   pipeline->avail_components.
2. Generating component->supported_outputs.

v2: Lower the debug message of komeda_component_dump to DRM_DEBUG.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../gpu/drm/arm/display/komeda/komeda_dev.c   |  6 ++
 .../drm/arm/display/komeda/komeda_pipeline.c  | 75 +++++++++++++++++++
 .../drm/arm/display/komeda/komeda_pipeline.h  |  2 +-
 3 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 0fe6954fbbf4..a1160e2f07ec 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -143,6 +143,12 @@ struct komeda_dev *komeda_dev_create(struct device *de=
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
index f755280caa3e..c2e469164244 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
@@ -198,3 +198,78 @@ void komeda_component_destroy(struct komeda_dev *mdev,
 {
 	devm_kfree(mdev->dev, c);
 }
+
+static void komeda_component_dump(struct komeda_component *c)
+{
+	if (!c)
+		return;
+
+	DRM_DEBUG("	%s: ID %d-0x%08lx.\n",
+		  c->name, c->id, BIT(c->id));
+	DRM_DEBUG("		max_active_inputs:%d, supported_inputs: 0x%08x.\n",
+		  c->max_active_inputs, c->supported_inputs);
+	DRM_DEBUG("		max_active_outputs:%d, supported_outputs: 0x%08x.\n",
+		  c->max_active_outputs, c->supported_outputs);
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
index 943aa52189d4..f9b7f517a484 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -363,7 +363,7 @@ komeda_pipeline_add(struct komeda_dev *mdev, size_t siz=
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

