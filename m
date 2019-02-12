Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCDEC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9EA920823
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YpNW7JlM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="P41l3QNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbfBLOAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:00:24 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:45616 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbfBLOAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549980023; x=1581516023;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vN8txHa9eKbHp7FQJ7smEDvEdJGYAGARBV8FGwbfewQ=;
  b=YpNW7JlM6jbSEko6p7yX/PqgRyYFfOz8JwqXSdvwFIA/7snHDrNx0LKk
   X4KiVq/NP7eU3Y/xzAgLkVOmrgz40GGyn7HWeg+/mk//yXvt++h7FZANU
   +vkEhiQcSF+cUijFaoeaXB7tbH9gfZKI5FHBiHMof8DldBz6fDTmJ3y19
   wY7acJXN8rl0VUB7KGjc4nloT7hF7ZcSW30/UmL4GvinHeVV20r+B4ZCM
   gcxZdtbs1SqWd/VNzMgD77/M8Qc9oWJ/M9Pq7CcHvrgZYYj5+DoGeHwSn
   7ICJH0qCiqCTBnCj0Iud4bt4zhfr3zLp4lm3ZxvxIG4g39TNfz8fZzLgM
   w==;
X-IronPort-AV: E=Sophos;i="5.58,362,1544457600"; 
   d="scan'208";a="206165797"
Received: from mail-bn3nam01lp2058.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.58])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2019 22:00:22 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71ZzPWQxZILvR2Jm5FIM90PuiFR9mOI/0ZWkIZRe7aU=;
 b=P41l3QNJma5HOGnCl+oa+w5DYqAUo83pl0rWHo4VQQBNOQMzXmwlK6CxvHbRclh4zxEJG/ultCCNlzZtvHWqvSJUs6untuAIP7ra/1H/48LcPVJUN9/O/Sci8c1IJE1vKMOCeDFWi/bWQbUxI943M3E+lodjZZOn20uORg5N5aQ=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.247.148) by
 MN2PR04MB6062.namprd04.prod.outlook.com (20.178.247.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Tue, 12 Feb 2019 14:00:21 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::2cdb:c465:af57:8be1]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::2cdb:c465:af57:8be1%7]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 14:00:21 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v3 2/6] RISC-V: Setup init_mm before parse_early_param()
