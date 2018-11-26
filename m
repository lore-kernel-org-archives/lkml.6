Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F17C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C67120855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="eTr1k97d";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="VM7/3mUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C67120855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbeKZSQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:16:57 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:56976 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726158AbeKZSQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:16:57 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAQ7J5Ju004111;
        Sun, 25 Nov 2018 23:23:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=hlD06X5roSM97pddUtV1QB3e1O174YpIo/UYsRbOvSQ=;
 b=eTr1k97d8aS+VtwiLjRqcI+QUn1e37ks/65WluCwJqSSioYFYXhZfci0zGhhXUBtIl+I
 1vxNCRIWi4q6tCBSKE5mhWCXetqVH0NvEo84ArfDlQS0avQRNP885Qz5Zboop5fcq95J
 4oHczUlSHr7u9Obwn+ZogPoTwpPWkH4xlTVRiVTADBDP0xBgNpcjFx7IWrQsxCMjjQGP
 7impjm9UevGRpnzY5IboI+kEHs64D0Xi6DhDY7eXHBkvVElVMiOyYL8WhabgnaMHKs7t
 6TpAMbOjWIG7+eMK9chZ0GS4bPhysOJb5PAf9/PHcX76gARxiI/UHBp1KjIw/5bJ4ZZQ 5g== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp0082.outbound.protection.outlook.com [207.46.163.82])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2ny34cgs62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 25 Nov 2018 23:23:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlD06X5roSM97pddUtV1QB3e1O174YpIo/UYsRbOvSQ=;
 b=VM7/3mUgiUXS102FRsh6jCP0Z3mCoNRZK/GZoKdHgWqoI/i4wkI2IQ8/g4HcPajDzGNf8HNLZ48xrTAuTqZ1bFwmjYGQwMdb99xmThhu5N1PNxmca3Q6aTgM2JcMmw/3NpvRFcjs+WTaOvfCRPGITb5fa6jfmRHtYF9LVXZfAKs=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5575.namprd07.prod.outlook.com (20.177.231.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Mon, 26 Nov 2018 07:23:13 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644%6]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 07:23:11 +0000
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
Subject: RE: [RFC PATCH v2 05/15] usb:cdns3: Added DRD support
Thread-Topic: [RFC PATCH v2 05/15] usb:cdns3: Added DRD support
Thread-Index: AQHUfycWERNbYpUTLUKmTA3BhMz+TaVdedoAgAQTVDA=
Date:   Mon, 26 Nov 2018 07:23:11 +0000
Message-ID: <BYAPR07MB470991EB0AE200B6481AEE35DDD70@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-6-git-send-email-pawell@cadence.com>
 <5BF8140C.7000605@ti.com>
