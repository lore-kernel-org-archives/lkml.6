Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ADAC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1504218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rzg8j7+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfBKNFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:05:04 -0500
Received: from mail-eopbgr130081.outbound.protection.outlook.com ([40.107.13.81]:31018
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727182AbfBKNFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIAApjtE1jh7Kf92D8go1dW5TusT+j72TGarvGRzMrs=;
 b=rzg8j7+GMIroQyfYuDd+bOWNiXfPR7GhoXugAxCGgBG6w8b60a2Q8hpzgEZE7fVXFWp679jqPCednhINoGphjU1NoyzMneyLeuM9h9l93SzSZnuOvRUM1YgqiAKK9+Z0XJucnB7BZ9wp56vatiM/GnOjo/+LhoKoIsk5Lg0kq4I=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.16) by
 DB7PR04MB4489.eurprd04.prod.outlook.com (52.135.138.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Mon, 11 Feb 2019 13:04:59 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::fd45:a391:7591:1aa5]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::fd45:a391:7591:1aa5%6]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 13:04:59 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm: use memblocks_present
Thread-Topic: [PATCH] arm: use memblocks_present
Thread-Index: AQHUwgpk6mha5pabokK36jjcALV7pg==
Date:   Mon, 11 Feb 2019 13:04:59 +0000
Message-ID: <20190211131602.3294-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::15) To DB7PR04MB4490.eurprd04.prod.outlook.com
 (2603:10a6:5:35::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4489;6:j9uPY1758Wtj+WDr7cG+0sl/tXQolnMQQnQXVS+O4MBS5bIxKwqpcDaKpbwzT6JbfU6I26YmAicW5SHSSyPd7S0ASNM3BlaEHrjLpAQ8zMnkSE8L4RXevr8f4AMWOI5TN300grJqEH+PGRdJLfQwfvQk4pm1JUtSW+nRXVDtZN5TsHIwBzb3RYeJ2gZN+Wp5WcEAS9VA4BbFZTg3OD3X1xCRGMM9+B55DWoXgQezZ0mVOQ2urKrgQX//PG7CrIDPZ+Ouop/zd0xwC7M3DfaGyTiVEcproraTg7QNSmkXsjo4wB9fv4N7QONJROmD9E/U2huaugyYLGPtyIXA6YFd3xI4tuAPyooACsNKNeATFr3e9wT4WKyb+SwDnWsjCD9vuPF1hx+qdqyrcp2L0dnP0EHL6LcgN3l9+XWDYCVqKV8ty3RgHpq3RtZYxfNYJQgsdtSR13cPvHa0041TxOVkaw==;5:g6KODoSU5iIAmosKXfaMO8QyT7KaF8OzmhqJRG6lOZe/iJ6NMJAQRsz6WtCshwBNQsMnuKsXvXI5AbR1NdusBz1RpgGFBPmp02nWGZbKLybp0mG1J0IETuom4ss0pPURyEDhcyCouARCklCC7iwHQf9YIE1LN7pSiii29Ea4/+Q8C4CjurGE0rgU4u0XKtAwGXWSyWk6wdjKIFAlK6OX8A==;7:NZdZ1OOnYl5q2ujy3n87FxMV44zRK5xRr2Vn06Tl9UFuKETtQijzLtVi6SGNkRCNdYWuKjzOxSHXYXpJate5Kss822ktJlzCJHLDx0UiqMFO7zQqD/r4QBJhaPhFlztCFqz5FBQBApD9aWprPShYYw==
x-ms-office365-filtering-correlation-id: c08b2d9a-9fad-4d9d-064e-08d690218693
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4489;
x-ms-traffictypediagnostic: DB7PR04MB4489:
x-microsoft-antispam-prvs: <DB7PR04MB4489667D35FA921F8704AC8188640@DB7PR04MB4489.eurprd04.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(346002)(39860400002)(366004)(199004)(189003)(68736007)(44832011)(97736004)(52116002)(7416002)(305945005)(7736002)(102836004)(50226002)(14454004)(6506007)(106356001)(386003)(486006)(105586002)(8676002)(81166006)(36756003)(2906002)(2501003)(81156014)(71200400001)(71190400001)(256004)(478600001)(476003)(53936002)(66066001)(25786009)(26005)(2616005)(8936002)(1076003)(6436002)(2201001)(86362001)(54906003)(316002)(6486002)(186003)(6512007)(4326008)(110136005)(6116002)(99286004)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4489;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Yx5IINc9jP34ACH5r8PZxajbtD0EfipfNhhJXS7hRK5ii8+2NDJKQy5Oh0dtXQ3542Q4OKjfgpFOZ5nx7gJxskmdoWORbycJiqpT9JNpYguE1WCc6oCx4aLJP0cF7U0d7h1wIbggCVH0uuhV95C4e7IgMi8N6XxuCxMtSJR1ogSrn5H8g+np1GS/qBZIw+H1Jv+N0wB5j5DE2jZUFXFtEoq5qmSZ3PdF8PjuCdVXtC/S48EvinN314P4o6DedX8DDItYfVnBaEzy7/bnewAIVhIcdyvDtzkdV8GHO+oOyBV2HeJiLoPaBcxUlOUYNptC23mDbbHjZJ7d4uqj61GbJEm+sEucGvIhz1SaaKP0C/fu8Ue1NzRetTqgO0USMYxP3OBGqT+FZxpapuDQVkaeZSrF72QtWOdceAqhGAcnCLQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08b2d9a-9fad-4d9d-064e-08d690218693
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 13:04:54.0035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4489
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm_memory_present is doing same thing as memblocks_present, so
let's use common code memblocks_present instead of platform
specific arm_memory_present.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mm/init.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 478ea8b7db87..6c50dd407ba8 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -182,21 +182,6 @@ int pfn_valid(unsigned long pfn)
 EXPORT_SYMBOL(pfn_valid);
 #endif
=20
-#ifndef CONFIG_SPARSEMEM
-static void __init arm_memory_present(void)
-{
-}
-#else
-static void __init arm_memory_present(void)
-{
-	struct memblock_region *reg;
-
-	for_each_memblock(memory, reg)
-		memory_present(0, memblock_region_memory_base_pfn(reg),
-			       memblock_region_memory_end_pfn(reg));
-}
-#endif
-
 static bool arm_memblock_steal_permitted =3D true;
=20
 phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
@@ -292,7 +277,7 @@ void __init bootmem_init(void)
 	 * Sparsemem tries to allocate bootmem in memory_present(),
 	 * so must be done after the fixed reservations
 	 */
-	arm_memory_present();
+	memblocks_present();
=20
 	/*
 	 * sparse_init() needs the bootmem allocator up and running.
--=20
2.16.4

