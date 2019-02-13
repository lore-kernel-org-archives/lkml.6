Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4421C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AABF2222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aqMPOXvV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="T0vTWxWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733146AbfBMGc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 01:32:27 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:32464 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbfBMGcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 01:32:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550039545; x=1581575545;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+/p8HkxkueZ7rQ8VzLG/lOFOWhPGN42z3n4YDQTEe1Y=;
  b=aqMPOXvViAZY/6RxnbCQ17RfGATPK9weIg3HJG4AF8E3/fou394goeWZ
   ldt8vpSCY16IJ8z1GYk1SawfgTIVy8/4IN609nqksyMXjsWYJTO4pxfTn
   zxCQ7KThMtJyiTGWYld1jKIKFZluTNIGxHEEHdhILSIQGnO6774QJ5K4w
   bftoe3NILjxC4UPvvkh7aznU8UnnWQeNcbzYN+xxQfDc4SquEIsyWitjo
   dj7JWSyGz0+bJ0kYxVXaMqxWM5OMor1nCwFFIjYCutbrOfZt8XjK807V/
   j/H9lT+VpAwO3ozMMZ4SB2/ebRBiKsu+7arGCY679B6KI9gK0ld1edG1W
   g==;
X-IronPort-AV: E=Sophos;i="5.58,364,1544457600"; 
   d="scan'208";a="102859898"
Received: from mail-co1nam05lp2050.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.50])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2019 14:32:24 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sxx+mlJOnQqF8LM3AFqxTEVHgpOYIFpbc+4AjA3qutU=;
 b=T0vTWxWZfRQq1mBruxLOubJxihzE3BrwOyjfAxksmV6Xt/THlVw2JHvi2rhsGBAOWsW6c8R266BxkYZ8wXQBQn2ExhpmmkHOuCHa+w40eDgMQtKnAjXmPoS67NzWK6BI72ccVxB383h6oYeljPpfUqZtV8r4u2i1GrB2CG5q3R0=
