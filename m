Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B2BC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E92620664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aSnECSHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E92620664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbeJaFZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 01:25:43 -0400
Received: from mail-eopbgr40066.outbound.protection.outlook.com ([40.107.4.66]:47616
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726287AbeJaFZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 01:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66MYGNVhGzDnRnshQhI6PRDLvDR/Dnrb2C15o0W2eWg=;
 b=aSnECSHTUBlNfO+ucnLh4NVLJsLUc4d496GpRSL6FkD9vs0mtLzKJ1O+fYpv4QozrJYvUf8VRzino/mTt3enL5R+2EiqfHdbgfuAgpDBquIJ2Jv8IG7W/b8iD6oX5JupRG9HcnXqedpcDPHn2+wTeQdJ3GY42iZEaxXTl93yDgA=
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com (10.172.245.17) by
 DB6PR0402MB2920.eurprd04.prod.outlook.com (10.172.248.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Tue, 30 Oct 2018 20:30:40 +0000
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::e012:b6c0:4c6c:c314]) by DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::e012:b6c0:4c6c:c314%4]) with mapi id 15.20.1273.027; Tue, 30 Oct 2018
 20:30:40 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     "stuyoder@gmail.com" <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Youri Querry <youri.querry_1@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH v1 2/2] soc: fsl: dpio: Add support for memory backed QBMan
 portals
Thread-Topic: [PATCH v1 2/2] soc: fsl: dpio: Add support for memory backed
 QBMan portals
