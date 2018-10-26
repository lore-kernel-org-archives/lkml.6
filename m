Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D930BC46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648BB20824
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="MiM6N73N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648BB20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbeJZJeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 05:34:37 -0400
Received: from mail-eopbgr710078.outbound.protection.outlook.com ([40.107.71.78]:61248
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725817AbeJZJeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 05:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXpjPKqIylArw23Mjrf/g0lhMzbovkdo5RfdREC/m44=;
 b=MiM6N73NGxfRvm92pKae/SVqd6QClH6UEpRi37LgU6BuwpVbSDdEfglfIffCRSSKhG4Tf0qzWZ4rcVCS0wESDEvUBG6MZVaRlTrTvmXmeCq1aGC+kp/MMPKLngEd6Db+wQOKULXL7lzXMBKQUypzxrgu//bxDBQAh7lqAGDZ4Ok=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5512.namprd05.prod.outlook.com (20.177.186.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.9; Fri, 26 Oct 2018 00:59:40 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%5]) with mapi id 15.20.1273.021; Fri, 26 Oct 2018
 00:59:40 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
CC:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v3 07/12] x86/fsgsbase/64: Introduce the new FIND_PERCPU_BASE
 macro
Thread-Topic: [v3 07/12] x86/fsgsbase/64: Introduce the new FIND_PERCPU_BASE
 macro
Thread-Index: AQHUbMJqluL2/w6O1EK+yTpxEl7bf6UwtNEA
Date:   Fri, 26 Oct 2018 00:59:40 +0000
Message-ID: <DFC98A15-9C61-4087-8F49-C9950A2D28F9@vmware.com>
References: <20181023184234.14025-1-chang.seok.bae@intel.com>
 <20181023184234.14025-8-chang.seok.bae@intel.com>
 <CALCETrV-fmLpwsa7tXZ8J+G5PQ6s0yhYVhY3jtE=FP9gAXc+QQ@mail.gmail.com>
