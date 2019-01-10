Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC75C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0943920874
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hp+DbLY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbfAJSeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:34:14 -0500
Received: from mail-eopbgr770040.outbound.protection.outlook.com ([40.107.77.40]:32304
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727737AbfAJSeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:34:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITuJGkHuoeGKL34egilMfjzHnu/+zEjA/OLuEGH8zXk=;
 b=hp+DbLY+2xVlccepRhE5ZD3uow6wCjZzN2w+mDN9bFQdFkco4Jz7pWe7dCVKEHMqEf1b2jza+Fc2UHHFjnskQqhUhE2abnRCcZOQlM+48wt2+7P943fbJ/EZVyPdZHuP/PTwje+W/a7xjb/xdEbMBYvlMhSpGYSE3Gb+8NpLGLk=
Received: from MN2PR12MB3631.namprd12.prod.outlook.com (20.178.243.19) by
 MN2PR12MB3167.namprd12.prod.outlook.com (20.179.81.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.15; Thu, 10 Jan 2019 18:34:09 +0000
Received: from MN2PR12MB3631.namprd12.prod.outlook.com
 ([fe80::1da6:b950:a28e:dae2]) by MN2PR12MB3631.namprd12.prod.outlook.com
 ([fe80::1da6:b950:a28e:dae2%5]) with mapi id 15.20.1495.011; Thu, 10 Jan 2019
 18:34:09 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>, Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jikos@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: General protection fault in `switch_mm_irqs_off()`
Thread-Topic: General protection fault in `switch_mm_irqs_off()`
Thread-Index: AQHUo629ixN4vswCO0W5h+67CHfr8qWfUYmAgAeOigCAABODAIAABY6AgAAPAYCAAAFhgIAAHCYAgAAFRYCAAE1cAIABGT4AgAAibgCAAA2MgIAAHUOA
Date:   Thu, 10 Jan 2019 18:34:09 +0000
Message-ID: <3a35722f-969b-e720-1f3f-c60be7818ed1@amd.com>
References: <alpine.LRH.2.00.1901041737290.28043@gjva.wvxbf.pm>
 <cb7ba667-562b-1e4c-f16e-7c11804bc98a@molgen.mpg.de>
 <alpine.DEB.2.21.1901091410500.1755@nanos.tec.linutronix.de>
 <5c38f377-f088-5684-91a5-c2cc2d64dbbd@molgen.mpg.de>
 <ea49acb9-8165-80a3-e6fe-b29123ad5795@amd.com>
 <206f4322-c15e-6f0b-733d-fd19cd9c24a7@molgen.mpg.de>
 <98ed83c0-3077-848b-9de4-add70e9b417a@amd.com>
 <9bca3e26-1dfc-6e86-cf28-90cadd983ff4@molgen.mpg.de>
 <20190109211104.GG15665@zn.tnic>
 <9bbcbaa7-b164-fcef-0588-7c5f25aa2440@molgen.mpg.de>
 <20190110160054.GD17621@zn.tnic>
 <4de0b458-6028-3ab1-fef6-04c7fc440277@molgen.mpg.de>
In-Reply-To: <4de0b458-6028-3ab1-fef6-04c7fc440277@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:805:de::33) To MN2PR12MB3631.namprd12.prod.outlook.com
 (2603:10b6:208:cc::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3167;20:bODxWl69KU2N303nObPS/HCORe3ILClSP9v8gvXDsbAJmUEow0wBrEl3bDqTsokUMQ2AgVIAfmiGz+iqv6nZmYX3KUUGCwJAA/NTWCOT85KkhUZl/AL/enlq4HW+8yEmtl2F69GRYF3TRpu1+mZ7DxSkrF7A6xP2dVQXIXOyzBzcAkX4A8IrOsV3dX1rvrxKfpT9ZJAO20TL4CY3JTendxw9mf+irc+mbrBmwIPSdOBG0MdErKFtV8X9e6lz/rka
x-ms-office365-filtering-correlation-id: 20188653-5cf6-4247-d849-08d6772a35a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3167;
x-ms-traffictypediagnostic: MN2PR12MB3167:
x-microsoft-antispam-prvs: <MN2PR12MB3167551EF743A919DA6C0032EC840@MN2PR12MB3167.namprd12.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(136003)(396003)(346002)(189003)(199004)(2616005)(256004)(5024004)(5660300001)(105586002)(102836004)(99286004)(52116002)(81166006)(71200400001)(31696002)(66066001)(81156014)(71190400001)(76176011)(8676002)(36756003)(6506007)(3846002)(229853002)(26005)(386003)(186003)(11346002)(86362001)(575784001)(53546011)(8936002)(6116002)(476003)(446003)(6436002)(486006)(413944005)(93886005)(478600001)(6486002)(2906002)(6512007)(316002)(110136005)(53936002)(567974002)(72206003)(54906003)(25786009)(31686004)(305945005)(7736002)(106356001)(4326008)(14454004)(6246003)(97736004)(68736007)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3167;H:MN2PR12MB3631.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r16tlhQobV1xaAVpm78SI8aRb9JJCKxBY0a+mvkByUJeQm/VIufuMfS9N+X/IznXilc12Ppf5VLxwKo12JuNqdYNoyedqyRdGXz8blLr5cgoks3PyB591EEDpLRJtYBZdsYVyNyevBJOv8qk3fD4UAqdcNGxTmuT61SBCNa8eN1Yiqp1VVjoorHNfVCwjUoA6Q2c/ntmrIp6AzW504E5WGAgzUS+uA6+lrzr/fAvlyx/CBTRZvKB2RR/yZdHLAyO3iZsWVIXPxF+6XLMQViuw9TH8Ib//lE+mYTCSD8muNM9a/DFOUmj+q9CwBU6NllL
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1566C6D0F9788345AAE1C8C095C0B64F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20188653-5cf6-4247-d849-08d6772a35a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 18:34:09.5909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8xMC8xOSAxMDo0OSBBTSwgUGF1bCBNZW56ZWwgd3JvdGU6DQo+IERlYXIgQm9yaXMsIGRl
YXIgVGhvbWFzLA0KPiANCj4gDQo+IE9uIDAxLzEwLzE5IDE3OjAwLCBCb3Jpc2xhdiBQZXRrb3Yg
d3JvdGU6DQo+PiBPbiBUaHUsIEphbiAxMCwgMjAxOSBhdCAwMjo1Nzo0MFBNICswMTAwLCBQYXVs
IE1lbnplbCB3cm90ZToNCj4+PiBUaGFuayB5b3UgdmVyeSBtdWNoLiBJbmRlZWQsIHRoZSBtYWNo
aW5lIGRvZXMgbm90IGNyYXNoLiBJIHVzZWQgTGludXPigJkNCj4+PiBtYXN0ZXIgYnJhbmNoIGZv
ciB0ZXN0aW5nLCBhbmQgYXBwbGllZCB5b3VyIHBhdGNoIG9uIHRvcC4gUGxlYXNlIGZpbmQNCj4+
PiB0aGUgZnVsbCBsb2cgYXR0YWNoZWQuDQo+Pg0KPj4+IDgwLjY0OTogWyAgICAzLjE5NzEwN10g
U3BlY3RyZSBWMiA6IHNwZWN0cmVfdjJfdXNlcl9zZWxlY3RfbWl0aWdhdGlvbjogc2V0IFg4Nl9G
RUFUVVJFX1VTRV9JQlBCDQo+Pg0KPj4gVGhpcyBpcyBhbWF6aW5nLg0KPj4NCj4+IE9rLCBuZXh0
IGRpZmYsIHNhbWUgZXhlcmNpc2UuIFRoeC4+IA0KPj4gLS0tDQo+PiBkaWZmIC0tZ2l0IGEvYXJj
aC94ODYvaW5jbHVkZS9hc20vbm9zcGVjLWJyYW5jaC5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20v
bm9zcGVjLWJyYW5jaC5oDQo+PiBpbmRleCBkYWQxMmI3NjdiYTAuLjUyOGVmODMzNmY1ZiAxMDA2
NDQNCj4+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL25vc3BlYy1icmFuY2guaA0KPj4gKysr
IGIvYXJjaC94ODYvaW5jbHVkZS9hc20vbm9zcGVjLWJyYW5jaC5oDQo+PiBAQCAtMjg0LDYgKzI4
NCwxMiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgaW5kaXJlY3RfYnJhbmNoX3ByZWRpY3Rpb25fYmFy
cmllcih2b2lkKQ0KPj4gIHsNCj4+ICAJdTY0IHZhbCA9IFBSRURfQ01EX0lCUEI7DQo+PiAgDQo+
PiArCWlmIChXQVJOX09OKGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9VU0VfSUJQQikpKSB7DQo+
PiArCQlwcl9pbmZvKCIlczogYzogJXB4LCBhcnJheTogMHgleFxuIiwNCj4+ICsJCQlfX2Z1bmNf
XywgJmJvb3RfY3B1X2RhdGEsIGJvb3RfY3B1X2RhdGEueDg2X2NhcGFiaWxpdHlbN10pOw0KPj4g
KwkJcmV0dXJuOw0KPj4gKwl9DQo+PiArDQo+PiAgCWFsdGVybmF0aXZlX21zcl93cml0ZShNU1Jf
SUEzMl9QUkVEX0NNRCwgdmFsLCBYODZfRkVBVFVSRV9VU0VfSUJQQik7DQo+PiAgfQ0KPj4gIA0K
Pj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvYnVncy5jIGIvYXJjaC94ODYva2Vy
bmVsL2NwdS9idWdzLmMNCj4+IGluZGV4IDg2NTRiOGIwYzg0OC4uZTgxOGU1YWJlNjExIDEwMDY0
NA0KPj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMNCj4+ICsrKyBiL2FyY2gveDg2
L2tlcm5lbC9jcHUvYnVncy5jDQo+PiBAQCAtMzcxLDYgKzM3MSw5IEBAIHNwZWN0cmVfdjJfdXNl
cl9zZWxlY3RfbWl0aWdhdGlvbihlbnVtIHNwZWN0cmVfdjJfbWl0aWdhdGlvbl9jbWQgdjJfY21k
KQ0KPj4gIAlpZiAoYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX0lCUEIpKSB7DQo+PiAgCQlzZXR1
cF9mb3JjZV9jcHVfY2FwKFg4Nl9GRUFUVVJFX1VTRV9JQlBCKTsNCj4+ICANCj4+ICsJCXByX2Vy
cigiJXM6IHNldCBYODZfRkVBVFVSRV9VU0VfSUJQQiwgYzogJXB4LCBhcnJheTogMHgleFxuIiwN
Cj4+ICsJCQlfX2Z1bmNfXywgJmJvb3RfY3B1X2RhdGEsIGJvb3RfY3B1X2RhdGEueDg2X2NhcGFi
aWxpdHlbN10pOw0KPj4gKw0KPj4gIAkJc3dpdGNoIChjbWQpIHsNCj4+ICAJCWNhc2UgU1BFQ1RS
RV9WMl9VU0VSX0NNRF9GT1JDRToNCj4+ICAJCWNhc2UgU1BFQ1RSRV9WMl9VU0VSX0NNRF9QUkNU
TF9JQlBCOg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMgYi9h
cmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5jDQo+PiBpbmRleCBjYjI4ZTk4YTA2NTkuLjg1NjY3
MzdmYTUwMCAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMNCj4+
ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMNCj4+IEBAIC03NjUsNiArNzY1LDkg
QEAgc3RhdGljIHZvaWQgYXBwbHlfZm9yY2VkX2NhcHMoc3RydWN0IGNwdWluZm9feDg2ICpjKQ0K
Pj4gIAkJYy0+eDg2X2NhcGFiaWxpdHlbaV0gJj0gfmNwdV9jYXBzX2NsZWFyZWRbaV07DQo+PiAg
CQljLT54ODZfY2FwYWJpbGl0eVtpXSB8PSBjcHVfY2Fwc19zZXRbaV07DQo+PiAgCX0NCj4+ICsN
Cj4+ICsJaWYgKGMgPT0gJmJvb3RfY3B1X2RhdGEpDQo+PiArCQlwcl9pbmZvKCIlczogYzogJXB4
LCBhcnJheTogMHgleFxuIiwgX19mdW5jX18sIGMsIGMtPng4Nl9jYXBhYmlsaXR5WzddKTsNCj4+
ICB9DQo+PiAgDQo+PiAgc3RhdGljIHZvaWQgaW5pdF9zcGVjdWxhdGlvbl9jb250cm9sKHN0cnVj
dCBjcHVpbmZvX3g4NiAqYykNCj4+IEBAIC03NzgsNiArNzgxLDEwIEBAIHN0YXRpYyB2b2lkIGlu
aXRfc3BlY3VsYXRpb25fY29udHJvbChzdHJ1Y3QgY3B1aW5mb194ODYgKmMpDQo+PiAgCWlmIChj
cHVfaGFzKGMsIFg4Nl9GRUFUVVJFX1NQRUNfQ1RSTCkpIHsNCj4+ICAJCXNldF9jcHVfY2FwKGMs
IFg4Nl9GRUFUVVJFX0lCUlMpOw0KPj4gIAkJc2V0X2NwdV9jYXAoYywgWDg2X0ZFQVRVUkVfSUJQ
Qik7DQo+PiArDQo+PiArCQlwcl9pbmZvKCIlczogWDg2X0ZFQVRVUkVfU1BFQ19DVFJMOiBjOiAl
cHgsIGFycmF5OiAweCV4LCBDUFVJRDogMHgleFxuIiwNCj4+ICsJCQlfX2Z1bmNfXywgYywgYy0+
eDg2X2NhcGFiaWxpdHlbN10sIGNwdWlkX2VkeCg3KSk7DQo+PiArDQo+PiAgCQlzZXRfY3B1X2Nh
cChjLCBYODZfRkVBVFVSRV9NU1JfU1BFQ19DVFJMKTsNCj4+ICAJfQ0KPj4gIA0KPj4gQEAgLTc5
Myw5ICs4MDAsMTMgQEAgc3RhdGljIHZvaWQgaW5pdF9zcGVjdWxhdGlvbl9jb250cm9sKHN0cnVj
dCBjcHVpbmZvX3g4NiAqYykNCj4+ICAJCXNldF9jcHVfY2FwKGMsIFg4Nl9GRUFUVVJFX01TUl9T
UEVDX0NUUkwpOw0KPj4gIAl9DQo+PiAgDQo+PiAtCWlmIChjcHVfaGFzKGMsIFg4Nl9GRUFUVVJF
X0FNRF9JQlBCKSkNCj4+ICsJaWYgKGNwdV9oYXMoYywgWDg2X0ZFQVRVUkVfQU1EX0lCUEIpKSB7
DQo+PiAgCQlzZXRfY3B1X2NhcChjLCBYODZfRkVBVFVSRV9JQlBCKTsNCj4+ICANCj4+ICsJCXBy
X2luZm8oIiVzOiBYODZfRkVBVFVSRV9BTURfSUJQQjogYzogJXB4LCBhcnJheTogMHgleCwgQ1BV
SUQ6IDB4JXhcbiIsDQo+PiArCQkJX19mdW5jX18sIGMsIGMtPng4Nl9jYXBhYmlsaXR5WzddLCBj
cHVpZF9lYngoMHg4MDAwMDAwOCkpOw0KPj4gKwl9DQo+PiArDQo+PiAgCWlmIChjcHVfaGFzKGMs
IFg4Nl9GRUFUVVJFX0FNRF9TVElCUCkpIHsNCj4+ICAJCXNldF9jcHVfY2FwKGMsIFg4Nl9GRUFU
VVJFX1NUSUJQKTsNCj4+ICAJCXNldF9jcHVfY2FwKGMsIFg4Nl9GRUFUVVJFX01TUl9TUEVDX0NU
UkwpOw0KPiANCj4gUGxlYXNlIGZpbmQgdGhlIGxvZ3MgYXR0YWNoZWQuDQoNCkFoLCBzbyB0aGUg
Q1BVSUQgdmFsdWUgaXMgc2hvd2luZyBYODZfRkVBVFVSRV9BTURfSUJQQiAobm90IHN1cmUgd2h5
IHRoZQ0KY3B1aWQgY29tbWFuZCB3YXMgc2hvd2luZyBhIHZhbHVlIG9mIHplcm8gZm9yIEVCWCBp
biB5b3VyIHByZXZpb3VzIGVtYWlsKS4NCkxldCBtZSBzZWUgd2hhdCBJIGNhbiBmaW5kIG91dCBh
Ym91dCB0aGlzIHByb2Nlc3Nvci9maXJtd2FyZSByZWxhdGlvbi4gSQ0Kd291bGRuJ3QgZXhwZWN0
IHRvIHNlZSB0aGUgI0dQIGdpdmVuIHRoYXQgdGhlIGZpcm13YXJlIHNheXMgSUJQQiBpcw0Kc3Vw
cG9ydGVkLg0KDQpUaGFua3MsDQpUb20NCg0KPiANCj4gDQo+IEtpbmQgcmVnYXJkcywNCj4gDQo+
IFBhdWwNCj4gDQo=
