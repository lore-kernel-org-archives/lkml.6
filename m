Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E0BC5ACCD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DD521523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W1pVzHbL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64DD521523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeJQOGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:06:05 -0400
Received: from mail-eopbgr60040.outbound.protection.outlook.com ([40.107.6.40]:24112
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726663AbeJQOGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nagH/4X26CtrrSYDW6wqSApRiVo2ninpbN2hDXPsEWc=;
 b=W1pVzHbLjvoxf7SkDJrYVjJXyVQNn9Ir+k4VahS3RO7yjcAlwvJJFcQW+Abrd1IgLhebxrr9VHh/AfkMNCwXzISXSdY6A+OPiGKr0Xp95NGapv9ybdrqTs3sR6r9TfGTGt+A+d2shOJzEOOKmImd8ziTw1445+aOd2MFFI+aXZM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3883.eurprd04.prod.outlook.com (52.134.71.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Wed, 17 Oct 2018 06:11:59 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::ddfd:3571:1813:2ee4]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::ddfd:3571:1813:2ee4%3]) with mapi id 15.20.1250.020; Wed, 17 Oct 2018
 06:11:59 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/2] clk: imx: cpu clock should be always critical
Thread-Topic: [PATCH 1/2] clk: imx: cpu clock should be always critical
Thread-Index: AQHUZeBQyTR9MeyjOke3JZ4UgZ2tsA==
Date:   Wed, 17 Oct 2018 06:11:59 +0000
Message-ID: <1539756441-18776-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0023.apcprd03.prod.outlook.com
 (2603:1096:203:2e::35) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3883;6:w4HKpFMJgAWyQg52L7KSRBxPvQjMJZfEeZEAQoX2DRKsXiSv70j9wbzb4XPSoIVRvdTWU09A7WA0TQcAAoG9LSpIBevyCc82qs1LphN+B10FgrBPLC6XCjV0kVe5zrdnUpGTigjYzOudeHD+u8kPTiouSBZJ5SndC2XSNkzLabmHUPDLbSdzh6zBZED0eviv0q+6ZR5yq427xCbPzJ82/Zb+srL4UDCgT2sjywmKhzw1ws/Zc93dppfzCksg+3LlzsDiF+Vm+yyu5LdfgfOTTBL6vzrpK4iIxHnTxXwS1MwTSDHyy7/yNvTe1jIT9N5JsFQFnYbfds4uuZzi0i5ZOuaGXB41NipfB0OuHdytiuUPbS7jLEpKILXUyFy4UIiVtFlqkXcu+npakF22bPM7sdkacA7bb4xQfuejLpHDB0nxqYmRfdXY2fiXEs9ucXN2Op0dxeO8vVZkszKpTzC1OQ==;5:B4D7KewN7CwCa6XksJlLj5d5o2/c03fQ03+oi+XXfcxkCabwo7+YYO9B1MfaTgi/KL7IRBPsodsAjRccmEzUs4ZbgmwGXMeCNpCCiCWKa9MtdFAevYlHdXkxqaC5akU8KnGDF/UpTkfmJ8YSe/WTDbYRFB+RTfkbVMkNkwaCIKU=;7:et+hx9lUuPM8xKARADhuOtwfdemQm/gRItPZiN2RKFQolMkEXeznNzTXuQxcuY16XG9/O37WsmO9c85Qz+SuQ+m/TnPMabpgIWh1AJcslHRbeICS2ocfvVaF4zSlITlfwmx7OMjap516plJE2nPUoqj/gcZ30AqN9xNN/VB7g96a1TRLqdyc8NOnVB6SuwILRMxBm2P5DlVI/rWzMwEvBfMC3lhXhlWJNWYn98mzXSvXPbPRBCUk1V3rmQDEe0hb
x-ms-office365-filtering-correlation-id: b604fbda-f153-4987-a1fb-08d633f7726f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3883;
x-ms-traffictypediagnostic: DB3PR0402MB3883:
x-microsoft-antispam-prvs: <DB3PR0402MB3883DAB4342500450CD24475F5FF0@DB3PR0402MB3883.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991093);SRVR:DB3PR0402MB3883;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3883;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(316002)(106356001)(2900100001)(68736007)(6486002)(6436002)(53936002)(386003)(36756003)(6116002)(102836004)(3846002)(52116002)(6506007)(305945005)(7736002)(50226002)(6512007)(2906002)(8676002)(486006)(66066001)(81156014)(110136005)(105586002)(71190400001)(8936002)(476003)(5660300001)(81166006)(71200400001)(478600001)(14444005)(256004)(14454004)(26005)(2201001)(99286004)(4326008)(97736004)(25786009)(2616005)(5250100002)(2501003)(86362001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3883;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BPUYAjxNwMVkL1Wcb6f46kyb+tnBg9AOpC2fEfAIz4p0lNzxj3xsywSMz+CTYJeD/gb4/i9BmhO8ue/2+qZSST7j6T2kNOyTeFSTst2ryzL8xj3XVCt5rsp3tKCBhCGvRlHCTncnuYyAer9FVPXys70BFLqspA/AAz2oeA0pT5dmX478v2jAhxRsdr3sZ1kmOHGMp+zcr4+j6SUW+7xyTET2KFMpXXBPq7YJzPX0pOIpXzMQOdsJx4OGMus4EtI2SXTWjr0SKdSqbjZWvoaJJ5rEgm0K1MigIcfjSijYdhKKn9904f51M2iENEk/GjGGJ/vdJuYH/oXmgWoWlkZJYwXsVmI6kulDeYE312WqzBo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b604fbda-f153-4987-a1fb-08d633f7726f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 06:11:59.4986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3883
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CLK_IS_CRITICAL flag for cpu clock type to
make cpu clock use count correct, as cpu clock
should be always critical.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-cpu.c b/drivers/clk/imx/clk-cpu.c
index 9d46eac..ed1b7e9 100644
--- a/drivers/clk/imx/clk-cpu.c
+++ b/drivers/clk/imx/clk-cpu.c
@@ -94,7 +94,7 @@ struct clk *imx_clk_cpu(const char *name, const char *par=
ent_name,
=20
 	init.name =3D name;
 	init.ops =3D &clk_cpu_ops;
-	init.flags =3D 0;
+	init.flags =3D CLK_IS_CRITICAL;
 	init.parent_names =3D &parent_name;
 	init.num_parents =3D 1;
=20
--=20
2.7.4

