Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D87C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13FB222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="YSr77eGp";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="P5y6eJUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405628AbfBNGJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 01:09:05 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:58186 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726407AbfBNGJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 01:09:04 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1E644Ql023499;
        Wed, 13 Feb 2019 22:08:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=aRO6RhAjnT7+bkDa99XLRAcx0NoDMRnqtXJsv7GKziU=;
 b=YSr77eGpAnZAWS3aIrGTmAsjo3NnXOj3DAVxzJHU7LMdr2TQnyG2+AQzsvgNPdg+WPGo
 5wN9Rkywcze/vUsobZ/xrDwQ16j9tgkfy+/2cDYS25qEtNW5NM/s8yGZW/P6LALAWmP6
 DzyQhDeoCvCuWkH6M6kI3hCCUls4iVDXL8/OUsKSWjdrDnNx3qsnvkb6QGXGJFxdrMUF
 Iq6/GUtaRnYuFIIoUIM7Cd3Cy4/YMg0G2KSipY0LcyytDalrK14b4J00AnXIf9+qC1+H
 I7P0+iRvxaxF+GtfCJvUQxOK37Js8eCknvBBpNXlaHgnWTAfUaoMqHCoU5uxVToY/XcL RA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2050.outbound.protection.outlook.com [104.47.48.50])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2qmveqhb25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 13 Feb 2019 22:08:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRO6RhAjnT7+bkDa99XLRAcx0NoDMRnqtXJsv7GKziU=;
 b=P5y6eJUhIbK8TGTVgLDe/oZMDTH6UbEUYyY2NidssQnGYrNisfcBboUlB3DrNbczlO+ZQI0c9Eipjz8mjKFLXKrP5E94dDTcS0/XJaLzdFsSqUlOnoP2LrChjRktdag6WsFg/oBDcJ8LjKUJdXx7cr5tfrPt4DKZtbf0EH0QyW8=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB6327.namprd07.prod.outlook.com (20.179.88.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 14 Feb 2019 06:08:45 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::c87c:4924:afa4:733a]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::c87c:4924:afa4:733a%5]) with mapi id 15.20.1622.018; Thu, 14 Feb 2019
 06:08:45 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Rob Herring <robh@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v3 1/6] dt-bindings: add binding for USBSS-DRD controller.
Thread-Topic: [PATCH v3 1/6] dt-bindings: add binding for USBSS-DRD
 controller.
Thread-Index: AQHUuVumh/iv/3g2hEy+OcA5M2gRSqXeadCAgAB1ADA=
Date:   Thu, 14 Feb 2019 06:08:45 +0000
Message-ID: <BYAPR07MB4709EA63F1374EA24E23C186DD670@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1548935553-452-1-git-send-email-pawell@cadence.com>
 <1548935553-452-2-git-send-email-pawell@cadence.com>
 <20190213224841.GA9319@bogus>
