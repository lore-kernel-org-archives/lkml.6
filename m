Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AFFC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B702075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="FqfJi/GR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfBVWIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:08:24 -0500
Received: from mail-eopbgr790050.outbound.protection.outlook.com ([40.107.79.50]:46956
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726504AbfBVWIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkuPZAfX/eWo2TcuX3VenqOetaqYxlhgFGzuWek9kXQ=;
 b=FqfJi/GRUTsGI3JD0TFef+WcHlbbvb0jZPKKM2jpcDn6j7/e+gEheca4wIIIj5rH2ATj2+WDb0DfzDo516BHOiDOHsSgFdr5QhqYaUOm1Fu3a8q135sQGu4P8EqkY7RpPnJRKJaI2MFtmuWviLDN5Dfeb2GZQawSOR81e8bECiQ=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6405.namprd05.prod.outlook.com (20.178.51.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.11; Fri, 22 Feb 2019 22:08:14 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::6cf6:1336:9f92:b1b5]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::6cf6:1336:9f92:b1b5%4]) with mapi id 15.20.1665.008; Fri, 22 Feb 2019
 22:08:14 +0000
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
Thread-Index: AQHUyvfM0aln3zH+GEuLAnG94DvLR6XsYEWA
Date:   Fri, 22 Feb 2019 22:08:14 +0000
Message-ID: <0ED6836E-3432-4E1C-BABC-BEA6BDD36287@vmware.com>
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
In-Reply-To: <CAG48ez2tVwzhKPu1tvK+E52jUCq5vTwjssrtMaGuCO=kMpSXGw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bf09b4b-6300-4f69-40bf-08d699123dd1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB6405;
x-ms-traffictypediagnostic: BYAPR05MB6405:
x-ms-exchange-purlcount: 2
x-microsoft-exchange-diagnostics: 1;BYAPR05MB6405;20:DBdfH8Xb3eXk4ryoy4TUVVhvLTzNJDf6hPCTEz6JxebqdpJD9GgwJeTAkhbkiKxT1AaA9wpmlupNlRZBSh+fTGVIMBJ7NFoxTTEt4A7t6dew2/x1rOC0xoEKksJM48zJFLonigSyEfctTa66MCOkeNGkTPDvxdtggQ2pX73+zDA=
x-microsoft-antispam-prvs: <BYAPR05MB64057328D1D3E4A6AAA202BCD07F0@BYAPR05MB6405.namprd05.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(366004)(376002)(346002)(199004)(189003)(106356001)(97736004)(186003)(478600001)(5660300002)(53936002)(99286004)(66066001)(486006)(36756003)(305945005)(6306002)(45080400002)(82746002)(6512007)(3846002)(8676002)(2906002)(26005)(25786009)(6116002)(14454004)(105586002)(33656002)(4326008)(476003)(2616005)(446003)(11346002)(86362001)(8936002)(81166006)(6246003)(102836004)(7736002)(14444005)(83716004)(76176011)(93886005)(68736007)(54906003)(6436002)(316002)(71200400001)(256004)(229853002)(81156014)(6916009)(71190400001)(53546011)(6506007)(7416002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6405;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FK+31JyjSTd4j7M7EmhhThOp8JypcAlmSBeU7uySQO9GySHbgejzbSSUiZeswyGBcGz6zuidjNy8f9DXmdVAM7YGmeIqskN5FdeHwsX9//cF0YKQzZRsDN45iCBjmfMcOVgnkab3CTHCMazwWnS4uyR4WE1HueHLIuIL4kGajFoypWxPXpd2o6ead+Hd5sVsdg2wzJ1QpNrTf6j+BBNvOOH0epD3ASTseb0QWiPzTwU3fVe6c6pM9/7484xOsr0XhhizvjvxJbwcrHsspxvFA0SxL6gpbfaRDPYB97Ae0I8+EUXvCXpi1Usn/w2zNdMcwfIteuXNdHIjBLTjtMu68jgT1I6XKiWI4JYp6e+xtM43Aw8mWs5aeent2Gy0FJ2owEB4pPcEwC4o6XAaFeJakCf1FoQUXM6tMsRCMd2Dkl8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9B577DD26656740A8C6DA4530E198AD@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf09b4b-6300-4f69-40bf-08d699123dd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 22:08:14.1456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6405
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBGZWIgMjIsIDIwMTksIGF0IDE6NDMgUE0sIEphbm4gSG9ybiA8amFubmhAZ29vZ2xlLmNv
bT4gd3JvdGU6DQo+IA0KPiAoYWRkaW5nIHNvbWUgcGVvcGxlIGZyb20gdGhlIHRleHRfcG9rZSBz
ZXJpZXMgdG8gdGhlIHRocmVhZCwgcmVtb3Zpbmcgc3RhYmxlQCkNCj4gDQo+IE9uIEZyaSwgRmVi
IDIyLCAyMDE5IGF0IDg6NTUgUE0gQW5keSBMdXRvbWlyc2tpIDxsdXRvQGFtYWNhcGl0YWwubmV0
PiB3cm90ZToNCj4+PiBPbiBGZWIgMjIsIDIwMTksIGF0IDExOjM0IEFNLCBBbGV4ZWkgU3Rhcm92
b2l0b3YgPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOg0KPj4+PiBPbiBGcmks
IEZlYiAyMiwgMjAxOSBhdCAwMjozMDoyNlBNIC0wNTAwLCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToN
Cj4+Pj4gT24gRnJpLCAyMiBGZWIgMjAxOSAxMToyNzowNSAtMDgwMA0KPj4+PiBBbGV4ZWkgU3Rh
cm92b2l0b3YgPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOg0KPj4+PiANCj4+
Pj4+PiBPbiBGcmksIEZlYiAyMiwgMjAxOSBhdCAwOTo0MzoxNEFNIC0wODAwLCBMaW51cyBUb3J2
YWxkcyB3cm90ZToNCj4+Pj4+PiANCj4+Pj4+PiBUaGVuIHdlIHNob3VsZCBzdGlsbCBwcm9iYWJs
eSBmaXggdXAgIl9fcHJvYmVfa2VybmVsX3JlYWQoKSIgdG8gbm90DQo+Pj4+Pj4gYWxsb3cgdXNl
ciBhY2Nlc3Nlcy4gVGhlIGVhc2llc3Qgd2F5IHRvIGRvIHRoYXQgaXMgYWN0dWFsbHkgbGlrZWx5
IHRvDQo+Pj4+Pj4gdXNlIHRoZSAidW5zYWZlX2dldF91c2VyKCkiIGZ1bmN0aW9ucyAqd2l0aG91
dCogZG9pbmcgYQ0KPj4+Pj4+IHVhY2Nlc3NfYmVnaW4oKSwgd2hpY2ggd2lsbCBtZWFuIHRoYXQg
bW9kZXJuIENQVSdzIHdpbGwgc2ltcGx5IGZhdWx0DQo+Pj4+Pj4gb24gYSBrZXJuZWwgYWNjZXNz
IHRvIHVzZXIgc3BhY2UuDQo+Pj4+PiANCj4+Pj4+IE9uIGJwZiBzaWRlIHRoZSBicGZfcHJvYmVf
cmVhZCgpIGhlbHBlciBqdXN0IGNhbGxzIHByb2JlX2tlcm5lbF9yZWFkKCkNCj4+Pj4+IGFuZCB1
c2VycyBwYXNzIGJvdGggdXNlciBhbmQga2VybmVsIGFkZHJlc3NlcyBpbnRvIGl0IGFuZCBleHBl
Y3QNCj4+Pj4+IHRoYXQgdGhlIGhlbHBlciB3aWxsIGFjdHVhbGx5IHRyeSB0byByZWFkIGZyb20g
dGhhdCBhZGRyZXNzLg0KPj4+Pj4gDQo+Pj4+PiBJZiBfX3Byb2JlX2tlcm5lbF9yZWFkIHdpbGwg
c3VkZGVubHkgc3RhcnQgZmFpbGluZyBvbiBhbGwgdXNlciBhZGRyZXNzZXMNCj4+Pj4+IGl0IHdp
bGwgYnJlYWsgdGhlIGV4cGVjdGF0aW9ucy4NCj4+Pj4+IEhvdyBkbyB3ZSBzb2x2ZSBpdCBpbiBi
cGZfcHJvYmVfcmVhZD8NCj4+Pj4+IENhbGwgcHJvYmVfa2VybmVsX3JlYWQgYW5kIGlmIHRoYXQg
ZmFpbHMgY2FsbCB1bnNhZmVfZ2V0X3VzZXIgYnl0ZS1ieS1ieXRlDQo+Pj4+PiBpbiB0aGUgbG9v
cD8NCj4+Pj4+IFRoYXQncyBkb2FibGUsIGJ1dCBwZW9wbGUgYWxyZWFkeSBjb21wbGFpbiB0aGF0
IGJwZl9wcm9iZV9yZWFkKCkgaXMgc2xvdw0KPj4+Pj4gYW5kIHNob3dzIHVwIGluIHRoZWlyIHBl
cmYgcmVwb3J0Lg0KPj4+PiANCj4+Pj4gV2UncmUgY2hhbmdpbmcga3Byb2JlcyB0byBhZGQgYSBz
cGVjaWZpYyBmbGFnIHRvIHNheSB0aGF0IHdlIHdhbnQgdG8NCj4+Pj4gZGlmZmVyZW50aWF0ZSBi
ZXR3ZWVuIGtlcm5lbCBvciB1c2VyIHJlYWRzLiBDYW4gdGhpcyBiZSBkb25lIHdpdGgNCj4+Pj4g
YnBmX3Byb2JlX3JlYWQoKT8gSWYgaXQncyBzaG93aW5nIHVwIGluIHBlcmYgcmVwb3J0LCBJIGRv
dWJ0IGEgc2luZ2xlDQo+Pj4gDQo+Pj4gc28geW91J3JlIHNheWluZyB5b3Ugd2lsbCBicmVhayBl
eGlzdGluZyBrcHJvYmUgc2NyaXB0cz8NCj4+PiBJIGRvbid0IHRoaW5rIGl0J3MgYSBnb29kIGlk
ZWEuDQo+Pj4gSXQncyBub3QgYWNjZXB0YWJsZSB0byBicmVhayBicGZfcHJvYmVfcmVhZCB1YXBp
Lg0KPj4gDQo+PiBJZiBzbywgdGhlIHVhcGkgaXMgd3Jvbmc6IGEgbG9uZy1zaXplZCBudW1iZXIg
ZG9lcyBub3QgcmVsaWFibHkgaWRlbnRpZnkgYW4gYWRkcmVzcyBpZiB5b3UgZG9u4oCZdCBzZXBh
cmF0ZWx5IGtub3cgd2hldGhlciBpdOKAmXMgYSB1c2VyIG9yIGtlcm5lbCBhZGRyZXNzLiBzMzkw
eCBhbmQgNEc6NEcgeDg2XzMyIGFyZSB0aGUgbm90YWJsZSBleGNlcHRpb25zLiBJIGhhdmUgbG9i
YmllZCBmb3IgUklTQy1WIGFuZCBmdXR1cmUgeDg2XzY0IHRvIGpvaW4gdGhlIGNyb3dkLiAgSSBk
b27igJl0IGtub3cgd2hldGhlciBJ4oCZbGwgd2luIHRoaXMgZmlnaHQsIGJ1dCB0aGUgdWFwaSB3
aWxsIHByb2JhYmx5IGhhdmUgdG8gY2hhbmdlIGZvciBhdCBsZWFzdCBzMzkweC4NCj4+IA0KPj4g
V2hhdCB0byBkbyBhYm91dCBleGlzdGluZyBzY3JpcHRzIGlzIGEgZGlmZmVyZW50IHF1ZXN0aW9u
Lg0KPiANCj4gVGhpcyBsYWNrIG9mIGxvZ2ljYWwgc2VwYXJhdGlvbiBiZXR3ZWVuIHVzZXIgYW5k
IGtlcm5lbCBhZGRyZXNzZXMNCj4gbWlnaHQgaW50ZXJhY3QgaW50ZXJlc3RpbmdseSB3aXRoIHRo
ZSB0ZXh0X3Bva2Ugc2VyaWVzLCBzcGVjaWZpY2FsbHkNCj4gIltQQVRDSCB2MyAwNS8yMF0geDg2
L2FsdGVybmF0aXZlOiBJbml0aWFsaXplIHRlbXBvcmFyeSBtbSBmb3INCj4gcGF0Y2hpbmciICho
dHRwczovL25hMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUz
QSUyRiUyRmxvcmUua2VybmVsLm9yZyUyRmxrbWwlMkYyMDE5MDIyMTIzNDQ1MS4xNzYzMi02LXJp
Y2sucC5lZGdlY29tYmUlNDBpbnRlbC5jb20lMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q25hbWl0JTQw
dm13YXJlLmNvbSU3Q2Q0NGQ2ZjA3NjVkZDQ5YjIwZGI3MDhkNjk5MGVlN2U4JTdDYjM5MTM4Y2Ez
Y2VlNGI0YWE0ZDZjZDgzZDlkZDYyZjAlN0MwJTdDMCU3QzYzNjg2NDY4NjcxNzE0Mjg5MiZhbXA7
c2RhdGE9Z1ZBTGRrRVVMRWhqNGlKTkVXQUd4eVlXZTJseG5IUmRhbVc1WkEyQTVSUSUzRCZhbXA7
cmVzZXJ2ZWQ9MCkNCj4gYW5kICJbUEFUQ0ggdjMgMDYvMjBdIHg4Ni9hbHRlcm5hdGl2ZTogVXNl
IHRlbXBvcmFyeSBtbSBmb3IgdGV4dA0KPiBwb2tpbmciIChodHRwczovL25hMDEuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvcmUua2VybmVsLm9y
ZyUyRmxrbWwlMkYyMDE5MDIyMTIzNDQ1MS4xNzYzMi03LXJpY2sucC5lZGdlY29tYmUlNDBpbnRl
bC5jb20lMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q25hbWl0JTQwdm13YXJlLmNvbSU3Q2Q0NGQ2ZjA3
NjVkZDQ5YjIwZGI3MDhkNjk5MGVlN2U4JTdDYjM5MTM4Y2EzY2VlNGI0YWE0ZDZjZDgzZDlkZDYy
ZjAlN0MwJTdDMCU3QzYzNjg2NDY4NjcxNzE0Mjg5MiZhbXA7c2RhdGE9bnUySjFGdEpzWkptdDUz
U0tKejhDOGt0V0U5ZXljd2RBQSUyQmlDaTFUZkNjJTNEJmFtcDtyZXNlcnZlZD0wKSwNCj4gcmln
aHQ/IElmIHNvbWVvbmUgbWFuYWdlcyB0byBnZXQgYSB0cmFjaW5nIEJQRiBwcm9ncmFtIHRvIHRy
aWdnZXIgaW4gYQ0KPiB0YXNrIHRoYXQgaGFzIHN3aXRjaGVkIHRvIHRoZSBwYXRjaGluZyBtbSwg
Y291bGQgdGhleSB1c2UNCj4gYnBmX3Byb2JlX3dyaXRlX3VzZXIoKSAtIHdoaWNoIHVzZXMgcHJv
YmVfa2VybmVsX3dyaXRlKCkgYWZ0ZXINCj4gY2hlY2tpbmcgdGhhdCBLRVJORUxfRFMgaXNuJ3Qg
YWN0aXZlIGFuZCB0aGF0IGFjY2Vzc19vaygpIHBhc3NlcyAtIHRvDQo+IG92ZXJ3cml0ZSBrZXJu
ZWwgdGV4dCB0aGF0IGlzIG1hcHBlZCB3cml0YWJsZSBpbiB0aGUgcGF0Y2hpbmcgbW0/DQoNClll
cywgdGhpcyBpcyBhIGdvb2QgcG9pbnQuIEkgZ3Vlc3MgdGV4dF9wb2tlKCkgc2hvdWxkIGJlIGRl
ZmluZWQgd2l0aA0K4oCcX19rcHJvYmVz4oCdIGFuZCBvcGVuLWNvZGUgbWVtY3B5Lg0KDQpEb2Vz
IGl0IHNvdW5kIHJlYXNvbmFibGU/DQoNCg==
