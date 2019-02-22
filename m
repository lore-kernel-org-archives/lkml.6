Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A792C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF012206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="I2GJjwU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbfBVWX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:23:27 -0500
Received: from mail-eopbgr680042.outbound.protection.outlook.com ([40.107.68.42]:46880
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbfBVWX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icqfUX7UhDvMVhTlkrgK86HpMcGJjA//fDU2fikvLkE=;
 b=I2GJjwU3auymdfCcl611c8ENx6BpogQfVG1fcJeYjVmpOxvE7y3tsCCjl2ipQNSa732nd9bVeIYYXXoS5JZS8979DhSqfuwhhrK2zazLtHF6bgv+mU/2iMvvhlRqSegBEEi9AEyp4+gMsPpDQVorwY5I+hhyRX2Kfeajl/+mlio=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6533.namprd05.prod.outlook.com (20.178.234.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.11; Fri, 22 Feb 2019 22:21:39 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::6cf6:1336:9f92:b1b5]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::6cf6:1336:9f92:b1b5%4]) with mapi id 15.20.1665.008; Fri, 22 Feb 2019
 22:21:39 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Jann Horn <jannh@google.com>
CC:     Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Thread-Topic: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Thread-Index: AQHUyvfM0aln3zH+GEuLAnG94DvLR6XsYEWAgAACsACAAAEPAA==
Date:   Fri, 22 Feb 2019 22:21:39 +0000
Message-ID: <7701651F-F10E-4212-925E-1CB77C5D3E69@vmware.com>
References: <20190219111802.1d6dbaa3@gandalf.local.home>
 <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
 <20190219140330.5dd9e876@gandalf.local.home>
 <20190220171019.5e81a4946b56982f324f7c45@kernel.org>
 <20190220094926.0ab575b3@gandalf.local.home>
 <20190222172745.2c7205d62003c0a858e33278@kernel.org>
 <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org>
 <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
 <20190222143026.17d6f0f6@gandalf.local.home>
 <20190222193456.5vqppubzrcx5wsul@ast-mbp.dhcp.thefacebook.com>
 <9E670A9A-699C-4B65-962F-CE1AEFD72974@amacapital.net>
 <CAG48ez2tVwzhKPu1tvK+E52jUCq5vTwjssrtMaGuCO=kMpSXGw@mail.gmail.com>
 <0ED6836E-3432-4E1C-BABC-BEA6BDD36287@vmware.com>
 <CAG48ez10RH2YhQ0wnEDOpKoGjrociq+zK0En6Aq06Yg9W3o5aQ@mail.gmail.com>
