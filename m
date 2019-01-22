Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61962C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EA220870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="g+q+lx15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfAVLKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:10:35 -0500
Received: from mail-eopbgr20056.outbound.protection.outlook.com ([40.107.2.56]:10757
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727604AbfAVLKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:10:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Heer9f5BagOKIIY52PvgDaav672wxASyrU7iQljnGOc=;
 b=g+q+lx15yMYekEqn6D0gQAMo62vYNzZGJMW5LxUXJy91HvF+CRF3pWuDzhf+bom5Hlr6JrM8RubFQeAOwBLyEnP7SJGITd0XUWGEalpsBWTf7Xu/0GudO/AhVX05kgtHq8zDIp8SeXpuOYXUrmeXMKTXJv5L1Nyhz1TjKsJELqQ=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB2088.eurprd08.prod.outlook.com (10.168.87.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.28; Tue, 22 Jan 2019 11:10:30 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 11:10:30 +0000
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
Subject: [PATCH v2 01/11] drm/komeda: Add komeda_build_display_data_flow
Thread-Topic: [PATCH v2 01/11] drm/komeda: Add komeda_build_display_data_flow
Thread-Index: AQHUskMVYIlkrRHZF0SiTtKrhRQ0fA==
Date:   Tue, 22 Jan 2019 11:10:30 +0000
Message-ID: <20190122110932.5138-2-james.qian.wang@arm.com>
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
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB2088;6:S7infNF6tk02fkCjQyLqJk5Ej+QBR/1zOFM+q02pgIZUPKe7F4U24bn8KK3QIlgB60mbY8zjbWmviDgcLcxWwGZ7xN9rV5yfN0J+gzLblXEcQI00dt/6V9PBHjRtedV+nhsMm9QgeS/ltcfmAn6DZZlBGo+RyV9inf6yXshShveK5yBDBSWqHO1hjl6EhN8aiB7xUCRjZdtGFY7hWp2izUJT9hd/liT0dmFSUUs6aGsW4CJMAZ1q3eaTtdx8RGxQoGe+Zr01DSUKGssBtZF+26MppQYRrusPD22qQRJUCp6zxkw1+MrZwi5433dS5m9pkc7m2YOtl0bRndU7rPEMVWOCdVSG9KPwbr3YXcMKq7JkR/hBr9/KFdHnWZUxy6yZ3CLUaCfkAL8cIKO+TV1cir1XifxwYBa7XUx613D74c9cP6LDFtXe0cNIHEPE/ASNpQvpHuF0ewseFswOT/IjrQ==;5:54wEIkwAr1JZtkQjKxQxevYcV4X2XXJc0We9nFUhsCA6p07ECaNZnktsxMrPzOGiER4UCryvMgEqXyrVU4ztiS7OS5F+sipFeq1n5luwU7EG5qEqDi/6FotG8AsWmQ9jiGs4scAXfEngKliBSxG/QtnvJ0/RsQ+KtJQ+ITuEDEqMr39LeARFKw0ITz/1IGbw2bmvqorqpORh/gibWcwBnA==;7:mgdO2BMgcisErujqs7RYnk1MZsVdUq0A9E4ozTDRRX3j2faifByaAgW4SYONLbC4h6dR6AOd7Yumf/02Q44uKhokfqLRBsI/6Qk3b+q8KQB5U0EiKX2o78W7SdgN8bXQ2y7VaERUTXxRM608oVPJwA==
x-ms-office365-filtering-correlation-id: f23e699a-86af-4f16-3abd-08d6805a3805
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2088;
x-ms-traffictypediagnostic: DB6PR0801MB2088:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB20880636891F65EF94A06AE0B3980@DB6PR0801MB2088.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(346002)(39860400002)(376002)(189003)(199004)(7736002)(76176011)(2501003)(52116002)(256004)(478600001)(55236004)(14444005)(102836004)(6506007)(14454004)(4326008)(386003)(53936002)(186003)(8676002)(6636002)(103116003)(6512007)(26005)(6486002)(50226002)(6436002)(8936002)(6116002)(3846002)(81166006)(81156014)(316002)(106356001)(99286004)(71200400001)(97736004)(110136005)(54906003)(1076003)(2906002)(105586002)(25786009)(36756003)(71190400001)(11346002)(446003)(476003)(68736007)(2616005)(86362001)(486006)(66066001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB2088;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CgImJmT8LMFcxSoNDAxGMCPBZAQnJhGsMn15I1Tut9EN4RBaCglQd/RFoY/Lwd81tUtPUkVRiVx6YMnWYmOF6YlkJ3engquMN8YSDLnCdVGG6Z3QNoEavVpwHXQa8H8fizZC0YQk0IuUu/FycHoPtc3SKKTGUNzaAOX0qxn1+rsP7AhRn974CoRu3R+V/W9OCJHcWg9ixS6EPFZmYqQaTGuqI8edoqipkl1pj0vcBbidIRl2mOvjACWSYItba8/pK9lmcfoXYoKlggTEhb7uo5KBO5krAy8lBaoth1PdnQ7Oa8mlJcJFNwiLBOCrlkknWJO2eGrrbDwCRdRy39Nmz0YOooRxEKR4FaKAadYvHVzHtyGfebilHn6ULyw0ySI7gVw9CbFvlY87VX7zUCKz2OwyRpFsXocYObCAJZLm+nI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f23e699a-86af-4f16-3abd-08d6805a3805
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 11:10:21.3688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

This function builds a display output pipeline according to crtc_state.
And this change only added single pipeline support, the dual pipeline with
slave enabled data flow support will be added in the following change.

v2: Rebase

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../drm/arm/display/komeda/komeda_pipeline.h  |  3 +
 .../display/komeda/komeda_pipeline_state.c    | 76 ++++++++++++++++++-
 2 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index 16d7ae891e81..22ad4dfc3e8d 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -400,10 +400,13 @@ void komeda_component_destroy(struct komeda_dev *mdev=
,
=20
 struct komeda_plane_state;
 struct komeda_crtc_state;
+struct komeda_crtc;
=20
 int komeda_build_layer_data_flow(struct komeda_layer *layer,
 				 struct komeda_plane_state *kplane_st,
 				 struct komeda_crtc_state *kcrtc_st,
 				 struct komeda_data_flow_cfg *dflow);
+int komeda_build_display_data_flow(struct komeda_crtc *kcrtc,
+				   struct komeda_crtc_state *kcrtc_st);
=20
 #endif /* _KOMEDA_PIPELINE_H_*/
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 74d25e542103..6a481508624f 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -344,7 +344,7 @@ komeda_compiz_set_input(struct komeda_compiz *compiz,
 	return 0;
 }
=20
-int
+static int
 komeda_compiz_validate(struct komeda_compiz *compiz,
 		       struct komeda_crtc_state *state,
 		       struct komeda_data_flow_cfg *dflow)
@@ -382,6 +382,53 @@ komeda_compiz_validate(struct komeda_compiz *compiz,
 	return 0;
 }
=20
+static int
+komeda_improc_validate(struct komeda_improc *improc,
+		       struct komeda_crtc_state *kcrtc_st,
+		       struct komeda_data_flow_cfg *dflow)
+{
+	struct drm_crtc *crtc =3D kcrtc_st->base.crtc;
+	struct komeda_component_state *c_st;
+	struct komeda_improc_state *st;
+
+	c_st =3D komeda_component_get_state_and_set_user(&improc->base,
+			kcrtc_st->base.state, crtc, crtc);
+	if (IS_ERR(c_st))
+		return PTR_ERR(c_st);
+
+	st =3D to_improc_st(c_st);
+
+	st->hsize =3D dflow->in_w;
+	st->vsize =3D dflow->in_h;
+
+	komeda_component_add_input(&st->base, &dflow->input, 0);
+	komeda_component_set_output(&dflow->input, &improc->base, 0);
+
+	return 0;
+}
+
+static int
+komeda_timing_ctrlr_validate(struct komeda_timing_ctrlr *ctrlr,
+			     struct komeda_crtc_state *kcrtc_st,
+			     struct komeda_data_flow_cfg *dflow)
+{
+	struct drm_crtc *crtc =3D kcrtc_st->base.crtc;
+	struct komeda_timing_ctrlr_state *st;
+	struct komeda_component_state *c_st;
+
+	c_st =3D komeda_component_get_state_and_set_user(&ctrlr->base,
+			kcrtc_st->base.state, crtc, crtc);
+	if (IS_ERR(c_st))
+		return PTR_ERR(c_st);
+
+	st =3D to_ctrlr_st(c_st);
+
+	komeda_component_add_input(&st->base, &dflow->input, 0);
+	komeda_component_set_output(&dflow->input, &ctrlr->base, 0);
+
+	return 0;
+}
+
 int komeda_build_layer_data_flow(struct komeda_layer *layer,
 				 struct komeda_plane_state *kplane_st,
 				 struct komeda_crtc_state *kcrtc_st,
@@ -404,3 +451,30 @@ int komeda_build_layer_data_flow(struct komeda_layer *=
layer,
=20
 	return err;
 }
+
+/* build display output data flow, the data path is:
+ * compiz -> improc -> timing_ctrlr
+ */
+int komeda_build_display_data_flow(struct komeda_crtc *kcrtc,
+				   struct komeda_crtc_state *kcrtc_st)
+{
+	struct komeda_pipeline *master =3D kcrtc->master;
+	struct komeda_data_flow_cfg m_dflow; /* master data flow */
+	int err;
+
+	memset(&m_dflow, 0, sizeof(m_dflow));
+
+	err =3D komeda_compiz_validate(master->compiz, kcrtc_st, &m_dflow);
+	if (err)
+		return err;
+
+	err =3D komeda_improc_validate(master->improc, kcrtc_st, &m_dflow);
+	if (err)
+		return err;
+
+	err =3D komeda_timing_ctrlr_validate(master->ctrlr, kcrtc_st, &m_dflow);
+	if (err)
+		return err;
+
+	return 0;
+}
--=20
2.17.1