In-Reply-To: <5BF8140C.7000605@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMjBlYWJmNDQtZjE0Yy0xMWU4LTg3MjYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDIwZWFiZjQ1LWYxNGMtMTFlOC04NzI2LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTc1MzkiIHQ9IjEzMTg3NjkwNTkyMzc3MDU4NSIgaD0iM0RQazBzWkhJaFlDdDJ0RzJjZUNXTjJOUTdFPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5575;20:ynXrjf/FqllNTndtsFzqJVeNdD1NM0KDZPTjp5UuWYtMkilhwZi0IMsJxVvNgFj1pNcfy4RP4X9P7Pr/7eIDjZHXfihwG5rqzTrIEZ/jbqfw7BHqPdNZ2ul5dq+fzDaJ1BOvZUKsn3mSN79LbGWrRzpurLhjB+0t65PGQLqxbLcxSe3yclXUsQ48G230957pFqunziujQObomBx/EKhEmBSteX029YZteB/cEfOncF8rtN3/rtk3TV9INGOMNFkv
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(376002)(346002)(199004)(189003)(36092001)(305945005)(74316002)(7736002)(102836004)(6506007)(76176011)(6436002)(316002)(66066001)(2501003)(14454004)(71200400001)(71190400001)(229853002)(4326008)(81166006)(81156014)(106356001)(105586002)(478600001)(8936002)(5660300001)(186003)(4744004)(26005)(33656002)(2906002)(97736004)(8676002)(575784001)(86362001)(217873002)(476003)(486006)(9686003)(3846002)(6116002)(54906003)(55016002)(110136005)(99286004)(53946003)(6246003)(7696005)(107886003)(256004)(14444005)(68736007)(446003)(11346002)(53936002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5575;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: cbcf5966-245c-4166-0e45-08d6537005c3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5575;
x-ms-traffictypediagnostic: BYAPR07MB5575:
x-microsoft-antispam-prvs: <BYAPR07MB5575E3CE99F47451CFD306D5DDD70@BYAPR07MB5575.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231443)(944501410)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB5575;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5575;
x-forefront-prvs: 086831DFB4
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dOOpzwnN9fqXBB9P/N2OpU4qC4pX1CSfjn2tfD2+v33aal8Y/yxJws4TtQzAF+PWS29/QbfhFkxpsnspSX38hnVXNkToLiaiysDRW8SxmF+DzlR28E8qHWtUMaDSf4npZVNmjAhEY1WjSfyMKaVrFRFlofJKToENhwMsPxQW2ao2FpkY447pIAcndmwONO7Q1nlmOyghs46Y23VPlG7qU+rAKuUv8frPPUOnfL8Sw80Dk0vdSOD8RWEMVsMuz54AcQcnWeHc3G4gSePZM/ckEh3HZzQps1/DQ/B9j5zqfoQletF+xlXHNsBgxQ4UsXqRZ5gnY9XRI4AycqZGfd9B2/7oouM7BwweTDS6w4EMIjo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbcf5966-245c-4166-0e45-08d6537005c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 07:23:11.6474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5575
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-26_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811260068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

