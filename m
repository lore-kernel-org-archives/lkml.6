Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C1CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAD42075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="lPfAm8UC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfBVXWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:22:17 -0500
Received: from mail-eopbgr820085.outbound.protection.outlook.com ([40.107.82.85]:6016
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbfBVXWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:22:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eb2Azoj7AoQOJabkHmDaMhsqOh/fDTKO2FKhqGtne3U=;
 b=lPfAm8UC/hy1Ql0T/f8r9cs28b9A1Qt+3YrjrKweDpTEe4bSYbNpEKxDci4qK/+dPoEZjI0o94DK8d+//aWOLGc2j+g44LqxP/Xv/MkrnqPSo5rpYCV4lNLMx8GVQPdHa+8/n1GlKEWyvGqlsKYVVteqTtb1e3YqdHzkxhW9Oj4=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4918.namprd05.prod.outlook.com (52.135.235.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.6; Fri, 22 Feb 2019 23:22:12 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::6cf6:1336:9f92:b1b5]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::6cf6:1336:9f92:b1b5%4]) with mapi id 15.20.1665.008; Fri, 22 Feb 2019
 23:22:12 +0000
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Igor Stoppa <igor.stoppa@gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Thread-Topic: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Thread-Index: AQHUyvfM0aln3zH+GEuLAnG94DvLR6XsYEWAgAACsACAAAEPAIAABO4AgAAGf4CAAAV+gA==
Date:   Fri, 22 Feb 2019 23:22:12 +0000
Message-ID: <107D4D4F-E8B2-47AB-B559-40AE8E80D480@vmware.com>
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
 <7701651F-F10E-4212-925E-1CB77C5D3E69@vmware.com>
 <A7232EDD-C53C-4B7D-AD02-4A480F40538B@vmware.com>
 <CAG48ez1Dm04kg2x3O=OOmBFFBSDr+RmnhBYChcwYv5zLbPGudQ@mail.gmail.com>
In-Reply-To: <CAG48ez1Dm04kg2x3O=OOmBFFBSDr+RmnhBYChcwYv5zLbPGudQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88d2ed8f-59a9-4707-a3f0-08d6991c92ea
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4918;
x-ms-traffictypediagnostic: BYAPR05MB4918:
x-ms-exchange-purlcount: 2
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4918;20:YAVkOcg9QlVwsOTC04qmmBSbG1IM1/MUSQ+jOjSgzET8ypGGAoIskzBsa+ZTFRuzrr3u9lVM8vIDKpnt381V7tajlsucRW9k9kRewidRwZNRacpPBa5fW/A1js9buW9p+qHIkPvM/lddTlBRs7WY9jeoOn0D/hG/HT95+JUaCZU=
x-microsoft-antispam-prvs: <BYAPR05MB4918D1BE3AD64E7917DDFDAED07F0@BYAPR05MB4918.namprd05.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(346002)(136003)(376002)(51444003)(189003)(199004)(93886005)(97736004)(105586002)(305945005)(25786009)(68736007)(71190400001)(66066001)(83716004)(71200400001)(7736002)(446003)(486006)(256004)(76176011)(14444005)(102836004)(82746002)(53546011)(106356001)(6506007)(11346002)(33656002)(14454004)(6246003)(316002)(54906003)(6916009)(2616005)(476003)(6486002)(7416002)(99286004)(186003)(6306002)(5660300002)(8936002)(229853002)(45080400002)(81156014)(2906002)(8676002)(26005)(4326008)(478600001)(86362001)(36756003)(81166006)(53936002)(3846002)(6436002)(6116002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4918;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5xNu/t3bbg6rM64l7Laj1i0L2VQhMmcAI7Fs8EqS8Znj7jhWDJKUVm87nrdckDwvjUxKbSEdB7MVy6E8ggAd8SgrKZN1rM6fjXvA4nsT71xIGIbLBH2gNQf52zCzqcPtgGgUSQlO7LTnFSjJqjRCeiqBAFlUSaam6c5DjAX1cwPjluicMmu6p2xc71KQCEdikn+JucnkHQZGEAe5DChiz0yMzxQa9TOTZ5rIegJ41NiXOJSqOB6W0H6EAknNivOi3cOUvDLNOGhrC+++D5IqtSoJVzmp9xREOzEq91IeqGuXYwxCcK56kLOvjSAd735anJUVJ4Pcf5x1HB6qrHnglWmcUk0AmWk+ioXCQ3MsAOqWDqB6h3Q1yuQaav+bcG/uoHrItOaobVawX4/pt5ksjYcW9NOgpcQqWVk+hfhXSv8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF7F9DC12CDFC04CB108872981D4A471@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d2ed8f-59a9-4707-a3f0-08d6991c92ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 23:22:12.0977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4918
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBGZWIgMjIsIDIwMTksIGF0IDM6MDIgUE0sIEphbm4gSG9ybiA8amFubmhAZ29vZ2xlLmNv
bT4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIEZlYiAyMiwgMjAxOSBhdCAxMTozOSBQTSBOYWRhdiBB
bWl0IDxuYW1pdEB2bXdhcmUuY29tPiB3cm90ZToNCj4+PiBPbiBGZWIgMjIsIDIwMTksIGF0IDI6
MjEgUE0sIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+PiBP
biBGZWIgMjIsIDIwMTksIGF0IDI6MTcgUE0sIEphbm4gSG9ybiA8amFubmhAZ29vZ2xlLmNvbT4g
d3JvdGU6DQo+Pj4+IA0KPj4+PiBPbiBGcmksIEZlYiAyMiwgMjAxOSBhdCAxMTowOCBQTSBOYWRh
diBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPiB3cm90ZToNCj4+Pj4+PiBPbiBGZWIgMjIsIDIwMTks
IGF0IDE6NDMgUE0sIEphbm4gSG9ybiA8amFubmhAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+Pj4+Pj4g
DQo+Pj4+Pj4gKGFkZGluZyBzb21lIHBlb3BsZSBmcm9tIHRoZSB0ZXh0X3Bva2Ugc2VyaWVzIHRv
IHRoZSB0aHJlYWQsIHJlbW92aW5nIHN0YWJsZUApDQo+Pj4+Pj4gDQo+Pj4+Pj4gT24gRnJpLCBG
ZWIgMjIsIDIwMTkgYXQgODo1NSBQTSBBbmR5IEx1dG9taXJza2kgPGx1dG9AYW1hY2FwaXRhbC5u
ZXQ+IHdyb3RlOg0KPj4+Pj4+Pj4gT24gRmViIDIyLCAyMDE5LCBhdCAxMTozNCBBTSwgQWxleGVp
IFN0YXJvdm9pdG92IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToNCj4+Pj4+
Pj4+PiBPbiBGcmksIEZlYiAyMiwgMjAxOSBhdCAwMjozMDoyNlBNIC0wNTAwLCBTdGV2ZW4gUm9z
dGVkdCB3cm90ZToNCj4+Pj4+Pj4+PiBPbiBGcmksIDIyIEZlYiAyMDE5IDExOjI3OjA1IC0wODAw
DQo+Pj4+Pj4+Pj4gQWxleGVpIFN0YXJvdm9pdG92IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwu
Y29tPiB3cm90ZToNCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+IE9uIEZyaSwgRmViIDIyLCAyMDE5
IGF0IDA5OjQzOjE0QU0gLTA4MDAsIExpbnVzIFRvcnZhbGRzIHdyb3RlOg0KPj4+Pj4+Pj4+Pj4g
DQo+Pj4+Pj4+Pj4+PiBUaGVuIHdlIHNob3VsZCBzdGlsbCBwcm9iYWJseSBmaXggdXAgIl9fcHJv
YmVfa2VybmVsX3JlYWQoKSIgdG8gbm90DQo+Pj4+Pj4+Pj4+PiBhbGxvdyB1c2VyIGFjY2Vzc2Vz
LiBUaGUgZWFzaWVzdCB3YXkgdG8gZG8gdGhhdCBpcyBhY3R1YWxseSBsaWtlbHkgdG8NCj4+Pj4+
Pj4+Pj4+IHVzZSB0aGUgInVuc2FmZV9nZXRfdXNlcigpIiBmdW5jdGlvbnMgKndpdGhvdXQqIGRv
aW5nIGENCj4+Pj4+Pj4+Pj4+IHVhY2Nlc3NfYmVnaW4oKSwgd2hpY2ggd2lsbCBtZWFuIHRoYXQg
bW9kZXJuIENQVSdzIHdpbGwgc2ltcGx5IGZhdWx0DQo+Pj4+Pj4+Pj4+PiBvbiBhIGtlcm5lbCBh
Y2Nlc3MgdG8gdXNlciBzcGFjZS4NCj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+IE9uIGJwZiBzaWRl
IHRoZSBicGZfcHJvYmVfcmVhZCgpIGhlbHBlciBqdXN0IGNhbGxzIHByb2JlX2tlcm5lbF9yZWFk
KCkNCj4+Pj4+Pj4+Pj4gYW5kIHVzZXJzIHBhc3MgYm90aCB1c2VyIGFuZCBrZXJuZWwgYWRkcmVz
c2VzIGludG8gaXQgYW5kIGV4cGVjdA0KPj4+Pj4+Pj4+PiB0aGF0IHRoZSBoZWxwZXIgd2lsbCBh
Y3R1YWxseSB0cnkgdG8gcmVhZCBmcm9tIHRoYXQgYWRkcmVzcy4NCj4+Pj4+Pj4+Pj4gDQo+Pj4+
Pj4+Pj4+IElmIF9fcHJvYmVfa2VybmVsX3JlYWQgd2lsbCBzdWRkZW5seSBzdGFydCBmYWlsaW5n
IG9uIGFsbCB1c2VyIGFkZHJlc3Nlcw0KPj4+Pj4+Pj4+PiBpdCB3aWxsIGJyZWFrIHRoZSBleHBl
Y3RhdGlvbnMuDQo+Pj4+Pj4+Pj4+IEhvdyBkbyB3ZSBzb2x2ZSBpdCBpbiBicGZfcHJvYmVfcmVh
ZD8NCj4+Pj4+Pj4+Pj4gQ2FsbCBwcm9iZV9rZXJuZWxfcmVhZCBhbmQgaWYgdGhhdCBmYWlscyBj
YWxsIHVuc2FmZV9nZXRfdXNlciBieXRlLWJ5LWJ5dGUNCj4+Pj4+Pj4+Pj4gaW4gdGhlIGxvb3A/
DQo+Pj4+Pj4+Pj4+IFRoYXQncyBkb2FibGUsIGJ1dCBwZW9wbGUgYWxyZWFkeSBjb21wbGFpbiB0
aGF0IGJwZl9wcm9iZV9yZWFkKCkgaXMgc2xvdw0KPj4+Pj4+Pj4+PiBhbmQgc2hvd3MgdXAgaW4g
dGhlaXIgcGVyZiByZXBvcnQuDQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gV2UncmUgY2hhbmdpbmcg
a3Byb2JlcyB0byBhZGQgYSBzcGVjaWZpYyBmbGFnIHRvIHNheSB0aGF0IHdlIHdhbnQgdG8NCj4+
Pj4+Pj4+PiBkaWZmZXJlbnRpYXRlIGJldHdlZW4ga2VybmVsIG9yIHVzZXIgcmVhZHMuIENhbiB0
aGlzIGJlIGRvbmUgd2l0aA0KPj4+Pj4+Pj4+IGJwZl9wcm9iZV9yZWFkKCk/IElmIGl0J3Mgc2hv
d2luZyB1cCBpbiBwZXJmIHJlcG9ydCwgSSBkb3VidCBhIHNpbmdsZQ0KPj4+Pj4+Pj4gDQo+Pj4+
Pj4+PiBzbyB5b3UncmUgc2F5aW5nIHlvdSB3aWxsIGJyZWFrIGV4aXN0aW5nIGtwcm9iZSBzY3Jp
cHRzPw0KPj4+Pj4+Pj4gSSBkb24ndCB0aGluayBpdCdzIGEgZ29vZCBpZGVhLg0KPj4+Pj4+Pj4g
SXQncyBub3QgYWNjZXB0YWJsZSB0byBicmVhayBicGZfcHJvYmVfcmVhZCB1YXBpLg0KPj4+Pj4+
PiANCj4+Pj4+Pj4gSWYgc28sIHRoZSB1YXBpIGlzIHdyb25nOiBhIGxvbmctc2l6ZWQgbnVtYmVy
IGRvZXMgbm90IHJlbGlhYmx5IGlkZW50aWZ5IGFuIGFkZHJlc3MgaWYgeW91IGRvbuKAmXQgc2Vw
YXJhdGVseSBrbm93IHdoZXRoZXIgaXTigJlzIGEgdXNlciBvciBrZXJuZWwgYWRkcmVzcy4gczM5
MHggYW5kIDRHOjRHIHg4Nl8zMiBhcmUgdGhlIG5vdGFibGUgZXhjZXB0aW9ucy4gSSBoYXZlIGxv
YmJpZWQgZm9yIFJJU0MtViBhbmQgZnV0dXJlIHg4Nl82NCB0byBqb2luIHRoZSBjcm93ZC4gIEkg
ZG9u4oCZdCBrbm93IHdoZXRoZXIgSeKAmWxsIHdpbiB0aGlzIGZpZ2h0LCBidXQgdGhlIHVhcGkg
d2lsbCBwcm9iYWJseSBoYXZlIHRvIGNoYW5nZSBmb3IgYXQgbGVhc3QgczM5MHguDQo+Pj4+Pj4+
IA0KPj4+Pj4+PiBXaGF0IHRvIGRvIGFib3V0IGV4aXN0aW5nIHNjcmlwdHMgaXMgYSBkaWZmZXJl
bnQgcXVlc3Rpb24uDQo+Pj4+Pj4gDQo+Pj4+Pj4gVGhpcyBsYWNrIG9mIGxvZ2ljYWwgc2VwYXJh
dGlvbiBiZXR3ZWVuIHVzZXIgYW5kIGtlcm5lbCBhZGRyZXNzZXMNCj4+Pj4+PiBtaWdodCBpbnRl
cmFjdCBpbnRlcmVzdGluZ2x5IHdpdGggdGhlIHRleHRfcG9rZSBzZXJpZXMsIHNwZWNpZmljYWxs
eQ0KPj4+Pj4+ICJbUEFUQ0ggdjMgMDUvMjBdIHg4Ni9hbHRlcm5hdGl2ZTogSW5pdGlhbGl6ZSB0
ZW1wb3JhcnkgbW0gZm9yDQo+Pj4+Pj4gcGF0Y2hpbmciIChodHRwczovL25hMDEuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvcmUua2VybmVsLm9y
ZyUyRmxrbWwlMkYyMDE5MDIyMTIzNDQ1MS4xNzYzMi02LXJpY2sucC5lZGdlY29tYmUlNDBpbnRl
bC5jb20lMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q25hbWl0JTQwdm13YXJlLmNvbSU3Q2QwM2RmMmRi
NzY2MjRkYThlYjIwMDhkNjk5MTllNDFhJTdDYjM5MTM4Y2EzY2VlNGI0YWE0ZDZjZDgzZDlkZDYy
ZjAlN0MwJTdDMCU3QzYzNjg2NDczMzgyMTIzMzkwNiZhbXA7c2RhdGE9a3k1aVRyc0NjZW9Qd1ZX
NU45RkI0c0RzcHdHRVE4TVRsUkU0YjFCcW41NCUzRCZhbXA7cmVzZXJ2ZWQ9MCkNCj4+Pj4+PiBh
bmQgIltQQVRDSCB2MyAwNi8yMF0geDg2L2FsdGVybmF0aXZlOiBVc2UgdGVtcG9yYXJ5IG1tIGZv
ciB0ZXh0DQo+Pj4+Pj4gcG9raW5nIiAoaHR0cHM6Ly9uYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9u
Lm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsb3JlLmtlcm5lbC5vcmclMkZsa21sJTJG
MjAxOTAyMjEyMzQ0NTEuMTc2MzItNy1yaWNrLnAuZWRnZWNvbWJlJTQwaW50ZWwuY29tJTJGJmFt
cDtkYXRhPTAyJTdDMDElN0NuYW1pdCU0MHZtd2FyZS5jb20lN0NkMDNkZjJkYjc2NjI0ZGE4ZWIy
MDA4ZDY5OTE5ZTQxYSU3Q2IzOTEzOGNhM2NlZTRiNGFhNGQ2Y2Q4M2Q5ZGQ2MmYwJTdDMCU3QzAl
N0M2MzY4NjQ3MzM4MjEyMzM5MDYmYW1wO3NkYXRhPUVKczhkb0xyZkZmTVRLaVZIbVdqbXBucFdv
bG11dVo1cHhPbUVNY0kwZXclM0QmYW1wO3Jlc2VydmVkPTApLA0KPj4+Pj4+IHJpZ2h0PyBJZiBz
b21lb25lIG1hbmFnZXMgdG8gZ2V0IGEgdHJhY2luZyBCUEYgcHJvZ3JhbSB0byB0cmlnZ2VyIGlu
IGENCj4+Pj4+PiB0YXNrIHRoYXQgaGFzIHN3aXRjaGVkIHRvIHRoZSBwYXRjaGluZyBtbSwgY291
bGQgdGhleSB1c2UNCj4+Pj4+PiBicGZfcHJvYmVfd3JpdGVfdXNlcigpIC0gd2hpY2ggdXNlcyBw
cm9iZV9rZXJuZWxfd3JpdGUoKSBhZnRlcg0KPj4+Pj4+IGNoZWNraW5nIHRoYXQgS0VSTkVMX0RT
IGlzbid0IGFjdGl2ZSBhbmQgdGhhdCBhY2Nlc3Nfb2soKSBwYXNzZXMgLSB0bw0KPj4+Pj4+IG92
ZXJ3cml0ZSBrZXJuZWwgdGV4dCB0aGF0IGlzIG1hcHBlZCB3cml0YWJsZSBpbiB0aGUgcGF0Y2hp
bmcgbW0/DQo+Pj4+PiANCj4+Pj4+IFllcywgdGhpcyBpcyBhIGdvb2QgcG9pbnQuIEkgZ3Vlc3Mg
dGV4dF9wb2tlKCkgc2hvdWxkIGJlIGRlZmluZWQgd2l0aA0KPj4+Pj4g4oCcX19rcHJvYmVz4oCd
IGFuZCBvcGVuLWNvZGUgbWVtY3B5Lg0KPj4+Pj4gDQo+Pj4+PiBEb2VzIGl0IHNvdW5kIHJlYXNv
bmFibGU/DQo+Pj4+IA0KPj4+PiBEb2Vzbid0IF9fdGV4dF9wb2tlKCkgYXMgaW1wbGVtZW50ZWQg
aW4gdGhlIHByb3Bvc2VkIHBhdGNoIHVzZSBhDQo+Pj4+IGNvdXBsZSBvdGhlciBrZXJuZWwgZnVu
Y3Rpb25zLCB0b28/IExpa2Ugc3dpdGNoX21tX2lycXNfb2ZmKCkgYW5kDQo+Pj4+IHB0ZV9jbGVh
cigpICh3aGljaCBjYW4gYmUgYSBjYWxsIGludG8gYSBzZXBhcmF0ZSBmdW5jdGlvbiBvbiBwYXJh
dmlydA0KPj4+PiBrZXJuZWxzKT8NCj4+PiANCj4+PiBJIHdpbGwgbW92ZSB0aGUgcHRlX2NsZWFy
KCkgdG8gYmUgZG9uZSBhZnRlciB0aGUgcG9raW5nIG1tIHdhcyB1bmxvYWRlZC4NCj4+PiBHaXZl
IG1lIGEgZmV3IG1pbnV0ZXMgdG8gc2VuZCBhIHNrZXRjaCBvZiB3aGF0IEkgdGhpbmsgc2hvdWxk
IGJlIGRvbmUuDQo+PiANCj4+IEVyci4uIFlvdSBhcmUgcmlnaHQsIEkgZG9u4oCZdCBzZWUgYW4g
ZWFzeSB3YXkgb2YgcHJldmVudGluZyBhIGtwcm9iZSBmcm9tDQo+PiBiZWluZyBzZXQgb24gc3dp
dGNoX21tX2lycXNfb2ZmKCksIGFuZCBvcGVuLWNvZGluZyB0aGlzIG1vbnN0ZXIgaXMgdG9vIHVn
bHkuDQo+PiANCj4+IFRoZSByZWFzb25hYmxlIHNvbHV0aW9uIHNlZW1zIHRvIG1lIGFzIHRha2lu
ZyBhbGwgdGhlIHJlbGV2YW50IHBpZWNlcyBvZg0KPj4gY29kZSAoYW5kIGRhdGEpIHRoYXQgbWln
aHQgYmUgdXNlZCBkdXJpbmcgdGV4dC1wb2tpbmcgYW5kIGVuY2Fwc3VsYXRpbmcgdGhlbSwgc28g
dGhleQ0KPj4gd2lsbCBiZSBzZXQgaW4gYSBtZW1vcnkgYXJlYSB3aGljaCBjYW5ub3QgYmUga3By
b2JlJ2QuIFRoaXMgY2FuIGFsc28gYmUNCj4+IHVzZWZ1bCB0byB3cml0ZS1wcm90ZWN0IGRhdGEg
c3RydWN0dXJlcyBvZiBjb2RlIHRoYXQgY2FsbHMgdGV4dF9wb2tlKCksDQo+PiBlLmcuLCBzdGF0
aWMta2V5cy4gSXQgY2FuIGFsc28gcHJvdGVjdCBkYXRhIG9uIHRoYXQgc3RhY2sgdGhhdCBpcyB1
c2VkDQo+PiBkdXJpbmcgdGV4dF9wb2tlKCkgZnJvbSBiZWluZyBvdmVyd3JpdHRlbiBmcm9tIGFu
b3RoZXIgY29yZS4NCj4+IA0KPj4gVGhpcyBzb2x1dGlvbiBpcyBzb21ld2hhdCBzaW1pbGFyIHRv
IElnb3IgU3RvcHBh4oCZcyBpZGVhIG9mIHVzaW5nIOKAnGVuY2xhdmVz4oCdDQo+PiB3aGVuIGRv
aW5nIHdyaXRlLXJhcmVseSBvcGVyYXRpb25zLg0KPj4gDQo+PiBSaWdodCBub3csIEkgdGhpbmsg
dGhhdCB0ZXh0X3Bva2UoKSB3aWxsIGtlZXAgYmVpbmcgc3VzY2VwdGlibGUgdG8gc3VjaA0KPj4g
YW4gYXR0YWNrLCB1bmxlc3MgeW91IGhhdmUgYSBiZXR0ZXIgc3VnZ2VzdGlvbi4NCj4gDQo+IEEg
cmVsYXRpdmVseSBzaW1wbGUgYXBwcm9hY2ggbWlnaHQgYmUgdG8gdGVhY2ggQlBGIG5vdCB0byBy
dW4ga3Byb2JlDQo+IHByb2dyYW1zIGFuZCBzdWNoIGluIGNvbnRleHRzIHdoZXJlIGN1cnJlbnQt
Pm1tIGlzbid0IHRoZSBhY3RpdmUgbW0/DQo+IE1heWJlIHVzaW5nIG5taV91YWNjZXNzX29rYXko
KSwgb3Igc29tZXRoaW5nIGxpa2UgdGhhdD8gSXQgbG9va3MgbGlrZQ0KPiBwZXJmX2NhbGxjaGFp
bl91c2VyKCkgYWxzbyBhbHJlYWR5IHVzZXMgdGhhdC4gRXhjZXB0IHRoYXQgYSBsb3Qgb2YNCj4g
dGhpcyBjb2RlIGlzIHg4Ni1zcGVjaWZpY+KApg0KDQpJIGtlZXAgaGF2aW5nIGluIG1pbmQgaG93
IHRvIHJlZHVjZSB0aGUgVENCIHRoYXQgaXMgdXNlZCB3aGlsZSB0ZXh0X3Bva2UoKQ0KaXMgcnVu
bmluZywgYnV0IGZvciB0aGUgc3BlY2lmaWMgaXNzdWUgaGVyZSwgSSB0aGluayB5b3VyIGFwcHJv
YWNoIHdvdWxkDQpiZSBmaW5lLCBhbmQgdHJhY2VfY2FsbF9icGYoKSBjYW4gYmUgbW9kaWZpZWQg
dG8gZG8gd2hhdCB5b3UgYXNrIGZvci4NCg0KQnV0LCBJIGFtIG5vdCBzdXJlIHRoYXQgcmVseWlu
ZyBvbiBjdXJyZW50LT5tbSBnZXRzIHVzIGFueSBtb3JlIHNlY3VyaXR5LA0KcmVsYXRpdmVseSB0
byBoYXZpbmcgYW5vdGhlciB1bnJlbGF0ZWQgZXhwbGljaXQga3Byb2JlLWRpc2FibGUgaW5kaWNh
dGlvbiwNCndoaWNoIGlzIGNsZWFuZXIgZnJvbSBkZXNpZ24gcG9pbnQtb2Ytdmlldy4NCg0KSSBj
YW4gc2VlIGhvdyB3ZSBnZXQg4oCcc29tZSBtb3JlIHNlY3VyaXR54oCdIGlmIG91ciBkZWNpc2lv
biB3aGV0aGVyIGtwcm9iZXMNCnNob3VsZCBiZSBlbmFibGVkIHdhcyBwdXJlbHkgYmFzZWQgb24g
c29tZSBoYXJkd2FyZSByZWdpc3RlciAoZS5nLiwgQ1IzKSBhbmQNCndlIGNvdWxkIHVuZXF1aXZv
Y2FsbHkgcmVhbGl6ZSB3aGV0aGVyIGtwcm9iZXMgZUJQRiBzaG91bGQgYmUgb24vb2ZmIHdpdGhv
dXQNCm1lbW9yeSBhY2Nlc3NlcyAoZS5nLiwgUENJRCBiaXQgc2V0KS4gWWV0LCBJIGFtIG5vdCBz
dXJlIGl0IHdvcnRoIGl0Lg0KDQpXaGF0IGRvIHlvdSBzYXk/
