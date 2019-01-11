Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756A7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C627218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="sMwSf/3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388670AbfAKTdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:33:39 -0500
Received: from mail-eopbgr710057.outbound.protection.outlook.com ([40.107.71.57]:20480
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732214AbfAKTdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rm4v9Kwj3H84zeMgJbcMXf69WjRq9WfElcCSPKXaPZs=;
 b=sMwSf/3BA9LZh1nCj2QxqJwa7duFzuhxx72rKASHbmdgYsFO6clLlCKpMRf3GLargsW6DhjMuXI3plZzWxXf403k1aP1WcF3FyaVlUXpdSZ51SyVjdBxaYK7IVG5ZCOkeEPOd0IDBthyYC8xqGWVMiwXTNh4WGAcctLzPI2b+RA=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4455.namprd05.prod.outlook.com (52.135.203.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.6; Fri, 11 Jan 2019 19:33:31 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732%2]) with mapi id 15.20.1537.013; Fri, 11 Jan 2019
 19:33:31 +0000
From:   Nadav Amit <namit@vmware.com>
To:     "hpa@zytor.com" <hpa@zytor.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 0/6] Static calls
Thread-Topic: [PATCH v3 0/6] Static calls
Thread-Index: AQHUqG8IuMNefdUVHE69woqiOXvtzqWo9cGAgAAGKQCAACROAIAAH8IAgAAOP4CAAOHdgIAAP7oAgAAFlYCAAALLgA==
Date:   Fri, 11 Jan 2019 19:33:30 +0000
Message-ID: <F39DA47E-BFCA-49F2-B2F4-C19F860CC79F@vmware.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <20190110203023.GL2861@worktop.programming.kicks-ass.net>
 <20190110205226.iburt6mrddsxnjpk@treble>
 <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
 <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
 <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com>
 <20190111151525.tf7lhuycyyvjjxez@treble>
 <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
 <12578A17-E695-4DD5-AEC7-E29FAB2C8322@zytor.com>
