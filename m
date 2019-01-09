Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24133C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CF22070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pIcRLesk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbfAIO3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:29:46 -0500
Received: from mail-eopbgr750042.outbound.protection.outlook.com ([40.107.75.42]:11712
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730605AbfAIO3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnxOn3ra6wEaZLCJjEXnB3sTohf+0+jqP82NeV+PpPo=;
 b=pIcRLeskPty3AO0Qf1KniXUrCw7Q7hLYJWkL7iyLKygbBQGRPse8YZewqUPNIw7SPntSh6U43388BQh7LFxIdRPPusJ7mgG/7A+jdm20pMBvus1Rv7wFRZJlZUY8iiBmg0n8fhGdbsxd2Wshi/31Nf1E2eQvP5RAe+gSbLhxO1w=
Received: from MN2PR12MB3631.namprd12.prod.outlook.com (20.178.243.19) by
 MN2PR12MB3040.namprd12.prod.outlook.com (20.178.243.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Wed, 9 Jan 2019 14:29:42 +0000
Received: from MN2PR12MB3631.namprd12.prod.outlook.com
 ([fe80::1da6:b950:a28e:dae2]) by MN2PR12MB3631.namprd12.prod.outlook.com
 ([fe80::1da6:b950:a28e:dae2%5]) with mapi id 15.20.1495.011; Wed, 9 Jan 2019
 14:29:42 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Jiri Kosina <jikos@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: General protection fault in `switch_mm_irqs_off()`
Thread-Topic: General protection fault in `switch_mm_irqs_off()`
Thread-Index: AQHUo629ixN4vswCO0W5h+67CHfr8qWfUYmAgAeOigCAABODAIAABY6AgAAPAYA=
Date:   Wed, 9 Jan 2019 14:29:41 +0000
Message-ID: <ea49acb9-8165-80a3-e6fe-b29123ad5795@amd.com>
References: <784ab00e-ed72-c1bc-bc0c-31264deb7726@molgen.mpg.de>
 <alpine.LRH.2.00.1901041737290.28043@gjva.wvxbf.pm>
 <cb7ba667-562b-1e4c-f16e-7c11804bc98a@molgen.mpg.de>
 <alpine.DEB.2.21.1901091410500.1755@nanos.tec.linutronix.de>
 <5c38f377-f088-5684-91a5-c2cc2d64dbbd@molgen.mpg.de>
In-Reply-To: <5c38f377-f088-5684-91a5-c2cc2d64dbbd@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0801CA0016.namprd08.prod.outlook.com
 (2603:10b6:803:29::26) To MN2PR12MB3631.namprd12.prod.outlook.com
 (2603:10b6:208:cc::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3040;20:DNAbimW2tplPbfH00E/RiAix5kbue98g6R7RtYoA2PU0tX6yxzWk7BFgK96Co11S8gA70HKLHGmHUz4Mb+247KXhyAKHFEv3qYDYWcmv6gDOgeL0bWhE7UotxuQ4nkUSUxXadNMWcrE5Wy207svx713/hG+hnPidLa37yeKIokaSp9Z0gpFvkZnd/6Sg+iSLFYRGLbbQoNbp1KMNqAZ3/dycjidL2edZ8QM8Z/rbvsrnVzcurM6TrHTDXkXp5fZb
x-ms-office365-filtering-correlation-id: f6c14be7-50f2-4257-f745-08d6763ee4c0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3040;
x-ms-traffictypediagnostic: MN2PR12MB3040:
x-microsoft-antispam-prvs: <MN2PR12MB3040DFC3C9F261CB02D67F99EC8B0@MN2PR12MB3040.namprd12.prod.outlook.com>
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(366004)(39860400002)(189003)(199004)(36756003)(102836004)(31696002)(14454004)(6512007)(81166006)(81156014)(8676002)(11346002)(6246003)(99286004)(105586002)(8936002)(31686004)(72206003)(6436002)(5660300001)(229853002)(305945005)(7736002)(25786009)(53936002)(2616005)(54906003)(413944005)(52116002)(68736007)(26005)(256004)(2906002)(478600001)(4326008)(110136005)(6486002)(316002)(476003)(76176011)(93886005)(6506007)(97736004)(386003)(71190400001)(71200400001)(86362001)(486006)(186003)(14444005)(66066001)(3846002)(106356001)(53546011)(6116002)(446003)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3040;H:MN2PR12MB3631.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eZIzYPbJpUZq8CkxWAw2UAG8TksJe3aTU3pnndq+jpdH7I0z5BGLqaGitJtnJ5rNGUKUEOmOY6/pUSvAirfOS2d9GdvUVdDk25BuMzoizKpD6m0htTQ2AsCR0jLp7SeXJz24gysN2hWcP8iGNe2G2O62NEebOc6c5boXeC+Bn2ZDdghTpE5vUOvINVwaqatMjRwfdq4T1szAvezz2liajSqvOXME3H+SbpbSpigyL6aY/u7KviOqIrbklW9SOVscwf5O5dGhvaOuDmCLf6MkWajKFtplExgXuIpX6PIGbtnueyRm4IUDCX5w3f6Fs0u5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F6CBBA7486BFC40AC3D06C0A5FBEDD5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c14be7-50f2-4257-f745-08d6763ee4c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 14:29:42.1478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS85LzE5IDc6MzUgQU0sIFBhdWwgTWVuemVsIHdyb3RlOg0KPiBEZWFyIFRob21hcywNCj4g
DQo+IA0KPiBPbiAwMS8wOS8xOSAxNDoxNiwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiANCj4+
IE9uIFdlZCwgOSBKYW4gMjAxOSwgUGF1bCBNZW56ZWwgd3JvdGU6DQo+Pj4gSSBnZXQgdGhlIHNh
bWUgd2l0aCBtaWNyb2NvZGUgdXBkYXRlcyBhcHBsaWVkLg0KPj4+DQo+Pj4gICAgICQgZG1lc2cg
fCBncmVwICdtaWNyb2NvZGU6IENQVTA6IHBhdGNoX2xldmVsJw0KPj4+ICAgICBbICAgIDMuODA5
MjEwXSBtaWNyb2NvZGU6IENQVTA6IHBhdGNoX2xldmVsPTB4MDYwMDA2M2UNCj4+PiAgICAgJCBz
dWRvIG1vZHByb2JlIG1zcg0KPj4+ICAgICAkIHN1ZG8gLi93cm1zciAweDQ5IDB4MQ0KPj4+ICAg
ICB3cm1zcjogQ1BVIDAgY2Fubm90IHNldCBNU1IgMHgwMDAwMDA0OSB0byAweDAwMDAwMDAwMDAw
MDAwMDENCj4+Pg0KPj4+PiBDb3VsZCB5b3UgcGxlYXNlIHBvc3QgL3Byb2MvY3B1aW5mbyBmcm9t
IHN1Y2ggYSBib290IGFzIHdlbGw/DQo+Pg0KPj4gL3Byb2MvY3B1aW5mbyB1bmZvcnR1bmF0ZWx5
IGRvZXMgbm90IGNvbnRhaW4gdGhlIGFtZCBzcGVjaWZpYyBJQlBCIGZsYWcsDQo+PiBidXQgdGhl
IGRtZXNnIG9mIHRoZSBvcmlnaW5hbCByZXBvcnQgc2F5czoNCj4+DQo+PiAgIFNwZWN0cmUgVjIg
OiBtaXRpZ2F0aW9uOiBFbmFibGluZyBjb25kaXRpb25hbCBJbmRpcmVjdCBCcmFuY2ggUHJlZGlj
dGlvbiBCYXJyaWVyDQo+Pg0KPj4gd2hpY2ggbWVhbnMsIHRoYXQgdGhlIENQVUlEIGJpdCBpcyBz
ZXQuDQo+Pg0KPj4gQ2FuIHlvdSBwbGVhc2UgcHJvdmlkZSB0aGUgb3V0cHV0IG9mOg0KPj4NCj4+
ICAgY3B1aWQgLTEgLWwgMHg4MDAwMDAwOCAtcg0KPj4NCj4+IE9uIG15IEFNRCBPcHRlcm9uKFRN
KSBQcm9jZXNzb3IgNjI3NiB3aXRoIG1pY3JvY29kZSAweDYwMDA2M2QgbG9hZGVkIEkgZ2V0Og0K
Pj4NCj4+ICAgIDB4ODAwMDAwMDggMHgwMDogZWF4PTB4MDAwMDMwMzAgZWJ4PTB4MDAwMDAwMDAg
ZWN4PTB4MDAwMDUwMGYgZWR4PTB4MDAwMDAwMDANCj4+DQo+PiBFQlggaXMgMCwgd2hpY2ggbWVh
bnMgdGhhdCBYODZfRkVBVFVSRV9BTURfSUJQQiBpcyBub3QgZW5hYmxlZC4gU28gdGhlDQo+PiBr
ZXJuZWwgZG9lcyBub3QgdHJ5IHRvIHVzZSB0aGUgc3BlY3VsYXRpb24gY29udHJvbCBNU1IgKDB4
NDkpLg0KPiANCj4gV2l0aCBDUFVJRCAyMDE4MDUxOSwgSSBnZXQgdGhlIG91dHB1dCBiZWxvdyB3
aXRoIGJvdGggbWljcm9jb2RlIHVwZGF0ZSB2ZXJzaW9ucy4NCj4gDQo+IDB4NjAwMDYzZDoNCj4g
DQo+ICAgICAkIHN1ZG8gLi9jcHVpZCAtMSAtbCAweDgwMDAwMDA4IC1yDQo+ICAgICBDUFU6DQo+
ICAgICAgICAweDgwMDAwMDA4IDB4MDA6IGVheD0weDAwMDAzMDMwIGVieD0weDAwMDAwMDAwIGVj
eD0weDAwMDA1MDBmIGVkeD0weDAwMDAwMDAwDQo+IA0KPiAweDYwMDA2M2U6DQo+IA0KPiAgICAg
JCBzdWRvIC4vY3B1aWQgLTEgLWwgMHg4MDAwMDAwOCAtcg0KPiAgICAgQ1BVOg0KPiAgICAgICAg
MHg4MDAwMDAwOCAweDAwOiBlYXg9MHgwMDAwMzAzMCBlYng9MHgwMDAwMDAwMCBlY3g9MHgwMDAw
NTAwZiBlZHg9MHgwMDAwMDAwMA0KPiANCg0KSG1tbS4uLiBzbyBlYnggaXMgMCBmb3IgYm90aCB2
ZXJzaW9ucywgc28gSSdtIG5vdCBzdXJlIGhvdyBJQlBCIGlzIGJlaW5nDQpzZXQuIFdoYXQncyB0
aGUgQ1BVSUQgb3V0cHV0IGZvciAweDA3IChjcHVpZCAtMSAtbCAweDA3IC1yKT8NCg0KVGhhbmtz
LA0KVG9tDQoNCj4gDQo+IEtpbmQgcmVnYXJkcywNCj4gDQo+IFBhdWwNCj4gDQo=
