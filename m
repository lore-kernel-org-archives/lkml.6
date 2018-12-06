Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C402C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058FE20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Xbpn7fQC";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="cDM0Y4Bj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058FE20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbeLFK0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:26:43 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:42172 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727575AbeLFK0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:26:40 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB6AO5Gf022517;
        Thu, 6 Dec 2018 02:26:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=M3xHkDOslABCTXWIu8MslURGbd8SFOuv+PWTrdjokmQ=;
 b=Xbpn7fQC/8vy4TUYorkz/7JjR9GeW/4VRkWDkSzyCo1ZXq2YHHnydvb9GhNV6/1OUjnw
 CGmsSQZMUKQzadKAF+xtpoQf1Ej6H4nHQbhjuSomVhNlAZny2Eqr8E/bv1VmcCzmHNEN
 aZQf5EpjTo2sLipnPlksVenF4apwMl7b5Kbq+7VP3DzNA9jqcDs0afJflQSU7jwm0A/a
 rUBT0HZhiDz8kCnhKWeSatbYJDdMvBG4RFwg8nqK8Q45bGAPawT51zaVLxsAlC9WtbDZ
 77dNOlI657qOysbVUD5NBb5kWR720r0ZPmgSo5NLVF6RvhodatfbC3s8J9G0EjJDAoWY LQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2054.outbound.protection.outlook.com [104.47.36.54])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2p6w7hs9ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 06 Dec 2018 02:26:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3xHkDOslABCTXWIu8MslURGbd8SFOuv+PWTrdjokmQ=;
 b=cDM0Y4BjNBP9GB1W1PF68/6xIc+Ko/EycF0OBui4OLHGQTCdfDlfPby+8d3eJfU2B/9aHNcPX+VuD1oVQ1wBZoHJUBz/99tclfy48eoGjWxPX5rLl21ymSzczREm7wrEgJmpa4lBUQQVROYeJ7IUqYUejLt1QZq6QBB+Q3GqcDo=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5526.namprd07.prod.outlook.com (20.177.231.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Thu, 6 Dec 2018 10:26:28 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644%6]) with mapi id 15.20.1382.024; Thu, 6 Dec 2018
 10:26:28 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Rob Herring <robh@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [RFC PATCH v2 03/15] dt-bindings: add binding for USBSS-DRD
 controller.
Thread-Topic: [RFC PATCH v2 03/15] dt-bindings: add binding for USBSS-DRD
 controller.
Thread-Index: AQHUfycJl8d7ihdwL0KyGfF/ckVY2qVvRtIAgAJUywA=
Date:   Thu, 6 Dec 2018 10:26:28 +0000
Message-ID: <BYAPR07MB470979F18C0DAFEBD774A08BDDA90@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-4-git-send-email-pawell@cadence.com>
 <20181204224158.GA29726@bogus>
