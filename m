Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4D2C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 12:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FAEF20855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 12:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="gdPCNZpA";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="q/VM70tO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FAEF20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeKYX1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 18:27:09 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:50798 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726050AbeKYX1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 18:27:09 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAPB8ilD024735;
        Sun, 25 Nov 2018 04:35:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=YwDCL+rz0r/hlf7p3UqDQPQEwMrwdoM5TgsVZ/diRVc=;
 b=gdPCNZpA5Tp8uqdbFXVhwNhDYxCrPvvU4hjQ7TLduiouwsKSAtm4F9PEGnhG8uMiL1wH
 blHtvcYp+TKH/cHg2hxwe2zClFlOoJt2Stcew42wQxibhCnVOLUBci5G8YPppdE87JTj
 QIMGt0eZQp0Aozs4OCdfvzdp8vJdIGBsgxmmoiiK5npKdivUx8hIHLgF7ahaoDzd0h6N
 ZkL1WBQodpt3u8O/vIpsHnb+0xvFmnqo7ylM9cHZ3yDlJvXXNs6UFzb7AY9yByX716fN
 Ag9bfQldLzRqLLwaeER0pmH1PKyRS/JMyTIiVj73+PAuLhS5Pc2815XYETRcS3dG5y8B 7Q== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp0178.outbound.protection.outlook.com [216.32.180.178])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2ny42ww0ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 25 Nov 2018 04:35:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwDCL+rz0r/hlf7p3UqDQPQEwMrwdoM5TgsVZ/diRVc=;
 b=q/VM70tO84M1gd/u1U971qv53W3na3Tm4VmWOpxTkZQjTqLmSDYiY7lxX4atgUbdfnBwlnG4H2y0i8u0DuBBR7lGmHVOCGHVIFilrO3FQFSln5ybA/fTYvg3OCN7G8KOrgAv0ImZJgaZAXoQmHifWVOxoXw3HYJImcIXtzgTrCQ=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4229.namprd07.prod.outlook.com (52.135.223.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Sun, 25 Nov 2018 12:35:38 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644%6]) with mapi id 15.20.1361.019; Sun, 25 Nov 2018
 12:35:36 +0000
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
Subject: RE: [RFC PATCH v2 04/15] usb:cdns3: Driver initialization code.
Thread-Topic: [RFC PATCH v2 04/15] usb:cdns3: Driver initialization code.
Thread-Index: AQHUfycKfg2nmnNwYkGzkCY+37gGkqVdQtkAgAMQ/7A=
Date:   Sun, 25 Nov 2018 12:35:35 +0000
Message-ID: <BYAPR07MB47093E282D8B60572B4FBE01DDD60@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-5-git-send-email-pawell@cadence.com>
 <5BF7E5E8.3090406@ti.com>