Thread-Index: AQHUcI9sGkqk2TGHg0KREwkxUKWkMA==
Date:   Tue, 30 Oct 2018 20:30:40 +0000
Message-ID: <1540931418-10697-3-git-send-email-roy.pledge@nxp.com>
References: <1540931418-10697-1-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1540931418-10697-1-git-send-email-roy.pledge@nxp.com>
Reply-To: Roy Pledge <roy.pledge@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: BYAPR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::39) To DB6PR0402MB2727.eurprd04.prod.outlook.com
 (2603:10a6:4:94::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [72.142.119.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0402MB2920;6:vqYqOcxoposT9yc5QFnRP5HwJFhZ8A+gJoSmD3Try063OdovCD4Iq6g5PKbmdebgZEeu4sMx3mFWNLozhl1zuEJ6gQ8fA1XwuAL+EUVOcTC9HV25iKKbgJ7aFE2ADcAFVaM7N5ADPBFT1YdYWQrTnLRTOoya+RmevpoGVxV1ECt7z81O2aA/UagBl1LPDUS1CYNobhvfoMQQtVzB+X/YOUq/RoZPeo2V7mgTFHamJPIOn9pIMV2VXAHE/G+Fe/erYRvhIVfAvGapI5syreuykKszIiUF1FBxDj5LogaqAPzaoLG2wqf+1VtY21tSr74jislDzqbzsOuh1gWNLSeTMTyk8NDxoCDfAstt5J0iaZfJLKEtvtnwxSFT1b+HwPzJp1EnjpeIZZ8NXC0vfgo7u4f9chY5nSKTk4anKP8YIxd6yDI+5/cWnarP5B5yt5c66OENIWqFhFXA/LU09rxouw==;5:XvCM4Joe71/goX60rRYBsHVHBakV941RvviYSuAuAyxa6QpfiGieU5RVQE5M/+k72jcVNVMOMEQi4Iqs+Rhg2f+RF5G0lSTVbLLs6GeU3BwTjSXwpGq9cNWgAwb1izvqzEBRe6abCQ7Qn4z6u3sljEURuvHSik4XblVeJQGs1nI=;7:fm02HM/eBvPFzEb9dNVB4tfA3zOVUm9CWglT6woOSHw+ohx/pk6aEE7YyXhChmR5diHhivnzXah8P39M45nhTNn/tAyK13uMwR8eXRAm22HLysLC8WXonni+A2xElvzo9Hnn4TR0tOk5xeasWM6hvw==
x-ms-office365-filtering-correlation-id: 0beb42e4-986e-44b7-6490-08d63ea68e9e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB6PR0402MB2920;
x-ms-traffictypediagnostic: DB6PR0402MB2920:
x-microsoft-antispam-prvs: <DB6PR0402MB29201370A07AE3D1BBCA82AB86CC0@DB6PR0402MB2920.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(227817650892897)(275809806118684)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB6PR0402MB2920;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0402MB2920;
x-forefront-prvs: 08417837C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(39860400002)(396003)(346002)(199004)(189003)(43066004)(4744004)(7736002)(81156014)(8676002)(99286004)(3450700001)(6486002)(81166006)(2501003)(76176011)(68736007)(6436002)(97736004)(8936002)(2900100001)(102836004)(305945005)(14454004)(71190400001)(105586002)(53936002)(478600001)(6512007)(52116002)(5250100002)(6506007)(386003)(36756003)(106356001)(71200400001)(186003)(5660300001)(3846002)(50226002)(2616005)(11346002)(446003)(256004)(54906003)(486006)(14444005)(476003)(110136005)(86362001)(44832011)(66066001)(25786009)(316002)(4326008)(26005)(2201001)(39060400002)(2906002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2920;H:DB6PR0402MB2727.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ww3rIxDT4VbW5KL7ie5efQ8/TT+aMm3hYs5x+rXi4pvpt69t8mv2dmpmS0Wc4A5EnCm7UrfQse6BiX5JeyNofm8s6GsJGJvL7anG//FtPzH6UEeJpXmnNg4aOvtxmAP9oI/lzVZyljo3qNATPTWSu3OfZdrXX4tQI+u2vpPFjCKoF6+uRBxMNcnl3Gb49EB85Ua2Dux1QbzMO89J+E56KILyYqFc52GfGSiYhai8BYLlT2EDzoacxSj5F80AA7ZVllk2zNawAAORHU7evOP/OOEovF5t6UsmXx/85EW7HWOvXZctC5f5H4YHO5n9/Jym0Ln3eTbsO8C9C5jl1g3GeWNkcW8Y0RHs53ZHeWPcjJ0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0beb42e4-986e-44b7-6490-08d63ea68e9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2018 20:30:40.2325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2920
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NXP devices with QBMan version 5 and above can enable software
portals that are memory backed. This allows the portal to be
mapped as cacheable/sharable (same as all normal memory) so
that portals can freely migrate between cores and clusters
in the SoC. The driver will enable this mode by default when
appropriate HW support is detected.

Signed-off-by: Youri Querry <youri.querry_1@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/dpio/dpio-driver.c  |  23 ++++--
 drivers/soc/fsl/dpio/qbman-portal.c | 148 ++++++++++++++++++++++++++++++--=
----
 drivers/soc/fsl/dpio/qbman-portal.h |   5 ++
 3 files changed, 144 insertions(+), 32 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio=
-driver.c
index e58fcc9..399a8e1 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -140,13 +140,22 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpi=
o_dev)
 	}
 	desc.cpu =3D next_cpu;
=20
-	/*
-	 * Set the CENA regs to be the cache inhibited area of the portal to
-	 * avoid coherency issues if a user migrates to another core.
-	 */
-	desc.regs_cena =3D devm_memremap(dev, dpio_dev->regions[1].start,
-				       resource_size(&dpio_dev->regions[1]),
-				       MEMREMAP_WC);
+	if (dpio_dev->obj_desc.region_count < 3) {
+		/* No support for DDR backed portals, use classic mapping */
+		/*
+		 * Set the CENA regs to be the cache inhibited area of the
+		 * portal to avoid coherency issues if a user migrates to
+		 * another core.
+		 */
+		desc.regs_cena =3D devm_memremap(dev, dpio_dev->regions[1].start,
+					resource_size(&dpio_dev->regions[1]),
+					MEMREMAP_WC);
+	} else {
+		desc.regs_cena =3D devm_memremap(dev, dpio_dev->regions[2].start,
+					resource_size(&dpio_dev->regions[2]),
+					MEMREMAP_WB);
+	}
+
 	if (IS_ERR(desc.regs_cena)) {
 		dev_err(dev, "devm_memremap failed\n");
 		err =3D PTR_ERR(desc.regs_cena);
diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbm=
an-portal.c
index cf1d448..9d7277d 100644
--- a/drivers/soc/fsl/dpio/qbman-portal.c
+++ b/drivers/soc/fsl/dpio/qbman-portal.c
@@ -15,6 +15,8 @@
 #define QMAN_REV_4000   0x04000000
 #define QMAN_REV_4100   0x04010000
 #define QMAN_REV_4101   0x04010001
+#define QMAN_REV_5000   0x05000000
+
 #define QMAN_REV_MASK   0xffff0000
=20
 /* All QBMan command and result structures use this "valid bit" encoding *=
/
@@ -25,10 +27,17 @@
 #define QBMAN_WQCHAN_CONFIGURE 0x46
=20
 /* CINH register offsets */
+#define QBMAN_CINH_SWP_EQCR_PI      0x800
 #define QBMAN_CINH_SWP_EQAR    0x8c0
+#define QBMAN_CINH_SWP_CR_RT        0x900
+#define QBMAN_CINH_SWP_VDQCR_RT     0x940
+#define QBMAN_CINH_SWP_EQCR_AM_RT   0x980
+#define QBMAN_CINH_SWP_RCR_AM_RT    0x9c0
 #define QBMAN_CINH_SWP_DQPI    0xa00
 #define QBMAN_CINH_SWP_DCAP    0xac0
 #define QBMAN_CINH_SWP_SDQCR   0xb00
+#define QBMAN_CINH_SWP_EQCR_AM_RT2  0xb40
+#define QBMAN_CINH_SWP_RCR_PI       0xc00
 #define QBMAN_CINH_SWP_RAR     0xcc0
 #define QBMAN_CINH_SWP_ISR     0xe00
 #define QBMAN_CINH_SWP_IER     0xe40
@@ -43,6 +52,13 @@
 #define QBMAN_CENA_SWP_RR(vb)  (0x700 + ((u32)(vb) >> 1))
 #define QBMAN_CENA_SWP_VDQCR   0x780
=20
+/* CENA register offsets in memory-backed mode */
+#define QBMAN_CENA_SWP_DQRR_MEM(n)  (0x800 + ((u32)(n) << 6))
+#define QBMAN_CENA_SWP_RCR_MEM(n)   (0x1400 + ((u32)(n) << 6))
+#define QBMAN_CENA_SWP_CR_MEM       0x1600
+#define QBMAN_CENA_SWP_RR_MEM       0x1680
+#define QBMAN_CENA_SWP_VDQCR_MEM    0x1780
+
 /* Reverse mapping of QBMAN_CENA_SWP_DQRR() */
 #define QBMAN_IDX_FROM_DQRR(p) (((unsigned long)(p) & 0x1ff) >> 6)
=20
@@ -96,10 +112,13 @@ static inline void *qbman_get_cmd(struct qbman_swp *p,=
 u32 offset)
=20
 #define SWP_CFG_DQRR_MF_SHIFT 20
 #define SWP_CFG_EST_SHIFT     16
+#define SWP_CFG_CPBS_SHIFT    15
 #define SWP_CFG_WN_SHIFT      14
 #define SWP_CFG_RPM_SHIFT     12
 #define SWP_CFG_DCM_SHIFT     10
 #define SWP_CFG_EPM_SHIFT     8
+#define SWP_CFG_VPM_SHIFT     7
+#define SWP_CFG_CPM_SHIFT     6
 #define SWP_CFG_SD_SHIFT      5
 #define SWP_CFG_SP_SHIFT      4
 #define SWP_CFG_SE_SHIFT      3
@@ -125,6 +144,8 @@ static inline u32 qbman_set_swp_cfg(u8 max_fill, u8 wn,=
	u8 est, u8 rpm, u8 dcm,
 		ep << SWP_CFG_EP_SHIFT);
 }
=20
+#define QMAN_RT_MODE	   0x00000100
+
 /**
  * qbman_swp_init() - Create a functional object representing the given
  *                    QBMan portal descriptor.
@@ -146,6 +167,8 @@ struct qbman_swp *qbman_swp_init(const struct qbman_swp=
_desc *d)
 	p->sdq |=3D qbman_sdqcr_dct_prio_ics << QB_SDQCR_DCT_SHIFT;
 	p->sdq |=3D qbman_sdqcr_fc_up_to_3 << QB_SDQCR_FC_SHIFT;
 	p->sdq |=3D QMAN_SDQCR_TOKEN << QB_SDQCR_TOK_SHIFT;
+	if ((p->desc->qman_version & QMAN_REV_MASK) >=3D QMAN_REV_5000)
+		p->mr.valid_bit =3D QB_VALID_BIT;
=20
 	atomic_set(&p->vdq.available, 1);
 	p->vdq.valid_bit =3D QB_VALID_BIT;
@@ -163,6 +186,9 @@ struct qbman_swp *qbman_swp_init(const struct qbman_swp=
_desc *d)
 	p->addr_cena =3D d->cena_bar;
 	p->addr_cinh =3D d->cinh_bar;
=20
+	if ((p->desc->qman_version & QMAN_REV_MASK) >=3D QMAN_REV_5000)
+		memset(p->addr_cena, 0, 64 * 1024);
+
 	reg =3D qbman_set_swp_cfg(p->dqrr.dqrr_size,
 				1, /* Writes Non-cacheable */
 				0, /* EQCR_CI stashing threshold */
@@ -175,6 +201,10 @@ struct qbman_swp *qbman_swp_init(const struct qbman_sw=
p_desc *d)
 				1, /* dequeue stashing priority =3D=3D TRUE */
 				0, /* dequeue stashing enable =3D=3D FALSE */
 				0); /* EQCR_CI stashing priority =3D=3D FALSE */
