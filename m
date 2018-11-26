Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C59C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CFE20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="g7cPBw4P";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ay+IvGyP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5CFE20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbeKZTdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:33:31 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:34336 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726164AbeKZTdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:33:31 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAQ8bxaf009480;
        Mon, 26 Nov 2018 00:39:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=jz0Yijbg01N5SUieJ3x8b8r1Fijs0Seeb1OtKaZNR7Q=;
 b=g7cPBw4P9fFn6r2VHVe2egsLzmve57FkaqlGkq3ZEMkLYEHuClgtwGcwRYDWg1bWSLWA
 9Iq3Va29fG8cRUSWu3MxpmiUe7Hm9C+N6VOV/LM4eCVYF+tytZggreACoE8AXE3mecjv
 LtAJLy+lYqN9yJdmOkC0OnO69ji+1sCsf6jy0Cke4nbr4UfmjtiIWWqKhuE60i5rkbJ6
 lcjVbBqEV8GlneECgULc7K+ijDk8nqJLNkcXLY7APsCZk4GTyi7oTEDATmdJNG+iQs+o
 L7R4oKSOIXMCELS7JIkyKwplzrudpE4hAl78pt0sv3w1/te8sY/twjn+VflLHmOUY7fS Yw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp0111.outbound.protection.outlook.com [207.46.163.111])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2ny42x0eu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Nov 2018 00:39:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jz0Yijbg01N5SUieJ3x8b8r1Fijs0Seeb1OtKaZNR7Q=;
 b=ay+IvGyPbgnxDXOLTMabBuQKPqNEhPWkyBPLcPgQpQbbdHNUHdqNN8/hcRtMvAME+baiMRmbB2nXHAQEJNzRCzWAZkF56YMP6JJwUhKmze1cEzTwclSB1cdCmL0dDY9YcsCYUTKvjZWGEP+pvdsdn3SBVDcQ/sQcRf+86CopTbY=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4693.namprd07.prod.outlook.com (52.135.204.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.28; Mon, 26 Nov 2018 08:39:35 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644%6]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 08:39:35 +0000
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
Thread-Index: AQHUfycWERNbYpUTLUKmTA3BhMz+TaVdedoAgAQTVDCAADKkAIAABLaw
Date:   Mon, 26 Nov 2018 08:39:34 +0000
Message-ID: <BYAPR07MB47092F6F92A344AA76C093C9DDD70@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-6-git-send-email-pawell@cadence.com>
 <5BF8140C.7000605@ti.com>
 <BYAPR07MB470991EB0AE200B6481AEE35DDD70@BYAPR07MB4709.namprd07.prod.outlook.com>
 <5BFBA9BC.20306@ti.com>
