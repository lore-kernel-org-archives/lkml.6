Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CB4C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED4E2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4pT5zdmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfAXMbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 07:31:39 -0500
Received: from mail-eopbgr780049.outbound.protection.outlook.com ([40.107.78.49]:4000
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727665AbfAXMbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 07:31:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zem/NLEfCCT83vuerTISDi0hKUZgi+GBO72d+fegUzE=;
 b=4pT5zdmqtPbdIaQCORSDugwyLJQw/WXE9PC6wj6vQp5F/A2waXeB1acdVozLza1CLSzEfZO7Np0DA71I3Jg7U84IGqNb7pQTiByQp4xuedMWVdZr1FP59z5ccSWGv0pFICubFF1/a91D2ivZ6zXkTWOYMQhGoy4jm6s3HqAhl+U=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB1786.namprd12.prod.outlook.com (10.175.91.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.31; Thu, 24 Jan 2019 12:31:33 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::35a3:c1b4:5ad0:ec6e]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::35a3:c1b4:5ad0:ec6e%10]) with mapi id 15.20.1558.016; Thu, 24 Jan
 2019 12:31:33 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Zhang, Jerry" <Jerry.Zhang@amd.com>,
        "Daenzer, Michel" <Michel.Daenzer@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Carsten Haitzler <Carsten.Haitzler@arm.com>
