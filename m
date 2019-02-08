Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFD7C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D934820844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netmodule.onmicrosoft.com header.i=@netmodule.onmicrosoft.com header.b="h3RoH+Nb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfBHNbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:31:04 -0500
Received: from mail-eopbgr00130.outbound.protection.outlook.com ([40.107.0.130]:31664
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726568AbfBHNbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:31:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netmodule.onmicrosoft.com; s=selector1-netmodule-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DXu2ip/OjtWRlxDcYFlFZg+Qtb93zqm6q1bgfJtr/o=;
 b=h3RoH+Nbb3kmC7z1Z4jDgEhztwSs4quqQjX48rDR7pPD3WbZHfetwH2p1FwWVgjIClQN42yN4Jvym3MgOKprkC/CWUfScqusmPLA9LcGzeOrxODITfvCeMA0SxAwFUty7oWFPv5CanD0+JMJmDSUgYJN53+xreRchQZxBrH9My8=
Received: from AM0PR06MB4419.eurprd06.prod.outlook.com (20.176.214.91) by
 AM0PR06MB4148.eurprd06.prod.outlook.com (52.135.149.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Fri, 8 Feb 2019 13:31:00 +0000
Received: from AM0PR06MB4419.eurprd06.prod.outlook.com
 ([fe80::df9:4308:d40a:e0f9]) by AM0PR06MB4419.eurprd06.prod.outlook.com
 ([fe80::df9:4308:d40a:e0f9%5]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 13:31:00 +0000
From:   Andrejs Cainikovs <Andrejs.Cainikovs@netmodule.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Patrick Zysset <Patrick.Zysset@netmodule.com>
Subject: [PATCH 0/2] D_CAN RX buffer size improvements
Thread-Topic: [PATCH 0/2] D_CAN RX buffer size improvements
Thread-Index: AQHUv7KHnaxRQxxv60a1wrC1lXXQfQ==
Date:   Fri, 8 Feb 2019 13:31:00 +0000
Message-ID: <20190208132954.28166-1-andrejs.cainikovs@netmodule.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P194CA0007.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:be::17) To AM0PR06MB4419.eurprd06.prod.outlook.com
 (2603:10a6:208:bf::27)
x-mailer: git-send-email 2.11.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrejs.Cainikovs@netmodule.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.130.140.44]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR06MB4148;6:JEh4LGuqczt9m1xRFT+CrsyoJS59TKa5sEJ13+Te72V84lFMg14DlUyNIiLotpy0XFcl8as/pEHtVg2ZItFl/mMzsmE3GR3wwE331azQXQKb+zSuq5DHfvf6tL+Xmqhf0m3KmeK4R2ITmirysED2GZ2hrddXrIdL4mQznPByhyWUUb15FrC5G5Sx4m72QiiQS5faBbySvdNrfMdlUgxT/2sjQ83K0Re/22ocdm8lSH8txCmbgTrDC6qS5gOiZjLxHjxZ658VzyzqIDB0IQUJlbIJ/hV7+ueyOvWQBtw2U8Hzp5ME1+vx5+EX7QdS2OWW9eYBLjYQpnu+W5GcYI0FXjJZ/XiVi4S23DecCRrML2o79gr0TIic04tIMA+JSVR8ZhEdHsyfTPImE/p61Og6qQ30W0fr6IM0ClaojnF2dSJz75KN8y97IprIcN0nfKsTpDkOr6sMcIl6h8OWAa6Wvw==;5:qiULpl3fb3M55bFF1fbcszA7QcV+4XLdW2a8qud0d0yuwVzQWYKJ1tr/5KjW0zTYtmGf7bR4pGi58uVrV5bJ10AtM3rTA/UiOkZzxywCnQZ5IX8jgUCXViBBnsPDq6ZoRxyJhPNqNDkNCrO3mo672F6kRrJh29lBYKcZR4gDSi0Ti4CqfSdDIWT0hBZcTxBN1FleHFNfaGjoMtL67SeaAg==;7:G51ChpNxJcte3TB/mLU8/QSBSV/zelbOTSlLcVwatXEkR/2sEk5vRj5sV2+r3//xS+qu/TAcWXV9whNjyoxAoX+kaZGbr7r4SLGgqgc7Guef60ZOLmfRS1O/icP/aUKtoi0mhwB/vJIflf/crxbsEA==
x-ms-office365-filtering-correlation-id: 4cec5b93-d62b-4e1e-0d5f-08d68dc9a9f4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:AM0PR06MB4148;
x-ms-traffictypediagnostic: AM0PR06MB4148:
x-microsoft-antispam-prvs: <AM0PR06MB41489C43095ACD01E6DC4376F6690@AM0PR06MB4148.eurprd06.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(136003)(39840400004)(366004)(199004)(189003)(52116002)(2616005)(81156014)(36756003)(99286004)(6486002)(107886003)(316002)(68736007)(53936002)(110136005)(305945005)(476003)(7736002)(50226002)(86362001)(8936002)(486006)(6436002)(81166006)(1076003)(44832011)(71190400001)(71200400001)(2201001)(97736004)(8676002)(186003)(26005)(6512007)(386003)(4326008)(3846002)(2906002)(6506007)(106356001)(105586002)(102836004)(2501003)(14454004)(6116002)(256004)(25786009)(72206003)(66066001)(508600001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR06MB4148;H:AM0PR06MB4419.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netmodule.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qa3Sl1WBgvoEEn/39nWwU4OPFmuRYAKBe1hH0RYjLlms5Z9+prNca9X3SGeFCqdghzHay06KZpbWFNsS9Kj9wC8A4jwZfiBi8v8lamJfjUDp1RWegz/XEhIbxFxHGBb9OWoR9PrW+m6rwrckrgBkM//z7j8YcjQUs2kQOUrwXNFpDam/8+Xl9cX4J/Yyi1MYiekblL4qehkBVPKPpbAF2lD71fdb6Zox+ZTWlLHEE5sFmQPNieqAUyPAdveAmu/9IPW4jadVc1thpPQdMXYzVllEPavgIJtvesuEHWFX+VDhFVn7Dlz8NCZDcxi/BAmAlKBEcPHcLy8pZ5cBe9guHawbTKE1bqioZOt6UwbwFPHJ6muYuMkWoHAaRKuhg2xtxVg3pAFYLftaZLy6RYzywNiUYqtg8dR/DDLb65dJQ2o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netmodule.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cec5b93-d62b-4e1e-0d5f-08d68dc9a9f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 13:30:59.4397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: dcdfa962-340b-405e-be0c-5bfcc8a0841e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB4148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-sending entire patchset due to missed cover letter, sorry.

This patchset introduces support for 64 D_CAN message objects with an optio=
n of
unequal split between RX/TX.

The rationale behind this is that there are lots of frame loss on higher bu=
s
speeds. Below are test results from my custom Sitara AM3352 based board:

  Sender: timeout 15m cangen can0 -g 0 -i x
  Target: candump can0,0~0,#FFFFFFFF -td -c -d -e

  * Without patches:
    - 15 minute RX test, 500kbps
    - 16 RX / 16 TX message objects
    - 77 received frames lost out of 4649415

  * With patches applied:
    - 15 hours RX test, 500kbps
    - 56 RX / 8 TX message objects
    - 41 received frames lost out of 279303376

Please note, I do not have ability to test pure C_CAN, so it is left untest=
ed.

---

Andrejs Cainikovs (2):
  can: c_can: support 64 message objects for D_CAN
  can: c_can: configurable amount of D_CAN RX objects

 drivers/net/can/c_can/Kconfig | 20 ++++++++++
 drivers/net/can/c_can/c_can.c | 93 +++++++++++++++++++++++++++------------=
----
 drivers/net/can/c_can/c_can.h | 20 +++++++---
 3 files changed, 94 insertions(+), 39 deletions(-)

---
2.11.0

