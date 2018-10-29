Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5BEC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0642081B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="flHfyhRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0642081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbeJ2UEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 16:04:32 -0400
Received: from mail-he1eur01on0093.outbound.protection.outlook.com ([104.47.0.93]:6466
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726720AbeJ2UEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 16:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhYAUXT9TrHSb50xK7dMMkYz+tGAQktxBNYXvCCIZAQ=;
 b=flHfyhRNDnnt33t7cVWeaXe1ggMAOn85kTd5EntwdfLLtF2GJXpgjSBYljJ0EF5ecM79iZXm5KDpxf1LR5MxIp9+YPTz1/rsLPDrnhDwjhjUYXPjG4+4h4te9nM3nuOkCWRQLSm4v0ypt1Y2zkRfOSdiKK6RjTDCq5hWWFViRUk=
Received: from DB7PR08MB3258.eurprd08.prod.outlook.com (52.134.111.20) by
 DB7PR08MB3660.eurprd08.prod.outlook.com (20.177.120.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.25; Mon, 29 Oct 2018 11:16:15 +0000
Received: from DB7PR08MB3258.eurprd08.prod.outlook.com
 ([fe80::9015:d3f0:49b0:3c4e]) by DB7PR08MB3258.eurprd08.prod.outlook.com
 ([fe80::9015:d3f0:49b0:3c4e%4]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 11:16:15 +0000
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Will Deacon <will.deacon@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kyeongdon Kim <kyeongdon.kim@lge.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 2/3] arm64: lib: use C string functions with KASAN
 enabled.
Thread-Topic: [PATCH v2 2/3] arm64: lib: use C string functions with KASAN
 enabled.
Thread-Index: AQHUUOm30ardQOGNO0efxuU6827od6U2QrGAgAANSoA=
Date:   Mon, 29 Oct 2018 11:16:15 +0000
Message-ID: <9cf4a5ff-b68d-5703-720a-bce05409428a@virtuozzo.com>
References: <20180914152800.GB6236@arm.com>
 <20180920135631.23833-1-aryabinin@virtuozzo.com>
 <20180920135631.23833-2-aryabinin@virtuozzo.com>
 <20181029102922.GC14127@arm.com>
In-Reply-To: <20181029102922.GC14127@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0102CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:14::28) To DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR08MB3660;20:klB7FR+jToNFx/KXbCyREJGH7jnudNH5j3p+G3bAKfs54ink+0Om1PfV/o8sSTeoqsYpsn/BN6SVwjCHjLSAdQ4AbHLEvPqdDnoRml84pGFrWzLcpfZqvaNRMktVaFnLqwF3KXzWKmz4WBJ8/LjjZ2Cq3/GPaTg+h8ML33kpDrE=
x-ms-office365-filtering-correlation-id: ee72dd5b-9678-440f-1c56-08d63d8ff0a9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3660;
x-ms-traffictypediagnostic: DB7PR08MB3660:
x-microsoft-antispam-prvs: <DB7PR08MB3660901991907A32CA4EBD6BB0F30@DB7PR08MB3660.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(180628864354917)(211936372134217)(153496737603132);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231382)(944501410)(4982022)(52105095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR08MB3660;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3660;
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(39840400004)(396003)(366004)(189003)(199004)(14444005)(8676002)(14454004)(106356001)(81166006)(26005)(81156014)(54906003)(966005)(25786009)(186003)(6486002)(256004)(6246003)(6916009)(3846002)(6116002)(31686004)(6306002)(6436002)(7736002)(71190400001)(97736004)(102836004)(71200400001)(7416002)(6512007)(305945005)(2906002)(478600001)(105586002)(6346003)(36756003)(53936002)(8936002)(86362001)(486006)(4326008)(31696002)(68736007)(316002)(446003)(11346002)(476003)(2900100001)(5250100002)(229853002)(53546011)(386003)(6506007)(76176011)(99286004)(5660300001)(66066001)(52116002)(93886005)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3660;H:DB7PR08MB3258.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
x-microsoft-antispam-message-info: qKPnStPsLl8PrCAkzO9B13kIicCBvo8OEPOCF5hkOvXLjB5eZYLW2GAPdgu5WbXbOhe/ZFFUDvriX5O1pxDM6OSuCLw9zyBiuESaoMV4rCZjhEnt+uMKNvpXMEY61JsUxf/SIAvXPikVguGrfE72GVHmhNvLcqECcUu0QqJIPquIZB9fLinNyZXGjWGOBKssqTH4LGL0gteYiF2uQYOLEsygTLojaLTEQ7EgqFg8kaqNj54JsNyM8jsYlw9JzCwh4sEI0cLTiUiJqD+JllhJzW7SUp+YtP4aSFo+bhDGXVtvToD/U8F2idBLCueYK0RPmX8z6lafyeRS/ZRVugjd6dskLjoT5EU9WrD1N/JK6Ww=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7911F4531723C2418882CC1F599F481D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee72dd5b-9678-440f-1c56-08d63d8ff0a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 11:16:15.2517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3660
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzI5LzIwMTggMDE6MjkgUE0sIFdpbGwgRGVhY29uIHdyb3RlOg0KPiBPbiBUaHUs
IFNlcCAyMCwgMjAxOCBhdCAwNDo1NjozMFBNICswMzAwLCBBbmRyZXkgUnlhYmluaW4gd3JvdGU6
DQo+PiBBUk02NCBoYXMgYXNtIGltcGxlbWVudGF0aW9uIG9mIG1lbWNocigpLCBtZW1jbXAoKSwg
c3RyW3JdY2hyKCksDQo+PiBzdHJbbl1jbXAoKSwgc3RyW25dbGVuKCkuIEtBU0FOIGRvbid0IHNl
ZSBtZW1vcnkgYWNjZXNzZXMgaW4gYXNtDQo+PiBjb2RlLCB0aHVzIGl0IGNhbiBwb3RlbnRpYWxs
eSBtaXNzIG1hbnkgYnVncy4NCj4+DQo+PiBJZmRlZiBvdXQgX19IQVZFX0FSQ0hfKiBkZWZpbmVz
IG9mIHRoZXNlIGZ1bmN0aW9ucyB3aGVuIEtBU0FOIGlzDQo+PiBlbmFibGVkLCBzbyB0aGUgZ2Vu
ZXJpYyBpbXBsZW1lbnRhdGlvbnMgZnJvbSBsaWIvc3RyaW5nLmMgd2lsbCBiZSB1c2VkLg0KPj4N
Cj4+IFdlIGNhbid0IGp1c3QgcmVtb3ZlIHRoZSBhc20gZnVuY3Rpb25zIGJlY2F1c2UgZWZpc3R1
YiB1c2VzIHRoZW0uDQo+PiBBbmQgd2UgY2FuJ3QgaGF2ZSB0d28gbm9uLXdlYWsgZnVuY3Rpb25z
IGVpdGhlciwgc28gZGVjbGFyZSB0aGUgYXNtDQo+PiBmdW5jdGlvbnMgYXMgd2Vhay4NCj4+DQo+
PiBSZXBvcnRlZC1ieTogS3llb25nZG9uIEtpbSA8a3llb25nZG9uLmtpbUBsZ2UuY29tPg0KPj4g
U2lnbmVkLW9mZi1ieTogQW5kcmV5IFJ5YWJpbmluIDxhcnlhYmluaW5AdmlydHVvenpvLmNvbT4N
Cj4+IC0tLQ0KPj4gQ2hhbmdlcyBzaW5jZSB2MToNCj4+ICAtIFVzZSBXRUFLKCkgaW5zdGVhZCBv
ZiAud2Vhaw0KPj4NCj4+ICBhcmNoL2FybTY0L2luY2x1ZGUvYXNtL3N0cmluZy5oIHwgMTQgKysr
KysrKystLS0tLS0NCj4+ICBhcmNoL2FybTY0L2tlcm5lbC9hcm02NGtzeW1zLmMgIHwgIDcgKysr
KystLQ0KPj4gIGFyY2gvYXJtNjQvbGliL21lbWNoci5TICAgICAgICAgfCAgMiArLQ0KPj4gIGFy
Y2gvYXJtNjQvbGliL21lbWNtcC5TICAgICAgICAgfCAgMiArLQ0KPj4gIGFyY2gvYXJtNjQvbGli
L3N0cmNoci5TICAgICAgICAgfCAgMiArLQ0KPj4gIGFyY2gvYXJtNjQvbGliL3N0cmNtcC5TICAg
ICAgICAgfCAgMiArLQ0KPj4gIGFyY2gvYXJtNjQvbGliL3N0cmxlbi5TICAgICAgICAgfCAgMiAr
LQ0KPj4gIGFyY2gvYXJtNjQvbGliL3N0cm5jbXAuUyAgICAgICAgfCAgMiArLQ0KPj4gIGFyY2gv
YXJtNjQvbGliL3N0cm5sZW4uUyAgICAgICAgfCAgMiArLQ0KPj4gIGFyY2gvYXJtNjQvbGliL3N0
cnJjaHIuUyAgICAgICAgfCAgMiArLQ0KPj4gIDEwIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlv
bnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiANCj4gQWNrZWQtYnk6IFdpbGwgRGVhY29uIDx3aWxs
LmRlYWNvbkBhcm0uY29tPg0KPiANCj4gUGxlYXNlIHBvc3QgdGhlc2UgYWdhaW4gYWZ0ZXIgdGhl
IG1lcmdlIHdpbmRvdyBhbmQgd2UnbGwgZmlndXJlIG91dCBob3cgdG8NCj4gZ2V0IHRoZW0gcXVl
dWVkLg0KPiANCg0KDQpBbmRyZXcgc2VudCB0aGVzZSBwYXRjaGVzIHRvIExpbnVzIGNvdXBsZSBk
YXlzIGFnbywgc28gdGhleSBhcmUgaW4gdHJlZSBhbHJlYWR5Lg0KDQpTb21ldGhpbmcgd2VudCB3
cm9uZyB3aXRoIG1haWwgbm90aWZpY2F0aW9uIHRob3VnaC4gSSBkaWRuJ3QgZXZlbiByZWFsaXpl
IHRoYXQgdGhleQ0Kd2VyZSBpbiAtbW0gdHJlZSwgYmVjYXVzZSBJIGRpZG4ndCByZWNlaXZlIHRo
ZSB1c3VhbCAndGhlIHBhdGNoIGhhcyBiZWVuIGFkZGVkIHRvIC1tbSB0cmVlJyBlbWFpbC4NCkJ1
dCBJIGRpZCByZWNlaXZlIGVtYWlsIHRoYXQgd2FzIHNlbnQgdG8gTGludXMuDQoNCkFsc28gdGhl
cmUgd2FzIG5vIHlvdSBvciBDYXRhbGluIGluIENjIHRhZ3MgaW4gMiwzIHBhdGNoZXMsIGFuZCBp
biB0aGUgZmlyc3QgcGF0Y2gsIHRoZSBDYyB0YWdzIHdlcmUNCmNvcnJ1cHRlZDoNCg0KRnJvbTog
QW5kcmV5IFJ5YWJpbmluIDxhcnlhYmluaW5AdmlydHVvenpvLmNvbT4NClN1YmplY3Q6IGluY2x1
ZGUvbGludXgvbGlua2FnZS5oOiBhbGlnbiB3ZWFrIHN5bWJvbHMNCg0KU2luY2UgV0VBSygpIHN1
cHBvc2VkIHRvIGJlIHVzZWQgaW5zdGVhZCBvZiBFTlRSWSgpIHRvIGRlZmluZSB3ZWFrDQpzeW1i
b2xzLCBidXQgdW5saWtlIEVOVFJZKCkgaXQgZG9lc24ndCBoYXZlIEFMSUdOIGRpcmVjdGl2ZS4g
IEl0IHNlZW1zDQp0aGVyZSBpcyBubyBhY3R1YWwgcmVhc29uIHRvIG5vdCBoYXZlLCBzbyBsZXQn
cyBhZGQgQUxJR04gdG8gV0VBSygpIHRvby4NCg0KTGluazogaHR0cDovL2xrbWwua2VybmVsLm9y
Zy9yLzIwMTgwOTIwMTM1NjMxLjIzODMzLTEtYXJ5YWJpbmluQHZpcnR1b3p6by5jb20NClNpZ25l
ZC1vZmYtYnk6IEFuZHJleSBSeWFiaW5pbiA8YXJ5YWJpbmluQHZpcnR1b3p6by5jb20+DQpXaWxs
IERlYWNvbiA8d2lsbC5kZWFjb25AYXJtLmNvbT4sIENhdGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5t
YXJpbmFzQGFybS5jb20+DQpDYzogS3llb25nZG9uIEtpbSA8a3llb25nZG9uLmtpbUBsZ2UuY29t
Pg0KQ2M6IEFyZCBCaWVzaGV1dmVsIDxhcmQuYmllc2hldXZlbEBsaW5hcm8ub3JnPg0KQ2M6IEFs
ZXhhbmRlciBQb3RhcGVua28gPGdsaWRlckBnb29nbGUuY29tPg0KQ2M6IERtaXRyeSBWeXVrb3Yg
PGR2eXVrb3ZAZ29vZ2xlLmNvbT4NCkNjOiBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0u
Y29tPg0KU2lnbmVkLW9mZi1ieTogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9u
Lm9yZz4NCg==
