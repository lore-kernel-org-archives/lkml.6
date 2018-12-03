Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D740BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84832214F1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uXU1FY+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84832214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbeLCT0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:26:19 -0500
Received: from mail-eopbgr760089.outbound.protection.outlook.com ([40.107.76.89]:18490
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbeLCT0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:26:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE7HeuFMnmLDClkWGzf0/ZZDxlz9+NWWNWiOIN0Dqm0=;
 b=uXU1FY+1WCs1ADfwIeGQLgsPFjghByJaks7LhSp2hs70cHy2GdIlfzG/mjiUr1PVmfrwXb3+d/w99cOzhq1KEUv3L24OcK1BeC3H5DDYeyOBDOW6K1eZdtQRKYSsLjcrEgBNmLH2MDgaG6Hsf1Ef6fbDKd/nGXC0oTo3QUvbyh8=
Received: from MWHPR1201MB0061.namprd12.prod.outlook.com (10.174.98.12) by
 MWHPR1201MB2556.namprd12.prod.outlook.com (10.172.97.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 19:26:11 +0000
Received: from MWHPR1201MB0061.namprd12.prod.outlook.com
 ([fe80::4481:91d7:9564:e869]) by MWHPR1201MB0061.namprd12.prod.outlook.com
 ([fe80::4481:91d7:9564:e869%9]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 19:26:10 +0000
From:   "StDenis, Tom" <Tom.StDenis@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 0/4] x86/mm/cpa: Fix cpa-array TLB invalidation
Thread-Topic: [PATCH 0/4] x86/mm/cpa: Fix cpa-array TLB invalidation
Thread-Index: AQHUiLXipdRkoql6EkWifNhS5aJus6VoZy0AgAAE7ICAAAE+AIAAAp2AgAACJQCAAA16AIAErDEAgAA+4gA=
Date:   Mon, 3 Dec 2018 19:26:10 +0000
Message-ID: <ebd0b71b-88be-9b55-bd7a-e32d6ff5476a@amd.com>
References: <20181130134455.490139778@infradead.org>
 <d1e4cb48-1952-fb61-bd2b-db9efe3b5f1a@amd.com>
 <20181130150959.GA11614@hirez.programming.kicks-ass.net>
 <9b172efa-0279-0a39-0b6b-7cf3492d326d@amd.com>
 <20181130152347.GB11614@hirez.programming.kicks-ass.net>
 <20181130153128.GB11650@hirez.programming.kicks-ass.net>
 <8ee4e546-4680-e463-23ac-64489a60b946@amd.com>
 <20181203154102.GI11614@hirez.programming.kicks-ass.net>
In-Reply-To: <20181203154102.GI11614@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::39) To MWHPR1201MB0061.namprd12.prod.outlook.com
 (2603:10b6:301:54::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [69.159.71.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR1201MB2556;20:gYUy1OfhXC4ZovPCG/g09m7zJhc+mLIjzaB4OCJpZcLRWLB+aN1y99k2g+fwXrgRo+9hAPW4GRtsZj2nH+KQ4fsgHdtQavbK3i9P/QfG4EAyBQiRCVnaKs+pq6lOlBlEnlYbCAMRUr/LN5HA0Vm1EQFW9VAj6GR9GOidcEO0ym0rlwnDYvraA/whgIqIsRLE/pHR5Dz1f9wgasZyoaxveCZf2WAPHm4WeaCfefkRxgUYUQH4TA776qKOhcNHPtsZ
x-ms-office365-filtering-correlation-id: 63f096ec-dbd2-4cf5-bc49-08d659552e14
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR1201MB2556;
x-ms-traffictypediagnostic: MWHPR1201MB2556:
x-microsoft-antispam-prvs: <MWHPR1201MB2556C2EB6442ED054D5FE1EBF7AE0@MWHPR1201MB2556.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR1201MB2556;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB2556;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(366004)(199004)(189003)(105586002)(4326008)(386003)(6506007)(53546011)(305945005)(106356001)(7736002)(478600001)(3846002)(52116002)(11346002)(72206003)(53936002)(6116002)(6246003)(66066001)(99286004)(6916009)(5660300001)(446003)(5024004)(14454004)(229853002)(81166006)(486006)(6486002)(6436002)(54906003)(31696002)(316002)(256004)(14444005)(8936002)(36756003)(25786009)(81156014)(6512007)(102836004)(31686004)(26005)(2906002)(71190400001)(71200400001)(186003)(76176011)(476003)(86362001)(2616005)(8676002)(97736004)(68736007)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB2556;H:MWHPR1201MB0061.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AHz3XtWQrS10oI+eNYMc8z9hX0njIYoGC+XqmyuJVqHutnlA8iHCrmwdLomPStWHMuD4HhClusrq5p4pVkxNAzoqaxgRyoAT65aO6oadaJUNqC7+UUh1r8kUqZusEwP6ODvIOQL3PPDZ8/ALT9WpvXFLKSifPbEd4GMAkxz5WpmUEkGWstKxkioVlnHiRMGfRITtLwaq28/Sr2jbAFf2coUOSp6H/6PcAGRk4687TDy7IzhvxqcjzUuzXu5nA7Tkqteze/2gX2X8XA9lR9rJz9+r80hYvbSj2ETFNZqmwbNQEXWn6w8QcB+TE03HgJxiCbQJ6v2Urg/WYreQ2gdkoPOh07OZCOppRkt3G9iiq3Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8254D939916B3944B122514F788FA575@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f096ec-dbd2-4cf5-bc49-08d659552e14
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 19:26:10.8654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2556
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGV0ZXIsDQoNCkFmdGVyIHVwZGF0aW5nIG15IFVNRHMgKG1lc2EvZXRjKSBvdmVyIHRoZSB3
ZWVrZW5kIEkgY2Fubm90IHJlcHJvZHVjZSANCnRoZSBidWcgdG8gYmVnaW4gd2l0aC4gIEknbGwg
dHJ5IGp1bXBpbmcgZGlyZWN0bHkgdG8gdGhlIGludGVyc2VjdGlvbiANCmFuZCBzZWUgaWYgSSBj
YW4gcmVwcm9kdWNlIHRoZSBmYXVsdCB0aGVyZSBvdGhlcndpc2UgSSdsbCBoYXZlIHRvIA0Kcm9s
bGJhY2sgbXkgdW1kcy4NCg0KSG9wZWZ1bGx5IEkgY2FuIHRlc3QgdGhpcyB0b21vcnJvdy4NCg0K
VG9tDQoNCk9uIDIwMTgtMTItMDMgMTA6NDEgYS5tLiwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+
IE9uIEZyaSwgTm92IDMwLCAyMDE4IGF0IDA0OjE5OjQ2UE0gKzAwMDAsIFN0RGVuaXMsIFRvbSB3
cm90ZToNCj4+IE5BSyBJIGdldCBhIGZhaWx1cmUgaW4gVFRNIG9uIGluaXQgd2l0aCB5b3VyIHg4
Ni9tbSBicmFuY2ggKHNlZSBhdHRhY2hlZA0KPj4gZG1lc2cpLg0KPiANCj4gU28gdGhlIGdvb2Qg
bmV3cyBpcyB0aGF0IHdpdGggc29tZSBhZGRpdGlvbmFsIHNlbGYtdGVzdHMgSSBjYW4gdHJpdmlh
bGx5DQo+IHJlcHJvZHVjZSB0aGlzLiBUaGUgYmFkIG5ld3MgaXMgdGhhdCBhbiBvdGhlcndpc2Ug
c3RyYWlnaHQgZm9yd2FyZA0KPiBjbGVhbnVwIHNlZW1zIHRvIG1ha2UgQ1BBIGhvcnJpYmx5IG1h
ZCBhdCBtZS4NCj4gDQo+IEFuZCBzaW5jZSB3ZSdyZSBzb21ld2hhdCBsYXRlIGluIHRoZSByZWxl
YXNlIGN5Y2xlLCBJIHN1cHBvc2Ugd2Ugc2hvdWxkDQo+IGRvIHRoZSBzaW1wbGUgdGhpbmcgZmly
c3QsIGFuZCB0aGVuIEkgY2FuIHRyeSBhbmQgZmlndXJlIG91dCB0aGlzIENQQQ0KPiBtZXNzIGxh
dGVyLg0KPiANCj4gU28gaG93IGFib3V0IHRoaXMgcmVsYXRpdmVseSBzaW1wbGUgcGFydGlhbCBy
ZXZlcnQgdG8gc29ydCB0aGUgcHJvYmxlbS4NCj4gDQo+IC0tLQ0KPiBTdWJqZWN0OiB4ODYvbW0v
Y3BhOiBGaXggY3BhX2ZsdXNoX2FycmF5KCkgVExCIGludmFsaWRhdGlvbg0KPiANCj4gSW4gY29t
bWl0Og0KPiANCj4gICAgYTcyOTVmZDUzYzM5ICgieDg2L21tL2NwYTogVXNlIGZsdXNoX3RsYl9r
ZXJuZWxfcmFuZ2UoKSIpDQo+IA0KPiBJIG1pc3JlYWQgdGhlIGNwYSBhcnJheSBjb2RlIGFuZCBp
bmNvcnJlY3RseSB1c2VkDQo+IHRsYl9mbHVzaF9rZXJuZWxfcmFuZ2UoKSwgcmVzdWx0aW5nIGlu
IG1pc3NpbmcgVExCIGZsdXNoZXMgYW5kDQo+IGNvbnNlcXVlbnQgZmFpbHVyZXMuDQo+IA0KPiBJ
bnN0ZWFkIGRvIGEgZnVsbCBpbnZhbGlkYXRlIGluIHRoaXMgY2FzZSAtLSBmb3Igbm93Lg0KPiAN
Cj4gRml4ZXM6IGE3Mjk1ZmQ1M2MzOSAoIng4Ni9tbS9jcGE6IFVzZSBmbHVzaF90bGJfa2VybmVs
X3JhbmdlKCkiKQ0KPiBSZXBvcnRlZC1ieTogIlN0RGVuaXMsIFRvbSIgPFRvbS5TdERlbmlzQGFt
ZC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFBldGVyIFppamxzdHJhIChJbnRlbCkgPHBldGVyekBp
bmZyYWRlYWQub3JnPg0KPiAtLS0NCj4gICBhcmNoL3g4Ni9tbS9wYWdlYXR0ci5jIHwgMjQgKysr
KysrKysrKysrKysrKy0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMo
KyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0vcGFnZWF0
dHIuYyBiL2FyY2gveDg2L21tL3BhZ2VhdHRyLmMNCj4gaW5kZXggYmFjMzUwMDFkODk2Li42MWJj
N2QxODAwZDcgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L21tL3BhZ2VhdHRyLmMNCj4gKysrIGIv
YXJjaC94ODYvbW0vcGFnZWF0dHIuYw0KPiBAQCAtMjg1LDIwICsyODUsMTYgQEAgc3RhdGljIHZv
aWQgY3BhX2ZsdXNoX2FsbCh1bnNpZ25lZCBsb25nIGNhY2hlKQ0KPiAgIAlvbl9lYWNoX2NwdShf
X2NwYV9mbHVzaF9hbGwsICh2b2lkICopIGNhY2hlLCAxKTsNCj4gICB9DQo+ICAgDQo+IC1zdGF0
aWMgYm9vbCBfX2NwYV9mbHVzaF9yYW5nZSh1bnNpZ25lZCBsb25nIHN0YXJ0LCBpbnQgbnVtcGFn
ZXMsIGludCBjYWNoZSkNCj4gK3N0YXRpYyBib29sIF9faW52X2ZsdXNoX2FsbChpbnQgY2FjaGUp
DQo+ICAgew0KPiAgIAlCVUdfT04oaXJxc19kaXNhYmxlZCgpICYmICFlYXJseV9ib290X2lycXNf
ZGlzYWJsZWQpOw0KPiAgIA0KPiAtCVdBUk5fT04oUEFHRV9BTElHTihzdGFydCkgIT0gc3RhcnQp
Ow0KPiAtDQo+ICAgCWlmIChjYWNoZSAmJiAhc3RhdGljX2NwdV9oYXMoWDg2X0ZFQVRVUkVfQ0xG
TFVTSCkpIHsNCj4gICAJCWNwYV9mbHVzaF9hbGwoY2FjaGUpOw0KPiAgIAkJcmV0dXJuIHRydWU7
DQo+ICAgCX0NCj4gICANCj4gLQlmbHVzaF90bGJfa2VybmVsX3JhbmdlKHN0YXJ0LCBzdGFydCAr
IFBBR0VfU0laRSAqIG51bXBhZ2VzKTsNCj4gLQ0KPiAtCXJldHVybiAhY2FjaGU7DQo+ICsJcmV0
dXJuIGZhbHNlOw0KPiAgIH0NCj4gICANCj4gICBzdGF0aWMgdm9pZCBjcGFfZmx1c2hfcmFuZ2Uo
dW5zaWduZWQgbG9uZyBzdGFydCwgaW50IG51bXBhZ2VzLCBpbnQgY2FjaGUpDQo+IEBAIC0zMDYs
NyArMzAyLDE0IEBAIHN0YXRpYyB2b2lkIGNwYV9mbHVzaF9yYW5nZSh1bnNpZ25lZCBsb25nIHN0
YXJ0LCBpbnQgbnVtcGFnZXMsIGludCBjYWNoZSkNCj4gICAJdW5zaWduZWQgaW50IGksIGxldmVs
Ow0KPiAgIAl1bnNpZ25lZCBsb25nIGFkZHI7DQo+ICAgDQo+IC0JaWYgKF9fY3BhX2ZsdXNoX3Jh
bmdlKHN0YXJ0LCBudW1wYWdlcywgY2FjaGUpKQ0KPiArCVdBUk5fT04oUEFHRV9BTElHTihzdGFy
dCkgIT0gc3RhcnQpOw0KPiArDQo+ICsJaWYgKF9faW52X2ZsdXNoX2FsbChjYWNoZSkpDQo+ICsJ
CXJldHVybjsNCj4gKw0KPiArCWZsdXNoX3RsYl9rZXJuZWxfcmFuZ2Uoc3RhcnQsIHN0YXJ0ICsg
UEFHRV9TSVpFICogbnVtcGFnZXMpOw0KPiArDQo+ICsJaWYgKCFjYWNoZSkNCj4gICAJCXJldHVy
bjsNCj4gICANCj4gICAJLyoNCj4gQEAgLTMzMiw3ICszMzUsMTIgQEAgc3RhdGljIHZvaWQgY3Bh
X2ZsdXNoX2FycmF5KHVuc2lnbmVkIGxvbmcgYmFkZHIsIHVuc2lnbmVkIGxvbmcgKnN0YXJ0LA0K
PiAgIHsNCj4gICAJdW5zaWduZWQgaW50IGksIGxldmVsOw0KPiAgIA0KPiAtCWlmIChfX2NwYV9m
bHVzaF9yYW5nZShiYWRkciwgbnVtcGFnZXMsIGNhY2hlKSkNCj4gKwlpZiAoX19pbnZfZmx1c2hf
YWxsKGNhY2hlKSkNCj4gKwkJcmV0dXJuOw0KPiArDQo+ICsJZmx1c2hfdGxiX2FsbCgpOw0KPiAr
DQo+ICsJaWYgKCFjYWNoZSkNCj4gICAJCXJldHVybjsNCj4gICANCj4gICAJLyoNCj4gDQoNCg==
