Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B61C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC296222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KEXRavfu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Hfj0Twx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390345AbfBMIHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:07:30 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26081 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729612AbfBMIH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550045249; x=1581581249;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h25QTCPdlhMfqtz+zmztEhyRxhdRVXagsuYHINwV8lo=;
  b=KEXRavfunNphl6o7whkbKGQXNPhoLnvFxh5qeVJRIs32LgWbBTxH1P/r
   IvHpz7R4zNjG5/z/pv+Ig7V7MPOQDURhiZmRdJ/bqK0zSOQ68U4rEfJTU
   02SzdM34n4gOD6bc1aM625wU4VUtltiTucoMusNuAoR5IGDZH2lMoYO1x
   ui/cZt8tObG/kcdlPR0wZR8PZqoianF3EAkSNijdrwrSS/sSvnEt0bGXq
   W4A+wK4v/634esr24YgrEsI3iemNzGoTe40oMYK8TUJ/1M1OFlqrmickE
   oDjhIwbzEsgWi+jcFn1VxtWUe3zv/WSfqNqqYoh9YQYOeOP1i9Sugxk5J
   A==;
X-IronPort-AV: E=Sophos;i="5.58,365,1544457600"; 
   d="scan'208";a="102402297"
Received: from mail-co1nam05lp2053.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.53])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2019 16:07:28 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8qCA2Iv5UJ1d1yEkinn+T39/F/zEuxMl5ljAL1ZXGM=;
 b=Hfj0Twx0LROkyOranho1twaEmTrd6cXIWErC1TRuA8KgVJpYpGZiR3jAFR/Iui1cIDTR4/jWrSkm/ER3nbBsqoaE2T12Z0JeAUjk36vPBkvN86BhBaNLn4SgBraqnun/csa5U5xnsGcrxqzv2rXU0BliTxNTMVEcmJKrvA4D9dc=
Received: from DM6PR04MB6059.namprd04.prod.outlook.com (20.178.226.89) by
 DM6PR04MB5993.namprd04.prod.outlook.com (20.178.225.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 08:07:26 +0000
Received: from DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c]) by DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c%2]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 08:07:26 +0000
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
Subject: [PATCH v5 2/6] RISC-V: Setup init_mm before parse_early_param()
Thread-Topic: [PATCH v5 2/6] RISC-V: Setup init_mm before parse_early_param()
Thread-Index: AQHUw3MojzWUPEGlyUOTNqeH6ojcbA==
Date:   Wed, 13 Feb 2019 08:07:26 +0000
Message-ID: <20190213080647.68204-3-anup.patel@wdc.com>
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
x-ms-office365-filtering-correlation-id: 2016079c-fd96-483f-dbb5-08d6918a4a4a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB5993;
x-ms-traffictypediagnostic: DM6PR04MB5993:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DM6PR04MB5993;23:dRkXvadU4amHWoDZW6zTrM5nkYAmyD6a+4lxOkc?=
 =?iso-8859-1?Q?hbemWWGUfdldLXVuJ6T0og0cO5M6raytIfKrscVhui/YhfDinTw13ZHB9v?=
 =?iso-8859-1?Q?kaF9yg8cQZG5sGA1OClq6aQqba4NpO8M9YZwng3zIdRJLl4scbqnWvrOPM?=
 =?iso-8859-1?Q?Oc7NkCjoMdHQxfqpwAyatsjzjZWjclhAcwvPghieQ/JCI1ZY00kJG7k2fr?=
 =?iso-8859-1?Q?S4uhf4X3gNUmmH0Ji63lrBY6SEPJOez8d/T+kiUixT6GG09+HhIDpl6KAy?=
 =?iso-8859-1?Q?tRVTkwmEQybFncPZYFnOaOGgMyi2KsUEjPtrogD8vAs4r8SS2ZjEFqwU7M?=
 =?iso-8859-1?Q?BsV9nPSZfBVZ1IWEpCw5LeWCLtJ94r23YCyMrenJcpjYLtYph6gRmHO8U3?=
 =?iso-8859-1?Q?9pz0u3b2hz1LDj1WxvdLXeDQFPjGO7MI13O6J/xxMfLeT/r89xuHgah3or?=
 =?iso-8859-1?Q?ukyaj8IXdCKdXEUvMzj3/meyxpUWNHdoqnpD1Gkl7Wsx700jwKu5KiwpO+?=
 =?iso-8859-1?Q?tGRAYEoWI6LwjRv91V06Mj8k6eloOvgrw349qey2syds0qcUBqheB8pQv8?=
 =?iso-8859-1?Q?9To8vVKSvOrW5AqeYa5SOq+aoDIVHR7ywtMBpHHqCT0CifTIzLfjOBLecP?=
 =?iso-8859-1?Q?6dwZGsmfBMzpfYW1onn6y00N2VfEdSjpONHhzt9grAQBXTGB07Kf88S383?=
 =?iso-8859-1?Q?dy24Qamkw+tBQe7R+Ee2BdNGyMZ9ROXVlQBvKh38yKNaU6rrSiz0B8zdAe?=
 =?iso-8859-1?Q?bwbWXSv4hrCv9qeomzwCxyvInK+tbEvZ17FyNAwZTwmNNtO5mdInIuEeyY?=
 =?iso-8859-1?Q?WGZ6oD3Fjfek1umtPz2p0AIU8PfZihYqtqdH08775RSIFiwjfcdWJV3CPk?=
 =?iso-8859-1?Q?dsfQuT5fN4Tu1HNt3MRQSb+1NmQX+uJ2FEaMCT/UDqlTuvo23ZtI8onBAB?=
 =?iso-8859-1?Q?i5cqxGWAHrXkFSKOa7dxT58t2Kfv2JZfU0zRrs/QBO8uUw/D2zWbs+StO+?=
 =?iso-8859-1?Q?U/a408X5P2Sg1unD0i9UP3zIQRszlrTDlyEyfaYLq39ClyazhGXLmWN3Va?=
 =?iso-8859-1?Q?pQI0VFB/TRHmZwIEzA8/d8/TqJuVekaLlfr56tVWivxUFMRKmn49tv9+4G?=
 =?iso-8859-1?Q?GUT1xfSi3RWeg4kTFM8fysq/GRL9x5SfSVzEm3WrSI4Oeeoy9nE//4dU6x?=
 =?iso-8859-1?Q?IKiwM1nu+WEgzrDtseu96zguSRLFMu1XHX0/IYQ7kGBYu8sZf7dtSdQ8L4?=
 =?iso-8859-1?Q?+ULiapBfdkaBzQwC5G2TC9NYsSbZ0e84K0N8FJeHpVlZ5qCvsuCqeOwtNw?=
 =?iso-8859-1?Q?4s=3D?=