In-Reply-To: <CALCETrV-fmLpwsa7tXZ8J+G5PQ6s0yhYVhY3jtE=FP9gAXc+QQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5512;20:Wd1cvvbg9cgqcwDwWPVPimO92b5HF5OapnBUZFQOWJOHSLpPHXDaSti21RfSAy7ivM44xIo2iYGncJTarA6izWIH2LJjQxNbozBzOEFOUXkGHZJw+O2QRebydnXTmjwcDu1tsEv1/Cqn4FhRx1nExdS6hce0beqjsYtESU2leXY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: be24e66e-9a25-4ba9-4208-08d63ade4f63
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5512;
x-ms-traffictypediagnostic: BYAPR05MB5512:
x-microsoft-antispam-prvs: <BYAPR05MB55124CDDA07CC79480C2ED72D0F00@BYAPR05MB5512.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(61668805478150)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5512;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5512;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(366004)(346002)(376002)(189003)(199004)(97736004)(36756003)(6116002)(5660300001)(105586002)(53936002)(476003)(2906002)(2616005)(106356001)(8936002)(6486002)(6512007)(25786009)(2900100001)(110136005)(68736007)(229853002)(71190400001)(186003)(11346002)(4326008)(71200400001)(3846002)(446003)(6246003)(486006)(83716004)(26005)(14454004)(316002)(8676002)(81156014)(66066001)(6436002)(86362001)(81166006)(76176011)(99286004)(7416002)(82746002)(5250100002)(6346003)(54906003)(7736002)(478600001)(6506007)(53546011)(14444005)(305945005)(102836004)(33656002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5512;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-message-info: n1yYnekdxBsBx0vsx6Oa1KQCLG1/M8JEB8OmFzR9VQ/7F3fYXGNpFUiVoVzweIaTqCOky+0kJMa0M8cmmu0c+jNKPyC8sLkUzT9I/UFTMz654RiWZ6DDHt0G4vTLcPG0rwNkQNDKBmuN8brLdOpE2xU2Iu52DFwsqGiKzquB2BMOq+Ds1q8CXyu7l0WlSXIBs2jXx37KgpTopOGFfSQ1NPFV7XFTwVviLFo8x8BMOK4z10MRqyXCqyuLtgWFLzhhp6D9PH39oiMMifXPpy/abN4L2IlIXYYkd+/vA32/hQkUPHwTdji2GGVr8N9rdORy48Tp+DHhIvs+WBhy6HxJQ8jMQn/jGTgKK7ptuu4Ug2w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A521514513D6447AE75C0DDCF2CF888@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be24e66e-9a25-4ba9-4208-08d63ade4f63
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 00:59:40.6418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5keSBMdXRvbWlyc2tpDQpTZW50OiBPY3RvYmVyIDI2LCAyMDE4IGF0IDEyOjI1OjE3
IEFNIEdNVA0KPiBUbzogQmFlLCBDaGFuZyBTZW9rIDxjaGFuZy5zZW9rLmJhZUBpbnRlbC5jb20+
LCBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPg0KPiBDYzogSW5nbyBNb2xuYXIgPG1pbmdv
QGtlcm5lbC5vcmc+LCBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4sIEFuZHJl
dyBMdXRvbWlyc2tpIDxsdXRvQGtlcm5lbC5vcmc+LCBILiBQZXRlciBBbnZpbiA8aHBhQHp5dG9y
LmNvbT4sIEFuZGkgS2xlZW4gPGFrQGxpbnV4LmludGVsLmNvbT4sIERhdmUgSGFuc2VuIDxkYXZl
LmhhbnNlbkBsaW51eC5pbnRlbC5jb20+LCBNZXR6Z2VyLCBNYXJrdXMgVCA8bWFya3VzLnQubWV0
emdlckBpbnRlbC5jb20+LCBSYXZpIFYuIFNoYW5rYXIgPHJhdmkudi5zaGFua2FyQGludGVsLmNv
bT4sIExLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBb
djMgMDcvMTJdIHg4Ni9mc2dzYmFzZS82NDogSW50cm9kdWNlIHRoZSBuZXcgRklORF9QRVJDUFVf
QkFTRSBtYWNybw0KPiANCj4gDQo+IE9uIFR1ZSwgT2N0IDIzLCAyMDE4IGF0IDExOjQzIEFNIENo
YW5nIFMuIEJhZSA8Y2hhbmcuc2Vvay5iYWVAaW50ZWwuY29tPiB3cm90ZToNCj4+IEdTQkFTRSBp
cyB1c2VkIHRvIGZpbmQgcGVyLUNQVSBkYXRhIGluIHRoZSBrZXJuZWwuIEJ1dCB3aGVuIGl0IGlz
IHVua25vd24sDQo+PiB0aGUgcGVyLUNQVSBiYXNlIGNhbiBiZSBmb3VuZCBmcm9tIHRoZSBwZXJf
Y3B1X29mZnNldCB0YWJsZSB3aXRoIGEgQ1BVIE5SLg0KPj4gVGhlIENQVSBOUiBpcyBleHRyYWN0
ZWQgZnJvbSB0aGUgbGltaXQgZmllbGQgb2YgdGhlIENQVU5PREUgZW50cnkgaW4gR0RULA0KPj4g
b3IgYnkgdGhlIFJEUElEIGluc3RydWN0aW9uLg0KPj4gDQo+PiBBbHNvLCBhZGQgdGhlIEdBUy1j
b21wYXRpYmxlIFJEUElEIG1hY3JvLg0KPj4gDQo+PiBUaGUgbmV3IG1hY3JvIHdpbGwgYmUgdXNl
ZCBvbiBhIGZvbGxvd2luZyBwYXRjaC4NCj4+IA0KPj4gU3VnZ2VzdGVkLWJ5OiBILiBQZXRlciBB
bnZpbiA8aHBhQHp5dG9yLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IENoYW5nIFMuIEJhZSA8Y2hh
bmcuc2Vvay5iYWVAaW50ZWwuY29tPg0KPj4gQ2M6IEFuZGkgS2xlZW4gPGFrQGxpbnV4LmludGVs
LmNvbT4NCj4+IENjOiBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4NCj4+IENjOiBE
YXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPg0KPj4gQ2M6IFRob21hcyBH
bGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KPj4gQ2M6IEluZ28gTW9sbmFyIDxtaW5nb0Br
ZXJuZWwub3JnPg0KPj4gLS0tDQo+PiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9mc2dzYmFzZS5oIHwg
NTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiBhcmNoL3g4Ni9pbmNsdWRl
L2FzbS9pbnN0LmggICAgIHwgMTUgKysrKysrKysrKw0KPj4gMiBmaWxlcyBjaGFuZ2VkLCA2NyBp
bnNlcnRpb25zKCspDQo+PiANCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9m
c2dzYmFzZS5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vZnNnc2Jhc2UuaA0KPj4gaW5kZXggZTUw
MGQ3NzExNTVmLi4wYzJkN2Q4YThjMDEgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9mc2dzYmFzZS5oDQo+PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9mc2dzYmFzZS5o
DQo+PiBAQCAtMTExLDYgKzExMSw1OCBAQCBleHRlcm4gdm9pZCB4ODZfZ3NiYXNlX3dyaXRlX2Nw
dV9pbmFjdGl2ZSh1bnNpZ25lZCBsb25nIGdzYmFzZSk7DQo+PiAgICAgICAgTU9EUk0gMHhkMCB3
cmdzYmFzZV9vcGQgMQ0KPj4gLmVuZG0NCj4+IA0KPj4gKyNpZiBDT05GSUdfU01QDQo+PiArDQo+
PiArLyoNCj4+ICsgKiBGZXRjaCB0aGUgcGVyLUNQVSBHU0JBU0UgdmFsdWUgZm9yIHRoaXMgcHJv
Y2Vzc29yIGFuZCBwdXQgaXQgaW4gQHJlZy4NCj4+ICsgKiBXZSBub3JtYWxseSB1c2UgJWdzIGZv
ciBhY2Nlc3NpbmcgcGVyLUNQVSBkYXRhLCBidXQgd2UgYXJlIHNldHRpbmcgdXANCj4+ICsgKiAl
Z3MgaGVyZSBhbmQgb2J2aW91c2x5IGNhbiBub3QgdXNlICVncyBpdHNlbGYgdG8gYWNjZXNzIHBl
ci1DUFUgZGF0YS4NCj4+ICsgKi8NCj4+ICsubWFjcm8gRklORF9QRVJDUFVfQkFTRV9SRFBJRCBy
ZWc6cmVxDQo+PiArICAgICAgIC8qDQo+PiArICAgICAgICAqIFRoZSBDUFUvbm9kZSBOUiBpcyBp
bml0aWFsaXplZCBlYXJsaWVyLCBkaXJlY3RseSBpbiBjcHVfaW5pdCgpLg0KPiBQDQo+PiArICAg
ICAgICAqLw0KPj4gKyAgICAgICBSRFBJRCAgIFxyZWcNCj4gDQo+IEkgd291bGQgc3VnZ2VzdCB0
aGF0IHlvdSBpbnN0ZWFkIGFkZCBhIG1hY3JvIExPQURfQ1BVX0FORF9OT0RFIFxyZWcNCj4gYW5k
IGhhdmUgdGhhdCBtYWNybyBjb250YWluIHRoZSBhbHRlcm5hdGl2ZS4gIEl0IGNhbiBzd2l0Y2gg
YmV0d2Vlbg0KPiBSRFBJRCBhbmQgTFNMLiAgVGhpcyB3YXkgeW91IGF2b2lkIGR1cGxpY2F0aW5n
IHRoZSByZXN0IG9mIGl0Lg0KPiANCj4gVGhpcyBzaG91bGQgZW5kIHVwIGluIHRoZSBzYW1lIGhl
YWRlciBhcyBfX2dldGNwdSgpIC0tIGl0IHByb2JhYmx5DQo+IG1ha2VzIHNlbnNlIHRvIGp1c3Qg
bW92ZSBfX2dldGNwdSgpIGZvciB0aGlzIHB1cnBvc2UuDQo+IA0KPiBBbHNvLCBocGEgYW5kIE5h
ZGF2LCBzaG91bGRuJ3QgYXNtL2luc3QuaCBlbmQgdXAgaW4gbWFjcm9zLlM/DQoNCklmIHRoZXJl
IGFyZSBnb2luZyB0byBiZSBDIHVzZXMsIHllcy4NCg0KSW5nbyB3YXMgY29uY2VybmVkIHRoYXQg
dGhlIC5zIGZpbGUgd2lsbCBiZSB0b28gYmlnLCBzbyBpdCBzaG91bGQgbm90DQpiZSBvdmVybHkg
YWJ1c2VkLiBJbiBhZGRpdGlvbiwgSSB3YW50IHRvIHNlbmQgYSBwYXRjaCB0aGF0IHJlY29tcGls
ZXMgYWxsDQp0aGUgLmMgZmlsZXMgaW4gbWFjcm8uUyBjaGFuZ2VzLiBJ4oCZbSB3b3JyaWVkIGl0
IHdpbGwgc3RhcnQgY3JlYXRpbmcgYnVpbGQNCnByb2JsZW1zLg0KDQo=