+	if ((p->desc->qman_version & QMAN_REV_MASK) >=3D QMAN_REV_5000)
+		reg |=3D 1 << SWP_CFG_CPBS_SHIFT | /* memory-backed mode */
+		       1 << SWP_CFG_VPM_SHIFT |  /* VDQCR read triggered mode */
+		       1 << SWP_CFG_CPM_SHIFT;   /* CR read triggered mode */
=20
 	qbman_write_register(p, QBMAN_CINH_SWP_CFG, reg);
 	reg =3D qbman_read_register(p, QBMAN_CINH_SWP_CFG);
@@ -183,6 +213,10 @@ struct qbman_swp *qbman_swp_init(const struct qbman_sw=
p_desc *d)
 		return NULL;
 	}
=20
+	if ((p->desc->qman_version & QMAN_REV_MASK) >=3D QMAN_REV_5000) {
+		qbman_write_register(p, QBMAN_CINH_SWP_EQCR_PI, QMAN_RT_MODE);
+		qbman_write_register(p, QBMAN_CINH_SWP_RCR_PI, QMAN_RT_MODE);
+	}
 	/*
 	 * SDQCR needs to be initialized to 0 when no channels are
 	 * being dequeued from or else the QMan HW will indicate an
@@ -277,7 +311,10 @@ void qbman_swp_interrupt_set_inhibit(struct qbman_swp =
*p, int inhibit)
  */
 void *qbman_swp_mc_start(struct qbman_swp *p)
 {
-	return qbman_get_cmd(p, QBMAN_CENA_SWP_CR);
+	if ((p->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000)
+		return qbman_get_cmd(p, QBMAN_CENA_SWP_CR);
+	else
+		return qbman_get_cmd(p, QBMAN_CENA_SWP_CR_MEM);
 }
=20
 /*
@@ -288,8 +325,14 @@ void qbman_swp_mc_submit(struct qbman_swp *p, void *cm=
d, u8 cmd_verb)
 {
 	u8 *v =3D cmd;
=20
-	dma_wmb();
-	*v =3D cmd_verb | p->mc.valid_bit;
+	if ((p->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000) {
+		dma_wmb();
+		*v =3D cmd_verb | p->mc.valid_bit;
+	} else {
+		*v =3D cmd_verb | p->mc.valid_bit;
+		dma_wmb();
+		qbman_write_register(p, QBMAN_CINH_SWP_CR_RT, QMAN_RT_MODE);
+	}
 }
=20
 /*
@@ -300,13 +343,27 @@ void *qbman_swp_mc_result(struct qbman_swp *p)
 {
 	u32 *ret, verb;
=20
-	ret =3D qbman_get_cmd(p, QBMAN_CENA_SWP_RR(p->mc.valid_bit));
+	if ((p->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000) {
+		ret =3D qbman_get_cmd(p, QBMAN_CENA_SWP_RR(p->mc.valid_bit));
+		/* Remove the valid-bit - command completed if the rest
+		 * is non-zero.
+		 */
+		verb =3D ret[0] & ~QB_VALID_BIT;
+		if (!verb)
+			return NULL;
+		p->mc.valid_bit ^=3D QB_VALID_BIT;
+	} else {
+		ret =3D qbman_get_cmd(p, QBMAN_CENA_SWP_RR_MEM);
+		/* Command completed if the valid bit is toggled */
+		if (p->mr.valid_bit !=3D (ret[0] & QB_VALID_BIT))
+			return NULL;
+		/* Command completed if the rest is non-zero */
+		verb =3D ret[0] & ~QB_VALID_BIT;
+		if (!verb)
+			return NULL;
+		p->mr.valid_bit ^=3D QB_VALID_BIT;
+	}
=20
-	/* Remove the valid-bit - command completed if the rest is non-zero */
-	verb =3D ret[0] & ~QB_VALID_BIT;
-	if (!verb)
-		return NULL;
-	p->mc.valid_bit ^=3D QB_VALID_BIT;
 	return ret;
 }
