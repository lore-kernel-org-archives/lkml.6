Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE2FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE92208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="V/HrrPh7";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="B+AeGF/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE92208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbeKZVDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:03:54 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:51138 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726203AbeKZVDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:03:54 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAQA3tJk003708;
        Mon, 26 Nov 2018 02:09:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=x/NlmgziDGuu4typ4yM0So7DuenIif5q7JqlcR/LMWI=;
 b=V/HrrPh7Xco7QAK7L7m0BwD9E5CmWgSKHIMhM8NN+Ny+R6OlWMdExXRERGYgSB4ZwE7N
 1PxDSsX+6ZAMYpH7AlOrkio3C+HFLpafr4L59BlITPvzzO4xK/m2ZeIyhgeYv72/YOlk
 w+Ils+juGrOCC60I/tAsEJeSUqwehOObGbtWkbrajhHHuLJHix8UN7zc4UCNUZQIxB0l
 xFwxwpYuMkNOyfday8BRdiFV/6JxxGcRlqKmSrfsDbPOmAjQ1mvhy5p0fAEjhCwbcwmm
 2j9BpJJNowa4YVmMui/VLkyZzB4xaMNMJbwaAdmmfR62OyN13aX7np7lOtvk2xM5hOdX lQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp0022.outbound.protection.outlook.com [207.46.163.22])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2ny34che1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 26 Nov 2018 02:09:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/NlmgziDGuu4typ4yM0So7DuenIif5q7JqlcR/LMWI=;
 b=B+AeGF/Y6EKy1XiqsB2DsJr+MM4YXCssC/rSfZfFM5k81K0KUaMZ7mQLOx8lAJvQR11w1nJdyHuKVpE0S6PLsGU+F9xaR2KoRj2Otb5DjT2aVMZSiulVVRewMm3Ws8fux+dJz3c2/PFkW59dVCAhRlyunb+6qdwUvI0BQSqYnnA=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5429.namprd07.prod.outlook.com (52.135.241.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Mon, 26 Nov 2018 10:09:49 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644%6]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 10:09:48 +0000
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
Thread-Index: AQHUfycWERNbYpUTLUKmTA3BhMz+TaVdedoAgAQTVDCAADKkAIAABLawgAAVHICAAAEU0A==
Date:   Mon, 26 Nov 2018 10:09:48 +0000
Message-ID: <BYAPR07MB4709DFA347BC883F7F276332DDD70@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-6-git-send-email-pawell@cadence.com>
 <5BF8140C.7000605@ti.com>
 <BYAPR07MB470991EB0AE200B6481AEE35DDD70@BYAPR07MB4709.namprd07.prod.outlook.com>
 <5BFBA9BC.20306@ti.com>
 <BYAPR07MB47092F6F92A344AA76C093C9DDD70@BYAPR07MB4709.namprd07.prod.outlook.com>
 <5BFBBF65.7090204@ti.com>
