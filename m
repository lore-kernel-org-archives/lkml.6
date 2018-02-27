Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753308AbeB0N0r (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 08:26:47 -0500
Received: from mail-co1nam03on0056.outbound.protection.outlook.com ([104.47.40.56]:49808
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753239AbeB0N0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 08:26:45 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com;
From: George Cherian <george.cherian@cavium.com>
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wsa@the-dreams.de, George Cherian <george.cherian@cavium.com>
Subject: [PATCHv2 1/3] i2c: xlp9xx: Check for Bus state before every transfer
Date: Tue, 27 Feb 2018 13:26:18 +0000
Message-Id: <1519737980-27997-1-git-send-email-george.cherian@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BM1PR01CA0086.INDPRD01.PROD.OUTLOOK.COM (10.174.208.154) To
 BY2PR07MB2328.namprd07.prod.outlook.com (10.166.114.142)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14d5be77-5a0d-4712-fb41-08d57de5bcd4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BY2PR07MB2328;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2328;3:7JuIeJfMpCoA8uTotTdbD3nw4iwsZjgU96MyUeCpqtrHgUaGkfgPQOqtxYVztxEy3XhHZinJbZch2xshyxqKo+EDxETRXaxGRO6QTKn3z2q8nSD5Hp0GFmz7KOB4PboRtJnBGNdtLv4eE23KGporNXqkoEEy00uPJ9PHxci/dm2y4K9HLVI7xlZ3s28UAi9zRlCI0xk+jim9/Te81AlU39k2TdtXxDdGftCSMtf9PSP6WS0VRwTUf/5JFi/df9nl;25:PS8S0Wee4yzDO7u53UUdXnQMDqqSUO8Q82hLPmAVAGU1wdv7A0tbnGEQp1lpNPxekUKULzY3ik75ac8NXRznhaoq7fC6zUtgPa7eElO3RHCycDWEz+OpoculPRAGos8049cIed5zlGgmLRk7ZFZn0/ezmR+KviiSwPnE3MDheGJDiV91Lp3zy5UQq4cy3dphiUN9TnuEBIGrDz5rNao8kbQScvH3VZPM39iB/DmGg5UknHJjtbAK7l0D02fWQtucD08Ffon9W6KYipU8pHlJL9R/bYQCC5Hhh7pWKg8Lwc4LSc3DUCQykfNW2LO6Vj0FDUjFP+ADjGKIsx4Jlg07bQ==;31:5pw6UlrvVmYI9j8eJOvA+peELw2pN/MetK21oWXboIfcXqRN+2LnX2s4W0Ey8S/FimPWQ+5e//bDHdDta7rNukj/qJPG0koS9hrOZJG5j/0ghMhqdjr8/1hf9a3hSUFLrbwnGVlpHdnEhxfZyv3CrBfTe581op5fG4WIZavg21i1YeeVlld7QjBChimAPjsL7VKfBiP26e2A5gNi38UvLRUyDjZ78wN2hO5qq+aSzEY=
X-MS-TrafficTypeDiagnostic: BY2PR07MB2328:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2328;20:J/86U30b7m0SbJL0Z7LB18uGxJwsKH+DxieMDhkUhP8XTtYEW6lpIKvfJxtVTQk9ztrmMy4vPKYMDYBm0gqevGAL9P+PEx0Xptq+QhOBTl50V35KQMYUjNpROcQaGAlOho6Q1c+kn4TzUWOR029OaJ1sOZynLbhBd+Glr7AEV3LZgMw9HkzrI6nSCX+Pb47AZNkCYok3D6p5PxX9gYzSQwr+CYaIC3DggAF9FUCsikI/H7y6Z1NJgD5vniKI0aOApixiV/xAZDYHwAubEp60ZwlDonpe/ZCsmGewGcVsGRdzZuBHLB/uagKc5PxKhC2XpArMmfFNwTU54ke/mQLP5+AXJ+3AhEe7p7S34mCeG84o5+4ErgOSZH9YTmDee3EoHTm0cjMzSevjiTf5SyoNTtsQIh+2P9usyfbK4xOaVokze/Dl9IYt12VDSDB25LKHMNE9PFolnXsbuToYjVk2WI4v8ie6nfffXb9r7+MXTKlygxqAhdFJAyLYrTC5rAfY;4:2p2f3v9vmA+C35pFIQuRNvj8AaxnQOkdH5veOo5XRUI6CxCms5nsbSDiGOm2bUGoTAGgkGaRJ8jYJ8p9m1/NuPfeuv5J+Kaxb5Qbfu/3/vMEo3sQIF9E9UxNJAaD2FIteiEGt4SYMWZJ8rYMnqAM8yjtwAIP0R6EQyTM9KQY9sUtBZQnPqe4/2HRS3crSxIrfAK/DMCKVX84XpebXx0vuDXW6Tf0VimlXYT0qDc5P/UhnDb0OwnS+dqXcs4RcJPkIHRc1hbLrEasS8djIKfyFQ==
X-Microsoft-Antispam-PRVS: <BY2PR07MB2328DA284E6D1C04CE2F106DF9C00@BY2PR07MB2328.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(3231220)(944501198)(93006095)(93001095)(10201501046)(6041288)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BY2PR07MB2328;BCL:0;PCL:0;RULEID:;SRVR:BY2PR07MB2328;
X-Forefront-PRVS: 05961EBAFC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39380400002)(366004)(396003)(39860400002)(199004)(189003)(97736004)(51416003)(50466002)(86362001)(48376002)(36756003)(66066001)(305945005)(6486002)(7736002)(53416004)(26005)(386003)(68736007)(16526019)(478600001)(16586007)(6666003)(72206003)(316002)(52116002)(4326008)(106356001)(5009440100003)(25786009)(107886003)(551934003)(105586002)(186003)(6506007)(53936002)(6512007)(6116002)(3846002)(5660300001)(81166006)(50226002)(8676002)(2906002)(69596002)(81156014)(47776003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB2328;H:ubuntu.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR07MB2328;23:t/fDjQoPKwNkgBQmRyKd88uo+bQiwWU4JlBy3Ycn0?=
 =?us-ascii?Q?8YwUhncZ5IJ2MEzQ+voz5YBG/Woh3cbjxy0bg4RS80IrPgWb1XHPPieLWUuT?=
 =?us-ascii?Q?5wJXCAYAEgeIVp8mQL5+PSjCMIEQMy8PW6QXHwawRQ529CA/W1tp2l8evMjV?=
 =?us-ascii?Q?SP8fY+BGZuIiwCon4eArQlUKwjcVDZpbGfI5n4JCYJcuamGqwgIya3xllCT5?=
 =?us-ascii?Q?W0nwGBwaODf5bcPjd5z7eCoRwpxOXHvt38cItMYLcFmQBn58XOaAMk56j5Da?=
 =?us-ascii?Q?1qfOR5LKzTeTLlVNja3xglMOsdf8PmggxJoX87ZZsac/fVpQtddzhkmvzzLO?=
 =?us-ascii?Q?NoTjfaFJydHPG4YEHdl345jf4kyu3SholsnbfLyxXa61x7VOuT4uN/VCRuUb?=
 =?us-ascii?Q?AVZdDl9Fl7xEKvrfdhO5UYs1NOqipf95cm+09wgP3igJdY7DSR71B9ediT/8?=
 =?us-ascii?Q?pG6lyYk53e3+yL904N1aqeiSCK6jXHSTI4quLSjxvHYO8IPTVx6A8drJzMn+?=
 =?us-ascii?Q?oDEdSrh1h8RlAgbd/7GT/7OCYF4UZrHEcQQI9Y4jIqxWL3LqpwJtkEM7Pu1c?=
 =?us-ascii?Q?EfHElz30xd08NqgNyytNdybxFcvDvKC0ljgsn6JN9W7y9Q1xeL5pFLhNPIuh?=
 =?us-ascii?Q?bVVUS4m4LLrhdpVYpdpHcCxZPBfCI/MCfLXW8Hnt1Ess7WuYJfQiRbf6y4mZ?=
 =?us-ascii?Q?pFPERaXfY/eJ2zGm0hSWfndblkKcAkn5AMFGdxCKn184aDFUD8229IQBXWPv?=
 =?us-ascii?Q?ersb0A4fDZDK7EwU5bJF0WMWULQgDOAhUiklf/OFXlQ9+n1exZfb49xk0AWB?=
 =?us-ascii?Q?Ew5gXahLD5UOJc9E2FFiNDugbBYERf6v0KDvK1f/dGYNdXgm7kmps92YghHL?=
 =?us-ascii?Q?r8uihglBDzYuPq9q+Melb9pgfBesw4wYtgK67EegQ3qoJTppX8QwHFD0D4wl?=
 =?us-ascii?Q?16YJPa/nTKAWqf+02RHI8FoPLhUyqqVIcq7edzzxCKmeEcDfCjZMe0YXN/K3?=
 =?us-ascii?Q?xzLg/yttMwt8cGoKuf0aYXgSDLrOWG2d9FQCdz4vl+FVWpo2hc4zkm/9RaSV?=
 =?us-ascii?Q?opkWfu9ieq1kbwRaFLOEtWBJ5XnfL1uU6/P/QchZcSFHftOPtB5LtQeoNBTX?=
 =?us-ascii?Q?0OzDJMqT8zFvmiy2InTROaijbtsQzRKbJRssYd/rafnLO4hPdZI/kzQCx0Ct?=
 =?us-ascii?Q?WkDrrypQc1i+Rg=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2328;6:JGZs5PKkjdyz1M02F7ZNeDODdpeB6K48LTZTslmfXbnIIJ+VRBX/5ED4Gp5j8YTgn95w+m4en4ua2UNUxrfM+9nql6G6ZntsTg1vOfXfFwEkrDyKXZpHXLhjCHIUxqUrNvwFuDKq0m1DBnepVNzjqchRLbld1Z+aZGj6ffFZ7YWNK1Hb+VPmf5jCplURQBaQ4K3aWJKT+Aft4d8oADcWdZGlgHy2bPRXtWq3ZAguNoGCmTylzxFPcVdHguF6DBySNNDSi5jRejkbr13TwDUwCOb7Ds1R9FY6573Hg2QmobX3lCELnJ06w76BsQB0EySZWcErFaT10rvAR6tLyfZamz/FMNCgjS70nuRMdzmIUTo=;5:FnqoSDLP18/21N92iSd0AE9CfE3/3v5Abks3qRSl3PkccFpXGyKtUR0u2p/76Hj1FPuK8QOFXXRTZ36Br4r7Yyp/Gr4NNjQSlcmw2gHMn1axnLxkWYJTvdh2npK4IJeuOgA+KqF9lR+0m6ETXHdxzJZhMFZeFWR1QKYXW3utfM0=;24:7kYptB+LnGTswjSEXAbgcSOwJAb20LCnDV94Lt9jjL/LXVagTFgj0H2LZdZGISNGnic/entTJj/+8WuID4awVJ30CxdPy4y9tKW3mSSgtf8=;7:941iA78SMKLe4q+NMxrZK6OyqZrJz9yWPpIQv1M1oGD7XUfZdPAm2chCXi17hPeUb2aASimbVeYLwPMDpgJxVdcXYnVrEJ9GvZZtf60wIey72j/g9FZoVZSVjnwLbdmgWK/D00gqlxJdeIe7qQPe4MekXagSay4DJjXOUwVIw9F/6V0SCDeZDfsobhhbAx2cpxjYXJ4vo7TQNPqb8Pqh0amty1ioSi0gApg/jfsBQog/SpZxTXP5mteBNlNKxan2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 13:26:39.5600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d5be77-5a0d-4712-fb41-08d57de5bcd4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR07MB2328
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2C bus enters the STOP condition after the DATA_DONE interrupt is raised.
Essentially the driver should be checking the bus state before sending
any transaction. In case a transaction is initiated while the
bus is busy, the prior transaction's stop condition is not achieved.
Add the check to make sure the bus is not busy before every transaction.

Signed-off-by: George Cherian <george.cherian@cavium.com>
---
 drivers/i2c/busses/i2c-xlp9xx.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index 1f6d780..42dd1fa 100644
--- a/drivers/i2c/busses/i2c-xlp9xx.c
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/delay.h>
 
 #define XLP9XX_I2C_DIV			0x0
 #define XLP9XX_I2C_CTRL			0x1
@@ -36,6 +37,8 @@
 #define XLP9XX_I2C_TIMEOUT		0X10
 #define XLP9XX_I2C_GENCALLADDR		0x11
 
+#define XLP9XX_I2C_STATUS_BUSY		BIT(0)
+
 #define XLP9XX_I2C_CMD_START		BIT(7)
 #define XLP9XX_I2C_CMD_STOP		BIT(6)
 #define XLP9XX_I2C_CMD_READ		BIT(5)
@@ -71,6 +74,7 @@
 #define XLP9XX_I2C_HIGH_FREQ		400000
 #define XLP9XX_I2C_FIFO_SIZE		0x80U
 #define XLP9XX_I2C_TIMEOUT_MS		1000
+#define XLP9XX_I2C_BUSY_TIMEOUT		50
 
 #define XLP9XX_I2C_FIFO_WCNT_MASK	0xff
 #define XLP9XX_I2C_STATUS_ERRMASK	(XLP9XX_I2C_INTEN_ARLOST | \
@@ -241,6 +245,26 @@ static irqreturn_t xlp9xx_i2c_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int xlp9xx_i2c_check_bus_status(struct xlp9xx_i2c_dev *priv)
+{
+	u32 status;
+	u32 busy_timeout = XLP9XX_I2C_BUSY_TIMEOUT;
+
+	while (busy_timeout) {
+		status = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_STATUS);
+		if ((status & XLP9XX_I2C_STATUS_BUSY) == 0)
+			break;
+
+		busy_timeout--;
+		usleep_range(1000, 1100);
+	}
+
+	if (!busy_timeout)
+		return -EIO;
+
+	return 0;
+}
+
 static int xlp9xx_i2c_init(struct xlp9xx_i2c_dev *priv)
 {
 	u32 prescale;
@@ -363,6 +387,14 @@ static int xlp9xx_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	int i, ret;
 	struct xlp9xx_i2c_dev *priv = i2c_get_adapdata(adap);
 
+	ret = xlp9xx_i2c_check_bus_status(priv);
+	if (ret) {
+		xlp9xx_i2c_init(priv);
+		ret = xlp9xx_i2c_check_bus_status(priv);
+		if (ret)
+			return ret;
+	}
+
 	for (i = 0; i < num; i++) {
 		ret = xlp9xx_i2c_xfer_msg(priv, &msgs[i], i == num - 1);
 		if (ret != 0)
-- 
2.1.4
