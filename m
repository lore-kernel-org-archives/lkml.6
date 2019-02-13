Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395EAC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15B1222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J6sloyyX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GlMr/wjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390311AbfBMIHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:07:20 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:38764 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729612AbfBMIHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550045240; x=1581581240;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+/p8HkxkueZ7rQ8VzLG/lOFOWhPGN42z3n4YDQTEe1Y=;
  b=J6sloyyXbNU36t6irNEaVvJ5IdHW1v00/zoL7BXQJgptHqw7ZBL5Tmfl
   J4vSuJe83F6+Fp+LqYnlnnnpVcLd8pdkDcPUYHW9icNVAntn0VwU+Vx/k
   LNRa2HsKVUa5VbR38u0KKQeDMiyPSR9+iGtFqFx1ellp2xs9fHU5DMZep
   PTNZQpa9vDny4UWjDfANg4lG+fdspUKtlQFpKVwij8/cHhzG4KbS1NPHv
   8KyL4VJKTzNi4BLSXRry6oq/zmPIFWlcvvCmZTi1jwx/TGYe0R5hKlfbD
   FWM7v5MOF1kWDK65M032Tdt+yoUT7/PV/0Log02YmtjbwHLFM2sHPtbVV
   g==;
X-IronPort-AV: E=Sophos;i="5.58,365,1544457600"; 
   d="scan'208";a="101081331"
Received: from mail-co1nam05lp2051.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.51])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2019 16:07:19 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sxx+mlJOnQqF8LM3AFqxTEVHgpOYIFpbc+4AjA3qutU=;
 b=GlMr/wjMgQajqD9TMlaT+Pf8JbGrF5339wJSA7em9S3d+BsnxAO5O+IpL8XgkT/XZIn3WQt4j1+iXgXSGVJk6yGqTUNp2YJDkZ1J6RWk/cTtW7WYvlwI7RSn1Wu6Ps+Q3zQa25S5E3IWodXUV+4aVpWEvRT8iW++h01z8RHxQfM=
