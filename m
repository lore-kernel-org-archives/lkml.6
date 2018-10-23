Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC44C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009112082B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gGOJIRQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009112082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeJWNiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 09:38:50 -0400
Received: from mail-db5eur01on0049.outbound.protection.outlook.com ([104.47.2.49]:10563
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727118AbeJWNiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 09:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpoX+d7UE7xq110gwotcrMbNoi+QwmwQGqzUhkMyUYo=;
 b=gGOJIRQiCDsYgfdA1Ijh1gcibVRqW6GPjh26JnLWmTFHm1ayaQYc4gGx67ZL5EAE6b/YFmBu7l82MOtO0yLyKY1NLPGOpRRK1D5jnHuC3dae6Y1/+2hiG+HU9gogLq77nTKjqxEFCz/yJOIEUrlabBTTNfXsSz/YyA/a/Aqr70o=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4299.eurprd04.prod.outlook.com (52.135.131.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 05:17:03 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%4]) with mapi id 15.20.1250.028; Tue, 23 Oct 2018
 05:17:03 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V1 0/2] can: flexcan: Add CAN self wakeup support
Thread-Topic: [PATCH V1 0/2] can: flexcan: Add CAN self wakeup support
Thread-Index: AQHUao+hBV+z6y4BJkaiocCt+SqC+A==
Date:   Tue, 23 Oct 2018 05:17:02 +0000
Message-ID: <20181023051449.2116-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4299;6:xPXYeAithN2cNmj+vYYxDB49Q0J6ptW2YZ9hK2N3iAvPKTX7JVjccwHnjhZ3cNedkl7zYbrR8R8VB1fyGSONYJsZbnTzOCyiCZ0eBUJXkZr9gtEk01KsWoV9wZE4u2ss5G+4Yj95X7bsDckTW6XKOBufnCQr6CSQg0K+N1HGPJBvJ3xHy9OCZYs5fiMtur2Zf/DFVlaCYgGaV1Am+LFlZyP5sW6OTYUHNuqM1tAILWTkd+pLx3ICP8Btsq+SDLrG4yvGIhjbzEL8QJNJap38pRJF3KyFG/UVNtCH4cntVue7oei09uo3U2xG3snl9hWR/bAvMFI2b+0EpQvwRaUkuvyXPrKgT+t5X/A6mDn9UAag7Tc1DPzRblSUmYq1w+bPLtOEf9BJ5ROLaWbYmnInjJC/4McSdnDV3R76n9TG07xXd8sAzqe13/H6SQEwUz8pvx7+vSGBNDYiMjQ8PCwFdQ==;5:yn/f3teiiwnGN+A8Qh194hrz+SbgFo/TLMHFwvZKJ7B2AbzxUaysHJEsfXz50q0pjujpBgZZBNY7JGTKP1exCyv5bl7br6kfz4fsCp1bK3/O6d61B31+zWz3KlAXrKWq0ACqSdk24NAeB56qm9Mn5tRci9baoUjBi0MmgqdQJm4=;7:GkADkRwAo05eUXuLFkc0M1822zwr8GjJ0vYi1TdJJnSyPXg8+LlJ4oQbQndrFLQyV0pFB82FLByyOefRkbnnhifbEj2c9//QZtWj1Rf0PX+ArzcO3LlTXQJ1I96uxahUGm1hhXvfMhhjxxPfme8G7WzGifkMvJ+0aRe4oE/Z4URwUK4zCVnu/KW+QqBuf7/oqYGO0lIh/MvAfZ/JMqb0cS9+FaGlVP3OhBQn+HKy71HjzLj6TWE3RYxzD7A0GTg1
x-ms-office365-filtering-correlation-id: c9012c67-9b33-428e-83ec-08d638a6c414
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4299;
x-ms-traffictypediagnostic: DB7PR04MB4299:
x-microsoft-antispam-prvs: <DB7PR04MB429911D284940FD7856666CCE6F50@DB7PR04MB4299.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4299;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4299;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(376002)(136003)(396003)(199004)(189003)(486006)(52116002)(6436002)(99286004)(5640700003)(102836004)(6486002)(476003)(26005)(6916009)(186003)(71190400001)(36756003)(106356001)(5250100002)(71200400001)(105586002)(2616005)(5660300001)(3846002)(305945005)(2501003)(2900100001)(7736002)(25786009)(1076002)(4326008)(14454004)(6116002)(97736004)(478600001)(316002)(68736007)(6506007)(66066001)(86362001)(386003)(2351001)(8676002)(81166006)(54906003)(50226002)(6512007)(53936002)(8936002)(256004)(2906002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4299;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QsJ2HBfyGLfxsWCfuFa+nUpQQMkrsMNZOVg8z8rRSs63Ed80KeH+XwI32oWydER/B/a8bbKkGV2hOYn6E4RVy+3y7zlpqRjNvKZug9Oh2LUQczX/FhYhDQiZEtif9DGolKl/IgM2Y4fw54bc0hCWDu2LaGLmRnn26ZXD4crichCGaaVI4L9GnmW5AMoKZuIL1IleFu0KY6Z4L2dsR4a6G/ISrsj6tRacE7nToAjmdLluvOOn4mLAxbiGVDgEQX3M6Ik4rh/JdL22Bb79nQij6/0Mb4DcGQj9NRSPFmTDhErX3FqM2FhuZDQm3lI6AcW++Ra9P1hIiKMLjtL+PkNMl3NaOr3MRHW1OgQAw5+58GQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9012c67-9b33-428e-83ec-08d638a6c414
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 05:17:03.0065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4299
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series intends to add CAN self wakeup support. The CAN
controller can parse stop-mode property from device tree to enable self
wakeup feature.

Dong Aisheng (2):
  can: flexcan: Add self wakeup support
  Documentation: can: flexcan: Add stop-mode property to device tree

 .../bindings/net/can/fsl-flexcan.txt          |   8 +
 drivers/net/can/flexcan.c                     | 141 ++++++++++++++++--
 2 files changed, 140 insertions(+), 9 deletions(-)

--=20
2.17.1

