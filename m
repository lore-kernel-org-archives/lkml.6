Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32FFC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DC52086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qcQ/0nuu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BOltmh4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbfASN2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 08:28:04 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:62583 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbfASN2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 08:28:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547904481; x=1579440481;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bfGgcKFovQlx1ySUtIbNJcOCKArG8v4y5K1IW9wcmX8=;
  b=qcQ/0nuuHYkUuzT6OyZBDZj+/8nXdhnWxLmIXrj7yf6ulEgBjJpjg6wg
   8ATRWcIg5oU3qLcMq6D1QXqomeJ7G6TB+SjxXRRUd8r4T2aCZQPP1Ua9N
   xDYkXNgPERSaf080r8iAIWwEGBsSzMC0RZ9ilxHKNOFeB4CeV2p907GPr
   jv4gNGKJY3UBnkkx14jX38Pxd9VsP68Tf/dF+debFRDjFJ061AhIsEv2R
   Nde92dWquUUcXTabuPNKog6Cnioa0KVkpVBr7vDVC5yfIf/8wKv/u6o3k
   zeU87jq31b6Wi0Le+w4g1QN0EuH8J9+E59rRu2AAdG9M2TXIyecquSusS
   w==;
X-IronPort-AV: E=Sophos;i="5.56,495,1539619200"; 
   d="scan'208";a="204221742"
Received: from mail-bl2nam02lp2057.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.57])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2019 21:27:59 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FjW/hr5VB43w3Yfq2ljGtg1B108sexcO+M8lWi87JM=;
 b=BOltmh4fVbtIeXB5PSiCTnsKG9LHcaijJr80Z/yCZkWsa5zrfctI2jjgXdfDyhgNzoYwbH8v84fpi4VgdGvmiHSKTpeaMD9NkFou+OUI0u8PXjX1LGd4gdaGLr3XlY+r4FPc2s45MBB4lms/Um3rDq5piTBjNDbHjoaqvEcC6w8=
Received: from BYAPR04MB5303.namprd04.prod.outlook.com (20.178.49.148) by
 BYAPR04MB6117.namprd04.prod.outlook.com (20.178.234.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Sat, 19 Jan 2019 13:27:58 +0000
Received: from BYAPR04MB5303.namprd04.prod.outlook.com
 ([fe80::add1:92cc:65d7:5d94]) by BYAPR04MB5303.namprd04.prod.outlook.com
 ([fe80::add1:92cc:65d7:5d94%2]) with mapi id 15.20.1537.028; Sat, 19 Jan 2019
 13:27:58 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v2 1/6] RISC-V: Move free_initrd_mem() to kernel/setup.c