=20
@@ -383,6 +440,18 @@ void qbman_eq_desc_set_qd(struct qbman_eq_desc *d, u32=
 qdid,
 #define EQAR_VB(eqar)      ((eqar) & 0x80)
 #define EQAR_SUCCESS(eqar) ((eqar) & 0x100)
=20
+static inline void qbman_write_eqcr_am_rt_register(struct qbman_swp *p,
+						   u8 idx)
+{
+	if (idx < 16)
+		qbman_write_register(p, QBMAN_CINH_SWP_EQCR_AM_RT + idx * 4,
+				     QMAN_RT_MODE);
+	else
+		qbman_write_register(p, QBMAN_CINH_SWP_EQCR_AM_RT2 +
+				     (idx - 16) * 4,
+				     QMAN_RT_MODE);
+}
+
 /**
  * qbman_swp_enqueue() - Issue an enqueue command
  * @s:  the software portal used for enqueue
@@ -407,9 +476,15 @@ int qbman_swp_enqueue(struct qbman_swp *s, const struc=
t qbman_eq_desc *d,
 	memcpy(&p->dca, &d->dca, 31);
 	memcpy(&p->fd, fd, sizeof(*fd));
=20
-	/* Set the verb byte, have to substitute in the valid-bit */
-	dma_wmb();
-	p->verb =3D d->verb | EQAR_VB(eqar);
+	if ((s->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000) {
+		/* Set the verb byte, have to substitute in the valid-bit */
+		dma_wmb();
+		p->verb =3D d->verb | EQAR_VB(eqar);
+	} else {
+		p->verb =3D d->verb | EQAR_VB(eqar);
+		dma_wmb();
+		qbman_write_eqcr_am_rt_register(s, EQAR_IDX(eqar));
+	}
=20
 	return 0;
 }
@@ -586,17 +661,27 @@ int qbman_swp_pull(struct qbman_swp *s, struct qbman_=
pull_desc *d)
 		return -EBUSY;
 	}
 	s->vdq.storage =3D (void *)(uintptr_t)d->rsp_addr_virt;
