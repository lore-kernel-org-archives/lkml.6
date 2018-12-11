Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10FAC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC5E2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ORBYX6Hr";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="EA2QmgLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC5E2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeLKKBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:01:12 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:59398 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726170AbeLKKBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:01:11 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBB9xOYn018307;
        Tue, 11 Dec 2018 02:01:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=+pV5cku6CGGivSL36dJivnerrPTzhAjgy8pt/2qtoX0=;
 b=ORBYX6HrRaWxeffHGMb7qvDngIiC48fvvW1CVqLw1N3W46f0X8FxPowz7UhA1aCfGB/t
 jVrvXG+DAFwApBugA5r1lJWufnR0GMCAcesyzKXtzvD9QS+EOA15YRBR0Wv5f/YdBNGq
 xcBA7RgjWVsPCxTIuvKnr7PmyT8KZfNaG6z5wISlvnwlmEO5vk+AYewz998TfjNnx65V
 tFD6Gc4cwCtTn0mKC0+c90vcNhgwo+4JzopF+93jePhF77L1kwCDtjp1CA8WB4Opnnv2
 n/poajx2oDOc3CInCGq+adYy3dm5X6tU8sQUkbNLtq57qALIc2QxsoJdyEjXhAAtN0iO 7A== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2056.outbound.protection.outlook.com [104.47.50.56])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2p9wg8bmvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 11 Dec 2018 02:01:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pV5cku6CGGivSL36dJivnerrPTzhAjgy8pt/2qtoX0=;
 b=EA2QmgLm8Pc+dFxyGLQChRO+Nz1mYXqdBCbeRISNIj92k1LpztwR4tWZfCl/RfCUQb2QcLVgHRd2lTBSSFBKzRpVjn7VHJqdtOitMV+en2AvXHJ5kekWnP6K1I2CJ4bnd4E2h8uYDqbLlUPPCb0CYW9jDL9sBoXbI2qzDcw+tBo=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4150.namprd07.prod.outlook.com (52.135.222.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Tue, 11 Dec 2018 10:01:02 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644%6]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 10:01:02 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v1 2/2] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v1 2/2] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHUkIWTYw8ZmuofoE+7Ba9cSOLyP6V5Sd4AgAAEMBA=
Date:   Tue, 11 Dec 2018 10:01:02 +0000
Message-ID: <BYAPR07MB47095A5EEBC106EE7CD0E078DDA60@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1544445555-17325-1-git-send-email-pawell@cadence.com>
 <1544445555-17325-3-git-send-email-pawell@cadence.com>
 <5C0F85E4.10609@ti.com>
