Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88EAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839812086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="i6BbzRhj";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="hXIki/vN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839812086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbeKGSL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 13:11:59 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:39656 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726218AbeKGSL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 13:11:58 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA78fx8v027167;
        Wed, 7 Nov 2018 00:42:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=zhAM9zqIaR6o2MPP+TQ7KaCZ4BuZvL+Zym+Iu5NSvaA=;
 b=i6BbzRhjzpxsTNvt2+HFPGcK3R50CFfvAfUW1gq55xdFLV2AviI8MPGvq3evbpeOzxkS
 TaBCZhwp11hkbxLG6Hhuo/muwI9rQoBkMsONVQyAXp0Wf3u/vgKb1vPoMLRLG1o84gML
 dYSCGSRcMR8RXbhgDv+1tWXLhOB4QOqFnPGWXHObCjUGTI/dLVFBIO/+DvsAWCI+hNf7
 1vbu3tgj9vj6rGZ2TvBPd4AtY1//KWelamPTtEPLaRCzd28uzp95doMzBesPK0bU4tBF
 ndfnUPpT/XCZRJRhsrl88tzCvEJZK2oFvosV78OdLeKTlL42nx8ssQt+dp4H+3wbF1a2 AQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp0178.outbound.protection.outlook.com [216.32.180.178])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2nkvbng3b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 07 Nov 2018 00:42:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhAM9zqIaR6o2MPP+TQ7KaCZ4BuZvL+Zym+Iu5NSvaA=;
 b=hXIki/vNIpfDXcerFUUWfKDEfR58pShMtrADD+HINj+gwQ2E3zx4RhTdm42+w9sXvAMpvr2gTnq3PAVLpDDfQsVK3+He+3/s4kWTJ5eVHsKYnjMc6MZ0HdczTkehDGgwemUL4YHfx7y5CdAbOzz+9Po7nf2W7/k1j6vO9C1P5j8=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5544.namprd07.prod.outlook.com (20.177.231.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 7 Nov 2018 08:42:28 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8000:536f:b287:710f]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8000:536f:b287:710f%4]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 08:42:26 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [RFC PATCH v1 01/14] usb:cdns3: add pci to platform driver
 wrapper.
Thread-Topic: [RFC PATCH v1 01/14] usb:cdns3: add pci to platform driver
 wrapper.
Thread-Index: AQHUc530R+IcH8cP4ECKabWr/3y5sqVCx5mAgAETCIA=
Date:   Wed, 7 Nov 2018 08:42:25 +0000
Message-ID: <BYAPR07MB4709E63A6B10AC2A894835E7DDC40@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1541267487-3664-1-git-send-email-pawell@cadence.com>
 <1541267487-3664-2-git-send-email-pawell@cadence.com>
 <5BE19BB5.3030006@ti.com>
