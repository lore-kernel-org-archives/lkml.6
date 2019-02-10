Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C5BC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 09:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31D221773
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 09:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kt4VDElV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfBJJ2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 04:28:48 -0500
Received: from mail-eopbgr20049.outbound.protection.outlook.com ([40.107.2.49]:5968
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfBJJ2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 04:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMmNOC53PYJev0rzBy1zlCBXS0hp6g33BP/psSTn1dc=;
 b=kt4VDElVzblBbyOXCu3mIPzOon4E6pAN388lFLS0dmfELBqrEci37OplLFG9xEZamfAiaxOt1IThYVCdvJiP75G9qFbl06twSnGR0JnJBbcuYp4FPtFHKmKfm+YQFgm/BsW/xidrRRj0D6uCdlmX7z4SnFqwbi3GHMxciKlIBYE=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.148.143) by
 AM0PR04MB4482.eurprd04.prod.outlook.com (52.135.148.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Sun, 10 Feb 2019 09:28:43 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::69ce:7da3:3bcf:d903]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::69ce:7da3:3bcf:d903%3]) with mapi id 15.20.1601.016; Sun, 10 Feb 2019
 09:28:43 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "ghackmann@android.com" <ghackmann@android.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: use memblocks_present
Thread-Topic: [PATCH] arm64: use memblocks_present
Thread-Index: AQHUwSMEW3Pz/Bimd06u3YBihOcWUA==
Date:   Sun, 10 Feb 2019 09:28:43 +0000
Message-ID: <20190210093738.30923-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.14.1
x-clientproxiedby: HK2PR04CA0067.apcprd04.prod.outlook.com
 (2603:1096:202:15::11) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:73::15)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4482;6:UQ6WuXe6clyt2JoLZgTZ6Mc5PwkJJnpjkgW4ovBXPAqWcxS/eif23DNt0y2wcz7inkl1yjU/HAcEZwT45uZEVfnmEUUFUxNo/tvKe51Vd6Au+XfZ149UdeyThBzJycDaVy6VyP5HqgO0HSEo1ZASN5pt2/XUjMqEXK6M1auLlAwWGgxTyC3ilmFxAm+COWDZh1532JVvQYyxvSU3+rYRopxFR6HsVGDtkScdj280Uv7dNaZm02fe/jotS79fxj7qu5cxI/Hg5B+U/oDqSbOvppUwWmXvLeubwcoQ5WVB7+aeWI81is7EZRNWOnQmVxy9VOTNmBvIpgJYI1AC21S0GKUS+S0YBeznWL0Fdc7r8Z8FDXfvu+ceJfLSDpaxQJAQoOTdApQ0YJmVK2REgNiO68woBdmzoZnd4W9ppnknfo4UYESazUkIepXQhhord7klELC0ebshIoFEwwAVMgA5xw==;5:zx9axVh9t8SEduEIIa7xTS8S8WoRbk9wixW22ACKBMDzCX0rf50mWH1Th/eNBxju8IFWzyUndT27RzMuOY1B3i2okFGlK/yM/ALyZekDfKrUHGrLyfl3VGHvBGhukwFSGhnuOUvWWxF94aUbb3IiS5P9m9Ehv5R2xFo2qtsAq5XGMs+wFw1xk477BaRvS78htrdeIXxuBJEr1xnhqAJRjQ==;7:AWIUh2zFsT+9oDyKLXvF7dryTI+OQWGxDqjvgfWN8jKXPSCJxAvd/JUpzMDd3UmKNb3f4+CubYVLBleE/DZtGpQ/WaJ70qgXBTTxNG7pn/8ZB46sd87TZQ9BAETL/XWTJyJASskQQ5jp6GuwSCrSxA==
x-ms-office365-filtering-correlation-id: bcef9528-4019-454f-5353-08d68f3a2623
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4482;
x-ms-traffictypediagnostic: AM0PR04MB4482:
x-microsoft-antispam-prvs: <AM0PR04MB4482530C812BC0871DF76A05886B0@AM0PR04MB4482.eurprd04.prod.outlook.com>
x-forefront-prvs: 09443CAA7E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(136003)(366004)(189003)(199004)(305945005)(7736002)(36756003)(478600001)(6512007)(110136005)(71190400001)(4326008)(71200400001)(86362001)(6436002)(316002)(8676002)(6486002)(2501003)(8936002)(14454004)(81166006)(81156014)(25786009)(53936002)(6346003)(2616005)(50226002)(97736004)(386003)(6506007)(1076003)(44832011)(102836004)(6116002)(26005)(68736007)(186003)(66066001)(3846002)(256004)(105586002)(52116002)(99286004)(106356001)(14444005)(54906003)(2906002)(486006)(476003)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4482;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yXa4luGWc2J6ySnNxUbTjau0Tm7p/F96EvmA8y4gqJRcIZA/I5oPfafE5YhN7lNSPBB6l46fCKUivj0LIXQ5f5ahgAXD4jQ4d/lP4uScEKW888XDTksXOemlgLy/lURhMb6RgVu+Yyq8RufhOrHr4ahmSYXAIxIn6NpQlN6VIbj0hGqRWKjpKX0+TAnQZyyvAU+geFqJSzyOcthAcg2PebvisPaNL6a+6NX+u+xj5HT3Qhn2V/T5SonTJRxYyK1Ti9b1QgbeSIX8NKunFVHCCjIHb+UCz8jO+GODqeYg2I/5dEhjsIAN0uQGD62MHLm/jR1dOEAxodcBtG94wndkbQKacO+EXb610qfDUlEuN99LrcyGcsohzMzPlh9pjz1o9cvh02RiWDMt8NJuTg4xrJq2yCMNBbXxc9bDS1FKyZY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcef9528-4019-454f-5353-08d68f3a2623
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2019 09:28:38.3364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4482
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64_memory_present is doing same thing as memblocks_present, so
let's use common code memblocks_present instead of platform
specific arm64_memory_present.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/mm/init.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 7205a9085b4d..2302b4093a63 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -285,24 +285,6 @@ int pfn_valid(unsigned long pfn)
 }
 EXPORT_SYMBOL(pfn_valid);
=20
-#ifndef CONFIG_SPARSEMEM
-static void __init arm64_memory_present(void)
-{
-}
-#else
-static void __init arm64_memory_present(void)
-{
-	struct memblock_region *reg;
-
-	for_each_memblock(memory, reg) {
-		int nid =3D memblock_get_region_node(reg);
-
-		memory_present(nid, memblock_region_memory_base_pfn(reg),
-				memblock_region_memory_end_pfn(reg));
-	}
-}
-#endif
-
 static phys_addr_t memory_limit =3D PHYS_ADDR_MAX;
=20
 /*
@@ -489,7 +471,7 @@ void __init bootmem_init(void)
 	 * Sparsemem tries to allocate bootmem in memory_present(), so must be
 	 * done after the fixed reservations.
 	 */
-	arm64_memory_present();
+	memblocks_present();
=20
 	sparse_init();
 	zone_sizes_init(min, max);
--=20
2.14.1

