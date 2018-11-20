Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F166C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E574D214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E574D214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeKUGjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 01:39:04 -0500
Received: from mail-eopbgr810077.outbound.protection.outlook.com ([40.107.81.77]:31375
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725926AbeKUGjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 01:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPISaWfBSC161D07hPCnWr6yDagHGiM0KELDAoMgGUo=;
 b=ms3TrFIXrUNxvwyrGyWNBtskoyb4p2mIqpTRKUW6g/Kv0AYaBgNpYjjFt+9ZAIBuIdBChf/mJ7gGE5+IYwtYlFhLxv9K74SuKRoEXg29e3CrvNKtDf7DClE68lQn//0c8fFVZqaWtpvMY4cEu7IlTpxSohIRLFBGr8ktYzTDU80=
Received: from CY1PR12MB0604.namprd12.prod.outlook.com (10.163.238.139) by
 CY1PR12MB0357.namprd12.prod.outlook.com (10.161.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.38; Tue, 20 Nov 2018 20:08:01 +0000
Received: from CY1PR12MB0604.namprd12.prod.outlook.com
 ([fe80::f2:8b5c:5ba0:7dc9]) by CY1PR12MB0604.namprd12.prod.outlook.com
 ([fe80::f2:8b5c:5ba0:7dc9%2]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 20:08:01 +0000
From:   "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>
To:     Colin King <colin.king@canonical.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][drm-next] drm/amd/display: fix dereference of pointer
 fs_params before it is null checked
Thread-Topic: [PATCH][drm-next] drm/amd/display: fix dereference of pointer
 fs_params before it is null checked
Thread-Index: AQHUgPT3KGPpE94Wtkq/MuGpMmKQQ6VZF4kA
Date:   Tue, 20 Nov 2018 20:08:00 +0000
Message-ID: <f62f6823-228a-dff9-dad5-45b3fde9c5c2@amd.com>
References: <20181120171745.13812-1-colin.king@canonical.com>
In-Reply-To: <20181120171745.13812-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::35) To CY1PR12MB0604.namprd12.prod.outlook.com
 (2a01:111:e400:c43c::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sunpeng.Li@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR12MB0357;20:dCSA5i9NdFKqbe7ZRaM1thAAP5ZLzlVeAF6vPeG5wTQLe//CmXyet01OprZ1OriAs4hWCmLwYKCAzXKkMtbgRBZH0QUDmY0WpTsaencZoi1yZeeHaK1Cgc5EAz4GSqvxD/PpKsjFRHDMCoGHs9NBixPA0IjGvUZj+utMRzVzfFYbcSI81SRxeBkT1l3m9z1AkjglSh65jXZaPJA7lqv3tQNFMk6jZXuIA6rcAOWFHL3LF46czy+9BUzJZ0BgiVR2
x-ms-office365-filtering-correlation-id: 3cd66f98-593b-4d67-0146-08d64f23df2d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0357;
x-ms-traffictypediagnostic: CY1PR12MB0357:
x-microsoft-antispam-prvs: <CY1PR12MB035798DE2EC215E117569BC382D90@CY1PR12MB0357.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(198206253151910)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:CY1PR12MB0357;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0357;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(136003)(396003)(189003)(199004)(7736002)(305945005)(31696002)(6246003)(2201001)(4001150100001)(86362001)(68736007)(36756003)(72206003)(97736004)(2900100001)(229853002)(71190400001)(8936002)(6486002)(14454004)(71200400001)(4326008)(478600001)(486006)(99286004)(2616005)(6512007)(8676002)(81156014)(476003)(6436002)(446003)(11346002)(81166006)(52116002)(3846002)(6116002)(53546011)(31686004)(386003)(6506007)(66066001)(2906002)(76176011)(186003)(53936002)(110136005)(2501003)(5660300001)(256004)(26005)(54906003)(25786009)(106356001)(105586002)(316002)(102836004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0357;H:CY1PR12MB0604.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FKlHidCKCJvVz0f5H5eiBSkPchDPslhQ+pMfn1RKJATJ6bvZ6mAZmGeCOYlA9qxUA4henNaO/uHznOGPdRAJsmiVbUBdUZAAGvNuD3Oop1VOLKYSzcvW76zha36kdebf5PTozqB8Ip/HhVIQBdBJ69eJ5IDvyEvXnOX0u6Y6n4FDS336nuYjafcZ1b3Ln81cxo1z73ICTAif3ccTj9JAFhZXRQ4cNcSosCkN4Gv/dzKiIosRcgHqf1IQmCXA3Ph0eYe8fFbjVSZwdQCWmGY7NOaSPATdNzjENQYCyaowe2aufPr0207cog2YftvFPQtrGxySM1OHRj3CHq6yGFoSsU/0oA71R+tW3BS5sfL0w/Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <373C3230283B3C479C50A9205A0B7115@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd66f98-593b-4d67-0146-08d64f23df2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 20:08:00.8363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0357
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIwMTgtMTEtMjAgMTI6MTcgcC5tLiwgQ29saW4gS2luZyB3cm90ZToNCj4gRnJvbTog
Q29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCj4gDQo+IEN1cnJlbnRs
eSB0aGVyZSBhcmUgc2V2ZXJhbCBpbnN0YW5jZXMgb2YgcG9pbnRlciBmc19wYXJhbXMgYmVpbmcN
Cj4gZGVyZWZlcmVuY2VkIGJlZm9yZSBmc19wYXJhbXMgaXMgYmVpbmcgbnVsbCBjaGVja2VkLiAg
Rml4IHRoaXMgYnkNCj4gb25seSBkZXJlZmVyZW5jaW5nIGZzX3BhcmFtcyBhZnRlciB0aGUgbnVs
bCBjaGVjay4NCj4gDQo+IERldGVjdGVkIGJ5IENvdmVyaXR5U2NhbiwgQ0lEIzE0NzU1NjUgKCJE
ZXJlZmVyZW5jZSBiZWZvcmUgbnVsbCBjaGVjayIpDQo+IA0KPiBGaXhlczogZTFlOGEwMjBjNmI4
ICgiZHJtL2FtZC9kaXNwbGF5OiBBZGQgc3VwcG9ydCBmb3IgRnJlZXN5bmMgMiBIRFIgYW5kIENv
bnRlbnQgdG8gRGlzcGxheSBNYXBwaW5nIikNCj4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtp
bmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IExlbyBMaSA8c3Vu
cGVuZy5saUBhbWQuY29tPg0KDQpUaGFua3MhDQoNCj4gLS0tDQo+ICAgLi4uL2RybS9hbWQvZGlz
cGxheS9tb2R1bGVzL2NvbG9yL2NvbG9yX2dhbW1hLmMgIHwgMTYgKysrKysrKysrKystLS0tLQ0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2NvbG9y
L2NvbG9yX2dhbW1hLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9jb2xv
ci9jb2xvcl9nYW1tYS5jDQo+IGluZGV4IDc0ODBmMDcyYzM3NS4uYmJlY2JhZWZiNzQxIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9jb2xvci9jb2xv
cl9nYW1tYS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2Nv
bG9yL2NvbG9yX2dhbW1hLmMNCj4gQEAgLTgxMywyMCArODEzLDI2IEBAIHN0YXRpYyBib29sIGJ1
aWxkX2ZyZWVzeW5jX2hkcihzdHJ1Y3QgcHdsX2Zsb2F0X2RhdGFfZXggKnJnYl9yZWdhbW1hLA0K
PiAgIAljb25zdCBzdHJ1Y3QgaHdfeF9wb2ludCAqY29vcmRfeCA9IGNvb3JkaW5hdGVfeDsNCj4g
ICAJc3RydWN0IGZpeGVkMzFfMzIgc2NhbGVkWCA9IGRjX2ZpeHB0X3plcm87DQo+ICAgCXN0cnVj
dCBmaXhlZDMxXzMyIHNjYWxlZFgxID0gZGNfZml4cHRfemVybzsNCj4gLQlzdHJ1Y3QgZml4ZWQz
MV8zMiBtYXhfZGlzcGxheSA9IGRjX2ZpeHB0X2Zyb21faW50KGZzX3BhcmFtcy0+bWF4X2Rpc3Bs
YXkpOw0KPiAtCXN0cnVjdCBmaXhlZDMxXzMyIG1pbl9kaXNwbGF5ID0gZGNfZml4cHRfZnJvbV9m
cmFjdGlvbihmc19wYXJhbXMtPm1pbl9kaXNwbGF5LCAxMDAwMCk7DQo+IC0Jc3RydWN0IGZpeGVk
MzFfMzIgbWF4X2NvbnRlbnQgPSBkY19maXhwdF9mcm9tX2ludChmc19wYXJhbXMtPm1heF9jb250
ZW50KTsNCj4gLQlzdHJ1Y3QgZml4ZWQzMV8zMiBtaW5fY29udGVudCA9IGRjX2ZpeHB0X2Zyb21f
ZnJhY3Rpb24oZnNfcGFyYW1zLT5taW5fY29udGVudCwgMTAwMDApOw0KPiArCXN0cnVjdCBmaXhl
ZDMxXzMyIG1heF9kaXNwbGF5Ow0KPiArCXN0cnVjdCBmaXhlZDMxXzMyIG1pbl9kaXNwbGF5Ow0K
PiArCXN0cnVjdCBmaXhlZDMxXzMyIG1heF9jb250ZW50Ow0KPiArCXN0cnVjdCBmaXhlZDMxXzMy
IG1pbl9jb250ZW50Ow0KPiAgIAlzdHJ1Y3QgZml4ZWQzMV8zMiBjbGlwID0gZGNfZml4cHRfb25l
Ow0KPiAgIAlzdHJ1Y3QgZml4ZWQzMV8zMiBvdXRwdXQ7DQo+ICAgCWJvb2wgdXNlX2VldGYgPSBm
YWxzZTsNCj4gICAJYm9vbCBpc19jbGlwcGVkID0gZmFsc2U7DQo+IC0Jc3RydWN0IGZpeGVkMzFf
MzIgc2RyX3doaXRlX2xldmVsID0gZGNfZml4cHRfZnJvbV9pbnQoZnNfcGFyYW1zLT5zZHJfd2hp
dGVfbGV2ZWwpOw0KPiArCXN0cnVjdCBmaXhlZDMxXzMyIHNkcl93aGl0ZV9sZXZlbDsNCj4gICAN
Cj4gICAJaWYgKGZzX3BhcmFtcyA9PSBOVUxMIHx8IGZzX3BhcmFtcy0+bWF4X2NvbnRlbnQgPT0g
MCB8fA0KPiAgIAkJCWZzX3BhcmFtcy0+bWF4X2Rpc3BsYXkgPT0gMCkNCj4gICAJCXJldHVybiBm
YWxzZTsNCj4gICANCj4gKwltYXhfZGlzcGxheSA9IGRjX2ZpeHB0X2Zyb21faW50KGZzX3BhcmFt
cy0+bWF4X2Rpc3BsYXkpOw0KPiArCW1pbl9kaXNwbGF5ID0gZGNfZml4cHRfZnJvbV9mcmFjdGlv
bihmc19wYXJhbXMtPm1pbl9kaXNwbGF5LCAxMDAwMCk7DQo+ICsJbWF4X2NvbnRlbnQgPSBkY19m
aXhwdF9mcm9tX2ludChmc19wYXJhbXMtPm1heF9jb250ZW50KTsNCj4gKwltaW5fY29udGVudCA9
IGRjX2ZpeHB0X2Zyb21fZnJhY3Rpb24oZnNfcGFyYW1zLT5taW5fY29udGVudCwgMTAwMDApOw0K
PiArCXNkcl93aGl0ZV9sZXZlbCA9IGRjX2ZpeHB0X2Zyb21faW50KGZzX3BhcmFtcy0+c2RyX3do
aXRlX2xldmVsKTsNCj4gKw0KPiAgIAlpZiAoZnNfcGFyYW1zLT5taW5fZGlzcGxheSA+IDEwMDAp
IC8vIGNhcCBhdCAwLjEgYXQgdGhlIGJvdHRvbQ0KPiAgIAkJbWluX2Rpc3BsYXkgPSBkY19maXhw
dF9mcm9tX2ZyYWN0aW9uKDEsIDEwKTsNCj4gICAJaWYgKGZzX3BhcmFtcy0+bWF4X2Rpc3BsYXkg
PCAxMDApIC8vIGNhcCBhdCAxMDAgYXQgdGhlIHRvcA0KPiANCg==
