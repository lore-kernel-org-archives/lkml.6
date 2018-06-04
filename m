Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751409AbeFDTBM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 15:01:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751354AbeFDTBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 15:01:08 -0400
From: Eddie James <eajames@linux.vnet.ibm.com>
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        wsa@the-dreams.de, robh+dt@kernel.org, benh@kernel.crashing.org,
        joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, andy.shevchenko@gmail.com,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v9 3/7] i2c: fsi: Add port structures
Date: Mon,  4 Jun 2018 14:00:46 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1528138850-18259-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1528138850-18259-1-git-send-email-eajames@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18060419-0060-0000-0000-000002781684
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009129; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01042302; UDB=6.00533707; IPR=6.00821432;
 MB=3.00021461; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-04 19:01:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060419-0061-0000-0000-0000455670AC
Message-Id: <1528138850-18259-4-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-04_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806040219
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and initialize I2C adapters for each port on the FSI-attached I2C
master. Ports for each master are defined in the devicetree.

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 drivers/i2c/busses/i2c-fsi.c | 90 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index e1b183c..12130c3 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -17,7 +17,10 @@
 #include <linux/fsi.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/slab.h>
 
 #define FSI_ENGID_I2C		0x7
 
@@ -123,6 +126,14 @@
 struct fsi_i2c_master {
 	struct fsi_device	*fsi;
 	u8			fifo_size;
+	struct list_head	ports;
+};
+
+struct fsi_i2c_port {
+	struct list_head	list;
+	struct i2c_adapter	adapter;
+	struct fsi_i2c_master	*master;
+	u16			port;
 };
 
 static int fsi_i2c_read_reg(struct fsi_device *fsi, unsigned int reg,
@@ -176,9 +187,38 @@ static int fsi_i2c_dev_init(struct fsi_i2c_master *i2c)
 	return fsi_i2c_write_reg(i2c->fsi, I2C_FSI_WATER_MARK, &watermark);
 }
 
+static int fsi_i2c_set_port(struct fsi_i2c_port *port)
+{
+	int rc;
+	struct fsi_device *fsi = port->master->fsi;
+	u32 mode, dummy = 0;
+
+	rc = fsi_i2c_read_reg(fsi, I2C_FSI_MODE, &mode);
+	if (rc)
+		return rc;
+
+	if (FIELD_GET(I2C_MODE_PORT, mode) == port->port)
+		return 0;
+
+	mode = (mode & ~I2C_MODE_PORT) | FIELD_PREP(I2C_MODE_PORT, port->port);
+	rc = fsi_i2c_write_reg(fsi, I2C_FSI_MODE, &mode);
+	if (rc)
+		return rc;
+
+	/* reset engine when port is changed */
+	return fsi_i2c_write_reg(fsi, I2C_FSI_RESET_ERR, &dummy);
+}
+
 static int fsi_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			int num)
 {
+	int rc;
+	struct fsi_i2c_port *port = adap->algo_data;
+
+	rc = fsi_i2c_set_port(port);
+	if (rc)
+		return rc;
+
 	return -EOPNOTSUPP;
 }
 
@@ -196,23 +236,72 @@ static u32 fsi_i2c_functionality(struct i2c_adapter *adap)
 static int fsi_i2c_probe(struct device *dev)
 {
 	struct fsi_i2c_master *i2c;
+	struct fsi_i2c_port *port;
+	struct device_node *np;
 	int rc;
+	u32 port_no;
 
 	i2c = devm_kzalloc(dev, sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
 
 	i2c->fsi = to_fsi_dev(dev);
+	INIT_LIST_HEAD(&i2c->ports);
 
 	rc = fsi_i2c_dev_init(i2c);
 	if (rc)
 		return rc;
 
+	/* Add adapter for each i2c port of the master. */
+	for_each_available_child_of_node(dev->of_node, np) {
+		rc = of_property_read_u32(np, "reg", &port_no);
+		if (rc || port_no > USHRT_MAX)
+			continue;
+
+		port = kzalloc(sizeof(*port), GFP_KERNEL);
+		if (!port)
+			break;
+
+		port->master = i2c;
+		port->port = port_no;
+
+		port->adapter.owner = THIS_MODULE;
+		port->adapter.dev.of_node = np;
+		port->adapter.dev.parent = dev;
+		port->adapter.algo = &fsi_i2c_algorithm;
+		port->adapter.algo_data = port;
+
+		snprintf(port->adapter.name, sizeof(port->adapter.name),
+			 "i2c_bus-%u", port_no);
+
+		rc = i2c_add_adapter(&port->adapter);
+		if (rc < 0) {
+			dev_err(dev, "Failed to register adapter: %d\n", rc);
+			kfree(port);
+			continue;
+		}
+
+		list_add(&port->list, &i2c->ports);
+	}
+
 	dev_set_drvdata(dev, i2c);
 
 	return 0;
 }
 
+static int fsi_i2c_remove(struct device *dev)
+{
+	struct fsi_i2c_master *i2c = dev_get_drvdata(dev);
+	struct fsi_i2c_port *port;
+
+	list_for_each_entry(port, &i2c->ports, list) {
+		i2c_del_adapter(&port->adapter);
+		kfree(port);
+	}
+
+	return 0;
+}
+
 static const struct fsi_device_id fsi_i2c_ids[] = {
 	{ FSI_ENGID_I2C, FSI_VERSION_ANY },
 	{ 0 }
@@ -224,6 +313,7 @@ static int fsi_i2c_probe(struct device *dev)
 		.name = "i2c-fsi",
 		.bus = &fsi_bus_type,
 		.probe = fsi_i2c_probe,
+		.remove = fsi_i2c_remove,
 	},
 };
 
-- 
1.8.3.1