x-microsoft-antispam-prvs: <DM6PR04MB5993337677AB8DF74AAF00988D660@DM6PR04MB5993.namprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(6512007)(99286004)(53936002)(50226002)(386003)(6116002)(52116002)(105586002)(3846002)(106356001)(76176011)(110136005)(6506007)(25786009)(256004)(54906003)(86362001)(6436002)(316002)(2171002)(36756003)(6486002)(97736004)(4326008)(81166006)(66066001)(8676002)(68736007)(102836004)(72206003)(476003)(2906002)(11346002)(446003)(81156014)(1076003)(14454004)(71200400001)(71190400001)(8936002)(7736002)(305945005)(26005)(186003)(486006)(2616005)(478600001)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB5993;H:DM6PR04MB6059.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eNtj9ZWJ7WDE3BoOBqH9xLtvX6qM93cAKDhAxgsAlhvzVTDsBIht7+lV3vq30vD8ophFL2g6yNzOvmaReV9ZGtd+D6cNVEN8ejQP+qHlS1kVtAP6My7m+ChHQgBRPgOzXdA7VzWOSbaVbheYh2OdFCdMj74tidW6OvS1KJF2o8qWdJx/Qb/t72X3sdfH9H6g3TVC7EHn6hOUg+dqG1cWjsrmJjYZ/eBrVxFSKsDWT14eM7CgVXLvVB3RVdVrCAUl7IP1TtK7FcYBM8xdweUUzisWVkc4nKQbmxfquYVTKEdoP5eG46/QajKNe+enb7cnEyne7MfUEcwLvWZ5fBXMlJ0JzEBZIFCR/2yDyWfh0VwXeAS1WbiV+m+jwSwDC7E9CzF1pmx4qxf2q5kckOLcloLL9OL2dGmUdQ+F28oep1g=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2016079c-fd96-483f-dbb5-08d6918a4a4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 08:07:22.6696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5993
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