>On 18/11/18 12:09, Pawel Laszczak wrote:
>> Patch adds supports for detecting Host/Device mode.
>> Controller has additional OTG register that allow
>> implement even whole OTG functionality.
>> At this moment patch adds support only for detecting
>> the appropriate mode based on strap pins and ID pin.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/cdns3/Makefile |   2 +-
>>  drivers/usb/cdns3/core.c   |  27 +++--
>>  drivers/usb/cdns3/drd.c    | 229 +++++++++++++++++++++++++++++++++++++
>>  drivers/usb/cdns3/drd.h    | 122 ++++++++++++++++++++
>>  4 files changed, 372 insertions(+), 8 deletions(-)
>>  create mode 100644 drivers/usb/cdns3/drd.c
>>  create mode 100644 drivers/usb/cdns3/drd.h
>>
>> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
>> index 02d25b23c5d3..e779b2a2f8eb 100644
>> --- a/drivers/usb/cdns3/Makefile
>> +++ b/drivers/usb/cdns3/Makefile
>> @@ -1,5 +1,5 @@
>>  obj-$(CONFIG_USB_CDNS3)			+=3D cdns3.o
>>  obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+=3D cdns3-pci.o
>>
>> -cdns3-y					:=3D core.o
>> +cdns3-y					:=3D core.o drd.o
>>  cdns3-pci-y		 		:=3D cdns3-pci-wrap.o
>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>> index f9055d4da67f..dbee4325da7f 100644
>> --- a/drivers/usb/cdns3/core.c
>> +++ b/drivers/usb/cdns3/core.c
>> @@ -17,6 +17,7 @@
>>
>>  #include "gadget.h"
>>  #include "core.h"
>> +#include "drd.h"
>>
>>  static inline struct cdns3_role_driver *cdns3_get_current_role_driver(s=
truct cdns3 *cdns)
>>  {
>> @@ -57,8 +58,10 @@ static inline void cdns3_role_stop(struct cdns3 *cdns=
)
>>  static enum cdns3_roles cdns3_get_role(struct cdns3 *cdns)
>>  {
>>  	if (cdns->roles[CDNS3_ROLE_HOST] && cdns->roles[CDNS3_ROLE_GADGET]) {
>> -		//TODO: implements selecting device/host mode
>> -		return CDNS3_ROLE_HOST;
>> +		if (cdns3_is_host(cdns))
>> +			return CDNS3_ROLE_HOST;
>> +		if (cdns3_is_device(cdns))
>> +			return CDNS3_ROLE_GADGET;
>>  	}
>>  	return cdns->roles[CDNS3_ROLE_HOST]
>>  		? CDNS3_ROLE_HOST
>> @@ -124,6 +127,12 @@ static irqreturn_t cdns3_irq(int irq, void *data)
>>  	struct cdns3 *cdns =3D data;
>>  	irqreturn_t ret =3D IRQ_NONE;
>>
>> +	if (cdns->dr_mode =3D=3D USB_DR_MODE_OTG) {
>> +		ret =3D cdns3_drd_irq(cdns);
>> +		if (ret =3D=3D IRQ_HANDLED)
>> +			return ret;
>> +	}
>
>The kernel's shared IRQ model takes care of sharing the same interrupt
>between different devices and their drivers. You don't need to manually
>handle it here. Just let all 3 drivers do a request_irq() and have
>handlers check if the IRQ was theirs or not and return IRQ_HANDLED or
>IRQ_NONE accordingly.
>
>Looks like you can do away with irq member of the role driver struct.

Ok, I will split it into 3 separate part, but in this case, I additionally =
have to check the current=20
role in ISR function. Driver can't read host side registers when controller=
 works in device role=20
and vice versa. One part of controller is kept in reset. Only DRD registers=
 are common and are all accessible.

>> +
>>  	/* Handle device/host interrupt */
>>  	if (cdns->role !=3D CDNS3_ROLE_END)
>>  		ret =3D cdns3_get_current_role_driver(cdns)->irq(cdns);
>> @@ -176,11 +185,8 @@ static void cdns3_role_switch(struct work_struct *w=
ork)
>>
>>  	cdns =3D container_of(work, struct cdns3, role_switch_wq);
>>
>> -	//TODO: implements this functions.
>> -	//host =3D cdns3_is_host(cdns);
>> -	//device =3D cdns3_is_device(cdns);
>> -	host =3D 1;
>> -	device =3D 0;
>> +	host =3D cdns3_is_host(cdns);
>> +	device =3D cdns3_is_device(cdns);
>
>What if there is a ID transition between the 2 functions so that
>and both host and device become true?
>Since you are checking the ID level separately in both the functions.
>
>How about instead having cdns3_get_id() and using
>it to start/stop relevant roles if we are in OTG mode.
>
>Is this going to be used for a role switch even if we're not in OTG mode?
>If not then it is a BUG if we get here.
>
Good point.
User can change current mode by debugfs and then this function will also in=
voked.
Probably I use  cdns3_get_id as you suggest.=20

>>
>>  	if (host)
>>  		role =3D CDNS3_ROLE_HOST;
>> @@ -194,6 +200,12 @@ static void cdns3_role_switch(struct work_struct *w=
ork)
>>  	pm_runtime_get_sync(cdns->dev);
>>  	cdns3_role_stop(cdns);
>>
>> +	if (cdns->desired_dr_mode !=3D cdns->current_dr_mode) {
>
>This is about roles, why are we checking dr_mode here?

Because after changing dr_mode by means of debugfs we need to update mode.=
=20
Driver should do this after stopping the previous role.  I will move this c=
ondition=20
to cdns3_drd_update_mode and add comment in this place.=20

>
>> +		cdns3_drd_update_mode(cdns);
>> +		host =3D cdns3_is_host(cdns);
>> +		device =3D cdns3_is_device(cdns);
>> +	}
>> +
>>  	if (host) {
>>  		if (cdns->roles[CDNS3_ROLE_HOST])
>>  			cdns3_do_role_switch(cdns, CDNS3_ROLE_HOST);
>> @@ -287,6 +299,7 @@ static int cdns3_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		goto err2;
>>
>> +	ret =3D cdns3_drd_init(cdns);
>>  	if (ret)
>>  		goto err2;
>>
>> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
>> new file mode 100644
>> index 000000000000..ac741c80e776
>> --- /dev/null
>> +++ b/drivers/usb/cdns3/drd.c
>> @@ -0,0 +1,229 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Cadence USBSS DRD Driver.
>> + *
>> + * Copyright (C) 2018 Cadence.
>> + *
>> + * Author: Pawel Laszczak <pawell@cadence.com
>> + *
>> + */
>> +#include <linux/kernel.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/delay.h>
>> +#include <linux/usb/otg.h>
>> +
>> +#include "gadget.h"
>> +#include "drd.h"
>> +
>> +/**
>> + * cdns3_set_mode - change mode of OTG Core
>> + * @cdns: pointer to context structure
>> + * @mode: selected mode from cdns_role
>> + */
>> +void cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
>> +{
>> +	u32 reg;
>> +
>> +	cdns->current_dr_mode =3D mode;
>> +	switch (mode) {
>> +	case USB_DR_MODE_PERIPHERAL:
>> +		dev_info(cdns->dev, "Set controller to Gadget mode\n");
>> +		writel(OTGCMD_DEV_BUS_REQ | OTGCMD_OTG_DIS,
>> +		       &cdns->otg_regs->cmd);
>> +		break;
>> +	case USB_DR_MODE_HOST:
>> +		dev_info(cdns->dev, "Set controller to Host mode\n");
>> +		writel(OTGCMD_HOST_BUS_REQ | OTGCMD_OTG_DIS,
>> +		       &cdns->otg_regs->cmd);
>> +		break;
>> +	case USB_DR_MODE_OTG:
>> +		dev_info(cdns->dev, "Set controller to OTG mode\n");
>> +		reg =3D readl(&cdns->otg_regs->ctrl1);
>> +		reg |=3D OTGCTRL1_IDPULLUP;
>> +		writel(reg, &cdns->otg_regs->ctrl1);
>> +
>> +		/* wait until valid ID (ID_VALUE) can be sampled (50ms). */
>> +		mdelay(50);
>> +		break;
>> +	default:
>> +		cdns->current_dr_mode =3D USB_DR_MODE_UNKNOWN;
>> +		dev_err(cdns->dev, "Unsupported mode of operation %d\n", mode);
>> +		return;
>> +	}
>> +}
>> +
>> +static int cdns3_otg_get_id(struct cdns3 *cdns)
>> +{
>> +	int id;
>> +
>> +	id =3D readl(&cdns->otg_regs->sts) & OTGSTS_ID_VALUE;
>> +	dev_dbg(cdns->dev, "OTG ID: %d", id);
>> +	return id;
>> +}
>> +
>> +int cdns3_is_host(struct cdns3 *cdns)
>> +{
>> +	if (cdns->current_dr_mode =3D=3D USB_DR_MODE_HOST)
>> +		return 1;
>
>Why do you need this?

I assumed that some SoC could have cut DRD /OTG and Device or Host part.=20
In such case the driver cannot be based on ID pin.=20
For only HOST it's not a problem because=20
the standard XHCI driver will be used.  Probably I will remove this fragmen=
t.
>
>> +	else if (cdns->current_dr_mode =3D=3D USB_DR_MODE_OTG)
>> +		if (!cdns3_otg_get_id(cdns))
>> +			return 1;
>> +
>> +	return 0;
>> +}
>> +
>> +int cdns3_is_device(struct cdns3 *cdns)
>> +{
>> +	if (cdns->current_dr_mode =3D=3D USB_DR_MODE_PERIPHERAL)
>> +		return 1;
>> +	else if (cdns->current_dr_mode =3D=3D USB_DR_MODE_OTG)
>> +		if (cdns3_otg_get_id(cdns))
>> +			return 1;
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * cdns3_otg_disable_irq - Disable all OTG interrupts
>> + * @cdns: Pointer to controller context structure
>> + */
>> +static void cdns3_otg_disable_irq(struct cdns3 *cdns)
>> +{
>> +	writel(0, &cdns->otg_regs->ien);
>> +}
>> +
>> +/**
>> + * cdns3_otg_enable_irq - enable id and sess_valid interrupts
>> + * @cdns: Pointer to controller context structure
>> + */
>> +static void cdns3_otg_enable_irq(struct cdns3 *cdns)
>> +{
>> +	writel(OTGIEN_ID_CHANGE_INT | OTGIEN_VBUSVALID_RISE_INT |
>> +	       OTGIEN_VBUSVALID_FALL_INT, &cdns->otg_regs->ien);
>> +}
>> +
>> +/**
>> + * cdns3_init_otg_mode - initialize drd controller
>> + * @cdns: Pointer to controller context structure
>> + *
>> + * Returns 0 on success otherwise negative errno
>> + */
>> +static void cdns3_init_otg_mode(struct cdns3 *cdns)
>> +{
>> +	cdns3_otg_disable_irq(cdns);
>> +	/* clear all interrupts */
>> +	writel(~0, &cdns->otg_regs->ivect);
>> +
>> +	cdns3_set_mode(cdns, USB_DR_MODE_OTG);
>> +
>> +	cdns3_otg_enable_irq(cdns);
>> +}
>> +
>> +/**
>> + * cdns3_drd_update_mode - initialize mode of operation
>
>Looks like this will be called only once. How about calling it
>
>cdns3_drd_init_mode()?

It will be also called after changing dr_mode from debugfs.

>> + * @cdns: Pointer to controller context structure
>> + *
>> + * Returns 0 on success otherwise negative errno
>> + */
>> +int cdns3_drd_update_mode(struct cdns3 *cdns)
>> +{
>> +	int ret =3D 0;
>> +
>> +	switch (cdns->desired_dr_mode) {
>
>I think we can get rid of desired_dr_mode member in struct cdns.
>Just pass the mode as an argument to cdns3_drd_init_mode()

This will be used also in patch that introduce debugfs. This filed is also =
used=20
during changing dr_mode from user space.

My intention was:
dr_mode - indicated what driver can support, this filed based on dr_mode fr=
om device tree,=20
	     straps bits from otg register and kernel configuration.=20
desired_ dr_mode - the next mode desired by user, changed by debugfs=20
current_dr_mode  - actually selected mode=20

>
>And we already have cdns->dr_mode.
>
>> +	case USB_DR_MODE_PERIPHERAL:
>> +		cdns3_set_mode(cdns, USB_DR_MODE_PERIPHERAL);
>> +		break;
>> +	case USB_DR_MODE_HOST:
>> +		cdns3_set_mode(cdns, USB_DR_MODE_HOST);
>> +		break;
>> +	case USB_DR_MODE_OTG:
>> +		cdns3_init_otg_mode(cdns);
>> +		break;
>> +	default:
>> +		dev_err(cdns->dev, "Unsupported mode of operation %d\n",
>> +			cdns->dr_mode);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +irqreturn_t cdns3_drd_irq(struct cdns3 *cdns)
>> +{
>> +	irqreturn_t ret =3D IRQ_NONE;
>> +	u32 reg;
>> +
>> +	if (cdns->dr_mode !=3D USB_DR_MODE_OTG)
>> +		return ret;
>> +
>> +	reg =3D readl(&cdns->otg_regs->ivect);
>> +	if (!reg)
>> +		return ret;
>> +
>> +	if (reg & OTGIEN_ID_CHANGE_INT) {
>> +		int id =3D cdns3_otg_get_id(cdns);
>> +
>> +		dev_dbg(cdns->dev, "OTG IRQ: new ID: %d\n",
>> +			cdns3_otg_get_id(cdns));
>> +
>> +		if (id)
>> +			cdns->role =3D CDNS3_ROLE_GADGET;
>> +		else
>> +			cdns->role =3D CDNS3_ROLE_HOST;
>
>Why check ID and set role here? It might change by the time
>the role_switch_wq starts up. Why not check the ID status there?
>
>Also directly changing role here doesn't make sense as
>there will be a mismatch between currently active role and cdns->role.

Yes this fragment does not make sense. =20
>> +
>> +		queue_work(system_freezable_wq, &cdns->role_switch_wq);
>> +
>> +		ret =3D IRQ_HANDLED;
>> +	}
>> +
>> +	writel(~0, &cdns->otg_regs->ivect);
>> +	return IRQ_HANDLED;
>
>return ret;
>
>> +}
>> +
>> +int cdns3_drd_init(struct cdns3 *cdns)
>> +{
>> +	enum usb_dr_mode dr_mode;
>> +	int ret =3D 0;
>> +	u32 state;
>> +
>> +	state =3D OTGSTS_STRAP(readl(&cdns->otg_regs->sts));
>> +
>> +	dr_mode =3D cdns->dr_mode;
>> +	if (state =3D=3D OTGSTS_STRAP_HOST) {
>> +		dev_info(cdns->dev, "Controller strapped to HOST\n");
>> +		dr_mode =3D USB_DR_MODE_HOST;
>> +		if (cdns->dr_mode !=3D USB_DR_MODE_HOST &&
>> +		    cdns->dr_mode !=3D USB_DR_MODE_OTG)
>> +			ret =3D -EINVAL;
>> +	} else if (state =3D=3D OTGSTS_STRAP_GADGET) {
>> +		dev_info(cdns->dev, "Controller strapped to PERIPHERAL\n");
>> +		dr_mode =3D USB_DR_MODE_PERIPHERAL;
>> +		if (cdns->dr_mode !=3D USB_DR_MODE_PERIPHERAL &&
>> +		    cdns->dr_mode !=3D USB_DR_MODE_OTG)
>> +			ret =3D -EINVAL;
>> +	}
>> +
>> +	if (ret) {
>> +		dev_err(cdns->dev, "Incorrect DRD configuration\n");
>> +		return ret;
>> +	}
>> +
>> +	//Updating DR mode according to strap.
>> +	cdns->dr_mode =3D dr_mode;
>> +	cdns->desired_dr_mode =3D dr_mode;
>> +	cdns->current_dr_mode =3D USB_DR_MODE_UNKNOWN;
>> +
>> +	dev_info(cdns->dev, "Controller Device ID: %08lx, Revision ID: %08lx\n=
",
>> +		 CDNS_RID(readl(&cdns->otg_regs->rid)),
>> +		 CDNS_DID(readl(&cdns->otg_regs->did)));
>
>dev_info should be moved at the end if cdns3_drd_update_mode() if it succe=
eded.
Ok,=20
>
>> +
>> +	state =3D readl(&cdns->otg_regs->sts);
>> +	if (OTGSTS_OTG_NRDY(state) !=3D 0) {
>> +		dev_err(cdns->dev, "Cadence USB3 OTG device not ready\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	ret =3D cdns3_drd_update_mode(cdns);
>> +
>> +	return ret;
>> +}
>> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
>> new file mode 100644
>> index 000000000000..0faa7520ecac
>> --- /dev/null
>> +++ b/drivers/usb/cdns3/drd.h
>> @@ -0,0 +1,122 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Cadence USB3 DRD part of USBSS driver
>> + *
>> + * Copyright (C) 2018 Cadence.
>> + *
>> + * Author: Pawel Laszczak <pawell@cadence.com>
>> + */
>> +#ifndef __LINUX_CDNS3_DRD
>> +#define __LINUX_CDNS3_DRD
>> +
>> +#include <linux/usb/otg.h>
>> +#include <linux/phy/phy.h>
>> +#include "core.h"
>> +
>> +/*  DRD register interface. */
>> +struct cdns3_otg_regs {
>> +	__le32 did;
>> +	__le32 rid;
>> +	__le32 capabilities;
>> +	__le32 reserved1;
>> +	__le32 cmd;
>> +	__le32 sts;
>> +	__le32 state;
>> +	__le32 reserved2;
>> +	__le32 ien;
>> +	__le32 ivect;
>> +	__le32 refclk;
>> +	__le32 tmr;
>> +	__le32 reserved3[4];
>> +	__le32 simulate;
>> +	__le32 override;
>> +	__le32 susp_ctrl;
>> +	__le32 reserved4;
>> +	__le32 anasts;
>> +	__le32 adp_ramp_time;
>> +	__le32 ctrl1;
>> +	__le32 ctrl2;
>> +};
>> +
>> +/* CDNS_RID - bitmasks */
>> +#define CDNS_RID(p)			((p) & GENMASK(15, 0))
>> +
>> +/* CDNS_VID - bitmasks */
>> +#define CDNS_DID(p)			((p) & GENMASK(31, 0))
>> +
>> +/* OTGCMD - bitmasks */
>> +/* "Request the bus for Device mode. */
>> +#define OTGCMD_DEV_BUS_REQ	BIT(0)
>> +/* Request the bus for Host mode */
>> +#define OTGCMD_HOST_BUS_REQ		BIT(1)
>> +/* Enable OTG mode. */
>> +#define OTGCMD_OTG_EN			BIT(2)
>> +/* Disable OTG mode */
>> +#define OTGCMD_OTG_DIS			BIT(3)
>> +/*"Configure OTG as A-Device. */
>> +#define OTGCMD_A_DEV_EN			BIT(4)
>> +/*"Configure OTG as A-Device. */
>> +#define OTGCMD_A_DEV_DIS		BIT(5)
>> +/* Drop the bus for Device mod	e. */
>> +#define OTGCMD_DEV_BUS_DROP		BIT(8)
>> +/* Drop the bus for Host mode*/
>> +#define OTGCMD_HOST_BUS_DROP		BIT(9)
>> +/* Power Down USBSS-DEV. */
>> +#define OTGCMD_DEV_POWER_OFF		BIT(11)
>> +/* Power Down CDNSXHCI. */
>> +#define OTGCMD_HOST_POWER_OFF		BIT(12)
>> +
>> +/* OTGIEN - bitmasks */
>> +/* ID change interrupt enable */
>> +#define OTGIEN_ID_CHANGE_INT		BIT(0)
>> +/* Vbusvalid fall detected interrupt enable.*/
>> +#define OTGIEN_VBUSVALID_RISE_INT	BIT(4)
>> +/* Vbusvalid fall detected interrupt enable */
>> +#define OTGIEN_VBUSVALID_FALL_INT	BIT(5)
>> +
>> +/* OTGSTS - bitmasks */
>> +/*
>> + * Current value of the ID pin. It is only valid when idpullup in
>> + *  OTGCTRL1_TYPE register is set to '1'.
>> + */
>> +#define OTGSTS_ID_VALUE			BIT(0)
>> +/* Current value of the vbus_valid */
>> +#define OTGSTS_VBUS_VALID		BIT(1)
>> +/* Current value of the b_sess_vld */
>> +#define OTGSTS_SESSION_VALID		BIT(2)
>> +/*Device mode is active*/
>> +#define OTGSTS_DEV_ACTIVE		BIT(3)
>> +/* Host mode is active. */
>> +#define OTGSTS_HOST_ACTIVE		BIT(4)
>> +/* OTG Controller not ready. */
>> +#define OTGSTS_OTG_NRDY_MASK		BIT(11)
>> +#define OTGSTS_OTG_NRDY(p)		((p) & OTGSTS_OTG_NRDY_MASK)
>> +/*
>> + * Value of the strap pins.
>> + * 000 - no default configuration
>> + * 010 - Controller initiall configured as Host
>> + * 100 - Controller initially configured as Device
>> + */
>> +#define OTGSTS_STRAP(p)			(((p) & GENMASK(14, 12)) >> 12)
>> +#define OTGSTS_STRAP_NO_DEFAULT_CFG	0x00
>> +#define OTGSTS_STRAP_HOST_OTG		0x01
>> +#define OTGSTS_STRAP_HOST		0x02
>> +#define OTGSTS_STRAP_GADGET		0x04
>> +/* Host mode is turned on. */
>> +#define OTGSTSE_XHCI_READYF		BIT(26)
>> +/* "Device mode is turned on .*/
>> +#define OTGSTS_DEV_READY		BIT(27)
>> +
>> +/* OTGREFCLK - bitmasks */
>> +#define OTGREFCLK_STB_CLK_SWITCH_EN	BIT(31)
>> +
>> +/* OTGCTRL1 - bitmasks */
>> +#define OTGCTRL1_IDPULLUP		BIT(24)
>> +
>> +int cdns3_is_host(struct cdns3 *cdns);
>> +int cdns3_is_device(struct cdns3 *cdns);
>> +int cdns3_drd_init(struct cdns3 *cdns);
>> +int cdns3_drd_update_mode(struct cdns3 *cdns);
>> +irqreturn_t cdns3_drd_irq(struct cdns3 *cdns);
>> +
>> +#endif /* __LINUX_CDNS3_DRD */
>>
>
>cheers,
>-roger
>--
>Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

Thanks for all your comments.
Cheers=20
Pawel
