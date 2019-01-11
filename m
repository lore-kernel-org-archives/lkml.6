Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BA3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45101218A4
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="KxAo+3u7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388154AbfAKTUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:20:19 -0500
Received: from mail-eopbgr680066.outbound.protection.outlook.com ([40.107.68.66]:17888
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbfAKTUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:20:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZL5x3uDKS3iLn8m6tW/g7Fud9dBoazR+wZum3D2xoNo=;
 b=KxAo+3u7UmPSLCL4vJO8sWtjYFfeJ7UscKZIdhrSsdg0KEGEKdMt6PCs7aVg85ZRG4kkEddQE3/zHk4I3tLT4+e35pXSNo3IdqP6ZfK7L5IfbN5HIQFlM/mlc9x8BV02cmL6bY0F8TOD7SLdC6tl8UVp8gF5If0tBBBdwz3amXU=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4342.namprd05.prod.outlook.com (52.135.202.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.6; Fri, 11 Jan 2019 19:17:21 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732%2]) with mapi id 15.20.1537.013; Fri, 11 Jan 2019
 19:17:20 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 0/6] Static calls
Thread-Topic: [PATCH v3 0/6] Static calls
Thread-Index: AQHUqG8IuMNefdUVHE69woqiOXvtzqWo9cGAgAAGKQCAACROAIAAH8IAgAAOP4CAAOHdgIAAP7oAgAAD3IA=
Date:   Fri, 11 Jan 2019 19:17:20 +0000
Message-ID: <F82AE531-5E8F-4F70-B700-861DFC66B80A@vmware.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <20190110203023.GL2861@worktop.programming.kicks-ass.net>
 <20190110205226.iburt6mrddsxnjpk@treble>
 <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
 <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
 <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com>
 <20190111151525.tf7lhuycyyvjjxez@treble>
 <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
