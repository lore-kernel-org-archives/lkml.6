Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8A5C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 09:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC54206A2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 09:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="N6s6VM8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbeLOJSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 04:18:36 -0500
Received: from mail-eopbgr80131.outbound.protection.outlook.com ([40.107.8.131]:20608
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbeLOJSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 04:18:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wr2kVnQvZlatVkKcx/lyYxPC1RNoq5/VCFmpbWnpIQY=;
 b=N6s6VM8Ka4Zb1q+Ew6RfG4v5mjvN0bqsf37QRCBIa8zfXWP2ArFJf4TLmi2T/HajF4KUX9s1Bk8etISPFS6qtiYOVXBhrfqRYzidYyrclwclSgZKVKEFNuom7sLFEhokmKk+XpmLibLncQTJOOZ+8eIGwsgwEsmxcnqBhk7C4rw=
Received: from DB7PR08MB3771.eurprd08.prod.outlook.com (20.178.47.26) by
 DB7PR08MB3308.eurprd08.prod.outlook.com (52.134.111.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Sat, 15 Dec 2018 09:18:23 +0000
Received: from DB7PR08MB3771.eurprd08.prod.outlook.com
 ([fe80::5caa:70f5:2319:24b8]) by DB7PR08MB3771.eurprd08.prod.outlook.com
 ([fe80::5caa:70f5:2319:24b8%4]) with mapi id 15.20.1425.021; Sat, 15 Dec 2018
 09:18:23 +0000
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "hughd@google.com" <hughd@google.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>
CC:     "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "imbrenda@linux.vnet.ibm.com" <imbrenda@linux.vnet.ibm.com>,
        "riel@surriel.com" <riel@surriel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: Reuse only-pte-mapped KSM page in do_wp_page()
Thread-Topic: [PATCH] mm: Reuse only-pte-mapped KSM page in do_wp_page()
Thread-Index: AQHUkvikqotwXQSVqUO14lRGxf55iKV9ClwAgAEgFYCAAF8mAIAA/qyA
Date:   Sat, 15 Dec 2018 09:18:23 +0000
Message-ID: <b1e37dbe-5a1d-7883-8423-45d2a5f74b66@virtuozzo.com>
References: <154471491016.31352.1168978849911555609.stgit@localhost.localdomain>
 <5d5bfbd2-8411-e707-1628-18bde66a6793@linux.alibaba.com>
 <a394a604-20d6-e261-1735-bc225e39f2a2@virtuozzo.com>
 <00af5cd2-e226-89e3-3506-de5e6de05060@linux.alibaba.com>
In-Reply-To: <00af5cd2-e226-89e3-3506-de5e6de05060@linux.alibaba.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0039.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::25) To DB7PR08MB3771.eurprd08.prod.outlook.com
 (2603:10a6:10:7c::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [128.69.177.17]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR08MB3308;20:GZAXPiFyYuaNcoEFpuCnFVctSawZSw5DjdUHVp+Ox9Gv7lIiNHcyMw62Gkzhk2ODnCnNmoQ5QxIzsXXJogC2VbBtl1E2hbaUT9mDNhG1iiAk9Em2vI9ozJz8fygK2BQALCDlKRgprp7GLlpNzghKExOzx9W8E9hV3boLHVq5VO8=
x-ms-office365-filtering-correlation-id: b996cc9f-e7ca-421d-dded-08d6626e4355
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3308;
x-ms-traffictypediagnostic: DB7PR08MB3308:
x-microsoft-antispam-prvs: <DB7PR08MB3308242BD8B556D8027287E0CDA20@DB7PR08MB3308.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB7PR08MB3308;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3308;
x-forefront-prvs: 088751B4D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(39850400004)(346002)(376002)(52314003)(189003)(199004)(386003)(31696002)(7736002)(486006)(53546011)(2201001)(6506007)(102836004)(305945005)(71200400001)(71190400001)(76176011)(11346002)(256004)(14444005)(52116002)(81156014)(14454004)(2501003)(7416002)(81166006)(2906002)(68736007)(8676002)(8936002)(97736004)(229853002)(55236004)(476003)(2616005)(6486002)(6436002)(106356001)(110136005)(54906003)(316002)(36756003)(93886005)(53936002)(25786009)(4326008)(6512007)(31686004)(105586002)(446003)(186003)(26005)(6116002)(5660300001)(99286004)(66066001)(6246003)(3846002)(86362001)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3308;H:DB7PR08MB3771.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4O5XQEYT/VQfU60+fPSvO3ih7gTJCPZpJags11DBxJ3T4Evk6OiuUzLPQqzqqS70K00jMmKPuSMzj0gWvDeovGmoXD2Jy1ceyTwz7AuFN3qFrr0zNZ2nIeiSSvGK1kYv2l1R0yxJ6VZ6oI7bV7+K/9ppGOoi6CFkNB5elmDryle8by4urkVCNbIcEmVC6oXibJ0P6ryk/EInBLn9++Kwq1JS2viXTAT1IA5XBgtWPtwzlvD/+mCKJbPG7oPUgCC36UfSn3KvXrDT6dHtEZ2c2TO1VqxvQDDpDDuD758CYslXof3cWwtPrk5Of7iPGfX0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B4BB8D11FB64C45B33B49D558665F7C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b996cc9f-e7ca-421d-dded-08d6626e4355
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2018 09:18:23.8231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3308
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQuMTIuMjAxOCAyMTowNiwgWWFuZyBTaGkgd3JvdGU6DQo+IA0KPiANCj4gT24gMTIvMTQv
MTggMToyNiBBTSwgS2lyaWxsIFRraGFpIHdyb3RlOg0KPj4gT24gMTMuMTIuMjAxOCAyMjoxNSwg
WWFuZyBTaGkgd3JvdGU6DQo+Pj4NCj4+PiBPbiAxMi8xMy8xOCA3OjI5IEFNLCBLaXJpbGwgVGto
YWkgd3JvdGU6DQo+Pj4+IFRoaXMgcGF0Y2ggYWRkcyBhbiBvcHRpbWl6YXRpb24gZm9yIEtTTSBw
YWdlcyBhbG1vc3QNCj4+Pj4gaW4gdGhlIHNhbWUgd2F5LCB0aGF0IHdlIGhhdmUgZm9yIG9yZGlu
YXJ5IGFub255bW91cw0KPj4+PiBwYWdlcy4gSWYgdGhlcmUgaXMgYSB3cml0ZSBmYXVsdCBpbiBh
IHBhZ2UsIHdoaWNoIGlzDQo+Pj4+IG1hcHBlZCB0byBhbiBvbmx5IHB0ZSwgYW5kIGl0IGlzIG5v
dCByZWxhdGVkIHRvIHN3YXANCj4+Pj4gY2FjaGU7IHRoZSBwYWdlIG1heSBiZSByZXVzZWQgd2l0
aG91dCBjb3B5aW5nIGl0cw0KPj4+PiBjb250ZW50Lg0KPj4+Pg0KPj4+PiBbTm90ZSwgdGhhdCB3
ZSBkbyBub3QgY29uc2lkZXIgUGFnZVN3YXBDYWNoZSgpIHBhZ2VzDQo+Pj4+IMKgwqAgYXQgbGVh
c3QgZm9yIG5vdywgc2luY2Ugd2UgZG9uJ3Qgd2FudCB0byBjb21wbGljYXRlDQo+Pj4+IMKgwqAg
X19nZXRfa3NtX3BhZ2UoKSwgd2hpY2ggaGFzIG5pY2Ugb3B0aW1pemF0aW9uIGJhc2VkDQo+Pj4+
IMKgwqAgb24gdGhpcyAoZm9yIHRoZSBtaWdyYXRpb24gY2FzZSkuIEN1cnJlbmx5IGl0IGlzDQo+
Pj4+IMKgwqAgc3Bpbm5pbmcgb24gUGFnZVN3YXBDYWNoZSgpIHBhZ2VzLCB3YWl0aW5nIGZvciB3
aGVuDQo+Pj4+IMKgwqAgdGhleSBoYXZlIHVuZnJlZXplZCBjb3VudGVycyAoaS5lLiwgZm9yIHRo
ZSBtaWdyYXRpb24NCj4+Pj4gwqDCoCBmaW5pc2gpLiBCdXQgd2UgZG9uJ3Qgd2FudCB0byBtYWtl
IGl0IGFsc28gc3Bpbm5pbmcNCj4+Pj4gwqDCoCBvbiBzd2FwIGNhY2hlIHBhZ2VzLCB3aGljaCB3
ZSB0cnkgdG8gcmV1c2UsIHNpbmNlDQo+Pj4+IMKgwqAgdGhlcmUgaXMgbm90IGEgdmVyeSBoaWdo
IHByb2JhYmlsaXR5IHRvIHJldXNlIHRoZW0uDQo+Pj4+IMKgwqAgU28sIGZvciBub3cgd2UgZG8g
bm90IGNvbnNpZGVyIFBhZ2VTd2FwQ2FjaGUoKSBwYWdlcw0KPj4+PiDCoMKgIGF0IGFsbC5dDQo+
Pj4+DQo+Pj4+IFNvLCBpbiByZXVzZV9rc21fcGFnZSgpIHdlIGNoZWNrIGZvciAxKVBhZ2VTd2Fw
Q2FjaGUoKQ0KPj4+PiBhbmQgMilwYWdlX3N0YWJsZV9ub2RlKCksIHRvIHNraXAgYSBwYWdlLCB3
aGljaCBLU00NCj4+Pj4gaXMgY3VycmVudGx5IHRyeWluZyB0byBsaW5rIHRvIHN0YWJsZSB0cmVl
LiBUaGVuIHdlDQo+Pj4+IGRvIHBhZ2VfcmVmX2ZyZWV6ZSgpIHRvIHByb2hpYml0IEtTTSB0byBt
ZXJnZSBvbmUgbW9yZQ0KPj4+PiBwYWdlIGludG8gdGhlIHBhZ2UsIHdlIGFyZSByZXVzaW5nLiBB
ZnRlciB0aGF0LCBub2JvZHkNCj4+Pj4gY2FuIHJlZmVyIHRvIHRoZSByZXVzaW5nIHBhZ2U6IEtT
TSBza2lwcyAhUGFnZVN3YXBDYWNoZSgpDQo+Pj4+IHBhZ2VzIHdpdGggemVybyByZWZjb3VudDsg
YW5kIHRoZSBwcm90ZWN0aW9uIGFnYWluc3QNCj4+Pj4gb2YgYWxsIG90aGVyIHBhcnRpY2lwYW50
cyBpcyB0aGUgc2FtZSBhcyBmb3IgcmV1c2VkDQo+Pj4+IG9yZGluYXJ5IGFub24gcGFnZXMgcHRl
IGxvY2ssIHBhZ2UgbG9jayBhbmQgbW1hcF9zZW0uDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6
IEtpcmlsbCBUa2hhaSA8a3RraGFpQHZpcnR1b3p6by5jb20+DQo+Pj4+IC0tLQ0KPj4+PiDCoMKg
IGluY2x1ZGUvbGludXgva3NtLmggfMKgwqDCoCA3ICsrKysrKysNCj4+Pj4gwqDCoCBtbS9rc20u
Y8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMjUgKysrKysrKysrKysrKysrKysrKysrKyst
LQ0KPj4+PiDCoMKgIG1tL21lbW9yeS5jwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxNiArKysrKysr
KysrKysrKy0tDQo+Pj4+IMKgwqAgMyBmaWxlcyBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9rc20u
aCBiL2luY2x1ZGUvbGludXgva3NtLmgNCj4+Pj4gaW5kZXggMTYxZTgxNjRhYmNmLi5lNDhiMWU0
NTNmZjUgMTAwNjQ0DQo+Pj4+IC0tLSBhL2luY2x1ZGUvbGludXgva3NtLmgNCj4+Pj4gKysrIGIv
aW5jbHVkZS9saW51eC9rc20uaA0KPj4+PiBAQCAtNTMsNiArNTMsOCBAQCBzdHJ1Y3QgcGFnZSAq
a3NtX21pZ2h0X25lZWRfdG9fY29weShzdHJ1Y3QgcGFnZSAqcGFnZSwNCj4+Pj4gwqDCoCDCoCB2
b2lkIHJtYXBfd2Fsa19rc20oc3RydWN0IHBhZ2UgKnBhZ2UsIHN0cnVjdCBybWFwX3dhbGtfY29u
dHJvbCAqcndjKTsNCj4+Pj4gwqDCoCB2b2lkIGtzbV9taWdyYXRlX3BhZ2Uoc3RydWN0IHBhZ2Ug
Km5ld3BhZ2UsIHN0cnVjdCBwYWdlICpvbGRwYWdlKTsNCj4+Pj4gK2Jvb2wgcmV1c2Vfa3NtX3Bh
Z2Uoc3RydWN0IHBhZ2UgKnBhZ2UsDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVj
dCB2bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25lZCBsb25nIGFkZHJlc3MpOw0KPj4+PiDCoMKg
IMKgICNlbHNlwqAgLyogIUNPTkZJR19LU00gKi8NCj4+Pj4gwqDCoCBAQCAtODYsNiArODgsMTEg
QEAgc3RhdGljIGlubGluZSB2b2lkIHJtYXBfd2Fsa19rc20oc3RydWN0IHBhZ2UgKnBhZ2UsDQo+
Pj4+IMKgwqAgc3RhdGljIGlubGluZSB2b2lkIGtzbV9taWdyYXRlX3BhZ2Uoc3RydWN0IHBhZ2Ug
Km5ld3BhZ2UsIHN0cnVjdCBwYWdlICpvbGRwYWdlKQ0KPj4+PiDCoMKgIHsNCj4+Pj4gwqDCoCB9
DQo+Pj4+ICtzdGF0aWMgaW5saW5lIGJvb2wgcmV1c2Vfa3NtX3BhZ2Uoc3RydWN0IHBhZ2UgKnBh
Z2UsDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAq
dm1hLCB1bnNpZ25lZCBsb25nIGFkZHJlc3MpDQo+Pj4+ICt7DQo+Pj4+ICvCoMKgwqAgcmV0dXJu
IGZhbHNlOw0KPj4+PiArfQ0KPj4+PiDCoMKgICNlbmRpZiAvKiBDT05GSUdfTU1VICovDQo+Pj4+
IMKgwqAgI2VuZGlmIC8qICFDT05GSUdfS1NNICovDQo+Pj4+IMKgwqAgZGlmZiAtLWdpdCBhL21t
L2tzbS5jIGIvbW0va3NtLmMNCj4+Pj4gaW5kZXggMzgzZjk2MWU1NzdhLi5mYmQxNDI2NGQ3ODQg
MTAwNjQ0DQo+Pj4+IC0tLSBhL21tL2tzbS5jDQo+Pj4+ICsrKyBiL21tL2tzbS5jDQo+Pj4+IEBA
IC03MDcsOCArNzA3LDkgQEAgc3RhdGljIHN0cnVjdCBwYWdlICpfX2dldF9rc21fcGFnZShzdHJ1
Y3Qgc3RhYmxlX25vZGUgKnN0YWJsZV9ub2RlLA0KPj4+PiDCoMKgwqDCoMKgwqDCoCAqIGNhc2Ug
dGhpcyBub2RlIGlzIG5vIGxvbmdlciByZWZlcmVuY2VkLCBhbmQgc2hvdWxkIGJlIGZyZWVkOw0K
Pj4+PiDCoMKgwqDCoMKgwqDCoCAqIGhvd2V2ZXIsIGl0IG1pZ2h0IG1lYW4gdGhhdCB0aGUgcGFn
ZSBpcyB1bmRlciBwYWdlX3JlZl9mcmVlemUoKS4NCj4+Pj4gwqDCoMKgwqDCoMKgwqAgKiBUaGUg
X19yZW1vdmVfbWFwcGluZygpIGNhc2UgaXMgZWFzeSwgYWdhaW4gdGhlIG5vZGUgaXMgbm93IHN0
YWxlOw0KPj4+PiAtwqDCoMKgwqAgKiBidXQgaWYgcGFnZSBpcyBzd2FwY2FjaGUgaW4gbWlncmF0
ZV9wYWdlX21vdmVfbWFwcGluZygpLCBpdCBtaWdodA0KPj4+PiAtwqDCoMKgwqAgKiBzdGlsbCBi
ZSBvdXIgcGFnZSwgaW4gd2hpY2ggY2FzZSBpdCdzIGVzc2VudGlhbCB0byBrZWVwIHRoZSBub2Rl
Lg0KPj4+PiArwqDCoMKgwqAgKiB0aGUgc2FtZSBpcyBpbiByZXVzZV9rc21fcGFnZSgpIGNhc2U7
IGJ1dCBpZiBwYWdlIGlzIHN3YXBjYWNoZQ0KPj4+PiArwqDCoMKgwqAgKiBpbiBtaWdyYXRlX3Bh
Z2VfbW92ZV9tYXBwaW5nKCksIGl0IG1pZ2h0IHN0aWxsIGJlIG91ciBwYWdlLA0KPj4+PiArwqDC
oMKgwqAgKiBpbiB3aGljaCBjYXNlIGl0J3MgZXNzZW50aWFsIHRvIGtlZXAgdGhlIG5vZGUuDQo+
Pj4+IMKgwqDCoMKgwqDCoMKgICovDQo+Pj4+IMKgwqDCoMKgwqDCoCB3aGlsZSAoIWdldF9wYWdl
X3VubGVzc196ZXJvKHBhZ2UpKSB7DQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qDQo+Pj4+
IEBAIC0yNjY2LDYgKzI2NjcsMjYgQEAgdm9pZCBybWFwX3dhbGtfa3NtKHN0cnVjdCBwYWdlICpw
YWdlLCBzdHJ1Y3Qgcm1hcF93YWxrX2NvbnRyb2wgKnJ3YykNCj4+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZ290byBhZ2FpbjsNCj4+Pj4gwqDCoCB9DQo+Pj4+IMKgwqAgK2Jvb2wgcmV1c2Vfa3Nt
X3BhZ2Uoc3RydWN0IHBhZ2UgKnBhZ2UsDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0
cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLA0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1
bnNpZ25lZCBsb25nIGFkZHJlc3MpDQo+Pj4+ICt7DQo+Pj4+ICvCoMKgwqAgVk1fQlVHX09OX1BB
R0UoaXNfemVyb19wZm4ocGFnZV90b19wZm4ocGFnZSkpLCBwYWdlKTsNCj4+Pj4gK8KgwqDCoCBW
TV9CVUdfT05fUEFHRSghcGFnZV9tYXBwZWQocGFnZSksIHBhZ2UpOw0KPj4+PiArwqDCoMKgIFZN
X0JVR19PTl9QQUdFKCFQYWdlTG9ja2VkKHBhZ2UpLCBwYWdlKTsNCj4+Pj4gKw0KPj4+PiArwqDC
oMKgIGlmIChQYWdlU3dhcENhY2hlKHBhZ2UpIHx8ICFwYWdlX3N0YWJsZV9ub2RlKHBhZ2UpKQ0K
Pj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOw0KPj4+PiArwqDCoMKgIC8qIFByb2hp
Yml0IHBhcmFsbGVsIGdldF9rc21fcGFnZSgpICovDQo+Pj4+ICvCoMKgwqAgaWYgKCFwYWdlX3Jl
Zl9mcmVlemUocGFnZSwgMSkpDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7DQo+
Pj4+ICsNCj4+Pj4gK8KgwqDCoCBwYWdlX21vdmVfYW5vbl9ybWFwKHBhZ2UsIHZtYSk7DQo+Pj4g
T25jZSB0aGUgbWFwcGluZyBpcyBjaGFuZ2VkLCBpdCBpcyBub3QgS1NNIG1hcHBpbmcgYW55bW9y
ZS4gSXQgbG9va3MgbGF0ZXIgZ2V0X2tzbV9wYWdlKCkgd291bGQgYWx3YXlzIGZhaWwgb24gdGhp
cyBwYWdlLiBJcyB0aGlzIGV4cGVjdGVkPw0KPj4gWWVzLCB0aGlzIGlzIHRoZSB0aGluZyB0aGF0
IHRoZSBwYXRjaCBtYWtlcy4gTGV0J3MgbG9vayBhdCB0aGUgYWN0aW9ucywNCj4+IHdlIGhhdmUg
d2l0aG91dCB0aGUgcGF0Y2gsIHdoZW4gdGhlcmUgaXMgYSB3cml0aW5nIHRvIGFuIG9ubHktcHRl
LW1hcHBlZA0KPj4gS1NNIHBhZ2UuDQo+Pg0KPj4gV2UgZW50ZXIgdG8gZG9fd3BfcGFnZSgpIHdp
dGggcGFnZV9jb3VudCgpID09IDEsIHNpbmNlIEtTTSBwYWdlIGlzIG1hcHBlZA0KPj4gaW4gb25s
eSBwdGUgKGFuZCB3ZSBkbyBub3QgZ2V0IGV4dHJhIHJlZmVyZW5jZSB0byBhIHBhZ2UsIHdoZW4g
d2UgYWRkIGl0DQo+PiB0byBLU00gc3RhYmxlIHRyZWUpLiBUaGVuOg0KPj4NCj4+IMKgwqAgZG9f
d3BfcGFnZSgpDQo+PiDCoMKgwqDCoCBnZXRfcGFnZSh2bWYtPnBhZ2UpIDwtIHBhZ2VfY291bnQo
KSBpcyAyDQo+PiDCoMKgwqDCoCB3cF9wYWdlX2NvcHkoKQ0KPj4gwqDCoMKgwqDCoMKgIC4uDQo+
PiDCoMKgwqDCoMKgwqAgY293X3VzZXJfcGFnZSgpIC8qIENvcHkgdXNlciBwYWdlIHRvIGEgbmV3
IG9uZSAqLw0KPj4gwqDCoMKgwqDCoMKgIC4uDQo+PiDCoMKgwqDCoMKgwqAgcHV0X3BhZ2Uodm1m
LT5wYWdlKSA8LSBwYWdlX2NvdW50KCkgaXMgMQ0KPj4gwqDCoMKgwqDCoMKgIHB1dF9wYWdlKHZt
Zi0+cGFnZSkgPC0gcGFnZV9jb3VudCgpIGlzIDANCj4+DQo+PiBTZWNvbmQgcHV0X3BhZ2UoKSBm
cmVlcyB0aGUgcGFnZSAoYW5kIGFsc28gemVyb2VzIHBhZ2UtPm1hcHBpbmcpLA0KPj4gYW5kIHNp
bmNlIHRoYXQgaXQncyBub3QgYSBQYWdlS3NtKCkgcGFnZSBhbnltb3JlLiBGdXJ0aGVyDQo+PiBf
X2dldF9rc21fcGFnZSgpIGNhbGxzIHdpbGwgZmFpbCBvbiB0aGlzIHBhZ2UgKHNpbmNlIHRoZSBt
YXBwaW5nDQo+PiB3YXMgemVyb2VkKSwgYW5kIGl0cyBub2RlIHdpbGwgYmUgdW5saW5rZWQgZnJv
bSBrc20gc3RhYmxlIHRyZWU6DQo+Pg0KPj4gX19nZXRfa3NtX3BhZ2UoKQ0KPj4gew0KPj4gwqDC
oMKgwqAvKiBwYWdlLT5tYXBwaW5nID09IE5VTEwsIGV4cGVjdGVkX21hcHBpbmcgIT0gTlVMTCAq
Lw0KPj4gwqDCoMKgwqBpZiAoUkVBRF9PTkNFKHBhZ2UtPm1hcHBpbmcpICE9IGV4cGVjdGVkX21h
cHBpbmcpDQo+PiDCoMKgwqDCoMKgwqDCoCBnb3RvIHN0YWxlOw0KPj4gwqDCoMKgwqAuLi4uLi4u
DQo+PiBzdGFsZToNCj4+IMKgwqDCoMKgcmVtb3ZlX25vZGVfZnJvbV9zdGFibGVfdHJlZShzdGFi
bGVfbm9kZSk7DQo+PiB9DQo+Pg0KPj4NCj4+IFRoZSBwYXRjaCBvcHRpbWl6ZXMgZG9fd3BfcGFn
ZSgpLCBhbmQgbWFrZXMgaXQgdG8gYXZvaWQgdGhlIGNvcHlpbmcNCj4+IChsaWtlIHdlIGhhdmUg
Zm9yIG9yZGluYXJ5IGFub24gcGFnZXMpLiBTaW5jZSBLU00gcGFnZSBpcyBmcmVlZCBhbnl3YXks
DQo+PiBhZnRlciB3ZSBkcm9wcGVkIHRoZSBsYXN0IHJlZmVyZW5jZSB0byBpdDsgd2UgcmV1c2Ug
aXQgaW5zdGVhZCBvZiB0aGlzLg0KPj4gU28sIHRoZSB0aGluZyB3aWxsIG5vdyB3b3JrIGluIHRo
aXMgd2F5Og0KPj4NCj4+IGRvX3dwX3BhZ2UoKQ0KPj4gwqDCoCBsb2NrX3BhZ2Uodm1mLT5wYWdl
KQ0KPj4gwqDCoCByZXVzZV9rc21fcGFnZSgpDQo+PiDCoMKgwqDCoCBjaGVjayBQYWdlU3dhcENh
Y2hlKCkgYW5kIHBhZ2Vfc3RhYmxlX25vZGUoKQ0KPj4gwqDCoMKgwqAgcGFnZV9yZWZfZnJlZXpl
KHBhZ2UsIDEpIDwtIEZyZWV6ZSB0aGUgcGFnZSB0byBtYWtlIHBhcmFsbGVsDQo+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IF9fZ2V0X2tzbV9wYWdlKCkgKGlmIGFueSkgd2FpdGluZw0KPj4gwqDCoMKgwqAgcGFnZV9tb3Zl
X2Fub25fcm1hcCgpwqDCoMKgIDwtIFdyaXRlIG5ldyBtYXBwaW5nLCBzbyBfX2dldF9rc21fcGFn
ZSgpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHNlZXMgdGhpcyBpcyBub3QgYSBLU00gcGFnZSBhbnltb3JlLA0KPj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBhbmQgaXQgcmVtb3ZlcyBzdGFibGUgbm9kZS4NCj4+DQo+PiBTbywgdGhlIHJlc3Vs
dCBpcyB0aGUgc2FtZSwgYnV0IGFmdGVyIHRoZSBwYXRjaCB3ZSBhY2hpZXZlIGl0IGZhc3RlciA6
KQ0KPj4NCj4+IEFsc28sIG5vdGUsIHRoYXQgaW4gdGhlIG1vc3QgcHJvYmFibHkgY2FzZSwgZG9f
d3BfcGFnZSgpIGRvZXMgbm90IGNyb3NzDQo+PiB3aXRoIF9fZ2V0X2tzbV9wYWdlKCkgKHRoZSBy
YWNlIHdpbmRvdyBpcyB2ZXJ5IHNtYWxsOyBfX2dldF9rc21fcGFnZSgpDQo+PiBpcyBzcGlubmlu
Zywgb25seSB3aGVuIHJldXNlX2tzbV9wYWdlKCkgaXMgYmV0d2VlbiBwYWdlX3JlZl9mcmVlemUo
KQ0KPj4gYW5kIHBhZ2VfbW92ZV9hbm9uX3JtYXAoKSwgd2hpY2ggYXJlIG9uIG5laWdoYm9yaW5n
IGxpbmVzKS4NCj4+DQo+PiBTbywgdGhpcyBpcyB0aGUgaWRlYS4gUGxlYXNlLCBsZXQgbWUga25v
dyBpbiBjYXNlIG9mIHNvbWV0aGluZyBpcyB1bmNsZWFyDQo+PiBmb3IgeW91Lg0KPiANCj4gVGhh
bmtzIGZvciBlbGFib3JhdGluZyB0aGlzLiBJdCBzb3VuZHMgcmVhc29uYWJsZS4gWW91IGNhbiBh
ZGQgUmV2aWV3ZWQtYnk6IFlhbmcgU2hpIDx5YW5nLnNoaUBsaW51eC5hbGliYWJhLmNvbT4NCg0K
VGhhbmtzIQ0KDQpLaXJpbGwNCg==
