Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1144CC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94DB222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p9ay4t05";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UQxrw5r0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404020AbfBMLy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:54:28 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:65219 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfBMLxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:53:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550058821; x=1581594821;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BugnXiiHSquLMITdS4N4nCW3CaOWl+ENENqHgGEP1co=;
  b=p9ay4t05ZxS+Wf7TuRPjOMe2CuZobhgo6BHYBExmkXGUDlrRKnVDuKtB
   0930cVc1UBUnH5LW3KstEvghvPjGcNn5S9aMAPA1+zdjSW7HLTfW1EhUI
   7y8iSR3Syeu6LVjnBnjj7K7T4jpDlg6yfhIl/keNzYdOHIvPGvvvmLzS5
   t0ot1JzwYSyvjTErUBriTKhVSqoRyKpg8ZoKncdVz+0ocUVKxi643mGco
   po2nImDXAQBrPKxh4e2yNwl+noton1++BJDhoe6yErF/4TNIS3RlI094q
   Blj6xBPlmSP+XnfNUGGsrqYmjPo+PKvXyB3oWMvnDJ88QpbNDnC1HSQNS
   w==;
X-IronPort-AV: E=Sophos;i="5.58,365,1544457600"; 
   d="scan'208";a="102883425"
Received: from mail-dm3nam03lp2055.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.55])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2019 19:53:34 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iavg7vVy3aEZO2x3AbiPR7yXfQqOvTeZkm7ohvI5WJE=;
 b=UQxrw5r01V6QuEdNylW4UOd5L1+wYddnRTFTuMQ9RilBFcCso7+udgYF5dty5svPMtidd3q4R2jmEW9oYb78Hev5voSXPuD2DOe9TFZsH2b7tHO2VMYSBn0h5F+Zc+C1NceX6leQcpvLulnEvgp1m3fw7v/VRhZ+NhDOFSxHvm4=