In-Reply-To: <5BE19BB5.3030006@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMGRlZmZiZDAtZTI2OS0xMWU4LTg3MjUtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDBkZWZmYmQxLWUyNjktMTFlOC04NzI1LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iOTI5OCIgdD0iMTMxODYwNTM3NDgwMDAyODIzIiBoPSJNaVRUd2xwbGRJN3pydFdWUlBpUTdjWFdrQnc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5544;20:G5q4l8KKgRz4f4eHMqe00dlLzllL3glzbDKsl7hrLsOeWtS6xe11Ew9mmO/abHAf+xCQZR3+pJUBc1E0RMgGy3Qh7dutoSE20y7FV6cT0YWr82v192KKDRnql0ZrLZkmeugWdZDxiodTQb21gBug/UDayzNatXNppuReH5j9sEBYHuFxi3BA6N8dvto2tKil/AzWHFZgXvvjfcYA3x8Uvfl2i+SI6ZRPwhTX1HQWDCVrm5R4OEQUrZDIvmGvcAL3
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(39860400002)(396003)(346002)(199004)(189003)(36092001)(2906002)(217873002)(6246003)(256004)(486006)(446003)(11346002)(14454004)(305945005)(25786009)(2900100001)(26005)(186003)(53936002)(476003)(9686003)(74316002)(106356001)(107886003)(229853002)(97736004)(7736002)(99286004)(68736007)(8936002)(7696005)(6506007)(33656002)(81166006)(478600001)(6436002)(54906003)(8676002)(66066001)(102836004)(105586002)(5660300001)(55016002)(76176011)(81156014)(110136005)(316002)(86362001)(4326008)(71190400001)(71200400001)(2501003)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5544;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: ecc9f313-98b3-42f4-6251-08d6448cf1c1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5544;
x-ms-traffictypediagnostic: BYAPR07MB5544:
x-microsoft-antispam-prvs: <BYAPR07MB5544924A51055DA9D76D0F81DDC40@BYAPR07MB5544.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089)(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231382)(944501410)(52105095)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB5544;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5544;
x-forefront-prvs: 08497C3D99
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7CuLq3TUOhP6nf9YhMZbZ1X93hVhinDaYOk8YGVO+IY5RfpWIxbHNNRy+MCvWpICfr5Yfnf+gb5yldDYkB0tIhTV4dqR9Iq9bXwe5ew6sRvT84BRaKkRPNAf2AW7DqChngPNBwFv05uymVcRfhktNApPl1YQIyNOX2L+5tGeq4/Q6XooP3YGsj1kQuDiI4jvUwPnoCvQ4YWlJWcd3/GoTVKrf06NKc/4AtRdQ0w2UxpWCk4WyDWyuCFzpNn6C61hljGcf4zkmNHL0ju8jlWDdB6CVii0i+9s+xiZe9sMoXm2ryC7oUNe0/J7S/J13XHxFaDarTsKuKsScOex9bwRw8G3quHRDAaCQlxBOda9qBA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc9f313-98b3-42f4-6251-08d6448cf1c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 08:42:25.9415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5544
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811070081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,
>
>Hi Pawel,
>
>On 03/11/18 19:51, Pawel Laszczak wrote:
>> Patch adds PCI specific glue drivier that creaties and registers in
>
>s/drivier/driver
>s/creaties/creates
>s/in system/in-system
>
>> system cdns-usb3 platform device. Thanks to that we will be able to use
>> the cdns-usb3 platform driver for USBSS-DEV controller
>> build on PCI board
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/Kconfig                |   2 +
>>  drivers/usb/Makefile               |   2 +
>>  drivers/usb/cdns3/Kconfig          |  24 +++++
>>  drivers/usb/cdns3/Makefile         |   3 +
>>  drivers/usb/cdns3/cdns3-pci-wrap.c | 162 +++++++++++++++++++++++++++++
>>  5 files changed, 193 insertions(+)
>>  create mode 100644 drivers/usb/cdns3/Kconfig
>>  create mode 100644 drivers/usb/cdns3/Makefile
>>  create mode 100644 drivers/usb/cdns3/cdns3-pci-wrap.c
>>
>> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
>> index 987fc5ba6321..5f9334019d04 100644
>> --- a/drivers/usb/Kconfig
>> +++ b/drivers/usb/Kconfig
>> @@ -112,6 +112,8 @@ source "drivers/usb/usbip/Kconfig"
>>
>>  endif
>>
>> +source "drivers/usb/cdns3/Kconfig"
>> +
>>  source "drivers/usb/mtu3/Kconfig"
>>
>>  source "drivers/usb/musb/Kconfig"
>> diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
>> index 7d1b8c82b208..82093a60ea2c 100644
>> --- a/drivers/usb/Makefile
>> +++ b/drivers/usb/Makefile
>> @@ -8,6 +8,8 @@
>>  obj-$(CONFIG_USB)		+=3D core/
>>  obj-$(CONFIG_USB_SUPPORT)	+=3D phy/
>>
>> +obj-$(CONFIG_USB_CDNS3)		+=3D cdns3/
>> +
>>  obj-$(CONFIG_USB_DWC3)		+=3D dwc3/
>>  obj-$(CONFIG_USB_DWC2)		+=3D dwc2/
>>  obj-$(CONFIG_USB_ISP1760)	+=3D isp1760/
>> diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
>> new file mode 100644
>> index 000000000000..888458372adb
>> --- /dev/null
>> +++ b/drivers/usb/cdns3/Kconfig
>> @@ -0,0 +1,24 @@
>> +config USB_CDNS3
>> +	tristate "Cadence USB3 Dual-Role Controller"
>> +	depends on ((USB_XHCI_HCD && USB_GADGET) || (USB_XHCI_HCD && !USB_GADG=
ET) || (!USB_XHCI_HCD && USB_GADGET)) &&
>HAS_DMA
>
>Why not depend on USB instead of USB_XHCI_HCD?
=09
I will replace it with this:
Depend on USB_SUPPORT && (USB l| USB_GADGET) && HAS_DMA

