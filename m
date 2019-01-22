Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88880C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C32120870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ChP0oIER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfAVLKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:10:47 -0500
Received: from mail-eopbgr40058.outbound.protection.outlook.com ([40.107.4.58]:27776
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727604AbfAVLKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:10:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzPMk8GQT+yw0+iRNKOpFGt5ux6YFHW1JWjePHnRznc=;
 b=ChP0oIERqlxlUuyNq4it87RQ96m1GhIZFH5PdsQnUlrwUsALUVvHyweyGSBmTex7vODR2LG1pkGi+Yi2pWzzg9ms9kON8W4LiSsnVUGVRjKWfa+o9lmHh6P1duZIDT2xeQBVnrSYZF5PJr4mhDiWRQDlDlLpUj5CC0CiCXlEQH0=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1286.eurprd08.prod.outlook.com (10.168.11.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 11:10:39 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 11:10:39 +0000
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
Subject: [PATCH v2 02/11] drm/komeda: Add komeda_release_unclaimed_resources
Thread-Topic: [PATCH v2 02/11] drm/komeda: Add
 komeda_release_unclaimed_resources
Thread-Index: AQHUskMbvtrhfv1GbUCOatkB88XdEA==
Date:   Tue, 22 Jan 2019 11:10:39 +0000
Message-ID: <20190122110932.5138-3-james.qian.wang@arm.com>
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
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB1286;6:bCQ9CXeII+ROvAFxXo3qOA7WP4cszx1vVn3ULi0NPcanAgCMiUL7x6KZUD2lVkM5FxwVfMEHaRmpzmAGuq6KG+jog1jY+P66pTKxWefdROLfkoLqQObZeR6D2vQUprtKXbH9pWN7znCW3CM0gVymYMDeh9ZY4XEaL8ZcAuSxkob2LdHt3oi120DLyg7UaCT67E0+iOEfH9P3sF1VxxMzs/erHrdv3ufYZpZcVSY1i3fBuoiEoDeofa/YsLQDTbNS1SQfw22viJ3yV+AvH6moTbnDhZhJ9yPkQ+KmrPL3srshV7iSOgorEfw+rssLqBoGbErpWoJEsLFoT1umyJvzXBb4mddHZDFBosjqMj6jKr8XxoBoc6+x9mY/5Hc2nqORVNKcPoKXJJGQWogFkUwdc624AxCQL4KdSMxRpVG00WqNvP1/PLocU0aqLQoz5vICaZUHzueGHPRY0M6cK+WNzw==;5:JPpLibJtvAYh5FjXR2EH3VzdEmD+VNt/hQejae+F6Dn12PAJIlU5Af3UJNCVHdij2LQl74GLObiCO4SaHFeHEkGTvQIyl9HxxE9b4+lZONGK+h6d1xR9FPAe9dxLYHQmYSamsugNlbMDOxOFaEL4usVuAX1m5kFXcGsbe0sSb1z4UyGBC2kDvjXRMCdOB1h/4PPwO2LAc4W7Aycfwastjg==;7:Vf2EZfNJ7jHxLQkeTx30OqI/MhEyjcdwoLUdh/sXTQCgSJipZBabFhj40ecUDXKexWMm7peObbKMKIx8RfPGz2utX6eq5+rmNplBVN1u7AccQ/IkCKbtLZC4oBtOtjwxGBJZMVPNyfetwbOdlZN7uA==
x-ms-office365-filtering-correlation-id: 84797dcd-1c1b-4154-f90f-08d6805a3dd4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1286;
x-ms-traffictypediagnostic: DB6PR0801MB1286:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB12864AD2C9886E855769F4F0B3980@DB6PR0801MB1286.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(2906002)(25786009)(86362001)(36756003)(6116002)(3846002)(4326008)(6636002)(6486002)(103116003)(66066001)(105586002)(106356001)(6512007)(2501003)(53936002)(97736004)(6436002)(446003)(68736007)(81166006)(476003)(50226002)(8676002)(71200400001)(71190400001)(316002)(6506007)(52116002)(81156014)(486006)(11346002)(110136005)(54906003)(99286004)(305945005)(102836004)(14454004)(7736002)(26005)(76176011)(386003)(55236004)(1076003)(8936002)(478600001)(2616005)(186003)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1286;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ol2K178GHRUpAOO29UnsmrdSioiDHUPBRcGQ5xt/65fIz8ZttONSScg6WzjTApsvsH7hpEe9hW+TN93bhAHHEKuEOzUGRVjiE/Qjz3MqRjIVuc7ZJmZK+XpKryOJYqME23IwsUakFffFgOcnxk2KYhoG8h4C0grSC/vOahc4LHv386216ej3z7pGcUmUXXnXkqEdYGxVLeDK0gocKVStIE6hjoF9bfdztXez3XSswpQVwvtAk1/NAkRVj4IwjauQESwSWaMY9dcohnwvEL+41A39J+IIxUSmzvwDL23VsQMeZlbS1MEE6Jha8Gkr+zuBHQb7ztIwJXveQS4hdwW18b0Vh2B8imdM0E3WusH230MKei+gM0+ETpdNNJGsA7bYD6R1Eh0MZ+OHplNXl36saYm6eHy2lGVxFUl9MTM8Who=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84797dcd-1c1b-4154-f90f-08d6805a3dd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 11:10:30.5095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1286
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

Komeda driver treats KMS-CRTC/PLANE as user which will acquire pipeline
resources, but we still need to release the unclaimed resources.
crtc_atomic_check is the final check stage, so beside build a display data
pipeline according the crtc_state, but still needs to release/disable the
unclaimed pipeline resources.

v2: Rebase

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 27 +++++++++
 .../drm/arm/display/komeda/komeda_pipeline.h  |  3 +
 .../display/komeda/komeda_pipeline_state.c    | 58 +++++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 7ca9bc8ef725..a250ab824155 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -14,6 +14,32 @@
 #include "komeda_dev.h"
 #include "komeda_kms.h"
=20
+/* crtc_atomic_check is the final check stage, so beside build a display d=
ata
+ * pipeline according the crtc_state, but still needs to release/disable t=
he
+ * unclaimed pipeline resources.
+ */
+static int
+komeda_crtc_atomic_check(struct drm_crtc *crtc,
+			 struct drm_crtc_state *state)
+{
+	struct komeda_crtc *kcrtc =3D to_kcrtc(crtc);
+	struct komeda_crtc_state *kcrtc_st =3D to_kcrtc_st(state);
+	int err;
+
+	if (state->active) {
+		err =3D komeda_build_display_data_flow(kcrtc, kcrtc_st);
+		if (err)
+			return err;
+	}
+
+	/* release unclaimed pipeline resources */
+	err =3D komeda_release_unclaimed_resources(kcrtc->master, kcrtc_st);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
 			      struct komeda_events *evts)
 {
@@ -33,6 +59,7 @@ void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc=
,
 }
=20
 struct drm_crtc_helper_funcs komeda_crtc_helper_funcs =3D {
+	.atomic_check	=3D komeda_crtc_atomic_check,
 };
=20
 static const struct drm_crtc_funcs komeda_crtc_funcs =3D {
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index 22ad4dfc3e8d..54b646128760 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -409,4 +409,7 @@ int komeda_build_layer_data_flow(struct komeda_layer *l=
ayer,
 int komeda_build_display_data_flow(struct komeda_crtc *kcrtc,
 				   struct komeda_crtc_state *kcrtc_st);
=20
+int komeda_release_unclaimed_resources(struct komeda_pipeline *pipe,
+				       struct komeda_crtc_state *kcrtc_st);
+
 #endif /* _KOMEDA_PIPELINE_H_*/
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 6a481508624f..6797be630529 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -31,6 +31,18 @@ komeda_pipeline_get_state(struct komeda_pipeline *pipe,
 	return priv_to_pipe_st(priv_st);
 }
=20
+struct komeda_pipeline_state *
+komeda_pipeline_get_new_state(struct komeda_pipeline *pipe,
+			      struct drm_atomic_state *state)
+{
+	struct drm_private_state *priv_st;
+
+	priv_st =3D drm_atomic_get_new_private_obj_state(state, &pipe->obj);
+	if (priv_st)
+		return priv_to_pipe_st(priv_st);
+	return NULL;
+}
+
 /* Assign pipeline for crtc */
 struct komeda_pipeline_state *
 komeda_pipeline_get_state_and_set_crtc(struct komeda_pipeline *pipe,
@@ -478,3 +490,49 @@ int komeda_build_display_data_flow(struct komeda_crtc =
*kcrtc,
=20
 	return 0;
 }
+
+void komeda_pipeline_unbound_components(struct komeda_pipeline *pipe,
+					struct komeda_pipeline_state *new)
+{
+	struct drm_atomic_state *drm_st =3D new->obj.state;
+	struct komeda_pipeline_state *old =3D priv_to_pipe_st(pipe->obj.state);
+	struct komeda_component_state *c_st;
+	struct komeda_component *c;
+	u32 disabling_comps, id;
+
+	WARN_ON(!old);
+
+	disabling_comps =3D (~new->active_comps) & old->active_comps;
+
+	/* unbound all disabling component */
+	dp_for_each_set_bit(id, disabling_comps) {
+		c =3D komeda_pipeline_get_component(pipe, id);
+		c_st =3D komeda_component_get_state_and_set_user(c,
+				drm_st, NULL, new->crtc);
+		WARN_ON(IS_ERR(c_st));
+	}
+}
+
+/* release unclaimed pipeline resource */
+int komeda_release_unclaimed_resources(struct komeda_pipeline *pipe,
+				       struct komeda_crtc_state *kcrtc_st)
+{
+	struct drm_atomic_state *drm_st =3D kcrtc_st->base.state;
+	struct komeda_pipeline_state *st;
+
+	/* ignore the pipeline which is not affected */
+	if (!pipe || !has_bit(pipe->id, kcrtc_st->affected_pipes))
+		return 0;
+
+	if (has_bit(pipe->id, kcrtc_st->active_pipes))
+		st =3D komeda_pipeline_get_new_state(pipe, drm_st);
+	else
+		st =3D komeda_pipeline_get_state_and_set_crtc(pipe, drm_st, NULL);
+
+	if (WARN_ON(IS_ERR_OR_NULL(st)))
+		return -EINVAL;
+
+	komeda_pipeline_unbound_components(pipe, st);
+
+	return 0;
+}
--=20
2.17.1

