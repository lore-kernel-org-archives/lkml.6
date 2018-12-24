Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0060EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DB2217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="LWnPYUBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbeLXJZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:25:44 -0500
Received: from mail-eopbgr150081.outbound.protection.outlook.com ([40.107.15.81]:11941
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725294AbeLXJZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1T2N+TycWhJ6DsdqJo/0bi/+EXQuUQ+8DdyoNdukMg=;
 b=LWnPYUBS6HfqTjjANzdu2XqSRgDqLTMB1WN12d4STQrdiqwXu2E6jtGqGShruUaqcW8ue8OiuTODPOOB60Qqbvshjb+IIKb+lo7zaRMPmEhdMadXIfz8CJbfU26kg6t7kqihW4fyivLyYHcN1wPKemnRHQ63UfJk7TBOg+F3gnA=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0262.eurprd08.prod.outlook.com (10.161.35.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Mon, 24 Dec 2018 09:25:36 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 09:25:36 +0000
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
Subject: [PATCH 02/11] drm/komeda: Add komeda_release_unclaimed_resources
Thread-Topic: [PATCH 02/11] drm/komeda: Add komeda_release_unclaimed_resources
Thread-Index: AQHUm2qgbpr3MDaMjUmvP8RL3EQTdw==
Date:   Mon, 24 Dec 2018 09:25:36 +0000
Message-ID: <20181224092435.2792-3-james.qian.wang@arm.com>
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
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0262;6:idlLqi5AjrQ0r0iAXiIgFxhD8ssHbbS2fBQawLR7iqYSUEmVdyPsXZ/+p8KcFihQqYT/wXoHLVffi+pMMj+hNvLxOW4IpEwFrEiYsSSW4yQhV+XX/7wcCi4mLE8sE5Cz1vtLkwjfeIl4PkmHstgxgI0ILrT4NQqjJDC9YKnmXrezFCbuVZ6CzMVSEVsVgk8h+kZBqMRMHbCFKuXUTxodwuMc7U2ycKbvePgn7pSNkP/+WZ3XWcQp/yWrmdyicyyy522NdU0Pvm+ildKGPOjvHPpJu/kDR7hOQfWPekK66F3mFGy6AdcJZvdXlU7SYITfgsph/yiB6JkQBSUQiuy8fxNMf+Z8pvVTNXKn3Dsqvnzf6DN480a7q0g6ZqDRF1fvSVEq4XB4kTdeZ0EryJ4vptwlL8YCHMhRtfUMqH30Bh0Lls7TILIdvAXxw7j9Pvb5XlUBF+0Wuy/lGXAnWJHgXA==;5:1ZgqSP6+ORZWIGW5iAOPCtwXXznmpP3etLxXp1aH1Timk+7vIdYiBqW7peWDZSwRROhd4STEtHQNta7u0qMigR+2reJLmA2bMtbj6YcCx/tguA4Web41fXWt/gc05UHLMFWU1m/DOm/0f2iBlWCAYMoGRli2ZgHkmEuZqTOMycQ=;7:tKafw3usvwm9ZwHU8B64RbtAJJyONOxTozzDOaeWplbbg2q8TpE9lkvrs21p313wVwaZpzrmVkS3CYm9zSa1ixaDx7iKe/ZZXzlqIN2lLXu4jxTubYK0ib7i2uaG33zbt+ska48XztpxvV0ju6TNmQ==
x-ms-office365-filtering-correlation-id: 7c28083e-988d-4f00-f20d-08d66981c2bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0262;
x-ms-traffictypediagnostic: AM3PR08MB0262:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB0262844B1550A9FEB301D47CB3BB0@AM3PR08MB0262.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0262;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0262;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(39850400004)(346002)(199004)(189003)(4326008)(256004)(305945005)(53936002)(6862004)(71190400001)(71200400001)(486006)(7736002)(97736004)(446003)(2906002)(52116002)(6116002)(76176011)(1076003)(6436002)(86362001)(6512007)(5660300001)(11346002)(186003)(26005)(68736007)(3846002)(2616005)(476003)(55236004)(386003)(102836004)(6506007)(25786009)(103116003)(14454004)(105586002)(99286004)(54906003)(37006003)(6486002)(106356001)(316002)(8676002)(81166006)(81156014)(8936002)(6636002)(36756003)(478600001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0262;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: INRGs08h2PKDgHaUggLeFDOtRhyMwWdxE1aW4zCetaVLAnX8IVpHuWsLWTjctIvmJkBcors+jtnKA0/LtJweuGW/IppwUjjGTVMJy1qjFz7KBEFoivC+RY4TqEBKWJptzE5f67DVMkO91u//mE/cgWWOl9V4rTUCYLsTtbLF6y2Aln7445CiabNnMabybAIfljx5Ye3CSYLOcI+D1wBVyDoraJcAGKIu1SRlM0+KoTLaIHLzc2cHxjcUf2y3ZD/ry8z966TkH2yPBfwFIGS61H7ruwwU9Z1NScSGuJsMZWoRgG0za+hvdLwZiyaHyxFy
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c28083e-988d-4f00-f20d-08d66981c2bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 09:25:36.2211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Komeda driver treats KMS-CRTC/PLANE as user which will acquire pipeline
resources, but we still need to release the unclaimed resources.
crtc_atomic_check is the final check stage, so beside build a display data
pipeline according the crtc_state, but still needs to release/disable the
unclaimed pipeline resources.

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 27 +++++++++
 .../drm/arm/display/komeda/komeda_pipeline.h  |  3 +
 .../display/komeda/komeda_pipeline_state.c    | 58 +++++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index c896e46203ed..f84024aae155 100644
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
index bc4ed1513348..9a17d0152021 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -418,4 +418,7 @@ int komeda_build_layer_data_flow(struct komeda_layer *l=
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
index 05386e9d1749..920d2b40e9cc 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -42,6 +42,18 @@ komeda_pipeline_get_state(struct komeda_pipeline *pipe,
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
 /* Assign a pipeline crtc */
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

