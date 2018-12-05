Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9481EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D33C2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D33C2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeLEGmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:42:49 -0500
Received: from mail-eopbgr800045.outbound.protection.outlook.com ([40.107.80.45]:51470
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbeLEGms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7MWMbiM/oxW9qEAZ/EeWULfwvMCMdb0bk3WytpmepA=;
 b=sziBtOJBgwWijXvn/xjilBpLNqkQkqzNvzJ2mAa0HuhgC1Sop0uFMvqVh+E2DaTkcPAQJ72T+XI6tT5+WnkmCqpGLMUNFPITTYMLXrCThYoo1TMkPLdud+C2prU+1TaOODjYtiR+SgOkjF6k2+uVk95FGIuPIenXK9GZkdhL/Jo=
Received: from BN8PR12MB3508.namprd12.prod.outlook.com (20.179.67.161) by
 BN8PR12MB2850.namprd12.prod.outlook.com (20.179.64.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Wed, 5 Dec 2018 06:42:43 +0000
Received: from BN8PR12MB3508.namprd12.prod.outlook.com
 ([fe80::79d8:798b:6260:a546]) by BN8PR12MB3508.namprd12.prod.outlook.com
 ([fe80::79d8:798b:6260:a546%4]) with mapi id 15.20.1382.020; Wed, 5 Dec 2018
 06:42:43 +0000
From:   "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>
To:     Yu Zhao <yuzhao@google.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        aroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     Daniel Kurtz <djkurtz@chromium.org>,
        "Agrawal, Akshu" <Akshu.Agrawal@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] ASoC: use DMA addr rather than CPU pa for
 acp_audio_dma
Thread-Topic: [PATCH 1/2] ASoC: use DMA addr rather than CPU pa for
 acp_audio_dma
Thread-Index: AQHUjCK34U0WgShTGkGFHZeJVHaZVqVvtIUA
Date:   Wed, 5 Dec 2018 06:42:43 +0000
Message-ID: <0282a69b-51dc-b1e9-a017-2f18c08b9c50@amd.com>
References: <20181204224253.216075-1-yuzhao@google.com>
In-Reply-To: <20181204224253.216075-1-yuzhao@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::11) To BN8PR12MB3508.namprd12.prod.outlook.com
 (2603:10b6:408:6e::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Vijendar.Mukunda@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [125.21.194.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN8PR12MB2850;20:3gBK9iHxjYBfqVi+HVD1oKMMDBKnArfX4/BpqCPYM5RPw3Qc0CXY6Qwil4o5kERaOZbN/mWp6B5YhTeAc3+7n83v0u9BBWuO1QJbC3cOYtcSUeDZHURLZZVXYRw7SDnbwb1BAUPzIQfvhFmU9fDtPz1uS8kx6R18E/gkHOI9qhKRygXfyMhkM8Fl6bUabawN+odTorVSu3Brr4Yq7qndi4FBT6QnLBmlFxhylyzYGK3aVRn/g5jHafAi5jgkIc6z
x-ms-office365-filtering-correlation-id: 771e3a1b-b5c1-46ee-6d35-08d65a7cdbba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN8PR12MB2850;
x-ms-traffictypediagnostic: BN8PR12MB2850:
x-microsoft-antispam-prvs: <BN8PR12MB285034D5566A052BB1C12A1597A80@BN8PR12MB2850.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN8PR12MB2850;BCL:0;PCL:0;RULEID:;SRVR:BN8PR12MB2850;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39850400004)(346002)(366004)(396003)(136003)(189003)(199004)(2906002)(7736002)(25786009)(4326008)(478600001)(72206003)(76176011)(105586002)(6246003)(106356001)(99286004)(305945005)(52116002)(66066001)(68736007)(186003)(53546011)(2616005)(53936002)(11346002)(81156014)(26005)(81166006)(8676002)(8936002)(6512007)(39060400002)(486006)(446003)(54906003)(36756003)(97736004)(14454004)(5660300001)(476003)(386003)(102836004)(6486002)(6506007)(256004)(14444005)(6436002)(229853002)(31686004)(316002)(3846002)(71190400001)(71200400001)(86362001)(6116002)(110136005)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR12MB2850;H:BN8PR12MB3508.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VpHShlgqSa7WLVtJACK8D7MDLEzyPYXAZu9UmrzY3AXSX6wYnNBlSYDc2dKtlnM1FBYk3ZUEPGm2T2crBOlj2fYgYVXIsB9AV5Y/785KDC+ir549EqKaSojMI72SkNZXW5dgOlSGkMwgBAviKc55k0e2fh5qoDMTmCMgDVdmfIDTcB+WOphzorzG/qt1gW+jIdDGHOxymxkRXVGxAJ2zRJ+vS2AukKu7T0+Nri/pxr4arMFtsQ+Fk0ibo8wWebQ/7rUOlf6yvqFUudYKzYSLQ1ksJYoCHNYK/JRUGBZcHL/KOmqHaKtMVU1quvDwEZ9piIFp5L8gjzVubnWHve7BD4XDPKwqNSq4AIj1XumIegQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E23759D90C2E84B8321C9A4F5666CEB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 771e3a1b-b5c1-46ee-6d35-08d65a7cdbba
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 06:42:43.1228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2850
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA1LzEyLzE4IDQ6MTIgQU0sIFl1IFpoYW8gd3JvdGU6DQo+IFdlIHNob3VsZG4ndCBh
c3N1bWUgQ1BVIHBoeXNpY2FsIGFkZHJlc3Mgd2UgZ2V0IGZyb20gcGFnZV90b19waHlzKCkNCj4g
aXMgc2FtZSBhcyBETUEgYWRkcmVzcyB3ZSBnZXQgZnJvbSBkbWFfYWxsb2NfY29oZXJlbnQoKS4g
T24geDg2XzY0LA0KPiB3ZSB3b24ndCBydW4gaW50byBhbnkgcHJvYmxlbSB3aXRoIHRoZSBhc3N1
bXB0aW9uIHdoZW4gZG1hX29wcyBpcw0KPiBub21tdV9kbWFfb3BzLiBIb3dldmVyLCBETUEgYWRk
cmVzcyBpcyBJT1ZBIHdoZW4gSU9NTVUgaXMgZW5hYmxlZC4NCj4gQW5kIGl0J3MgbW9zdCBsaWtl
bHkgZGlmZmVyZW50IGZyb20gQ1BVIHBoeXNpY2FsIGFkZHJlc3Mgd2hlbiBBTUQNCj4gSU9NTVUg
aXMgbm90IGluIHBhc3N0aHJvdWdoIG1vZGUuDQoNClRoaXMgaXMgcmVhbGx5IGEgZ29vZCBmaXgu
IFdlIHdpbGwgYXBwbHkgdGhpcyBwYXRjaCBjaGFuZ2VzIGZvciBSYXZlbiANCnBsYXRmb3JtIGFs
c28uDQoNClRoYW5rcywNClZpamVuZGFyDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZdSBaaGFvIDx5
dXpoYW9AZ29vZ2xlLmNvbT4NCj4gLS0tDQo+ICAgc291bmQvc29jL2FtZC9hY3AtcGNtLWRtYS5j
IHwgMTUgKysrKystLS0tLS0tLS0tDQo+ICAgc291bmQvc29jL2FtZC9hY3AuaCAgICAgICAgIHwg
IDIgKy0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL2FtZC9hY3AtcGNtLWRtYS5jIGIvc291
bmQvc29jL2FtZC9hY3AtcGNtLWRtYS5jDQo+IGluZGV4IGNkZWJhYjJmOGNlNS4uZmQzZGI0YzM3
ODgyIDEwMDY0NA0KPiAtLS0gYS9zb3VuZC9zb2MvYW1kL2FjcC1wY20tZG1hLmMNCj4gKysrIGIv
c291bmQvc29jL2FtZC9hY3AtcGNtLWRtYS5jDQo+IEBAIC0zMDMsMTEgKzMwMywxMCBAQCBzdGF0
aWMgdm9pZCBzZXRfYWNwX3RvX2kyc19kbWFfZGVzY3JpcHRvcnModm9pZCBfX2lvbWVtICphY3Bf
bW1pbywgdTMyIHNpemUsDQo+ICAgfQ0KPiAgIA0KPiAgIC8qIENyZWF0ZSBwYWdlIHRhYmxlIGVu
dHJpZXMgaW4gQUNQIFNSQU0gZm9yIHRoZSBhbGxvY2F0ZWQgbWVtb3J5ICovDQo+IC1zdGF0aWMg
dm9pZCBhY3BfcHRlX2NvbmZpZyh2b2lkIF9faW9tZW0gKmFjcF9tbWlvLCBzdHJ1Y3QgcGFnZSAq
cGcsDQo+ICtzdGF0aWMgdm9pZCBhY3BfcHRlX2NvbmZpZyh2b2lkIF9faW9tZW0gKmFjcF9tbWlv
LCBkbWFfYWRkcl90IGFkZHIsDQo+ICAgCQkJICAgdTE2IG51bV9vZl9wYWdlcywgdTMyIHB0ZV9v
ZmZzZXQpDQo+ICAgew0KPiAgIAl1MTYgcGFnZV9pZHg7DQo+IC0JdTY0IGFkZHI7DQo+ICAgCXUz
MiBsb3c7DQo+ICAgCXUzMiBoaWdoOw0KPiAgIAl1MzIgb2Zmc2V0Ow0KPiBAQCAtMzE3LDcgKzMx
Niw2IEBAIHN0YXRpYyB2b2lkIGFjcF9wdGVfY29uZmlnKHZvaWQgX19pb21lbSAqYWNwX21taW8s
IHN0cnVjdCBwYWdlICpwZywNCj4gICAJCS8qIExvYWQgdGhlIGxvdyBhZGRyZXNzIG9mIHBhZ2Ug
aW50IEFDUCBTUkFNIHRocm91Z2ggU1JCTSAqLw0KPiAgIAkJYWNwX3JlZ193cml0ZSgob2Zmc2V0
ICsgKHBhZ2VfaWR4ICogOCkpLA0KPiAgIAkJCSAgICAgIGFjcF9tbWlvLCBtbUFDUF9TUkJNX1Rh
cmdfSWR4X0FkZHIpOw0KPiAtCQlhZGRyID0gcGFnZV90b19waHlzKHBnKTsNCj4gICANCj4gICAJ
CWxvdyA9IGxvd2VyXzMyX2JpdHMoYWRkcik7DQo+ICAgCQloaWdoID0gdXBwZXJfMzJfYml0cyhh
ZGRyKTsNCj4gQEAgLTMzMyw3ICszMzEsNyBAQCBzdGF0aWMgdm9pZCBhY3BfcHRlX2NvbmZpZyh2
b2lkIF9faW9tZW0gKmFjcF9tbWlvLCBzdHJ1Y3QgcGFnZSAqcGcsDQo+ICAgCQlhY3BfcmVnX3dy
aXRlKGhpZ2gsIGFjcF9tbWlvLCBtbUFDUF9TUkJNX1RhcmdfSWR4X0RhdGEpOw0KPiAgIA0KPiAg
IAkJLyogTW92ZSB0byBuZXh0IHBoeXNpY2FsbHkgY29udGlndW9zIHBhZ2UgKi8NCj4gLQkJcGcr
KzsNCj4gKwkJYWRkciArPSBQQUdFX1NJWkU7DQo+ICAgCX0NCj4gICB9DQo+ICAgDQo+IEBAIC0z
NDMsNyArMzQxLDcgQEAgc3RhdGljIHZvaWQgY29uZmlnX2FjcF9kbWEodm9pZCBfX2lvbWVtICph
Y3BfbW1pbywNCj4gICB7DQo+ICAgCXUxNiBjaF9hY3Bfc3lzbWVtLCBjaF9hY3BfaTJzOw0KPiAg
IA0KPiAtCWFjcF9wdGVfY29uZmlnKGFjcF9tbWlvLCBydGQtPnBnLCBydGQtPm51bV9vZl9wYWdl
cywNCj4gKwlhY3BfcHRlX2NvbmZpZyhhY3BfbW1pbywgcnRkLT5kbWFfYWRkciwgcnRkLT5udW1f
b2ZfcGFnZXMsDQo+ICAgCQkgICAgICAgcnRkLT5wdGVfb2Zmc2V0KTsNCj4gICANCj4gICAJaWYg
KHJ0ZC0+ZGlyZWN0aW9uID09IFNORFJWX1BDTV9TVFJFQU1fUExBWUJBQ0spIHsNCj4gQEAgLTg1
MCw3ICs4NDgsNiBAQCBzdGF0aWMgaW50IGFjcF9kbWFfaHdfcGFyYW1zKHN0cnVjdCBzbmRfcGNt
X3N1YnN0cmVhbSAqc3Vic3RyZWFtLA0KPiAgIAlpbnQgc3RhdHVzOw0KPiAgIAl1aW50NjRfdCBz
aXplOw0KPiAgIAl1MzIgdmFsID0gMDsNCj4gLQlzdHJ1Y3QgcGFnZSAqcGc7DQo+ICAgCXN0cnVj
dCBzbmRfcGNtX3J1bnRpbWUgKnJ1bnRpbWU7DQo+ICAgCXN0cnVjdCBhdWRpb19zdWJzdHJlYW1f
ZGF0YSAqcnRkOw0KPiAgIAlzdHJ1Y3Qgc25kX3NvY19wY21fcnVudGltZSAqcHJ0ZCA9IHN1YnN0
cmVhbS0+cHJpdmF0ZV9kYXRhOw0KPiBAQCAtOTg2LDE2ICs5ODMsMTQgQEAgc3RhdGljIGludCBh
Y3BfZG1hX2h3X3BhcmFtcyhzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwNCj4g
ICAJCXJldHVybiBzdGF0dXM7DQo+ICAgDQo+ICAgCW1lbXNldChzdWJzdHJlYW0tPnJ1bnRpbWUt
PmRtYV9hcmVhLCAwLCBwYXJhbXNfYnVmZmVyX2J5dGVzKHBhcmFtcykpOw0KPiAtCXBnID0gdmly
dF90b19wYWdlKHN1YnN0cmVhbS0+ZG1hX2J1ZmZlci5hcmVhKTsNCj4gICANCj4gLQlpZiAocGcp
IHsNCj4gKwlpZiAoc3Vic3RyZWFtLT5kbWFfYnVmZmVyLmFyZWEpIHsNCj4gICAJCWFjcF9zZXRf
c3JhbV9iYW5rX3N0YXRlKHJ0ZC0+YWNwX21taW8sIDAsIHRydWUpOw0KPiAgIAkJLyogU2F2ZSBm
b3IgcnVudGltZSBwcml2YXRlIGRhdGEgKi8NCj4gLQkJcnRkLT5wZyA9IHBnOw0KPiArCQlydGQt
PmRtYV9hZGRyID0gc3Vic3RyZWFtLT5kbWFfYnVmZmVyLmFkZHI7DQo+ICAgCQlydGQtPm9yZGVy
ID0gZ2V0X29yZGVyKHNpemUpOw0KPiAgIA0KPiAgIAkJLyogRmlsbCB0aGUgcGFnZSB0YWJsZSBl
bnRyaWVzIGluIEFDUCBTUkFNICovDQo+IC0JCXJ0ZC0+cGcgPSBwZzsNCj4gICAJCXJ0ZC0+c2l6
ZSA9IHNpemU7DQo+ICAgCQlydGQtPm51bV9vZl9wYWdlcyA9IFBBR0VfQUxJR04oc2l6ZSkgPj4g
UEFHRV9TSElGVDsNCj4gICAJCXJ0ZC0+ZGlyZWN0aW9uID0gc3Vic3RyZWFtLT5zdHJlYW07DQo+
IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvYW1kL2FjcC5oIGIvc291bmQvc29jL2FtZC9hY3AuaA0K
PiBpbmRleCBkYmJiMWE4NTYzOGQuLmU1YWI2YzYwNDBhNiAxMDA2NDQNCj4gLS0tIGEvc291bmQv
c29jL2FtZC9hY3AuaA0KPiArKysgYi9zb3VuZC9zb2MvYW1kL2FjcC5oDQo+IEBAIC0xMjMsNyAr
MTIzLDcgQEAgZW51bSBhY3BfZG1hX3ByaW9yaXR5X2xldmVsIHsNCj4gICB9Ow0KPiAgIA0KPiAg
IHN0cnVjdCBhdWRpb19zdWJzdHJlYW1fZGF0YSB7DQo+IC0Jc3RydWN0IHBhZ2UgKnBnOw0KPiAr
CWRtYV9hZGRyX3QgZG1hX2FkZHI7DQo+ICAgCXVuc2lnbmVkIGludCBvcmRlcjsNCj4gICAJdTE2
IG51bV9vZl9wYWdlczsNCj4gICAJdTE2IGkyc19pbnN0YW5jZTsNCj4gDQo=
