Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDFDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45EC20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zu0EAftH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388897AbfAKOaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:30:10 -0500
Received: from mail-eopbgr150047.outbound.protection.outlook.com ([40.107.15.47]:51024
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388821AbfAKOaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=is2jxYaxsxyra7TXBjz3HLjpSbGfQ4PY3siFm0opsu8=;
 b=Zu0EAftHui2njPTlQYa38pf/8VPOntYr55aiesBELqQVDFzQAL/vPgU2/M8N6Elnp6fXEPhkRymOO7YzvYEpPR2h14BoGASwCWGojD9E+nCSSYCCjBFZF5Sn3znzji6+XBshtvkzVDAfd66muTxzZ4Dx356cilXSIfCxiyjjwjg=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3902.eurprd04.prod.outlook.com (52.134.17.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Fri, 11 Jan 2019 14:29:49 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::a8aa:5f09:1d1c:7b57]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::a8aa:5f09:1d1c:7b57%3]) with mapi id 15.20.1495.013; Fri, 11 Jan 2019
 14:29:49 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] dma: imx-sdma: pass ->dev to dma_alloc_coherent() API
Thread-Topic: [PATCH] dma: imx-sdma: pass ->dev to dma_alloc_coherent() API
Thread-Index: AQHUqbobsjeXIYA2Z066CXfEtEyuRA==
Date:   Fri, 11 Jan 2019 14:29:49 +0000
Message-ID: <20190111142930.21193-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0062.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::39) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3902;6:yNjn6pybfa7SzQB+xPs/S7rUoHfL2MCQTzDYfvHyUOOu3Q32/w9qF/BXeqi3zrAwyZxez8sH+syxqxiOGSoMNA7UZLsQRU/IzzQ51d8/ofBBlgPQb47lHBTTrgzvpOfDbmA/+i2RscvTbKWNkYm+ZNil/U8R0CR80daYfu2Pox7cxd6E3I+AmKrXHYAE5Gegyd09y4yggcWvxJPFJ0IJh9IeOJZJErxfF0Vq3nOfxmYnEtcg/hbVwQ+lFIxMhPu9pFPO7fayjd5wCrUh+W4PVv+iqmL9aeCjkLGzXOmFjf4d3drQKmrDcaY5xYvWu9iTEPVufSFd3kv7Ye9/ymqLaReQySHd0VyZJt+O0FaKu4ABDrKaCOnxm1KtLSUNzrm6Mq+nvJz1XABhQpVIgYl7vNg8Q4EZsyYySIWuIfLDmyjtkiGK/noHWwfU34HODINjRpSHXUHEKf/omirpr2j2Hg==;5:0TxjEuax1gXiOrX8y5F2h8FD1/c/moNR5cegC5WXykuGE/xHsXIX2q7GD2UszJV3i+PFbEBVQkGMVWVnXp95OxJHayj0KwQmPArJg0WcozEY+MCRB1TNdjGRoAE1ZBlgCxFvK/O1PJWAxq6+XlsBg5gxK4pMB3Rcd5Gr7+WO0RFyM8aCfjnTj0O+xlI/FBn2yxtFIuEcXO232elDImpnjw==;7:QoY6eujgahNbmKD05BapPj6nHdYGVMnjPmj+XlTYo5T5CqKcpzDRwvI59amckrsFBlpJacQdyFSAmjBO2qEfnKmZ4Co4uHqs7aXyk3eiH84LVqC+KGCXIXQBHUTv0s35E/SF+6EswjGvdsJepksWVw==
x-ms-office365-filtering-correlation-id: 813d8c7a-3796-4741-96d1-08d677d13dc4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3902;
x-ms-traffictypediagnostic: VI1PR0402MB3902:
x-microsoft-antispam-prvs: <VI1PR0402MB3902813A672CC648780C3FE8F9850@VI1PR0402MB3902.eurprd04.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(99286004)(316002)(6436002)(36756003)(68736007)(256004)(110136005)(486006)(44832011)(6486002)(54906003)(478600001)(2501003)(66066001)(14444005)(14454004)(71190400001)(97736004)(71200400001)(5660300001)(6512007)(575784001)(86362001)(53936002)(7736002)(25786009)(1076003)(386003)(8936002)(6506007)(106356001)(81156014)(8676002)(81166006)(52116002)(4326008)(102836004)(476003)(2616005)(6116002)(3846002)(2906002)(26005)(50226002)(105586002)(186003)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3902;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r0dRyOJ74fQ6RghA+cwlF0oZww2z+tNbYHxlg40SXB5DUUQLSrO6msATQURCcD6lcCwbTZWuac1HYS91uETSh9X6qtB5Tu70iUXTkfxD1JkQTxmzHgOFe5F2XkfPdR54zVnrwRPCvgFQWhKs0DKSuJBjNLNlToddtOqkK48Z9GkaYDDBn188lQhZaTuJiI5mz6P3sITMT0hCE3roN4uJThsjJ3/iT9IlD6MpBH6zM5e7ZWos7bLggyHPZkP6Z4YsuByDrIGk+rl7tIRSmAqb/YYWeDq7bYkPC8euEuqoGVdC57Db96CtTvHDZ1pDS4OsGUXbD3VhOqg17CZDC5PHlE/GRaMS3pwrv1V1P6bvoJRww/kJu0LvsebStQwnRvuAun6gNeBmFGwftfbCkg1JN2GpBI1arYakhng1Lpnry4c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813d8c7a-3796-4741-96d1-08d677d13dc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 14:29:48.3304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3902
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Duan <fugang.duan@nxp.com>

