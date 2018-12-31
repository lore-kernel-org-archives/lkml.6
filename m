Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D31C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 05:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD7A20815
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 05:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="LTyQeno/";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="IKJuvNUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeLaFel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 00:34:41 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:47330 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726178AbeLaFel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 00:34:41 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBV5OTEc031622;
        Sun, 30 Dec 2018 21:32:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=cPlESz4vOls8CryN7lUf46EmLYHhpdY+6Cv4QLJK0y8=;
 b=LTyQeno/bJFiBts5ajOIwRJNEIRkgWDpb1jQAQAgm3tnnr/LUQche38rhybNuafYijLU
 9ycB+MZ2SuxTYUCV/pd/hCGjNvGlAtbIRuQ3e3wrSnT3MtrGElJigX7More0nfAaMmOd
 UhlcV6ZfVupcDOXtwUnm29pUvSZS4UnLtayppFWg7nZ5bodQJQXogUi6pZ0EuhsvMez6
 XC6zfMCvCMP9yJi8R0C6xlO2tZloO9jqRF5MsIwZoFtWNjvFl8zmNYp6P86rEixTrhYg
 YXVBm6C4z/K3VpGLgQC+7DnRMHdhXyTC+AFRKKUkXzbrWDT3BxuzGLG3Yem5aP3EazQ7 ng== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2051.outbound.protection.outlook.com [104.47.50.51])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2pp5d1f62n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 30 Dec 2018 21:32:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPlESz4vOls8CryN7lUf46EmLYHhpdY+6Cv4QLJK0y8=;
 b=IKJuvNUthWaqt8X3zK5TIwPWhMbMUS6208iClPujPpMqLYnx3g7fAcHfg3Qc4SrqieJUhRFMWX+yMmmIWknYnOsERWDhSjsBAlylI+HmFrT23hKPwCqwQY2Pb5tE0S5cFg03Mzs9gz1w9EBCGdohGi4AeocfubWddB92lH12hP8=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4725.namprd07.prod.outlook.com (52.135.205.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Mon, 31 Dec 2018 05:32:20 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e97e:1c66:94bc:24ef]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e97e:1c66:94bc:24ef%3]) with mapi id 15.20.1471.019; Mon, 31 Dec 2018
 05:32:20 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@nxp.com>, Peter Chen <hzpeterchen@gmail.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v2 5/5] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v2 5/5] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHUmtItEP31Hrx74EuIb6kD4d3L1KWNo02AgAGSJYCAAx9OYIABD7WAgAT2WyA=
Date:   Mon, 31 Dec 2018 05:32:20 +0000
Message-ID: <BYAPR07MB4709D8F210206B31093F9ACDDDB20@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1545577992-4013-1-git-send-email-pawell@cadence.com>
 <1545577992-4013-6-git-send-email-pawell@cadence.com>
 <CAL411-rj0mRMfPCZOHw04q3s-9oJx7Os9Jz83bO=RgPZKLrB1g@mail.gmail.com>
 <CAL411-omVL2rwoQP6GwKZa9f_1TLBbEAkyLdxNkJZqaQu9cvsA@mail.gmail.com>
 <BYAPR07MB4709F8A00A13390235BA4BE1DDB60@BYAPR07MB4709.namprd07.prod.outlook.com>
 <VI1PR04MB53274270615A700AB36967F78BB70@VI1PR04MB5327.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB53274270615A700AB36967F78BB70@VI1PR04MB5327.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNmQ3Zjk4ODAtMGNiZC0xMWU5LTg3MjktMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDZkN2Y5ODgxLTBjYmQtMTFlOS04NzI5LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTY4MiIgdD0iMTMxOTA3MDc5Mzc5MTEyNzA4IiBoPSJnWUpKd1kxMElnZWF3aXJqSmRFOWFmbWVWTUE9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4725;20:LlVgNQxjWcZ8CXWiJ4zCKubSaBPHRxCyVQfb5h7RWQ8jCyzrgLjQz/aHsl5PXMScZJHfaCfqDnSY2d9Zz6lDjdXlzgtHvESKkTYgNsBN2bu34oDIMSMZ3tKQfKpJVOVq3qJ/oR76uMvJjG7jNi28v/PqLTfS3fhywhTXoMgtfxLi/KsupXDPYFSbWhcoDUJRmzgl2bGHH4bu+8zxJZZ4SR2QMfumzYcgIYyG05popxj4Fdxptk/KDGGj2FhEdN/F
