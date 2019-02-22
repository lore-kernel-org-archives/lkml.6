Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D685FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9059A20645
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="TvDQo77w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfBVWjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:39:31 -0500
Received: from mail-eopbgr690089.outbound.protection.outlook.com ([40.107.69.89]:49159
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbfBVWja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZZIylC8dqWWf56tVEnyIuJuWYLOsMXjhITSGi48Qgs=;
 b=TvDQo77wjvO/YCs6oEhV07d8dYPbphFrMOgnLW7CccruNtuRPMWJi+8hNJf8oN/Tf7UqWdHfs7eR7hWdolbtfqO4eFn2PFExfF4DTZYWlHnyxwxUhff1TozbRMAWAYaPqtmR2CfZ0xVD9RW0u19LiquSWXUJ6xjKr5A3RrRAsxc=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5863.namprd05.prod.outlook.com (20.178.50.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.11; Fri, 22 Feb 2019 22:39:18 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::6cf6:1336:9f92:b1b5]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::6cf6:1336:9f92:b1b5%4]) with mapi id 15.20.1665.008; Fri, 22 Feb 2019
 22:39:18 +0000
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
Thread-Index: AQHUyvfM0aln3zH+GEuLAnG94DvLR6XsYEWAgAACsACAAAEPAIAABO4A
Date:   Fri, 22 Feb 2019 22:39:18 +0000
Message-ID: <A7232EDD-C53C-4B7D-AD02-4A480F40538B@vmware.com>
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
In-Reply-To: <7701651F-F10E-4212-925E-1CB77C5D3E69@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30f0c1de-3210-45a0-a924-08d699169506
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5863;
x-ms-traffictypediagnostic: BYAPR05MB5863:
x-ms-exchange-purlcount: 2
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5863;20:YDTKypV4gaeTCnO6v0c3iJcbgX5vtQGMD2iZyDWV7ZQqWpsJ9pWaEfdhu2lr++S0y66KeCuNNl7Fw3+N7oKZl+HaY/llFhjrLnqevmMYEsXdKN2N3Gh1yZ/TuzwBKBlOWSjbcMza9Txx0ZDgsAMJTLl/elePPvII9FrH5JUjxfA=
x-microsoft-antispam-prvs: <BYAPR05MB5863ACE9F65E546ADDD531C3D07F0@BYAPR05MB5863.namprd05.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(346002)(376002)(189003)(199004)(51444003)(8676002)(256004)(53936002)(6246003)(81156014)(5660300002)(6512007)(14454004)(476003)(486006)(71200400001)(14444005)(186003)(83716004)(7416002)(68736007)(25786009)(8936002)(33656002)(54906003)(81166006)(2906002)(71190400001)(99286004)(3846002)(6116002)(36756003)(6506007)(11346002)(86362001)(66066001)(478600001)(6436002)(26005)(6306002)(45080400002)(53546011)(102836004)(2616005)(446003)(97736004)(6916009)(305945005)(4326008)(6486002)(316002)(76176011)(93886005)(82746002)(7736002)(229853002)(106356001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5863;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yVABQ8eafwQmkoaqFwbSTMX0K1mZwo/Vca5aIgZUfw84Xu7nQBoXK2GzvCmEVXJTBpasULbm1noO06WG0n7LH+WndxZGbIdglgSm4ofiZ3WAUqRLhqaf/PJTsL4PNKIrUo8bJvn7cJcbBqq/rfvC7YdmOtvYR7VwdwLGWl+qkLEePExY0C8zWn0Qmh8RkJRCTkZN+BKsKcstxIRbfPOINFhF7yJo/1B/vmJNb0O7RH29fb/7Kj5Bh6cc2cBZ2Vi7Lg6vaN6PJgb0Uj74lWeviPJUWhoBry4xXvpOpRugfctVb3hWvpQfPUoF3TqvY3eCIxpmO2K7mF3+7Kew52B2emU8P5BV0YzT1yFMZ0Hm0xfrdq01/SAFQuIbVZCS7QIA8504xf0eNW3fGRYRqzCz2MvGHQkuBftD92e8hUwV7Yg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7DADF73F3479340959B23E55D3EDEC8@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f0c1de-3210-45a0-a924-08d699169506
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 22:39:18.5834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5863
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBGZWIgMjIsIDIwMTksIGF0IDI6MjEgUE0sIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5j
b20+IHdyb3RlOg0KPiANCj4+IE9uIEZlYiAyMiwgMjAxOSwgYXQgMjoxNyBQTSwgSmFubiBIb3Ju
IDxqYW5uaEBnb29nbGUuY29tPiB3cm90ZToNCj4+IA0KPj4gT24gRnJpLCBGZWIgMjIsIDIwMTkg
YXQgMTE6MDggUE0gTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4gd3JvdGU6DQo+Pj4+IE9u
IEZlYiAyMiwgMjAxOSwgYXQgMTo0MyBQTSwgSmFubiBIb3JuIDxqYW5uaEBnb29nbGUuY29tPiB3
cm90ZToNCj4+Pj4gDQo+Pj4+IChhZGRpbmcgc29tZSBwZW9wbGUgZnJvbSB0aGUgdGV4dF9wb2tl
IHNlcmllcyB0byB0aGUgdGhyZWFkLCByZW1vdmluZyBzdGFibGVAKQ0KPj4+PiANCj4+Pj4gT24g
RnJpLCBGZWIgMjIsIDIwMTkgYXQgODo1NSBQTSBBbmR5IEx1dG9taXJza2kgPGx1dG9AYW1hY2Fw
aXRhbC5uZXQ+IHdyb3RlOg0KPj4+Pj4+IE9uIEZlYiAyMiwgMjAxOSwgYXQgMTE6MzQgQU0sIEFs
ZXhlaSBTdGFyb3ZvaXRvdiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6DQo+
Pj4+Pj4+IE9uIEZyaSwgRmViIDIyLCAyMDE5IGF0IDAyOjMwOjI2UE0gLTA1MDAsIFN0ZXZlbiBS
b3N0ZWR0IHdyb3RlOg0KPj4+Pj4+PiBPbiBGcmksIDIyIEZlYiAyMDE5IDExOjI3OjA1IC0wODAw
DQo+Pj4+Pj4+IEFsZXhlaSBTdGFyb3ZvaXRvdiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNv
bT4gd3JvdGU6DQo+Pj4+Pj4+IA0KPj4+Pj4+Pj4+IE9uIEZyaSwgRmViIDIyLCAyMDE5IGF0IDA5
OjQzOjE0QU0gLTA4MDAsIExpbnVzIFRvcnZhbGRzIHdyb3RlOg0KPj4+Pj4+Pj4+IA0KPj4+Pj4+
Pj4+IFRoZW4gd2Ugc2hvdWxkIHN0aWxsIHByb2JhYmx5IGZpeCB1cCAiX19wcm9iZV9rZXJuZWxf
cmVhZCgpIiB0byBub3QNCj4+Pj4+Pj4+PiBhbGxvdyB1c2VyIGFjY2Vzc2VzLiBUaGUgZWFzaWVz
dCB3YXkgdG8gZG8gdGhhdCBpcyBhY3R1YWxseSBsaWtlbHkgdG8NCj4+Pj4+Pj4+PiB1c2UgdGhl
ICJ1bnNhZmVfZ2V0X3VzZXIoKSIgZnVuY3Rpb25zICp3aXRob3V0KiBkb2luZyBhDQo+Pj4+Pj4+
Pj4gdWFjY2Vzc19iZWdpbigpLCB3aGljaCB3aWxsIG1lYW4gdGhhdCBtb2Rlcm4gQ1BVJ3Mgd2ls
bCBzaW1wbHkgZmF1bHQNCj4+Pj4+Pj4+PiBvbiBhIGtlcm5lbCBhY2Nlc3MgdG8gdXNlciBzcGFj
ZS4NCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gT24gYnBmIHNpZGUgdGhlIGJwZl9wcm9iZV9yZWFkKCkg
aGVscGVyIGp1c3QgY2FsbHMgcHJvYmVfa2VybmVsX3JlYWQoKQ0KPj4+Pj4+Pj4gYW5kIHVzZXJz
IHBhc3MgYm90aCB1c2VyIGFuZCBrZXJuZWwgYWRkcmVzc2VzIGludG8gaXQgYW5kIGV4cGVjdA0K
Pj4+Pj4+Pj4gdGhhdCB0aGUgaGVscGVyIHdpbGwgYWN0dWFsbHkgdHJ5IHRvIHJlYWQgZnJvbSB0
aGF0IGFkZHJlc3MuDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IElmIF9fcHJvYmVfa2VybmVsX3JlYWQg
d2lsbCBzdWRkZW5seSBzdGFydCBmYWlsaW5nIG9uIGFsbCB1c2VyIGFkZHJlc3Nlcw0KPj4+Pj4+
Pj4gaXQgd2lsbCBicmVhayB0aGUgZXhwZWN0YXRpb25zLg0KPj4+Pj4+Pj4gSG93IGRvIHdlIHNv
bHZlIGl0IGluIGJwZl9wcm9iZV9yZWFkPw0KPj4+Pj4+Pj4gQ2FsbCBwcm9iZV9rZXJuZWxfcmVh
ZCBhbmQgaWYgdGhhdCBmYWlscyBjYWxsIHVuc2FmZV9nZXRfdXNlciBieXRlLWJ5LWJ5dGUNCj4+
Pj4+Pj4+IGluIHRoZSBsb29wPw0KPj4+Pj4+Pj4gVGhhdCdzIGRvYWJsZSwgYnV0IHBlb3BsZSBh
bHJlYWR5IGNvbXBsYWluIHRoYXQgYnBmX3Byb2JlX3JlYWQoKSBpcyBzbG93DQo+Pj4+Pj4+PiBh
bmQgc2hvd3MgdXAgaW4gdGhlaXIgcGVyZiByZXBvcnQuDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBXZSdy
ZSBjaGFuZ2luZyBrcHJvYmVzIHRvIGFkZCBhIHNwZWNpZmljIGZsYWcgdG8gc2F5IHRoYXQgd2Ug
d2FudCB0bw0KPj4+Pj4+PiBkaWZmZXJlbnRpYXRlIGJldHdlZW4ga2VybmVsIG9yIHVzZXIgcmVh
ZHMuIENhbiB0aGlzIGJlIGRvbmUgd2l0aA0KPj4+Pj4+PiBicGZfcHJvYmVfcmVhZCgpPyBJZiBp
dCdzIHNob3dpbmcgdXAgaW4gcGVyZiByZXBvcnQsIEkgZG91YnQgYSBzaW5nbGUNCj4+Pj4+PiAN
Cj4+Pj4+PiBzbyB5b3UncmUgc2F5aW5nIHlvdSB3aWxsIGJyZWFrIGV4aXN0aW5nIGtwcm9iZSBz
Y3JpcHRzPw0KPj4+Pj4+IEkgZG9uJ3QgdGhpbmsgaXQncyBhIGdvb2QgaWRlYS4NCj4+Pj4+PiBJ
dCdzIG5vdCBhY2NlcHRhYmxlIHRvIGJyZWFrIGJwZl9wcm9iZV9yZWFkIHVhcGkuDQo+Pj4+PiAN
Cj4+Pj4+IElmIHNvLCB0aGUgdWFwaSBpcyB3cm9uZzogYSBsb25nLXNpemVkIG51bWJlciBkb2Vz
IG5vdCByZWxpYWJseSBpZGVudGlmeSBhbiBhZGRyZXNzIGlmIHlvdSBkb27igJl0IHNlcGFyYXRl
bHkga25vdyB3aGV0aGVyIGl04oCZcyBhIHVzZXIgb3Iga2VybmVsIGFkZHJlc3MuIHMzOTB4IGFu
ZCA0Rzo0RyB4ODZfMzIgYXJlIHRoZSBub3RhYmxlIGV4Y2VwdGlvbnMuIEkgaGF2ZSBsb2JiaWVk
IGZvciBSSVNDLVYgYW5kIGZ1dHVyZSB4ODZfNjQgdG8gam9pbiB0aGUgY3Jvd2QuICBJIGRvbuKA
mXQga25vdyB3aGV0aGVyIEnigJlsbCB3aW4gdGhpcyBmaWdodCwgYnV0IHRoZSB1YXBpIHdpbGwg
cHJvYmFibHkgaGF2ZSB0byBjaGFuZ2UgZm9yIGF0IGxlYXN0IHMzOTB4Lg0KPj4+Pj4gDQo+Pj4+
PiBXaGF0IHRvIGRvIGFib3V0IGV4aXN0aW5nIHNjcmlwdHMgaXMgYSBkaWZmZXJlbnQgcXVlc3Rp
b24uDQo+Pj4+IA0KPj4+PiBUaGlzIGxhY2sgb2YgbG9naWNhbCBzZXBhcmF0aW9uIGJldHdlZW4g
dXNlciBhbmQga2VybmVsIGFkZHJlc3Nlcw0KPj4+PiBtaWdodCBpbnRlcmFjdCBpbnRlcmVzdGlu
Z2x5IHdpdGggdGhlIHRleHRfcG9rZSBzZXJpZXMsIHNwZWNpZmljYWxseQ0KPj4+PiAiW1BBVENI
IHYzIDA1LzIwXSB4ODYvYWx0ZXJuYXRpdmU6IEluaXRpYWxpemUgdGVtcG9yYXJ5IG1tIGZvcg0K
Pj4+PiBwYXRjaGluZyIgKGh0dHBzOi8vbmEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29r
LmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbG9yZS5rZXJuZWwub3JnJTJGbGttbCUyRjIwMTkwMjIx
MjM0NDUxLjE3NjMyLTYtcmljay5wLmVkZ2Vjb21iZSU0MGludGVsLmNvbSUyRiZhbXA7ZGF0YT0w
MiU3QzAxJTdDbmFtaXQlNDB2bXdhcmUuY29tJTdDZjI1MTMwMDllZjczNGVjZDZiMGQwOGQ2OTkx
M2E1YWUlN0NiMzkxMzhjYTNjZWU0YjRhYTRkNmNkODNkOWRkNjJmMCU3QzAlN0MwJTdDNjM2ODY0
NzA3MDIwODIxNzkzJmFtcDtzZGF0YT1IQWJuRGNyQm5lNjRKeVB1VlVNS21NN25RazY3RiUyQkZ2
anVYRW44VG1IZW8lM0QmYW1wO3Jlc2VydmVkPTApDQo+Pj4+IGFuZCAiW1BBVENIIHYzIDA2LzIw
XSB4ODYvYWx0ZXJuYXRpdmU6IFVzZSB0ZW1wb3JhcnkgbW0gZm9yIHRleHQNCj4+Pj4gcG9raW5n
IiAoaHR0cHM6Ly9uYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0
cHMlM0ElMkYlMkZsb3JlLmtlcm5lbC5vcmclMkZsa21sJTJGMjAxOTAyMjEyMzQ0NTEuMTc2MzIt
Ny1yaWNrLnAuZWRnZWNvbWJlJTQwaW50ZWwuY29tJTJGJmFtcDtkYXRhPTAyJTdDMDElN0NuYW1p
dCU0MHZtd2FyZS5jb20lN0NmMjUxMzAwOWVmNzM0ZWNkNmIwZDA4ZDY5OTEzYTVhZSU3Q2IzOTEz
OGNhM2NlZTRiNGFhNGQ2Y2Q4M2Q5ZGQ2MmYwJTdDMCU3QzAlN0M2MzY4NjQ3MDcwMjA4MjE3OTMm
YW1wO3NkYXRhPXZOUklNS3RGRHklMkYzejVGbFR3RGlKWTZWR0VWJTJGTUhnUVBUZEZTRnRDbzRz
JTNEJmFtcDtyZXNlcnZlZD0wKSwNCj4+Pj4gcmlnaHQ/IElmIHNvbWVvbmUgbWFuYWdlcyB0byBn
ZXQgYSB0cmFjaW5nIEJQRiBwcm9ncmFtIHRvIHRyaWdnZXIgaW4gYQ0KPj4+PiB0YXNrIHRoYXQg
aGFzIHN3aXRjaGVkIHRvIHRoZSBwYXRjaGluZyBtbSwgY291bGQgdGhleSB1c2UNCj4+Pj4gYnBm
X3Byb2JlX3dyaXRlX3VzZXIoKSAtIHdoaWNoIHVzZXMgcHJvYmVfa2VybmVsX3dyaXRlKCkgYWZ0
ZXINCj4+Pj4gY2hlY2tpbmcgdGhhdCBLRVJORUxfRFMgaXNuJ3QgYWN0aXZlIGFuZCB0aGF0IGFj
Y2Vzc19vaygpIHBhc3NlcyAtIHRvDQo+Pj4+IG92ZXJ3cml0ZSBrZXJuZWwgdGV4dCB0aGF0IGlz
IG1hcHBlZCB3cml0YWJsZSBpbiB0aGUgcGF0Y2hpbmcgbW0/DQo+Pj4gDQo+Pj4gWWVzLCB0aGlz
IGlzIGEgZ29vZCBwb2ludC4gSSBndWVzcyB0ZXh0X3Bva2UoKSBzaG91bGQgYmUgZGVmaW5lZCB3
aXRoDQo+Pj4g4oCcX19rcHJvYmVz4oCdIGFuZCBvcGVuLWNvZGUgbWVtY3B5Lg0KPj4+IA0KPj4+
IERvZXMgaXQgc291bmQgcmVhc29uYWJsZT8NCj4+IA0KPj4gRG9lc24ndCBfX3RleHRfcG9rZSgp
IGFzIGltcGxlbWVudGVkIGluIHRoZSBwcm9wb3NlZCBwYXRjaCB1c2UgYQ0KPj4gY291cGxlIG90
aGVyIGtlcm5lbCBmdW5jdGlvbnMsIHRvbz8gTGlrZSBzd2l0Y2hfbW1faXJxc19vZmYoKSBhbmQN
Cj4+IHB0ZV9jbGVhcigpICh3aGljaCBjYW4gYmUgYSBjYWxsIGludG8gYSBzZXBhcmF0ZSBmdW5j
dGlvbiBvbiBwYXJhdmlydA0KPj4ga2VybmVscyk/DQo+IA0KPiBJIHdpbGwgbW92ZSB0aGUgcHRl
X2NsZWFyKCkgdG8gYmUgZG9uZSBhZnRlciB0aGUgcG9raW5nIG1tIHdhcyB1bmxvYWRlZC4NCj4g
R2l2ZSBtZSBhIGZldyBtaW51dGVzIHRvIHNlbmQgYSBza2V0Y2ggb2Ygd2hhdCBJIHRoaW5rIHNo
b3VsZCBiZSBkb25lLg0KDQpFcnIuLiBZb3UgYXJlIHJpZ2h0LCBJIGRvbuKAmXQgc2VlIGFuIGVh
c3kgd2F5IG9mIHByZXZlbnRpbmcgYSBrcHJvYmUgZnJvbQ0KYmVpbmcgc2V0IG9uIHN3aXRjaF9t
bV9pcnFzX29mZigpLCBhbmQgb3Blbi1jb2RpbmcgdGhpcyBtb25zdGVyIGlzIHRvbyB1Z2x5Lg0K
DQpUaGUgcmVhc29uYWJsZSBzb2x1dGlvbiBzZWVtcyB0byBtZSBhcyB0YWtpbmcgYWxsIHRoZSBy
ZWxldmFudCBwaWVjZXMgb2YNCmNvZGUgKGFuZCBkYXRhKSB0aGF0IG1pZ2h0IGJlIHVzZWQgZHVy
aW5nIHRleHQtcG9raW5nIGFuZCBlbmNhcHN1bGF0aW5nIHRoZW0sIHNvIHRoZXkNCndpbGwgYmUg
c2V0IGluIGEgbWVtb3J5IGFyZWEgd2hpY2ggY2Fubm90IGJlIGtwcm9iZSdkLiBUaGlzIGNhbiBh
bHNvIGJlDQp1c2VmdWwgdG8gd3JpdGUtcHJvdGVjdCBkYXRhIHN0cnVjdHVyZXMgb2YgY29kZSB0
aGF0IGNhbGxzIHRleHRfcG9rZSgpLA0KZS5nLiwgc3RhdGljLWtleXMuIEl0IGNhbiBhbHNvIHBy
b3RlY3QgZGF0YSBvbiB0aGF0IHN0YWNrIHRoYXQgaXMgdXNlZA0KZHVyaW5nIHRleHRfcG9rZSgp
IGZyb20gYmVpbmcgb3ZlcndyaXR0ZW4gZnJvbSBhbm90aGVyIGNvcmUuDQoNClRoaXMgc29sdXRp
b24gaXMgc29tZXdoYXQgc2ltaWxhciB0byBJZ29yIFN0b3BwYeKAmXMgaWRlYSBvZiB1c2luZyDi
gJxlbmNsYXZlc+KAnQ0Kd2hlbiBkb2luZyB3cml0ZS1yYXJlbHkgb3BlcmF0aW9ucy4NCg0KUmln
aHQgbm93LCBJIHRoaW5rIHRoYXQgdGV4dF9wb2tlKCkgd2lsbCBrZWVwIGJlaW5nIHN1c2NlcHRp
YmxlIHRvIHN1Y2gNCmFuIGF0dGFjaywgdW5sZXNzIHlvdSBoYXZlIGEgYmV0dGVyIHN1Z2dlc3Rp
b24uDQoNCg==
