Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A13C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA5A218D9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="NWFHfD/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfAVJYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:24:35 -0500
Received: from mail-eopbgr00063.outbound.protection.outlook.com ([40.107.0.63]:55406
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727509AbfAVJYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpPikFVYawzc/7k/HZ45Yi4MqvwShOkyErB9PxSCFVA=;
 b=NWFHfD/UxvWaBducraSvrnLG7okHk9LDjgmAKvw3IGv74olJM9Ux8thCqb5asURNrTFE5sbMlZ60BaUct0+WJVgrGNlqSobfycERHUkYL93SEQ06/eBKoA20W+M4PPZTtsdelvPzljkWcGzFCEVzhroNUYVCjwfV2Q3lXFdmTDA=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1813.eurprd08.prod.outlook.com (10.169.227.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 09:24:26 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 09:24:26 +0000
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
Subject: [PATCH v2 6/7] drm/komeda: Add irq handling
Thread-Topic: [PATCH v2 6/7] drm/komeda: Add irq handling
Thread-Index: AQHUsjRETgedwkt14Em51hz5Ex8diA==
Date:   Tue, 22 Jan 2019 09:24:25 +0000
Message-ID: <20190122092243.21226-7-james.qian.wang@arm.com>
References: <20190122092243.21226-1-james.qian.wang@arm.com>
In-Reply-To: <20190122092243.21226-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYCPR01CA0039.ausprd01.prod.outlook.com
 (2603:10c6:10:e::27) To DB6PR0801MB1990.eurprd08.prod.outlook.com
 (2603:10a6:4:6c::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB1813;6:Sj/3niJqZtkhRLyElrJr2JkW4+H480Y6IjRb0e8jPQmxm8RG72KbGbTOJUr+Ra1jo8JobhAmAOBYrAQwZ9QZBN+4yN5bDX5mGybiLDND4Mq81yXgGZ7PTvOQgNRAd1lsdUdxCP2/Db6N3qjYdRTtnxtLOunSBgW5uVlm9YkQ7kemfxpbKdJsstdZv/mIG+ogzSZMD8qGQWXBz5qrxKXxZLxLc/8O8mtnPsxwFvYp2nzcxxGoFzY4clgriKfaFxQaBjvDqj2HnSCBufmaxNxtFM+w2K+xlmKJL3uX6hsldK8vlPasDqQEMJcl8gzgGIu/TvmyjMphbGF2AL3kreDY84Oz49IsRg5VRBcfulBWDSgnG5MuJ7QdxBjLuoGmPNBO9FAZsCr1Rclpq8nrNha8eZaXUbBGrKVkxnFLgaqhgkL3VR3VoAlB2Vtldl0AHySwDb0Hj3vkjVhXcwHnGb2xyw==;5:sMokVRzp3838aTclmcwrqmykNZ+JDu7C18kA2Mp/WBsF5Vtkxhvn/wIGs4LNuyjGiaujvQP9LdEYZh3CBMiaBK65phxjvYhH/m2naXFhC/KuuPOtD/eqUd1zASLpeWa/RRxGwtaXQTB61RDlFQtgSoqW0k708gjjFudas9JqfUo970wcwnD6tdT0gGkX/qOoJgHml+NBfuypHfJRq+Tbkw==;7:VzQJNT54CccuRw+a5DjdaA/Kg1PKucGM/r2+3shT7nKEB8DgZphiLA4ok6u/Pk1f5A0Zd05jkUL7A9UDsALFficXJTKpqLzzQ8nvcOJDN+vgLsh/lgnFgkW3SRrSHLye7xG4niRERtepkVEEoDm7tw==
x-ms-office365-filtering-correlation-id: ea3ca720-8be8-4ece-1973-08d6804b66ce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1813;
x-ms-traffictypediagnostic: DB6PR0801MB1813:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB18132F65D5B34AC8D0798E3FB3980@DB6PR0801MB1813.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(366004)(189003)(199004)(54906003)(110136005)(305945005)(66066001)(103116003)(316002)(6486002)(25786009)(6636002)(478600001)(11346002)(446003)(256004)(5024004)(14444005)(486006)(81156014)(2616005)(476003)(53946003)(1076003)(4326008)(50226002)(68736007)(6512007)(386003)(6506007)(55236004)(71190400001)(71200400001)(53936002)(36756003)(105586002)(3846002)(2501003)(6116002)(8936002)(14454004)(99286004)(52116002)(97736004)(26005)(8676002)(81166006)(7736002)(86362001)(30864003)(186003)(6436002)(2906002)(102836004)(106356001)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1813;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: arq1uuirKvSV2S8toivhKjQOpqc1/07OWdPIHdepCCRjOR+mc40voMs++N15a/qcFM7T3d990f8yke2SnRcvREHylbhcSmZEf65dkK65WT0zXwlc0YmcjdrEfS3gaTPZK1iZofpPcjCgxSIks/McLj4+a1gQqOTq2KwTqZAFmVXAvnSqPbHYjLRle7Le6Hm8KMiH7NEw0lbrn9O++f5hIK1gE30Ysqy+Yt6pNQmGNu4BuiMs4ALotaLXKaqIkPfSrDVe4JI9Y7TyhiTNlkRyJvQDCcF6EA0TY1T49OdGbR5RBrMgBqeWNzOUoHpLBNRIWF1YiIU8UwanmpdQKgrZaYPcivJRL33p6RNuQ4xmNkSPBxbUBomFB5HHXNfRVBgcj8boznmSrFt3VGALbXKHA/xBUN9+YJ/skKffLZRtPuo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3ca720-8be8-4ece-1973-08d6804b66ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 09:24:17.4251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1813
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

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

v2:
- Move get IRQ number into this change.
- Enable irq before drm_dev_register.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 237 ++++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  18 ++
 .../gpu/drm/arm/display/komeda/komeda_dev.c   |   6 +
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |  46 ++++
 .../gpu/drm/arm/display/komeda/komeda_kms.c   |  37 ++-
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |   3 +
 6 files changed, 345 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.c
index b87ffae62dbe..afc13d3b3afc 100644
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
@@ -220,6 +454,9 @@ static struct komeda_dev_funcs d71_chip_funcs =3D {
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
index 5bb5a55f6b31..7ca9bc8ef725 100644
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
+		DRM_DEBUG("EOW.\n");
+
+	/* will handle it with crtc->flush */
+	if (events & KOMEDA_EVENT_FLIP)
+		DRM_DEBUG("FLIP Done.\n");
+}
+
 struct drm_crtc_helper_funcs komeda_crtc_helper_funcs =3D {
 };
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index a1160e2f07ec..01ae869b659b 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -49,6 +49,7 @@ static int komeda_parse_pipe_dt(struct komeda_dev *mdev, =
struct device_node *np)
=20
 static int komeda_parse_dt(struct device *dev, struct komeda_dev *mdev)
 {
+	struct platform_device *pdev =3D to_platform_device(dev);
 	struct device_node *child, *np =3D dev->of_node;
 	struct clk *clk;
 	int ret;
@@ -58,6 +59,11 @@ static int komeda_parse_dt(struct device *dev, struct ko=
meda_dev *mdev)
 		return PTR_ERR(clk);
=20
 	mdev->mclk =3D clk;
+	mdev->irq  =3D platform_get_irq(pdev, 0);
+	if (mdev->irq < 0) {
+		DRM_ERROR("could not get IRQ number.\n");
+		return mdev->irq;
+	}
=20
 	for_each_available_child_of_node(np, child) {
 		if (of_node_cmp(child->name, "pipeline") =3D=3D 0) {
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index 0f77dead6a23..681fe022bd22 100644
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
@@ -81,6 +124,9 @@ struct komeda_dev {
 	/** @mck: HW main engine clk */
 	struct clk *mclk;
=20
+	/** @irq: irq number */
+	int irq;
+
 	int n_pipelines;
 	struct komeda_pipeline *pipelines[KOMEDA_MAX_PIPELINES];
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.c
index 3fc096d3883e..4adc6a3104c9 100644
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
-	err =3D drm_dev_register(drm, 0);
+	err =3D drm_irq_install(drm, mdev->irq);
 	if (err)
 		goto cleanup_mode_config;
=20
+	err =3D mdev->funcs->enable_irq(mdev);
+	if (err)
+		goto uninstall_irq;
+
+	err =3D drm_dev_register(drm, 0);
+	if (err)
+		goto uninstall_irq;
+
 	return kms;
=20
+uninstall_irq:
+	drm_irq_uninstall(drm);
 cleanup_mode_config:
 	drm_mode_config_cleanup(drm);
 free_kms:
@@ -158,7 +189,9 @@ void komeda_kms_detach(struct komeda_kms_dev *kms)
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

