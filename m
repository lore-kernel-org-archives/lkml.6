Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51365C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3F32146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="WYnY5qDB";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="RLbSvbGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfBTG3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 01:29:24 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:48558 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725857AbfBTG3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 01:29:24 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1K6OYav018611;
        Tue, 19 Feb 2019 22:29:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=rnnje4TX5n6c9zYpw5Bp2t8BJ3SePlmhnms6+qD91ew=;
 b=WYnY5qDBKOm9uA9q/sBYILe3SvDC+KKEN2emFqabAW7HGifRCxcaEXMrrh/IH7zBEWFc
 MjjxfXJR4TyhlxcPsMZfZ/pV8uy4RllusN1KI/JSrBolNcSyeABsBmBPy8knPfevSGxv
 LDV8DjaCpvwcn2XA48OzDZy/e3cWYj5sBVU+w9K4CXzhiYo0NgSH8e46QHqMo99FGqG+
 rQpH+QFK4HZ0gktmeZuwCXsl9yl5jT0ib/TpJZXFQisLulvSDukmZ9mC8wzYdh24KTl6
 rokFl8k607oEMWdynj4lzjPepVe1zWzfgzhKUXCy347VyBSky/OYe9TTJD25xfO9ZLC6 Fw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2052.outbound.protection.outlook.com [104.47.40.52])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2qpeyyh3u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Feb 2019 22:29:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnnje4TX5n6c9zYpw5Bp2t8BJ3SePlmhnms6+qD91ew=;
 b=RLbSvbGxpRh9tzNWCACgID43LhUPSXMMufRQXEJ9fj5RuF3Gr/TAenkHLX/TI50U76iESu3sOIKQayfFBFWucgPQq2prjPgCBsvhhd546QMjqOlp/8EjQs9ZH1opeTbT7khkiUtJajQ0NMhqyyJm5UryUhoXCyr1DJZHaqFTDJg=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4341.namprd07.prod.outlook.com (52.135.223.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 06:29:00 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::c87c:4924:afa4:733a]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::c87c:4924:afa4:733a%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 06:29:00 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
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
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v4 2/6] usb:common Separated decoding functions from dwc3
 driver.
Thread-Topic: [PATCH v4 2/6] usb:common Separated decoding functions from dwc3
 driver.
Thread-Index: AQHUxJ4He4b6NYU+cEefdq0LKEwlpaXnILoAgAEV5qA=
Date:   Wed, 20 Feb 2019 06:28:59 +0000
Message-ID: <BYAPR07MB47096562AEB2B07800130D7ADD7D0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1550173514-23573-1-git-send-email-pawell@cadence.com>
 <1550173514-23573-3-git-send-email-pawell@cadence.com>
 <20190219131402.GB20719@kroah.com>
