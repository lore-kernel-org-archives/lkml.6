Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18252C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0488206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BWPaWGmv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfAJIg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:36:59 -0500
Received: from mail-eopbgr700048.outbound.protection.outlook.com ([40.107.70.48]:51518
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726369AbfAJIg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:36:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njfjVCvUL06l4WW6en/rOtyVLTktrSjrPmo4bkXx2Cw=;
 b=BWPaWGmvDfQmBM8IsoU4VxEweacU1uJ3VmrZIDvI1BSTij367KQH7SeUIt2DQZ2yFrPH2hDbN1qrFvHiCQsu8Lo8kB6gFPBAkFc5DJBKgGUwKngnY1KVqWzjag9tPDQKXxzjB6gshT50xphhETmNeKapAbKEy/L5Fxuc+2w/N+0=
Received: from BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11) by
 BN6PR12MB1236.namprd12.prod.outlook.com (10.168.227.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.15; Thu, 10 Jan 2019 08:36:52 +0000
Received: from BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::1c01:3bbc:5ef1:4090]) by BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::1c01:3bbc:5ef1:4090%11]) with mapi id 15.20.1516.015; Thu, 10 Jan
 2019 08:36:52 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "Bernhard.Rosenkranzer@linaro.org" <Bernhard.Rosenkranzer@linaro.org>,
        "Carsten.Haitzler@arm.com" <Carsten.Haitzler@arm.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Zhang, Jerry" <Jerry.Zhang@amd.com>,
        David Airlie <airlied@linux.ie>
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
Thread-Topic: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
Thread-Index: AQHUqLYqeBA87jEBLUOvwyi3in13KaWoLdCA
Date:   Thu, 10 Jan 2019 08:36:52 +0000
Message-ID: <1ef4c460-9f11-3894-712f-b19b67287c4b@amd.com>
References: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:125b:9a00:a142:2be6:b7be:5a3a]
x-clientproxiedby: AM5PR0202CA0004.eurprd02.prod.outlook.com
 (2603:10a6:203:69::14) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1236;20:9QuVhKajwWEt+O0qT4vZN1R0wCAChLEYv/X6ojX3IIXSpqOksHIeoQiSPU7bArOP9uSj7kEkEuOY8wnA9dpyhXL9J0gVSe9P9JTOO5LBkXJsJSB2Isr0BZwYCca0I5wSwZflAGZdyhkWqsZ8eGtYxUC33GpaXgSAVzSmqujiIQQuTxROQChO+cuPEihgW+6eN1FPM0JBU0Hz3cK2w7g5zGUTaYmBmsP8IaBxASAPyEGPMFraGePzS2IYsOj2W9u8