Pass ->dev to dma_alloc_coherent() API. We need this
becase dma_alloc_coherent() makes use of dev parameter
and receiving NULL will result in a crash.

Signed-off-by: Andy Duan <fugang.duan@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/dma/imx-sdma.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index a2b0a0e71168..26133b78ced8 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -677,7 +677,7 @@ static int sdma_load_script(struct sdma_engine *sdma, v=
oid *buf, int size,
 	int ret;
 	unsigned long flags;
=20
-	buf_virt =3D dma_alloc_coherent(NULL, size, &buf_phys, GFP_KERNEL);
+	buf_virt =3D dma_alloc_coherent(sdma->dev, size, &buf_phys, GFP_KERNEL);
 	if (!buf_virt) {
 		return -ENOMEM;
 	}
@@ -696,7 +696,7 @@ static int sdma_load_script(struct sdma_engine *sdma, v=
oid *buf, int size,
=20
 	spin_unlock_irqrestore(&sdma->channel_0_lock, flags);
=20
-	dma_free_coherent(NULL, size, buf_virt, buf_phys);
+	dma_free_coherent(sdma->dev, size, buf_virt, buf_phys);
=20
 	return ret;
 }
@@ -1182,7 +1182,7 @@ static int sdma_request_channel0(struct sdma_engine *=
sdma)
 {
 	int ret =3D -EBUSY;
=20
-	sdma->bd0 =3D dma_zalloc_coherent(NULL, PAGE_SIZE, &sdma->bd0_phys,
+	sdma->bd0 =3D dma_zalloc_coherent(sdma->dev, PAGE_SIZE, &sdma->bd0_phys,
 					GFP_NOWAIT);
 	if (!sdma->bd0) {
 		ret =3D -ENOMEM;
@@ -1205,8 +1205,8 @@ static int sdma_alloc_bd(struct sdma_desc *desc)
 	u32 bd_size =3D desc->num_bd * sizeof(struct sdma_buffer_descriptor);
 	int ret =3D 0;
=20
-	desc->bd =3D dma_zalloc_coherent(NULL, bd_size, &desc->bd_phys,
-					GFP_NOWAIT);
+	desc->bd =3D dma_zalloc_coherent(desc->sdmac->sdma->dev, bd_size,
+				       &desc->bd_phys, GFP_NOWAIT);
 	if (!desc->bd) {
 		ret =3D -ENOMEM;
 		goto out;
@@ -1219,7 +1219,8 @@ static void sdma_free_bd(struct sdma_desc *desc)
 {
 	u32 bd_size =3D desc->num_bd * sizeof(struct sdma_buffer_descriptor);
=20
-	dma_free_coherent(NULL, bd_size, desc->bd, desc->bd_phys);
+	dma_free_coherent(desc->sdmac->sdma->dev, bd_size, desc->bd,
+			  desc->bd_phys);
 }
=20
 static void sdma_desc_free(struct virt_dma_desc *vd)
@@ -1842,7 +1843,7 @@ static int sdma_init(struct sdma_engine *sdma)
 	/* Be sure SDMA has not started yet */
 	writel_relaxed(0, sdma->regs + SDMA_H_C0PTR);
=20
-	sdma->channel_control =3D dma_alloc_coherent(NULL,
+	sdma->channel_control =3D dma_alloc_coherent(sdma->dev,
 			MAX_DMA_CHANNELS * sizeof (struct sdma_channel_control) +
 			sizeof(struct sdma_context_data),
 			&ccb_phys, GFP_KERNEL);
--=20
2.17.1