-	p =3D qbman_get_cmd(s, QBMAN_CENA_SWP_VDQCR);
+	if ((s->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000)
+		p =3D qbman_get_cmd(s, QBMAN_CENA_SWP_VDQCR);
+	else
+		p =3D qbman_get_cmd(s, QBMAN_CENA_SWP_VDQCR_MEM);
 	p->numf =3D d->numf;
 	p->tok =3D QMAN_DQ_TOKEN_VALID;
 	p->dq_src =3D d->dq_src;
 	p->rsp_addr =3D d->rsp_addr;
 	p->rsp_addr_virt =3D d->rsp_addr_virt;
-	dma_wmb();
=20
-	/* Set the verb byte, have to substitute in the valid-bit */
-	p->verb =3D d->verb | s->vdq.valid_bit;
-	s->vdq.valid_bit ^=3D QB_VALID_BIT;
+	if ((s->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000) {
+		dma_wmb();
+		/* Set the verb byte, have to substitute in the valid-bit */
+		p->verb =3D d->verb | s->vdq.valid_bit;
+		s->vdq.valid_bit ^=3D QB_VALID_BIT;
+	} else {
+		p->verb =3D d->verb | s->vdq.valid_bit;
+		s->vdq.valid_bit ^=3D QB_VALID_BIT;
+		dma_wmb();
+		qbman_write_register(s, QBMAN_CINH_SWP_VDQCR_RT, QMAN_RT_MODE);
+	}
=20
 	return 0;
 }
@@ -654,7 +739,10 @@ const struct dpaa2_dq *qbman_swp_dqrr_next(struct qbma=
n_swp *s)
 				       QBMAN_CENA_SWP_DQRR(s->dqrr.next_idx)));
 	}
