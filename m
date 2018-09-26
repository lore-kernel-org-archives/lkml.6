Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62629C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2FE21531
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YMmSQWTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2FE21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbeI0BZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:25:33 -0400
Received: from mail-eopbgr700072.outbound.protection.outlook.com ([40.107.70.72]:10018
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726304AbeI0BZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D00xAK8WgNemTCfSnTVJBkMqpBnKrFx3QK/zpPX08TA=;
 b=YMmSQWTK8AAMJPv7tcDklTho/YF9k5TUmVEBVLl9Nj0l0umgIhfU0ZgYg48YDi0pL8PfYZFnEeKTi4UKjWQ0zZp4BV0wY9zpukdc+9mvstVYZejr+ZqYpqOMM+Sliml3Zu0bGc+gvWsAqOkNWt2+4Ati9Sp9bmSfkD/xeFW6uww=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB2576.namprd12.prod.outlook.com (52.132.197.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Wed, 26 Sep 2018 19:11:04 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::2d1b:5638:5680:80e7]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::2d1b:5638:5680:80e7%5]) with mapi id 15.20.1143.022; Wed, 26 Sep 2018
 19:11:03 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [Patch v2 3/4] x86/speculation: Extend per process STIBP to AMD
 cpus.
Thread-Topic: [Patch v2 3/4] x86/speculation: Extend per process STIBP to AMD
 cpus.
Thread-Index: AQHUVTbpuNPfpG7ENUK1PyuvJmZ7v6UC0QyAgAAd0wA=
Date:   Wed, 26 Sep 2018 19:11:03 +0000
Message-ID: <769e4725-754b-9185-7d91-c0f4dfb06b09@amd.com>
References: <cover.1537920575.git.tim.c.chen@linux.intel.com>
 <705b51cba5b5e7805aeb08af7f7d21e6ec897a17.1537920575.git.tim.c.chen@linux.intel.com>
 <cf7e8b0b-4195-6fea-df75-cb9ac2023a1d@linux.intel.com>
