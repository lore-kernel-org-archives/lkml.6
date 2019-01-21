Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3537AC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06112085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u0/FmvTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfAUKLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:11:09 -0500
Received: from mail-eopbgr820053.outbound.protection.outlook.com ([40.107.82.53]:12101
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726003AbfAUKLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzZEq//8OdKM3/D419Jdvlj/dhb4JsuWedzH2fYl36c=;
 b=u0/FmvTTR99/lQ9dDRJiCsgbAr18oXG/gwwSfeIQJuKRJgbXVBF133b0WWQGq727cjwGMhZcaqlfyGK34cQI+HS+PVsWhEbUlYjzMsV+tLGgaBq8q07u2ZEUHzXvEYjhw75aP9Yz41Rp0NWz+rCScy7K8G4Gq37Yi+8arvkuP8o=
Received: from CY4PR12MB1717.namprd12.prod.outlook.com (10.175.62.139) by
 CY4PR12MB1253.namprd12.prod.outlook.com (10.168.167.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.31; Mon, 21 Jan 2019 10:11:04 +0000
Received: from CY4PR12MB1717.namprd12.prod.outlook.com
 ([fe80::7dec:669a:ec18:7f0f]) by CY4PR12MB1717.namprd12.prod.outlook.com
 ([fe80::7dec:669a:ec18:7f0f%7]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 10:11:04 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
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
        Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Thread-Topic: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Thread-Index: AQHUsXD3UXk0MPD/dUyEFCISRS4xuqW5gE+A
Date:   Mon, 21 Jan 2019 10:11:04 +0000
Message-ID: <3246d2e5-497f-dac5-fa78-cf9e95c45423@amd.com>
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM5P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::23) To CY4PR12MB1717.namprd12.prod.outlook.com
 (2603:10b6:903:121::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR12MB1253;20:GQu/hfVZAOZASSA55LtqB1hQY1gVYrbhQTA7DhNY/M+8NT5ZYg0RBUfs5S5b8zFDkysftlaSITiyfaLwWFFNV0vU0cz7h4MK+jw40WvRP//YqOR3vDkM/cTqQQ9BZWuIybTK9chXMeki7fY4GQwpyE1Tf4MWSScNzRPr15Xu5lykANrHIhdAyRY+q1n0RztYgVw7qKcfnJepOFRL2qgF9f78GzQ/xCjrFViuSIn6Wdd56jobCHGZKYMBRYz1/1j4
x-ms-office365-filtering-correlation-id: 453c5f7f-6cd3-4acd-d8db-08d67f88c057
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1253;
x-ms-traffictypediagnostic: CY4PR12MB1253:
x-microsoft-antispam-prvs: <CY4PR12MB12534055E746687614E93C99839F0@CY4PR12MB1253.namprd12.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(346002)(39860400002)(199004)(189003)(65956001)(8936002)(81166006)(81156014)(6246003)(25786009)(97736004)(2906002)(478600001)(966005)(58126008)(316002)(54906003)(72206003)(110136005)(14454004)(4326008)(65826007)(99286004)(68736007)(7416002)(76176011)(229853002)(36756003)(31696002)(6486002)(7736002)(6436002)(66574012)(65806001)(106356001)(386003)(102836004)(6506007)(486006)(305945005)(186003)(2501003)(52116002)(105586002)(8676002)(6116002)(71190400001)(71200400001)(256004)(64126003)(53936002)(6512007)(6306002)(31686004)(2616005)(46003)(476003)(446003)(11346002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1253;H:CY4PR12MB1717.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vBVW7fVy1LBGozzxdM34jkj8Ha1DnECT/0XHYmmlxMpSj7TC3Ul49xk9fim2czkI+X2Ihd2BJdX1hF9vphthYxupMRp0fFYuDut3aanZ3VL8ZCckJDo22I32YQmgDXvw9nRVtaY9XHMv+bSiagt5T3biCPonTZsI74jiciyGiDx4yUkUgKY+ADjR60n0nG1iTHd5A4wqPxMGFN6GkJETb7ne2NiKDVmhF+psgr6wR439qgcRiEfWmfhuzu4f+c41lwhA65aqN8vGu6gJFBwXVEIrwN3RSeX8kVQeiriIzPsII6fsbAyCiGjF1V5aguilLju3VM6vgP+qJWf3BvQIcaE4FWqtDwOkMCYrrCPdTKyQ/8/yW2QabPOsMdIFlLivRQ8kG263nF8gvEz0O+MGtKvMFmSjyC2zGmlFRVexEOA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <26658351F424B7459A556CA16433D0AF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453c5f7f-6cd3-4acd-d8db-08d67f88c057
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 10:11:00.6509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1253
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMjEuMDEuMTkgdW0gMTE6MDYgc2NocmllYiBBcmQgQmllc2hldXZlbDoNCj4gQ3VycmVudGx5
LCB0aGUgRFJNIGNvZGUgYXNzdW1lcyB0aGF0IFBDSSBkZXZpY2VzIGFyZSBhbHdheXMgY2FjaGUN
Cj4gY29oZXJlbnQgZm9yIERNQSwgYW5kIHRoYXQgdGhpcyBjYW4gYmUgc2VsZWN0aXZlbHkgb3Zl
cnJpZGRlbiBmb3INCj4gc29tZSBidWZmZXJzIHVzaW5nIG5vbi1jYWNoZWQgbWFwcGluZ3Mgb24g
dGhlIENQVSBzaWRlIGFuZCBQQ0llDQo+IE5vU25vb3AgdHJhbnNhY3Rpb25zIG9uIHRoZSBidXMg
c2lkZS4NCj4NCj4gV2hldGhlciB0aGUgTm9Tbm9vcCBwYXJ0IGlzIGltcGxlbWVudGVkIGNvcnJl
Y3RseSBpcyBoaWdobHkgcGxhdGZvcm0NCj4gc3BlY2lmaWMuIFdoZXRoZXIgaXQgL21hdHRlcnMv
IGlmIE5vU25vb3AgaXMgaW1wbGVtZW50ZWQgY29ycmVjdGx5IG9yDQo+IG5vdCBpcyBhcmNoaXRl
Y3R1cmUgc3BlY2lmaWM6IG9uIHg4Niwgc3VjaCB0cmFuc2FjdGlvbnMgYXJlIGNvaGVyZW50DQo+
IHdpdGggdGhlIENQVSB3aGV0aGVyIHRoZSBOb1Nub29wIGF0dHJpYnV0ZSBpcyBob25vcmVkIG9y
IG5vdC4gT24gb3RoZXINCj4gYXJjaGl0ZWN0dXJlcywgaXQgZGVwZW5kcyBvbiB3aGV0aGVyIHN1
Y2ggdHJhbnNhY3Rpb25zIG1heSBhbGxvY2F0ZSBpbg0KPiBjYWNoZXMgdGhhdCBhcmUgbm9uLWNv
aGVyZW50IHdpdGggdGhlIENQVSdzIHVuY2FjaGVkIG1hcHBpbmdzLg0KPg0KPiBCb3R0b20gbGlu
ZSBpcyB0aGF0IHdlIHNob3VsZCBub3QgcmVseSBvbiB0aGlzIG9wdGltaXphdGlvbiB0byB3b3Jr
DQo+IGNvcnJlY3RseSBmb3IgY2FjaGUgY29oZXJlbnQgZGV2aWNlcyBpbiB0aGUgZ2VuZXJhbCBj
YXNlLiBPbiB0aGUNCj4gb3RoZXIgaGFuZCwgZGlzYWJsaW5nIHRoaXMgb3B0aW1pemF0aW9uIGZv
ciBub24tY29oZXJlbnQgZGV2aWNlcw0KPiBpcyBsaWtlbHkgdG8gY2F1c2UgYnJlYWthZ2UgYXMg
d2VsbCwgc2luY2UgdGhlIGRyaXZlciB3aWxsIGFzc3VtZQ0KPiBjYWNoZSBjb2hlcmVudCBQQ0ll
IGlmIHRoaXMgb3B0aW1pemF0aW9uIGlzIHR1cm5lZCBvZmYuDQo+DQo+IFNvIHJlbmFtZSBkcm1f
YXJjaF9jYW5fd2NfbWVtb3J5KCkgdG8gZHJtX2RldmljZV9jYW5fd2NfbWVtb3J5KCksIGFuZA0K
PiBwYXNzIHRoZSBkcm1fZGV2aWNlIHBvaW50ZXIgaW50byBpdCBzbyB3ZSBjYW4gYmFzZSB0aGUg
cmV0dXJuIHZhbHVlDQo+IG9uIHdoZXRoZXIgdGhlIGRldmljZSBpcyBjYWNoZSBjb2hlcmVudCBv
ciBub3QgaWYgbm90IHJ1bm5pbmcgb24NCj4gWDg2Lg0KPg0KPiBDYzogQ2hyaXN0aWFuIEtvZW5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPg0KPiBDYzogRGF2aWQgWmhvdSA8RGF2aWQxLlpob3VAYW1kLmNv
bT4NCj4gQ2M6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+DQo+IENjOiBKdW53ZWkgWmhh
bmcgPEplcnJ5LlpoYW5nQGFtZC5jb20+DQo+IENjOiBNaWNoZWwgRGFlbnplciA8bWljaGVsLmRh
ZW56ZXJAYW1kLmNvbT4NCj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4NCj4g
Q2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4NCj4gQ2M6IE1hYXJ0ZW4gTGFua2hv
cnN0IDxtYWFydGVuLmxhbmtob3JzdEBsaW51eC5pbnRlbC5jb20+DQo+IENjOiBNYXhpbWUgUmlw
YXJkIDxtYXhpbWUucmlwYXJkQGJvb3RsaW4uY29tPg0KPiBDYzogU2VhbiBQYXVsIDxzZWFuQHBv
b3JseS5ydW4+DQo+IENjOiBNaWNoYWVsIEVsbGVybWFuIDxtcGVAZWxsZXJtYW4uaWQuYXU+DQo+
IENjOiBCZW5qYW1pbiBIZXJyZW5zY2htaWR0IDxiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+DQo+
IENjOiBXaWxsIERlYWNvbiA8d2lsbC5kZWFjb25AYXJtLmNvbT4NCj4gUmVwb3J0ZWQtYnk6IENh
cnN0ZW4gSGFpdHpsZXIgPENhcnN0ZW4uSGFpdHpsZXJAYXJtLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogQXJkIEJpZXNoZXV2ZWwgPGFyZC5iaWVzaGV1dmVsQGxpbmFyby5vcmc+DQoNCkxvb2tzIHNh
bmUgdG8gbWUsIGJ1dCBJIGNhbid0IGZ1bGx5IGp1ZGdlIGlmIHRoZSBjaGVjayBpcyBhY3R1YWxs
eSANCmNvcnJlY3Qgb3Igbm90Lg0KDQpTbyBBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KDQo+IC0tLQ0KPiBUaGlzIGlzIGEgZm9sbG93dXAgdG8g
J1tSRkMgUEFUQ0hdIGRybS90dG06IGZvcmNlIGNhY2hlZCBtYXBwaW5ncyBmb3Igc3lzdGVtDQo+
IFJBTSBvbiBBUk0nDQo+DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWFybS1rZXJu
ZWwvMjAxOTAxMTAwNzI4NDEuMzI4My0xLWFyZC5iaWVzaGV1dmVsQGxpbmFyby5vcmcvDQo+DQo+
IFdpdGhvdXQgdA0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3Qu
YyB8ICAyICstDQo+ICAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fb2JqZWN0LmMgICAg
IHwgIDIgKy0NCj4gICBpbmNsdWRlL2RybS9kcm1fY2FjaGUuaCAgICAgICAgICAgICAgICAgICAg
fCAxOSArKysrKysrKysrKy0tLS0tLS0tDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRp
b25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9vYmplY3QuYw0KPiBpbmRleCA3MjhlMTVlNWQ2OGEuLjc3N2ZhMjUxODM4ZiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYw0KPiBAQCAt
NDgwLDcgKzQ4MCw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2JvX2RvX2NyZWF0ZShzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwNCj4gICAJLyogRm9yIGFyY2hpdGVjdHVyZXMgdGhhdCBkb24ndCBz
dXBwb3J0IFdDIG1lbW9yeSwNCj4gICAJICogbWFzayBvdXQgdGhlIFdDIGZsYWcgZnJvbSB0aGUg
Qk8NCj4gICAJICovDQo+IC0JaWYgKCFkcm1fYXJjaF9jYW5fd2NfbWVtb3J5KCkpDQo+ICsJaWYg
KCFkcm1fZGV2aWNlX2Nhbl93Y19tZW1vcnkoYWRldi0+ZGRldikpDQo+ICAgCQliby0+ZmxhZ3Mg
Jj0gfkFNREdQVV9HRU1fQ1JFQVRFX0NQVV9HVFRfVVNXQzsNCj4gICAjZW5kaWYNCj4gICANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX29iamVjdC5jIGIvZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fb2JqZWN0LmMNCj4gaW5kZXggODMzZTkwOTcwNmE5
Li42MTA4ODliZjZhYjUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFk
ZW9uX29iamVjdC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX29iamVj
dC5jDQo+IEBAIC0yNDksNyArMjQ5LDcgQEAgaW50IHJhZGVvbl9ib19jcmVhdGUoc3RydWN0IHJh
ZGVvbl9kZXZpY2UgKnJkZXYsDQo+ICAgCS8qIEZvciBhcmNoaXRlY3R1cmVzIHRoYXQgZG9uJ3Qg
c3VwcG9ydCBXQyBtZW1vcnksDQo+ICAgCSAqIG1hc2sgb3V0IHRoZSBXQyBmbGFnIGZyb20gdGhl
IEJPDQo+ICAgCSAqLw0KPiAtCWlmICghZHJtX2FyY2hfY2FuX3djX21lbW9yeSgpKQ0KPiArCWlm
ICghZHJtX2RldmljZV9jYW5fd2NfbWVtb3J5KHJkZXYtPmRkZXYpKQ0KPiAgIAkJYm8tPmZsYWdz
ICY9IH5SQURFT05fR0VNX0dUVF9XQzsNCj4gICAjZW5kaWYNCj4gICANCj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvZHJtL2RybV9jYWNoZS5oIGIvaW5jbHVkZS9kcm0vZHJtX2NhY2hlLmgNCj4gaW5k
ZXggYmZlMTYzOWRmMDJkLi5jZWQ2M2IxMjA3YTMgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvZHJt
L2RybV9jYWNoZS5oDQo+ICsrKyBiL2luY2x1ZGUvZHJtL2RybV9jYWNoZS5oDQo+IEBAIC0zMyw2
ICszMyw4IEBADQo+ICAgI2lmbmRlZiBfRFJNX0NBQ0hFX0hfDQo+ICAgI2RlZmluZSBfRFJNX0NB
Q0hFX0hfDQo+ICAgDQo+ICsjaW5jbHVkZSA8ZHJtL2RybV9kZXZpY2UuaD4NCj4gKyNpbmNsdWRl
IDxsaW51eC9kbWEtbm9uY29oZXJlbnQuaD4NCj4gICAjaW5jbHVkZSA8bGludXgvc2NhdHRlcmxp
c3QuaD4NCj4gICANCj4gICB2b2lkIGRybV9jbGZsdXNoX3BhZ2VzKHN0cnVjdCBwYWdlICpwYWdl
c1tdLCB1bnNpZ25lZCBsb25nIG51bV9wYWdlcyk7DQo+IEBAIC00MSwxNSArNDMsMTYgQEAgdm9p
ZCBkcm1fY2xmbHVzaF92aXJ0X3JhbmdlKHZvaWQgKmFkZHIsIHVuc2lnbmVkIGxvbmcgbGVuZ3Ro
KTsNCj4gICB1NjQgZHJtX2dldF9tYXhfaW9tZW0odm9pZCk7DQo+ICAgDQo+ICAgDQo+IC1zdGF0
aWMgaW5saW5lIGJvb2wgZHJtX2FyY2hfY2FuX3djX21lbW9yeSh2b2lkKQ0KPiArc3RhdGljIGlu
bGluZSBib29sIGRybV9kZXZpY2VfY2FuX3djX21lbW9yeShzdHJ1Y3QgZHJtX2RldmljZSAqZGRl
dikNCj4gICB7DQo+IC0jaWYgZGVmaW5lZChDT05GSUdfUFBDKSAmJiAhZGVmaW5lZChDT05GSUdf
Tk9UX0NPSEVSRU5UX0NBQ0hFKQ0KPiAtCXJldHVybiBmYWxzZTsNCj4gLSNlbGlmIGRlZmluZWQo
Q09ORklHX01JUFMpICYmIGRlZmluZWQoQ09ORklHX0NQVV9MT09OR1NPTjMpDQo+IC0JcmV0dXJu
IGZhbHNlOw0KPiAtI2Vsc2UNCj4gLQlyZXR1cm4gdHJ1ZTsNCj4gLSNlbmRpZg0KPiArCWlmIChJ
U19FTkFCTEVEKENPTkZJR19QUEMpKQ0KPiArCQlyZXR1cm4gSVNfRU5BQkxFRChDT05GSUdfTk9U
X0NPSEVSRU5UX0NBQ0hFKTsNCj4gKwllbHNlIGlmIChJU19FTkFCTEVEKENPTkZJR19NSVBTKSkN
Cj4gKwkJcmV0dXJuICFJU19FTkFCTEVEKENPTkZJR19DUFVfTE9PTkdTT04zKTsNCj4gKwllbHNl
IGlmIChJU19FTkFCTEVEKENPTkZJR19YODYpKQ0KPiArCQlyZXR1cm4gdHJ1ZTsNCj4gKw0KPiAr
CXJldHVybiAhZGV2X2lzX2RtYV9jb2hlcmVudChkZGV2LT5kZXYpOw0KPiAgIH0NCj4gICANCj4g
ICAjZW5kaWYNCg0K
