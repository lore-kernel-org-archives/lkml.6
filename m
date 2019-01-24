Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BE2C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9A520811
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CEznkfB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfAXLYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 06:24:30 -0500
Received: from mail-eopbgr750072.outbound.protection.outlook.com ([40.107.75.72]:65024
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbfAXLYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 06:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxWNwSmmE55sTJyelMz8iE/HwWE5xzZ37IN9KuTrM0k=;
 b=CEznkfB6B4IcBokBPZYTrjNw3uDMUffyzHkAQkModP9RUZ1qP0KnCEsiOWSxmF/EVsXUhSXKGk/k9piqnipDgCtSoCHQ33CO/s3J84zMgRqBswznjpyy/7RDkRD83m3m9r7AECYMTAdNHWX1gCwTSRQ7rLuQd2Q/eLp4fVg4CeA=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB2358.namprd12.prod.outlook.com (52.132.141.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Thu, 24 Jan 2019 11:23:44 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::35a3:c1b4:5ad0:ec6e]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::35a3:c1b4:5ad0:ec6e%10]) with mapi id 15.20.1558.016; Thu, 24 Jan
 2019 11:23:44 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Zhang, Jerry" <Jerry.Zhang@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Sean Paul <sean@poorly.run>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Thread-Topic: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Thread-Index: AQHUsXD3UXk0MPD/dUyEFCISRS4xuqW50zEAgAAHO4CAAActAIAABFSAgAACPQCAAAIPAIAAF8kAgAABIQCAAAF0AIAABGAAgAABGQCAAAFFAIAAChyAgADjSQCAAM5NgIAAAvSAgACp8ICAAB+TAIAAf28AgAACVwCAARHuAIAAA2gAgAAA64CAAASOgIAAA/WAgAAXlAA=
Date:   Thu, 24 Jan 2019 11:23:44 +0000
Message-ID: <57590a48-4629-e2a1-8673-ce9eb2ec210b@amd.com>
References: <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
 <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
 <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
 <20190123071521.GB20526@infradead.org>
 <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
 <20190123164428.GA9367@infradead.org>
 <CAKv+Gu-9vEKu8mG-o+-4M1ZcgZmTTJVfEdNS9R27AFX8P5sqyQ@mail.gmail.com>
 <20190124091316.GA22796@infradead.org>
 <bb559f74-4b1e-d5ee-74fb-b5dcd4a128cb@amd.com>
 <CAKv+Gu_3LurSN-6w1WijPfpJpc+Pgu0YTnwTfMrXMF3-AKAnJA@mail.gmail.com>
 <953e5e5f-5d47-d6df-40df-c8c94db5447f@amd.com>
 <CAKv+Gu9umPEmB+wh54NOTYcQ14oxf7rwVAXgCqo7V2A+VwkqPA@mail.gmail.com>
