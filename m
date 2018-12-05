Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F34C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852AF20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="WTe+Quic";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="bp02Oop6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 852AF20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeLEIzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:55:45 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:33824 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726102AbeLEIzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:55:44 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB58sqvY016713;
        Wed, 5 Dec 2018 00:55:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=3F8iizObh3QhF29NLqkubvO8/b5Sk+C37MCOmTWbSpE=;
 b=WTe+QuicZFe3KQJm0goBB8e34lZuaiD86V5IheiJWkoa8JxFKhN5hPD7Abv3/Ewx4fXD
 S1fKrpHRGJYwGEdXauNK737gGryHmgl1sCo91xNLUj2LaHKA+4502ZhSCSa/QiiqP4Gb
 KVTQoAMAtMnEZZ+eHWklJGzSwbu9gisxBezYgUIemwTAaP3tUwf1hsQzqOXU1bhAHZqL
 EV+UI7yHq+ta9DoqOpNTqvYOESelxVGnrTmO7ZWQLiLtPdvTEWij64d49EKHTGcC10j6
 tn4hchHaHUPVWg5mOhGLxammYGWYJ3ES9js8DipjO2XOSGLloooLOmI7OUtKwV5gODfi RA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=adouglas@cadence.com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2051.outbound.protection.outlook.com [104.47.36.51])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2p3ps2xkpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 05 Dec 2018 00:55:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3F8iizObh3QhF29NLqkubvO8/b5Sk+C37MCOmTWbSpE=;
 b=bp02Oop6Mhwm6VP7fMGivUDiNSyp7uxNHHI7LrB3Eq1KvDGhDZenw2zMt9QDR2O+vkaI5TuotafenoxBJ5AKH7/ZbHqF6UF3ZM11KkGJkFw1rknmxZEJXv/LkvircN/GN62X29Q6usvIsClES+lRrkKXKcnpow3TA9AX1Vsmlrw=
