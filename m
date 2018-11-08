Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49232C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BF02133D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="dVWZtkpp";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="aybyJVwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03BF02133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeKHVOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 16:14:03 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:39310 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726274AbeKHVOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 16:14:02 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA8BX1ZZ027990;
        Thu, 8 Nov 2018 03:38:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=ROJLj1Wy+fYM5KI2KilD0/HnmnqXas/1apr0JUAHuXU=;
 b=dVWZtkpp4122uHO2uMKxPqXDS4P8PrfXcZMEkooq1C2RupbcfkBRCrP7nnw2JrQZtcgS
 QDMXvAmUTjbUhEEPrrYQyXcb/zQIedzY62mG3AvvokSmedi3kGRZ0F+U1TvpoqDk9sYV
 ReeL4Srk9fdXj7bcVIhMRgt/Rv7AxsNuqcyTMriFWN2jFbOut3NP6/PitIMnIeePFw8R
 EoaRdB7I6/ObVg4MN478LbJIu55o68jOuDmej9r59eXuZ4h/s2Zvij8RUHnOSeh8AEWE
 qlG5uCv2+0SJUZ2ju54WaBgQseynhMB9zJvs4ZnDGoeAb97yZ/CsPLYdd8aLu6n7MV39 rg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp0080.outbound.protection.outlook.com [207.46.163.80])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2nm927jws0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Nov 2018 03:38:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROJLj1Wy+fYM5KI2KilD0/HnmnqXas/1apr0JUAHuXU=;
 b=aybyJVwdMhE85Co4dGnpglTSD6Oej13RBKnfLZ0w2EVZawlNbPaIDamd4B0JWuP5TmqQv/dJmW7E7HqXl1PQZGvaBDAtF8IW/2W3nqdbWNBKtCAVL7h65DzHDMKqTfq4x1GLML4B4OowlPKvHYH1zvWk7nUVHS60Le9O1YeDidM=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5576.namprd07.prod.outlook.com (20.177.231.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Thu, 8 Nov 2018 11:38:23 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8000:536f:b287:710f]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8000:536f:b287:710f%4]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 11:38:23 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [RFC PATCH v1 03/14] usb:cdns3: Driver initialization code.
Thread-Topic: [RFC PATCH v1 03/14] usb:cdns3: Driver initialization code.
Thread-Index: AQHUc534prkwn2EqT025m/zVcx902aVC10+AgALvRqA=
Date:   Thu, 8 Nov 2018 11:38:23 +0000
Message-ID: <BYAPR07MB4709AAC7559CD5D086CD2E74DDC50@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1541267487-3664-1-git-send-email-pawell@cadence.com>
 <1541267487-3664-4-git-send-email-pawell@cadence.com>
 <5BE1A8E3.6000705@ti.com>
