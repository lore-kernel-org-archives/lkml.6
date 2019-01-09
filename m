Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE99C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC322070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WGYo8SvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732584AbfAIQP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:15:26 -0500
Received: from mail-eopbgr720063.outbound.protection.outlook.com ([40.107.72.63]:20736
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730263AbfAIQP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nm3nw6qVMm7wPMidSsJvg3DUh4QVCAJzHdGai24dPJ0=;
 b=WGYo8SvHpFq8+nl4Bz58uf5VJO69OOqwGU+lTgGtq63awCfJhhrhibFfBXH55B3vkRDDVLdGGgjwHkYbAbcXBonHq7kpyUpGNDYnitPKnwtGr+kxvciTF/GkUpWhWARkqAo+2cYAT4Y3VhPHHIuyq5Mlpn/m0V4jQN1viSeUXEI=
Received: from MN2PR12MB3631.namprd12.prod.outlook.com (20.178.243.19) by
 MN2PR12MB3376.namprd12.prod.outlook.com (20.178.242.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Wed, 9 Jan 2019 16:15:23 +0000
Received: from MN2PR12MB3631.namprd12.prod.outlook.com
 ([fe80::1da6:b950:a28e:dae2]) by MN2PR12MB3631.namprd12.prod.outlook.com
 ([fe80::1da6:b950:a28e:dae2%5]) with mapi id 15.20.1495.011; Wed, 9 Jan 2019
 16:15:23 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Jiri Kosina <jikos@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: General protection fault in `switch_mm_irqs_off()`
Thread-Topic: General protection fault in `switch_mm_irqs_off()`
Thread-Index: AQHUo629ixN4vswCO0W5h+67CHfr8qWfUYmAgAeOigCAABODAIAABY6AgAAPAYCAAAFhgIAAHCYA
Date:   Wed, 9 Jan 2019 16:15:22 +0000
Message-ID: <98ed83c0-3077-848b-9de4-add70e9b417a@amd.com>
References: <784ab00e-ed72-c1bc-bc0c-31264deb7726@molgen.mpg.de>
 <alpine.LRH.2.00.1901041737290.28043@gjva.wvxbf.pm>
 <cb7ba667-562b-1e4c-f16e-7c11804bc98a@molgen.mpg.de>
 <alpine.DEB.2.21.1901091410500.1755@nanos.tec.linutronix.de>
 <5c38f377-f088-5684-91a5-c2cc2d64dbbd@molgen.mpg.de>
 <ea49acb9-8165-80a3-e6fe-b29123ad5795@amd.com>
 <206f4322-c15e-6f0b-733d-fd19cd9c24a7@molgen.mpg.de>
In-Reply-To: <206f4322-c15e-6f0b-733d-fd19cd9c24a7@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:805:8e::21) To MN2PR12MB3631.namprd12.prod.outlook.com
 (2603:10b6:208:cc::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3376;20:/fR1cjuSHD0i02eUb0cdgps2Oi4dns6FI31uJat2sVu5gn8R560HNU6i62cR5LEbhqBKuGY3rTB5156P9hl2n3HJPb9a+wwJEP3gGnqpKONt6p73WoQ4ua6jkfPCvfiCn9iUgg3uy2M17Vdq3jiykS10LeQBI7A26+7/ErEfkZUiq0TYUbleEFrrRV9/yDiFo3/H/isLnTMsobMx7+87n6nTtNYrcqSEEbGLFRNWllhrbM/JlPo41sBO7Cg6PlYB
x-ms-office365-filtering-correlation-id: 80772c1d-f3fd-4eac-11c8-08d6764da80f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3376;
x-ms-traffictypediagnostic: MN2PR12MB3376:
x-microsoft-antispam-prvs: <MN2PR12MB337666BD1C4D5C17AC2FE3B8EC8B0@MN2PR12MB3376.namprd12.prod.outlook.com>
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(366004)(346002)(199004)(189003)(102836004)(229853002)(186003)(2906002)(26005)(476003)(2616005)(11346002)(36756003)(25786009)(54906003)(316002)(446003)(110136005)(99286004)(6512007)(93886005)(53936002)(4326008)(6486002)(8676002)(68736007)(6246003)(66066001)(72206003)(413944005)(6116002)(81166006)(386003)(81156014)(7736002)(305945005)(478600001)(31696002)(86362001)(6436002)(8936002)(486006)(5660300001)(3846002)(6506007)(53546011)(97736004)(14454004)(76176011)(256004)(14444005)(52116002)(31686004)(105586002)(71190400001)(71200400001)(106356001)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3376;H:MN2PR12MB3631.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g8Sb1vGAOqnJ3rIgXT8vF8n9FvsQAxFyCdDh+t+5p8eqGKwr9326qarC+ryUk1g3oQgR86HZxAx5+hj0BEocSFUBrsN6nGshUpijfDsdc+H4cdOJJZschPFXnl8jtJ1fvXZHYmTt8PeehnD/t5gi0/JZF0d3K73T7TndE5e1c8U7lB8ndx31w2COyKqDZJlspvYVkGKgRlWXRPI4HN954ROiSRzKGQv7eiBeC99uDdmgeUUY8u4vCyLvA0HP6H7GHpAGdQH7JB3ug7sh9UnXdJVxTYVCueIFxiuzV/nFnGClnmyxkas32YycSz0LHsR3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CBED3A134249F42805079973B14A3B0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80772c1d-f3fd-4eac-11c8-08d6764da80f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 16:15:22.9727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3376
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS85LzE5IDg6MzQgQU0sIFBhdWwgTWVuemVsIHdyb3RlOg0KPiBEZWFyIFRob21hcywNCj4g
DQo+IA0KPiBPbiAwMS8wOS8xOSAxNToyOSwgTGVuZGFja3ksIFRob21hcyB3cm90ZToNCj4+IE9u
IDEvOS8xOSA3OjM1IEFNLCBQYXVsIE1lbnplbCB3cm90ZToNCj4gDQo+Pj4gT24gMDEvMDkvMTkg
MTQ6MTYsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4+Pg0KPj4+PiBPbiBXZWQsIDkgSmFuIDIw
MTksIFBhdWwgTWVuemVsIHdyb3RlOg0KPj4+Pj4gSSBnZXQgdGhlIHNhbWUgd2l0aCBtaWNyb2Nv
ZGUgdXBkYXRlcyBhcHBsaWVkLg0KPj4+Pj4NCj4+Pj4+ICAgICAkIGRtZXNnIHwgZ3JlcCAnbWlj
cm9jb2RlOiBDUFUwOiBwYXRjaF9sZXZlbCcNCj4+Pj4+ICAgICBbICAgIDMuODA5MjEwXSBtaWNy
b2NvZGU6IENQVTA6IHBhdGNoX2xldmVsPTB4MDYwMDA2M2UNCj4+Pj4+ICAgICAkIHN1ZG8gbW9k
cHJvYmUgbXNyDQo+Pj4+PiAgICAgJCBzdWRvIC4vd3Jtc3IgMHg0OSAweDENCj4+Pj4+ICAgICB3
cm1zcjogQ1BVIDAgY2Fubm90IHNldCBNU1IgMHgwMDAwMDA0OSB0byAweDAwMDAwMDAwMDAwMDAw
MDENCj4+Pj4+DQo+Pj4+Pj4gQ291bGQgeW91IHBsZWFzZSBwb3N0IC9wcm9jL2NwdWluZm8gZnJv
bSBzdWNoIGEgYm9vdCBhcyB3ZWxsPw0KPj4+Pg0KPj4+PiAvcHJvYy9jcHVpbmZvIHVuZm9ydHVu
YXRlbHkgZG9lcyBub3QgY29udGFpbiB0aGUgYW1kIHNwZWNpZmljIElCUEIgZmxhZywNCj4+Pj4g
YnV0IHRoZSBkbWVzZyBvZiB0aGUgb3JpZ2luYWwgcmVwb3J0IHNheXM6DQo+Pj4+DQo+Pj4+ICAg
U3BlY3RyZSBWMiA6IG1pdGlnYXRpb246IEVuYWJsaW5nIGNvbmRpdGlvbmFsIEluZGlyZWN0IEJy
YW5jaCBQcmVkaWN0aW9uIEJhcnJpZXINCj4+Pj4NCj4+Pj4gd2hpY2ggbWVhbnMsIHRoYXQgdGhl
IENQVUlEIGJpdCBpcyBzZXQuDQo+Pj4+DQo+Pj4+IENhbiB5b3UgcGxlYXNlIHByb3ZpZGUgdGhl
IG91dHB1dCBvZjoNCj4+Pj4NCj4+Pj4gICBjcHVpZCAtMSAtbCAweDgwMDAwMDA4IC1yDQo+Pj4+
DQo+Pj4+IE9uIG15IEFNRCBPcHRlcm9uKFRNKSBQcm9jZXNzb3IgNjI3NiB3aXRoIG1pY3JvY29k
ZSAweDYwMDA2M2QgbG9hZGVkIEkgZ2V0Og0KPj4+Pg0KPj4+PiAgICAweDgwMDAwMDA4IDB4MDA6
IGVheD0weDAwMDAzMDMwIGVieD0weDAwMDAwMDAwIGVjeD0weDAwMDA1MDBmIGVkeD0weDAwMDAw
MDAwDQo+Pj4+DQo+Pj4+IEVCWCBpcyAwLCB3aGljaCBtZWFucyB0aGF0IFg4Nl9GRUFUVVJFX0FN
RF9JQlBCIGlzIG5vdCBlbmFibGVkLiBTbyB0aGUNCj4+Pj4ga2VybmVsIGRvZXMgbm90IHRyeSB0
byB1c2UgdGhlIHNwZWN1bGF0aW9uIGNvbnRyb2wgTVNSICgweDQ5KS4NCj4+Pg0KPj4+IFdpdGgg
Q1BVSUQgMjAxODA1MTksIEkgZ2V0IHRoZSBvdXRwdXQgYmVsb3cgd2l0aCBib3RoIG1pY3JvY29k
ZSB1cGRhdGUgdmVyc2lvbnMuDQo+Pj4NCj4+PiAweDYwMDA2M2Q6DQo+Pj4NCj4+PiAgICAgJCBz
dWRvIC4vY3B1aWQgLTEgLWwgMHg4MDAwMDAwOCAtcg0KPj4+ICAgICBDUFU6DQo+Pj4gICAgICAg
IDB4ODAwMDAwMDggMHgwMDogZWF4PTB4MDAwMDMwMzAgZWJ4PTB4MDAwMDAwMDAgZWN4PTB4MDAw
MDUwMGYgZWR4PTB4MDAwMDAwMDANCj4+Pg0KPj4+IDB4NjAwMDYzZToNCj4+Pg0KPj4+ICAgICAk
IHN1ZG8gLi9jcHVpZCAtMSAtbCAweDgwMDAwMDA4IC1yDQo+Pj4gICAgIENQVToNCj4+PiAgICAg
ICAgMHg4MDAwMDAwOCAweDAwOiBlYXg9MHgwMDAwMzAzMCBlYng9MHgwMDAwMDAwMCBlY3g9MHgw
MDAwNTAwZiBlZHg9MHgwMDAwMDAwMA0KPj4NCj4+IEhtbW0uLi4gc28gZWJ4IGlzIDAgZm9yIGJv
dGggdmVyc2lvbnMsIHNvIEknbSBub3Qgc3VyZSBob3cgSUJQQiBpcyBiZWluZw0KPj4gc2V0LiBX
aGF0J3MgdGhlIENQVUlEIG91dHB1dCBmb3IgMHgwNyAoY3B1aWQgLTEgLWwgMHgwNyAtcik/DQo+
IA0KPiAgICAgJCBzdWRvIC4vY3B1aWQgLTEgLWwgMHgwNyAtcg0KPiAgICAgQ1BVOg0KPiAgICAg
ICAgMHgwMDAwMDAwNyAweDAwOiBlYXg9MHgwMDAwMDAwMCBlYng9MHgwMDAwMDAwMCBlY3g9MHgw
MDAwMDAwMCBlZHg9MHgwMDAwMDAwMA0KDQpJJ20gY29uZnVzZWQgdGhlbi4uLiAgdGhlIG9ubHkg
d2F5IHRoYXQgSSBjYW4gc2VlIHRoYXQgdGhlIElCUEIgZmVhdHVyZQ0KY2FuIGJlIHNldCBpcyBp
ZiAweDgwMDAwMDA4W0VCWF0gYml0IDEyIGlzIHNldCBvciBpZiAweDA3W0VEWF0gYml0IDI2IGlz
DQpzZXQgLSBuZWl0aGVyIG9mIHdoaWNoIGlzIHRoZSBjYXNlLiBJIG11c3QgYmUgbWlzc2luZyBz
b21ldGhpbmcuLi4NCg0KVGhhbmtzLA0KVG9tDQoNCj4gDQo+IA0KPiBLaW5kIHJlZ2FyZHMsDQo+
IA0KPiBQYXVsDQo+IA0K