>> +	help
>> +	  Say Y here if your system has a cadence USB3 dual-role controller.
>> +	  It supports: dual-role switch Host-only, and Peripheral-only.
>
>Need a coma between switch and Host-only.
>
>> +
>> +	  If you choose to build this driver is a dynamically linked
>> +	  module, the module will be called cdns3.ko.
>> +
>> +if USB_CDNS3
>> +
>> +config USB_CDNS3_PCI_WRAP
>> +	tristate "PCIe-based Platforms"
>> +	depends on USB_PCI && ACPI
>> +	default USB_CDNS3
>> +	help
>> +	  If you're using the USBSS Core IP with a PCIe, please say
>> +	  'Y' or 'M' here.
>> +
>> +	  If you choose to build this driver as module it will
>> +	  be dynamically linked and module will be called cdns3-pci.ko
>> +
>> +endif
>> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
>> new file mode 100644
>> index 000000000000..dcdd62003c6a
>> --- /dev/null
>> +++ b/drivers/usb/cdns3/Makefile
>> @@ -0,0 +1,3 @@
>> +obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+=3D cdns3-pci.o
>> +
>> +cdns3-pci-y		 		:=3D cdns3-pci-wrap.o
>> diff --git a/drivers/usb/cdns3/cdns3-pci-wrap.c b/drivers/usb/cdns3/cdns=
3-pci-wrap.c
>> new file mode 100644
>> index 000000000000..6c229ab6dffb
>> --- /dev/null
>> +++ b/drivers/usb/cdns3/cdns3-pci-wrap.c
>> @@ -0,0 +1,162 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Cadence USBSS PCI Glue driver
>> + *
>> + * Copyright (C) 2018 Cadence.
>> + *
>> + * Author: Pawel Laszczak <pawell@cadence.com>
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/slab.h>
>> +
>> +struct cdns3_wrap {
>> +	struct platform_device *plat_dev;
>> +	struct pci_dev *hg_dev;
>> +	struct resource dev_res[4];
>> +};
>> +
>> +struct cdns3_wrap wrap;
>> +
>> +#define RES_IRQ_ID		0
>> +#define RES_HOST_ID		1
>> +#define RES_DEV_ID		2
>> +#define RES_DRD_ID		3
>> +
>> +#define PCI_BAR_HOST		0
>> +#define PCI_BAR_DEV		2
>> +#define PCI_BAR_OTG		4
>> +
>> +#define PCI_DEV_FN_HOST_DEVICE	0
>> +#define PCI_DEV_FN_OTG		1
>> +
>> +#define PCI_DRIVER_NAME		"cdns3-pci-usbss"
>> +#define PLAT_DRIVER_NAME	"cdns-usb3"
>> +
>> +#define CDNS_VENDOR_ID 0x17cd
>> +#define CDNS_DEVICE_ID 0x0100
>> +
>> +/**
>> + * cdns3_pci_probe - Probe function for Cadence USB wrapper driver
>> + * @pdev: platform device object
>> + * @id: pci device id
>> + *
>> + * Returns 0 on success otherwise negative errno
>> + */
>> +static int cdns3_pci_probe(struct pci_dev *pdev,
>> +			   const struct pci_device_id *id)
>> +{
>> +	struct platform_device_info plat_info;
>> +	struct cdns3_wrap *wrap;
>> +	struct resource *res;
>> +	int err;
>> +
>> +	/*
>> +	 * for GADGET/HOST PCI (devfn) function number is 0,
>> +	 * for OTG PCI (devfn) function number is 1
>> +	 */
>> +	if (!id || pdev->devfn !=3D PCI_DEV_FN_HOST_DEVICE)
>> +		return -EINVAL;
>> +
>> +	err =3D pcim_enable_device(pdev);
>> +	if (err) {
>> +		dev_err(&pdev->dev, "Enabling PCI device has failed %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	pci_set_master(pdev);
>> +	wrap =3D devm_kzalloc(&pdev->dev, sizeof(*wrap), GFP_KERNEL);
>> +	if (!wrap) {
>> +		dev_err(&pdev->dev, "Failed to load PCI module\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	/* function 0: host(BAR_0) + device(BAR_1) + otg(BAR_2)). */
>> +	memset(wrap->dev_res, 0x00,
>> +	       sizeof(struct resource) * ARRAY_SIZE(wrap->dev_res));
>> +	dev_info(&pdev->dev, "Initialize Device resources\n");
>> +	res =3D wrap->dev_res;
>> +
>> +#if IS_ENABLED(CONFIG_USB_CDNS3_GADGET)
>
>Why depend on Config options to populate resources? The resources should b=
e there regardless.
>It is a lot simpler that way as it reflects the hardware as-is.

You're right. I will remove these Config options from this code.
>
>> +	res[RES_DEV_ID].start =3D pci_resource_start(pdev, PCI_BAR_DEV);
>> +	res[RES_DEV_ID].end =3D   pci_resource_end(pdev, PCI_BAR_DEV);
>> +	res[RES_DEV_ID].name =3D "cdns3-dev-regs";
>> +	res[RES_DEV_ID].flags =3D IORESOURCE_MEM;
>> +	dev_info(&pdev->dev, "USBSS-DEV physical base addr: %pa\n",
>> +		 &res[RES_DEV_ID].start);
>> +
>
>dev_dbg() for this and all occurrences below?
Ok , I replaced it. =20
>
>> +#endif
>> +
>> +#if IS_ENABLED(CONFIG_USB_CDNS3_HOST)
>> +	res[RES_HOST_ID].start =3D pci_resource_start(pdev, PCI_BAR_HOST);
>> +	res[RES_HOST_ID].end =3D pci_resource_end(pdev, PCI_BAR_HOST);
>> +	res[RES_HOST_ID].name =3D "cdns3-xhci-regs";
>> +	res[RES_HOST_ID].flags =3D IORESOURCE_MEM;
>> +	dev_info(&pdev->dev, "USBSS-XHCI physical base addr: %pa\n",
>> +		 &res[RES_HOST_ID].start);
>> +#endif
>> +
>> +	res[RES_DRD_ID].start =3D pci_resource_start(pdev, PCI_BAR_OTG);
>> +	res[RES_DRD_ID].end =3D   pci_resource_end(pdev, PCI_BAR_OTG);
>> +	res[RES_DRD_ID].name =3D "cdns3-otg";
>> +	res[RES_DRD_ID].flags =3D IORESOURCE_MEM;
>> +	dev_info(&pdev->dev, "USBSS-DRD physical base addr: %pa\n",
>> +		 &res[RES_DRD_ID].start);
>> +
>> +	/* Interrupt common for both device and XHCI */
>> +	wrap->dev_res[RES_IRQ_ID].start =3D pdev->irq;
>> +	wrap->dev_res[RES_IRQ_ID].name =3D "cdns3-irq";
>> +	wrap->dev_res[RES_IRQ_ID].flags =3D IORESOURCE_IRQ;
>> +
>> +	/* set up platform device info */
>> +	memset(&plat_info, 0, sizeof(plat_info));
>> +	plat_info.parent =3D &pdev->dev;
>> +	plat_info.fwnode =3D pdev->dev.fwnode;
>> +	plat_info.name =3D PLAT_DRIVER_NAME;
>> +	plat_info.id =3D pdev->devfn;
>> +	plat_info.res =3D wrap->dev_res;
>> +	plat_info.num_res =3D ARRAY_SIZE(wrap->dev_res);
>> +	plat_info.dma_mask =3D pdev->dma_mask;
>> +
>> +	/* register platform device */
>> +	wrap->plat_dev =3D platform_device_register_full(&plat_info);
>> +	if (IS_ERR(wrap->plat_dev)) {
>> +		err =3D PTR_ERR(wrap->plat_dev);
>> +		return err;
>> +	}
>> +
>> +	pci_set_drvdata(pdev, wrap);
>> +
>> +	return err;
>> +}
>> +
>> +void cdns3_pci_remove(struct pci_dev *pdev)
>> +{
>> +	struct cdns3_wrap *wrap =3D (struct cdns3_wrap *)pci_get_drvdata(pdev)=
;
>> +
>> +	platform_device_unregister(wrap->plat_dev);
>> +}
>> +
>> +static const struct pci_device_id cdns3_pci_ids[] =3D {
>> +	{ PCI_DEVICE(CDNS_VENDOR_ID, CDNS_DEVICE_ID), },
>> +	{ 0, }
>> +};
>> +
>> +static struct pci_driver cdns3_pci_driver =3D {
>> +	.name =3D PCI_DRIVER_NAME,
>> +	.id_table =3D cdns3_pci_ids,
>> +	.probe =3D cdns3_pci_probe,
>> +	.remove =3D cdns3_pci_remove,
>> +};
>> +
>> +module_pci_driver(cdns3_pci_driver);
>> +MODULE_DEVICE_TABLE(pci, cdns3_pci_ids);
>> +
>> +MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("Cadence USBSS PCI wrapperr");
>> +
>>
>
>cheers,
>-roger
>--
>Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

Thanks for all comments

Regards,
Pawel Laszczak
