Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCDDC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DF921531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="il6c5dpS";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Tf/WQslQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3DF921531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733174AbeITUk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:40:57 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:49330 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731025AbeITUk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:40:57 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8KD4O13023660;
        Thu, 20 Sep 2018 06:08:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=6IYRzkR/kWSmdy7T4hMaOlhfzb2ad27zs8ZdcsetEJ0=;
 b=il6c5dpS1caOd/wMIKm3S7b0QHT0QYOpEX8xceO2Xe1nA/m10T+I/+udoCLF5RKn9HP+
 9btR0952UQ8yGFO3WmJvSG1pzuvrewaWbScXB1rKI2wBjBsoF7zPymLBIQpEOnoNM5uO
 3JPL2bKMzcFwgoihrWBQgesUBtRZOOqvsqp+8/yU+DpvKrzzaVeJb0aeDbIfPBCz+g+K
 MysMk+T2ZhpGAqp2yB2XspQheKftO8+B1ZXdrzXFSWvTLYWFn/L72Nx/2owbWiFqUmXK
 kY5TaByMLUL7TSNUTSTdbDZPNBK/I5f9NyBcd1ymZAUi2gFtTJW23M+Ij7DaB44NHtGh pw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp0112.outbound.protection.outlook.com [216.32.180.112])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2mgwnvjk81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Sep 2018 06:08:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IYRzkR/kWSmdy7T4hMaOlhfzb2ad27zs8ZdcsetEJ0=;
 b=Tf/WQslQOaJEkmxCLg78njuDSkyW5DwIiRT64dhObi3nYyqRzrxigeKDXff5NO++Ah1a+5ytWL9Hd7fnNXMSyZzWqPyUVnoIXGTdozLUaNUv6aBRmGgjxJdeMN8xNlY32VBPuWXEyl3mTlfbtS90EJMpLjbQ8mEpmyVle7KfQeI=