In-Reply-To: <5BF7E5E8.3090406@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-tag-bcast: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctOTk4MDA2MjMtZjBhZS0xMWU4LTg3MjYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDk5ODAwNjI0LWYwYWUtMTFlOC04NzI2LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjA4NTMiIHQ9IjEzMTg3NjIyOTM3Mzc1MzQ0NiIgaD0ib3dkU2R1MHdBd2xBUHRUalFpSzdnV0hIUTBFPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-paste: 
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4229;20:ZWVxgOeR8bxBTEySdULu5yPmC1bRhoLxJ32e+Q8963LG9c82Lv7bqoZ9h7rsVBzm96OPmGClJfVhVzlWNRmO6jwtEUrZVNcle0uCc3l5POhIyMxz1ZVnsjYimUJa0I87UZv/sVCJHVouin+wQrq21IxPeHxAu20lz+gHcVmJaAIJL6M1rP+z5MCf/Q6Tp+UOIlRre5/nkXRW8Qs48jkRMs1sJLmrSi5NnMBvObWaTdhqkda+b7dLttiG0aKajpye
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39850400004)(346002)(376002)(396003)(366004)(136003)(189003)(199004)(51444003)(36092001)(68736007)(4744004)(186003)(2906002)(5660300001)(107886003)(86362001)(105586002)(53936002)(99286004)(6506007)(6246003)(478600001)(14444005)(256004)(71190400001)(74316002)(7736002)(217873002)(26005)(2501003)(4326008)(97736004)(6116002)(11346002)(229853002)(25786009)(8936002)(76176011)(446003)(53946003)(7696005)(9686003)(345774005)(33656002)(476003)(3846002)(55016002)(316002)(66066001)(110136005)(54906003)(486006)(71200400001)(102836004)(81166006)(106356001)(14454004)(8676002)(305945005)(81156014)(6436002)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4229;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 8d9e63f0-2109-4049-2915-08d652d27fcc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4229;
x-ms-traffictypediagnostic: BYAPR07MB4229:
x-microsoft-antispam-prvs: <BYAPR07MB422934167085843D081D6933DDD60@BYAPR07MB4229.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231442)(944501410)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4229;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4229;
x-forefront-prvs: 0867F4F1AA
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: F4C5EWKCRtNsOS7LInOG/HScFC3T2oQA0EZRPfujiY748WRrqY0p8uzad7TuQR/XvqE4MgUi6/cXqwxITfjhImKYUT3L4Nb/zg0DesD42lrhRK/m4w/4oD7UqdQRGQr3CLnSspGNqkOd0uuRTHE0Ljt7YDCn0e0GHDcQFrngGtppaM7oIMthq0BG/BbIIeT8RmQAdvbOdWNdDRza3dxYuCNSjuO3L9HakBlvGN/ajEcSg/32dbiz4KPRw10aAI2ZcY1eVjYmlLv0F2LCov5zO0JuHW9vOgE4IAaO71DFUxq1yvLkjNyGJVQB2PQt3RJINptyznzKsU6d9UKNzK0nKhaKiNwNmlXE1aYQfO4lNXw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9e63f0-2109-4049-2915-08d652d27fcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2018 12:35:35.9519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4229
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-25_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811250066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger

>On 18/11/18 12:09, Pawel Laszczak wrote:
>> Patch adds core.c and core.h file that implements initialization
>> of platform driver and adds function responsible for selecting,
>> switching and running appropriate Device/Host mode.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/cdns3/Makefile |   2 +
>>  drivers/usb/cdns3/core.c   | 413 +++++++++++++++++++++++++++++++++++++
>>  drivers/usb/cdns3/core.h   | 100 +++++++++
>>  3 files changed, 515 insertions(+)
>>  create mode 100644 drivers/usb/cdns3/core.c
>>  create mode 100644 drivers/usb/cdns3/core.h
>>
>> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
>> index dcdd62003c6a..02d25b23c5d3 100644
>> --- a/drivers/usb/cdns3/Makefile
>> +++ b/drivers/usb/cdns3/Makefile
>> @@ -1,3 +1,5 @@
>> +obj-$(CONFIG_USB_CDNS3)			+=3D cdns3.o
>>  obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+=3D cdns3-pci.o
>>
>> +cdns3-y					:=3D core.o
>>  cdns3-pci-y		 		:=3D cdns3-pci-wrap.o
>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>> new file mode 100644
>> index 000000000000..f9055d4da67f
>> --- /dev/null
>> +++ b/drivers/usb/cdns3/core.c
>> @@ -0,0 +1,413 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Cadence USBSS DRD Driver.
>> + *
>> + * Copyright (C) 2018 Cadence.
>> + *
>> + * Author: Peter Chen <peter.chen@nxp.com>
>> + *         Pawel Laszczak <pawell@cadence.com>
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/pm_runtime.h>
>> +
>> +#include "gadget.h"
>> +#include "core.h"
>> +
>> +static inline struct cdns3_role_driver *cdns3_get_current_role_driver(s=
truct cdns3 *cdns)
>> +{
>> +	WARN_ON(cdns->role >=3D CDNS3_ROLE_END || !cdns->roles[cdns->role]);
>> +	return cdns->roles[cdns->role];
>> +}
>> +
>> +static inline int cdns3_role_start(struct cdns3 *cdns, enum cdns3_roles=
 role)
