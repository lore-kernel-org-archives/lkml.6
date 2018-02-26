Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbeBZAaI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 19:30:08 -0500
Received: from mail-co1nam03on0076.outbound.protection.outlook.com ([104.47.40.76]:7840
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751928AbeBZA3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 19:29:51 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrew.cooks@opengear.com;
From: Andrew Cooks <andrew.cooks@opengear.com>
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org (open list:I2C/SMBUS CONTROLLER DRIVERS FOR
        PC),
        linux-kernel@vger.kernel.org (open list)
Cc: Andrew Cooks <acooks@rationali.st>, linux-acpi@vger.kernel.org,
        platypus-sw@opengear.com, "Tobin C . Harding" <me@tobin.cc>,
        Andrew Cooks <andrew.cooks@opengear.com>
Subject: [RESEND][PATCH v4 2/3] i2c: piix4: fix probing of reserved ports on AMD
Date: Mon, 26 Feb 2018 10:28:44 +1000
Message-Id: <970f151329b43cfa5f842dc0fe0604b03c5c1297.1519601860.git.andrew.cooks@opengear.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1519601860.git.andrew.cooks@opengear.com>
References: <cover.1519601860.git.andrew.cooks@opengear.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [59.167.150.161]
X-ClientProxiedBy: ME2PR01CA0002.ausprd01.prod.outlook.com
 (2603:10c6:201:15::14) To DM5PR15MB1210.namprd15.prod.outlook.com
 (2603:10b6:3:b2::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9fe74b3-56c2-4343-31d7-08d57cb00bc2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR15MB1210;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1210;3:9UO5hnLhuGBAM1WM9l70VLqsJ0B1wbs86C56O61WVguc3c35Ga9GtA8wQkoIezHNPriiCZuY/Ewud1z1Kij3FLsvFYdoywJctv/dph/jPl3p+o9p2Yb6IeYHR9H56HZf7hRBOG0FpZ94VK627RCbpts+nDXcqgpgEB49fI+Xq9fiF7k3CM/kfcFWUAueaC++vLUtZghZwnKvoMekXi3G3GNYNA2r76Xmfunm+iaWf3R1rbKypULw2azcAyZE3Ywb;25:GcM/FjA3gkDxV1JSpTezTS4sNHPCt2YaGAkPADGo80BJAZo932VriYIJQep/aL2N9KdGGTfXTaJ3KNcanqk6myH8TfXYnc6yp2k2niSuj9a/qX6OtLvPk4S8PJkjs31eLqc7WSvQN4xVl+EmA2QKOrQJULERnRvYLhG0yehsBg9zRW6pOVDftyUNUB+UsP6ZuwQa/AzL6S7qCfLMxY2wCLElgt4QGi3iKORctf0FCHThlCv7SBtQJxw1Hks4DPovFfDTpDm997m6yAy7a/0RdgRHsgPekzCtsStUONqO48/zmeOuApV3PDC9wJhv70gHzFQJ7lBaE14PLPa/pBttVw==;31:bDmwBfAxvGNRy2jpa3v4dm88YLbCU/e7rsRdsVFZymCN6nD9eKEohN1xWHJXdCsO2oilD8mLQ7bnwg+J4CGawzWThpALtz+yzwTDzLDgB0D6T+EvlBjEUSdkutyb/PJW63ZbNYCvs0KEETzo8SV5iLVJ7QgWcig0YIToOnEMDH7H/pXFUPmuF53HA213WjWyBCtsb3lc6GlrCnMzHX8apXXDfGIuGWXsT6dYwn0ajhs=
X-MS-TrafficTypeDiagnostic: DM5PR15MB1210:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1210;20:I2LVCrGzbYaNf0GuYhEquJn/34oGVNmwXSjlAku9o2U1Z9NOOdeK9ZSvrSX2eUhiHR0Mg+a7raZsmwNCa4B4Mle4+Dj1ZxCuPXQG6UQiryyw+G3ZmSwysWk3IIEPOOt2V5C4T1tygZ2xc8DKHQOnio54W0YUaZjs3UvZulQuJrM=;4:OLwzR99poOTZ8LzLEFQFuK0OkNtL9fPsL699p/XELxout/gtudbCYUvq/vrzem9+3Wu8oJL6oTcD3aoEFTt3y+GZWaqNB0wsRtyBlzRSExTe+MhJ016KbiiaLXQt6nKNxb3tkC8NrgR/5CNT0UoLBOxgOxfBacjmSkvCnm3z8/Oc8HAmQVqubgRFmArHiqZu/i0LvC4NYPTImeanadGSTK9V2+Q6WAlf7Ye8vOFuV4T3IZQtGeQGCQBk1QtzwB5fVGDHCCOsOnx4LOEf5wEacA==
X-Microsoft-Antispam-PRVS: <DM5PR15MB1210B69BA18827DB7E8A7714EEC10@DM5PR15MB1210.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501161)(52105095)(6041288)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR15MB1210;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1210;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39830400003)(39380400002)(366004)(199004)(189003)(66066001)(76176011)(52116002)(7696005)(1857600001)(97736004)(68736007)(54906003)(110136005)(118296001)(6486002)(51416003)(50466002)(48376002)(186003)(4326008)(16526019)(26005)(316002)(86362001)(25786009)(386003)(107886003)(305945005)(16586007)(105586002)(3846002)(6116002)(478600001)(53936002)(5660300001)(36756003)(7736002)(2906002)(106356001)(8676002)(2950100002)(81166006)(8936002)(50226002)(47776003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR15MB1210;H:andrewc.bne.opengear.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR15MB1210;23:z2uWgibIVawNLs5RBjsRNBi5oDlOgd5QSvdqYLgRa?=
 =?us-ascii?Q?g1vsxI81j58YjdM3/S6Ugv8c8mC4+LcDP/0NxQWjyJmekkWkTomhFvEnhXzW?=
 =?us-ascii?Q?9q5EGi9e7tEAipftY6RPanX9drnKLeI9LjhcRTU+67uBbYG3ZlexpzA7bFTj?=
 =?us-ascii?Q?SrJpc0oHFhZKFFIM7spHksbrWWWOb1/oY4wjlxVYDM+a0l3BUbWgYsjhbaoA?=
 =?us-ascii?Q?Xt3frn2COkh9yokxrXeW+DI0vfZdq6eqCCZncvN2SQ9BxtSJTg6GgUpUBlJM?=
 =?us-ascii?Q?ZIsV5Q/7QBAoXOb+Ch9oiE6zqmw4/gkiGsgf1WtZd0OeppjR5IPQvhYkLyja?=
 =?us-ascii?Q?kvzd1Pgg6qQAG9ah5eUXSOWgTYToQkFNOE7n6MzpsXMKWITI6amncaWJDXZg?=
 =?us-ascii?Q?jGcVpJeSPIj9zYCx4NRb5gVTbb1Cz7tvJdDZGujbPeNRw/cPL4xYVjDBbBYR?=
 =?us-ascii?Q?WdtgoDbAN3GatglmRVTXDTn9VgykSl0vH3Cy5MKV7kf0yxAB1SGWHS3goC9+?=
 =?us-ascii?Q?JSXeCXTh0mRKL1kFElKHQB5FYV3LCxL4Xw1zFTmZpbE+a13Sh/kiMIRcDO7S?=
 =?us-ascii?Q?WyTcjfzypA8t6OpaDGj0WKT97iaK2FPlGu8ZW0n9uc50LUay3KvUV25qJ2LM?=
 =?us-ascii?Q?hiYna3AU/0qz89OJ4ugmD0JK4rg7ptFrKYPTMdLcQhPYw9oiWT2BF/tqWH27?=
 =?us-ascii?Q?rFm00RmHeKsEn7aQC0o4mva+vhN7jUe62fwRrcg12aRs1bCbsV8TY0g0zhgg?=
 =?us-ascii?Q?pKLEPdDt134atshPhL0+gz/DXD2vMIayeQnk6FB8wIromMXrK24m65V9HRMU?=
 =?us-ascii?Q?AgDEr4IIhvlFxHVHsioRqDdal3TpSf7kceb/sPbQn789woj2DRgz5ufW+iIp?=
 =?us-ascii?Q?hiWO6dP9dw5S352QHf1vgJNkNog9K0euZi6dN4I9qqiyFijen4opcrzwtZaZ?=
 =?us-ascii?Q?foti489gnw2IxKAkKUvK1V5JV+uFQo8l2NWkvXmRy0dO/IE7VbJrXc9sdR1z?=
 =?us-ascii?Q?vZ3v4l5EdYQyHujFLH7AgWZbIVr4UsuPbXET05vJpA2Hc43BBEpljE1uDrdN?=
 =?us-ascii?Q?fmut7AIU2EHNAhuWneyE7O6hxlE22fHqNzFu35sski6QU4ZT5/dZRFNNyNG3?=
 =?us-ascii?Q?m55Y2fnKnLbyoLGhcnF5xuhLgq7xJcTLQOx3w4eHZLkveihCRu8yw=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1210;6:s6ebraAhF/HaZXlw+Uz2fOM5y+u7P74bBr6SunRdd3RsWLLaSKChAqG9sOuMYfjnnuqM701ASx2B8qCXcJuuBahTdxC5oNsNlHfr9+a1ZnY4ummdIH6n5Zj3MEtDL9oDDqzS1PvhYqP1Cb4EVLiWq409nJOZBeO3sHmgRVdkJQlrDa09D3EZKI1Ee8Jb9KLOZC5VZOKC0swgYpOu3L/RzKLlyE5qxxTzbI2Qx0lk0zTm9P8jPFwvIZfr+Iqovr/mUXqvz6pPpKmIHViMNZEUWKcduZKhwgEK1w8Z++LrtTPSViwPqC2IoW4/apfN56K4F6x0wTfeZ0RPoqJN0O837H3C0qbQ13f0lO+5+kREc68=;5:N59eW5nL0Kuwg6EgxBk8LHA41pj/zsBkySjg8JWNZ2xijSFwx/cJo9S8Y+Da2+6dPIgvSokb67/cuccEvzRF222D35C9noe/lBFhYSi9fI99IQaBoJLxojFDDDVOkVpU2hUu7J8M7WoraxvdS3XsCt2+OnZfNOxJexihr0LduPc=;24:NeUV/J0YXxMvW5DbAzqau73bD/STWVAony8pSw6O2PEQX3UoMzOAQZQk4bgCYRCqG/W36L3K/3Am24bsAZA0+sCM0RfE31j0i2tWI2IaiC4=;7:lIEu/cS6oNnvfSNGmuv3BOAhM2eZOkG0F4yHyXQmgJsQfQ8ILLIoCZYPDC2HJpfvo8itndHfn+jJkapCl+ZBbJYEQJjecV1nx6m5LaYT70XiXB+///3oNdlHU4n+bvKh/15Qlna/o9Vl+kPgbMBkhXLu2t+uRXHqv2sQHHMQK/0eX1k/CSYEpoNkpgF5oDVnkEqda9e3KXUVJWuipx/E0wx7An7rdA3l9/tGFKnhgpmx+tNll3vhacallueVStXJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 00:29:46.6157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fe74b3-56c2-4343-31d7-08d57cb00bc2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a6251c26-d21f-4164-a225-1f4eaebf5f9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1210
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent bus timeouts and resets on Family 16h Model 30h by not probing
reserved Ports 3 and 4.

According to the AMD BIOS and Kernel Developer's Guides (BKDG), Port 3
and Port 4 are reserved on the following devices:
 - Family 15h Model 60h-6Fh
 - Family 15h Model 70h-7Fh
 - Family 16h Model 30h-3Fh

Signed-off-by: Andrew Cooks <andrew.cooks@opengear.com>
---
 drivers/i2c/busses/i2c-piix4.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 5c90a44..01f1610 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -80,7 +80,8 @@
 #define PIIX4_BLOCK_DATA	0x14
 
 /* Multi-port constants */
-#define PIIX4_MAX_ADAPTERS 4
+#define PIIX4_MAX_ADAPTERS	4
+#define HUDSON2_MAIN_PORTS	2 /* HUDSON2, KERNCZ reserves ports 3, 4 */
 
 /* SB800 constants */
 #define SB800_PIIX4_SMB_IDX		0xcd6
@@ -800,6 +801,7 @@ MODULE_DEVICE_TABLE (pci, piix4_ids);
 
 static struct i2c_adapter *piix4_main_adapters[PIIX4_MAX_ADAPTERS];
 static struct i2c_adapter *piix4_aux_adapter;
+static int piix4_adapter_count;
 
 static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 			     bool sb800_main, u8 port, bool notify_imc,
@@ -849,6 +851,7 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 	}
 
 	*padap = adap;
