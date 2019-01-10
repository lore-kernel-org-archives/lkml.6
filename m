Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216C7C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35FC208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="PQVnhC9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbfAJRaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:30:20 -0500
Received: from mail-eopbgr750052.outbound.protection.outlook.com ([40.107.75.52]:28382
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729785AbfAJRaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HRsbE0nhs5LzeKPuy1TR1NSIpOAVe60hyI8PN7+BcU=;
 b=PQVnhC9l+pjfB1bcAsQhh4XQGw4F9m+u+v+Gb6/vFlbflsvUTDeokLJzig2ZKq+qO8kS8hsHZH7fPOTx/kLZbKVhKIqYdIgo77qZmCUF2TvuiH8bQYLO9F/TUnIrr1vqeCYzdzICF/tH+jOIOSMb4sGF5GIcgnAAC3cg7X5W/6o=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4117.namprd05.prod.outlook.com (52.135.199.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.4; Thu, 10 Jan 2019 17:29:59 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732%2]) with mapi id 15.20.1516.010; Thu, 10 Jan 2019
 17:29:59 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 5/6] x86/alternative: Use a single access in
 text_poke() where possible
Thread-Topic: [PATCH v3 5/6] x86/alternative: Use a single access in
 text_poke() where possible
Thread-Index: AQHUqG8Wf4/RNokb7ki08kHGReVe6KWoPeeAgACCrgCAAALEAA==
Date:   Thu, 10 Jan 2019 17:29:59 +0000
Message-ID: <A53EB816-EF0F-48F1-8F4F-E1BB4BF25BD3@vmware.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <279b8003f7f0a6831d090ab822d37bc958f974de.1547073843.git.jpoimboe@redhat.com>
 <8138A1EE-359D-4CD2-8E96-5BF00313AB3B@vmware.com>
 <20190110172004.wuh45xoafynfm2df@treble>