>> +{
>> +	int ret;
>> +
>> +	if (role >=3D CDNS3_ROLE_END)
>
>WARN_ON()?
I agree.=20
>
>> +		return 0;
>> +
>> +	if (!cdns->roles[role])
>> +		return -ENXIO;
>> +
>> +	mutex_lock(&cdns->mutex);
>> +	cdns->role =3D role;
>> +	ret =3D cdns->roles[role]->start(cdns);
>> +	mutex_unlock(&cdns->mutex);
>> +	return ret;
>> +}
>> +
>> +static inline void cdns3_role_stop(struct cdns3 *cdns)
>> +{
>> +	enum cdns3_roles role =3D cdns->role;
>> +
>> +	if (role =3D=3D CDNS3_ROLE_END)
>
>WARN_ON(role >=3D CNDS3_ROLE_END) ?
I agree
>
>> +		return;
>> +
>> +	mutex_lock(&cdns->mutex);
>> +	cdns->roles[role]->stop(cdns);
>> +	cdns->role =3D CDNS3_ROLE_END;
>
>Why change the role here? You are just stopping the role not changing it.
>I think cdns->role should remain unchanged, so we can call cdns3_role_star=
t()
>if required without error.

This line is unnecessary.

>
>> +	mutex_unlock(&cdns->mutex);
>> +}
>> +
>> +static enum cdns3_roles cdns3_get_role(struct cdns3 *cdns)
>> +{
>> +	if (cdns->roles[CDNS3_ROLE_HOST] && cdns->roles[CDNS3_ROLE_GADGET]) {
>> +		//TODO: implements selecting device/host mode
>> +		return CDNS3_ROLE_HOST;
>> +	}
>> +	return cdns->roles[CDNS3_ROLE_HOST]
>> +		? CDNS3_ROLE_HOST
>> +		: CDNS3_ROLE_GADGET;
>
>Why not just
>	return cdns->role;
>
>I'm wondering if we really need this function

TODO will look likie:
		if (cdns3_is_host(cdns))
			return CDNS3_ROLE_HOST;
		if (cdns3_is_device(cdns))
			return CDNS3_ROLE_GADGET;

Function selects initial role. Before invoking it the role is unknown.
I think that function name should be  changed because current name can be m=
isleading.=20

I will change it to cdns3_get_initial_role.
.
>> +}
>
>> +
>> +/**
>> + * cdns3_core_init_role - initialize role of operation
>> + * @cdns: Pointer to cdns3 structure
>> + *
>> + * Returns 0 on success otherwise negative errno
>> + */
>> +static int cdns3_core_init_role(struct cdns3 *cdns)
>> +{
>> +	struct device *dev =3D cdns->dev;
>> +	enum usb_dr_mode dr_mode;
>> +
>> +	dr_mode =3D usb_get_dr_mode(dev);
>> +	cdns->role =3D CDNS3_ROLE_END;
>> +
>> +	/*
>> +	 * If driver can't read mode by means of usb_get_dr_mdoe function then
>> +	 * chooses mode according with Kernel configuration. This setting
>> +	 * can be restricted later depending on strap pin configuration.
>> +	 */
>> +	if (dr_mode =3D=3D USB_DR_MODE_UNKNOWN) {
>> +		if (IS_ENABLED(CONFIG_USB_CDNS3_HOST) &&
>> +		    IS_ENABLED(CONFIG_USB_CDNS3_GADGET))
>> +			dr_mode =3D USB_DR_MODE_OTG;
>> +		else if (IS_ENABLED(CONFIG_USB_CDNS3_HOST))
>> +			dr_mode =3D USB_DR_MODE_HOST;
>> +		else if (IS_ENABLED(CONFIG_USB_CDNS3_GADGET))
>> +			dr_mode =3D USB_DR_MODE_PERIPHERAL;
>> +	}
>> +
>> +	if (dr_mode =3D=3D USB_DR_MODE_OTG || dr_mode =3D=3D USB_DR_MODE_HOST)=
 {
>> +		//TODO: implements host initialization
>
>		/* TODO: Add host role */ ?
>
>> +	}
>> +
>> +	if (dr_mode =3D=3D USB_DR_MODE_OTG || dr_mode =3D=3D USB_DR_MODE_PERIP=
HERAL) {
>> +		//TODO: implements device initialization
>
>		/* TODO: Add device role */ ?
>
>> +	}
>> +
>> +	if (!cdns->roles[CDNS3_ROLE_HOST] && !cdns->roles[CDNS3_ROLE_GADGET]) =
{
>> +		dev_err(dev, "no supported roles\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	cdns->dr_mode =3D dr_mode;
>> +	return 0;
>> +}
>> +
>> +/**
>> + * cdns3_irq - interrupt handler for cdns3 core device
>> + *
>> + * @irq: irq number for cdns3 core device
>> + * @data: structure of cdns3
>> + *
>> + * Returns IRQ_HANDLED or IRQ_NONE
>> + */
>> +static irqreturn_t cdns3_irq(int irq, void *data)
>> +{
>> +	struct cdns3 *cdns =3D data;
>> +	irqreturn_t ret =3D IRQ_NONE;
>> +
>> +	/* Handle device/host interrupt */
>> +	if (cdns->role !=3D CDNS3_ROLE_END)
>
>Is it because of this that you need to set role to END at role_stop?
>I think it is better to add a state variable to struct cdns3_role_driver, =
so we can
>check if it is active or stopped.
>
>e.g.
>	if (cdns3_get_current_role_driver(cdns)->state =3D=3D CDNS3_ROLE_STATE_AC=
TIVE)

Ok, I will do it in this way.=20
>> +		ret =3D cdns3_get_current_role_driver(cdns)->irq(cdns);
>> +
>> +	return ret;
>> +}
>> +
>> +static void cdns3_remove_roles(struct cdns3 *cdns)
>
>Should this be called cdns3_exit_roles() to be opposite of cdns3_init_role=
s()?

Sounds better.=20
I also change cdns3_host_remove to cdns3_host_exit and
cdns3_gadget_remove to cdns3_gadget_exit.=20
>
>> +{
>> +	//TODO: implements this function
>> +}
>
>> +
>> +static int cdns3_do_role_switch(struct cdns3 *cdns, enum cdns3_roles ro=
le)
>> +{
>> +	enum cdns3_roles current_role;
>> +	int ret =3D 0;
>> +
>> +	current_role =3D cdns->role;
>> +
>> +	if (role =3D=3D CDNS3_ROLE_END)
>> +		return 0;
>
>role =3D=3D END looks like error state. and it should never happen.
>WARN here?

Ok, will be changed.
>
>> +
>> +	dev_dbg(cdns->dev, "Switching role");
>> +
>
>Don't you have to stop the previous role before starting the new role?
>
>> +	ret =3D cdns3_role_start(cdns, role);
>> +	if (ret) {
>> +		/* Back to current role */
>> +		dev_err(cdns->dev, "set %d has failed, back to %d\n",
>> +			role, current_role);
>> +		ret =3D cdns3_role_start(cdns, current_role);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +/**
>> + * cdns3_role_switch - work queue handler for role switch
>> + *
>> + * @work: work queue item structure
>> + *
>> + * Handles below events:
>> + * - Role switch for dual-role devices
>> + * - CDNS3_ROLE_GADGET <--> CDNS3_ROLE_END for peripheral-only devices
>> + */
>> +static void cdns3_role_switch(struct work_struct *work)
>> +{
>> +	enum cdns3_roles role =3D CDNS3_ROLE_END;
>> +	struct cdns3 *cdns;
>> +	bool device, host;
>> +
>> +	cdns =3D container_of(work, struct cdns3, role_switch_wq);
>> +
>> +	//TODO: implements this functions.
>> +	//host =3D cdns3_is_host(cdns);
>> +	//device =3D cdns3_is_device(cdns);
>> +	host =3D 1;
>> +	device =3D 0;
>> +
>> +	if (host)
>> +		role =3D CDNS3_ROLE_HOST;
>> +	else if (device)
>> +		role =3D CDNS3_ROLE_GADGET;
>> +
>> +	if (cdns->desired_dr_mode =3D=3D cdns->current_dr_mode &&
>> +	    cdns->role =3D=3D role)
>> +		return;
>> +
>
>I think all the below code can be moved to cdns3_do_role_switch().

Yes, I agree with you. cdns3_role_stop  should be in cdns3_do_role_switch.=
=20

>> +	pm_runtime_get_sync(cdns->dev);
>> +	cdns3_role_stop(cdns);
>> +
>> +	if (host) {
>> +		if (cdns->roles[CDNS3_ROLE_HOST])
>> +			cdns3_do_role_switch(cdns, CDNS3_ROLE_HOST);
>> +		pm_runtime_put_sync(cdns->dev);
>> +		return;
>> +	}
>> +
>> +	if (device)
>> +		cdns3_do_role_switch(cdns, CDNS3_ROLE_GADGET);
>> +	else
>> +		cdns3_do_role_switch(cdns, CDNS3_ROLE_END);
>> +
>> +	pm_runtime_put_sync(cdns->dev);
>> +}
>> +
>> +/**
>> + * cdns3_probe - probe for cdns3 core device
>> + * @pdev: Pointer to cdns3 core platform device
>> + *
>> + * Returns 0 on success otherwise negative errno
>> + */
>> +static int cdns3_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev =3D &pdev->dev;
>> +	struct resource	*res;
>> +	struct cdns3 *cdns;
>> +	void __iomem *regs;
>> +	int ret;
>> +
>> +	cdns =3D devm_kzalloc(dev, sizeof(*cdns), GFP_KERNEL);
>> +	if (!cdns)
>> +		return -ENOMEM;
>> +
>> +	cdns->dev =3D dev;
>> +
>> +	platform_set_drvdata(pdev, cdns);
>> +
>> +	res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>> +	if (!res) {
>> +		dev_err(dev, "missing IRQ\n");
>> +		return -ENODEV;
>> +	}
>> +	cdns->irq =3D res->start;
>> +
>> +	/*
>> +	 * Request memory region
>> +	 * region-0: xHCI
>> +	 * region-1: Peripheral
>> +	 * region-2: OTG registers
>> +	 */
>
>The memory region order is different from the dt-binding.
>There it is OTG, host(xhci), device (peripheral).

I corrected dt-binding.
>
>> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	regs =3D devm_ioremap_resource(dev, res);
>> +
>> +	if (IS_ERR(regs))
>> +		return PTR_ERR(regs);
>> +	cdns->xhci_regs =3D regs;
>> +	cdns->xhci_res =3D res;
>> +
>> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +	regs =3D devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(regs))
>> +		return PTR_ERR(regs);
>> +	cdns->dev_regs	=3D regs;
>> +
>> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 2);
>> +	regs =3D devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(regs))
>> +		return PTR_ERR(regs);
>> +	cdns->otg_regs =3D regs;
>> +
>> +	mutex_init(&cdns->mutex);
>> +
>> +	cdns->phy =3D devm_phy_get(dev, "cdns3,usbphy");
>
>"cdns3,usbphy" is not documented in dt-binding.

I assume that I should add  to dt-binding (cdns3-usb.txt) something like:
 - phys: reference to the USB PHY
 - phy-names: name of the USB PHY, should be " cdns3,usbphy "
=20
>
>> +	if (IS_ERR(cdns->phy)) {
>> +		dev_info(dev, "no generic phy found\n");
>> +		cdns->phy =3D NULL;
>> +		/*
>> +		 * fall through here!
>> +		 * if no generic phy found, phy init
>> +		 * should be done under boot!
>> +		 */
>
>No you shouldn't fall through always if it is an error condition.
>Something like this should work better.
>
>        if (IS_ERR(cnds->phy)) {
>                ret =3D PTR_ERR(cdns->phy);
>                if (ret =3D=3D -ENOSYS || ret =3D=3D -ENODEV) {
>                        cdns->phy =3D NULL;
>                } else if (ret =3D=3D -EPROBE_DEFER) {
>                        return ret;
>                } else {
>                        dev_err(dev, "no phy found\n");
>                        goto err0;
>                }
>        }
>
>So if PHY was provided in DT, and PHY support/drivers is present
>and error condition means something is wrong and we have to error out.
>
>> +	} else {
>> +		phy_init(cdns->phy);
>> +	}
>
>You can do phy_init() outside the else.
>
Thank you for explanation. I will correct this.=20
>> +
>> +	ret =3D cdns3_core_init_role(cdns);
>> +	if (ret)
>> +		goto err1;
>> +
>> +	INIT_WORK(&cdns->role_switch_wq, cdns3_role_switch);
>> +	if (ret)
>> +		goto err2;
>> +
>> +	if (ret)
>> +		goto err2;
>> +
>> +	cdns->role =3D cdns3_get_role(cdns);
>
>I think this should move to cd I'll have a some though on ns3_core_init_ro=
le().

Ok, I will do it.=20
>
>> +
>> +	ret =3D devm_request_irq(dev, cdns->irq, cdns3_irq, IRQF_SHARED,
>> +			       dev_name(dev), cdns);
>> +
>> +	if (ret)
>> +		goto err2;
>
>How about moving request_irq to before cdsn3_core_init_role()?
>
>Then you can move cdns3_role_start() as well to core_init_role().
I'll give it  some though on it, but probably I will probably have to chang=
e little other function..
So the new order should look like this:=20

cdns3_drd_init
devm_request_irq
cdns3_core_init_role, cdns3_get_role, cdns3_role_start

>
>> +
>> +	ret =3D cdns3_role_start(cdns, cdns->role);
>> +	if (ret) {
>> +		dev_err(dev, "can't start %s role\n",
>> +			cdns3_get_current_role_driver(cdns)->name);
>> +		goto err2;
>> +	}
>> +
>> +	device_set_wakeup_capable(dev, true);
>> +	pm_runtime_set_active(dev);
>> +	pm_runtime_enable(dev);
>> +
>> +	/*
>> +	 * The controller needs less time between bus and controller suspend,
>> +	 * and we also needs a small delay to avoid frequently entering low
>> +	 * power mode.
>> +	 */
>> +	pm_runtime_set_autosuspend_delay(dev, 20);
>> +	pm_runtime_mark_last_busy(dev);
>> +	pm_runtime_use_autosuspend(dev);
>> +	dev_dbg(dev, "Cadence USB3 core: probe succeed\n");
>> +
>> +	return 0;
>> +
>> +err2:
>> +	cdns3_remove_roles(cdns);
>> +err1:
>
>phy_exit() ?
I will add.=20
>
>> +	return ret;
>> +}
>> +
>> +/**
>> + * cdns3_remove - unbind drd driver and clean up
>> + * @pdev: Pointer to Linux platform device
>> + *
>> + * Returns 0 on success otherwise negative errno
>> + */
>> +static int cdns3_remove(struct platform_device *pdev)
>> +{
>> +	struct cdns3 *cdns =3D platform_get_drvdata(pdev);
>> +
>> +	pm_runtime_get_sync(&pdev->dev);
>> +	pm_runtime_disable(&pdev->dev);
>> +	pm_runtime_put_noidle(&pdev->dev);
>> +	cdns3_remove_roles(cdns);
>
>phy_exit() ?
I will add.
>
>> +
>> +	return 0;
>> +}
>> +
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id of_cdns3_match[] =3D {
>> +	{ .compatible =3D "cdns,usb3" },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, of_cdns3_match);
>> +#endif
>> +
>> +#ifdef CONFIG_PM
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int cdns3_suspend(struct device *dev)
>> +{
>> +	//TODO: implements this function
>> +	return 0;
>> +}
>> +
>> +static int cdns3_resume(struct device *dev)
>> +{
>> +	//TODO: implements this function
>> +	return 0;
>> +}
>> +#endif /* CONFIG_PM_SLEEP */
>> +static int cdns3_runtime_suspend(struct device *dev)
>> +{	//TODO: implements this function
>> +	return 0;
>> +}
>> +
>> +static int cdns3_runtime_resume(struct device *dev)
>> +{
>> +	//TODO: implements this function
>> +	return 0;
>> +}
>> +#endif /* CONFIG_PM */
>> +
>> +static const struct dev_pm_ops cdns3_pm_ops =3D {
>> +	SET_SYSTEM_SLEEP_PM_OPS(cdns3_suspend, cdns3_resume)
>> +	SET_RUNTIME_PM_OPS(cdns3_runtime_suspend, cdns3_runtime_resume, NULL)
>> +};
>> +
>> +static struct platform_driver cdns3_driver =3D {
>> +	.probe		=3D cdns3_probe,
>> +	.remove		=3D cdns3_remove,
>> +	.driver		=3D {
>> +		.name	=3D "cdns-usb3",
>> +		.of_match_table	=3D of_match_ptr(of_cdns3_match),
>> +		.pm	=3D &cdns3_pm_ops,
>> +	},
>> +};
>> +
>> +static int __init cdns3_driver_platform_register(void)
>> +{
>> +	return platform_driver_register(&cdns3_driver);
>> +}
>> +module_init(cdns3_driver_platform_register);
>> +
>> +static void __exit cdns3_driver_platform_unregister(void)
>> +{
>> +	platform_driver_unregister(&cdns3_driver);
>> +}
>> +module_exit(cdns3_driver_platform_unregister);
>> +
>> +MODULE_ALIAS("platform:cdns3");
>> +MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("Cadence USB3 DRD Controller Driver");
>> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
>> new file mode 100644
>> index 000000000000..7c8204fe4d3d
>> --- /dev/null
>> +++ b/drivers/usb/cdns3/core.h
>> @@ -0,0 +1,100 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Cadence USBSS DRD Driver.
>> + *
>> + * Copyright (C) 2017 NXP
>> + * Copyright (C) 2018 Cadence.
>> + *
>> + * Authors: Peter Chen <peter.chen@nxp.com>
>> + *          Pawel Laszczak <pawell@cadence.com>
>> + */
>> +#include <linux/usb/otg.h>
>> +
>> +#ifndef __LINUX_CDNS3_CORE_H
>> +#define __LINUX_CDNS3_CORE_H
>> +
>> +struct cdns3;
>> +enum cdns3_roles {
>> +	CDNS3_ROLE_HOST =3D 0,
>> +	CDNS3_ROLE_GADGET,
>> +	CDNS3_ROLE_END,
>> +};
>> +
>> +/**
>> + * struct cdns3_role_driver - host/gadget role driver
>> + * @start: start this role
>> + * @stop: stop this role
>> + * @suspend: suspend callback for this role
>> + * @resume: resume callback for this role
>> + * @irq: irq handler for this role
>> + * @name: role name string (host/gadget)
>> + */
>> +struct cdns3_role_driver {
>> +	int (*start)(struct cdns3 *cdns);
>> +	void (*stop)(struct cdns3 *cdns);
>> +	int (*suspend)(struct cdns3 *cdns, bool do_wakeup);
>> +	int (*resume)(struct cdns3 *cdns, bool hibernated);
>> +	irqreturn_t (*irq)(struct cdns3 *cdns);
>> +	const char *name;
>> +};
>> +
>> +#define CDNS3_NUM_OF_CLKS	5
>> +/**
>> + * struct cdns3 - Representation of Cadence USB3 DRD controller.
>> + * @dev: pointer to Cadence device struct
>> + * @xhci_regs: pointer to base of xhci registers
>> + * @xhci_res: the resource for xhci
>> + * @dev_regs: pointer to base of dev registers
>> + * @otg_regs: pointer to base of otg registers
>> + * @irq: irq number for controller
>> + * @roles: array of supported roles for this controller
>> + * @role: current role
>> + * @host_dev: the child host device pointer for cdns3 core
>> + * @gadget_dev: the child gadget device pointer for cdns3 core
>> + * @usb: phy for this controller
>> + * @role_switch_wq: work queue item for role switch
>> + * @in_lpm: the controller in low power mode
>> + * @wakeup_int: the wakeup interrupt
>> + * @mutex: the mutex for concurrent code at driver
>> + * @dr_mode: supported mode of operation it can be only Host, only Devi=
ce
>> + *           or OTG mode that allow to switch between Device and Host m=
ode.
>> + *           This field based on hardware configuration and cant't be c=
hanged.
>
>But dr_mode can be forced in device-tree. So it isn't really only hardware=
 configuration.
Right, I added dr_mode to dt-binding , so we have STRAP bits in registers a=
nd additionally=20
optional dr_mode in device-tree. Driver should take into account this two o=
ptions.  =20
I will remove this line.=20

>
>> + * @current_dr_role: current mode of operation when in dual-role mode
>> + * @desired_dr_role: desired mode of operation when in dual-role mode.
>> + *           This value can be changed during runtime.
>> + *           Available options depends on  dr_mode:
>> + *           dr_mode                 |  desired_dr_role and current_dr_=
role
>> + *           ----------------------------------------------------------=
------
>> + *           USB_DR_MODE_HOST        | only USB_DR_MODE_HOST
>> + *           USB_DR_MODE_PERIPHERAL  | only USB_DR_MODE_PERIPHERAL
>> + *           USB_DR_MODE_OTG         | only USB_DR_MODE_HOST
>> + *           USB_DR_MODE_OTG         | only USB_DR_MODE_PERIPHERAL
>> + *           USB_DR_MODE_OTG         | USB_DR_MODE_OTG
>
>Do you need to update the right hand side to reflect ROLEs instead of MODE=
?

I see that there are incorrect name. There should be mode instead role.=20
In structure below the names are correct.=20
>
>> + *
>> + *           Desired_dr_role can be changed by means of debugfs.
>> + * @root: debugfs root folder pointer
>> + */
>> +struct cdns3 {
>> +	struct device			*dev;
>> +	void __iomem			*xhci_regs;
>> +	struct resource			*xhci_res;
>> +	struct cdns3_usb_regs __iomem	*dev_regs;
>> +	struct cdns3_otg_regs		*otg_regs;
>> +	int irq;
>> +	struct cdns3_role_driver	*roles[CDNS3_ROLE_END];
>> +	enum cdns3_roles		role;
>> +	struct device			*host_dev;
>> +	struct device			*gadget_dev;
>> +	struct phy			*phy;
>> +	struct work_struct		role_switch_wq;
>> +	int				in_lpm:1;
>> +	int				wakeup_int:1;
>> +	/* mutext used in workqueue*/
>> +	struct mutex			mutex;
>> +	enum usb_dr_mode		dr_mode;
>> +	enum usb_dr_mode		current_dr_mode;
>> +	enum usb_dr_mode		desired_dr_mode;
>> +	struct dentry			*root;
>> +};
>> +
>> +#endif /* __LINUX_CDNS3_CORE_H */
>>
>
>cheers,
>-roger
>--
>Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

Thank for all your comments,
Cheers,
Pawel
