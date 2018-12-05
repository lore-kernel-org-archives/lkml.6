Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79ADC65BB3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E982082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ql+MaIyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E982082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbeLEGqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:46:45 -0500
Received: from mail-eopbgr800048.outbound.protection.outlook.com ([40.107.80.48]:43389
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726092AbeLEGqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:46:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDyD2Niw5mVJQZRQeb0cnSA7PhYXZeesCA7sPZTe98o=;
 b=Ql+MaIyxgGdhH+sKY0Dv5feBchiub/8EzEZ9DdJxVi4Os9X0ffojOOI0NaH9RseuO1+OM/602T9l+yZ0KPSENExI/YqqawxkBGBpolhOpm0abh91eakwZboJEONK3yNaxDTXOqx4Bg4ZcIZ1h4YzwTi0HM715cfXlKIXQqA9M/k=
Received: from BN8PR12MB3508.namprd12.prod.outlook.com (20.179.67.161) by
 BN8PR12MB2850.namprd12.prod.outlook.com (20.179.64.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Wed, 5 Dec 2018 06:46:00 +0000
Received: from BN8PR12MB3508.namprd12.prod.outlook.com
 ([fe80::79d8:798b:6260:a546]) by BN8PR12MB3508.namprd12.prod.outlook.com
 ([fe80::79d8:798b:6260:a546%4]) with mapi id 15.20.1382.020; Wed, 5 Dec 2018
 06:45:59 +0000
From:   "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>
To:     Yu Zhao <yuzhao@google.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        aroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     Daniel Kurtz <djkurtz@chromium.org>,
        "Agrawal, Akshu" <Akshu.Agrawal@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ASoC: use dma_ops of parent device for acp_audio_dma
Thread-Topic: [PATCH 2/2] ASoC: use dma_ops of parent device for acp_audio_dma
Thread-Index: AQHUjCK7qshLmPfge0eZEWUg7ltiKaVvtY2A
Date:   Wed, 5 Dec 2018 06:45:59 +0000
Message-ID: <cc34f15e-c8a3-da32-4a61-a6c34bed8281@amd.com>
References: <20181204224253.216075-1-yuzhao@google.com>
 <20181204224253.216075-2-yuzhao@google.com>
In-Reply-To: <20181204224253.216075-2-yuzhao@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::27) To BN8PR12MB3508.namprd12.prod.outlook.com
 (2603:10b6:408:6e::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Vijendar.Mukunda@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [125.21.194.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN8PR12MB2850;20:gRyo5Ds6POKYwwdZzLuAjkdnxVDG4YfCNSCKZjR9ThNMeTJldYew1MkmgFXIl4iZTdf7waX/pMfdLG3TAk/zR+J2vGFza4IyZ0z408PG/HWm5AoB9d98XKXQ7VqQjtoN2E0qpg1HaDvdClwGqhLAyr8WBmHiTtfPvgwNNAH344mNrFtzeB1xfCzHe09KLeERsT4bfKxW+i/69kJ+rCIKX66omzofgS4GhveDV4Omncpd8OHevp34P3hnjJuxhkrz
x-ms-office365-filtering-correlation-id: b714bbf5-7ae2-4ddb-1065-08d65a7d50f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN8PR12MB2850;
x-ms-traffictypediagnostic: BN8PR12MB2850:
x-microsoft-antispam-prvs: <BN8PR12MB2850F1E96C54F5EB7AB2FEFE97A80@BN8PR12MB2850.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN8PR12MB2850;BCL:0;PCL:0;RULEID:;SRVR:BN8PR12MB2850;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(366004)(39850400004)(376002)(199004)(189003)(6506007)(102836004)(476003)(386003)(6486002)(256004)(6436002)(229853002)(36756003)(14454004)(97736004)(54906003)(5660300001)(86362001)(3846002)(71200400001)(71190400001)(6116002)(110136005)(31696002)(316002)(31686004)(99286004)(52116002)(305945005)(7736002)(4326008)(25786009)(2906002)(106356001)(105586002)(6246003)(72206003)(478600001)(76176011)(81166006)(26005)(81156014)(8676002)(39060400002)(486006)(446003)(8936002)(6512007)(66066001)(11346002)(186003)(68736007)(53936002)(53546011)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR12MB2850;H:BN8PR12MB3508.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: R7fCAJMeeo0usH8luhtyDQWYB/LSqFt5bS8OK8pDuF7T6QYohreKCYfy05kCbV4rWwtkxCLT1F26OwbCk2ktLfRhl1bGZWwQNlm45ygaZ+Wgw7o3MFFrRBrXB2gwWbccj2h+r0Ey/YGBjmNw1u57Z2fW9LgREH6T6Cq39/r2tPW8ydiZ4p2ghGUOg4BCrB65rKznyxSlUNDVV01wGC/O9JHwKeyz84OOuSr75Ecus5Q9qfeJs5xDro66UyzoBzN8p/VoLvSs2kZxHMMIhagsR9J1idwzuatISPHIkpl7u5J2N+udpU5mjygsCLomegp5/MwO40efSF2CLGTEtF8tex6rk/6+kDoBOcbdDb4fVQE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <79023FCB5CE2AD42A6B87E2AFFB67F79@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b714bbf5-7ae2-4ddb-1065-08d65a7d50f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 06:45:59.8277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2850
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA1LzEyLzE4IDQ6MTIgQU0sIFl1IFpoYW8gd3JvdGU6DQo+IEFNRCBwbGF0Zm9ybSBk
ZXZpY2UgYWNwX2F1ZGlvX2RtYSBjYW4gb25seSBiZSBjcmVhdGVkIGJ5IHBhcmVudCBQQ0kNCj4g
ZGV2aWNlIGRyaXZlciAoZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FjcC5jKS4g
UGFzcyBzdHJ1Y3QNCj4gZGV2aWNlIG9mIHRoZSBwYXJlbnQgdG8gc25kX3BjbV9saWJfcHJlYWxs
b2NhdGVfcGFnZXMoKSBzbw0KPiBkbWFfYWxsb2NfY29oZXJlbnQoKSBjYW4gdXNlIGNvcnJlY3Qg
ZG1hX29wcy4gT3RoZXJ3aXNlLCBpdCB3aWxsDQo+IHVzZSBkZWZhdWx0IGRtYV9vcHMgd2hpY2gg
aXMgbm9tbXVfZG1hX29wcyBvbiB4ODZfNjQgZXZlbiB3aGVuDQo+IElPTU1VIGlzIGVuYWJsZWQg
YW5kIHNldCB0byBub24gcGFzc3Rocm91Z2ggbW9kZS4NCj4gDQo+IFRob3VnaCBwbGF0Zm9ybSBk
ZXZpY2UgaW5oZXJpdHMgc29tZSBkbWEgcmVsYXRlZCBmaWVsZHMgZHVyaW5nIGl0cw0KPiBjcmVh
dGlvbiBpbiBtZmRfYWRkX2RldmljZSgpLCB3ZSBjYW4ndCBzaW1wbHkgcGFzcyBpdHMgc3RydWN0
IGRldmljZQ0KPiB0byBzbmRfcGNtX2xpYl9wcmVhbGxvY2F0ZV9wYWdlcygpIGJlY2F1c2UgZG1h
X29wcyBpcyBub3QgYW1vbmcgdGhlDQo+IGluaGVyaXRlZCBmaWVsZHMuIEV2ZW4gaXQgd2VyZSwg
ZHJpdmVycy9pb21tdS9hbWRfaW9tbXUuYyB3b3VsZA0KPiBpZ25vcmUgaXQgYmVjYXVzZSBnZXRf
ZGV2aWNlX2lkKCkgZG9lc24ndCBoYW5kbGUgcGxhdGZvcm0gZGV2aWNlLg0KPiANCj4gVGhpcyBj
aGFuZ2Ugc2hvdWxkbid0IGdpdmUgdXMgYW55IHRyb3VibGUgZXZlbiBzdHJ1Y3QgZGV2aWNlIG9m
IHRoZQ0KPiBwYXJlbnQgYmVjb21lcyBudWxsIG9yIHJlcHJlc2VudHMgc29tZSBub24gUENJIGRl
dmljZSBpbiB0aGUgZnV0dXJlLA0KPiBiZWNhdXNlIGdldF9kbWFfb3BzKCkgY29ycmVjdGx5IGhh
bmRsZXMgbnVsbCBzdHJ1Y3QgZGV2aWNlIG9yIHVzZXMNCj4gdGhlIGRlZmF1bHQgZG1hX29wcyBp
ZiBzdHJ1Y3QgZGV2aWNlIGRvZXNuJ3QgaGF2ZSBpdCBzZXQuDQo+IA0KDQpUaGlzIGlzIHJlYWxs
eSBhIGdvb2QgZml4LiBXZSB3aWxsIGFsc28gYXBwbHkgdGhpcyBmaXggZm9yIFJhdmVuIHBsYXRm
b3JtLg0KDQpUaGFua3MsDQpWaWplbmRhcg0KPiBTaWduZWQtb2ZmLWJ5OiBZdSBaaGFvIDx5dXpo
YW9AZ29vZ2xlLmNvbT4NCj4gLS0tDQo+ICAgc291bmQvc29jL2FtZC9hY3AtcGNtLWRtYS5jIHwg
NyArKysrKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvYW1kL2FjcC1wY20tZG1hLmMgYi9z
b3VuZC9zb2MvYW1kL2FjcC1wY20tZG1hLmMNCj4gaW5kZXggZmQzZGI0YzM3ODgyLi5mNDAxMWJl
YmM3ZWMgMTAwNjQ0DQo+IC0tLSBhL3NvdW5kL3NvYy9hbWQvYWNwLXBjbS1kbWEuYw0KPiArKysg
Yi9zb3VuZC9zb2MvYW1kL2FjcC1wY20tZG1hLmMNCj4gQEAgLTExNDYsMTggKzExNDYsMjEgQEAg
c3RhdGljIGludCBhY3BfZG1hX25ldyhzdHJ1Y3Qgc25kX3NvY19wY21fcnVudGltZSAqcnRkKQ0K
PiAgIAlzdHJ1Y3Qgc25kX3NvY19jb21wb25lbnQgKmNvbXBvbmVudCA9IHNuZF9zb2NfcnRkY29t
X2xvb2t1cChydGQsDQo+ICAgCQkJCQkJCQkgICAgRFJWX05BTUUpOw0KPiAgIAlzdHJ1Y3QgYXVk
aW9fZHJ2X2RhdGEgKmFkYXRhID0gZGV2X2dldF9kcnZkYXRhKGNvbXBvbmVudC0+ZGV2KTsNCj4g
KwlzdHJ1Y3QgZGV2aWNlICpwYXJlbnQgPSBjb21wb25lbnQtPmRldi0+cGFyZW50Ow0KPiAgIA0K
PiAgIAlzd2l0Y2ggKGFkYXRhLT5hc2ljX3R5cGUpIHsNCj4gICAJY2FzZSBDSElQX1NUT05FWToN
Cj4gICAJCXJldCA9IHNuZF9wY21fbGliX3ByZWFsbG9jYXRlX3BhZ2VzX2Zvcl9hbGwocnRkLT5w
Y20sDQo+ICAgCQkJCQkJCSAgICBTTkRSVl9ETUFfVFlQRV9ERVYsDQo+IC0JCQkJCQkJICAgIE5V
TEwsIFNUX01JTl9CVUZGRVIsDQo+ICsJCQkJCQkJICAgIHBhcmVudCwNCj4gKwkJCQkJCQkgICAg
U1RfTUlOX0JVRkZFUiwNCj4gICAJCQkJCQkJICAgIFNUX01BWF9CVUZGRVIpOw0KPiAgIAkJYnJl
YWs7DQo+ICAgCWRlZmF1bHQ6DQo+ICAgCQlyZXQgPSBzbmRfcGNtX2xpYl9wcmVhbGxvY2F0ZV9w
YWdlc19mb3JfYWxsKHJ0ZC0+cGNtLA0KPiAgIAkJCQkJCQkgICAgU05EUlZfRE1BX1RZUEVfREVW
LA0KPiAtCQkJCQkJCSAgICBOVUxMLCBNSU5fQlVGRkVSLA0KPiArCQkJCQkJCSAgICBwYXJlbnQs
DQo+ICsJCQkJCQkJICAgIE1JTl9CVUZGRVIsDQo+ICAgCQkJCQkJCSAgICBNQVhfQlVGRkVSKTsN
Cj4gICAJCWJyZWFrOw0KPiAgIAl9DQo+IA0K