In-Reply-To: <5C0F85E4.10609@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYWEyYzRlZGItZmQyYi0xMWU4LTg3MjctMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGFhMmM0ZWRjLWZkMmItMTFlOC04NzI3LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzQ5NSIgdD0iMTMxODg5OTYwNjI2NTMyODEyIiBoPSJlUi9ib3BjQjA4TzlCM2I3UkJYTHJoRkltSk09IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4150;20:bbEwdJLwwYJwe/i1oTtEx7TDxdeFVen460un/pM5lriy0O3RFrUoCGPI5+j4xdOq+wolKL1flFeSO51x/haQSIF3rF1MJiKvEih7BmBmdlL9/6PyYPLN2lPbXNw6wxUoGhnxF4Xj60W0mwh2iNs/Bbm5lnmJmBHy47sp0yeAiKK3FIcRWiCxPMyk8juhx/9DKbaAJ2ScTlKCYNB1TMXxSat3qjRDqkhu9rkFp/NPP+zum4wsMZhTkG0rbCumOV8Z
x-ms-office365-filtering-correlation-id: c26ddfe2-8cdf-4e22-345f-08d65f4f8ef7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4150;
x-ms-traffictypediagnostic: BYAPR07MB4150:
x-microsoft-antispam-prvs: <BYAPR07MB41505D47BFA59C38F01804EADDA60@BYAPR07MB4150.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3231472)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4150;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4150;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(376002)(396003)(39860400002)(199004)(189003)(36092001)(8676002)(7736002)(8936002)(81166006)(305945005)(66066001)(186003)(25786009)(68736007)(81156014)(7696005)(316002)(33656002)(71200400001)(71190400001)(86362001)(26005)(2906002)(478600001)(6506007)(76176011)(97736004)(110136005)(3846002)(102836004)(6116002)(54906003)(107886003)(5660300001)(106356001)(105586002)(11346002)(446003)(7416002)(55016002)(256004)(486006)(4326008)(476003)(6246003)(9686003)(53936002)(74316002)(14454004)(229853002)(14444005)(6436002)(2501003)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4150;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FKj8VcAloXPHARAXvzzQSxQIqyNksrUN3MOLsZLfIMzKO0SJPqycJNr5qRoa4J1dEjKlTuYovpU+mPFPwcfHt9d2fy19DBJUHlxk8ffqWfd1hHQDbNEiTT6etuxAdamQtp4bfFyCOnUDi91A8u7UIPsPW9Yhchp73d797rlmwogPc0ZbIaJ3+inYVe0a3kazeWF+qGxhTdIJl5EZaz1oazeqHwnQe4uoQMxeXpI9uxwWQVYU2ErN7CN+NK61yLjV7kmpUMgGhNF7QhBDQ4tILXMA3Rjw43it2dByL9hNwm7/maGXVOTmcX13DGZqC69g
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c26ddfe2-8cdf-4e22-345f-08d65f4f8ef7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 10:01:02.3133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4150
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812110094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>On 10/12/18 14:39, Pawel Laszczak wrote:
>> This patch introduce new Cadence USBSS DRD driver
>> to linux kernel.
>>
>> The Cadence USBSS DRD Driver is a highly
>> configurable IP Core which can be
>> instantiated as Dual-Role Device (DRD),
>> Peripheral Only and Host Only (XHCI)
>> configurations.
>>
>> The current driver has been validated with
>> FPGA burned. We have support for PCIe
>> bus, which is used on FPGA prototyping.
>>
>> The host side of USBSS-DRD controller is compliance
>> with XHCI specification, so it works with
>> standard XHCI linux driver.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/Kconfig                |    2 +
>>  drivers/usb/Makefile               |    2 +
>>  drivers/usb/cdns3/Kconfig          |   44 +
>>  drivers/usb/cdns3/Makefile         |   16 +
>>  drivers/usb/cdns3/cdns3-pci-wrap.c |  157 +++
>>  drivers/usb/cdns3/core.c           |  451 +++++++
>>  drivers/usb/cdns3/core.h           |  108 ++
>>  drivers/usb/cdns3/debug.h          |  346 ++++++
>>  drivers/usb/cdns3/debugfs.c        |  168 +++
>>  drivers/usb/cdns3/drd.c            |  315 +++++
>>  drivers/usb/cdns3/drd.h            |  129 ++
>>  drivers/usb/cdns3/ep0.c            |  864 +++++++++++++
>>  drivers/usb/cdns3/gadget-export.h  |   28 +
>>  drivers/usb/cdns3/gadget.c         | 1802 ++++++++++++++++++++++++++++
>>  drivers/usb/cdns3/gadget.h         | 1177 ++++++++++++++++++
>>  drivers/usb/cdns3/host-export.h    |   28 +
>>  drivers/usb/cdns3/host.c           |   74 ++
>>  drivers/usb/cdns3/trace.c          |   11 +
>>  drivers/usb/cdns3/trace.h          |  343 ++++++
>
>You went to the other extreme of combining everything (host/gadget/drd) to=
gether
>which again makes this very hard to review.
>
>I think what Felipe meant was to only combine the gadget driver code into =
one patch.
>
>The series could be split into 6 patches like so.
>-dt binding
>-pci glue
>-core driver
>-host driver
>-gadget driver
>-drd driver

Felipe wrote:
"=20
Frankly, I don't understand why this is a series. It's a single driver
and splitting it into a series just makes it more difficult to review,
actually.

Sure, a single patch will be large, but there's no way to have a
functional driver until all patches are applied, anyway.
"

Felipe should I split this driver as suggested by Roger ?.=20
Now it's very big patch but it's still a single driver.


>>  19 files changed, 6065 insertions(+)
>>  create mode 100644 drivers/usb/cdns3/Kconfig
>>  create mode 100644 drivers/usb/cdns3/Makefile
>>  create mode 100644 drivers/usb/cdns3/cdns3-pci-wrap.c
>>  create mode 100644 drivers/usb/cdns3/core.c
>>  create mode 100644 drivers/usb/cdns3/core.h
>>  create mode 100644 drivers/usb/cdns3/debug.h
>>  create mode 100644 drivers/usb/cdns3/debugfs.c
>>  create mode 100644 drivers/usb/cdns3/drd.c
>>  create mode 100644 drivers/usb/cdns3/drd.h
>>  create mode 100644 drivers/usb/cdns3/ep0.c
>>  create mode 100644 drivers/usb/cdns3/gadget-export.h
>>  create mode 100644 drivers/usb/cdns3/gadget.c
>>  create mode 100644 drivers/usb/cdns3/gadget.h
>>  create mode 100644 drivers/usb/cdns3/host-export.h
>>  create mode 100644 drivers/usb/cdns3/host.c
>>  create mode 100644 drivers/usb/cdns3/trace.c
>>  create mode 100644 drivers/usb/cdns3/trace.h
>>
><snip>
>
Cheers=20
Pawel
