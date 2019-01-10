Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF84C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E18208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="sVemKIk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfAJTpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:45:34 -0500
Received: from mail-eopbgr680052.outbound.protection.outlook.com ([40.107.68.52]:6688
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726255AbfAJTpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3mYHwlJ3j0Rc2o0eajmS9Q2kifOyq0pIGX5lU67qc4=;
 b=sVemKIk3rnty3TBgkaYtoE0EMFql4RROxomPjHMJjl+NJfbrxFcFBmLMZkLrZOHEgBnOetSbSnVFwVWYXIpuLGhgp+nHj0tNFvyA7l+9Wshy6o2YtRqRgb1cB5aMslGRdkwoTFMdoAr4sOGZ+nWz8odDyhkBQJgN85zoUK8boyw=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4837.namprd05.prod.outlook.com (52.135.235.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.7; Thu, 10 Jan 2019 19:45:26 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732%2]) with mapi id 15.20.1516.010; Thu, 10 Jan 2019
 19:45:26 +0000
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
Subject: Re: [PATCH v3 0/6] Static calls
Thread-Topic: [PATCH v3 0/6] Static calls
Thread-Index: AQHUqG8IuMNefdUVHE69woqiOXvtzqWntJ6AgAEB5ICAAA1xgIAADNqAgAAYZIA=
Date:   Thu, 10 Jan 2019 19:45:26 +0000
Message-ID: <3F89FB6B-DA8B-4C71-B825-2B7EB86F274E@vmware.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <A42784EF-3215-4ED9-8D35-1A2C38A0711F@vmware.com>
 <20190110164401.g747vifrppbhbo3o@treble>
 <D8481FBB-4873-43B2-9187-C0896E859191@vmware.com>
 <20190110181807.irh2b7fk6at43rdl@treble>
