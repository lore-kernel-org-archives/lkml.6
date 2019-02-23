Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B298C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2125B206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="l4Bvs8hq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfBWAQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:16:05 -0500
Received: from mail-eopbgr710068.outbound.protection.outlook.com ([40.107.71.68]:25984
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbfBWAQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+hYe30GBongr+8OuFvveKlphRgkfqdHYxRMBUay5Eo=;
 b=l4Bvs8hq+Eg2EFsWVKwbueegzf3nELYNMV2BCoigv77bn3q9yGSeuFhGFeZvxnm/nJzRT/Ilm/CgFPAXtiQ15s6+r2aYZjDBfS40O6zkYc/DjmnjX5/sGZPb3vD8VPuszZ6iyNDysqwxRsQTgNnvyi+K/7pO0lAQZS9l3HAIuNk=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6631.namprd05.prod.outlook.com (20.179.60.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.11; Sat, 23 Feb 2019 00:15:56 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::6cf6:1336:9f92:b1b5]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::6cf6:1336:9f92:b1b5%4]) with mapi id 15.20.1665.008; Sat, 23 Feb 2019
 00:15:56 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Jann Horn <jannh@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Kees Cook <keescook@chromium.org>,
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
Thread-Index: AQHUyvfM0aln3zH+GEuLAnG94DvLR6XsYEWAgAACsACAAAEPAIAABO4AgAAGf4CAAA/rAIAABJeA
Date:   Sat, 23 Feb 2019 00:15:56 +0000
Message-ID: <7E4E5362-4C13-40FA-B5A8-F88D3E60827F@vmware.com>
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
 <CALCETrU2V5KBA97g3O-yHiUu1acmM_K9b2a5ATmKSqGwdd-+Dw@mail.gmail.com>