Subject: Re: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
Thread-Topic: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
Thread-Index: AQHUs91WkPVlhDut2EqHoBfS2x93tqW+WbOA
Date:   Thu, 24 Jan 2019 12:31:33 +0000
Message-ID: <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com>
References: <20190124120658.30288-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20190124120658.30288-1-ard.biesheuvel@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM6PR0502CA0057.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::34) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1786;20:RjtbeXqOfKvmQE3oVrJ8q1gMvP8+LwqDz8/mUUmS+h8AsoZ9uLElKlEacdDgFoEPKW/5FBGX31NU5K+jchpm6QNx0dfH4q6TUxkF6CSldyVfrc4jj+ikhQyYgsxHtdz0x2sZAAEKL/4swZOIuIbMYyawZOFfB8AP47bf7ee1YO6Xq4ASPDz4VyyR2SxEojJTOINgpsaQz9q9mrh+LSYvsUE/lB44ggaqTevlpEoHHnzRYEgb92qAVgXQMaLbQftM
x-ms-office365-filtering-correlation-id: b1d37c83-c928-4c68-2cfd-08d681f7dfe7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1786;
x-ms-traffictypediagnostic: DM5PR12MB1786:
x-microsoft-antispam-prvs: <DM5PR12MB178642629C1585342FD6F129839A0@DM5PR12MB1786.namprd12.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(99286004)(305945005)(53936002)(97736004)(31696002)(46003)(386003)(86362001)(8676002)(6506007)(65826007)(6246003)(256004)(2501003)(71200400001)(102836004)(71190400001)(7736002)(6116002)(186003)(36756003)(54906003)(110136005)(4326008)(6436002)(14454004)(58126008)(105586002)(229853002)(446003)(65806001)(72206003)(68736007)(2616005)(31686004)(106356001)(486006)(476003)(11346002)(65956001)(52116002)(316002)(76176011)(6486002)(81166006)(25786009)(7416002)(8936002)(64126003)(81156014)(478600001)(6512007)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1786;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +hCTn452IaDxoNupg7ClklXQ7daM2aOclJU8OfENFiKjG2kyJs8x7KIyUIqZS6BaVeq+ivgRHqfV018miuQkP9t1+/OvwiFPs9pRkHRG+NviuOMBATpFEHFsYL6g1QulkamwoSZtTjqUuULgyTqC2tiGgQDoOqxc8Ufois7+53koRJFU8V75KCi77VRA24vgyTh95FzWiYo2GyyPIeRDEmExk/jt2eg5nhVxguIpDojuNp+r5wzBc1GoKxIr+SzOFXH6meICL5VNFRmjp68Vt3ZFAHvz3vsaNdKuHwZQynVMyJc1dWxpqUKqkzZEd+unlpOCUMxxmduF1LK/tsXQhBHyLQCB+SvqNxH5CQnqK5BGLyGV4c0TEyD2Cnv5o3VSZlxL4LN86Ieujz8f+2q/YBZuQHSMv8i7vffrfnKxQHY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFDBC66C185C37408FF79FFB56393AD8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d37c83-c928-4c68-2cfd-08d681f7dfe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 12:31:28.8561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1786
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMjQuMDEuMTkgdW0gMTM6MDYgc2NocmllYiBBcmQgQmllc2hldXZlbDoNCj4gVGhlIERSTSBk
cml2ZXIgc3RhY2sgaXMgZGVzaWduZWQgdG8gd29yayB3aXRoIGNhY2hlIGNvaGVyZW50IGRldmlj
ZXMNCj4gb25seSwgYnV0IHBlcm1pdHMgYW4gb3B0aW1pemF0aW9uIHRvIGJlIGVuYWJsZWQgaW4g
c29tZSBjYXNlcywgd2hlcmUNCj4gZm9yIHNvbWUgYnVmZmVycywgYm90aCB0aGUgQ1BVIGFuZCB0
aGUgR1BVIHVzZSB1bmNhY2hlZCBtYXBwaW5ncywNCj4gcmVtb3ZpbmcgdGhlIG5lZWQgZm9yIERN
QSBzbm9vcGluZyBhbmQgYWxsb2NhdGlvbiBpbiB0aGUgQ1BVIGNhY2hlcy4NCj4NCj4gVGhlIHVz
ZSBvZiB1bmNhY2hlZCBHUFUgbWFwcGluZ3MgcmVsaWVzIG9uIHRoZSBjb3JyZWN0IGltcGxlbWVu
dGF0aW9uDQo+IG9mIHRoZSBQQ0llIE5vU25vb3AgVExQIGF0dHJpYnV0ZSBieSB0aGUgcGxhdGZv
cm0sIG90aGVyd2lzZSB0aGUgR1BVDQo+IHdpbGwgdXNlIGNhY2hlZCBtYXBwaW5ncyBub25ldGhl
bGVzcy4gT24geDg2IHBsYXRmb3JtcywgdGhpcyBkb2VzIG5vdA0KPiBzZWVtIHRvIG1hdHRlciwg
YXMgdW5jYWNoZWQgQ1BVIG1hcHBpbmdzIHdpbGwgc25vb3AgdGhlIGNhY2hlcyBpbiBhbnkNCj4g
Y2FzZS4gSG93ZXZlciwgb24gQVJNIGFuZCBhcm02NCwgZW5hYmxpbmcgdGhpcyBvcHRpbWl6YXRp
b24gb24gYQ0KPiBwbGF0Zm9ybSB3aGVyZSBOb1Nub29wIGlzIGlnbm9yZWQgcmVzdWx0cyBpbiBs
b3NzIG9mIGNvaGVyZW5jeSwgd2hpY2gNCj4gYnJlYWtzIGNvcnJlY3Qgb3BlcmF0aW9uIG9mIHRo
ZSBkZXZpY2UuIFNpbmNlIHdlIGhhdmUgbm8gd2F5IG9mDQo+IGRldGVjdGluZyB3aGV0aGVyIE5v
U25vb3Agd29ya3Mgb3Igbm90LCBqdXN0IGRpc2FibGUgdGhpcw0KPiBvcHRpbWl6YXRpb24gZW50
aXJlbHkgZm9yIEFSTSBhbmQgYXJtNjQuDQo+DQo+IENjOiBDaHJpc3RpYW4gS29lbmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+DQo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+DQo+IENjOiBEYXZpZCBaaG91IDxEYXZpZDEuWmhvdUBhbWQuY29tPg0KPiBD
YzogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4NCj4gQ2M6IEp1bndlaSBaaGFuZyA8SmVy
cnkuWmhhbmdAYW1kLmNvbT4NCj4gQ2M6IE1pY2hlbCBEYWVuemVyIDxtaWNoZWwuZGFlbnplckBh
bWQuY29tPg0KPiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPg0KPiBDYzogRGFu
aWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPg0KPiBDYzogTWFhcnRlbiBMYW5raG9yc3QgPG1h
YXJ0ZW4ubGFua2hvcnN0QGxpbnV4LmludGVsLmNvbT4NCj4gQ2M6IE1heGltZSBSaXBhcmQgPG1h
eGltZS5yaXBhcmRAYm9vdGxpbi5jb20+DQo+IENjOiBTZWFuIFBhdWwgPHNlYW5AcG9vcmx5LnJ1
bj4NCj4gQ2M6IE1pY2hhZWwgRWxsZXJtYW4gPG1wZUBlbGxlcm1hbi5pZC5hdT4NCj4gQ2M6IEJl
bmphbWluIEhlcnJlbnNjaG1pZHQgPGJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZz4NCj4gQ2M6IFdp
bGwgRGVhY29uIDx3aWxsLmRlYWNvbkBhcm0uY29tPg0KPiBDYzogQ2hyaXN0b3BoIEhlbGx3aWcg
PGhjaEBpbmZyYWRlYWQub3JnPg0KPiBDYzogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJt
LmNvbT4NCj4gQ2M6IGFtZC1nZnggbGlzdCA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+
DQo+IENjOiBkcmktZGV2ZWwgPGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+DQo+IFJl
cG9ydGVkLWJ5OiBDYXJzdGVuIEhhaXR6bGVyIDxDYXJzdGVuLkhhaXR6bGVyQGFybS5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IEFyZCBCaWVzaGV1dmVsIDxhcmQuYmllc2hldXZlbEBsaW5hcm8ub3Jn
Pg0KDQpUaGUgc3ViamVjdCBsaW5lIHNob3VsZCBwcm9iYWJseSByZWFkICJkaXNhYmxlIHVuY2Fj
aGVkLi4uIi4NCg0KV2l0aCB0aGF0IGZpeGVkIHRoZSBwYXRjaCBpcyBSZXZpZXdlZC1ieTogQ2hy
aXN0aWFuIEvDtm5pZyANCjxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Lg0KDQpSZWdhcmRzLA0K
Q2hyaXN0aWFuLg0KDQo+IC0tLQ0KPiAgIGluY2x1ZGUvZHJtL2RybV9jYWNoZS5oIHwgMTggKysr
KysrKysrKysrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykNCj4N
Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2RybV9jYWNoZS5oIGIvaW5jbHVkZS9kcm0vZHJt
X2NhY2hlLmgNCj4gaW5kZXggYmZlMTYzOWRmMDJkLi45N2ZjNDk4ZGM3NjcgMTAwNjQ0DQo+IC0t
LSBhL2luY2x1ZGUvZHJtL2RybV9jYWNoZS5oDQo+ICsrKyBiL2luY2x1ZGUvZHJtL2RybV9jYWNo
ZS5oDQo+IEBAIC00Nyw2ICs0NywyNCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgZHJtX2FyY2hfY2Fu
X3djX21lbW9yeSh2b2lkKQ0KPiAgIAlyZXR1cm4gZmFsc2U7DQo+ICAgI2VsaWYgZGVmaW5lZChD
T05GSUdfTUlQUykgJiYgZGVmaW5lZChDT05GSUdfQ1BVX0xPT05HU09OMykNCj4gICAJcmV0dXJu
IGZhbHNlOw0KPiArI2VsaWYgZGVmaW5lZChDT05GSUdfQVJNKSB8fCBkZWZpbmVkKENPTkZJR19B
Uk02NCkNCj4gKwkvKg0KPiArCSAqIFRoZSBEUk0gZHJpdmVyIHN0YWNrIGlzIGRlc2lnbmVkIHRv
IHdvcmsgd2l0aCBjYWNoZSBjb2hlcmVudCBkZXZpY2VzDQo+ICsJICogb25seSwgYnV0IHBlcm1p
dHMgYW4gb3B0aW1pemF0aW9uIHRvIGJlIGVuYWJsZWQgaW4gc29tZSBjYXNlcywgd2hlcmUNCj4g
KwkgKiBmb3Igc29tZSBidWZmZXJzLCBib3RoIHRoZSBDUFUgYW5kIHRoZSBHUFUgdXNlIHVuY2Fj
aGVkIG1hcHBpbmdzLA0KPiArCSAqIHJlbW92aW5nIHRoZSBuZWVkIGZvciBETUEgc25vb3Bpbmcg
YW5kIGFsbG9jYXRpb24gaW4gdGhlIENQVSBjYWNoZXMuDQo+ICsJICoNCj4gKwkgKiBUaGUgdXNl
IG9mIHVuY2FjaGVkIEdQVSBtYXBwaW5ncyByZWxpZXMgb24gdGhlIGNvcnJlY3QgaW1wbGVtZW50
YXRpb24NCj4gKwkgKiBvZiB0aGUgUENJZSBOb1Nub29wIFRMUCBhdHRyaWJ1dGUgYnkgdGhlIHBs
YXRmb3JtLCBvdGhlcndpc2UgdGhlIEdQVQ0KPiArCSAqIHdpbGwgdXNlIGNhY2hlZCBtYXBwaW5n
cyBub25ldGhlbGVzcy4gT24geDg2IHBsYXRmb3JtcywgdGhpcyBkb2VzIG5vdA0KPiArCSAqIHNl
ZW0gdG8gbWF0dGVyLCBhcyB1bmNhY2hlZCBDUFUgbWFwcGluZ3Mgd2lsbCBzbm9vcCB0aGUgY2Fj
aGVzIGluIGFueQ0KPiArCSAqIGNhc2UuIEhvd2V2ZXIsIG9uIEFSTSBhbmQgYXJtNjQsIGVuYWJs
aW5nIHRoaXMgb3B0aW1pemF0aW9uIG9uIGENCj4gKwkgKiBwbGF0Zm9ybSB3aGVyZSBOb1Nub29w
IGlzIGlnbm9yZWQgcmVzdWx0cyBpbiBsb3NzIG9mIGNvaGVyZW5jeSwgd2hpY2gNCj4gKwkgKiBi
cmVha3MgY29ycmVjdCBvcGVyYXRpb24gb2YgdGhlIGRldmljZS4gU2luY2Ugd2UgaGF2ZSBubyB3
YXkgb2YNCj4gKwkgKiBkZXRlY3Rpbmcgd2hldGhlciBOb1Nub29wIHdvcmtzIG9yIG5vdCwganVz
dCBkaXNhYmxlIHRoaXMNCj4gKwkgKiBvcHRpbWl6YXRpb24gZW50aXJlbHkgZm9yIEFSTSBhbmQg
YXJtNjQuDQo+ICsJICovDQo+ICsJcmV0dXJuIGZhbHNlOw0KPiAgICNlbHNlDQo+ICAgCXJldHVy
biB0cnVlOw0KPiAgICNlbmRpZg0KDQo=