In-Reply-To: <5BFBBF65.7090204@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNjdlZTQ5ZTQtZjE2My0xMWU4LTg3MjYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDY3ZWU0OWU1LWYxNjMtMTFlOC04NzI2LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNTU2MyIgdD0iMTMxODc3MDA1ODkzOTM4MTQ0IiBoPSJTcGtNSnk3QzNYcFpDWWFVcTBjMU42ZXJBSmc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5429;20:CrSdPYmMWUS2dywHYMn03pKm4HqY1VxNWg58lvOVnc/wQMKubKPzfPt1uJIeP00xwdF4ZInKb1CQzud49PfRsCbNXPFmwVTFaI/nt5xk7nNHTBNZcJVsVoZm0wtYNkIAG+77HXZX4/mkygHND7aCDH5m8kYQek70oPdCY3zM24X/FOKSU4yP+CRPhLBd/nGhu9r9QQuYX5u+mYh/h945BS5G1uEE4ZA0Xhv6Rz4wO3M3NiRfbBs8N7I4dJb/AG2V
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(136003)(39850400004)(366004)(376002)(396003)(36092001)(189003)(199004)(99286004)(76176011)(106356001)(186003)(4326008)(9686003)(7696005)(55016002)(6246003)(53546011)(6506007)(102836004)(2906002)(6116002)(3846002)(107886003)(81166006)(8936002)(26005)(5660300001)(53936002)(74316002)(486006)(97736004)(14454004)(105586002)(305945005)(7736002)(33656002)(446003)(11346002)(93886005)(2501003)(54906003)(66066001)(256004)(14444005)(217873002)(86362001)(110136005)(71200400001)(316002)(6436002)(71190400001)(478600001)(229853002)(81156014)(25786009)(8676002)(68736007)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5429;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: b2a5426f-915d-4762-08a5-08d653874c2d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5429;
x-ms-traffictypediagnostic: BYAPR07MB5429:
x-microsoft-antispam-prvs: <BYAPR07MB5429642604BF0FF97495A2EDDDD70@BYAPR07MB5429.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231443)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB5429;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5429;
x-forefront-prvs: 086831DFB4
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Qb855asXAWiwuCgS30zPKMc2gAnGcBwS8gBom89jcwlpmdgc1izHx5hnYi4HB3vI9mZYWD1IbD12sLryYtN2VF8Fv8OPOw7exOGBtHqlTvYZIuUpcFdpoy1BlUL822M4sb+l9S/OKJo0fOvo3l4eIoaorcdBSmrgpgF81mE+g+8gwIxnhEBY71wh8xsxQGCFA8SxEij/AnKIiNYMLfRx+nNuiATbbXSt6/W1AYCAO+gu4Dm4BThu+7IDwlOiF3O9lsooeSf3R4OazPbpyEdOeZ9G+39IirIk8jApbokV4OWzPAiOXSaPlQBQp//GVoQkji90lzyBKSXXOCt8gsVFQ2qOeVn1/D+xRmACMZ2bw3k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a5426f-915d-4762-08a5-08d653874c2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 10:09:48.2523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5429
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811260094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>
>>> Pawel,
>>>
>>> On 26/11/18 09:23, Pawel Laszczak wrote:
>>>> Hi Roger,
>>>>
>>>>> On 18/11/18 12:09, Pawel Laszczak wrote:
>>>>>> Patch adds supports for detecting Host/Device mode.
>>>>>> Controller has additional OTG register that allow
>>>>>> implement even whole OTG functionality.
>>>>>> At this moment patch adds support only for detecting
>>>>>> the appropriate mode based on strap pins and ID pin.
>>>>>>
>>>>>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>>>>>> ---
>>>>>>  drivers/usb/cdns3/Makefile |   2 +-
>>>>>>  drivers/usb/cdns3/core.c   |  27 +++--
>>>>>>  drivers/usb/cdns3/drd.c    | 229 ++++++++++++++++++++++++++++++++++=
+++
>>>>>>  drivers/usb/cdns3/drd.h    | 122 ++++++++++++++++++++
>>>>>>  4 files changed, 372 insertions(+), 8 deletions(-)
>>>>>>  create mode 100644 drivers/usb/cdns3/drd.c
>>>>>>  create mode 100644 drivers/usb/cdns3/drd.h
>>>>>>
>>>>>> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
>>>>>> index 02d25b23c5d3..e779b2a2f8eb 100644
>>>>>> --- a/drivers/usb/cdns3/Makefile
>>>>>> +++ b/drivers/usb/cdns3/Makefile
>>>>>> @@ -1,5 +1,5 @@
>>>>>>  obj-$(CONFIG_USB_CDNS3)			+=3D cdns3.o
>>>>>>  obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+=3D cdns3-pci.o
>>>>>>
>>>>>> -cdns3-y					:=3D core.o
>>>>>> +cdns3-y					:=3D core.o drd.o
>>>>>>  cdns3-pci-y		 		:=3D cdns3-pci-wrap.o
>>>>>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>>>>>> index f9055d4da67f..dbee4325da7f 100644
>>>>>> --- a/drivers/usb/cdns3/core.c
>>>>>> +++ b/drivers/usb/cdns3/core.c
>>>>>> @@ -17,6 +17,7 @@
>>>>>>
>>>>>>  #include "gadget.h"
>>>>>>  #include "core.h"
>>>>>> +#include "drd.h"
>>>>>>
>>>>>>  static inline struct cdns3_role_driver *cdns3_get_current_role_driv=
er(struct cdns3 *cdns)
>>>>>>  {
>>>>>> @@ -57,8 +58,10 @@ static inline void cdns3_role_stop(struct cdns3 *=
cdns)
>>>>>>  static enum cdns3_roles cdns3_get_role(struct cdns3 *cdns)
>>>>>>  {
>>>>>>  	if (cdns->roles[CDNS3_ROLE_HOST] && cdns->roles[CDNS3_ROLE_GADGET]=
) {
>>>>>> -		//TODO: implements selecting device/host mode
>>>>>> -		return CDNS3_ROLE_HOST;
>>>>>> +		if (cdns3_is_host(cdns))
>>>>>> +			return CDNS3_ROLE_HOST;
>>>>>> +		if (cdns3_is_device(cdns))
>>>>>> +			return CDNS3_ROLE_GADGET;
>>>>>>  	}
>>>>>>  	return cdns->roles[CDNS3_ROLE_HOST]
>>>>>>  		? CDNS3_ROLE_HOST
>>>>>> @@ -124,6 +127,12 @@ static irqreturn_t cdns3_irq(int irq, void *dat=
a)
>>>>>>  	struct cdns3 *cdns =3D data;
>>>>>>  	irqreturn_t ret =3D IRQ_NONE;
>>>>>>
>>>>>> +	if (cdns->dr_mode =3D=3D USB_DR_MODE_OTG) {
>>>>>> +		ret =3D cdns3_drd_irq(cdns);
>>>>>> +		if (ret =3D=3D IRQ_HANDLED)
>>>>>> +			return ret;
>>>>>> +	}
>>>>>
>>>>> The kernel's shared IRQ model takes care of sharing the same interrup=
t
>>>>> between different devices and their drivers. You don't need to manual=
ly
>>>>> handle it here. Just let all 3 drivers do a request_irq() and have
>>>>> handlers check if the IRQ was theirs or not and return IRQ_HANDLED or
>>>>> IRQ_NONE accordingly.
>>>>>
>>>>> Looks like you can do away with irq member of the role driver struct.
>>>>
>>>> Ok, I will split it into 3 separate part, but in this case, I addition=
ally have to check the current
>>>> role in ISR function. Driver can't read host side registers when contr=
oller works in device role
>>>> and vice versa. One part of controller is kept in reset. Only DRD regi=
sters are common and are all accessible.
>>>>
>>>
>>> In which ISR do you need to check current role?
>>>
>>> I'm not sure if we are on the same page.
>>> Core (drd) driver shouldn't read host/device side registers. All 3 driv=
ers,
>>> i.e. DRD(core), Host (xhci) and device (cdns3) should do a request_irq(=
)
>>> and process their respective IRQ events.
>>
>> Yes, I understand.
>> I need to check this in cdns3_irq_handler_thread and cdns3_host_irq.
>>
>> Core (drd) has register that are always accessible.
>> Core (device)  - registers are available also in device mode
>> Core (host)  - registers  are available only in host mode
>>
>> So we can use separate request_irq  for drd, device and host side, but
>> we need ensure that in host side driver will not touch the device regist=
er.
>
>That should never happen as host side doesn't have visibility to device re=
gisters.

I meant the following scenario:
Assume that controller work in Device role and it raise interrupt for Devic=
e part.=20
Now host is kept in reset.=20
1. System receive interrupt=20
2.  Kernel call drd_irq but this function return IRQ_NONE
3.  Kernel call cdns3_host_irq and driver has to read some interrupt regist=
er to check if=20
     this event is addressed to him. In this moment we can have unknown beh=
avior.=20
4.  Kernel call cdns3_irq_handler  (device). This point probably will not h=
appen because=20
    It could have stuck at point 3.=20

Ok, I think I understood. After changing role, the driver unregisters the i=
nterrupt function
used by previous role so point 3 never happen.=20

I will try to check how it works. =20

>>
>> We doesn't know the order in which  the system will call interrupts func=
tion related to
>>  the shared interrupt line.
>
>Order shouldn't matter. Each user will check its own events return IRQ_NON=
E if they
>didn't cause the IRQ.
>>
>
><snip>
>
>cheers,
>-roger
>
>--
>Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

Thanks,=20
Cheers,
Pawel