=20
-	p =3D qbman_get_cmd(s, QBMAN_CENA_SWP_DQRR(s->dqrr.next_idx));
+	if ((s->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000)
+		p =3D qbman_get_cmd(s, QBMAN_CENA_SWP_DQRR(s->dqrr.next_idx));
+	else
+		p =3D qbman_get_cmd(s, QBMAN_CENA_SWP_DQRR_MEM(s->dqrr.next_idx));
 	verb =3D p->dq.verb;
=20
 	/*
@@ -806,18 +894,28 @@ int qbman_swp_release(struct qbman_swp *s, const stru=
ct qbman_release_desc *d,
 		return -EBUSY;
=20
 	/* Start the release command */
-	p =3D qbman_get_cmd(s, QBMAN_CENA_SWP_RCR(RAR_IDX(rar)));
+	if ((s->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000)
+		p =3D qbman_get_cmd(s, QBMAN_CENA_SWP_RCR(RAR_IDX(rar)));
+	else
+		p =3D qbman_get_cmd(s, QBMAN_CENA_SWP_RCR_MEM(RAR_IDX(rar)));
 	/* Copy the caller's buffer pointers to the command */
 	for (i =3D 0; i < num_buffers; i++)
 		p->buf[i] =3D cpu_to_le64(buffers[i]);
 	p->bpid =3D d->bpid;
=20
-	/*
-	 * Set the verb byte, have to substitute in the valid-bit and the number
-	 * of buffers.
-	 */
-	dma_wmb();
-	p->verb =3D d->verb | RAR_VB(rar) | num_buffers;
+	if ((s->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000) {
+		/*
+		 * Set the verb byte, have to substitute in the valid-bit
+		 * and the number of buffers.
+		 */
+		dma_wmb();
+		p->verb =3D d->verb | RAR_VB(rar) | num_buffers;
+	} else {
+		p->verb =3D d->verb | RAR_VB(rar) | num_buffers;
+		dma_wmb();
+		qbman_write_register(s, QBMAN_CINH_SWP_RCR_AM_RT +
+				     RAR_IDX(rar)  * 4, QMAN_RT_MODE);
+	}
=20
 	return 0;
 }
diff --git a/drivers/soc/fsl/dpio/qbman-portal.h b/drivers/soc/fsl/dpio/qbm=
an-portal.h
index 89d1dd9..a975b1fc 100644
--- a/drivers/soc/fsl/dpio/qbman-portal.h
+++ b/drivers/soc/fsl/dpio/qbman-portal.h
@@ -110,6 +110,11 @@ struct qbman_swp {
 		u32 valid_bit; /* 0x00 or 0x80 */
 	} mc;
=20
+	/* Management response */
+	struct {
+		u32 valid_bit; /* 0x00 or 0x80 */
+	} mr;
+
 	/* Push dequeues */
 	u32 sdq;
=20
--=20
2.7.4

