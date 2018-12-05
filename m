Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C4AC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8625B20879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PHXidmJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8625B20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeLEVmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:42:50 -0500
Received: from mail-eopbgr800048.outbound.protection.outlook.com ([40.107.80.48]:25572
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727278AbeLEVmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKMwFdbK2w12+UsjVGNpesYSRHjJmpaZz/IhibsItwU=;
 b=PHXidmJhU5CNHcuXRzVkL37LP1G+JRWLL+hwNibXTJ0aN3vOdlnYJ8mh4/3quCOG1h4g6ynQtyzFdaACS2YKzaNtI6Qm3ADyqw19DGwXbWXl/F+ObUcOwtbUPSOq71yBU18k6u+8x6jr/oTF07nz9g1isn2ls3+O9jVqSXHH+QE=
Received: from DM5PR12MB1707.namprd12.prod.outlook.com (10.175.89.136) by
 DM5PR12MB1514.namprd12.prod.outlook.com (10.172.39.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Wed, 5 Dec 2018 21:42:45 +0000
Received: from DM5PR12MB1707.namprd12.prod.outlook.com
 ([fe80::6c3e:bc59:80d9:d17d]) by DM5PR12MB1707.namprd12.prod.outlook.com
 ([fe80::6c3e:bc59:80d9:d17d%3]) with mapi id 15.20.1404.016; Wed, 5 Dec 2018
 21:42:45 +0000
From:   "Kuehling, Felix" <Felix.Kuehling@amd.com>
To:     "jglisse@redhat.com" <jglisse@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <zwisler@kernel.org>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] mm/mmu_notifier: use structure for
 invalidate_range_start/end callback
Thread-Topic: [PATCH v2 1/3] mm/mmu_notifier: use structure for
 invalidate_range_start/end callback
Thread-Index: AQHUjFySPulSYcO6VE6A1hHsSlKmSaVwri6A
Date:   Wed, 5 Dec 2018 21:42:45 +0000
Message-ID: <b76dfbdd-a017-4032-d8a1-860ff62dfb59@amd.com>
References: <20181205053628.3210-1-jglisse@redhat.com>
 <20181205053628.3210-2-jglisse@redhat.com>
In-Reply-To: <20181205053628.3210-2-jglisse@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-clientproxiedby: YTOPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::40) To DM5PR12MB1707.namprd12.prod.outlook.com
 (2603:10b6:3:10f::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1514;20:90WU9a5vioKQLV3sav+I1Umkx1du7R1u775gJ7zPxE/iSD5JZYKiUfB3FxM78OLRzsK67z8NxMjFP5ecJDb4Szqti9MpxPBeacfYNsMI7OWB+39SqBl4qcSJ7NjyC7tr3sCBWth5W6DSToke5iOc1dgptBAjalrs4yEbbe8wTy2beBvqGJp/2H65zl+9SOuSkmW76qBr+g3Buofbs7bGOfHrxLPEuH1HF1ntYbtaegFyjMfGZp02YFEBrsVQ0bk3
x-ms-office365-filtering-correlation-id: 8d3d97b6-c241-4623-d1f1-08d65afa978f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1514;
x-ms-traffictypediagnostic: DM5PR12MB1514:
x-microsoft-antispam-prvs: <DM5PR12MB1514EBA0402F0F6EA473DD3292A80@DM5PR12MB1514.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1514;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1514;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(366004)(39860400002)(189003)(199004)(72206003)(305945005)(4326008)(53936002)(66066001)(25786009)(105586002)(65956001)(7736002)(65806001)(478600001)(68736007)(6512007)(316002)(65826007)(36756003)(8936002)(64126003)(66574009)(5660300001)(71190400001)(71200400001)(81166006)(8676002)(81156014)(6506007)(386003)(446003)(53546011)(2501003)(99286004)(11346002)(3846002)(476003)(86362001)(6486002)(229853002)(97736004)(76176011)(52116002)(106356001)(54906003)(58126008)(110136005)(102836004)(31686004)(6246003)(14454004)(31696002)(14444005)(256004)(6436002)(2616005)(6116002)(26005)(186003)(2906002)(486006)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1514;H:DM5PR12MB1707.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +N/ZCG5arb1R6i/CJ9pYAZ/F1RXzE3Tf9rPXSM1TsPFyFGYHxBcXDRL44AV9gtLT27LKUivyWxiVThID6K3WvpdKckrmmrJ6i0/OnPG6nFIS9ZPySe4FSG/hIuerAxTKoKLuqjIqIlEEWjcb1W+A8WKjJtsXPnZ/5KCykDQ38pGdkun7AyGkKGARSvZy4Morcvibnek7BNSBjlMm6DN9yEXWVtl0YZ74l0uJTd8KdHzJOidmbXdNIjiAyTkbKKhoLRE41+aWOjFhzJ4R31TCuagDm5HxqDw8zFmeml9U4t/l4VTZi2TxfOO0Ki3raMfPBswDI3d4cF2Se72Oub0Ylhiug6UNvpP2WUzXe46Umgw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A207F0DF5E8C14E945C8F700F9AA796@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3d97b6-c241-4623-d1f1-08d65afa978f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 21:42:45.5496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1514
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGFtZGdwdSBwYXJ0IGxvb2tzIGdvb2QgdG8gbWUuDQoNCkEgbWlub3Igbml0LXBpY2sgaW4g
bW11X25vdGlmaWVyLmMgKGlubGluZSkuDQoNCkVpdGhlciB3YXksIHRoZSBzZXJpZXMgaXMgQWNr
ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KDQpPbiAyMDE4
LTEyLTA1IDEyOjM2IGEubS4sIGpnbGlzc2VAcmVkaGF0LmNvbSB3cm90ZToNCj4gRnJvbTogSsOp
csO0bWUgR2xpc3NlIDxqZ2xpc3NlQHJlZGhhdC5jb20+DQo+DQo+IFRvIGF2b2lkIGhhdmluZyB0
byBjaGFuZ2UgbWFueSBjYWxsYmFjayBkZWZpbml0aW9uIGV2ZXJ5dGltZSB3ZSB3YW50DQo+IHRv
IGFkZCBhIHBhcmFtZXRlciB1c2UgYSBzdHJ1Y3R1cmUgdG8gZ3JvdXAgYWxsIHBhcmFtZXRlcnMg
Zm9yIHRoZQ0KPiBtbXVfbm90aWZpZXIgaW52YWxpZGF0ZV9yYW5nZV9zdGFydC9lbmQgY2FsbGJh
Y2suIE5vIGZ1bmN0aW9uYWwgY2hhbmdlcw0KPiB3aXRoIHRoaXMgcGF0Y2guDQo+DQo+IFNpZ25l
ZC1vZmYtYnk6IErDqXLDtG1lIEdsaXNzZSA8amdsaXNzZUByZWRoYXQuY29tPg0KPiBDYzogQW5k
cmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCj4gQ2M6IE1hdHRoZXcgV2ls
Y294IDxtYXdpbGNveEBtaWNyb3NvZnQuY29tPg0KPiBDYzogUm9zcyBad2lzbGVyIDx6d2lzbGVy
QGtlcm5lbC5vcmc+DQo+IENjOiBKYW4gS2FyYSA8amFja0BzdXNlLmN6Pg0KPiBDYzogRGFuIFdp
bGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+IENjOiBQYW9sbyBCb256aW5pIDxw
Ym9uemluaUByZWRoYXQuY29tPg0KPiBDYzogUmFkaW0gS3LEjW3DocWZIDxya3JjbWFyQHJlZGhh
dC5jb20+DQo+IENjOiBNaWNoYWwgSG9ja28gPG1ob2Nrb0BrZXJuZWwub3JnPg0KPiBDYzogQ2hy
aXN0aWFuIEtvZW5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiBDYzogRmVsaXggS3Vl
aGxpbmcgPGZlbGl4Lmt1ZWhsaW5nQGFtZC5jb20+DQo+IENjOiBSYWxwaCBDYW1wYmVsbCA8cmNh
bXBiZWxsQG52aWRpYS5jb20+DQo+IENjOiBKb2huIEh1YmJhcmQgPGpodWJiYXJkQG52aWRpYS5j
b20+DQo+IENjOiBrdm1Admdlci5rZXJuZWwub3JnDQo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQo+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGlu
dXgtZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmcNCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfbW4uYyAgfCA0MyArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tDQo+ICBk
cml2ZXJzL2dwdS9kcm0vaTkxNS9pOTE1X2dlbV91c2VycHRyLmMgfCAxNCArKysrLS0tLQ0KPiAg
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fbW4uYyAgICAgIHwgMTYgKysrKy0tLS0tDQo+
ICBkcml2ZXJzL2luZmluaWJhbmQvY29yZS91bWVtX29kcC5jICAgICAgfCAyMCArKysrKy0tLS0t
LS0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9oZmkxL21tdV9yYi5jICAgICB8IDEzICsrKy0t
LS0tDQo+ICBkcml2ZXJzL21pc2MvbWljL3NjaWYvc2NpZl9kbWEuYyAgICAgICAgfCAxMSArKy0t
LS0tDQo+ICBkcml2ZXJzL21pc2Mvc2dpLWdydS9ncnV0bGJwdXJnZS5jICAgICAgfCAxNCArKysr
LS0tLQ0KPiAgZHJpdmVycy94ZW4vZ250ZGV2LmMgICAgICAgICAgICAgICAgICAgIHwgMTIgKysr
LS0tLQ0KPiAgaW5jbHVkZS9saW51eC9tbXVfbm90aWZpZXIuaCAgICAgICAgICAgIHwgMTQgKysr
KystLS0NCj4gIG1tL2htbS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDIzICsr
KysrKy0tLS0tLS0NCj4gIG1tL21tdV9ub3RpZmllci5jICAgICAgICAgICAgICAgICAgICAgICB8
IDIxICsrKysrKysrKystLQ0KPiAgdmlydC9rdm0va3ZtX21haW4uYyAgICAgICAgICAgICAgICAg
ICAgIHwgMTQgKysrLS0tLS0NCj4gIDEyIGZpbGVzIGNoYW5nZWQsIDEwMiBpbnNlcnRpb25zKCsp
LCAxMTMgZGVsZXRpb25zKC0pDQo+DQpbc25pcF0NCj4gZGlmZiAtLWdpdCBhL21tL21tdV9ub3Rp
Zmllci5jIGIvbW0vbW11X25vdGlmaWVyLmMNCj4gaW5kZXggNTExOWZmODQ2NzY5Li41ZjY2NjVh
ZTNlZTIgMTAwNjQ0DQo+IC0tLSBhL21tL21tdV9ub3RpZmllci5jDQo+ICsrKyBiL21tL21tdV9u
b3RpZmllci5jDQo+IEBAIC0xNzgsMTQgKzE3OCwyMCBAQCBpbnQgX19tbXVfbm90aWZpZXJfaW52
YWxpZGF0ZV9yYW5nZV9zdGFydChzdHJ1Y3QgbW1fc3RydWN0ICptbSwNCj4gIAkJCQkgIHVuc2ln
bmVkIGxvbmcgc3RhcnQsIHVuc2lnbmVkIGxvbmcgZW5kLA0KPiAgCQkJCSAgYm9vbCBibG9ja2Fi
bGUpDQo+ICB7DQo+ICsJc3RydWN0IG1tdV9ub3RpZmllcl9yYW5nZSBfcmFuZ2UsICpyYW5nZSA9
ICZfcmFuZ2U7DQoNCkknbSBub3Qgc3VyZSB3aHkgeW91IG5lZWQgdG8gYWNjZXNzIF9yYW5nZSBp
bmRpcmVjdGx5IHRocm91Z2ggYSBwb2ludGVyLg0KU2VlIGJlbG93Lg0KDQoNCj4gIAlzdHJ1Y3Qg
bW11X25vdGlmaWVyICptbjsNCj4gIAlpbnQgcmV0ID0gMDsNCj4gIAlpbnQgaWQ7DQo+ICANCj4g
KwlyYW5nZS0+YmxvY2thYmxlID0gYmxvY2thYmxlOw0KPiArCXJhbmdlLT5zdGFydCA9IHN0YXJ0
Ow0KPiArCXJhbmdlLT5lbmQgPSBlbmQ7DQo+ICsJcmFuZ2UtPm1tID0gbW07DQoNClRoaXMgY291
bGQganVzdCBhc3NpZ24gX3JhbmdlLmJsb2NrYWJsZSwgX3JhbmdlLnN0YXJ0LCBldGMuIHdpdGhv
dXQgdGhlDQppbmRpcmVjdGlvbi4gT3IgeW91IGNvdWxkIGV2ZW4gdXNlIGFuIGluaXRpYWxpemVy
IGluc3RlYWQ6DQoNCnN0cnVjdCBtbXVfbm90aWZpZXJfcmFuZ2UgcmFuZ2UgPSB7DQrCoMKgwqAg
LmJsb2NrYWJsZSA9IGJsb2NrYWJsZSwNCsKgwqDCoCAuc3RhcnQgPSBzdGFydCwNCsKgwqDCoCAu
Li4NCn07DQoNCg0KPiArDQo+ICAJaWQgPSBzcmN1X3JlYWRfbG9jaygmc3JjdSk7DQo+ICAJaGxp
c3RfZm9yX2VhY2hfZW50cnlfcmN1KG1uLCAmbW0tPm1tdV9ub3RpZmllcl9tbS0+bGlzdCwgaGxp
c3QpIHsNCj4gIAkJaWYgKG1uLT5vcHMtPmludmFsaWRhdGVfcmFuZ2Vfc3RhcnQpIHsNCj4gLQkJ
CWludCBfcmV0ID0gbW4tPm9wcy0+aW52YWxpZGF0ZV9yYW5nZV9zdGFydChtbiwgbW0sIHN0YXJ0
LCBlbmQsIGJsb2NrYWJsZSk7DQo+ICsJCQlpbnQgX3JldCA9IG1uLT5vcHMtPmludmFsaWRhdGVf
cmFuZ2Vfc3RhcnQobW4sIHJhbmdlKTsNCg0KVGhpcyBjb3VsZCBqdXN0IHVzZSAmX3JhbmdlIHdp
dGhvdXQgdGhlIGluZGlyZWN0aW9uLg0KDQpTYW1lIGluIC4uLl9pbnZhbGlkYXRlX3JhbmdlX2Vu
ZCBiZWxvdy4NCg0KUmVnYXJkcywNCsKgIEZlbGl4DQoNCg0KPiAgCQkJaWYgKF9yZXQpIHsNCj4g
IAkJCQlwcl9pbmZvKCIlcFMgY2FsbGJhY2sgZmFpbGVkIHdpdGggJWQgaW4gJXNibG9ja2FibGUg
Y29udGV4dC5cbiIsDQo+ICAJCQkJCQltbi0+b3BzLT5pbnZhbGlkYXRlX3JhbmdlX3N0YXJ0LCBf
cmV0LA0KPiBAQCAtMjA1LDkgKzIxMSwyMCBAQCB2b2lkIF9fbW11X25vdGlmaWVyX2ludmFsaWRh
dGVfcmFuZ2VfZW5kKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLA0KPiAgCQkJCQkgdW5zaWduZWQgbG9u
ZyBlbmQsDQo+ICAJCQkJCSBib29sIG9ubHlfZW5kKQ0KPiAgew0KPiArCXN0cnVjdCBtbXVfbm90
aWZpZXJfcmFuZ2UgX3JhbmdlLCAqcmFuZ2UgPSAmX3JhbmdlOw0KPiAgCXN0cnVjdCBtbXVfbm90
aWZpZXIgKm1uOw0KPiAgCWludCBpZDsNCj4gIA0KPiArCS8qDQo+ICsJICogVGhlIGVuZCBjYWxs
IGJhY2sgd2lsbCBuZXZlciBiZSBjYWxsIGlmIHRoZSBzdGFydCByZWZ1c2VkIHRvIGdvDQo+ICsJ
ICogdGhyb3VnaCBiZWNhdXNlIG9mIGJsb2NrYWJsZSB3YXMgZmFsc2Ugc28gaGVyZSBhc3N1bWUg
dGhhdCB3ZQ0KPiArCSAqIGNhbiBibG9jay4NCj4gKwkgKi8NCj4gKwlyYW5nZS0+YmxvY2thYmxl
ID0gdHJ1ZTsNCj4gKwlyYW5nZS0+c3RhcnQgPSBzdGFydDsNCj4gKwlyYW5nZS0+ZW5kID0gZW5k
Ow0KPiArCXJhbmdlLT5tbSA9IG1tOw0KPiArDQo+ICAJaWQgPSBzcmN1X3JlYWRfbG9jaygmc3Jj
dSk7DQo+ICAJaGxpc3RfZm9yX2VhY2hfZW50cnlfcmN1KG1uLCAmbW0tPm1tdV9ub3RpZmllcl9t
bS0+bGlzdCwgaGxpc3QpIHsNCj4gIAkJLyoNCj4gQEAgLTIyNiw3ICsyNDMsNyBAQCB2b2lkIF9f
bW11X25vdGlmaWVyX2ludmFsaWRhdGVfcmFuZ2VfZW5kKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLA0K
PiAgCQlpZiAoIW9ubHlfZW5kICYmIG1uLT5vcHMtPmludmFsaWRhdGVfcmFuZ2UpDQo+ICAJCQlt
bi0+b3BzLT5pbnZhbGlkYXRlX3JhbmdlKG1uLCBtbSwgc3RhcnQsIGVuZCk7DQo+ICAJCWlmICht
bi0+b3BzLT5pbnZhbGlkYXRlX3JhbmdlX2VuZCkNCj4gLQkJCW1uLT5vcHMtPmludmFsaWRhdGVf
cmFuZ2VfZW5kKG1uLCBtbSwgc3RhcnQsIGVuZCk7DQo+ICsJCQltbi0+b3BzLT5pbnZhbGlkYXRl
X3JhbmdlX2VuZChtbiwgcmFuZ2UpOw0KPiAgCX0NCj4gIAlzcmN1X3JlYWRfdW5sb2NrKCZzcmN1
LCBpZCk7DQo+ICB9DQo+IGRpZmYgLS1naXQgYS92aXJ0L2t2bS9rdm1fbWFpbi5jIGIvdmlydC9r
dm0va3ZtX21haW4uYw0KPiBpbmRleCAyNjc5ZTQ3NmI2YzMuLmY4MjlmNjNmMmIxNiAxMDA2NDQN
Cj4gLS0tIGEvdmlydC9rdm0va3ZtX21haW4uYw0KPiArKysgYi92aXJ0L2t2bS9rdm1fbWFpbi5j
DQo+IEBAIC0zNjAsMTAgKzM2MCw3IEBAIHN0YXRpYyB2b2lkIGt2bV9tbXVfbm90aWZpZXJfY2hh
bmdlX3B0ZShzdHJ1Y3QgbW11X25vdGlmaWVyICptbiwNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGlu
dCBrdm1fbW11X25vdGlmaWVyX2ludmFsaWRhdGVfcmFuZ2Vfc3RhcnQoc3RydWN0IG1tdV9ub3Rp
ZmllciAqbW4sDQo+IC0JCQkJCQkgICAgc3RydWN0IG1tX3N0cnVjdCAqbW0sDQo+IC0JCQkJCQkg
ICAgdW5zaWduZWQgbG9uZyBzdGFydCwNCj4gLQkJCQkJCSAgICB1bnNpZ25lZCBsb25nIGVuZCwN
Cj4gLQkJCQkJCSAgICBib29sIGJsb2NrYWJsZSkNCj4gKwkJCQkJY29uc3Qgc3RydWN0IG1tdV9u
b3RpZmllcl9yYW5nZSAqcmFuZ2UpDQo+ICB7DQo+ICAJc3RydWN0IGt2bSAqa3ZtID0gbW11X25v
dGlmaWVyX3RvX2t2bShtbik7DQo+ICAJaW50IG5lZWRfdGxiX2ZsdXNoID0gMCwgaWR4Ow0KPiBA
QCAtMzc3LDcgKzM3NCw3IEBAIHN0YXRpYyBpbnQga3ZtX21tdV9ub3RpZmllcl9pbnZhbGlkYXRl
X3JhbmdlX3N0YXJ0KHN0cnVjdCBtbXVfbm90aWZpZXIgKm1uLA0KPiAgCSAqIGNvdW50IGlzIGFs
c28gcmVhZCBpbnNpZGUgdGhlIG1tdV9sb2NrIGNyaXRpY2FsIHNlY3Rpb24uDQo+ICAJICovDQo+
ICAJa3ZtLT5tbXVfbm90aWZpZXJfY291bnQrKzsNCj4gLQluZWVkX3RsYl9mbHVzaCA9IGt2bV91
bm1hcF9odmFfcmFuZ2Uoa3ZtLCBzdGFydCwgZW5kKTsNCj4gKwluZWVkX3RsYl9mbHVzaCA9IGt2
bV91bm1hcF9odmFfcmFuZ2Uoa3ZtLCByYW5nZS0+c3RhcnQsIHJhbmdlLT5lbmQpOw0KPiAgCW5l
ZWRfdGxiX2ZsdXNoIHw9IGt2bS0+dGxic19kaXJ0eTsNCj4gIAkvKiB3ZSd2ZSB0byBmbHVzaCB0
aGUgdGxiIGJlZm9yZSB0aGUgcGFnZXMgY2FuIGJlIGZyZWVkICovDQo+ICAJaWYgKG5lZWRfdGxi
X2ZsdXNoKQ0KPiBAQCAtMzg1LDcgKzM4Miw4IEBAIHN0YXRpYyBpbnQga3ZtX21tdV9ub3RpZmll
cl9pbnZhbGlkYXRlX3JhbmdlX3N0YXJ0KHN0cnVjdCBtbXVfbm90aWZpZXIgKm1uLA0KPiAgDQo+
ICAJc3Bpbl91bmxvY2soJmt2bS0+bW11X2xvY2spOw0KPiAgDQo+IC0JcmV0ID0ga3ZtX2FyY2hf
bW11X25vdGlmaWVyX2ludmFsaWRhdGVfcmFuZ2Uoa3ZtLCBzdGFydCwgZW5kLCBibG9ja2FibGUp
Ow0KPiArCXJldCA9IGt2bV9hcmNoX21tdV9ub3RpZmllcl9pbnZhbGlkYXRlX3JhbmdlKGt2bSwg
cmFuZ2UtPnN0YXJ0LA0KPiArCQkJCQlyYW5nZS0+ZW5kLCByYW5nZS0+YmxvY2thYmxlKTsNCj4g
IA0KPiAgCXNyY3VfcmVhZF91bmxvY2soJmt2bS0+c3JjdSwgaWR4KTsNCj4gIA0KPiBAQCAtMzkz
LDkgKzM5MSw3IEBAIHN0YXRpYyBpbnQga3ZtX21tdV9ub3RpZmllcl9pbnZhbGlkYXRlX3Jhbmdl
X3N0YXJ0KHN0cnVjdCBtbXVfbm90aWZpZXIgKm1uLA0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9p
ZCBrdm1fbW11X25vdGlmaWVyX2ludmFsaWRhdGVfcmFuZ2VfZW5kKHN0cnVjdCBtbXVfbm90aWZp
ZXIgKm1uLA0KPiAtCQkJCQkJICBzdHJ1Y3QgbW1fc3RydWN0ICptbSwNCj4gLQkJCQkJCSAgdW5z
aWduZWQgbG9uZyBzdGFydCwNCj4gLQkJCQkJCSAgdW5zaWduZWQgbG9uZyBlbmQpDQo+ICsJCQkJ
CWNvbnN0IHN0cnVjdCBtbXVfbm90aWZpZXJfcmFuZ2UgKnJhbmdlKQ0KPiAgew0KPiAgCXN0cnVj
dCBrdm0gKmt2bSA9IG1tdV9ub3RpZmllcl90b19rdm0obW4pOw0KPiAgDQo=
