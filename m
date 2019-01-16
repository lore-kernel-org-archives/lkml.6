Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569D9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B97F20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="brLdY/sR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392578AbfAPLs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:48:57 -0500
Received: from mail-eopbgr10044.outbound.protection.outlook.com ([40.107.1.44]:33184
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389735AbfAPLsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yktlCVQ9I8BT0W2qXeAYFVIhUBpDuMXP9UKx7qzzwSU=;
 b=brLdY/sRXs0Fw3dzZfK5xjgXWwf0ahJFq1U9QQJu3iLivnwi8iT94b8xvp94Cbiv9mi1siOJ00IMtUB8AW0RMbMxruBBwiPCYsqSaYEagAx6c02Gwzo8Mb0agmNCV6c45OK/y59bIZ2n+GFERJQoUL7IlMkG6LlbaZYAEMD9v6g=
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com (52.135.161.10) by
 AM6PR04MB6280.eurprd04.prod.outlook.com (20.179.18.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Wed, 16 Jan 2019 11:48:48 +0000
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9]) by AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9%5]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 11:48:48 +0000
From:   Robert Chiras <robert.chiras@nxp.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>
CC:     Robert Chiras <robert.chiras@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Anson Huang <anson.huang@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/11] drm/mxsfb: Clear OUTSTANDING_REQS bits
Thread-Topic: [PATCH 11/11] drm/mxsfb: Clear OUTSTANDING_REQS bits
Thread-Index: AQHUrZFx6GwZl2wRTEajGcQBe5+8+w==
Date:   Wed, 16 Jan 2019 11:48:48 +0000
Message-ID: <1547639306-19151-12-git-send-email-robert.chiras@nxp.com>
References: <1547639306-19151-1-git-send-email-robert.chiras@nxp.com>
In-Reply-To: <1547639306-19151-1-git-send-email-robert.chiras@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0502CA0018.eurprd05.prod.outlook.com
 (2603:10a6:203:91::28) To AM6PR04MB4007.eurprd04.prod.outlook.com
 (2603:10a6:209:40::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robert.chiras@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB6280;6:XT+M4Qf3IIBlzMI9d9Ed1qvINZwtiRcuVFwKS5Rr+v9c3sMqJhKaIe93L/quQSctB/sE8yzkhfEdztLiFx6NQBAvZ06WHbmHTUHdgAI2Q2eIPbosmYGG3fAWOS7IZLYNZ9mpLuO9PgPwjL9GB8T5OCu7eVrqGQk23QkUdfwIgU00yUJJ6Zl+4/ZQSjrYK34f0ypTUgagA5us4FRl6eFC00DUGrxYxNVKg7mt/JQ82GgdsPiomfGNXiUduw9fGmDrz+FvDFabpTSUZ+U+lOgFZC7GCMBXHxHPQHPhnHAhmo+vr7jJ/XaJhIpC1mV3CABK1EuPvRoJJvya9INAWHxFmMhK9pRzCI1KUOYxv7ydj4yUSoHWCY69mzw9hmm02zdBKScN96dBFuITLmoN8Kl9oK+QxqzBEQpnY9QDmFqr8JHBjk+23Rq+0k+bkIKP6EtOMWU2uf1wodemhROjLNKm2A==;5:NaACSl6yGT9UhYNOjguG39r0uu26GnpB95aAlvdwLjX0OC2V/10Wq8CWHTDTF/UDI9qD5k0jnpzrnc85qtVnSClnnGO2pBVZ6at1salHP7TkN+K/xCn5rieOQh/wp98x9QjaYuWvoMuPpFsruOVELSUNR+Al4sKr79aj7j4AMNrptp+9ekOOFN6D+UdkZVrJv0Lm+BjXMGwI+FzWD0gIlQ==;7:36iuOu+8m64XgKcRHqstdnj6DTRvHj8RTA7ti2AhpDwC+5hOwXxvgnT5QjzvQnmK1fuYHt6yszdF3w/Zqn05VNOr22f2CX5VpJZyC2Y+bu6Uu7RRAHB4K+CSyAx1i6QHBcjC+EfVR5K0rM9+hqqqQg==
x-ms-office365-filtering-correlation-id: 1ae36352-34aa-4680-e066-08d67ba893e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6280;
x-ms-traffictypediagnostic: AM6PR04MB6280:
x-microsoft-antispam-prvs: <AM6PR04MB62809106C263886D4ECCA755E3820@AM6PR04MB6280.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39860400002)(366004)(346002)(199004)(189003)(6436002)(44832011)(50226002)(6486002)(86362001)(6512007)(4326008)(486006)(105586002)(97736004)(53936002)(66066001)(478600001)(71200400001)(8676002)(71190400001)(446003)(11346002)(14454004)(186003)(2616005)(6116002)(316002)(106356001)(76176011)(102836004)(305945005)(8936002)(99286004)(386003)(25786009)(3846002)(26005)(2906002)(256004)(54906003)(14444005)(7736002)(110136005)(36756003)(52116002)(68736007)(5660300001)(476003)(81166006)(81156014)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6280;H:AM6PR04MB4007.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ef8Jwh6xw8c9262+aB8x9l806cmXGv0nbbKR+Cr0U42zpjV9irBwqmMW7a56RhW8OrHMOF4ma7V9ddbDj96xnZNOH9H9AqnRrENX26OQkUUbA9Xx9WfPKI/ePaj/WGe3UcQSxqG4k4L0JqesmIXarMY9JX32DZVVjf+xmkWJlA93Y/Ee3cvsmUGk6fEWC80AASnl9io/NV/OFnOV0yETRQvdZhgrDoNfJebmjMla2fuU21tV4kLj0A25mAw74QaR0KdJ/5q6l2V0tymZ8HDW/h+2sxLRkBAYMvHbKbgRL6bdj5S2j8lApwaRwNkB0bACLzhs2FlBvp4+VZr8MyUdlVBs6xQw7pRtt6fJ8zEGpZ6zOHA6ftqcXyhJ6sgTmtYdqc1ksas+z9zBsk29o52IVwpeVtrsVkI68S12yyErS9g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae36352-34aa-4680-e066-08d67ba893e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 11:48:47.9200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6280
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bit 21 can alter the CTRL2_OUTSTANDING_REQS value right after the eLCDIF
is enabled, since it comes up with default value of 1 (this behaviour
has been seen on some imx8 platforms).
In order to fix this, clear CTRL2_OUTSTANDING_REQS bits before setting
its value.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxs=
fb_crtc.c
index cbdbd47..41b3648 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -231,6 +231,13 @@ static void mxsfb_enable_controller(struct mxsfb_drm_p=
rivate *mxsfb)
 	clk_prepare_enable(mxsfb->clk);
=20
 	if (mxsfb->devdata->ipversion >=3D 4) {
+		/*
+		 * On some platforms, bit 21 is defaulted to 1, which may alter
+		 * the below setting. So, to make sure we have the right setting
+		 * clear all the bits for CTRL2_OUTSTANDING_REQS.
+		 */
+		writel(CTRL2_OUTSTANDING_REQS(0x7),
+			mxsfb->base + LCDC_V4_CTRL2 + REG_CLR);
 		writel(CTRL2_OUTSTANDING_REQS(REQ_16),
 			mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
 		/* Assert LCD Reset bit */
--=20
2.7.4

