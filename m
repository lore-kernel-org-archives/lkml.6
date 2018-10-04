Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03236C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B311821473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="V3x5S6mf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B311821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeJDPcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:32:50 -0400
Received: from mail-bl2nam02on0067.outbound.protection.outlook.com ([104.47.38.67]:37996
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726857AbeJDPcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3I8lgk6apUoAD13TMsCYgdQM3KmY4wFZZmu623ssZE=;
 b=V3x5S6mfWfrTJkWSRPSkM3m5dRFxfe9nnKybi215HJxtTuQQ+r+VmR2JDaA3cJpMDI+3mM2PeqDwNOg3IxX7MNE9YukEHi7z7j8TP+9yF+iUjcDQQJEgpU5QoT5iQp16IZsQnA2eJpW8RfklRwoY6KlikcSxm7jwpQFiB1G88pA=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4824.namprd05.prod.outlook.com (52.135.235.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.8; Thu, 4 Oct 2018 08:40:34 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%3]) with mapi id 15.20.1207.018; Thu, 4 Oct 2018
 08:40:34 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v9 04/10] x86: refcount: prevent gcc distortions
Thread-Topic: [PATCH v9 04/10] x86: refcount: prevent gcc distortions
Thread-Index: AQHUW2CZEG0GJCpfDkK4fEgcOSwgMqUOuSmAgAAL6AA=
Date:   Thu, 4 Oct 2018 08:40:34 +0000
Message-ID: <65767CEA-370F-4180-9A81-116BE0BE2EA2@vmware.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181003213100.189959-5-namit@vmware.com> <20181004075755.GA3353@gmail.com>
In-Reply-To: <20181004075755.GA3353@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4824;20:bsUqM3aS9VngTvXP4GlXX7u/nTWweuM+rLlC51Dqi3rSJfBnnIZHXD7UCqyMavBRqyJs4N34VS2cM2a+DW/ruQP6xIckpDV64dSUBMxaf6Nw0Iazz9nGybJgOG5x4rY3Ou41Ucrodba+0Sral//PVRkfvRBKB+78dWX67BT77pE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: eb2c0892-2dbb-4521-372e-08d629d50d61
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4824;
x-ms-traffictypediagnostic: BYAPR05MB4824:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB4824E2221B5FD4F98C31A81AD0EA0@BYAPR05MB4824.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991048);SRVR:BYAPR05MB4824;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4824;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(396003)(136003)(376002)(54534003)(199004)(189003)(14454004)(81166006)(446003)(6436002)(11346002)(486006)(81156014)(86362001)(2906002)(26005)(36756003)(478600001)(66066001)(8936002)(71200400001)(71190400001)(83716004)(99286004)(6506007)(229853002)(54906003)(76176011)(6486002)(14444005)(82746002)(256004)(2616005)(6512007)(53936002)(8676002)(476003)(68736007)(3846002)(6116002)(5250100002)(316002)(33656002)(97736004)(6916009)(5660300001)(102836004)(106356001)(105586002)(25786009)(186003)(7416002)(4326008)(7736002)(305945005)(2900100001)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4824;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xfUptKsojYMnIna2naydAQ8YEBmjX6t3i5u4raBaO5z10/wzGbm0mkbq7OW1A5cYiJX66rN2vSGT8RYjcSvSN1yFaOsH3ud23kGH8q0y0A4nsdOyIq8tOkEmNUaYyyZ2VwXP21lQCrmdChH9ENEDg8R6jhOuMmY4O+q5Qnjy5BvvrPRJMov7PH5eR10+0VGYVHgjvXKBHL76gKlzPMNiUA2NFSaLJyiSxMIuU2RhvYqVh3lo68+HvGoxN2XV2NLk/S6x9rL0s4FKyH2JteLNrKRMB9J8AQoI5adZ4hoOeKKKTO2Qm46W+Q0Wy6kGMzNQ850vuRkzm47RDycToIw715feQPbgiSmWUcO4FbHR8X0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B8DECAD03AE9D4FAF61C077D85A2CE8@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2c0892-2dbb-4521-372e-08d629d50d61
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 08:40:34.6720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMTI6NTcgQU0sIEluZ28gTW9sbmFyIDxtaW5nb0BrZXJuZWwub3JnPiB3cm90ZToNCg0KPiAN
Cj4gKiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPiB3cm90ZToNCj4gDQo+PiBHQ0MgY29u
c2lkZXJzIHRoZSBudW1iZXIgb2Ygc3RhdGVtZW50cyBpbiBpbmxpbmVkIGFzc2VtYmx5IGJsb2Nr
cywNCj4+IGFjY29yZGluZyB0byBuZXctbGluZXMgYW5kIHNlbWljb2xvbnMsIGFzIGFuIGluZGlj
YXRpb24gdG8gdGhlIGNvc3Qgb2YNCj4+IHRoZSBibG9jayBpbiB0aW1lIGFuZCBzcGFjZS4gVGhp
cyBkYXRhIGlzIGRpc3RvcnRlZCBieSB0aGUga2VybmVsIGNvZGUsDQo+PiB3aGljaCBwdXRzIGlu
Zm9ybWF0aW9uIGluIGFsdGVybmF0aXZlIHNlY3Rpb25zLiBBcyBhIHJlc3VsdCwgdGhlDQo+PiBj
b21waWxlciBtYXkgcGVyZm9ybSBpbmNvcnJlY3QgaW5saW5pbmcgYW5kIGJyYW5jaCBvcHRpbWl6
YXRpb25zLg0KPj4gDQo+PiBUaGUgc29sdXRpb24gaXMgdG8gc2V0IGFuIGFzc2VtYmx5IG1hY3Jv
IGFuZCBjYWxsIGl0IGZyb20gdGhlIGlubGluZWQNCj4+IGFzc2VtYmx5IGJsb2NrLiBBcyBhIHJl
c3VsdCBHQ0MgY29uc2lkZXJzIHRoZSBpbmxpbmUgYXNzZW1ibHkgYmxvY2sgYXMNCj4+IGEgc2lu
Z2xlIGluc3RydWN0aW9uLg0KPj4gDQo+PiBUaGlzIHBhdGNoIGFsbG93cyB0byBpbmxpbmUgZnVu
Y3Rpb25zIHN1Y2ggYXMgX19nZXRfc2VjY29tcF9maWx0ZXIoKS4NCj4+IEludGVyZXN0aW5nbHks
IHRoaXMgYWxsb3dzIG1vcmUgYWdncmVzc2l2ZSBpbmxpbmluZyB3aGlsZSByZWR1Y2luZyB0aGUN
Cj4+IGtlcm5lbCBzaXplLg0KPj4gDQo+PiAgIHRleHQJICAgZGF0YQkgICAgYnNzCSAgICBkZWMJ
ICAgIGhleAlmaWxlbmFtZQ0KPj4gMTgxNDA5NzAgMTAyMjU0MTIgMjk1NzMxMiAzMTMyMzY5NCAx
ZGRmNjJlIC4vdm1saW51eCBiZWZvcmUNCj4+IDE4MTQwMTQwIDEwMjI1Mjg0IDI5NTczMTIgMzEz
MjI3MzYgMWRkZjI3MCAuL3ZtbGludXggYWZ0ZXIgKC05NTgpDQo+PiANCj4+IFN0YXRpYyB0ZXh0
IHN5bWJvbHM6DQo+PiBCZWZvcmU6CTQwMzAyDQo+PiBBZnRlcjoJNDAyODYJKC0xNikNCj4+IA0K
Pj4gRnVuY3Rpb25zIHN1Y2ggYXMga3JlZl9nZXQoKSwgZnJlZV91c2VyKCksIGZ1c2VfZmlsZV9n
ZXQoKSBub3cgZ2V0DQo+PiBpbmxpbmVkLg0KPiANCj4gWWVhaCwgc28gSSBraW5kIG9mIGhhZCB5
b3VyIHNlcmllcyBvbiB0aGUgYmFjay1idXJuZXIgKEknbSBzdXJlIHlvdSBub3RpY2VkISksDQo+
IG1vc3RseSBiZWNhdXNlIHdoYXQgSSBjb21wbGFpbmVkIGFib3V0IGluIGEgcHJldmlvdXMgcm91
bmQgb2YgcmV2aWV3IGEgY291cGxlDQo+IG9mIG1vbnRocyBhZ286IHRoYXQgdGhlIGRlc2NyaXB0
aW9uIG9mIHRoZSBzZXJpZXMgYW5kIHRoZSBjaGFuZ2Vsb2cgb2YgZXZlcnkNCj4gc2luZ2xlIHBh
dGNoIGluIGl0IGlzIHRpcHRvZWluZyBhcm91bmQgdGhlICpyZWFsKiBwcm9ibGVtIGFuZCBuZXZl
ciB0cnVseQ0KPiBkZXNjcmliZXMgaXQ6DQo+IA0KPiAgICoqIFRoaXMgaXMgYSBHQ0MgYnVnLCBw
bGFpbiBhbmQgc2ltcGxlLCBhbmQgd2UgYXJlIHVnbGlmeWluZyAqKg0KPiAgICoqIGFuZCBjb21w
bGljYXRpbmcga2VybmVsIGFzc2VtYmx5IGNvZGUgdG8gd29yayBpdCBhcm91bmQuICAqKg0KPiAN
Cj4gV2UnZCBuZXZlciBldmVyIGNvbnNpZGVyIHN1Y2ggdWdsaWZpY2F0aW9uIGZvciBDbGFuZywg
bm90IGV2ZW4gX2Nsb3NlXy4NCj4gU3VyZSB0aGlzIHdvdWxkIGhhdmUgd2FycmFudGVkIGEgcGFz
c2luZyBtZW50aW9uPyBJbnN0ZWFkIHRoZSBjaGFuZ2Vsb2dzIGFyZQ0KPiBsb3ZpbmdseSBjYWxs
aW5nIGl0IGEgImRpc3RvcnRpb24iIGFzIGlmIHRoaXMgd2FzIG5vLW9uZSdzIGZhdWx0IHJlYWxs
eSwgYW5kDQo+IHRoZSBwYXRjaCBhICJzb2x1dGlvbiIuDQo+IA0KPiBIb3cgYWJvdXQgY2FsbGlu
ZyBpdCBhICJHQ0MgaW5saW5pbmcgYnVnIiBhbmQgYSAid29ya2Fyb3VuZCB3aXRoIGNvc3RzIiAN
Cj4gd2hpY2ggaXQgaXMgaW4gcmVhbGl0eSwgYW5kIHN0b3Agd2hpdGV3YXNoaW5nIHRoZSBwcm9i
bGVtPw0KPiANCj4gQXQgdGhlIHNhbWUgdGltZSBJIHJlYWxpemUgdGhhdCB3ZSBzdGlsbCBuZWVk
IHRoaXMgc2VyaWVzIGJlY2F1c2UgR0NDIHdvbid0DQo+IGdldCBmaXhlZCwgc28gYXMgYSBjb25z
b2xhdGlvbiBJIHdyb3RlIHRoZSBjaGFuZ2Vsb2cgYmVsb3cgdGhhdCBleHBsYWlucw0KPiBob3cg
aXQgcmVhbGx5IGlzLCBubyBob2xkcyBiYXJyZWQuDQo+IA0KPiBTaW5jZSB0aGUgdG9uZSBvZiB0
aGUgY2hhbmdlbG9nIGlzIGEgYml0IC4uLiBmcm9zdHksIEkgYWRkZWQgdGhpcyBkaXNjbGFpbWVy
Og0KPiANCj4gIFsgbWluZ286IFdyb3RlIG5ldyBjaGFuZ2Vsb2cuIF0NCj4gDQo+IExldCBtZSBr
bm93IGlmIHlvdSB3YW50IG1lIHRvIG1ha2UgaXQgbW9yZSBwcm9taW5lbnQgdGhhdCB5b3UgaGFk
IGFic29sdXRlbHkNCj4gbm8gcm9sZSBpbiB3cml0aW5nIHRoYXQgY2hhbmdlbG9nLg0KPiANCj4g
SSdtIGFsc28gc29tZXdoYXQgYW5ub3llZCBhdCB0aGUgZmFjdCB0aGF0IHRoaXMgc2VyaWVzIGNh
cnJpZXMgYSBib2F0bG9hZA0KPiBvZiByZXZpZXdlZC1ieSdzIGFuZCBhY2tlZC1ieSdzLCB5ZXQg
bm9uZSBvZiB0aG9zZSByZXZpZXdlcnMgZm91bmQgaXQNCj4gaW1wb3J0YW50IHRvIHBvaW50IG91
dCB0aGUgbGFyZ2UgY2hhc20gdGhhdCBpcyBnYXBpbmcgYmV0d2VlbiBkZXNjcmlwdGlvbg0KPiBh
bmQgcmVhbGl0eS4NCg0KU28sIEnigJltIHNvcnJ5IGZvciBtaXNzaW5nIHlvdXIgY29tbWVudCBh
Ym91dCBtaXNyZXByZXNlbnRpbmcgdGhlIHByb2JsZW0uDQoNCkZlZWwgZnJlZSB0byBkbyB3aGF0
ZXZlciB5b3Ugd2FudCB3aXRoIHRoZSBjb21taXQgbWVzc2FnZSAoanVzdCBmaXggdGhlIHR5cG8N
CmluIOKAnGF0dGVtdCIpLiBBcyBsb25nIGFzIHlvdSBkb27igJl0IE5BSyB0aGUgcGF0Y2hlcyBv
ciBzZW5kIG1lIHRvIHJlZG8gdGhlbSwNCml04oCZcyBmaW5lLiBJIGp1c3Qgd2FudCB0byBjbGFy
aWZ5IGZldyB0aGluZ3MgZm9yIHlvdSB0byBjb25zaWRlci4NCg0KRmlyc3QsIHlvdSBhcmUgcmln
aHQgdGhhdCBjbGFuZyBkb2VzIG5vdCBoYXZlIHRoaXMgaXNzdWUgKEkgY2hlY2tlZCksIGJ1dA0K
dGhlIGJlaGF2aW9yIG9mIGdjYyBpcyBjbGVhcmx5IGRvY3VtZW50ZWQgLSBvbmNlIHlvdSBrbm93
IHdoYXQgdG8gbG9vayBmb3IuDQoNClNlY29uZCwgSSB0aGluayB0aGUgZW5kIHJlc3VsdCBpcyBu
b3QgYXMgdWdseSBhcyB5b3UgbWFrZSBpdCBzb3VuZCAoYW5kDQptYXliZSBub3QgdWdseSBhdCBh
bGwpLiBVc2luZyB0aGlzIHBhdGNoLXNldCwgeW91IGNhbiB3cml0ZSBiaWcgYmxvY2tzIG9mDQpp
bmxpbmVkIGFzc2VtYmx5IGNvZGUgd2l0aG91dCBoYXZpbmcgdGhvc2UgZGlzZ3VzdGluZyBDIG1h
Y3Jvcy4gWW91IGNhbiBhbHNvDQpzaGFyZSB0aGUgc2FtZSBjb2RlIGJldHdlZW4gaW5saW5lIGFz
bSBhbmQgYXNtIGZpbGVzLg0KDQpZb3UgY2FuIGhhdmUgYSBsb29rLCBmb3IgZXhhbXBsZSwgb24g
QUxURVJOQVRJVkUgd2hpY2ggaXMgZGVmaW5lZCBib3RoIGFzDQphc3NlbWJseSBtYWNybyBhbmQg
QyBtYWNyby4gSXMgdGhlIEMgbWFjcm8gcmVhZGFibGU/IElzIGl0IGVhc3kgdG8gbWFpbnRhaW4N
CnR3byBkaWZmZXJlbnQgdmVyc2lvbj8gSSBkbyBoYXZlIGEgcGF0Y2ggdGhhdCBtZXJnZXMgdGhl
IHR3byBpbXBsZW1lbnRhdGlvbnMNCnRvZ2V0aGVyICh3aGljaCBJIHN0aWxsIGRpZG7igJl0IHNl
bmQsIHNpbmNlIEkgd2FpdCBmb3IgdGhlIGluZnJhIHRvIGJlDQphcHBsaWVkIGZpcnN0KSwgYW5k
IEkgdGhpbmsgbWFrZXMgbXVjaCBtb3JlIHNlbnNlLg0KDQpGaW5hbGx5LCBub3RlIHRoYXQgaXTi
gJlzIG5vdCBhcyBpZiB0aGUgYmluYXJ5IGFsd2F5cyBiZWNvbWVzIHNtYWxsZXIuDQpPdmVyYWxs
LCB3aXRoIHRoZSBmdWxsIHBhdGNoLXNldCBpdCBpcyBzbGlnaHRseSBiaWdnZXIuIEJ1dCBzdGls
bCwgdGhhdOKAmXMNCmhvdyBpdCB3YXMgc3VwcG9zZWQgdG8gYmUgaWYgZ2NjIHdhc27igJl0IGRv
aW5nIHRoaW5ncyBiYWRseS4NCg0KVGhhbmtzIGFnYWluLA0KTmFkYXYNCg0K