In-Reply-To: <cf7e8b0b-4195-6fea-df75-cb9ac2023a1d@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:102:2::18) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB2576;20:E6mirWw8V0RXXZCRBCF64+KZEYHH/+3AO40KgSU8oRFqXXgYftaRaEOz5FacgHjHu1kkKm4vT4NvxgjgOuoMPVn3TIG3rOF/UkiXV9iYJfn2ObYDJM0UObd7knVA/hjib+7tphpfw3ceCA8k6T3okhU/hLcXsV5yydBcvyeWdCMalc5kEDCHMdNaOJXj0nKdVTCxzgthQM7EerM7M446FkLV94kk9HOw1G+uJayzI4Y/lkfbARJTUN76BwzUJQxw
x-ms-office365-filtering-correlation-id: 54585d41-a95d-4ec5-f063-08d623e3cd6b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2576;
x-ms-traffictypediagnostic: SN1PR12MB2576:
x-microsoft-antispam-prvs: <SN1PR12MB2576FBA55ACB86DD5741518CEC150@SN1PR12MB2576.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:SN1PR12MB2576;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2576;
x-forefront-prvs: 08076ABC99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(136003)(39860400002)(43544003)(189003)(199004)(36756003)(6486002)(72206003)(486006)(14454004)(53936002)(229853002)(6246003)(316002)(3846002)(6116002)(71200400001)(25786009)(71190400001)(6512007)(8936002)(6436002)(8676002)(81166006)(81156014)(2616005)(4326008)(476003)(66066001)(11346002)(31696002)(446003)(256004)(106356001)(14444005)(54906003)(110136005)(478600001)(7416002)(86362001)(31686004)(105586002)(386003)(2900100001)(53546011)(6506007)(305945005)(34290500001)(76176011)(7736002)(52116002)(26005)(97736004)(68736007)(186003)(2906002)(5660300001)(99286004)(5250100002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2576;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0lJfrBj+cgS2I7JxhlD4o/6UsX+SkWiOUGQ+Hlnrr1MP4uNwGFpK44apP4LgTNxkqrQIWO0E81hwLhbhERBTKHnDiuvuv1+/dc2wcjiqorNDiQr4IU8mmQ2axUYNv8odJ6TeoFt1bNHzVFLB5icM4Xm8bu7RHoVxxqqYGVrDfxOkYe6CqMZu8ALuQRiCkv3eG5cj6BCAWuAGXlM4BMIvXSb68/tbleI4B3DMQgQqAJo2e/4LBONiyTMx4l0tbwxQpy7Uf4zfbuhhvcRL+bpWbDWsyQxLQqgMvfyEJDHTBSkSJsTWSOhUuDPrCofoa6jQBQzLV7TvQ9hc0zuPp5b1yXp4qhGpsYVB/UVRF8rQ9QQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A800F048532DFF46B00813CE8F941E51@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54585d41-a95d-4ec5-f063-08d623e3cd6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2018 19:11:03.8268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2576
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMjYvMjAxOCAxMjoyNCBQTSwgVGltIENoZW4gd3JvdGU6DQo+IE9uIDA5LzI1LzIwMTgg
MDU6NDMgUE0sIFRpbSBDaGVuIHdyb3RlOg0KPj4gRnJvbTogVGhvbWFzIExlbmRhY2t5IDxUaG9t
YXMuTGVuZGFja3lAYW1kLmNvbT4NCj4+DQo+PiBXZSBleHRlbmQgdGhlIGFwcCB0byBhcHAgc3Bl
Y3RyZSB2MiBtaXRpZ2F0aW9uIHVzaW5nIFNUSUJQDQo+PiB0byB0aGUgQU1EIGNwdXMuIFdlIG5l
ZWQgdG8gdGFrZSBjYXJlIG9mIHNwZWNpYWwNCj4+IGNhc2VzIGZvciBBTUQgY3B1J3MgdXBkYXRl
IG9mIFNQRUNfQ1RSTCBNU1IgdG8gYXZvaWQgZG91YmxlDQo+PiB3cml0aW5nIG9mIE1TUnMgZnJv
bSB1cGRhdGUgdG8gU1NCRCBhbmQgU1RJQlAuDQo+IA0KPiBUb20sIGlmIHRoaXMgcGF0Y2ggbG9v
a3Mgb2theSB0byB5b3UsIGNhbiBJIGFkZCB5b3VyIHNpZ24gb2ZmPw0KDQpIaSBUaW0sDQoNCll1
cCwgdGhhdCBsb29rcyBjb3JyZWN0Lg0KDQo+IA0KPiBUaW0NCj4gDQo+Pg0KPj4gT3JpZ2luYWxs
eS1ieTogVGhvbWFzIExlbmRhY2t5IDxUaG9tYXMuTGVuZGFja3lAYW1kLmNvbT4NCj4+IFNpZ25l
ZC1vZmYtYnk6IFRpbSBDaGVuIDx0aW0uYy5jaGVuQGxpbnV4LmludGVsLmNvbT4NCg0KU2lnbmVk
LW9mZi1ieTogVG9tIExlbmRhY2t5IDx0aG9tYXMubGVuZGFja3lAYW1kLmNvbT4NCg0KVGhhbmtz
LA0KVG9tDQoNCj4+IC0tLQ0KPj4gIGFyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmMgfCA0OCArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPj4gIDEgZmlsZSBj
aGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvYXJjaC94ODYva2VybmVsL3Byb2Nlc3MuYyBiL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNz
LmMNCj4+IGluZGV4IGNiMjQwMTQuLjRhM2E2NzIgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9r
ZXJuZWwvcHJvY2Vzcy5jDQo+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jDQo+PiBA
QCAtMzk5LDYgKzM5OSwxMCBAQCBzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQgc2V0X3NwZWNf
Y3RybF9zdGF0ZSh1bnNpZ25lZCBsb25nIHRpZm4pDQo+PiAgew0KPj4gIAl1NjQgbXNyID0geDg2
X3NwZWNfY3RybF9iYXNlOw0KPj4gIA0KPj4gKwkvKg0KPj4gKwkgKiBBTUQgY3B1IG1heSBoYXZl
IHVzZWQgYSBkaWZmZXJlbnQgbWV0aG9kIHRvIHVwZGF0ZSBTU0JELCBzbw0KPj4gKwkgKiB3ZSBu
ZWVkIHRvIGJlIHN1cmUgd2UgYXJlIHVzaW5nIHRoZSBTUEVDX0NUUkwgTVNSIGZvciBTU0JELg0K
Pj4gKwkgKi8NCj4+ICAJaWYgKHN0YXRpY19jcHVfaGFzKFg4Nl9GRUFUVVJFX1NTQkQpKQ0KPj4g
IAkJbXNyIHw9IHNzYmRfdGlmX3RvX3NwZWNfY3RybCh0aWZuKTsNCj4+ICANCj4+IEBAIC00MDgs
MjAgKzQxMiw0NSBAQCBzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQgc2V0X3NwZWNfY3RybF9z
dGF0ZSh1bnNpZ25lZCBsb25nIHRpZm4pDQo+PiAgCXdybXNybChNU1JfSUEzMl9TUEVDX0NUUkws
IG1zcik7DQo+PiAgfQ0KPj4gIA0KPj4gLXN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9pZCBfX3Nw
ZWN1bGF0aXZlX3N0b3JlX2J5cGFzc191cGRhdGUodW5zaWduZWQgbG9uZyB0aWZuKQ0KPj4gK3N0
YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9pZCBfX3NwZWN1bGF0aXZlX3N0b3JlX2J5cGFzc191cGRh
dGUodW5zaWduZWQgbG9uZyB0aWZwLA0KPj4gKwkJCQkJCQkgICAgICB1bnNpZ25lZCBsb25nIHRp
Zm4pDQo+PiAgew0KPj4gLQlpZiAoc3RhdGljX2NwdV9oYXMoWDg2X0ZFQVRVUkVfVklSVF9TU0JE
KSkNCj4+IC0JCWFtZF9zZXRfc3NiX3ZpcnRfc3RhdGUodGlmbik7DQo+PiAtCWVsc2UgaWYgKHN0
YXRpY19jcHVfaGFzKFg4Nl9GRUFUVVJFX0xTX0NGR19TU0JEKSkNCj4+IC0JCWFtZF9zZXRfY29y
ZV9zc2Jfc3RhdGUodGlmbik7DQo+PiAtCWVsc2UNCj4+IC0JCXNldF9zcGVjX2N0cmxfc3RhdGUo
dGlmbik7DQo+PiArCWJvb2wgc3RpYnAgPSAhISgodGlmcCBeIHRpZm4pICYgX1RJRl9TVElCUCk7
DQo+PiArCWJvb2wgc3NiZCA9ICEhKCh0aWZwIF4gdGlmbikgJiBfVElGX1NTQkQpOw0KPj4gKw0K
Pj4gKwlpZiAoIXNzYmQgJiYgIXN0aWJwKQ0KPj4gKwkJcmV0dXJuOw0KPj4gKw0KPj4gKwlpZiAo
c3NiZCkgew0KPj4gKwkJLyoNCj4+ICsJCSAqIEZvciBBTUQsIHRyeSB0aGVzZSBtZXRob2RzIGZp
cnN0LiAgVGhlIHNzYmQgdmFyaWFibGUgd2lsbA0KPj4gKwkJICogcmVmbGVjdCBpZiB0aGUgU1BF
Q19DVFJMIE1TUiBtZXRob2QgaXMgbmVlZGVkLg0KPj4gKwkJICovDQo+PiArCQlzc2JkID0gZmFs
c2U7DQo+PiArDQo+PiArCQlpZiAoc3RhdGljX2NwdV9oYXMoWDg2X0ZFQVRVUkVfVklSVF9TU0JE
KSkNCj4+ICsJCQlhbWRfc2V0X3NzYl92aXJ0X3N0YXRlKHRpZm4pOw0KPj4gKwkJZWxzZSBpZiAo
c3RhdGljX2NwdV9oYXMoWDg2X0ZFQVRVUkVfTFNfQ0ZHX1NTQkQpKQ0KPj4gKwkJCWFtZF9zZXRf
Y29yZV9zc2Jfc3RhdGUodGlmbik7DQo+PiArCQllbHNlDQo+PiArCQkJc3NiZCA9IHRydWU7DQo+
PiArCX0NCj4+ICsNCj4+ICsJLyogQXZvaWQgYSBwb3NzaWJsZSBleHRyYSBNU1Igd3JpdGUsIHJl
Y2hlY2sgdGhlIGZsYWdzICovDQo+PiArCWlmICghc3NiZCAmJiAhc3RpYnApDQo+PiArCQlyZXR1
cm47DQo+PiArDQo+PiArCXNldF9zcGVjX2N0cmxfc3RhdGUodGlmbik7DQo+PiAgfQ0KPj4gIA0K
Pj4gIHZvaWQgc3BlY3VsYXRpdmVfc3RvcmVfYnlwYXNzX3VwZGF0ZSh1bnNpZ25lZCBsb25nIHRp
ZikNCj4+ICB7DQo+PiArCS8qDQo+PiArCSAqIE9uIHRoaXMgcGF0aCB3ZSdyZSBmb3JjaW5nIHRo
ZSB1cGRhdGUsIHNvIHVzZSB+dGlmIGFzIHRoZQ0KPj4gKwkgKiBwcmV2aW91cyBmbGFncy4NCj4+
ICsJICovDQo+PiAgCXByZWVtcHRfZGlzYWJsZSgpOw0KPj4gLQlfX3NwZWN1bGF0aXZlX3N0b3Jl
X2J5cGFzc191cGRhdGUodGlmKTsNCj4+ICsJX19zcGVjdWxhdGl2ZV9zdG9yZV9ieXBhc3NfdXBk
YXRlKH50aWYsIHRpZik7DQo+PiAgCXByZWVtcHRfZW5hYmxlKCk7DQo+PiAgfQ0KPj4gIA0KPj4g
QEAgLTQ1Nyw4ICs0ODYsNyBAQCB2b2lkIF9fc3dpdGNoX3RvX3h0cmEoc3RydWN0IHRhc2tfc3Ry
dWN0ICpwcmV2X3AsIHN0cnVjdCB0YXNrX3N0cnVjdCAqbmV4dF9wLA0KPj4gIAlpZiAoKHRpZnAg
XiB0aWZuKSAmIF9USUZfTk9DUFVJRCkNCj4+ICAJCXNldF9jcHVpZF9mYXVsdGluZyghISh0aWZu
ICYgX1RJRl9OT0NQVUlEKSk7DQo+PiAgDQo+PiAtCWlmICgodGlmcCBeIHRpZm4pICYgKF9USUZf
U1NCRCB8IF9USUZfU1RJQlApKQ0KPj4gLQkJX19zcGVjdWxhdGl2ZV9zdG9yZV9ieXBhc3NfdXBk
YXRlKHRpZm4pOw0KPj4gKwlfX3NwZWN1bGF0aXZlX3N0b3JlX2J5cGFzc191cGRhdGUodGlmcCwg
dGlmbik7DQo+PiAgfQ0KPj4gIA0KPj4gIC8qDQo+Pg0KPiANCg==
