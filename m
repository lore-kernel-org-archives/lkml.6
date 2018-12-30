Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED50C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 09:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB2620855
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 09:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BKr6XNnu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbeL3Jr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 04:47:59 -0500
Received: from mail-eopbgr80128.outbound.protection.outlook.com ([40.107.8.128]:6213
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726042AbeL3Jr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 04:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toDC11NTDQ1teCPDSZ7rympBZveAbZwwkioTSulhaHY=;
 b=BKr6XNnuX+DqBDJ8pIfS3g/eG+QBCAFh8GgsuBu9EsutHBcFVx+tRnoLJgVzUU2tLRKZQ895unELjhD/3CKz/GX0hCWdzBm5GDKWQa+EUnHZEaPSk5QIejczsBc0RSEJNo3HlAdKBf5pscbz6Ui6TUUGMl9QH0eUJidCCNZvark=
Received: from DB7PR08MB3771.eurprd08.prod.outlook.com (20.178.47.26) by
 DB7PR08MB3820.eurprd08.prod.outlook.com (20.178.84.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Sun, 30 Dec 2018 09:47:51 +0000
Received: from DB7PR08MB3771.eurprd08.prod.outlook.com
 ([fe80::83:10e6:94a0:6bb8]) by DB7PR08MB3771.eurprd08.prod.outlook.com
 ([fe80::83:10e6:94a0:6bb8%4]) with mapi id 15.20.1471.019; Sun, 30 Dec 2018
 09:47:51 +0000
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "kirill@shutemov.name" <kirill@shutemov.name>,
        "hughd@google.com" <hughd@google.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "imbrenda@linux.vnet.ibm.com" <imbrenda@linux.vnet.ibm.com>,
        "yang.shi@linux.alibaba.com" <yang.shi@linux.alibaba.com>,
        "riel@surriel.com" <riel@surriel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: Reuse only-pte-mapped KSM page in do_wp_page()
Thread-Topic: [PATCH] mm: Reuse only-pte-mapped KSM page in do_wp_page()
Thread-Index: AQHUkvikqotwXQSVqUO14lRGxf55iKWWWDyAgADLOYA=
Date:   Sun, 30 Dec 2018 09:47:51 +0000
Message-ID: <cfb2180d-8da8-6d99-44b8-ffc052869182@virtuozzo.com>
References: <154471491016.31352.1168978849911555609.stgit@localhost.localdomain>
 <20181229134017.0264b5cab7e3ebb483b49f65@linux-foundation.org>
In-Reply-To: <20181229134017.0264b5cab7e3ebb483b49f65@linux-foundation.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0260.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::12) To DB7PR08MB3771.eurprd08.prod.outlook.com
 (2603:10a6:10:7c::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [128.69.177.17]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR08MB3820;20:0U8O0L4kQUvumkbAqPYC1r/fRzSVqo7fEWu7cO9o8YhP+9Si2JFs/ONeB60BH0nmxPc606yK9QEGFQ8KWuXg0jElwLELveXCtWquL4FFvho8VLRDtaIYa++UBwRsOEBu0obvVhOrgbFSSv54yxuJ+5VTaNGmjZ8a/1KWgVTF33Q=
x-ms-office365-filtering-correlation-id: 9c20d4b4-8d57-4c63-b0ed-08d66e3bdd3f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3820;
x-ms-traffictypediagnostic: DB7PR08MB3820:
x-microsoft-antispam-prvs: <DB7PR08MB3820C0B150ADCFE4D9402611CDB10@DB7PR08MB3820.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR08MB3820;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3820;
x-forefront-prvs: 0902222726
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39840400004)(396003)(346002)(366004)(376002)(189003)(199004)(86362001)(6512007)(6436002)(2616005)(5660300001)(31686004)(6116002)(11346002)(3846002)(6916009)(446003)(25786009)(105586002)(31696002)(26005)(68736007)(6486002)(99286004)(4326008)(54906003)(106356001)(55236004)(14454004)(14444005)(256004)(53936002)(476003)(316002)(7416002)(6246003)(36756003)(8676002)(81166006)(81156014)(6506007)(386003)(52116002)(97736004)(7736002)(305945005)(486006)(478600001)(53546011)(102836004)(8936002)(71190400001)(71200400001)(186003)(66066001)(2906002)(76176011)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3820;H:DB7PR08MB3771.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s9iEN6uRbjwEW8s1XPy8zxALqsS52IN2+H6z1C7V4cYVFF8lYW8AxwsEatbRSGQRpK2L6+4bjXZ9whmITxYGoytyOPoa/SlS4itsej+9CezetP+onO45o7kRVbiaTvtXk+7fa91HZSFGX9fS4hVmMO+DoWPDck7NE6eH7fs/qp/o1Ygvd4WhP+6EXAa8ug2dwOv1GLWTrb9kKPT6BETrOi6rTf7KLzLGo4zQlAXKVY1vCgPlikqHToG8n7xAWqSIKAry6ylFgxS8vAaQ/X6YCFlFdDRlyqYPDthZJrHd8G6crbwlkCIO/xHUUddZi1p0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DF348614EA5A04184A626689FF5FC19@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c20d4b4-8d57-4c63-b0ed-08d66e3bdd3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2018 09:47:51.6750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3820
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAuMTIuMjAxOCAwMDo0MCwgQW5kcmV3IE1vcnRvbiB3cm90ZToNCj4gT24gVGh1LCAxMyBE
ZWMgMjAxOCAxODoyOTowOCArMDMwMCBLaXJpbGwgVGtoYWkgPGt0a2hhaUB2aXJ0dW96em8uY29t
PiB3cm90ZToNCj4gDQo+PiBUaGlzIHBhdGNoIGFkZHMgYW4gb3B0aW1pemF0aW9uIGZvciBLU00g
cGFnZXMgYWxtb3N0DQo+PiBpbiB0aGUgc2FtZSB3YXksIHRoYXQgd2UgaGF2ZSBmb3Igb3JkaW5h
cnkgYW5vbnltb3VzDQo+PiBwYWdlcy4gSWYgdGhlcmUgaXMgYSB3cml0ZSBmYXVsdCBpbiBhIHBh
Z2UsIHdoaWNoIGlzDQo+PiBtYXBwZWQgdG8gYW4gb25seSBwdGUsIGFuZCBpdCBpcyBub3QgcmVs
YXRlZCB0byBzd2FwDQo+PiBjYWNoZTsgdGhlIHBhZ2UgbWF5IGJlIHJldXNlZCB3aXRob3V0IGNv
cHlpbmcgaXRzDQo+PiBjb250ZW50Lg0KPj4NCj4+IFtOb3RlLCB0aGF0IHdlIGRvIG5vdCBjb25z
aWRlciBQYWdlU3dhcENhY2hlKCkgcGFnZXMNCj4+ICBhdCBsZWFzdCBmb3Igbm93LCBzaW5jZSB3
ZSBkb24ndCB3YW50IHRvIGNvbXBsaWNhdGUNCj4+ICBfX2dldF9rc21fcGFnZSgpLCB3aGljaCBo
YXMgbmljZSBvcHRpbWl6YXRpb24gYmFzZWQNCj4+ICBvbiB0aGlzIChmb3IgdGhlIG1pZ3JhdGlv
biBjYXNlKS4gQ3VycmVubHkgaXQgaXMNCj4+ICBzcGlubmluZyBvbiBQYWdlU3dhcENhY2hlKCkg
cGFnZXMsIHdhaXRpbmcgZm9yIHdoZW4NCj4+ICB0aGV5IGhhdmUgdW5mcmVlemVkIGNvdW50ZXJz
IChpLmUuLCBmb3IgdGhlIG1pZ3JhdGlvbg0KPj4gIGZpbmlzaCkuIEJ1dCB3ZSBkb24ndCB3YW50
IHRvIG1ha2UgaXQgYWxzbyBzcGlubmluZw0KPj4gIG9uIHN3YXAgY2FjaGUgcGFnZXMsIHdoaWNo
IHdlIHRyeSB0byByZXVzZSwgc2luY2UNCj4+ICB0aGVyZSBpcyBub3QgYSB2ZXJ5IGhpZ2ggcHJv
YmFiaWxpdHkgdG8gcmV1c2UgdGhlbS4NCj4+ICBTbywgZm9yIG5vdyB3ZSBkbyBub3QgY29uc2lk
ZXIgUGFnZVN3YXBDYWNoZSgpIHBhZ2VzDQo+PiAgYXQgYWxsLl0NCj4+DQo+PiBTbywgaW4gcmV1
c2Vfa3NtX3BhZ2UoKSB3ZSBjaGVjayBmb3IgMSlQYWdlU3dhcENhY2hlKCkNCj4+IGFuZCAyKXBh
Z2Vfc3RhYmxlX25vZGUoKSwgdG8gc2tpcCBhIHBhZ2UsIHdoaWNoIEtTTQ0KPj4gaXMgY3VycmVu
dGx5IHRyeWluZyB0byBsaW5rIHRvIHN0YWJsZSB0cmVlLiBUaGVuIHdlDQo+PiBkbyBwYWdlX3Jl
Zl9mcmVlemUoKSB0byBwcm9oaWJpdCBLU00gdG8gbWVyZ2Ugb25lIG1vcmUNCj4+IHBhZ2UgaW50
byB0aGUgcGFnZSwgd2UgYXJlIHJldXNpbmcuIEFmdGVyIHRoYXQsIG5vYm9keQ0KPj4gY2FuIHJl
ZmVyIHRvIHRoZSByZXVzaW5nIHBhZ2U6IEtTTSBza2lwcyAhUGFnZVN3YXBDYWNoZSgpDQo+PiBw
YWdlcyB3aXRoIHplcm8gcmVmY291bnQ7IGFuZCB0aGUgcHJvdGVjdGlvbiBhZ2FpbnN0DQo+PiBv
ZiBhbGwgb3RoZXIgcGFydGljaXBhbnRzIGlzIHRoZSBzYW1lIGFzIGZvciByZXVzZWQNCj4+IG9y
ZGluYXJ5IGFub24gcGFnZXMgcHRlIGxvY2ssIHBhZ2UgbG9jayBhbmQgbW1hcF9zZW0uDQo+Pg0K
Pj4gLi4uDQo+Pg0KPj4gK2Jvb2wgcmV1c2Vfa3NtX3BhZ2Uoc3RydWN0IHBhZ2UgKnBhZ2UsDQo+
PiArCQkgICAgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsDQo+PiArCQkgICAgdW5zaWduZWQg
bG9uZyBhZGRyZXNzKQ0KPj4gK3sNCj4+ICsJVk1fQlVHX09OX1BBR0UoaXNfemVyb19wZm4ocGFn
ZV90b19wZm4ocGFnZSkpLCBwYWdlKTsNCj4+ICsJVk1fQlVHX09OX1BBR0UoIXBhZ2VfbWFwcGVk
KHBhZ2UpLCBwYWdlKTsNCj4+ICsJVk1fQlVHX09OX1BBR0UoIVBhZ2VMb2NrZWQocGFnZSksIHBh
Z2UpOw0KPj4gKw0KPj4gKwlpZiAoUGFnZVN3YXBDYWNoZShwYWdlKSB8fCAhcGFnZV9zdGFibGVf
bm9kZShwYWdlKSkNCj4+ICsJCXJldHVybiBmYWxzZTsNCj4+ICsJLyogUHJvaGliaXQgcGFyYWxs
ZWwgZ2V0X2tzbV9wYWdlKCkgKi8NCj4+ICsJaWYgKCFwYWdlX3JlZl9mcmVlemUocGFnZSwgMSkp
DQo+PiArCQlyZXR1cm4gZmFsc2U7DQo+PiArDQo+PiArCXBhZ2VfbW92ZV9hbm9uX3JtYXAocGFn
ZSwgdm1hKTsNCj4+ICsJcGFnZS0+aW5kZXggPSBsaW5lYXJfcGFnZV9pbmRleCh2bWEsIGFkZHJl
c3MpOw0KPj4gKwlwYWdlX3JlZl91bmZyZWV6ZShwYWdlLCAxKTsNCj4+ICsNCj4+ICsJcmV0dXJu
IHRydWU7DQo+PiArfQ0KPiANCj4gQ2FuIHdlIGF2b2lkIHRob3NlIEJVR19PTigpcz8NCj4gDQo+
IFNvbWV0aGluZyBsaWtlIHRoaXM6DQo+IA0KPiAtLS0gYS9tbS9rc20uY35tbS1yZXVzZS1vbmx5
LXB0ZS1tYXBwZWQta3NtLXBhZ2UtaW4tZG9fd3BfcGFnZS1maXgNCj4gKysrIGEvbW0va3NtLmMN
Cj4gQEAgLTI2NDksOSArMjY0OSwxNCBAQCBib29sIHJldXNlX2tzbV9wYWdlKHN0cnVjdCBwYWdl
ICpwYWdlLA0KPiAgCQkgICAgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsDQo+ICAJCSAgICB1
bnNpZ25lZCBsb25nIGFkZHJlc3MpDQo+ICB7DQo+IC0JVk1fQlVHX09OX1BBR0UoaXNfemVyb19w
Zm4ocGFnZV90b19wZm4ocGFnZSkpLCBwYWdlKTsNCj4gLQlWTV9CVUdfT05fUEFHRSghcGFnZV9t
YXBwZWQocGFnZSksIHBhZ2UpOw0KPiAtCVZNX0JVR19PTl9QQUdFKCFQYWdlTG9ja2VkKHBhZ2Up
LCBwYWdlKTsNCj4gKyNpZmRlZiBDT05GSUdfREVCVUdfVk0NCj4gKwlpZiAoV0FSTl9PTihpc196
ZXJvX3BmbihwYWdlX3RvX3BmbihwYWdlKSkpIHx8DQo+ICsJCQlXQVJOX09OKCFwYWdlX21hcHBl
ZChwYWdlKSkgfHwNCj4gKwkJCVdBUk5fT04oIVBhZ2VMb2NrZWQocGFnZSkpKSB7DQo+ICsJCWR1
bXBfcGFnZShwYWdlLCAicmV1c2Vfa3NtX3BhZ2UiKTsNCj4gKwkJcmV0dXJuIGZhbHNlOw0KPiAr
CX0NCj4gKyNlbmRpZg0KDQpMb29rcyBnb29kIQ0KICANCj4gIAlpZiAoUGFnZVN3YXBDYWNoZShw
YWdlKSB8fCAhcGFnZV9zdGFibGVfbm9kZShwYWdlKSkNCj4gIAkJcmV0dXJuIGZhbHNlOw0KPiAN
Cj4gV2UgZG9uJ3QgaGF2ZSBhIFZNX1dBUk5fT05fUEFHRSgpIGFuZCB3ZSBjYW4ndCBwcm92aWRl
IG9uZSBiZWNhdXNlIHRoZQ0KPiBWTV9mb28oKSBtYWNyb3MgZG9uJ3QgcmV0dXJuIGEgdmFsdWUu
ICBJdCdzIGlycml0YXRpbmcgYW5kIEkga2VlcA0KPiBmb3JnZXR0aW5nIHdoeSB3ZSBlbmRlZCB1
cCBkb2luZyB0aGVtIHRoaXMgd2F5Lg0KVGhhbmtzIQ0K
