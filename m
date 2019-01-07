Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3709C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FD9204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AxBwnpcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfAGHrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:47:37 -0500
Received: from mail-eopbgr10075.outbound.protection.outlook.com ([40.107.1.75]:33397
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726441AbfAGHrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 02:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skznDClZ6ggI5dksGE7YufWrLyy98zU7k5lNQB3Qig0=;
 b=AxBwnpcmF5BUEWI15L5WBm6SRMUt0gJ9e8QsLzjIkkBZ6Y+Fy2dmoHUjNN34e1zh2WhBjHQff6Xydh8NM8EMpyRuz6RxNb6YIM5S3cYcihamLZ8pavJxyQdBFlwRljx238a3cJNz+pT4/Ly4Xjdq3NNqhvtiggq9lCcgiA1R+AM=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB5333.eurprd04.prod.outlook.com (52.135.169.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 07:47:32 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::7c57:c2f3:1681:3fc4]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::7c57:c2f3:1681:3fc4%6]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 07:47:32 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH 0/8] spi: lpspi: Fix bugs and Add some functions support
Thread-Topic: [PATCH 0/8] spi: lpspi: Fix bugs and Add some functions support
Thread-Index: AQHUpl0/GhBPmLcLhkKhs0spWEeNvA==
Date:   Mon, 7 Jan 2019 07:47:32 +0000
Message-ID: <20190107074639.6336-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0087.apcprd02.prod.outlook.com
 (2603:1096:4:90::27) To AM6PR04MB5016.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5333;6:XXXeBKRJMYbV7H9nvJpiaxG07qtPYHHraLLzuprEJDZVQIMyFOvZ28+lJT+Z9OumqahILZLqmeGrCSJ3A5/Tpu9nLKtu5wGdrUWaqe0DwvxOa/yT+nJ6M94cZoDq8UpWrv19Z0x4R4129H3/f9k8n8WFBMnVI4FqaTGlDmQJdOxQ+DqMh4YQTPR/74PLEmS0E3b+QKOoVNwvd1tD7dbp5/98+AChVNjjyMIGzfbqcTwmqXuiEfBQsRu2SBEuDoVb/B0M+uqEy1y9mEKfQdYXwRp6SmhZ0jUau600FxuvfDmi84//8rclmwTHSfe7yr4nkSAivg5jeizTtDRSZOU6gr/FVH1Wfc4cyByMwkmOfISpHV7xreDxFkOxkFYPgcE7IUO0IWNDgdxw1BXAHR2CbXVr0HvtyTKKt+j871mJ5JC7f+7sO11u878ey1/5poVft86QF87QgUa/Q94Hx3C7Zg==;5:c4c1/5xqAkeldVpXeySeZopuiL9VZKdq3vkc4C6pB6FzZQZQ7aNswMmm0P5kRVboUS1ycbK/XQIID/fRGywoV8fW1H+AiWrBeKnsTnFqKdiMVAiFnCykGW3m86N2r65pD5bueNyx2nMYIqBFou3LjBixnPFqh3GsoZxuB+i8YeUchSupWXchXjK7hXEyigkuMxwRJx13CSupBm29X5Zl4A==;7:3V2IQZMNS7mqTQilPclQ54xnNPkCc2910WT6Nc17hKG1gyeetRkvUpFx6g+Tst/vJsLKhOoZscYFr9AFhbgKkSFDswSvTVPc8q7bqQ9+h71ptWR9Rh1ZVh/K2MpXLsv36e6nPjYQtoWV+HARJTH17w==
x-ms-office365-filtering-correlation-id: 7a6171d6-009b-40e4-fd82-08d674746160
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5333;
x-ms-traffictypediagnostic: AM6PR04MB5333:
x-microsoft-antispam-prvs: <AM6PR04MB5333E51E8757864F2664A0FFF3890@AM6PR04MB5333.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5333;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5333;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(366004)(376002)(199004)(189003)(6116002)(3846002)(97736004)(53936002)(6486002)(2501003)(1076003)(4326008)(68736007)(25786009)(66066001)(86362001)(71190400001)(6916009)(6436002)(14444005)(2906002)(256004)(5660300001)(186003)(99286004)(2616005)(486006)(478600001)(305945005)(81156014)(476003)(7736002)(14454004)(71200400001)(5640700003)(81166006)(1730700003)(8676002)(8936002)(50226002)(6512007)(36756003)(2351001)(26005)(316002)(54906003)(386003)(6506007)(106356001)(105586002)(52116002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5333;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rZly0P68DNTlO9z9Oy/rK0t3rbIRWZdkKoCIKN8b80ZjPFVnIuvBLj6H1wwql23gqBBE+lppvjCyzp7mQ6yN1roRpFxeJDv1D03vuOs185R0ebe6JMkeLwVKIt0wstSqb79Z0gg6cE3xT17fdl9Z44pzt1fvNC1zVJCRKnsgUdS24Q2IwEjZ7mromq4h9dR4OCDOTDDcvJ+HYfDGJ3bsAwLdUmIOt819sPqPYOEioh/Nqg5+E7dJohuvGzXjFOsofniQa3EVd8gOEBPyQN6PpW9WZQMTk9RtA2DaWFFYYqGf7k5nuv58xChBdC0C+p6J
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6171d6-009b-40e4-fd82-08d674746160
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 07:47:30.2107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5333
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

As subject, these fucntions support, including:
 - Support i.MX8 series boards;
 - Support cs-gpio fucntion;
 - Support DMA mode for both master and salve mode.

From patch 3 to 6 are some bug-fix for PIO mode. In order to avoid data los=
s
and improve data transmission stability.

These are some notes about cs-gpio and DMA:
 - cs-gpio:
   Because LPSPI driver don't use default implementation of
   transfer_one_message(), I do the cs-gpio control way as same as the way
   used in spi core;

 - DMA:
   Any frame length longer than half txfifosize will be sent by DMA mode.
   For now, there are some limits:
      1. The maximum transfer speed in master mode depends on the slave dev=
ice,
         at least 40MHz on i.MX8 series (tested by spi-nor on 8qm-lpddr4-ar=
m2
         base board);
      2. The maximum transfer speed in slave mode is 15MHz(i.MX7ULP),
         22MHz(i.MX8 series).

Clark Wang (8):
  spi: lpspi: Add i.MX8 boards support for lpspi
  spi: lpspi: enable runtime pm for lpspi
  spi: lpspi: Improve the stability of lpspi data transmission
  spi: lpspi: Fix wrong transmission when don't use CONT
  spi: lpspi: Fix CLK pin becomes low before one transfer
  spi: lpspi: add the error info of transfer speed setting
  spi: lpspi: Add cs-gpio support
  spi: lpspi: add dma mode support

 drivers/spi/spi-fsl-lpspi.c | 612 ++++++++++++++++++++++++++++++++----
 1 file changed, 552 insertions(+), 60 deletions(-)

--=20
2.17.1

