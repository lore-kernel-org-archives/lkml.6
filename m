Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5BCC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41BC222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="r23/9/z2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="m/oukO1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733161AbfBMGcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 01:32:32 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:32464 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733119AbfBMGc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 01:32:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550039546; x=1581575546;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h25QTCPdlhMfqtz+zmztEhyRxhdRVXagsuYHINwV8lo=;
  b=r23/9/z2B+9jqkj3oxXI/Ko45pLaUzM9c9z9+e2gLo2hF2yyeiAWo3QW
   hRXvXrI28Hvd3jOM68MG/VCxXahY/2WQ6ZipG3Wc0cy0cdoulD8OTo232
   yZDIYZYx6z8XPtx3YVmZNm1vMQ+d5fX8nvhluU6Qy/lbG5Jit8UTpxXKR
   G6f5nEpeOkMfUx/02dGPGqCP8Cbrd/a+iKJRsqtRvCdIgx3FKLPrzFLRe
   7VqNKBhDMj5j/5HC2X/ILr/fRf+3psk247wgHD5S6RG1UH+3EsA2s8z6x
   rxDxwZdC4o4Kh9kE+5xNzSzpGGlmNxYO2OKL4QQl9CY7PCb4b0vjvlHb4
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,364,1544457600"; 
   d="scan'208";a="102859901"
Received: from mail-co1nam05lp2050.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.50])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2019 14:32:25 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8qCA2Iv5UJ1d1yEkinn+T39/F/zEuxMl5ljAL1ZXGM=;
 b=m/oukO1MXLU7grl9pGZVN8I2FUBamNt5QjLOayGTVm80CiW6ckS6o+UFz6HK0QA6CoBVHj4s11n87w5YrZZWp+Hw02aUWci8Q1NTmwaL1NY0jZZa6O1lJPsr1mGtFrZ5UaqXXVljl8l/UTKimoL5mYQfr1TQ+TxQbzOFc8rJLuY=
Received: from DM6PR04MB6059.namprd04.prod.outlook.com (20.178.226.89) by
 DM6PR04MB5515.namprd04.prod.outlook.com (20.178.224.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Wed, 13 Feb 2019 06:32:07 +0000
Received: from DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c]) by DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c%2]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 06:32:07 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v4 2/6] RISC-V: Setup init_mm before parse_early_param()
Thread-Topic: [PATCH v4 2/6] RISC-V: Setup init_mm before parse_early_param()
Thread-Index: AQHUw2XXY56X4eWHMkuwX0WnD4R8rA==
Date:   Wed, 13 Feb 2019 06:32:07 +0000
Message-ID: <20190213063127.28703-3-anup.patel@wdc.com>
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
x-ms-office365-filtering-correlation-id: 5ed4c8e0-c26d-4f5a-47ba-08d6917cf972
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB5515;
x-ms-traffictypediagnostic: DM6PR04MB5515:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DM6PR04MB5515;23:zJ0fRm00/9MUwR01jnNrYGUu+B/cpT+BI7OX1VY?=
 =?iso-8859-1?Q?8lhItQ5soJX+sYeoBeQ67k/sSDN8fO8M7zGIdsfaOY2/grKKH93tRG/iBr?=
 =?iso-8859-1?Q?KVsNfGevV+if7j6FSgrCjzRizNY5KR7we0WT75yiLE82sAPdC61PnNxbb8?=
 =?iso-8859-1?Q?31llYn4cI0ItrE1F79R22DzDHxr5Cc148+cRPyomeZ+IJukoBSJo8jBQB1?=
 =?iso-8859-1?Q?r61J2i8iDRz1JqTCUngEtsj5YQlJNaHSiGtw7JESlEEgmLoVSakHp2YRxB?=
 =?iso-8859-1?Q?8D5F32BsZ1cfQWNmT/FiuH/KlglUnDZkP7QwpTsmcubybKSxbzewoh1iib?=
 =?iso-8859-1?Q?fic+GNFSqbduUgPEc2xH22B9Quxja1nWSZ37qi7XF7vp35vxX9IyDl9ms3?=
 =?iso-8859-1?Q?ZkkhfBJtkh0s/vQcgajMmVLQTo6YwI65plZH02P97h+CB4eaKXD9g8RYN+?=
 =?iso-8859-1?Q?oAxuO8i6QBSxhJzqAEzCM7QmLzGOWG/q60tHloujHMkW5lnwXOaBrdt7ll?=
 =?iso-8859-1?Q?gpYNeejrk5cODbpP5iZYDdyeyQxRPur0bf9A6nvCgGMfvRjD4mFfk0e7ks?=
 =?iso-8859-1?Q?UT3JyJWyYHGnL/1WVY54sGUHG7YIAXXNuOvO1lPP47t/+ThWfsz2/mjDj+?=
 =?iso-8859-1?Q?IMrS4aeIyjWg0qNNMxbREtTC4HN+NyE5fYbV4SxW4dyKGTCRps2Ba6OtsZ?=
 =?iso-8859-1?Q?Uf+w8EwY/qsUdKkgv701XRQxXsdjvgrp8v9H0N+F5JKp+ZMCgPwA83K/CN?=
 =?iso-8859-1?Q?LfNTWbNIm7NT9dnjKIpu/TWy2MtvKlSL/gzDiPQvGK4tzoPfojga7KtLkW?=
 =?iso-8859-1?Q?/va1t20jchk0g+K8vxjRYf8EHNELPqAmttsa7idHTjDlPnhwfXxwBNUyhv?=
 =?iso-8859-1?Q?XxjAwTSlo+aMqUfdyaV7yt8wjYKbWouxteNw1QN76hMHebIQD0+afIxBsN?=
 =?iso-8859-1?Q?03vt4QMaufUdQHbozw4+soGnfUcyljli48KNPDrs97xeocsluqLuKisAht?=
 =?iso-8859-1?Q?gMbOwMq4y3nK6KwRwaIEO+TU3WAtXx15s+7uoPG31IB9AZtqgj0Kzuem7N?=
 =?iso-8859-1?Q?7xF+WOdCcbxKf4jzyXnQVIp730WmoOuv6im+7uonlX6KRyKy09Y0bklYmm?=
 =?iso-8859-1?Q?qedio6t3uSYKsx2vbk8r5DHG8wV8zPDXeJLRifD+Wqpchbz2uce+RP3+72?=
 =?iso-8859-1?Q?aAeOGPYXmF4GbvD339XnmlwpAyVvrnsKvgkveUMg88K1QLM77Xza7dllFh?=
 =?iso-8859-1?Q?BbOQctUeLlca5i9oGwiw6cO3XT0k9H5j2qR94yLdtEbSJp3+l5ubTMTVmc?=
 =?iso-8859-1?Q?FvAK08fhtuIOlIFCwjEtD2l?=
