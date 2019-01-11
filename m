Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3D0C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D21D20870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wf8OhXML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfAKHJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 02:09:08 -0500
Received: from mail-eopbgr70044.outbound.protection.outlook.com ([40.107.7.44]:4185
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728513AbfAKHJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 02:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmN4ykcmcj1KdQe/6K8EcfUQh+r4Ni+4Sm98nsm4fJs=;
 b=wf8OhXMLcXuViZ0HcmObx2NjqPlbmQvjeLq9NcT+XNLeatDf6rAUzs7cnor+so5ryfMiL/yZgs+QcbMJ4/eZ/dbEu6iO8q7z474vPZcwGtaHb1x5F6/VzlCSMd+AjSji/IT7kYlmLRty+JJb+svPeZyeW7SMPSBJ7PV9JUIXMZc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3673.eurprd04.prod.outlook.com (52.134.70.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Fri, 11 Jan 2019 07:09:03 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97%6]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 07:09:03 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] rtc: snvs: make sure clock is enabled for interrupt handle
Thread-Topic: [PATCH] rtc: snvs: make sure clock is enabled for interrupt
 handle
Thread-Index: AQHUqXyIz6U11eu4LkGyuJrswoDOgw==
Date:   Fri, 11 Jan 2019 07:09:02 +0000
Message-ID: <1547190255-9388-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0057.apcprd03.prod.outlook.com
 (2603:1096:203:52::21) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3673;6:H3IA8h2ETpgK7cMiRJCZwkYtx1lPIOemDzEKLMTxLmeQwA49xZ3pakUy6jIyh9pYPIZNyaF8d5qvxQe5lEl9XuijES29uR7TLBc+l/wWRnupjEqaWjKdcNJHW3nnlsx2HKzdKp7zEhUoVGg6WTy5KGHDt8Zh8I9pRqv+BVJRNrE95tNv1H8mAd7JJyAmlvp1hJv1WFoPOW+j/8VPKEFElK2NcMBf8M5q72ctABr2lbMPSWP6JvxVlGqlTJzGc9rkyt2A0RmHPxP3rN7jnqLScgb/fWi61enIEgJIwLqYPBSlwQQAQ3h7hxE80xW/MM+SFK68q/sjd6/i9h1WDMvJurXw6Nim91sdH2jH68Ob40F4lr8gmAKFggPGhFXj5KPQkaUUrkrTIlCwLOQv2N8IdBrv6Cyt07Tcvzg/lIky50QTZgk6hLK8apQ9yxnOOZ880GzbjrMni851M2azinwlgQ==;5:TAAvDonvP0SS2NCae6QMxUtgSGAfjxM8uizITkRVz7Aw8952nYn02A+Ct6rISbUEGDRawYt2u4fegtWSHcoDThpvAQaj+JluZx6muFw13CfphbN1oYoKGI1MnPdg+MSeDBJuXebSnoH/VJ/NeWvaR2drp601XnvvwmYr5+4kDQSE8RyurFJ0coQhlqhDFyAfQzOgevatOLCdKPY5fh01Bg==;7:UCha1EVM3IdWBlPv6/iQiFUysBbwPCgzXf9Y0IqNtdOopcz2klhvakhIP9xXuAUatXxemR1xGg2j4gusU39IKRTh2/FjxZUViGkNnU1ofUoV2wkcvHYags8zkibHOyScQwY3SQCpLV9pSs4BeB1Xnw==
x-ms-office365-filtering-correlation-id: b7fa8267-d475-4865-ea7c-08d67793aa85
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3673;
x-ms-traffictypediagnostic: DB3PR0402MB3673:
x-microsoft-antispam-prvs: <DB3PR0402MB36739C6CA270D21249A79050F5850@DB3PR0402MB3673.eurprd04.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(376002)(366004)(189003)(199004)(2616005)(5660300001)(66066001)(8936002)(476003)(50226002)(97736004)(25786009)(68736007)(6116002)(3846002)(110136005)(2906002)(7736002)(105586002)(81166006)(106356001)(81156014)(8676002)(2201001)(2501003)(53936002)(6506007)(316002)(386003)(6486002)(478600001)(52116002)(486006)(102836004)(36756003)(26005)(99286004)(4326008)(186003)(305945005)(86362001)(71190400001)(6436002)(71200400001)(6512007)(14444005)(14454004)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3673;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x8aYWUApr/nTFCJ+52qOXJBE5XoyXAqIAb6w3uOxYoRv33z/zuWEj/MmF9SCj7oY8Y+lX07o/+6TSk+4w9dQmE3eZXjol5K8aL2gMQQkRxUKlW1khfX7viSuudTA/sxqQmGGa/3rUUd8lJ6Et33jxN8tFsHMe1RxFml278CLakiix9YNazZ4nGNjFmsP4zs0qISODcZ6zjbjmc4V6KbnhrX7gAMYKiV5KVhcUR3rux8UpwGrhYOvJfzPoN/kZGVxu5oGUVWUNojbOE1IRO2mrcG+LlD8NKjymhqMf4y6LgUFF8V46w5tIanzCUaHdaLNqauCnLx3KfyoIZJgKL8tvcEj5RMrtXaLo2XfSj1LcdDAZn3Qt0go3jIeUncslMubsQHfLHoVkIiGpSjpVtG0umoEPTiY+8ExOE2HeLBchBY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fa8267-d475-4865-ea7c-08d67793aa85
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 07:09:00.2749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During system suspend, the SNVS RTC's clock will be disabled in
noirq suspend phase, but SNVS RTC's alarm interrupt could still
arrive, system will hang if SNVS RTC driver tries to access register
without clock enabled, this patch fixes the issue of this scenario.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/rtc/rtc-snvs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index b2483a7..0b9eff1 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -239,6 +239,9 @@ static irqreturn_t snvs_rtc_irq_handler(int irq, void *=
dev_id)
 	u32 lpsr;
 	u32 events =3D 0;
=20
+	if (data->clk)
+		clk_enable(data->clk);
+
 	regmap_read(data->regmap, data->offset + SNVS_LPSR, &lpsr);
=20
 	if (lpsr & SNVS_LPSR_LPTA) {
@@ -253,6 +256,9 @@ static irqreturn_t snvs_rtc_irq_handler(int irq, void *=
dev_id)
 	/* clear interrupt status */
 	regmap_write(data->regmap, data->offset + SNVS_LPSR, lpsr);
=20
+	if (data->clk)
+		clk_disable(data->clk);
+
 	return events ? IRQ_HANDLED : IRQ_NONE;
 }
=20
--=20
2.7.4

