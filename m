Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BB5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 09:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8961B214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 09:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qlH6udro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbeL0J0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 04:26:33 -0500
Received: from mail-eopbgr780074.outbound.protection.outlook.com ([40.107.78.74]:4972
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728050AbeL0J0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 04:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgnjVPmKTwJ2mnndFLWPXGAT8/NcXBB712VcDy/YA/g=;
 b=qlH6udrotS9oPt9rBaMG1TySe/MNHHm/UrQv4xsFjUNrkBx/EMNaVMk04u2TFhujii1+jn4QeVDEsURFZdXKwfdBUknF4eGq6CrXPZjI9BoQIhEUQVO7t8arVI2XVAue401oUE5KDua0vI3HpfX4K/xr7/321x5Alf3wrVahlxc=
Received: from BYAPR12MB2791.namprd12.prod.outlook.com (20.177.126.80) by
 BYAPR12MB2760.namprd12.prod.outlook.com (20.177.125.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.21; Thu, 27 Dec 2018 09:26:28 +0000
Received: from BYAPR12MB2791.namprd12.prod.outlook.com
 ([fe80::203a:c88d:8f6d:4080]) by BYAPR12MB2791.namprd12.prod.outlook.com
 ([fe80::203a:c88d:8f6d:4080%6]) with mapi id 15.20.1471.019; Thu, 27 Dec 2018
 09:26:26 +0000
From:   "Qu, Jim" <Jim.Qu@amd.com>
To:     Kangjie Lu <kjlu@umn.edu>
CC:     "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Xu, Feifei" <Feifei.Xu@amd.com>,
        "Francis, David" <David.Francis@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "pakki001@umn.edu" <pakki001@umn.edu>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Gao, Likun" <Likun.Gao@amd.com>, "Zhu, Rex" <Rex.Zhu@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBncHU6IGRybTogZml4IGFuIGltcHJvcGVyIGNoZWNr?=
 =?gb2312?B?IG9mIGFtZGdwdV9ib19jcmVhdGVfa2VybmVs?=
Thread-Topic: [PATCH] gpu: drm: fix an improper check of
 amdgpu_bo_create_kernel
Thread-Index: AQHUnOONEcshgKVKEU2ZwQMEVbCPbaWSSTbJ
Date:   Thu, 27 Dec 2018 09:26:26 +0000
Message-ID: <BYAPR12MB279124DEA06FE8EA43E164BC99B60@BYAPR12MB2791.namprd12.prod.outlook.com>
References: <20181226062348.75519-1-kjlu@umn.edu>
In-Reply-To: <20181226062348.75519-1-kjlu@umn.edu>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=Jim.Qu@amd.com; 
x-originating-ip: [116.228.147.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2760;20:litC8WQ4OT/NdWXcViYmB3BHsgLP8BfNEE/73OLbayBRClB1EDA5Ird9GT8QiKWBBajX8PD8KYIphNwu1G1VLxHX1oydeKIz4ZTyRZgHUqT5nsyLVL+2VbnFxSwzQkH1AHcVM4kC8Ng8LdreW0Q/YSaYNa8DpbNhsZofZwVsDRla6IiUTD6VEN9zh1wUwYF6gBIIL1R9iM7gbB3KRQAX4CULFDDI6CLWLzT+dv+1SecU0GpcWE8xTyQwewi+dUqb
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(199004)(189003)(54906003)(106356001)(86362001)(4326008)(8936002)(81166006)(105586002)(99286004)(224303003)(5660300001)(446003)(11346002)(186003)(316002)(25786009)(81156014)(9686003)(68736007)(55016002)(7696005)(72206003)(66066001)(76176011)(102836004)(6506007)(33656002)(97736004)(486006)(476003)(6436002)(966005)(256004)(14454004)(71190400001)(53936002)(6306002)(2906002)(6916009)(478600001)(305945005)(74316002)(2171002)(26005)(3846002)(71200400001)(7736002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2760;H:BYAPR12MB2791.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: d53b0bb9-c063-4e7f-71fb-08d66bdd605c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2760;
x-ms-traffictypediagnostic: BYAPR12MB2760:
x-microsoft-antispam-prvs: <BYAPR12MB27601D8C715E8E971EA4E38899B60@BYAPR12MB2760.namprd12.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR12MB2760;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2760;
x-forefront-prvs: 0899B47777
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F+SrmYuNerhsTMJENKkUdIQD2KnrDZ1xqjqsajeHprJF8n6auR2dHfQlWxM1YZ30amvzx+wn8q3WOPcuenYnoNlrPhcES/UCZKVNl4RiYGEboJtVb5l/qJZUoEwN6j0qNKJcg/y5PYZeZGqiiwW4hfDQaNvfqSTCw1pFSf/M8U/lXTNYNJP8MgETzCGpIerVj36sFHMTnMJee1b8yViwuwLwEIL7ND8b793jIR3YZOPLUNuiyjYeJc9woSTa+V5Y56znisD/RVUrSXmclaAqoSyD10YHtYkyHG2bLsUJ1GH7fQnE5VnDstCITa7WXf45
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53b0bb9-c063-4e7f-71fb-08d66bdd605c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2018 09:26:26.6438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2760
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpDb21tZW50cyBpbiBsaW5lLg0KDQpUaGFua3MNCkppbVF1DQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fDQq3orz+yMs6IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0Bs
aXN0cy5mcmVlZGVza3RvcC5vcmc+ILT6se0gS2FuZ2ppZSBMdSA8a2psdUB1bW4uZWR1Pg0Kt6LL
zcqxvOQ6IDIwMTjE6jEy1MIyNsjVIDE0OjIzDQrK1bz+yMs6IGtqbHVAdW1uLmVkdQ0Ks63LzTog
WmhvdSwgRGF2aWQoQ2h1bk1pbmcpOyBEYXZpZCBBaXJsaWU7IFh1LCBGZWlmZWk7IEZyYW5jaXMs
IERhdmlkOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZzsgSHVhbmcsIFJheTsgZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsg
RGFuaWVsIFZldHRlcjsgcGFra2kwMDFAdW1uLmVkdTsgRGV1Y2hlciwgQWxleGFuZGVyOyBHYW8s
IExpa3VuOyBaaHUsIFJleDsgS29lbmlnLCBDaHJpc3RpYW47IFpoYW5nLCBIYXdraW5nDQrW98zi
OiBbUEFUQ0hdIGdwdTogZHJtOiBmaXggYW4gaW1wcm9wZXIgY2hlY2sgb2YgYW1kZ3B1X2JvX2Ny
ZWF0ZV9rZXJuZWwNCg0KYWRldi0+ZmlybXdhcmUuZndfYnVmIGJlaW5nIG5vdCBOVUxMIG1heSBu
b3QgaW5kaWNhdGUga2VybmVsIGJ1ZmZlciBpcw0KY3JlYXRlZCBzdWNjZXNzZnVsLiBBIGJldHRl
ciB3YXkgaXMgdG8gY2hlY2sgdGhlIHN0YXR1cyAocmV0dXJuIHZhbHVlKQ0Kb2YgaXQuIFRoZSBm
aXggZG9lcyBzby4NCg0KU2lnbmVkLW9mZi1ieTogS2FuZ2ppZSBMdSA8a2psdUB1bW4uZWR1Pg0K
LS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmMgfCAxOCArKysr
KysrKysrKystLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgNiBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV91Y29kZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmMNCmlu
ZGV4IDdiMzM4NjcwMzZlNy4uYmEzYzFjZmIyYzM1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV91Y29kZS5jDQpAQCAtNDIyLDEzICs0MjIsMTkgQEAgc3RhdGljIGludCBh
bWRncHVfdWNvZGVfcGF0Y2hfanQoc3RydWN0IGFtZGdwdV9maXJtd2FyZV9pbmZvICp1Y29kZSwN
Cg0KIGludCBhbWRncHVfdWNvZGVfY3JlYXRlX2JvKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQ0KIHsNCisgICAgICAgaW50IHJldDsNCisNCiAgICAgICAgaWYgKGFkZXYtPmZpcm13YXJlLmxv
YWRfdHlwZSAhPSBBTURHUFVfRldfTE9BRF9ESVJFQ1QpIHsNCi0gICAgICAgICAgICAgICBhbWRn
cHVfYm9fY3JlYXRlX2tlcm5lbChhZGV2LCBhZGV2LT5maXJtd2FyZS5md19zaXplLCBQQUdFX1NJ
WkUsDQotICAgICAgICAgICAgICAgICAgICAgICBhbWRncHVfc3Jpb3ZfdmYoYWRldikgPyBBTURH
UFVfR0VNX0RPTUFJTl9WUkFNIDogQU1ER1BVX0dFTV9ET01BSU5fR1RULA0KLSAgICAgICAgICAg
ICAgICAgICAgICAgJmFkZXYtPmZpcm13YXJlLmZ3X2J1ZiwNCi0gICAgICAgICAgICAgICAgICAg
ICAgICZhZGV2LT5maXJtd2FyZS5md19idWZfbWMsDQotICAgICAgICAgICAgICAgICAgICAgICAm
YWRldi0+ZmlybXdhcmUuZndfYnVmX3B0cik7DQotICAgICAgICAgICAgICAgaWYgKCFhZGV2LT5m
aXJtd2FyZS5md19idWYpIHsNCisgICAgICAgICAgICAgICByZXQgPQ0KKyAgICAgICAgICAgICAg
ICAgICAgICAgYW1kZ3B1X2JvX2NyZWF0ZV9rZXJuZWwoYWRldiwNCisgICAgICAgICAgICAgICAg
ICAgICAgICAgYWRldi0+ZmlybXdhcmUuZndfc2l6ZSwNCisgICAgICAgICAgICAgICAgICAgICAg
ICAgUEFHRV9TSVpFLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICBhbWRncHVfc3Jpb3ZfdmYo
YWRldikgPyBBTURHUFVfR0VNX0RPTUFJTl9WUkFNIDoNCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgQU1ER1BVX0dFTV9ET01BSU5fR1RULA0KKyAgICAgICAgICAgICAgICAgICAgICAg
ICAmYWRldi0+ZmlybXdhcmUuZndfYnVmLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAmYWRl
di0+ZmlybXdhcmUuZndfYnVmX21jLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAm
YWRldi0+ZmlybXdhcmUuZndfYnVmX3B0cik7DQorICAgICAgICAgICAgICAgaWYgKHJldCkgew0K
DQpKaW1RdTogTG9vayBpbnRvIGFtZGdwdV9ib19jcmVhdGVfa2VybmVsKCksIG5ldyBibyB3aWxs
IGJlIGNyZWF0ZWQgb25seSBpZiAqYm9fcHRyID0gTlVMTCwgU28gaWYgeW91IGVuY291bnRlciB0
aGUgaXNzdWUgdGhlIGFkZXYtPmZpcm13YXJlLmZ3X2J1ZiAhPSBOVUxMIGJ1dCBuZXcgYm8gaXMg
bm90IGNyZWF0ZWQsIHRoZSBvbmx5IHByb2JsZW0gSSBjYW4gc2VlIGFyZToNCg0KMS4gdGhlcmUg
aXMgYnVnIGluIGFtZGdwdV9ib19jcmVhdGVfa2VybmVsKCkNCjIuIGFkZXYtPmZpcm13YXJlLmZ3
X2J1ZiAhPSBOVUxMIGJlZm9yZSBpdCBpcyB0cmFuc2ZlcnJlZCBpbnRvIGFtZGdwdV9ib19jcmVh
dGVfa2VybmVsKCkuDQoNCkNvdWxkIHlvdSBjb21taXQgd2hhdCBpcyBlbnZpcm9ubWVudCB5b3Ug
ZW5jb3VudGVyIHRoZSBpc3N1ZT8NCg0KVGhhbmtzDQpKaW1RdSANCiAgICAgICAgICAgICAgICAg
ICAgICAgIGRldl9lcnIoYWRldi0+ZGV2LCAiZmFpbGVkIHRvIGNyZWF0ZSBrZXJuZWwgYnVmZmVy
IGZvciBmaXJtd2FyZS5md19idWZcbiIpOw0KICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IC1FTk9NRU07DQogICAgICAgICAgICAgICAgfSBlbHNlIGlmIChhbWRncHVfc3Jpb3ZfdmYoYWRl
dikpIHsNCi0tDQoyLjE3LjIgKEFwcGxlIEdpdC0xMTMpDQoNCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA0K