Received: from MWHPR07MB3502.namprd07.prod.outlook.com (10.164.192.29) by
 MWHPR07MB3117.namprd07.prod.outlook.com (10.172.95.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.18; Wed, 5 Dec 2018 08:55:29 +0000
Received: from MWHPR07MB3502.namprd07.prod.outlook.com
 ([fe80::70e2:ccd9:2baf:68f9]) by MWHPR07MB3502.namprd07.prod.outlook.com
 ([fe80::70e2:ccd9:2baf:68f9%5]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 08:55:29 +0000
From:   Alan Douglas <adouglas@cadence.com>
To:     Pawel Laszczak <pawell@cadence.com>,
        Peter Chen <hzpeterchen@gmail.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [RFC PATCH v2 04/15] usb:cdns3: Driver initialization code.
Thread-Topic: [RFC PATCH v2 04/15] usb:cdns3: Driver initialization code.
Thread-Index: AQHUfycKcdgNetLEF0mtEJTXx/rmTKVn/0mAgAP/M4CAAkRqAIABlJ6AgAAYs0A=
Date:   Wed, 5 Dec 2018 08:55:28 +0000
Message-ID: <MWHPR07MB3502A7A07AD114D6343BD6C0D8A80@MWHPR07MB3502.namprd07.prod.outlook.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-5-git-send-email-pawell@cadence.com>
 <CAL411-rWbQ6yj1r_aaLP8UagVRJhsn7xdznQwXS9enkxXTs2LA@mail.gmail.com>
 <BYAPR07MB4709A8E4B0B0CC05A842B708DDAD0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <CAL411-rzhH+y-b0-xze4-WmeVtey4bXt4Jc6TWYyfw6E8x-5Eg@mail.gmail.com>
 <BYAPR07MB47090A16A7A8A85C6C3FD46ADDA80@BYAPR07MB4709.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB47090A16A7A8A85C6C3FD46ADDA80@BYAPR07MB4709.namprd07.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWRvdWdsYXNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy04MzRiMTlhNC1mODZiLTExZTgtYWI4Zi1hNDRjYzg0ZTk5NTlcYW1lLXRlc3RcODM0YjE5YTUtZjg2Yi0xMWU4LWFiOGYtYTQ0Y2M4NGU5OTU5Ym9keS50eHQiIHN6PSI0NjM4IiB0PSIxMzE4ODQ3MzcyOTMxOTQzNTkiIGg9InhrRm90RTgzYUNsbCsrQ2hiSkdrYmZFZ0RKYz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR07MB3117;20:4f07vOxyBCkc1WFPWPZez2OwI6rbR7TbHjkEBsNKL+CYEfGSebTza6chEQFcdc/x1SkeVhQ+Zk53bA6bTWaZiSJdCUHXdcI0Af3fYtpfKYlqHOv0c0319vLnKC+4fpLS3u3D1dLmDuOydMmQS/VYsiSKQVfZC2HoyGIlmYy/ki2jEOjyWBXfeMBTcqBsNQ6nKFsbfFZDSDTscs99b8SieZI6HB/fLeXQcEiRo+PUl1v6Q+eAs1cjBlFlSgQlVBxN
x-ms-office365-filtering-correlation-id: 2e0af29d-ab66-4ab9-c508-08d65a8f67f6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR07MB3117;
x-ms-traffictypediagnostic: MWHPR07MB3117:
x-microsoft-antispam-prvs: <MWHPR07MB3117AB7015A1FA4E3E3D9749D8A80@MWHPR07MB3117.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR07MB3117;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB3117;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(366004)(51444003)(36092001)(199004)(189003)(14454004)(305945005)(229853002)(25786009)(478600001)(217873002)(106356001)(256004)(93886005)(105586002)(68736007)(6436002)(102836004)(33656002)(76176011)(6506007)(53546011)(186003)(26005)(8676002)(71190400001)(99286004)(81156014)(81166006)(8936002)(71200400001)(446003)(7696005)(110136005)(476003)(74316002)(11346002)(54906003)(86362001)(4326008)(7416002)(6246003)(5660300001)(39060400002)(97736004)(486006)(107886003)(66066001)(6306002)(9686003)(2906002)(55016002)(6116002)(3846002)(7736002)(316002)(53936002)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3117;H:MWHPR07MB3502.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: A/kcxYzIE7R8bwYIk5TFpJ+8vgc21v/wO9L1Y5qEnl3Vwh1sjuEARD7SNgw/vZUb+hcgwUSrfDKdyipfXnXPblFX8mxpGZZBuBromK7rBElDppipgpXJJrijGotXkdDaABlX2Aybs5RZphHgxnrBIJJvWutOJcS0ZLRmAj5K2Dwu/hKGCg470XxwEsqpcJGaGokEl+iFNYT05LP0VjtQeEvdOCY8wH285sAIZYA7UBKOKut1+zfUBCYIInhxpg5L2/uALD4Tyu1FDp+6N6fPS15WXYn8iQ8bph4W71d2HNsvZZgfWMnW6Yja0O6gRgZOhutSaC0q57gXHqjt2JjhT6Vql7M+VYA8tHCPjdWLHgQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0af29d-ab66-4ab9-c508-08d65a8f67f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 08:55:28.8761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3117
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-05_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812050083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGV0ZXIsDQoNCk9uIDA1IERlY2VtYmVyIDIwMTggMDc6MjAsIFBhd2VsIExhc3pjemFrIHdy
b3RlOg0KPiBIaSwNCj4gDQo+ID4+ID4+DQo+ID4+ID4+IFBhdGNoIGFkZHMgY29yZS5jIGFuZCBj
b3JlLmggZmlsZSB0aGF0IGltcGxlbWVudHMgaW5pdGlhbGl6YXRpb24NCj4gPj4gPj4gb2YgcGxh
dGZvcm0gZHJpdmVyIGFuZCBhZGRzIGZ1bmN0aW9uIHJlc3BvbnNpYmxlIGZvciBzZWxlY3Rpbmcs
DQo+ID4+ID4+IHN3aXRjaGluZyBhbmQgcnVubmluZyBhcHByb3ByaWF0ZSBEZXZpY2UvSG9zdCBt
b2RlLg0KPiA+PiA+Pg0KPiA+PiA+PiBTaWduZWQtb2ZmLWJ5OiBQYXdlbCBMYXN6Y3phayA8cGF3
ZWxsQGNhZGVuY2UuY29tPg0KPiA+PiA+PiAtLS0NCj4gPj4gPj4gIGRyaXZlcnMvdXNiL2NkbnMz
L01ha2VmaWxlIHwgICAyICsNCj4gPj4gPj4gIGRyaXZlcnMvdXNiL2NkbnMzL2NvcmUuYyAgIHwg
NDEzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPj4gPj4gIGRyaXZl
cnMvdXNiL2NkbnMzL2NvcmUuaCAgIHwgMTAwICsrKysrKysrKw0KPiA+PiA+PiAgMyBmaWxlcyBj
aGFuZ2VkLCA1MTUgaW5zZXJ0aW9ucygrKQ0KPiA+PiA+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvdXNiL2NkbnMzL2NvcmUuYw0KPiA+PiA+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvdXNiL2NkbnMzL2NvcmUuaA0KPiA+PiA+Pg0KPiA+PiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy91c2IvY2RuczMvTWFrZWZpbGUgYi9kcml2ZXJzL3VzYi9jZG5zMy9NYWtlZmlsZQ0KPiA+PiA+
PiBpbmRleCBkY2RkNjIwMDNjNmEuLjAyZDI1YjIzYzVkMyAxMDA2NDQNCj4gPj4gPj4gLS0tIGEv
ZHJpdmVycy91c2IvY2RuczMvTWFrZWZpbGUNCj4gPj4gPj4gKysrIGIvZHJpdmVycy91c2IvY2Ru
czMvTWFrZWZpbGUNCj4gPj4gPj4gQEAgLTEsMyArMSw1IEBADQo+ID4+ID4+ICtvYmotJChDT05G
SUdfVVNCX0NETlMzKSAgICAgICAgICAgICAgICAgICAgICAgICs9IGNkbnMzLm8NCj4gPj4gPj4g
IG9iai0kKENPTkZJR19VU0JfQ0ROUzNfUENJX1dSQVApICAgICAgICs9IGNkbnMzLXBjaS5vDQo+
ID4+ID4+DQo+ID4+ID4+ICtjZG5zMy15ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDo9IGNvcmUubw0KPiA+PiA+PiAgY2RuczMtcGNpLXkgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgOj0gY2RuczMtcGNpLXdyYXAubw0KPiA+PiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy91c2IvY2RuczMvY29yZS5jIGIvZHJpdmVycy91c2IvY2RuczMvY29yZS5jDQo+ID4+ID4+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4+ID4+IGluZGV4IDAwMDAwMDAwMDAwMC4uZjkwNTVkNGRh
NjdmDQo+ID4+ID4+IC0tLSAvZGV2L251bGwNCj4gPj4gPj4gKysrIGIvZHJpdmVycy91c2IvY2Ru
czMvY29yZS5jDQo+ID4+ID4+IEBAIC0wLDAgKzEsNDEzIEBADQo+ID4+ID4+ICsvLyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+PiA+PiArLyoNCj4gPj4gPj4gKyAqIENhZGVu
Y2UgVVNCU1MgRFJEIERyaXZlci4NCj4gPj4gPj4gKyAqDQo+ID4+ID4+ICsgKiBDb3B5cmlnaHQg
KEMpIDIwMTggQ2FkZW5jZS4NCj4gPj4gPj4gKyAqDQo+ID4+ID4NCj4gPj4gPlBsZWFzZSBhZGQg
TlhQIGNvcHlyaWdodCB0b28uDQo+ID4+DQo+ID4+IE9rLCBJIGRvbid0IGtub3cgd2h5IEkgb21p
dHRlZCB0aGlzLg0KPiA+PiBJIGtub3cgdGhhdCB5b3UgYXJlIHRoZSBtYWluIGF1dGhvciBvZiB0
aGlzIGZpbGUNCj4gPj4gU29ycnkgZm9yIHRoYXQuDQo+ID4+DQo+ID4+IE9uZSBhZGRpdGlvbmFs
IHF1ZXN0aW9uLiBXaGF0IHllYXIgSSBzaG91bGQgYWRkIGluIENvcHlyaWdodCBmb3IgTlhQPy4N
Cj4gPj4gVGhlIG9yaWdpbmFsIHllYXIgMjAxNyBvciBJIHNob3VsZCBtb2RpZmllZCBhbGwgdG8g
MjAxOC4NCj4gPj4NCj4gPlBsZWFzZSB1c2UgYmVsb3cgY29weXJpZ2h0LCB0aGFua3MuDQo+ID4N
Cj4gPkNvcHlyaWdodCAyMDE3LTIwMTggTlhQDQo+IA0KPiBJIGFkZCB0aGlzIGluIGFsbCBmaWxl
cyAgbW9kaWZpZWQgb3IgY3JlYXRlZCBieSB5b3UuDQo+ID4NCj4gPg0KPiA+DQo+ID4+ID4+ICsg
ICAgICAgbXV0ZXhfaW5pdCgmY2Rucy0+bXV0ZXgpOw0KPiA+PiA+PiArDQo+ID4+ID4+ICsgICAg
ICAgY2Rucy0+cGh5ID0gZGV2bV9waHlfZ2V0KGRldiwgImNkbnMzLHVzYnBoeSIpOw0KPiA+PiA+
PiArICAgICAgIGlmIChJU19FUlIoY2Rucy0+cGh5KSkgew0KPiA+PiA+PiArICAgICAgICAgICAg
ICAgZGV2X2luZm8oZGV2LCAibm8gZ2VuZXJpYyBwaHkgZm91bmRcbiIpOw0KPiA+PiA+PiArICAg
ICAgICAgICAgICAgY2Rucy0+cGh5ID0gTlVMTDsNCj4gPj4gPj4gKyAgICAgICAgICAgICAgIC8q
DQo+ID4+ID4+ICsgICAgICAgICAgICAgICAgKiBmYWxsIHRocm91Z2ggaGVyZSENCj4gPj4gPj4g
KyAgICAgICAgICAgICAgICAqIGlmIG5vIGdlbmVyaWMgcGh5IGZvdW5kLCBwaHkgaW5pdA0KPiA+
PiA+PiArICAgICAgICAgICAgICAgICogc2hvdWxkIGJlIGRvbmUgdW5kZXIgYm9vdCENCj4gPj4g
Pj4gKyAgICAgICAgICAgICAgICAqLw0KPiA+PiA+DQo+ID4+ID5JZiB0aGUgcGh5IGRyaXZlciBp
cyBkZWZlci1wcm9iZWQsIGl0IHdpbGwgYmUgaGVyZSwgaXQgaXMgbm90IGFuIGVycm9yLg0KPiA+
PiA+SSB0aGluayB5b3UgY291bGQgaGF2ZSBhIGdlbmVyaWMgcGh5IGRyaXZlciBvciB1c2IgZ2Vu
ZXJpYyBwaHkgZHJpdmVyDQo+ID4+ID4oZHJpdmVycy91c2IvcGh5L3BoeS1nZW5lcmljLmMpIGV2
ZW4geW91IGRvbid0IG5lZWQgYW55IG9wZXJhdGlvbnMgZm9yDQo+ID4+ID5QSFkuIEl0IHdpbGwg
YmUgZWFzeSBmb3Igb3RoZXIgcGxhdGZvcm1zLg0KPiA+Pg0KPiA+PiBZZXMsIFJvZ2VyIGFzayBt
ZSB0byBtb2RpZnkgdGhpcyBmcmFnbWVudC4gSW4gbmV4dCB2ZXJzaW9uIGl0IHdpbGwgbG9vayBs
aWtlOg0KPiA+PiAgICAgICAgIGNkbnMtPnBoeSA9IGRldm1fcGh5X2dldChkZXYsICJjZG5zMyx1
c2JwaHkiKTsNCj4gPj4gICAgICAgICBpZiAoSVNfRVJSKGNkbnMtPnBoeSkpIHsNCj4gPj4gICAg
ICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIoY2Rucy0+cGh5KTsNCj4gPj4gICAgICAgICAgICAg
ICAgIGlmIChyZXQgPT0gLUVOT1NZUyB8fCByZXQgPT0gLUVOT0RFVikgew0KPiA+PiAgICAgICAg
ICAgICAgICAgICAgICAgICBjZG5zLT5waHkgPSBOVUxMOw0KPiA+PiAgICAgICAgICAgICAgICAg
fSBlbHNlIGlmIChyZXQgPT0gLUVQUk9CRV9ERUZFUikgew0KPiA+PiAgICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gcmV0Ow0KPiA+PiAgICAgICAgICAgICAgICAgfSBlbHNlIHsNCj4gPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJubyBwaHkgZm91bmRcbiIpOw0K
PiA+PiAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycjA7DQo+ID4+ICAgICAgICAgICAg
ICAgICB9DQo+ID4+ICAgICAgICAgfQ0KPiA+Pg0KPiA+PiAgICAgICAgIHBoeV9pbml0KGNkbnMt
PnBoeSk7DQo+ID4+DQo+ID4+IFdlIGFyZSBnb2luZyB0byB1c2UgcGh5IGRyaXZlci4gSSBkb24n
dCBrbm93IGlmIGl0IGNvcnJlY3QuDQo+ID4+IEkgZG9uJ3QgaGF2ZSBleHBlcmllbmNlIGluIHRo
aXMgZmlsZWQuDQo+ID4+IFdlIG5lZWQgcGh5IGluaXRpYWxpemF0aW9uIGJ1dCBJIGRvbid0IGhh
dmUgdGVzdGluZyBwbGF0Zm9ybSBub3cuDQo+ID4+IEluIG1vc3QgdXNiIGRyaXZlcnMgSSBzZWUg
dGhhdCB0aGVyZSBhcmUgdXNlZCB1c2IgcGh5IGRyaXZlcmQgaW5zdGVhZCBwaHkgZGlydmVyZC4N
Cj4gPj4NCj4gPg0KPiA+QXQgbXkgQ0ROUzMgcGxhdGZvcm0sIHRoZXJlIGFyZSBzb21lIFVTQiBQ
SFkgaW5pdGlhbGl6YXRpb24gZm9yIHJlZ2lzdGVyIHNldHRpbmcNCj4gPmFuZCBjbG9jayBlbmFi
bGUuIFlvdSBjb3VsZCBhZGQgZ2VuZXJpYyBQSFkgZHJpdmVyIHVuZGVyOiBkcml2ZXJzL3BoeS9j
YWRlbmNlLy4NCj4gPg0KPiA+QWJvdmUgUEhZIGluaXRpYWxpemF0aW9uIGNvZGUgaXMgT0sgZm9y
IG1lLg0KPiANCj4gSXQgd2lsbCBiZSBhZGRlZCBhcyBzZXBhcmF0ZSBkcml2ZXIuDQo+IEkgdGhp
bmsgdGhhdCBBbGxhbiBEb3VnbGFzIHdvcmtpbmcgb24gaXQuDQo+IEkgYXNrIGhpbSB0byBhZGQg
eW91IHRvIC1jYyBpbiBwYXRjaCBmb3IgcGh5Lg0KUGF0Y2ggc2VyaWVzIGZvciB0aGUgY2FkZW5j
ZSBTaWVycmEgZ2VuZXJpYyBQSFkgZHJpdmVyIGNhbiBiZSBmb3VuZCBoZXJlOg0KaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvcGF0Y2h3b3JrL2NvdmVyLzEwMTE0ODYvDQoNCkl0IGNhbiBhbHNvIGJl
IGZvdW5kIGluIEtpc2hvbidzIGxpbnV4LXBoeSBnaXQgdHJlZSBhdA0KICAgIGdpdDovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9raXNob24vbGludXgtcGh5LmdpdA0K
aW4gdGhlICduZXh0JyBicmFuY2guDQoNCkl0IHdpbGwgYmUgZ3JlYXQgaWYgeW91IGFyZSBhYmxl
IHRvIHRha2UgYSBsb29rIGF0IGl0Lg0KDQpSZWdhcmRzLA0KQWxhbg0K
