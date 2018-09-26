Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8590FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2153121546
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="R8c1z2f/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2153121546
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeI0AKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:10:55 -0400
Received: from mail-eopbgr720072.outbound.protection.outlook.com ([40.107.72.72]:39264
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727280AbeI0AKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aMDlrTMbEztT/faE8GaQTY7MKAUI52BC4zEXkvW2q8=;
 b=R8c1z2f/Gpur9pa90vfqACRunfGxa7PHyL5aWgVwRTGrFlcjCF/gJEzXx1xb5pKQ3OZ9L2+VEiFyCegzNtfGhx6dr67P4pVOfN34tO5NgHB8JO90LEpN20Ri6dch+Y1gjbeZrOBIctf7HxjxVg5Kra9O/HPk/H2D8piguSYO6Jw=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4455.namprd05.prod.outlook.com (52.135.203.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.8; Wed, 26 Sep 2018 17:56:07 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1cc9:412c:6f6b:e0ae]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1cc9:412c:6f6b:e0ae%5]) with mapi id 15.20.1185.019; Wed, 26 Sep 2018
 17:56:07 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>
CC:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH v8 02/10] Makefile: Prepare for using macros for inline
 asm
Thread-Topic: [PATCH v8 02/10] Makefile: Prepare for using macros for inline
 asm
Thread-Index: AQHUT5bXKvBkh+LIPE6RXFqGVNbGXKUCTuyAgACWSoA=
Date:   Wed, 26 Sep 2018 17:56:06 +0000
Message-ID: <307823F9-DCCF-4384-9FBE-28642FAD6B4E@vmware.com>
References: <20180918212847.199085-1-namit@vmware.com>
 <20180918212847.199085-3-namit@vmware.com>
 <1aa5a1f3-ef3d-5cd3-831c-2202d73d3c9e@rasmusvillemoes.dk>
