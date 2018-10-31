Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DCDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F402054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="QTfQubTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F402054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbeKAAhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:37:25 -0400
Received: from mail-ty1jpn01on0125.outbound.protection.outlook.com ([104.47.93.125]:24307
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728848AbeKAAhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXd/9NoR/FGIafpwqzwzrt/Ea1VU1GI1BpsKUkIN+4c=;
 b=QTfQubTqSdxy+r2zg6Fdc8rBlHqCoPC+p22ZXtj0c6VE5+0InAQFbuqpg/PXiAQXIEOJmVM+nj4kU/9qAmfNdP3cm6QYqwidCHtciRF2SXTRzXtjv4RWHkhp1i8IDaR19TvJ4Sennv1y7qc/SmAfX7KSmfFsuRmXv0C0ZFiFZeo=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1802.jpnprd01.prod.outlook.com (52.133.164.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.26; Wed, 31 Oct 2018 15:38:48 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6%4]) with mapi id 15.20.1273.028; Wed, 31 Oct 2018
 15:38:48 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] irqchip: Add support for Renesas RZ/N1 GPIO
 interrupt multiplexer
Thread-Topic: [PATCH v2 2/2] irqchip: Add support for Renesas RZ/N1 GPIO
 interrupt multiplexer
Thread-Index: AQHUcD2lJIxNUCxga0G4J4tYz/ve2aU4/58AgABgR3CAAB0GAIAAAMBg
Date:   Wed, 31 Oct 2018 15:38:48 +0000
Message-ID: <TY1PR01MB1769D6F84F7BCD91C1018922F5CD0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20181030104438.27827-1-phil.edworthy@renesas.com>
 <20181030104438.27827-3-phil.edworthy@renesas.com>
 <86d0rq35o1.wl-marc.zyngier@arm.com>
 <TY1PR01MB176959B0CF663D0ECB298924F5CD0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <b95c7fc3-7fda-48b7-6933-b7b183b6fa67@arm.com>
