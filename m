Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5ADFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AD4206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="b4Nw6eSr";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="clXZ3kPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732486AbeLQLwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:52:07 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:33466 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726831AbeLQLwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:52:07 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBHBpgVU003634;
        Mon, 17 Dec 2018 03:51:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=ujMNuP970mi18BpAlE7B8xlPpIDjIEANiMcnxGwK0UM=;
 b=b4Nw6eSro+16wmvYXscjidoPenJNydc0kHxoHTr/21lrYbO6vW79GvzzYKEjSFoGHx1e
 0q1kqUpEXMWwLaLKu312W/ujNg+/n/QDhq6ApLhw4/EOsVB0KWoI5MAIacNPbVry7KN8
 TaW1/vieiIg2ftInEAfqiNb3YEZIVcIS4zwmat3Rnj86AITk4Z8ubHeyrnUrT3/P72WV
 oWkGz9GUangD3xH2M/NoduzZx+C50CXyaJvJ0cmS93l7kaZvYiyr3JZv4v9F/Ev/VVm+
 u8g8Uc30pXIhg5IyvXlli0oB7o9/XU/oiSz/2ROz717RpTLI4F27FOEoX/IhkTVtDis6 AA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2052.outbound.protection.outlook.com [104.47.33.52])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2pdbx6e5dh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 17 Dec 2018 03:51:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujMNuP970mi18BpAlE7B8xlPpIDjIEANiMcnxGwK0UM=;
 b=clXZ3kPeNmbkKjiBnO4hLWvCYCo5U74O+GSWSXaLZDrEcthQCcm5sh8DUIMosplA6YTF9NpioAC7wHRE4cujZ5QQKHMEpywMtn6rtZKfHxM5sJhNiMBQWuXswYqIcBBQqUHjuM6cZRIEPLoYL81D7lGsn5F4xLz6Lprimd+9nMo=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5621.namprd07.prod.outlook.com (20.177.231.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Mon, 17 Dec 2018 11:51:50 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e97e:1c66:94bc:24ef]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e97e:1c66:94bc:24ef%2]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 11:51:50 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Felipe Balbi <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v1 2/2] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v1 2/2] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHUkIWTYw8ZmuofoE+7Ba9cSOLyP6V5dPgAgAAFtpCAATKygIAILIIQ
Date:   Mon, 17 Dec 2018 11:51:50 +0000
Message-ID: <BYAPR07MB47097F1DE4D13CB23763A7C8DDBC0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1544445555-17325-1-git-send-email-pawell@cadence.com>
 <1544445555-17325-3-git-send-email-pawell@cadence.com>
 <87h8fkmfar.fsf@linux.intel.com>
 <BYAPR07MB47095110AF28CC11B4C9E144DDA60@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87a7lbme3m.fsf@linux.intel.com>
In-Reply-To: <87a7lbme3m.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMjM1ZjIxNjEtMDFmMi0xMWU5LTg3MjgtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDIzNWYyMTYyLTAxZjItMTFlOS04NzI4LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTQ3OCIgdD0iMTMxODk1MjExMTA5OTg3Nzc5IiBoPSJGamZnUWRPOW9yeWJONjVkdTZPNTFKa0YxQnM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5621;20:1COAPRZXNHHuwhFjOrLRMd4TyqS1aPxIxDtsJePjau5M5uBkar/6R31BBcCfRocpV6WiKL2CvMslpBWTqgMkcWHYDKxh7owsm2cEVWH5ybUvxDiePkElXvWpEFLerrxAOZYXzSkIL16CCwNT4LhqYbQPveXLom2oZsQtBkGkDVkAuY0TfO/AO1oI28/RfFCJdK7xz3PI+fwyKESVlITm6EmbLtluY+VM8wnHo/GZeWV/SvA6i+ZxOiJAFR2Dfng9
x-ms-office365-filtering-correlation-id: f89ae6dd-438b-4c78-6683-08d664160839
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5621;
x-ms-traffictypediagnostic: BYAPR07MB5621:
x-microsoft-antispam-prvs: <BYAPR07MB5621595FBF605D7B8C7FE725DDBC0@BYAPR07MB5621.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB5621;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5621;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(36092001)(199004)(189003)(256004)(14444005)(316002)(8676002)(7736002)(81156014)(81166006)(6246003)(93886005)(33656002)(14454004)(8936002)(6436002)(102836004)(107886003)(74316002)(2501003)(6116002)(305945005)(5660300001)(106356001)(3846002)(26005)(99286004)(446003)(7696005)(6506007)(476003)(53936002)(11346002)(486006)(55016002)(76176011)(9686003)(66066001)(97736004)(7416002)(2906002)(25786009)(105586002)(68736007)(86362001)(110136005)(54906003)(186003)(71190400001)(478600001)(4326008)(229853002)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5621;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9WiPRfS8zwtVJATmxZ1XH+JjRAp0MaKZV7w3o6fgIDafVwTYQl60K5gVd4I+WJ8aBpQ1RmjKgAU7z2bSOr+ghEEu140Zm5lI9S/Witahf+d1ZypwNmwH9U7Q534TN9cR2isGTU4e+VVIIfVFFmwJ22eDrP3owdZ+BJNncbxCITnuTkROAx4Y/N2JOcnhel3N/aCw5XuPXdLrAAN8Z3bEfm4sGzWd9s4h/foIj98Df14/TodqVKRzW1pk8HKSv/PAXPqokxAOwry4W8I/KfSUc9eakso2yhnqmFZ4ZjhNPJ49XVpyagqa8bqD2wg6XMF4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f89ae6dd-438b-4c78-6683-08d664160839
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 11:51:50.8291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5621
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=728 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812170110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>
>>>> +static irqreturn_t cdns3_device_irq_handler(int irq, void *data)
>>>> +{
>>>> +	struct cdns3_device *priv_dev;
>>>> +	struct cdns3 *cdns =3D data;
>>>> +	irqreturn_t ret =3D IRQ_NONE;
>>>> +	unsigned long flags;
>>>> +	u32 reg;
>>>> +
>>>> +	priv_dev =3D cdns->gadget_dev;
>>>> +	spin_lock_irqsave(&priv_dev->lock, flags);
>>>
>>>you're already running in hardirq context. Why do you need this lock at
>>>all? I would be better to use the hardirq handler to mask your
>>>interrupts, so they don't fire again, then used the top-half (softirq)
>>>handler to actually handle the interrupts.
>>
>> Yes, spin_lock_irqsave is not necessary here.
>>
>> Do you mean replacing devm_request_irq with a request_threaded_irq ?
>> I have single interrupt line shared between  Host, Driver, DRD/OTG.
>> I'm not sure if it will work more efficiently.
>
>The whole idea for running very little in hardirq context is to give the
>scheduler a chance to decide what should run. This is important to
>reduce latency when running with RT patchset applied, for
>example. However, I'll give you that, it's a minor requirement. It's
>just that, to me, it's a small detail that's easy to implement.

I will do it in PATCH v2 or PATCH v3. =20
I need to post next version before 24 of December, so if I can do it
before this date then it will be in PATCH v2.=20

Thanks=20
Pawel

