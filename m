Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901C7ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3426E208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="odihc4tU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3426E208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbeIQIrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:47:33 -0400
Received: from mail-eopbgr710093.outbound.protection.outlook.com ([40.107.71.93]:31768
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729402AbeIQI3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybgW06LDwC/9T5uMw8D9iRkIYddxOpXn7dwIYxxuHvg=;
 b=odihc4tUzaHsIB7Kyya7aGRtqyby+WNRFpsIUESf+rPar8xtJ3LukdZTofcnjUj1BUJW0a/NqzaqPVSAei9p+EExwXFdPkqp2K5FKCQkh1zYh5aNILC9pjO13LIFO3JqFq17tjKNYDr3l5fmMNCF7xRUrXXNpwPa9SA/is7ndLk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 47/87] mtd: rawnand: atmel: add module param to
 avoid using dma
Thread-Topic: [PATCH AUTOSEL 4.14 47/87] mtd: rawnand: atmel: add module param
 to avoid using dma
Thread-Index: AQHUTjLs73vCDCsu2ki/c3QwG11A+Q==
Date:   Mon, 17 Sep 2018 03:02:52 +0000
Message-ID: <20180917030220.245686-47-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0776;6:n6oi+J0R+Vw/K3+ZOTC9UwNuB3UuCYxzTC+Pc54FfIf1pWdtn76J+Joi6+EoSlmukQqmUvMJOOVRZ4XGAF+/eUcuNbo/FADkS1tT+U/SVO/BdSTph3YBvmRVTqZFxonSToujontnm2pZDYwnURkW+Q2iqQEbhjXPyCXmOEAt/pWhEh6H4PcHnDJFshkN8P6RP6gNk/sa1bxYAtQlsXjx+BI0U3V7aVCsXuSqOJJA8fqqY3nofovbfZJ39GwoTqWi7OMuWS9kMESG8+vxkWkPiF34CR/xWPo1eCSTXYOZ6dewGRlH9V0QX0ERwS/BpnVP0Hvgr1TibHKPoltndnQj7LyLAM4LAZzm9Jikep64K24ms+4MjMrrE6SqRT8n0w9TMRO1tNmiMaOfBlgV/V1iwGU9YQletzPrx4+VL8uRP+xmWbaJcgFjVQ8DUDM/XWI+3d3zEUEn/5XlL/m7ahrkZw==;5:IACPGqz0bA583+F9ptpWbLXMYcY0vHxz9X2eTnhBLdaHJ2j1QetdLyQfuC2/Bp3b1T+eiSO3tOrFq01/hYfEqjr3u+F7YvqBcoqO4Dvl/lzgPCmk86FtKkyQSAUc28pTYPhAq+LYPsdd4pIDcuYFDnfjqKwrajtsWnp7zR1ZmdY=;7:31fxWHCzDuLo8gpw8JKNMccQC7FGu5XWGNgUku3vdqN2gs1wFxefJYyYT/gXbjQRkZ8ZCCgOn+DvQdwElNtSFFtbDTD19/X0Fu2cNmOfe8a/9x2DC+IyM6kn5wz02Jt5XYvfdWOwzBbJh8WMLoZvic05/8YcM9O606xXZAbOxAGXbQhSXlHk4cdwhYi6Veivixl9xs+kMn+rIuVcqNVCVQAv/0k0RL9w2MqLRS+Q0BRTy4/TzFmJwp4DeEyaX6N1
x-ms-office365-filtering-correlation-id: 3739ce6f-9433-4a4a-e67c-08d61c4a4220
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0776;
x-ms-traffictypediagnostic: CY4PR21MB0776:
x-microsoft-antispam-prvs: <CY4PR21MB077689B9D226BD9B762847F8FB1E0@CY4PR21MB0776.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0776;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0776;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(5250100002)(53936002)(72206003)(14454004)(102836004)(478600001)(4326008)(6346003)(2501003)(25786009)(6666003)(10290500003)(110136005)(54906003)(6436002)(66066001)(8936002)(316002)(107886003)(76176011)(2906002)(217873002)(6116002)(3846002)(22452003)(14444005)(6506007)(486006)(5660300001)(7736002)(2616005)(11346002)(446003)(97736004)(476003)(6486002)(105586002)(81166006)(99286004)(186003)(81156014)(2900100001)(8676002)(86612001)(68736007)(86362001)(26005)(36756003)(305945005)(256004)(106356001)(6512007)(1076002)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0776;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 0EpQ5i+USrSlqxmoUvG0hwB4AyDzpX+c9qWoICSExMyLfHtorRsvHwkY2xSfCiPm1dJF7lhOMOZzRCLv/GE/uvUOdZwy1/kRcQaECA+U3QLMttHebiF+aoyYzcyWNkkJ6QB9nL0L5wmFcVO141z+lqz6sUoqf6mrbLUZaKZ2E55xjiMNQJSYnRWNNjW8NsxIQHjwsqsUtgmMQTjohkg+ii9niB5VWg2oMQwqJ8EFH+LVIxmkcFAk7SB90HH2SA+nvk4XLN8cE0QbE3o1YG1/en+J1fODpBgzm2o7GHhLkqXds4bwIEuM7p9cOeOXSBFgtDBZ/hzfmhj01TLuMwEgRpcwfXmOFVbzHqUMohWyZSg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3739ce6f-9433-4a4a-e67c-08d61c4a4220
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:52.9467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

[ Upstream commit efc6362c6f8c1e74b340e2611f1b35e7d557ce7b ]

On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
flash accesses have a tendency to cause display disturbances. Add a
module param to disable DMA from the NAND controller, since that fixes
the display problem for me.

Signed-off-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mtd/nand/atmel/nand-controller.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/atmel/nand-controller.c b/drivers/mtd/nand/at=
mel/nand-controller.c
index 68c9d98a3347..148744418e82 100644
--- a/drivers/mtd/nand/atmel/nand-controller.c
+++ b/drivers/mtd/nand/atmel/nand-controller.c
@@ -129,6 +129,11 @@
 #define DEFAULT_TIMEOUT_MS			1000
 #define MIN_DMA_LEN				128
=20
+static bool atmel_nand_avoid_dma __read_mostly;
+
+MODULE_PARM_DESC(avoiddma, "Avoid using DMA");
+module_param_named(avoiddma, atmel_nand_avoid_dma, bool, 0400);
+
 enum atmel_nand_rb_type {
 	ATMEL_NAND_NO_RB,
 	ATMEL_NAND_NATIVE_RB,
@@ -1975,7 +1980,7 @@ static int atmel_nand_controller_init(struct atmel_na=
nd_controller *nc,
 		return ret;
 	}
=20
-	if (nc->caps->has_dma) {
+	if (nc->caps->has_dma && !atmel_nand_avoid_dma) {
 		dma_cap_mask_t mask;
=20
 		dma_cap_zero(mask);
--=20
2.17.1
