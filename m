Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78332C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 22:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3481F21934
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 22:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="KxxURWRH";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="a3mEom6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392839AbeLVWY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 17:24:57 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:48638 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390303AbeLVWY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 17:24:56 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBMMOj5F013365;
        Sat, 22 Dec 2018 14:24:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=eQNGmEwPgLNSOL527R5NiqYFCbK5Ogq+Fmiw9L9igVY=;
 b=KxxURWRHSsjkhwlUU9zgOJ+BEUPIQic3GTGtNjuyCcKkhz9Bb7WQvHVdq7A1J31DOaIj
 OGuNs77ygfN8yyULA5LV8A449uywaS+oWFIB0V1gRLdK6YNWjBDkWyfKLN6J9DdgAKqV
 Qk/0lom3nQH3HVT5w3Lm+k+rIUV4rGtVfh2Qp8Mv3pov8sNZyYcSLCGj7pgH16fgvEsX
 SSvgxSLmqIntpSInrF4LKUF1dC3S/d0JWOPx0xuQ2QzD8JvsdQzgUtpgvYVPPpsd2NDX
 0Bm7MXqObJNEhnegEdOm9AZQc0gV4y4eD+8BbMJkGmrN/ect04WO6jS7NUj9vg8nhnyJ EQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2057.outbound.protection.outlook.com [104.47.33.57])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2phjq1jgn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 22 Dec 2018 14:24:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQNGmEwPgLNSOL527R5NiqYFCbK5Ogq+Fmiw9L9igVY=;
 b=a3mEom6nRNqxkqNQssILimOtH5FNvxa2AmVEaTJD+KDTzUm63kAtklGouN9CA/zwNXnHFf7hiv4HN/trXkrEcidoNtR4EvgtvELodV9W1KNCjyfQPf/5IZfbJGw5dnVV0BhqaQZFft0Tum9o8kARk1+vqRBgntVh5ta5iZlikjw=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB6246.namprd07.prod.outlook.com (20.179.63.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.20; Sat, 22 Dec 2018 22:24:42 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e97e:1c66:94bc:24ef]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e97e:1c66:94bc:24ef%3]) with mapi id 15.20.1446.022; Sat, 22 Dec 2018
 22:24:42 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Rob Herring <robh@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v1 1/2] dt-bindings: add binding for USBSS-DRD controller.
Thread-Topic: [PATCH v1 1/2] dt-bindings: add binding for USBSS-DRD
 controller.
Thread-Index: AQHUkIWR9ZZRuTwCZUuVYkxzeBHYYqWIHHaAgANGl2A=
Date:   Sat, 22 Dec 2018 22:24:42 +0000
Message-ID: <BYAPR07MB4709910A6EE4B54BA455E713DDB90@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1544445555-17325-1-git-send-email-pawell@cadence.com>
 <1544445555-17325-2-git-send-email-pawell@cadence.com>
 <20181220200111.GA27998@bogus>
In-Reply-To: <20181220200111.GA27998@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNWUxYTM4YTAtMDYzOC0xMWU5LTg3MjgtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDVlMWEzOGEyLTA2MzgtMTFlOS04NzI4LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjk4NyIgdD0iMTMxODk5OTEwNzg5Njk1MTcxIiBoPSJlbEowYm04NFU3YlVpa3lrd1lCY0V5aVd5cUE9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB6246;20:j3rzQYR3iIjBcfeBBAVtyAuy8z7/cN2YAFhNyHSDNxTm9bSv3Z/msPdO3hfLnoYj3HiM7m2dmfy/TucE5pTsJyQTFcM4CMZOlcqD1B1DkSKdtc4m6gCsD8Nm7QSeRnXQOb/jPPI/hO47ATpVZyg0Pf15IyXW22znK9Ivxa8CSfh48h9TWXGY4Olu5ovcp/u7GclND7XrNqiH028Ax/pTJz9DpHnKwCAS5GM6CQUwNfmvw3q2iMp6IUoVxsZBvbbo
x-ms-office365-filtering-correlation-id: 74a49b44-e5d5-4214-802b-08d6685c454c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB6246;
x-ms-traffictypediagnostic: BYAPR07MB6246:
x-microsoft-antispam-prvs: <BYAPR07MB6246A92B9D5E53ABE2692682DDB90@BYAPR07MB6246.namprd07.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(10201501046)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB6246;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB6246;
x-forefront-prvs: 089473E5FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(136003)(366004)(346002)(51444003)(36092001)(189003)(199004)(9686003)(5660300001)(55016002)(99286004)(186003)(107886003)(478600001)(26005)(53936002)(316002)(54906003)(4326008)(25786009)(102836004)(14454004)(6506007)(256004)(7696005)(76176011)(6246003)(74316002)(11346002)(446003)(476003)(7416002)(486006)(68736007)(86362001)(575784001)(97736004)(33656002)(229853002)(66066001)(106356001)(8936002)(81166006)(6436002)(2906002)(3846002)(6916009)(8676002)(105586002)(7736002)(6116002)(71200400001)(71190400001)(305945005)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB6246;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qyU7QuS0r+9DDyewmUQRgKUJiFCSMEjWm6VhTbk/hLReo5Je3VWxVLu0cPJnX2ZeJmb8RlPql1YhoBbwsNpsoVsUllVdIOsjWk9XSqPVC+QYXe9kigzHd1tlq4rcEvIo2jj48fHeBkaqgyZRVxCb2OxhUl7sCA33SzxTBMWUe/Rq1JXaMlpADvBycmttC3+jtO5fj0VvIoaCTde6SJiIEfxJzp1D4ZQl9KpwL79et2EbWKZeHtkgLo7gMyzbr5zETNKnRG1p2OKL9CQUv6JjLixaVoMbC4DHHH0YiYxngTOI/g2AVjqzLvngOEXEm1cS
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a49b44-e5d5-4214-802b-08d6685c454c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2018 22:24:42.5963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6246
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-22_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812220203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

