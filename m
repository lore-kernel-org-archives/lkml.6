Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101D0C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E4120870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Yth2X/t7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfAVLLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:11:14 -0500
Received: from mail-eopbgr40053.outbound.protection.outlook.com ([40.107.4.53]:22688
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728022AbfAVLLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xnecnrQIt5wQGyQ6SOQ9PiMlWX/rkVkZlgg+rt2Hso=;
 b=Yth2X/t77qFOo2Gx42PWJqP+qxxJEwcbD1JSU3G2mzaII+j+W7LzwwaBRCZELcAt0g6GYad8tAC9YF0s/jGaFCDaciuoNq3bz2BJUiECpcbjuVgs8pyX95qENZ2C0Y6oj6h5ryC0N/pNKD1rMtzlRuzztg5TI8BH2eOLHbSnrCI=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1784.eurprd08.prod.outlook.com (10.169.227.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 11:11:07 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 11:11:07 +0000
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
Subject: [PATCH v2 05/11] drm/komeda: Add komeda_crtc_prepare/unprepare
Thread-Topic: [PATCH v2 05/11] drm/komeda: Add komeda_crtc_prepare/unprepare
Thread-Index: AQHUskMsibovwpzi6E6Ub38r7bWMsw==
Date:   Tue, 22 Jan 2019 11:11:07 +0000
Message-ID: <20190122110932.5138-6-james.qian.wang@arm.com>
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
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB1784;6:ooIapGyulhLaPagrEqbrccF63UlMgLzibQHaahwhHy1xSW/UCfSOzrhpr4QlaecfzTC8JgNtaRkaz4UrVJTixnJqRCL5v13zuMH5KICoWLMbxJwB+7vn5D8lrleSAGDvws2hFFNjRdLSfSbIgB6pB2ed4H/KkSJZh2d5FPLuSnfp2tVmhay2ZtWFp3yMven2N9Q7SMdXVlzH8LMWAL6Dnlbv2IE4bNUjnW7k8T7AYjb1UN8m695LJPm2BzOfhaB1ADDSCs/WXTHHQro6mNWzRPQ9u9o6iHF/ZZz9jctHtPF7E++hCgJi1ltsA8vQBfAEOpQd3OF5SGMImM/EGc3PV47YE6qETpazjPylET1BYPDND9IzQT9kXFE5ph3h6kj0fki/kXfUtGPfYndOIJBXkQQNgYzkBy0gOZ9VMpiNp1hpp4MIH2XfJcGVDnf0PEtQQgSuKiqCSsVPvDNp3MjIEA==;5:qF2TT0ekMkht96yCMr6ZUUewja5oPTgLsylWyBS+tNAcBX98YeefYMK/VrdsCWojLBtvljlVmBVIEEdNS5hjdiGR8icoXBC7efYmvowzk84YrVHRtWYpApSThi7w3ZuCAxW9nOKNRiwjOENtT/dTZKTQVyiG4BNWlavK7Fd5Gzuw8toLADXAJClRw+aMLW5tcGEDhLDGQVtEZMSdktYjPQ==;7:gpPOndxJKIbHOHKQae9JF1TC7twTzBZ/M/k44SISHu3RkkCxAxSaZIjlA83vA5Vq56DeKtElKK/y4XcdcTs0F1sMjB4I9URXQbJKSPI2mFUJDe6FDHdWaxiNlX6FGIZakUs02JRqBm8ojvQHBOeM/w==
x-ms-office365-filtering-correlation-id: 40e348af-74b7-478f-b995-08d6805a4de5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1784;
x-ms-traffictypediagnostic: DB6PR0801MB1784:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB1784CFA2B55D97AE2F97E5A9B3980@DB6PR0801MB1784.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(39860400002)(346002)(189003)(199004)(446003)(2616005)(76176011)(11346002)(105586002)(14454004)(476003)(2501003)(14444005)(66066001)(6506007)(386003)(186003)(97736004)(26005)(68736007)(55236004)(102836004)(106356001)(478600001)(36756003)(52116002)(103116003)(6436002)(7736002)(6486002)(99286004)(81166006)(81156014)(8936002)(6116002)(3846002)(305945005)(50226002)(8676002)(71200400001)(71190400001)(25786009)(54906003)(6512007)(256004)(2906002)(486006)(110136005)(4326008)(6636002)(1076003)(53936002)(86362001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1784;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7Q0VV0hv19ND75Zrk2GbqAX6um+m7vmx4ELG8bC50OUQBnFseCYhHSPK5EZUEl0WLY6pAI7O6gWbWDtZRnQYk6cbNsGkaMf3xGeDEVuzat7s7Fzu3fu9VfQ7AD64OZYwgrUccRdoxczZZVnW9ylM9+V+bFcYuPiRRas+06Bz3m+qd36GAmqKM769msT7mB67+TIm/73+qDBOKGn2qXQB0lNYga7vAJVb6UUIxOK69nrJI966L6LDAhL8d4aa2NGarGMPGr3SaKhmREz/68vg6nPe6a+Kvsa9p72VP7tbklJkTko8xjZxlTP414iMiSSdYLe+hl6hE9ipqhUj37mh4tIt6ips7kz8cgBSOxJ/Kp41tS4cOpveY5PE+oWX6sBhGkiH6L7Dzzrz2Qcm6HJCxlMyKfeY0EoWMoa/C8aB/tQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e348af-74b7-478f-b995-08d6805a4de5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 11:10:58.1034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1784
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

These two function will be used by komeda_crtc_enable/disable to do some
prepartion works when enable/disable a crtc. like enable a crtc:
  1. Adjust display operation mode.
  2. Enable/prepare needed clk.

v2: Rebase

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  |  32 ++++++
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 104 ++++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_dev.c   |   2 +
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |  26 +++++
 4 files changed, 164 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.c
index 74aab4f23ea0..2fb29aea9f69 100644
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
@@ -467,6 +498,7 @@ static struct komeda_dev_funcs d71_chip_funcs =3D {
 	.irq_handler	=3D d71_irq_handler,
 	.enable_irq	=3D d71_enable_irq,
 	.disable_irq	=3D d71_disable_irq,
+	.change_opmode	=3D d71_change_opmode,
 	.flush		=3D d71_flush,
 };
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 7e0bf78da733..ef4c3ee2a688 100644
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
+int
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
+int
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
index a012b3bbf53b..7152f2c08e01 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -145,6 +145,8 @@ struct komeda_dev *komeda_dev_create(struct device *dev=
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
index 0bd38bdf0518..1ad1f6e49854 100644
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
@@ -133,6 +156,9 @@ struct komeda_dev {
 	/** @irq: irq number */
 	int irq;
=20
+	struct mutex lock; /* used to protect dpmode */
+	u32 dpmode; /* current display mode */
+
 	int n_pipelines;
 	struct komeda_pipeline *pipelines[KOMEDA_MAX_PIPELINES];
=20
--=20
2.17.1

