Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D64C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BF22083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="f3k8fWaC";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="QEV2Nd0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BF22083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388421AbeKFXCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:02:54 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:44486 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388116AbeKFXCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:02:54 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA6DXmca020262;
        Tue, 6 Nov 2018 05:37:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=proofpoint;
 bh=GljHdJBhbJQOOKUaSzIM5jdx6nlC7g8Rs9Y9UggQWag=;
 b=f3k8fWaCgy1CPNULBH5hTB7ZiCMKpDbp+uvwwgWnn9mq8CqwKUkbtpuWnCsIfrYjjFL3
 m5ACBpOQ4mzOPiXCRkw4NlPgnhNCDh/jz3Sn35/DBljj6h2P31dZcfn0ttBfVOyYrnZt
 SAVHu0OGWDTmeIdU0EOPDG+VAhVlfGZ2czwBJjib3BQXhSH4CmtpvIEArbZVFemv0i27
 ZWxIVcowo0LHnLN4DzCI6eXG1KyE8pgQg4fXhSjnn9cTxWrPM96jwn3G/QkqhQBGIrPF
 YGlNb5d+trqmaFx4937GD6XS6fPcWbUfnSvB1aZBpdQFuEguwo+jR5YlEgb5L2bwI15I kA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp0052.outbound.protection.outlook.com [216.32.180.52])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2nh9edpem1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 06 Nov 2018 05:37:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GljHdJBhbJQOOKUaSzIM5jdx6nlC7g8Rs9Y9UggQWag=;
 b=QEV2Nd0zboHE8SWkwOTc8b0u/vCMy7BJeScJmINo5UWhUzUgmZ3qh1QvB2iil426blM5ZO6VIaObWKK41Vj83YlqWBbwF6y0nVLM6t++9iQLIEZIDN1V7GhuIisCaJ2S2FITFODn7NEbo1UsL+k3Sq3Ytyzx6lxTvGVPIOuo+wQ=
