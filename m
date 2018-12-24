Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F4DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5479B217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="YXq3vxJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbeLXJ01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:26:27 -0500
Received: from mail-eopbgr150043.outbound.protection.outlook.com ([40.107.15.43]:29931
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725294AbeLXJ00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7IejrG7mNxGAizgZygJS9AB0LVA5aU8CA/Uc48UK2o=;
 b=YXq3vxJBVKHOL729mifQQSR+wfQt3/yJ+ZjvMvxiUp2aNFBoNOZBwLkA7/qc/wAf70Y1IHuLnkuVK6AS/00JkWJI+FcRBVBTkEBxTQAGGu+NEvh4GJxmL/OZXzXcBR21m9Irw+pufwfZpoFrDGPCqC6uNrK1+o8s/S/9ygIIpYk=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0262.eurprd08.prod.outlook.com (10.161.35.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Mon, 24 Dec 2018 09:26:20 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 09:26:20 +0000
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
Subject: [PATCH 06/11] drm/komeda: Add komeda_crtc_atomic_enable/disable
Thread-Topic: [PATCH 06/11] drm/komeda: Add komeda_crtc_atomic_enable/disable
Thread-Index: AQHUm2q690swUo66dUG0QXMzStM9tQ==
Date:   Mon, 24 Dec 2018 09:26:20 +0000
Message-ID: <20181224092435.2792-7-james.qian.wang@arm.com>
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
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0262;6:hTI78dR59TWdRZcMmTxbKXXdZihZRKmss8aFs5D2/IiwDywHWL+L3cWmmbQXcVN2hO17Swuh5cJ3OIuxg5Y1oUfq9yQCxul7Ilm8LGSQbqFII0cj/Fm+V6BkBd87QMWzgbDLros7WY7pBPQ9qRJxMm++xbRs2UtYUUZgHl3hDYaPa03mAJhOVlqg92kKG198DlhVEuyhreYohQhPU+csDQxAbMMim0Y/AjtUuVlubVHSYUFb6tDwJRthdstSk/WeV9PKB4F7UBYMgcxuxAKo8tSUvnjT4NhQW37nYoWyLVS+KqAs+SUXMcWI1PhhGQN/Jb0xyCwABpT1htnQVyaPDRlhiHg5aDRTiphEyLJcfhJ3zgw91S262yrQesM6AkHw8Vsos+/+BEnPwNUMk1iu8x8rGHAkUCN2umsP+h3SzPl11DVpbpQREkGg3I9bPuMs3F5ioli0E3WFrFxCclM91Q==;5:mbAUSWuB8zXYiPQ9yP933jPlKBZ7ykhdgu08YBtyiUF4dESB3am2ru2/NwNkYX7a4bTkx7/wJWCnBTyFXxACpAYF7fT0xtq2cjmcMuacTRp3xAHI8z66V+aY7gtyKmRhe4iUMl5gzea3FllkJ6P+JKofDijDu+A/J6ZhbuczHkY=;7:oFN9f6BeUuMTFFq2PNUOMrmtq2HBvkJJBAkql0gseOC1yXbtmvRnZYkqECFpEue8l/+zFkOLkEGlzKBbO9ZOaHaRuwGxvAcnw5nOMelK0YOUeDQOg5u3jYs00EVbQESCoreTTLKwlLANqJsFLXbMEg==
x-ms-office365-filtering-correlation-id: 44032e80-75cb-45dc-aa70-08d66981dd26
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0262;
x-ms-traffictypediagnostic: AM3PR08MB0262:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB02623F915802AA6D5B184073B3BB0@AM3PR08MB0262.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0262;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0262;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(39850400004)(346002)(199004)(189003)(4326008)(256004)(305945005)(53936002)(6862004)(71190400001)(71200400001)(486006)(7736002)(97736004)(446003)(2906002)(52116002)(6116002)(76176011)(1076003)(575784001)(6436002)(86362001)(6512007)(5660300001)(11346002)(186003)(26005)(68736007)(3846002)(2616005)(476003)(55236004)(386003)(102836004)(14444005)(6506007)(25786009)(103116003)(14454004)(105586002)(99286004)(54906003)(37006003)(6486002)(106356001)(316002)(8676002)(81166006)(81156014)(8936002)(6636002)(36756003)(478600001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0262;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pKbZcRa4RN5Bt8l+PkymHiR79GY6wUjvGWtMWPdNyZeLF9YSEIXMKAOHSfsS4ImkKUq9VFB651Ub8UZaGSzkcnXedpb8ecfEnUrCgYz/rv5Vce2Ja9JGOZYRp/+2ovmkwjojBAPr3GPQcdpDmZ2WQh/ZmKsI/rG4+pNUP42zezhfdwezd1+VGjBCChdE74ZjF7GgvUO5acqGY/xsSnZGjWd0sAaF5GSrxhRLTmX8lNdUriWsfE/MUNGMsXzD9wAUmJoITNMWkHvSpiut7Ys9XNMXcAW3vs0SoLFKu7UKVMeoSHSnuGKJ+ev8spArFrMb
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44032e80-75cb-45dc-aa70-08d66981dd26
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 09:26:20.5023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass enable/disable command to komeda and adjust komeda hardware for
enable/disable a display instance.

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 102 +++++++++++++++++-
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |   3 +
 .../drm/arm/display/komeda/komeda_pipeline.h  |   4 +
 .../display/komeda/komeda_pipeline_state.c    |  32 ++++++
 4 files changed, 138 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 9c176ea59303..c76cd75a0100 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -157,9 +157,28 @@ void komeda_crtc_handle_event(struct komeda_crtc   *kc=
rtc,
 	if (events & KOMEDA_EVENT_EOW)
 		DRM_INFO("EOW.\n");
=20
-	/* will handle it with crtc->flush */
-	if (events & KOMEDA_EVENT_FLIP)
-		DRM_INFO("FLIP Done.\n");
+	if (events & KOMEDA_EVENT_FLIP) {
+		unsigned long flags;
+		struct drm_pending_vblank_event *event;
+
+		spin_lock_irqsave(&crtc->dev->event_lock, flags);
+		if (kcrtc->disable_done) {
+			complete_all(kcrtc->disable_done);
+			kcrtc->disable_done =3D NULL;
+		} else if (crtc->state->event) {
+			event =3D crtc->state->event;
+			/*
+			 * Consume event before notifying drm core that flip
+			 * happened.
+			 */
+			crtc->state->event =3D NULL;
+			drm_crtc_send_vblank_event(crtc, event);
+		} else {
+			DRM_WARN("CRTC[%d]: FLIP happen but no pending commit.\n",
+				 drm_crtc_index(&kcrtc->base));
+		}
+		spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
+	}
 }
=20
 static void
@@ -183,6 +202,81 @@ komeda_crtc_do_flush(struct drm_crtc *crtc,
 	mdev->funcs->flush(mdev, master->id, kcrtc_st->active_pipes);
 }
=20
+static void
+komeda_crtc_atomic_enable(struct drm_crtc *crtc,
+			  struct drm_crtc_state *old)
+{
+	komeda_crtc_prepare(to_kcrtc(crtc));
+	drm_crtc_vblank_on(crtc);
+	komeda_crtc_do_flush(crtc, old);
+}
+
+static void
+komeda_crtc_atomic_disable(struct drm_crtc *crtc,
+			   struct drm_crtc_state *old)
+{
+	struct komeda_crtc *kcrtc =3D to_kcrtc(crtc);
+	struct komeda_crtc_state *old_st =3D to_kcrtc_st(old);
+	struct komeda_dev *mdev =3D crtc->dev->dev_private;
+	struct komeda_pipeline *master =3D kcrtc->master;
+	struct completion *disable_done =3D &crtc->state->commit->flip_done;
+	struct completion temp;
+	int timeout;
+
+	DRM_DEBUG_ATOMIC("CRTC%d_DISABLE: active_pipes: 0x%x, affected: 0x%x.\n",
+			 drm_crtc_index(crtc),
+			 old_st->active_pipes, old_st->affected_pipes);
+
+	if (has_bit(master->id, old_st->active_pipes))
+		komeda_pipeline_disable(master, old->state);
+
+	/* crtc_disable has two scenarios according to the state->active switch.
+	 * 1. active -> inactive
+	 *    this commit is a disable commit. and the commit will be finished
+	 *    or done after the disable operation. on this case we can directly
+	 *    use the crtc->state->event to tracking the HW disable operation.
+	 * 2. active -> active
+	 *    the crtc->commit is not for disable, but a modeset operation when
+	 *    crtc is active, such commit actually has been completed by 3
+	 *    DRM operations:
+	 *    crtc_disable, update_planes(crtc_flush), crtc_enable
+	 *    so on this case the crtc->commit is for the whole process.
+	 *    we can not use it for tracing the disable, we need a temporary
+	 *    flip_done for tracing the disable. and crtc->state->event for
+	 *    the crtc_enable operation.
+	 *    That's also the reason why skip modeset commit in
+	 *    komeda_crtc_atomic_flush()
+	 */
+	if (crtc->state->active) {
+		struct komeda_pipeline_state *pipe_st;
+		/* clear the old active_comps to zero */
+		pipe_st =3D komeda_pipeline_get_old_state(master, old->state);
+		pipe_st->active_comps =3D 0;
+
+		init_completion(&temp);
+		kcrtc->disable_done =3D &temp;
+		disable_done =3D &temp;
+	}
+
+	mdev->funcs->flush(mdev, master->id, 0);
+
+	/* wait the disable take affect.*/
+	timeout =3D wait_for_completion_timeout(disable_done, HZ);
+	if (timeout =3D=3D 0) {
+		DRM_ERROR("disable pipeline%d timeout.\n", kcrtc->master->id);
+		if (crtc->state->active) {
+			unsigned long flags;
+
+			spin_lock_irqsave(&crtc->dev->event_lock, flags);
+			kcrtc->disable_done =3D NULL;
+			spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
+		}
+	}
+
+	drm_crtc_vblank_off(crtc);
+	komeda_crtc_unprepare(kcrtc);
+}
+
 static void
 komeda_crtc_atomic_flush(struct drm_crtc *crtc,
 			 struct drm_crtc_state *old)
@@ -247,6 +341,8 @@ static bool komeda_crtc_mode_fixup(struct drm_crtc *crt=
c,
 struct drm_crtc_helper_funcs komeda_crtc_helper_funcs =3D {
 	.atomic_check	=3D komeda_crtc_atomic_check,
 	.atomic_flush	=3D komeda_crtc_atomic_flush,
+	.atomic_enable	=3D komeda_crtc_atomic_enable,
+	.atomic_disable	=3D komeda_crtc_atomic_disable,
 	.mode_valid	=3D komeda_crtc_mode_valid,
 	.mode_fixup	=3D komeda_crtc_mode_fixup,
 };
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.h
index 0faeeac2765a..d5607897bb52 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -69,6 +69,9 @@ struct komeda_crtc {
 	 * merge into the master.
 	 */
 	struct komeda_pipeline *slave;
+
+	/* this flip_done is for tracing the disable */
+	struct completion *disable_done;
 };
=20
 /** struct komeda_crtc_state */
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index 9a96ee906a36..f1715b4b0cbd 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -409,6 +409,7 @@ void komeda_component_destroy(struct komeda_dev *mdev,
 struct komeda_plane_state;
 struct komeda_crtc_state;
 struct komeda_crtc;
+struct drm_atomic_state;
=20
 int komeda_build_layer_data_flow(struct komeda_layer *layer,
 				 struct komeda_component_output *dflow,
@@ -421,6 +422,9 @@ int komeda_build_display_data_flow(struct komeda_crtc *=
kcrtc,
 int komeda_release_unclaimed_resources(struct komeda_pipeline *pipe,
 				       struct komeda_crtc_state *kcrtc_st);
=20
+struct komeda_pipeline_state *
+komeda_pipeline_get_old_state(struct komeda_pipeline *pipe,
+			      struct drm_atomic_state *state);
 void komeda_pipeline_disable(struct komeda_pipeline *pipe,
 			     struct drm_atomic_state *old_state);
 void komeda_pipeline_update(struct komeda_pipeline *pipe,
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 19d8ed904bf7..b08edbb5db1f 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -549,6 +549,38 @@ int komeda_release_unclaimed_resources(struct komeda_p=
ipeline *pipe,
 	return 0;
 }
=20
+void komeda_pipeline_disable(struct komeda_pipeline *pipe,
+			     struct drm_atomic_state *old_state)
+{
+	struct komeda_pipeline_state *old;
+	struct komeda_component *c;
+	struct komeda_component_state *c_st;
+	u32 id, disabling_comps =3D 0;
+
+	old =3D komeda_pipeline_get_old_state(pipe, old_state);
+
+	disabling_comps =3D old->active_comps;
+	DRM_DEBUG_ATOMIC("PIPE%d: disabling_comps: 0x%x.\n",
+			 pipe->id, disabling_comps);
+
+	dp_for_each_set_bit(id, disabling_comps) {
+		c =3D komeda_pipeline_get_component(pipe, id);
+		c_st =3D priv_to_comp_st(c->obj.state);
+
+		/*
+		 * If we disabled a component then all active_inputs should be
+		 * put in the list of changed_active_inputs, so they get
+		 * re-enabled.
+		 * This usually happens during a modeset when the pipeline is
+		 * first disabled and then the actual state gets committed
+		 * again.
+		 */
+		c_st->changed_active_inputs |=3D c_st->active_inputs;
+
+		c->funcs->disable(c);
+	}
+}
+
 void komeda_pipeline_update(struct komeda_pipeline *pipe,
 			    struct drm_atomic_state *old_state)
 {
--=20
2.17.1

