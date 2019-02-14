Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A9FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470A1222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wzoNikwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406936AbfBNMqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:46:15 -0500
Received: from mail-eopbgr00083.outbound.protection.outlook.com ([40.107.0.83]:23053
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727958AbfBNMqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 07:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuJ6+yAQTOthGAJuFI7z0+3eU377vOz+ej6gIRIiYcY=;
 b=wzoNikwP3SIrrJ7zdUdEwPK8oepSSX5/J55Z+e7TgZ5WAeQx/nWBn24m56Fn1ONEe1LjAfPKw02jas0s6HY+dhxsJWXC1sC4XHedBxSMyKsn4ej+ssWOpJ94+FiUmAaw6BbrZ4Ui5hPs79Ab9jJ6mQou1bKpi/K6ttYqt4pTgDc=
Received: from VI1PR04MB4496.eurprd04.prod.outlook.com (20.177.54.92) by
 VI1PR04MB4814.eurprd04.prod.outlook.com (20.177.48.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Thu, 14 Feb 2019 12:45:52 +0000
Received: from VI1PR04MB4496.eurprd04.prod.outlook.com
 ([fe80::ede0:3ae0:e171:9356]) by VI1PR04MB4496.eurprd04.prod.outlook.com
 ([fe80::ede0:3ae0:e171:9356%2]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 12:45:52 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "labbott@redhat.com" <labbott@redhat.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "andreyknvl@google.com" <andreyknvl@google.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] mm/cma: cma_declare_contiguous: correct err handling
Thread-Topic: [PATCH] mm/cma: cma_declare_contiguous: correct err handling
Thread-Index: AQHUxGM3TWg8yAT7z0a/qrCp1B+TPw==
Date:   Thu, 14 Feb 2019 12:45:51 +0000
Message-ID: <20190214125704.6678-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:202:2e::15) To VI1PR04MB4496.eurprd04.prod.outlook.com
 (2603:10a6:803:69::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29c7f0a3-b96e-4c58-5af5-08d6927a59c4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4814;
x-ms-traffictypediagnostic: VI1PR04MB4814:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR04MB4814;23:uH500QrpxOaak7YBvl+tsZHVc+46eP7ZmIe5YsN?=
 =?iso-8859-1?Q?rQLmrfpHLq3+7p/rm325acZPHt+mwi89UM8qewJXfG7zX7xJ3BmbUlsj1a?=
 =?iso-8859-1?Q?f+CdRwozPFr1/hudOPXybL9y1Zv9VwuOvkHqxOF90f4L16Vu9nFl3zN5HM?=
 =?iso-8859-1?Q?ahOeCkjwuDdYqqfljgUWVQbzcuvBIq6lC90rnYhIvjkDg/MPWSoIWcToOx?=
 =?iso-8859-1?Q?UJ0K4cmG1FgHK+IL4PN7yH0DYQtDqU1TUFPMFB3QQDivZgxLBUPIOycEU3?=
 =?iso-8859-1?Q?7ViXmicym896b5TH/j7LV380iQig6j66pLe3jKGq0LQKZn4chYnOr+zOc4?=
 =?iso-8859-1?Q?GxtMdAfvzs/8o1mesaqY/nYhQ5Hw5XrROT4l9e2YVHmILQk4Cmd45/j0iF?=
 =?iso-8859-1?Q?6yeRcyAtdw4VFVBBUcQQ80PS0QPrco8yFVVeyVzr2qQoPsUHCaYdDo1xQh?=
 =?iso-8859-1?Q?aWf9k6411TDsZiR5t0H3LRoBivpWPjZ50Ksn9XoVrqbrH18pJeE3nTr+MF?=
 =?iso-8859-1?Q?qmhZUEjvBdX31ZU3sJUsv6nyftUiMZ/fY+scz300KiN6t0Tf4jq4lA4jlT?=
 =?iso-8859-1?Q?YXb9ltO3hUd1wB+xA7YmsJ3shyVkrNl4aG7uMIeK44xE+AR+NG0Q2Yr7OQ?=
 =?iso-8859-1?Q?iiRsO+YgqOLvMUbjinBR8gDbD8Kl55jsW6rD6SxzzB9FLydyQbFLalIw1j?=
 =?iso-8859-1?Q?ecPe2G2lgepzN0UwEptNvOiVEbZBBwoaV3YzVxJUx5RaRHA2mLQoUonJeZ?=
 =?iso-8859-1?Q?H4G3E7t4t7/QKjCTtJudM2djLJgLMsbKrxT0u/+86gv88/epIVhHPZ8moJ?=
 =?iso-8859-1?Q?f7KboYUmELS2lSkTrePSTCpOSbtXCKjJlwiZwABTOA2PlMnXKCO86iWcYn?=
 =?iso-8859-1?Q?Zj1v3g4JoQ6IRC5IemjZTL6PrM6aq1ZPKmXd17LitpdLiNENdWWOkT/4Bs?=
 =?iso-8859-1?Q?JVkKmls6wAtLKE9XMU1GjLAfUHU8emEIrsElGQ0FqhJoMseQfFq/GEEwQN?=
 =?iso-8859-1?Q?w+XQ6NLkZVgDnlq/4unWfgniEdrc/bHyDJdL0rF87s2SwyWU0daFRe283o?=
 =?iso-8859-1?Q?ULfQ01e5GEo5+bwQnwSdSacLfyH71GrgAi7hAR5JRavdolPq0BpPMfbl6U?=
 =?iso-8859-1?Q?5R/QFl4CLdjk645W4t9M3k9cUDuG3jIP2khTThbvLHqrIudnzXCvp/XCqJ?=
 =?iso-8859-1?Q?osqJGIqKUnTNjqxV1ubQdZP6GRNHJbheo+r0+Th+3YGaTwsUFVa4un5jVf?=
 =?iso-8859-1?Q?eqvXGqkyZ/0EKr9gQK9482w+7WRWhdKaWEIpIWCAfwQzO02Jc/hfEfXLwG?=
 =?iso-8859-1?Q?24=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB4814FD9965B83F137D9BEC9888670@VI1PR04MB4814.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(136003)(376002)(39860400002)(189003)(199004)(1076003)(316002)(97736004)(7736002)(305945005)(86362001)(2201001)(36756003)(2501003)(81156014)(8936002)(8676002)(44832011)(4744005)(2906002)(6486002)(81166006)(6436002)(99286004)(54906003)(68736007)(52116002)(110136005)(50226002)(105586002)(71190400001)(186003)(14444005)(256004)(26005)(486006)(386003)(7416002)(2616005)(106356001)(4326008)(14454004)(66066001)(71200400001)(476003)(53936002)(3846002)(6116002)(25786009)(6506007)(478600001)(102836004)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4814;H:VI1PR04MB4496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gg5BTYDNSODyetnGhGe8qqwttf+oufqTLqeDhtstjb296TiL2WJXaYrZtCjSCTfQotoVvERW6aJZYBP8rLk2M+qtHHhp/TVTdD3GC2+4mZG2WZLjfJC5prpVgid/2rvxdy3ZZsAIkzB6pXgEHCQNp03Ojw2RBSQVAiax1eszsdmjRLFcmSgstEzYRqwn9NFL5GszGoDgf+JjHAW/khSv6GnP3wkJz9PxIbJ2p42Gv+m6q/pJkjVrUQ2E66+IKrNsxHhdUPNxDsSSY3N0lnshxSKgsOZ4/x4g4cvKGYb18yo3hKj9KmBGj3PHbs9jjzfkqso7joxWns6wcwftVayYt0AU4JYmaqVRQ4BcnDD5wmb1/GXWkNBeY+DY5oYPE5Fd2OOyQmOlOaTIsxbqdshqn5iEUsl5j+NIlKQrJ7G5Nt4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c7f0a3-b96e-4c58-5af5-08d6927a59c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 12:45:46.8381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4814
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case cma_init_reserved_mem failed, need to free the memblock allocated
by memblock_reserve or memblock_alloc_range.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 code inspection, I do not met failure in cma_init_reserved_mem.

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

