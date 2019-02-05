Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BB5C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C4220821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="nBHzcdtZ";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="R95NklJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfBEIdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:33:23 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:59610 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726379AbfBEIdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:33:23 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x158SBJT006931;
        Tue, 5 Feb 2019 00:33:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=BtuV6Pc30/XN879oplR6HlMt4kQ4arw0r+Nk1UNElg8=;
 b=nBHzcdtZ7Y8tE1G6eXM447/QTt9ercaLJgBf5wo8bAaQbD2TstgNlMQ8bpLrDJm+aBDj
 EzxQ1dM1tA2DCHJYXHEf9XcYdiaVxGmuNNIOeGDlkWIFxvXVkzY5pucqr2JBJQYHFeWZ
 bIMb4c4mgY7E04GpDZv8II/nMBp1bQH0CHo12B394TreQlnFnlN5C/1MpoR8lCKISMmQ
 JfGd7+0UPVakf6ptcZ4XjHNBs8xhQpO+QqTny655xNRz/+0mdzRxz07Ur1c/Kxc7YDss
 ZWTlW2grq49zV/0jG/P5cnKD9v/A2rQnR4D906R7JK7oKpocty+deCybigzJcDB4XZ5i uw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2057.outbound.protection.outlook.com [104.47.45.57])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2qd8mwagug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 05 Feb 2019 00:33:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtuV6Pc30/XN879oplR6HlMt4kQ4arw0r+Nk1UNElg8=;
 b=R95NklJDeQLxiidFr1Dpw39B+kJrrJgJG9uHXcJvEl5nCWvfXGzwBec1cPew2zgkrUaQz+9fo6GVESaNgJJUrOFv8xDk4VF5FBUe1G7N27Vv38dC0U8uIhVgwV1fxhVsXlifk8u1l8v19rr9m0mbBQW1rampd+7SFPZZWfco/MI=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5462.namprd07.prod.outlook.com (20.177.229.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Tue, 5 Feb 2019 08:33:04 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::c87c:4924:afa4:733a]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::c87c:4924:afa4:733a%4]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 08:33:04 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v3 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v3 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHUuVvBctF/8kn8o0S04iUewl/ZDKXPjG6AgAFXCcA=
Date:   Tue, 5 Feb 2019 08:33:04 +0000
Message-ID: <BYAPR07MB47097B8DD9A86D9066B35E31DD6E0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1548935553-452-1-git-send-email-pawell@cadence.com>
 <1548935553-452-6-git-send-email-pawell@cadence.com>
 <20190204114841.GD28608@kroah.com>