x-microsoft-antispam-prvs: <DM6PR04MB5515B33C63BC65B3369D68D38D660@DM6PR04MB5515.namprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(346002)(396003)(376002)(199004)(189003)(1076003)(6512007)(2171002)(478600001)(72206003)(446003)(386003)(6346003)(2616005)(11346002)(102836004)(6506007)(476003)(2906002)(256004)(50226002)(4326008)(97736004)(14454004)(6486002)(110136005)(25786009)(6436002)(68736007)(316002)(44832011)(486006)(99286004)(36756003)(8936002)(186003)(6116002)(106356001)(81156014)(81166006)(8676002)(3846002)(86362001)(26005)(105586002)(71200400001)(71190400001)(66066001)(305945005)(53936002)(52116002)(7736002)(76176011)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB5515;H:DM6PR04MB6059.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z5K61Xf4Kf4a0zlwo1cfGlFQKMyi1Md1daORb9HUwnsHXoHAgf93qvQjf8NqxbITj6DhMzOOZCdbcnvoWXdeOj2WIkpGtkDeWZeGGSa4I53xnupstcNYpBOQq6uycEeQtjR3nzddRtR9tBaX7i2Ia62A2OMA5JqfvJIdSoARi/j2HY/p3OpSLZTC1nr4e3ubKWT8dj0iMLu0tdz6/BQKPPWGs4VMA0hMTexNvEJ3B4GCHccYijVY1flV7qOs+25XI5Hl3fshdCT+Lx+4rJ3g+ttDuIu655f9vcD8no1V8jpT7eKKVgJZ4Unh/jlwgE73CMR0E1CU3eovQLdUzjHxvFPrTF55KoK2rm6nz9koFW66hC2eJdIWOvkdIpb1KEVsNGggMMqv1bcwuUgt+YEPosw0ENGh1zFpM5248R/Ofdk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed4c8e0-c26d-4f5a-47ba-08d6917cf972
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 06:32:03.6391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5515
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should setup init_mm before doing parse_early_param() in setup_arch()
to be consistent with setup_arch() of other architectures such as x86,
ARM, and ARM64.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/kernel/setup.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 36f60b4d2147..9e6395b7d409 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -208,15 +208,15 @@ static void __init setup_bootmem(void)
=20
 void __init setup_arch(char **cmdline_p)
 {
-	*cmdline_p =3D boot_command_line;
-
-	parse_early_param();
-
 	init_mm.start_code =3D (unsigned long) _stext;
 	init_mm.end_code   =3D (unsigned long) _etext;
 	init_mm.end_data   =3D (unsigned long) _edata;
 	init_mm.brk        =3D (unsigned long) _end;
=20
+	*cmdline_p =3D boot_command_line;
+
+	parse_early_param();
+
 	setup_bootmem();
 	paging_init();
 	unflatten_device_tree();
@@ -235,4 +235,3 @@ void __init setup_arch(char **cmdline_p)
=20
 	riscv_fill_hwcap();
 }
-
--=20
2.17.1

