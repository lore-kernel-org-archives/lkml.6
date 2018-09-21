Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06161ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A0421547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4g+TUu/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A0421547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389093AbeIUKp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 06:45:28 -0400
Received: from mail-bl2nam02on0049.outbound.protection.outlook.com ([104.47.38.49]:11863
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727795AbeIUKp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 06:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibWmHN57ILrwpYv1tNg7uyh3pNeHJc0uVFGLhbrhS80=;
 b=4g+TUu/MCraqMMEadRLeJcVkdP91cHzK79euPU1CB50bRBfoO/Zb16x7iGRfpvLLl44+7sZl4+vzzouwsZ1W+T3YPTyrqpXizlsXnyNf/ucjPxeIxrTfq5LGku6S9QTc6ukYU8jkHnsoR3fDZzZNBqGqjjew3u531dCZXg6J/Gk=
Received: from CY4PR1201MB2534.namprd12.prod.outlook.com (10.172.121.7) by
 CY4PR1201MB0246.namprd12.prod.outlook.com (10.172.79.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 21 Sep 2018 04:58:18 +0000
Received: from CY4PR1201MB2534.namprd12.prod.outlook.com
 ([fe80::b08f:8c8e:9b73:a942]) by CY4PR1201MB2534.namprd12.prod.outlook.com
 ([fe80::b08f:8c8e:9b73:a942%9]) with mapi id 15.20.1143.017; Fri, 21 Sep 2018
 04:58:18 +0000
From:   Jiandi An <jiandi@amd.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
CC:     Dave Airlie <airlied@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        Dave Airlie <airlied@linux.ie>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [virtio-dev] [PATCH 2/2] drm/virtio: add iommu support.
Thread-Topic: [virtio-dev] [PATCH 2/2] drm/virtio: add iommu support.
Thread-Index: AQHUP5Ky9o6EaoAaAUKshOjpemWQV6TfQrMAgAyj3wCAAG3ngIAKHNIAgAC24gCAACmmAIAASX+AgACvr4CAAI0ggIABeCMA
Date:   Fri, 21 Sep 2018 04:58:18 +0000
Message-ID: <95778dd4-8aca-eff6-f84a-c8efdd3b355d@amd.com>
References: <20180829122026.27012-1-kraxel@redhat.com>
 <20180829122026.27012-3-kraxel@redhat.com>
 <CAPM=9tyXc41DAkgjCRojrqH28qkirxgrpgNmrwu4WAeLpg7tAw@mail.gmail.com>
 <9bf20fa1-3752-edd1-588c-e38cd166c3af@amd.com>
 <20180912072541.nagfrr2dgy34szcx@sirius.home.kraxel.org>
 <5684a3fc-3605-7bb0-b0be-418c2ae702b5@amd.com>
 <20180919044600.utvnu5l6fvvi2qi4@sirius.home.kraxel.org>
 <d4c25272-9df8-33d6-d310-964b17a8c80d@amd.com>
 <20180919113807.6mwqxkdg6f55h6fg@sirius.home.kraxel.org>
 <bb7b8676-cf39-3144-2de1-389f4b0a70b3@amd.com>
 <20180920063201.nt7kw555s4clshzr@sirius.home.kraxel.org>
In-Reply-To: <20180920063201.nt7kw555s4clshzr@sirius.home.kraxel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM6PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:5:f8::14) To CY4PR1201MB2534.namprd12.prod.outlook.com
 (2603:10b6:903:da::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jiandi.An@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR1201MB0246;20:WrKfpOQ34BP8vGSLcBfEAC8dJxYZ2nELXX5Mqn/vJ/W09kgHOaEsj03pztoISthGRfzKtOHIZx8uALaU9aew68OZOLoZky91gD1CVXJJgxJ1IFNZ/F2cuuAwZeaW4jStz9P8YwCowQEGt9BkOmKEUb9V5KfmntAcyy43bo02+KpruTcEyOSE/24/mJ/n63+gM7Ld8aavt/ojpATsrFODMG0uK8hXmRO4jmA6lCPgWTrR4D71gB/6etd7qkY5SBmQ
x-ms-office365-filtering-correlation-id: 130927ec-3f6f-474f-c39a-08d61f7ed8d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY4PR1201MB0246;
x-ms-traffictypediagnostic: CY4PR1201MB0246:
x-microsoft-antispam-prvs: <CY4PR1201MB0246DA1E8F06B0CC03A45682FD120@CY4PR1201MB0246.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:CY4PR1201MB0246;BCL:0;PCL:0;RULEID:;SRVR:CY4PR1201MB0246;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(346002)(39860400002)(376002)(199004)(189003)(476003)(52116002)(99286004)(5250100002)(4326008)(2900100001)(93886005)(6116002)(3846002)(6916009)(76176011)(6436002)(5660300001)(316002)(36756003)(54906003)(6246003)(6512007)(53936002)(305945005)(7736002)(31696002)(66066001)(25786009)(6486002)(97736004)(8936002)(39060400002)(6506007)(386003)(26005)(2616005)(229853002)(102836004)(486006)(68736007)(81166006)(106356001)(478600001)(81156014)(72206003)(8676002)(446003)(11346002)(186003)(53546011)(14454004)(256004)(105586002)(31686004)(2906002)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB0246;H:CY4PR1201MB2534.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pV/X4nl1KSJLIqSxA/WBREpVSQ7jjfHmzoiTLGXSD0xOH2m2mKxDEkxpI/hqVoK1WxouS4fgvEdtV0cbOOrR6XVrgCWE4meYqQ/kbBMbKgDBDgucF8O45hK3mIsOtqerAmujnEzLw7O/dl5Ycf9zHf+ZgSQIlx/Ubogf3WYr7qc/CFfFf6R6gLrY/vbT4LcJIeSqG1KJXhScU0m+RyF0DCehHMpLYm7v2eUcFzK1LqKiMm8eyKFJ1xRu/K6CPv6i6tW3YGVA1b0X4I3N2jf3K3CvH7OniwJgakdavguZ7qmNTcjM/u6H1S3RW3DerhlabWlxT+AXsST1+uHcZuJSL5CWNT3uTt3leS1UcCwNhtE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A55590094CBC3D46ABD4777523194B0A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130927ec-3f6f-474f-c39a-08d61f7ed8d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 04:58:18.7545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0246
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA5LzIwLzIwMTggMDE6MzIgQU0sIEdlcmQgSG9mZm1hbm4gd3JvdGU6DQo+ICAgSGks
DQo+IA0KPj4gdm9pZCB2aXJ0aW9fZ3B1X2NtZF90cmFuc2Zlcl90b19ob3N0XzJkKHN0cnVjdCB2
aXJ0aW9fZ3B1X2RldmljZSAqdmdkZXYsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdWludDMyX3QgcmVzb3VyY2VfaWQsIHVpbnQ2NF90IG9mZnNldCwNCj4+IC4u
Lg0KPj4gICAgICBzdHJ1Y3QgdmlydGlvX2dwdV9mYmRldiAqdmdmYmRldiA9IHZnZGV2LT52Z2Zi
ZGV2Ow0KPj4gICAgICBzdHJ1Y3QgdmlydGlvX2dwdV9mcmFtZWJ1ZmZlciAqZmIgPSAmdmdmYmRl
di0+dmdmYjsNCj4+ICAgICAgc3RydWN0IHZpcnRpb19ncHVfb2JqZWN0ICpvYmogPSBnZW1fdG9f
dmlydGlvX2dwdV9vYmooZmItPmJhc2Uub2JqWzBdKTsNCj4gDQo+IEFoLCByaWdodC4gIFNob3Vs
ZCBoYXZlIG5vdGljZWQgdGhpcyBvbiByZXZpZXcuICBZb3Ugc3luYyB0aGUgZmJjb24NCj4gZnJh
bWVidWZmZXIgdW5jb25maXRpb25hbGx5IC4uLg0KPiANCj4+IElzIHRoZXJlIGJldHRlciB3YXkg
dG8gZ2V0IHRvIHRoZSB2aXJ0aW9fZ3B1X29iamVjdCBjcmVhdGVkIGluIHRoZQ0KPj4gdmlydGlv
X2dwdV9tb2RlX2R1bWJfY3JlYXRlKCkgcGF0aCBmcm9tIHZpcnRpb19ncHVfZGV2aWNlIG9yIHNv
bWVob3cgZnJvbSBkcm1fZmlsZQ0KPj4gdmlhIGdlbV9oYW5kbGUgZG93biBhdCB0aGUgbGF5ZXIg
b2YgdmlydGlvX2dwdV9jbWRfdHJhbnNmZXJfdG9faG9zdCgpPw0KPiANCj4gSnVzdCBwYXNzIGl0
IGRvd24sIHRoZSBjYWxsIHNpdGVzIGFsbCBrbm93IGl0IChzZWUgcGF0Y2gganVzdCBzZW50KS4N
Cg0KVGVzdGVkIHRoYXQgcGF0Y2ggeW91IHNlbnQuICBUb2dldGhlciB3aXRoIHRoaXMgcGF0Y2gg
aXQgYWxzbyByZXNvbHZlcw0KdGhlIHZpcnRpbyBncHUgZ3JhcGhpY2FsIGRpc3BsYXkgaXNzdWUg
Zm9yIFNFViBndWVzdC4NCg0KSXMgdGhlcmUgYSB3YXkgdG8gb3B0aW1pemUgdGhlIGRtYV9zeW5j
X3NnIHRvIG9ubHkgc3luYyBvbiB0aGUgcGFnZXMNCmJlaW5nIHVwZGF0ZWQgaW5zdGVhZCBvZiBh
bGwgdGhlIHBhZ2VzIGluIHRoZSBvYmogc2dsIGxpc3QgZXZlcnkgdGltZT8NCg0KVGhhbmtzLg0K
LSBKaWFuZGkNCg0KPiANCj4gY2hlZXJzLA0KPiAgIEdlcmQNCj4gDQo=