Received: from DM6PR04MB6059.namprd04.prod.outlook.com (20.178.226.89) by
 DM6PR04MB5993.namprd04.prod.outlook.com (20.178.225.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 08:07:17 +0000
Received: from DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c]) by DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c%2]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 08:07:17 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v5 1/6] RISC-V: Move free_initrd_mem() to kernel/setup.c
Thread-Topic: [PATCH v5 1/6] RISC-V: Move free_initrd_mem() to kernel/setup.c
Thread-Index: AQHUw3MilRR/kWU9BEe52TaCNV3UfQ==
Date:   Wed, 13 Feb 2019 08:07:17 +0000
Message-ID: <20190213080647.68204-2-anup.patel@wdc.com>
References: <20190213080647.68204-1-anup.patel@wdc.com>
In-Reply-To: <20190213080647.68204-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::34) To DM6PR04MB6059.namprd04.prod.outlook.com
 (2603:10b6:5:129::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 508153db-2797-4fae-db82-08d6918a454d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB5993;
x-ms-traffictypediagnostic: DM6PR04MB5993:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DM6PR04MB5993;23:09DnEsKmxZ6rw9xAYenst6je1hAG71XYXISVuom?=
 =?iso-8859-1?Q?6I1ABRBcDiAWdgG2G5YrcMHmWmNQoEFTd7l/fS3uJSwJxkle/9PI/uw9XJ?=
 =?iso-8859-1?Q?cGbfgC/c5gtuPBl3hj2g7NbQRmbN5nlk74EKIk77rvXLWqyJ60O5kVFkrK?=
 =?iso-8859-1?Q?D1ZcwclbmODSUaA4t8G9zkEtQyn3YQlx5DMn98wJ12//jWN1azZzrNgmjI?=
 =?iso-8859-1?Q?XNYNCE6+LI7NoeAlablLljHUTljzcmEoCHwm/xtzwQAWfOHBSv1ThDSEOk?=
 =?iso-8859-1?Q?qFwDYNXV8Z8oKgNXaK+z21o8cpPUPE8oZsJtIqIho4OgJPb9IMWt5zFtSC?=
 =?iso-8859-1?Q?KwBh2M5JLcCwVsWbXtW8EkCB1ewd1GICSxR7+sQjtzHve5eabKl/VP7WCF?=
 =?iso-8859-1?Q?WhNrWj1YGqw+4AW6owIbtQmhNXz4h9J90OcVnVW2mrz9Pprh7ow4jJR3Jg?=
 =?iso-8859-1?Q?oWxim1pAPmywCJFuC8VB6FCbWKHxR0okIG4fXXIaX+jAJ31Fa0gwR/rTtp?=
 =?iso-8859-1?Q?sVYeGVnXQIPEBZCvoPVc8dtKZDuKEwhodw3ZjqR9bjXsU/74TKACSR+8pw?=
 =?iso-8859-1?Q?5UV9o423WZo4+wZtvk8ZXF3saZzUWLMvxjMHXPLQBf6EBvVTVZU12cRnV7?=
 =?iso-8859-1?Q?5ttfQVAvb6j9JyFF+eBbHZuD3MTlYykZ8evj0g/6OV6v2zr6kAI2hi89RO?=
 =?iso-8859-1?Q?csCHQ8jSoZUuQNEFZ1Tyeth0/OTG1utOLcVqinL5m/tESBApVumn0mAns+?=
 =?iso-8859-1?Q?KI3Ybm63SEJCjO9HnzCZoCKJOly6xyrfRI6+ltEK56mxFwyn+HQIKtfWcx?=
 =?iso-8859-1?Q?Eq2u8RvZllEvzF5Yut+5O7BMxUlkXbGjur6P7M6cqpypGQ5HlS5QeHgpWQ?=
 =?iso-8859-1?Q?NE6QEn42P0gxRyk11imZzcuBmy9uUW5GSFSKjrku/UUnjNsh7NX6qFrS5Q?=
 =?iso-8859-1?Q?CdaD/wrxmH7mEBwjD3jfAgxHz4NSxyHErq78UcRq7lR/s6MyyuJj4+w5eX?=
 =?iso-8859-1?Q?blXR3TTUpT/rsmQfRbSCalVt9ydbxt/4WtPFWbYcXfZgsSNDlWI9QG7wKk?=
 =?iso-8859-1?Q?6YyuFUoolEeHKg1nQdlYxPswiRtOHs2qgOGYdMqxpfTL3AF4E5Uq1w7YGU?=
 =?iso-8859-1?Q?uZCrLUeP+kCsEsaCO4PSmDh1Cv+io9Xq2VuEnCdTyvFRr3SJHbpaB4LiGv?=
 =?iso-8859-1?Q?kB6qdRGRXRMKa9ge5vANdC0JG4Oj2Rsu1B85qUYsZXX4KrTEoJu5Oja0Ap?=
 =?iso-8859-1?Q?Of1eve1BQz851+ern3NmUKoFbadGIRhNM2rw1aA0+iF6Kxx96njEtk/WZP?=
 =?iso-8859-1?Q?fY=3D?=
x-microsoft-antispam-prvs: <DM6PR04MB599374D4027147CCE210E9BE8D660@DM6PR04MB5993.namprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(6512007)(99286004)(53936002)(50226002)(386003)(6116002)(52116002)(105586002)(3846002)(106356001)(76176011)(110136005)(6506007)(25786009)(256004)(54906003)(86362001)(6436002)(316002)(2171002)(36756003)(6486002)(97736004)(4326008)(81166006)(66066001)(8676002)(68736007)(102836004)(72206003)(476003)(2906002)(11346002)(446003)(81156014)(1076003)(14454004)(71200400001)(71190400001)(8936002)(7736002)(305945005)(26005)(186003)(486006)(2616005)(478600001)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB5993;H:DM6PR04MB6059.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z11LWHjHEHEBeSI+J8R9xnqlPGfFJSp1ogYs3b7s7/Ywdwnid63ZcgKYP3YY5DGY20HL5vQY1mC1AZIiouONY94Yz2VcczOBCCnoOz4sxFEQzQZW/V7ql9/73gEUbOnwDJugSFHHyV8WPuqYhdjIdvzAi36boncUt8w0WCvd7dCFhaEGu/mMYPsTvSUHpf3zPiGp2Cm6YaojwpjSjXisgJMr6R6z9TA/SqkacnRheyWsZPRf3tjdJCqLIVylLb2ABrGdN2dEJCp+xLK0Cxq4ClkUKJdtkwC+roWKWrEbanv6yEAJNjRual4VC+gnupUV/ezCIJg2myuYi8lFffLlOqC1EmCSHiC8ab7ttgdmQ7Z+z7nJQEsr/IoVU/qeReMoqjq0vlW0zLJGVjXb1BA93JbJfONjAbp3MWhhMMtaas8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508153db-2797-4fae-db82-08d6918a454d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 08:07:14.2876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5993
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We move free_initrd_mem() to kernel/setup.c so that all initrd related
functions are in one place.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/kernel/setup.c | 4 ++++
 arch/riscv/mm/init.c      | 7 -------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 77564310235f..36f60b4d2147 100644
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
index 658ebf645f42..504a5e491f5a 100644
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
@@ -64,9 +63,3 @@ void free_initmem(void)
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

