Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF431C00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9429D213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XQ2F1o0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbfB0OfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:35:00 -0500
Received: from mail-eopbgr140058.outbound.protection.outlook.com ([40.107.14.58]:29859
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726866AbfB0Oe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydPKA5bYPG4oJWewMmo9KXUQqkLI9/V32BgyLDEghQg=;
 b=XQ2F1o0t/ldbkVL6p9C67OWuVdSsZ58a5cwp25mBexMrRriEr7BLSCIaY4d6IdImFrgTHqjxirh015qfpnnVjQ2hk+I2PMze3QupSNzEKTGMqWouBcohbJXj6uCOe/D3IsanNnOHpi9lezydZPHIipgOyz07/BQbRft0K/U0tNQ=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4387.eurprd04.prod.outlook.com (52.135.148.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Wed, 27 Feb 2019 14:34:55 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185%5]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 14:34:55 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "labbott@redhat.com" <labbott@redhat.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "andreyknvl@google.com" <andreyknvl@google.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] mm/cma: cma_declare_contiguous: correct err handling
Thread-Topic: [PATCH V2] mm/cma: cma_declare_contiguous: correct err handling
Thread-Index: AQHUzqmb2gOP19YBOEqDLHalEnAZ9g==
Date:   Wed, 27 Feb 2019 14:34:55 +0000
Message-ID: <20190227144631.16708-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0P153CA0037.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::25) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bc17a3f-4e3b-4dc1-e998-08d69cc0bdc4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4387;
x-ms-traffictypediagnostic: AM0PR04MB4387:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB4387;23:y6ljAC1GU2xbUvOeSDE1klbwV7PpK2frWB0TKaR?=
 =?iso-8859-1?Q?7HaciBCqWYx4u27n9lSHkF0uOAtM8gOJLu0qCwXX7mNPWYa88W4yE/4WDq?=
 =?iso-8859-1?Q?ZNEJV8QC7c11oDf2Pd6yt6mjcE/oh0AZeMHcI+RlJUOTuyFcjzrStK84ep?=
 =?iso-8859-1?Q?u88mRb7dfF2eIa3AUZ9dqi0lFWHfJCK29LXD89m33PAsHZ64iFx6eEjLpS?=
 =?iso-8859-1?Q?RfPxejujnlbQwq6b2tvhpnPkonU4sSdA1UF79/iTbamzauWAqPzIEt2Obv?=
 =?iso-8859-1?Q?+H833xy5OsKqsV+BaVwZE1LX8wtjTp/1DyjpLuJI6vx7MB/J302c+v5Ng3?=
 =?iso-8859-1?Q?ms9Gpzr+Wvqg7TcwcrnUXu1GzC+Ki+rBDEawnZGZJqBuDDPDJgULAnoBaT?=
 =?iso-8859-1?Q?3FDq5tLfujniR8ApsjvbHc+c7JWY8sE/e4js5J7X28AXo7U+R8rCQocjf+?=
 =?iso-8859-1?Q?3f9Ntfzmo/kAFOQ9OFdObMv8irm3PqKoOdIKx0u6aRtjiIOIfUJmCZdrqi?=
 =?iso-8859-1?Q?HFfatlS6rHjk0968uk3ksdI//rRK9jcAc/TR2kq87YwwXh2/wxOgZXiFEo?=
 =?iso-8859-1?Q?NHX9Y/Kbv27IW8qoUm9n9lFSXMaSvobGrlwKacTmdc25VfEFO3YILFQVbR?=
 =?iso-8859-1?Q?EOJV/baQb8Qb4JvLYcioB+Onzd6oBB85tilpivI+2sQkkh32SbK/YDlrLJ?=
 =?iso-8859-1?Q?WHW3OWWSfmcLt4kB+sSnQAlZXECDRC4ijEWRZY6lOMMxs7i6qOju3gRo7v?=
 =?iso-8859-1?Q?Shn8gCHdR3bQpGuqv8itBjxFPZ+9cTALNRlP0Zz9p+nXV6jqbcluGzEXwf?=
 =?iso-8859-1?Q?3VU+HuXgncv3mX/vRB9Jdspd/DMDuS4fE37+X9WTtVI98okpY1OAvfsOBX?=
 =?iso-8859-1?Q?SLyZbecKcNafoLCvn2ZAZRcW2Kz7pJ+v+qEbXnTf7ZGFbqc9daulnbHS8+?=
 =?iso-8859-1?Q?fX+0T+Cdl+ozz8XOIqNdA6fEGY3Ztek/bBSTypZoHGc35640wjEbyHXDtU?=
 =?iso-8859-1?Q?4vU4/ysvTEaBKwHIe6omkVRXHTZ6QcSTRFG7sppWJlbzMh75ctMHNn6CY8?=
 =?iso-8859-1?Q?9Rv+ry1V/43UgvvbFWiAzHK0dw5SmXF4+XwyIDB+7qBuFc7iY14L9d3jWt?=
 =?iso-8859-1?Q?nDY51id8BaQRNKVu7ofpPw3O86nMRJs27uCwFmRco/5rh3Z/MIBt53hBlp?=
 =?iso-8859-1?Q?Mz9SPAb4aZ5hIAWRVi/ARDo0gpR42hpbi4mVNiqm4EWyMRatB6Hmcc0znk?=
 =?iso-8859-1?Q?P9gsDMuQZmaJXtHj6MC6n+6tfM4vg0dROxE5+9hkiZwy8GUS3zwnpuTEaL?=
 =?iso-8859-1?Q?szDlU8DtUA+BRJ8AgchXWbMzdGMAFdzmkZ7y3RkvYIm8g=3D=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB43873FC1EEFC654ABE903DD288740@AM0PR04MB4387.eurprd04.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(136003)(396003)(199004)(189003)(256004)(97736004)(8936002)(7416002)(99286004)(52116002)(966005)(71190400001)(71200400001)(68736007)(486006)(26005)(14444005)(14454004)(478600001)(186003)(2616005)(476003)(2501003)(81166006)(8676002)(81156014)(7736002)(44832011)(36756003)(305945005)(106356001)(105586002)(5660300002)(1076003)(66066001)(53936002)(6306002)(2906002)(102836004)(6512007)(386003)(6506007)(6486002)(110136005)(316002)(54906003)(2201001)(6436002)(86362001)(4326008)(3846002)(25786009)(6116002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4387;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 64NH0bMY1y0xSNMIiVr9w1CMjnecvCr+0IJWiZ82vQVUP7MBreS9MHZUK7wgXAJ/uFw8izpPixWqQlzYuiu+AKO11BYkrfEh+uQTrJgCFjnFYvEAjz86RKUxGEePDhqeFF5ARtmXVThVTicew1xHI7Rx4Anke9ItyT6aEiIjndA21q9FWmQVeZgwSZsvMvtQWaGSfyuYW74zp24Vr4pkvfC/UThdCUiqvFobMD/zt+yC7kD8WgfNjqtr+3+8AKMMy5iolZh9cGso3JhN8NK0BuWGl3sOGvrfRf1ls/F7BFeE6e1Z+1CrbTO4rGysqAOR8crB1hbrYxEVVG8SDzPXasBBpruURs9sscizT5VUhK9d8UKQItCmY6tWPb7EZLtDQqSTUjNoEjRPhYpXbPUnqd5HHoBqUcjTLXdltw2gv8U=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc17a3f-4e3b-4dc1-e998-08d69cc0bdc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 14:34:50.8506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4387
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case cma_init_reserved_mem failed, need to free the memblock allocated
by memblock_reserve or memblock_alloc_range.

Quote Catalin's comments:
https://lkml.org/lkml/2019/2/26/482
Kmemleak is supposed to work with the memblock_{alloc,free} pair and it
ignores the memblock_reserve() as a memblock_alloc() implementation
detail. It is, however, tolerant to memblock_free() being called on
a sub-range or just a different range from a previous memblock_alloc().
So the original patch looks fine to me. FWIW:

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---

V2:
 Per Mike's comments, add more information in commit log
 Add R-B

 mm/cma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/cma.c b/mm/cma.c
index c7b39dd3b4f6..f4f3a8a57d86 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -353,12 +353,14 @@ int __init cma_declare_contiguous(phys_addr_t base,
=20
 	ret =3D cma_init_reserved_mem(base, size, order_per_bit, name, res_cma);
 	if (ret)
-		goto err;
+		goto free_mem;
=20
 	pr_info("Reserved %ld MiB at %pa\n", (unsigned long)size / SZ_1M,
 		&base);
 	return 0;
=20
+free_mem:
+	memblock_free(base, size);
 err:
 	pr_err("Failed to reserve %ld MiB\n", (unsigned long)size / SZ_1M);
 	return ret;
--=20
2.16.4