Received: from DM6PR04MB6059.namprd04.prod.outlook.com (20.178.226.89) by
 DM6PR04MB5515.namprd04.prod.outlook.com (20.178.224.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Wed, 13 Feb 2019 06:32:02 +0000
Received: from DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c]) by DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c%2]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 06:32:02 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v4 1/6] RISC-V: Move free_initrd_mem() to kernel/setup.c
Thread-Topic: [PATCH v4 1/6] RISC-V: Move free_initrd_mem() to kernel/setup.c
Thread-Index: AQHUw2XUM0HeGU3JKUmZsgmw0A9sjg==
Date:   Wed, 13 Feb 2019 06:32:02 +0000
Message-ID: <20190213063127.28703-2-anup.patel@wdc.com>
References: <20190213063127.28703-1-anup.patel@wdc.com>
In-Reply-To: <20190213063127.28703-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::13) To DM6PR04MB6059.namprd04.prod.outlook.com
 (2603:10b6:5:129::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7afd3fc0-37b8-46df-590e-08d6917cf6bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB5515;
x-ms-traffictypediagnostic: DM6PR04MB5515:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DM6PR04MB5515;23:Ru+yyp8fRRKgnE+O6K89A+ODEm7aKdJONymiwXu?=
 =?iso-8859-1?Q?B3LmjezHXAvyysRCVr416VCmyYup3z82B3AzVE5YF1E/Qg6C3inBCrEjtj?=
 =?iso-8859-1?Q?0R/P+citeWMsfzTyWtGJzHs5LfuvjzKyRz2vKKOopnukP2405pp5Q2vHFu?=
 =?iso-8859-1?Q?x1GQviuB+5YwRwOppEnz/YkKcRI+aP0i8DzRFB9vXl0yhyjtEF1o3PWgKl?=
 =?iso-8859-1?Q?j3HmdSE7OdSEwp65fNQAQ1fZS38wti8vR2gA4pPzC1FAkEHN2OMhHNX9Nr?=
 =?iso-8859-1?Q?nvNN3muRy9IkwmIv2IHwxOBOHOXeBZz1OHMwDZFSLL8FT0JG20ORE2P4KY?=
 =?iso-8859-1?Q?6bqvz9Qw/BfLyvGVj+AVCFXnaWSNn+Z5AcmN8+lzJ0450ZnVa1S9anU8g7?=
 =?iso-8859-1?Q?gGTqrcGoDaPaPkXhY+LgNSFkWEj+OLNl8W6j7ksOXeyoCT2cVWpjTy3B/R?=
 =?iso-8859-1?Q?iCaH5pvB59Ksj3WAp7T90jb6vUAGZgTIhSPACuv5AqtLTb4OyTfmjGnfYK?=
 =?iso-8859-1?Q?K9KleGwY9NSpzYQP9eHRzi/VizmFIi6crv/D/COqkq4JoH3rByQ38KpTIg?=
 =?iso-8859-1?Q?WSskNWlrzuRhTdj/3DV1frLemXIHjs8cOqoDPhhkhOAw/G7Q+EjSw/ZWcZ?=
 =?iso-8859-1?Q?kGALFcg0o+Qs+l0S9E6ixRPEvpeHGLW1O5lbqK6sxkr4rjupNK9TcRfZji?=
 =?iso-8859-1?Q?jMefbqgHVXt2yyriTIB/AICRqZU2XA1WPtcU6xdHHbTCgd754sLBimbk9S?=
 =?iso-8859-1?Q?sBSxOwyxg4zX+Wxyh8EohAGtVmnP0N9vjLTKkrfa6T9ymg5rxaJBvdZA3n?=
 =?iso-8859-1?Q?v2NfTLeNQr2AzRcQS90PCZsctaNcku+HAlnyiemFIQgNgeTgWkoCvt1Ueo?=
 =?iso-8859-1?Q?lC3fp5JercTEWI2B36EMGuqlDqLI6V8W7o//gc+jCeFRmX6SnaIOw4XpX9?=
 =?iso-8859-1?Q?9g3LcfbT6O9aQe70sqQeyG3Vs9T7kg2i28A93Y5MsnS9Ke96t6PTr2upVS?=
 =?iso-8859-1?Q?YE4HjWsuIBMIgyY5WhJ40PyJb+J0m5Zu3dF3RmGrjfPB3yDmFOBF7F+PAs?=
 =?iso-8859-1?Q?P83RYpVYq5L6ve/FVVEt/TIdLFiGWymBzq2Hc1AIR/PO739lUAYP9IIyr5?=
 =?iso-8859-1?Q?ax7sAnTxyiOJ/ykhUwmNflu+rkAzLhx75csS7ZexmLhGGe2oVmK0TgSAZW?=
 =?iso-8859-1?Q?xq6s80ZRCvshUPFNIEMDN/StPEeBiSdD0J++ksCb/XuMd76mPGO9kBsnEL?=
 =?iso-8859-1?Q?BwZOkUFbKX5AVIec78IM4JHshQ64rLoi8giHS9n9wd4Xg/WIwSEc3N3MvU?=
 =?iso-8859-1?Q?DY9SJTJD2fX0HtBOHLfedpO?=
x-microsoft-antispam-prvs: <DM6PR04MB55155BE91D60E132350187438D660@DM6PR04MB5515.namprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(346002)(396003)(376002)(199004)(189003)(1076003)(6512007)(2171002)(478600001)(72206003)(446003)(386003)(6346003)(2616005)(11346002)(102836004)(6506007)(476003)(2906002)(256004)(50226002)(4326008)(97736004)(14454004)(6486002)(110136005)(25786009)(6436002)(68736007)(316002)(44832011)(486006)(99286004)(36756003)(8936002)(186003)(6116002)(106356001)(81156014)(81166006)(8676002)(3846002)(86362001)(26005)(105586002)(71200400001)(71190400001)(66066001)(305945005)(53936002)(52116002)(7736002)(76176011)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB5515;H:DM6PR04MB6059.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z/+k1kL3m5Ezi+vw8DoPnzd8eDogu4WAijlP41ExbSzZ0t8Cm2IF87iNX9+u2Xvq1tcGZHsFC+rN1C/58ePiIKOqLm41rqOb2PjWy8wsbIY5LA0xzpJGP8LxAE4FH3AQi0hUVtLQN82QoGZ9gtpgBZCGh53JCaiMmz8sLDS52TJ8ycC08qWl1UJCYfuyjVtIM1icZzmXXWpW8ZGVyqwekZpTtJ38hiaSsQHVNWgojk0MyxkPVqJiKVLWfHMg1s73z3ZnX/AEgCiwiSWxsSRLtJrOEOACdJdZrfJz5jncWktEn2JD3KRggzdiaFPZ0GQGwqItZs3zVHWbkl1ZjWImgRmlGR1vxPR0ebjFvdnU8f7uWLph2qc0U3e19OLxAekAvJS+Ii/HuteW0eRULalX7VNzp4b27Jxys79HESvcnK8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7afd3fc0-37b8-46df-590e-08d6917cf6bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 06:31:59.3520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5515
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