In-Reply-To: <5BE1A8E3.6000705@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctY2QxMGU2OTYtZTM0YS0xMWU4LTg3MjUtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGNkMTBlNjk4LWUzNGEtMTFlOC04NzI1LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzMyNSIgdD0iMTMxODYxNTA3MDUyODgzMjE0IiBoPSJzQmhsWE43VWdURC9QbTN6VHozQkNWTjhmanM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5576;20:cTpyxKeP4jVwidMweB0MXbqzcGx1QLyMhWIQcSq4bJPBSLjJvlFYInwzx+9GZJ8ZzSIe9/r+IcfdxJV8r45iRMVC0iK9Tos2+WTC1JPzJC4pLB+YS7LkpS2LBERkGHOdxAlBDrRDxiAwYvhvn+/mW4LJR9VlADLRqZiyBIp+Sr0XnuwljivZ+rKmO90rqYwD9XZPvuv/RRe0/CzTiBR39XoPM9ai9SKgyIvFDm3BTqS00nfYYWm/SmApVd9QgQNI
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(39860400002)(396003)(376002)(36092001)(189003)(199004)(102836004)(68736007)(33656002)(6506007)(81166006)(6436002)(8676002)(26005)(186003)(86362001)(53936002)(2906002)(14444005)(256004)(217873002)(55016002)(6246003)(8936002)(4326008)(71190400001)(71200400001)(3846002)(99286004)(107886003)(6116002)(76176011)(81156014)(7696005)(229853002)(446003)(66066001)(14454004)(2501003)(486006)(106356001)(9686003)(476003)(478600001)(25786009)(105586002)(74316002)(97736004)(11346002)(7736002)(305945005)(316002)(110136005)(54906003)(5660300001)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5576;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 7c0eee1c-7dff-4434-edd4-08d6456eb0a4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5576;
x-ms-traffictypediagnostic: BYAPR07MB5576:
x-microsoft-antispam-prvs: <BYAPR07MB5576FB1EE61EC7D8A9BBC69DDDC50@BYAPR07MB5576.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB5576;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5576;
x-forefront-prvs: 0850800A29
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ymSc/KsyDWF/4aUV7MvAtizqz8JEKS/Iiu/NMXw65Xc4k8YD+m3nXLuyK3vej6wlnEOKMXb4YKhAjq3dlrN6LBQ6BG71Vi3rIXwvd72yvnzZdcJ32bSZ4zattzPUZk5vb9+NnR9/DwpI40r+LzsQsaYoBOi+PWs3JsZImlpnbchEQ3ZmzgFfIvX713yiaOmGa1ou+3//7Bv9xENxB+USm8Rv7+4QD0w0ExUfMS4HJXV3BQQ7DgiHU4aqFtVYNCvyBMrB90R+XSF3EUutxANXAWwgtUwXVE4B60oSfTaNIRCrbfLjMqj+a5flaGwNifkWBiEhWm1K82pvNM1hwTmBg39TNzgW/u8DEYCp5XjJxPU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0eee1c-7dff-4434-edd4-08d6456eb0a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 11:38:23.0821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5576
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 03/11/18 19:51, Pawel Laszczak wrote:
>> Patch adds core.c and core.h file that implements initialization
>> of platform driver and adds function responsible for selecting,
>> switching and running appropriate Device/Host mode.
>>
>> Patch also adds gadget.c, host.c, gadget-export.h, host-export.h.
>> These files contains templates functions used during initialization.
>> The implementation will be added in next patches.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/cdns3/Kconfig         |  20 ++
>>  drivers/usb/cdns3/Makefile        |   4 +
>>  drivers/usb/cdns3/core.c          | 373 ++++++++++++++++++++++++++++++
>>  drivers/usb/cdns3/core.h          |  88 +++++++
>>  drivers/usb/cdns3/gadget-export.h |  27 +++
>>  drivers/usb/cdns3/gadget.c        |  36 +++
>>  drivers/usb/cdns3/host-export.h   |  30 +++
>>  drivers/usb/cdns3/host.c          |  28 +++
>>  8 files changed, 606 insertions(+)
>>  create mode 100644 drivers/usb/cdns3/core.c
>>  create mode 100644 drivers/usb/cdns3/core.h
>>  create mode 100644 drivers/usb/cdns3/gadget-export.h
>>  create mode 100644 drivers/usb/cdns3/gadget.c
>>  create mode 100644 drivers/usb/cdns3/host-export.h
>>  create mode 100644 drivers/usb/cdns3/host.c
>>
>
>
><snip>
>
>> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
>> new file mode 100644
>> index 000000000000..e7159c474308
>> --- /dev/null
>> +++ b/drivers/usb/cdns3/core.h
>> @@ -0,0 +1,88 @@
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
>> +	CDNS3_ROLE_OTG,
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
>
>Why does role driver need hook to irq handler?
>
>Can't each driver host or gadget handle it's respective irq
>on its own? If the same IRQ line is used it could be requested
>as a shared IRQ.

When controller is working as Device then host part of controller is held i=
n reset and=20
vice versa, so driver has restricted access to registers.=20

>> +	const char *name;
>> +};
>> +
>
>cheers,
>-roger
>
>--
>Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

Thanks,
Cheers,
Pawel Laszczak
