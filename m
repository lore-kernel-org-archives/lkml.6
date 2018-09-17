Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF647ECE565
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B1D21508
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="pB0GdbN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B1D21508
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeIQIZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:25:33 -0400
Received: from mail-eopbgr710124.outbound.protection.outlook.com ([40.107.71.124]:62784
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728249AbeIQIZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZ3tu63yEnoJ/cWz5uo2MRNbaNfYoIVZFFPYP+wPmZU=;
 b=pB0GdbN8yIRd381BGQLKGdtviP1C2YQkD/FQWwJubROhLcAnft15B7kxaM/FhBsH7hBzqgu0BKhA3t6a6rDMRi9KgMc3AAzeCVVFUEYIKu0FuRs4JcLmWB24du7DY6xnBLjdHvmXFcwgLXKZ4PBfh0NWvuUv2ySnLQeZm1kjWKA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0134.namprd21.prod.outlook.com (10.173.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:00:15 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:15 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Fuyun Liang <liangfuyun1@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 007/136] net: hns3: Fix for mailbox message
 truncated problem
Thread-Topic: [PATCH AUTOSEL 4.18 007/136] net: hns3: Fix for mailbox message
 truncated problem
Thread-Index: AQHUTjKOdmHBLKnwcEiTabQAzGnZBA==
Date:   Mon, 17 Sep 2018 03:00:15 +0000
Message-ID: <20180917030006.245495-7-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0134;6:1PXBt1taRPsYxp2jW6LvR9iXOZkCCnZbJ5xYQ1GAKCEwwUIxNmEoT6mGaQJngTtf4d+wQSMr8k29oLpT5v5HdYl9xkDlztIcbCfy2sVJDYj6OIj7mmRefrvNOclzaHKh6U2PMPzxFyjHFLIWledQWyKo+CyBf1T0WH6FpLcFu+4QGlCrWrwAjPGyQ0d9nkEA37BgBKFRmWw6UD1honZ4R5DaLd8Hs2HQl6Ko2vObo81LZVnTkFF6ytvpGJr0iGGRF5vNrl2p4cGU0oQQ07crtr/+Z27TLXOkvI+5N1TI6u+CMKSvHFfuFgrmLVpgEKhMh2Ua1UeG7LrSKalmgDiOphxwuuQ6n27B5d3jblIR3rcsHmSmBmTq+DfgMcV/HC8bozB8ODIwxprlcCqof1JgNnsFWngl9EV7qpsMqR7BKc5wcqOytgv34TmwdXjwWAsmxpWT+cYKFPGG2TcZMTsoHg==;5:2D6P6LVBDsGg7aWaPOq3S1uoJR+7YqMIDMve0aF6zy/7LbKB5f0yp+s+clNvxsNXritvL/3JfIBVuQdkgRbuUJqLQpmGhvvlSGkZ32DIapAxSwXYTekx+DtVefFYkZ8cSdr7BpCq3k2iS5DaRk9F6AliEehgiqIgLdM18dHoXW8=;7:jnljaGESpTiERckKsnkmm8MKnjyrsyGBeIKSeTDNYk37uQsHXQfUGKAvidEMTT0rKBYHqiMc8JQFrNBlQTdoOXrTyTjlWYvwCFMkjk+irZdAIedCze+xW/QPcWv9D6jKC+TdDvCAMzW9Vdsqxg16FKU3qwuezz05pYC8j59LLDAh6F6qDvcDprWuDlxIHbYaebrlRndLhFrzSGuYIpWC5JqKxC2aOYoAAyXQ1//bvl8F4MKntJ43fFupgEV3lIkK
x-ms-office365-filtering-correlation-id: 1e47af3f-6b18-4d20-8f41-08d61c49b15d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0134;
x-ms-traffictypediagnostic: CY4PR21MB0134:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB013473FF861B7713C705CB48FB1E0@CY4PR21MB0134.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0134;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(136003)(199004)(189003)(6506007)(10090500001)(14454004)(99286004)(76176011)(68736007)(6512007)(4326008)(25786009)(217873002)(15650500001)(107886003)(72206003)(22452003)(256004)(14444005)(36756003)(54906003)(110136005)(8676002)(6486002)(97736004)(10290500003)(6116002)(11346002)(26005)(7736002)(86612001)(5660300001)(86362001)(575784001)(53936002)(316002)(486006)(476003)(2900100001)(5250100002)(105586002)(102836004)(305945005)(106356001)(66066001)(81166006)(81156014)(1076002)(2501003)(2906002)(6436002)(8936002)(446003)(478600001)(2616005)(186003)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0134;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5XmDRAVBKIDy9wHaXJCkszMQNbTRayM0VoqITMwooAsXyKp4PHTbzk7yQ7ld49Mf14ihLuSrVlaCIQWgtxn9t4rH4qI1nKithyorDeohxy/A9ekf1RB7tOQmNz923DSjnLKdKAHGxl8DTfhCeJEqZIqHkkpNRujc3IPtfg4YakCrUWyEMQT3rZwCaaAbjaO7p+WC7w595JlER871uDr1LVNCUEU1P0+Kk+f3iWzuy//kqzM9+wEd9yGOPLiv2eyDIqP56FW5q0A639zVrt29yd5tPV0msiJyQxaxY5ubrXESESjplO+PLeTdDH5UOc0TKY+h/lAVkoRrO//U3mQG2n2ilr1gTmgsRBIXasmxrUc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e47af3f-6b18-4d20-8f41-08d61c49b15d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:15.2767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuyun Liang <liangfuyun1@huawei.com>

[ Upstream commit ead5bd4d35c0a14d5ce1474177718c678dff5205 ]

The payload of mailbox message is 16 byte and the value of
HCLGE_MBX_MAX_ARQ_MSG_SIZE is 8. A message truncated problem will
happen when mailbox message is converted to ARQ message. This patch
replaces HCLGE_MBX_MAX_ARQ_MSG_SIZE with the size of ARQ message in
hclgevf_mbx_handler to fix this problem.

Fixes: b11a0bb231f3 ("net: hns3: Add mailbox support to VF driver")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c b/dri=
vers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
index b598c06af8e0..cd246f906150 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
@@ -208,7 +208,8 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
=20
 			/* tail the async message in arq */
 			msg_q =3D hdev->arq.msg_q[hdev->arq.tail];
-			memcpy(&msg_q[0], req->msg, HCLGE_MBX_MAX_ARQ_MSG_SIZE);
+			memcpy(&msg_q[0], req->msg,
+			       HCLGE_MBX_MAX_ARQ_MSG_SIZE * sizeof(u16));
 			hclge_mbx_tail_ptr_move_arq(hdev->arq);
 			hdev->arq.count++;
=20
--=20
2.17.1
