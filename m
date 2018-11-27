Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD83FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AAF2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="Yds0i48l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AAF2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maximintegrated.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbeK1Epi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:45:38 -0500
Received: from mail-eopbgr770092.outbound.protection.outlook.com ([40.107.77.92]:60672
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726288AbeK1Epi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com; s=selector1-maximintegrated-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAimZd61AaTxITo07BeNhlx9zqr7kyfNFKnKIp6Iwas=;
 b=Yds0i48lGfRMlm2BZQGnB8hEHPWGYjLNUnX6gQ+2h/C4cT+KgKBqlPkPWZmgwqVcQCtDVHCwMqtEtWWCWyGKeTEiWeExj4QEe5PZjbky5oSZvCiXRoqZs/H0Fvn4FhVpb8np6+jdOYQXkLxbZLkG8QaETt/Xxi2+Swk3YxOazRc=
Received: from DM6PR11MB3131.namprd11.prod.outlook.com (20.177.219.96) by
 DM6PR11MB2988.namprd11.prod.outlook.com (20.177.217.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Tue, 27 Nov 2018 17:44:02 +0000
Received: from DM6PR11MB3131.namprd11.prod.outlook.com
 ([fe80::2dfb:d623:d7cb:cbe1]) by DM6PR11MB3131.namprd11.prod.outlook.com
 ([fe80::2dfb:d623:d7cb:cbe1%3]) with mapi id 15.20.1361.018; Tue, 27 Nov 2018
 17:44:02 +0000
From:   Ryan Lee <RyanS.Lee@maximintegrated.com>
To:     Grant Grundler <grundler@chromium.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Benson Leung <bleung@chromium.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: max98373: Added max98373_reset for stable amp reset
Thread-Topic: [PATCH] ASoC: max98373: Added max98373_reset for stable amp
 reset
Thread-Index: AQHUhbhJ96XSCK8z8UOo2bPiHw7S7qVi5UkAgAAA0nA=
Date:   Tue, 27 Nov 2018 17:44:02 +0000
Message-ID: <DM6PR11MB31314A9FCC12CBCA581052E7E7D00@DM6PR11MB3131.namprd11.prod.outlook.com>
References: <20181126183942.2631-1-ryans.lee@maximintegrated.com>
 <CANEJEGu30oPGRjeK2Sp1dUj4CuFjZeZ9+-2DRwhvmMLNex3p7A@mail.gmail.com>
In-Reply-To: <CANEJEGu30oPGRjeK2Sp1dUj4CuFjZeZ9+-2DRwhvmMLNex3p7A@mail.gmail.com>
Accept-Language: en-US, ko-KR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RyanS.Lee@maximintegrated.com; 
x-originating-ip: [204.17.143.20]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR11MB2988;6:AHQb+2Ndk0bYABOfKAvHYmG1jipmWCybSUerZZaZmWxou0eUUHxK5R2R7SZnPvSArTpXXwWC2gLfQr8PeZT/xato9WMUaNcse8PNwXbDow64qs7XZJkuzRU6RslRouYUSnuUJ1h+jm4tDSTwE/9pY8q74HkJkCbWH5Q9vU5Kl5Kr51SC3e2MwbfGEvmzQBVx6cDZEb69O8NrZTYssH5LLZ/WMHh43NUnq70O3uF7WjhPoko8A9QsK3ZAAfCgGU+yrxw5GXXR8yJffp62/hjcti0H/OUWygJ1mNE4Nd7ocn8+0/C6+haltN+wLHRokTieCxqaKOhtCtjMzI2YdoaDa9TCnHEV+F3ooIFi/8wptuLV2l+dpUBopw/ogdT3XdUi/arkIemjGr4T6i2HAwp+Ks1gGu3dbKgWC7FGSMpUlI5O/fik+R7MEGU/9mZm83MYhNG5u02UiKJS4ubEQYs45Q==;5:VI6HWG0sXEHc78XoCn1anW6CIqNa8f64nKWCoKUhPR+oz7VdgscQlIu58bn5hVEAUmxzpLMXNMbAGXC2jEiv2mZYuZ8AALlEbjQCy374dQTwnP0S1aH2lfncwXJGyuMXd5nwUXKsFMTUlUlhBLzwUW5+enbB+pydSBGZwA+Likg=;7:IMNsEDYug7TkyFNg5Iwg51B4REEusYB+f4K7bu0dglxMx6BOuwHGIc2t4vU+b5muH8ObeTX3yXlyhBEDsahcq7W146Kv9aGeMbRGG8PeyRZ5Qt6os2GcDPkQOp06SvbmrC5s4Ivn329q/Rf/impPjQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e96bba65-260a-4b71-69c9-08d6548feb44
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR11MB2988;
x-ms-traffictypediagnostic: DM6PR11MB2988:
x-microsoft-antispam-prvs: <DM6PR11MB298841CA93CD20D7699DF3FFE7D00@DM6PR11MB2988.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231443)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM6PR11MB2988;BCL:0;PCL:0;RULEID:;SRVR:DM6PR11MB2988;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(13464003)(51914003)(305945005)(54906003)(186003)(229853002)(6246003)(6916009)(6436002)(256004)(14444005)(72206003)(7736002)(81166006)(81156014)(7696005)(86362001)(6506007)(8676002)(4326008)(97736004)(99286004)(5660300001)(8936002)(106356001)(3846002)(14454004)(316002)(33656002)(6116002)(66066001)(53936002)(68736007)(25786009)(2906002)(11346002)(476003)(74316002)(71200400001)(76176011)(26005)(9686003)(71190400001)(39060400002)(55016002)(102836004)(478600001)(486006)(105586002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB2988;H:DM6PR11MB3131.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: maximintegrated.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: U3/cjMWG5fSCeMBcoIKXPD06XKbc6ymIXFB+MdtoLycErHiPYMqBQvWGLuJb0T0gbyEUJd0stCH03Ptk5HFj1BX9AeND9Xhx2gtAS5RcsmiDEgLtYVhlFWNGj2UkdpDstQt6HJUiPrG9UegpQHdgqSPCnWS6r5HK23+pyyzPKQQIcwEMaKtQloc3oH6nsm3HuoomAImXnVo19QYyebdFU+vp5vBu5PvVOqq5/YkDxufsU3EsSxJxAPje6fNB0H/eu2dTLsUprOqHkavocLUTJIsjzUCK3SHqSs58xEsNEd2X3QNnSSikfdjQdOY6sJa8BcdtruUbh9gTFbm08r0PYcxE5YeJI+Puo4ccypiBzVA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96bba65-260a-4b71-69c9-08d6548feb44
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 17:44:02.3064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2988
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R3JhbnQsDQpUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2suIFBsZWFzZSBmaW5kIG15IGFuc3dlcnMg
aW5saW5lLg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogR3JhbnQgR3J1bmRs
ZXIgPGdydW5kbGVyQGNocm9taXVtLm9yZz4NCj5TZW50OiBNb25kYXksIE5vdmVtYmVyIDI2LCAy
MDE4IDY6MjUgUE0NCj5UbzogUnlhbiBMZWUgPFJ5YW5TLkxlZUBtYXhpbWludGVncmF0ZWQuY29t
Pg0KPkNjOiBMaWFtIEdpcmR3b29kIDxsZ2lyZHdvb2RAZ21haWwuY29tPjsgYnJvb25pZUBrZXJu
ZWwub3JnOw0KPnBlcmV4QHBlcmV4LmN6OyB0aXdhaUBzdXNlLmNvbTsgR3JhbnQgR3J1bmRsZXIN
Cj48Z3J1bmRsZXJAY2hyb21pdW0ub3JnPjsgS3VuaW5vcmkgTW9yaW1vdG8NCj48a3VuaW5vcmku
bW9yaW1vdG8uZ3hAcmVuZXNhcy5jb20+OyBCZW5zb24gTGV1bmcNCj48YmxldW5nQGNocm9taXVt
Lm9yZz47IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsgTEtNTCA8bGludXgtDQo+a2VybmVs
QHZnZXIua2VybmVsLm9yZz4NCj5TdWJqZWN0OiBSZTogW1BBVENIXSBBU29DOiBtYXg5ODM3Mzog
QWRkZWQgbWF4OTgzNzNfcmVzZXQgZm9yIHN0YWJsZSBhbXANCj5yZXNldA0KPg0KPkVYVEVSTkFM
IEVNQUlMDQo+DQo+DQo+DQo+SGkgUnlhbiENCj4NCj5KdXN0IHNvbWUgcXVlc3Rpb25zIGlubGlu
ZSAtIGluIGdlbmVyYWwgSSBsaWtlIHRoZSByZXNldCBmdW5jdGlvbi4NCj4NCj5PbiBNb24sIE5v
diAyNiwgMjAxOCBhdCAxMDo0NiBBTSBSeWFuIExlZQ0KPjxSeWFuUy5MZWVAbWF4aW1pbnRlZ3Jh
dGVkLmNvbT4gd3JvdGU6DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUnlhbiBMZWUgPHJ5YW5zLmxl
ZUBtYXhpbWludGVncmF0ZWQuY29tPg0KPj4gLS0tDQo+PiAgQ2hhbmdlcyA6IENyZWF0ZWQgbWF4
OTgzNzNfcmVzZXQgZnVuY3Rpb24gdG8gbWluaW1pemUgY29kZSBkdXBsaWNhdGlvbi4NCj4+ICAg
ICAgICAgICAgQ2hhbmdlZCByZWdtYXBfd3JpdGUgdG8gcmVnbWFwX3VwZGF0ZV9iaXRzLiBPdGhl
ciBiaXRzIGV4Y2VwdCBMU0INCj5uZWVkIHRvIGJlIG1hc2tlZC4NCj4+ICAgICAgICAgICAgQWRk
ZWQgcmVzZXQgdmVyaWZpY2F0aW9uIHN0ZXAgdG8gbWFrZSBzdXJlIHNvZnR3YXJlIHJlc2V0IGlz
DQo+Y29tcGxldGVkIHdlbGwuIFNvZnR3YXJlIHJlc2V0IGlzIGRvbmUgaW4gMTBtcyBpbiBub3Jt
YWwgY2FzZS4NCj4+ICAgICAgICAgICAgUmV2aXNpb24gSUQgaXMgYXZhaWxhYmxlIHdoZW4gdGhl
IGFtcCBpcyBpbiB0aGUgaWRsZSBzdGF0ZSB3aGljaCBtZWFucw0KPnNvZnR3YXJlIHJlc2V0IGlz
IGNvbXBsZXRlZC4NCj4+ICAgICAgICAgICAgU29mdHdhcmUgcmVzZXQgd2lsbCBiZSBwZXJmb3Jt
ZWQgbWF4aW11bSAzIHRpbWVzIHRvIGF2b2lkIGFtcCByZXNldA0KPmZhaWx1cmUuIEdlbmVyYWxs
eSBpdCBpcyBkb25lIGluIHRoZSBmaXJzdCB0cmlhbC4NCj4+ICAgICAgICAgICAgc2xlZXAgdGlt
ZSBhZnRlciBzb2Z0d2FyZSByZXNldCBpcyBpbmNyZWFzZWQgKyAzMG1zIGZvciBldmVyeSByZXRy
aWFsLg0KPk1heGltdW0gcG9zc2libGUgbXNsZWVwIHRpbWUgaXMgMTAwIG1zIChpbml0aWFsIDEw
IG1zICsgMzAgbXMgKiAzIHRpbWVzKS4NCj4NCj5XaHkgaXMgdGhlIHNsZWVwIHRpbWUgaW5jcmVh
c2VkIGFmdGVyIGVhY2ggU1cgcmVzZXQ/DQo+V2hhdCBpcyB0aGUgZmFpbHVyZSBjYXNlIHRoYXQg
eW91J3ZlIHNlZW4gd2hpY2ggd291bGQgYmVuZWZpdCBmcm9tIHRoaXM/DQpHZW5lcmFsbHkgMTBt
cyBpcyBlbm91Z2ggdGltZSBmb3IgYW1wIHNvZnR3YXJlIHJlc2V0IGJ1dCBJIHdhbnRlZCB0byBh
ZGQgbW9yZSBndWFyZCB0aW1lIGZvciB0aGUgcmV0cmlhbCBiZWNhdXNlIGl0IGlzIGFscmVhZHkg
ZmFpbGVkIG9uY2UuDQpJIGhhdmUgbm90IHNlZW4gYSBmYWlsdXJlIGlzc3VlIHdpdGggMTBtcyBk
ZWxheSBvbiBteSB0ZXN0IHNldHVwIGJ1dCBJIHdhbnRlZCB0byBtYWtlIGl0IG1vcmUgY29uc2Vy
dmF0aXZlLg0KTGV0IG1lIHJlbW92ZSB0aGlzLg0KDQo+DQo+Pg0KPj4gIHNvdW5kL3NvYy9jb2Rl
Y3MvbWF4OTgzNzMuYyB8IDQxDQo+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9u
cygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL21heDk4MzczLmMgYi9z
b3VuZC9zb2MvY29kZWNzL21heDk4MzczLmMNCj4+IGluZGV4IGEwOWQwMTMuLjU1YWY3ZjAyIDEw
MDY0NA0KPj4gLS0tIGEvc291bmQvc29jL2NvZGVjcy9tYXg5ODM3My5jDQo+PiArKysgYi9zb3Vu
ZC9zb2MvY29kZWNzL21heDk4MzczLmMNCj4+IEBAIC03MjQsMTQgKzcyNCw0NSBAQCBzdGF0aWMg
c3RydWN0IHNuZF9zb2NfZGFpX2RyaXZlciBtYXg5ODM3M19kYWlbXSA9DQo+ew0KPj4gICAgICAg
ICB9DQo+PiAgfTsNCj4+DQo+PiArc3RhdGljIHZvaWQgbWF4OTgzNzNfcmVzZXQoc3RydWN0IG1h
eDk4MzczX3ByaXYgKm1heDk4MzczLCBzdHJ1Y3QNCj4+ICtkZXZpY2UgKmRldikgew0KPj4gKyAg
ICAgICBpbnQgcmV0LCByZWcsIGNvdW50LCBkZWxheTsNCj4+ICsNCj4+ICsgICAgICAgY291bnQg
PSAwOw0KPj4gKyAgICAgICB3aGlsZSAodHJ1ZSkgew0KPj4gKyAgICAgICAgICAgICAgIC8qIFNv
ZnR3YXJlIFJlc2V0ICovDQo+PiArICAgICAgICAgICAgICAgcmV0ID0gcmVnbWFwX3VwZGF0ZV9i
aXRzKG1heDk4MzczLT5yZWdtYXAsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICBNQVg5ODM3
M19SMjAwMF9TV19SRVNFVCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIE1BWDk4MzczX1NP
RlRfUkVTRVQsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICBNQVg5ODM3M19TT0ZUX1JFU0VU
KTsNCj4+ICsgICAgICAgICAgICAgICBpZiAocmV0KQ0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgZGV2X2VycihkZXYsICJSZXNldCBjb21tYW5kIGZhaWxlZC4NCj4+ICsgKHJldDolZClcbiIs
IHJldCk7DQo+PiArDQo+PiArICAgICAgICAgICAgICAgZGVsYXkgPSAxMDAwMCArIChjb3VudCAq
IDMwMDAwKTsNCj4+ICsgICAgICAgICAgICAgICB1c2xlZXBfcmFuZ2UoZGVsYXksIGRlbGF5ICsg
MTAwMCk7DQo+PiArDQo+PiArICAgICAgICAgICAgICAgLyogU29mdHdhcmUgUmVzZXQgVmVyaWZp
Y2F0aW9uICovDQo+PiArICAgICAgICAgICAgICAgcmV0ID0gcmVnbWFwX3JlYWQobWF4OTgzNzMt
PnJlZ21hcCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIE1BWDk4MzczX1IyMUZGX1JFVl9J
RCwgJnJlZyk7DQo+PiArICAgICAgICAgICAgICAgaWYgKCFyZXQpIHsNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGRldl9pbmZvKGRldiwgIlJlc2V0IGNvbXBsZXRlZCAocmV0cnk6JWQpXG4i
LCBjb3VudCk7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4NCj5JbnN0ZWFk
IG9mIGJyZWFrLCBjYW4gdGhlIGNvZGUgcmV0dXJuIGhlcmU/DQo+ImJyZWFrIiBpbXBsaWVzIHNv
bWV0aGluZyBlbHNlIHdpbGwgaGFwcGVuIGFmdGVyIHRoZSB3aGlsZSBsb29wIGV4aXRzDQo+LSB0
aGVyZSBpc24ndC4NCk9rYXkuIEkgd2lsbCBmaXggaXQuIFRoYW5rcyBmb3IgdGhlIGNvbW1lbnQu
DQoNCj4NCj4+ICsgICAgICAgICAgICAgICB9DQo+PiArDQo+PiArICAgICAgICAgICAgICAgaWYg
KCsrY291bnQgPiAzKSAgICAgICAgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgZGV2X2Vy
cihkZXYsICJSZXNldCBmYWlsZWQuIChyZXQ6JWQpXG4iLCByZXQpOw0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgYnJlYWs7DQo+PiArICAgICAgICAgICAgICAgfQ0KPj4gKyAgICAgICAgICAg
ICAgIHVzbGVlcF9yYW5nZSgxMDAwMCwgMTEwMDApOw0KPg0KPldoeSBpcyB0aGVyZSBhIHNlY29u
ZCBkZWxheSBhZnRlciByZWFkaW5nIE1BWDk4MzczX1IyMUZGX1JFVl9JRD8NCj5JcyB0aGlzIHJl
YWxseSBuZWNlc3Nhcnk/DQpJdCBpcyBub3QgdmVyeSBuZWNlc3NhcnkuIEkganVzdCB3YW50ZWQg
dG8gbWFrZSBpdCBtb3JlIGNvbnNlcnZhdGl2ZSBiZWNhdXNlIHRoaXMgZGVsYXkgaXMgYXBwbGll
ZCBvbmx5IHdoZW4gcmVzZXQgaXMgZmFpbGVkLg0KDQo+DQo+SWYgdGhlIHNlY29uZCB1c2xlZXBf
cmFuZ2UoKSBpc24ndCBuZWVkZWQsIGl0IHdvdWxkIGJlIGJldHRlci9jbGVhcmVyDQo+dG8gbWFr
ZSBjb2RlIGxvb3Agb24gIndoaWxlIChjb3VudCA8IDQpIi4gICBBbmQgdGhlbiBvdXRzaWRlIHRo
ZSB3aGlsZQ0KPmxvb3AsIHVzZSBkZXZfZXJyKCkgdG8gc2hhcmUgd2hhdCB0aGUgZmFpbHVyZSB3
YXMuDQpPSy4gTGV0IG1lIGZpeCBpdC4NCg0KPg0KPj4gKyAgICAgICB9DQo+PiArfQ0KPj4gKw0K
Pj4gIHN0YXRpYyBpbnQgbWF4OTgzNzNfcHJvYmUoc3RydWN0IHNuZF9zb2NfY29tcG9uZW50ICpj
b21wb25lbnQpICB7DQo+PiAgICAgICAgIHN0cnVjdCBtYXg5ODM3M19wcml2ICptYXg5ODM3MyA9
DQo+PiBzbmRfc29jX2NvbXBvbmVudF9nZXRfZHJ2ZGF0YShjb21wb25lbnQpOw0KPj4NCj4+ICAg
ICAgICAgLyogU29mdHdhcmUgUmVzZXQgKi8NCj4+IC0gICAgICAgcmVnbWFwX3dyaXRlKG1heDk4
MzczLT5yZWdtYXAsDQo+PiAtICAgICAgICAgICAgICAgTUFYOTgzNzNfUjIwMDBfU1dfUkVTRVQs
IE1BWDk4MzczX1NPRlRfUkVTRVQpOw0KPj4gLSAgICAgICB1c2xlZXBfcmFuZ2UoMTAwMDAsIDEx
MDAwKTsNCj4+ICsgICAgICAgbWF4OTgzNzNfcmVzZXQobWF4OTgzNzMsIGNvbXBvbmVudC0+ZGV2
KTsNCj4+DQo+PiAgICAgICAgIC8qIElWIGRlZmF1bHQgc2xvdCBjb25maWd1cmF0aW9uICovDQo+
PiAgICAgICAgIHJlZ21hcF93cml0ZShtYXg5ODM3My0+cmVnbWFwLCBAQCAtODE4LDkgKzg0OSw3
IEBAIHN0YXRpYyBpbnQNCj4+IG1heDk4MzczX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpICB7
DQo+PiAgICAgICAgIHN0cnVjdCBtYXg5ODM3M19wcml2ICptYXg5ODM3MyA9IGRldl9nZXRfZHJ2
ZGF0YShkZXYpOw0KPj4NCj4+IC0gICAgICAgcmVnbWFwX3dyaXRlKG1heDk4MzczLT5yZWdtYXAs
DQo+PiAtICAgICAgICAgICAgICAgTUFYOTgzNzNfUjIwMDBfU1dfUkVTRVQsIE1BWDk4MzczX1NP
RlRfUkVTRVQpOw0KPj4gLSAgICAgICB1c2xlZXBfcmFuZ2UoMTAwMDAsIDExMDAwKTsNCj4+ICsg
ICAgICAgbWF4OTgzNzNfcmVzZXQobWF4OTgzNzMsIGRldik7DQo+PiAgICAgICAgIHJlZ2NhY2hl
X2NhY2hlX29ubHkobWF4OTgzNzMtPnJlZ21hcCwgZmFsc2UpOw0KPj4gICAgICAgICByZWdjYWNo
ZV9zeW5jKG1heDk4MzczLT5yZWdtYXApOw0KPj4gICAgICAgICByZXR1cm4gMDsNCj4+IC0tDQo+
PiAyLjcuNA0KPj4NCj4NCj5jaGVlcnMsDQo+Z3JhbnQNCg==
