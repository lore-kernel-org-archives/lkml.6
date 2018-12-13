Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B659C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2805F2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="cnKerJb8";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="MDzqUAQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2805F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeLMJ0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:26:13 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:34114 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727063AbeLMJ0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:26:12 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBD9O5Js027274;
        Thu, 13 Dec 2018 01:26:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=ort+lOixMd8kstaFuNF3K1gU66u2yHpNle4S4i+sbZw=;
 b=cnKerJb890VHFr+WV+J2Qnyg72CKAdGjcLpYNcFKl8zeDGQUiAZV9DKioTcKf672syzi
 v2Qh99ARITpzKj4V2bP/NTlQi/qFJUcd3lfF6o9IKmQOgjl2BxhrlQl7iFOzBGDCNuTZ
 jddFb4JnoPhQBoXYGegb+fs1rxLRu4YrHlTRw5b4tM7VGZDQU3b+BLjO3CS+oYLukfvM
 Q1y/4LO/YWGvnej82t/DWt85qXkF4N2/bOVFd9ZqT1G/KgaPKh3oIw4LpC5aAFGFZUOM
 yhvMDY60DQcDdB8RYcsUd/7msQ31/ZHz0uAVWm8gw0S1TdCME1fUfO8VQQVPEwvhIfTP Rw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2056.outbound.protection.outlook.com [104.47.45.56])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2pbkac0hc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 13 Dec 2018 01:26:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ort+lOixMd8kstaFuNF3K1gU66u2yHpNle4S4i+sbZw=;
 b=MDzqUAQTtD9+hXsUd+Jix8ufwxZ9Kh1BDSymfZGdwsd1oIkze8xQwYzd5ZXxy7OpEZtvjG6gMVa0FAMQtOEqETCBY0ZzO/hVc79sAFguR/lZlOJWbtC5EgH5Hin2YO4eBeLy5JxNlaTpM2X2fg4AlhFVgULKPYqv2jZ/oZj7bJE=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4327.namprd07.prod.outlook.com (52.135.223.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Thu, 13 Dec 2018 09:25:57 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644%6]) with mapi id 15.20.1404.026; Thu, 13 Dec 2018
 09:25:57 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <hzpeterchen@gmail.com>, "rogerq@ti.com" <rogerq@ti.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v1 1/2] dt-bindings: add binding for USBSS-DRD controller.
Thread-Topic: [PATCH v1 1/2] dt-bindings: add binding for USBSS-DRD
 controller.
Thread-Index: AQHUkIWR9ZZRuTwCZUuVYkxzeBHYYqV5VBuAgAMVKICAAABj4A==
Date:   Thu, 13 Dec 2018 09:25:57 +0000
Message-ID: <BYAPR07MB470969E4433BEB820007F988DDA00@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1544445555-17325-1-git-send-email-pawell@cadence.com>
 <1544445555-17325-2-git-send-email-pawell@cadence.com>
 <5C0F8E7B.3030601@ti.com>
 <CAL411-qP3TAt1kz5Q1WcUejSbt4Agpmqry7JVE_6W+2MpCag4Q@mail.gmail.com>
