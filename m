Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08D3C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916DB21855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="VkCTSHbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfAWWcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:32:09 -0500
Received: from mail-eopbgr50065.outbound.protection.outlook.com ([40.107.5.65]:3536
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726343AbfAWWcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiQlyfAeJeZuIcQJg92ZzQzYc2Os3EvAjvdZNwJs7ac=;
 b=VkCTSHbULAd9IjHHA8PEJVeFwN3kDHtpzQIMJQ1FqX3d+3eI5QbGSTKs/lBzGRr3I0bM8xlYbXPqwZKPQdaa6OQEfzFLF9Jg0OIC4u1VPzUGmgCN6hY0kbSm3kGda4xqsTTkQoVqHhZVJ2+Sv++LRa92EHZ6l6EVS+NFKa9CvQg=
Received: from VI1PR05MB4607.eurprd05.prod.outlook.com (20.176.3.140) by
 VI1PR05MB3454.eurprd05.prod.outlook.com (10.170.239.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.31; Wed, 23 Jan 2019 22:32:00 +0000
Received: from VI1PR05MB4607.eurprd05.prod.outlook.com
 ([fe80::addb:3c9d:60ab:b4f7]) by VI1PR05MB4607.eurprd05.prod.outlook.com
 ([fe80::addb:3c9d:60ab:b4f7%6]) with mapi id 15.20.1558.016; Wed, 23 Jan 2019
 22:32:00 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     "jglisse@redhat.com" <jglisse@redhat.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        Jan Kara <jack@suse.cz>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 9/9] RDMA/umem_odp: optimize out the case when a range
 is updated to read only
Thread-Topic: [PATCH v4 9/9] RDMA/umem_odp: optimize out the case when a range
 is updated to read only
Thread-Index: AQHUs2pVbLg/IJ14+k+C+5Tg1GV8cKW9cAyA
Date:   Wed, 23 Jan 2019 22:32:00 +0000
Message-ID: <20190123223153.GP8986@mellanox.com>
References: <20190123222315.1122-1-jglisse@redhat.com>
 <20190123222315.1122-10-jglisse@redhat.com>
In-Reply-To: <20190123222315.1122-10-jglisse@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0070.namprd14.prod.outlook.com
 (2603:10b6:300:81::32) To VI1PR05MB4607.eurprd05.prod.outlook.com
 (2603:10a6:802:5f::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR05MB3454;6:9vInXa6wHz1JP+6b52tucd0ok9a2JuQ7V/HV8Cga5GGQ3uZUjzDg2BbKDGUCzs4uVbbmw2uuV58Ppr82d0hPmHRKjl3m2FbOwWeWHiBUzBXcBkny0dEfsgdRjzh6iTyWSsoKXh4lgNMl9w4kx7p5yQPXltjJ0jqDeOE888mnlyPVMpRUTHwyyk0gG9bqLVyn0uPvMiUX0J+o9Jue/Mtz+tNxmPvU/2ANfQwoDBGph7vsIHW9uOts1c9eBlQBcy14heXFzctwBoVa8VKXMJJGT8ipibGwKT4/s8qEbWCkY6m6UoMDEqllfj/2qzaSFXFulgFkk8Y+x08BrUIPqUWHESWVXpqbyCBxhXkC1bbD4U1uge9tJnFkp/IMWwW/GuKpi/kWdipc1DhL5MPrq3YCGMASbaCRxJ6aanTl6j2F1V5SPcbkZwsfiRXdQfc82CeeUiuFL7J6y6FsVsXip3hZIg==;5:QlEsfCk86dk2eNrj9zcUxldaOO0tICERztBiIZ/pGdLwMtUH5Y6H9TzTP9MlCtO+RWL7SLJmOBUs+6WWJUQaiYHArj5ZBUlJY9qphNL+e/vUCl19re6n/iYTHS3/jDpMrn78fNN9ljkG/T08i04cE3nFFvi99y8sbFLfOMZ4B90J60fpbUbluV9sO4mG51yhDowwbOKD0Ziv9uWZAyGNZw==;7:jNH8aASTC5ae2W4UdAudnTmQzYB/voIhtX+PGtLcK0veMRO8FfAowyCdgM/sYL60gMAFok6WOqGOu8Jp9Ncip3TSyTRUR/061gH0eCc4ZXNCJQaY7YTG9CfZRYucijFm8qDERFZ02qtjkvsNwdSFmA==
x-ms-office365-filtering-correlation-id: 2b0368ee-3e52-46e2-7b7d-08d681829712
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB3454;
x-ms-traffictypediagnostic: VI1PR05MB3454:
x-microsoft-antispam-prvs: <VI1PR05MB3454DB55D0BFDD99B562E375CF990@VI1PR05MB3454.eurprd05.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(366004)(346002)(376002)(199004)(189003)(1730700003)(186003)(81156014)(2906002)(7736002)(15650500001)(2501003)(14444005)(256004)(7416002)(8676002)(81166006)(26005)(6436002)(106356001)(5640700003)(86362001)(2351001)(6116002)(305945005)(8936002)(97736004)(229853002)(105586002)(6486002)(3846002)(54906003)(14454004)(6512007)(476003)(4326008)(53936002)(25786009)(1076003)(446003)(6246003)(486006)(33656002)(71200400001)(71190400001)(316002)(99286004)(68736007)(6506007)(52116002)(102836004)(76176011)(66574012)(36756003)(66066001)(6916009)(386003)(11346002)(478600001)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3454;H:VI1PR05MB4607.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8qF6+8sx+ck8cGS6rqrxF8VJrLcj4uC2+/mI9S4+E6aPQa3altyJS9AYrOP9LgaXghO4QtFw6CpNvDh5rg23KT2/0o5bL6cQBM5Iiowx524+mO4LP8eBKm8dOAxyOXFkKNBfLvAcE9LgMYJIEQWjNlKc3s0c+BwBms9JOFRpLzFeOh8bv4BwjT0Hikh95JyHNb11F9IzZlwDcwZxaqcngWldlp57g36od9A6taaOmFt2MSeNuH/T6kKhZO4qqnvZaGNIRy4DnVXYeUX7ddrmS+8L4vsmnR+yiBKuqjyzo5R+MCpt6etg5m9A5wq9rN3/L6QEZEcgIb+KFFpvUazcANf8mTo1Sgz621hD2YxSJw6qKHXNxVheTHgZgJbiXl/1cnjEpnWC99cHUtLT3hNnIKGyjUm/i8C1VOyStNFvbHI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <19C285F8CDFF0C43B3E8C91122C9998E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0368ee-3e52-46e2-7b7d-08d681829712
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 22:31:59.9806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKYW4gMjMsIDIwMTkgYXQgMDU6MjM6MTVQTSAtMDUwMCwgamdsaXNzZUByZWRoYXQu
Y29tIHdyb3RlOg0KPiBGcm9tOiBKw6lyw7RtZSBHbGlzc2UgPGpnbGlzc2VAcmVkaGF0LmNvbT4N
Cj4gDQo+IFdoZW4gcmFuZ2Ugb2YgdmlydHVhbCBhZGRyZXNzIGlzIHVwZGF0ZWQgcmVhZCBvbmx5
IGFuZCBjb3JyZXNwb25kaW5nDQo+IHVzZXIgcHRyIG9iamVjdCBhcmUgYWxyZWFkeSByZWFkIG9u
bHkgaXQgaXMgcG9pbnRsZXNzIHRvIGRvIGFueXRoaW5nLg0KPiBPcHRpbWl6ZSB0aGlzIGNhc2Ug
b3V0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSsOpcsO0bWUgR2xpc3NlIDxqZ2xpc3NlQHJlZGhh
dC5jb20+DQo+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
DQo+IENjOiBKYW4gS2FyYSA8amFja0BzdXNlLmN6Pg0KPiBDYzogRmVsaXggS3VlaGxpbmcgPEZl
bGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IENjOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BtZWxsYW5v
eC5jb20+DQo+IENjOiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0K
PiBDYzogTWF0dGhldyBXaWxjb3ggPG1hd2lsY294QG1pY3Jvc29mdC5jb20+DQo+IENjOiBSb3Nz
IFp3aXNsZXIgPHp3aXNsZXJAa2VybmVsLm9yZz4NCj4gQ2M6IERhbiBXaWxsaWFtcyA8ZGFuLmou
d2lsbGlhbXNAaW50ZWwuY29tPg0KPiBDYzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0
LmNvbT4NCj4gQ2M6IFJhZGltIEtyxI1tw6HFmSA8cmtyY21hckByZWRoYXQuY29tPg0KPiBDYzog
TWljaGFsIEhvY2tvIDxtaG9ja29Aa2VybmVsLm9yZz4NCj4gQ2M6IFJhbHBoIENhbXBiZWxsIDxy
Y2FtcGJlbGxAbnZpZGlhLmNvbT4NCj4gQ2M6IEpvaG4gSHViYmFyZCA8amh1YmJhcmRAbnZpZGlh
LmNvbT4NCj4gQ2M6IGt2bUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnDQo+IENjOiBs
aW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogQXJuZCBCZXJnbWFubiA8YXJuZEBh
cm5kYi5kZT4NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL3VtZW1fb2RwLmMgfCAyMiArKysr
KysrKysrKysrKysrKysrLS0tDQo+ICBpbmNsdWRlL3JkbWEvaWJfdW1lbV9vZHAuaCAgICAgICAg
IHwgIDEgKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL3VtZW1fb2Rw
LmMgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS91bWVtX29kcC5jDQo+IGluZGV4IGE0ZWM0MzA5
M2NiMy4uZmE0ZTdmZGNhYmZjIDEwMDY0NA0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvY29y
ZS91bWVtX29kcC5jDQo+IEBAIC0xNDAsOCArMTQwLDE1IEBAIHN0YXRpYyB2b2lkIGliX3VtZW1f
bm90aWZpZXJfcmVsZWFzZShzdHJ1Y3QgbW11X25vdGlmaWVyICptbiwNCj4gIHN0YXRpYyBpbnQg
aW52YWxpZGF0ZV9yYW5nZV9zdGFydF90cmFtcG9saW5lKHN0cnVjdCBpYl91bWVtX29kcCAqaXRl
bSwNCj4gIAkJCQkJICAgICB1NjQgc3RhcnQsIHU2NCBlbmQsIHZvaWQgKmNvb2tpZSkNCj4gIHsN
Cj4gKwlib29sIHVwZGF0ZV90b19yZWFkX29ubHkgPSAqKChib29sICopY29va2llKTsNCj4gKw0K
PiAgCWliX3VtZW1fbm90aWZpZXJfc3RhcnRfYWNjb3VudChpdGVtKTsNCj4gLQlpdGVtLT51bWVt
LmNvbnRleHQtPmludmFsaWRhdGVfcmFuZ2UoaXRlbSwgc3RhcnQsIGVuZCk7DQo+ICsJLyoNCj4g
KwkgKiBJZiBpdCBpcyBhbHJlYWR5IHJlYWQgb25seSBhbmQgd2UgYXJlIHVwZGF0aW5nIHRvIHJl
YWQgb25seSB0aGVuIHdlDQo+ICsJICogZG8gbm90IG5lZWQgdG8gY2hhbmdlIGFueXRoaW5nLiBT
byBzYXZlIHRpbWUgYW5kIHNraXAgdGhpcyBvbmUuDQo+ICsJICovDQo+ICsJaWYgKCF1cGRhdGVf
dG9fcmVhZF9vbmx5IHx8ICFpdGVtLT5yZWFkX29ubHkpDQo+ICsJCWl0ZW0tPnVtZW0uY29udGV4
dC0+aW52YWxpZGF0ZV9yYW5nZShpdGVtLCBzdGFydCwgZW5kKTsNCj4gIAlyZXR1cm4gMDsNCj4g
IH0NCj4gIA0KPiBAQCAtMTUwLDYgKzE1Nyw3IEBAIHN0YXRpYyBpbnQgaWJfdW1lbV9ub3RpZmll
cl9pbnZhbGlkYXRlX3JhbmdlX3N0YXJ0KHN0cnVjdCBtbXVfbm90aWZpZXIgKm1uLA0KPiAgew0K
PiAgCXN0cnVjdCBpYl91Y29udGV4dF9wZXJfbW0gKnBlcl9tbSA9DQo+ICAJCWNvbnRhaW5lcl9v
Zihtbiwgc3RydWN0IGliX3Vjb250ZXh0X3Blcl9tbSwgbW4pOw0KPiArCWJvb2wgdXBkYXRlX3Rv
X3JlYWRfb25seTsNCj4gIA0KPiAgCWlmIChyYW5nZS0+YmxvY2thYmxlKQ0KPiAgCQlkb3duX3Jl
YWQoJnBlcl9tbS0+dW1lbV9yd3NlbSk7DQo+IEBAIC0xNjYsMTAgKzE3NCwxMyBAQCBzdGF0aWMg
aW50IGliX3VtZW1fbm90aWZpZXJfaW52YWxpZGF0ZV9yYW5nZV9zdGFydChzdHJ1Y3QgbW11X25v
dGlmaWVyICptbiwNCj4gIAkJcmV0dXJuIDA7DQo+ICAJfQ0KPiAgDQo+ICsJdXBkYXRlX3RvX3Jl
YWRfb25seSA9IG1tdV9ub3RpZmllcl9yYW5nZV91cGRhdGVfdG9fcmVhZF9vbmx5KHJhbmdlKTsN
Cj4gKw0KPiAgCXJldHVybiByYnRfaWJfdW1lbV9mb3JfZWFjaF9pbl9yYW5nZSgmcGVyX21tLT51
bWVtX3RyZWUsIHJhbmdlLT5zdGFydCwNCj4gIAkJCQkJICAgICByYW5nZS0+ZW5kLA0KPiAgCQkJ
CQkgICAgIGludmFsaWRhdGVfcmFuZ2Vfc3RhcnRfdHJhbXBvbGluZSwNCj4gLQkJCQkJICAgICBy
YW5nZS0+YmxvY2thYmxlLCBOVUxMKTsNCj4gKwkJCQkJICAgICByYW5nZS0+YmxvY2thYmxlLA0K
PiArCQkJCQkgICAgICZ1cGRhdGVfdG9fcmVhZF9vbmx5KTsNCj4gIH0NCj4gIA0KPiAgc3RhdGlj
IGludCBpbnZhbGlkYXRlX3JhbmdlX2VuZF90cmFtcG9saW5lKHN0cnVjdCBpYl91bWVtX29kcCAq
aXRlbSwgdTY0IHN0YXJ0LA0KPiBAQCAtMzYzLDYgKzM3NCw5IEBAIHN0cnVjdCBpYl91bWVtX29k
cCAqaWJfYWxsb2Nfb2RwX3VtZW0oc3RydWN0IGliX3Vjb250ZXh0X3Blcl9tbSAqcGVyX21tLA0K
PiAgCQlnb3RvIG91dF9vZHBfZGF0YTsNCj4gIAl9DQo+ICANCj4gKwkvKiBBc3N1bWUgcmVhZCBv
bmx5IGF0IGZpcnN0LCBlYWNoIHRpbWUgR1VQIGlzIGNhbGwgdGhpcyBpcyB1cGRhdGVkLiAqLw0K
PiArCW9kcF9kYXRhLT5yZWFkX29ubHkgPSB0cnVlOw0KPiArDQo+ICAJb2RwX2RhdGEtPmRtYV9s
aXN0ID0NCj4gIAkJdnphbGxvYyhhcnJheV9zaXplKHBhZ2VzLCBzaXplb2YoKm9kcF9kYXRhLT5k
bWFfbGlzdCkpKTsNCj4gIAlpZiAoIW9kcF9kYXRhLT5kbWFfbGlzdCkgew0KPiBAQCAtNjE5LDgg
KzYzMywxMCBAQCBpbnQgaWJfdW1lbV9vZHBfbWFwX2RtYV9wYWdlcyhzdHJ1Y3QgaWJfdW1lbV9v
ZHAgKnVtZW1fb2RwLCB1NjQgdXNlcl92aXJ0LA0KPiAgCQlnb3RvIG91dF9wdXRfdGFzazsNCj4g
IAl9DQo+ICANCj4gLQlpZiAoYWNjZXNzX21hc2sgJiBPRFBfV1JJVEVfQUxMT1dFRF9CSVQpDQo+
ICsJaWYgKGFjY2Vzc19tYXNrICYgT0RQX1dSSVRFX0FMTE9XRURfQklUKSB7DQo+ICsJCXVtZW1f
b2RwLT5yZWFkX29ubHkgPSBmYWxzZTsNCg0KTm8gbG9ja2luZz8NCg0KPiAgCQlmbGFncyB8PSBG
T0xMX1dSSVRFOw0KPiArCX0NCj4gIA0KPiAgCXN0YXJ0X2lkeCA9ICh1c2VyX3ZpcnQgLSBpYl91
bWVtX3N0YXJ0KHVtZW0pKSA+PiBwYWdlX3NoaWZ0Ow0KPiAgCWsgPSBzdGFydF9pZHg7DQo+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL3JkbWEvaWJfdW1lbV9vZHAuaCBiL2luY2x1ZGUvcmRtYS9pYl91
bWVtX29kcC5oDQo+IGluZGV4IDBiMTQ0NmZlMmZhYi4uODI1NjY2OGM2MTcwIDEwMDY0NA0KPiAr
KysgYi9pbmNsdWRlL3JkbWEvaWJfdW1lbV9vZHAuaA0KPiBAQCAtNzYsNiArNzYsNyBAQCBzdHJ1
Y3QgaWJfdW1lbV9vZHAgew0KPiAgCXN0cnVjdCBjb21wbGV0aW9uCW5vdGlmaWVyX2NvbXBsZXRp
b247DQo+ICAJaW50CQkJZHlpbmc7DQo+ICAJc3RydWN0IHdvcmtfc3RydWN0CXdvcms7DQo+ICsJ
Ym9vbCByZWFkX29ubHk7DQo+ICB9Ow0KDQpUaGUgaWJfdW1lbSBhbHJlYWR5IGhhcyBhIHdyaXRl
YWJsZSBmbGFnLiBUaGlzIHJlZmxlY3RzIGlmIHRoZSB1c2VyDQphc2tlZCBmb3Igd3JpdGUgcGVy
bWlzc2lvbiB0byBiZSBncmFudGVkLi4gVGhlIHRyYWNraW5nIGhlcmUgaXMgaWYgYW55DQpyZW1v
dGUgZmF1bHQgdGh1cyBmYXIgaGFzIHJlcXVlc3RlZCB3cml0ZSwgaXMgdGhpcyBhbiBpbXBvcnRh
bnQNCmRpZmZlcmVuY2UgdG8ganVzdGlmeSB0aGUgbmV3IGZsYWc/DQoNCkphc29uDQo=
