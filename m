Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974E6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C96D20838
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rFO9QDt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C96D20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406583AbeKWFgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 00:36:02 -0500
Received: from mail-eopbgr810040.outbound.protection.outlook.com ([40.107.81.40]:57848
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392136AbeKWFgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 00:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRIIqtxIJDEZPKh2wm3qfuJ99ekfCYeRUDkJY+VyuR4=;
 b=rFO9QDt8JBw5vU2qcgoGgig7BOHUu6E8yEEPiEL9YoOOdM/YIV88pF2NCBs4z1pwbmFeupopTijD0OVD6lJG8ru/p9NFKk9vvlEso/VCeG3AUw0FGYRPa5YELQAklOFLvATGr5Kpv7u3vpK1+DNxRuMyeZTZb9HeXNPy46SjMKE=
Received: from BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11) by
 BN6PR12MB1393.namprd12.prod.outlook.com (10.168.228.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.23; Thu, 22 Nov 2018 18:55:17 +0000
Received: from BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::f8a7:157:6224:34ee]) by BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::f8a7:157:6224:34ee%2]) with mapi id 15.20.1339.027; Thu, 22 Nov 2018
 18:55:17 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Linux MM <linux-mm@kvack.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/3] mm, notifier: Catch sleeping/blocking for !blockable
Thread-Topic: [PATCH 2/3] mm, notifier: Catch sleeping/blocking for !blockable
Thread-Index: AQHUgoOXn35FlQ7VOUGIwFoSriypUaVcJMKA
Date:   Thu, 22 Nov 2018 18:55:17 +0000
Message-ID: <f9c39a9a-5afd-4aed-c9ad-0c3fef34a449@amd.com>
References: <20181122165106.18238-1-daniel.vetter@ffwll.ch>
 <20181122165106.18238-3-daniel.vetter@ffwll.ch>
In-Reply-To: <20181122165106.18238-3-daniel.vetter@ffwll.ch>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:125b:9a00:a142:2be6:b7be:5a3a]
x-clientproxiedby: AM5PR0701CA0053.eurprd07.prod.outlook.com
 (2603:10a6:203:2::15) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1393;20:PbxAU93wa0J3u3SJvCDE26lAneccqyXv72Pyy8Fjk8zjFYas0WDuc+hL/OBOQpwnI8GI/OQhIH4/de4UkZwar/cyGUyhsmQoilOjC1VsRApUMSNffBaGdUIJwXUeyLuMvL5AUxfeEMqIm7SMPdEHuyw7hMLKmryCLMYtdZoOAwrzWAypg9wVdOZ7O/zJ02WC27a87bSagwrkCYJAf19w9WC8ktASvzxP/NTV7jh699PCkwDt3477DOjDTfyc4EYP
