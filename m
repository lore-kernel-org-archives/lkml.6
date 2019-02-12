Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7292C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6924020823
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S6B8Aopf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="I6x34EpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbfBLOBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:01:22 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42895 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbfBLOBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549980081; x=1581516081;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sk3fdN0LwxgJvMgUpwPfeV1OJbFU3WDo0eWIv38YgDg=;
  b=S6B8AopfydDDjUCf3i6k1DiMhPlSE/Q7d0p2w02NDKMgKLg1SY2hiKgN
   Tojmr6zpXsWsXRPzHagmD659YDDS+Hq5ZI9jMnL/BGEUqEh1GhCSDVMzd
   c5gOR3Gtdy3bP/K0sGz7oIUBwy0pkL6dTGuUaq+QVYd0sdGmCR5z8+Thq
   hJQYIwFqmqi4LCatR5M6VWMGtxvxWSN7cGZUh8ckW/aEqU+G601hZe6eb
   tShO+WxZfMC98jaJIZbioqQj5vJJEpNe+CW9m9O38fkZ/LUJVPtBZJyNx
   fGrVWBZWMB1ZacqkoaxWcwt13p49CJVLrtqXJtNa94ES5VZ8vO+uUky4d
   w==;
X-IronPort-AV: E=Sophos;i="5.58,362,1544457600"; 
   d="scan'208";a="102320715"
Received: from mail-by2nam05lp2053.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.53])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2019 22:01:21 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC6FY+xLOBsl1N4zS/biP8WkZqLwzg471RcMRzpWkXU=;
 b=I6x34EpOp3qDR06fTudIPiGYjBbFia5plHluaJodwi5IBkvc+UQjfuRBIqsN2DajVjNELlJAFtFXUQvdX3JrQqmc3TwCZvGevU9xaXbtFQGIfqE1Knxgqik+9Su5n49ocwYxs71xLtNCABFfo4lcmWG0uaRWhPguLn5IBbJylCI=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.247.148) by
 MN2PR04MB6062.namprd04.prod.outlook.com (20.178.247.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Tue, 12 Feb 2019 14:01:19 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::2cdb:c465:af57:8be1]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::2cdb:c465:af57:8be1%7]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 14:01:19 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v3 6/6] RISC-V: Implement keepinitrd kernel parameter
Thread-Topic: [PATCH v3 6/6] RISC-V: Implement keepinitrd kernel parameter
Thread-Index: AQHUwtttaGujNBaGJ026ihx5TuVFxQ==
Date:   Tue, 12 Feb 2019 14:01:19 +0000
Message-ID: <20190212135942.105008-7-anup.patel@wdc.com>
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
x-ms-office365-filtering-correlation-id: 5e0ec97e-51d9-41a7-fe4a-08d690f28fdd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR04MB6062;
x-ms-traffictypediagnostic: MN2PR04MB6062:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MN2PR04MB6062;23:U8Me1X3UFR5HtADcyV2iC1gFXU+lYon36UqrYry?=
 =?iso-8859-1?Q?/UAnYi/o9H8lLqMEY2Ihw3JQd9TXmsRI1lS49iliQ8G+7fP4riv8eLkXJk?=
 =?iso-8859-1?Q?lMH53yk0vcaDjdd14TSTMspNUleBReiw1udZT0oDo3SF5kUSsnW+66bZ+O?=
 =?iso-8859-1?Q?FkoH+nOD2mrv+haq97FPJPdsxgGiNpO3+8adWZyDBeORKv8RwDElvrZgc8?=
 =?iso-8859-1?Q?CJ/rruCi9IhCX88oVAwlIpIpIhEqWii3xjUptDNt4U4oMtjNnrDLGBn43Z?=
 =?iso-8859-1?Q?aLc85TxrIhc05luuZ+v5OcWm0iAO1yIaO/EsQm0Fm4yXZKRS1g5TOFnOPx?=
 =?iso-8859-1?Q?64JcsgPhq3B9pNpG7BK99FzJzJfhANl+VdOFbSd1vHZmQwckwpEWYyeYCn?=
 =?iso-8859-1?Q?dRnzb0sIKNcQOUiSZ3YjRFhlyq4QrgFtIgzz6U7tFOvf74L77dxkNO1CgI?=
 =?iso-8859-1?Q?SFX+2nLbMGH4SvxKmfQdgWoG0xERSZub3/Q/kc37UhdKHfLTL2p3mcBnsh?=
 =?iso-8859-1?Q?hRcGRo5QVRH7M+q2Xsvw8bWwbsSuRySLCQW6EIAvrRtkSE395/UjnXiYzC?=
 =?iso-8859-1?Q?bv9navkS5UiHTloYMvjIrZKprt1ff2Od1AvaP9HpJ10B0tLcm+GH0FONd5?=
 =?iso-8859-1?Q?AIeJcbwmD95XyJFawwisEsuRbV6udyWWtTT1hjGF5O/Fh5pEOoj2TFSmxw?=
 =?iso-8859-1?Q?dH9zhWtNMDKYwtzhpnKF9w7L7arrHWr3JmLkNkPliC9KZLQlAllw8XxixD?=
 =?iso-8859-1?Q?EsL/gPe7ehTQkP4fzUfeaAjF6DYOO/tajjP7WQmXvU5fv4iD+33wojX1dT?=
 =?iso-8859-1?Q?ieey2VC6zZlN5OjyzthkMko9LdPGjBDiSVAf9lhUzNiIxB5JXXGdBIyoHb?=
 =?iso-8859-1?Q?BULM8zeiATZzk5jJ+u10DaoQZFQExJU7B2KhO8O/JNBAfuhpZtefrzWC/G?=
 =?iso-8859-1?Q?9mEuzSi5LQ7FebKUVlyVuBbo2Z3DKI/9LaWiv3ranw3rSz6e+Nz/bn6DGu?=
 =?iso-8859-1?Q?D5kUTkvxtT8zhbs8Yp1mYV/vVjZKmPbrKQOkf0dkn8kc6TUbz/ClLmUveM?=
 =?iso-8859-1?Q?r6ZQMDC0dEmWTBDSGYLZ/G8Q/3Xkwt47aE6mtXM3H96MMrhFeDacxt2j7C?=
 =?iso-8859-1?Q?OLLMLkH0ETGTUFK/YPIMP/0klvYf8JebQbH1GIUbiSAVge4Rvg+2pWrNv/?=
 =?iso-8859-1?Q?JX9bLHMb+7AnunKzw0DPXKUdvbv2I2dDrR5+AoyhSYYy/+RMxfAwuawGwO?=
 =?iso-8859-1?Q?nyOJVDeUOiAbohaz26dSCo8tiNaIm0IQgp58XzTSjGIlJmr257W84JpS2M?=
 =?iso-8859-1?Q?pckGCSOvsE/gQ/QQsIuURvjhOMTNkikvFuWWN7JSKLbmg=3D=3D?=
