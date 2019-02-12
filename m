Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F35C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7CE214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kOsxmxeq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbfBLMlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:41:03 -0500
Received: from mail-eopbgr150044.outbound.protection.outlook.com ([40.107.15.44]:24288
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727732AbfBLMlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpL2EdLrUZcH6pUDOqkoOKqgaq6l5VORjkNC53ZTYuM=;
 b=kOsxmxeqGLFFFdhAsRQQ9ohqZegwOMrq3TQLK0+xGa3sAt3DvlBblmnfZU+8iWkRFHokVBieAoC/KdDPgogaroJr3mGuhPydCQa8iuPPXnhqOu213ga54suaM0PC9SSpZNIQ72CEZT7sicvTb9nbav+n7+iId7yp2pYNlmYEs7c=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3659.eurprd04.prod.outlook.com (52.134.66.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Tue, 12 Feb 2019 12:40:25 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 12:40:25 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] mailbox: imx: keep MU irq working during suspend/resume
Thread-Topic: [PATCH] mailbox: imx: keep MU irq working during suspend/resume
Thread-Index: AQHUwtAg/pNADKFPLk+9n0uazrY7lA==
Date:   Tue, 12 Feb 2019 12:40:25 +0000
Message-ID: <1549974905-12116-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0180.apcprd02.prod.outlook.com
 (2603:1096:201:21::16) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3659;6:5qBQZfjI8fiaj4cfR7awbgxHr6BHXWqESlNCl3mFvmDlFDxV2tP1OCqu+YEJ+IiQYAZaQHMufUw7qnB3OzTC1UMHevEkwx0xX8jSBpIHTx5P8OU6jfu7Q8DLNi7RsQ914J7BMBgqj9sD1HHNEgrOFx2Zw0Ea7RlgYBpSWvmcyP5HlvqnhEU9XzmajuARFR9K64KJ/mM8Qxuz/Cch9KFSlFbxNIgOVFGaBa1pFYUtGYgBoPJWyHOt71rAAL3jKMJgPQpdadVn6F8nMAGLA2qVMm2CATxINNZFhgKyPjNgTqSRScJgXsaHZ7uolgyy4fptkSk/TPNex/GU/KUL3mHAwbQUr36HGeC1D615Tmz1P7FPZ5u/lsS0H0XaT0Lpc2gnEm1bqCtfB8JvDioZTm07cMdYSuUQf8G5fDi2U3MaRf0ahQqNgd7kyeChjj9utBmWCIyh/8Xlf8spL/ln02jGvA==;5:nO8uG4w1PH/qZ0D93SCchqDiCj3+dGaiukCXS18KMVJ+Yq//yS6hTi7eTsrXEzo2eJX64xSAN4Vc9B+2oPT1eSYqyBdyRXMiLvzOwrseNUCfef3QYtK87TaxOUjINcy79Jbq52Qb01ulGoE0i7FazlEguEuXLMt2mL5zjvq1K5iTv5Lv4aGY43Oo/eEuusNgTUwk5OgsbuAceLB5TR8oPQ==;7:DVpqbEtfXY0PNSvKvHLqDkZvgO3+PbHJ5VCzZSnezqPzs3fbvLulMF59f7EYfj/YT1Gfmp3KRVUfzzAsk6WssG5WLDtDLeESKCLSb08cIm/WFBJxYItCYltFVd0vhCIHoe5IAwyTca5Xxg3FPWzVjA==
x-ms-office365-filtering-correlation-id: f03dba34-f5cf-4840-8d2b-08d690e742d7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3659;
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-microsoft-antispam-prvs: <DB3PR0402MB3659BA006D12F2CB003111DCF5650@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(396003)(39860400002)(376002)(189003)(199004)(4326008)(71200400001)(7736002)(186003)(71190400001)(52116002)(15650500001)(2616005)(476003)(486006)(25786009)(97736004)(305945005)(3846002)(53936002)(6116002)(2906002)(68736007)(66066001)(2501003)(386003)(110136005)(102836004)(50226002)(316002)(8936002)(81156014)(36756003)(8676002)(6512007)(14454004)(14444005)(106356001)(256004)(86362001)(6436002)(26005)(105586002)(6486002)(478600001)(6506007)(81166006)(99286004)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3659;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Hmg+UN3zmfPV1xqjleA4HG3MhtT5jegoYu7zx+c9nIZoQKJnKaaudWNyyMJUv6I8qX6sIERIsAbWC+J7uIf0rb63DFF3VP9PLOXOBIJUUpqpMkkz3IO0Tv2ajUDO3mSAC9+zkmFGjtpuz7aKYHQngAYsaknW3W4wqGok8XwEOnBLxwYfqFZNjMbKsuyoqCmFqdJKsgtqMuB4XRi68wMoYdOiwYw3rOfkJ+aAQ4saCAhfgKWTgWNyx/yLe8YxBJ8JQpBbcho6QVjZcKiPCN22S02hMXeSDWXB5daDobcwyaJqIGUQo8tFueovVVg2tnhsxex8QrK2MTFR7WCdd5TSaJd5VU6I8p1buDIGKR9eaaQmLzfNsJGAXIjfNJTEnnGaS7vFi+660YdKew7c3WRj4xjvWoy9GxXRaGMEZZvOCfI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03dba34-f5cf-4840-8d2b-08d690e742d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 12:40:22.2900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During noirq suspend phase, mailbox MU irq will be masked
but many drivers still need to communicate with system
controller firmware via mailbox, if MU irq is masked, it
will cause RPC timeout as below:

[   23.372103] imx-scu scu: RPC send msg timeout

Setting MU irq to be wakeup source is NOT working as GIC
driver does NOT have .irq_set_wake implemented, so to
support suspend/resume, just make imx mailbox driver NOT
suspend, since MU is always a wakeup source on i.MX platforms
with system controller inside, and its power/clock is
maintained by system controller, mailbox driver no need
to manage them.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 774362a..85fc5b5 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -187,8 +187,8 @@ static int imx_mu_startup(struct mbox_chan *chan)
 		return 0;
 	}
=20
-	ret =3D request_irq(priv->irq, imx_mu_isr, IRQF_SHARED, cp->irq_desc,
-			  chan);
+	ret =3D request_irq(priv->irq, imx_mu_isr, IRQF_SHARED |
+			  IRQF_NO_SUSPEND, cp->irq_desc, chan);
 	if (ret) {
 		dev_err(priv->dev,
 			"Unable to acquire IRQ %d\n", priv->irq);
--=20
2.7.4

