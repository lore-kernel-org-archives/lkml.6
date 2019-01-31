Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A87C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25362218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d/KY4bam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbfAaJh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:37:29 -0500
Received: from mail-eopbgr20089.outbound.protection.outlook.com ([40.107.2.89]:19040
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726440AbfAaJh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/v/Oo1l/kQZWWk48nOkAYoWoqdNGsBo2pitDU8QavEE=;
 b=d/KY4bamWCkMt4HkkCRFgiX1PAGbB4fOWYUV7sj+j0Z1266h9ubvQo/I1WgdB0inPvJX+iLVg9l6a3zwWfUFOXBK2r2rZ5yfodl2O2o333PScnkjzyUssLFB1WicNV9FRb/S2BIFqaWRD81PA6TxwOO4pvUpJWp/yR/Y1SNqRCw=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4619.eurprd04.prod.outlook.com (52.135.138.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Thu, 31 Jan 2019 09:37:22 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::d4eb:ad3a:a610:c181]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::d4eb:ad3a:a610:c181%4]) with mapi id 15.20.1580.018; Thu, 31 Jan 2019
 09:37:22 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH] can: flexcan: fix timeout when set small bitrate
Thread-Topic: [PATCH] can: flexcan: fix timeout when set small bitrate
Thread-Index: AQHUuUiQ4yWIPYpxOkiOxPx7F+znng==
Date:   Thu, 31 Jan 2019 09:37:22 +0000
Message-ID: <20190131093509.12613-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR04CA0132.apcprd04.prod.outlook.com
 (2603:1096:3:16::16) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4619;6:altorR17A3SSJmWfTB4GU+IRcg9z0ofH6gWNZqYprDyStP687nsR5OHhlr2dR7A2d4S3x+glvFeRGV89KGPbar58JE/Nm/JF7wuxzZgN/Kw2U8W8vvW3ctfor/hlfZRc8t9YthRGONWYqECJKsjPVRDH8HQQCgzutPTeSRdrvhk0/r2SvYDHOVnwbe1z7HIyAo35COUIe9azBZ7EZuOnbc9Ar3r4ajWqHhge5Yt1yx1frfO5wtyvF9LzLOuDovDsK7fl/xiS/478NbEiVAquUxN4dFAaBHVrEMsfsrg+xxRu5leQtbXtEgFqJCR6nbCCuMpW/4bcK1sDaTxesudiWyDAoGKs7Yk/fYP6vvJ9RgpM/jQJMp7XTM59Y/YV0Cjsy4/FavlQepV7h5/HHelrlmgyL3MrCxJKUU/P0t0K8/BENfcO5N1tFq/IoFILVZLeLt1JkYFkH2iL4o+Z9xP/AQ==;5:LpcYeGNGcLRRFJagA+Eemg4TRPQEAhb0VfUNUiph1jxssVp0AKV9nAzIFoLtQjT+NSWxy9heolqz3Yn6p+6hn5MeFAGcSBEiOl87OYp3l7ZqRVO9iOmWTY24W4YQzzGaNBGjWtcb79k7uRggNPyTGYT6D7G8lgfOKaFDJkmuv3Qidqk1gIBqtmNA3WH4AaHw7/JK0c7ez4LTs0mwtGNniA==;7:RHQh8giR36LdxSeLAr1UWJjff56yMvPr7kwpNAT3y6vL5tvegRqV6IrAvVC1rc/xZ3GFfd3sQb5c3FPXXsYLQCjAdL/0LiPUqoBaSVHuAXS4agsyFu16QGW0MGaD5HfYnJYzdXLINyEPmoDFTDqn/g==
x-ms-office365-filtering-correlation-id: 68a873d2-6df3-46c7-2775-08d6875fb305
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4619;
x-ms-traffictypediagnostic: DB7PR04MB4619:
x-microsoft-antispam-prvs: <DB7PR04MB4619081875508D955BFDBFAFE6910@DB7PR04MB4619.eurprd04.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(346002)(39860400002)(396003)(189003)(45904002)(199004)(6506007)(2616005)(7736002)(53936002)(8936002)(68736007)(2501003)(66066001)(102836004)(14444005)(25786009)(26005)(386003)(305945005)(256004)(54906003)(4326008)(50226002)(8676002)(476003)(99286004)(81156014)(186003)(110136005)(81166006)(316002)(486006)(97736004)(6116002)(86362001)(3846002)(478600001)(6436002)(52116002)(14454004)(2906002)(36756003)(6512007)(71190400001)(106356001)(71200400001)(105586002)(1076003)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4619;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EeBwwwg+dHdN5PDjv2G+XGwEjzzBj29gjaiofg+dDONZhUjU8kiyx7d/tct0tNzH/k2AEim08RyPOdM6NEKY30i/MdlY/2zXIfWMEGWIodUfh3RJsWwTDHZIMR4thl8haHbsYc6GTrLScrcWkoyUNBXYuTCirJwOYKst8qQrbLDyEgHwf3yGNt6TxsSqnX2+35sSdmlVcXGkJcQXEnnPz5H4KN8ivb75q1W2DpdG1kF5uIiECRc+nY7WLOsTYOeMBmryAt0eibzMYpSzdEKkKYycuqM1/fxKGCUB+09QYCPjZ+gGN0W013Isx0LhCkBQfPySprzSflUq/MMhICqm57PJDtlvTYjlb/bg1J/+fbxo/7vrgZP8gczYSkwRycCz7Ld7avXY+1l52UYlCv/lnYJNJMn4c1r8KTdRNMWSbiw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a873d2-6df3-46c7-2775-08d6875fb305
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 09:37:18.9608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4619
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current we can meet timeout issue when setting a small bitrate like 10000
as follows on i.MX6UL EVK board (ipg clock =3D 66MHZ, per clock =3D 30MHZ):
root@imx6ul7d:~# ip link set can0 up type can bitrate 10000
A link change request failed with some changes committed already.
Interface can0 may have been left with an inconsistent configuration, pleas=
e check.
RTNETLINK answers: Connection timed out

It is caused by calling of flexcan_chip_unfreeze() timeout.

Originally the code is using usleep_range(10, 20) for unfreeze operation,
but the patch (8badd65 can: flexcan: avoid calling usleep_range from interr=
upt
context) changed it into udelay(10) which is only a half delay of before,
there're also some other delay changes.

After double to FLEXCAN_TIMEOUT_US to 100 can fix the issue.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 2bca867bcfaa..1f2b4db7da88 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -166,7 +166,7 @@
 #define FLEXCAN_MB_CNT_LENGTH(x)	(((x) & 0xf) << 16)
 #define FLEXCAN_MB_CNT_TIMESTAMP(x)	((x) & 0xffff)
=20
-#define FLEXCAN_TIMEOUT_US		(50)
+#define FLEXCAN_TIMEOUT_US		(100)
=20
 /* FLEXCAN hardware feature flags
  *
--=20
2.17.1