In-Reply-To: <CAL411-qP3TAt1kz5Q1WcUejSbt4Agpmqry7JVE_6W+2MpCag4Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMTdlN2UzOWItZmViOS0xMWU4LTg3MjctMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDE3ZTdlMzlkLWZlYjktMTFlOC04NzI3LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjc1OSIgdD0iMTMxODkxNjY3NTY5OTM3MDI4IiBoPSJyckhLY0Z6MDh1b0pWaG54Q0ZTeGdGUTNHTTA9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4327;20:lEaaq/tDauKz229ZSdwVofxypcJI3SG9USlHDTyjKR2b8QXgUIXWZ2fax7NK0Tp5BkSM/6IxFdDlu3tISjYVYl8grrxEUcVW/3E7aZkqZUZT/3OMsN6tABntd/NMOjsvBGLMACUYE6byBEalI0lskVy9Bpt5+yCpdiRtpmOWQCPIsyMHG7Tp+HhdY/9+5CSk550zRINWT5AhkiwvKprxuoto3yM1X1d/Wo9jYh3+oylMIRm32A0xuqvWI0dTtGsQ
x-ms-office365-filtering-correlation-id: 7650f5f2-393f-43c3-a34a-08d660dcfd57
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4327;
x-ms-traffictypediagnostic: BYAPR07MB4327:
x-microsoft-antispam-prvs: <BYAPR07MB4327B068BAC3BFD4B3CF1F04DDA00@BYAPR07MB4327.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4327;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4327;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(396003)(39860400002)(199004)(189003)(36092001)(66066001)(26005)(81156014)(11346002)(6116002)(3846002)(105586002)(14454004)(68736007)(5660300001)(4326008)(7736002)(186003)(446003)(476003)(55016002)(7416002)(6436002)(486006)(99286004)(305945005)(2501003)(2906002)(25786009)(575784001)(106356001)(9686003)(6246003)(39060400002)(33656002)(107886003)(478600001)(74316002)(76176011)(86362001)(110136005)(53936002)(7696005)(81166006)(229853002)(256004)(316002)(93886005)(8936002)(6506007)(71200400001)(71190400001)(97736004)(54906003)(102836004)(53546011)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4327;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: e+KrD98k72iJyu8zBBIJceoR0DWgNV894T74o0mjzLSqITc1iNGx6qijpPR0jwjkHoyskWWfxzvpSNTV3EIz8naVaQ6/8ae50IHjxTYWHGHWgMXP2H2T30UPK6Yc0GCY6W0JTET4ds6z7uExPYuLj03cQFDvAyRKYLDafsgP2J1544/zj1FlM+wKHoYMYlMtfTp81cyBRINUMn9AfNatIQxMobbdiF/iKfDghFtB/UJZnZ9ix3i3b5afGE05rCFHaBIvu4RfiHjAPqrY/Vvz2EVh/IvGg7asd4vTwvcPysWE5dGMQl8nFsFVYhtMs+Hw
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7650f5f2-393f-43c3-a34a-08d660dcfd57
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 09:25:57.7563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4327
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-13_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812130085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIA0KDQo+T24gVHVlLCBEZWMgMTEsIDIwMTggYXQgNjoxOSBQTSBSb2dlciBRdWFkcm9zIDxy
b2dlcnFAdGkuY29tPiB3cm90ZToNCj4+DQo+PiBQYXdlbCwNCj4+DQo+PiBPbiAxMC8xMi8xOCAx
NDozOSwgUGF3ZWwgTGFzemN6YWsgd3JvdGU6DQo+PiA+IFRoaXMgcGF0Y2ggYWltIGF0IGRvY3Vt
ZW50aW5nIFVTQiByZWxhdGVkIGR0LWJpbmRpbmdzIGZvciB0aGUNCj4+ID4gQ2FkZW5jZSBVU0JT
Uy1EUkQgY29udHJvbGxlci4NCj4+ID4NCj4+ID4gU2lnbmVkLW9mZi1ieTogUGF3ZWwgTGFzemN6
YWsgPHBhd2VsbEBjYWRlbmNlLmNvbT4NCj4+ID4gLS0tDQo+PiA+ICAuLi4vZGV2aWNldHJlZS9i
aW5kaW5ncy91c2IvY2RuczMtdXNiLnR4dCAgICAgfCAzMSArKysrKysrKysrKysrKysrKysrDQo+
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKQ0KPj4gPiAgY3JlYXRlIG1vZGUg
MTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvY2RuczMtdXNiLnR4
dA0KPj4gPg0KPj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3VzYi9jZG5zMy11c2IudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3VzYi9jZG5zMy11c2IudHh0DQo+PiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiA+IGluZGV4
IDAwMDAwMDAwMDAwMC4uYWU0YTI1NWYwYjEwDQo+PiA+IC0tLSAvZGV2L251bGwNCj4+ID4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9jZG5zMy11c2IudHh0DQo+
PiA+IEBAIC0wLDAgKzEsMzEgQEANCj4+ID4gK0JpbmRpbmcgZm9yIHRoZSBDYWRlbmNlIFVTQlNT
LURSRCBjb250cm9sbGVyDQo+PiA+ICsNCj4+ID4gK1JlcXVpcmVkIHByb3BlcnRpZXM6DQo+PiA+
ICsgIC0gcmVnOiBQaHlzaWNhbCBiYXNlIGFkZHJlc3MgYW5kIHNpemUgb2YgdGhlIGNvbnRyb2xs
ZXIncyByZWdpc3RlciBhcmVhcy4NCj4+ID4gKyAgICAgIENvbnRyb2xsZXIgaGFzIDMgZGlmZmVy
ZW50IHJlZ2lvbnM6DQo+PiA+ICsgICAgICByZWdpb24gMSAtIEhPU1QgcmVnaXN0ZXJzIGFyZWEN
Cj4+ID4gKyAgICAgIHJlZ2lvbiAyIC0gREVWSUNFIHJlZ2lzdGVycyBhcmVhDQo+PiA+ICsgICAg
ICByZWdpb24gMyAtIE9URy9EUkQgcmVnaXN0ZXJzIGFyZWENCj4+ID4gKyAgLSBjb21wYXRpYmxl
OiBTaG91bGQgY29udGFpbjogImNkbnMsdXNiMyINCj4+ID4gKyAgLSBpbnRlcnJ1cHRzOiBJbnRl
cnJ1cHQgc3BlY2lmaWVyLiBSZWZlciB0byBpbnRlcnJ1cHQgYmluZGluZ3MuDQo+PiA+ICsgICAg
ICAgICAgICAgRHJpdmVyIHN1cHBvcnRzIG9ubHkgc2luZ2xlIGludGVycnVwdCBsaW5lLg0KPj4g
PiArICAgICAgICAgICAgICAgIFRoaXMgc2luZ2xlIGludGVycnVwdCBpcyBzaGFyZWQgYmV0d2Vl
biBEZXZpY2UsDQo+PiA+ICsgICAgICAgICAgICAgaG9zdCBhbmQgT1RHL0RSRCBwYXJ0IG9mIGRy
aXZlci4NCj4+ID4gKw0KPj4gPiArT3B0aW9uYWwgcHJvcGVydGllc2k6DQo+Pg0KPj4gcy9wcm9w
ZXJ0aWVzaS9wcm9wZXJ0aWVzDQo+Pg0KPj4gPiArIC0gbWF4aW11bS1zcGVlZCA6IHZhbGlkIGFy
Z3VtZW50cyBhcmUgInN1cGVyLXNwZWVkIiwgImhpZ2gtc3BlZWQiIGFuZA0KPj4gPiArICAgICAg
ICAgICAgICAgICAgICJmdWxsLXNwZWVkIjsgcmVmZXIgdG8gdXNiL2dlbmVyaWMudHh0DQo+PiA+
ICsgLSBkcl9tb2RlOiBTaG91bGQgYmUgb25lIG9mICJob3N0IiwgInBlcmlwaGVyYWwiIG9yICJv
dGciLg0KPj4gPiArIC0gcGh5czogcmVmZXJlbmNlIHRvIHRoZSBVU0IgUEhZDQo+PiA+ICsgLSBw
aHktbmFtZXM6IG5hbWUgb2YgdGhlIFVTQiBQSFksIHNob3VsZCBiZSAiY2RuczMsdXNicGh5Ig0K
Pj4gPiArDQo+PiA+ICsNCj4+ID4gK0V4YW1wbGU6DQo+PiA+ICsgICAgIHVzYkBmMzAwMDAwMCB7
DQo+PiA+ICsgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJjZG5zLHVzYjMiOw0KPj4gPiArICAg
ICAgICAgICAgIGludGVycnVwdHMgPSA8VVNCX0lSUSAgNyBJUlFfVFlQRV9MRVZFTF9ISUdIPjsN
Cj4+ID4gKyAgICAgICAgICAgICByZWcgPSA8MHhmMzAwMDAwMCAweDEwMDAwICAgICAgIC8vbWVt
b3J5IGFyZWEgZm9yIEhPU1QgcmVnaXN0ZXJzDQo+PiA+ICsgICAgICAgICAgICAgICAgICAgICAw
eGYzMDEwMDAwIDB4MTAwMDAgICAgICAvL21lbW9yeSBhcmVhIGZvciBERVZJQ0UgcmVnaXN0ZXJz
DQo+PiA+ICsgICAgICAgICAgICAgICAgICAgICAweGYzMDIwMDAwIDB4MTAwMDA+OyAgICAvL21l
bW9yeSBhcmVhIGZvciBPVEcvRFJEIHJlZ2lzdGVycw0KPj4NCj4+IFVzZSAiLyogPGNvbW1lbnQ+
ICovIiBpbnN0ZWFkLg0KPj4NCj4+ID4gKyAgICAgfTsNCj4+ID4gKw0KPj4gPg0KPg0KPldoZW4g
cnVubmluZyBnaXQgYW0gdG8gYXBwbHkgcGF0Y2gsIGl0IGhhcyBiZWxvdyB3YXJuaW5nLCBwbGVh
c2UgZml4IHRoZW0uDQo+DQo+QXBwbHlpbmc6IGR0LWJpbmRpbmdzOiBhZGQgYmluZGluZyBmb3Ig
VVNCU1MtRFJEIGNvbnRyb2xsZXIuDQo+LmdpdC9yZWJhc2UtYXBwbHkvcGF0Y2g6NDI6IG5ldyBi
bGFuayBsaW5lIGF0IEVPRi4NCj4rDQo+d2FybmluZzogMSBsaW5lIGFkZHMgd2hpdGVzcGFjZSBl
cnJvcnMuDQoNCk9rLCB0aGFua3MNCkNoZWVycyANClBhd2VsDQo=