Received: from BN3PR07MB2690.namprd07.prod.outlook.com (10.167.5.141) by
 BN3PR07MB2482.namprd07.prod.outlook.com (10.167.4.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 6 Nov 2018 13:37:21 +0000
Received: from BN3PR07MB2690.namprd07.prod.outlook.com
 ([fe80::98db:442c:9721:e086]) by BN3PR07MB2690.namprd07.prod.outlook.com
 ([fe80::98db:442c:9721:e086%4]) with mapi id 15.20.1294.034; Tue, 6 Nov 2018
 13:37:21 +0000
From:   Janek Kotas <jank@cadence.com>
To:     "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] scsi: ufs: Add UFS platform driver for Cadence UFS
Thread-Topic: [PATCH v4 2/2] scsi: ufs: Add UFS platform driver for Cadence
 UFS
Thread-Index: AQHUUOMHXEPp/a1DKUixcejdU+ucqaVDCeeA
Date:   Tue, 6 Nov 2018 13:37:21 +0000
Message-ID: <1A428C77-982A-4EB8-8FDD-A33979753660@global.cadence.com>
References: <C77CE2E3-F88A-4B1E-BECB-5D031E2930E3@global.cadence.com>
In-Reply-To: <C77CE2E3-F88A-4B1E-BECB-5D031E2930E3@global.cadence.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR07MB2482;20:8K65QEl0XM82qjNR7OZd5cXKGLjuiIwcKD3Z0vioEOkOctPBylljKxkmRANHSlVb+BceAIgAC9AkcGad4wS2sz2W4I0mLq7VhKB7Lwx/oTo7WBOLsIJp87j11VVETbgCbRjg7CwUNryVurAW4E2cuUWX+Zm7UbEVgQ3ZN0wP41w5+9iHtq8I9HPBNWhbd6e6J1tj2SGD0ePVxDCloEN2cOIQVXVTIBtCdnux+OVw1Jkk7ZHxxK6H4j9lm33qMqMV
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7b2832bc-4676-48e3-9e86-08d643ecfa97
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN3PR07MB2482;
x-ms-traffictypediagnostic: BN3PR07MB2482:
x-microsoft-antispam-prvs: <BN3PR07MB24824198863BFAD52917E598D0CB0@BN3PR07MB2482.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN3PR07MB2482;BCL:0;PCL:0;RULEID:;SRVR:BN3PR07MB2482;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(39860400002)(346002)(376002)(189003)(199004)(36092001)(5660300001)(102836004)(6506007)(53546011)(2201001)(6436002)(6512007)(66066001)(8936002)(86362001)(186003)(446003)(11346002)(486006)(476003)(106356001)(105586002)(82746002)(7736002)(14444005)(83716004)(26005)(53936002)(2900100001)(68736007)(97736004)(316002)(6246003)(25786009)(256004)(2906002)(54906003)(4326008)(305945005)(6116002)(3846002)(14454004)(8676002)(478600001)(33656002)(71200400001)(229853002)(81166006)(76176011)(39060400002)(110136005)(81156014)(2501003)(99286004)(71190400001)(6486002)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR07MB2482;H:BN3PR07MB2690.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 95Mi6mqmXAHqlGKrN0C8zC4ShKujJFjP/Cm2rR2U6an+C6CjlSEe018JoyHljPw44h4+Nt1vgkMIHiXiOIrYuf9kM5RE0xdJ5wWEtfxaIDxbYe/Prfw2+r1EyO9MU7tK0080N9i8tsKV/8pprezlJSgeeQKbl9Tzgan6A+PyttsM6Zbw/jIrm90b1BTnCDCQWivAfeIATKEmFryTuVHVfPZYwZ27TzhUoniVhpqzxmZJ/2jznB0lbzDaue9P7qBlTM9teEmZHCSdxbF2NbKfajfFeuR3ceb7E3TbT3Aqpro4kA94w90QMI70DXquWDu35bbpLpNkiZi6lQaGN8JG16JUZjyCYaO6PnO68ljA6wU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B950FC8FF19471479751E5DBCAC05743@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2832bc-4676-48e3-9e86-08d643ecfa97
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 13:37:21.3195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR07MB2482
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-06_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811060120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A very gentle ping.=20

Could you please take a look at the proposed patch?

Thanks,
Jan

> On 20 Sep 2018, at 15:08, Janek Kotas <jank@cadence.com> wrote:
>=20
> This patch adds a device tree platform driver for
> Cadence UFS Host Controller.
> It can be enabled with SCSI_UFS_CDNS_PLATFORM Kconfig option.
>=20
> Signed-off-by: Jan Kotas <jank@cadence.com>
> ---
> drivers/scsi/ufs/Kconfig       |   8 +++
> drivers/scsi/ufs/Makefile      |   1 +
> drivers/scsi/ufs/cdns-pltfrm.c | 149 ++++++++++++++++++++++++++++++++++++=
+++++
> 3 files changed, 158 insertions(+)
> create mode 100644 drivers/scsi/ufs/cdns-pltfrm.c
>=20
> diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
> index e09fe6a..8f884c3 100644
> --- a/drivers/scsi/ufs/Kconfig
> +++ b/drivers/scsi/ufs/Kconfig
> @@ -80,6 +80,14 @@ config SCSI_UFSHCD_PLATFORM
>=20
> 	  If unsure, say N.
>=20
> +config SCSI_UFS_CDNS_PLATFORM
> +	tristate "Cadence UFS Controller platform driver"
> +	depends on SCSI_UFSHCD_PLATFORM
> +	help
> +	This selects the Cadence specific additions to UFSHCD platform driver.
> +
> +	  If unsure, say N.
> +
> config SCSI_UFS_DWC_TC_PLATFORM
> 	tristate "DesignWare platform support using a G210 Test Chip"
> 	depends on SCSI_UFSHCD_PLATFORM
> diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
> index 2c50f03..e17d14a 100644
> --- a/drivers/scsi/ufs/Makefile
> +++ b/drivers/scsi/ufs/Makefile
> @@ -2,6 +2,7 @@
> # UFSHCD makefile
> obj-$(CONFIG_SCSI_UFS_DWC_TC_PCI) +=3D tc-dwc-g210-pci.o ufshcd-dwc.o tc-=
dwc-g210.o
> obj-$(CONFIG_SCSI_UFS_DWC_TC_PLATFORM) +=3D tc-dwc-g210-pltfrm.o ufshcd-d=
wc.o tc-dwc-g210.o
> +obj-$(CONFIG_SCSI_UFS_CDNS_PLATFORM) +=3D cdns-pltfrm.o
> obj-$(CONFIG_SCSI_UFS_QCOM) +=3D ufs-qcom.o
> obj-$(CONFIG_SCSI_UFSHCD) +=3D ufshcd-core.o
> ufshcd-core-objs :=3D ufshcd.o ufs-sysfs.o
> diff --git a/drivers/scsi/ufs/cdns-pltfrm.c b/drivers/scsi/ufs/cdns-pltfr=
m.c
> new file mode 100644
> index 0000000..8bcf863
> --- /dev/null
> +++ b/drivers/scsi/ufs/cdns-pltfrm.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Platform UFS Host driver for Cadence controller
> + *
> + * Copyright (C) 2018 Cadence Design Systems, Inc.
> + *
> + * Authors:
> + *	Jan Kotas <jank@cadence.com>
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/time.h>
> +
> +#include "ufshcd-pltfrm.h"
> +
> +#define CDNS_UFS_REG_HCLKDIV 0xFC
> +
> +/**
> + * Sets HCLKDIV register value based on the core_clk
> + * @hba: host controller instance
> + *
> + * Return zero for success and non-zero for failure
> + */
> +static int cdns_ufs_set_hclkdiv(struct ufs_hba *hba)
> +{
> +	struct ufs_clk_info *clki;
> +	struct list_head *head =3D &hba->clk_list_head;
> +	unsigned long core_clk_rate =3D 0;
> +	u32 core_clk_div =3D 0;
> +
> +	if (list_empty(head))
> +		return 0;
> +
> +	list_for_each_entry(clki, head, list) {
> +		if (IS_ERR_OR_NULL(clki->clk))
> +			continue;
> +		if (!strcmp(clki->name, "core_clk"))
> +			core_clk_rate =3D clk_get_rate(clki->clk);
> +	}
> +
> +	if (!core_clk_rate) {
> +		dev_err(hba->dev, "%s: unable to find core_clk rate\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	core_clk_div =3D core_clk_rate / USEC_PER_SEC;
> +
> +	ufshcd_writel(hba, core_clk_div, CDNS_UFS_REG_HCLKDIV);
> +	/**
> +	 * Make sure the register was updated,
> +	 * UniPro layer will not work with an incorrect value.
> +	 */
> +	mb();
> +
> +	return 0;
> +}
> +
> +/**
> + * Sets clocks used by the controller
> + * @hba: host controller instance
> + * @on: if true, enable clocks, otherwise disable
> + * @status: notify stage (pre, post change)
> + *
> + * Return zero for success and non-zero for failure
> + */
> +static int cdns_ufs_setup_clocks(struct ufs_hba *hba, bool on,
> +				 enum ufs_notify_change_status status)
> +{
> +	if ((!on) || (status =3D=3D PRE_CHANGE))
> +		return 0;
> +
> +	return cdns_ufs_set_hclkdiv(hba);
> +}
> +
> +static struct ufs_hba_variant_ops cdns_pltfm_hba_vops =3D {
> +	.name =3D "cdns-ufs-pltfm",
> +	.setup_clocks =3D cdns_ufs_setup_clocks,
> +};
> +
> +/**
> + * cdns_ufs_pltfrm_probe - probe routine of the driver
> + * @pdev: pointer to platform device handle
> + *
> + * Return zero for success and non-zero for failure
> + */
> +static int cdns_ufs_pltfrm_probe(struct platform_device *pdev)
> +{
> +	int err;
> +	struct device *dev =3D &pdev->dev;
> +
> +	/* Perform generic probe */
> +	err =3D ufshcd_pltfrm_init(pdev, &cdns_pltfm_hba_vops);
> +	if (err)
> +		dev_err(dev, "ufshcd_pltfrm_init() failed %d\n", err);
> +
> +	return err;
> +}
> +
> +/**
> + * cdns_ufs_pltfrm_remove - removes the ufs driver
> + * @pdev: pointer to platform device handle
> + *
> + * Always returns 0
> + */
> +static int cdns_ufs_pltfrm_remove(struct platform_device *pdev)
> +{
> +	struct ufs_hba *hba =3D  platform_get_drvdata(pdev);
> +
> +	ufshcd_remove(hba);
> +	return 0;
> +}
> +
> +static const struct of_device_id cdns_ufs_of_match[] =3D {
> +	{ .compatible =3D "cdns,ufshc" },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, cdns_ufs_of_match);
> +
> +static const struct dev_pm_ops cdns_ufs_dev_pm_ops =3D {
> +	.suspend         =3D ufshcd_pltfrm_suspend,
> +	.resume          =3D ufshcd_pltfrm_resume,
> +	.runtime_suspend =3D ufshcd_pltfrm_runtime_suspend,
> +	.runtime_resume  =3D ufshcd_pltfrm_runtime_resume,
> +	.runtime_idle    =3D ufshcd_pltfrm_runtime_idle,
> +};
> +
> +static struct platform_driver cdns_ufs_pltfrm_driver =3D {
> +	.probe	=3D cdns_ufs_pltfrm_probe,
> +	.remove	=3D cdns_ufs_pltfrm_remove,
> +	.driver	=3D {
> +		.name   =3D "cdns-ufshcd",
> +		.owner  =3D THIS_MODULE,
> +		.pm     =3D &cdns_ufs_dev_pm_ops,
> +		.of_match_table =3D cdns_ufs_of_match,
> +	},
> +};
> +
> +module_platform_driver(cdns_ufs_pltfrm_driver);
> +
> +MODULE_AUTHOR("Jan Kotas <jank@cadence.com>");
> +MODULE_DESCRIPTION("Cadence UFS host controller platform driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_VERSION(UFSHCD_DRIVER_VERSION);
> --=20
> 1.9.0
>=20
>=20