Received: from CO2PR07MB2695.namprd07.prod.outlook.com (10.166.214.8) by
 CO2PR07MB618.namprd07.prod.outlook.com (10.141.228.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Thu, 20 Sep 2018 13:08:30 +0000
Received: from CO2PR07MB2695.namprd07.prod.outlook.com
 ([fe80::4c7c:3f0f:3bba:ab95]) by CO2PR07MB2695.namprd07.prod.outlook.com
 ([fe80::4c7c:3f0f:3bba:ab95%4]) with mapi id 15.20.1143.017; Thu, 20 Sep 2018
 13:08:30 +0000
From:   Janek Kotas <jank@cadence.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: [PATCH v4 2/2] scsi: ufs: Add UFS platform driver for Cadence UFS
Thread-Topic: [PATCH v4 2/2] scsi: ufs: Add UFS platform driver for Cadence
 UFS
Thread-Index: AQHUUOMGVtosypj9Lkqvm/iGUiZvsw==
Date:   Thu, 20 Sep 2018 13:08:30 +0000
Message-ID: <C77CE2E3-F88A-4B1E-BECB-5D031E2930E3@global.cadence.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR07MB618;20:iLNs3kMHeiA9df7wI46vcJAY26kKuNbvqJsal0VD48JcON9jnHClI2cZPss+4+eifbKhluxjVxoSlEHgosCfZ+hIdSHzI0yLIUfBgeKuVzpNLA8fL1nwwQjo2xUsp77L8J2OMsOuWKGzbZGkX+MCd7URQapI3+wOp9nXsQXLJL4yiOV3MNsvrWhUV6c0Q7lmiUWBjNJcTNnNr0E5FR6K3BUK4/a850poWWh6ltM4BlT/sjRaXpiwEzdUMU7IZIWK
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 94ac5d1d-4d46-4438-1956-08d61efa29a5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB618;
x-ms-traffictypediagnostic: CO2PR07MB618:
x-microsoft-antispam-prvs: <CO2PR07MB618B8D30FE93E891A9DE774D0130@CO2PR07MB618.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:CO2PR07MB618;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB618;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(366004)(136003)(189003)(199004)(36092001)(2501003)(4326008)(6486002)(5660300001)(7736002)(476003)(26005)(33656002)(8936002)(8676002)(316002)(105586002)(54906003)(71200400001)(71190400001)(5250100002)(305945005)(102836004)(486006)(256004)(97736004)(6436002)(82746002)(2906002)(478600001)(6512007)(6506007)(106356001)(68736007)(99286004)(86362001)(3846002)(6116002)(83716003)(110136005)(2201001)(14444005)(81166006)(53936002)(66066001)(25786009)(14454004)(81156014)(2900100001)(186003)(39060400002)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB618;H:CO2PR07MB2695.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pIuyVW0QjmP2c45jjuuNTaKuhE7N2SRDjnqyurLFiG7tl8mDEOzymNSjjU6IEbOdfKarSoPbSk16fNMIMakvqsHxW7VeSoCYPmdpNjRfeGlORNBUY+FL/QRgCi7nJ+UWbb0vWK6Vs0tXd4MfW9UBJtEKzCXsP6MHl9XhVe0OAOb3wMsHQOx+gISOaAuyJV44xRhfpFViJVw/EWxm+IrWi1EWIFjj8uftzw2RZJH7JrQ4MWqtP5OdHYr2QgrW7zIdcX0yVbFbhYzI6smbgqKOCoIDfJAZinuKLGezTh81091tEhDIXqXFhmquuQu/tuC/8AXXCB/KhONQfG+vh68LoIDsIOASPa5W6ATlmiVitOg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5EAC3CABE857BB4D9BB2A1286629A158@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ac5d1d-4d46-4438-1956-08d61efa29a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 13:08:30.6134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB618
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-20_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809200133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a device tree platform driver for
Cadence UFS Host Controller.
It can be enabled with SCSI_UFS_CDNS_PLATFORM Kconfig option.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 drivers/scsi/ufs/Kconfig       |   8 +++
 drivers/scsi/ufs/Makefile      |   1 +
 drivers/scsi/ufs/cdns-pltfrm.c | 149 +++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 158 insertions(+)
 create mode 100644 drivers/scsi/ufs/cdns-pltfrm.c

diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
index e09fe6a..8f884c3 100644
--- a/drivers/scsi/ufs/Kconfig
+++ b/drivers/scsi/ufs/Kconfig
@@ -80,6 +80,14 @@ config SCSI_UFSHCD_PLATFORM
=20
 	  If unsure, say N.
=20
+config SCSI_UFS_CDNS_PLATFORM
+	tristate "Cadence UFS Controller platform driver"
+	depends on SCSI_UFSHCD_PLATFORM
+	help
+	This selects the Cadence specific additions to UFSHCD platform driver.
+
+	  If unsure, say N.
+
 config SCSI_UFS_DWC_TC_PLATFORM
 	tristate "DesignWare platform support using a G210 Test Chip"
 	depends on SCSI_UFSHCD_PLATFORM
diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
index 2c50f03..e17d14a 100644
--- a/drivers/scsi/ufs/Makefile
+++ b/drivers/scsi/ufs/Makefile
@@ -2,6 +2,7 @@
 # UFSHCD makefile
 obj-$(CONFIG_SCSI_UFS_DWC_TC_PCI) +=3D tc-dwc-g210-pci.o ufshcd-dwc.o tc-d=
wc-g210.o
 obj-$(CONFIG_SCSI_UFS_DWC_TC_PLATFORM) +=3D tc-dwc-g210-pltfrm.o ufshcd-dw=
c.o tc-dwc-g210.o
+obj-$(CONFIG_SCSI_UFS_CDNS_PLATFORM) +=3D cdns-pltfrm.o
 obj-$(CONFIG_SCSI_UFS_QCOM) +=3D ufs-qcom.o
 obj-$(CONFIG_SCSI_UFSHCD) +=3D ufshcd-core.o
 ufshcd-core-objs :=3D ufshcd.o ufs-sysfs.o
diff --git a/drivers/scsi/ufs/cdns-pltfrm.c b/drivers/scsi/ufs/cdns-pltfrm.=
c
new file mode 100644
index 0000000..8bcf863
--- /dev/null
+++ b/drivers/scsi/ufs/cdns-pltfrm.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Platform UFS Host driver for Cadence controller
+ *
+ * Copyright (C) 2018 Cadence Design Systems, Inc.
+ *
+ * Authors:
+ *	Jan Kotas <jank@cadence.com>
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/time.h>
+
+#include "ufshcd-pltfrm.h"
+
+#define CDNS_UFS_REG_HCLKDIV 0xFC
+
+/**
+ * Sets HCLKDIV register value based on the core_clk
+ * @hba: host controller instance
+ *
+ * Return zero for success and non-zero for failure
+ */
+static int cdns_ufs_set_hclkdiv(struct ufs_hba *hba)
+{
+	struct ufs_clk_info *clki;
+	struct list_head *head =3D &hba->clk_list_head;
+	unsigned long core_clk_rate =3D 0;
+	u32 core_clk_div =3D 0;
+
+	if (list_empty(head))
+		return 0;
+
+	list_for_each_entry(clki, head, list) {
+		if (IS_ERR_OR_NULL(clki->clk))
+			continue;
+		if (!strcmp(clki->name, "core_clk"))
+			core_clk_rate =3D clk_get_rate(clki->clk);
+	}
+
+	if (!core_clk_rate) {
+		dev_err(hba->dev, "%s: unable to find core_clk rate\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	core_clk_div =3D core_clk_rate / USEC_PER_SEC;
+
+	ufshcd_writel(hba, core_clk_div, CDNS_UFS_REG_HCLKDIV);
+	/**
+	 * Make sure the register was updated,
+	 * UniPro layer will not work with an incorrect value.
+	 */
+	mb();
+
+	return 0;
+}
+
+/**
+ * Sets clocks used by the controller
+ * @hba: host controller instance
+ * @on: if true, enable clocks, otherwise disable
+ * @status: notify stage (pre, post change)
+ *
+ * Return zero for success and non-zero for failure
+ */
+static int cdns_ufs_setup_clocks(struct ufs_hba *hba, bool on,
+				 enum ufs_notify_change_status status)
+{
+	if ((!on) || (status =3D=3D PRE_CHANGE))
+		return 0;
+
+	return cdns_ufs_set_hclkdiv(hba);
+}
+
+static struct ufs_hba_variant_ops cdns_pltfm_hba_vops =3D {
+	.name =3D "cdns-ufs-pltfm",
+	.setup_clocks =3D cdns_ufs_setup_clocks,
+};
+
+/**
+ * cdns_ufs_pltfrm_probe - probe routine of the driver
+ * @pdev: pointer to platform device handle
+ *
+ * Return zero for success and non-zero for failure
+ */
+static int cdns_ufs_pltfrm_probe(struct platform_device *pdev)
+{
+	int err;
+	struct device *dev =3D &pdev->dev;
+
+	/* Perform generic probe */
+	err =3D ufshcd_pltfrm_init(pdev, &cdns_pltfm_hba_vops);
+	if (err)
+		dev_err(dev, "ufshcd_pltfrm_init() failed %d\n", err);
+
+	return err;
+}
+
+/**
+ * cdns_ufs_pltfrm_remove - removes the ufs driver
+ * @pdev: pointer to platform device handle
+ *
+ * Always returns 0
+ */
+static int cdns_ufs_pltfrm_remove(struct platform_device *pdev)
+{
+	struct ufs_hba *hba =3D  platform_get_drvdata(pdev);
+
+	ufshcd_remove(hba);
+	return 0;
+}
+
+static const struct of_device_id cdns_ufs_of_match[] =3D {
+	{ .compatible =3D "cdns,ufshc" },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, cdns_ufs_of_match);
+
+static const struct dev_pm_ops cdns_ufs_dev_pm_ops =3D {
+	.suspend         =3D ufshcd_pltfrm_suspend,
+	.resume          =3D ufshcd_pltfrm_resume,
+	.runtime_suspend =3D ufshcd_pltfrm_runtime_suspend,
+	.runtime_resume  =3D ufshcd_pltfrm_runtime_resume,
+	.runtime_idle    =3D ufshcd_pltfrm_runtime_idle,
+};
+
+static struct platform_driver cdns_ufs_pltfrm_driver =3D {
+	.probe	=3D cdns_ufs_pltfrm_probe,
+	.remove	=3D cdns_ufs_pltfrm_remove,
+	.driver	=3D {
+		.name   =3D "cdns-ufshcd",
+		.owner  =3D THIS_MODULE,
+		.pm     =3D &cdns_ufs_dev_pm_ops,
+		.of_match_table =3D cdns_ufs_of_match,
+	},
+};
+
+module_platform_driver(cdns_ufs_pltfrm_driver);
+
+MODULE_AUTHOR("Jan Kotas <jank@cadence.com>");
+MODULE_DESCRIPTION("Cadence UFS host controller platform driver");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION(UFSHCD_DRIVER_VERSION);
--=20
1.9.0