In-Reply-To: <20190213224841.GA9319@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZjczMDBhZTQtMzAxZS0xMWU5LTg3MmUtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGY3MzAwYWU1LTMwMWUtMTFlOS04NzJlLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjg3MCIgdD0iMTMxOTQ1OTgxMjA2NDUzNjA2IiBoPSJwdGdNYzZtTnQwV1VRZGFqUWZrRlRraWxwM1k9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6bd87dc-5a47-4c8a-5eeb-08d69242e0a0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB6327;
x-ms-traffictypediagnostic: BYAPR07MB6327:
x-microsoft-exchange-diagnostics: 1;BYAPR07MB6327;20:x3T14XnbH7btkOvuOyQmJvcxJhrEhK4v1l5WjC8BrhknT3BOrpwNskLnEFnl0Gk1jhR9Wb91F8ojeAksEeX5mIgaLOXCd1WyrPHFjlfoQsDEZEnNAbGVA9BYBm+a/JXpkFELJSJsmCqDAd2sPObdkttIxRn3+gPLZ2OAnpuiaToKtvYRsmeH7TKgaIvT5zkzYrhI3NpqGP4uCXuRMKFyd9ZGSBCY62DeLJAZ/nPx4ksjIMgC/YFQlmS88yzYcMuH
x-microsoft-antispam-prvs: <BYAPR07MB6327E8526780A9046CFD9783DD670@BYAPR07MB6327.namprd07.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39860400002)(376002)(346002)(36092001)(199004)(189003)(4326008)(71200400001)(97736004)(256004)(476003)(71190400001)(486006)(11346002)(107886003)(106356001)(6246003)(102836004)(6506007)(33656002)(25786009)(446003)(2906002)(105586002)(186003)(26005)(53936002)(478600001)(74316002)(55016002)(76176011)(9686003)(14454004)(305945005)(229853002)(316002)(86362001)(7736002)(6116002)(6916009)(6436002)(99286004)(7416002)(7696005)(54906003)(68736007)(8676002)(8936002)(81156014)(81166006)(3846002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB6327;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pwkvPgenwgsMnveWtBWZ+pErfQ2ReY2V/G02qTkYB+KbLEhsGjS5AfdC1fvT3FvXA7hFpR/kXpimxkEZcq6Q5Q6Oahs1rHVKsovnvkiKuaLrwxNKh42wAI10mScwGhWj7M2pUQCci52iIZD0ncJ5Dx7Z2IHl6JjDaLPWSZ6cgwq3h2rG+sRB6jig6IrxjpDAOtmqQ1wQuunUKFj/FIbSg0/mGnM2sEaIEFwvek1r6+vWJsI8WCjAUssZS7cX0NKa7JvfcTxc/D/4KCOMOyev3GDHCiRWJi33Ellup8t+kjcHudHOKZNt39W3kk0dnY4BerjyMFLnmZwnXbMeKd2iVM7a3175KP9+CwwwmNDHWr0uvjN9dD4AFANG2rImFuW+gL5i0JXy4SJ/pN5ZzhRvz4msTHUfnwBKWalSvkxJZpU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bd87dc-5a47-4c8a-5eeb-08d69242e0a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 06:08:45.1825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6327
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902140045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
>On Thu, Jan 31, 2019 at 11:52:28AM +0000, Pawel Laszczak wrote:
>> This patch aim at documenting USB related dt-bindings for the
>> Cadence USBSS-DRD controller.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  .../devicetree/bindings/usb/cdns-usb3.txt     | 33 +++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3.txt
>>
>> diff --git a/Documentation/devicetree/bindings/usb/cdns-usb3.txt b/Docum=
entation/devicetree/bindings/usb/cdns-usb3.txt
>> new file mode 100644
>> index 000000000000..6dc38be77f5c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/cdns-usb3.txt
>> @@ -0,0 +1,33 @@
>> +Binding for the Cadence USBSS-DRD controller
>> +
>> +Required properties:
>> +  - reg: Physical base address and size of the controller's register ar=
eas.
>> +	 Controller has 3 different regions:
>> +	 region 1 - HOST registers area
>> +	 region 2 - DEVICE registers area
>> +	 region 3 - OTG/DRD registers area
>> +  - reg-names - register memory area names:
>> +	"xhci" - for HOST registers space
>> +	"dev" - for DEVICE registers space
>> +	"otg" - for OTG/DRD registers space
>> +  - compatible: Should contain: "cdns,usb3-1.0.0" or "cdns,usb3-1.0.1"
>> +  - interrupts: Interrupt specifier. Refer to interrupt bindings.
>> +		Driver supports only single interrupt line.
>
>Driver supports or h/w only has 1 interrupt?

h/w internally has 3 separate interrupt line, but in my testing board=20
they are ored. So physically driver sees only one h/w interrupt line and=20
assumes that h/w has single common interrupt line.=20

>
>> +                This single interrupt is shared between Device,
>> +		host and OTG/DRD part of driver.
>> +
>> +Optional properties:
>> + - maximum-speed : valid arguments are "super-speed", "high-speed" and
>> +                   "full-speed"; refer to usb/generic.txt
>> + - dr_mode: Should be one of "host", "peripheral" or "otg".
>> + - phys: reference to the USB PHY
>> +
>> +Example:
>> +	usb@f3000000 {
>> +		compatible =3D "cdns,usb3";
>
>Doesn't match above.
Right, should be:
		Compatible =3D " cdns,usb3-1.0.0", "cdns,usb3-1.0.1";
>
>> +		interrupts =3D <USB_IRQ  7 IRQ_TYPE_LEVEL_HIGH>;
>> +		reg =3D <0xf3000000 0x10000	/* memory area for HOST registers */
>> +			0xf3010000 0x10000	/* memory area for DEVICE registers */
>> +			0xf3020000 0x10000>;	/* memory area for OTG/DRD registers */
>
>Are these really 64KB long? That wastes virtual address space on 32-bit
>systems if not.

Yes, on my testing platform it takes 64KB. It's only example, and it could =
be limited.=20
>
>> +		reg-names =3D "xhci", "dev", "otg";
>> +	};
>> --
>> 2.17.1
>>
Thanks=20
Pawel