In-Reply-To: <CALCETrU2V5KBA97g3O-yHiUu1acmM_K9b2a5ATmKSqGwdd-+Dw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e9700b6-de3b-4eff-39b4-08d6992414b0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB6631;
x-ms-traffictypediagnostic: BYAPR05MB6631:
x-ms-exchange-purlcount: 2
x-microsoft-exchange-diagnostics: 1;BYAPR05MB6631;20:ou5vEkp/VOjaV3fnZrQl60fe+f/Sa6FHQQrbH55o+U9HclR9N60Q/WZ7TjPszlqsovHOVy7l49+mcf+I+w/bb4FCsCS/90y4DH1CVIv+fo++rW3mt/4gif/f7SPub/e43P5Enksp3oAc4wf25U4Q1J2CfrD72OYo/RSBz9n1nWA=
x-microsoft-antispam-prvs: <BYAPR05MB663169265FD166339E88F8B3D0780@BYAPR05MB6631.namprd05.prod.outlook.com>
x-forefront-prvs: 0957AD37A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(136003)(39860400002)(396003)(199004)(189003)(51444003)(83716004)(71200400001)(14444005)(54906003)(3846002)(25786009)(6346003)(93886005)(6486002)(8936002)(7416002)(256004)(68736007)(446003)(106356001)(8676002)(86362001)(81156014)(6246003)(6116002)(105586002)(5660300002)(6436002)(2906002)(66066001)(6916009)(71190400001)(82746002)(4326008)(11346002)(316002)(81166006)(36756003)(14454004)(186003)(26005)(97736004)(76176011)(53936002)(102836004)(476003)(486006)(305945005)(229853002)(478600001)(45080400002)(99286004)(6512007)(33656002)(7736002)(53546011)(6506007)(6306002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6631;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VTnZrwnxN0WnWosYuIfPsw7Vzp07xt4zU6G/cDntfLl6V8p77HQ21IqciSie1DZd1siCZEDy5yOY687S3XW58xYS9KCwaZJdGqaxMGImwRzmDIiq+sdqNaqP5ohU8knERIntCy3eNTC6GceY77cmx7QFdjj9oHxNukh7dOljhH08whmsJ03fsxl1+EHvS8A0/nW5NZ948aDLjltnrpOt1lFlqhOi/4cO91dW26aC1XSSfrkFMeQCa3DMO0373t1T3bzU+53gpeBI0oaP8fMHvmDi4oE5vO6NWgjIU9ipTIAuyJjeghkSRVmKD0j0GgT/mxJmoE08YGq8zcEpqArVcoJS05gN7e8QM8w1m4IAZ+crYrN6Ax4r8+w/46WWk8BHQJmWvPGNQIbN4hCaZP79kCmXLP0Jyl1CLNlN8ijgma8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADD4FC40398C2A4ABDA23F0BFC4BE4B1@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9700b6-de3b-4eff-39b4-08d6992414b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2019 00:15:56.2088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBGZWIgMjIsIDIwMTksIGF0IDM6NTkgUE0sIEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgRmViIDIyLCAyMDE5IGF0IDM6MDIgUE0gSmFu
biBIb3JuIDxqYW5uaEBnb29nbGUuY29tPiB3cm90ZToNCj4+IE9uIEZyaSwgRmViIDIyLCAyMDE5
IGF0IDExOjM5IFBNIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4+PiBP
biBGZWIgMjIsIDIwMTksIGF0IDI6MjEgUE0sIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+
IHdyb3RlOg0KPj4+PiANCj4+Pj4+IE9uIEZlYiAyMiwgMjAxOSwgYXQgMjoxNyBQTSwgSmFubiBI
b3JuIDxqYW5uaEBnb29nbGUuY29tPiB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4gT24gRnJpLCBGZWIg
MjIsIDIwMTkgYXQgMTE6MDggUE0gTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4gd3JvdGU6
DQo+Pj4+Pj4+IE9uIEZlYiAyMiwgMjAxOSwgYXQgMTo0MyBQTSwgSmFubiBIb3JuIDxqYW5uaEBn
b29nbGUuY29tPiB3cm90ZToNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IChhZGRpbmcgc29tZSBwZW9wbGUg
ZnJvbSB0aGUgdGV4dF9wb2tlIHNlcmllcyB0byB0aGUgdGhyZWFkLCByZW1vdmluZyBzdGFibGVA
KQ0KPj4+Pj4+PiANCj4+Pj4+Pj4gT24gRnJpLCBGZWIgMjIsIDIwMTkgYXQgODo1NSBQTSBBbmR5
IEx1dG9taXJza2kgPGx1dG9AYW1hY2FwaXRhbC5uZXQ+IHdyb3RlOg0KPj4+Pj4+Pj4+IE9uIEZl
YiAyMiwgMjAxOSwgYXQgMTE6MzQgQU0sIEFsZXhlaSBTdGFyb3ZvaXRvdiA8YWxleGVpLnN0YXJv
dm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4+Pj4+Pj4+IE9uIEZyaSwgRmViIDIyLCAyMDE5
IGF0IDAyOjMwOjI2UE0gLTA1MDAsIFN0ZXZlbiBSb3N0ZWR0IHdyb3RlOg0KPj4+Pj4+Pj4+PiBP
biBGcmksIDIyIEZlYiAyMDE5IDExOjI3OjA1IC0wODAwDQo+Pj4+Pj4+Pj4+IEFsZXhlaSBTdGFy
b3ZvaXRvdiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4+Pj4+Pj4+
IA0KPj4+Pj4+Pj4+Pj4+IE9uIEZyaSwgRmViIDIyLCAyMDE5IGF0IDA5OjQzOjE0QU0gLTA4MDAs
IExpbnVzIFRvcnZhbGRzIHdyb3RlOg0KPj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4+IFRoZW4g
d2Ugc2hvdWxkIHN0aWxsIHByb2JhYmx5IGZpeCB1cCAiX19wcm9iZV9rZXJuZWxfcmVhZCgpIiB0
byBub3QNCj4+Pj4+Pj4+Pj4+PiBhbGxvdyB1c2VyIGFjY2Vzc2VzLiBUaGUgZWFzaWVzdCB3YXkg
dG8gZG8gdGhhdCBpcyBhY3R1YWxseSBsaWtlbHkgdG8NCj4+Pj4+Pj4+Pj4+PiB1c2UgdGhlICJ1
bnNhZmVfZ2V0X3VzZXIoKSIgZnVuY3Rpb25zICp3aXRob3V0KiBkb2luZyBhDQo+Pj4+Pj4+Pj4+
Pj4gdWFjY2Vzc19iZWdpbigpLCB3aGljaCB3aWxsIG1lYW4gdGhhdCBtb2Rlcm4gQ1BVJ3Mgd2ls
bCBzaW1wbHkgZmF1bHQNCj4+Pj4+Pj4+Pj4+PiBvbiBhIGtlcm5lbCBhY2Nlc3MgdG8gdXNlciBz
cGFjZS4NCj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4gT24gYnBmIHNpZGUgdGhlIGJwZl9wcm9i
ZV9yZWFkKCkgaGVscGVyIGp1c3QgY2FsbHMgcHJvYmVfa2VybmVsX3JlYWQoKQ0KPj4+Pj4+Pj4+
Pj4gYW5kIHVzZXJzIHBhc3MgYm90aCB1c2VyIGFuZCBrZXJuZWwgYWRkcmVzc2VzIGludG8gaXQg
YW5kIGV4cGVjdA0KPj4+Pj4+Pj4+Pj4gdGhhdCB0aGUgaGVscGVyIHdpbGwgYWN0dWFsbHkgdHJ5
IHRvIHJlYWQgZnJvbSB0aGF0IGFkZHJlc3MuDQo+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+IElm
IF9fcHJvYmVfa2VybmVsX3JlYWQgd2lsbCBzdWRkZW5seSBzdGFydCBmYWlsaW5nIG9uIGFsbCB1
c2VyIGFkZHJlc3Nlcw0KPj4+Pj4+Pj4+Pj4gaXQgd2lsbCBicmVhayB0aGUgZXhwZWN0YXRpb25z
Lg0KPj4+Pj4+Pj4+Pj4gSG93IGRvIHdlIHNvbHZlIGl0IGluIGJwZl9wcm9iZV9yZWFkPw0KPj4+
Pj4+Pj4+Pj4gQ2FsbCBwcm9iZV9rZXJuZWxfcmVhZCBhbmQgaWYgdGhhdCBmYWlscyBjYWxsIHVu
c2FmZV9nZXRfdXNlciBieXRlLWJ5LWJ5dGUNCj4+Pj4+Pj4+Pj4+IGluIHRoZSBsb29wPw0KPj4+
Pj4+Pj4+Pj4gVGhhdCdzIGRvYWJsZSwgYnV0IHBlb3BsZSBhbHJlYWR5IGNvbXBsYWluIHRoYXQg
YnBmX3Byb2JlX3JlYWQoKSBpcyBzbG93DQo+Pj4+Pj4+Pj4+PiBhbmQgc2hvd3MgdXAgaW4gdGhl
aXIgcGVyZiByZXBvcnQuDQo+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+PiBXZSdyZSBjaGFuZ2luZyBr
cHJvYmVzIHRvIGFkZCBhIHNwZWNpZmljIGZsYWcgdG8gc2F5IHRoYXQgd2Ugd2FudCB0bw0KPj4+
Pj4+Pj4+PiBkaWZmZXJlbnRpYXRlIGJldHdlZW4ga2VybmVsIG9yIHVzZXIgcmVhZHMuIENhbiB0
aGlzIGJlIGRvbmUgd2l0aA0KPj4+Pj4+Pj4+PiBicGZfcHJvYmVfcmVhZCgpPyBJZiBpdCdzIHNo
b3dpbmcgdXAgaW4gcGVyZiByZXBvcnQsIEkgZG91YnQgYSBzaW5nbGUNCj4+Pj4+Pj4+PiANCj4+
Pj4+Pj4+PiBzbyB5b3UncmUgc2F5aW5nIHlvdSB3aWxsIGJyZWFrIGV4aXN0aW5nIGtwcm9iZSBz
Y3JpcHRzPw0KPj4+Pj4+Pj4+IEkgZG9uJ3QgdGhpbmsgaXQncyBhIGdvb2QgaWRlYS4NCj4+Pj4+
Pj4+PiBJdCdzIG5vdCBhY2NlcHRhYmxlIHRvIGJyZWFrIGJwZl9wcm9iZV9yZWFkIHVhcGkuDQo+
Pj4+Pj4+PiANCj4+Pj4+Pj4+IElmIHNvLCB0aGUgdWFwaSBpcyB3cm9uZzogYSBsb25nLXNpemVk
IG51bWJlciBkb2VzIG5vdCByZWxpYWJseSBpZGVudGlmeSBhbiBhZGRyZXNzIGlmIHlvdSBkb27i
gJl0IHNlcGFyYXRlbHkga25vdyB3aGV0aGVyIGl04oCZcyBhIHVzZXIgb3Iga2VybmVsIGFkZHJl
c3MuIHMzOTB4IGFuZCA0Rzo0RyB4ODZfMzIgYXJlIHRoZSBub3RhYmxlIGV4Y2VwdGlvbnMuIEkg
aGF2ZSBsb2JiaWVkIGZvciBSSVNDLVYgYW5kIGZ1dHVyZSB4ODZfNjQgdG8gam9pbiB0aGUgY3Jv
d2QuICBJIGRvbuKAmXQga25vdyB3aGV0aGVyIEnigJlsbCB3aW4gdGhpcyBmaWdodCwgYnV0IHRo
ZSB1YXBpIHdpbGwgcHJvYmFibHkgaGF2ZSB0byBjaGFuZ2UgZm9yIGF0IGxlYXN0IHMzOTB4Lg0K
Pj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBXaGF0IHRvIGRvIGFib3V0IGV4aXN0aW5nIHNjcmlwdHMgaXMg
YSBkaWZmZXJlbnQgcXVlc3Rpb24uDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBUaGlzIGxhY2sgb2YgbG9n
aWNhbCBzZXBhcmF0aW9uIGJldHdlZW4gdXNlciBhbmQga2VybmVsIGFkZHJlc3Nlcw0KPj4+Pj4+
PiBtaWdodCBpbnRlcmFjdCBpbnRlcmVzdGluZ2x5IHdpdGggdGhlIHRleHRfcG9rZSBzZXJpZXMs
IHNwZWNpZmljYWxseQ0KPj4+Pj4+PiAiW1BBVENIIHYzIDA1LzIwXSB4ODYvYWx0ZXJuYXRpdmU6
IEluaXRpYWxpemUgdGVtcG9yYXJ5IG1tIGZvcg0KPj4+Pj4+PiBwYXRjaGluZyIgKGh0dHBzOi8v
bmEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJG
bG9yZS5rZXJuZWwub3JnJTJGbGttbCUyRjIwMTkwMjIxMjM0NDUxLjE3NjMyLTYtcmljay5wLmVk
Z2Vjb21iZSU0MGludGVsLmNvbSUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDbmFtaXQlNDB2bXdhcmUu
Y29tJTdDYmFiNTNlNTJjYzVjNGFjNDQxOTAwOGQ2OTkyMWQxZjElN0NiMzkxMzhjYTNjZWU0YjRh
YTRkNmNkODNkOWRkNjJmMCU3QzAlN0MwJTdDNjM2ODY0NzY3ODc5NzMxOTQxJmFtcDtzZGF0YT0y
dHFEN3VkVENmTmJjTkxjajVTRnBadDhXd0s1Tnd0Z2FXTUttMVllMUVFJTNEJmFtcDtyZXNlcnZl
ZD0wKQ0KPj4+Pj4+PiBhbmQgIltQQVRDSCB2MyAwNi8yMF0geDg2L2FsdGVybmF0aXZlOiBVc2Ug
dGVtcG9yYXJ5IG1tIGZvciB0ZXh0DQo+Pj4+Pj4+IHBva2luZyIgKGh0dHBzOi8vbmEwMS5zYWZl
bGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbG9yZS5rZXJu
ZWwub3JnJTJGbGttbCUyRjIwMTkwMjIxMjM0NDUxLjE3NjMyLTctcmljay5wLmVkZ2Vjb21iZSU0
MGludGVsLmNvbSUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDbmFtaXQlNDB2bXdhcmUuY29tJTdDYmFi
NTNlNTJjYzVjNGFjNDQxOTAwOGQ2OTkyMWQxZjElN0NiMzkxMzhjYTNjZWU0YjRhYTRkNmNkODNk
OWRkNjJmMCU3QzAlN0MwJTdDNjM2ODY0NzY3ODc5NzMxOTQxJmFtcDtzZGF0YT03JTJCTFNoZ0xL
bnJhNnh6U2t4ZEpyQ2NsQ2FjZmRFNUlkY3p3U2NXODNudUUlM0QmYW1wO3Jlc2VydmVkPTApLA0K
Pj4+Pj4+PiByaWdodD8gSWYgc29tZW9uZSBtYW5hZ2VzIHRvIGdldCBhIHRyYWNpbmcgQlBGIHBy
b2dyYW0gdG8gdHJpZ2dlciBpbiBhDQo+Pj4+Pj4+IHRhc2sgdGhhdCBoYXMgc3dpdGNoZWQgdG8g
dGhlIHBhdGNoaW5nIG1tLCBjb3VsZCB0aGV5IHVzZQ0KPj4+Pj4+PiBicGZfcHJvYmVfd3JpdGVf
dXNlcigpIC0gd2hpY2ggdXNlcyBwcm9iZV9rZXJuZWxfd3JpdGUoKSBhZnRlcg0KPj4+Pj4+PiBj
aGVja2luZyB0aGF0IEtFUk5FTF9EUyBpc24ndCBhY3RpdmUgYW5kIHRoYXQgYWNjZXNzX29rKCkg
cGFzc2VzIC0gdG8NCj4+Pj4+Pj4gb3ZlcndyaXRlIGtlcm5lbCB0ZXh0IHRoYXQgaXMgbWFwcGVk
IHdyaXRhYmxlIGluIHRoZSBwYXRjaGluZyBtbT8NCj4+Pj4+PiANCj4+Pj4+PiBZZXMsIHRoaXMg
aXMgYSBnb29kIHBvaW50LiBJIGd1ZXNzIHRleHRfcG9rZSgpIHNob3VsZCBiZSBkZWZpbmVkIHdp
dGgNCj4+Pj4+PiDigJxfX2twcm9iZXPigJ0gYW5kIG9wZW4tY29kZSBtZW1jcHkuDQo+Pj4+Pj4g
DQo+Pj4+Pj4gRG9lcyBpdCBzb3VuZCByZWFzb25hYmxlPw0KPj4+Pj4gDQo+Pj4+PiBEb2Vzbid0
IF9fdGV4dF9wb2tlKCkgYXMgaW1wbGVtZW50ZWQgaW4gdGhlIHByb3Bvc2VkIHBhdGNoIHVzZSBh
DQo+Pj4+PiBjb3VwbGUgb3RoZXIga2VybmVsIGZ1bmN0aW9ucywgdG9vPyBMaWtlIHN3aXRjaF9t
bV9pcnFzX29mZigpIGFuZA0KPj4+Pj4gcHRlX2NsZWFyKCkgKHdoaWNoIGNhbiBiZSBhIGNhbGwg
aW50byBhIHNlcGFyYXRlIGZ1bmN0aW9uIG9uIHBhcmF2aXJ0DQo+Pj4+PiBrZXJuZWxzKT8NCj4+
Pj4gDQo+Pj4+IEkgd2lsbCBtb3ZlIHRoZSBwdGVfY2xlYXIoKSB0byBiZSBkb25lIGFmdGVyIHRo
ZSBwb2tpbmcgbW0gd2FzIHVubG9hZGVkLg0KPj4+PiBHaXZlIG1lIGEgZmV3IG1pbnV0ZXMgdG8g
c2VuZCBhIHNrZXRjaCBvZiB3aGF0IEkgdGhpbmsgc2hvdWxkIGJlIGRvbmUuDQo+Pj4gDQo+Pj4g
RXJyLi4gWW91IGFyZSByaWdodCwgSSBkb27igJl0IHNlZSBhbiBlYXN5IHdheSBvZiBwcmV2ZW50
aW5nIGEga3Byb2JlIGZyb20NCj4+PiBiZWluZyBzZXQgb24gc3dpdGNoX21tX2lycXNfb2ZmKCks
IGFuZCBvcGVuLWNvZGluZyB0aGlzIG1vbnN0ZXIgaXMgdG9vIHVnbHkuDQo+Pj4gDQo+Pj4gVGhl
IHJlYXNvbmFibGUgc29sdXRpb24gc2VlbXMgdG8gbWUgYXMgdGFraW5nIGFsbCB0aGUgcmVsZXZh
bnQgcGllY2VzIG9mDQo+Pj4gY29kZSAoYW5kIGRhdGEpIHRoYXQgbWlnaHQgYmUgdXNlZCBkdXJp
bmcgdGV4dC1wb2tpbmcgYW5kIGVuY2Fwc3VsYXRpbmcgdGhlbSwgc28gdGhleQ0KPj4+IHdpbGwg
YmUgc2V0IGluIGEgbWVtb3J5IGFyZWEgd2hpY2ggY2Fubm90IGJlIGtwcm9iZSdkLiBUaGlzIGNh
biBhbHNvIGJlDQo+Pj4gdXNlZnVsIHRvIHdyaXRlLXByb3RlY3QgZGF0YSBzdHJ1Y3R1cmVzIG9m
IGNvZGUgdGhhdCBjYWxscyB0ZXh0X3Bva2UoKSwNCj4+PiBlLmcuLCBzdGF0aWMta2V5cy4gSXQg
Y2FuIGFsc28gcHJvdGVjdCBkYXRhIG9uIHRoYXQgc3RhY2sgdGhhdCBpcyB1c2VkDQo+Pj4gZHVy
aW5nIHRleHRfcG9rZSgpIGZyb20gYmVpbmcgb3ZlcndyaXR0ZW4gZnJvbSBhbm90aGVyIGNvcmUu
DQo+Pj4gDQo+Pj4gVGhpcyBzb2x1dGlvbiBpcyBzb21ld2hhdCBzaW1pbGFyIHRvIElnb3IgU3Rv
cHBh4oCZcyBpZGVhIG9mIHVzaW5nIOKAnGVuY2xhdmVz4oCdDQo+Pj4gd2hlbiBkb2luZyB3cml0
ZS1yYXJlbHkgb3BlcmF0aW9ucy4NCj4+PiANCj4+PiBSaWdodCBub3csIEkgdGhpbmsgdGhhdCB0
ZXh0X3Bva2UoKSB3aWxsIGtlZXAgYmVpbmcgc3VzY2VwdGlibGUgdG8gc3VjaA0KPj4+IGFuIGF0
dGFjaywgdW5sZXNzIHlvdSBoYXZlIGEgYmV0dGVyIHN1Z2dlc3Rpb24uDQo+PiANCj4+IEEgcmVs
YXRpdmVseSBzaW1wbGUgYXBwcm9hY2ggbWlnaHQgYmUgdG8gdGVhY2ggQlBGIG5vdCB0byBydW4g
a3Byb2JlDQo+PiBwcm9ncmFtcyBhbmQgc3VjaCBpbiBjb250ZXh0cyB3aGVyZSBjdXJyZW50LT5t
bSBpc24ndCB0aGUgYWN0aXZlIG1tPw0KPj4gTWF5YmUgdXNpbmcgbm1pX3VhY2Nlc3Nfb2theSgp
LCBvciBzb21ldGhpbmcgbGlrZSB0aGF0PyBJdCBsb29rcyBsaWtlDQo+PiBwZXJmX2NhbGxjaGFp
bl91c2VyKCkgYWxzbyBhbHJlYWR5IHVzZXMgdGhhdC4gRXhjZXB0IHRoYXQgYSBsb3Qgb2YNCj4+
IHRoaXMgY29kZSBpcyB4ODYtc3BlY2lmaWMuLi4NCj4gDQo+IFRoaXMgc291bmRzIGxpa2UgZXhh
Y3RseSB0aGUgcmlnaHQgc29sdXRpb24uICBJZiB5b3UncmUgcnVubmluZyBmcm9tDQo+IHNvbWUg
dW5rbm93biBjb250ZXh0IChsaWtlIE5NSSBvciB0cmFjaW5nKSwgdGhlbiB5b3Ugc2hvdWxkIGNo
ZWNrDQo+IG5taV91YWNjZXNzX29rYXkoKS4gIEkgdGhpbmsgd2Ugc2hvdWxkIGp1c3QgcHJvbW90
ZSB0aGF0IHRvIGJlIGENCj4gbm9uLWFyY2gtc3BlY2lmaWMgZnVuY3Rpb24gKHRoYXQgcmV0dXJu
cyB0cnVlIGJ5IGRlZmF1bHQpIGFuZCBjaGVjayBpdA0KPiB0aGUgcmVsZXZhbnQgYnBmX3Byb2Jl
X3h5eigpIGZ1bmN0aW9ucy4NCg0KSSBjYW4gZG8gdGhhdCwgYnV0IG5vdGljZSB0aGF0IHN3aXRj
aF9tbV9pcnFzX29mZigpIHdyaXRlcyB0bw0KY3B1X3RsYnN0YXRlLmxvYWRlZF9tbSBiZWZvcmUg
aXQgYWN0dWFsbHkgd3JpdGVzIHRvIENSMy4gU28gdGhlcmUgYXJlIHN0aWxsDQphIGNvdXBsZSBv
ZiBpbnN0cnVjdGlvbnMgKGFuZCB0aGUgbG9hZF9uZXdfbW1fY3IzKCkpIGluIGJldHdlZW4gdGhh
dCBhDQprcHJvYmUgY2FuIGJlIHNldCBvbiwgbm8/DQoNCkkgY2FuIG1hcmsgdGhlbSBhcyBub24t
a3Byb2JhYmxlLg0KDQo=