x-microsoft-antispam-prvs: <MN2PR04MB6062D64DD53A26F811D0394D8D650@MN2PR04MB6062.namprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(136003)(366004)(396003)(199004)(189003)(8676002)(2906002)(81166006)(86362001)(44832011)(50226002)(2616005)(11346002)(106356001)(446003)(68736007)(316002)(53936002)(476003)(81156014)(76176011)(105586002)(25786009)(486006)(8936002)(14444005)(55236004)(14454004)(6116002)(256004)(4326008)(36756003)(3846002)(71200400001)(71190400001)(102836004)(66066001)(386003)(52116002)(6506007)(99286004)(1076003)(186003)(6512007)(2171002)(54906003)(110136005)(6436002)(7736002)(26005)(72206003)(478600001)(305945005)(6486002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6062;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4X49z4u9GRfKePYOMv6bSyPFVg9Vs1+fxfCAsH0zFHJ5gvgZoL+rpIrqpb8i+ED8C8OV3v4fI0klH6fOe8ira+KDK1TsYnsJxZKI5+qCu+Scz43Or3PDBJMjI0UZYXid6CT65cQI0ereJl3QaE8oBYKK5lGp7Pc062DoJhRX8oM6lPjXwSuNnlq4BdDc8kDyYyyrnt6srUZ3BiKwuLFgygGFbqhZoCyLg13cH02U9/ZQ3nv6hF7iayu64TEUJl/2hj9BLyZ01oEaTzpUes+TpDGGHA0DIpf5TIQQ6B9wbYPcHdaVnIfvJekaB4rEu/zMJ4X8+DMLIB8hm5bT81nUFS38MbT/dVT7yGmfocUiRSDmugys71IpAHCKLIxssQqdjm7zXCAQMPtVkydtJ+DbeNN1hSuGORL0qkPgaUML+c8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0ec97e-51d9-41a7-fe4a-08d690f28fdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 14:01:16.5492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements keepinitrd kernel parameter. By default,
keepinitrd=3D0 so initrd memory will be freed by default freed but
users can pass "keepinitrd=3D1" to keep the initrd memory.

The keepinitrd kernel parameter is already implemented by unicore32,
arm, and arm64 architectures and it is documented at:
Documentation/admin-guide/kernel-parameters.txt

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/kernel/setup.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 9cd583b6d1cd..46e547dd8245 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -97,8 +97,20 @@ static void __init setup_initrd(void)
 	initrd_end =3D 0;
 }
=20
-void free_initrd_mem(unsigned long start, unsigned long end)
+static int keep_initrd __initdata;
+
+static int __init keepinitrd_setup(char *__unused)
+{
+	keep_initrd =3D 1;
+	return 1;
+}
+
+__setup("keepinitrd", keepinitrd_setup);
+
+void __init free_initrd_mem(unsigned long start, unsigned long end)
 {
+	if (!keep_initrd)
+		memblock_free(__pa(start), end - start);
 }
 #endif /* CONFIG_BLK_DEV_INITRD */
=20
--=20
2.17.1