In-Reply-To: <20190219131402.GB20719@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctY2FmNTllY2QtMzRkOC0xMWU5LTg3MmYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGNhZjU5ZWNlLTM0ZDgtMTFlOS04NzJmLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjU2MCIgdD0iMTMxOTUxMTc3MzcxNTYxNTAwIiBoPSJJd3R3K2FweDBwOEJ5VHpRVHB5akdrRlFTS1k9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 434d02ff-add3-40d9-2a58-08d696fcb31b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4341;
x-ms-traffictypediagnostic: BYAPR07MB4341:
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4341;20:HGC4ASGbk4usZkkZzrdBlKwKWU8Fe02/VtGQnYuZeAesvWY6HtvK5OU1XgFSR6oyeH3NdfHC21dAMqnd9nnKukPZcBED92RGCn7RhcO+0iwPZDjL4Z4uvHX5cShpHFwWlf31fRm/UyfszWoFvwiC0uUwAM5TpP4xgUz/xjxojNIhHLHDZ1ctK3N6lxuH5hkfHLwXNrDmerqgmL3jr5PHDaWzMTU4xUed2KXoPypivjeNWyJ60xNkiEskX13pOCkU
x-microsoft-antispam-prvs: <BYAPR07MB434185606BDA3B8C223DBA75DD7D0@BYAPR07MB4341.namprd07.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39850400004)(136003)(376002)(189003)(199004)(36092001)(71200400001)(86362001)(74316002)(102836004)(8676002)(229853002)(478600001)(316002)(54906003)(14454004)(6506007)(53936002)(7736002)(8936002)(81156014)(305945005)(71190400001)(6436002)(66066001)(26005)(76176011)(99286004)(81166006)(68736007)(2906002)(5660300002)(7696005)(186003)(6916009)(55016002)(9686003)(446003)(11346002)(105586002)(476003)(106356001)(97736004)(3846002)(4326008)(256004)(6246003)(7416002)(107886003)(486006)(6116002)(33656002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4341;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Bw9n6Q8plXd8UTdU3KkUXadDpWKsy+zkL/PgqvuYlW0QIAfBRSkVV+99NU4sRi8BzeYasQEW7Qk8035o4xildM7AJKaX49vyMJQLUCKtTUYyy65RvFFe8/XxQygeTedzJbn7scEJSylLY/RcKFA44GGNItX8fLUG//a822CtJQHbswFsRWNr+TxUPp7oxkUcxWxyOcBOZO3UUJxCbVIQDLa6QNaMf3S/tJ5ze7/ojdN8cyzajeDahw4/VIbEQ4g2ulfN4XklFWyeXgrXEsAJ91QfmM2wMJZJXKIt1fHEuQXWYIvwoKhq4jBAVICqKr7nroXbpuy4P8o0MXqTBr54hJIYhCiAeFgySyt8p2BHSrFN+AFpEKGl5MKLtuUUUJfNwNjI6iiFPhudNfeJpno8LCXNdCQD7AfxKpK0xaWlz1I=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434d02ff-add3-40d9-2a58-08d696fcb31b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 06:28:59.8619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4341
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-20_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>On Thu, Feb 14, 2019 at 07:45:10PM +0000, Pawel Laszczak wrote:
>> Patch moves some decoding functions from driver/usb/dwc3/debug.h driver
>> to driver/usb/common/debug.c file. These moved functions include:
>>     dwc3_decode_get_status
>>     dwc3_decode_set_clear_feature
>>     dwc3_decode_set_address
>>     dwc3_decode_get_set_descriptor
>>     dwc3_decode_get_configuration
>>     dwc3_decode_set_configuration
>>     dwc3_decode_get_intf
>>     dwc3_decode_set_intf
>>     dwc3_decode_synch_frame
>>     dwc3_decode_set_sel
>>     dwc3_decode_set_isoch_delay
>>     dwc3_decode_ctrl
>>
>> These functions are used also in inroduced cdns3 driver.
>>
>> All functions prefixes were changed from dwc3 to usb.
>> Also, function's parameters has been extended according to the name
>> of fields in standard SETUP packet.
>> Additionally, patch adds usb_decode_ctrl function to
>> include/linux/usb/ch9.h file.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/common/Makefile |   2 +-
>>  drivers/usb/common/debug.c  | 270 ++++++++++++++++++++++++++++++++++++
>>  drivers/usb/dwc3/debug.h    | 249 ---------------------------------
>>  drivers/usb/dwc3/trace.h    |   2 +-
>>  include/linux/usb/ch9.h     |  25 ++++
>>  5 files changed, 297 insertions(+), 251 deletions(-)
>>  create mode 100644 drivers/usb/common/debug.c
>>
>> diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
>> index fb4d5ef4165c..3d3d2962ea4b 100644
>> --- a/drivers/usb/common/Makefile
>> +++ b/drivers/usb/common/Makefile
>> @@ -4,7 +4,7 @@
>>  #
>>
>>  obj-$(CONFIG_USB_COMMON)	  +=3D usb-common.o
>> -usb-common-y			  +=3D common.o
>> +usb-common-y			  +=3D common.o debug.o
>
>It's nice to have these in a common place, but you just bloated all of
>the USB-enabled systems in the world for the use of 2 odd-ball system
>controllers that almost no one has :)
>
>So, any way to only pull in this file if you actually need these
>functions?
>
Yes, I'm using these functions a lot for debugging. It's only way to check =
what driver does.
We are also going to upstreaming 3.1 controller so there will be a third dr=
iver using them :).=20
 =20
I'm not sure If anyone will use them on host side, so we can consider wheth=
er they should be
in usb/common directory. Maybe usb/gadget will be better place.=20

Felipe, do you have any comments in this topic?  =20

Thanks=20
Pawel