In-Reply-To: <20181204224158.GA29726@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNjNhODNjMGMtZjk0MS0xMWU4LTg3MjYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDYzYTgzYzBkLWY5NDEtMTFlOC04NzI2LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTgxMyIgdD0iMTMxODg1NjU1ODg1NTk5NjU5IiBoPSIxWTVBSGhRN0o3ajZaRUJRcERROWhSdXcyUE09IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5526;20:cUm6BL6jTJW3E9v2heGRw6Cpo7aW04ia7nveyusZQT8PkpVB/SQr71NWq+cs5ju+ufyjb4dzyZqE5V2A/9yU06JK3xlE4caeg6k3DoIvflxZOsbxxkfVKwTlj5i9OlPcy1jpNuyVL7WPWU1nwF4u9v458XjlmpwfYOmbUEHB3rhQNqQW/ICOPwHPagexmR9Gp5WPGOY7FPsbxvvUFtEXPRhjsJk9soBx9qWkC63K4YvA/B2s/t4qCZBSZ7HZNOUS
x-ms-office365-filtering-correlation-id: deeed14b-a865-4055-3e1f-08d65b654890
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5526;
x-ms-traffictypediagnostic: BYAPR07MB5526:
x-microsoft-antispam-prvs: <BYAPR07MB5526BE0ECC804484EAAC8207DDA90@BYAPR07MB5526.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB5526;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5526;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(396003)(376002)(346002)(189003)(199004)(36092001)(6246003)(86362001)(7696005)(25786009)(7416002)(97736004)(8936002)(81166006)(446003)(8676002)(81156014)(54906003)(68736007)(229853002)(99286004)(186003)(6506007)(14454004)(6116002)(3846002)(478600001)(76176011)(316002)(6436002)(26005)(71190400001)(71200400001)(33656002)(486006)(476003)(6916009)(102836004)(2906002)(217873002)(9686003)(55016002)(66066001)(5660300001)(106356001)(105586002)(53936002)(107886003)(4326008)(11346002)(256004)(7736002)(305945005)(14444005)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5526;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: S2XPG68aGpmbI9NpGPBqjpbg6DxqrW55n0/TFKOf1EV5lqtpaJ+fXxgwz9KCtoLYdV6HE4UkYb7hKtzoae7Q4gJx9xKCxH/3kSbaGpPSgUrgPySUejpQtTrNxRs5pHjXS14K5panhXC5tAiZjm4LK5I9wwS30UfYVkGoh/aO7ZJPPi7Omw1fGFtjBTxWhKknWJzxFJoCLfIZMaZFlUVfJ5mVEHMzoFww6bZGCWSffrYYOTJslIwKCV7mJm5Y5tFc/VtdRzSlZw5A9a4oCgcfj+F3VOL1uXeABceWvt9vZiBB8cef8rzxt1rkNbDfJKZL1I3wmwBhuZSZTDcZUrmyoTzFOrCAmCPPUkile93+aeg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deeed14b-a865-4055-3e1f-08d65b654890
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 10:26:28.6040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5526
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=886 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812060094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>On Sun, Nov 18, 2018 at 10:08:59AM +0000, Pawel Laszczak wrote:
>> Thsi patch aim at documenting USB related dt-bindings for the
>
>typo
>
>> Cadence USBSS-DRD controller.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  .../devicetree/bindings/usb/cdns3-usb.txt       | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/usb/cdns3-usb.txt
>>
>> diff --git a/Documentation/devicetree/bindings/usb/cdns3-usb.txt b/Docum=
entation/devicetree/bindings/usb/cdns3-usb.txt
>> new file mode 100644
>> index 000000000000..f9e953f32d47
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/cdns3-usb.txt
>> @@ -0,0 +1,17 @@
>> +Binding for the Cadence USBSS-DRD controller
>> +
>> +Required properties:
>> +  - reg: Physical base address and size of the controller's register ar=
ea.
>
>1 or 3 regions? If 3, what is each one and the order?

I will add extra description.
>
>> +  - compatible: Should contain: "cdns,usb3"
>
>Only one version and one set of bugs?
Yes, currently we have only one version.=20

>
>> +  - interrupts: Interrupt specifier. Refer to interrupt bindings.
>
>How many interrupts?

Single line  for Device/Host/OTG

I will add description
>
>> +
>> +
>> +Example:
>> +	cdns3@f3000000 {
>
>usb@...
>
Ok.=20

>> +		compatible =3D "cdns,usb3";
>> +		interrupts =3D <USB_IRQ  7 IRQ_TYPE_LEVEL_HIGH>;
>> +		reg =3D <0xf3000000 0x10000	//memory area for OTG/DRD registers
>> +			0xf3010000 0x10000	//memory area for HOST registers
>> +			0xf3020000 0x10000>;	//memory area for Device registers
>> +	};
>> +
>> --
>> 2.17.1
>>

Thanks,
Cheers
Pawel
