Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6B4C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E780A2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EUXn1TZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E780A2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbeLACgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:36:45 -0500
Received: from mail-eopbgr770051.outbound.protection.outlook.com ([40.107.77.51]:10368
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726555AbeLACgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:36:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsXw8U8RPy4MQjbKWfEIE1g/CznRfCZxKrOJIZxWvY0=;
 b=EUXn1TZ4794sZq8KTZtr9sN4tBwtW3sclGUE9WmluvRANGy7jg+Mql8lZlivcjPgQieV5s4iFj90rHqZV1uk+/NpYN5+ggfu70FJXQ3OwoD0DjKPJoFToEffxDJq8lKUIhB2dQnE3ydBppbKH1wKrgTy5iedEKk2ou+xHZC4I4o=
Received: from MWHPR1201MB0061.namprd12.prod.outlook.com (10.174.98.12) by
 MWHPR1201MB0270.namprd12.prod.outlook.com (10.174.99.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.18; Fri, 30 Nov 2018 15:27:02 +0000
Received: from MWHPR1201MB0061.namprd12.prod.outlook.com
 ([fe80::4481:91d7:9564:e869]) by MWHPR1201MB0061.namprd12.prod.outlook.com
 ([fe80::4481:91d7:9564:e869%9]) with mapi id 15.20.1361.019; Fri, 30 Nov 2018
 15:27:02 +0000
From:   "StDenis, Tom" <Tom.StDenis@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 0/4] x86/mm/cpa: Fix cpa-array TLB invalidation
Thread-Topic: [PATCH 0/4] x86/mm/cpa: Fix cpa-array TLB invalidation
Thread-Index: AQHUiLXipdRkoql6EkWifNhS5aJus6VoZy0AgAAE7ICAAAE+AIAAAp2AgAAA5AA=
Date:   Fri, 30 Nov 2018 15:27:02 +0000
Message-ID: <2b50ff31-11a5-21d1-a22a-4ffda0664c9a@amd.com>
References: <20181130134455.490139778@infradead.org>
 <d1e4cb48-1952-fb61-bd2b-db9efe3b5f1a@amd.com>
 <20181130150959.GA11614@hirez.programming.kicks-ass.net>
 <9b172efa-0279-0a39-0b6b-7cf3492d326d@amd.com>
 <20181130152347.GB11614@hirez.programming.kicks-ass.net>
In-Reply-To: <20181130152347.GB11614@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::22) To MWHPR1201MB0061.namprd12.prod.outlook.com
 (2603:10b6:301:54::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR1201MB0270;20:5sHIpI0ZtHEFklsKhE/Oug8Rw6RWSki0rHitKbP00teO6/cNMZnpzzWPTm4pjTNGFvbX0iFPvZpn0GYv7KShY+2qL4KwsdATJS1yBqxlFWhjPIr1v36EhFK6LAg8KwaumUVWqwQz83p31FLQ5cSoYYHXoEShS8mJniJr2qzFLYiAshUrVwSnETEYt+AWQjYG8wT8qkmEENMrlEgZL+zb0Ek6gQNAlmgm1QAURD6GnE9g20miYFEPCo0+hVNMT9/B
x-ms-office365-filtering-correlation-id: 1195e32c-062a-4278-1818-08d656d846ed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR1201MB0270;
x-ms-traffictypediagnostic: MWHPR1201MB0270:
x-microsoft-antispam-prvs: <MWHPR1201MB02701D5400E4930B3659401DF7D30@MWHPR1201MB0270.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231453)(999002)(944501466)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR1201MB0270;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB0270;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(39860400002)(346002)(396003)(189003)(199004)(66066001)(36756003)(31686004)(106356001)(105586002)(6512007)(99286004)(2616005)(11346002)(476003)(446003)(52116002)(3846002)(53936002)(6246003)(6116002)(2906002)(486006)(6916009)(5660300001)(93886005)(316002)(68736007)(6436002)(6486002)(4326008)(76176011)(305945005)(7736002)(386003)(6506007)(53546011)(26005)(186003)(4001150100001)(229853002)(97736004)(86362001)(71200400001)(71190400001)(31696002)(81156014)(81166006)(8936002)(5024004)(478600001)(8676002)(14454004)(102836004)(72206003)(256004)(54906003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0270;H:MWHPR1201MB0061.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /EJRiiQ6JFUZOpWhhg0Jxi0oAHLh6ZN17mAbjRK61Wp54//043oUZuLUecjJwIGDdJrta19vKK6PXfzxXmwsiv/o0uPEEBhabjF2IgxlqRWEAaQ87swpec3rtIUY/YNN1XlT6ZCJC0dP98QMFmdNClYHyHOnIc34mUOPEkcpLjz7ZrS/4zJ3he2NJ6ngOryiVKEsy7QLVxQyFfobV9fdB4BxTRy2+qhHawuC4E6fFyKlVapk7bgM5t6q07if1c1EkNIFKggMofdoOTVlwKaeBlfzrVwniS2d/cKTIt/hOf5tjipl1EULSTytRs7f30taly6l/RmH1QXXxjXF70kiQtNuQTdU48CJpIku2D4CS34=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C94CE80C93D1E49A422C9EF0BF4FB72@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1195e32c-062a-4278-1818-08d656d846ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 15:27:02.5814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0270
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMS0zMCAxMDoyMyBhLm0uLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gT24gRnJp
LCBOb3YgMzAsIDIwMTggYXQgMDM6MTQ6MzBQTSArMDAwMCwgU3REZW5pcywgVG9tIHdyb3RlOg0K
Pj4gT24gMjAxOC0xMS0zMCAxMDowOSBhLm0uLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4+PiBP
biBGcmksIE5vdiAzMCwgMjAxOCBhdCAwMjo1MjoyNlBNICswMDAwLCBTdERlbmlzLCBUb20gd3Jv
dGU6DQo+Pj4+IEhpIFBldGVyLA0KPj4+Pg0KPj4+PiBVbmZvcnR1bmF0ZWx5IEkgY2FuJ3QgYXBw
bHkgdGhpcyBvbiB0b3Agb2Ygb3VyIGRybS1uZXh0IHRoZSBmaXJzdCBwYXRjaA0KPj4+PiBmYWls
cy4NCj4+Pg0KPj4+IEFnYWluc3Qgd2hhdCB0cmVlIHdvdWxkIHlvdSBsaWtlIHRoZSBwYXRjaGVz
PyByZWJhc2luZyBzaG91bGQgbm90IGJlDQo+Pj4gaGFyZCBJIHRoaW5rLg0KPj4+DQo+Pg0KPj4g
QWN0dWFsbHkgSSBqdXN0IHRyaWVkIGFwcGx5aW5nIGFnYWluc3QgdGhlIHRpcCBvZiBtYXN0ZXIg
YW5kIGdvdCB0aGUNCj4+IHNhbWUgZXJyb3JzLi4uDQo+Pg0KPj4gW3Jvb3RAY2Fycml6byBsaW51
eF0jIGdpdCBhcHBseSBcW1BBVENIXCAxXzRcXVwgeDg2X21tX2NwYVw6XCBBZGRcDQo+PiBfX2Nw
YV9hZGRyXChcKVwgaGVscGVyXCAtXCBQZXRlclwgWmlqbHN0cmFcIFw8cGV0ZXJ6QGluZnJhZGVh
ZC5vcmdcPlwgLVwNCj4+IDIwMTgtMTEtMzBcIDA4NDQuZW1sDQo+PiBlcnJvcjogcGF0Y2ggZmFp
bGVkOiBhcmNoL3g4Ni9tbS9wYWdlYXR0ci5jOjIyOA0KPj4gZXJyb3I6IGFyY2gveDg2L21tL3Bh
Z2VhdHRyLmM6IHBhdGNoIGRvZXMgbm90IGFwcGx5DQo+Pg0KPj4NCj4+IEFueSBpZGVhcz8NCj4g
DQo+IEh1cm0uLiBuby4gVGhleSBhcHBseSBjbGVhbmx5IHRvIExpbnVzJyB0cmVlIGhlcmUuDQo+
IA0KPiBsaW51eC0yLjYkIGdpdCBkZXNjcmliZQ0KPiB2NC4yMC1yYzQtMTU2LWc5NGYzNzFjYjcz
OTQNCj4gbGludXgtMi42JCBxdWlsdCBwdXNoIDQNCj4gQXBwbHlpbmcgcGF0Y2ggcGF0Y2hlcy9w
ZXRlcnotY3BhLWFkZHIucGF0Y2gNCj4gcGF0Y2hpbmcgZmlsZSBhcmNoL3g4Ni9tbS9wYWdlYXR0
ci5jDQo+IEFwcGx5aW5nIHBhdGNoIHBhdGNoZXMvcGV0ZXJ6LWNwYS1maXgtZmx1c2hfYXJyYXku
cGF0Y2gNCj4gcGF0Y2hpbmcgZmlsZSBhcmNoL3g4Ni9tbS9tbV9pbnRlcm5hbC5oDQo+IHBhdGNo
aW5nIGZpbGUgYXJjaC94ODYvbW0vcGFnZWF0dHIuYw0KPiBwYXRjaGluZyBmaWxlIGFyY2gveDg2
L21tL3RsYi5jDQo+IEFwcGx5aW5nIHBhdGNoIHBhdGNoZXMvcGV0ZXJ6LWNwYS1mb2xkLWNwYV9m
bHVzaC5wYXRjaA0KPiBwYXRjaGluZyBmaWxlIGFyY2gveDg2L21tL3BhZ2VhdHRyLmMNCj4gQXBw
bHlpbmcgcGF0Y2ggcGF0Y2hlcy9wZXRlcnotY3BhLWNsZmx1c2hfb3B0LnBhdGNoDQo+IHBhdGNo
aW5nIGZpbGUgYXJjaC94ODYvbW0vcGFnZWF0dHIuYw0KPiBOb3cgYXQgcGF0Y2ggcGF0Y2hlcy9w
ZXRlcnotY3BhLWNsZmx1c2hfb3B0LnBhdGNoDQo+IA0KPiBXZWlyZC4NCj4gDQoNCkkgY2FuIGFw
cGx5IHRoZSBwYXRjaCB5b3UgYXR0YWNoZWQgYnV0IHRoZSBpbmxpbmUgcGF0Y2hlcyBqdXN0IGRv
bid0IA0KYXBwbHkuICBDb3VsZCBiZSBteSBpbWFwIGNsaWVudCAodGh1bmRlcmJpcmQpIG1hbmds
ZWQgdGhlbSBidXQgSSd2ZSANCmFwcGxpZWQgcGF0Y2hlcyB0aGlzIHdheSBiZWZvcmUuICBjb3Vs
ZCB5b3UgYXR0YWNoIHRoZW0gaW5zdGVhZCBwbGVhc2U/DQoNClRvbQ0K