In-Reply-To: <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4342;20:5XugEDAhQX3+f3RTmeuC3YKZBIzkvKz5K4fRsSJWJdRJVTb7Psa5dSDNGRRtFWhpK5MQiVnGM2MpJ8Ho24gIUy93/wg30CwGayryK7tSRfJTNPjySmm3JSdVzESALlq/yghb6pA2J+Yk58rskPc6/4Hs9IyGKrjRvJRtspJHh1c=
x-ms-office365-filtering-correlation-id: 95413ba5-7f6e-428e-9891-08d677f968e4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4342;
x-ms-traffictypediagnostic: BYAPR05MB4342:
x-microsoft-antispam-prvs: <BYAPR05MB4342408A91292F55EFB5AC37D0850@BYAPR05MB4342.namprd05.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(68736007)(6436002)(6346003)(486006)(82746002)(99286004)(6246003)(6512007)(26005)(186003)(102836004)(7736002)(97736004)(6916009)(83716004)(71190400001)(476003)(71200400001)(86362001)(2616005)(33656002)(305945005)(446003)(5660300001)(11346002)(66066001)(53936002)(256004)(229853002)(76176011)(14454004)(54906003)(3846002)(6306002)(6486002)(478600001)(105586002)(14444005)(45080400002)(106356001)(966005)(8676002)(4326008)(2906002)(7416002)(93886005)(8936002)(6116002)(316002)(81156014)(6506007)(53546011)(36756003)(81166006)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4342;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LeGKH3m0HjeLCTdH5UfVv/fWlvNDISpE8xbeRS4ESffK9bUMbSqwU9wIYH6Duv6EH7zw+MefQ3l4SiiaiS2WkozgkkeGtcA/y0lCLsFJM/X98+RYx/ZDkFUgLcGtm2HbWBzihdSEzGq5jvK31F9wdNZ9hRS8R1SsfG0QjshOCoZmIUKWZGFvfNwR73tCkk8b8Uop5PFXPJ3BZQYUOL/nV8OX5V3FB6bgVJD9ydMgJxx+faMqjVC33KSMOSAORZs1CEg+NllvyWJNiafnXVYOK0KPWBHkcax9xVAPfB9MTEm5UKtkJk+kvVWGZKYRhli6U1/SnYjSIjQgSfWnRP0ATOkRwtapFOylbbqpBJNnKYAK+hWyWJ6dyZYQpF97mNK2cmkpg7JzoHA6s1qFpgrz5B6iuFL+fJz5aOVumnYlOeE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBECC21E8A96CF4D8431BE67E5943425@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95413ba5-7f6e-428e-9891-08d677f968e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 19:17:20.6835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4342
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gMTEsIDIwMTksIGF0IDExOjAzIEFNLCBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNA
bGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBKYW4gMTEsIDIwMTkg
YXQgNzoxNSBBTSBKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VAcmVkaGF0LmNvbT4gd3JvdGU6DQo+
Pj4gTm93LCBpbiB0aGUgaW50MyBoYW5kbGVyIGNhbiB5b3UgdGFrZSB0aGUgZmF1bHRpbmcgUklQ
IGFuZCBzZWFyY2ggZm9yIGl0IGluDQo+Pj4gdGhlIOKAnHN0YXRpYy1jYWxsc+KAnSB0YWJsZSwg
d3JpdGluZyB0aGUgUklQKzUgKG9mZnNldCkgaW50byBSMTAgKHJldHVybg0KPj4+IGFkZHJlc3Mp
IGFuZCB0aGUgdGFyZ2V0IGludG8gUjExLiBZb3UgbWFrZSB0aGUgaW50MyBoYW5kbGVyIHRvIGRp
dmVydCB0aGUNCj4+PiBjb2RlIGV4ZWN1dGlvbiBieSBjaGFuZ2luZyBwdF9yZWdzLT5yaXAgdG8g
cG9pbnQgdG8gYSBuZXcgZnVuY3Rpb24gdGhhdCBkb2VzOg0KPj4+IA0KPj4+ICAgICAgcHVzaCBS
MTANCj4+PiAgICAgIGptcCBfX3g4Nl9pbmRpcmVjdF90aHVua19yMTENCj4+PiANCj4+PiBBbmQg
dGhlbiB5b3UgYXJlIGRvbmUuIE5vPw0KPj4gDQo+PiBJSVVDLCB0aGF0IHNvdW5kcyBwcmV0dHkg
bXVjaCBsaWtlIHdoYXQgU3RldmVuIHByb3Bvc2VkOg0KPj4gDQo+PiAgaHR0cHM6Ly9uYTAxLnNh
ZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsa21sLmtl
cm5lbC5vcmclMkZyJTJGMjAxODExMjkxMjIwMDAuN2ZiNGZiMDQlNDBnYW5kYWxmLmxvY2FsLmhv
bWUmYW1wO2RhdGE9MDIlN0MwMSU3Q25hbWl0JTQwdm13YXJlLmNvbSU3Q2Q5MGYyYWVlMDM4NTRh
OGRhNWRkMDhkNjc3Zjc4NjZlJTdDYjM5MTM4Y2EzY2VlNGI0YWE0ZDZjZDgzZDlkZDYyZjAlN0Mw
JTdDMCU3QzYzNjgyODMwMjM3MTQxNzQ1NCZhbXA7c2RhdGE9S0VHVmpDWmJsNXo3Y0NRWDdGMCUy
Rk9hV2ZVN2wlMkJ2ZDJZRHdaTVh1T2hwR0klM0QmYW1wO3Jlc2VydmVkPTANCj4+IA0KPj4gSSBs
aWtlZCB0aGUgaWRlYSwgQlVULCBob3cgd291bGQgaXQgd29yayBmb3IgY2FsbGVlLXNhdmVkIFBW
IG9wcz8gIEluDQo+PiB0aGF0IGNhc2UgdGhlcmUncyBvbmx5IG9uZSBjbG9iYmVyZWQgcmVnaXN0
ZXIgdG8gd29yayB3aXRoIChyYXgpLg0KPiANCj4gQWN0dWFsbHksIHRoZXJlJ3MgYSBtdWNoIHNp
bXBsZXIgbW9kZWwgbm93IHRoYXQgSSB0aGluayBhYm91dCBpdC4NCj4gDQo+IFRoZSBCUCBmaXh1
cCBqdXN0IGZpeGVzIHVwICVyaXAgdG8gdG8gcG9pbnQgdG8gImJwX2ludDNfaGFuZGxlciIuDQo+
IA0KPiBBbmQgdGhhdCdzIGp1c3QgYSByYW5kb20gdGV4dCBhZGRyZXNzIHNldCB1cCBieSAidGV4
dF9wb2tlX2JwKCkiLg0KPiANCj4gU28gaG93IGFib3V0IHRoZSBzdGF0aWMgY2FsbCByZXdyaXRp
bmcgc2ltcGx5IGRvIHRoaXM6DQo+IA0KPiAtIGZvciBlYWNoIHN0YXRpYyBjYWxsOg0KPiANCj4g
MSkgICBjcmVhdGUgYSBmaXh1cCBjb2RlIHN0dWIgdGhhdCBkb2VzDQo+IA0KPiAgICAgICAgcHVz
aCAkcmV0dXJuYWRkcmVzc2ZvclRISVNjYWxsDQo+ICAgICAgICBqbXAgdGFyZ2V0Zm9yVEhJU2Nh
bGwNCj4gDQo+IDIpIGRvDQo+IA0KPiAgICAgICAgb25fZWFjaF9jcHUoZG9fc3luY19jb3JlLCBO
VUxMLCAxKTsNCj4gDQo+ICAgICB0byBtYWtlIHN1cmUgYWxsIENQVSdzIHNlZSB0aGlzIGdlbmVy
YXRlZCBjb2RlDQo+IA0KPiAgMykgZG8NCj4gDQo+ICAgICAgICB0ZXh0X3Bva2VfYnAoYWRkciwg
bmV3Y29kZSwgbmV3bGVuLCBnZW5lcmF0ZWRjb2RlKTsNCj4gDQo+IFRhLWRhYSEgRG9uZS4NCj4g
DQo+IEluIGZhY3QsIGl0IHR1cm5zIG91dCB0aGF0IGV2ZW4gdGhlIGV4dHJhICJkb19zeW5jX2Nv
cmUoKSIgaW4gIzIgaXMNCj4gdW5uZWNlc3NhcnksIGJlY2F1c2UgdGFraW5nIHRoZSBCUCB3aWxs
IGJlIHNlcmlhbGl6aW5nIG9uIHRoZSBDUFUgdGhhdA0KPiB0YWtlcyBpdCwgc28gd2UgY2FuIHNr
aXAgaXQuDQo+IA0KPiBFbmQgcmVzdWx0OiB0aGUgdGV4dF9wb2tlX2JwKCkgZnVuY3Rpb24gd2ls
bCBkbyB0aGUgdHdvIGRvX3N5bmNfY29yZQ0KPiBJUEkncyB0aGF0IGd1YXJhbnRlZSB0aGF0IGJ5
IHRoZSB0aW1lIGl0IHJldHVybnMsIG5vIG90aGVyIENQVSBpcw0KPiB1c2luZyB0aGUgZ2VuZXJh
dGVkIGNvZGUgYW55IG1vcmUsIHNvIGl0IGNhbiBiZSByZS11c2VkIGZvciB0aGUgbmV4dA0KPiBz
dGF0aWMgY2FsbCBmaXh1cC4NCj4gDQo+IE5vdGljZT8gTm8gb2RkIGVtdWxhdGlvbiwgbm8gbmVl
ZCB0byBhZGp1c3QgdGhlIHN0YWNrIGluIHRoZSBCUA0KPiBoYW5kbGVyLCBqdXN0IHRoZSByZWd1
bGFyICJyZXR1cm4gdG8gYSBkaWZmZXJlbnQgSVAiLg0KPiANCj4gTm93LCB0aGVyZSBpcyBhIG5h
c3R5IHNwZWNpYWwgY2FzZSB3aXRoIHRoYXQgc3R1YiwgdGhvdWdoLg0KPiANCj4gU28gbmFzdHkg
dGhpbmcgd2l0aCB0aGUgd2hvbGUgImdlbmVyYXRlIGEgc3R1YiBmb3IgZWFjaCBjYWxsIiBjYXNl
Og0KPiBiZWNhdXNlIGl0J3MgZHluYW1pYyBhbmQgYmVjYXVzZSBvZiB0aGUgcmUtdXNlIG9mIHRo
ZSBzdHViLCB5b3UgY291bGQNCj4gYmUgaW4gdGhlIHNpdHVhdGlvbiB3aGVyZToNCj4gDQo+ICBD
UFUxICAgICAgICAgICAgICAgICAgQ1BVMg0KPiAgLS0tLSAgICAgICAgICAgICAgICAgIC0tLS0N
Cj4gDQo+ICBnZW5lcmF0ZSBhIHN0dWINCj4gIG9uX2VhY2hfY3B1KGRvX3N5bmNfY29yZS4uKQ0K
PiAgdGV4dF9wb2tlX2JwKCkNCj4gIC4uLg0KPiANCj4gIHJld3JpdGUgdG8gQlANCj4gICAgICAg
ICAgICAgICAgICAgICAgICB0cmlnZ2VyIHRoZSBCUA0KPiAgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiB0byB0aGUgc3R1Yg0KPiAgICAgICAgICAgICAgICAgICAgICAgIGZ1biB0aGUgZmly
c3QgaW5zdHJ1Y3Rpb24gb2YgdGhlIHN0dWINCj4gICAgICAgICAgICAgICAgICAgICAgICAqSU5U
RVJSVVBUIGNhdXNlcyByZXNjaGVkdWxpbmcqDQo+IA0KPiAgb25fZWFjaF9jcHUoZG9fc3luY19j
b3JlLi4pDQo+ICByZXdyaXRlIHRvIGdvb2QgaW5zdHJ1Y3Rpb24NCj4gIG9uX2VhY2hfY3B1KGRv
X3N5bmNfY29yZS4uKQ0KPiANCj4gIGZyZWUgb3IgcmUtZ2VuZXJhdGUgdGhlIHN0dWINCj4gDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgISEgVGhlIHN0dWIgaXMgc3RpbGwgaW4gdXNlICEhDQo+
IA0KPiBTbyB0aGF0IHNpbXBsZSAianVzdCBnZW5lcmF0ZSB0aGUgc3R1YiBkeW5hbWljYWxseSIg
aXNuJ3Qgc28gc2ltcGxlIGFmdGVyIGFsbC4NCj4gDQo+IEJ1dCBpdCB0dXJucyBvdXQgdGhhdCB0
aGF0IGlzIHJlYWxseSBzaW1wbGUgdG8gaGFuZGxlIHRvby4gSG93IGRvIHdlIGRvIHRoYXQ/DQo+
IA0KPiBXZSBkbyB0aGF0IGJ5IGdpdmluZyB0aGUgQlAgaGFuZGxlciAqdHdvKiBjb2RlIHNlcXVl
bmNlcywgYW5kIHdlIG1ha2UNCj4gdGhlIEJQIGhhbmRsZXIgcGljayBvbmUgZGVwZW5kaW5nIG9u
IHdoZXRoZXIgaXQgaXMgcmV0dXJuaW5nIHRvIGENCj4gImludGVycnVwdHMgZGlzYWJsZWQiIG9y
ICJpbnRlcnJ1cHRzIGVuYWJsZWQiIGNhc2UuDQo+IA0KPiBTbyB0aGUgQlAgaGFuZGxlciBkb2Vz
IHRoaXM6DQo+IA0KPiAtIGlmIHdlJ3JlIHJldHVybmluZyB3aXRoIGludGVycnVwdHMgZGlzYWJs
ZWQsIHBpY2sgdGhlIHNpbXBsZSBzdHViDQo+IA0KPiAtIGlmIHdlJ3JlIHJldHVybmluZyB3aXRo
IGludGVycnVwdHMgZW5hYmxlZCwgY2xrZWFyIElGIGluIHRoZSByZXR1cm4NCj4gJXJmbGFncywg
YW5kIHBpY2sgYSAqc2xpZ2h0bHkqIG1vcmUgY29tcGxleCBzdHViOg0KPiANCj4gICAgICAgIHB1
c2ggJHJldHVybmFkZHJlc3Nmb3JUSElTY2FsbA0KPiAgICAgICAgc3RpDQo+ICAgICAgICBqbXAg
dGFyZ2V0Zm9yVEhJU2NhbGwNCj4gDQo+IGFuZCBub3cgdGhlIFNUSSBzaGFkb3cgd2lsbCBtZWFu
IHRoYXQgdGhpcyBzZXF1ZW5jZSBpcyB1bmludGVycnVwdGlibGUuDQo+IA0KPiBTbyB3ZSdkIG5v
dCBkbyBjb21wbGV4IGVtdWxhdGlvbiBvZiB0aGUgY2FsbCBpbnN0cnVjdGlvbiBhdCBCUCB0aW1l
LA0KPiBidXQgd2UnZCBkbyB0aGF0ICp0cml2aWFsKiBjaGFuZ2UgYXQgQlAgdGltZS4NCj4gDQo+
IFRoaXMgc2VlbXMgc2ltcGxlLCBkb2Vzbid0IG5lZWQgYW55IHRlbXBvcmFyeSByZWdpc3RlcnMg
YXQgYWxsLCBhbmQNCj4gZG9lc24ndCBuZWVkIGFueSBleHRyYSBzdGFjayBtYWdpYy4gSXQgbGl0
ZXJhbGx5IG5lZWRzIGp1c3QgYSB0cml2aWFsDQo+IHNlcXVlbmNlIGluIHBva2VfaW50M19oYW5k
bGVyKCkuDQo+IA0KPiBUaGUgd2UnZCBjaGFuZ2UgdGhlIGVuZCBvZiBwb2tlX2ludDNfaGFuZGxl
cigpIHRvIGRvIHNvbWV0aGluZyBsaWtlDQo+IHRoaXMgaW5zdGVhZDoNCj4gDQo+ICAgICAgICB2
b2lkICpuZXdpcCA9IGJwX2ludDNfaGFuZGxlcjsNCj4gICAgICAgIC4uDQo+ICAgICAgICBpZiAo
bmV3ID09IG1hZ2ljX3N0YXRpY19jYWxsX2JwX2ludDNfaGFuZGxlcikgew0KPiAgICAgICAgICAg
ICAgICBpZiAocmVncy0+ZmxhZ3MgJlg4Nl9GTEFHU19JRikgew0KPiAgICAgICAgICAgICAgICAg
ICAgICAgIG5ld2lwID0gbWFnaWNfc3RhdGljX2NhbGxfYnBfaW50M19oYW5kbGVyX3N0aTsNCj4g
ICAgICAgICAgICAgICAgICAgICAgICByZWdzLT5mbGFncyAmPSB+WDg2X0ZMQUdTX0lGOw0KPiAg
ICAgICAgfQ0KPiAgICAgICAgcmVncy0+aXAgPSAodW5zaWduZWQgbG9uZykgbmV3aXA7DQo+ICAg
ICAgICByZXR1cm4gMTsNCj4gDQo+IEFBTkQgbm93IHdlJ3JlICpyZWFsbHkqIGRvbmUuDQo+IA0K
PiBEb2VzIGFueWJvZHkgc2VlIGFueSBpc3N1ZXMgaW4gdGhpcz8NCg0KSSB0aGluayBpdOKAmXMg
YSBiZXR0ZXIgYXJ0aWN1bGF0ZWQsIG1vcmUgZGV0YWlsZWQgdmVyc2lvbiB0byB0aGUgc29sdXRp
b24gSQ0KcHJvcG9zZWQgaW4gdGhpcyB0aHJlYWQgKHdoaWNoIGFsc28gdXNlZCBhIHBhdGNoZWQg
dHJhbXBvbGluZSB3aXRoIFNUSStKTVApLg0KDQpTbyBvYnZpb3VzbHkgSSBsaWtlIGl0LiA7LSk=
