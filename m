Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BC4ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A8E21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Xsu4ZWYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A8E21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeJSPHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:07:09 -0400
Received: from mail-bl2nam02on0057.outbound.protection.outlook.com ([104.47.38.57]:55073
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726340AbeJSPHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 11:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWgM0VyrzvNfgBuyTiXP3Fx90lK9BswnU0NZVOvJ+r8=;
 b=Xsu4ZWYYWcYSiV5V/KSk6goKSKmfZ5bQAh5QAklQANXo6+SugN44sPyRukIIeAgCml26GC1MSt7kc3ypKGqtkQk1MAerUtcmtPO6/P56LcaPOpjtc8BH23UABKNifSQ1C/k9RdnA5hG3bvk4e1rQmPbyCzR0HYvpr4YZZiMtgcQ=
Received: from BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11) by
 BN6PR12MB1730.namprd12.prod.outlook.com (10.175.101.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.25; Fri, 19 Oct 2018 07:02:16 +0000
Received: from BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::5472:26e2:affa:2b41]) by BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::5472:26e2:affa:2b41%7]) with mapi id 15.20.1250.028; Fri, 19 Oct 2018
 07:02:16 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Wenwen Wang <wang6495@umn.edu>
CC:     Kangjie Lu <kjlu@umn.edu>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/radeon: fix a missing-check bug
Thread-Topic: [PATCH] drm/radeon: fix a missing-check bug
Thread-Index: AQHUZwXu+tUJTIxJoU26tNMgKJilKaUmJUSA
Date:   Fri, 19 Oct 2018 07:02:16 +0000
Message-ID: <90c22763-fdba-0415-c570-ef8e85bf5889@amd.com>
References: <1539882809-7189-1-git-send-email-wang6495@umn.edu>
In-Reply-To: <1539882809-7189-1-git-send-email-wang6495@umn.edu>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
x-clientproxiedby: AM6P193CA0031.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::44) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1730;20:aqzO7Sd7Ur7FylEaHKj36Xkz1b3tK3FKIWDgWVzjvnJLKn/jn4PXplmBvjiaMuthAuARmZhmZl2P7RHap0QDc/9cbYEa41jK+EzMXlIE4vy+N3ePYF/nCZoo4b2iqV2Fdk5UuLMRLIWiWz7hvYsebLZ3Vi/sfe6ApMNGiaix1fnPBJFkMTiJojrOrGZTzDgEmD8FW9aQ0OF+MZA+S4wnCeItC3ayr+rgpZr6D0w7dXAOzbfxRbtgifLhdDUINkaJ
x-ms-office365-filtering-correlation-id: ce4b5acf-eb62-41d8-9268-08d63590cdb4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1730;
x-ms-traffictypediagnostic: BN6PR12MB1730:
x-microsoft-antispam-prvs: <BN6PR12MB17300413D65CAA8418F087BB83F90@BN6PR12MB1730.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705)(8104003914727);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN6PR12MB1730;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1730;
x-forefront-prvs: 0830866D19
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(39860400002)(366004)(376002)(199004)(189003)(65826007)(97736004)(64126003)(81166006)(106356001)(6512007)(105586002)(46003)(65806001)(8936002)(53936002)(2171002)(31696002)(71200400001)(86362001)(6436002)(81156014)(102836004)(478600001)(72206003)(2900100001)(31686004)(68736007)(186003)(6486002)(65956001)(71190400001)(5660300001)(575784001)(8676002)(11346002)(54906003)(316002)(229853002)(476003)(14444005)(7736002)(446003)(25786009)(36756003)(14454004)(6916009)(2906002)(5250100002)(52116002)(2616005)(386003)(305945005)(6116002)(99286004)(76176011)(486006)(6246003)(256004)(4326008)(58126008)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1730;H:BN6PR12MB1714.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yz37MnD9Fk3Sh6jsUN53gHQT7uRBsWlov3A8RaluGmh/fFrdqUfhd8MCG0DBTCzkW9xpUSI5EuNTxFl+TtT9uC8bxnV4zx2QgDLq0iblT/ZaWWnOsG6m872KAGqAQGDTkS828Xv/wZreFKA2+T/Fths2EAdo/cIRJBFnTL4mhWp75WelQkJ1xaDMtObN7h6CKxaEmhNwPBrPKuWZdgDDCb6zP3Yn2HYhVR94VEcMxMdAqT9LQxWWtKBZ9oKS4oQnodO9A0imamiN3oKt0CYzOSCKqAjWbc+S1nP3m/jxqnE6Ne9PimkPwAM97CDlKDL+jImwklmxBB5pZDpJ0Mj+RjbIk5zG4xvyu9PK8gc2huc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <53DC363A6F28FD4CA03C6D28A4B8AE77@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4b5acf-eb62-41d8-9268-08d63590cdb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2018 07:02:16.7073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1730
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMTguMTAuMTggdW0gMTk6MTMgc2NocmllYiBXZW53ZW4gV2FuZzoNCj4gSW4gcmFkZW9uX3Jl
YWRfYmlvcygpLCB0aGUgYmlvcyByb20gaXMgZmlyc3RseSBtYXBwZWQgdG8gdGhlIElPIG1lbW9y
eQ0KPiByZWdpb24gJ2Jpb3MnIHRocm91Z2ggcGNpX21hcF9yb20oKS4gVGhlbiB0aGUgZmlyc3Qg
dHdvIGJ5dGVzIG9mICdiaW9zJyBhcmUNCj4gY29waWVkIHRvICd2YWwxJyBhbmQgJ3ZhbDInIHJl
c3BlY3RpdmVseSB0aHJvdWdoIHJlYWRiKCkuIEFmdGVyIHRoYXQsDQo+ICd2YWwxJyBhbmQgJ3Zh
bDInIGFyZSBjaGVja2VkIHRvIHNlZSB3aGV0aGVyIHRoZXkgaGF2ZSBleHBlY3RlZCB2YWx1ZXMs
DQo+IGkuZS4sIDB4NTUgYW5kIDB4YWEsIHJlc3BlY3RpdmVseS4gSWYgeWVzLCB0aGUgd2hvbGUg
ZGF0YSBpbiAnYmlvcycgaXMgdGhlbg0KPiBjb3BpZWQgdG8gJ3JkZXYtPmJpb3MnIHRocm91Z2gg
bWVtY3B5X2Zyb21pbygpLiBPYnZpb3VzbHksIHRoZSBmaXJzdCB0d28NCj4gYnl0ZXMgaW4gJ2Jp
b3MnIGFyZSBjb3BpZWQgdHdpY2UuIE1vcmUgaW1wb3J0YW50bHksIG5vIGNoZWNrIGlzIGVuZm9y
Y2VkIG9uDQo+IHRoZSBmaXJzdCB0d28gYnl0ZXMgb2YgJ3JkZXYtPmJpb3MnIGFmdGVyIG1lbWNw
eV9mcm9taW8oKS4gR2l2ZW4gdGhhdCB0aGUNCj4gSU8gbWVtb3J5IHJlZ2lvbiBjYW4gYWxzbyBi
ZSBhY2Nlc3NlZCBieSB0aGUgZGV2aWNlLCBpdCBpcyBwb3NzaWJsZSB0aGF0IGENCj4gbWFsaWNp
b3VzIGRldmljZSBjYW4gcmFjZSB0byBtb2RpZnkgdGhlc2UgdHdvIGJ5dGVzIGJldHdlZW4gdGhl
IHR3byBjb3BpZXMNCj4gYW5kIHRodXMgYWZ0ZXIgbWVtY3B5X2Zyb21pbygpLCB0aGUgZmlyc3Qg
dHdvIGJ5dGVzIGluICdyZGV2LT5iaW9zJyBjYW4NCj4gaGF2ZSB1bmV4cGVjdGVkIHZhbHVlcy4g
IFRoaXMgY2FuIGNhdXNlIHVuZGVmaW5lZCBiZWhhdmlvciBvZiB0aGUga2VybmVsDQo+IGFuZCBp
bnRyb2R1Y2UgcG90ZW50aWFsIHNlY3VyaXR5IHJpc2ssIGlmIHRoZSBkZXZpY2UgY2FuIGJlIGNv
bnRyb2xsZWQgYnkNCj4gYXR0YWNrZXJzLg0KPg0KPiBUaGlzIHBhdGNoIHJld3JpdGVzIHRoZSBm
aXJzdCB0d28gYnl0ZXMgb2YgJ3JkZXYtPmJpb3MnIGFmdGVyDQo+IG1lbWNweV9mcm9taW8oKSB3
aXRoIGV4cGVjdGVkIHZhbHVlcy4gVGhyb3VnaCB0aGlzIHdheSwgdGhlIGFib3ZlIGlzc3VlIGNh
bg0KPiBiZSBhdm9pZGVkLg0KDQpXZWxsIE5BSywgdGhhdCBkb2Vzbid0IG1ha2UgYW55IHNlbnNl
IHRvIG1lLg0KDQpGaXJzdCBvZiBhbGwgd2UgZG9uJ3QgbWFwIFZSQU0sIGJ1dCByYXRoZXIgdGhl
IFJPTSB3aGljaCBpcyBhIHJlYWQgb25seSANCmZsYXNoLiBXcml0aW5nIHRvIHRoZSBmbGFzaCBp
cyBub3Qgc3VwcG9ydGVkIHRocm91Z2ggdGhlIEJBUiBhcyBmYXIgYXMgSSANCmtub3cuDQoNClRo
ZW4gd2UgY2hlY2sgdGhlIGZpcnN0IHR3byBieXRlcyB0byBtYWtlIHN1cmUgdGhhdCB0aGUgUk9N
IGlzIGNvcnJlY3RseSANCm1hcHBlZCBhbmQgbm90IHRvIHByZXZlbnQgYW55IG1hbGljaW91cyBh
dHRhY2tzLg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFdl
bndlbiBXYW5nIDx3YW5nNjQ5NUB1bW4uZWR1Pg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbl9iaW9zLmMgfCAyICsrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25f
Ymlvcy5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYmlvcy5jDQo+IGluZGV4IDA0
YzBlZDQuLmYzMzY3MTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFk
ZW9uX2Jpb3MuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9iaW9zLmMN
Cj4gQEAgLTk4LDYgKzk4LDggQEAgc3RhdGljIGJvb2wgcmFkZW9uX3JlYWRfYmlvcyhzdHJ1Y3Qg
cmFkZW9uX2RldmljZSAqcmRldikNCj4gICAJCXJldHVybiBmYWxzZTsNCj4gICAJfQ0KPiAgIAlt
ZW1jcHlfZnJvbWlvKHJkZXYtPmJpb3MsIGJpb3MsIHNpemUpOw0KPiArCXJkZXYtPmJpb3NbMF0g
PSB2YWwxOw0KPiArCXJkZXYtPmJpb3NbMV0gPSB2YWwyOw0KPiAgIAlwY2lfdW5tYXBfcm9tKHJk
ZXYtPnBkZXYsIGJpb3MpOw0KPiAgIAlyZXR1cm4gdHJ1ZTsNCj4gICB9DQoNCg==
