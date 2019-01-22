Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191ECC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E5220870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="eZUOrB8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfAVLKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:10:53 -0500
Received: from mail-eopbgr40042.outbound.protection.outlook.com ([40.107.4.42]:13488
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727604AbfAVLKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:10:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3rVixnRTGlvpzGPPMiIFawU4uTo7yRfa3tCRsKpNOM=;
 b=eZUOrB8YnkKCtAGFphigIM0IDToleaVDs/qZ/s8ieTvQzM/iG8XlRpKCPuM6NdaHDHCWD9Sot4/BK3GNEDObO3cl+TCox0UPmny2d87LKvOWaz6mIECLKOOT9zf/kVspibEaPwI9sCcxOVR0ZJGW8qHznPLUGnkLgysRncxzlvE=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1286.eurprd08.prod.outlook.com (10.168.11.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 11:10:48 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 11:10:48 +0000
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
Subject: [PATCH v2 03/11] drm/komeda: Add komeda_crtc_atomic_flush
Thread-Topic: [PATCH v2 03/11] drm/komeda: Add komeda_crtc_atomic_flush
Thread-Index: AQHUskMgVWflZN1Mf0+iLzifEy0HzA==
Date:   Tue, 22 Jan 2019 11:10:48 +0000
Message-ID: <20190122110932.5138-4-james.qian.wang@arm.com>
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
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB1286;6:fQj+Qz7tjXCWepxoswmEGtTtgsJ1u4lfP/IzJIFKOBBWhCH37LAPsRFJEJl7W8m74QlNqU9zfFTc6u/QrHBW8BuTjBSiJV2azufPFQkdRkvRzwmIps1Ml3IlZNHR9k73hTHCgPYKA1al4rQEHEfYZTLQ/8wpMa2jCMr0wy4di2MnxOKl52CTPYOQzxsOik1HZedeCNVEYxbJkctxe9UgdW6+D+Rq7AeWgX35z3nBMVdkREBMEwsh4vPubnfbG0q2lfC+c5FM0m//s67upgXMjSHTh1EV7TcvPZzp2qcSETWIyLUgfKEJW5oyj76sPJg+JJypmPZUvXt30Cp4wNsPfL00vDTFbHX1CvQIGxEg1lIfF4QLigLNp2u3dJAjxy9UhTtRfZm0gyChGyrIgePwUjYFv7qpLlqrh8fpgwZ7+BimIeoVMBW+MqPe/z+LHRs0hTTZgt4q1ie2sbn6Lvsn1w==;5:0eT3RhizjCpsZrWEtttduOYmluxjaTxtftUIfg5Os/luGcRGFAeR8K/QE3FTuAPKsA82QahLB+nkQk+yIxoXaYkqdrtgAP/ESaocE6FETN5B3CuNfFboCodZVc3JFRdTQLf+uvu99Jb9so4m3/9bZDCBdHVWvP2yPF8dfPpXEozVcOBf/yiPXP3KnutVwvWdimBTFrsnPQorDLdBGexp1Q==;7:cu/QgxJ46XmAYpfUoQv9/12D2tnRJQlnTiJI2bm4Muwqgv27MVnsJ4m59xRMTy221gI0psPovGIaHiWhi7m3vwcLCMZF5AtGPMu94G3fOqmaizS/IFonqqR1aP2TNvSHZXdR9udIGqfl3dxKG0tPEw==
x-ms-office365-filtering-correlation-id: ab6c4ae3-5bea-4bfb-0af5-08d6805a4337
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1286;
x-ms-traffictypediagnostic: DB6PR0801MB1286:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB1286E586168912D2BC3CF346B3980@DB6PR0801MB1286.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(2906002)(25786009)(86362001)(36756003)(6116002)(3846002)(4326008)(6636002)(6486002)(103116003)(66066001)(105586002)(106356001)(6512007)(2501003)(53936002)(97736004)(6436002)(446003)(68736007)(81166006)(476003)(50226002)(8676002)(71200400001)(71190400001)(316002)(6506007)(52116002)(81156014)(486006)(11346002)(110136005)(54906003)(99286004)(305945005)(102836004)(14454004)(7736002)(26005)(76176011)(386003)(55236004)(1076003)(8936002)(478600001)(2616005)(186003)(14444005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1286;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vGAoBd/XYBAw3AnmcM5JpMclIZIshfJTJmCCrU1cJAW7A7+JBDh6RMogClq1a6R7GU607ltkVDrJInh/hy5A5Pk5cV8QsyNB/W5aCBmbxDrwGRerfdloxhL9j/M+lEcrHFS75JROLUaEXcmcLovSUaWRZts2/e1fHlDRW8MSWjr4neyas4e/sFJTdJuxc8vgipdqbZDb2B+IE1x2DUDAwYa4eC57bu6z2kJNAwm/cW3hkPLyefnzt/vo9TkgiXtVgHeS0V7jIzdXr6xLy0PJRwCm68+Wjk74EKEqlsyPq6rI4M1xT+wLOtTFUfO6peCBoitQXwgT1uBcDFx3XUDw+q33x1E9QjO4FT/wmnj9jQFn7PTCpC4cGMh+TmR/1ZhTnroR2pS0AD7RDDpZfcyNSghW1S159ayuFtQBJUesoc4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6c4ae3-5bea-4bfb-0af5-08d6805a4337
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 11:10:40.1814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1286
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

A komeda flush is comprised two steps:
1. update pipeline/component state to HW.
2. call dev_func->flush to notify HW to kickoff the update.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 11 ++++++
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 33 +++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |  3 ++
 .../drm/arm/display/komeda/komeda_pipeline.h  |  5 +++
 .../display/komeda/komeda_pipeline_state.c    | 37 +++++++++++++++++++
 5 files changed, 89 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.c
index afc13d3b3afc..74aab4f23ea0 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
@@ -241,6 +241,16 @@ static int d71_disable_irq(struct komeda_dev *mdev)
 	return 0;
 }
=20
+static void d71_flush(struct komeda_dev *mdev,
+		      int master_pipe, u32 active_pipes)
+{
+	struct d71_dev *d71 =3D mdev->chip_data;
+	u32 reg_offset =3D (master_pipe =3D=3D 0) ?
+			 GCU_CONFIG_VALID0 : GCU_CONFIG_VALID1;
+
+	malidp_write32(d71->gcu_addr, reg_offset, GCU_CONFIG_CVAL);
+}
+
 static int d71_reset(struct d71_dev *d71)
 {
 	u32 __iomem *gcu =3D d71->gcu_addr;
@@ -457,6 +467,7 @@ static struct komeda_dev_funcs d71_chip_funcs =3D {
 	.irq_handler	=3D d71_irq_handler,
 	.enable_irq	=3D d71_enable_irq,
 	.disable_irq	=3D d71_disable_irq,
+	.flush		=3D d71_flush,
 };
=20
 struct komeda_dev_funcs *
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index a250ab824155..95d8f2bcd523 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -58,8 +58,41 @@ void komeda_crtc_handle_event(struct komeda_crtc   *kcrt=
c,
 		DRM_DEBUG("FLIP Done.\n");
 }
=20
+static void
+komeda_crtc_do_flush(struct drm_crtc *crtc,
+		     struct drm_crtc_state *old)
+{
+	struct komeda_crtc *kcrtc =3D to_kcrtc(crtc);
+	struct komeda_crtc_state *kcrtc_st =3D to_kcrtc_st(crtc->state);
+	struct komeda_dev *mdev =3D kcrtc->base.dev->dev_private;
+	struct komeda_pipeline *master =3D kcrtc->master;
+
+	DRM_DEBUG_ATOMIC("CRTC%d_FLUSH: active_pipes: 0x%x, affected: 0x%x.\n",
+			 drm_crtc_index(crtc),
+			 kcrtc_st->active_pipes, kcrtc_st->affected_pipes);
+
+	/* step 1: update the pipeline/component state to HW */
+	if (has_bit(master->id, kcrtc_st->affected_pipes))
+		komeda_pipeline_update(master, old->state);
+
+	/* step 2: notify the HW to kickoff the update */
+	mdev->funcs->flush(mdev, master->id, kcrtc_st->active_pipes);
+}
+
+static void
+komeda_crtc_atomic_flush(struct drm_crtc *crtc,
+			 struct drm_crtc_state *old)
+{
+	/* commit with modeset will be handled in enable/disable */
+	if (drm_atomic_crtc_needs_modeset(crtc->state))
+		return;
+
+	komeda_crtc_do_flush(crtc, old);
+}
+
 struct drm_crtc_helper_funcs komeda_crtc_helper_funcs =3D {
 	.atomic_check	=3D komeda_crtc_atomic_check,
+	.atomic_flush	=3D komeda_crtc_atomic_flush,
 };
=20
 static const struct drm_crtc_funcs komeda_crtc_funcs =3D {
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index 8eae2620ce77..0bd38bdf0518 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -106,6 +106,9 @@ struct komeda_dev_funcs {
=20
 	/** @dump_register: Optional, dump registers to seq_file */
 	void (*dump_register)(struct komeda_dev *mdev, struct seq_file *seq);
+	/** @flush: Notify the HW to flush or kickoff the update */
+	void (*flush)(struct komeda_dev *mdev,
+		      int master_pipe, u32 active_pipes);
 };
=20
 /**
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index 54b646128760..3d7a9ee550b2 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -412,4 +412,9 @@ int komeda_build_display_data_flow(struct komeda_crtc *=
kcrtc,
 int komeda_release_unclaimed_resources(struct komeda_pipeline *pipe,
 				       struct komeda_crtc_state *kcrtc_st);
=20
+void komeda_pipeline_disable(struct komeda_pipeline *pipe,
+			     struct drm_atomic_state *old_state);
+void komeda_pipeline_update(struct komeda_pipeline *pipe,
+			    struct drm_atomic_state *old_state);
+
 #endif /* _KOMEDA_PIPELINE_H_*/
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 6797be630529..87fd6493d202 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -31,6 +31,18 @@ komeda_pipeline_get_state(struct komeda_pipeline *pipe,
 	return priv_to_pipe_st(priv_st);
 }
=20
+struct komeda_pipeline_state *
+komeda_pipeline_get_old_state(struct komeda_pipeline *pipe,
+			      struct drm_atomic_state *state)
+{
+	struct drm_private_state *priv_st;
+
+	priv_st =3D drm_atomic_get_old_private_obj_state(state, &pipe->obj);
+	if (priv_st)
+		return priv_to_pipe_st(priv_st);
+	return NULL;
+}
+
 struct komeda_pipeline_state *
 komeda_pipeline_get_new_state(struct komeda_pipeline *pipe,
 			      struct drm_atomic_state *state)
@@ -536,3 +548,28 @@ int komeda_release_unclaimed_resources(struct komeda_p=
ipeline *pipe,
=20
 	return 0;
 }
+
+void komeda_pipeline_update(struct komeda_pipeline *pipe,
+			    struct drm_atomic_state *old_state)
+{
+	struct komeda_pipeline_state *new =3D priv_to_pipe_st(pipe->obj.state);
+	struct komeda_pipeline_state *old;
+	struct komeda_component *c;
+	u32 id, changed_comps =3D 0;
+
+	old =3D komeda_pipeline_get_old_state(pipe, old_state);
+
+	changed_comps =3D new->active_comps | old->active_comps;
+
+	DRM_DEBUG_ATOMIC("PIPE%d: active_comps: 0x%x, changed: 0x%x.\n",
+			 pipe->id, new->active_comps, changed_comps);
+
+	dp_for_each_set_bit(id, changed_comps) {
+		c =3D komeda_pipeline_get_component(pipe, id);
+
+		if (new->active_comps & BIT(c->id))
+			c->funcs->update(c, priv_to_comp_st(c->obj.state));
+		else
+			c->funcs->disable(c);
+	}
+}
--=20
2.17.1

