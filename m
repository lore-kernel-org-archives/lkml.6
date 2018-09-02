Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7862AC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253CB205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RcgoRq5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253CB205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbeIBRaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:30:07 -0400
Received: from mail-eopbgr700130.outbound.protection.outlook.com ([40.107.70.130]:49888
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728318AbeIBRaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mmgd1qcefW9sf/+4il2CpvdaC1r7f1KxD9bgVTsEvWo=;
 b=RcgoRq5X762PmAJ6DSsV8d3ZwqTzmWfFdtS/Pyl+0dYGhgTgmBbQSxI2p4RCt3MtONyueCmeOCz/muM+Tu0+6GM34Or/ounwZlXX1wn8pd+R7C6cAPJ2m+R5tin0LBmiVMfDDsZwkuSNON6okOUx8x8p3pSkM/yIorTtZ2etrnY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:17 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 12/62] tty: rocket: Fix possible buffer overwrite
 on register_PCI
Thread-Topic: [PATCH AUTOSEL 4.9 12/62] tty: rocket: Fix possible buffer
 overwrite on register_PCI
Thread-Index: AQHUQr7ZkeVrdSzh9EKCLh4nhz1ZNQ==
Date:   Sun, 2 Sep 2018 13:14:16 +0000
Message-ID: <20180902131411.183978-2-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:HI6eqRKEQMbGQ5uRyuKK2mgkRw1KnloMquGEWvHb9ziZz0VUWEKiqwKgwEVp1ed//WpxraAQEl0sD89osmJlRLgBRaskA+jx4t2ifTMZlWF2lqTdS2Fg6aLWtR7ynC8fZrRrz+rXMMcC5eWa9SS6FHBdf6Q6QLPLkPMmThf/+/bKefGbvOxVHUnUkyVEy3888D3TDhfZ4NqabpO9I01RuBkuJviA1FHefTFkn8Q2GArFUWZU+VqhTWj81y+H3kXwtz6KvvEa/anCkj899JXnWp82EzgAJcPm1ufCkvY+6DmXNk3Va1fxEBc6NZYu8xrSu5lv4yQ1LCoxsm+ULgQ4Tob3rfLyhNh37PVUm07NpcW4mXzYctuaPC3CT6+EEAIaSmdEf/0IQvNIrspUB8QGk7GI4gjNCGSufpQwhl95FhpYofLF4PjJtS4IHgWpdLIr9IadKOl0UrGafyjRfxPXbA==;5:4rOGSSJa3TwqTbvpFc/UZgCoYFFvTP9USYLUn2jMai3u/XHTOx0XZieQK/fuM2GB05uowJBIm82I2vec3szql+M5e9Xb8UY8Ly1ni3Xm5DiDqFqfvoq41kYoOp5mT+V2SSmBp96JrGdWNEd2ZrzfIsuCV4ncCQPMzPOktyI0xkA=;7:1L+cps4Hx/HIslRChSDj5l1CYONuE6dn5z73foJjC2G+CJkAjv/Z0zesAiCBUoAcudm6dioGqj9Jxtp8UufsxGHzgEJYul7T6nvrP8B8RSWu7nWh6iMa5gf++3nYbMapKtnwN9YRVQ2xysjDGm3eo0u0Pgu1WJ6Rr8hk9wgMtSppK1LBHAgm5Ina2PKCjmrU1dZ4EgadhDobCuyUqnfmR419l3q1plZpwDsLBGrZpvemvHxvR0cQukNzCSWMY+bF
x-ms-office365-filtering-correlation-id: fbd54482-51ce-41d0-7229-08d610d5fc8e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0120E4CDB5562CA7F900CE40FB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(376002)(396003)(366004)(189003)(199004)(106356001)(53936002)(72206003)(5250100002)(22452003)(97736004)(6512007)(10090500001)(2616005)(2501003)(446003)(11346002)(478600001)(10290500003)(476003)(4477795004)(14454004)(81166006)(186003)(486006)(25786009)(4326008)(36756003)(102836004)(8676002)(81156014)(105586002)(8936002)(2900100001)(99286004)(66066001)(68736007)(110136005)(26005)(107886003)(6506007)(5660300001)(76176011)(14444005)(54906003)(316002)(1076002)(86612001)(3846002)(6116002)(256004)(7736002)(6486002)(575784001)(86362001)(6436002)(305945005)(217873002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cwOjV/kNlBRzIlpd3ky0vveuClkYNPjoks1FSJlwax+bZAJ1aXhgvh9dBHrWmZx6AyfmzMLp5FrMqU1KuMwtnGkg6pcCY0UO47rzl4oC+RmeJk8mdl/1yMPl4+TxtkN8zgZyyjLNzJPxpE0gsOsMaZBgJt+cUyH7E0yZ4+xTDuBHvnQ3nyVce01dLxx26kXVQsdQK7sbvboYp/JAIWOqiqOaIHz6ihJQ4updBWHRxKXzN8ptUzSgIMao5AkpgtRhCN69PQumPB5/s1tWfhPCW2McwwwX6XcfxQTeRGFAB/qm6Bi1DF72/q5+gm2VU1gWVnVnaw641DZmFtNj/bA3ul+ZK3ONXGmoCywyTpgsn2w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd54482-51ce-41d0-7229-08d610d5fc8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:16.9364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 0419056ec8fd01ddf5460d2dba0491aad22657dd ]

If number of isa and pci boards exceed NUM_BOARDS on the path
rp_init()->init_PCI()->register_PCI() then buffer overwrite occurs
in register_PCI() on assign rcktpt_io_addr[i].

The patch adds check on upper bound for index of registered
board in register_PCI.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/rocket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index b0cc47c77b40..e8e8973939d3 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -1913,7 +1913,7 @@ static __init int register_PCI(int i, struct pci_dev =
*dev)
 	ByteIO_t UPCIRingInd =3D 0;
=20
 	if (!dev || !pci_match_id(rocket_pci_ids, dev) ||
-	    pci_enable_device(dev))
+	    pci_enable_device(dev) || i >=3D NUM_BOARDS)
 		return 0;
=20
 	rcktpt_io_addr[i] =3D pci_resource_start(dev, 0);
--=20
2.17.1