In-Reply-To: <20190204114841.GD28608@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYTYwNTE2YWQtMjkyMC0xMWU5LTg3MmQtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGE2MDUxNmFlLTI5MjAtMTFlOS04NzJkLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzg2OSIgdD0iMTMxOTM4MjkxODI0NDIzNzk0IiBoPSJZRTRWVlJaNDZ4V0tJNmQ1UFErN3FVU2lWc1k9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5462;20:DwB0ujojYvBu2F7yqnrIt2925cR0fxLC6aQfBDn+2MHQpqT82o5Ew92gx1wjX5EWxkVS6PZCx7k5WSgCVpCxpqGayrpB6R7MEMRgrM4rjhSpkkTx/kTufJ1y75wjN2kwnlc3rUJvxRIt5g/mHFaY9rGOfgc/bHOhyRTSf+F4W22EB9mmyDmpOGigXA+9EqKZd5PGXVinmUh1HP65jEenfcV/RrO2ZEUwl9o9mEA30ggrf8dfbUTeu0byCjUDeBsL
x-ms-office365-filtering-correlation-id: 47fe04cc-cd3d-4c7a-54aa-08d68b448c62
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5462;
x-ms-traffictypediagnostic: BYAPR07MB5462:
x-microsoft-antispam-prvs: <BYAPR07MB5462D73FAA10D5A1D8D7E3EEDD6E0@BYAPR07MB5462.namprd07.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(136003)(366004)(189003)(199004)(36092001)(25786009)(6916009)(105586002)(14454004)(7416002)(6116002)(6246003)(6436002)(86362001)(3846002)(4326008)(71200400001)(71190400001)(486006)(8676002)(106356001)(81156014)(107886003)(316002)(99286004)(81166006)(2906002)(186003)(66066001)(966005)(476003)(26005)(6506007)(14444005)(7736002)(74316002)(305945005)(33656002)(256004)(97736004)(53936002)(54906003)(478600001)(6306002)(9686003)(102836004)(68736007)(11346002)(55016002)(8936002)(7696005)(446003)(76176011)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5462;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HrbPSiEZ98gcPuuHnbEALu/8poZMzZViq0jiZ0Y35Kntvs4n1ARVWjq5SBDJGsgge6OzGwbr4Trh3WwSrpnk3dmyWKoL3LgxcmyMcQbdV2+SvGgqUKWiI1Uzue2tRsYgDbkfVBrV/+bPVFZ16zV70+gCm2NnC8vW4KdALlw3osQDaF57/KWFr4klKi2uACSIsnOsbxXmto/n2xWBHNiYVloRUsiC6ZntuDdtax2Rbn7j+saaBFI2+9d2KvcDGvV1kAJ2Wt1jt8Zc7ALd2jgQ4duJhaB659UUPJQVwvtM0TqggL+3NCj9fVccBj7xte3nv55TLpSXiWqy/kf7DnkCwAbvYnp6fRvaNJrRJFSgO72Qnvce06+uniGUmO72HmH32Cp+JWtbyka6Bilrn1i01YguVBfTWM+Mvrk5dJAeXmE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47fe04cc-cd3d-4c7a-54aa-08d68b448c62
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 08:33:04.8354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5462
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-05_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=998 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902050069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>On Thu, Jan 31, 2019 at 11:52:32AM +0000, Pawel Laszczak wrote:
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
>
>Please line-wrap this properly at 72 columns, like your editor asks you
>to when you run git :)
>
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/Kconfig                |    2 +
>>  drivers/usb/Makefile               |    2 +
>>  drivers/usb/cdns3/Kconfig          |   44 +
>>  drivers/usb/cdns3/Makefile         |   14 +
>>  drivers/usb/cdns3/cdns3-pci-wrap.c |  155 +++
>>  drivers/usb/cdns3/core.c           |  403 ++++++
>>  drivers/usb/cdns3/core.h           |  116 ++
>>  drivers/usb/cdns3/debug.h          |  168 +++
>>  drivers/usb/cdns3/debugfs.c        |  164 +++
>>  drivers/usb/cdns3/drd.c            |  365 +++++
>>  drivers/usb/cdns3/drd.h            |  162 +++
>>  drivers/usb/cdns3/ep0.c            |  907 +++++++++++++
>>  drivers/usb/cdns3/gadget-export.h  |   28 +
>>  drivers/usb/cdns3/gadget.c         | 1985 ++++++++++++++++++++++++++++
>>  drivers/usb/cdns3/gadget.h         | 1207 +++++++++++++++++
>>  drivers/usb/cdns3/host-export.h    |   28 +
>>  drivers/usb/cdns3/host.c           |   72 +
>>  drivers/usb/cdns3/trace.c          |   23 +
>>  drivers/usb/cdns3/trace.h          |  404 ++++++
>>  19 files changed, 6249 insertions(+)
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
>
>This is way too big to try to review all at once.  You need to break
>this up into logical chunks, each one adding a single functionality to
>make it possible to actually review it.
>

In the past driver was split into series of patch, but it was difficult to =
review for other=20
reviewers so I made decision to prepare it in this way.=20
The short discuss you can find on https://lkml.org/lkml/2018/11/30/502.

Quotation: "
>> Frankly, I don't understand why this is a series. It's a single driver a=
nd splitting it into
>> a series just makes it more difficult to review, actually.
>>
>> Sure, a single patch will be large, but there's no way to have a functio=
nal driver until
>> all patches are applied, anyway.
>>
>
>Yes, I agree with Felipe. Pawel, you could remove the "RFC" prefix, and se=
nd the whole
>one as one patch. I will test it at my hardware.

Ok, I will prepare such single patch. =20
Peter I know that you have little different platform.=20
Probably you should made some additional changes for your platform.
"

Thanks

Pawel Laszczak.