+	piix4_adapter_count++;
 	return 0;
 }
 
@@ -856,10 +859,17 @@ static int piix4_add_adapters_sb800(struct pci_dev *dev, unsigned short smba,
 				    bool notify_imc)
 {
 	struct i2c_piix4_adapdata *adapdata;
-	int port;
+	int port, port_count;
 	int retval;
 
-	for (port = 0; port < PIIX4_MAX_ADAPTERS; port++) {
+	if (dev->device == PCI_DEVICE_ID_AMD_HUDSON2_SMBUS ||
+	    dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) {
+		port_count = HUDSON2_MAIN_PORTS;
+	} else {
+		port_count = PIIX4_MAX_ADAPTERS;
+	}
+
+	for (port = 0; port < port_count; port++) {
 		retval = piix4_add_adapter(dev, smba, true, port, notify_imc,
 					   piix4_main_port_names_sb800[port],
 					   &piix4_main_adapters[port]);
@@ -889,6 +899,7 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	int retval;
 	bool is_sb800 = false;
+	piix4_adapter_count = 0;
 
 	if ((dev->vendor == PCI_VENDOR_ID_ATI &&
 	     dev->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
@@ -993,7 +1004,7 @@ static void piix4_adap_remove(struct i2c_adapter *adap)
 
 static void piix4_remove(struct pci_dev *dev)
 {
-	int port = PIIX4_MAX_ADAPTERS;
+	int port = piix4_adapter_count;
 
 	while (--port >= 0) {
 		if (piix4_main_adapters[port]) {
-- 
2.7.4
