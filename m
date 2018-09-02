Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37475C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEFE20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Q/PVQcNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEEFE20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeIBRT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:58 -0400
Received: from mail-cys01nam02on0091.outbound.protection.outlook.com ([104.47.37.91]:41829
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727487AbeIBRT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7qh+spN7wD2PXDVN9U5HcRdLfDhIGBTz67X67FqitI=;
 b=Q/PVQcNFCFJKWaTi1lx4GijT9fCUslmToTm7SMS0zZ3SISgOds6V922ZfrlM0Kc6z54/Tab1I5JXwnGsw7abA5Fk87Wq1wA91ocHoL/dD6ESu9YdETxxyeD1Jhyk/iV9+nK1h+24OY4QsHILxfImZS5+kRxv+uM1WbokezSLVyQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.4; Sun, 2 Sep 2018 13:04:07 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:07 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 032/131] tty: rocket: Fix possible buffer
 overwrite on register_PCI
Thread-Topic: [PATCH AUTOSEL 4.18 032/131] tty: rocket: Fix possible buffer
 overwrite on register_PCI
Thread-Index: AQHUQr1dVGMSiCxOeEGKst5KGGE9lw==
Date:   Sun, 2 Sep 2018 13:03:37 +0000
Message-ID: <20180902064601.183036-32-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:lcWo2NPvJatgLLqhosyT/AGAaw9R0Vo4oXfD+z/uknZyPL7880kQl0rdUT2XB+JTntrQ4HHBJh8hhuRWItQBc4tg+4J0G64CgvOjuh1qXJ0sED4qf+7AbaPlCNgt59ApIQLIGLze4D/LSpkd72/Fw9hGWEHMGieS8LTF6z7asiyqGobcATVet6gljBFMLLn40xO3UnQjl54W8K0bbBHV4b0VyUon06bATYKH35SED6ZjVQqboISmyqOqRq4Li9lKnQZy3F62RRFZGyUCSJQi4h7DFc3DFg6APly5sppEPZA1rcpb1UpXb5tPOCr+tnxwZ2LH7XUyiuznxYo0Rpl17c0NJ4iVjmGjxkuA9399xMJj4WjShOSzVMyz3sze/iwFErVZZXWkzL0N9R63kToYoSKJqNgmIggJJxa5VAeo5rcyRA0gLpqV1F7pnbMDSAIToJLN1fKjBYOr0L6mvJAkwA==;5:3CgW/T6ycLWwfs59aFC/PMKr8jw0ntCDcIivsu+D91Kvb2s+r80BIu8o1xiJBD18/eu+scfXqX2tT78hQ0H01LmF3iVCaLnycS0zsXwROdgnHp4o0YlmP6bBxcwPJUDmwXWvlbu5R2jZ7QHFK4uLGmly5H7+8c9IW5uVre9fvCI=;7:c7nJPINWsb5SMoHS4LGe1haDNjqUS+rZaSVt0Yl+rPqMMlqKH0NvAmZwd4pOStZCZh3FfrJnFSYr8IK3b3Sq8gWp6S0x9VdFm9wRlRm+oELW+6jjYRE6yPd/y1hmbXVE3YxmaWB1lrTMEwg/U/5TnjChC3JlueVReu7V6wB35VVQhY/Cg7e0Wp/mWtqAwjJB9/6IYqmVk9wsVnqRd5W8S/aYDuJ90U4YH4Yj/27QMfRD5rOESpg1MDOFOj6qeLV+
x-ms-office365-filtering-correlation-id: eb4731b2-8db8-415a-c264-08d610d49122
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB015042D888A5A9CEEC10DF42FB0D0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(256004)(22452003)(2906002)(217873002)(3846002)(68736007)(10090500001)(6506007)(6116002)(1076002)(6436002)(102836004)(486006)(53936002)(76176011)(106356001)(105586002)(14444005)(7736002)(305945005)(8676002)(316002)(5660300001)(6512007)(99286004)(36756003)(4326008)(97736004)(6666003)(5250100002)(2616005)(4477795004)(476003)(2900100001)(11346002)(186003)(2501003)(81166006)(26005)(8936002)(81156014)(110136005)(54906003)(107886003)(66066001)(478600001)(86612001)(14454004)(6346003)(6486002)(10290500003)(86362001)(72206003)(25786009)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: O9lv23hBjrXTiXjRxc6iVu9Ms/6Csdn6/CEdep8R3Wo18Nzqa9P3f1p/El+I77udzrlfePZFlr7MOuGXWeY8zL4VWb19M1LMhYL9KgfqJaO32TcQ/wX/sV4Hh3hsKt+Ldi756aXEzHakE1l/zZ6HzdsZtSldKJA0M1TD7nL41DrV+9g1yMbW0a1OvBBme/GNL2Di+VNU+MkGmw+9K1j9BR/RNw2UhtiX7K28mzSjz6t1569WpVrp+hgvQ0NYqV3uka6jL/J4r87JUhCRX4kUGeDLwbcxhrGswPIzFIZKxIrXhPzZ0OS6gYzigGDYXRPuRjFBp07ops5rbZ6V4A3QSZVmzulWViR1zccgKny7ZIQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4731b2-8db8-415a-c264-08d610d49122
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:37.8496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
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
index bdd17d2aaafd..b121d8f8f3d7 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -1881,7 +1881,7 @@ static __init int register_PCI(int i, struct pci_dev =
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
