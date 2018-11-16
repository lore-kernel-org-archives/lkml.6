Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C739C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0CE2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="Al69Sj+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0CE2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeKQHPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 02:15:50 -0500
Received: from mail-eopbgr770087.outbound.protection.outlook.com ([40.107.77.87]:35232
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbeKQHPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 02:15:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wx8dwSoP+ROiLN0tVr8pkoRBfvBPH+tjIwV2OdjO5g=;
 b=Al69Sj+aUqpDxH2pigXRAwDNUAbtVmGLp46ZmRKgs+kgXIGpmCNIlPXX+3lMJpio/1HdnUbesMumCLi3d+l+/ZHhZe+MD6BLukMaItaMr233XjwUox4fPAoydw7y0Y6ij+8cOTL2QWlL5hpdP+C8I0ftEjji6pQu/9LZVR9y3+k=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4248.namprd05.prod.outlook.com (20.176.252.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.7; Fri, 16 Nov 2018 21:01:34 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1339.023; Fri, 16 Nov 2018
 21:01:34 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     Ingo Molnar <mingo@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] Makefile: Fix distcc compilation with x86 macros
Thread-Topic: [PATCH v2 1/2] Makefile: Fix distcc compilation with x86 macros
Thread-Index: AQHUfJfvmtKbIIZ6B0mJO/gQ5HjNB6VSB5OAgADeVwA=
Date:   Fri, 16 Nov 2018 21:01:34 +0000
Message-ID: <1C316B94-8F27-439C-B049-9947DC329780@vmware.com>
References: <20181114204309.18645-1-namit@vmware.com>
 <20181114204309.18645-2-namit@vmware.com>
 <CAK7LNAREF_Pcejq1LJ=3K7h0M4o4oSRLfbeJc73O+8HV420Ziw@mail.gmail.com>
In-Reply-To: <CAK7LNAREF_Pcejq1LJ=3K7h0M4o4oSRLfbeJc73O+8HV420Ziw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4248;20:KxzXJKK+aQHRSk7uzjV6rIe1ydxrepMW7tP9UMfad9QhRjatuHcZqwsHAsYKXebwFt910IPSAVWLkZA1tlbHDaKUdu/nK/bjkg1+8CRPWaRqFvFoxUPA8vbXu8r3ms6Gqsob+y31qkezsKscbPrDAgETEhkkkSm16/ArIFt6oRE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 973f1afb-9ca8-4510-655b-08d64c06b165
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4248;
x-ms-traffictypediagnostic: BYAPR05MB4248:
x-microsoft-antispam-prvs: <BYAPR05MB42486165F0D7155CBED6A155D0DD0@BYAPR05MB4248.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231415)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4248;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4248;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(366004)(199004)(189003)(6246003)(99286004)(2900100001)(2616005)(229853002)(6116002)(86362001)(6512007)(6486002)(71200400001)(71190400001)(3846002)(2906002)(83716004)(486006)(26005)(476003)(305945005)(82746002)(106356001)(6436002)(66066001)(105586002)(6506007)(478600001)(53546011)(446003)(8936002)(8676002)(6916009)(81166006)(81156014)(316002)(33656002)(14454004)(53936002)(76176011)(186003)(5660300001)(36756003)(7736002)(256004)(54906003)(97736004)(11346002)(68736007)(25786009)(4326008)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4248;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tTv6Ktckxj+lc8pO6mZlu+E9vQbCF/lSF46Pt9z9YCLTffb8lukacdT4TjXNyAx5TqtyTKrbAdzAhiybsXM8XaTgJVKxZDRPhAvGXNQ/jV2bEKaABwp6OtR2fK0Q71NEedQgpZvYsAlTpmCnVdil5QYPQsGoFvIMZOrPt5vCXxKtCuxoYnERI77hErMPF89EUFPkQp7uPaZtoYOhncFdivCOmdrXXhU1q0Ztz3B9jbi+c+ewEBz70p+W1luyJw+dPnsg9YetILQvY+GLdQzgXMyLcIQpl4iMrEp8SBco8RwEf5i1gojyR7kTUNXg4v8IabkAnfqx5f9+AiZUjfJ7JIkE7NSfEFMAAXoIWPh6QSU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A20752D87B6F749848D09EE097DD717@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973f1afb-9ca8-4510-655b-08d64c06b165
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 21:01:34.7355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4248
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFzYWhpcm8gWWFtYWRhDQpTZW50OiBOb3ZlbWJlciAxNiwgMjAxOCBhdCA3OjQ1OjQ1
IEFNIEdNVA0KPiBUbzogTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4NCj4gQ2M6IEluZ28g
TW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPiwgTWljaGFsIE1hcmVrIDxtaWNoYWwubGttbEBtYXJr
b3ZpLm5ldD4sIFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPiwgQm9yaXNsYXYg
UGV0a292IDxicEBhbGllbjguZGU+LCBILiBQZXRlciBBbnZpbiA8aHBhQHp5dG9yLmNvbT4sIFg4
NiBNTCA8eDg2QGtlcm5lbC5vcmc+LCBMaW51eCBLYnVpbGQgbWFpbGluZyBsaXN0IDxsaW51eC1r
YnVpbGRAdmdlci5rZXJuZWwub3JnPiwgTGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzJdIE1h
a2VmaWxlOiBGaXggZGlzdGNjIGNvbXBpbGF0aW9uIHdpdGggeDg2IG1hY3Jvcw0KPiANCj4gDQo+
IE9uIFRodSwgTm92IDE1LCAyMDE4IGF0IDE6MDEgUE0gTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJl
LmNvbT4gd3JvdGU6DQo+PiBJbnRyb2R1Y2luZyB0aGUgdXNlIG9mIGFzbSBtYWNyb3MgaW4gYy1j
b2RlIGJyb2tlIGRpc3RjYywgc2luY2UgaXQgb25seQ0KPj4gc2VuZHMgdGhlIHByZXByb2Nlc3Nl
ZCBzb3VyY2UgZmlsZS4gVGhlIHNvbHV0aW9uIGlzIHRvIGJyZWFrIHRoZQ0KPj4gY29tcGlsYXRp
b24gaW50byB0d28gc2VwYXJhdGUgcGhhc2VzIG9mIGNvbXBpbGF0aW9uIGFuZCBhc3NlbWJseSwg
YW5kDQo+PiBiZXR3ZWVuIHRoZSB0d28gY29uY2F0ZW5hdGUgdGhlIGFzc2VtYmx5IG1hY3JvcyBh
bmQgdGhlIGNvbXBpbGVkICh5ZXQNCj4+IG5vdCBhc3NlbWJsZWQpIHNvdXJjZSBmaWxlLiBTaW5j
ZSB0aGlzIGlzIGxlc3MgZWZmaWNpZW50LCB0aGlzDQo+PiBjb21waWxhdGlvbiBtb2RlIGlzIG9u
bHkgdXNlZCB3aGVuIGRpc3RjYyBvciBpY2VjYyBhcmUgdXNlZC4NCj4+IA0KPj4gTm90ZSB0aGF0
IHRoZSBhc3NlbWJseSBzdGFnZSBzaG91bGQgYWxzbyBiZSBkaXN0cmlidXRlZCwgaWYgZGlzdGNj
IGlzDQo+PiBjb25maWd1cmVkIHVzaW5nICJDRkxBR1M9LURFTkFCTEVfUkVNT1RFX0FTU0VNQkxF
Ii4NCj4+IA0KPj4gUmVwb3J0ZWQtYnk6IExvZ2FuIEd1bnRob3JwZSA8bG9nYW5nQGRlbHRhdGVl
LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+DQo+
IA0KPiANCj4gV293LCB0aGlzIGlzIHNvIHVnbHkuDQoNCkluZGVlZCwgaXQgaXMgbm90IHByZXR0
eSBmcm9tIHRoZSBNYWtlZmlsZSBzeXN0ZW0gcG9pbnQgb2Ygdmlldy4NCg0KQnV0IGl0IGRvZXMg
aGF2ZSBtZXJpdHMgd2hlbiBpdCBjb21lcyB0byB0aGUgYWN0dWFsIHVzZSAoYnkgZGV2ZWxvcGVy
cykuIElmDQp5b3UgbG9vayBvbiB4ODYsIHRoZXJlIGFyZSBhIGxvdCBvZiBkdXBsaWNhdGVkIGlt
cGxlbWVudGF0aW9uIGZvciBDIGFuZCBBc20NCmFuZCBjcmF6eSBDIG1hY3JvcywgZm9yIGV4YW1w
bGUgZm9yIFBWIGZ1bmN0aW9uIGNhbGwgb3IgdGhlIGFsdGVybmF0aXZlDQptZWNoYW5pc20uIFRo
ZSBjb2RlIGlzIGFsc28gbGVzcyByZWFkYWJsZSBpbiBpdHMgY3VycmVudCBmb3JtLg0KDQo+IEkg
cmVhbGl6ZWQgaG93IG11Y2ggSSBoYXRlZCB0aGlzIGJ5IG5vdy4NCj4gDQo+IE15IHF1ZXN0aW9u
IGlzLCBob3cgbG9uZyBkbyB3ZSBuZWVkIHRvIGNhcnJ5IHRoaXM/DQoNCklmIGl0IGlzIHB1cmVs
eSBhYm91dCBwZXJmb3JtYW5jZSwgSSBhbSBub3Qgc3VyZSBpdCB3b3VsZCBtYWtlIHNlbnNlIHRv
DQpwdXQgaXQgaW4sIGFzIGl0IHdpbGwgaW5kZWVkIGJlIChldmVudHVhbGx5KSBzb2x2ZWQgYnkg
dGhlIGNvbXBpbGVyLCBhbmQNCnRoZSBwZW5hbHR5IGlzIG5vdCB0b28gZ3JlYXQuDQoNClRoZXJl
IGlzIGFsc28gYW4gYWR2YW50YWdlIGZvciBoYXZpbmcgYXNzZW1ibHkgbWFjcm9zIHRoYXQgY2Fu
IG92ZXJyaWRlIHRoZQ0KZ2VuZXJhdGVkIGFzc2VtYmx5IHRoYXQgd2FzIGdlbmVyYXRlZCBieSB0
aGUgY29tcGlsZXIuIEkgdGhpbmsgSFBBIChjY+KAmWQpDQpsb29rcyBpbiB0aGlzIGRpcmVjdGlv
biAoYW5kIHNvIGRvIEkpLg0KDQpSZWdhcmRzLA0KTmFkYXY=
