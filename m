Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39971C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D2B217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Lx4MnLeI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbeLXI7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 03:59:42 -0500
Received: from mail-eopbgr00068.outbound.protection.outlook.com ([40.107.0.68]:51376
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726849AbeLXI7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 03:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ptE2cZhZwNXxJO/mLIepAejbIvvV7pZj42KLh0qFh4=;
 b=Lx4MnLeIXtp9/nyGaNzQ8LruLWOjcMqh1IRs4OAj1PSSFSeETPP2tZSFcFW5XQIAjsG2+SU8X3GWnoYgowItw11Gbr/Csvh3PGj8Jdvta0QzGNRfXfQFrfNA4YvYe+nMvzBHwv6DQ8O160/7QvfMZKYsDt6HhDDCNwLp8PCwBdY=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0184.eurprd08.prod.outlook.com (10.161.35.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Mon, 24 Dec 2018 08:59:35 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 08:59:35 +0000
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
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH 6/7] drm/komeda: Add irq handling
Thread-Topic: [PATCH 6/7] drm/komeda: Add irq handling
Thread-Index: AQHUm2b+xrUoakgtc0mybAR83z5p2w==
Date:   Mon, 24 Dec 2018 08:59:35 +0000
Message-ID: <20181224085716.2325-7-james.qian.wang@arm.com>
References: <20181224085716.2325-1-james.qian.wang@arm.com>
In-Reply-To: <20181224085716.2325-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYBPR01CA0036.ausprd01.prod.outlook.com
 (2603:10c6:10:4::24) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0184;6:Ih3AjpWTdLzAaVFT20ZBHQcZc07bdz6bsct8r8Bi8NybrdQGiqSyNac3CK/dWC/HDadYfqoTKiJoTcg+gNfdOQc2bUpc3jVzNxkr4/6Y7D9FMfxM8S97WVTO/rSvGQxhyaYTj5NFJ9d999fi3muJJWa0YrHHj0RVOyRm3n+fjbb8jRfULtSeEu+V3GL/mm5voiEFqsTx32IF6gZ24XI1rRnnBdigjfgHl1lrTjJuAX7ikLdBe46N58+chNvlzpKmjaFto1wbxpTRvohwc5X7ymlBEq4s1EKhXcv7Rw9+tkRUnXram6pJ0L1aTnRUuGAj1S3tJEw6aKJmbOdLU2pWkBVd84nUh6/TnCc1gx8VfmHr7faNsHHrPvrZZ/HeWlXngmPa7k4MxHUZ0P12fLKqmRlJbGlXwJKZArt+QGRfZOlT0SyjocaxkjHun94XxHBj4kA+xJQA0FS4m1xbGuNUHg==;5:ffBGhu02qf33/bfQE3AYEV8XtLzu6JEbeHchBnGHW2WtGkGS8VOVYULKofTwi6S/YsoT+B+EedbYNoCwtkDnYZd886oUSOgKQ88cmy3xPchjskP1VZWAeUjE3u0ssY/9kA15l8eSt+CtgwwPmuN+zeHWHPlJb8x+/npH4HL0YtA=;7:VLkrJhZThh8EHYE4KC4Bne2wo6dmJaJWIih2Hzd8s3KsV1CWwuVrpcuwIimbLNVsZ15yTeas9e58UDfyTwVU2Q1PLWfAYc/9s2sgOcz206764ZWhUza1Cz8OBExep9vxDxaee0Mu58Hg6v1fTK+eBg==
x-ms-office365-filtering-correlation-id: 123b296d-a7b7-46eb-e2cc-08d6697e208c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0184;
x-ms-traffictypediagnostic: AM3PR08MB0184:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB01846ACF895FF19F72521974B3BB0@AM3PR08MB0184.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0184;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0184;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(346002)(39850400004)(376002)(199004)(189003)(6862004)(11346002)(446003)(36756003)(4326008)(2616005)(99286004)(14454004)(478600001)(476003)(386003)(102836004)(76176011)(52116002)(26005)(66066001)(53936002)(6506007)(3846002)(6116002)(55236004)(186003)(106356001)(97736004)(103116003)(5660300001)(105586002)(2906002)(486006)(6636002)(256004)(305945005)(8936002)(86362001)(6436002)(575784001)(6512007)(4744004)(68736007)(6486002)(81166006)(25786009)(7736002)(8676002)(71190400001)(1076003)(54906003)(81156014)(37006003)(71200400001)(316002)(5024004)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0184;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q1r4eUSQPw2Ph8oWV2EaJd3s5NEJuoG4SiX0HXEWhSroj0u7VErGg0EKPw/pnZl6DHU2ZhifvhF0paGPQppeOgs2ZGx6yL82efQLIeWAMAedxEuoebbHESzVDH+LEnGyN0H4HfAELK25uCSHb97li3LNMZOoKNLpD8eA7Ze//lqD67/2ki3JV9ArYyE8wGxiKYHydoVP0C8S7oQcFx+ofF6Yv/Jr2vfWFaIGCRydrkKAXRLXuKTrHIJs4WvOtyQ8YxYJ2DswdkiCwgmBdyBQCgHCe2kSCKKeZYZX6diK+hbjbk1WoBLyqCnRUaF7yQQr
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123b296d-a7b7-46eb-e2cc-08d6697e208c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 08:59:35.6116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Added irq_handler/irq_enable/irq_disable to komeda_dev_func, then the
   Komeda-CORE can control the HW irq via these chip function.
2. Install irq and register irq_handler to system by DRM, so once the IRQ
   coming, the handling sequence is:

   komeda_kms_irq_handler(int irq, void *data)
        /* step 1. call into the CHIP to recognize event */
	mdev->funcs->irq_handler(mdev, &evts);

	/* step 2. notify the crtc to handle the events */
	for (i =3D 0; i < kms->n_crtcs; i++)
		komeda_crtc_handle_event(&kms->crtcs[i], &evts);

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 237 ++++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  18 ++
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |  43 ++++
 .../gpu/drm/arm/display/komeda/komeda_kms.c   |  35 ++-
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |   3 +
 5 files changed, 335 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.c
index 3c10e1fe5bd0..895603695d79 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
@@ -7,6 +7,240 @@
 #include "d71_dev.h"
 #include "malidp_io.h"
=20
+static u64 get_lpu_event(struct d71_pipeline *d71_pipeline)
+{
+	u32 __iomem *reg =3D d71_pipeline->lpu_addr;
+	u32 status, raw_status;
+	u64 evts =3D 0ULL;
+
+	raw_status =3D malidp_read32(reg, BLK_IRQ_RAW_STATUS);
+	if (raw_status & LPU_IRQ_IBSY)
+		evts |=3D KOMEDA_EVENT_IBSY;
+	if (raw_status & LPU_IRQ_EOW)
+		evts |=3D KOMEDA_EVENT_EOW;
+
+	if (raw_status & (LPU_IRQ_ERR | LPU_IRQ_IBSY)) {
+		u32 restore =3D 0, tbu_status;
+		/* Check error of LPU status */
+		status =3D malidp_read32(reg, BLK_STATUS);
+		if (status & LPU_STATUS_AXIE) {
+			restore |=3D LPU_STATUS_AXIE;
+			evts |=3D KOMEDA_ERR_AXIE;
+		}
+		if (status & LPU_STATUS_ACE0) {
+			restore |=3D LPU_STATUS_ACE0;
+			evts |=3D KOMEDA_ERR_ACE0;
+		}
+		if (status & LPU_STATUS_ACE1) {
+			restore |=3D LPU_STATUS_ACE1;
+			evts |=3D KOMEDA_ERR_ACE1;
+		}
+		if (status & LPU_STATUS_ACE2) {
+			restore |=3D LPU_STATUS_ACE2;
+			evts |=3D KOMEDA_ERR_ACE2;
+		}
+		if (status & LPU_STATUS_ACE3) {
+			restore |=3D LPU_STATUS_ACE3;
+			evts |=3D KOMEDA_ERR_ACE3;
+		}
+		if (restore !=3D 0)
+			malidp_write32_mask(reg, BLK_STATUS, restore, 0);
+
+		restore =3D 0;
+		/* Check errors of TBU status */
+		tbu_status =3D malidp_read32(reg, LPU_TBU_STATUS);
+		if (tbu_status & LPU_TBU_STATUS_TCF) {
+			restore |=3D LPU_TBU_STATUS_TCF;
+			evts |=3D KOMEDA_ERR_TCF;
+		}
+		if (tbu_status & LPU_TBU_STATUS_TTNG) {
+			restore |=3D LPU_TBU_STATUS_TTNG;
+			evts |=3D KOMEDA_ERR_TTNG;
+		}
+		if (tbu_status & LPU_TBU_STATUS_TITR) {
+			restore |=3D LPU_TBU_STATUS_TITR;
+			evts |=3D KOMEDA_ERR_TITR;
+		}
+		if (tbu_status & LPU_TBU_STATUS_TEMR) {
+			restore |=3D LPU_TBU_STATUS_TEMR;
+			evts |=3D KOMEDA_ERR_TEMR;
+		}
+		if (tbu_status & LPU_TBU_STATUS_TTF) {
+			restore |=3D LPU_TBU_STATUS_TTF;
+			evts |=3D KOMEDA_ERR_TTF;
+		}
+		if (restore !=3D 0)
+			malidp_write32_mask(reg, LPU_TBU_STATUS, restore, 0);
+	}
+
+	malidp_write32(reg, BLK_IRQ_CLEAR, raw_status);
+	return evts;
+}
+
+static u64 get_cu_event(struct d71_pipeline *d71_pipeline)
+{
+	u32 __iomem *reg =3D d71_pipeline->cu_addr;
+	u32 status, raw_status;
+	u64 evts =3D 0ULL;
+
+	raw_status =3D malidp_read32(reg, BLK_IRQ_RAW_STATUS);
+	if (raw_status & CU_IRQ_OVR)
+		evts |=3D KOMEDA_EVENT_OVR;
+
+	if (raw_status & (CU_IRQ_ERR | CU_IRQ_OVR)) {
+		status =3D malidp_read32(reg, BLK_STATUS) & 0x7FFFFFFF;
+		if (status & CU_STATUS_CPE)
+			evts |=3D KOMEDA_ERR_CPE;
+		if (status & CU_STATUS_ZME)
+			evts |=3D KOMEDA_ERR_ZME;
+		if (status & CU_STATUS_CFGE)
+			evts |=3D KOMEDA_ERR_CFGE;
+		if (status)
+			malidp_write32_mask(reg, BLK_STATUS, status, 0);
+	}
+
+	malidp_write32(reg, BLK_IRQ_CLEAR, raw_status);
+
+	return evts;
+}
+
+static u64 get_dou_event(struct d71_pipeline *d71_pipeline)
+{
+	u32 __iomem *reg =3D d71_pipeline->dou_addr;
+	u32 status, raw_status;
+	u64 evts =3D 0ULL;
+
+	raw_status =3D malidp_read32(reg, BLK_IRQ_RAW_STATUS);
+	if (raw_status & DOU_IRQ_PL0)
+		evts |=3D KOMEDA_EVENT_VSYNC;
+	if (raw_status & DOU_IRQ_UND)
+		evts |=3D KOMEDA_EVENT_URUN;
+
+	if (raw_status & (DOU_IRQ_ERR | DOU_IRQ_UND)) {
+		u32 restore  =3D 0;
+
+		status =3D malidp_read32(reg, BLK_STATUS);
+		if (status & DOU_STATUS_DRIFTTO) {
+			restore |=3D DOU_STATUS_DRIFTTO;
+			evts |=3D KOMEDA_ERR_DRIFTTO;
+		}
+		if (status & DOU_STATUS_FRAMETO) {
+			restore |=3D DOU_STATUS_FRAMETO;
+			evts |=3D KOMEDA_ERR_FRAMETO;
+		}
+		if (status & DOU_STATUS_TETO) {
+			restore |=3D DOU_STATUS_TETO;
+			evts |=3D KOMEDA_ERR_TETO;
+		}
+		if (status & DOU_STATUS_CSCE) {
+			restore |=3D DOU_STATUS_CSCE;
+			evts |=3D KOMEDA_ERR_CSCE;
+		}
+
+		if (restore !=3D 0)
+			malidp_write32_mask(reg, BLK_STATUS, restore, 0);
+	}
+
+	malidp_write32(reg, BLK_IRQ_CLEAR, raw_status);
+	return evts;
+}
+
+static u64 get_pipeline_event(struct d71_pipeline *d71_pipeline, u32 gcu_s=
tatus)
+{
+	u32 evts =3D 0ULL;
+
+	if (gcu_status & (GLB_IRQ_STATUS_LPU0 | GLB_IRQ_STATUS_LPU1))
+		evts |=3D get_lpu_event(d71_pipeline);
+
+	if (gcu_status & (GLB_IRQ_STATUS_CU0 | GLB_IRQ_STATUS_CU1))
+		evts |=3D get_cu_event(d71_pipeline);
+
+	if (gcu_status & (GLB_IRQ_STATUS_DOU0 | GLB_IRQ_STATUS_DOU1))
+		evts |=3D get_dou_event(d71_pipeline);
+
+	return evts;
+}
+
+static irqreturn_t
+d71_irq_handler(struct komeda_dev *mdev, struct komeda_events *evts)
+{
+	struct d71_dev *d71 =3D mdev->chip_data;
+	u32 status, gcu_status, raw_status;
+
+	gcu_status =3D malidp_read32(d71->gcu_addr, GLB_IRQ_STATUS);
+
+	if (gcu_status & GLB_IRQ_STATUS_GCU) {
+		raw_status =3D malidp_read32(d71->gcu_addr, BLK_IRQ_RAW_STATUS);
+		if (raw_status & GCU_IRQ_CVAL0)
+			evts->pipes[0] |=3D KOMEDA_EVENT_FLIP;
+		if (raw_status & GCU_IRQ_CVAL1)
+			evts->pipes[1] |=3D KOMEDA_EVENT_FLIP;
+		if (raw_status & GCU_IRQ_ERR) {
+			status =3D malidp_read32(d71->gcu_addr, BLK_STATUS);
+			if (status & GCU_STATUS_MERR) {
+				evts->global |=3D KOMEDA_ERR_MERR;
+				malidp_write32_mask(d71->gcu_addr, BLK_STATUS,
+						    GCU_STATUS_MERR, 0);
+			}
+		}
+
+		malidp_write32(d71->gcu_addr, BLK_IRQ_CLEAR, raw_status);
+	}
+
+	if (gcu_status & GLB_IRQ_STATUS_PIPE0)
+		evts->pipes[0] |=3D get_pipeline_event(d71->pipes[0], gcu_status);
+
+	if (gcu_status & GLB_IRQ_STATUS_PIPE1)
+		evts->pipes[1] |=3D get_pipeline_event(d71->pipes[1], gcu_status);
+
+	return gcu_status ? IRQ_HANDLED : IRQ_NONE;
+}
+
+#define ENABLED_GCU_IRQS	(GCU_IRQ_CVAL0 | GCU_IRQ_CVAL1 | \
+				 GCU_IRQ_MODE | GCU_IRQ_ERR)
+#define ENABLED_LPU_IRQS	(LPU_IRQ_IBSY | LPU_IRQ_ERR | LPU_IRQ_EOW)
+#define ENABLED_CU_IRQS		(CU_IRQ_OVR | CU_IRQ_ERR)
+#define ENABLED_DOU_IRQS	(DOU_IRQ_UND | DOU_IRQ_ERR)
+
+static int d71_enable_irq(struct komeda_dev *mdev)
+{
+	struct d71_dev *d71 =3D mdev->chip_data;
+	struct d71_pipeline *pipe;
+	u32 i;
+
+	malidp_write32_mask(d71->gcu_addr, BLK_IRQ_MASK,
+			    ENABLED_GCU_IRQS, ENABLED_GCU_IRQS);
+	for (i =3D 0; i < d71->num_pipelines; i++) {
+		pipe =3D d71->pipes[i];
+		malidp_write32_mask(pipe->cu_addr,  BLK_IRQ_MASK,
+				    ENABLED_CU_IRQS, ENABLED_CU_IRQS);
+		malidp_write32_mask(pipe->lpu_addr, BLK_IRQ_MASK,
+				    ENABLED_LPU_IRQS, ENABLED_LPU_IRQS);
+		malidp_write32_mask(pipe->dou_addr, BLK_IRQ_MASK,
+				    ENABLED_DOU_IRQS, ENABLED_DOU_IRQS);
+	}
+	return 0;
+}
+
+static int d71_disable_irq(struct komeda_dev *mdev)
+{
+	struct d71_dev *d71 =3D mdev->chip_data;
+	struct d71_pipeline *pipe;
+	u32 i;
+
+	malidp_write32_mask(d71->gcu_addr, BLK_IRQ_MASK, ENABLED_GCU_IRQS, 0);
+	for (i =3D 0; i < d71->num_pipelines; i++) {
+		pipe =3D d71->pipes[i];
+		malidp_write32_mask(pipe->cu_addr,  BLK_IRQ_MASK,
+				    ENABLED_CU_IRQS, 0);
+		malidp_write32_mask(pipe->lpu_addr, BLK_IRQ_MASK,
+				    ENABLED_LPU_IRQS, 0);
+		malidp_write32_mask(pipe->dou_addr, BLK_IRQ_MASK,
+				    ENABLED_DOU_IRQS, 0);
+	}
+	return 0;
+}
+
 static int d71_reset(struct d71_dev *d71)
 {
 	u32 __iomem *gcu =3D d71->gcu_addr;
@@ -214,6 +448,9 @@ static struct komeda_dev_funcs d71_chip_funcs =3D {
 	.init_format_table =3D d71_init_fmt_tbl,
 	.enum_resources	=3D d71_enum_resources,
 	.cleanup	=3D d71_cleanup,
+	.irq_handler	=3D d71_irq_handler,
+	.enable_irq	=3D d71_enable_irq,
+	.disable_irq	=3D d71_disable_irq,
 };
=20
 struct komeda_dev_funcs *
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 5bb5a55f6b31..c896e46203ed 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -14,6 +14,24 @@
 #include "komeda_dev.h"
 #include "komeda_kms.h"
=20
+void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
+			      struct komeda_events *evts)
+{
+	struct drm_crtc *crtc =3D &kcrtc->base;
+	u32 events =3D evts->pipes[kcrtc->master->id];
+
+	if (events & KOMEDA_EVENT_VSYNC)
+		drm_crtc_handle_vblank(crtc);
+
+	/* will handle it together with the write back support */
+	if (events & KOMEDA_EVENT_EOW)
+		DRM_INFO("EOW.\n");
+
+	/* will handle it with crtc->flush */
+	if (events & KOMEDA_EVENT_FLIP)
+		DRM_INFO("FLIP Done.\n");
+}
+
 struct drm_crtc_helper_funcs komeda_crtc_helper_funcs =3D {
 };
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index 555510be66f1..a760bc465465 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -13,6 +13,33 @@
 #include "malidp_product.h"
 #include "komeda_format_caps.h"
