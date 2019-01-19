Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44029C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018322086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aFbFS4H6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BhGS45YX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfASN3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 08:29:05 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59604 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbfASN3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 08:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547904545; x=1579440545;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RkBTH8lbPokRi3AbbPZC7LaTnjprJMzCRLruXMKSeEc=;
  b=aFbFS4H6YzyThIATQ7bs1zo77TH8N2LESt0/NS9Usm1qWaDLh4rrFRtl
   1O7IZcwQXa8he52VHmWFUMUZ8Ofy2w96gt0KBKfJXjxR18YOdd3UDarod
   WfjWvaWh5gRGAPibFEY+2Ft+QDHFIbHWULJkoC1LDjmxcrYrMjmaFwQqr
   gam1x/AFimoVJhj0z/nACXl5sCsra82zduUFaOyAp0+LDZ9yl8QT9MF2w
   S0osrrLAv2ldn0IvwaDZI6LPgyEOGAtc3bf+qQYsXGbUsdcyWZ/XLICGL
   EsO481+ZznI5+80qkCy7IFd1HKGLaptAChjqdnpNFar7bJJgWQAjPR59h
   w==;
X-IronPort-AV: E=Sophos;i="5.56,495,1539619200"; 
   d="scan'208";a="104187216"
Received: from mail-by2nam03lp2055.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.55])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2019 21:29:04 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUGRwrEhvO7GNr+kDod846Bm8yelHx5kYWNQyVfOwr8=;
 b=BhGS45YXBnp2J3WLa48/kgoEVPYsmTES8PfzrhT5b+JeWPpRejgewfWCBOhVO398iiwzsJdbDk2enaa8Y0YK66mujBQjmQQYYQE3PVx1/+fCRZ4HVtv9ujgxdRGXU0hqrCrPXoFqlo54QmBXV/1V48T7vYB8Z3IGULijfnxWpxA=
Received: from BYAPR04MB5303.namprd04.prod.outlook.com (20.178.49.148) by
 BYAPR04MB5397.namprd04.prod.outlook.com (20.178.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.19; Sat, 19 Jan 2019 13:28:59 +0000
Received: from BYAPR04MB5303.namprd04.prod.outlook.com
 ([fe80::add1:92cc:65d7:5d94]) by BYAPR04MB5303.namprd04.prod.outlook.com
 ([fe80::add1:92cc:65d7:5d94%2]) with mapi id 15.20.1537.028; Sat, 19 Jan 2019
 13:28:59 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v2 6/6] RISC-V: Implement keepinitrd kernel parameter
Thread-Topic: [PATCH v2 6/6] RISC-V: Implement keepinitrd kernel parameter
Thread-Index: AQHUr/rvNlD18fFOHEuGvgVx64rC4Q==
Date:   Sat, 19 Jan 2019 13:28:59 +0000
Message-ID: <20190119132650.9978-7-anup.patel@wdc.com>
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
x-microsoft-exchange-diagnostics: 1;BYAPR04MB5397;6:I95jqhLKkE1aouccQGNmrUJuyPeFo8xAKYDLBMv6FDC9PGFh9eeZreaO8es4hOcGm05MeXkvqYr4iHg7DJSbPI1J94BMHD+f36O7bDeHM6pFpjtSGfLx7E8hyHHmL/Yr51u0OkzHlev1igx4EVX6V+M/1CZS3V+CN9hnysp9tZVECpE4Zw+TwJ/sEeba7aELnNm3K8zapkBVdXjvoDk47PIqdudiFex7SlkxG9APN22Jb8M3c0ZQvuUBMtO0MDXYxDh+7uAvF5kwqRGg+0ztEMDrxunUBK0sy8liKAXEgGWWCdCO0OrSN7/GAJntWxAHAdYLPJWgZJ73OEA/7hrE4UHOGMi9pIymJLRyKHjv8DY0q5/Lg/bW1k7M8ap8c8joYOfPvuQdjJSPA1plgpFvKxaTGQEzJkUM4thzZs9RFUet+ik0NK5Pud3K44EiYHEZnYbv8Roux6cK7K/5RqL0ZA==;5:0n3K4Zfvs3yCLpfW26AcBWJy9qJj79F3ua8ZmUF+D/MdHam+GPmZ+3mr3ocJFAGG3IrBmW118GA3IlotpULqrQSNfLJzB8iYoAxoT2t4rCi51XHDUOCGGIpn+oiwUuI5kKvRmFIHPICAsmIZ3zYPEusqFbJbn9Wo5dV3FelVItTwm9zkMCtUmpPEYSoNrwjMzzRPQt9EXUtPgJxF4jp0Xw==;7:GiIYfOTA46KXGaqtZwZbB2cfdITqp7jpnZGP3UidcTPJPevci/18FFb4Bb2B5T9T97mKheEZaVY0dQT4OcyOAkeZt1pszRAXOnaaWlUukRJp9rirnhQ0HTDSnMKpEKqMwtEP4VRPhr5+JsLgDyEtbA==
x-ms-office365-filtering-correlation-id: 36b63613-5f19-480a-eac7-08d67e1211c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB5397;
x-ms-traffictypediagnostic: BYAPR04MB5397:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5397F2C02117AF7E3953AFBF8D9D0@BYAPR04MB5397.namprd04.prod.outlook.com>
x-forefront-prvs: 09222B39F5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(366004)(376002)(396003)(199004)(189003)(6116002)(99286004)(14444005)(25786009)(72206003)(8936002)(4326008)(102836004)(50226002)(81166006)(14454004)(68736007)(105586002)(305945005)(7736002)(66066001)(478600001)(2171002)(8676002)(1076003)(81156014)(256004)(53936002)(106356001)(3846002)(26005)(86362001)(386003)(55236004)(6506007)(71190400001)(2906002)(71200400001)(97736004)(6436002)(6486002)(476003)(2616005)(186003)(44832011)(76176011)(6512007)(316002)(5660300001)(446003)(11346002)(52116002)(486006)(110136005)(54906003)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5397;H:BYAPR04MB5303.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ii1hjsBLKm//soG1BH1Fq2NOppTFNn5vN0wOyDlB1CTkxwsUOFaHubdpgB5uQTQxhI2DPXQYKBe2N5aqPYF494nLcsNkQg4XTQFv3BoP/oItvULrPO+8vkGAiu5jn/9gbVqJGy2Bj1sDy5R+lHZToJDzST+RGszJ8cGTjxiG96/q6G/zg7TVE/SE/D0vUqIkJ9MijGAWfeDkv0fBNm6RfQ+IVFsnpZHm8L5RiIk2S2dCRQqg0CO5QVHzbm/D5shup3o/2Pp0qsRGaNZuSppeRYnIPPPn4i+JTNabiTWZ8n3SCO0a5u+8HO2E/nQHx6GjHHwgZvCR64sdCCupHi2S1e6pT79AXksF8eTUZB6JSpjk/TjeE67YqdQj42rZtf89KwjYnawzTPjKxB3sLaf+GndB9Y4e74bo8nHzzqb9Rwo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b63613-5f19-480a-eac7-08d67e1211c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2019 13:28:57.0831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5397
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements keepinitrd kernel parameter. By default,
keepinitrd=3D1 but users can pass "keepinitrd=3D0" to free-up
initrd memory at boot-time in free_initrd_mem() function.

The keepinitrd kernel parameter is already implemented by
unicore32, arm, and arm64 architectures and it is documented
at: Documentation/admin-guide/kernel-parameters.txt

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