x-ms-office365-filtering-correlation-id: 71be5540-aaab-4cdb-edeb-08d66ee155c1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4725;
x-ms-traffictypediagnostic: BYAPR07MB4725:
x-microsoft-antispam-prvs: <BYAPR07MB4725EDF2D416C860E2EABACBDDB20@BYAPR07MB4725.namprd07.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4725;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4725;
x-forefront-prvs: 0903DD1D85
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39850400004)(346002)(136003)(396003)(376002)(189003)(199004)(36092001)(7416002)(71190400001)(71200400001)(53936002)(76176011)(105586002)(106356001)(66066001)(446003)(229853002)(476003)(486006)(6436002)(74316002)(256004)(11346002)(14444005)(5660300001)(97736004)(4326008)(3846002)(26005)(7736002)(305945005)(186003)(6116002)(93886005)(39060400002)(110136005)(6506007)(25786009)(316002)(102836004)(107886003)(86362001)(68736007)(33656002)(99286004)(2906002)(8676002)(55016002)(478600001)(7696005)(81166006)(81156014)(6246003)(14454004)(54906003)(9686003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4725;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Zu3pScVm5epupZKzua3zm9T0nKyzdKbpKfP2FDZYxK5+QpotbiSFqB/NjBRD0QJLW9bIDLGHYW6ElYdbhOK/6FZe8xm1wuu03M8cutmCHzh0aeMExKuslb44/FKwMfG3WAQkm4wXKMdJs/UQ1RzFo4djN6f9bepI3MYirYB0naXsvCyvcI/bNiCmbkAtAINcILAYXG0NveGQsWygyShEWgiSWjMlWxYI2uv3leYmJjnMiUM1gowvI/HznrpiwrU8FAX+q/eFrSm+pUsFAzqby/FY/L4oFy4U2cZPKARcZ34+KHm0P/Sm7IbadsPRZ7YN
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71be5540-aaab-4cdb-edeb-08d66ee155c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2018 05:32:20.2972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4725
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-31_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=970 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812310050
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGV0ZXIsDQo+DQo+PiA+DQo+PiA+QEAgLTI5OSw2ICszMDYsNyBAQCBpbnQgY2RuczNfZHJk
X2luaXQoc3RydWN0IGNkbnMzICpjZG5zKQ0KPj4gPiAgICAgICAgICAgICAgICBjZG5zLT52ZXJz
aW9uICA9IENETlMzX0NPTlRST0xMRVJfVjA7DQo+PiA+ICAgICAgICAgICAgICAgIGNkbnMtPm90
Z192MV9yZWdzID0gTlVMTDsNCj4+ID4gICAgICAgICAgICAgICAgY2Rucy0+b3RnX3JlZ3MgPSBy
ZWdzOw0KPj4gPisgICAgICAgICAgICAgICB3cml0ZWwoMHgxLCAmY2Rucy0+b3RnX3YwX3JlZ3Mt
PnNpbXVsYXRlKTsNCj4+ID4gICAgICAgICAgICAgICAgZGV2X2luZm8oY2Rucy0+ZGV2LCAiRFJE
IHZlcnNpb24gdjAgKCUwOHgpXG4iLA0KPj4gPiAgICAgICAgICAgICAgICAgICAgICAgICByZWFk
bCgmY2Rucy0+b3RnX3YwX3JlZ3MtPnZlcnNpb24pKTsNCj4+ID4gICAgICAgIH0gZWxzZSB7DQo+
Pg0KPj4gSSBoYXZlIGNvbmZpcm1hdGlvbiBmcm9tIEhXIHRlYW0gdGhhdCB0aW1lIHRoYXQgZHJp
dmVyIHNob3VsZCB3YWl0IGFmdGVyIGRlLQ0KPj4gc2VsZWN0aW5nIG1vZGUgaXMgMi0zbXMgZm9y
IHNpbXVsYXRlIG1vZGUuIEl0J3MgdGltZSB3aGVuIEZTTSBpcyBpbg0KPj4gRFJEX0hfV0FJVF9W
QlVTX0ZBSUwuDQo+PiBEcml2ZXIgY2Fubm90IHJlLWVuYWJsZSB0aGUgaG9zdC9kZXZpY2UgbW9k
ZSBiZWZvcmUgdGhpcyB0aW1lIGhhcyBlbGFwc2VkLg0KPj4NCj4+IDMgbXMgaXMgdGhlIG1heGlt
dW0gdGltZS4gQWRkaXRpb25hbGx5LCB5b3UgY2FuIGNvbmZpcm0gdGhlIGN1cnJlbnQgRlNNIHN0
YXRlIGJ5DQo+PiByZWFkaW5nIHRoZSBob3N0X290Z19zdGF0ZSAoYml0IDU6Mykgb3IgZGV2X290
Z19zdGF0ZSAoMjowKSAgZnJvbSBPVEdTVEFURQ0KPj4gcmVnaXN0ZXIuDQo+Pg0KPj4gSWYgYml0
IDAgaW4gc2ltdWxhdGUgcmVnaXN0ZXIgaXMgY2xlYXJlZCB0aGUgdGltZSBpcyBleGFjdGx5IDFz
Lg0KPj4NCj4NCj5UaGFua3MsIFBhd2VsLg0KPg0KPldvdWxkIHlvdSBwbGVhc2UgYWRkIGJlbG93
IGNoYW5nZXMgaW4geW91ciBuZXh0IHJldmlzaW9uPw0KPi0gU2V0IGJpdCAwIGluIHNpbXVsYXRl
IHJlZ2lzdGVyDQpCdXQgaXQncyB1c2VkIG9ubHkgZm9yIHNpbXVsYXRpb24gZW52aXJvbm1lbnRz
IHRvIHNwZWVkIHVwIHNpbXVsYXRpb24uIA0KT24gcmVhbCBwbGF0Zm9ybXMgdGhpcyBiaXQgc2hv
dWxkIGJlIGNsZWFyZWQuIEknbSBub3Qgc3VyZSBpZiBJIGNhbiANCmFkZCBzb21lIGNvZGUgcmVs
YXRlZCB0byBzaW11bGF0aW9uIGVudmlyb25tZW50IHRvIGRyaXZlci4gDQpJZiB5ZXMgdGhlbiBJ
IG11c3QgaW50cm9kdWNlIHRoZSB3YXksIHRoYXQgYWxsb3cgdG8gcmVjb2duaXplIHRoaXMgdHdv
IG1vZGVzLiANCkkgY291bGQgYWRkIG1vZHVsZSBwYXJhbWV0ZXIgb3IgYWRkIGFkZGl0aW9uYWwg
Y29uZmlnIGluIEtjb25maWcgZmlsZS4NCg0KPi0gdGltZW91dCBsb2dpYyBmb3Igd2FpdGluZyBo
b3N0X290Z19zdGF0ZSBvciBkZXZfb3RnX3N0YXRlIGF0IE9UR1NUQVRFDQo+d2hlbiBzd2l0Y2gg
dG8gaG9zdCBvciBkZXZpY2UuDQoNCkkgd2lsbCBhZGQgc3VjaCBjb2RlLiANCg0KUGF3ZWwNCg0K