In-Reply-To: <1aa5a1f3-ef3d-5cd3-831c-2202d73d3c9e@rasmusvillemoes.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4455;20:TmKCQ3w/C2Uhfk8Tov0v8G4m08gkW2EcowDd8p62IJvXlr0vtQ6WpaKECt0DYH0NEd86C9fITrpAhB0s0q7BKTRJ+GhM8Y+/8DDilFbeDrM47BfKFcb91J/QR3odpkA2OIkKuoujZRPhuFuig9ACe/6Yv2K0ZzLSIpMi67GgXyA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 066b8e0f-ae7e-4aeb-3f13-08d623d95599
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4455;
x-ms-traffictypediagnostic: BYAPR05MB4455:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB4455A537643E390A9E82D793D0150@BYAPR05MB4455.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:BYAPR05MB4455;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4455;
x-forefront-prvs: 08076ABC99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(376002)(136003)(346002)(189003)(199004)(105586002)(76176011)(14444005)(256004)(4326008)(25786009)(36756003)(229853002)(316002)(2900100001)(81166006)(81156014)(106356001)(54906003)(110136005)(86362001)(8676002)(82746002)(11346002)(3846002)(6506007)(26005)(33656002)(2616005)(476003)(97736004)(66066001)(8936002)(6486002)(6436002)(5250100002)(6512007)(53546011)(6116002)(53936002)(486006)(102836004)(34290500001)(71190400001)(6246003)(5660300001)(68736007)(186003)(71200400001)(446003)(478600001)(83716004)(99286004)(305945005)(7736002)(2906002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4455;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Tad52jQJE6cxBB4wawPr/0wAGaHuZmRloiWYtDkhZ0d5i66JacUJqr1A0kdh46uqLHUMFr/o0qeo52+JBV2ZZKYiiA7WPzd9WMFDBE4tGYOYTzJNDu7xYLg+5VJY7wINE4WkHHFh9MIOHLi8YUJSFOygrJmynHYDJg6Umid/CAvGJJXP9C+y1Ngq3k+lUQeYsOGJBqY6tkO+66aEl+3dl1m+nHi/DKiFVfPw2mh0kauKfFtkHjBHZLnLFEwdZYQpim/hNYbwKwMo9jkbtU0pDj/HALQJ9uoF6lwkfYJgWdaQrOKmq5gS4i/MYoetVKoLfxWbmyHi/7B0TmE1GxEitVmeWSuDpOqabsVnT6vmd3s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D04A32E8904B7F4982D807F1D11DF753@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 066b8e0f-ae7e-4aeb-3f13-08d623d95599
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2018 17:56:06.8674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMTo1OCBBTSwgUmFzbXVzIFZpbGxlbW9lcyA8bGludXhAcmFzbXVzdmlsbGVtb2VzLmRrPiB3
cm90ZToNCg0KPiBPbiAyMDE4LTA5LTE4IDIzOjI4LCBOYWRhdiBBbWl0IHdyb3RlOg0KPiANCj4+
IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9NYWtlZmlsZSBiL2FyY2gveDg2L01ha2VmaWxlDQo+PiBp
bmRleCA4ZjZlN2ViOGFlOWYuLjk0NGZhM2JjOTM3NiAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2
L01ha2VmaWxlDQo+PiArKysgYi9hcmNoL3g4Ni9NYWtlZmlsZQ0KPj4gQEAgLTIxNCw4ICsyMTQs
OCBAQCBpZmRlZiBDT05GSUdfWDg2XzY0DQo+PiBLQlVJTERfTERGTEFHUyArPSAkKGNhbGwgbGQt
b3B0aW9uLCAteiBtYXgtcGFnZS1zaXplPTB4MjAwMDAwKQ0KPj4gZW5kaWYNCj4+IA0KPj4gLSMg
U3BlZWQgdXAgdGhlIGJ1aWxkDQo+PiAtS0JVSUxEX0NGTEFHUyArPSAtcGlwZQ0KPj4gKyMgV2Ug
Y2Fubm90IHVzZSAtcGlwZSBmbGFnIHNpbmNlIHdlIGdpdmUgYW4gYWRkaXRpb25hbCAucyBmaWxl
IHRvIHRoZSBjb21waWxlcg0KPj4gKyNLQlVJTERfQ0ZMQUdTICs9IC1waXBlDQo+IA0KPiBJcyB0
aGlzIHJlYWxseSBuZWNlc3Nhcnk/IFRoZSBnYXMgbWFudWFsIHNheXMgdGhhdCBvbmUgY2FuIHVz
ZSAtLSB0bw0KPiBuYW1lIHN0ZGluLCB0aG91Z2ggdGhhdCdzIHByb2JhYmx5IGEgdHlwbyBhbmQg
c2hvdWxkIGp1c3QgYmUgLSAuIERvaW5nDQo+IA0KPiBnY2MgLXBpcGUgLVdhLGZvby5zIC1XYSwt
DQoNCkdvb2QgaWRlYS4gSSBkaWRu4oCZdCB0aGluayBvZiBpdC4gWWVzLCB0aGlzIGNhbiBkbyB0
aGUgdHJpY2suIEnigJlsbCBkbyBpdCBpbg0KdjkuDQoNCj4gZG9lcyBzZWVtIHRvIHdvcmsgYXMg
ZXhwZWN0ZWQgKGFuZCB3b3VsZCBhbHNvIG1ha2UgaXQgcG9zc2libGUgdG8gYXBwZW5kDQo+IHNv
bWUgLnMgZmlsZSBzaG91bGQgdGhhdCBldmVyIGJlIHJlcXVpcmVkKS4NCj4+ICthcmNobWFjcm9z
Og0KPj4gKwkkKFEpJChNQUtFKSAkKGJ1aWxkKT1hcmNoL3g4Ni9rZXJuZWwgYXJjaC94ODYva2Vy
bmVsL21hY3Jvcy5zDQo+PiArDQo+PiArQVNNX01BQ1JPX0ZMQUdTID0gLVdhLGFyY2gveDg2L2tl
cm5lbC9tYWNyb3Mucw0KPj4gK2V4cG9ydCBBU01fTUFDUk9fRkxBR1MNCj4+ICtLQlVJTERfQ0ZM
QUdTICs9ICQoQVNNX01BQ1JPX0ZMQUdTKQ0KPiBIb3cgZG9lcyB0aGlzIGFmZmVjdCB3aGF0IGdl
dHMgcmVidWlsdCB3aGVuIG9uZSBvZiB0aGUgYXNtL2Zvby5oIGZpbGVzDQo+IGdvaW5nIGludG8g
bWFjcm9zLnMgY2hhbmdlcz8gRG9lcyB0aGF0IGNhdXNlIGEgZ2xvYmFsIHJlYnVpbGQgYmVjYXVz
ZQ0KPiBldmVyeXRoaW5nIGRlcGVuZHMgb24gbWFjcm9zLnMsIG9yIGRvIHdlIHN0aWxsIG9ubHkg
cmVidWlsZCB0aGUgZmlsZXMNCj4gdGhhdCBhY3R1YWxseSBpbmNsdWRlIGFzbS9mb28uaD8NCg0K
VGhlcmUgd2lsbCBub3QgYmUgYSBnbG9iYWwgcmVidWlsZC4gQW55IHNvdXJjZSBmaWxlIHRoYXQg
dXNlcyB0aGUgaGVhZGVyDQpmaWxlcyB0aGF0IGFyZSBpbmNsdWRlZCBpbiBtYWNyb3MuUyB3aWxs
IGJlIHJlYnVpbHQuDQoNCkJ1dCB5b3VyIHF1ZXN0aW9uIGFjdHVhbGx5IHJhaXNlcyB0d28gaXNz
dWVzOg0KDQoxLiBJZiBtYWNyb3MuUyBjaGFuZ2VzLCB0aGVyZSAqc2hvdWxkKiBiZSBhIGdsb2Jh
bCByZWJ1aWxkLCBhbmQgY3VycmVudGx5DQp0aGVyZSB3b3VsZG7igJl0IGJlIG9uZS4gRG8geW91
IGhhcHBlbiB0byBrbm93IHdoYXQgd291bGQgYmUgdGhlIGFwcHJvcHJpYXRlDQp3YXkgdG8gdHJp
Z2dlciBvbmU/DQoNCjIuIFNvbWVvbmUgbWlnaHQgbWlzdGFrZW5seSB1c2UgdGhlIG1hY3JvcyB0
aHJvdWdoIGlubGluZSBhc3NlbWJseSB3aXRob3V0DQppbmNsdWRpbmcgdGhlIGhlYWRlciBmaWxl
LiBJdCB3b3VsZCBiZSBiZXR0ZXIgdG8gZGV0ZWN0IHN1Y2ggY2FzZXMgYW5kIGZhaWwNCnRoZSBi
dWlsZC4gSSBtYXkgYmUgYWJsZSB0byBjcmVhdGUgYW5vdGhlciBhc20gbWFjcm8gaW4gdGhlIEMg
cGFydCBvZiB0aGUNCmhlYWRlciB0aGF0IHdvdWxkIGNhdXNlIHRoZSBidWlsZCB0byBmYWlsLiBC
dXQgbGV0IG1lIGtub3cgaWYgeW91IGFueQ0KYmV0dGVyIGlkZWEuDQoNClJlZ2FyZHMsDQpOYWRh
dg0KDQo=
