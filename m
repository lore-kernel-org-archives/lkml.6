Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432C9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE40F206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UFBgZDbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfANRiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:38:18 -0500
Received: from mail-eopbgr800043.outbound.protection.outlook.com ([40.107.80.43]:45812
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726559AbfANRiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:38:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFeXaYRtpY1P663KV5zkr/lo5SVF51R0UVE1iOAWbA0=;
 b=UFBgZDbemBh4Dm6Lg20LfCveEimb1gRnEnVpQYkDKklozG9Rv5wB839uw7qn40QjtM7dVE3h0dBcHlwwPEVEAp5cUwVCjDxenXrr/qfI6/tcy0pcvfpL0jGOHp160boWKg1OcwyTZvLjXtCJFHmR3+bM+7ezvavn8z05mIs1MI0=
Received: from MN2PR12MB3631.namprd12.prod.outlook.com (20.178.243.19) by
 MN2PR12MB3264.namprd12.prod.outlook.com (20.179.83.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Mon, 14 Jan 2019 17:37:34 +0000
Received: from MN2PR12MB3631.namprd12.prod.outlook.com
 ([fe80::a861:43c0:476d:e044]) by MN2PR12MB3631.namprd12.prod.outlook.com
 ([fe80::a861:43c0:476d:e044%4]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 17:37:34 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>, Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jikos@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: General protection fault in `switch_mm_irqs_off()`
Thread-Topic: General protection fault in `switch_mm_irqs_off()`
Thread-Index: AQHUo629ixN4vswCO0W5h+67CHfr8qWfUYmAgAeOigCAABODAIAABY6AgAAPAYCAAAFhgIAAHCYAgAAFRYCAAE1cAIABGT4AgAAibgCAAA2MgIAAHUOAgAYvNwCAAAJ+gIAAB88A
Date:   Mon, 14 Jan 2019 17:37:34 +0000
Message-ID: <a536de63-bfbf-01dc-6fa0-90ccc3f759f1@amd.com>
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
 <3a35722f-969b-e720-1f3f-c60be7818ed1@amd.com>
 <8d6c854c-cbb9-adbf-345b-f04a40206573@amd.com>
 <e45c8578-37e8-0aee-b235-d4d9bcedc8ee@molgen.mpg.de>
In-Reply-To: <e45c8578-37e8-0aee-b235-d4d9bcedc8ee@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR16CA0045.namprd16.prod.outlook.com
 (2603:10b6:805:ca::22) To MN2PR12MB3631.namprd12.prod.outlook.com
 (2603:10b6:208:cc::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3264;20:VFnbOwDzSZNaO7t4DWGp+7D+qnVde2DNXdUD2HnkCEvDNhD1PPll3V6VDP5ax54+gSkEhMd1v8LEnJXRiO+oBSj+Aj21KGkUvGHqGYBW2OX27nJkZe3DinP/qyEw5oyKEM6zNryCfPbwGiTno+dUwY+UbsYoOwDh8xdkR1O149usTimJ+NhBgluSwZcshLEShZ9pU7mJBiRouPjOVSEdYPEVp4PzGGr4QTiEoYlZD9L7M6s5pPYyHhmMkAUxIERN
x-ms-office365-filtering-correlation-id: 64fccc36-cb49-4972-9f9b-08d67a46f7d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3264;
x-ms-traffictypediagnostic: MN2PR12MB3264:
x-microsoft-antispam-prvs: <MN2PR12MB326468C0B9697BDAFBEDA00AEC800@MN2PR12MB3264.namprd12.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(366004)(189003)(199004)(8676002)(6512007)(25786009)(5660300001)(305945005)(2906002)(6436002)(345774005)(256004)(5024004)(52116002)(4326008)(6246003)(76176011)(6486002)(36756003)(53936002)(81166006)(81156014)(386003)(86362001)(102836004)(6506007)(229853002)(53546011)(68736007)(575784001)(7736002)(8936002)(31696002)(66066001)(486006)(2616005)(26005)(31686004)(446003)(71190400001)(72206003)(478600001)(11346002)(476003)(71200400001)(105586002)(106356001)(3846002)(6116002)(14454004)(93886005)(413944005)(99286004)(316002)(54906003)(110136005)(186003)(97736004)(81973001)(414714003)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3264;H:MN2PR12MB3631.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Vj78026R7WTUO5qDJ6t9Bdw5lf7lmUu1LN11BuhPN/kH1BDNrT2yRqbsVpWqi3v7n4pYEiiFhmf+YHdCybeaZWwtGvfYsUaZZNWE9AGmAFpq67psMP9ANEOYeBHOd4176qqjWwatz6cludPxEg+Jk77CYU2U0YZQGLLUvyqWnqmJU8SPOpp75pYJ5MNMaonW6Ge92BYWt0MNQOsOIcBFYnZRcBIHfdiBPv9JGdcWcRMwRbAgpfJsrClo8EoD+NATxjI61HDboL76lPv3GwdPkx4TbiI87YL7B8mRw6vtHpn7awMR3sf3CtrUJt7PaGLPr44asy32HglMkE9WLAgjDsD/cObK/6NTM41gHM4RYFJ0u7oyPJiHBUYGw1C3ZdiFr87MCJJzyFG5JZlWOXR306cdytUTovs+0ALkTwypZnc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <349EA1579680274FA3755789A080E92A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64fccc36-cb49-4972-9f9b-08d67a46f7d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 17:37:34.5635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3264
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8xNC8xOSAxMTowOSBBTSwgUGF1bCBNZW56ZWwgd3JvdGU6DQo+IERlYXIgVGhvbWFzLA0K
PiANCj4gDQo+IFRoYW5rIHlvdSBmb3IgY2hlY2tpbmcgdGhpcywgYW5kIGNvbWluZyBiYWNrIHdp
dGggdGhlIHJlc3VsdHMgc28gcXVpY2tseS4NCj4gDQo+IE9uIDAxLzE0LzE5IDE4OjAwLCBMZW5k
YWNreSwgVGhvbWFzIHdyb3RlOg0KPj4gT24gMS8xMC8xOSAxMjozNCBQTSwgTGVuZGFja3ksIFRo
b21hcyB3cm90ZToNCj4+PiBPbiAxLzEwLzE5IDEwOjQ5IEFNLCBQYXVsIE1lbnplbCB3cm90ZToN
Cj4+Pj4gRGVhciBCb3JpcywgZGVhciBUaG9tYXMsDQo+Pj4+DQo+Pj4+DQo+Pj4+IE9uIDAxLzEw
LzE5IDE3OjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+Pj4+PiBPbiBUaHUsIEphbiAxMCwg
MjAxOSBhdCAwMjo1Nzo0MFBNICswMTAwLCBQYXVsIE1lbnplbCB3cm90ZToNCj4+Pj4+PiBUaGFu
ayB5b3UgdmVyeSBtdWNoLiBJbmRlZWQsIHRoZSBtYWNoaW5lIGRvZXMgbm90IGNyYXNoLiBJIHVz
ZWQgTGludXPigJkNCj4+Pj4+PiBtYXN0ZXIgYnJhbmNoIGZvciB0ZXN0aW5nLCBhbmQgYXBwbGll
ZCB5b3VyIHBhdGNoIG9uIHRvcC4gUGxlYXNlIGZpbmQNCj4+Pj4+PiB0aGUgZnVsbCBsb2cgYXR0
YWNoZWQuDQo+Pj4+Pg0KPj4+Pj4+IDgwLjY0OTogWyAgICAzLjE5NzEwN10gU3BlY3RyZSBWMiA6
IHNwZWN0cmVfdjJfdXNlcl9zZWxlY3RfbWl0aWdhdGlvbjogc2V0IFg4Nl9GRUFUVVJFX1VTRV9J
QlBCDQo+Pj4+Pg0KPj4+Pj4gVGhpcyBpcyBhbWF6aW5nLg0KPj4+Pj4NCj4+Pj4+IE9rLCBuZXh0
IGRpZmYsIHNhbWUgZXhlcmNpc2UuIFRoeC4+IA0KPj4+Pj4gLS0tDQo+Pj4+PiBkaWZmIC0tZ2l0
IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbm9zcGVjLWJyYW5jaC5oIGIvYXJjaC94ODYvaW5jbHVk
ZS9hc20vbm9zcGVjLWJyYW5jaC5oDQo+Pj4+PiBpbmRleCBkYWQxMmI3NjdiYTAuLjUyOGVmODMz
NmY1ZiAxMDA2NDQNCj4+Pj4+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL25vc3BlYy1icmFu
Y2guaA0KPj4+Pj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vbm9zcGVjLWJyYW5jaC5oDQo+
Pj4+PiBAQCAtMjg0LDYgKzI4NCwxMiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgaW5kaXJlY3RfYnJh
bmNoX3ByZWRpY3Rpb25fYmFycmllcih2b2lkKQ0KPj4+Pj4gIHsNCj4+Pj4+ICAJdTY0IHZhbCA9
IFBSRURfQ01EX0lCUEI7DQo+Pj4+PiAgDQo+Pj4+PiArCWlmIChXQVJOX09OKGJvb3RfY3B1X2hh
cyhYODZfRkVBVFVSRV9VU0VfSUJQQikpKSB7DQo+Pj4+PiArCQlwcl9pbmZvKCIlczogYzogJXB4
LCBhcnJheTogMHgleFxuIiwNCj4+Pj4+ICsJCQlfX2Z1bmNfXywgJmJvb3RfY3B1X2RhdGEsIGJv
b3RfY3B1X2RhdGEueDg2X2NhcGFiaWxpdHlbN10pOw0KPj4+Pj4gKwkJcmV0dXJuOw0KPj4+Pj4g
Kwl9DQo+Pj4+PiArDQo+Pj4+PiAgCWFsdGVybmF0aXZlX21zcl93cml0ZShNU1JfSUEzMl9QUkVE
X0NNRCwgdmFsLCBYODZfRkVBVFVSRV9VU0VfSUJQQik7DQo+Pj4+PiAgfQ0KPj4+Pj4gIA0KPj4+
Pj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvYnVncy5jIGIvYXJjaC94ODYva2Vy
bmVsL2NwdS9idWdzLmMNCj4+Pj4+IGluZGV4IDg2NTRiOGIwYzg0OC4uZTgxOGU1YWJlNjExIDEw
MDY0NA0KPj4+Pj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMNCj4+Pj4+ICsrKyBi
L2FyY2gveDg2L2tlcm5lbC9jcHUvYnVncy5jDQo+Pj4+PiBAQCAtMzcxLDYgKzM3MSw5IEBAIHNw
ZWN0cmVfdjJfdXNlcl9zZWxlY3RfbWl0aWdhdGlvbihlbnVtIHNwZWN0cmVfdjJfbWl0aWdhdGlv
bl9jbWQgdjJfY21kKQ0KPj4+Pj4gIAlpZiAoYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX0lCUEIp
KSB7DQo+Pj4+PiAgCQlzZXR1cF9mb3JjZV9jcHVfY2FwKFg4Nl9GRUFUVVJFX1VTRV9JQlBCKTsN
Cj4+Pj4+ICANCj4+Pj4+ICsJCXByX2VycigiJXM6IHNldCBYODZfRkVBVFVSRV9VU0VfSUJQQiwg
YzogJXB4LCBhcnJheTogMHgleFxuIiwNCj4+Pj4+ICsJCQlfX2Z1bmNfXywgJmJvb3RfY3B1X2Rh
dGEsIGJvb3RfY3B1X2RhdGEueDg2X2NhcGFiaWxpdHlbN10pOw0KPj4+Pj4gKw0KPj4+Pj4gIAkJ
c3dpdGNoIChjbWQpIHsNCj4+Pj4+ICAJCWNhc2UgU1BFQ1RSRV9WMl9VU0VSX0NNRF9GT1JDRToN
Cj4+Pj4+ICAJCWNhc2UgU1BFQ1RSRV9WMl9VU0VSX0NNRF9QUkNUTF9JQlBCOg0KPj4+Pj4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMgYi9hcmNoL3g4Ni9rZXJuZWwv
Y3B1L2NvbW1vbi5jDQo+Pj4+PiBpbmRleCBjYjI4ZTk4YTA2NTkuLjg1NjY3MzdmYTUwMCAxMDA2
NDQNCj4+Pj4+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMNCj4+Pj4+ICsrKyBi
L2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMNCj4+Pj4+IEBAIC03NjUsNiArNzY1LDkgQEAg
c3RhdGljIHZvaWQgYXBwbHlfZm9yY2VkX2NhcHMoc3RydWN0IGNwdWluZm9feDg2ICpjKQ0KPj4+
Pj4gIAkJYy0+eDg2X2NhcGFiaWxpdHlbaV0gJj0gfmNwdV9jYXBzX2NsZWFyZWRbaV07DQo+Pj4+
PiAgCQljLT54ODZfY2FwYWJpbGl0eVtpXSB8PSBjcHVfY2Fwc19zZXRbaV07DQo+Pj4+PiAgCX0N
Cj4+Pj4+ICsNCj4+Pj4+ICsJaWYgKGMgPT0gJmJvb3RfY3B1X2RhdGEpDQo+Pj4+PiArCQlwcl9p
bmZvKCIlczogYzogJXB4LCBhcnJheTogMHgleFxuIiwgX19mdW5jX18sIGMsIGMtPng4Nl9jYXBh
YmlsaXR5WzddKTsNCj4+Pj4+ICB9DQo+Pj4+PiAgDQo+Pj4+PiAgc3RhdGljIHZvaWQgaW5pdF9z
cGVjdWxhdGlvbl9jb250cm9sKHN0cnVjdCBjcHVpbmZvX3g4NiAqYykNCj4+Pj4+IEBAIC03Nzgs
NiArNzgxLDEwIEBAIHN0YXRpYyB2b2lkIGluaXRfc3BlY3VsYXRpb25fY29udHJvbChzdHJ1Y3Qg
Y3B1aW5mb194ODYgKmMpDQo+Pj4+PiAgCWlmIChjcHVfaGFzKGMsIFg4Nl9GRUFUVVJFX1NQRUNf
Q1RSTCkpIHsNCj4+Pj4+ICAJCXNldF9jcHVfY2FwKGMsIFg4Nl9GRUFUVVJFX0lCUlMpOw0KPj4+
Pj4gIAkJc2V0X2NwdV9jYXAoYywgWDg2X0ZFQVRVUkVfSUJQQik7DQo+Pj4+PiArDQo+Pj4+PiAr
CQlwcl9pbmZvKCIlczogWDg2X0ZFQVRVUkVfU1BFQ19DVFJMOiBjOiAlcHgsIGFycmF5OiAweCV4
LCBDUFVJRDogMHgleFxuIiwNCj4+Pj4+ICsJCQlfX2Z1bmNfXywgYywgYy0+eDg2X2NhcGFiaWxp
dHlbN10sIGNwdWlkX2VkeCg3KSk7DQo+Pj4+PiArDQo+Pj4+PiAgCQlzZXRfY3B1X2NhcChjLCBY
ODZfRkVBVFVSRV9NU1JfU1BFQ19DVFJMKTsNCj4+Pj4+ICAJfQ0KPj4+Pj4gIA0KPj4+Pj4gQEAg
LTc5Myw5ICs4MDAsMTMgQEAgc3RhdGljIHZvaWQgaW5pdF9zcGVjdWxhdGlvbl9jb250cm9sKHN0
cnVjdCBjcHVpbmZvX3g4NiAqYykNCj4+Pj4+ICAJCXNldF9jcHVfY2FwKGMsIFg4Nl9GRUFUVVJF
X01TUl9TUEVDX0NUUkwpOw0KPj4+Pj4gIAl9DQo+Pj4+PiAgDQo+Pj4+PiAtCWlmIChjcHVfaGFz
KGMsIFg4Nl9GRUFUVVJFX0FNRF9JQlBCKSkNCj4+Pj4+ICsJaWYgKGNwdV9oYXMoYywgWDg2X0ZF
QVRVUkVfQU1EX0lCUEIpKSB7DQo+Pj4+PiAgCQlzZXRfY3B1X2NhcChjLCBYODZfRkVBVFVSRV9J
QlBCKTsNCj4+Pj4+ICANCj4+Pj4+ICsJCXByX2luZm8oIiVzOiBYODZfRkVBVFVSRV9BTURfSUJQ
QjogYzogJXB4LCBhcnJheTogMHgleCwgQ1BVSUQ6IDB4JXhcbiIsDQo+Pj4+PiArCQkJX19mdW5j
X18sIGMsIGMtPng4Nl9jYXBhYmlsaXR5WzddLCBjcHVpZF9lYngoMHg4MDAwMDAwOCkpOw0KPj4+
Pj4gKwl9DQo+Pj4+PiArDQo+Pj4+PiAgCWlmIChjcHVfaGFzKGMsIFg4Nl9GRUFUVVJFX0FNRF9T
VElCUCkpIHsNCj4+Pj4+ICAJCXNldF9jcHVfY2FwKGMsIFg4Nl9GRUFUVVJFX1NUSUJQKTsNCj4+
Pj4+ICAJCXNldF9jcHVfY2FwKGMsIFg4Nl9GRUFUVVJFX01TUl9TUEVDX0NUUkwpOw0KPj4+Pg0K
Pj4+PiBQbGVhc2UgZmluZCB0aGUgbG9ncyBhdHRhY2hlZC4NCj4+Pg0KPj4+IEFoLCBzbyB0aGUg
Q1BVSUQgdmFsdWUgaXMgc2hvd2luZyBYODZfRkVBVFVSRV9BTURfSUJQQiAobm90IHN1cmUgd2h5
IHRoZQ0KPj4+IGNwdWlkIGNvbW1hbmQgd2FzIHNob3dpbmcgYSB2YWx1ZSBvZiB6ZXJvIGZvciBF
QlggaW4geW91ciBwcmV2aW91cyBlbWFpbCkuDQo+Pj4gTGV0IG1lIHNlZSB3aGF0IEkgY2FuIGZp
bmQgb3V0IGFib3V0IHRoaXMgcHJvY2Vzc29yL2Zpcm13YXJlIHJlbGF0aW9uLiBJDQo+Pj4gd291
bGRuJ3QgZXhwZWN0IHRvIHNlZSB0aGUgI0dQIGdpdmVuIHRoYXQgdGhlIGZpcm13YXJlIHNheXMg
SUJQQiBpcw0KPj4+IHN1cHBvcnRlZC4NCj4+DQo+PiBJJ20gbm90IGFibGUgdG8gcmVwcm9kdWNl
IHRoaXMgaXNzdWUgb24gbXkgZmFtaWx5IDIxLCBtb2RlbCAxLCBzdGVwcGluZyAyDQo+PiBwcm9j
ZXNzb3IgKEFNRCBPcHRlcm9uKFRNKSBQcm9jZXNzb3IgNjI3NCkgYXMgSSBhbSBhYmxlIHRvIHN1
Y2Nlc3NmdWxseQ0KPj4gd3JpdGUgdG8gdGhlIFBSRURfQ01EIE1TUi4NCj4gDQo+IEl04oCZcyBu
b3QgZXhhY3RseSB0aGUgc2FtZSBwcm9jZXNzb3IsIGJ1dCBJIGd1ZXNzIHRoZSBzYW1lIGZhbWls
eSBzaG91bGQgYmUNCj4gZ29vZCBlbm91Z2guIFdoYXQgYm9hcmQgZG8geW91IGhhdmU/IERvIHlv
dSBoYXZlIHR3byBzb2NrZXRzLCBhbmQgYm90aA0KPiBwb3B1bGF0ZWQ/DQoNClllcywgSXQgaXMg
YSB0d28tc29ja2V0IHN5c3RlbSB3aXRoIHR3byBwcm9jZXNzb3JzIGluc3RhbGxlZC4NCg0KPiAN
Cj4gSGVyZSBpcyBhbiBBc3VzIEtHUEUtRDE2IHdpdGggdHdvIEFNRCBPcHRlcm9ucyBwdXQgaW4u
DQo+IA0KPiBMYXN0bHksIG15IG1pY3JvY29kZSB1cGRhdGVzIGFyZSBhcHBsaWVkIGluIGZpcm13
YXJlLCBhbmQgbm90IGJ5IEdOVS9MaW51eC4NCg0KT2ssIEkgd2FzIGNvbmZ1c2VkIG9uIGhvdyB5
b3UgaGFkIHJlcG9ydGVkIHRoYXQsIHNvcnJ5Lg0KDQpDYW4gd2UgdHJ5IGFuIGV4cGVyaW1lbnQg
d2hlcmUgeW91IHVzZSB0aGUgb2xkZXIgdmVyc2lvbiBvZiB0aGUgQXN1cw0KZmlybXdhcmUgYnV0
IGJ1aWxkIGFuIGluaXRyYW1mcyB0aGF0IHdpbGwgcGVyZm9ybSBlYXJseSBtaWNyb2NvZGUgbG9h
ZGluZz8NCkknbSBjdXJpb3VzIGlmIHRoaW5ncyB3aWxsIHdvcmsgd2hlbiBsb2FkZWQgdmlhIExp
bnV4Lg0KDQpUaGFua3MsDQpUb20NCg0KPiANCj4+IExldCdzIGNoZWNrIHRoZSBmaXJtd2FyZSBm
aWxlIHRoYXQgeW91J3JlIGxvYWRpbmcuIFRoZSBvbmUgSSdtIHVzaW5nIGlzOg0KPj4NCj4+ICQg
c2hhMXN1bSAvbGliL2Zpcm13YXJlL2FtZC11Y29kZS9taWNyb2NvZGVfYW1kX2ZhbTE1aC5iaW4g
DQo+PiA5MDg5NjI1Njk1MWQ4ZWRmN2JhZjgxODFhZTExZTJkYzYxOGE1MTcxICAvbGliL2Zpcm13
YXJlL2FtZC11Y29kZS9taWNyb2NvZGVfYW1kX2ZhbTE1aC5iaW4NCj4+DQo+PiBEb2VzIHRoYXQg
bWF0Y2ggd2hhdCB5b3UgaGF2ZT8NCj4gDQo+IFllcywgdGhhdCBtYXRjaGVzIGV4YWN0bHkuDQo+
IA0KPiAgICAgOTA4OTYyNTY5NTFkOGVkZjdiYWY4MTgxYWUxMWUyZGM2MThhNTE3MSAgM3JkcGFy
dHkvYmxvYnMvY3B1L2FtZC9mYW1pbHlfMTVoL21pY3JvY29kZV9hbWRfZmFtMTVoLmJpbg0KPiAN
Cj4gDQo+IEtpbmQgcmVnYXJkcywNCj4gDQo+IFBhdWwNCj4gDQo=