In-Reply-To: <20190110181807.irh2b7fk6at43rdl@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4837;20:T07ywQ5PLgQjlrx+vDZ7vjVHXkeusqFPDODXL8rzMQesOYnsv0AMjSzBX0hyJUAZOs9+IxE0cthkmhiSFCxgTnl3gA07qjVcQVt5V+ne1zUB7Fmn3fLujy3osRbnN7R+pqQ7dcMhHiJaXWLjtrJ+5+X+XHyuxNpvy3vw3BMMPVY=
x-ms-office365-filtering-correlation-id: a65877e7-078b-4ccd-7286-08d677342b43
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4837;
x-ms-traffictypediagnostic: BYAPR05MB4837:
x-microsoft-antispam-prvs: <BYAPR05MB48372B2772FC337BBB498164D0840@BYAPR05MB4837.namprd05.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(478600001)(561944003)(33656002)(86362001)(575784001)(54906003)(45080400002)(8936002)(229853002)(81156014)(8676002)(81166006)(6436002)(305945005)(7736002)(68736007)(97736004)(6246003)(76176011)(25786009)(2906002)(6306002)(6512007)(4326008)(53936002)(82746002)(6486002)(66066001)(11346002)(446003)(71200400001)(71190400001)(2616005)(83716004)(476003)(53546011)(6506007)(36756003)(105586002)(6116002)(3846002)(26005)(99286004)(102836004)(5660300001)(7416002)(186003)(486006)(966005)(256004)(14444005)(6916009)(106356001)(14454004)(316002)(93886005)(567974002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4837;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /kOhls2u3VPM6YOo1be09cZai9qUYK3+9kZn+TidAuk9VYhH6FI9VNYZ+SXrlnxAZXUxBtyFISQVxIAakDw/MaPkFk5kU+5zusZGqLqN2ouVkCWBk2vFPjdJh70zE6R+LREz1n6S/MVVXrsXhF1fpau2YeLst/AMi6rGEHziqNCPBvkk61EQsiN/Hcs/O4mIn/4RZ8AtAxIEx5w5TRsDgnwN2d4JnYPD6QxiV62j8chns4V5JpeHiuMUvlJF0KbcC4gj9ShK9hf2TptXtwnyqWlYA14VYDDRYy61nCwi/QvKbc2RjYO4A2X9zw4MnttIhgNPYDj4jFNrsMEIS/THPfWUaXA57mnT9JuyF0lEqN99MFkRfA9eocGBSQl9Yg8rzv55x6AOcXNcHPZ7+Ej8XggwAZ4tNohppm9X8DFijEwFS0Ponoz+6pGI8qeHRR9UVRy091di6Rb6CWEk40DS3A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <64139FD69CFD4649962562D079DFD67B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65877e7-078b-4ccd-7286-08d677342b43
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 19:45:26.5161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gMTAsIDIwMTksIGF0IDEwOjE4IEFNLCBKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VA
cmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEphbiAxMCwgMjAxOSBhdCAwNTozMjow
OFBNICswMDAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4+IE9uIEphbiAxMCwgMjAxOSwgYXQgODo0
NCBBTSwgSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4+IA0K
Pj4+IE9uIFRodSwgSmFuIDEwLCAyMDE5IGF0IDAxOjIxOjAwQU0gKzAwMDAsIE5hZGF2IEFtaXQg
d3JvdGU6DQo+Pj4+PiBPbiBKYW4gOSwgMjAxOSwgYXQgMjo1OSBQTSwgSm9zaCBQb2ltYm9ldWYg
PGpwb2ltYm9lQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBXaXRoIHRoaXMgdmVy
c2lvbiwgSSBzdG9wcGVkIHRyeWluZyB0byB1c2UgdGV4dF9wb2tlX2JwKCksIGFuZCBpbnN0ZWFk
DQo+Pj4+PiB3ZW50IHdpdGggYSBkaWZmZXJlbnQgYXBwcm9hY2g6IGlmIHRoZSBjYWxsIHNpdGUg
ZGVzdGluYXRpb24gZG9lc24ndA0KPj4+Pj4gY3Jvc3MgYSBjYWNoZWxpbmUgYm91bmRhcnksIGp1
c3QgZG8gYW4gYXRvbWljIHdyaXRlLiAgT3RoZXJ3aXNlLCBrZWVwDQo+Pj4+PiB1c2luZyB0aGUg
dHJhbXBvbGluZSBpbmRlZmluaXRlbHkuDQo+Pj4+PiANCj4+Pj4+IE5PVEU6IEF0IGxlYXN0IGV4
cGVyaW1lbnRhbGx5LCB0aGUgY2FsbCBkZXN0aW5hdGlvbiB3cml0ZXMgc2VlbSB0byBiZQ0KPj4+
Pj4gYXRvbWljIHdpdGggcmVzcGVjdCB0byBpbnN0cnVjdGlvbiBmZXRjaGluZy4gIE9uIE5laGFs
ZW0gSSBjYW4gZWFzaWx5DQo+Pj4+PiB0cmlnZ2VyIGNyYXNoZXMgd2hlbiB3cml0aW5nIGEgY2Fs
bCBkZXN0aW5hdGlvbiBhY3Jvc3MgY2FjaGVsaW5lcyB3aGlsZQ0KPj4+Pj4gcmVhZGluZyB0aGUg
aW5zdHJ1Y3Rpb24gb24gb3RoZXIgQ1BVOyBidXQgSSBnZXQgbm8gc3VjaCBjcmFzaGVzIHdoZW4N
Cj4+Pj4+IHJlc3BlY3RpbmcgY2FjaGVsaW5lIGJvdW5kYXJpZXMuDQo+Pj4+PiANCj4+Pj4+IEJV
VCwgdGhlIFNETSBkb2Vzbid0IGRvY3VtZW50IHRoaXMgYXBwcm9hY2gsIHNvIGl0IHdvdWxkIGJl
IGdyZWF0IGlmIGFueQ0KPj4+Pj4gQ1BVIHBlb3BsZSBjYW4gY29uZmlybSB0aGF0IGl0J3Mgc2Fm
ZSENCj4+Pj4gDQo+Pj4+IEkgKHN0aWxsKSB0aGluayB0aGF0IGhhdmluZyBhIGNvbXBpbGVyIHBs
dWdpbiBjYW4gbWFrZSB0aGluZ3MgbXVjaCBjbGVhbmVyDQo+Pj4+IChhcyBkb25lIGluIFsxXSku
IFRoZSBjYWxsZXJzIHdvdWxkIG5vdCBuZWVkIHRvIGJlIGNoYW5nZWQsIGFuZCB0aGUga2V5IGNh
bg0KPj4+PiBiZSBwcm92aWRlZCB0aHJvdWdoIGFuIGF0dHJpYnV0ZS4NCj4+Pj4gDQo+Pj4+IFVz
aW5nIGEgcGx1Z2luIHNob3VsZCBhbHNvIGFsbG93IHRvIHVzZSBTdGV2ZW7igJlzIHByb3Bvc2Fs
IGZvciBkb2luZw0KPj4+PiB0ZXh0X3Bva2UoKSBzYWZlbHk6IGJ5IGNoYW5naW5nICdmdW5jKCkn
IGludG8gJ2FzbSAo4oCcY2FsbCBmdW5j4oCdKScsIGFzIGRvbmUNCj4+Pj4gYnkgdGhlIHBsdWdp
biwgeW91IGNhbiBiZSBndWFyYW50ZWVkIHRoYXQgcmVnaXN0ZXJzIGFyZSBjbG9iYmVyZWQuIFRo
ZW4sIHlvdQ0KPj4+PiBjYW4gc3RvcmUgaW4gdGhlIGFzc2VtYmx5IGJsb2NrIHRoZSByZXR1cm4g
YWRkcmVzcyBpbiBvbmUgb2YgdGhlc2UNCj4+Pj4gcmVnaXN0ZXJzLg0KPj4+IA0KPj4+IEknbSBu
byBHQ0MgZXhwZXJ0ICh3aHkgZG8gSSBmaW5kIG15c2VsZiBzYXlpbmcgdGhpcyBhIGxvdCBsYXRl
bHk/KSwgYnV0DQo+Pj4gdGhpcyBzb3VuZHMgdG8gbWUgbGlrZSBpdCBjb3VsZCBiZSB0cmlja3kg
dG8gZ2V0IHJpZ2h0Lg0KPj4+IA0KPj4+IEkgc3VwcG9zZSB5b3UnZCBoYXZlIHRvIGRvIGl0IGlu
IGFuIGVhcmx5IHBhc3MsIHRvIGFsbG93IEdDQyB0byBjbG9iYmVyDQo+Pj4gdGhlIHJlZ2lzdGVy
cyBpbiBhIGxhdGVyIHBhc3MuICBTbyBpdCB3b3VsZCBuZWNlc3NhcmlseSBoYXZlIHNpZGUNCj4+
PiBlZmZlY3RzLCBidXQgSSBkb24ndCBrbm93IHdoYXQgdGhlIHJpc2tzIGFyZS4NCj4+IA0KPj4g
SeKAmW0gbm90IEdDQyBleHBlcnQgZWl0aGVyIGFuZCB3cml0aW5nIHRoaXMgY29kZSB3YXMgbm90
IG1ha2luZyBtZSBmdWxsIG9mDQo+PiBqb3ksIGV0Yy4uIEnigJlsbCBiZSBoYXBweSB0aGF0IG15
IGNvZGUgd291bGQgYmUgcmV2aWV3ZWQsIGJ1dCBpdCBkb2VzIHdvcmsuIEkNCj4+IGRvbuKAmXQg
dGhpbmsgYW4gZWFybHkgcGFzcyBpcyBuZWVkZWQsIGFzIGxvbmcgYXMgaGFyZHdhcmUgcmVnaXN0
ZXJzIHdlcmUgbm90DQo+PiBhbGxvY2F0ZWQuDQo+PiANCj4+PiBXb3VsZCBpdCB3b3JrIHdpdGgg
bW9yZSB0aGFuIDUgYXJndW1lbnRzLCB3aGVyZSBhcmdzIGdldCBwYXNzZWQgb24gdGhlDQo+Pj4g
c3RhY2s/DQo+PiANCj4+IEl0IGRvZXMuDQo+PiANCj4+PiBBdCB0aGUgdmVyeSBsZWFzdCwgaXQg
d291bGQgKGF0IGxlYXN0IHBhcnRpYWxseSkgZGVmZWF0IHRoZSBwb2ludCBvZiB0aGUNCj4+PiBj
YWxsZWUtc2F2ZWQgcGFyYXZpcnQgb3BzLg0KPj4gDQo+PiBBY3R1YWxseSwgSSB0aGluayB5b3Ug
Y2FuIGV2ZW4gZGVhbCB3aXRoIGNhbGxlZS1zYXZlZCBmdW5jdGlvbnMgYW5kIHJlbW92ZQ0KPj4g
YWxsIHRoZSAodGVycmlibGUpIG1hY3Jvcy4gWW91IHdvdWxkIG5lZWQgdG8gdGVsbCB0aGUgZXh0
ZW5zaW9uIG5vdCB0bw0KPj4gY2xvYmJlciB0aGUgcmVnaXN0ZXJzIHRocm91Z2ggYSBuZXcgYXR0
cmlidXRlLg0KPiANCj4gT2ssIGl0IGRvZXMgc291bmQgaW50ZXJlc3RpbmcgdGhlbi4gIEkgYXNz
dW1lIHlvdSdsbCBiZSBzaGFyaW5nIHRoZQ0KPiBjb2RlPw0KDQpPZiBjb3Vyc2UuIElmIHRoaXMg
d2hhdCBpcyBnb2luZyB0byBjb252aW5jZSwgSeKAmWxsIG1ha2UgYSBzbWFsbCB2ZXJzaW9uIGZv
cg0KUFYgY2FsbGVlLXNhdmVkIGZpcnN0Lg0KDQo+Pj4gV2hhdCBpZiB3ZSBqdXN0IHVzZWQgYSBw
bHVnaW4gaW4gYSBzaW1wbGVyIGZhc2hpb24gLS0gdG8gZG8gY2FsbCBzaXRlDQo+Pj4gYWxpZ25t
ZW50LCBpZiBuZWNlc3NhcnksIHRvIGVuc3VyZSB0aGUgaW5zdHJ1Y3Rpb24gZG9lc24ndCBjcm9z
cw0KPj4+IGNhY2hlbGluZSBib3VuZGFyaWVzLiAgVGhpcyBjb3VsZCBiZSBkb25lIGluIGEgbGF0
ZXIgcGFzcywgd2l0aCBubyBzaWRlDQo+Pj4gZWZmZWN0cyBvdGhlciB0aGFuIGNvZGUgbGF5b3V0
LiAgQW5kIGl0IHdvdWxkIGFsbG93IHVzIHRvIGF2b2lkDQo+Pj4gYnJlYWtwb2ludHMgYWx0b2dl
dGhlciAtLSBhZ2FpbiwgYXNzdW1pbmcgc29tZWJvZHkgY2FuIHZlcmlmeSB0aGF0DQo+Pj4gaW50
cmEtY2FjaGVsaW5lIGNhbGwgZGVzdGluYXRpb24gd3JpdGVzIGFyZSBhdG9taWMgd2l0aCByZXNw
ZWN0IHRvDQo+Pj4gaW5zdHJ1Y3Rpb24gZGVjb2RlciByZWFkcy4NCj4+IA0KPj4gVGhlIHBsdWdp
biBzaG91bGQgbm90IGJlIGFibGUgdG8gZG8gc28uIExheW91dCBvZiB0aGUgYnl0ZWNvZGUgaXMg
ZG9uZSBieQ0KPj4gdGhlIGFzc2VtYmxlciwgc28gSSBkb27igJl0IHRoaW5rIGEgcGx1Z2luIHdv
dWxkIGhlbHAgeW91IHdpdGggdGhpcyBvbmUuDQo+IA0KPiBBY3R1YWxseSBJIHRoaW5rIHdlIGNv
dWxkIHVzZSAuYnVuZGxlX2FsaWduX21vZGUgZm9yIHRoaXMgcHVycG9zZToNCj4gDQo+ICBodHRw
czovL25hMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUy
RiUyRnNvdXJjZXdhcmUub3JnJTJGYmludXRpbHMlMkZkb2NzLTIuMzElMkZhcyUyRkJ1bmRsZS1k
aXJlY3RpdmVzLmh0bWwmYW1wO2RhdGE9MDIlN0MwMSU3Q25hbWl0JTQwdm13YXJlLmNvbSU3Q2Zh
MjlmYjhiZTIwODQ5OGQwMzkwMDhkNjc3MjdmZTMwJTdDYjM5MTM4Y2EzY2VlNGI0YWE0ZDZjZDgz
ZDlkZDYyZjAlN0MwJTdDMCU3QzYzNjgyNzQxMTAwNDY2NDU0OSZhbXA7c2RhdGE9ZWxEdUFWT3NT
bGlkRzdwWlNaZmpiaHJnbk1PSGVYNkFXS3MwaEpNNGNDRSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KDQpI
beKApiBJIGRvbuKAmXQgdW5kZXJzdGFuZCB3aGF0IHlvdSBoYXZlIGluIG1pbmQgKGkuZS4sIHdo
ZW4gd291bGQgdGhpcw0KYXNzZW1ibHkgZGlyZWN0aXZlcyB3b3VsZCBiZSBlbWl0dGVkKS4NCg0K
DQoNCg==
