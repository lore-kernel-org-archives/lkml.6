Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968351AbeE2WY7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 18:24:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S968453AbeE2WYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 18:24:44 -0400
From: Eddie James <eajames@linux.vnet.ibm.com>
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        wsa@the-dreams.de, robh+dt@kernel.org, benh@kernel.crashing.org,
        joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org,
        "Edward A. James" <eajames@us.ibm.com>
Subject: [PATCH v7 2/7] drivers/i2c: Add FSI-attached I2C master algorithm
Date: Tue, 29 May 2018 17:24:20 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1527632665-25707-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1527632665-25707-1-git-send-email-eajames@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052922-0016-0000-0000-000008D42A20
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009097; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01039556; UDB=6.00532065; IPR=6.00818685;
 MB=3.00021364; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-29 22:24:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052922-0017-0000-0000-00003EFCE282
Message-Id: <1527632665-25707-3-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805290238
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Edward A. James" <eajames@us.ibm.com>

Add register definitions for FSI-attached I2C master and functions to
access those registers over FSI. Add an FSI driver so that our I2C bus
is probed up during an FSI scan.

Signed-off-by: Edward A. James <eajames@us.ibm.com>
---
 drivers/i2c/busses/Kconfig   |  11 ++
 drivers/i2c/busses/Makefile  |   1 +
 drivers/i2c/busses/i2c-fsi.c | 244 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 256 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-fsi.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 4f8df2e..ebba369 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -1330,4 +1330,15 @@ config I2C_ZX2967
 	  This driver can also be built as a module. If so, the module will be
 	  called i2c-zx2967.
 
+config I2C_FSI
+	tristate "FSI I2C driver"
+	depends on FSI
+	help
+	  Driver for FSI bus attached I2C masters. These are I2C masters that
+	  are connected to the system over a FSI bus, instead of the more
+	  common PCI or MMIO interface.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called as i2c-fsi.
+
 endmenu
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 5a86914..4909fd6 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -137,5 +137,6 @@ obj-$(CONFIG_I2C_PCA_ISA)	+= i2c-pca-isa.o
 obj-$(CONFIG_I2C_SIBYTE)	+= i2c-sibyte.o
 obj-$(CONFIG_I2C_XGENE_SLIMPRO) += i2c-xgene-slimpro.o
 obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
+obj-$(CONFIG_I2C_FSI)		+= i2c-fsi.o
 
 ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG
diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
new file mode 100644
index 0000000..79475f8
--- /dev/null
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -0,0 +1,244 @@
+/*
+ * Copyright 2017 IBM Corporation
+ *
+ * Eddie James <eajames@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/fsi.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#define FSI_ENGID_I2C		0x7
+
+/* Find left shift from first set bit in m */
+#define MASK_TO_LSH(m)		(__builtin_ffsll(m) - 1ULL)
+
+/* Extract field m from v */
+#define GETFIELD(m, v)		(((v) & (m)) >> MASK_TO_LSH(m))
+
+/* Set field m of v to val */
+#define SETFIELD(m, v, val)	\
+	(((v) & ~(m)) | ((((typeof(v))(val)) << MASK_TO_LSH(m)) & (m)))
+
+#define I2C_DEFAULT_CLK_DIV	6
+
+/* i2c registers */
+#define I2C_FSI_FIFO		0x00
+#define I2C_FSI_CMD		0x04
+#define I2C_FSI_MODE		0x08
+#define I2C_FSI_WATER_MARK	0x0C
+#define I2C_FSI_INT_MASK	0x10
+#define I2C_FSI_INT_COND	0x14
+#define I2C_FSI_OR_INT_MASK	0x14
+#define I2C_FSI_INTS		0x18
+#define I2C_FSI_AND_INT_MASK	0x18
+#define I2C_FSI_STAT		0x1C
+#define I2C_FSI_RESET_I2C	0x1C
+#define I2C_FSI_ESTAT		0x20
+#define I2C_FSI_RESET_ERR	0x20
+#define I2C_FSI_RESID_LEN	0x24
+#define I2C_FSI_SET_SCL		0x24
+#define I2C_FSI_PORT_BUSY	0x28
+#define I2C_FSI_RESET_SCL	0x2C
+#define I2C_FSI_SET_SDA		0x30
+#define I2C_FSI_RESET_SDA	0x34
+
+/* cmd register */
+#define I2C_CMD_WITH_START	0x80000000
+#define I2C_CMD_WITH_ADDR	0x40000000
+#define I2C_CMD_RD_CONT		0x20000000
+#define I2C_CMD_WITH_STOP	0x10000000
+#define I2C_CMD_FORCELAUNCH	0x08000000
+#define I2C_CMD_ADDR		0x00fe0000
+#define I2C_CMD_READ		0x00010000
+#define I2C_CMD_LEN		0x0000ffff
+
+/* mode register */
+#define I2C_MODE_CLKDIV		0xffff0000
+#define I2C_MODE_PORT		0x0000fc00
+#define I2C_MODE_ENHANCED	0x00000008
+#define I2C_MODE_DIAG		0x00000004
+#define I2C_MODE_PACE_ALLOW	0x00000002
+#define I2C_MODE_WRAP		0x00000001
+
+/* watermark register */
+#define I2C_WATERMARK_HI	0x0000f000
+#define I2C_WATERMARK_LO	0x000000f0
+
+#define I2C_FIFO_HI_LVL		4
+#define I2C_FIFO_LO_LVL		4
+
+/* interrupt register */
+#define I2C_INT_INV_CMD		0x00008000
+#define I2C_INT_PARITY		0x00004000
+#define I2C_INT_BE_OVERRUN	0x00002000
+#define I2C_INT_BE_ACCESS	0x00001000
+#define I2C_INT_LOST_ARB	0x00000800
+#define I2C_INT_NACK		0x00000400
+#define I2C_INT_DAT_REQ		0x00000200
+#define I2C_INT_CMD_COMP	0x00000100
+#define I2C_INT_STOP_ERR	0x00000080
+#define I2C_INT_BUSY		0x00000040
+#define I2C_INT_IDLE		0x00000020
+
+#define I2C_INT_ENABLE		0x0000ff80
+#define I2C_INT_ERR		0x0000fcc0
+
+/* status register */
+#define I2C_STAT_INV_CMD	0x80000000
+#define I2C_STAT_PARITY		0x40000000
+#define I2C_STAT_BE_OVERRUN	0x20000000
+#define I2C_STAT_BE_ACCESS	0x10000000
+#define I2C_STAT_LOST_ARB	0x08000000
+#define I2C_STAT_NACK		0x04000000
+#define I2C_STAT_DAT_REQ	0x02000000
+#define I2C_STAT_CMD_COMP	0x01000000
+#define I2C_STAT_STOP_ERR	0x00800000
+#define I2C_STAT_MAX_PORT	0x000f0000
+#define I2C_STAT_ANY_INT	0x00008000
+#define I2C_STAT_SCL_IN		0x00000800
+#define I2C_STAT_SDA_IN		0x00000400
+#define I2C_STAT_PORT_BUSY	0x00000200
+#define I2C_STAT_SELF_BUSY	0x00000100
+#define I2C_STAT_FIFO_COUNT	0x000000ff
+
+#define I2C_STAT_ERR		0xfc800000
+#define I2C_STAT_ANY_RESP	0xff800000
+
+/* extended status register */
+#define I2C_ESTAT_FIFO_SZ	0xff000000
+#define I2C_ESTAT_SCL_IN_SY	0x00008000
+#define I2C_ESTAT_SDA_IN_SY	0x00004000
+#define I2C_ESTAT_S_SCL		0x00002000
+#define I2C_ESTAT_S_SDA		0x00001000
+#define I2C_ESTAT_M_SCL		0x00000800
+#define I2C_ESTAT_M_SDA		0x00000400
+#define I2C_ESTAT_HI_WATER	0x00000200
+#define I2C_ESTAT_LO_WATER	0x00000100
+#define I2C_ESTAT_PORT_BUSY	0x00000080
+#define I2C_ESTAT_SELF_BUSY	0x00000040
+#define I2C_ESTAT_VERSION	0x0000001f
+
+struct fsi_i2c_master {
+	struct fsi_device	*fsi;
+	u8			fifo_size;
+};
+
+static int fsi_i2c_read_reg(struct fsi_device *fsi, unsigned int reg,
+			    u32 *data)
+{
+	int rc;
+	__be32 data_be;
+
+	rc = fsi_device_read(fsi, reg, &data_be, sizeof(data_be));
+	if (rc)
+		return rc;
+
+	*data = be32_to_cpu(data_be);
+
+	return 0;
+}
+
+static int fsi_i2c_write_reg(struct fsi_device *fsi, unsigned int reg,
+			     u32 *data)
+{
+	__be32 data_be = cpu_to_be32(*data);
+
+	return fsi_device_write(fsi, reg, &data_be, sizeof(data_be));
+}
+
+static int fsi_i2c_dev_init(struct fsi_i2c_master *i2c)
+{
+	int rc;
+	u32 mode = I2C_MODE_ENHANCED, extended_status, watermark = 0;
+	u32 interrupt = 0;
+
+	/* since we use polling, disable interrupts */
+	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_INT_MASK, &interrupt);
+	if (rc)
+		return rc;
+
+	mode = SETFIELD(I2C_MODE_CLKDIV, mode, I2C_DEFAULT_CLK_DIV);
+	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_MODE, &mode);
+	if (rc)
+		return rc;
+
+	rc = fsi_i2c_read_reg(i2c->fsi, I2C_FSI_ESTAT, &extended_status);
+	if (rc)
+		return rc;
+
+	i2c->fifo_size = GETFIELD(I2C_ESTAT_FIFO_SZ, extended_status);
+	watermark = SETFIELD(I2C_WATERMARK_HI, watermark,
+			     i2c->fifo_size - I2C_FIFO_HI_LVL);
+	watermark = SETFIELD(I2C_WATERMARK_LO, watermark,
+			     I2C_FIFO_LO_LVL);
+
+	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_WATER_MARK, &watermark);
+
+	return rc;
+}
+
+static int fsi_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
+			int num)
+{
+	return -EOPNOTSUPP;
+}
+
+static u32 fsi_i2c_functionality(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_PROTOCOL_MANGLING | I2C_FUNC_10BIT_ADDR
+		| I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SMBUS_BLOCK_DATA;
+}
+
+static const struct i2c_algorithm fsi_i2c_algorithm = {
+	.master_xfer = fsi_i2c_xfer,
+	.functionality = fsi_i2c_functionality,
+};
+
+static int fsi_i2c_probe(struct device *dev)
+{
+	struct fsi_i2c_master *i2c;
+	int rc;
+
+	i2c = devm_kzalloc(dev, sizeof(*i2c), GFP_KERNEL);
+	if (!i2c)
+		return -ENOMEM;
+
+	i2c->fsi = to_fsi_dev(dev);
+
+	rc = fsi_i2c_dev_init(i2c);
+	if (rc)
+		return rc;
+
+	dev_set_drvdata(dev, i2c);
+
+	return 0;
+}
+
+static const struct fsi_device_id fsi_i2c_ids[] = {
+	{ FSI_ENGID_I2C, FSI_VERSION_ANY },
+	{ 0 }
+};
+
+static struct fsi_driver fsi_i2c_driver = {
+	.id_table = fsi_i2c_ids,
+	.drv = {
+		.name = "i2c-fsi",
+		.bus = &fsi_bus_type,
+		.probe = fsi_i2c_probe,
+	},
+};
+
+module_fsi_driver(fsi_i2c_driver);
+
+MODULE_AUTHOR("Eddie James <eajames@us.ibm.com>");
+MODULE_DESCRIPTION("FSI attached I2C master");
+MODULE_LICENSE("GPL");
-- 
1.8.3.1
