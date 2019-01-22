Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67022C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6C120870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="BGu6+R4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfAVLLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:11:22 -0500
Received: from mail-eopbgr00076.outbound.protection.outlook.com ([40.107.0.76]:36352
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727777AbfAVLLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPdqsMPfjy9R7+XrHZN+SQxy7VWmMk6HKTMO9Qqkeow=;
 b=BGu6+R4PMeChkFDEKUJN+W1dbLz55IKUI1QtXpuAv6P6566SUi7yBHubbTky1MNw4D6MBtQCCpiU7ZJiBQgHmaYHbLwTdhOgiuw4+wqsMm5mXN22gM5GyepRul/RG9rOPDh6gcYO5pZyPSEIj5pykh2EJQRndjF4CDn3nb37D3g=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1784.eurprd08.prod.outlook.com (10.169.227.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 11:11:16 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 11:11:16 +0000
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
Subject: [PATCH v2 06/11] drm/komeda: Add komeda_crtc_atomic_enable/disable
Thread-Topic: [PATCH v2 06/11] drm/komeda: Add
 komeda_crtc_atomic_enable/disable
Thread-Index: AQHUskMxu0VEuSfWC0GgPiORgM25bA==
Date:   Tue, 22 Jan 2019 11:11:16 +0000
Message-ID: <20190122110932.5138-7-james.qian.wang@arm.com>
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
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB1784;6:QHo9BeYdchfzdkYbOkVuMUva0DRBn40fKrKe/09qrC2iQ6Jz5Uf41HuOmgXBtqQZ6GRBMuKHMHD+qIpGKbHqRYrV3euN5GcrbSDXkrpcPYNXxwvQz9ySXOrafJUQTxDg1tRH77SOXr64KdIs+sEoLOpNr6izhhNhbpaDoR75FcwAzpw9pTn0Fc84BcTWy5+1OW8eCZrEtWJ2A8Qqo2nwiRvhK/m2gFanNG6PWiv1zOVppQC0I/TYl/1vgoOfpJSTM5VnTQEa+Wz+ITaukJtsv6FPjCGOr0j748KGyrV7y77xvuBmhZ8c+j0noY4qWD6YpzvJ3kIsK13awnorh451zFXDwDbqDJZOabO21QqiykeXIig5gLYaKt8kZQBXSRu7F/jtJWKdifSW/pA3UVU3TqAfCIqfrjRP+DYImwVrdUoLbFYF0pAXv9e0FsiX8cEUaS5E7r4tCuCG0qHaUF+XCg==;5:biIedyQKLvyTmdR/V4HYuBg5+v5375KpesA1lH8RH3AhmLYOQ+JNc/tYOVDrtSJIlY8bweeaa8SnepbToVtGVfyWJvYEPxvRetqJZiPTidUNcucyEI4hsFMnDXyRS1eRw5Aoy5g5aIQwLy7xHwZXVPK7hXUo61KRiadlDgKgBOMB7Kt9rh6lzpt6C2M8Cy4ipvwhJvGl0BIgaBBntiRKig==;7:/1r+58eLXY6lS+hd89NDywF/IWKn6DEcY5GHSXwh3Od3fG/dnQJnLzMjidbCzNQFEFsKWm/1T7yjZP/5+oNsNu/jXTp8cuKr+ljt/zV5sN6w76ChfCvYG1QdUjrFwGgv8JRCuwtktOsnpgq6XVAwAw==
x-ms-office365-filtering-correlation-id: d1e9e9b0-f3ab-4db7-16e6-08d6805a5394
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1784;
x-ms-traffictypediagnostic: DB6PR0801MB1784:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB17844FE5E1A1F901619D1203B3980@DB6PR0801MB1784.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(39860400002)(346002)(189003)(199004)(446003)(2616005)(76176011)(11346002)(105586002)(14454004)(476003)(2501003)(14444005)(66066001)(6506007)(386003)(186003)(97736004)(26005)(68736007)(55236004)(102836004)(106356001)(478600001)(36756003)(52116002)(103116003)(6436002)(7736002)(6486002)(99286004)(81166006)(81156014)(8936002)(6116002)(3846002)(305945005)(50226002)(8676002)(71200400001)(71190400001)(25786009)(54906003)(6512007)(256004)(2906002)(486006)(110136005)(4326008)(6636002)(1076003)(53936002)(86362001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1784;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ulBZTLKXWBpV2nDGbM3otuvYtPmQnt1zV8PAP9dJlZtRU8x+53Ha7oKvgA3ccZKJHexyOaLwNvvPjGvUFKAZDYXNvhbD3lhhq8PJyT6hda2otNFv/dgODy7LhURmkq02lJmMebUDAEehIbhNRflgLCi499x7O0yRnYhEngt8vKjECDXNbHm63RutgD5x5gb+PD3K//goPaRFqUijmjy9tO3TM9KZQoQxlCh86cSMe/VtXTU/CYbr4JIXXifXogI7nmCtFLOgwOIIC1jOoI6bPHkkzmb9cTL/7eXJdZygp6jXn/m4Fg8JBJvzoGa+Q7qL2JG5A+jxLcoIpSEs5K4Y3ZBBodXKtoK5bP4Z5hkB+mmNbyENjOvrnY28g2VlQlEVTsTJ9TsymJkxsnv2CLTnq3KF22FOzXENOvjeUU5kVYs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e9e9b0-f3ab-4db7-16e6-08d6805a5394
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 11:11:07.6191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1784
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

Pass enable/disable command to komeda and adjust komeda hardware for
enable/disable a display instance.

v2: Rebase

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 106 +++++++++++++++++-
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |   3 +
 .../drm/arm/display/komeda/komeda_pipeline.h  |   3 +
 .../display/komeda/komeda_pipeline_state.c    |  32 ++++++
 4 files changed, 139 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index ef4c3ee2a688..9b370e1232e2 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -51,7 +51,7 @@ u32 komeda_calc_mclk(struct komeda_crtc_state *kcrtc_st)
  * 1. adjust display operation mode.
  * 2. enable needed clk
  */
-int
+static int
 komeda_crtc_prepare(struct komeda_crtc *kcrtc)
 {
 	struct komeda_dev *mdev =3D kcrtc->base.dev->dev_private;
@@ -107,7 +107,7 @@ komeda_crtc_prepare(struct komeda_crtc *kcrtc)
 	return err;
 }
=20
-int
+static int
 komeda_crtc_unprepare(struct komeda_crtc *kcrtc)
 {
 	struct komeda_dev *mdev =3D kcrtc->base.dev->dev_private;
@@ -157,9 +157,28 @@ void komeda_crtc_handle_event(struct komeda_crtc   *kc=
rtc,
 	if (events & KOMEDA_EVENT_EOW)
 		DRM_DEBUG("EOW.\n");
=20
-	/* will handle it with crtc->flush */
-	if (events & KOMEDA_EVENT_FLIP)
-		DRM_DEBUG("FLIP Done.\n");
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
index 06394716367b..990071352040 100644
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
index 3d7a9ee550b2..233e512319e8 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -412,6 +412,9 @@ int komeda_build_display_data_flow(struct komeda_crtc *=
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
index 87fd6493d202..69a622f06453 100644
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

