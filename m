Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C6FECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF07208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uw73Q82V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF07208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbeISMvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:51:44 -0400
Received: from mail-eopbgr720079.outbound.protection.outlook.com ([40.107.72.79]:44320
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730605AbeISMvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcEff2bJTjdevkcjx/Ap9T+vs7JqUIOXjrUwlyY+MK4=;
 b=uw73Q82VyBQjId9nrnu3SkRGWykhNGNkFRFSHR77bFMtSqH9Ty+D0/t0pkN09PNCsKjJmNfUWdiVtU+vA8Dzr68N/3NjNOAo9hNL+vS4zbkCch9XgOnkYnerIXPrGF1J1JWS8fbaf3deNXz/YiXwx6h9Xzul8L7GLo/lJ6tfzs4=
Received: from CY4PR1201MB2534.namprd12.prod.outlook.com (10.172.121.7) by
 CY4PR1201MB0149.namprd12.prod.outlook.com (10.172.78.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.14; Wed, 19 Sep 2018 07:15:06 +0000
Received: from CY4PR1201MB2534.namprd12.prod.outlook.com
 ([fe80::b08f:8c8e:9b73:a942]) by CY4PR1201MB2534.namprd12.prod.outlook.com
 ([fe80::b08f:8c8e:9b73:a942%9]) with mapi id 15.20.1143.017; Wed, 19 Sep 2018
 07:15:06 +0000
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
Thread-Index: AQHUP5Ky9o6EaoAaAUKshOjpemWQV6TfQrMAgAyj3wCAAG3ngIAKHNIAgAC24gCAACmmAA==
Date:   Wed, 19 Sep 2018 07:15:06 +0000
Message-ID: <d4c25272-9df8-33d6-d310-964b17a8c80d@amd.com>
References: <20180829122026.27012-1-kraxel@redhat.com>
 <20180829122026.27012-3-kraxel@redhat.com>
 <CAPM=9tyXc41DAkgjCRojrqH28qkirxgrpgNmrwu4WAeLpg7tAw@mail.gmail.com>
 <9bf20fa1-3752-edd1-588c-e38cd166c3af@amd.com>
 <20180912072541.nagfrr2dgy34szcx@sirius.home.kraxel.org>
 <5684a3fc-3605-7bb0-b0be-418c2ae702b5@amd.com>
 <20180919044600.utvnu5l6fvvi2qi4@sirius.home.kraxel.org>
In-Reply-To: <20180919044600.utvnu5l6fvvi2qi4@sirius.home.kraxel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR1501CA0024.namprd15.prod.outlook.com
 (2603:10b6:4:9d::37) To CY4PR1201MB2534.namprd12.prod.outlook.com
 (2603:10b6:903:da::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jiandi.An@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR1201MB0149;20:NYNeRPXA2aCPd1EehBkxutNAyGQHX1QRgWIP0lkvynAqtRIjvCB0y3eHAgPxOafAXW5stwessZ8c+k3MyWHfmFl+byykUUxZR/zaCTEelhJ9ZIGj+3BGZkc2K656Q32dbVjyrefhXByIEyk8pxsJPB81y2SgH3AyQ+3C4vDiET8T186GFhEfXMBbvK5onG/9SiqjxEdfE+7t7LlgNiyCxsaJyCmrFHtHvlPU1jAcL4UpwGqlfMcq7q69B79h/cso
x-ms-office365-filtering-correlation-id: 54ee840d-a860-4c9e-3e46-08d61dffa06f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY4PR1201MB0149;
x-ms-traffictypediagnostic: CY4PR1201MB0149:
x-microsoft-antispam-prvs: <CY4PR1201MB014946C8535BE87CA11A6B0CFD1C0@CY4PR1201MB0149.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:CY4PR1201MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR1201MB0149;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(366004)(396003)(189003)(199004)(386003)(8676002)(6436002)(6306002)(6512007)(305945005)(36756003)(54906003)(68736007)(81156014)(256004)(66066001)(6916009)(6246003)(8936002)(81166006)(316002)(53546011)(53936002)(4326008)(5250100002)(229853002)(7736002)(105586002)(186003)(31686004)(106356001)(99286004)(39060400002)(6486002)(5660300001)(14454004)(52116002)(6116002)(93886005)(2906002)(76176011)(102836004)(486006)(476003)(966005)(11346002)(26005)(6506007)(446003)(478600001)(2616005)(97736004)(31696002)(72206003)(25786009)(2900100001)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB0149;H:CY4PR1201MB2534.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wwWaw99rmd1F5nycsmxgpyTdCkE967cB5oriU/CAQR/o6tm6XOr8wdv+916AHW71aDT7KPEVGB4knEfdf+Kj11GiD2wFn0L7/FuKPi2NldQiUFQ9QTmEh7Eb+lhhjWYW8r7ApB/A9+E8+2O77uePd/WyDWGivea1bYszuf/Xk3Zj5wDPVlK5zj50BKC1+UlU/GLQjG9lC7ogoLZh+5vDR/lBxMCMciL4wK9IK8hkQr78b4OEf61lGc8/CxxvVkwkM6Qkxaos8CGxqKMeNSzyjvj8bKr4sOZOKteyg9qHscupChSyPxvdIRs3MhI74A/mng+cOhalt56jVka3OR6JQFcE9OvruQTF7gLcNLehdQI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D690730D8F0B445973B9A6C93873C76@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ee840d-a860-4c9e-3e46-08d61dffa06f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 07:15:06.7456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA5LzE4LzIwMTggMTE6NDYgUE0sIEdlcmQgSG9mZm1hbm4gd3JvdGU6DQo+ICAgSGks
DQo+IA0KPj4gYnVmZmVyLiAgSSB0cmllZCB0byBwdXQgYSBkbWFfc3luY19zZ19mb3JfZGV2aWNl
KCkgb24gdmlydGlvX2dwdV9vYmplY3Qgb2JqLT5wYWdlcy1zZ2wNCj4+IGJlZm9yZSBWSVJUSU9f
R1BVX0NNRF9UUkFOU0ZFUl9UT19IT1NUXzJEIGlzIHNlbnQuICBUaGlzIGZpeGVzIHRoZSBrZXJu
ZWwgY29uc29sZSBwYXRoLg0KPiANCj4gVGhhdCBzaG91bGQgYmUgdGhlIHJpZ2h0IHBsYWNlLg0K
PiANCj4+IE9uY2UgZGlzcGxheSBtYW5nZXIgaXMga2lja2VkIG9mZiBmb3IgZXhhbXBsZSAoc3Vk
byBzeXN0ZW1jdGwgc3RhcnQgbGlnaHRkbS5zZXJ2aWNlKSBhbmQNCj4+IHJlc291cmNlIGlkIDMg
Z2V0cyBjcmVhdGVkIGZyb20gdXNlciBzcGFjZSBkb3duLCBpdCBzdGlsbCBnaXZlcyBhIGJsYW5r
IGJsYWNrIHNjcmVlbi4NCj4gDQo+IEhtbS4gIEknZCBzdXNwZWN0IHRoZXJlIGlzIHNpbXBseSBh
IGNvZGUgcGF0aCBtaXNzaW5nLiAgQ2FuIHlvdSBzZW5kIHRoZQ0KPiBwYXRjaCB5b3UgaGF2ZT8N
Cj4gDQo+IGNoZWVycywNCj4gICBHZXJkDQo+IA0KDQpJIHNlbnQgdGhlIHBhdGNoLiAgRm9yIG5v
dyBpdCBkb2VzIGRtYV9zeW5jX3NnIG9uIHRoZSBwYWdlcyBpbiANClRSQU5TRkVSX1RPX0hPU1Rf
MkQvM0Qgd2hlbiB1c2VfZG1hX2FwaSBpcyB0cnVlLg0KDQpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9sa21sLzIwMTgwOTE5MDcwOTMxLjkxMTY4LTEtamlhbmRpLmFuQGFtZC5jb20vDQoNCi0gSmlh
bmRpDQo=
