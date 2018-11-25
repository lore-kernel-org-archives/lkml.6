Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F206EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3756C20867
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Ylxfrh+P";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="bec7L04w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3756C20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbeKYSYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 13:24:30 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:50768 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726503AbeKYSYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 13:24:30 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAP78gam019237;
        Sat, 24 Nov 2018 23:33:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=q5qsep1ZFNRVX3jL8sGnusMQwytVu4GUIGe4EhXy8Og=;
 b=Ylxfrh+P3mnCjUqjS7mc1UDFsa6qASjUSM2VB6RLPgazc7QqmrKeCPpcUpCvRz0qmps+
 MI6N0gDKAuCXy0KqVhF1kDP1b/TrQ6WDpfySaMoEl3Vlt9LPN3EfPZIm14meRgnm7l9S
 W9vNicNeAQGwBSs8cqiFz3w1yaKc3eqQnjTbTYBkCcbX9jhA/EBPA9Qovpl8Rxes2uC1
 fnzI5DEoQVIeZVSB2uuvBYnJlLyUAfK6C9tVYWnsj2jq9Cx11jsuehkBhunntbJPw6V5
 dY1bjz7vesdUfBZRnNoDmbUDiVk1VFilbDuHdQJ7lOjJzlHkuAVEzM9hQrS3lKMsDOA5 WA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp0180.outbound.protection.outlook.com [216.32.181.180])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2ny34cckky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 24 Nov 2018 23:33:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5qsep1ZFNRVX3jL8sGnusMQwytVu4GUIGe4EhXy8Og=;
 b=bec7L04w9XLg5uNwpXNxP2q8FRxqBPNd/hm+IkqEZGXjlArJY6qOQNt7JkoIeXaBwDY/nHv57XKEhxJTHFnPbLqXv1XTJO3mkED0kstviKTFLJH+sVNdHAaHjVbGN6evurbUV1n2yyimn+RaxzJb+pBJAdbT1AA63x/HbLrZh/A=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5014.namprd07.prod.outlook.com (52.135.238.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.25; Sun, 25 Nov 2018 07:33:36 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644%6]) with mapi id 15.20.1361.019; Sun, 25 Nov 2018
 07:33:33 +0000
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
Subject: RE: [RFC PATCH v2 03/15] dt-bindings: add binding for USBSS-DRD
 controller.
Thread-Topic: [RFC PATCH v2 03/15] dt-bindings: add binding for USBSS-DRD
 controller.
Thread-Index: AQHUfycJl8d7ihdwL0KyGfF/ckVY2qVdNx8AgALpkrA=
Date:   Sun, 25 Nov 2018 07:33:33 +0000
Message-ID: <BYAPR07MB47096DA8D0A23B585F731111DDD60@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-4-git-send-email-pawell@cadence.com>
 <5BF7DC12.4060600@ti.com>
In-Reply-To: <5BF7DC12.4060600@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNjRmNjBhZWMtZjA4NC0xMWU4LTg3MjYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDY0ZjYwYWVkLWYwODQtMTFlOC04NzI2LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTk5MyIgdD0iMTMxODc2MDQ4MTM2NzI1NDYxIiBoPSJ4S2JYalUzUUR1Q2Q2Q252bDVvQ3QvcHp0Wm89IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5014;20:sxWe6j7aRGKcoPOBsShXh5DrEH879yqtmEWejZU4mJMziFlUwbL1WO6IQB/tqXWD52C+0mSUI+L5vqbaFA+lNHg4msS5Ixtl6rP1K/pFv/jufhl0cqVHFmqzRVpa1Fr4hgHEORABEDOMzTjElU2jJbPAt26vet3h51Ac3sdFToSso/wW+ot2JH5HEQe0z889q1u9WoHzp3sIUquKi69B/FPKNF5ywVYdzJ3GOd1PiS6UmtROAT+gM9m3pH23AXBW
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(366004)(396003)(189003)(199004)(51444003)(36092001)(7736002)(99286004)(5660300001)(74316002)(478600001)(6246003)(107886003)(25786009)(11346002)(476003)(446003)(229853002)(14454004)(4326008)(486006)(81156014)(81166006)(110136005)(8936002)(33656002)(55016002)(2906002)(8676002)(305945005)(53936002)(9686003)(68736007)(256004)(3846002)(217873002)(6116002)(186003)(2501003)(66066001)(71190400001)(71200400001)(106356001)(105586002)(6436002)(316002)(97736004)(6506007)(7696005)(76176011)(54906003)(26005)(102836004)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5014;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: a299d7b5-487a-4644-7cd3-08d652a84de7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5014;
x-ms-traffictypediagnostic: BYAPR07MB5014:
x-microsoft-antispam-prvs: <BYAPR07MB5014F8A29D04382E8357D146DDD60@BYAPR07MB5014.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231442)(944501410)(52105112)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB5014;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5014;
x-forefront-prvs: 0867F4F1AA
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lTMPewYUdX3tggr6mpJ2gVBSb+t/ymcTfwhz5dpwik1HGOOx83BEwQs8Uoow/dR8wWJUG/bNWMlick0BZ3vpNxM0q8OSY9Zq/kecKF8IMpuaBJeXl9Akh3lKewlEMG/pU41PILHohHbqgKyzbttWKVg0FZZorV9mF3dwNE/CRnq0LHmxjMRr8BNNrFL+neibIWGj9J9b1TlH996icFf3C/6APTvRCO/1039BJ39dfXkmtjC/mhi5PYoJBK9xKuLuSS2ubpuefQ7HvfI23gpHjApPnkEFvcRquiRNhKXn7WV5jFMPgVFiKrkPBEfCpx60O3JGxpUBiSy9n81WfkHobV6TGLI3NgVxws5/w5OxcOw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a299d7b5-487a-4644-7cd3-08d652a84de7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2018 07:33:33.3122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5014
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-25_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811250066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger

>On 18/11/18 12:08, Pawel Laszczak wrote:
>> Thsi patch aim at documenting USB related dt-bindings for the
>
>s/Thsi/This
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
>> +  - compatible: Should contain: "cdns,usb3"
>> +  - interrupts: Interrupt specifier. Refer to interrupt bindings.
>
>Do you also comply with USB generic bindings for dr_mode, speed, etc?
>i.e. Documentation/devicetree/bindings/usb/generic.txt
>
>If yes it must be mentioned in Optional properties:

I took a look at this document and I think that only dr_mode and maximum-sp=
eed make sense=20
as optional parameters.
I will add these two as optional.=20

Thanks.

>
>> +
>> +
>> +Example:
>> +	cdns3@f3000000 {
>> +		compatible =3D "cdns,usb3";
>> +		interrupts =3D <USB_IRQ  7 IRQ_TYPE_LEVEL_HIGH>;
>> +		reg =3D <0xf3000000 0x10000	//memory area for OTG/DRD registers
>> +			0xf3010000 0x10000	//memory area for HOST registers
>> +			0xf3020000 0x10000>;	//memory area for Device registers
>> +	};
>> +
>>
>
>cheers,
>-roger
>--
>Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

Cheers,
Pawel
