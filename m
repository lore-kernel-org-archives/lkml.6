Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088D7C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4FB2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wZ7nmDE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4FB2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeLEQ1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:27:01 -0500
Received: from mail-eopbgr760081.outbound.protection.outlook.com ([40.107.76.81]:37664
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727523AbeLEQ1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuJBtZ7pvwPhu3PeCJ1WodN29k4N7mbkqoThv0ZGgi0=;
 b=wZ7nmDE1YtXZroiaLm1qNQbm+Hjbbu9Bg/JYxuRyJiJjO/S/pE/6KmMSjjxQHcg1zphy8LAuMAqcr2foROAvl1trKzTHOZIY9pkeoAN3ANPNpI8h6/qCUEOWsGKTGL2S1Z8IGQmV1VoN0BEn0owUCAN8yB5L+wBHTqxn0mwWOHM=
Received: from MWHPR1201MB0061.namprd12.prod.outlook.com (10.174.98.12) by
 MWHPR1201MB2509.namprd12.prod.outlook.com (10.172.96.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Wed, 5 Dec 2018 16:24:02 +0000
Received: from MWHPR1201MB0061.namprd12.prod.outlook.com
 ([fe80::4481:91d7:9564:e869]) by MWHPR1201MB0061.namprd12.prod.outlook.com
 ([fe80::4481:91d7:9564:e869%9]) with mapi id 15.20.1404.019; Wed, 5 Dec 2018
 16:24:02 +0000
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
Thread-Index: AQHUiLXipdRkoql6EkWifNhS5aJus6VoZy0AgAAE7ICAAAE+AIAAAp2AgAACJQCAAA16AIAErDEA///rEQCAA0WYAA==
Date:   Wed, 5 Dec 2018 16:24:02 +0000
Message-ID: <54ccb426-c967-4851-bc51-519357a04eaf@amd.com>
References: <20181130134455.490139778@infradead.org>
 <d1e4cb48-1952-fb61-bd2b-db9efe3b5f1a@amd.com>
 <20181130150959.GA11614@hirez.programming.kicks-ass.net>
 <9b172efa-0279-0a39-0b6b-7cf3492d326d@amd.com>
 <20181130152347.GB11614@hirez.programming.kicks-ass.net>
 <20181130153128.GB11650@hirez.programming.kicks-ass.net>
 <8ee4e546-4680-e463-23ac-64489a60b946@amd.com>
 <20181203154102.GI11614@hirez.programming.kicks-ass.net>
 <ebd0b71b-88be-9b55-bd7a-e32d6ff5476a@amd.com>
In-Reply-To: <ebd0b71b-88be-9b55-bd7a-e32d6ff5476a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::25) To MWHPR1201MB0061.namprd12.prod.outlook.com
 (2603:10b6:301:54::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [69.159.71.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR1201MB2509;20:weRal79/YgDiYL/Vdhb/Q229UDvczFEzGRWlHOZfgle/DPs18ihMBaeErIO7g6B9anGJjoH+uvAIQvNR5Cg8l8EovLXiT5avkO7OeT7HiQYzIc97hxP54YQKYQYr36689/qm54NRDpetcQ+rnTKfvWTYEPUWB1ezc1b3yz7HhPogGu3EmiqvxeeSQEPafWcfFo+3bYQE3NvPKWm2c4Ab4coA15XWzxJ8ic7uyCpWI4QE47wBNynuVYS/cCXwJUN6
x-ms-office365-filtering-correlation-id: 24970d46-71a3-415c-d258-08d65ace114e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR1201MB2509;
x-ms-traffictypediagnostic: MWHPR1201MB2509:
x-microsoft-antispam-prvs: <MWHPR1201MB250997CA1804E6B128995638F7A80@MWHPR1201MB2509.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:MWHPR1201MB2509;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB2509;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(39860400002)(136003)(189003)(199004)(31686004)(7736002)(86362001)(66066001)(8676002)(6246003)(446003)(54906003)(6486002)(53936002)(8936002)(97736004)(4326008)(6436002)(6512007)(76176011)(81166006)(81156014)(52116002)(71200400001)(71190400001)(11346002)(99286004)(106356001)(72206003)(229853002)(5660300001)(3846002)(14454004)(186003)(6116002)(5024004)(14444005)(256004)(93886005)(476003)(26005)(105586002)(25786009)(6916009)(316002)(36756003)(2616005)(53546011)(2906002)(31696002)(486006)(305945005)(68736007)(6506007)(386003)(478600001)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB2509;H:MWHPR1201MB0061.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /+ClwyLI8Yq106vrdb4PB7Q7kdw+s/Y3EeBkA1T1yScwFdJndpwdgL9E7twXve4zwuwtRNdnvJ7OTs79UCne7qbOfIokhp8Vo7MC+pLW++xhcuXcadewuE2ufHw/FghDwLYBPzB3437201V468TyMIyEjQZMkpwgDu1aiD+CdKYPOQq8vZImPenFDbnTHH9ht9plCl9EDD/EDovFJ8usdyLAesOcIoVeJfRhJTmk7g9Ia5UP36epzAc6ESRA6S0HULsnNnos0Kjr/+uMGicAwaJY3WTcB+J/HWHeTg/znfhNjq3ZXSmvwkrTyzjQMyfT/J/l98rSybqc6uf5McXigXHpQVnC8wFZKaVAlXylE/U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <052F73674CB3834D9FDADAABA2D45EBF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24970d46-71a3-415c-d258-08d65ace114e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 16:24:02.6150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2509
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGV0ZXIsDQoNCkdvb2QgbmV3cyBpcyB0aGF0IEkgZ290IG91ciBvcGVuZ2wgdGVzdCBydW5u
aW5nIG9uIHlvdXIgeDg2L21tIGJyYW5jaC4gDQpUaGUgY29tbWl0IGEyYjQzMDZjNTBiNWRlMmNh
OTU1Y2Q3M2FjNTdjMmFjNjQyNmVlMTUgKGN1cnJlbnQgdGlwIG9mIA0KeDg2L21tKSBpcyBnb29k
LiAgRm9yIHNhbml0eSBJIGp1bXBlZCBiYWNrIGFuZCBmb3VuZCAgdGhpcyBjb21taXQNCmEyYWE1
MmFiMTZlZmJlZTQwYWQxMThlYmFjNGE1ZTQzOGY1YjQzZWUgZG9lc24ndCB3b3JrLg0KDQpUaGFu
a3MsDQpUb20NCg0KDQoNCk9uIDIwMTgtMTItMDMgMjoyNiBwLm0uLCBUb20gU3QgRGVuaXMgd3Jv
dGU6DQo+IEhpIFBldGVyLA0KPiANCj4gQWZ0ZXIgdXBkYXRpbmcgbXkgVU1EcyAobWVzYS9ldGMp
IG92ZXIgdGhlIHdlZWtlbmQgSSBjYW5ub3QgcmVwcm9kdWNlIA0KPiB0aGUgYnVnIHRvIGJlZ2lu
IHdpdGguwqAgSSdsbCB0cnkganVtcGluZyBkaXJlY3RseSB0byB0aGUgaW50ZXJzZWN0aW9uIA0K
PiBhbmQgc2VlIGlmIEkgY2FuIHJlcHJvZHVjZSB0aGUgZmF1bHQgdGhlcmUgb3RoZXJ3aXNlIEkn
bGwgaGF2ZSB0byANCj4gcm9sbGJhY2sgbXkgdW1kcy4NCj4gDQo+IEhvcGVmdWxseSBJIGNhbiB0
ZXN0IHRoaXMgdG9tb3Jyb3cuDQo+IA0KPiBUb20NCj4gDQo+IE9uIDIwMTgtMTItMDMgMTA6NDEg
YS5tLiwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+PiBPbiBGcmksIE5vdiAzMCwgMjAxOCBhdCAw
NDoxOTo0NlBNICswMDAwLCBTdERlbmlzLCBUb20gd3JvdGU6DQo+Pj4gTkFLIEkgZ2V0IGEgZmFp
bHVyZSBpbiBUVE0gb24gaW5pdCB3aXRoIHlvdXIgeDg2L21tIGJyYW5jaCAoc2VlIGF0dGFjaGVk
DQo+Pj4gZG1lc2cpLg0KPj4NCj4+IFNvIHRoZSBnb29kIG5ld3MgaXMgdGhhdCB3aXRoIHNvbWUg
YWRkaXRpb25hbCBzZWxmLXRlc3RzIEkgY2FuIHRyaXZpYWxseQ0KPj4gcmVwcm9kdWNlIHRoaXMu
IFRoZSBiYWQgbmV3cyBpcyB0aGF0IGFuIG90aGVyd2lzZSBzdHJhaWdodCBmb3J3YXJkDQo+PiBj
bGVhbnVwIHNlZW1zIHRvIG1ha2UgQ1BBIGhvcnJpYmx5IG1hZCBhdCBtZS4NCj4+DQo+PiBBbmQg
c2luY2Ugd2UncmUgc29tZXdoYXQgbGF0ZSBpbiB0aGUgcmVsZWFzZSBjeWNsZSwgSSBzdXBwb3Nl
IHdlIHNob3VsZA0KPj4gZG8gdGhlIHNpbXBsZSB0aGluZyBmaXJzdCwgYW5kIHRoZW4gSSBjYW4g
dHJ5IGFuZCBmaWd1cmUgb3V0IHRoaXMgQ1BBDQo+PiBtZXNzIGxhdGVyLg0KPj4NCj4+IFNvIGhv
dyBhYm91dCB0aGlzIHJlbGF0aXZlbHkgc2ltcGxlIHBhcnRpYWwgcmV2ZXJ0IHRvIHNvcnQgdGhl
IHByb2JsZW0uDQo+Pg0KPj4gLS0tDQo+PiBTdWJqZWN0OiB4ODYvbW0vY3BhOiBGaXggY3BhX2Zs
dXNoX2FycmF5KCkgVExCIGludmFsaWRhdGlvbg0KPj4NCj4+IEluIGNvbW1pdDoNCj4+DQo+PiDC
oMKgIGE3Mjk1ZmQ1M2MzOSAoIng4Ni9tbS9jcGE6IFVzZSBmbHVzaF90bGJfa2VybmVsX3Jhbmdl
KCkiKQ0KPj4NCj4+IEkgbWlzcmVhZCB0aGUgY3BhIGFycmF5IGNvZGUgYW5kIGluY29ycmVjdGx5
IHVzZWQNCj4+IHRsYl9mbHVzaF9rZXJuZWxfcmFuZ2UoKSwgcmVzdWx0aW5nIGluIG1pc3Npbmcg
VExCIGZsdXNoZXMgYW5kDQo+PiBjb25zZXF1ZW50IGZhaWx1cmVzLg0KPj4NCj4+IEluc3RlYWQg
ZG8gYSBmdWxsIGludmFsaWRhdGUgaW4gdGhpcyBjYXNlIC0tIGZvciBub3cuDQo+Pg0KPj4gRml4
ZXM6IGE3Mjk1ZmQ1M2MzOSAoIng4Ni9tbS9jcGE6IFVzZSBmbHVzaF90bGJfa2VybmVsX3Jhbmdl
KCkiKQ0KPj4gUmVwb3J0ZWQtYnk6ICJTdERlbmlzLCBUb20iIDxUb20uU3REZW5pc0BhbWQuY29t
Pg0KPj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgWmlqbHN0cmEgKEludGVsKSA8cGV0ZXJ6QGluZnJh
ZGVhZC5vcmc+DQo+PiAtLS0NCj4+IMKgIGFyY2gveDg2L21tL3BhZ2VhdHRyLmMgfCAyNCArKysr
KysrKysrKysrKysrLS0tLS0tLS0NCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25z
KCspLCA4IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9tbS9wYWdl
YXR0ci5jIGIvYXJjaC94ODYvbW0vcGFnZWF0dHIuYw0KPj4gaW5kZXggYmFjMzUwMDFkODk2Li42
MWJjN2QxODAwZDcgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9tbS9wYWdlYXR0ci5jDQo+PiAr
KysgYi9hcmNoL3g4Ni9tbS9wYWdlYXR0ci5jDQo+PiBAQCAtMjg1LDIwICsyODUsMTYgQEAgc3Rh
dGljIHZvaWQgY3BhX2ZsdXNoX2FsbCh1bnNpZ25lZCBsb25nIGNhY2hlKQ0KPj4gwqDCoMKgwqDC
oCBvbl9lYWNoX2NwdShfX2NwYV9mbHVzaF9hbGwsICh2b2lkICopIGNhY2hlLCAxKTsNCj4+IMKg
IH0NCj4+IC1zdGF0aWMgYm9vbCBfX2NwYV9mbHVzaF9yYW5nZSh1bnNpZ25lZCBsb25nIHN0YXJ0
LCBpbnQgbnVtcGFnZXMsIGludCANCj4+IGNhY2hlKQ0KPj4gK3N0YXRpYyBib29sIF9faW52X2Zs
dXNoX2FsbChpbnQgY2FjaGUpDQo+PiDCoCB7DQo+PiDCoMKgwqDCoMKgIEJVR19PTihpcnFzX2Rp
c2FibGVkKCkgJiYgIWVhcmx5X2Jvb3RfaXJxc19kaXNhYmxlZCk7DQo+PiAtwqDCoMKgIFdBUk5f
T04oUEFHRV9BTElHTihzdGFydCkgIT0gc3RhcnQpOw0KPj4gLQ0KPj4gwqDCoMKgwqDCoCBpZiAo
Y2FjaGUgJiYgIXN0YXRpY19jcHVfaGFzKFg4Nl9GRUFUVVJFX0NMRkxVU0gpKSB7DQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgY3BhX2ZsdXNoX2FsbChjYWNoZSk7DQo+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIHRydWU7DQo+PiDCoMKgwqDCoMKgIH0NCj4+IC3CoMKgwqAgZmx1c2hfdGxiX2tl
cm5lbF9yYW5nZShzdGFydCwgc3RhcnQgKyBQQUdFX1NJWkUgKiBudW1wYWdlcyk7DQo+PiAtDQo+
PiAtwqDCoMKgIHJldHVybiAhY2FjaGU7DQo+PiArwqDCoMKgIHJldHVybiBmYWxzZTsNCj4+IMKg
IH0NCj4+IMKgIHN0YXRpYyB2b2lkIGNwYV9mbHVzaF9yYW5nZSh1bnNpZ25lZCBsb25nIHN0YXJ0
LCBpbnQgbnVtcGFnZXMsIGludCANCj4+IGNhY2hlKQ0KPj4gQEAgLTMwNiw3ICszMDIsMTQgQEAg
c3RhdGljIHZvaWQgY3BhX2ZsdXNoX3JhbmdlKHVuc2lnbmVkIGxvbmcgc3RhcnQsIA0KPj4gaW50
IG51bXBhZ2VzLCBpbnQgY2FjaGUpDQo+PiDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCBpLCBsZXZl
bDsNCj4+IMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBhZGRyOw0KPj4gLcKgwqDCoCBpZiAoX19j
cGFfZmx1c2hfcmFuZ2Uoc3RhcnQsIG51bXBhZ2VzLCBjYWNoZSkpDQo+PiArwqDCoMKgIFdBUk5f
T04oUEFHRV9BTElHTihzdGFydCkgIT0gc3RhcnQpOw0KPj4gKw0KPj4gK8KgwqDCoCBpZiAoX19p
bnZfZmx1c2hfYWxsKGNhY2hlKSkNCj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+PiArDQo+
PiArwqDCoMKgIGZsdXNoX3RsYl9rZXJuZWxfcmFuZ2Uoc3RhcnQsIHN0YXJ0ICsgUEFHRV9TSVpF
ICogbnVtcGFnZXMpOw0KPj4gKw0KPj4gK8KgwqDCoCBpZiAoIWNhY2hlKQ0KPj4gwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybjsNCj4+IMKgwqDCoMKgwqAgLyoNCj4+IEBAIC0zMzIsNyArMzM1LDEy
IEBAIHN0YXRpYyB2b2lkIGNwYV9mbHVzaF9hcnJheSh1bnNpZ25lZCBsb25nIGJhZGRyLCANCj4+
IHVuc2lnbmVkIGxvbmcgKnN0YXJ0LA0KPj4gwqAgew0KPj4gwqDCoMKgwqDCoCB1bnNpZ25lZCBp
bnQgaSwgbGV2ZWw7DQo+PiAtwqDCoMKgIGlmIChfX2NwYV9mbHVzaF9yYW5nZShiYWRkciwgbnVt
cGFnZXMsIGNhY2hlKSkNCj4+ICvCoMKgwqAgaWYgKF9faW52X2ZsdXNoX2FsbChjYWNoZSkpDQo+
PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPj4gKw0KPj4gK8KgwqDCoCBmbHVzaF90bGJfYWxs
KCk7DQo+PiArDQo+PiArwqDCoMKgIGlmICghY2FjaGUpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuOw0KPj4gwqDCoMKgwqDCoCAvKg0KPj4NCj4gDQoNCg==