In-Reply-To: <b95c7fc3-7fda-48b7-6933-b7b183b6fa67@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1802;20:+8IbUzpoo2j/LJY3lo5DCDuz/4w17blcBD1vZlpQJiU7X6KBQIN2tFLMt6xFNxleCHCRNRqXXWIzkSqhzupwkirRbmw9v/6tvE6l0Wzsyyixfkvu/Y0sZdP73vfNzRTJwgsvqG09t241pGcD8kE1G0huXOz9yUtGK3KmTbEo5OA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: df0b8dd4-886c-4825-09b7-08d63f46f35a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1802;
x-ms-traffictypediagnostic: TY1PR01MB1802:
x-microsoft-antispam-prvs: <TY1PR01MB1802857CA9FF2CA7846924FAF5CD0@TY1PR01MB1802.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1802;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1802;
x-forefront-prvs: 084285FC5C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(39860400002)(346002)(376002)(199004)(189003)(25786009)(4326008)(8676002)(316002)(53546011)(106356001)(102836004)(33656002)(44832011)(93886005)(105586002)(6506007)(26005)(66066001)(81166006)(81156014)(71190400001)(71200400001)(6916009)(76176011)(7736002)(305945005)(5250100002)(74316002)(478600001)(229853002)(8936002)(7696005)(99286004)(68736007)(9686003)(6116002)(3846002)(5660300001)(2906002)(55016002)(476003)(256004)(11346002)(6246003)(186003)(6436002)(97736004)(14454004)(2900100001)(446003)(86362001)(486006)(54906003)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1802;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RESVQhIWtH2xDx/SKAbJPXueWCMcCwwDDl19HDYY16d3Kuu0R7Y0w/9irUraRVQYMq8EHmzPBkjb+pyrX2K57hGyomrD4f7ONeEWE/KKNlfLKYVpV3zDgiH5GcvX5aqiEC8QQwh7BRBUDmGy2q3weyDTlAQh36AjadMjaYKRVcp6CIZzdGoTUdoL+IJTcCWcW4GUWlxCVWmhs1uFhDpoeHrDyD2GaXpf3JRz5SnOIIpIZ3+fo3oppWzpvqqOnMHODVVHxbHbTh9TW6uJIS9Y67KZgyF5wJf3+s4tqgmqaxxSOcT1Dq2TmBHjiY5Utvmc6EvJOdzgXo1EHsGX130GS3KHMUMgX797m8dqnAg99wA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0b8dd4-886c-4825-09b7-08d63f46f35a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2018 15:38:48.0809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1802
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyYywNCg0KT24gMzEgT2N0b2JlciAyMDE4IDE1OjMxLCBNYXJjIFp5bmdpZXIgd3JvdGU6
DQo+IE9uIDMxLzEwLzE4IDE1OjA5LCBQaGlsIEVkd29ydGh5IHdyb3RlOg0KPiA+IE9uIDMxIE9j
dG9iZXIgMjAxOCAwODowMiwgTWFyYyBaeW5naWVyIHdvdGU6DQo+ID4+IE9uIFR1ZSwgMzAgT2N0
IDIwMTggMTA6NDQ6MzggKzAwMDAsIFBoaWwgRWR3b3J0aHkgd3JvdGU6DQo+ID4+Pg0KPiA+Pj4g
T24gUlovTjEgZGV2aWNlcywgdGhlcmUgYXJlIDMgU3lub3BzeXMgRGVzaWduV2FyZSBHUElPIGJs
b2NrcyBlYWNoDQo+ID4+PiBjb25maWd1cmVkIHRvIGhhdmUgMzIgaW50ZXJydXB0IG91dHB1dHMs
IHNvIHdlIGhhdmUgYSB0b3RhbCBvZiA5Ng0KPiA+Pj4gR1BJTyBpbnRlcnJ1cHRzLiBBbGwgb2Yg
dGhlc2UgYXJlIHBhc3NlZCB0byB0aGUgR1BJTyBJUlEgTXV4ZXIsDQo+ID4+PiB3aGljaCBzZWxl
Y3RzDQo+ID4+PiA4IG9mIHRoZSBHUElPIGludGVycnVwdHMgdG8gcGFzcyBvbnRvIHRoZSBHSUMu
IFRoZSBpbnRlcnJ1cHQgc2lnbmFscw0KPiA+Pj4gYXJlbid0IGxhdGNoZWQsIHNvIHRoZXJlIGlz
IG5vdGhpbmcgdG8gZG8gaW4gdGhpcyBkcml2ZXIgd2hlbiBhbg0KPiA+Pj4gaW50ZXJydXB0IGlz
IHJlY2VpdmVkLCBvdGhlciB0aGFuIHRlbGwgdGhlIGNvcnJlc3BvbmRpbmcgR1BJTyBibG9jay4N
Cj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBQaGlsIEVkd29ydGh5IDxwaGlsLmVkd29ydGh5
QHJlbmVzYXMuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiB2MjoNCj4gPj4+ICAtIFVzZSBpbnRlcnJ1
cHQtbWFwIHRvIGFsbG93IHRoZSBHUElPIGNvbnRyb2xsZXIgaW5mbyB0byBiZSBzcGVjaWZpZWQN
Cj4gPj4+ICAgIGFzIHBhcnQgb2YgdGhlIGlycS4NCj4gPj4+ICAtIFJlbmFtZWQgc3RydWN0IGFu
ZCBmdW5jcyBmcm9tICdnaXJxJyB0byBhIG1vcmUgY29tcHJlaGVuaXNibGUNCj4gJ2lycW11eCcu
DQo+ID4+PiAtLS0NCj4gPj4+ICBkcml2ZXJzL2lycWNoaXAvS2NvbmZpZyAgICAgICAgfCAgMTAg
KysNCj4gPj4+ICBkcml2ZXJzL2lycWNoaXAvTWFrZWZpbGUgICAgICAgfCAgIDEgKw0KPiA+Pj4g
IGRyaXZlcnMvaXJxY2hpcC9yem4xLWlycS1tdXguYyB8IDIzNQ0KPiA+Pj4gKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ID4+PiAgMyBmaWxlcyBjaGFuZ2VkLCAyNDYgaW5zZXJ0
aW9ucygrKQ0KPiA+Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lycWNoaXAvcnpuMS1p
cnEtbXV4LmMNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pcnFjaGlwL0tjb25m
aWcgYi9kcml2ZXJzL2lycWNoaXAvS2NvbmZpZyBpbmRleA0KPiA+Pj4gOTY0NTFiNTgxNDUyLi4z
YTYwYThhZjYwZGQgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL2lycWNoaXAvS2NvbmZpZw0K
PiA+Pj4gKysrIGIvZHJpdmVycy9pcnFjaGlwL0tjb25maWcNCj4gPj4+IEBAIC0yMDQsNiArMjA0
LDE2IEBAIGNvbmZpZyBSRU5FU0FTX0lSUUMNCj4gPj4+ICAJc2VsZWN0IEdFTkVSSUNfSVJRX0NI
SVANCj4gPj4+ICAJc2VsZWN0IElSUV9ET01BSU4NCj4gPj4+DQo+ID4+PiArY29uZmlnIFJFTkVT
QVNfUlpOMV9JUlFfTVVYDQo+ID4+PiArCWJvb2wgIlJlbmVzYXMgUlovTjEgR1BJTyBJUlEgbXVs
dGlwbGV4ZXIgc3VwcG9ydCINCj4gPj4+ICsJZGVwZW5kcyBvbiBBUkNIX1JaTjENCj4gPj4+ICsJ
c2VsZWN0IElSUV9ET01BSU4NCj4gPj4+ICsJc2VsZWN0IElSUV9ET01BSU5fSElFUkFSQ0hZDQo+
ID4+PiArCWhlbHANCj4gPj4+ICsJICBTYXkgeWVzIGhlcmUgdG8gYWRkIHN1cHBvcnQgZm9yIHRo
ZSBHUElPIElSUSBtdWx0aXBsZXhlcg0KPiA+PiBlbWJlZGRlZA0KPiA+Pj4gKwkgIGluIFJlbmVz
YXMgUlovTjEgU29DIGRldmljZXMuIFRoZSBHUElPIElSUSBNdXhlciBzZWxlY3RzIHdoaWNoIG9m
DQo+ID4+PiArCSAgdGhlIGludGVycnVwdHMgY29taW5nIGZyb20gdGhlIEdQSU8gY29udHJvbGxl
cnMgYXJlIHVzZWQuDQo+ID4+PiArDQo+ID4+PiAgY29uZmlnIFNUX0lSUUNISVANCj4gPj4+ICAJ
Ym9vbA0KPiA+Pj4gIAlzZWxlY3QgUkVHTUFQDQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
cnFjaGlwL01ha2VmaWxlIGIvZHJpdmVycy9pcnFjaGlwL01ha2VmaWxlDQo+ID4+PiBpbmRleCBi
ODIyMTk5NDQ1ZmYuLmIwOTBmODRkZDQyZSAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvaXJx
Y2hpcC9NYWtlZmlsZQ0KPiA+Pj4gKysrIGIvZHJpdmVycy9pcnFjaGlwL01ha2VmaWxlDQo+ID4+
PiBAQCAtNDUsNiArNDUsNyBAQCBvYmotJChDT05GSUdfU0lSRl9JUlEpCQkJKz0NCj4gPj4gaXJx
LXNpcmZzb2Mubw0KPiA+Pj4gIG9iai0kKENPTkZJR19KQ09SRV9BSUMpCQkJKz0gaXJxLWpjb3Jl
LWFpYy5vDQo+ID4+PiAgb2JqLSQoQ09ORklHX1JFTkVTQVNfSU5UQ19JUlFQSU4pCSs9IGlycS1y
ZW5lc2FzLWludGMtaXJxcGluLm8NCj4gPj4+ICBvYmotJChDT05GSUdfUkVORVNBU19JUlFDKQkJ
Kz0gaXJxLXJlbmVzYXMtaXJxYy5vDQo+ID4+PiArb2JqLSQoQ09ORklHX1JFTkVTQVNfUlpOMV9J
UlFfTVVYKQkrPSByem4xLWlycS1tdXgubw0KPiA+Pj4gIG9iai0kKENPTkZJR19WRVJTQVRJTEVf
RlBHQV9JUlEpCSs9IGlycS12ZXJzYXRpbGUtZnBnYS5vDQo+ID4+PiAgb2JqLSQoQ09ORklHX0FS
Q0hfTlNQSVJFKQkJKz0gaXJxLXpldmlvLm8NCj4gPj4+ICBvYmotJChDT05GSUdfQVJDSF9WVDg1
MDApCQkrPSBpcnEtdnQ4NTAwLm8NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lycWNoaXAv
cnpuMS1pcnEtbXV4LmMNCj4gPj4+IGIvZHJpdmVycy9pcnFjaGlwL3J6bjEtaXJxLW11eC5jIG5l
dyBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4DQo+ID4+PiAwMDAwMDAwMDAwMDAuLjc2N2NlNjdlMzRk
Mg0KPiA+Pj4gLS0tIC9kZXYvbnVsbA0KPiA+Pj4gKysrIGIvZHJpdmVycy9pcnFjaGlwL3J6bjEt
aXJxLW11eC5jDQo+ID4+PiBAQCAtMCwwICsxLDIzNSBAQA0KPiA+Pj4gKy8vIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4+PiArLyoNCj4gPj4+ICsgKiBSWi9OMSBHUElPIElu
dGVycnVwdCBNdWx0aXBsZXhlcg0KPiA+Pj4gKyAqDQo+ID4+PiArICogQ29weXJpZ2h0IChDKSAy
MDE4IFJlbmVzYXMgRWxlY3Ryb25pY3MgRXVyb3BlIExpbWl0ZWQNCj4gPj4+ICsgKg0KPiA+Pj4g
KyAqIE9uIFJaL04xIGRldmljZXMsIHRoZXJlIGFyZSAzIFN5bm9wc3lzIERlc2lnbldhcmUgR1BJ
TyBibG9ja3MNCj4gPj4+ICtlYWNoIGNvbmZpZ3VyZWQNCj4gPj4+ICsgKiB0byBoYXZlIDMyIGlu
dGVycnVwdCBvdXRwdXRzLCBzbyB3ZSBoYXZlIGEgdG90YWwgb2YgOTYgR1BJTw0KPiBpbnRlcnJ1
cHRzLg0KPiA+Pj4gKyAqIEFsbCBvZiB0aGVzZSBhcmUgcGFzc2VkIHRvIHRoZSBHUElPIElSUSBN
dXhlciwgd2hpY2ggc2VsZWN0cyA4DQo+ID4+PiArb2YgdGhlIEdQSU8NCj4gPj4+ICsgKiBpbnRl
cnJ1cHRzIHRvIHBhc3Mgb250byB0aGUgR0lDLg0KPiA+Pj4gKyAqLw0KPiA+Pj4gKw0KPiA+Pj4g
KyNpbmNsdWRlIDxsaW51eC9iaXRvcHMuaD4NCj4gPj4+ICsjaW5jbHVkZSA8bGludXgvaW50ZXJy
dXB0Lmg+DQo+ID4+PiArI2luY2x1ZGUgPGxpbnV4L2lycS5oPg0KPiA+Pj4gKyNpbmNsdWRlIDxs
aW51eC9pcnFjaGlwL2NoYWluZWRfaXJxLmg+ICNpbmNsdWRlIDxsaW51eC9pcnFkb21haW4uaD4N
Cj4gPj4+ICsjaW5jbHVkZSA8bGludXgva2VybmVsLmg+ICNpbmNsdWRlIDxsaW51eC9tb2R1bGUu
aD4gI2luY2x1ZGUNCj4gPj4+ICs8bGludXgvb2ZfaXJxLmg+ICNpbmNsdWRlIDxsaW51eC9vZl9w
bGF0Zm9ybS5oPg0KPiA+Pj4gKw0KPiA+Pj4gKyNkZWZpbmUgR1BJT19JUlFfU1BFQ19TSVpFCTMN
Cj4gPj4+ICsjZGVmaW5lIE1BWF9OUl9HUElPX0NPTlRST0xMRVJTCTMNCj4gPj4+ICsjZGVmaW5l
IE1BWF9OUl9HUElPX0lSUQkJMzINCj4gPj4+ICsjZGVmaW5lIE1BWF9OUl9JTlBVVF9JUlFTCShN
QVhfTlJfR1BJT19DT05UUk9MTEVSUyAqDQo+ID4+IE1BWF9OUl9HUElPX0lSUSkNCj4gPj4+ICsj
ZGVmaW5lIE1BWF9OUl9PVVRQVVRfSVJRUwk4DQo+ID4+PiArDQo+ID4+PiArc3RydWN0IGlycW11
eF9wcml2Ow0KPiA+Pj4gK3N0cnVjdCBpcnFtdXhfb25lIHsNCj4gPj4+ICsJdW5zaWduZWQgaW50
IG1hcHBlZF9pcnE7DQo+ID4+PiArCXVuc2lnbmVkIGludCBpbnB1dF9pcnFfbnI7DQo+ID4+PiAr
CXN0cnVjdCBpcnFtdXhfcHJpdiAqcHJpdjsNCj4gPj4+ICt9Ow0KPiA+Pj4gKw0KPiA+Pj4gK3N0
cnVjdCBpcnFtdXhfcHJpdiB7DQo+ID4+PiArCXN0cnVjdCBkZXZpY2UgKmRldjsNCj4gPj4+ICsJ
c3RydWN0IGlycV9jaGlwIGlycV9jaGlwOw0KPiA+Pg0KPiA+PiBEbyB3ZSByZWFsbHkgbmVlZCB0
aGlzIHRvIGJlIHBlci1kZXZpY2U/IFNlZSBiZWxvdy4NCj4gPiBJIHRob3VnaHQgd2UgZ2VuZXJh
bGx5IHdhbnRlZCBldmVyeXRoaW5nIHRvIGJlIHBlci1kZXZpY2Ugc28gdGhhdCB3ZQ0KPiA+IGNh
biBjb3BlIHdoZW4gc29tZW9uZSBzdGlja3MgdHdvIG9mIHRoZXNlIGluIGEgZGV2aWNlLiBBbSBJ
IHdyb25nPw0KPiANCj4gVGhpcyBvbmx5IGNvbnRhaW5zIGZ1bmN0aW9uIHBvaW50ZXJzIHRoYXQg
YXJlIHNwZWNpZmljIHRvIGEgcGFydGljdWxhciB0eXBlIG9mDQo+IGludGVycnVwdCBjb250cm9s
bGVyLiBOb3RoaW5nIGluIHN0cnVjdCBpcnFfY2hpcCBpcyBpbnN0YW5jZS1zcGVjaWZpYy4NCkFo
LCBJIHNlZSENCg0KPHNuaXA+DQo+ID4+IE9LLCB0aGF0J3Mgd2hlcmUgSSB0aGluayB3ZSBoYXZl
IGEgcHJvYmxlbS4gWW91ciBpcnFjaGlwIHN0cnVjdHVyZQ0KPiA+PiBzZWVtIHRvIG9ubHkgYmUg
dXNlZCB0byBkaXNwbGF5IGEgbmFtZT8hPw0KPiA+IFJpZ2h0LCB0aGF0IHdhc24ndCB0aGUgaW50
ZW50aW9uISBTbywgaG93IGRvIEkgaG9vayBpbiBteSBvd24NCj4gPiBpbnRlcnJ1cHQgaGFuZGxl
ciB3aXRob3V0IGNhbGxpbmcgaXJxX3NldF9jaGlwX2FuZF9oYW5kbGVyKCk/DQo+ID4gVGhhdCdz
IHdoYXQgbGVkIG1lIHRvIHRoaW5rIEkgbmVlZCBhbiBpcnFfY2hpcCBpbnN0YW5jZS4NCj4gDQo+
IFRoYXQncyB0aGUgdGhpbmcsIHlvdSBkb24ndCBuZWVkIGl0LiBlYWNoIGlycV9jaGlwIGlzIGp1
c3QgYSBidW5jaCBvZiBtZXRob2RzLA0KPiBhbmQgdGhlc2UgbWV0aG9kcyBhcHBseSB0byBhbGwg
dGhlIGluc3RhbmNlcyBvZiB0aGUgc2FtZSBjb250cm9sbGVyLg0KPiANCj4gPj4gVG8gc3RhcnQg
d2l0aCwgdGhhdCdzIG5vdCByZWFsbHkgdGhlIHByaW1hcnkgdXNlIGZvciB0aGlzIG9iamVjdCwg
YW5kDQo+ID4+IEknZCBsaWtlIGl0IHRvIGJlIGEgc2luZ2xlIHN0YXRpYyBzdHJ1Y3R1cmUgZm9y
IHRoZSB3aG9sZSBkcml2ZXIuDQo+ID4+IFVzZXJzcGFjZSBkb2Vzbid0IG5lZWQgdG8ga25vdyBh
Ym91dCB0aGUgbmFtZSwgc28gcGxlYXNlIGdldCByaWQgb2YNCj4gdGhpcy4NCj4gPj4NCj4gPj4g
VGhlIHJlYWwgaXNzdWUgaXMgdGhhdCB5b3UgYnVpbGQgdGhlIHdob2xlIHRoaW5nIGFzIGEgY2hh
aW5lZA0KPiA+PiBpbnRlcnJ1cHQgY29udHJvbGxlciwgbWVhbmluZyB0aGF0IG5vdGhpbmcgY29u
dHJvbHMgdGhlIG1hc2tpbmcgb2YNCj4gPj4gdGhlIGludGVycnVwdC4gSWYsIGFzIEkgdW5kZXJz
dGFuZCBpdCwgdGhpcyBJUCBpcyBhbiBpbnRlcnJ1cHQgcm91dGVyDQo+ID4+IHRoYXQgc2VsZWN0
cyA4IG91dCBvZiAzMiBpbnRlcnJ1cHRzIGFuZCBwYXNzZXMgdGhlbSBvbnRvIHRoZSBHSUMsDQo+
ID4+IHRoZW4gYSBub2lzeSBkZXZpY2UgY2FuIGp1c3QgdGFrZSB0aGUgd2hvbGUgQ1BVIGRvd24g
Ynkga2VlcGluZyB0aGUgbGluZQ0KPiBhc3NlcnRlZCwgYW5kIFNXIGNhbm5vdCBtYXNrIGl0Lg0K
PiA+IFRoZSBpbnRlcnJ1cHRzIGludG8gdGhpcyBtdXggY29tZSBmcm9tIEdQSU8gYmxvY2tzIHRo
YXQgZG8gdGhlDQo+ID4gbWFza2luZy4gVGhlIEdQSU8gYmxvY2tzIGluIHRoaXMgY2FzZSBhcmUg
c3RhbmRhcmQgU3lub3BzeXMgSVAgYmxvY2tzLg0KPiA+IFRoZXJlIGlzIG5vdGhpbmcgaW4gdGhl
IGlycSBtdXggaGFyZHdhcmUgdGhhdCBjYW4gbWFzayB0aGVtLCBvciBkbw0KPiA+IGFueXRoaW5n
IG90aGVyIHRoYW4gc2VsZWN0IHdoaWNoIG9uZSB0byB1c2UsIGhlbmNlIHdoeSB0aGlzIGlzIGEN
Cj4gPiBjaGFpbmVkIGludGVycnVwdCBjb250cm9sbGVyLiBTaG91bGQgSSBiZSB1c2luZyBzb21l
dGhpbmcgZWxzZSBpbiB0aGlzIGNhc2U/DQo+IA0KPiBUaGVyZSBhcmUgdHdvIGNhc2VzOg0KPiAx
KSB0aGVyZSBpcyAxOjEgbWFwcGluZyBiZXR3ZWVuIGEgdXNlZCBpbnB1dCBhbmQgYW4gb3V0cHV0
LCBsZWF2aW5nIHNvbWUNCj4gaW5wdXQgdW51c2VkDQo+IDIpIHRoZXJlIGlzIGFuIG46MSBtYXBw
aW5nIGJldHdlZW4gaW5wdXQgYW5kIG91dHB1dCwgYW5kIGFsbCB0aGUgaW5wdXQgY2FuIGJlDQo+
IHVzZWQgYXQgYW55IGdpdmVuIHRpbWUNCj4gDQo+IElmIHdoYXQgeW91IGhhdmUgaXMgKDEpLCB5
b3UgbmVlZCB0byBpbXBsZW1lbnQgYW4gaGllcmFyY2h5Lg0KPiBJZiB3aGF0IHlvdSBoYXZlIGlz
ICgyKSwgeW91IG5lZWQgdG8gaW1wbGVtZW50IGEgY2hhaW5lZCBjb250cm9sbGVyLg0KPiANCj4g
KDEpIHJlcXVpcmVzIHlvdSB0byByZXZpc2l0IHRoaXMgZHJpdmVyLCBtYWtpbmcgaXQgYSBsb3Qg
bW9yZSBsaWtlIHRpJ3MgaXJxLWNyb3NzYmFyDQo+ICgyKSByZXF1aXJlcyB5b3UgdG8gYWN0dWFs
bHkgZG8gc29tZSBkZWNvZGluZyBpbiB0aGUgY2hhaW5lZCBoYW5kbGVyDQo+IA0KPiBJIGJlbGll
dmUgeW91J3JlIGluIGNvbmZpZ3VyYXRpb24gKDEpLiBBbSBJIHJpZ2h0Pw0KUmlnaHQsIGl0J3Mg
YSAxOjEgbWFwcGluZy4gVGhlIGluZm9ybWF0aW9uIGFib3V0IHdoaWNoIGlucHV0IHRvIGJlIHVz
ZWQgbmVlZHMNCnRvIGJlIHNwZWNpZmllZCBpbiBkdC4NCkkgZGlkbuKAmXQgdGhpbmsgSSBjb3Vs
ZCBpbXBsZW1lbnQgYSBoaWVyYXJjaHkgdGhhdCBkaWRu4oCZdCBtYXNrIHRoZSBpbnRlcnJ1cHRz
LCBzbyBJDQpuZWVkIHRvIGdvIGJhY2sgb3ZlciB0aGF0IGFuZCBsb29rIGFnYWluLi4uDQoNCk1h
bnkgdGhhbmtzIQ0KUGhpbA0KDQo+IFRoYW5rcywNCj4gDQo+IAlNLg0KPiAtLQ0KPiBKYXp6IGlz
IG5vdCBkZWFkLiBJdCBqdXN0IHNtZWxscyBmdW5ueS4uLg0K
