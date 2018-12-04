Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E26CC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC84320851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fe6qeE79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC84320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeLDLU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:20:28 -0500
Received: from mail-eopbgr140044.outbound.protection.outlook.com ([40.107.14.44]:22553
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727672AbeLDLU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:20:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoE841FJnowX73LZS5XIVWkxzjgp64jXGbxf1NpRBow=;
 b=Fe6qeE79Yrpn9yRmAkpQPT6y4EEwoeCxorQdDG5UxwBsZLfn58FfrwpCRByVyoP0oDx975yYLbzjyBDO9Zwh9ZpGHDxtlvZCGZHmHTbQpVglXCIFPFGq88H7tIiJpEGwTsLzukZa/qT8GzaCwtSdEJWCexpdbrLsk3cZKFkMWQ4=
Received: from AM5PR0402MB2785.eurprd04.prod.outlook.com (10.175.41.15) by
 AM5PR0402MB2721.eurprd04.prod.outlook.com (10.175.40.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 11:20:22 +0000
Received: from AM5PR0402MB2785.eurprd04.prod.outlook.com
 ([fe80::9d72:48b9:59c6:6dfa]) by AM5PR0402MB2785.eurprd04.prod.outlook.com
 ([fe80::9d72:48b9:59c6:6dfa%4]) with mapi id 15.20.1382.020; Tue, 4 Dec 2018
 11:20:22 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Roy Pledge <roy.pledge@nxp.com>,
        Youri Querry <youri.querry_1@nxp.com>,
        Leo Li <leoyang.li@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 0/2] soc: fsl: dpio: cleanup on the remove path
Thread-Topic: [PATCH v2 0/2] soc: fsl: dpio: cleanup on the remove path
Thread-Index: AQHUi8NY/qVDx0R3HU+wg/jBhhsemQ==
Date:   Tue, 4 Dec 2018 11:20:21 +0000
Message-ID: <1543922408-22950-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0135.eurprd07.prod.outlook.com
 (2603:10a6:802:16::22) To AM5PR0402MB2785.eurprd04.prod.outlook.com
 (2603:10a6:203:98::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2721;6:JrdlqMRvRQRzTxH7/d8UmU8bI2jqv0LqUDoVYSXtw2Hbplxou8W75zJINuEzUVdTiBmAmqZP2UkmY4CLvI+KPimq5S0Rhtu+8jalL8xN1Xq0g38BDce6zAqLo/tHctXB5XaNtfjbZ0PswLcmkGTbrLFkWMbxdk07ds7UYx1qHbkDB/0R2MDG6T+T8puCM4YM+YTmr88mOf4lO5+dN7LKgpyKb6TR4WqxtDPAK4GUnWX0TSuJAdH5SC1mZ784y/x172y1kPYP/XoSi4KPOTDPc0JJRrWPlLuEV9hyen0vwAmt87tIqi6DC7nLi6NFt1aMRDfc/brPdpQ0voYIVd3bDp+OnHKZbCi8WIklDB1aBKjeCD0TNchFp+ubcPQSQUkV7nsldeWXyiZ5JXj8A7s07EhYPzq4W3gFdupw42tCPRR/kDSG0Ik9CkenDlTcYsfBHvtR08/ykkF+z7NrL+CvPg==;5:7LsGJm0JyQH8ban1d7Y+lIPUcypTpxEoJqAp/FbnDmta7JwFSq//mARul7bwX00yaO0GqI2JmCJFCoFeh0YJM8ecPSezi/4ozCbT++YtnNyGgoI3gtI9sORIw1KM6WMfS0NUNzrshbNBf+87ztUfYKHr1Dg1VX4Q4XYwmtOxptM=;7:J+2Btbwj91EW6BsTTrn1Zu0B/EIcMDPN9gN4D1duxXXIFYIbMH/69iHiryIYNpPg5BP7dwJQCBChJaXecZIYrcdAaY3toxYGj5SmF2XnpmQdMQHxwhFLwhFS/CD5+p6Bbaon3AI85HrlSRZL0m1o+Q==
x-ms-office365-filtering-correlation-id: 7985a4b1-bf80-46f2-9b29-08d659da7aba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2721;
x-ms-traffictypediagnostic: AM5PR0402MB2721:
x-microsoft-antispam-prvs: <AM5PR0402MB2721E1326F5B8185FBBBAE70E0AF0@AM5PR0402MB2721.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM5PR0402MB2721;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0402MB2721;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(136003)(396003)(199004)(189003)(476003)(5660300001)(71190400001)(102836004)(25786009)(6436002)(52116002)(71200400001)(66066001)(386003)(26005)(7736002)(186003)(68736007)(256004)(6636002)(6486002)(305945005)(99286004)(14454004)(6506007)(110136005)(54906003)(106356001)(105586002)(97736004)(486006)(53936002)(478600001)(44832011)(6512007)(6116002)(2616005)(36756003)(4326008)(8676002)(81156014)(3846002)(8936002)(316002)(81166006)(86362001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2721;H:AM5PR0402MB2785.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MtlD0TNeaj4BaMtmFxCl/DSeFuuMGpB0uSuxq9dyGQIB6LXUbiyzUqkE/J00dVwsrTo+tdii/GU0D6Q29tBw/hn3L5CAE2EVDTPNIjGNzNEiLIl5fQZOpWPAnD6YT8cB/Q47eavuU5djpNSKUDVUR9kDcQYmA6WEDBrqM+bH5+F4zbIVqlcoaxJ8V4iDBGcbDwVeqh1lrw+zobYsHWbISo8gkyZ+MDqW32vsCoDDrZ8650dsDJw1L114wk7nTEoImUhqeJllDvkSnJW0KKin3QQasWeYEApULIfa4zb/DwX+BkkFWXy9tjc+sFUmIe6fOplvYZp/yaBxknKATwShfhN05F1nIwd8QJ7huQVYnAU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7985a4b1-bf80-46f2-9b29-08d659da7aba
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 11:20:22.0499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series cleans up the remove path in the dpio driver so that
successive bind/unbind commands behave properly.

Changes in v2:
  - added kernel-doc comment to the dpaa2_io_get_cpu function

Ioana Ciornei (2):
  soc: fsl: dpio: cleanup the cpu array on dpaa2_io_down
  soc: fsl: dpio: use a cpumask to identify which cpus are unused

 drivers/soc/fsl/dpio/dpio-driver.c  | 25 ++++++++++++++++---------
 drivers/soc/fsl/dpio/dpio-service.c | 18 ++++++++++++++++++
 include/soc/fsl/dpaa2-io.h          |  2 ++
 3 files changed, 36 insertions(+), 9 deletions(-)

--=20
1.9.1

