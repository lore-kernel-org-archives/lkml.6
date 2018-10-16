Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20CBC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43656208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=opengear.com header.i=@opengear.com header.b="I9cUSMKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43656208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opengear.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeJPIpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 04:45:47 -0400
Received: from mail-co1nam03on0061.outbound.protection.outlook.com ([104.47.40.61]:47808
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726883AbeJPIpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 04:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdgNBPjpMN/xOWalNwKksUINZU0/AaW5/Ihnco7cHrs=;
 b=I9cUSMKeC6ZmU1hkK50t3g3Tw9fwE6LaEjALyQd0z4vxZrPokE4AQtAJo3dQwouv1WAbMCifNQEg2CH49pzj8g7W1pWCkMhuGGEUAw3BUUkUNTFCDpgVhZvHcw3f/B3Rw6ejK/yLJbRA6FjGEPsJkBOorVaSMyJdQYvMMb+DZM4=
Received: from DM5PR1501MB2056.namprd15.prod.outlook.com (52.132.130.30) by
 DM5PR1501MB2165.namprd15.prod.outlook.com (52.132.131.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Tue, 16 Oct 2018 00:57:41 +0000
Received: from DM5PR1501MB2056.namprd15.prod.outlook.com
 ([fe80::7d9d:bade:239d:6bf8]) by DM5PR1501MB2056.namprd15.prod.outlook.com
 ([fe80::7d9d:bade:239d:6bf8%6]) with mapi id 15.20.1228.027; Tue, 16 Oct 2018
 00:57:41 +0000
From:   "Grandbois, Brett" <brett.grandbois@opengear.com>
To:     Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mtd: spi-nor: Add support for SPI boot flash access for
 AMD Family 16h
Thread-Topic: [PATCH v2] mtd: spi-nor: Add support for SPI boot flash access
 for AMD Family 16h
Thread-Index: AQHUZOs9cFLja65s+EWijjbFGrgyHw==
Date:   Tue, 16 Oct 2018 00:57:41 +0000
Message-ID: <20181016005726.26813-1-brett.grandbois@opengear.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY2PR01CA0029.ausprd01.prod.outlook.com
 (2603:10c6:1:15::17) To DM5PR1501MB2056.namprd15.prod.outlook.com
 (2603:10b6:4:a2::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brett.grandbois@opengear.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [59.167.150.161]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR1501MB2165;6:QrWuZGwssEKKcaqE4JERMWtmiFRDTbRMTnxf7/8/300Fek1zGop9ybR62W/jlotNjqLeMPSvnhJr2nmqpLzcDzCWr5i0EcRnDoH1HPXbALGWZ+2lwqTmc/d6bX+ULgHG8utH3pmfBNNnXbSnkjWxI7N4ddk/R5HX65QqP+f+ij2XIIMxEPm20hnyuI/NPG1lUPCmVTea/YcpYMNPJ+pg0fY1xwNyqWB4kLcDH/RS92Xf7dM53gQtgM6dN/TUmtCfUKY0Hm2rPG+Ev09/B4XnG4hSRN40SkqRdfZ4pyRf/cw7kEw2JlghhuckPM6AtBTXSsxPnXVyNSpuRH3Wx2Dpv8TaqDh5WaWaC5PW2Ig2pono+tJK/XOWr0Ga5qp3LcRsW8LYlwyVeJhm3CIO4VwfuATamliH0e6NIOv1tuXFFoMRlcDLn9T1CXZ4baiNkfBUh0ZEnji5/ykqTy1k4TN4Tg==;5:bFbet2zEGcWvkuTuMcy2OBmOAIiSVo8wJ+QQy+zadcsaH+v5AHrckxKhroMGvqG9XSg5lwpF6qvif6ZZWwfeee6o1VToQ5n7jt8ZV31FZjVyUvyhgjWzY9oIklYWxqTCLhwcyp3Z+sY2Mz9uIytTnqOcQzJ+IV4Qky9RYFPlHGc=;7:a7w9YgfanUw3AxMSOSyqbcwrlTmgVeB5V6iE80CXvv93dfmkK8uMCvmBR1D48CWTD3mtVsPH2URacNaTJjNpirhlchA3U0JsBBaQ2jj3K8chnrHy4WCdNs1sVhLZYdv6/SuCpc8UoCtQonVcYmNx3TwEqIM6Ik9EDAJEq5WXJYjPWTTsnLGyoa4pXy6bdfYIdfyjK5rizSTSGSbwWMcms7oYo4TWpaIp+RVcU7qLsYCZxIqa5R3AuETuUv/XDXMb
x-ms-office365-filtering-correlation-id: d4c4c004-2ef4-4e03-973a-08d633025f8d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR1501MB2165;
x-ms-traffictypediagnostic: DM5PR1501MB2165:
x-microsoft-antispam-prvs: <DM5PR1501MB216585ED4BAC0E8A3849264E82FE0@DM5PR1501MB2165.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(21532816269658)(60795455431006);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991067);SRVR:DM5PR1501MB2165;BCL:0;PCL:0;RULEID:;SRVR:DM5PR1501MB2165;
x-forefront-prvs: 0827D7ACB9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39850400004)(136003)(366004)(346002)(57704003)(43544003)(199004)(189003)(8936002)(106356001)(575784001)(4326008)(97736004)(81156014)(86362001)(39060400002)(66066001)(5250100002)(2501003)(25786009)(476003)(68736007)(486006)(186003)(26005)(5660300001)(99286004)(110136005)(305945005)(6436002)(7736002)(1076002)(6486002)(71200400001)(53936002)(386003)(14444005)(6506007)(6512007)(53946003)(256004)(6116002)(3846002)(105586002)(2616005)(52116002)(4744004)(36756003)(71190400001)(316002)(478600001)(81166006)(14454004)(2900100001)(2906002)(8676002)(102836004)(559001)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR1501MB2165;H:DM5PR1501MB2056.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: opengear.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xEwfC+Qlz/4C0xVdQpQEU6vA7q+oRmVYLzqBPZyerdit66pSPKrcZusJd4qLO4i9MiGJtga/5XjUdLZFrymNj48UmJtVbWriBUiiLgiAtrq1OQdnvNRg1BC1EWAp5SxFUf4nKHsUgaf1hRF+m6tYbyvTeyXF0K53QQOKV4swWTusdHriS0dCrMnQwjdlfupQkw0avKYR7CgH0jA++q7q08soaZ5xz8vzItFzGJfVLE+nMRfiFvvuXen8x9SxJrdYLQeLQJRxlXnP3YlwsMNwZxG5jaBGnybUB8n8G38rq0H2JRgB0x2YW+0PHJhtn4psBYZjaRYKKP+TNBBLQymqybDB2QBEHVtxld2j7J+M/Hk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c4c004-2ef4-4e03-973a-08d633025f8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2018 00:57:41.1614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a6251c26-d21f-4164-a225-1f4eaebf5f9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB2165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to expose the SPI boot flash on AMD Family 16h CPUs as a
standard mtd device to give userspace BIOS updaters greater feature
support.  The BIOS and Kernel Developer's Guide refers to this as the
'SPI ROM' controller and so the driver follows that naming convention
for consistency.

Signed-off-by: Brett Grandbois <brett.grandbois@opengear.com>
---

Changes for v2:
- address sparse warnings

 drivers/mtd/spi-nor/Kconfig      |  15 +
 drivers/mtd/spi-nor/Makefile     |   1 +
 drivers/mtd/spi-nor/amd-spirom.c | 805 +++++++++++++++++++++++++++++++
 3 files changed, 821 insertions(+)
 create mode 100644 drivers/mtd/spi-nor/amd-spirom.c

diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
index 6cc9c929ff57..f99b40ec0fef 100644
--- a/drivers/mtd/spi-nor/Kconfig
+++ b/drivers/mtd/spi-nor/Kconfig
@@ -129,4 +129,19 @@ config SPI_STM32_QUADSPI
 	  This enables support for the STM32 Quad SPI controller.
 	  We only connect the NOR to this controller.
=20
+config SPI_AMD_SPIROM
+	tristate "AMD Hudson FCH SPI flash drvier (DANGEROUS)"
+	depends on X86 && PCI
+	help
+	  This enables support for the AMD Family 16h SPI flash controller to
+	  access the boot flash from Linux as an mtd device.
+
+	  Using this driver it is possible to upgrade BIOS directly from Linux.
+
+	  Say N here unless you know what you are doing. Overwriting the
+	  SPI flash may render the system unbootable.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called amd-spirom.
+
 endif # MTD_SPI_NOR
diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index f4c61d282abd..e49ea4e619c1 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_SPI_INTEL_SPI)	+=3D intel-spi.o
 obj-$(CONFIG_SPI_INTEL_SPI_PCI)	+=3D intel-spi-pci.o
 obj-$(CONFIG_SPI_INTEL_SPI_PLATFORM)	+=3D intel-spi-platform.o
 obj-$(CONFIG_SPI_STM32_QUADSPI)	+=3D stm32-quadspi.o
