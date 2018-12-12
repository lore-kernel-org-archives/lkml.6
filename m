Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3F7C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CCE20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OZPlyuZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CCE20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeLLPEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:04:12 -0500
Received: from mail-eopbgr720048.outbound.protection.outlook.com ([40.107.72.48]:42182
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726228AbeLLPEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 10:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xU4bh0oYDUq/rV0bbZiH422TrJOOaLtNsrn6LNenOW8=;
 b=OZPlyuZu3TqKxguETFmQBOG+yqX0hDMJEoVj6eSc+qKFmvm2AtF79TZn51c0QJaXVqlLsYTJBDhLT3+Yr7u2ktyPHHNJJO/6s7HGtEG5puVIjpy92gTeEzeDNkGLr7updcPqySOMAZ+jYVNkZ8P0wthPd5L13bdm46rnjHWxEfw=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB0750.namprd12.prod.outlook.com (10.164.26.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Wed, 12 Dec 2018 15:04:07 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5%6]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 15:04:07 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH v2] x86/speculation: Add support for STIBP always-on
 preferred mode
Thread-Topic: [PATCH v2] x86/speculation: Add support for STIBP always-on
 preferred mode
Thread-Index: AQHUkaNTNctPywnCTEqVxIZjhKo+laV6OXQAgAA7RQCAAEpzAIAAagmAgAALXYA=
Date:   Wed, 12 Dec 2018 15:04:07 +0000
Message-ID: <86576138-e65b-aa33-32ef-1b48d7a61f51@amd.com>
References: <20181211224615.5373.65736.stgit@tlendack-t1.amdoffice.net>
 <20181212000518.GX27375@zn.tnic>
 <alpine.DEB.2.21.1812111910520.22893@nanos.tec.linutronix.de>
 <38aca18b-4312-5e03-fdd9-86e47c332e44@amd.com>
 <alpine.DEB.2.21.1812120621130.30793@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1812120621130.30793@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0036.prod.exchangelabs.com (2603:10b6:804:2::46)
 To SN1PR12MB0175.namprd12.prod.outlook.com (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0750;20:48tM297Njn/hHYHy7uWKIqQIQDNPT+3NorhSXn14k3nmp0VgUZankSKvFqvKwpAYMZhIAyQYoKjxxmEcANQARD8Mg0WQLOSBsW1W8ciQW5ODzd2iTnspM/T1R2Qhfif9pWVeIXh0K45bJbS5tY0HQzMeuYiFJaj6gzCgeVpUkZQerSHoiCEmRr5nHlAcWnr6F/P+L4W/Z/fPyCI/ucp4gBuxnoe0Y0hI4kVENXVKpteBiJFYJlFDjEilUEFqxsK3
x-ms-office365-filtering-correlation-id: 09b5135b-80ab-4a7d-a4d4-08d660431043
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0750;
x-ms-traffictypediagnostic: SN1PR12MB0750:
x-microsoft-antispam-prvs: <SN1PR12MB0750DE4B63528AD6A7A822EDECA70@SN1PR12MB0750.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB0750;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0750;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(376002)(366004)(136003)(199004)(52314003)(189003)(31686004)(106356001)(256004)(11346002)(476003)(2616005)(54906003)(446003)(486006)(102836004)(316002)(93886005)(7736002)(68736007)(8936002)(26005)(4326008)(6116002)(25786009)(3846002)(97736004)(478600001)(86362001)(7416002)(53936002)(81156014)(81166006)(105586002)(186003)(76176011)(6246003)(6486002)(2906002)(6506007)(8676002)(31696002)(6306002)(229853002)(72206003)(386003)(6512007)(53546011)(99286004)(66066001)(71190400001)(14454004)(6916009)(5660300001)(966005)(52116002)(6436002)(305945005)(71200400001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0750;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: G9EimPL8fQv3ts7ZG2eoKFquV//BFP29AlXfOfKUt2buSsSmt3+FyvIQGEy5XQVTHPdxFt7fiFXnzr4Li3GVqHg1uWO5k+MmjpdhsbQ+JFfWXGodotgRlIZn6RkFtFUYhZVbi0S7MkElS0KqedPNmhLQWBMnnW3FFYv4NhTm6KVZdW0GJDiVhi81YpisolSXwhUj88THzhWTcJ0WHJKk05LUwCB6SH0AsuYtjosFyirYiKRHceHBIDbTKfD1nKxbhiI1GstMq2m0IhODy6iOdy4vDVT6PfXh+xjFvJsrj8AfZt3TSCpOjiNV+A8xo6X/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2641E65763F899459B906B28117F2F3C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b5135b-80ab-4a7d-a4d4-08d660431043
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 15:04:07.5450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0750
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMTIvMjAxOCAwODoyMyBBTSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiBPbiBXZWQs
IDEyIERlYyAyMDE4LCBMZW5kYWNreSwgVGhvbWFzIHdyb3RlOg0KPj4gT24gMTIvMTEvMjAxOCAw
OTozNyBQTSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPj4+IE9uIFdlZCwgMTIgRGVjIDIwMTgs
IEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4+Pj4gSSBzdGlsbCBkb24ndCBsaWtlIHRoYXQgc2Vw
YXJhdGUgc3RpYnBfYWx3YXlzX29uIHZhcmlhYmxlIHdoZW4gd2UgY2FuIGRvDQo+Pj4+IGFsbCB0
aGUgcXVlcnlpbmcganVzdCBieSB1c2luZyBtb2RlIGFuZCBYODZfRkVBVFVSRV9BTURfU1RJQlBf
QUxXQVlTX09OLg0KPj4+DQo+Pj4gSG1tbS4gSSd2ZSBub3Qgc2VlbiB0aGUgVjEgb2YgdGhpcyAo
aXQncyBub3QgaW4gbXkgaW5ib3gpIGJ1dCB0aGUgdjEtPnYyDQo+Pj4gY2hhbmdlcyBjb250YWlu
Og0KPj4NCj4+IFRoYXQncyBzdHJhbmdlLCB5b3Ugd2VyZSBvbiB0aGUgY2M6IGxpc3QuIEFueXdh
eSwgaGVyZSdzIGEgbGluayB0byB0aGUNCj4+IGZpcnN0IHZlcnNpb246IGh0dHBzOi8vbGttbC5v
cmcvbGttbC8yMDE4LzEyLzExLzEyNDgNCj4gDQo+IE11c3QgaGF2ZSBiZWVuIG15IHNsZWVwIGRl
cHJpdmVkIGJyYWluLiBGb3VuZCBpdCBub3cgOikgU29ycnkgZm9yIG5vdA0KPiBwYXlpbmcgYXR0
ZW50aW9uIGJhY2sgdGhlbi4NCj4gDQo+Pj4+PiAtIFJlbW92ZWQgZXhwbGljaXQgU1BFQ1RSRV9W
Ml9VU0VSX1NUUklDVF9QUkVGRVJSRUQgbW9kZQ0KPj4+DQo+Pj4gTm93IEkgcmVhbGx5IGhhdmUg
dG8gYXNrIHdoeT8NCj4+Pg0KPj4+IE5laXRoZXIgdGhlIGV4dHJhIHZhcmlhYmxlIG5vciB0aGUg
Y3B1IGZlYXR1cmUgY2hlY2sgYXJlIHByZXR0eS4gQW4NCj4+PiBleHBsaWNpdCBtb2RlIGlzIHdh
eSBiZXR0ZXIgaW4gdGVybXMgb2YgY29kZSBjbGFyaXR5IGFuZCB5b3UgZ2V0IHRoZSBwcm9wZXIN
Cj4+PiBwcmludG91dCB2aWEgc3BlY3RyZV92Ml91c2VyX3N0cmluZ3MuDQo+Pj4NCj4+PiBIbW0/
DQo+Pg0KPj4gVGhhdCBpcyB3aGF0IHRoZSBmaXJzdCB2ZXJzaW9uIGRpZC4gU2VlIGlmIHRoYXQn
cyBpbi1saW5lIHdpdGggd2hhdA0KPj4geW91J3JlIHRoaW5raW5nLg0KPiANCj4gWWVzLCB0aG91
Z2ggSSdtIG5vdCB0b28gZm9uZCBhYm91dCB0aGUgcHJlZmVycmVkIHdvcmRpbmcsIGJ1dCBjYW4n
dCBjb21lIHVwDQo+IHdpdGggYW55dGhpbmcgYmV0dGVyLg0KDQpJJ20gbm90IGNyYXp5IGFib3V0
IHRoYXQgZWl0aGVyLiBNYXliZSBnZXR0aW5nIHJpZCBvZiAicHJlZmVycmVkIiBhbmQganVzdA0K
aGF2aW5nICJhbHdheXMtb24iIGZvciB0aGUgd29yZGluZyBpcyBlbm91Z2g/DQoNClRoYW5rcywN
ClRvbQ0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiAJdGdseA0KPiANCg==
