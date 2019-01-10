Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20A2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802F72173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="B4a4pTGr";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="m7X8zIJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfAJHTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:19:09 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:57244 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727331AbfAJHTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:19:08 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0A79O2g009013;
        Wed, 9 Jan 2019 23:18:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=lVbbEa7zPo5wxgcjo513nQsGDqYkbu47brRsXo6fT60=;
 b=B4a4pTGrWvG8Kq5nw8NYikYqPMRxFVjn48DTxtNxHOYEbwog5z87WHcdRmHM1M5A0sZf
 FLDtyvIuPkvYi5QDx1RhLbnSN3xRfMCMUqEXUfEYR74Jn8RppJzKP5SSfOp+s36B8d2D
 1rX1+M1L2NetglwmjHaOB0Qmu6OdLGQgHDCuucV/0bosFEuoaqCOu/DNfMA8MXT2wPfM
 pa0jILBwdVo85KyF8n8Y9q9IkjoicuTEjm1UVFqX4/pWWLBA7+kJtE+j7HKtw3UvG+zP
 X3g5tMXVqoOSvdXeJr8zrLl/HOGhVLT3TVhxRGWXmAmYP5tZLk2lvaOjxga9HN98JRC7 5g== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2054.outbound.protection.outlook.com [104.47.36.54])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2pts227jtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 09 Jan 2019 23:18:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVbbEa7zPo5wxgcjo513nQsGDqYkbu47brRsXo6fT60=;
 b=m7X8zIJb3geIVVU+R+4ACjIgmtCaLQISyyLoWYZh1qSDCwmvrJoy7S1c66zbY+iN3l6HoTZSIlfY1RoW7lEiSpeJmjkmPQUu4+cpVUQLsWdYjStxFtvllXC+R+WoZvQ2E9FgAPVMUsOe/NYKSqTsGWNlMeldra0w9f/FjlZ7jdQ=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5573.namprd07.prod.outlook.com (20.177.231.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 10 Jan 2019 07:18:50 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e97e:1c66:94bc:24ef]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e97e:1c66:94bc:24ef%3]) with mapi id 15.20.1495.011; Thu, 10 Jan 2019
 07:18:50 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <hzpeterchen@gmail.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "adouglas@cadence.com" <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v2 5/5] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v2 5/5] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHUmtItEP31Hrx74EuIb6kD4d3L1KWn0o2AgABbWgCAAADSYA==
Date:   Thu, 10 Jan 2019 07:18:50 +0000
Message-ID: <BYAPR07MB4709A8E20953E24E67A801EADD840@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1545577992-4013-1-git-send-email-pawell@cadence.com>
 <1545577992-4013-6-git-send-email-pawell@cadence.com>
 <CAL411-oF2j1Xjz60Q3B1beBoUoFUxN+rBi9_Z0nx7R2P0p_3tg@mail.gmail.com>
 <20190110065738.GA28817@kroah.com>
In-Reply-To: <20190110065738.GA28817@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZjdmNWUzMWUtMTRhNy0xMWU5LTg3MjktMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGY3ZjVlMzFmLTE0YTctMTFlOS04NzI5LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTM4NyIgdD0iMTMxOTE1NzgzMjc1MDczMjMxIiBoPSI0cHVCNkR4RzZsZzMrQjJuNVNJU21tQi84aEE9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5573;20:8i/6DiFc3Z9PQUomEh9weAV+v3M6rnlGezd5+BWCKvej2qQ6QZzpvAcMk5KnqxQEcXnOkH3p4uJzCcaQrJZqIjk15ba+iHEkMFpGnnjRd5SInuC/bwG5BZOMwwcEnhwIi9U6VRLEqewrHqFjQ3T5GpX7qmN0V7TAQQKpiotRn6KuXJ5C/nnM6dmJTM8qx4Wnl54XAEW/8tBAJIoUrIhL+JpkaOqP0XIAJCAZQpSUTavGkPYZLl7x8Qg64yNbtjSG
x-ms-office365-filtering-correlation-id: d73a4734-71bf-4765-eaf6-08d676cbde72
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5573;
x-ms-traffictypediagnostic: BYAPR07MB5573:
x-microsoft-antispam-prvs: <BYAPR07MB557328B0E52E980F709C30F5DD840@BYAPR07MB5573.namprd07.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(366004)(39860400002)(36092001)(199004)(189003)(66066001)(14454004)(7696005)(106356001)(2906002)(256004)(26005)(476003)(33656002)(14444005)(99286004)(486006)(68736007)(54906003)(305945005)(110136005)(446003)(74316002)(11346002)(186003)(105586002)(53546011)(4326008)(53936002)(25786009)(55016002)(6246003)(102836004)(93886005)(5660300001)(9686003)(7736002)(71190400001)(71200400001)(478600001)(6506007)(76176011)(6116002)(6436002)(316002)(3846002)(8936002)(39060400002)(97736004)(81166006)(7416002)(229853002)(81156014)(86362001)(8676002)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5573;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pVkQFlPsYt3Iss3LvlEqPGapDjJ8uWJ8Uv6zOCd5/63vTXJWQu9DYj6y/M76FQqshXU0sWEFi/+ifufI6TzmElmr4HfEETxdtb2eHz347J6RJv4DsO6wyTwIBP8CNu9dRLWCIQL9Cvx9RFv49ZE3M7/E5w6Qj5M6xu8vuvFk57M3fwk+3yZD7zTbk3jHknlN7xYlbt9VaKeF+Px1H+saNxThygkUxD5NhUteorzNRnz1GQk063ncw7kTQcT42urt2yPOsIGU30LYd4qMjEqcxAVv0b9InKa4REoJf2KCDQWIQaTMPmZ4VQGQtRwEN4lo
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73a4734-71bf-4765-eaf6-08d676cbde72
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 07:18:50.1095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5573
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-10_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901100059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=20

>On Thu, Jan 10, 2019 at 09:30:41AM +0800, Peter Chen wrote:
>> On Mon, Dec 24, 2018 at 12:44 AM Pawel Laszczak <pawell@cadence.com> wro=
te:
>> - debugfs is nice to have feature, I suggest removing it at this
>> initial version. Besides, role switch
>> through /sys is normal feature, the end user may use it at real
>> product, so, it is better at device's
>> /sys entry instead of debugfs.
>>
>> - I don't know why you add "disable" at debugfs, please comment.
>
>As you imply here, no real-world functionality should ever be in
>debugfs as it is an optional system component and kernel code should
>work just fine without it being enabled (as more and more systems are
>disabling it due to the obvious security problems it has.)
>
"disable" it's not required. It's used for testing. It allows to enable/dis=
able the current role.
It can be used for testing eg. connect/disconnect event.=20

I mainly test the driver remotely and I can't do connect/disconnect by USB =
cable.=20
"disable" allow me to get trace log from host/device without disconnecting =
cable:
I'm using the fallowing sequence:
 - load cdns3.ko modules=20
 - echo 1 > disable - disable current role
 - echo cdns3:* tracing/set_event=20
 - echo 0 > disable  - enable role again=20
 - cat tracing/trace.=20

Pawel
