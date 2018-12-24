Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C62C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1655B2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="lsCpGUuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbeLXJ0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:26:16 -0500
Received: from mail-eopbgr150077.outbound.protection.outlook.com ([40.107.15.77]:6260
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725294AbeLXJ0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5mhJF3JX59hdJDX0N0acDoMVlnlEZprswspmOQRT6E=;
 b=lsCpGUuLXeXgpumeGRW7qguZyRrc3+1n5qD1oEGj06ji9QFM/TMcwlaxSf/OO7ItI2ILtQyeWf5Y2Yfyu6sV9Ay4NsHKKBAY81Wsgq4JpULLNVkpB3odN0kwQO6swUd40YRsOCT9ihKwAc4r67GOSDq37q4XYBa1kCYIqHCxOno=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0262.eurprd08.prod.outlook.com (10.161.35.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Mon, 24 Dec 2018 09:26:09 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 09:26:09 +0000
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
Subject: [PATCH 05/11] drm/komeda: Add komeda_crtc_prepare/unprepare
Thread-Topic: [PATCH 05/11] drm/komeda: Add komeda_crtc_prepare/unprepare
Thread-Index: AQHUm2q067w9tQBgxkG49VShivGxWA==
Date:   Mon, 24 Dec 2018 09:26:09 +0000
Message-ID: <20181224092435.2792-6-james.qian.wang@arm.com>
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
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0262;6:xWbLd0vryvQ3XLeZ3bUSWxxRBZVO0LSGBqgEW+v73vKH74H4tWImmrGf06LXuIO4fv5TRzUTb9bzuKN9y0r1p9thQ1YDDnLjA3h9yd4/U9KpaWGvI20DaT7pZ/muhdt5Hp6qrCuSCvB5uKck5ioMsdQ8j6GRDmn5Afqc2R+P1ZN/B4UOHa/Lzn3fwlykQBOWyTuuG6kA5dlyTKveWIGkQbj24Kjbx2ScPiey91PJMH0PNWTLyeD35UNLnF8oUOyuOmRZmw9KiCsjFW5lU6CQiEM6EuzW844tGStzv4BS9bMp1Xt/p+cyt2LepXFT0CmaTTXp6JAFPfzSgv0rnx2N8iTDGF/sTK7MO/3zZne72+FazhMRaam5YSK7IezeRZS1I0ZovWFhxzQf4gli3FFTDnhzuaqV0e+wGVEJBveml7Hv3RP0OESGkmHbi/Gz5EZM57ImWDGhbeIVdpVr9vFpEQ==;5:FQNCvRltlFLy1woNtHpbMc37L9TBX4i8ArYfaOi6rFGiqWi9HnKiQ+0K12pL2/ZSStVhZG8bvksIoTaioH3JcqlgT/Vsocx5G3yubOgXssQ1aRQDWZrm2qjn4Wm8LTMtRWzBfy4bcPB7CO1Ao1XU+dJovXfxqb9rwo47Hiychbk=;7:IbWNDSkpfb/LYderOGzMWfchh+qLRuC/CUlt+vg9mHhFqGhbNk2kMInnfyOdGqKpnr4TftAp3Wv/98IjoHEIEE+8VRJRE4YOq4bA6znxacG08uaoNaV9M/y8pn8ML5TjDbJ8ptsGoPrhdQxRlWxBRA==
x-ms-office365-filtering-correlation-id: b53ef5d6-af61-4955-2d5b-08d66981d672
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0262;
x-ms-traffictypediagnostic: AM3PR08MB0262:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB02627C601210332E84011798B3BB0@AM3PR08MB0262.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0262;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0262;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(39850400004)(346002)(199004)(189003)(4326008)(256004)(305945005)(53936002)(6862004)(71190400001)(71200400001)(486006)(7736002)(97736004)(446003)(2906002)(52116002)(6116002)(76176011)(1076003)(6436002)(86362001)(6512007)(5660300001)(11346002)(186003)(26005)(68736007)(3846002)(2616005)(476003)(55236004)(386003)(102836004)(14444005)(6506007)(25786009)(103116003)(14454004)(105586002)(99286004)(54906003)(37006003)(6486002)(106356001)(316002)(8676002)(81166006)(81156014)(8936002)(6636002)(36756003)(478600001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0262;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yreR2hCBHkDp2Xpre+dooURGyem2uRcoJWeYcQmoF3iT4ZpHHyGeQQzHVNpC/D9nTDpbvuaHuTy3pjEjsfqJyCMCvcxu+pdfnB+5fXeZaUxPVI0cAExpoXdkd9VW2QueEfRmvyQBTmDTwfe0mh4cyOgVyxKELpioaDOX0O86l1NOLTKzlF+I8NqtV77iqrs5kaW9/M9Vh/NVRqZeUzn4R7nPdsNtp5mmcVd3QPcALMEUVhPBJC+GNJyFf4X7umGJrfBt6EucmNrpwtx2sZYPXdRDgxKeomphfQfYPGMwwO3VKutimJwBwnWdx0sOks3J
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53ef5d6-af61-4955-2d5b-08d66981d672
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 09:26:09.2811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two function will be used by komeda_crtc_enable/disable to do some
prepartion works when enable/disable a crtc. like enable a crtc:
  1. Adjust display operation mode.
  2. Enable/prepare needed clk.

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  |  32 ++++++
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 104 ++++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_dev.c   |   2 +
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |  27 +++++
 4 files changed, 165 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.c
index ecbcf26e8ad6..39b3c84cf483 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
@@ -241,6 +241,37 @@ static int d71_disable_irq(struct komeda_dev *mdev)
 	return 0;
 }
=20
+static int to_d71_opmode(int core_mode)
+{
+	switch (core_mode) {
+	case KOMEDA_MODE_DISP0:
+		return DO0_ACTIVE_MODE;
+	case KOMEDA_MODE_DISP1:
+		return DO1_ACTIVE_MODE;
+	case KOMEDA_MODE_DUAL_DISP:
+		return DO01_ACTIVE_MODE;
+	case KOMEDA_MODE_INACTIVE:
+		return INACTIVE_MODE;
+	default:
+		WARN(1, "Unknown operation mode");
+		return INACTIVE_MODE;
+	}
+}
+
+static int d71_change_opmode(struct komeda_dev *mdev, int new_mode)
+{
+	struct d71_dev *d71 =3D mdev->chip_data;
+	u32 opmode =3D to_d71_opmode(new_mode);
+	int ret;
+
+	malidp_write32_mask(d71->gcu_addr, BLK_CONTROL, 0x7, opmode);
+
+	ret =3D dp_wait_cond(((malidp_read32(d71->gcu_addr, BLK_CONTROL) & 0x7) =
=3D=3D opmode),
+			   100, 1000, 10000);
+
+	return ret > 0 ? 0 : -ETIMEDOUT;
+}
+
 static void d71_flush(struct komeda_dev *mdev,
 		      int master_pipe, u32 active_pipes)
 {
@@ -461,6 +492,7 @@ static struct komeda_dev_funcs d71_chip_funcs =3D {
 	.irq_handler	=3D d71_irq_handler,
 	.enable_irq	=3D d71_enable_irq,
 	.disable_irq	=3D d71_disable_irq,
+	.change_opmode	=3D d71_change_opmode,
 	.flush		=3D d71_flush,
 };
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 05bdff137e50..9c176ea59303 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -40,6 +40,110 @@ komeda_crtc_atomic_check(struct drm_crtc *crtc,
 	return 0;
 }
=20
+u32 komeda_calc_mclk(struct komeda_crtc_state *kcrtc_st)
+{
+	unsigned long mclk =3D kcrtc_st->base.adjusted_mode.clock * 1000;
+
+	return mclk;
+}
+
+/* For active a crtc, mainly need two parts of preparation
+ * 1. adjust display operation mode.
+ * 2. enable needed clk
+ */
+static int
+komeda_crtc_prepare(struct komeda_crtc *kcrtc)
+{
+	struct komeda_dev *mdev =3D kcrtc->base.dev->dev_private;
+	struct komeda_pipeline *master =3D kcrtc->master;
+	struct komeda_crtc_state *kcrtc_st =3D to_kcrtc_st(kcrtc->base.state);
+	unsigned long pxlclk_rate =3D kcrtc_st->base.adjusted_mode.clock * 1000;
+	u32 new_mode;
+	int err;
+
+	mutex_lock(&mdev->lock);
+
+	new_mode =3D mdev->dpmode | BIT(master->id);
+	if (WARN_ON(new_mode =3D=3D mdev->dpmode)) {
+		err =3D 0;
+		goto unlock;
+	}
+
+	err =3D mdev->funcs->change_opmode(mdev, new_mode);
+	if (err) {
+		DRM_ERROR("failed to change opmode: 0x%x -> 0x%x.\n,",
+			  mdev->dpmode, new_mode);
+		goto unlock;
+	}
+
+	mdev->dpmode =3D new_mode;
+	/* Only need to enable mclk on single display mode, but no need to
+	 * enable mclk it on dual display mode, since the dual mode always
+	 * switch from single display mode, the mclk already enabled, no need
+	 * to enable it again.
+	 */
+	if (new_mode !=3D KOMEDA_MODE_DUAL_DISP) {
+		err =3D clk_set_rate(mdev->mclk, komeda_calc_mclk(kcrtc_st));
+		if (err)
+			DRM_ERROR("failed to set mclk.\n");
+		err =3D clk_prepare_enable(mdev->mclk);
+		if (err)
+			DRM_ERROR("failed to enable mclk.\n");
+	}
+
+	err =3D clk_prepare_enable(master->aclk);
+	if (err)
+		DRM_ERROR("failed to enable axi clk for pipe%d.\n", master->id);
+	err =3D clk_set_rate(master->pxlclk, pxlclk_rate);
+	if (err)
+		DRM_ERROR("failed to set pxlclk for pipe%d\n", master->id);
+	err =3D clk_prepare_enable(master->pxlclk);
+	if (err)
+		DRM_ERROR("failed to enable pxl clk for pipe%d.\n", master->id);
+
+unlock:
+	mutex_unlock(&mdev->lock);
+
+	return err;
+}
+
+static int
+komeda_crtc_unprepare(struct komeda_crtc *kcrtc)
+{
+	struct komeda_dev *mdev =3D kcrtc->base.dev->dev_private;
+	struct komeda_pipeline *master =3D kcrtc->master;
+	u32 new_mode;
+	int err;
+
+	mutex_lock(&mdev->lock);
+
+	new_mode =3D mdev->dpmode & (~BIT(master->id));
+
+	if (WARN_ON(new_mode =3D=3D mdev->dpmode)) {
+		err =3D 0;
+		goto unlock;
+	}
+
+	err =3D mdev->funcs->change_opmode(mdev, new_mode);
+	if (err) {
+		DRM_ERROR("failed to change opmode: 0x%x -> 0x%x.\n,",
+			  mdev->dpmode, new_mode);
+		goto unlock;
+	}
+
+	mdev->dpmode =3D new_mode;
+
+	clk_disable_unprepare(master->pxlclk);
+	clk_disable_unprepare(master->aclk);
+	if (new_mode =3D=3D KOMEDA_MODE_INACTIVE)
+		clk_disable_unprepare(mdev->mclk);
+
+unlock:
+	mutex_unlock(&mdev->lock);
+
+	return err;
+}
+
 void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
 			      struct komeda_events *evts)
 {
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index cf3c8d5f5d90..811f3617e893 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -148,6 +148,8 @@ struct komeda_dev *komeda_dev_create(struct device *dev=
)
 	if (!mdev)
 		return ERR_PTR(-ENOMEM);
=20
+	mutex_init(&mdev->lock);
+
 	mdev->dev =3D dev;
 	mdev->reg_base =3D devm_ioremap_resource(dev, io_res);
 	if (IS_ERR(mdev->reg_base)) {
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index 686ce97ce30f..18dd82b09340 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -106,11 +106,34 @@ struct komeda_dev_funcs {
=20
 	/** @dump_register: Optional, dump registers to seq_file */
 	void (*dump_register)(struct komeda_dev *mdev, struct seq_file *seq);
+	/**
+	 * @change_opmode:
+	 *
+	 * Notify HW to switch to a new display operation mode.
+	 */
+	int (*change_opmode)(struct komeda_dev *mdev, int new_mode);
 	/** @flush: Notify the HW to flush or kickoff the update */
 	void (*flush)(struct komeda_dev *mdev,
 		      int master_pipe, u32 active_pipes);
 };
=20
+/**
+ * DISPLAY_MODE describes how many display been enabled, and which will be
+ * passed to CHIP by &komeda_dev_funcs->change_opmode(), then CHIP can do =
the
+ * pipeline resources assignment according to this usage hint.
+ * -   KOMEDA_MODE_DISP0: Only one display enabled, pipeline-0 work as mas=
ter.
+ * -   KOMEDA_MODE_DISP1: Only one display enabled, pipeline-0 work as mas=
ter.
+ * -   KOMEDA_MODE_DUAL_DISP: Dual display mode, both display has been ena=
bled.
+ * And D71 supports assign two pipelines to one single display on mode
+ * KOMEDA_MODE_DISP0/DISP1
+ */
+enum {
+	KOMEDA_MODE_INACTIVE	=3D 0,
+	KOMEDA_MODE_DISP0	=3D BIT(0),
+	KOMEDA_MODE_DISP1	=3D BIT(1),
+	KOMEDA_MODE_DUAL_DISP	=3D KOMEDA_MODE_DISP0 | KOMEDA_MODE_DISP1,
+};
+
 /**
  * struct komeda_dev
  *
@@ -133,6 +156,10 @@ struct komeda_dev {
 	/** @irq: irq number */
 	u32 irq;
=20
+	/* TODO: manage the dpmode by a drm_private_obj */
+	struct mutex lock; /* use to protect dpmode */
+	u32 dpmode; /* current display mode */
+
 	int n_pipelines;
 	struct komeda_pipeline *pipelines[KOMEDA_MAX_PIPELINES];
=20
--=20
2.17.1