=20
+#define KOMEDA_EVENT_VSYNC		BIT_ULL(0)
+#define KOMEDA_EVENT_FLIP		BIT_ULL(1)
+#define KOMEDA_EVENT_URUN		BIT_ULL(2)
+#define KOMEDA_EVENT_IBSY		BIT_ULL(3)
+#define KOMEDA_EVENT_OVR		BIT_ULL(4)
+#define KOMEDA_EVENT_EOW		BIT_ULL(5)
+#define KOMEDA_EVENT_MODE		BIT_ULL(6)
+
+#define KOMEDA_ERR_TETO			BIT_ULL(14)
+#define KOMEDA_ERR_TEMR			BIT_ULL(15)
+#define KOMEDA_ERR_TITR			BIT_ULL(16)
+#define KOMEDA_ERR_CPE			BIT_ULL(17)
+#define KOMEDA_ERR_CFGE			BIT_ULL(18)
+#define KOMEDA_ERR_AXIE			BIT_ULL(19)
+#define KOMEDA_ERR_ACE0			BIT_ULL(20)
+#define KOMEDA_ERR_ACE1			BIT_ULL(21)
+#define KOMEDA_ERR_ACE2			BIT_ULL(22)
+#define KOMEDA_ERR_ACE3			BIT_ULL(23)
+#define KOMEDA_ERR_DRIFTTO		BIT_ULL(24)
+#define KOMEDA_ERR_FRAMETO		BIT_ULL(25)
+#define KOMEDA_ERR_CSCE			BIT_ULL(26)
+#define KOMEDA_ERR_ZME			BIT_ULL(27)
+#define KOMEDA_ERR_MERR			BIT_ULL(28)
+#define KOMEDA_ERR_TCF			BIT_ULL(29)
+#define KOMEDA_ERR_TTNG			BIT_ULL(30)
+#define KOMEDA_ERR_TTF			BIT_ULL(31)
+
 /* malidp device id */
 enum {
 	MALI_D71 =3D 0,
@@ -39,6 +66,11 @@ struct komeda_product_data {
=20
 struct komeda_dev;
=20
+struct komeda_events {
+	u64 global;
+	u64 pipes[KOMEDA_MAX_PIPELINES];
+};
+
 /**
  * struct komeda_dev_funcs
  *
@@ -60,6 +92,17 @@ struct komeda_dev_funcs {
 	int (*enum_resources)(struct komeda_dev *mdev);
 	/** @cleanup: call to chip to cleanup komeda_dev->chip data */
 	void (*cleanup)(struct komeda_dev *mdev);
+	/**
+	 * @irq_handler:
+	 *
+	 * for CORE to get the HW event from the CHIP when interrupt happened.
+	 */
+	irqreturn_t (*irq_handler)(struct komeda_dev *mdev,
+				   struct komeda_events *events);
+	/** @enable_irq: enable irq */
+	int (*enable_irq)(struct komeda_dev *mdev);
+	/** @disable_irq: disable irq */
+	int (*disable_irq)(struct komeda_dev *mdev);
 };
=20
 /**
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.c
index fd48360ca524..210e5c05bf49 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -29,10 +29,31 @@ static int komeda_gem_cma_dumb_create(struct drm_file *=
file,
 	return drm_gem_cma_dumb_create_internal(file, dev, args);
 }
=20
+static irqreturn_t komeda_kms_irq_handler(int irq, void *data)
+{
+	struct drm_device *drm =3D data;
+	struct komeda_dev *mdev =3D drm->dev_private;
+	struct komeda_kms_dev *kms =3D to_kdev(drm);
+	struct komeda_events evts;
+	irqreturn_t status;
+	u32 i;
+
+	/* Call into the CHIP to recognize events */
+	memset(&evts, 0, sizeof(evts));
+	status =3D mdev->funcs->irq_handler(mdev, &evts);
+
+	/* Notify the crtc to handle the events */
+	for (i =3D 0; i < kms->n_crtcs; i++)
+		komeda_crtc_handle_event(&kms->crtcs[i], &evts);
+
+	return status;
+}
+
 static struct drm_driver komeda_kms_driver =3D {
 	.driver_features =3D DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC |
-			   DRIVER_PRIME,
+			   DRIVER_PRIME | DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED,
 	.lastclose			=3D drm_fb_helper_lastclose,
+	.irq_handler			=3D komeda_kms_irq_handler,
 	.gem_free_object_unlocked	=3D drm_gem_cma_free_object,
 	.gem_vm_ops			=3D &drm_gem_cma_vm_ops,
 	.dumb_create			=3D komeda_gem_cma_dumb_create,
@@ -140,12 +161,22 @@ struct komeda_kms_dev *komeda_kms_attach(struct komed=
a_dev *mdev)
=20
 	drm_mode_config_reset(drm);
=20
+	err =3D drm_irq_install(drm, mdev->irq);
+	if (err)
+		goto cleanup_mode_config;
+
 	err =3D drm_dev_register(drm, 0);
 	if (err)
 		goto uninstall_irq;
=20
+	err =3D mdev->funcs->enable_irq(mdev);
+	if (err)
+		goto unregister_dev;
+
 	return kms;
=20
+unregister_dev:
+	drm_dev_unregister(drm);
 uninstall_irq:
 	drm_irq_uninstall(drm);
 cleanup_mode_config:
@@ -160,7 +191,9 @@ void komeda_kms_detach(struct komeda_kms_dev *kms)
 	struct drm_device *drm =3D &kms->base;
 	struct komeda_dev *mdev =3D drm->dev_private;
=20
+	mdev->funcs->disable_irq(mdev);
 	drm_dev_unregister(drm);
+	drm_irq_uninstall(drm);
 	component_unbind_all(mdev->dev, drm);
 	komeda_kms_cleanup_private_objs(mdev);
 	drm_mode_config_cleanup(drm);
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.h
index f519a4c587e6..0faeeac2765a 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -109,6 +109,9 @@ int komeda_kms_add_private_objs(struct komeda_kms_dev *=
kms,
 				struct komeda_dev *mdev);
 void komeda_kms_cleanup_private_objs(struct komeda_dev *mdev);
=20
+void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
+			      struct komeda_events *evts);
+
 struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev);
 void komeda_kms_detach(struct komeda_kms_dev *kms);
=20
--=20
2.17.1