Thread-Topic: [PATCH v3 2/6] RISC-V: Setup init_mm before parse_early_param()
Thread-Index: AQHUwttKwXHCxLSmn0+7Lx/MnaLB8w==
Date:   Tue, 12 Feb 2019 14:00:21 +0000
Message-ID: <20190212135942.105008-3-anup.patel@wdc.com>
References: <20190212135942.105008-1-anup.patel@wdc.com>
In-Reply-To: <20190212135942.105008-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0126.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::20) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:de::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [49.207.48.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e34f63d-4bd2-4034-54ab-08d690f26cff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR04MB6062;
x-ms-traffictypediagnostic: MN2PR04MB6062:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MN2PR04MB6062;23:0mhnT2oxJraaEGSbckte0tnsxgNj3NBsEqN/1+E?=
 =?iso-8859-1?Q?WLmilUOy9PuO8NLrO9TQrUgQiyHOyiHxHS/+1mT10luB+udrmLFtqktOF7?=
 =?iso-8859-1?Q?ovyk1UtBuvx8KKS1qb9Mjp4vJHgqfyHXKQsmPLJCZc50gKi2cdJsqphGkn?=
 =?iso-8859-1?Q?Vz020/4KqChYf9mS9M16hLdMqsEw5KeZzsNdOEtDp6Dl0l/dSkRPHAXemU?=
 =?iso-8859-1?Q?mdT0QUDmw2bapXmx/2SYd+CN3AA2qStGBVWOC4iNy9qWosqxreX72QVDGQ?=
 =?iso-8859-1?Q?eaZebWgKFksv9re/nCAOvfhGPzGttwn2Z9kgHB/H0EpyWKBKXQgrA6zKeT?=
 =?iso-8859-1?Q?ZNkUmLNMr48Je4LzgRTQzPtizgID0L4oZmwlO6XFivsuPSOL6ni7kswDIY?=
 =?iso-8859-1?Q?nOHsCiTC8hGC5ZsHWUmSIM65CLQM1ePv+oZd2sx9EH57rerCi/eLBSHXnl?=
 =?iso-8859-1?Q?gr+HcK56Oa9Gtm+FqBGPlf+ZNjWRlUJNjc05M8W/bTuf2Tmj7ntMivX2I3?=
 =?iso-8859-1?Q?2wGh9DU/ZTeGhEvm7dO+SYRLPo8pXzADhWKI5CO7dI2PFuoXKtymr3lHpW?=
 =?iso-8859-1?Q?AOkWRSQNOc3hFg9J3mnGqHoqLwhDyc0JQogym3ImvqowvGaAS3cYxjcoss?=
 =?iso-8859-1?Q?6gZmcNFgvlRFiKYt6nmCqvpT50MPNJoYod6elB2epnInJZXlCQoTkCY5Fs?=
 =?iso-8859-1?Q?xYcKQ6yt3n+GLTJIc6LsVGsbb1uJAYKKGRCZOT1QZff+VQ9QL6Ehr8PucK?=
 =?iso-8859-1?Q?jividrThrKAr9E3fgFnl112eOAy6tLuK27KFy65bb9oMF4FMKcEj8yOHDQ?=
 =?iso-8859-1?Q?J8VT7M2zV15pB60mPfrFz/ecj8Uuo0tMP+TmQiI0/p1syOlKSQnAFOLzBr?=
 =?iso-8859-1?Q?06wMnXtfBv9EybGyu3ButLZe4sg9z7iSdbNu7sDDibDYXyR7ABaSd0GIo9?=
 =?iso-8859-1?Q?5+Ru74JTx6mah+7UnJ8uGh2STXDGi2V1d0kI29HB1qJVlmsQTSzphR1fyh?=
 =?iso-8859-1?Q?mXDmTA2fck5KouEsrzynESufdxugEMrnsTNmHBvN5ph5712kT6uvhOJTxZ?=
 =?iso-8859-1?Q?X+FLOaIZs79BIOcFm+jqgGXiFEmX+6iRGmvX0Q54sMmWVGhQksT+M4ZpBS?=
 =?iso-8859-1?Q?vsRNeV6+1BQldMd72AVUHhKJZ1K0zGD0zf89+xzsXX7JDG971QAgs4cE8F?=
 =?iso-8859-1?Q?8sY54WfTh1u/Fl6UbfHwzfKrnmJCZJFXgSUoVg4uf6GWW6rW/SQvJsK6Z/?=
 =?iso-8859-1?Q?tboY8jKHtH5wKVROsiLxumdPz3sLP2/24lD3vXlkQbXNCBlNWjjxhjiYxY?=
 =?iso-8859-1?Q?51LOTpGx6MxtBsrXmei3yTN?=
x-microsoft-antispam-prvs: <MN2PR04MB60628A855C04626EE09D91218D650@MN2PR04MB6062.namprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(136003)(366004)(396003)(199004)(189003)(8676002)(2906002)(81166006)(86362001)(44832011)(50226002)(2616005)(11346002)(106356001)(446003)(68736007)(316002)(53936002)(476003)(81156014)(76176011)(105586002)(25786009)(486006)(8936002)(55236004)(14454004)(6116002)(256004)(4326008)(36756003)(3846002)(71200400001)(71190400001)(102836004)(66066001)(386003)(52116002)(6506007)(99286004)(1076003)(186003)(6512007)(2171002)(54906003)(110136005)(6436002)(7736002)(26005)(72206003)(478600001)(305945005)(6486002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6062;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZGGqylWD8RZ1iXaZc4a4DAmj1PbmlI6yPb0TYqTsikxjR1Otl9ClG5UdiNqxeu4CSu/FEdTDP5HR+WaIHVnQcY4j6q8b7RJOG1vX+n8KKh/95EkyoCGGwPwxK3d0DOrM1ShFvrawRiY1M40BPjD3fro0/xhKkZOvUgKxyeaEd0x9rtxQ0QePqJGoBOyZxfofxZFv22xDxcuTFYf63YnQ7V7nnzoSgIo7jNDS0sfYvOKKWJ37BGnR8XwbqDIxlH/RbPCYzIGfhaKnGXeoAjk939288Ruz3zmHscAqYmCnIjOAP14NejqoUYRWh25kldPSKoSnmn5d5HnvPt2+ytx2gi9XlE4C8hD1fIuEqe1ekvvB8IRe7ejC+OQ1zJw9rVDFHBmBTOmrLGxkF857n8Ho0YDO3yv/XESzOWeSm0yqEWQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e34f63d-4bd2-4034-54ab-08d690f26cff
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 14:00:18.0284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should setup init_mm before doing parse_early_param() in setup_arch()
to be consistent with setup_arch() of other architectures such as x86,
ARM, and ARM64.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