In-Reply-To: <CAG48ez10RH2YhQ0wnEDOpKoGjrociq+zK0En6Aq06Yg9W3o5aQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bd44469-44a4-433e-f137-08d699141dcd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB6533;
x-ms-traffictypediagnostic: BYAPR05MB6533:
x-ms-exchange-purlcount: 2
x-microsoft-exchange-diagnostics: 1;BYAPR05MB6533;20:tvaIYbri2y0uVhRPPu36nscddxg28aaKp375N8HLQu1exjGJlGHcR3KAQE+tLFT0i/jygH2mMm8llJDfy6/7P9oLgAD4y2RXbYEzCM4rCsvTLp2ukRTUzDkcYP8dA3i+5DilGd3QW7WVyRd40loLdh3L/bnbebkViXBNDK/jhtQ=
x-microsoft-antispam-prvs: <BYAPR05MB6533E6EF390818FAEA84636ED07F0@BYAPR05MB6533.namprd05.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(396003)(136003)(346002)(189003)(199004)(6512007)(478600001)(68736007)(82746002)(6306002)(45080400002)(93886005)(6506007)(81166006)(76176011)(8676002)(256004)(102836004)(53546011)(81156014)(6246003)(14454004)(86362001)(14444005)(305945005)(66066001)(71200400001)(7736002)(71190400001)(83716004)(36756003)(53936002)(316002)(3846002)(2906002)(8936002)(105586002)(186003)(33656002)(26005)(6116002)(54906003)(6486002)(476003)(106356001)(6916009)(99286004)(11346002)(446003)(2616005)(4326008)(229853002)(7416002)(25786009)(486006)(5660300002)(97736004)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6533;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EE4DbvXtQxgE4jPIrwRCl+Efz2jCinmh+btVSIDnjNfj/CQZm0axNqSnt0VC4Yfqsdb+ltA6qYMKNqVc4JuzmU+YG9GIL9D7mwvOshY40vZofAyCcJSkNyJJdWiB1LyLkM0nxFyhUrvdvKBMmKkT/y0f0Zi0BfAQ6bnmzjHZ24XCE8xg1RCV6UQ+I0NameRkb0NmhJ73S1xsEyw4MaOdySdqvNa3jmmZueLIych2ji2V62ID4pIXzqj2wgUXddSLOtlbXBxmX8/rUuzZsxV0Fg0nXJqCdGYu4ZW4UvLpRucE5UAPRLcnrYf/XtWL2L8fCASk07TgwYsbCWtSA5C3zEY9jCbafi/2hb7FXssVE1TlNikKZuYTv3LCT1fB3O/f9q8PJsoS2luusWVv8hU6ud0H3NI3B/NtZIZdw7n5NDo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F223E39CF6B9104CBD3B630AE57284F5@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd44469-44a4-433e-f137-08d699141dcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 22:21:39.6114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6533
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBGZWIgMjIsIDIwMTksIGF0IDI6MTcgUE0sIEphbm4gSG9ybiA8amFubmhAZ29vZ2xlLmNv
bT4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIEZlYiAyMiwgMjAxOSBhdCAxMTowOCBQTSBOYWRhdiBB
bWl0IDxuYW1pdEB2bXdhcmUuY29tPiB3cm90ZToNCj4+PiBPbiBGZWIgMjIsIDIwMTksIGF0IDE6
NDMgUE0sIEphbm4gSG9ybiA8amFubmhAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gKGFk
ZGluZyBzb21lIHBlb3BsZSBmcm9tIHRoZSB0ZXh0X3Bva2Ugc2VyaWVzIHRvIHRoZSB0aHJlYWQs
IHJlbW92aW5nIHN0YWJsZUApDQo+Pj4gDQo+Pj4gT24gRnJpLCBGZWIgMjIsIDIwMTkgYXQgODo1
NSBQTSBBbmR5IEx1dG9taXJza2kgPGx1dG9AYW1hY2FwaXRhbC5uZXQ+IHdyb3RlOg0KPj4+Pj4g
T24gRmViIDIyLCAyMDE5LCBhdCAxMTozNCBBTSwgQWxleGVpIFN0YXJvdm9pdG92IDxhbGV4ZWku
c3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToNCj4+Pj4+PiBPbiBGcmksIEZlYiAyMiwgMjAx
OSBhdCAwMjozMDoyNlBNIC0wNTAwLCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToNCj4+Pj4+PiBPbiBG
cmksIDIyIEZlYiAyMDE5IDExOjI3OjA1IC0wODAwDQo+Pj4+Pj4gQWxleGVpIFN0YXJvdm9pdG92
IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToNCj4+Pj4+PiANCj4+Pj4+Pj4+
IE9uIEZyaSwgRmViIDIyLCAyMDE5IGF0IDA5OjQzOjE0QU0gLTA4MDAsIExpbnVzIFRvcnZhbGRz
IHdyb3RlOg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBUaGVuIHdlIHNob3VsZCBzdGlsbCBwcm9iYWJs
eSBmaXggdXAgIl9fcHJvYmVfa2VybmVsX3JlYWQoKSIgdG8gbm90DQo+Pj4+Pj4+PiBhbGxvdyB1
c2VyIGFjY2Vzc2VzLiBUaGUgZWFzaWVzdCB3YXkgdG8gZG8gdGhhdCBpcyBhY3R1YWxseSBsaWtl
bHkgdG8NCj4+Pj4+Pj4+IHVzZSB0aGUgInVuc2FmZV9nZXRfdXNlcigpIiBmdW5jdGlvbnMgKndp
dGhvdXQqIGRvaW5nIGENCj4+Pj4+Pj4+IHVhY2Nlc3NfYmVnaW4oKSwgd2hpY2ggd2lsbCBtZWFu
IHRoYXQgbW9kZXJuIENQVSdzIHdpbGwgc2ltcGx5IGZhdWx0DQo+Pj4+Pj4+PiBvbiBhIGtlcm5l
bCBhY2Nlc3MgdG8gdXNlciBzcGFjZS4NCj4+Pj4+Pj4gDQo+Pj4+Pj4+IE9uIGJwZiBzaWRlIHRo
ZSBicGZfcHJvYmVfcmVhZCgpIGhlbHBlciBqdXN0IGNhbGxzIHByb2JlX2tlcm5lbF9yZWFkKCkN
Cj4+Pj4+Pj4gYW5kIHVzZXJzIHBhc3MgYm90aCB1c2VyIGFuZCBrZXJuZWwgYWRkcmVzc2VzIGlu
dG8gaXQgYW5kIGV4cGVjdA0KPj4+Pj4+PiB0aGF0IHRoZSBoZWxwZXIgd2lsbCBhY3R1YWxseSB0
cnkgdG8gcmVhZCBmcm9tIHRoYXQgYWRkcmVzcy4NCj4+Pj4+Pj4gDQo+Pj4+Pj4+IElmIF9fcHJv
YmVfa2VybmVsX3JlYWQgd2lsbCBzdWRkZW5seSBzdGFydCBmYWlsaW5nIG9uIGFsbCB1c2VyIGFk
ZHJlc3Nlcw0KPj4+Pj4+PiBpdCB3aWxsIGJyZWFrIHRoZSBleHBlY3RhdGlvbnMuDQo+Pj4+Pj4+
IEhvdyBkbyB3ZSBzb2x2ZSBpdCBpbiBicGZfcHJvYmVfcmVhZD8NCj4+Pj4+Pj4gQ2FsbCBwcm9i
ZV9rZXJuZWxfcmVhZCBhbmQgaWYgdGhhdCBmYWlscyBjYWxsIHVuc2FmZV9nZXRfdXNlciBieXRl
LWJ5LWJ5dGUNCj4+Pj4+Pj4gaW4gdGhlIGxvb3A/DQo+Pj4+Pj4+IFRoYXQncyBkb2FibGUsIGJ1
dCBwZW9wbGUgYWxyZWFkeSBjb21wbGFpbiB0aGF0IGJwZl9wcm9iZV9yZWFkKCkgaXMgc2xvdw0K
Pj4+Pj4+PiBhbmQgc2hvd3MgdXAgaW4gdGhlaXIgcGVyZiByZXBvcnQuDQo+Pj4+Pj4gDQo+Pj4+
Pj4gV2UncmUgY2hhbmdpbmcga3Byb2JlcyB0byBhZGQgYSBzcGVjaWZpYyBmbGFnIHRvIHNheSB0
aGF0IHdlIHdhbnQgdG8NCj4+Pj4+PiBkaWZmZXJlbnRpYXRlIGJldHdlZW4ga2VybmVsIG9yIHVz
ZXIgcmVhZHMuIENhbiB0aGlzIGJlIGRvbmUgd2l0aA0KPj4+Pj4+IGJwZl9wcm9iZV9yZWFkKCk/
IElmIGl0J3Mgc2hvd2luZyB1cCBpbiBwZXJmIHJlcG9ydCwgSSBkb3VidCBhIHNpbmdsZQ0KPj4+
Pj4gDQo+Pj4+PiBzbyB5b3UncmUgc2F5aW5nIHlvdSB3aWxsIGJyZWFrIGV4aXN0aW5nIGtwcm9i
ZSBzY3JpcHRzPw0KPj4+Pj4gSSBkb24ndCB0aGluayBpdCdzIGEgZ29vZCBpZGVhLg0KPj4+Pj4g
SXQncyBub3QgYWNjZXB0YWJsZSB0byBicmVhayBicGZfcHJvYmVfcmVhZCB1YXBpLg0KPj4+PiAN
Cj4+Pj4gSWYgc28sIHRoZSB1YXBpIGlzIHdyb25nOiBhIGxvbmctc2l6ZWQgbnVtYmVyIGRvZXMg
bm90IHJlbGlhYmx5IGlkZW50aWZ5IGFuIGFkZHJlc3MgaWYgeW91IGRvbuKAmXQgc2VwYXJhdGVs
eSBrbm93IHdoZXRoZXIgaXTigJlzIGEgdXNlciBvciBrZXJuZWwgYWRkcmVzcy4gczM5MHggYW5k
IDRHOjRHIHg4Nl8zMiBhcmUgdGhlIG5vdGFibGUgZXhjZXB0aW9ucy4gSSBoYXZlIGxvYmJpZWQg
Zm9yIFJJU0MtViBhbmQgZnV0dXJlIHg4Nl82NCB0byBqb2luIHRoZSBjcm93ZC4gIEkgZG9u4oCZ
dCBrbm93IHdoZXRoZXIgSeKAmWxsIHdpbiB0aGlzIGZpZ2h0LCBidXQgdGhlIHVhcGkgd2lsbCBw
cm9iYWJseSBoYXZlIHRvIGNoYW5nZSBmb3IgYXQgbGVhc3QgczM5MHguDQo+Pj4+IA0KPj4+PiBX
aGF0IHRvIGRvIGFib3V0IGV4aXN0aW5nIHNjcmlwdHMgaXMgYSBkaWZmZXJlbnQgcXVlc3Rpb24u
DQo+Pj4gDQo+Pj4gVGhpcyBsYWNrIG9mIGxvZ2ljYWwgc2VwYXJhdGlvbiBiZXR3ZWVuIHVzZXIg
YW5kIGtlcm5lbCBhZGRyZXNzZXMNCj4+PiBtaWdodCBpbnRlcmFjdCBpbnRlcmVzdGluZ2x5IHdp
dGggdGhlIHRleHRfcG9rZSBzZXJpZXMsIHNwZWNpZmljYWxseQ0KPj4+ICJbUEFUQ0ggdjMgMDUv
MjBdIHg4Ni9hbHRlcm5hdGl2ZTogSW5pdGlhbGl6ZSB0ZW1wb3JhcnkgbW0gZm9yDQo+Pj4gcGF0
Y2hpbmciIChodHRwczovL25hMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3Vy
bD1odHRwcyUzQSUyRiUyRmxvcmUua2VybmVsLm9yZyUyRmxrbWwlMkYyMDE5MDIyMTIzNDQ1MS4x
NzYzMi02LXJpY2sucC5lZGdlY29tYmUlNDBpbnRlbC5jb20lMkYmYW1wO2RhdGE9MDIlN0MwMSU3
Q25hbWl0JTQwdm13YXJlLmNvbSU3Q2YyNTEzMDA5ZWY3MzRlY2Q2YjBkMDhkNjk5MTNhNWFlJTdD
YjM5MTM4Y2EzY2VlNGI0YWE0ZDZjZDgzZDlkZDYyZjAlN0MwJTdDMCU3QzYzNjg2NDcwNzAyMDgy
MTc5MyZhbXA7c2RhdGE9SEFibkRjckJuZTY0SnlQdVZVTUttTTduUWs2N0YlMkJGdmp1WEVuOFRt
SGVvJTNEJmFtcDtyZXNlcnZlZD0wKQ0KPj4+IGFuZCAiW1BBVENIIHYzIDA2LzIwXSB4ODYvYWx0
ZXJuYXRpdmU6IFVzZSB0ZW1wb3JhcnkgbW0gZm9yIHRleHQNCj4+PiBwb2tpbmciIChodHRwczov
L25hMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUy
RmxvcmUua2VybmVsLm9yZyUyRmxrbWwlMkYyMDE5MDIyMTIzNDQ1MS4xNzYzMi03LXJpY2sucC5l
ZGdlY29tYmUlNDBpbnRlbC5jb20lMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q25hbWl0JTQwdm13YXJl
LmNvbSU3Q2YyNTEzMDA5ZWY3MzRlY2Q2YjBkMDhkNjk5MTNhNWFlJTdDYjM5MTM4Y2EzY2VlNGI0
YWE0ZDZjZDgzZDlkZDYyZjAlN0MwJTdDMCU3QzYzNjg2NDcwNzAyMDgyMTc5MyZhbXA7c2RhdGE9
dk5SSU1LdEZEeSUyRjN6NUZsVHdEaUpZNlZHRVYlMkZNSGdRUFRkRlNGdENvNHMlM0QmYW1wO3Jl
c2VydmVkPTApLA0KPj4+IHJpZ2h0PyBJZiBzb21lb25lIG1hbmFnZXMgdG8gZ2V0IGEgdHJhY2lu
ZyBCUEYgcHJvZ3JhbSB0byB0cmlnZ2VyIGluIGENCj4+PiB0YXNrIHRoYXQgaGFzIHN3aXRjaGVk
IHRvIHRoZSBwYXRjaGluZyBtbSwgY291bGQgdGhleSB1c2UNCj4+PiBicGZfcHJvYmVfd3JpdGVf
dXNlcigpIC0gd2hpY2ggdXNlcyBwcm9iZV9rZXJuZWxfd3JpdGUoKSBhZnRlcg0KPj4+IGNoZWNr
aW5nIHRoYXQgS0VSTkVMX0RTIGlzbid0IGFjdGl2ZSBhbmQgdGhhdCBhY2Nlc3Nfb2soKSBwYXNz
ZXMgLSB0bw0KPj4+IG92ZXJ3cml0ZSBrZXJuZWwgdGV4dCB0aGF0IGlzIG1hcHBlZCB3cml0YWJs
ZSBpbiB0aGUgcGF0Y2hpbmcgbW0/DQo+PiANCj4+IFllcywgdGhpcyBpcyBhIGdvb2QgcG9pbnQu
IEkgZ3Vlc3MgdGV4dF9wb2tlKCkgc2hvdWxkIGJlIGRlZmluZWQgd2l0aA0KPj4g4oCcX19rcHJv
YmVz4oCdIGFuZCBvcGVuLWNvZGUgbWVtY3B5Lg0KPj4gDQo+PiBEb2VzIGl0IHNvdW5kIHJlYXNv
bmFibGU/DQo+IA0KPiBEb2Vzbid0IF9fdGV4dF9wb2tlKCkgYXMgaW1wbGVtZW50ZWQgaW4gdGhl
IHByb3Bvc2VkIHBhdGNoIHVzZSBhDQo+IGNvdXBsZSBvdGhlciBrZXJuZWwgZnVuY3Rpb25zLCB0
b28/IExpa2Ugc3dpdGNoX21tX2lycXNfb2ZmKCkgYW5kDQo+IHB0ZV9jbGVhcigpICh3aGljaCBj
YW4gYmUgYSBjYWxsIGludG8gYSBzZXBhcmF0ZSBmdW5jdGlvbiBvbiBwYXJhdmlydA0KPiBrZXJu
ZWxzKT8NCg0KSSB3aWxsIG1vdmUgdGhlIHB0ZV9jbGVhcigpIHRvIGJlIGRvbmUgYWZ0ZXIgdGhl
IHBva2luZyBtbSB3YXMgdW5sb2FkZWQuDQpHaXZlIG1lIGEgZmV3IG1pbnV0ZXMgdG8gc2VuZCBh
IHNrZXRjaCBvZiB3aGF0IEkgdGhpbmsgc2hvdWxkIGJlIGRvbmUuDQoNCg==