x-ms-office365-filtering-correlation-id: 2adeea86-f9ab-4555-7e97-08d650ac0b31
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1393;
x-ms-traffictypediagnostic: BN6PR12MB1393:
x-microsoft-antispam-prvs: <BN6PR12MB1393E1BC027FB348434154A483DB0@BN6PR12MB1393.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR12MB1393;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1393;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(25786009)(72206003)(64126003)(65956001)(65806001)(97736004)(68736007)(478600001)(316002)(76176011)(52116002)(6486002)(6436002)(99286004)(54906003)(2900100001)(14454004)(58126008)(110136005)(81156014)(81166006)(31686004)(186003)(6506007)(386003)(229853002)(102836004)(86362001)(106356001)(105586002)(36756003)(2906002)(7736002)(65826007)(6116002)(446003)(8936002)(6246003)(4326008)(486006)(46003)(14444005)(476003)(6512007)(2616005)(305945005)(53936002)(11346002)(8676002)(256004)(31696002)(66574009)(71190400001)(7416002)(71200400001)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1393;H:BN6PR12MB1714.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OV/aOhVst5pC58OVOJfIyOVnHJ2ViumnRO/ah8r4iu5kBGpZjvIRZv5fOQnixQvYvbJeNDQHE19jqgYNkcgKFv9BfyJ19ZYix0a1ci1y0FB5wPgCuTxrWpN/quEaPsRDcVMBML+7qsGL3QZmgxrwxqRCjIgqUdg+60gk6sg41BUNbEJ7tlde1J/wByFkAofEeRA+2HJTv3L5SyPugAhmKEM3WT5YYffV0ZOqJXJaXBHf02pLEESCwZgbfdQQ0059hjKyVf4ZMGfnklJ2lV3lBbpqjzMIYecKQFvEl8gZ9qfyBilBupId8zVmiyBR3GBRYctABHDzuiB3saSeBf9HLdm8M4fwDKs9SmaIF9lsiwY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EC4BF4399C95F4382DBAFADB9310725@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2adeea86-f9ab-4555-7e97-08d650ac0b31
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 18:55:17.5175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1393
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMjIuMTEuMTggdW0gMTc6NTEgc2NocmllYiBEYW5pZWwgVmV0dGVyOg0KPiBXZSBuZWVkIHRv
IG1ha2Ugc3VyZSBpbXBsZW1lbnRhdGlvbnMgZG9uJ3QgY2hlYXQgYW5kIGRvbid0IGhhdmUgYQ0K
PiBwb3NzaWJsZSBzY2hlZHVsZS9ibG9ja2luZyBwb2ludCBkZWVwbHkgYnVycmllZCB3aGVyZSBy
ZXZpZXcgY2FuJ3QNCj4gY2F0Y2ggaXQuDQo+DQo+IEknbSBub3Qgc3VyZSB3aGV0aGVyIHRoaXMg
aXMgdGhlIGJlc3Qgd2F5IHRvIG1ha2Ugc3VyZSBhbGwgdGhlDQo+IG1pZ2h0X3NsZWVwKCkgY2Fs
bHNpdGVzIHRyaWdnZXIsIGFuZCBpdCdzIGEgYml0IHVnbHkgaW4gdGhlIGNvZGUgZmxvdy4NCj4g
QnV0IGl0IGdldHMgdGhlIGpvYiBkb25lLg0KPg0KPiBDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBs
aW51eC1mb3VuZGF0aW9uLm9yZz4NCj4gQ2M6IE1pY2hhbCBIb2NrbyA8bWhvY2tvQHN1c2UuY29t
Pg0KPiBDYzogRGF2aWQgUmllbnRqZXMgPHJpZW50amVzQGdvb2dsZS5jb20+DQo+IENjOiAiQ2hy
aXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gQ2M6IERhbmllbCBW
ZXR0ZXIgPGRhbmllbC52ZXR0ZXJAZmZ3bGwuY2g+DQo+IENjOiAiSsOpcsO0bWUgR2xpc3NlIiA8
amdsaXNzZUByZWRoYXQuY29tPg0KPiBDYzogbGludXgtbW1Aa3ZhY2sub3JnDQo+IFNpZ25lZC1v
ZmYtYnk6IERhbmllbCBWZXR0ZXIgPGRhbmllbC52ZXR0ZXJAaW50ZWwuY29tPg0KPiAtLS0NCj4g
ICBtbS9tbXVfbm90aWZpZXIuYyB8IDggKysrKysrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNyBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9tbS9tbXVfbm90
aWZpZXIuYyBiL21tL21tdV9ub3RpZmllci5jDQo+IGluZGV4IDU5ZTEwMjU4OWEyNS4uNGQyODJj
ZmIyOTZlIDEwMDY0NA0KPiAtLS0gYS9tbS9tbXVfbm90aWZpZXIuYw0KPiArKysgYi9tbS9tbXVf
bm90aWZpZXIuYw0KPiBAQCAtMTg1LDcgKzE4NSwxMyBAQCBpbnQgX19tbXVfbm90aWZpZXJfaW52
YWxpZGF0ZV9yYW5nZV9zdGFydChzdHJ1Y3QgbW1fc3RydWN0ICptbSwNCj4gICAJaWQgPSBzcmN1
X3JlYWRfbG9jaygmc3JjdSk7DQo+ICAgCWhsaXN0X2Zvcl9lYWNoX2VudHJ5X3JjdShtbiwgJm1t
LT5tbXVfbm90aWZpZXJfbW0tPmxpc3QsIGhsaXN0KSB7DQo+ICAgCQlpZiAobW4tPm9wcy0+aW52
YWxpZGF0ZV9yYW5nZV9zdGFydCkgew0KPiAtCQkJaW50IF9yZXQgPSBtbi0+b3BzLT5pbnZhbGlk
YXRlX3JhbmdlX3N0YXJ0KG1uLCBtbSwgc3RhcnQsIGVuZCwgYmxvY2thYmxlKTsNCj4gKwkJCWlu
dCBfcmV0Ow0KPiArDQo+ICsJCQlpZiAoSVNfRU5BQkxFRChDT05GSUdfREVCVUdfQVRPTUlDX1NM
RUVQKSAmJiAhYmxvY2thYmxlKQ0KPiArCQkJCXByZWVtcHRfZGlzYWJsZSgpOw0KPiArCQkJX3Jl
dCA9IG1uLT5vcHMtPmludmFsaWRhdGVfcmFuZ2Vfc3RhcnQobW4sIG1tLCBzdGFydCwgZW5kLCBi
bG9ja2FibGUpOw0KPiArCQkJaWYgKElTX0VOQUJMRUQoQ09ORklHX0RFQlVHX0FUT01JQ19TTEVF
UCkgJiYgIWJsb2NrYWJsZSkNCj4gKwkJCQlwcmVlbXB0X2VuYWJsZSgpOw0KDQpKdXN0IGZvciB0
aGUgc2FrZSBvZiBiZXR0ZXIgZG9jdW1lbnRpbmcgdGhpcyBob3cgYWJvdXQgYWRkaW5nIHRoaXMg
dG8gDQppbmNsdWRlL2xpbnV4L2tlcm5lbC5oIHJpZ2h0IG5leHQgdG8gbWlnaHRfc2xlZXAoKToN
Cg0KI2RlZmluZSBkaXNhbGxvd19zbGVlcGluZ19pZihjb25kKcKgwqDCoCBmb3IoKGNvbmQpID8g
cHJlZW1wdF9kaXNhYmxlKCkgOiANCih2b2lkKTA7IChjb25kKTsgcHJlZW1wdF9kaXNhYmxlKCkp
DQoNCihKdXN0IGZyb20gdGhlIGJhY2sgb2YgbXkgaGVhZCwgbWlnaHQgY29udGFpbiBwZWFudXRz
IGFuZC9vciBoaW50cyBvZiANCmVycm9ycykuDQoNCkNocmlzdGlhbi4NCg0KPiAgIAkJCWlmIChf
cmV0KSB7DQo+ICAgCQkJCXByX2luZm8oIiVwUyBjYWxsYmFjayBmYWlsZWQgd2l0aCAlZCBpbiAl
c2Jsb2NrYWJsZSBjb250ZXh0LlxuIiwNCj4gICAJCQkJCQltbi0+b3BzLT5pbnZhbGlkYXRlX3Jh
bmdlX3N0YXJ0LCBfcmV0LA0KDQo=