>On Mon, Dec 10, 2018 at 12:39:14PM +0000, Pawel Laszczak wrote:
>> This patch aim at documenting USB related dt-bindings for the
>> Cadence USBSS-DRD controller.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  .../devicetree/bindings/usb/cdns3-usb.txt     | 31 +++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/usb/cdns3-usb.txt
>>
>> diff --git a/Documentation/devicetree/bindings/usb/cdns3-usb.txt b/Docum=
entation/devicetree/bindings/usb/cdns3-usb.txt
>> new file mode 100644
>> index 000000000000..ae4a255f0b10
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/cdns3-usb.txt
>
>cdns-usb3.txt?

In all functions we use prefix cdns3, so it was a reason for cdns3-usb.txt.
I agree  with you and I think that cdns-usb3.txt in this place will be bett=
er.
3 in cdns3  could be associated with  company name, but that's not true.=20

>
>> @@ -0,0 +1,31 @@
>> +Binding for the Cadence USBSS-DRD controller
>> +
>> +Required properties:
>> +  - reg: Physical base address and size of the controller's register ar=
eas.
>> +	 Controller has 3 different regions:
>> +	 region 1 - HOST registers area
>> +	 region 2 - DEVICE registers area
>> +	 region 3 - OTG/DRD registers area
>> +  - compatible: Should contain: "cdns,usb3"
>
>Only 1 version of the IP block?

I will add one more. Now I know that we should have=20
at least one additional version.=20
Controller version will be recognized at runtime, but in my opinion=20
we should also  have information  about this in dt-binding documentation.=20
>
>> +  - interrupts: Interrupt specifier. Refer to interrupt bindings.
>> +		Driver supports only single interrupt line.
>> +                This single interrupt is shared between Device,
>> +		host and OTG/DRD part of driver.
>> +
>> +Optional propertiesi:
>
>typo
Thank, I know that already. Someone has already reported me this typo.=20
"i" - insert mode in vim :)
>
>> + - maximum-speed : valid arguments are "super-speed", "high-speed" and
>> +                   "full-speed"; refer to usb/generic.txt
>> + - dr_mode: Should be one of "host", "peripheral" or "otg".
>> + - phys: reference to the USB PHY
>> + - phy-names: name of the USB PHY, should be "cdns3,usbphy"
>
>Don't need -names when there is only one.

But in the future probably we will need to add next phy version.
So maybe it's better to leave this name ?

>
>> +
>> +
>> +Example:
>> +	usb@f3000000 {
>> +		compatible =3D "cdns,usb3";
>> +		interrupts =3D <USB_IRQ  7 IRQ_TYPE_LEVEL_HIGH>;
>> +		reg =3D <0xf3000000 0x10000	//memory area for HOST registers
>> +			0xf3010000 0x10000	//memory area for DEVICE registers
>> +			0xf3020000 0x10000>;	//memory area for OTG/DRD registers
>> +	};
>> +
>> --
>> 2.17.1
>>

Thanks for comments=20
Cheers,
Pawel
