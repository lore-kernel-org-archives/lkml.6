Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4B0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEDD20883
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="gYw9PzdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfANXvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:51:46 -0500
Received: from mail-eopbgr690066.outbound.protection.outlook.com ([40.107.69.66]:47968
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727163AbfANXvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:51:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5zYVfqkj9Iy1sW4iMQ8KNRDFjWyQoNA6dlLQQPSDM8=;
 b=gYw9PzdRwnlMtoUReWRS0/DDZLfjE8EnxmspPPDPJlPSAwgBQp/gCYCS9hL7fM8wVBIS+Db6R7I4Yo8CAwrOkQOOJWmZ0DjmznDsEwLyVKQ3gPYgE8xTZ6AttIZKha/3DkMA3vs4H8gk0tc7lRT8T/j1UeAU7X251NsS937FcPk=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4150.namprd05.prod.outlook.com (52.135.199.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.18; Mon, 14 Jan 2019 23:51:38 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732%2]) with mapi id 15.20.1537.018; Mon, 14 Jan 2019
 23:51:38 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     "H. Peter Anvin" <hpa@zytor.com>, Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 0/6] Static calls
Thread-Topic: [PATCH v3 0/6] Static calls
Thread-Index: AQHUqG8IuMNefdUVHE69woqiOXvtzqWo9cGAgAAGKQCAACROAIAAH8IAgAAOP4CAAOHdgIAAP7oAgAAFlYCAAAR3AIADl7yAgAACmgCAAUQEAIAAGHmAgAAGngA=
Date:   Mon, 14 Jan 2019 23:51:37 +0000
Message-ID: <CB44BB60-8622-438D-A2E1-B706E2CF4A75@vmware.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <20190110203023.GL2861@worktop.programming.kicks-ass.net>
 <20190110205226.iburt6mrddsxnjpk@treble>
 <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
 <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
 <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com>
 <20190111151525.tf7lhuycyyvjjxez@treble>
 <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
 <12578A17-E695-4DD5-AEC7-E29FAB2C8322@zytor.com>
 <nycvar.YFH.7.76.1901112035570.6626@cbobk.fhfr.pm>
 <5cbd249a-3b2b-6b3b-fb52-67571617403f@zytor.com>
 <207c865e-a92a-1647-b1b0-363010383cc3@zytor.com>
 <9f60be8c-47fb-195b-fdb4-4098f1df3dc2@zytor.com>
 <CALCETrWE-GYr=bUF-RsSNNW5A-=jd2Oy_4yPisKTUiPZTAHm6A@mail.gmail.com>