In-Reply-To: <20190110172004.wuh45xoafynfm2df@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4117;20:y7mzYt0Kwn5+QOAYAofaTIx3Ng//1YlGUq/+bd1lq6MveKKvVsppuYaXscQMAbVV+JXd/OQWiRzVUB/QzOARjPsRp3W8as/akLFtNL/VOYeC76iCSZDiw+NzKwScrA1ozezmCAXqaPwlhOQRHJGQ8PhIoYmjpQLjvO05pSxxy3Q=
x-ms-office365-filtering-correlation-id: 743bf54f-cddb-4b99-29ac-08d677213f0f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4117;
x-ms-traffictypediagnostic: BYAPR05MB4117:
x-microsoft-antispam-prvs: <BYAPR05MB4117DD1CE0C184E5FC87CA54D0840@BYAPR05MB4117.namprd05.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(366004)(199004)(189003)(54094003)(66066001)(316002)(71200400001)(83716004)(71190400001)(256004)(36756003)(14444005)(81166006)(6246003)(105586002)(476003)(8676002)(81156014)(4326008)(229853002)(2906002)(8936002)(6436002)(54906003)(86362001)(6486002)(486006)(99286004)(7416002)(14454004)(478600001)(6916009)(68736007)(25786009)(6512007)(446003)(53546011)(6506007)(106356001)(3846002)(93886005)(5660300001)(6116002)(305945005)(102836004)(26005)(76176011)(53936002)(82746002)(11346002)(97736004)(186003)(7736002)(33656002)(2616005)(567974002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4117;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: akUTTNgVun5Fc+6n49f3WCrqL9aRUYaIq+taBpzkKchyXRxVbqnFjrSeI8sM5Pno0/z25syolWbAooVJJKs/75Zsnh/eRsInhXbWQUudvJW/4Ej8Pfo/5DQwoY/b5OyWsewOUR4i4PqtnoxQxeNYhQ+w6j5mD+lHTeVD1SoI8CUUcDAR6kGFYS0bFRqXFydI/Zyyw1O+zdphzSB801rRg3EmVaW8AHpfRs6FKlgM+mylgKykMzO8VqUmnLG4MBNeue/wLj5QtDalhDjwF/9o8twbK07k1oTzzE4mGKPfItUwASmQFOb5D0M0cmFZIbjm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <40D4686DFBED7E4DB4799C17084AE5E0@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743bf54f-cddb-4b99-29ac-08d677213f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 17:29:59.2744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gMTAsIDIwMTksIGF0IDk6MjAgQU0sIEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUBy
ZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgSmFuIDEwLCAyMDE5IGF0IDA5OjMyOjIz
QU0gKzAwMDAsIE5hZGF2IEFtaXQgd3JvdGU6DQo+Pj4gQEAgLTcxNCwxNCArNzE0LDM5IEBAIHZv
aWQgKnRleHRfcG9rZSh2b2lkICphZGRyLCBjb25zdCB2b2lkICpvcGNvZGUsIHNpemVfdCBsZW4p
DQo+Pj4gCX0NCj4+PiAJQlVHX09OKCFwYWdlc1swXSk7DQo+Pj4gCWxvY2FsX2lycV9zYXZlKGZs
YWdzKTsNCj4+PiArDQo+Pj4gCXNldF9maXhtYXAoRklYX1RFWFRfUE9LRTAsIHBhZ2VfdG9fcGh5
cyhwYWdlc1swXSkpOw0KPj4+IAlpZiAocGFnZXNbMV0pDQo+Pj4gCQlzZXRfZml4bWFwKEZJWF9U
RVhUX1BPS0UxLCBwYWdlX3RvX3BoeXMocGFnZXNbMV0pKTsNCj4+PiAtCXZhZGRyID0gKGNoYXIg
KilmaXhfdG9fdmlydChGSVhfVEVYVF9QT0tFMCk7DQo+Pj4gLQltZW1jcHkoJnZhZGRyWyh1bnNp
Z25lZCBsb25nKWFkZHIgJiB+UEFHRV9NQVNLXSwgb3Bjb2RlLCBsZW4pOw0KPj4+ICsNCj4+PiAr
CXZhZGRyID0gZml4X3RvX3ZpcnQoRklYX1RFWFRfUE9LRTApICsgKCh1bnNpZ25lZCBsb25nKWFk
ZHIgJiB+UEFHRV9NQVNLKTsNCj4+PiArDQo+Pj4gKwkvKg0KPj4+ICsJICogVXNlIGEgc2luZ2xl
IGFjY2VzcyB3aGVyZSBwb3NzaWJsZS4gIE5vdGUgdGhhdCBhIHNpbmdsZSB1bmFsaWduZWQNCj4+
PiArCSAqIG11bHRpLWJ5dGUgd3JpdGUgd2lsbCBub3QgbmVjZXNzYXJpbHkgYmUgYXRvbWljIG9u
IHg4Ni0zMiwgb3IgaWYgdGhlDQo+Pj4gKwkgKiBhZGRyZXNzIGNyb3NzZXMgYSBjYWNoZSBsaW5l
IGJvdW5kYXJ5Lg0KPj4+ICsJICovDQo+Pj4gKwlzd2l0Y2ggKGxlbikgew0KPj4+ICsJY2FzZSAx
Og0KPj4+ICsJCVdSSVRFX09OQ0UoKih1OCAqKXZhZGRyLCAqKHU4ICopb3Bjb2RlKTsNCj4+PiAr
CQlicmVhazsNCj4+PiArCWNhc2UgMjoNCj4+PiArCQlXUklURV9PTkNFKCoodTE2ICopdmFkZHIs
ICoodTE2ICopb3Bjb2RlKTsNCj4+PiArCQlicmVhazsNCj4+PiArCWNhc2UgNDoNCj4+PiArCQlX
UklURV9PTkNFKCoodTMyICopdmFkZHIsICoodTMyICopb3Bjb2RlKTsNCj4+PiArCQlicmVhazsN
Cj4+PiArCWNhc2UgODoNCj4+PiArCQlXUklURV9PTkNFKCoodTY0ICopdmFkZHIsICoodTY0ICop
b3Bjb2RlKTsNCj4+PiArCQlicmVhazsNCj4+PiArCWRlZmF1bHQ6DQo+Pj4gKwkJbWVtY3B5KCh2
b2lkICopdmFkZHIsIG9wY29kZSwgbGVuKTsNCj4+PiArCX0NCj4+PiArDQo+PiANCj4+IEV2ZW4g
aWYgSW50ZWwgYW5kIEFNRCBDUFVzIGFyZSBndWFyYW50ZWVkIHRvIHJ1biBpbnN0cnVjdGlvbnMg
ZnJvbSBMMQ0KPj4gYXRvbWljYWxseSwgdGhpcyBtYXkgYnJlYWsgaW5zdHJ1Y3Rpb24gZW11bGF0
b3JzLCBzdWNoIGFzIHRob3NlIHRoYXQNCj4+IGh5cGVydmlzb3JzIHVzZS4gVGhleSBtaWdodCBu
b3QgcmVhZCBpbnN0cnVjdGlvbnMgYXRvbWljYWxseSBpZiBvbiBTTVAgVk1zDQo+PiB3aGVuIHRo
ZSBWTSdzIHRleHRfcG9rZSgpIHJhY2VzIHdpdGggdGhlIGVtdWxhdGVkIGluc3RydWN0aW9uIGZl
dGNoLg0KPj4gDQo+PiBXaGlsZSBJIGNhbid0IGZpbmQgYSByZWFzb24gZm9yIGh5cGVydmlzb3Jz
IHRvIGVtdWxhdGUgdGhpcyBpbnN0cnVjdGlvbiwNCj4+IHNtYXJ0ZXIgcGVvcGxlIG1pZ2h0IGZp
bmQgd2F5cyB0byB0dXJuIGl0IGludG8gYSBzZWN1cml0eSBleHBsb2l0Lg0KPiANCj4gSW50ZXJl
c3RpbmcgcG9pbnQuLi4gYnV0IEkgd29uZGVyIGlmIGl0J3MgYSByZWFsaXN0aWMgY29uY2Vybi4g
IEJUVywNCj4gdGV4dF9wb2tlX2JwKCkgYWxzbyByZWxpZXMgb24gdW5kb2N1bWVudGVkIGJlaGF2
aW9yLg0KPiANCj4gVGhlIGVudGlyZSBpbnN0cnVjdGlvbiBkb2Vzbid0IG5lZWQgdG8gYmUgcmVh
ZCBhdG9taWNhbGx5OyBqdXN0IHRoZQ0KPiAzMi1iaXQgY2FsbCBkZXN0aW5hdGlvbi4gIEFzc3Vt
aW5nIHRoZSBoeXBlcnZpc29yIGlzIHg4Ni02NCwgYW5kIGl0IHVzZXMNCj4gYSAzMi1iaXQgYWNj
ZXNzIHRvIHJlYWQgdGhlIGNhbGwgZGVzdGluYXRpb24gKHdoaWNoIHNlZW1zIGxvZ2ljYWwpLCB0
aGUNCj4gaW50cmEtY2FjaGVsaW5lIHJlYWRzIHdpbGwgYmUgYXRvbWljLCBhcyBzdGF0ZWQgaW4g
dGhlIFNETS4NCg0KQXQgbGVhc3QgaW4gS1ZNLCBpdCBkb2VzbuKAmXQgZG8gc28gaW50ZW50aW9u
YWxseSAtIGV2ZW50dWFsbHkgdGhlIGVtdWxhdGVkDQpmZXRjaCBpcyBkb25lIHVzaW5nIF9fY29w
eV9mcm9tX3VzZXIoKS4gU28gbm93IHlvdSByZWx5IG9uDQpfX2NvcHlfZnJvbV91c2VyKCkgZG9p
bmcgaXQgY29ycmVjdGx5Lg0KDQo+IElmIHRoZSBhYm92ZSBhc3N1bXB0aW9ucyBhcmUgbm90IHRy
dWUsIGFuZCB0aGUgaHlwZXJ2aXNvciByZWFkcyB0aGUgY2FsbA0KPiBkZXN0aW5hdGlvbiBub24t
YXRvbWljYWxseSAod2hpY2ggc2VlbXMgdW5saWtlbHkgSU1PKSwgZXZlbiB0aGVuIEkgZG9uJ3QN
Cj4gc2VlIGhvdyBpdCBjb3VsZCBiZSByZWFsaXN0aWNhbGx5IGV4cGxvaXRhYmxlLiAgSXQgd291
bGQganVzdCBvb3BzIGZyb20NCj4gY2FsbGluZyBhIGNvcnJ1cHQgYWRkcmVzcy4NCg0KSXQgbWln
aHQgc3RpbGwgYmUgZXhwbG9pdGFibGUgYXMgRG9TIHRob3VnaCAoYWdhaW4sIG5vdCB0aGF0IEkg
dGhpbmsgZXhhY3RseQ0KaG93KS4gSGF2aW5nIHNhaWQgdGhhdCwgSSBtaWdodCBiZSBuZWdhdGl2
ZSBqdXN0IGJlY2F1c2UgSeKAmXZlIHB1dCBhIGxvdCBvZg0KZWZmb3J0IGludG8gYXZvaWRpbmcg
dGhpcyBwcm9ibGVtIGFjY29yZGluZyB0byB0aGUgU0RN4oCmDQoNCg==
