Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA143C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7791020841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EaNoxPpZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7791020841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeIBRUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:12 -0400
Received: from mail-eopbgr720097.outbound.protection.outlook.com ([40.107.72.97]:28208
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727049AbeIBRUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AmzfB3w5EuYQyrQGNcobwduHF5powG+VHdsiFQOcgg=;
 b=EaNoxPpZyr40wR0I7ir4wuINGXj8PC9SklM3iscwjk7TphVqlIzVJr9f7n7XlKQm5Ovtvu6FBCwlOzk7MSeVptYiShH2cUq3taRKHwG3Xama0zOOUYvDLERj8LtsAZkTTXj93HDcodogU5SjeIxlCLRgrXtOPQDiz5ESYwmZVzI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0837.namprd21.prod.outlook.com (10.173.192.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.3; Sun, 2 Sep 2018 13:03:11 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:11 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 011/131] powerpc/4xx: Fix error return path in
 ppc4xx_msi_probe()
Thread-Topic: [PATCH AUTOSEL 4.18 011/131] powerpc/4xx: Fix error return path
 in ppc4xx_msi_probe()
Thread-Index: AQHUQr1Nk3Cizao0AEG8v2BufR8/oA==
Date:   Sun, 2 Sep 2018 13:03:11 +0000
Message-ID: <20180902064601.183036-11-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0837;6:IkcNZ2216xjnFNGB66CfHTuZwf8hG/shdhgFugfhRmv0XFHa/Taxcyl859IfnzJIPT6BszQFsgxytDJQkPCjVqjIRDe1VMSOeO7/xORliW5+gtixOt4TvIqBoy2dNSxWvCOMQNSx1ALLSSUEl5Zta6kD2wU/iT9+AjF9+eCIp3+0W18ja9ETIszkc0bFwc5Qoqn/gtaa7yKRaEfSP6J/aAbQvDFQ9f06JERA8DY3QFrBAPNknYm2DAYsdm3fGSn075ELKfrKQyJPlkEY6Sz5HG7R6CGF4c3nQ2n7SBqCavVG840RAdyhUH8In5Rzm6U69lmoC8GO0MYsoPtm2YyifheVKfLXKs1weJD2aZjlt/psuG547bpZLsuIRFowenrIDOQ25bMKoESyAzhBXqVoFmBulUgy2/uqBWtR2CAjd+p61RjZUKQzafWRUVN3ee5a5FAMjvbie33mED7y00NltA==;5:Drxbzp/kZN8f5QAyFQYPKRFS90QpL/niz8Fv5kNxhD/jbmX5XkivluOlVZfgfJ7WioVV8htqw5j9+WY0RtQNfxgvCNsqy8qrp7HkhYHR1OTo3gaXjtqSvNgmK8eCtyvoLis1dGkL3puDTIelBM85pkGOkGnDu5C/LuZufpjKNWA=;7:pb88U+h0Bf+UmENSxepZdgjSoy/1akTj1Mo40iTtq5BmhzxR+xquDT72JkUba5YfEP8WITlvwFTa7SMnxYFHQ0eUSmmf+TzLYxNaY1Elja0LfCNixchO1budbCKDTFegSt2I3Yglg9+D4FrYLX7wl9xVWr19C20hFF7hETo0ClEIYMUAi2E6YdzDpuFSHjfLPqxB8cZx/5c39U9yNtUn7AJVkJ7jMj6RGk9EC0LF5xbFvUHSbzNW0kDBmFdBhDZW
x-ms-office365-filtering-correlation-id: 2364c8f5-0992-4569-aeb4-08d610d4701c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:CY4PR21MB0837;
x-ms-traffictypediagnostic: CY4PR21MB0837:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0837A6A112F3B1C5A5262ABBFB0D0@CY4PR21MB0837.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0837;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0837;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(136003)(366004)(346002)(189003)(199004)(6506007)(2616005)(25786009)(476003)(2900100001)(4326008)(6116002)(1076002)(3846002)(106356001)(305945005)(66066001)(7736002)(105586002)(10290500003)(2501003)(72206003)(478600001)(5250100002)(217873002)(11346002)(10090500001)(446003)(76176011)(6512007)(6486002)(256004)(53936002)(81156014)(14444005)(8676002)(81166006)(68736007)(14454004)(22452003)(8936002)(99286004)(316002)(102836004)(54906003)(110136005)(15760500003)(2906002)(107886003)(86612001)(5660300001)(186003)(486006)(575784001)(36756003)(86362001)(97736004)(26005)(5024004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0837;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: b1VbIrpcJbdONRJTkMwApk0o29t1DdwNBfQ7o5GEQgVmNRZxOOWImMj3bpJ0CSVyRboAx9kpjlgiC20pdKRzIRJ1TtmXDz9wYsNTKYBEpisc3QW8qEST+vyZjwys7Gz2GlWcx0CVmCyy9rPnV/Vn1QkQqhAuN4kpr6oSpyLkHW0/1AY92wFr836k5uP0Jt1tIbs14BFLJuENQcJDy3Y+Kj1/73vW1Y0ZiVLA2AQ8t4jnnpmfbRn1oMYYTyQgis/BWYH6vOB1jl0MEss3AQxGzsHvDg9VrtZVpDwbwZBUE2tDlk5AFDm+jo7ToH05MaQShizUdVN1PeKl3TKqXKhuQqA6yRmC2CFg5msL+Fj2F/g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2364c8f5-0992-4569-aeb4-08d610d4701c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:11.8231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 6e0495c2e8ac39b1aad0a4588fe64413ce9028c0 ]

An arbitrary error in ppc4xx_msi_probe() quite likely results in a
crash similar to the following, seen after dma_alloc_coherent()
returned an error.

  Unable to handle kernel paging request for data at address 0x00000000
  Faulting instruction address: 0xc001bff0
  Oops: Kernel access of bad area, sig: 11 [#1]
  BE Canyonlands
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper Tainted: G        W
  4.18.0-rc6-00010-gff33d1030a6c #1
  NIP:  c001bff0 LR: c001c418 CTR: c01faa7c
  REGS: cf82db40 TRAP: 0300   Tainted: G        W
  (4.18.0-rc6-00010-gff33d1030a6c)
  MSR:  00029000 <CE,EE,ME>  CR: 28002024  XER: 00000000
  DEAR: 00000000 ESR: 00000000
  GPR00: c001c418 cf82dbf0 cf828000 cf8de400 00000000 00000000 000000c4 000=
000c4
  GPR08: c0481ea4 00000000 00000000 000000c4 22002024 00000000 c00025e8 000=
00000
  GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 c0492380 000=
0004a
  GPR24: 00029000 0000000c 00000000 cf8de410 c0494d60 c0494d60 cf8bebc0 000=
00001
  NIP [c001bff0] ppc4xx_of_msi_remove+0x48/0xa0
  LR [c001c418] ppc4xx_msi_probe+0x294/0x3b8
  Call Trace:
  [cf82dbf0] [00029000] 0x29000 (unreliable)
  [cf82dc10] [c001c418] ppc4xx_msi_probe+0x294/0x3b8
  [cf82dc70] [c0209fbc] platform_drv_probe+0x40/0x9c
  [cf82dc90] [c0208240] driver_probe_device+0x2a8/0x350
  [cf82dcc0] [c0206204] bus_for_each_drv+0x60/0xac
  [cf82dcf0] [c0207e88] __device_attach+0xe8/0x160
  [cf82dd20] [c02071e0] bus_probe_device+0xa0/0xbc
  [cf82dd40] [c02050c8] device_add+0x404/0x5c4
  [cf82dd90] [c0288978] of_platform_device_create_pdata+0x88/0xd8
  [cf82ddb0] [c0288b70] of_platform_bus_create+0x134/0x220
  [cf82de10] [c0288bcc] of_platform_bus_create+0x190/0x220
  [cf82de70] [c0288cf4] of_platform_bus_probe+0x98/0xec
  [cf82de90] [c0449650] __machine_initcall_canyonlands_ppc460ex_device_prob=
e+0x38/0x54
  [cf82dea0] [c0002404] do_one_initcall+0x40/0x188
  [cf82df00] [c043daec] kernel_init_freeable+0x130/0x1d0
  [cf82df30] [c0002600] kernel_init+0x18/0x104
  [cf82df40] [c000c23c] ret_from_kernel_thread+0x14/0x1c
  Instruction dump:
  90010024 813d0024 2f890000 83c30058 41bd0014 48000038 813d0024 7f89f800
  409d002c 813e000c 57ea103a 3bff0001 <7c69502e> 2f830000 419effe0 4803b26d
  ---[ end trace 8cf551077ecfc42a ]---

Fix it up. Specifically,

- Return valid error codes from ppc4xx_setup_pcieh_hw(), have it clean
  up after itself, and only access hardware after all possible error
  conditions have been handled.
- Use devm_kzalloc() instead of kzalloc() in ppc4xx_msi_probe()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/platforms/4xx/msi.c | 51 +++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/platforms/4xx/msi.c b/arch/powerpc/platforms/4xx/=
msi.c
index 81b2cbce7df8..7c324eff2f22 100644
--- a/arch/powerpc/platforms/4xx/msi.c
+++ b/arch/powerpc/platforms/4xx/msi.c
@@ -146,13 +146,19 @@ static int ppc4xx_setup_pcieh_hw(struct platform_devi=
ce *dev,
 	const u32 *sdr_addr;
 	dma_addr_t msi_phys;
 	void *msi_virt;
+	int err;
=20
 	sdr_addr =3D of_get_property(dev->dev.of_node, "sdr-base", NULL);
 	if (!sdr_addr)
-		return -1;
+		return -EINVAL;
=20
-	mtdcri(SDR0, *sdr_addr, upper_32_bits(res.start));	/*HIGH addr */
-	mtdcri(SDR0, *sdr_addr + 1, lower_32_bits(res.start));	/* Low addr */
+	msi_data =3D of_get_property(dev->dev.of_node, "msi-data", NULL);
+	if (!msi_data)
+		return -EINVAL;
+
+	msi_mask =3D of_get_property(dev->dev.of_node, "msi-mask", NULL);
+	if (!msi_mask)
+		return -EINVAL;
=20
 	msi->msi_dev =3D of_find_node_by_name(NULL, "ppc4xx-msi");
 	if (!msi->msi_dev)
@@ -160,30 +166,30 @@ static int ppc4xx_setup_pcieh_hw(struct platform_devi=
ce *dev,
=20
 	msi->msi_regs =3D of_iomap(msi->msi_dev, 0);
 	if (!msi->msi_regs) {
-		dev_err(&dev->dev, "of_iomap problem failed\n");
-		return -ENOMEM;
+		dev_err(&dev->dev, "of_iomap failed\n");
+		err =3D -ENOMEM;
+		goto node_put;
 	}
 	dev_dbg(&dev->dev, "PCIE-MSI: msi register mapped 0x%x 0x%x\n",
 		(u32) (msi->msi_regs + PEIH_TERMADH), (u32) (msi->msi_regs));
=20
 	msi_virt =3D dma_alloc_coherent(&dev->dev, 64, &msi_phys, GFP_KERNEL);
-	if (!msi_virt)
-		return -ENOMEM;
+	if (!msi_virt) {
+		err =3D -ENOMEM;
+		goto iounmap;
+	}
 	msi->msi_addr_hi =3D upper_32_bits(msi_phys);
 	msi->msi_addr_lo =3D lower_32_bits(msi_phys & 0xffffffff);
 	dev_dbg(&dev->dev, "PCIE-MSI: msi address high 0x%x, low 0x%x\n",
 		msi->msi_addr_hi, msi->msi_addr_lo);
=20
+	mtdcri(SDR0, *sdr_addr, upper_32_bits(res.start));	/*HIGH addr */
+	mtdcri(SDR0, *sdr_addr + 1, lower_32_bits(res.start));	/* Low addr */
+
 	/* Progam the Interrupt handler Termination addr registers */
 	out_be32(msi->msi_regs + PEIH_TERMADH, msi->msi_addr_hi);
 	out_be32(msi->msi_regs + PEIH_TERMADL, msi->msi_addr_lo);
=20
-	msi_data =3D of_get_property(dev->dev.of_node, "msi-data", NULL);
-	if (!msi_data)
-		return -1;
-	msi_mask =3D of_get_property(dev->dev.of_node, "msi-mask", NULL);
-	if (!msi_mask)
-		return -1;
 	/* Program MSI Expected data and Mask bits */
 	out_be32(msi->msi_regs + PEIH_MSIED, *msi_data);
 	out_be32(msi->msi_regs + PEIH_MSIMK, *msi_mask);
@@ -191,6 +197,12 @@ static int ppc4xx_setup_pcieh_hw(struct platform_devic=
e *dev,
 	dma_free_coherent(&dev->dev, 64, msi_virt, msi_phys);
=20
 	return 0;
+
+iounmap:
+	iounmap(msi->msi_regs);
+node_put:
+	of_node_put(msi->msi_dev);
+	return err;
 }
=20
 static int ppc4xx_of_msi_remove(struct platform_device *dev)
@@ -209,7 +221,6 @@ static int ppc4xx_of_msi_remove(struct platform_device =
*dev)
 		msi_bitmap_free(&msi->bitmap);
 	iounmap(msi->msi_regs);
 	of_node_put(msi->msi_dev);
-	kfree(msi);
=20
 	return 0;
 }
@@ -223,18 +234,16 @@ static int ppc4xx_msi_probe(struct platform_device *d=
ev)
=20
 	dev_dbg(&dev->dev, "PCIE-MSI: Setting up MSI support...\n");
=20
-	msi =3D kzalloc(sizeof(*msi), GFP_KERNEL);
-	if (!msi) {
-		dev_err(&dev->dev, "No memory for MSI structure\n");
+	msi =3D devm_kzalloc(&dev->dev, sizeof(*msi), GFP_KERNEL);
+	if (!msi)
 		return -ENOMEM;
-	}
 	dev->dev.platform_data =3D msi;
=20
 	/* Get MSI ranges */
 	err =3D of_address_to_resource(dev->dev.of_node, 0, &res);
 	if (err) {
 		dev_err(&dev->dev, "%pOF resource error!\n", dev->dev.of_node);
-		goto error_out;
+		return err;
 	}
=20
 	msi_irqs =3D of_irq_count(dev->dev.of_node);
@@ -243,7 +252,7 @@ static int ppc4xx_msi_probe(struct platform_device *dev=
)
=20
 	err =3D ppc4xx_setup_pcieh_hw(dev, res, msi);
 	if (err)
-		goto error_out;
+		return err;
=20
 	err =3D ppc4xx_msi_init_allocator(dev, msi);
 	if (err) {
@@ -256,7 +265,7 @@ static int ppc4xx_msi_probe(struct platform_device *dev=
)
 		phb->controller_ops.setup_msi_irqs =3D ppc4xx_setup_msi_irqs;
 		phb->controller_ops.teardown_msi_irqs =3D ppc4xx_teardown_msi_irqs;
 	}
-	return err;
+	return 0;
=20
 error_out:
 	ppc4xx_of_msi_remove(dev);
--=20
2.17.1
