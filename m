Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60685C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBE520672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="aGVVKe5w";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="s6V36BB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBE520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbeKZTRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:17:35 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:58708 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726167AbeKZTRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:17:34 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAQ8Nrui007469;
        Mon, 26 Nov 2018 00:24:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=QzD1RYftKPRTLTQPy5rXW+NC0x//taccz1l17559ru0=;
 b=aGVVKe5wxZJgngdTCtTZ/Yjqnh2ZlElr1QeVTcqGCyb4kJFaVqzQ3CEmGhT9r4OoI8xG
 TYe9I0xcOh9DvTVGJ4DDEouynLkpK59KQ0GbnedQ1mzV/u8YYPunYF3GUQnxpHkGMQU+
 8BcdNihIBfTWkbUAPujKMeTb6gVxY3ULlw21u07f7Inxsv+k/CycAb0uZ4GAOZlUErcT
 om8vh9s6txO8yqgK7qncbKOgVn8os11Dtg5FBnGM8yo1ozplt+6sJ0TKSPSCJLZ84p7x
 hsdrgwl5aq/mUQH8gcOHW5j6ITteWi3u66m86IPQDSH2xg4NDpLhjWKY8NIKIbRtSRLj 6Q== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp0088.outbound.protection.outlook.com [207.46.163.88])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2ny34ch0vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 26 Nov 2018 00:24:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzD1RYftKPRTLTQPy5rXW+NC0x//taccz1l17559ru0=;
 b=s6V36BB+emgVr3fxa30CXl23VdATz7rjfshKq6PRkgTzxhdWMlT9IPn4y1zUW+4dd6d+AzfwOIWNkgM0hNLLu0co5kfFO8jFejQJnZndGFxM7VtoKg9E43cdWd4W4W9xnbgoiRZ25spKALPNZMpkoFAu0X35R+96n7FOkQ8evfQ=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5127.namprd07.prod.outlook.com (20.176.254.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Mon, 26 Nov 2018 08:24:01 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644%6]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 08:24:00 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [RFC PATCH v2 06/15] usb:cdns3: Adds Host support
Thread-Topic: [RFC PATCH v2 06/15] usb:cdns3: Adds Host support
Thread-Index: AQHUfycWiFpaPHr330eVBm8LUsw0C6VdccQAgARIupA=
Date:   Mon, 26 Nov 2018 08:24:00 +0000
Message-ID: <BYAPR07MB4709593D0B03399E9D35E07BDDD70@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-7-git-send-email-pawell@cadence.com>
 <5BF80D44.2050600@ti.com>