In-Reply-To: <5BFBA9BC.20306@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-tag-bcast: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctY2I0MDkyYzItZjE1Ni0xMWU4LTg3MjYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGNiNDA5MmMzLWYxNTYtMTFlOC04NzI2LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTI1NzIiIHQ9IjEzMTg3Njk1MTc2MDE0ODcyNyIgaD0iYU1OZFc4VkdhN1dCRUZwRVppb2Q2VUZKNEs4PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-paste: 
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4693;20:YiHuRJnkBW9WB/75E5QsRD0cZd3tApeeRGWmjij5Q/3TqgViZS7SqY0yPcqnA9rP36ayF1HaHlduaOOPxz6Ah3fxYmY+8N7tPGMSfkQo0RyVnnAeUcnENt0xnly9/3ygUq2Co2Yc4CigdeekzjKyEaN75+ja9tPrr1X4rl7gZcLcERAca/XnRpdPC17NI6xfmF9iKD1iVoG7SBPxbKA/TJ9wJe9obVtp1pG8M5NePgE9rSkWtPIQcI1wmXwIi6P2
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(136003)(39860400002)(36092001)(199004)(189003)(6506007)(478600001)(66066001)(53546011)(54906003)(110136005)(7696005)(486006)(25786009)(229853002)(33656002)(99286004)(86362001)(68736007)(14444005)(476003)(6246003)(9686003)(71190400001)(2501003)(6436002)(11346002)(53936002)(76176011)(2906002)(316002)(4326008)(71200400001)(107886003)(55016002)(14454004)(105586002)(4744004)(26005)(7736002)(74316002)(102836004)(186003)(305945005)(446003)(106356001)(217873002)(93886005)(8676002)(97736004)(256004)(6116002)(5660300001)(8936002)(81166006)(81156014)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4693;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 9945411f-6b33-4311-0ef4-08d6537ab19d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4693;
x-ms-traffictypediagnostic: BYAPR07MB4693:
x-microsoft-antispam-prvs: <BYAPR07MB469358D5E9E0750611EAB4F1DDD70@BYAPR07MB4693.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231443)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4693;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4693;
x-forefront-prvs: 086831DFB4
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lV7A0qG1jdpsRgi0MdiufkCFGWK8OKZdMiG7J19bGYfvVrMnGOHu169XclkfjCL7rpbtJx21nVNFBO31D2AbQxbjdANxbl5eJ1BRs8Vp8N1yWa4CyCv7+MKf8TyEUZ6kCw9rVxid5bdIATCGKvfKPxrShGz0dN69W4Z2jNoUpElem3vuMcJYGi15ZOECLy1g6jptgjpmYYOxNyLhW/MmvqbLRDGJTJamznh/Z11eIkP0G7q6iPpzq3Fd2CshNhlkfXqCpGi2dhsmNTYNcJQw8CW7V/Q7uPWufBYkfDaUSmmwchWs4TYWZwk153cIv9gp2en8UwUBLlXzU6tNUZojOD15jmvgYmywZw9XGm4xFdg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9945411f-6b33-4311-0ef4-08d6537ab19d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 08:39:34.9749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4693
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-26_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811260081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Pawel,
>
>On 26/11/18 09:23, Pawel Laszczak wrote:
>> Hi Roger,
>>
>>> On 18/11/18 12:09, Pawel Laszczak wrote:
>>>> Patch adds supports for detecting Host/Device mode.
>>>> Controller has additional OTG register that allow
>>>> implement even whole OTG functionality.
>>>> At this moment patch adds support only for detecting
>>>> the appropriate mode based on strap pins and ID pin.
>>>>
>>>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>>>> ---
>>>>  drivers/usb/cdns3/Makefile |   2 +-
>>>>  drivers/usb/cdns3/core.c   |  27 +++--
>>>>  drivers/usb/cdns3/drd.c    | 229 ++++++++++++++++++++++++++++++++++++=
+
>>>>  drivers/usb/cdns3/drd.h    | 122 ++++++++++++++++++++
>>>>  4 files changed, 372 insertions(+), 8 deletions(-)
>>>>  create mode 100644 drivers/usb/cdns3/drd.c
>>>>  create mode 100644 drivers/usb/cdns3/drd.h
>>>>
>>>> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
>>>> index 02d25b23c5d3..e779b2a2f8eb 100644
>>>> --- a/drivers/usb/cdns3/Makefile
>>>> +++ b/drivers/usb/cdns3/Makefile
>>>> @@ -1,5 +1,5 @@
>>>>  obj-$(CONFIG_USB_CDNS3)			+=3D cdns3.o
>>>>  obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+=3D cdns3-pci.o
>>>>
>>>> -cdns3-y					:=3D core.o
>>>> +cdns3-y					:=3D core.o drd.o
>>>>  cdns3-pci-y		 		:=3D cdns3-pci-wrap.o
>>>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>>>> index f9055d4da67f..dbee4325da7f 100644
>>>> --- a/drivers/usb/cdns3/core.c
>>>> +++ b/drivers/usb/cdns3/core.c
>>>> @@ -17,6 +17,7 @@
>>>>
>>>>  #include "gadget.h"
>>>>  #include "core.h"
>>>> +#include "drd.h"
>>>>
>>>>  static inline struct cdns3_role_driver *cdns3_get_current_role_driver=
(struct cdns3 *cdns)
>>>>  {
>>>> @@ -57,8 +58,10 @@ static inline void cdns3_role_stop(struct cdns3 *cd=
ns)
>>>>  static enum cdns3_roles cdns3_get_role(struct cdns3 *cdns)
>>>>  {
>>>>  	if (cdns->roles[CDNS3_ROLE_HOST] && cdns->roles[CDNS3_ROLE_GADGET]) =
{
>>>> -		//TODO: implements selecting device/host mode
>>>> -		return CDNS3_ROLE_HOST;
>>>> +		if (cdns3_is_host(cdns))
>>>> +			return CDNS3_ROLE_HOST;
>>>> +		if (cdns3_is_device(cdns))
>>>> +			return CDNS3_ROLE_GADGET;
>>>>  	}
>>>>  	return cdns->roles[CDNS3_ROLE_HOST]
>>>>  		? CDNS3_ROLE_HOST
>>>> @@ -124,6 +127,12 @@ static irqreturn_t cdns3_irq(int irq, void *data)
>>>>  	struct cdns3 *cdns =3D data;
>>>>  	irqreturn_t ret =3D IRQ_NONE;
>>>>
>>>> +	if (cdns->dr_mode =3D=3D USB_DR_MODE_OTG) {
>>>> +		ret =3D cdns3_drd_irq(cdns);
>>>> +		if (ret =3D=3D IRQ_HANDLED)
>>>> +			return ret;
>>>> +	}
>>>
>>> The kernel's shared IRQ model takes care of sharing the same interrupt
>>> between different devices and their drivers. You don't need to manually
>>> handle it here. Just let all 3 drivers do a request_irq() and have
>>> handlers check if the IRQ was theirs or not and return IRQ_HANDLED or
>>> IRQ_NONE accordingly.
>>>
>>> Looks like you can do away with irq member of the role driver struct.
>>
>> Ok, I will split it into 3 separate part, but in this case, I additional=
ly have to check the current
>> role in ISR function. Driver can't read host side registers when control=
ler works in device role
>> and vice versa. One part of controller is kept in reset. Only DRD regist=
ers are common and are all accessible.
>>
>
>In which ISR do you need to check current role?
>
>I'm not sure if we are on the same page.
>Core (drd) driver shouldn't read host/device side registers. All 3 drivers=
,
>i.e. DRD(core), Host (xhci) and device (cdns3) should do a request_irq()
>and process their respective IRQ events.

Yes, I understand.=20
I need to check this in cdns3_irq_handler_thread and cdns3_host_irq.

Core (drd) has register that are always accessible.=20
Core (device)  - registers are available also in device mode
Core (host)  - registers  are available only in host mode=20

So we can use separate request_irq  for drd, device and host side, but=20
we need ensure that in host side driver will not touch the device register.=
=20

We doesn't know the order in which  the system will call interrupts functio=
n related to=20
 the shared interrupt line.

>
>>>> +
>>>>  	/* Handle device/host interrupt */
>>>>  	if (cdns->role !=3D CDNS3_ROLE_END)
>>>>  		ret =3D cdns3_get_current_role_driver(cdns)->irq(cdns);
>>>> @@ -176,11 +185,8 @@ static void cdns3_role_switch(struct work_struct =
*work)
>>>>
>>>>  	cdns =3D container_of(work, struct cdns3, role_switch_wq);
>>>>
>>>> -	//TODO: implements this functions.
>>>> -	//host =3D cdns3_is_host(cdns);
>>>> -	//device =3D cdns3_is_device(cdns);
>>>> -	host =3D 1;
>>>> -	device =3D 0;
>>>> +	host =3D cdns3_is_host(cdns);
>>>> +	device =3D cdns3_is_device(cdns);
>>>
>>> What if there is a ID transition between the 2 functions so that
>>> and both host and device become true?
>>> Since you are checking the ID level separately in both the functions.
>>>
>>> How about instead having cdns3_get_id() and using
>>> it to start/stop relevant roles if we are in OTG mode.
>>>
>>> Is this going to be used for a role switch even if we're not in OTG mod=
e?
>>> If not then it is a BUG if we get here.
>>>
>> Good point.
>> User can change current mode by debugfs and then this function will also=
 invoked.
>> Probably I use  cdns3_get_id as you suggest.
>>
>>>>
>>>>  	if (host)
>>>>  		role =3D CDNS3_ROLE_HOST;
>>>> @@ -194,6 +200,12 @@ static void cdns3_role_switch(struct work_struct =
*work)
>>>>  	pm_runtime_get_sync(cdns->dev);
>>>>  	cdns3_role_stop(cdns);
>>>>
>>>> +	if (cdns->desired_dr_mode !=3D cdns->current_dr_mode) {
>>>
>>> This is about roles, why are we checking dr_mode here?
>>
>> Because after changing dr_mode by means of debugfs we need to update mod=
e.
>> Driver should do this after stopping the previous role.  I will move thi=
s condition
>> to cdns3_drd_update_mode and add comment in this place.
>>
>>>
>>>> +		cdns3_drd_update_mode(cdns);
>>>> +		host =3D cdns3_is_host(cdns);
>>>> +		device =3D cdns3_is_device(cdns);
>>>> +	}
>>>> +
>>>>  	if (host) {
>>>>  		if (cdns->roles[CDNS3_ROLE_HOST])
>>>>  			cdns3_do_role_switch(cdns, CDNS3_ROLE_HOST);
>>>> @@ -287,6 +299,7 @@ static int cdns3_probe(struct platform_device *pde=
v)
>>>>  	if (ret)
>>>>  		goto err2;
>>>>
>>>> +	ret =3D cdns3_drd_init(cdns);
>>>>  	if (ret)
>>>>  		goto err2;
>>>>
>>>> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
>>>> new file mode 100644
>>>> index 000000000000..ac741c80e776
>>>> --- /dev/null
>>>> +++ b/drivers/usb/cdns3/drd.c
>>>> @@ -0,0 +1,229 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Cadence USBSS DRD Driver.
>>>> + *
>>>> + * Copyright (C) 2018 Cadence.
>>>> + *
>>>> + * Author: Pawel Laszczak <pawell@cadence.com
>>>> + *
>>>> + */
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/interrupt.h>
>>>> +#include <linux/delay.h>
>>>> +#include <linux/usb/otg.h>
>>>> +
>>>> +#include "gadget.h"
>>>> +#include "drd.h"
>>>> +
>>>> +/**
>>>> + * cdns3_set_mode - change mode of OTG Core
>>>> + * @cdns: pointer to context structure
>>>> + * @mode: selected mode from cdns_role
>>>> + */
>>>> +void cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
>>>> +{
>>>> +	u32 reg;
>>>> +
>>>> +	cdns->current_dr_mode =3D mode;
>>>> +	switch (mode) {
>>>> +	case USB_DR_MODE_PERIPHERAL:
>>>> +		dev_info(cdns->dev, "Set controller to Gadget mode\n");
>>>> +		writel(OTGCMD_DEV_BUS_REQ | OTGCMD_OTG_DIS,
>>>> +		       &cdns->otg_regs->cmd);
>>>> +		break;
>>>> +	case USB_DR_MODE_HOST:
>>>> +		dev_info(cdns->dev, "Set controller to Host mode\n");
>>>> +		writel(OTGCMD_HOST_BUS_REQ | OTGCMD_OTG_DIS,
>>>> +		       &cdns->otg_regs->cmd);
>>>> +		break;
>>>> +	case USB_DR_MODE_OTG:
>>>> +		dev_info(cdns->dev, "Set controller to OTG mode\n");
>>>> +		reg =3D readl(&cdns->otg_regs->ctrl1);
>>>> +		reg |=3D OTGCTRL1_IDPULLUP;
>>>> +		writel(reg, &cdns->otg_regs->ctrl1);
>>>> +
>>>> +		/* wait until valid ID (ID_VALUE) can be sampled (50ms). */
>>>> +		mdelay(50);
>>>> +		break;
>>>> +	default:
>>>> +		cdns->current_dr_mode =3D USB_DR_MODE_UNKNOWN;
>>>> +		dev_err(cdns->dev, "Unsupported mode of operation %d\n", mode);
>>>> +		return;
>>>> +	}
>>>> +}
>>>> +
>>>> +static int cdns3_otg_get_id(struct cdns3 *cdns)
>>>> +{
>>>> +	int id;
>>>> +
>>>> +	id =3D readl(&cdns->otg_regs->sts) & OTGSTS_ID_VALUE;
>>>> +	dev_dbg(cdns->dev, "OTG ID: %d", id);
>>>> +	return id;
>>>> +}
>>>> +
>>>> +int cdns3_is_host(struct cdns3 *cdns)
>>>> +{
>>>> +	if (cdns->current_dr_mode =3D=3D USB_DR_MODE_HOST)
>>>> +		return 1;
>>>
>>> Why do you need this?
>>
>> I assumed that some SoC could have cut DRD /OTG and Device or Host part.
>> In such case the driver cannot be based on ID pin.
>> For only HOST it's not a problem because
>> the standard XHCI driver will be used.  Probably I will remove this frag=
ment.
>>>
>>>> +	else if (cdns->current_dr_mode =3D=3D USB_DR_MODE_OTG)
>>>> +		if (!cdns3_otg_get_id(cdns))
>>>> +			return 1;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +int cdns3_is_device(struct cdns3 *cdns)
>>>> +{
>>>> +	if (cdns->current_dr_mode =3D=3D USB_DR_MODE_PERIPHERAL)
>>>> +		return 1;
>>>> +	else if (cdns->current_dr_mode =3D=3D USB_DR_MODE_OTG)
>>>> +		if (cdns3_otg_get_id(cdns))
>>>> +			return 1;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +/**
>>>> + * cdns3_otg_disable_irq - Disable all OTG interrupts
>>>> + * @cdns: Pointer to controller context structure
>>>> + */
>>>> +static void cdns3_otg_disable_irq(struct cdns3 *cdns)
>>>> +{
>>>> +	writel(0, &cdns->otg_regs->ien);
>>>> +}
>>>> +
>>>> +/**
>>>> + * cdns3_otg_enable_irq - enable id and sess_valid interrupts
>>>> + * @cdns: Pointer to controller context structure
>>>> + */
>>>> +static void cdns3_otg_enable_irq(struct cdns3 *cdns)
>>>> +{
>>>> +	writel(OTGIEN_ID_CHANGE_INT | OTGIEN_VBUSVALID_RISE_INT |
>>>> +	       OTGIEN_VBUSVALID_FALL_INT, &cdns->otg_regs->ien);
>>>> +}
>>>> +
>>>> +/**
>>>> + * cdns3_init_otg_mode - initialize drd controller
>>>> + * @cdns: Pointer to controller context structure
>>>> + *
>>>> + * Returns 0 on success otherwise negative errno
>>>> + */
>>>> +static void cdns3_init_otg_mode(struct cdns3 *cdns)
>>>> +{
>>>> +	cdns3_otg_disable_irq(cdns);
>>>> +	/* clear all interrupts */
>>>> +	writel(~0, &cdns->otg_regs->ivect);
>>>> +
>>>> +	cdns3_set_mode(cdns, USB_DR_MODE_OTG);
>>>> +
>>>> +	cdns3_otg_enable_irq(cdns);
>>>> +}
>>>> +
>>>> +/**
>>>> + * cdns3_drd_update_mode - initialize mode of operation
>>>
>>> Looks like this will be called only once. How about calling it
>>>
>>> cdns3_drd_init_mode()?
>>
>> It will be also called after changing dr_mode from debugfs.
>>
>>>> + * @cdns: Pointer to controller context structure
>>>> + *
>>>> + * Returns 0 on success otherwise negative errno
>>>> + */
>>>> +int cdns3_drd_update_mode(struct cdns3 *cdns)
>>>> +{
>>>> +	int ret =3D 0;
>>>> +
>>>> +	switch (cdns->desired_dr_mode) {
>>>
>>> I think we can get rid of desired_dr_mode member in struct cdns.
>>> Just pass the mode as an argument to cdns3_drd_init_mode()
>>
>> This will be used also in patch that introduce debugfs. This filed is al=
so used
>> during changing dr_mode from user space.
>>
>> My intention was:
>> dr_mode - indicated what driver can support, this filed based on dr_mode=
 from device tree,
>> 	     straps bits from otg register and kernel configuration.
>> desired_ dr_mode - the next mode desired by user, changed by debugfs
>> current_dr_mode  - actually selected mode
>>
>
>OK, makes sense. But let's keep this patch simple. Add only the members yo=
u need right now.
>Introduce the new one (desired_dr_mode) in the debugfs patch.

Ok,  I will try to reorganize these two patches.=20
>
>>>
>>> And we already have cdns->dr_mode.
>>>
>>>> +	case USB_DR_MODE_PERIPHERAL:
>>>> +		cdns3_set_mode(cdns, USB_DR_MODE_PERIPHERAL);
>>>> +		break;
>>>> +	case USB_DR_MODE_HOST:
>>>> +		cdns3_set_mode(cdns, USB_DR_MODE_HOST);
>>>> +		break;
>>>> +	case USB_DR_MODE_OTG:
>>>> +		cdns3_init_otg_mode(cdns);
>>>> +		break;
>>>> +	default:
>>>> +		dev_err(cdns->dev, "Unsupported mode of operation %d\n",
>>>> +			cdns->dr_mode);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	return ret;
>>>> +}
>
><snip>
>
>cheers,
>-roger
>
>--
>Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