Thread-Topic: [PATCH v2 1/6] RISC-V: Move free_initrd_mem() to kernel/setup.c
Thread-Index: AQHUr/rLwFIQ0IoNdk2fJw9OHQEpQg==
Date:   Sat, 19 Jan 2019 13:27:58 +0000
Message-ID: <20190119132650.9978-2-anup.patel@wdc.com>
References: <20190119132650.9978-1-anup.patel@wdc.com>
In-Reply-To: <20190119132650.9978-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::27) To BYAPR04MB5303.namprd04.prod.outlook.com
 (2603:10b6:a03:c8::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [49.207.52.191]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB6117;6:PFp09F5I/3u3n6bKaebqgK7db3UkSc12Z3CvpXIByxPey/owtIhc8A+NJBrLPE71waPxUtd5QpT/g0EpSRaDrZGHzcnDU1kThW0lf5i+TN9T9SjLO8vU+DK97q/uB6BTbf4/yjT6gfK02KJ1TFEu+FCTB8BPDDxpwuGO0HjPQ709wnU7xDtbG+l8iUikanl+oqUQhZ0EEfpt9cg664X3YS+bPVBrlC+g7doZVyZK3qXEsYPRuFm41codSQUZGFzEfvmAxIgn+QNvlj+jTo0b8v0Uy6pZBTN3S2VTR8Vk6eDyEYIhhnnyUD4FWHEfpcacpDVcPY3Fa5I+1B3Gz4PFV2oj/Ur79Uzsba+348AZoVQXg/AGc7ciAmIHryT+7oeT0Mz+aruM3eIH0WQxuUWUS1f6cLCTkEg6hN9zk6ofJmJoRFRBIUzN34fqw/fzbcZQhhrUYimT3rWvSShko/PNIA==;5:Jb4thOLFZWCbmy4bAuMhQ7g+Wt+BIodf8eMEyLGSC1ApBD5L0wH9TVFX6Qeqrne3KbBKIk31zuwQM9Ej4hZcAdYrVEmoZwCM3YQmL31sqVGX6iJ8sqPvKMuT76+UB67j0W5V7yHC3QDmGXw2v/ApZkGcBKVezorqgaO31js7Vx79doA5C5AUdvUI0P/es5X8+kHVbIIu9K1F/vm6dOaEMQ==;7:4U8TtJQ6cqMi2/xlmOC3s614BuU5DJpT28HpZEU+ipnDEcEn+3oBfwVeZSlPV0IF7XYNO5DUNFQxuLn9seS5CrbFFsU5hacIqosj7BKkzukNMd0JelwOcUcsUWMSyElN67DRtRDYYh33uyKCyXnDdg==
x-ms-office365-filtering-correlation-id: b4dbd326-cc97-4ab1-abe7-08d67e11ed59
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB6117;
x-ms-traffictypediagnostic: BYAPR04MB6117:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB6117EE2847A9E789A187837D8D9D0@BYAPR04MB6117.namprd04.prod.outlook.com>
x-forefront-prvs: 09222B39F5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39860400002)(396003)(346002)(366004)(189003)(199004)(476003)(8936002)(52116002)(102836004)(55236004)(446003)(36756003)(6506007)(386003)(76176011)(2616005)(2171002)(50226002)(8676002)(6486002)(4326008)(81156014)(81166006)(25786009)(44832011)(105586002)(106356001)(53936002)(71200400001)(71190400001)(186003)(68736007)(99286004)(97736004)(6512007)(305945005)(3846002)(72206003)(478600001)(6116002)(256004)(86362001)(66066001)(5660300001)(7736002)(1076003)(316002)(2906002)(26005)(6436002)(11346002)(486006)(14454004)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6117;H:BYAPR04MB5303.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ebE4UYtxkvmezckm0VaB+37fB9K9p2gm7UlNjaG0lKgdeEZIc1q3+/i3HE7UcGNqCnoDKuOQi1/CF+SICFHuj1QeD/vTLQ2UMhsDBffYJmCT586yRwzChxbpYWRK51/DXU3zm8Xgjw3KXH7rQ0v8HWnds4o9JISthiLqxQT4Pn5kYzGfYwzNAvqO2HUWZueLKdy4Qg+phwSEj4YAsLlt0ZQJ+t0FSJKzq/F1dfS2q3ENRIyNCBBqAaKfHc7+f9Ieme8int1ItwB3r56Nhvy5a44uX2v9+D00r6CIg+WylkGnQOXXliDmRT7474YPOtxyqFxrqdkuMnw9JisDZzkwZwD4Tu6PU83MEhyqlZTbAEVF2om+27i5o9HG0BWTF+/GWRy1r6YwKv7DFZCtUblsQ5cFPt0PlvcKP23/U6aPW2g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4dbd326-cc97-4ab1-abe7-08d67e11ed59
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2019 13:27:55.9248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We move free_initrd_mem() to kernel/setup.c so that all initrd
related functions are in one place.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/kernel/setup.c | 4 ++++
 arch/riscv/mm/init.c      | 7 -------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 6e079e94b638..f270adcc678f 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -96,6 +96,10 @@ static void __init setup_initrd(void)
 	initrd_start =3D 0;
 	initrd_end =3D 0;
 }
+
+void free_initrd_mem(unsigned long start, unsigned long end)
+{
+}
 #endif /* CONFIG_BLK_DEV_INITRD */
=20
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 1d9bfaff60bc..f354486f9b78 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -14,7 +14,6 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/memblock.h>
-#include <linux/initrd.h>
 #include <linux/swap.h>
 #include <linux/sizes.h>
=20
@@ -63,9 +62,3 @@ void free_initmem(void)
 {
 	free_initmem_default(0);
 }
-
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-}
-#endif /* CONFIG_BLK_DEV_INITRD */
--=20
2.17.1