In-Reply-To: <12578A17-E695-4DD5-AEC7-E29FAB2C8322@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4455;20:2lDk0RrNeFBHSTNbRPO3Sow7PvNH89cyH4IqzYcNS5Rh8R0eQkhcUYUR+O9VovyeUfoiNgSfYZu6cdSCgqIdOsc6XZE2kCout0vrb+yTVidaW25tTyKVtTOJTbgxC7EED6UG4MSvDNghyqiHyxNJr2Ns7gJHtHWi5kb0wS9JIiE=
x-ms-office365-filtering-correlation-id: a083953d-20fa-4ceb-27d6-08d677fbab16
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4455;
x-ms-traffictypediagnostic: BYAPR05MB4455:
x-microsoft-antispam-prvs: <BYAPR05MB4455F609B7AF3D6A5A775A31D0850@BYAPR05MB4455.namprd05.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(376002)(346002)(396003)(189003)(199004)(105586002)(2616005)(102836004)(486006)(106356001)(82746002)(6916009)(93886005)(26005)(186003)(6246003)(53546011)(36756003)(446003)(6506007)(476003)(11346002)(53936002)(3846002)(256004)(14444005)(229853002)(6116002)(6436002)(6486002)(76176011)(5640700003)(2501003)(7736002)(68736007)(45080400002)(99286004)(2351001)(305945005)(54906003)(316002)(81166006)(81156014)(8676002)(66066001)(966005)(1730700003)(71200400001)(2906002)(5660300001)(86362001)(6306002)(83716004)(33656002)(71190400001)(478600001)(97736004)(14454004)(4326008)(6512007)(8936002)(25786009)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4455;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1tDT92TzvSr0SG/OuZgr8q7u5ct15tI2oEwoB/3yiRN3Y+sZD/hI3/grUa1YCy6RIPFRDGrrW/m3zZ0PXsJPEsl39yQdRVNANhmzHQmlTSbMvhnO59U7ZDu/+CLhLIeUTlNoM/pGicSznMNcW3QSRfowJpJ799tfYqRQJLRTTj7K158/nktA4GJpFfsISzZO3wUeqhXD0W/Yzi481YqNCOc5+ZRRbyrm8HlExomowr1IQQMt7csJgC2nXYFN1zKoWftgo1P5I5CQ/gZfkb0D5ddCsL++gyVrTxgJQP46UM2dxrFkFW1Wg7X8yiqU6za/WKeEF98sEPKFsQMwMQwNlVa2DlZ5tDlHD06PKwquIBv37a4IfxLSoja3j0/PLkbg1mge7cWPk73oTznzSI8XKN/icOUdp52Ek0ETMSl8Nkw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA6C9C61327F5F438941A0FA64EAB235@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a083953d-20fa-4ceb-27d6-08d677fbab16
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 19:33:30.6873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gMTEsIDIwMTksIGF0IDExOjIzIEFNLCBocGFAenl0b3IuY29tIHdyb3RlOg0KPiAN
Cj4gT24gSmFudWFyeSAxMSwgMjAxOSAxMTowMzozMCBBTSBQU1QsIExpbnVzIFRvcnZhbGRzIDx0
b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+PiBPbiBGcmksIEphbiAxMSwg
MjAxOSBhdCA3OjE1IEFNIEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUByZWRoYXQuY29tPg0KPj4g
d3JvdGU6DQo+Pj4+IE5vdywgaW4gdGhlIGludDMgaGFuZGxlciBjYW4geW91IHRha2UgdGhlIGZh
dWx0aW5nIFJJUCBhbmQgc2VhcmNoDQo+PiBmb3IgaXQgaW4NCj4+Pj4gdGhlIOKAnHN0YXRpYy1j
YWxsc+KAnSB0YWJsZSwgd3JpdGluZyB0aGUgUklQKzUgKG9mZnNldCkgaW50byBSMTANCj4+IChy
ZXR1cm4NCj4+Pj4gYWRkcmVzcykgYW5kIHRoZSB0YXJnZXQgaW50byBSMTEuIFlvdSBtYWtlIHRo
ZSBpbnQzIGhhbmRsZXIgdG8NCj4+IGRpdmVydCB0aGUNCj4+Pj4gY29kZSBleGVjdXRpb24gYnkg
Y2hhbmdpbmcgcHRfcmVncy0+cmlwIHRvIHBvaW50IHRvIGEgbmV3IGZ1bmN0aW9uDQo+PiB0aGF0
IGRvZXM6DQo+Pj4+ICAgICAgcHVzaCBSMTANCj4+Pj4gICAgICBqbXAgX194ODZfaW5kaXJlY3Rf
dGh1bmtfcjExDQo+Pj4+IA0KPj4+PiBBbmQgdGhlbiB5b3UgYXJlIGRvbmUuIE5vPw0KPj4+IA0K
Pj4+IElJVUMsIHRoYXQgc291bmRzIHByZXR0eSBtdWNoIGxpa2Ugd2hhdCBTdGV2ZW4gcHJvcG9z
ZWQ6DQo+PiBodHRwczovL25hMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3Vy
bD1odHRwcyUzQSUyRiUyRmxrbWwua2VybmVsLm9yZyUyRnIlMkYyMDE4MTEyOTEyMjAwMC43ZmI0
ZmIwNCU0MGdhbmRhbGYubG9jYWwuaG9tZSZhbXA7ZGF0YT0wMiU3QzAxJTdDbmFtaXQlNDB2bXdh
cmUuY29tJTdDYTY2NWEwNzQ5NDBiNDYzMGUzZmMwOGQ2NzdmYTc1M2IlN0NiMzkxMzhjYTNjZWU0
YjRhYTRkNmNkODNkOWRkNjJmMCU3QzAlN0MwJTdDNjM2ODI4MzE0OTQ5ODc0MDE5JmFtcDtzZGF0
YT1mczJ1byUyQmpMJTJGVjNycHpJSEolMkIzUW95SGc0S2hWJTJCJTJGVVBtVU9McHk4UzhwOCUz
RCZhbXA7cmVzZXJ2ZWQ9MA0KPj4+IEkgbGlrZWQgdGhlIGlkZWEsIEJVVCwgaG93IHdvdWxkIGl0
IHdvcmsgZm9yIGNhbGxlZS1zYXZlZCBQViBvcHM/ICBJbg0KPj4+IHRoYXQgY2FzZSB0aGVyZSdz
IG9ubHkgb25lIGNsb2JiZXJlZCByZWdpc3RlciB0byB3b3JrIHdpdGggKHJheCkuDQo+PiANCj4+
IEFjdHVhbGx5LCB0aGVyZSdzIGEgbXVjaCBzaW1wbGVyIG1vZGVsIG5vdyB0aGF0IEkgdGhpbmsg
YWJvdXQgaXQuDQo+PiANCj4+IFRoZSBCUCBmaXh1cCBqdXN0IGZpeGVzIHVwICVyaXAgdG8gdG8g
cG9pbnQgdG8gImJwX2ludDNfaGFuZGxlciIuDQo+PiANCj4+IEFuZCB0aGF0J3MganVzdCBhIHJh
bmRvbSB0ZXh0IGFkZHJlc3Mgc2V0IHVwIGJ5ICJ0ZXh0X3Bva2VfYnAoKSIuDQo+PiANCj4+IFNv
IGhvdyBhYm91dCB0aGUgc3RhdGljIGNhbGwgcmV3cml0aW5nIHNpbXBseSBkbyB0aGlzOg0KPj4g
DQo+PiAtIGZvciBlYWNoIHN0YXRpYyBjYWxsOg0KPj4gDQo+PiAxKSAgIGNyZWF0ZSBhIGZpeHVw
IGNvZGUgc3R1YiB0aGF0IGRvZXMNCj4+IA0KPj4gICAgICAgcHVzaCAkcmV0dXJuYWRkcmVzc2Zv
clRISVNjYWxsDQo+PiAgICAgICBqbXAgdGFyZ2V0Zm9yVEhJU2NhbGwNCj4+IA0KPj4gMikgZG8N
Cj4+IA0KPj4gICAgICAgb25fZWFjaF9jcHUoZG9fc3luY19jb3JlLCBOVUxMLCAxKTsNCj4+IA0K
Pj4gICAgdG8gbWFrZSBzdXJlIGFsbCBDUFUncyBzZWUgdGhpcyBnZW5lcmF0ZWQgY29kZQ0KPj4g
DQo+PiAzKSBkbw0KPj4gDQo+PiAgICAgICB0ZXh0X3Bva2VfYnAoYWRkciwgbmV3Y29kZSwgbmV3
bGVuLCBnZW5lcmF0ZWRjb2RlKTsNCj4+IA0KPj4gVGEtZGFhISBEb25lLg0KPj4gDQo+PiBJbiBm
YWN0LCBpdCB0dXJucyBvdXQgdGhhdCBldmVuIHRoZSBleHRyYSAiZG9fc3luY19jb3JlKCkiIGlu
ICMyIGlzDQo+PiB1bm5lY2Vzc2FyeSwgYmVjYXVzZSB0YWtpbmcgdGhlIEJQIHdpbGwgYmUgc2Vy
aWFsaXppbmcgb24gdGhlIENQVSB0aGF0DQo+PiB0YWtlcyBpdCwgc28gd2UgY2FuIHNraXAgaXQu
DQo+PiANCj4+IEVuZCByZXN1bHQ6IHRoZSB0ZXh0X3Bva2VfYnAoKSBmdW5jdGlvbiB3aWxsIGRv
IHRoZSB0d28gZG9fc3luY19jb3JlDQo+PiBJUEkncyB0aGF0IGd1YXJhbnRlZSB0aGF0IGJ5IHRo
ZSB0aW1lIGl0IHJldHVybnMsIG5vIG90aGVyIENQVSBpcw0KPj4gdXNpbmcgdGhlIGdlbmVyYXRl
ZCBjb2RlIGFueSBtb3JlLCBzbyBpdCBjYW4gYmUgcmUtdXNlZCBmb3IgdGhlIG5leHQNCj4+IHN0
YXRpYyBjYWxsIGZpeHVwLg0KPj4gDQo+PiBOb3RpY2U/IE5vIG9kZCBlbXVsYXRpb24sIG5vIG5l
ZWQgdG8gYWRqdXN0IHRoZSBzdGFjayBpbiB0aGUgQlANCj4+IGhhbmRsZXIsIGp1c3QgdGhlIHJl
Z3VsYXIgInJldHVybiB0byBhIGRpZmZlcmVudCBJUCIuDQo+PiANCj4+IE5vdywgdGhlcmUgaXMg
YSBuYXN0eSBzcGVjaWFsIGNhc2Ugd2l0aCB0aGF0IHN0dWIsIHRob3VnaC4NCj4+IA0KPj4gU28g
bmFzdHkgdGhpbmcgd2l0aCB0aGUgd2hvbGUgImdlbmVyYXRlIGEgc3R1YiBmb3IgZWFjaCBjYWxs
IiBjYXNlOg0KPj4gYmVjYXVzZSBpdCdzIGR5bmFtaWMgYW5kIGJlY2F1c2Ugb2YgdGhlIHJlLXVz
ZSBvZiB0aGUgc3R1YiwgeW91IGNvdWxkDQo+PiBiZSBpbiB0aGUgc2l0dWF0aW9uIHdoZXJlOg0K
Pj4gDQo+PiBDUFUxICAgICAgICAgICAgICAgICAgQ1BVMg0KPj4gLS0tLSAgICAgICAgICAgICAg
ICAgIC0tLS0NCj4+IA0KPj4gZ2VuZXJhdGUgYSBzdHViDQo+PiBvbl9lYWNoX2NwdShkb19zeW5j
X2NvcmUuLikNCj4+IHRleHRfcG9rZV9icCgpDQo+PiAuLi4NCj4+IA0KPj4gcmV3cml0ZSB0byBC
UA0KPj4gICAgICAgICAgICAgICAgICAgICAgIHRyaWdnZXIgdGhlIEJQDQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIHRvIHRoZSBzdHViDQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ZnVuIHRoZSBmaXJzdCBpbnN0cnVjdGlvbiBvZiB0aGUgc3R1Yg0KPj4gICAgICAgICAgICAgICAg
ICAgICAgICpJTlRFUlJVUFQgY2F1c2VzIHJlc2NoZWR1bGluZyoNCj4+IA0KPj4gb25fZWFjaF9j
cHUoZG9fc3luY19jb3JlLi4pDQo+PiByZXdyaXRlIHRvIGdvb2QgaW5zdHJ1Y3Rpb24NCj4+IG9u
X2VhY2hfY3B1KGRvX3N5bmNfY29yZS4uKQ0KPj4gDQo+PiBmcmVlIG9yIHJlLWdlbmVyYXRlIHRo
ZSBzdHViDQo+PiANCj4+ICAgICAgICAgICAgICAgICAgICAgICAhISBUaGUgc3R1YiBpcyBzdGls
bCBpbiB1c2UgISENCj4+IA0KPj4gU28gdGhhdCBzaW1wbGUgImp1c3QgZ2VuZXJhdGUgdGhlIHN0
dWIgZHluYW1pY2FsbHkiIGlzbid0IHNvIHNpbXBsZQ0KPj4gYWZ0ZXIgYWxsLg0KPj4gDQo+PiBC
dXQgaXQgdHVybnMgb3V0IHRoYXQgdGhhdCBpcyByZWFsbHkgc2ltcGxlIHRvIGhhbmRsZSB0b28u
IEhvdyBkbyB3ZSBkbw0KPj4gdGhhdD8NCj4+IA0KPj4gV2UgZG8gdGhhdCBieSBnaXZpbmcgdGhl
IEJQIGhhbmRsZXIgKnR3byogY29kZSBzZXF1ZW5jZXMsIGFuZCB3ZSBtYWtlDQo+PiB0aGUgQlAg
aGFuZGxlciBwaWNrIG9uZSBkZXBlbmRpbmcgb24gd2hldGhlciBpdCBpcyByZXR1cm5pbmcgdG8g
YQ0KPj4gImludGVycnVwdHMgZGlzYWJsZWQiIG9yICJpbnRlcnJ1cHRzIGVuYWJsZWQiIGNhc2Uu
DQo+PiANCj4+IFNvIHRoZSBCUCBoYW5kbGVyIGRvZXMgdGhpczoNCj4+IA0KPj4gLSBpZiB3ZSdy
ZSByZXR1cm5pbmcgd2l0aCBpbnRlcnJ1cHRzIGRpc2FibGVkLCBwaWNrIHRoZSBzaW1wbGUgc3R1
Yg0KPj4gDQo+PiAtIGlmIHdlJ3JlIHJldHVybmluZyB3aXRoIGludGVycnVwdHMgZW5hYmxlZCwg
Y2xrZWFyIElGIGluIHRoZSByZXR1cm4NCj4+ICVyZmxhZ3MsIGFuZCBwaWNrIGEgKnNsaWdodGx5
KiBtb3JlIGNvbXBsZXggc3R1YjoNCj4+IA0KPj4gICAgICAgcHVzaCAkcmV0dXJuYWRkcmVzc2Zv
clRISVNjYWxsDQo+PiAgICAgICBzdGkNCj4+ICAgICAgIGptcCB0YXJnZXRmb3JUSElTY2FsbA0K
Pj4gDQo+PiBhbmQgbm93IHRoZSBTVEkgc2hhZG93IHdpbGwgbWVhbiB0aGF0IHRoaXMgc2VxdWVu
Y2UgaXMgdW5pbnRlcnJ1cHRpYmxlLg0KPj4gDQo+PiBTbyB3ZSdkIG5vdCBkbyBjb21wbGV4IGVt
dWxhdGlvbiBvZiB0aGUgY2FsbCBpbnN0cnVjdGlvbiBhdCBCUCB0aW1lLA0KPj4gYnV0IHdlJ2Qg
ZG8gdGhhdCAqdHJpdmlhbCogY2hhbmdlIGF0IEJQIHRpbWUuDQo+PiANCj4+IFRoaXMgc2VlbXMg
c2ltcGxlLCBkb2Vzbid0IG5lZWQgYW55IHRlbXBvcmFyeSByZWdpc3RlcnMgYXQgYWxsLCBhbmQN
Cj4+IGRvZXNuJ3QgbmVlZCBhbnkgZXh0cmEgc3RhY2sgbWFnaWMuIEl0IGxpdGVyYWxseSBuZWVk
cyBqdXN0IGEgdHJpdmlhbA0KPj4gc2VxdWVuY2UgaW4gcG9rZV9pbnQzX2hhbmRsZXIoKS4NCj4+
IA0KPj4gVGhlIHdlJ2QgY2hhbmdlIHRoZSBlbmQgb2YgcG9rZV9pbnQzX2hhbmRsZXIoKSB0byBk
byBzb21ldGhpbmcgbGlrZQ0KPj4gdGhpcyBpbnN0ZWFkOg0KPj4gDQo+PiAgICAgICB2b2lkICpu
ZXdpcCA9IGJwX2ludDNfaGFuZGxlcjsNCj4+ICAgICAgIC4uDQo+PiAgICAgICBpZiAobmV3ID09
IG1hZ2ljX3N0YXRpY19jYWxsX2JwX2ludDNfaGFuZGxlcikgew0KPj4gICAgICAgICAgICAgICBp
ZiAocmVncy0+ZmxhZ3MgJlg4Nl9GTEFHU19JRikgew0KPj4gICAgICAgICAgICAgICAgICAgICAg
IG5ld2lwID0gbWFnaWNfc3RhdGljX2NhbGxfYnBfaW50M19oYW5kbGVyX3N0aTsNCj4+ICAgICAg
ICAgICAgICAgICAgICAgICByZWdzLT5mbGFncyAmPSB+WDg2X0ZMQUdTX0lGOw0KPj4gICAgICAg
fQ0KPj4gICAgICAgcmVncy0+aXAgPSAodW5zaWduZWQgbG9uZykgbmV3aXA7DQo+PiAgICAgICBy
ZXR1cm4gMTsNCj4+IA0KPj4gQUFORCBub3cgd2UncmUgKnJlYWxseSogZG9uZS4NCj4+IA0KPj4g
RG9lcyBhbnlib2R5IHNlZSBhbnkgaXNzdWVzIGluIHRoaXM/DQo+PiANCj4+ICAgICAgICAgICAg
IExpbnVzDQo+IA0KPiBJIHN0aWxsIGRvbid0IHNlZSB3aHkgY2FuJ3Qgc2ltcGx5IHNwaW4gaW4g
dGhlICNCUCBoYW5kbGVyIHVudGlsIHRoZSBwYXRjaCBpcyBjb21wbGV0ZS4NCj4gDQo+IFdlIGNh
bid0IGhhdmUgdGhlICNCUCBoYW5kbGVyIGRvIGFueSBhZGRpdGlvbmFsIHBhdGNoaW5nLCBhcyBw
cmV2aW91c2x5IGRpc2N1c3NlZCwgYnV0IHNwaW5uaW5nIHNob3VsZCBiZSBwZXJmZWN0bHkgc2Fm
ZS4gVGhlIHNpbXBsZXN0IHdheSB0byBzcGluIGl0IHRvIGp1c3QgSVJFVDsgdGhhdCBib3RoIHNl
cmlhbGl6ZXMgYW5kIHdpbGwgcmUtdGFrZSB0aGUgZXhjZXB0aW9uIGlmIHRoZSBwYXRjaCBpcyBz
dGlsbCBpbiBwcm9ncmVzcy4NCj4gDQo+IEl0IHJlcXVpcmVzIGV4YWN0bHkgKm5vKiBhd2FyZW5l
c3MgaW4gdGhlICNCUCBoYW5kbGVyLCBhbGxvd3MgZm9yIHRoZSBjYWxsIHRvIGJlIHJlcGxhY2Vk
IHdpdGggaW5saW5lIGNvZGUgb3IgYSBzaW1wbGUgTk9QIGlmIGRlc2lyZWQgKG9yIHZpY2UgdmVy
c2EsIGFzIGxvbmcgYXMgaXQgaXMgYSBzaW5nbGUgaW5zdHJ1Y3Rpb24uKQ0KPiANCj4gSWYgSSdt
IG1pc3Npbmcgc29tZXRoaW5nLCB0aGVuIHBsZWFzZSBlZHVjYXRlIG1lIG9yIHBvaW50IG1lIHRv
IHByZXZpb3VzIGRpc2N1c3Npb247IEkgd291bGQgZ3JlYXRseSBhcHByZWNpYXRlIGl0Lg0KDQpP
bmUgdGhpbmcgdGhhdCBjb21lcyB0byBtaW5kIGlzIHRoYXQgdGV4dF9wb2tlX2JwKCkgcnVucyBh
ZnRlciBwYXRjaGluZyB0aGUNCmludDMgYW5kIGJlZm9yZSBwYXRjaGluZyBpbiB0aGUgaW5zdHJ1
Y3Rpb246DQoNCglvbl9lYWNoX2NwdShkb19zeW5jX2NvcmUsIE5VTEwsIDEpOw0KDQpJZiBJUlFz
IGFyZSBkaXNhYmxlZCB3aGVuIHRoZSBCUCBpcyBoaXQsIHNwaW5uaW5nIGNhbiBjYXVzZSB0aGUg
c3lzdGVtIHRvDQpoYW5nLg0KDQo=
