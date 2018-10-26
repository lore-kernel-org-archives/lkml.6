Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4526EC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CD42085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pxhT7RGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CD42085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbeJZRgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:36:47 -0400
Received: from mail-eopbgr00089.outbound.protection.outlook.com ([40.107.0.89]:27067
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbeJZRgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCGRzNxBZbVWJMNcTlpN99yagNyKH0MfB7FVfIPX7GU=;
 b=pxhT7RGhDw26N3Wfk05WouBewqXh3hIoCIQ1CTAMrgDWxLBCqt16lBqL80ONeTpcRtaXS+anailxszMIfjc/dfYPuicYQDyIs/PGBSgOauns9qvqECKlkx0mz8MXgaznzFQ9fkGwsCika8AvQ1Ng8zRjpbsGR6gbVvl77T12ie4=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5322.eurprd04.prod.outlook.com (20.176.236.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Fri, 26 Oct 2018 09:00:31 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%5]) with mapi id 15.20.1273.025; Fri, 26 Oct 2018
 09:00:31 +0000
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
Subject: [PATCH V2 0/2] can: flexcan: Add CAN self wakeup support
Thread-Topic: [PATCH V2 0/2] can: flexcan: Add CAN self wakeup support
Thread-Index: AQHUbQpZeIhAKgynT0W0/oOzlaW5iw==
Date:   Fri, 26 Oct 2018 09:00:31 +0000
Message-ID: <20181026085814.23370-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR04CA0144.apcprd04.prod.outlook.com
 (2603:1096:3:16::28) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5322;6:Fv+9aFmppBcqlwHkFkCN9kusxqEFIvYEhZRRAxnFGhkQ7WzWnsHmyDN7kO9ZRcOl2w26TAAcRFO1X+zSWVvzHyLUsZVnnEEcsEXYlsAjDlt9J7z8zjFl8ga+umUmhiLpLzOfGr0NmzkI66P1tf1xM1Y/0SdzXCUIHAvEvA2KpfqB573UNGnvPIBw2MOPuoiAji3RBIUu/1/S7pTU5NqddDw+uZJyhNv7466dBP2//nthCtTgPzoIwubw2zFxHdSnwmWLuY99f0srpkbNQdf/K0qr38Oaujy7/c6eIVUQ+s3rvDtrzSebz0zR/jVwHx6ii7s59X35dpFFMfH9+CxbqvqOiAt8qI5S+kMFB70BeRsPm31b2j7Oj+Tnb1jGRnxTsi8x2pEA/bKiR55f016akSsXK1gjC6lolTU0nnwcInywcefsVWBZNAOKEUeOlZANvrx8a+dZMOs53gazZGW7xA==;5:GTx0NBt+kih3SrNrY46XtObW8t21juF+0xZPvAYjzp7OlUIqP8b9P1a28tr+/iVmZh3M1q1ay6rdic6uyET63Zgm0gpciw4BIhlPhayHFRQW45CdHKaW8hW+bp6w9oLrUhqsKNqhsf3Gd1grNbsj2nWgtJxaONgNgv0U+gOYv68=;7:m8G9xArik+ThMCdpdFwxZzix0x6l+wub3CCCO/itOnoT8OBKJMrlqkpXtkOZFQjJ7FTC6ObTuLnp9diaSC2xp3yudOFCq4X5Sx1N8KzkjP7qJ8CNtmvckKM+xe3JEUDACCqjLsuDybfg9PvCVwJeyQ==
x-ms-office365-filtering-correlation-id: fea08042-1303-454c-c8d3-08d63b217b34
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5322;
x-ms-traffictypediagnostic: DB7PR04MB5322:
x-microsoft-antispam-prvs: <DB7PR04MB5322DD811FE4086C90118AD8E6F00@DB7PR04MB5322.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5322;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5322;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(396003)(366004)(136003)(346002)(376002)(189003)(54534003)(199004)(6916009)(5660300001)(14454004)(6512007)(478600001)(53936002)(97736004)(106356001)(186003)(2900100001)(36756003)(2501003)(2351001)(5250100002)(54906003)(316002)(66066001)(71190400001)(71200400001)(105586002)(102836004)(1076002)(25786009)(256004)(4326008)(305945005)(26005)(5640700003)(2616005)(6486002)(7736002)(3846002)(8936002)(6116002)(86362001)(99286004)(486006)(52116002)(6506007)(8676002)(386003)(68736007)(6436002)(2906002)(50226002)(81156014)(81166006)(476003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5322;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KOgTcAg8K+q5z/UetUWJTYOGAQp59XsIVp5oHsPY7y1IEqxaT0725xLLmXASr3/ekF2rKO80msGFl9098tsx52LVLwC/vCM5xcflGmns5pzWi4ekHrEiFhooIjNiIt6ToohyXdX+RM1HjZwXlREEQxTGZyieCU1NeOFIzTbq4AWCIRBzBi9ZeyN5Rvwku1eG3h2HRbgHO/FIP5ExHCv+gfvdCU7BoLOGbhk8VLLHA51qdYnlSJrA2qZk92nxx16G4aNguSCYsVQ0+42HL63lxyDZeGY0Wh+RuOQqGkYv6qbUVSJw0F3rd3+hvJrC9VE7HFagm1kVW9Zp20V5Jy/6xojuVp7pgt+S2KZzlnBCiUw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea08042-1303-454c-c8d3-08d63b217b34
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 09:00:31.1884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5322
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series intends to add CAN self wakeup support. The CAN
controller can parse stop mode property from device tree to enable self
wakeup feature.

ChangeLog:
V1->V2:
	*add a vendor prefix in property (stop-mode -> fsl,stop-mode).

Dong Aisheng (2):
  can: flexcan: Add self wakeup support
  Documentation: can: flexcan: Add stop mode property to device tree

 .../bindings/net/can/fsl-flexcan.txt          |   8 +
 drivers/net/can/flexcan.c                     | 141 ++++++++++++++++--
 2 files changed, 140 insertions(+), 9 deletions(-)

--=20
2.17.1

