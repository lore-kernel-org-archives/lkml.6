Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1E9C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132CF20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="CLL7MLLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfAVLGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:06:32 -0500
Received: from mail-eopbgr60069.outbound.protection.outlook.com ([40.107.6.69]:8733
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727844AbfAVLG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:06:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVhguXBKg59S2ULtp2WFz/rlQV5iLeY2C8m6+RDwUJI=;
 b=CLL7MLLkjOsZrCIG2r57+fR2086M3IHQqqrIQE7LREj5BHGPqXCGmLJDiTurNRBnoGYHuLxyhle/B7hbhnkcX7ye72kZK2+f5mj64b+UOJMywAUcwErwonDqRKNqJIcFvXyCCDyej9stit46eIPYBSf8aeKuT1Lb4H9gk0MppEw=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1671.eurprd08.prod.outlook.com (10.169.226.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 11:06:01 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 11:06:01 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>
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
Subject: [PATCH v2 3/5] drm/komeda: Initialize komeda component as drm private
 object
Thread-Topic: [PATCH v2 3/5] drm/komeda: Initialize komeda component as drm
 private object
Thread-Index: AQHUskJ1xSsHYVvj3E296Mdq3/SoRg==
Date:   Tue, 22 Jan 2019 11:06:01 +0000
Message-ID: <20190122110431.5025-4-james.qian.wang@arm.com>
References: <20190122110431.5025-1-james.qian.wang@arm.com>
In-Reply-To: <20190122110431.5025-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYAPR01CA0021.ausprd01.prod.outlook.com (2603:10c6:1::33)
 To DB6PR0801MB1990.eurprd08.prod.outlook.com (2603:10a6:4:6c::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB1671;6:SKdjLVNJCJabILmM6Hiqb/hDFallzIEIB++pONIWGZiANUV7nm6UO2pzv57r2S0kMEGCETnod1jvAzJOhg9Thfytw/VvIPHCsj3PnkcBjpIkGH4Gv3YRHvBOZ6o28+vnN8HUu8FI5fJ1pSpVE9U8bPH0W66Bq8Rc0owsGTJc7KdLs2/wKpCO0znQoQ5AUDfLqg6HkoW6nXf6inOaKXcWZx7G2UI6XofHW8nYlXTHXoanqzyizvBjH2rSR+SA4sqtaxlOAxSVc2T8tAz/xaQ5ATWoXZeHEiuZUT5tC63LB10k2n5sDgLN79vrTGyTTzuKr1lh+7GhzXK0IkaILFkEmFC+OCHf9Nqc2r+QGjFIYgm6CIpmI8p+pK05EkhcDdtyfeFiEzr8Q24V4LC7qa99M017UM80SELD++bDoAs1sHgb3FDNbspoE2cIeJPK7HTJr4bJ2FXM20r2dIzmwB2FsA==;5:nSz6rkjwLMZKzyVNnlHBiCT1DBJnJTz0X8K82ktNtZ3M0F2QXa7rYlz/dzGtatLCmbqL0dqor2xhSuGEn26V5BBJ4ltZLEVGezhzQr/1to6qU+X9kPEuMmHbQFYUPKKEQZigndmeZOjWhh0fOrvXY6z71lWrCFx67MxsZmdf78q4lM0zGzqmIAQf7iOihhi1AQy9z0iuRzDdKASwGOgT4Q==;7:IuPurhEykawgp7dsJScD3XHEEX8qTz290aH630FstjTuZ9/7wEVloHhXt9Mbw9puSvjmoZNLvzr1razKULcBiBqk0eaLE7W0CsUHkVfn7VYa0U0b4kK4722uZpjXQbcak7WzQJg5F0X7cqyod9ozEw==
x-ms-office365-filtering-correlation-id: 686e110c-628a-496f-1694-08d6805997d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1671;
x-ms-traffictypediagnostic: DB6PR0801MB1671:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB16718434328B2C47900BB838B3980@DB6PR0801MB1671.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(2906002)(25786009)(86362001)(36756003)(6116002)(3846002)(4326008)(2201001)(6486002)(103116003)(66066001)(105586002)(106356001)(6512007)(2501003)(53936002)(97736004)(6436002)(446003)(68736007)(81166006)(476003)(50226002)(8676002)(71200400001)(71190400001)(316002)(6506007)(52116002)(81156014)(486006)(11346002)(110136005)(54906003)(99286004)(305945005)(102836004)(14454004)(7736002)(26005)(76176011)(386003)(55236004)(1076003)(8936002)(478600001)(2616005)(186003)(5024004)(14444005)(256004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1671;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I60++D13Abk3NGg0B53VGFIDjg4MJbo6WP/MLpfgRmrfTv8zCq6CBdjiSgOQe0qXCUuS6OswAqApzeYKiaW6mxHadgrkuas1X8ZcRNpalT8bEqvwpu0v5ECQDo4Ps9l3nj7doGMZsXZWyKdyCEtH8MQtEwUeXil8WldTwFl4DBjFXxT5s97CGlPTch9Mh//5scP1bkuO+POGyjjDQhpJi2mGN30FEuGNuLc07EgLdfTB00m4B2hn2/S/Z8khndx1AiLFEiPr+ujHI0MAHaBWvdcDFdpviNmBXw7K8Ph6T2hsf24562hewyz5D7HmQyt7cfJnyT+tyTTxkFQIN55XAhbgpcgGnmO9L0DHIkYN+tq6jc4gmCw3a3o473dPzh8gxVjPRfn9kiIsDZDHoKasfKOkUWNNIBOoftamDHXq9XI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 686e110c-628a-496f-1694-08d6805997d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 11:05:51.7257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1671
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

Initialize koemda_layer, komeda_compiz, komeda_improc and
komeda_timing_ctrlr as drm private object, then track komeda private
component state by drm_atomic_state.

v2:
- Update code after Applied commit:
  b962a12050a3 ("drm/atomic: integrate modeset lock with private objects")

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../gpu/drm/arm/display/komeda/komeda_kms.c   |   3 +-
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |   2 +-
 .../arm/display/komeda/komeda_private_obj.c   | 220 ++++++++++++++++--
 3 files changed, 208 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.c
index 4adc6a3104c9..7d7fb5013464 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -179,6 +179,7 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_=
dev *mdev)
 	drm_irq_uninstall(drm);
 cleanup_mode_config:
 	drm_mode_config_cleanup(drm);
+	komeda_kms_cleanup_private_objs(kms);
 free_kms:
 	kfree(kms);
 	return ERR_PTR(err);
@@ -193,7 +194,7 @@ void komeda_kms_detach(struct komeda_kms_dev *kms)
 	drm_dev_unregister(drm);
 	drm_irq_uninstall(drm);
 	component_unbind_all(mdev->dev, drm);
-	komeda_kms_cleanup_private_objs(mdev);
+	komeda_kms_cleanup_private_objs(kms);
 	drm_mode_config_cleanup(drm);
 	drm->dev_private =3D NULL;
 	drm_dev_put(drm);
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.h
index 0faeeac2765a..06394716367b 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -107,7 +107,7 @@ int komeda_kms_add_crtcs(struct komeda_kms_dev *kms, st=
ruct komeda_dev *mdev);
 int komeda_kms_add_planes(struct komeda_kms_dev *kms, struct komeda_dev *m=
dev);
 int komeda_kms_add_private_objs(struct komeda_kms_dev *kms,
 				struct komeda_dev *mdev);
-void komeda_kms_cleanup_private_objs(struct komeda_dev *mdev);
+void komeda_kms_cleanup_private_objs(struct komeda_kms_dev *kms);
=20
 void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
 			      struct komeda_events *evts);
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c b/driv=
ers/gpu/drm/arm/display/komeda/komeda_private_obj.c
index f1c9e3fefa86..a54878cbd6e4 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
@@ -7,6 +7,188 @@
 #include "komeda_dev.h"
 #include "komeda_kms.h"
=20
+static void
+komeda_component_state_reset(struct komeda_component_state *st)
+{
+	st->binding_user =3D NULL;
+	st->affected_inputs =3D st->active_inputs;
+	st->active_inputs =3D 0;
+	st->changed_active_inputs =3D 0;
+}
+
+static struct drm_private_state *
+komeda_layer_atomic_duplicate_state(struct drm_private_obj *obj)
+{
+	struct komeda_layer_state *st;
+
+	st =3D kmemdup(obj->state, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return NULL;
+
+	komeda_component_state_reset(&st->base);
+	__drm_atomic_helper_private_obj_duplicate_state(obj, &st->base.obj);
+
+	return &st->base.obj;
+}
+
+static void
+komeda_layer_atomic_destroy_state(struct drm_private_obj *obj,
+				  struct drm_private_state *state)
+{
+	struct komeda_layer_state *st =3D to_layer_st(priv_to_comp_st(state));
+
+	kfree(st);
+}
+
+static const struct drm_private_state_funcs komeda_layer_obj_funcs =3D {
+	.atomic_duplicate_state	=3D komeda_layer_atomic_duplicate_state,
+	.atomic_destroy_state	=3D komeda_layer_atomic_destroy_state,
+};
+
+static int komeda_layer_obj_add(struct komeda_kms_dev *kms,
+				struct komeda_layer *layer)
+{
+	struct komeda_layer_state *st;
+
+	st =3D kzalloc(sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	st->base.component =3D &layer->base;
+	drm_atomic_private_obj_init(&kms->base, &layer->base.obj, &st->base.obj,
+				    &komeda_layer_obj_funcs);
+	return 0;
+}
+
+static struct drm_private_state *
+komeda_compiz_atomic_duplicate_state(struct drm_private_obj *obj)
+{
+	struct komeda_compiz_state *st;
+
+	st =3D kmemdup(obj->state, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return NULL;
+
+	komeda_component_state_reset(&st->base);
+	__drm_atomic_helper_private_obj_duplicate_state(obj, &st->base.obj);
+
+	return &st->base.obj;
+}
+
+static void
+komeda_compiz_atomic_destroy_state(struct drm_private_obj *obj,
+				   struct drm_private_state *state)
+{
+	kfree(to_compiz_st(priv_to_comp_st(state)));
+}
+
+static const struct drm_private_state_funcs komeda_compiz_obj_funcs =3D {
+	.atomic_duplicate_state	=3D komeda_compiz_atomic_duplicate_state,
+	.atomic_destroy_state	=3D komeda_compiz_atomic_destroy_state,
+};
+
+static int komeda_compiz_obj_add(struct komeda_kms_dev *kms,
+				 struct komeda_compiz *compiz)
+{
+	struct komeda_compiz_state *st;
+
+	st =3D kzalloc(sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	st->base.component =3D &compiz->base;
+	drm_atomic_private_obj_init(&kms->base, &compiz->base.obj, &st->base.obj,
+				    &komeda_compiz_obj_funcs);
+
+	return 0;
+}
+
+static struct drm_private_state *
+komeda_improc_atomic_duplicate_state(struct drm_private_obj *obj)
+{
+	struct komeda_improc_state *st;
+
+	st =3D kmemdup(obj->state, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return NULL;
+
+	komeda_component_state_reset(&st->base);
+	__drm_atomic_helper_private_obj_duplicate_state(obj, &st->base.obj);
+
+	return &st->base.obj;
+}
+
+static void
+komeda_improc_atomic_destroy_state(struct drm_private_obj *obj,
+				   struct drm_private_state *state)
+{
+	kfree(to_improc_st(priv_to_comp_st(state)));
+}
+
+static const struct drm_private_state_funcs komeda_improc_obj_funcs =3D {
+	.atomic_duplicate_state	=3D komeda_improc_atomic_duplicate_state,
+	.atomic_destroy_state	=3D komeda_improc_atomic_destroy_state,
+};
+
+static int komeda_improc_obj_add(struct komeda_kms_dev *kms,
+				 struct komeda_improc *improc)
+{
+	struct komeda_improc_state *st;
+
+	st =3D kzalloc(sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	st->base.component =3D &improc->base;
+	drm_atomic_private_obj_init(&kms->base, &improc->base.obj, &st->base.obj,
+				    &komeda_improc_obj_funcs);
+
+	return 0;
+}
+
+static struct drm_private_state *
+komeda_timing_ctrlr_atomic_duplicate_state(struct drm_private_obj *obj)
+{
+	struct komeda_timing_ctrlr_state *st;
+
+	st =3D kmemdup(obj->state, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return NULL;
+
+	komeda_component_state_reset(&st->base);
+	__drm_atomic_helper_private_obj_duplicate_state(obj, &st->base.obj);
+
+	return &st->base.obj;
+}
+
+static void
+komeda_timing_ctrlr_atomic_destroy_state(struct drm_private_obj *obj,
+					 struct drm_private_state *state)
+{
+	kfree(to_ctrlr_st(priv_to_comp_st(state)));
+}
+
+static const struct drm_private_state_funcs komeda_timing_ctrlr_obj_funcs =
=3D {
+	.atomic_duplicate_state	=3D komeda_timing_ctrlr_atomic_duplicate_state,
+	.atomic_destroy_state	=3D komeda_timing_ctrlr_atomic_destroy_state,
+};
+
+static int komeda_timing_ctrlr_obj_add(struct komeda_kms_dev *kms,
+				       struct komeda_timing_ctrlr *ctrlr)
+{
+	struct komeda_compiz_state *st;
+
+	st =3D kzalloc(sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	st->base.component =3D &ctrlr->base;
+	drm_atomic_private_obj_init(&kms->base, &ctrlr->base.obj, &st->base.obj,
+				    &komeda_timing_ctrlr_obj_funcs);
+
+	return 0;
+}
+
 static struct drm_private_state *
 komeda_pipeline_atomic_duplicate_state(struct drm_private_obj *obj)
 {
@@ -55,7 +237,7 @@ int komeda_kms_add_private_objs(struct komeda_kms_dev *k=
ms,
 				struct komeda_dev *mdev)
 {
 	struct komeda_pipeline *pipe;
-	int i, err;
+	int i, j, err;
=20
 	for (i =3D 0; i < mdev->n_pipelines; i++) {
 		pipe =3D mdev->pipelines[i];
@@ -64,25 +246,33 @@ int komeda_kms_add_private_objs(struct komeda_kms_dev =
*kms,
 		if (err)
 			return err;
=20
-		/* Add component */
+		for (j =3D 0; j < pipe->n_layers; j++) {
+			err =3D komeda_layer_obj_add(kms, pipe->layers[j]);
+			if (err)
+				return err;
+		}
+
+		err =3D komeda_compiz_obj_add(kms, pipe->compiz);
+		if (err)
+			return err;
+
+		err =3D komeda_improc_obj_add(kms, pipe->improc);
+		if (err)
+			return err;
+
+		err =3D komeda_timing_ctrlr_obj_add(kms, pipe->ctrlr);
+		if (err)
+			return err;
 	}
=20
 	return 0;
 }
=20
-void komeda_kms_cleanup_private_objs(struct komeda_dev *mdev)
+void komeda_kms_cleanup_private_objs(struct komeda_kms_dev *kms)
 {
-	struct komeda_pipeline *pipe;
-	struct komeda_component *c;
-	int i, id;
+	struct drm_mode_config *config =3D &kms->base.mode_config;
+	struct drm_private_obj *obj, *next;
=20
-	for (i =3D 0; i < mdev->n_pipelines; i++) {
-		pipe =3D mdev->pipelines[i];
-		dp_for_each_set_bit(id, pipe->avail_comps) {
-			c =3D komeda_pipeline_get_component(pipe, id);
-
-			drm_atomic_private_obj_fini(&c->obj);
-		}
-		drm_atomic_private_obj_fini(&pipe->obj);
-	}
+	list_for_each_entry_safe(obj, next, &config->privobj_list, head)
+		drm_atomic_private_obj_fini(obj);
 }
--=20
2.17.1