In-Reply-To: <CAKv+Gu9umPEmB+wh54NOTYcQ14oxf7rwVAXgCqo7V2A+VwkqPA@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM6P194CA0058.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::35) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2358;20:pidIhfitzqAf77YOc8041QHkVEampjBLxYnFFsOFtMxCW2FJ0udHu7DXPALdXO64fX8iN/1NyOjV23RVEvw6dGVXPatsivK2Go0HNl5aCa3zkPYa5eb0Zj2nyl/dTc/Cn7coLpgKjo0eo0qoFKJfnffvQj22L6a3ujsdxyeD4cT0O19wb1j4EHV18vpflo8P3rd1cq69r0KOcZMlQDn70pXeA8d/FdSp5seq9pSZz3GCbSujF/Z36YPRd7yFZZjv
x-ms-office365-filtering-correlation-id: 52663b9c-8925-49b1-a884-08d681ee6647
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2358;
x-ms-traffictypediagnostic: DM5PR12MB2358:
x-microsoft-antispam-prvs: <DM5PR12MB23580468F09993F81E2902BB839A0@DM5PR12MB2358.namprd12.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(366004)(396003)(39860400002)(199004)(189003)(386003)(8936002)(6436002)(39060400002)(25786009)(6246003)(64126003)(2906002)(7416002)(71200400001)(71190400001)(316002)(6116002)(54906003)(4326008)(256004)(14444005)(99286004)(229853002)(6486002)(6506007)(476003)(2616005)(58126008)(6916009)(11346002)(31696002)(486006)(106356001)(7736002)(31686004)(446003)(65826007)(86362001)(105586002)(93886005)(76176011)(52116002)(97736004)(65806001)(186003)(14454004)(53936002)(81156014)(81166006)(478600001)(36756003)(65956001)(102836004)(72206003)(305945005)(68736007)(6512007)(46003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2358;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DAVEv5QzCck1Aoob2jDTbhZPF312BQk2V+MTy9mr66Mc5qOEdmTmvIsVoSVtR5bakLryVJA11FgVZAtwk/jho3KgRWsw9Uveg9laDwLjDW0LZaWOpg6dqRp0u4K3ET65aS+G6VFr7DxczwnWQLdE85RPgwS6DkU9rKTiNln4oCUoqUj7qip7F+NE+Hlem0aI+zgB9YTj9GZlmB0svezfwCxKti/xeqaNFZt0a3EYqGELevauS/SNO/ou7W+QG6H79Y9A5YBhJXkfDGf/1Ldrqv0SPSIfxH0H0WzO4hE8/RYtKrzm0+iM0zLvh/1bb2ludgyXj2vJDfDfHnQDZgEC8JMhg5ZbeqWO5Esbh0+w4JCBvav+lyYye0mK0UqMoOuu9p3tQQ2tLyRDEJvInCwGuVE7IyuBBxoJisEnaAE6/II=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F6D95F38827FC45AA3D1323D4075171@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52663b9c-8925-49b1-a884-08d681ee6647
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 11:23:41.0452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2358
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMjQuMDEuMTkgdW0gMTA6NTkgc2NocmllYiBBcmQgQmllc2hldXZlbDoNCj4gW1NOSVBdDQo+
IFRoaXMgaXMgKmV4YWN0bHkqIG15IHBvaW50IHRoZSB3aG9sZSB0aW1lLg0KPg0KPiBUaGUgY3Vy
cmVudCBjb2RlIGhhcw0KPg0KPiBzdGF0aWMgaW5saW5lIGJvb2wgZHJtX2FyY2hfY2FuX3djX21l
bW9yeSh2b2lkKQ0KPiB7DQo+ICNpZiBkZWZpbmVkKENPTkZJR19QUEMpICYmICFkZWZpbmVkKENP
TkZJR19OT1RfQ09IRVJFTlRfQ0FDSEUpDQo+ICAgICByZXR1cm4gZmFsc2U7DQo+DQo+IHdoaWNo
IG1lYW5zIHRoZSBvcHRpbWl6YXRpb24gaXMgZGlzYWJsZWQgKnVubGVzcyB0aGUgc3lzdGVtIGlz
DQo+IG5vbi1jYWNoZSBjb2hlcmVudCoNCj4NCj4gU28gaWYgeW91IGhhdmUgcmVwb3J0cyB0aGF0
IHRoZSBvcHRpbWl6YXRpb24gd29ya3Mgb24gc29tZSBQb3dlclBDLCBpdA0KPiBtdXN0IGJlIG5v
bi1jYWNoZSBjb2hlcmVudCBQb3dlclBDLCBiZWNhdXNlIHRoYXQgaXMgdGhlIG9ubHkgcGxhY2UN
Cj4gd2hlcmUgaXQgaXMgZW5hYmxlZCBpbiB0aGUgZmlyc3QgcGxhY2UuDQo+DQo+PiBUaGUgb25s
eSBwcm9ibGVtYXRpYyBoZXJlIGFjdHVhbGx5IHNlZW1zIHRvIGJlIEFSTSwgc28geW91IHNob3Vs
ZA0KPj4gcHJvYmFibHkganVzdCBhZGQgYW4gIiNpZmRlZiAuLl9BUk0gcmV0dXJuIGZhbHNlOyIu
DQo+Pg0KPiBBUk0vYXJtNjQgZG9lcyBub3QgaGF2ZSBhIEtjb25maWcgc3ltYm9sIGxpa2UNCj4g
Q09ORklHX05PVF9DT0hFUkVOVF9DQUNIRSwgc28gd2UgY2FuIG9ubHkgZGlzYWJsZSBpdCBldmVy
eXdoZXJlLiBJZg0KPiB0aGVyZSBhcmUgbm9uLWNvaGVyZW50IEFSTSBzeXN0ZW1zIHRoYXQgYXJl
IGN1cnJlbnRseSB3b3JraW5nIGluIHRoZQ0KPiBzYW1lIHdheSBhcyB0aG9zZSBub24tY29oZXJl
bnQgUG93ZXJQQyBzeXN0ZW1zLCB3ZSB3aWxsIGJyZWFrIHRoZW0gYnkNCj4gZG9pbmcgdGhpcy4N
Cg0KU3VtbWluZyB0aGUgdGhpbmdzIEkndmUgcmVhZCBzbyBmYXIgZm9yIEFSTSB1cCBJIGFjdHVh
bGx5IHRoaW5rIGl0IA0KZGVwZW5kcyBvbiBhIHJ1bnRpbWUgY29uZmlndXJhdGlvbiBhbmQgbm90
IG9uIGNvbXBpbGUgdGltZSBvbmUuDQoNClNvIHRoZSB3aG9sZSBpZGVhIG9mIHByb3ZpZGluZyB0
aGUgZGV2aWNlIHRvIHRoZSBkcm1fKl9jYW5fd2NfbWVtb3J5KCkgDQpmdW5jdGlvbiBpc24ndCBz
byBmYXIgZmV0Y2hlZC4NCg0KQnV0IGZvciBub3cgSSBkbyBwcmVmZXIgd29ya2luZyBhbmQgc2xp
Z2h0bHkgc2xvd2VyIHN5c3RlbSBvdmVyIGJyb2tlbiANCm9uZSwgc28gSSB0aGluayB3ZSBzaG91
bGQganVzdCBkaXNhYmxlIHRoaXMgb24gQVJNIGZvciBub3cuDQoNCkNocmlzdGlhbi4NCg==