+obj-$(CONFIG_SPI_AMD_SPIROM)	+=3D amd-spirom.o
diff --git a/drivers/mtd/spi-nor/amd-spirom.c b/drivers/mtd/spi-nor/amd-spi=
rom.c
new file mode 100644
index 000000000000..5ad985cd23b0
--- /dev/null
+++ b/drivers/mtd/spi-nor/amd-spirom.c
@@ -0,0 +1,805 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2018, Opengear
+ *
+ * AMD Family 16h Hudson FCH SPI flash driver.
+ *
+ * When the FCH is strapped to SPI boot ROM mode 'SPIROM'
+ * the FCH will do a flash auto-probe and self-configure
+ * for read operations to the ROM address range(s).
+ * For any command outside of read/write (chip erase, etc)
+ * you need to go through the alternate program method.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/mutex.h>
+#include <linux/iopoll.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/spi-nor.h>
+
+/* FCH Device LPC Bridge Configuration Registers */
+#define PCI_DEVICE_ID_AMD_FCH_LPC_BRIDGE	0x780E
+
+#define FCH_PCI_CONTROL				0x40
+#define FCH_INTEGRATED_EC_PRESENT		0x80
+#define FCH_EC_SEM				0x40
+#define FCH_BIOS_SEM				0x20
+#define FCH_LEGACY_DMA				0x04
+
+#define FCH_ROM_ADDR_RANGE_2			0x6C
+
+#define FCH_SPI_BASE_ADDR			0xA0
+#define FCH_SPI_BASE_ADDR_MASK			0xFFFFFFC0
+#define FCH_SPI_ROUTE_TPM_SPI			0x08
+#define FCH_SPI_ROM_ENABLE			0x02
+
+/* up through FIFO [C6:80] */
+#define SPI_IO_REGION_LEN			256
+
+/* SPI Registers, the labels come from the BKDG */
+#define SPI_CNTRL0				0x00
+#define SPI_CNTRL0_FIFO_PTR_CLEAR		0x00100000
+#define SPI_CNTRL0_FIFO_PTR_CLEAR_MASK		0xFFEFFFFF
+#define SPI_CNTRL0_SPI_ARB_ENABLE		0x00080000
+#define SPI_CNTRL0_SPI_ARB_ENABLE_MASK		0xFFF7FFFF
+
+#define ALT_SPI_CS				0x1D
+#define ALT_SPI_CS_MASK				0xFC
+#define ALT_SPI_CS_WR_BUF_EN			0x04
+
+#define SPI100_ENABLE				0x20
+#define SPI100_SPEED_CONFIG			0x22
+
+
+/* SPI control shadow registers */
+#define CMD_CODE				0x45
+
+#define CMD_TRIGGER				0x47
+#define CMD_TRIGGER_EXECUTE			0x80
+
+#define TX_BYTE_COUNT				0x48
+
+#define RX_BYTE_COUNT				0x4B
+
+#define SPI_STATUS				0x4C
+#define SPI_STATUS_BUSY_MASK			0x80000000
+
+#define SPI_FIFO				0x80
+
+static const struct pci_device_id amd_fch_lpc_pci_device_ids[] =3D {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_FCH_LPC_BRIDGE) },
+	{}
+};
+MODULE_DEVICE_TABLE(pci, amd_fch_lpc_pci_device_ids);
+
+static short norm_speed =3D -1;
+module_param(norm_speed, short, 0444);
+MODULE_PARM_DESC(norm_speed, "Specify SPI speed for normal read.  This set=
s NormSpeedNew[3:0] from BKDG. -1 means use existing (defaut).");
+
+static short fast_speed =3D -1;
+module_param(fast_speed, short, 0444);
+MODULE_PARM_DESC(fast_speed, "Specify SPI speed for fast/dual/quad read.  =
This sets FastSpeedNew[3:0] from BKDG. -1 means use existing (defaut).");
+
+static short alt_speed =3D -1;
+module_param(alt_speed, short, 0444);
+MODULE_PARM_DESC(alt_speed, "Specify alternate command SPI speed.  This se=
ts AltSpeedNew[3:0] from BKDG. -1 means use existing (defaut).");
+
+static int read_mode =3D -1;
+module_param(read_mode, int, 0444);
+MODULE_PARM_DESC(read_mode, "Specify SPI read settings.  This sets SpiRead=
Mode[2:0] from BKDG. -1 means use existing (defaut).");
+
+static char *flash_name;
+module_param(flash_name, charp, 0444);
+MODULE_PARM_DESC(flash_name, "Specify flash type name to spi_nor_scan(). D=
efault (null) is auto-probe from JEDEC ID.");
+
+static short chip_select =3D -1;
+module_param(chip_select, short, 0444);
+MODULE_PARM_DESC(chip_select, "Specify the alternate SPI CS# [0-3]. -1 mea=
ns use existing (defaut).");
+
+static char *part_name =3D "BIOS";
+module_param(part_name, charp, 0444);
+MODULE_PARM_DESC(part_name, "MTD partition label for SPIROM region.");
+
+static short write_buffer_enable =3D -1;
+module_param(write_buffer_enable, short, 0444);
+MODULE_PARM_DESC(write_buffer_enable, "Enable write buffer.  This sets Wri=
teBufferEn from BKDG.  0 means disable, >0 means enable, <0 means use exist=
ing (default)");
+
+static short mac_arb_enable =3D -1;
+module_param(mac_arb_enable, short, 0444);
+MODULE_PARM_DESC(write_buffer_enable, "Enable MAC arbitration.  This sets =
SpiArbEnable from BKDG.  0 means disable, >0 means enable, <0 means use exi=
sting (default)");
+
+
+static bool accelerated_rd =3D true;
+module_param(accelerated_rd, bool, 0444);
+MODULE_PARM_DESC(hw_write, "Have read requests go via flash MMIO address s=
pace. This is a performance enhancement.");
+
+/*
+ * The SPIROM interface only supports 1 flash chip so that's all the drive=
r
+ * supports.  Theoretically you could access up to 3 others via alt comman=
d
+ * and SPI_ALT_CS but that's a future expansion and likely not ever to be
+ * actually needed.
+ */
+struct amd_spirom {
+	void __iomem *spi;
+	void __iomem *rom;
+	struct spi_nor nor;
+	/*
+	 * pre-calculated delays for reg_xfer (up to 8 bytes data + opcode)
+	 * note that the delay includes the opcode byte and the value is double
+	 * because reg_xfer is using poll_timeout which actually quarters the
+	 * value for usleep_range.
+	 */
+	u32 reg_delay_us[9];
+	u16 spi_alt_speed;
+	bool mtd_registered;
+};
+
+/* note we're assuming no dual/quad here */
+static u32 amd_spirom_get_usecs_per_bytes(u16 speed_config, u32 bytes)
+{
+	static const u32 hz[6] =3D {	(u32)(6666 * 1000),
+					(u32)(3333 * 1000),
+					(u32)(2222 * 1000),
+					(u32)(1666 * 1000),
+					(u32)(100000 * 1000),
+					(u32)(800 * 1000) };
+
+	return mult_frac(bytes * 8, USEC_PER_SEC, hz[speed_config]);
+}
+
+static int amd_spirom_reg_xfer(struct amd_spirom *spirom, u8 opcode,
+				u8 rx_len, u8 tx_len, u8 *rx_buf, u8 *tx_buf)
+{
+	u32 delay_us;
+	u32 total_len;
+	u32 cntrl0;
+	u8 sts;
+	int rc;
+	uint i;
+
+	total_len =3D tx_len + rx_len + 1;
+
+	/* transfer FIFO is actually 70 bytes long so that's the hard limit */
+
+	/*
+	 * no irq here so just need to wait
+	 *
+	 * poll_timeout will actually quarter the delay so we'll double the
+	 * expected range and should then hit on the second or third iteration
+	 *
+	 * for reg_read/write transactions we can use the pre-calculated value
+	 *
+	 * Note we need to +1 for the opcode.
+	 */
+
+
+	if (total_len <=3D 9)
+		delay_us =3D spirom->reg_delay_us[total_len - 1];
+	else if (total_len <=3D 71)
+		delay_us =3D amd_spirom_get_usecs_per_bytes(spirom->spi_alt_speed,
+							  total_len << 1);
+	else
+		return -EINVAL;
+
+
+	iowrite8(opcode, spirom->spi + CMD_CODE);
+
+	iowrite8(tx_len, spirom->spi + TX_BYTE_COUNT);
+	iowrite8(rx_len, spirom->spi + RX_BYTE_COUNT);
+
+	/* reset the transfer fifo */
+	cntrl0 =3D ioread32(spirom->spi + SPI_CNTRL0);
+	cntrl0 &=3D SPI_CNTRL0_FIFO_PTR_CLEAR_MASK;
+	cntrl0 |=3D SPI_CNTRL0_FIFO_PTR_CLEAR;
+	iowrite32(cntrl0, spirom->spi + SPI_CNTRL0);
+
+	/* fill the FIFO */
+	for (i =3D 0; i < (uint)tx_len; i++)
+		iowrite8(tx_buf[i], spirom->spi + SPI_FIFO + i);
+
+	/* release the hounds... */
+	iowrite8(CMD_TRIGGER_EXECUTE, spirom->spi + CMD_TRIGGER);
+
+	rc =3D readb_poll_timeout(spirom->spi + SPI_STATUS, sts,
+				!(sts & SPI_STATUS_BUSY_MASK),
+				delay_us, 4 * delay_us);
+
+	if (!rc) {
+		/* drain the FIFO */
+		for (i =3D 0; i < (uint)rx_len; i++)
+			rx_buf[i] =3D ioread8(spirom->spi + SPI_FIFO + tx_len + i);
+	}
+
+	return rc;
+}
+
+static int amd_spirom_prepare(struct spi_nor *nor, enum spi_nor_ops ops)
+{
+	/* get the semaphore */
+	struct pci_dev *pcidev =3D to_pci_dev(nor->dev);
+	u32 pci_control;
+	int rc =3D -ETIMEDOUT;
+	int count;
+
+	/*
+	 * procedure from BKDG is to wait for EC_SEM to be 0, then write 1 to
+	 * BIOS_SEM, then read back to verify the 1 has been set by HW to grant
+	 * ownership
+	 *
+	 * this is only necessary when the IMC is active
+	 */
+	for (count =3D 0; count < 100 && rc; count++) {
+		pci_read_config_dword(pcidev, FCH_PCI_CONTROL, &pci_control);
+		if (pci_control & FCH_EC_SEM)
+			msleep(50);
+		else {
+			if (pci_control & FCH_BIOS_SEM)
+				rc =3D 0;
+			else
+				pci_write_config_dword(pcidev, FCH_PCI_CONTROL,
+						       pci_control | FCH_BIOS_SEM);
+		}
+	}
+
+	return rc;
+}
+
+static void amd_spirom_unprepare(struct spi_nor *nor, enum spi_nor_ops ops=
)
+{
+	/* we assume we own the semaphore at this point */
+	struct pci_dev *pcidev =3D to_pci_dev(nor->dev);
+	u32 pci_control;
+
+	pci_read_config_dword(pcidev, FCH_PCI_CONTROL, &pci_control);
+
+	pci_control &=3D FCH_LEGACY_DMA;
+
+	pci_write_config_dword(pcidev, FCH_PCI_CONTROL, pci_control);
+}
+
+static int amd_spirom_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf, in=
t len)
+{
+	struct amd_spirom *spirom =3D nor->priv;
+	int rc;
+
+	dev_dbg(nor->dev, "read_reg: op: 0x%02x  len: %d\n", opcode, len);
+
+	rc =3D amd_spirom_reg_xfer(spirom, opcode, len, 0, buf, NULL);
+	if (!rc)
+		dev_dbg(nor->dev, "read_reg: %*ph\n", len, buf);
+	else
+		dev_dbg(nor->dev, "read_reg: failed: %d\n", rc);
+
+	return rc;
+}
+
+static int amd_spirom_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, i=
nt len)
+{
+	struct amd_spirom *spirom =3D nor->priv;
+	int rc;
+
+	dev_dbg(nor->dev, "write_reg: op: 0x%02x  len: %d  data: %*ph\n",
+		opcode, len, len, buf);
+
+	rc =3D amd_spirom_reg_xfer(spirom, opcode, 0, len, NULL, buf);
+
+	if (rc)
+		dev_dbg(nor->dev, "write_reg: failed: %d\n", rc);
+
+	return rc;
+}
+
+/*
+ * fallback read op based on explicit read command
+ * ideally the HW io will be used but this needs to be available if it's n=
ot
+ * strapped, can't get the resources, etc.
+ * spi_nor_read() will loop on the actual bytes read so we can just limit
+ * ourselves to the 64-byte FIFO size.
+ */
+static ssize_t amd_spirom_read(struct spi_nor *nor, loff_t from,
+			       size_t len, u_char *read_buf)
+{
+	struct amd_spirom *spirom =3D nor->priv;
+	u32 *pbuf32;
+	size_t head;
+	size_t tail;
+	size_t left;
+	__be32 addr;
+	ssize_t rc;
+	size_t cur;
+	u8 *p_addr;
+	u8 rd_len;
+	size_t i;
+
+	dev_dbg(nor->dev, "read: from: %lld  len: %zu\n", from, len);
+
+	/*
+	 * We only allow READ in the HWCAPS so most read operations should come
+	 * with that opcode.  However, the SPI-NOR layer can swap out the read
+	 * opcode with something else (i.e. Read SFDP) which must be handled via
+	 * alt command and not the ROM IO
+	 */
+	if (spirom->rom && (nor->read_opcode =3D=3D SPINOR_OP_READ)) {
+		/*
+		 * no need for status/busy as the HW controller will deal with
+		 * that, but memcpy_fromio can make out-of-order fetches so need
+		 * to do this explicitly
+		 */
+		left =3D len;
+		head =3D from & 3;
+		left -=3D head;
+		tail =3D left & 3;
+		left -=3D tail;
+		cur =3D 0;
+
+		for (i =3D 0; i < head; i++, cur++)
+			read_buf[cur] =3D ioread8(spirom->rom + from + cur);
+
+		pbuf32 =3D (u32 *)(read_buf + cur);
+		left /=3D 4;
+
+		for (i =3D 0; i < left; i++, cur +=3D 4, pbuf32++)
+			*pbuf32 =3D ioread32(spirom->rom + from + cur);
+
+		for (i =3D 0; i < tail; i++, cur++)
+			read_buf[cur] =3D ioread8(spirom->rom + from + cur);
+
+		rc =3D (ssize_t)len;
+	} else {
+
+		addr =3D cpu_to_be32((u32)(from));
+		p_addr =3D (u8 *)(&addr);
+
+		rd_len =3D len > 64 ? 64 : (u8)len;
+
+		if (nor->addr_width =3D=3D 3)
+			p_addr++;
+
+		rc =3D amd_spirom_reg_xfer(spirom, nor->read_opcode, rd_len,
+					 nor->addr_width, read_buf, p_addr);
+
+		if (!rc)
+			rc =3D (ssize_t)rd_len;
+	}
+
+	return rc;
+}
+
+static ssize_t amd_spirom_write(struct spi_nor *nor, loff_t to,
+				size_t len, const u_char *write_buf)
+{
+	/*
+	 * spi_nor_write() will have already segmented this into pages
+	 * and we will have overridden the flash page size to 64 (or less)
+	 * for the FIFO size so just need to serialize into one byte stream
+	 * for the addr + data.
+	 * Note Page Program takes a BE address.
+	 * Supposedly the ROM IO space should be able to deal with writes but
+	 * cant get it to work in practice.
+	 */
+	struct amd_spirom *spirom =3D nor->priv;
+	u8 buf[4 + 64];
+	u8 *p_buf =3D buf;
+	__be32 addr;
+	int rc;
+
+	dev_dbg(nor->dev, "write: to: %lld  len: %zu\n", to, len);
+
+	if (len > 64)
+		return -EINVAL;
+
+	addr =3D cpu_to_be32((u32)(to));
+
+	memcpy(buf, &addr, 4);
+
+	memcpy(&buf[4], write_buf, len);
+
+	if (nor->addr_width =3D=3D 3)
+		p_buf++;
+
+	rc =3D amd_spirom_reg_xfer(spirom, nor->program_opcode, 0,
+				 len + nor->addr_width, NULL, p_buf);
+
+	return !rc ? (ssize_t)len : rc;
+}
+
+static int amd_spirom_spi_init(struct device *dev, struct amd_spirom *spir=
om,
+			       bool imc_active)
+{
+	struct spi_nor_hwcaps hwcaps;
+	bool update_speed_config =3D false;
+	u32 spi_read_mode;
+	u32 spi_cntrl0;
+	u16 speed_config;
+	u8 cs_val;
+	int i;
+
+	/*
+	 * Speed and Mode and CS settings should be configured by BIOS
+	 * but can be overridden by module param.
+	 */
+
+	cs_val =3D ioread8(spirom->spi + ALT_SPI_CS);
+	if (chip_select >=3D 0) {
+		if (chip_select < 4) {
+			iowrite8((cs_val & ALT_SPI_CS_MASK) | (u8)(chip_select),
+				 spirom->spi + ALT_SPI_CS);
+
+			dev_info(dev, "updated CS from: %d to: %d\n",
+				cs_val & 0xF, chip_select);
+
+		} else
+			dev_err(dev, "invalid chip_select value: %d\n",
+				chip_select);
+	} else
+		chip_select =3D (short)(cs_val & 0x3);
+
+	if (write_buffer_enable >=3D 0) {
+		cs_val =3D ioread8(spirom->spi + ALT_SPI_CS);
+		if (write_buffer_enable) {
+			iowrite8(cs_val | ALT_SPI_CS_WR_BUF_EN,
+				 spirom->spi + ALT_SPI_CS);
+			dev_info(dev, "enabled write buffer\n");
+		} else {
+			iowrite8(cs_val & ~ALT_SPI_CS_WR_BUF_EN,
+				 spirom->spi + ALT_SPI_CS);
+			dev_info(dev, "disabled write buffer\n");
+		}
+	} else
+		write_buffer_enable =3D (cs_val & ALT_SPI_CS_WR_BUF_EN) >> 2;
+
+	speed_config =3D ioread16(spirom->spi + SPI100_SPEED_CONFIG);
+	dev_info(dev, "SPI100 speed config: 0x%04x\n", speed_config);
+
+	if (alt_speed >=3D 0) {
+		if (alt_speed < 6) {
+			speed_config &=3D 0xFF0F;
+			speed_config |=3D alt_speed << 4;
+			update_speed_config =3D true;
+		} else
+			dev_err(dev, "invalid alt_speed value: %d\n",
+				alt_speed);
+	}
+
+	if (norm_speed >=3D 0) {
+		if (norm_speed < 6) {
+			speed_config &=3D 0x0FFF;
+			speed_config |=3D norm_speed << 12;
+			update_speed_config =3D true;
+		} else
+			dev_err(dev, "invalid norm_speed value: %d\n",
+				norm_speed);
+	}
+
+	if (fast_speed >=3D 0) {
+		if (fast_speed < 6) {
+			speed_config &=3D 0xF0FF;
+			speed_config |=3D fast_speed << 8;
+			update_speed_config =3D true;
+		} else
+			dev_err(dev, "invalid fast_speed value: %d\n",
+				fast_speed);
+	}
+
+	if (update_speed_config) {
+		dev_info(dev, "updated SPI100 speed config: 0x%04x\n",
+			 speed_config);
+		/* do we need to enable 100 mode? */
+		for (i =3D 0; i < 4; i++) {
+			if (((speed_config >> i) & 0xF) =3D=3D 4) {
+				iowrite8(1, spirom->spi + SPI100_ENABLE);
+				dev_info(dev, "SPI100 enabled\n");
+				break;
+			}
+		}
+		iowrite16(speed_config, spirom->spi + SPI100_SPEED_CONFIG);
+	}
+
+	/* AltSpeed is [7:4] */
+	spirom->spi_alt_speed =3D (speed_config >> 4) & 0xF;
+
+	/* which mode are we in, and therefore which reg to read? */
+	spi_cntrl0 =3D ioread32(spirom->spi + SPI_CNTRL0);
+	dev_info(dev, "SPI CNTRL0: 0x%08x\n", spi_cntrl0);
+
+	if (mac_arb_enable >=3D 0) {
+		if (mac_arb_enable) {
+			spi_cntrl0 |=3D SPI_CNTRL0_SPI_ARB_ENABLE;
+			dev_info(dev, "enabled MAC arbritration\n");
+		} else {
+			spi_cntrl0 &=3D SPI_CNTRL0_SPI_ARB_ENABLE;
+			dev_info(dev, "disabled MAC arbitration\n");
+		}
+	} else
+		mac_arb_enable =3D (spi_cntrl0 & SPI_CNTRL0_SPI_ARB_ENABLE) >> 19;
+	/*
+	 * this is a 3 bit mashup with bits [2:1] being [30:29]
+	 * and bit [0] being [18] in the register
+	 */
+	spi_read_mode  =3D (spi_cntrl0 >> 28) & 0x6;
+	spi_read_mode |=3D (spi_cntrl0 & BIT(18)) ? 1 : 0;
+	if (read_mode >=3D 0) {
+		if (read_mode < 8) {
+			spi_read_mode =3D read_mode;
+			spi_cntrl0 &=3D 0x17F80000;
+			spi_cntrl0 |=3D (read_mode & 0x6) << 29;
+			spi_cntrl0 |=3D (read_mode & 0x1) << 18;
+			iowrite32(spi_cntrl0, spirom->spi + SPI_CNTRL0);
+			dev_info(dev, "updated SPI_CNTRL0: 0x%08x\n",
+				 spi_cntrl0);
+		} else
+			dev_err(dev, "invalid read_mode value %d\n", read_mode);
+	}
+
+	/* update the params */
+	read_mode =3D spi_read_mode;
+	alt_speed =3D spirom->spi_alt_speed;
+	norm_speed =3D (speed_config >> 12) & 0xF;
+	fast_speed =3D (speed_config >> 8) & 0xF;
+
+	for (i =3D 0; i < 10; i++)
+		spirom->reg_delay_us[i - 1] =3D amd_spirom_get_usecs_per_bytes(alt_speed=
,
+									     i << 1);
+
+	/* as far as the spi-nor layer is concerned we can only do READ */
+	hwcaps.mask =3D SNOR_HWCAPS_READ | SNOR_HWCAPS_PP;
+
+	spirom->nor.dev =3D dev;
+	spirom->nor.priv =3D spirom;
+
+	spirom->nor.read_reg =3D amd_spirom_read_reg;
+	spirom->nor.write_reg =3D amd_spirom_write_reg;
+	spirom->nor.read =3D amd_spirom_read;
+	spirom->nor.write =3D amd_spirom_write;
+
+	/*
+	 * for now the un/prepare functions only deal with IMC so can global
+	 * enable/disable here.  if it turns out later we need other
+	 * functionality we'll have to filter IMC presence in the actual
+	 * routines.
+	 */
+	if (imc_active) {
+		spirom->nor.prepare =3D amd_spirom_prepare;
+		spirom->nor.unprepare =3D amd_spirom_unprepare;
+	}
+
+	return spi_nor_scan(&spirom->nor, flash_name, &hwcaps);
+}
+
+static int amd_spirom_mtd_init(struct device *dev, struct amd_spirom *spir=
om)
+{
+	struct mtd_partition part;
+	int rc;
+
+	/* need to define a basic partition for the region */
+
+	memset(&part, 0, sizeof(part));
+
+	/* Eventually add a CBFS region parser? */
+
+	part.name =3D part_name;
+	part.size =3D MTDPART_SIZ_FULL;
+
+	/*
+	 * need to override the flash page size to our 64-byte FIFO
+	 * limit so we can let the spi-nor layer take care of the
+	 * segmentation for us
+	 */
+	if (spirom->nor.page_size > 64) {
+		spirom->nor.page_size =3D 64;
+		spirom->nor.mtd.writebufsize =3D 64;
+	}
+
+	rc =3D mtd_device_parse_register(&spirom->nor.mtd, NULL, NULL, &part, 1);
+
+	if (rc)
+		dev_err(dev, "failed MTD device register: %d\n", rc);
+
+	spirom->mtd_registered =3D !rc;
+
+	return rc;
+}
+
+static bool amd_spirom_imc_enabled(struct pci_dev *pcidev)
+{
+	bool imc_enabled =3D false;
+	void __iomem *acpi_misc;
+	u32 imc_present;
+	u8 imc_active;
+
+	pci_read_config_dword(pcidev, FCH_PCI_CONTROL, &imc_present);
+	if (imc_present & FCH_INTEGRATED_EC_PRESENT) {
+		/* this is the hard-coded AcpiMmio Misc region address */
+		acpi_misc =3D ioremap_nocache(0xFED80E00, 256);
+		if (acpi_misc) {
+			imc_active =3D ioread8(acpi_misc + 0x80);
+			imc_enabled =3D imc_active & 0x04;
+			iounmap(acpi_misc);
+			if (imc_enabled)
+				dev_info(&pcidev->dev, "IMC is enabled\n");
+		} else {
+			dev_warn(&pcidev->dev, "failed to map AcpiMmio Misc region, assuming IM=
C is enabled\n");
+			imc_enabled =3D true;
+		}
+	}
+
+	return imc_enabled;
+}
+
+static int amd_spirom_pci_probe(struct pci_dev *pcidev,
+				const struct pci_device_id *id)
+{
+	struct cpuinfo_x86 *cpu =3D &boot_cpu_data;
+	struct device *dev =3D &pcidev->dev;
+	struct amd_spirom *spirom;
+	struct resource *res;
+	u32 spi_base_addr;
+	u32 rom_addr_range;
+	u32 rom_addr_start;
+	u32 rom_addr_end;
+	u32 rom_len;
+	bool imc_active;
+	int rc;
+
+	/*
+	 * Shouldn't get here without an AMD vendor code so ignore that,
+	 * but there are slight variations in the family/model implementations
+	 * that we need to be aware of.
+	 * Right now we only support Family 16h, all models seem to work the
+	 * same.
+	 * Is there a device/function version number somewhere?  That would be
+	 * better to switch off of but can't seem to find anything suitable in
+	 * the BKDG.
+	 */
+	if (cpu->x86 !=3D 0x16) {
+		dev_err(dev,
+			"unsupported CPU family: 0x%02x, only support 16h\n",
+			cpu->x86);
+		return -ENODEV;
+	}
+
+	rc =3D pcim_enable_device(pcidev);
+	if (rc) {
+		dev_err(dev, "failed pci enable: %d\n", rc);
+		return rc;
+	}
+
+	pci_set_master(pcidev);
+
+	spirom =3D devm_kzalloc(dev, sizeof(*spirom), GFP_KERNEL);
+	if (!spirom) {
+		rc =3D -ENOMEM;
+		dev_err(dev, "failed spirom alloc\n");
+		goto err_disable;
+	}
+
+	pci_set_drvdata(pcidev, spirom);
+
+	pci_read_config_dword(pcidev, FCH_SPI_BASE_ADDR, &spi_base_addr);
+
+	dev_info(dev, "SPI base addr: 0x%08x\n", spi_base_addr);
+
+	/*
+	 * set up the SPI region
+	 * the coreboot Hudson ACPI configuration sets this as a PNP0C02 BAR0
+	 * resource, which then gets claimed by the system driver. Problem is
+	 * that there's a bug there where they use the SPI_Base_Addr field
+	 * without masking the RouteTpm2Spi and SpiRomEnable bits so the whole
+	 * region can be incorrectly offset, which can then fail the resource
+	 * requests because of the bad overlap.  There doesn't seem to be any
+	 * ideal way to fix it in an external module so if detected just warn.
+	 */
+
+	res =3D devm_request_mem_region(dev,
+				      spi_base_addr & FCH_SPI_BASE_ADDR_MASK,
+				      SPI_IO_REGION_LEN, "amd-spirom-spi");
+	if (!res)
+		dev_warn(dev, "cannot claim SPI region, this is likely a harmless bug in=
 BIOS and can usually be ignored\n");
+
+	spirom->spi =3D devm_ioremap_nocache(dev,
+					   spi_base_addr & FCH_SPI_BASE_ADDR_MASK,
+					   SPI_IO_REGION_LEN);
+	if (!spirom->spi) {
+		rc =3D -ENOMEM;
+		dev_err(dev, "failed to remap SPI region\n");
+		goto err_disable;
+	}
+
+	imc_active =3D amd_spirom_imc_enabled(pcidev);
+
+	rc =3D amd_spirom_spi_init(dev, spirom, imc_active);
+	if (rc)
+		goto err_disable;
+
+	/*
+	 * look to see if we can use the HW IO support
+	 * if the SPIROM interface is strapped then HW has mapped the SPI flash
+	 * to the ROM regsions 1 and 2, which are the BIOS regions
+	 * we want to use ROM ADDR 2 as that's the 4GB - size range
+	 * but the controller assumes a 24-bit flash so only enable in that case
+	 */
+
+	if (accelerated_rd && (spirom->nor.addr_width =3D=3D 3) &&
+	    (spi_base_addr & FCH_SPI_ROM_ENABLE)) {
+
+		pci_read_config_dword(pcidev, FCH_ROM_ADDR_RANGE_2,
+				      &rom_addr_range);
+
+		dev_info(dev, "ROM address range 2: 0x%08x\n", rom_addr_range);
+
+		rom_addr_start =3D (rom_addr_range & 0xFFFF) << 16;
+		rom_addr_end =3D ((rom_addr_range & 0xFFFF0000) | 0xFFFF);
+		rom_len =3D rom_addr_end - rom_addr_start + 1;
+
+		dev_info(dev, "ROM base: 0x%08x  ROM len: %d\n", rom_addr_start,
+			 rom_len);
+
+		/*
+		 * ok now try to request the ROM regions.
+		 * maybe do a pci_quirk with this at some point to reserve
+		 * early?
+		 */
+
+		res =3D devm_request_mem_region(dev, rom_addr_start, rom_len,
+						"amd-spirom-rom");
+		if (res) {
+			spirom->rom =3D devm_ioremap_nocache(dev, res->start,
+							   rom_len);
+			if (!spirom->rom)
+				dev_warn(dev, "failed to map ROM region, cannot accelerate read\n");
+		} else
+			dev_warn(dev, "failed to request ROM region, cannot accelerate read\n")=
;
+	}
+
+
+	rc =3D amd_spirom_mtd_init(dev, spirom);
+	if (rc)
+		goto err_disable;
+
+	dev_info(dev, "enabled\n");
+
+	return 0;
+
+err_disable:
+	pci_disable_device(pcidev);
+	return rc;
+}
+
+static void amd_spirom_pci_remove(struct pci_dev *pcidev)
+{
+	struct amd_spirom *spirom =3D pci_get_drvdata(pcidev);
+
+	if (spirom && spirom->mtd_registered) {
+		dev_dbg(&pcidev->dev, "mtd unregister\n");
+		mtd_device_unregister(&spirom->nor.mtd);
+	}
+
+	dev_info(&pcidev->dev, "exit\n");
+
+	/* devres should clean up everything else */
+
+	pci_disable_device(pcidev);
+}
+
+static struct pci_driver amd_spirom_pci_driver =3D {
+	.name =3D	"amd-spirom",
+	.id_table =3D amd_fch_lpc_pci_device_ids,
+	.probe =3D	amd_spirom_pci_probe,
+	.remove =3D	amd_spirom_pci_remove,
+
+	/*
+	 * no need to worry about power ops here,
+	 * this whole interface is idle until explicit request
+	 */
+};
+
+module_pci_driver(amd_spirom_pci_driver);
+
+MODULE_DESCRIPTION("MTD SPI-NOR driver for AMD Hudson FCH SPIROM");
+MODULE_AUTHOR("Brett Grandbois <brett.grandbois@opengear.com>");
+MODULE_LICENSE("GPL");
--=20
2.17.1