In-Reply-To: <CALCETrWE-GYr=bUF-RsSNNW5A-=jd2Oy_4yPisKTUiPZTAHm6A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4150;20:VZudPZjiN08AVoC/9AHN9dZU9LE43xNYkq898LrHbl3ZR61Lm9mC9zSytwDvd/D9hcL9YcC3NzM8PaB9OeyAmVO8lb938KKSZ3DgdAExU5TKxIm4m0Ta1k5z9HEhdVmhXJcs+XxiQYQa7KGyojnaMh4WpTqCLRU2qQ3heUE7wAQ=
x-ms-office365-filtering-correlation-id: cfa782af-5fe7-44ba-da74-08d67a7b395b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4150;
x-ms-traffictypediagnostic: BYAPR05MB4150:
x-microsoft-antispam-prvs: <BYAPR05MB4150D2A71BB6BFB510881AC9D0800@BYAPR05MB4150.namprd05.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(366004)(39860400002)(199004)(189003)(68736007)(81166006)(25786009)(36756003)(81156014)(66066001)(6246003)(99286004)(316002)(106356001)(446003)(305945005)(6486002)(8936002)(105586002)(11346002)(476003)(2616005)(4326008)(76176011)(229853002)(33656002)(6436002)(5660300001)(93886005)(6916009)(54906003)(186003)(71200400001)(86362001)(53936002)(6346003)(71190400001)(478600001)(256004)(6116002)(3846002)(14444005)(2906002)(6512007)(82746002)(97736004)(14454004)(53546011)(7416002)(6506007)(486006)(102836004)(8676002)(7736002)(83716004)(26005)(60764002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4150;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YYeKhMthMDm9TtJzg9mimvTL1U7fTvOREMFcwa/TbERHH9zx8+208XdcCU0m7VOyD6nuXCm7GMvUkzaBB5JHzd+2Dy31fRRUsWj/W9sADfROBnXXv7jyk6TAsKcybp3PnMHDzSN0YYM/VLoS3Mff04iuni4X15epsBbZOkunDb76lh1wBXsJTutcbcWaKWGgBAZzt+Rt7Ur9snJS0S7ncD1LbZaTaCdEaSuarXagsyMeIxL5vt12txM+ZYRrqQ2Gge/gJRaJ5JWCBRYABaddI6IMdpWp2zuW411Ehq9Sd+8Rf0qdX1Tb+QmivjrElL92gx/U3PsCzDPNjfNmuN8a3yVGO0OCl+eKevIhQ9++bvqBBJ4SWhW8ULsILXvma6nw6T1ADRcO3X/RNVXOhUJWA5WSQQmeC98x4YCE4qit8ZY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FB630B0B518F04B9EC4E890518C1261@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa782af-5fe7-44ba-da74-08d67a7b395b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 23:51:37.8629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gMTQsIDIwMTksIGF0IDM6MjcgUE0sIEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgSmFuIDE0LCAyMDE5IGF0IDI6MDEgUE0gSC4g
UGV0ZXIgQW52aW4gPGhwYUB6eXRvci5jb20+IHdyb3RlOg0KPj4gU28gSSB3YXMgYWxyZWFkeSBp
biB0aGUgbWlkZGxlIG9mIGNvbXBvc2luZyB0aGlzIG1lc3NhZ2Ugd2hlbiBBbmR5IHBvc3RlZDoN
Cj4+IA0KPj4+IEkgZG9uJ3QgZXZlbiB0aGluayB0aGlzIGlzIHN1ZmZpY2llbnQuICBJIHRoaW5r
IHdlIGFsc28gbmVlZCBldmVyeW9uZQ0KPj4+IHdobyBjbGVhcnMgdGhlIGJpdCB0byBjaGVjayBp
ZiBhbGwgYml0cyBhcmUgY2xlYXIgYW5kLCBpZiBzbywgcmVtb3ZlDQo+Pj4gdGhlIGJyZWFrcG9p
bnQuICBPdGhlcndpc2Ugd2UgaGF2ZSBhIHNpdHVhdGlvbiB3aGVyZSwgaWYgeW91IGFyZSBpbg0K
Pj4+IHRleHRfcG9rZV9icCgpIGFuZCB5b3UgdGFrZSBhbiBOTUkgKG9yIGludGVycnVwdCBvciBN
Q0Ugb3Igd2hhdGV2ZXIpDQo+Pj4gYW5kIHRoYXQgaW50ZXJydXB0IHRoZW4gaGl0cyB0aGUgYnJl
YWtwb2ludCwgdGhlbiB5b3UgZGVhZGxvY2sgYmVjYXVzZQ0KPj4+IG5vIG9uZSByZW1vdmVzIHRo
ZSBicmVha3BvaW50Lg0KPj4+IA0KPj4+IElmIHdlIGRvIHRoaXMsIGFuZCBpZiB3ZSBjYW4gZ3Vh
cmFudGVlIHRoYXQgYWxsIENQVXMgbWFrZSBmb3J3YXJkDQo+Pj4gcHJvZ3Jlc3MsIHRoZW4gbWF5
YmUgdGhlIHByb2JsZW0gaXMgc29sdmVkLiBDYW4gd2UgZ3VhcmFudGVlIHNvbWV0aGluZw0KPj4+
IGxpa2UgYWxsIE5NSSBoYW5kbGVycyB0aGF0IG1pZ2h0IHdhaXQgaW4gYSBzcGlubG9jayBvciBm
b3IgYW55IG90aGVyDQo+Pj4gcmVhc29uIHdpbGwgcGVyaW9kaWNhbGx5IGNoZWNrIGlmIGEgc3lu
YyBpcyBuZWVkZWQgd2hpbGUgdGhleSdyZQ0KPj4+IHNwaW5uaW5nPw0KPj4gDQo+PiBTbyB0aGUg
cmVhbGx5LCByZWFsbHkgbmFzdHkgY2FzZSBpcyB3aGVuIGFuIGFzeW5jaHJvbm91cyBldmVudCBv
biB0aGUNCj4+ICpwYXRjaGluZyogcHJvY2Vzc29yIGdldHMgc3R1Y2sgc3Bpbm5pbmcgb24gYSBy
ZXNvdXJjZSB3aGljaCBpcw0KPj4gdW5hdmFpbGFibGUgZHVlIHRvIGFub3RoZXIgcHJvY2Vzc29y
IHNwaW5uaW5nIG9uIHRoZSAjQlAuIFdlIGNhbiBkaXNhYmxlDQo+PiBpbnRlcnJ1cHRzLCBidXQg
d2UgY2FuJ3Qgc3RvcCBOTUlzIGZyb20gY29taW5nIGluIChhbHRob3VnaCB3ZSBjb3VsZA0KPj4g
dGVzdCBpbiB0aGUgTk1JIGhhbmRsZXIgaWYgd2UgYXJlIGluIHRoYXQgY29uZGl0aW9uIGFuZCBy
ZXR1cm4NCj4+IGltbWVkaWF0ZWx5OyBJJ20gbm90IHN1cmUgd2Ugd2FudCB0byBkbyB0aGF0LCBh
bmQgd2Ugc3RpbGwgaGF2ZSB0byBkZWFsDQo+PiB3aXRoICNNQyBhbmQgd2hhdCBub3QuKQ0KPj4g
DQo+PiBUaGUgZnVuZGFtZW50YWwgcHJvYmxlbSBoZXJlIGlzIHRoYXQgd2UgZG9uJ3Qgc2VlIHRo
ZSAjQlAgb24gdGhlDQo+PiBwYXRjaGluZyBwcm9jZXNzb3IsIGluIHdoaWNoIGNhc2Ugd2UgY291
bGQgc2ltcGx5IGNvbXBsZXRlIHRoZSBwYXRjaGluZw0KPj4gZnJvbSB0aGUgI0JQIGhhbmRsZXIg
b24gdGhhdCBwcm9jZXNzb3IuDQo+PiANCj4+IE9uIDEvMTMvMTkgNjo0MCBQTSwgSC4gUGV0ZXIg
QW52aW4gd3JvdGU6DQo+Pj4gT24gMS8xMy8xOSA2OjMxIFBNLCBILiBQZXRlciBBbnZpbiB3cm90
ZToNCj4+Pj4gc3RhdGljIGNwdW1hc2tfdCB0ZXh0X3Bva2VfY3B1bWFzazsNCj4+Pj4gDQo+Pj4+
IHN0YXRpYyB2b2lkIHRleHRfcG9rZV9zeW5jKHZvaWQpDQo+Pj4+IHsNCj4+Pj4gICAgIHNtcF93
bWIoKTsNCj4+Pj4gICAgIHRleHRfcG9rZV9jcHVtYXNrID0gY3B1X29ubGluZV9tYXNrOw0KPj4+
PiAgICAgc21wX3dtYigpOyAgICAgIC8qIFNob3VsZCBiZSBvcHRpb25hbCBvbiB4ODYgKi8NCj4+
Pj4gICAgIGNwdW1hc2tfY2xlYXJfY3B1KCZ0ZXh0X3Bva2VfY3B1bWFzaywgc21wX3Byb2Nlc3Nv
cl9pZCgpKTsNCj4+Pj4gICAgIG9uX2VhY2hfY3B1X21hc2soJnRleHRfcG9rZV9jcHVtYXNrLCB0
ZXh0X3Bva2Vfc3luY19jcHUsIE5VTEwsIGZhbHNlKTsNCj4+Pj4gICAgIHdoaWxlICghY3B1bWFz
a19lbXB0eSgmdGV4dF9wb2tlX2NwdW1hc2spKSB7DQo+Pj4+ICAgICAgICAgICAgIGNwdV9yZWxh
eCgpOw0KPj4+PiAgICAgICAgICAgICBzbXBfcm1iKCk7DQo+Pj4+ICAgICB9DQo+Pj4+IH0NCj4+
Pj4gDQo+Pj4+IHN0YXRpYyB2b2lkIHRleHRfcG9rZV9zeW5jX2NwdSh2b2lkICpkdW1teSkNCj4+
Pj4gew0KPj4+PiAgICAgKHZvaWQpZHVtbXk7DQo+Pj4+IA0KPj4+PiAgICAgc21wX3JtYigpOw0K
Pj4+PiAgICAgY3B1bWFza19jbGVhcl9jcHUoJnBva2VfYml0bWFzaywgc21wX3Byb2Nlc3Nvcl9p
ZCgpKTsNCj4+Pj4gICAgIC8qDQo+Pj4+ICAgICAgKiBXZSBhcmUgZ3VhcmFudGVlZCB0byByZXR1
cm4gd2l0aCBhbiBJUkVULCBlaXRoZXIgZnJvbSB0aGUNCj4+Pj4gICAgICAqIElQSSBvciB0aGUg
I0JQIGhhbmRsZXI7IHRoaXMgcHJvdmlkZXMgc2VyaWFsaXphdGlvbi4NCj4+Pj4gICAgICAqLw0K
Pj4+PiB9DQo+Pj4gDQo+Pj4gVGhlIGludmFyaWFudHMgaGVyZSBhcmU6DQo+Pj4gDQo+Pj4gMS4g
VGhlIHBhdGNoaW5nIHJvdXRpbmUgbXVzdCBzZXQgZWFjaCBiaXQgaW4gdGhlIGNwdW1hc2sgYWZ0
ZXIgZWFjaCBldmVudA0KPj4+ICAgdGhhdCByZXF1aXJlcyBzeW5jaHJvbml6YXRpb24gaXMgY29t
cGxldGUuDQo+Pj4gMi4gVGhlIGJpdCBjYW4gYmUgKGF0b21pY2FsbHkpIGNsZWFyZWQgb24gdGhl
IHRhcmdldCBDUFUgb25seSwgYW5kIG9ubHkgaW4gYQ0KPj4+ICAgcGxhY2UgdGhhdCBndWFyYW50
ZWVzIGEgc3luY2hyb25pemluZyBldmVudCAoZS5nLiBJUkVUKSBiZWZvcmUgaXQgbWF5DQo+Pj4g
ICByZWFjaGluZyB0aGUgcG9rZWQgaW5zdHJ1Y3Rpb24uDQo+Pj4gMy4gQXQgYSBtaW5pbXVtIHRo
ZSBJUEkgaGFuZGxlciBhbmQgI0JQIGhhbmRsZXIgbmVlZHMgdG8gY2xlYXIgdGhlIGJpdC4gSXQN
Cj4+PiAgICppcyogYWxzbyBwb3NzaWJsZSB0byBjbGVhciBpdCBpbiBvdGhlciBwbGFjZXMsIGUu
Zy4gdGhlIE5NSSBoYW5kbGVyLCBpZg0KPj4+ICAgbmVjZXNzYXJ5IGFzIGxvbmcgYXMgY29uZGl0
aW9uIDIgaXMgc2F0aXNmaWVkLg0KPj4gDQo+PiBPSywgc28gd2l0aCBpbnRlcnJ1cHRzIGVuYWJs
ZWQgKm9uIHRoZSBwcm9jZXNzb3IgZG9pbmcgdGhlIHBhdGNoaW5nKiB3ZQ0KPj4gc3RpbGwgaGF2
ZSBhIHByb2JsZW0gaWYgaXQgdGFrZXMgYW4gaW50ZXJydXB0IHdoaWNoIGluIHR1cm4gdGFrZXMg
YSAjQlAuDQo+PiBEaXNhYmxpbmcgaW50ZXJydXB0cyB3b3VsZCBub3QgaGVscCwgYmVjYXVzZSBi
dXQgYW4gTk1JIGFuZCAjTUMgY291bGQNCj4+IHN0aWxsIGNhdXNlIHByb2JsZW1zIHVubGVzcyB3
ZSBjYW4gZ3VhcmFudGVlIHRoYXQgbm8gcGF0aCB3aGljaCBtYXkgYmUNCj4+IGludm9rZWQgYnkg
Tk1JLyNNQyBjYW4gZG8gdGV4dF9wb2tlLCB3aGljaCBzZWVtcyB0byBiZSBhIHZlcnkgYWdncmVz
c2l2ZQ0KPj4gYXNzdW1wdGlvbi4NCj4+IA0KPj4gTm90ZTogSSBhbSBhc3N1bWluZyBwcmVlbXB0
aW9uIGlzIGRpc2FibGVkLg0KPj4gDQo+PiBUaGUgZWFzaWVzdC9zYW5lc3Qgd2F5IHRvIGRlYWwg
d2l0aCB0aGlzIG1pZ2h0IGJlIHRvIHN3aXRjaCB0aGUgSURUIChvcg0KPj4gcHJvdmlkZSBhIGhv
b2sgaW4gdGhlIGdlbmVyaWMgZXhjZXB0aW9uIGVudHJ5IGNvZGUpIG9uIHRoZSBwYXRjaGluZw0K
Pj4gcHJvY2Vzc29yLCBzdWNoIHRoYXQgaWYgYW4gYXN5bmNocm9ub3VzIGV2ZW50IGNvbWVzIGlu
LCB3ZSBlaXRoZXIgcm9sbA0KPj4gZm9yd2FyZCBvciByZXZlcnQuIFRoaXMgaXMgZG9hYmxlIGJl
Y2F1c2UgdGhlIHNlY29uZCBzeW5jIHdlIGN1cnJlbnRseQ0KPj4gZG8gaXMgbm90IGFjdHVhbGx5
IG5lY2Vzc2FyeSBwZXIgdGhlIGhhcmR3YXJlIGd1eXMuDQo+IA0KPiBUaGlzIGlzIElNTyBpbnNh
bmVseSBjb21wbGljYXRlZC4gIEkgbXVjaCBwcmVmZXIgdGhlIGtpbmQgb2YNCj4gY29tcGxleGl0
eSB0aGF0IGlzIG1vcmUgb3IgbGVzcyBkZXRlcm1pbmlzdGljIGFuZCBlYXN5IHRvIHRlc3QgdG8g
dGhlDQo+IGtpbmQgb2YgY29tcGxleGl0eSAobGlrZSB0aGlzKSB0aGF0IG9ubHkgaGFwcGVucyBp
biBjb3JuZXIgY2FzZXMuDQo+IA0KPiBJIHNlZSB0d28gc29sdXRpb25zIGhlcmU6DQo+IA0KPiAx
LiBKdXN0IHN1Y2sgaXQgdXAgYW5kIGVtdWxhdGUgdGhlIENBTEwuICBBbmQgZmluZCBhIHdheSB0
byB3cml0ZSBhDQo+IHRlc3QgY2FzZSBzbyB3ZSBrbm93IGl0IHdvcmtzLg0KPiANCj4gMi4gRmlu
ZCBhIG5vbi1kZWFkbG9ja3kgd2F5IHRvIG1ha2UgdGhlIGJyZWFrcG9pbnQgaGFuZGxlciB3YWl0
IGZvcg0KPiB0aGUgYnJlYWtwb2ludCB0byBnZXQgcmVtb3ZlZCwgd2l0aG91dCBhbnkgbXVja2lu
ZyBhdCBhbGwgd2l0aCB0aGUNCj4gZW50cnkgY29kZS4gIEFuZCBmaW5kIGEgd2F5IHRvIHdyaXRl
IGEgdGVzdCBjYXNlIHNvIHdlIGtub3cgaXQgd29ya3MuDQo+IChFLmcuIHN0aWNrIGFuIGFjdHVh
bCBzdGF0aWNfY2FsbCBjYWxsIHNpdGUgKmluIHRleHRfcG9rZV9icCgpKiB0aGF0DQo+IGZpcmVz
IG9uY2Ugb24gYm9vdCBzbyB0aGF0IHRoZSByZWFsbHkgYXdmdWwgcmVjdXJzaXZlIGNhc2UgZ2V0
cw0KPiBleGVyY2lzZWQgYWxsIHRoZSB0aW1lLg0KPiANCj4gQnV0IGlmIHdlJ3JlIGdvaW5nIHRv
IGRvIGFueSBtdWNraW5nIHdpdGggdGhlIGVudHJ5IGNvZGUsIGxldCdzIGp1c3QNCj4gZG8gdGhl
IHNpbXBsZSBtdWNraW5nIHRvIG1ha2UgZW11bGF0aW5nIENBTEwgd29yay4NCg0KVGhlc2UgdHdv
IGFwcHJvYWNoZXMgc3RpbGwgc2VlbSBtb3JlIGNvbXBsaWNhdGVkIHRvIG1lIHRoYW4gaGF2aW5n
IGEgDQp0cmFtcG9saW5lIGFzIGJhY2t1cCwgd2hpY2ggaXMgcGF0Y2hlZCBkeW5hbWljYWxseS4N
CiANCklJVUMsIHRoZSBjdXJyZW50IHB1c2hiYWNrIGFnYWluc3QgdGhpcyBvcHRpb24gaXMgdGhh
dCBpdCBtYWtlcyBiYXRjaGluZyBpcw0KbW9yZSBjb21wbGljYXRlZC4gSSBhbSBub3Qgc3VyZSBp
dCBpcyB0aGF0IGJhZCwgYnV0IHRoZXJlIGFyZSBvdGhlciB2YXJpYW50cw0Kb2YgdGhpcyBzb2x1
dGlvbiwgZm9yIGV4YW1wbGUgdXNpbmcgYW4gcmV0cG9saW5lLWxpa2UgZmxvdzoNCg0KQlAtaGFu
ZGxlcjoNCgkvECogU2V0cyBhIHBlci1DUFUgdmFyaWFibGUgdG8gaG9sZCB0aGUgdGFyZ2V0ICov
IA0KCXRoaXNfY3B1X3dyaXRlKGludGVycnVwdGVkX3N0YXRpY19jYWxsX3RhcmdldCkgPSANCgkJ
CQkJZ2V0X3N0YXRpY19jYWxsX3RhcmdldHMocmVncy0+cmlwKTsNCg0KCS8qIENob29zZSB0aGUg
ZnVuY3Rpb24gYmFzZWQgaW4gSVJRLWRpc2FibGUgZHVyaW5nIGludGVycnVwdCAqLw0KCWlmIChy
ZWdzLT5mbGFncyAmIFg4Nl9FRkxBR1NfSUYpIHsNCgkJcmVncy0+ZmxhZ3MgJj0gflg4Nl9FRkxB
R1NfSUY7DQoJCXJlZ3MtPnJpcCA9IHVzZXJfaGFuZGxlcl9JUlFfZGlzYWJsZWQNCgl9IGVsc2Ug
ew0KCQlyZWdzLT5yaXAgPSB1c2VyX2hhbmRsZXJfSVJRX2VuYWJsZWQNCgl9DQoNCnVzZXJfaGFu
ZGxlcl9JUlFfZGlzYWJsZWQ6DQoJcHVzaCBQRVJfQ1BVX1ZBUihpbnRlcnJ1cHRlZF9zdGF0aWNf
Y2FsbF90YXJnZXQpDQoJc3RpICAjIHRoaXMgb25lIGlzIG5vdCBuZWVkZWQgaW4gdGhlIHRoZSBl
bmFibGVkIGNhc2UNCglyZXQgICMgc3RpLWJsb2NraW5nIHByZXZlbnRzIHByZWVtcHRpb24gYmVm
b3JlDQoNCk9idmlvdXNseSwgSSBkb27igJl0IGtub3cgaG93IHRoaXMgY29leGlzdHMgd2l0aCBD
RVQuDQoNCg==