In-Reply-To: <5BF80D44.2050600@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYTA1MTM5OWMtZjE1NC0xMWU4LTg3MjYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGEwNTEzOTlkLWYxNTQtMTFlOC04NzI2LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTM1MTIiIHQ9IjEzMTg3Njk0MjQxNTQ2NTcyNCIgaD0iK21qbU9vQWdIN3NMTG5wOFcwT0VlemQvN0lzPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5127;20:fahCGy6OWpHOfrAOv5wOuN30BCtGX+zg1eOBbdfShbQPwqqMBU9ldCkO1D0uQ32xCcgncmQyYvJCz8angn87OnoV2rxP9Ct7NLwRfcd5VUHkxDiL0NS+NdFbEvVgOa28DncrAceukEvbPoxB0eFORL9GEmmeG8tZAU/vu796DtWD14ncd7HLkQgLbF4tMWGJsrDfI/xLf9G5l/uF1/JOlmEQYuy13tyQpFHZeQfvncgaiXL96jorQJvKvzs3csmf
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(366004)(396003)(36092001)(189003)(199004)(11346002)(446003)(107886003)(71200400001)(76176011)(2906002)(102836004)(26005)(53936002)(6436002)(71190400001)(6246003)(186003)(5660300001)(4326008)(68736007)(8936002)(14444005)(9686003)(256004)(305945005)(86362001)(217873002)(6506007)(106356001)(105586002)(74316002)(7696005)(55016002)(99286004)(4744004)(14454004)(6116002)(3846002)(54906003)(316002)(110136005)(25786009)(2501003)(229853002)(66066001)(476003)(486006)(97736004)(7736002)(478600001)(81156014)(81166006)(8676002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5127;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 9c1f1205-474a-42db-6672-08d6537884ad
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5127;
x-ms-traffictypediagnostic: BYAPR07MB5127:
x-microsoft-antispam-prvs: <BYAPR07MB512735988381FFA56AC375D4DDD70@BYAPR07MB5127.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231443)(944501410)(52105112)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB5127;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5127;
x-forefront-prvs: 086831DFB4
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /rvTswqZCp9sFcH0l1o1h6H9NsS7WIXfq86kfHNR4C3I6KAKNdeEdUN8AxGhCJyHXRYGtEHlQDu9HRgB1eam6YImhUVBRgy1pEfdqskXIMRjEPGNKrcH0XUM4pL1I6343Di4g2Db7gjX/Sz0unAzhBCSVq53dtSp0NXSJc/W7wthnEoF25T7e8Fu+l5qIbQP4uifZBrjcJ3BtCnzvhD0LMInRlDM9n9H/aNEB6NNUWYsMaLkSwBAPHtQgYrQsI/IlbHyGTkln3eWnA0Osy3QJru3S5d1GUy//iBflpsMOyD1YGO1EA9PA0XJeabBikS7M40T9BJFjXE8kCoDwjPm/D7aRXifiVxVVCqAmWrZBmU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1f1205-474a-42db-6672-08d6537884ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 08:24:00.5160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5127
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-26_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811260079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>EXTERNAL MAIL
>
>
>On 18/11/18 12:09, Pawel Laszczak wrote:
>> Patch adds host-export.h and host.c file and mplements functions that
>> allow to initialize, start and stop XHCI host driver.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/cdns3/Kconfig       |  10 ++
>>  drivers/usb/cdns3/Makefile      |   1 +
>>  drivers/usb/cdns3/core.c        |   7 +-
>>  drivers/usb/cdns3/host-export.h |  30 ++++
>>  drivers/usb/cdns3/host.c        | 256 ++++++++++++++++++++++++++++++++
>>  5 files changed, 302 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/usb/cdns3/host-export.h
>>  create mode 100644 drivers/usb/cdns3/host.c
>>
>> diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
>> index eb22a8692991..d92bc3d68eb0 100644
>> --- a/drivers/usb/cdns3/Kconfig
>> +++ b/drivers/usb/cdns3/Kconfig
>> @@ -10,6 +10,16 @@ config USB_CDNS3
>>
>>  if USB_CDNS3
>>
>> +config USB_CDNS3_HOST
>> +        bool "Cadence USB3 host controller"
>> +        depends on USB_XHCI_HCD
>> +        help
>> +          Say Y here to enable host controller functionality of the
>> +          cadence driver.
>> +
>> +          Host controller is compliance with XHCI so it will use
>> +          standard XHCI driver.
>> +
>>  config USB_CDNS3_PCI_WRAP
>>  	tristate "PCIe-based Platforms"
>>  	depends on USB_PCI && ACPI
>> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
>> index e779b2a2f8eb..976117ba67ff 100644
>> --- a/drivers/usb/cdns3/Makefile
>> +++ b/drivers/usb/cdns3/Makefile
>> @@ -2,4 +2,5 @@ obj-$(CONFIG_USB_CDNS3)			+=3D cdns3.o
>>  obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+=3D cdns3-pci.o
>>
>>  cdns3-y					:=3D core.o drd.o
>> +cdns3-$(CONFIG_USB_CDNS3_HOST)          +=3D host.o
>>  cdns3-pci-y		 		:=3D cdns3-pci-wrap.o
>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>> index dbee4325da7f..4cb820be9ff3 100644
>> --- a/drivers/usb/cdns3/core.c
>> +++ b/drivers/usb/cdns3/core.c
>> @@ -17,6 +17,7 @@
>>
>>  #include "gadget.h"
>>  #include "core.h"
>> +#include "host-export.h"
>>  #include "drd.h"
>>
>>  static inline struct cdns3_role_driver *cdns3_get_current_role_driver(s=
truct cdns3 *cdns)
>> @@ -98,7 +99,8 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
>>  	}
>>
>>  	if (dr_mode =3D=3D USB_DR_MODE_OTG || dr_mode =3D=3D USB_DR_MODE_HOST)=
 {
>> -		//TODO: implements host initialization
>> +		if (cdns3_host_init(cdns))
>> +			dev_info(dev, "doesn't support host\n");
>
>dev_err()
>
>And you need to error out with error code.

ok, but I assume that even if host returns error then we can use=20
only device role. Only when both functions return errors, then it's  a crit=
ical error=20
and function return error code.=20
>
>>  	}
>>
>>  	if (dr_mode =3D=3D USB_DR_MODE_OTG || dr_mode =3D=3D USB_DR_MODE_PERIP=
HERAL) {
>> @@ -142,7 +144,7 @@ static irqreturn_t cdns3_irq(int irq, void *data)
>>
>>  static void cdns3_remove_roles(struct cdns3 *cdns)
>>  {
>> -	//TODO: implements this function
>
>if (dr_mode =3D=3D USB_DR_MODE_OTG || dr_mode =3D=3D USB_DR_MODE_HOST)
>
>> +	cdns3_host_remove(cdns);
>
>How about calling it cdns3_host_exit() to complement cdns3_host_init().
>
>>  }
>>
>>  static int cdns3_do_role_switch(struct cdns3 *cdns, enum cdns3_roles ro=
le)
>> @@ -410,6 +412,7 @@ static struct platform_driver cdns3_driver =3D {
>>
>>  static int __init cdns3_driver_platform_register(void)
>>  {
>> +	cdns3_host_driver_init();
>>  	return platform_driver_register(&cdns3_driver);
>>  }
>>  module_init(cdns3_driver_platform_register);
>> diff --git a/drivers/usb/cdns3/host-export.h b/drivers/usb/cdns3/host-ex=
port.h
>> new file mode 100644
>> index 000000000000..f8f3b230b472
>> --- /dev/null
>> +++ b/drivers/usb/cdns3/host-export.h
>> @@ -0,0 +1,30 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Cadence USBSS DRD Driver -Host Export APIs
>> + *
>> + * Copyright (C) 2017 NXP
>> + *
>> + * Authors: Peter Chen <peter.chen@nxp.com>
>> + */
>> +#ifndef __LINUX_CDNS3_HOST_EXPORT
>> +#define __LINUX_CDNS3_HOST_EXPORT
>> +
>> +#ifdef CONFIG_USB_CDNS3_HOST
>> +
>> +int cdns3_host_init(struct cdns3 *cdns);
>> +void cdns3_host_remove(struct cdns3 *cdns);
>> +void cdns3_host_driver_init(void);
>> +
>> +#else
>> +
>> +static inline int cdns3_host_init(struct cdns3 *cdns)
>> +{
>> +	return -ENXIO;
>> +}
>> +
>> +static inline void cdns3_host_remove(struct cdns3 *cdns) { }
>> +static inline void cdns3_host_driver_init(void) {}
>> +
>> +#endif /* CONFIG_USB_CDNS3_HOST */
>> +
>> +#endif /* __LINUX_CDNS3_HOST_EXPORT */
>> diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
>> new file mode 100644
>> index 000000000000..0dd47976cb28
>> --- /dev/null
>> +++ b/drivers/usb/cdns3/host.c
>> @@ -0,0 +1,256 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Cadence USBSS DRD Driver - host side
>> + *
>> + * Copyright (C) 2018 Cadence Design Systems.
>> + * Copyright (C) 2018 NXP
>> + *
>> + * Authors: Peter Chen <peter.chen@nxp.com>
>> + *	    Pawel Laszczak <pawell@cadence.com>
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/device.h>
>> +#include <linux/io.h>
>> +#include <linux/slab.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/usb.h>
>> +#include <linux/usb/hcd.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/usb/of.h>
>> +
>> +#include "../host/xhci.h"
>> +#include "core.h"
>> +#include "host-export.h"
>> +
>> +static struct hc_driver __read_mostly xhci_cdns3_hc_driver;
>> +
>> +static void xhci_cdns3_quirks(struct device *dev, struct xhci_hcd *xhci=
)
>> +{
>> +	/*
>> +	 * As of now platform drivers don't provide MSI support so we ensure
>> +	 * here that the generic code does not try to make a pci_dev from our
>> +	 * dev struct in order to setup MSI
>> +	 */
>> +	xhci->quirks |=3D XHCI_PLAT;
>> +}
>> +
>> +static int xhci_cdns3_setup(struct usb_hcd *hcd)
>> +{
>> +	struct xhci_hcd	*xhci =3D hcd_to_xhci(hcd);
>> +	u32 command;
>> +	int ret;
>> +
>> +	ret =3D xhci_gen_setup(hcd, xhci_cdns3_quirks);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* set usbcmd.EU3S */
>> +	command =3D readl(&xhci->op_regs->command);
>> +	command |=3D CMD_PM_INDEX;
>> +	writel(command, &xhci->op_regs->command);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct xhci_driver_overrides xhci_cdns3_overrides __initco=
nst =3D {
>> +	.extra_priv_size =3D sizeof(struct xhci_hcd),
>> +	.reset =3D xhci_cdns3_setup,
>> +};
>> +
>> +struct cdns3_host {
>> +	struct device dev;
>> +	struct usb_hcd *hcd;
>> +};
>> +
>> +static irqreturn_t cdns3_host_irq(struct cdns3 *cdns)
>> +{
>> +	struct device *dev =3D cdns->host_dev;
>> +	struct usb_hcd	*hcd;
>> +
>> +	if (dev)
>> +		hcd =3D dev_get_drvdata(dev);
>> +	else
>> +		return IRQ_NONE;
>> +
>> +	if (hcd)
>> +		return usb_hcd_irq(cdns->irq, hcd);
>> +	else
>> +		return IRQ_NONE;
>
>Why can't you just reuse the xhci-platform driver and let it manage the IR=
Q?
>Since it is a shared IRQ, different drivers can request the same IRQ and r=
eturn IRQ_NONE
>if the IRQ wasn't from their device.

In device role the host part of controller is kept in reset, so driver can'=
t read the host register.=20
Such solution allows driver to control access to host register.=20
So if driver has shared separate interrupt for host role then it has to che=
ck if controller work in=20
Host role. =20

>> +}
>> +
>> +static void cdns3_host_release(struct device *dev)
>> +{
>> +	struct cdns3_host *host =3D container_of(dev, struct cdns3_host, dev);
>> +
>> +	kfree(host);
>> +}
>> +
>> +static int cdns3_host_start(struct cdns3 *cdns)
>> +{
>> +	struct cdns3_host *host;
>> +	struct device *dev;
>> +	struct device *sysdev;
>> +	struct xhci_hcd	*xhci;
>> +	int ret;
>> +
>> +	host =3D kzalloc(sizeof(*host), GFP_KERNEL);
>> +	if (!host)
>> +		return -ENOMEM;
>> +
>> +	dev =3D &host->dev;
>> +	dev->release =3D cdns3_host_release;
>> +	dev->parent =3D cdns->dev;
>> +	dev_set_name(dev, "xhci-cdns3");
>> +	cdns->host_dev =3D dev;
>> +	ret =3D device_register(dev);
>> +	if (ret)
>> +		goto err1;
>> +
>> +	sysdev =3D cdns->dev;
>> +	/* Try to set 64-bit DMA first */
>> +	if (WARN_ON(!sysdev->dma_mask))
>> +		/* Platform did not initialize dma_mask */
>> +		ret =3D dma_coerce_mask_and_coherent(sysdev,
>> +						   DMA_BIT_MASK(64));
>> +	else
>> +		ret =3D dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
>> +
>> +	/* If setting 64-bit DMA mask fails, fall back to 32-bit DMA mask */
>> +	if (ret) {
>> +		ret =3D dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(32));
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	pm_runtime_set_active(dev);
>> +	pm_runtime_no_callbacks(dev);
>> +	pm_runtime_enable(dev);
>> +	host->hcd =3D __usb_create_hcd(&xhci_cdns3_hc_driver, sysdev, dev,
>> +				     dev_name(dev), NULL);
>> +	if (!host->hcd) {
>> +		ret =3D -ENOMEM;
>> +		goto err2;
>> +	}
>> +
>> +	host->hcd->regs =3D cdns->xhci_regs;
>> +	host->hcd->rsrc_start =3D cdns->xhci_res->start;
>> +	host->hcd->rsrc_len =3D resource_size(cdns->xhci_res);
>> +
>> +	device_wakeup_enable(host->hcd->self.controller);
>> +	xhci =3D hcd_to_xhci(host->hcd);
>> +
>> +	xhci->main_hcd =3D host->hcd;
>> +	xhci->shared_hcd =3D __usb_create_hcd(&xhci_cdns3_hc_driver, sysdev, d=
ev,
>> +					    dev_name(dev), host->hcd);
>> +	if (!xhci->shared_hcd) {
>> +		ret =3D -ENOMEM;
>> +		goto err3;
>> +	}
>> +
>> +	host->hcd->tpl_support =3D of_usb_host_tpl_support(sysdev->of_node);
>> +	xhci->shared_hcd->tpl_support =3D host->hcd->tpl_support;
>> +	ret =3D usb_add_hcd(host->hcd, 0, IRQF_SHARED);
>> +	if (ret)
>> +		goto err4;
>> +
>> +	ret =3D usb_add_hcd(xhci->shared_hcd, 0, IRQF_SHARED);
>> +	if (ret)
>> +		goto err5;
>> +
>> +	device_set_wakeup_capable(dev, true);
>
>All this is being done by the xhci-plat.c
>
>You can make use of it by just creating a xhci-hcd platform device.
>
>e.g.
>platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
>platform_device_add_resources() to add IRQ and memory resource.
>platform_device_add_properties() to add any quirks.
>platform_device_add()
>

If we do this in this way driver will not control the interrupt.=20
This code  has written by Peter Chan and I am convinced=20
that this concept is only correct one.

>> +
>> +	return 0;
>> +
>> +err5:
>> +	usb_remove_hcd(host->hcd);
>> +err4:
>> +	usb_put_hcd(xhci->shared_hcd);
>> +err3:
>> +	usb_put_hcd(host->hcd);
>> +err2:
>> +	device_del(dev);
>> +err1:
>> +	put_device(dev);
>> +	cdns->host_dev =3D NULL;
>> +	return ret;
>> +}
>> +
>> +static void cdns3_host_stop(struct cdns3 *cdns)
>> +{
>> +	struct device *dev =3D cdns->host_dev;
>> +	struct xhci_hcd	*xhci;
>> +	struct usb_hcd	*hcd;
>> +
>> +	if (dev) {
>> +		hcd =3D dev_get_drvdata(dev);
>> +		xhci =3D hcd_to_xhci(hcd);
>> +		usb_remove_hcd(xhci->shared_hcd);
>> +		usb_remove_hcd(hcd);
>> +		synchronize_irq(cdns->irq);
>> +		usb_put_hcd(xhci->shared_hcd);
>> +		usb_put_hcd(hcd);
>> +		cdns->host_dev =3D NULL;
>> +		pm_runtime_set_suspended(dev);
>> +		pm_runtime_disable(dev);
>> +		device_del(dev);
>> +		put_device(dev);
>> +	}
>
>You can replace this with just
>	platform_device_unregister(xhci_dev);
>
>> +}
>> +
>> +#if CONFIG_PM
>> +static int cdns3_host_suspend(struct cdns3 *cdns, bool do_wakeup)
>> +{
>> +	struct device *dev =3D cdns->host_dev;
>> +	struct xhci_hcd	*xhci;
>> +
>> +	if (!dev)
>> +		return 0;
>> +
>> +	xhci =3D hcd_to_xhci(dev_get_drvdata(dev));
>> +	return xhci_suspend(xhci, do_wakeup);
>> +}
>> +
>> +static int cdns3_host_resume(struct cdns3 *cdns, bool hibernated)
>> +{
>> +	struct device *dev =3D cdns->host_dev;
>> +	struct xhci_hcd	*xhci;
>> +
>> +	if (!dev)
>> +		return 0;
>> +
>> +	xhci =3D hcd_to_xhci(dev_get_drvdata(dev));
>> +	return xhci_resume(xhci, hibernated);
>> +}
>
>These won't be required any more as xhci-plat is doing this.
>
>> +#endif /* CONFIG_PM */
>> +
>> +int cdns3_host_init(struct cdns3 *cdns)
>> +{
>> +	struct cdns3_role_driver *rdrv;
>> +
>> +	rdrv =3D devm_kzalloc(cdns->dev, sizeof(*rdrv), GFP_KERNEL);
>> +	if (!rdrv)
>> +		return -ENOMEM;
>> +
>> +	rdrv->start	=3D cdns3_host_start;
>> +	rdrv->stop	=3D cdns3_host_stop;
>> +	rdrv->irq	=3D cdns3_host_irq;
>> +#if CONFIG_PM
>> +	rdrv->suspend	=3D cdns3_host_suspend;
>> +	rdrv->resume	=3D cdns3_host_resume;
>> +#endif /* CONFIG_PM */
>> +	rdrv->name	=3D "host";
>> +	cdns->roles[CDNS3_ROLE_HOST] =3D rdrv;
>> +
>> +	return 0;
>> +}
>> +
>> +void cdns3_host_remove(struct cdns3 *cdns)
>> +{
>> +	cdns3_host_stop(cdns);
>
>calling cdns3_host_stop() here can lead to problems as Controller might be=
 in
>peripheral mode at this point. The core driver needs to ensure that releva=
nt role
>is stopped before calling cdns3_host_remove().
>
>Here you need to unregister the role driver though.
>
>cdns->roles[CDNS3_ROLE_HOST] =3D NULL;
>
This function can be called only in host mode/role. It operate on host regi=
sters.=20
This checking is provided in core.c file.=20
>> +}
>> +
>> +void __init cdns3_host_driver_init(void)
>> +{
>> +	xhci_init_driver(&xhci_cdns3_hc_driver, &xhci_cdns3_overrides);
>> +}
>>
>
>cheers,
>-roger
>
>--
>Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