Received: from DM6PR04MB6059.namprd04.prod.outlook.com (20.178.226.89) by
 DM6PR04MB6171.namprd04.prod.outlook.com (20.178.227.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Wed, 13 Feb 2019 11:53:33 +0000
Received: from DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c]) by DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c%2]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 11:53:33 +0000
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
Subject: [PATCH v6 1/5] RISC-V: Setup init_mm before parse_early_param()
Thread-Topic: [PATCH v6 1/5] RISC-V: Setup init_mm before parse_early_param()
Thread-Index: AQHUw5K+eETtQHy410+MMjhdKr9Y1w==
Date:   Wed, 13 Feb 2019 11:53:33 +0000
Message-ID: <20190213115301.103989-2-anup.patel@wdc.com>
References: <20190213115301.103989-1-anup.patel@wdc.com>
In-Reply-To: <20190213115301.103989-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::17) To DM6PR04MB6059.namprd04.prod.outlook.com
 (2603:10b6:5:129::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [49.207.52.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2462f792-35fc-451b-f688-08d691a9e0d2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB6171;
x-ms-traffictypediagnostic: DM6PR04MB6171:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DM6PR04MB6171;23:rkfe2+f/EmvWnxrvl29LIQCdmQpQ4qlLBwDf0UW?=
 =?iso-8859-1?Q?MyiHyDJS0yxD1jhes1A07x5Mfu9mB96EGBiSfvkhAi4EZCnaV9A2xOzK9d?=
 =?iso-8859-1?Q?Db+o5XYkrjxHywT5ZaWym6MKdLsVX3EUlUVqOGUB3wrW5xsnKjOSKxQV8I?=
 =?iso-8859-1?Q?zctppw2nwL2iupxLCjrkfxjHeRs4W1W/M6X6R/HyOibZa+JxEBWc9PizT9?=
 =?iso-8859-1?Q?Wd8NdD3/cGvuCsevjZO1QoQjoAnz5sEKi6E28Uo2MPyeuyuNBE2ieWuRQ0?=
 =?iso-8859-1?Q?6lNt7m7QHYaR+FEVsme3VOPAY+LEWMVvBuDFlcGrTnuLpklm8zLUqo9Kd7?=
 =?iso-8859-1?Q?bJYSVXeihg3Dy2i1e9mS2uV78Az2fNLCknBd4o5/xmUtpM0qMDB0YABEBW?=
 =?iso-8859-1?Q?dyUiV390t/t/pVIhFojRslQRI/Q/Uy07ifBDI6tHF9SFCggi8jMA/iIWsx?=
 =?iso-8859-1?Q?ixrftBdfcviSq/Z5IUdsn9WIUSrlKWaK8Ec9+94HTtLNgpNBriqBUz0sHH?=
 =?iso-8859-1?Q?xDfAs5CT2lvKl9l6KxS4DjYkMAF3ffnjuzmTpLwK0AK7WEqqlSc9Ldn4cd?=
 =?iso-8859-1?Q?Z9WHALuxOo0Vq/b9AsFP0eMZNRzw0Wpc6RTanflrH8bDzSRe292qlDmbdt?=
 =?iso-8859-1?Q?5Vjq1Vp+IvXLCfJQsIZq7KOdmPcNVnqzOeyTKntCgFQqxstylqwD/Ywogw?=
 =?iso-8859-1?Q?s0n3SkMFh+ZLOiW54oOmqlSZJTaDPNn0hrx4eJP1oABES56ddfHsL7pbAL?=
 =?iso-8859-1?Q?SKUsOlIhwSCfSdCTsIqCroL5hrjX9KiSqqlRJcjxxNxv8sZxK8zjBTVn9H?=
 =?iso-8859-1?Q?e7zCeG5h4PtGBpyGc5jnTni8o2ngBDDvfjzOXl/++frtYevzey/6YBeKSs?=
 =?iso-8859-1?Q?A+m9/qtabmSAaTRi2oTevYLxBaboHWRKD0Mw50EvdTiecRzxCUwKmMnzja?=
 =?iso-8859-1?Q?+oZ408xBo4xtjpfAauQg7NFNNmoXztDHsp/wJHMAgcfKX8pYzrwSQm6KYe?=
 =?iso-8859-1?Q?Gp/dcNjcoNPhKFp+HP/7LP6qKI+vQw9SZaB4Yu//VRE316YZpm5tiZByX0?=
 =?iso-8859-1?Q?1ubG4OXRq9OG4DTtn3VVezn/cki7WQOZDLXNCKiQ0PL6VQksIbVFpTrpEA?=
 =?iso-8859-1?Q?7Lg+kbYxjK1wnI0XPpbRVepoY/QaNrVzh0icnIhMtSNVl2rm6LvCn5+zqa?=
 =?iso-8859-1?Q?wtR79Tr/l3YQy9fbzdR1uYD1ywuNTxoj+lgvmhcTXlrxhKKvtmzMkQDXvK?=
 =?iso-8859-1?Q?qqHxG9c8+S4ZuSd7wxPy5g6DvlzZC2CZSaQ3zo71V9XS4WGUuE/lTrTY5T?=
 =?iso-8859-1?Q?z4s6Jk6HlYhrseCAMcAPsDj?=
x-microsoft-antispam-prvs: <DM6PR04MB617106EDEA866E204A6DB7E28D660@DM6PR04MB6171.namprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(52116002)(4326008)(66066001)(71190400001)(76176011)(316002)(8676002)(6436002)(106356001)(6486002)(6116002)(71200400001)(105586002)(3846002)(53936002)(386003)(44832011)(6506007)(6512007)(256004)(55236004)(97736004)(8936002)(54906003)(478600001)(72206003)(305945005)(26005)(102836004)(446003)(186003)(68736007)(1076003)(14454004)(81156014)(81166006)(7736002)(25786009)(99286004)(36756003)(2171002)(486006)(86362001)(11346002)(2616005)(50226002)(110136005)(476003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB6171;H:DM6PR04MB6059.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ROjJ4sd8oQgPb/rR042naiRtbFdJLWJL7aD0WyYxdWY7SS5DCE965/pne+18GYxL5g5jQXCmjMj8VxaQW7oAl5K//W6v4b8XD7SR4Oz1XrGYAccz33ORSmI80foSz8slJV4dtTUBDOJeNIFkRM6k8rbOTqljIT2DQOt94ghKLXNgXYNiKr8F0VzTKywl3x/EkLgVDNbBUmaGjZcujSmckiA1UUZpob1EIymhgniqktSKdRgGQQ4+5tIM1mCpLcRrXeGsTjqxwnE0oceOYZ2iueY4ljjXZF+uKdRfvoS3nI6EAX2GY8jszlytau8tG3teWtoD5aq+TxL4mebNab1+QbaOGFdSb27mjyGZHETyllVRGIJThXW9/R8FSdkQZmFQHu6XxmsHI7rTsoMd+nOrYwoHX9qz/EomHDtfy/dQRsQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2462f792-35fc-451b-f688-08d691a9e0d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 11:53:29.7426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6171
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
index 77564310235f..c6e858122815 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -204,15 +204,15 @@ static void __init setup_bootmem(void)
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
@@ -231,4 +231,3 @@ void __init setup_arch(char **cmdline_p)
=20
 	riscv_fill_hwcap();
 }
-
--=20
2.17.1

