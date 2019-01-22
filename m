Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C848C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9AFC21726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HpMBtGU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfAVVkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:40:22 -0500
Received: from mail-eopbgr720086.outbound.protection.outlook.com ([40.107.72.86]:27199
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726423AbfAVVkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:40:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNJA8wccno8VxRfOCWNYYUmZFQgL7n7ylmk+2zxkwE4=;
 b=HpMBtGU8uSg1wb9cmGjSdHFgZXKMHIyzG9QsWyo9vc9ALOMtn1gLcdsM2E2S1M1wk+So4ytURacWBpYxFUiLt9V2rgHo4x2z4M8WbsYb7veeFaBisMkEyUd0ZHzeCisZybVmM7tjDIV3eUeaJScFlLDlzlAdMRh+qb/Xo6xx9IE=
Received: from MN2PR12MB3631.namprd12.prod.outlook.com (20.178.243.19) by
 MN2PR12MB3230.namprd12.prod.outlook.com (20.179.82.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Tue, 22 Jan 2019 21:40:16 +0000
Received: from MN2PR12MB3631.namprd12.prod.outlook.com
 ([fe80::a861:43c0:476d:e044]) by MN2PR12MB3631.namprd12.prod.outlook.com
 ([fe80::a861:43c0:476d:e044%5]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 21:40:16 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH 1/2] dma-direct: set_memory_{en,de}crypted() take number
 of pages
Thread-Topic: [PATCH 1/2] dma-direct: set_memory_{en,de}crypted() take number
 of pages
Thread-Index: AQHUspgJ4IESYvO40E+HEyQBiP4mGaW70OyA
Date:   Tue, 22 Jan 2019 21:40:16 +0000
Message-ID: <bc09628a-d329-bb95-d737-b7c618860c6a@amd.com>
References: <20190122211758.8317-1-bauerman@linux.ibm.com>
In-Reply-To: <20190122211758.8317-1-bauerman@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0006.namprd05.prod.outlook.com
 (2603:10b6:803:40::19) To MN2PR12MB3631.namprd12.prod.outlook.com
 (2603:10b6:208:cc::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3230;20:JFES4iPXdgJpFM+pl6e7qFJuO61TYFbPmzdoChEp71kOPKLos3pJAXP/CEsFamEYqDlAF1usyn2LADKuO9BjZl8DF8eXq0Kp2THVuCf/tXv7+1RRr+Ue2nD4NFjlLbwl8tz2zbQe62cclC57qjJfZj3KtC0Bufe7fxH+iWk/Gl18ToK/yGTEGMualY8kJ9L8EpXIwQkxflbfFeHlwdFM0JyPhmlLq+JhtRs8lQdyPf54CipgjlGQTnWmXErorshF
x-ms-office365-filtering-correlation-id: 154504cd-f3ca-4e2d-2da6-08d680b23294
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3230;
x-ms-traffictypediagnostic: MN2PR12MB3230:
x-microsoft-antispam-prvs: <MN2PR12MB3230FEC23172406D5E380DADEC980@MN2PR12MB3230.namprd12.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(366004)(199004)(189003)(7416002)(7736002)(305945005)(2616005)(11346002)(446003)(31696002)(6486002)(2501003)(86362001)(478600001)(386003)(53546011)(6116002)(316002)(26005)(3846002)(476003)(6506007)(8936002)(102836004)(97736004)(486006)(8676002)(54906003)(110136005)(186003)(81156014)(81166006)(71200400001)(68736007)(4326008)(71190400001)(53936002)(14444005)(6246003)(52116002)(76176011)(25786009)(256004)(99286004)(6512007)(31686004)(14454004)(66066001)(6436002)(72206003)(36756003)(2906002)(105586002)(229853002)(106356001)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3230;H:MN2PR12MB3631.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EyJcgFTyUCpc37JCxbe2T3bawQY2hng6zWTWrxFbsmxqlx+f8GTnZfZV4TpZhmIa9GXkzJ3Q7dk9dttq89Ug29QEBlGqLmV1Rmykxx7fKzW0WX6f0xCTted2OUzDbNd17TqypPOGR5nqyiQE9YEbZDdiyspecHtSYyWKXdZMcaFtgPCSfHWKc2e2hREOZqEQn4UM4gbEv2eBM/k3r4H9j/iXNUY02ZCAQRmM6bk8Jg8bkG22rKLIEs9pPHwsBaTk7a3neERyZkQP7ZmypEBL4zpgJAadfx+bBY3TxHgBOdlKV31A0Qdjay8LE/lTcU301t3mP+pNqyxHZMXQwzIJtITeBOdgOrI1uPjIkhA06TTxjk8CFW8Y4cYjtRk8O5SOxRRFW8d0YMA4hxm1wNPoz3BUiaXc1qaLfGtSqBhJ91E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF8680C2F258B34FB610853AB9622BB6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154504cd-f3ca-4e2d-2da6-08d680b23294
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 21:40:15.0972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3230
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yMi8xOSAzOjE3IFBNLCBUaGlhZ28gSnVuZyBCYXVlcm1hbm4gd3JvdGU6DQo+IEZyb206
IFJhbSBQYWkgPGxpbnV4cmFtQHVzLmlibS5jb20+DQo+IA0KPiBzZXRfbWVtb3J5X2VuY3J5cHRl
ZCgpIGFuZCBzZXRfbWVtb3J5X2RlY3J5cHRlZCgpIGV4cGVjdCB0aGUgbnVtYmVyIG9mDQo+IFBB
R0VfU0laRSBwYWdlcyB0byBlbmNyeXB0IG9yIGRlY3J5cHQuIGRtYV9kaXJlY3RfYWxsb2MoKSBh
bmQNCj4gZG1hX2RpcmVjdF9mcmVlKCkgaW5zdGVhZCBwYXNzIG51bWJlciBvZiBieXRlcy4gVGhp
cyBlbmNyeXB0cy9kZWNyeXB0cyBhDQo+IGh1Z2UgbnVtYmVyIG9mIHBhZ2VzIHJlc3VsdGluZyBp
biBkYXRhIGNvcnJ1cHRpb24uDQoNClRoYXQgaXMgbm90IHdoYXQgaXQgaXMgZG9pbmcuIFNlZSBj
b21tZW50cyBiZWxvdy4NCg0KPiANCj4gRml4ZWQgaXQuDQo+IA0KPiBbIGJhdWVybWFubjogU2xp
Z2h0bHkgcmV3b3JkZWQgY29tbWl0IG1lc3NhZ2UgYW5kIGFkZGVkIEZpeGVzOiB0YWcuIF0NCj4g
Rml4ZXM6IGQ3YjQxN2ZhMDhkMSAoIng4Ni9tbTogQWRkIERNQSBzdXBwb3J0IGZvciBTRVYgbWVt
b3J5IGVuY3J5cHRpb24iKQ0KPiBTaWduZWQtb2ZmLWJ5OiBSYW0gUGFpIDxsaW51eHJhbUB1cy5p
Ym0uY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBUaGlhZ28gSnVuZyBCYXVlcm1hbm4gPGJhdWVybWFu
QGxpbnV4LmlibS5jb20+DQo+IC0tLQ0KPiAga2VybmVsL2RtYS9kaXJlY3QuYyB8IDYgKystLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gTm90ZXM6DQo+IA0KPiAxLiBUaGlzIHdhcyB0ZXN0ZWQgb24gcG93ZXJwYyB3aXRoIHBhdGNo
ZXMgYWRkaW5nIHN1cHBvcnQgZm9yIHJ1bm5pbmcNCj4gICAgdW5kZXIgdGhlIHVsdHJhdmlzb3Is
IHdoaWNoIGFyZSBub3QgeWV0IHVwc3RyZWFtLg0KPiANCj4gMi4gVGhlIGxpbmVzIGNoYW5nZWQg
aW4gdGhpcyBwYXRjaCB3ZXJlIGFkZGVkIGJ5IGNvbW1pdCBjMTBmMDdhYTI3ZGENCj4gICAgKCJk
bWEvZGlyZWN0OiBIYW5kbGUgZm9yY2UgZGVjcnlwdGlvbiBmb3IgRE1BIGNvaGVyZW50IGJ1ZmZl
cnMgaW4NCj4gICAgY29tbW9uIGNvZGUiKSwgYnV0IGl0IG9ubHkgbW92ZXMgdGhlIGNvZGUgZnJv
bSBhbiB4ODYtc3BlY2lmaWMgZmlsZS4NCj4gICAgVGhlcmVmb3JlIHRoZSBGaXhlcyB0YWcgcmVm
ZXJlbmNlcyB0aGUgY29tbWl0IHRoYXQgZmlyc3QgaW50cm9kdWNlZA0KPiAgICB0aGUgY29kZS4N
Cj4gDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvZG1hL2RpcmVjdC5jIGIva2VybmVsL2RtYS9kaXJl
Y3QuYw0KPiBpbmRleCAzNTVkMTZhY2VlNmQuLmJjNzhjMzcyMjBiYSAxMDA2NDQNCj4gLS0tIGEv
a2VybmVsL2RtYS9kaXJlY3QuYw0KPiArKysgYi9rZXJuZWwvZG1hL2RpcmVjdC5jDQo+IEBAIC0x
NjYsNyArMTY2LDcgQEAgdm9pZCAqZG1hX2RpcmVjdF9hbGxvY19wYWdlcyhzdHJ1Y3QgZGV2aWNl
ICpkZXYsIHNpemVfdCBzaXplLA0KPiAgDQo+ICAJcmV0ID0gcGFnZV9hZGRyZXNzKHBhZ2UpOw0K
PiAgCWlmIChmb3JjZV9kbWFfdW5lbmNyeXB0ZWQoKSkgew0KPiAtCQlzZXRfbWVtb3J5X2RlY3J5
cHRlZCgodW5zaWduZWQgbG9uZylyZXQsIDEgPDwgZ2V0X29yZGVyKHNpemUpKTsNCj4gKwkJc2V0
X21lbW9yeV9kZWNyeXB0ZWQoKHVuc2lnbmVkIGxvbmcpcmV0LCAxKTsNCg0KVGhlIGdldF9vcmRl
cigpIGZ1bmN0aW9uIHdpbGwgcmV0dXJuIHRoZSBvcmRlciBmb3IgdGhlIHNwZWNpZmllZCBzaXpl
LiBUbw0KdGhlbiBnZXQgdGhlIG51bWJlciBvZiBwYWdlcyB5b3UgcGVyZm9ybSB0aGUgc2hpZnQg
YXMgaXMgYmVpbmcgZG9uZS4gVGhlDQpjaGFuZ2UgaXMgZGVmaW5pdGVseSB3cm9uZyBzaW5jZSB5
b3UgYXJlIG5vdyBoYXJkY29kaW5nIHRoZSBwYWdlIGNvdW50IHRvDQoxLiBUaGUgY2FsbCB0byBf
X2RtYV9kaXJlY3RfYWxsb2NfcGFnZXMoKSB3aWxsIGFsbG9jYXRlIG1vcmUgdGhhbiBvbmUgcGFn
ZQ0KaWYgdGhlIHNpemUgaXMgZ3JlYXRlciB0aGFuIGEgcGFnZS4NCg0KPiAgCQkqZG1hX2hhbmRs
ZSA9IF9fcGh5c190b19kbWEoZGV2LCBwYWdlX3RvX3BoeXMocGFnZSkpOw0KPiAgCX0gZWxzZSB7
DQo+ICAJCSpkbWFfaGFuZGxlID0gcGh5c190b19kbWEoZGV2LCBwYWdlX3RvX3BoeXMocGFnZSkp
Ow0KPiBAQCAtMTg2LDEwICsxODYsOCBAQCB2b2lkIF9fZG1hX2RpcmVjdF9mcmVlX3BhZ2VzKHN0
cnVjdCBkZXZpY2UgKmRldiwgc2l6ZV90IHNpemUsIHN0cnVjdCBwYWdlICpwYWdlKQ0KPiAgdm9p
ZCBkbWFfZGlyZWN0X2ZyZWVfcGFnZXMoc3RydWN0IGRldmljZSAqZGV2LCBzaXplX3Qgc2l6ZSwg
dm9pZCAqY3B1X2FkZHIsDQo+ICAJCWRtYV9hZGRyX3QgZG1hX2FkZHIsIHVuc2lnbmVkIGxvbmcg
YXR0cnMpDQo+ICB7DQo+IC0JdW5zaWduZWQgaW50IHBhZ2Vfb3JkZXIgPSBnZXRfb3JkZXIoc2l6
ZSk7DQo+IC0NCj4gIAlpZiAoZm9yY2VfZG1hX3VuZW5jcnlwdGVkKCkpDQo+IC0JCXNldF9tZW1v
cnlfZW5jcnlwdGVkKCh1bnNpZ25lZCBsb25nKWNwdV9hZGRyLCAxIDw8IHBhZ2Vfb3JkZXIpOw0K
PiArCQlzZXRfbWVtb3J5X2VuY3J5cHRlZCgodW5zaWduZWQgbG9uZyljcHVfYWRkciwgMSk7DQoN
ClNhbWUgY29tbWVudCBoZXJlIGFzIGFib3ZlLg0KDQpUaGFua3MsDQpUb20NCg0KPiAgCV9fZG1h
X2RpcmVjdF9mcmVlX3BhZ2VzKGRldiwgc2l6ZSwgdmlydF90b19wYWdlKGNwdV9hZGRyKSk7DQo+
ICB9DQo+ICANCj4gDQo=