x-ms-office365-filtering-correlation-id: 6372ea1d-7e7b-4acc-4a72-08d676d6c52b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1236;
x-ms-traffictypediagnostic: BN6PR12MB1236:
x-microsoft-antispam-prvs: <BN6PR12MB1236E3815C269D269325248783840@BN6PR12MB1236.namprd12.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(366004)(189003)(199004)(52116002)(2906002)(86362001)(99286004)(2501003)(76176011)(31696002)(54906003)(110136005)(316002)(36756003)(58126008)(72206003)(81166006)(8676002)(81156014)(14454004)(486006)(305945005)(478600001)(7736002)(6486002)(229853002)(8936002)(6436002)(106356001)(102836004)(105586002)(186003)(31686004)(386003)(6506007)(2616005)(476003)(68736007)(11346002)(446003)(46003)(4326008)(14444005)(256004)(64126003)(25786009)(97736004)(5660300001)(6512007)(65956001)(71190400001)(71200400001)(65806001)(6246003)(53936002)(6116002)(65826007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1236;H:BN6PR12MB1714.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CT25AwGHfhC4xNqLPU8CVb34MNnC+Zzwnw8wpFvzEH7nXMJJjpa3Id78GIgR/hPYMV1gGX4LGjnjnPRugazaHhgnMTA6RoYCRB1Ssqb8lsId6VG3s1ckfWnmypELUFlTMVZ0RuHubCiWHZ91IghC1Me1qsTriwzNqcWrAmdru7bIFlD+5joqx9FYQwE+gmV6lsGnCz8YXUP+Me120xyx96FMvICa/ngz38os0s2MrNb6tOQo4LxD91fe6R4nbbYTU8B/UP/Ln19l+VqSu2mVPtQiV2OtTQ9INmosdBovpZLK8ik+XaJYwnlEmG8LNjKF
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <410D8B22E2614F46A9833CB4D8DDB197@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6372ea1d-7e7b-4acc-4a72-08d676d6c52b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 08:36:52.4713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1236
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJkLA0KDQp0aGFua3MgYSBsb3QgZm9yIHRoaXMhIEF0IGxlYXN0IHNvbWVib2R5IHdobyBj
YW4gZXhwbGFpbiB3aHkgdGhpcyANCmRvZXNuJ3Qgd29yayBhcyBleHBlY3RlZC4NCg0KVGhlIHBy
b2JsZW0gaXMgdGhhdCB0aGUgaGFyZHdhcmUgYWN0dWFsbHkgbmVlZHMgYSBmZXcgcGFnZXMgYXMg
dW5jYWNoZWQgDQppbiBhIGNvdXBsZSBvZiBjYXNlcyB0byB3b3JrIGNvcnJlY3RseS4gU28gd2Ug
Y291bGQgc3RpbGwgcnVuIGludG8gDQppc3N1ZXMgd2l0aCB0aGF0IHNvbHV0aW9uLg0KDQpGb3Ig
bm93IHdlIGhhdmUgYmxvY2tlZCB1c2Vyc3BhY2Uva2VybmVsIGZyb20gZXh0ZW5zaXZlbHkgdXNp
bmcgd3JpdGUgDQpjb21iaW5lIG1hcHBpbmdzIGJ5IGFkanVzdGluZyBkcm1fYXJjaF9jYW5fd2Nf
bWVtb3J5KCksIGJ1dCB0aGF0IGlzIA0KcHJvYmFibHkgZGVncmFkaW5nIHBlcmZvcm1hbmNlIHF1
aXRlIGEgYml0Lg0KDQpXaGF0IGNhbiBiZSBkb25lIHRvIGltcHJvdmUgdGhlIHNvbHV0aW9uPyBB
dCBsZWFzdCBvbiBYODYgd2Ugc29sdmUgdGhpcyANCmJ5IG1hcmtpbmcgdGhlIHdyaXRlIGNvbWJp
bmVkIHBhZ2VzIGluIHRoZSBsaW5lYXIgbWFwcGluZyBhcyB1bmNhY2hlZCBhcyANCndlbGwuIFdv
dWxkIHRoaXMgYmUgZG9hYmxlIG9uIEFSTSBhcyB3ZWxsPw0KDQpUaGFua3MsDQpDaHJpc3RpYW4u
DQoNCkFtIDEwLjAxLjE5IHVtIDA4OjI4IHNjaHJpZWIgQXJkIEJpZXNoZXV2ZWw6DQo+IEFSTSBz
eXN0ZW1zIGRvIG5vdCBwZXJtaXQgdGhlIHVzZSBvZiBhbnl0aGluZyBvdGhlciB0aGFuIGNhY2hl
ZA0KPiBtYXBwaW5ncyBmb3Igc3lzdGVtIG1lbW9yeSwgc2luY2UgdGhhdCBtZW1vcnkgbWF5IGJl
IG1hcHBlZCBpbiB0aGUNCj4gbGluZWFyIHJlZ2lvbiBhcyB3ZWxsLCBhbmQgdGhlIGFyY2hpdGVj
dHVyZSBkb2VzIG5vdCBwZXJtaXQgYWxpYXNlcw0KPiB3aXRoIG1pc21hdGNoZWQgYXR0cmlidXRl
cy4NCj4NCj4gU28gc2hvcnQtY2lyY3VpdCB0aGUgZXZhbHVhdGlvbiBpbiB0dG1faW9fcHJvdCgp
IGlmIHRoZSBmbGFncyBpbmNsdWRlDQo+IFRUTV9QTF9TWVNURU0gd2hlbiBydW5uaW5nIG9uIEFS
TSBvciBhcm02NCwgYW5kIGp1c3QgcmV0dXJuIGNhY2hlZA0KPiBhdHRyaWJ1dGVzIGltbWVkaWF0
ZWx5Lg0KPg0KPiBUaGlzIGZpeGVzIHRoZSByYWRlb24gYW5kIGFtZGdwdSBbVEJDXSBkcml2ZXJz
IHdoZW4gcnVubmluZyBvbiBhcm02NC4NCj4gV2l0aG91dCB0aGlzIGNoYW5nZSwgYW1kZ3B1IGRv
ZXMgbm90IHN0YXJ0IGF0IGFsbCwgYW5kIHJhZGVvbiBvbmx5DQo+IHByb2R1Y2VzIGNvcnJ1cHQg
ZGlzcGxheSBvdXRwdXQuDQo+DQo+IENjOiBDaHJpc3RpYW4gS29lbmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+DQo+IENjOiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPg0KPiBDYzog
SnVud2VpIFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPg0KPiBDYzogRGF2aWQgQWlybGllIDxh
aXJsaWVkQGxpbnV4LmllPg0KPiBSZXBvcnRlZC1ieTogQ2Fyc3RlbiBIYWl0emxlciA8Q2Fyc3Rl
bi5IYWl0emxlckBhcm0uY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBcmQgQmllc2hldXZlbCA8YXJk
LmJpZXNoZXV2ZWxAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL3R0bS90
dG1fYm9fdXRpbC5jIHwgNSArKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3V0aWwuYyBi
L2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3V0aWwuYw0KPiBpbmRleCAwNDZhNmRkYTY5MGEu
LjBjMWVlZjVmN2FlMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9f
dXRpbC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3V0aWwuYw0KPiBAQCAt
NTMwLDYgKzUzMCwxMSBAQCBwZ3Byb3RfdCB0dG1faW9fcHJvdCh1aW50MzJfdCBjYWNoaW5nX2Zs
YWdzLCBwZ3Byb3RfdCB0bXApDQo+ICAgCWlmIChjYWNoaW5nX2ZsYWdzICYgVFRNX1BMX0ZMQUdf
Q0FDSEVEKQ0KPiAgIAkJcmV0dXJuIHRtcDsNCj4gICANCj4gKyNpZiBkZWZpbmVkKF9fYXJtX18p
IHx8IGRlZmluZWQoX19hYXJjaDY0X18pDQo+ICsJLyogQVJNIG9ubHkgcGVybWl0cyBjYWNoZWQg
bWFwcGluZ3Mgb2Ygc3lzdGVtIG1lbW9yeSAqLw0KPiArCWlmIChjYWNoaW5nX2ZsYWdzICYgVFRN
X1BMX1NZU1RFTSkNCj4gKwkJcmV0dXJuIHRtcDsNCj4gKyNlbmRpZg0KPiAgICNpZiBkZWZpbmVk
KF9faTM4Nl9fKSB8fCBkZWZpbmVkKF9feDg2XzY0X18pDQo+ICAgCWlmIChjYWNoaW5nX2ZsYWdz
ICYgVFRNX1BMX0ZMQUdfV0MpDQo+ICAgCQl0bXAgPSBwZ3Byb3Rfd3JpdGVjb21iaW5lKHRtcCk7
DQoNCg==
