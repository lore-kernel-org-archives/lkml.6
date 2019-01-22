Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31172C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7162084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f6Ao5Flw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfAVVno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:43:44 -0500
Received: from mail-eopbgr740084.outbound.protection.outlook.com ([40.107.74.84]:52858
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726225AbfAVVnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmux4+WstKbAQ1L3Vym71gu0NwYhKjSmRheC+c9g2Jo=;
 b=f6Ao5Flw+fkeV1JM25KHN4xvnudL9m/EVf1lcfW4VPXWRnVQkmb83+nN4s81peqPBcUdTl1JBi1+ozq1Gqtl+Y4YGi8g1lwziC1LIGDf2vj5891sD49sVrXgd9T2TgyyOX1HlymeEnnIHYtAPnGMJhSNqNLhjSGFW+iawmEJhdc=
Received: from MN2PR12MB3631.namprd12.prod.outlook.com (20.178.243.19) by
 MN2PR12MB2861.namprd12.prod.outlook.com (20.179.80.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 21:43:40 +0000
Received: from MN2PR12MB3631.namprd12.prod.outlook.com
 ([fe80::a861:43c0:476d:e044]) by MN2PR12MB3631.namprd12.prod.outlook.com
 ([fe80::a861:43c0:476d:e044%5]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 21:43:40 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH 2/2] x86/kvmclock: set_memory_decrypted() takes number of
 pages
Thread-Topic: [PATCH 2/2] x86/kvmclock: set_memory_decrypted() takes number of
 pages
Thread-Index: AQHUspgVfIwXb4OeBkOAdFm1kvco6qW70d+A
Date:   Tue, 22 Jan 2019 21:43:39 +0000
Message-ID: <d40ab37e-ae46-dce8-21f9-b62c062cab84@amd.com>
References: <20190122211758.8317-1-bauerman@linux.ibm.com>
 <20190122211758.8317-2-bauerman@linux.ibm.com>
In-Reply-To: <20190122211758.8317-2-bauerman@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0013.prod.exchangelabs.com (2603:10b6:804:2::23)
 To MN2PR12MB3631.namprd12.prod.outlook.com (2603:10b6:208:cc::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB2861;20:W8KyHgRFdMr8mYr3VcR6+ojoSIk4feE9mp97JOI8kKUxNvPYjOZCFbrhGoDwlw88MHa3rAkM7gE2guTtwcg3fMnlgamyQGe10c5nnd7wT3AHla0sDgVKDT4HOYw9iZq5lqgt8dLjyOlWAXDyXGAo7W6pBbpNN61k0IE5rbt/x7fsq+VLEqEJfDNCSJKXIfHlBJAp07wsAFNMXrKhYIeihD31JPc2fo04r7fmccLQfEIG2v8EVNC87aZ3RWAVlr7b
x-ms-office365-filtering-correlation-id: ddf9ca46-0078-4e91-1fd0-08d680b2abf1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB2861;
x-ms-traffictypediagnostic: MN2PR12MB2861:
x-microsoft-antispam-prvs: <MN2PR12MB28612E44B3B20E0B98BB8CE8EC980@MN2PR12MB2861.namprd12.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39860400002)(366004)(189003)(199004)(6506007)(6346003)(386003)(102836004)(6246003)(31686004)(53546011)(2906002)(105586002)(8936002)(4326008)(6436002)(26005)(106356001)(25786009)(186003)(66066001)(7736002)(305945005)(36756003)(6486002)(97736004)(6512007)(31696002)(86362001)(81156014)(81166006)(2501003)(229853002)(256004)(14444005)(8676002)(14454004)(478600001)(476003)(11346002)(2616005)(7416002)(486006)(68736007)(99286004)(53936002)(71200400001)(3846002)(6116002)(71190400001)(52116002)(446003)(316002)(76176011)(72206003)(110136005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2861;H:MN2PR12MB3631.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RSB4SC1tlK3hv3WiPfgb3eqHU3Z7/Me8rbcZ6dimS5Ivwg0SL8QhltWlUCO9klUtqNIah+s0TNH9g0g7Rgu/Mj0Z9j7hg0lKJxxY4RZfohOxRHd+7VrfrNcyaSwj337YdSAtsCmOknoUmP/NuAO9kq+4pNaS7WJ5+TPUne1D1kMuABGvKN7BaH2YN65r6R4rGL/SyOyG1XI//2h4srdXL/7UhZvrH/hFVuJLTi6+77VxpSSK1kE5CorDEiDjcoZFyHwN2oNGepvuYcieDbVN8xwCUZb97yso72oTojyTlRuKhTKxZVyjIcm9U40TQz6if/SOgZ2EQIQs1tnaSlko8uUj33nJfU7tRUEVdSlCZnJfb094hZqnEIVT35UaPOF2g9T+Jp7llKN7D3a9E1CvTxvepCtkCDnGGkQvnV5XBYw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF724676218A724C9BD29A9E44D6E310@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf9ca46-0078-4e91-1fd0-08d680b2abf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 21:43:38.7257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2861
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yMi8xOSAzOjE3IFBNLCBUaGlhZ28gSnVuZyBCYXVlcm1hbm4gd3JvdGU6DQo+IEZyb206
IFJhbSBQYWkgPGxpbnV4cmFtQHVzLmlibS5jb20+DQo+IA0KPiBzZXRfbWVtb3J5X2RlY3J5cHRl
ZCgpIGV4cGVjdHMgdGhlIG51bWJlciBvZiBQQUdFX1NJWkUgcGFnZXMgdG8gZGVjcnlwdC4NCj4g
a3ZtY2xvY2tfaW5pdF9tZW0oKSBpbnN0ZWFkIHBhc3NlcyBudW1iZXIgb2YgYnl0ZXMuIFRoaXMg
ZGVjcnlwdHMgYSBodWdlDQo+IG51bWJlciBvZiBwYWdlcyByZXN1bHRpbmcgaW4gZGF0YSBjb3Jy
dXB0aW9uLg0KDQpTYW1lIGNvbW1lbnQgYXMgcGF0Y2ggMS8yIGluIHRoaXMgc2VyaWVzLiAgVGhp
cyBpcyBub3QgY29ycmVjdC4gU2VlDQpjb21tZW50cyBiZWxvdy4NCg0KPiANCj4gRml4ZWQgaXQu
DQo+IA0KPiBbIGJhdWVybWFubjogU2xpZ2h0bHkgcmV3b3JkZWQgY29tbWl0IG1lc3NhZ2UgYW5k
IGFkZGVkIEZpeGVzOiB0YWcuIF0NCj4gRml4ZXM6IDZhMWNhYzU2ZjQxZiAoIng4Ni9rdm06IFVz
ZSBfX2Jzc19kZWNyeXB0ZWQgYXR0cmlidXRlIGluIHNoYXJlZCB2YXJpYWJsZXMiKQ0KPiBTaWdu
ZWQtb2ZmLWJ5OiBSYW0gUGFpIDxsaW51eHJhbUB1cy5pYm0uY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBUaGlhZ28gSnVuZyBCYXVlcm1hbm4gPGJhdWVybWFuQGxpbnV4LmlibS5jb20+DQo+IC0tLQ0K
PiAgYXJjaC94ODYva2VybmVsL2t2bWNsb2NrLmMgfCAzICstLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gTm90ZTogRm91bmQgYnkgY29k
ZSBpbnNwZWN0aW9uLiBJIGRvbid0IGhhdmUgYSB3YXkgdG8gdGVzdC4NCj4gDQo+IGRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9rZXJuZWwva3ZtY2xvY2suYyBiL2FyY2gveDg2L2tlcm5lbC9rdm1jbG9j
ay5jDQo+IGluZGV4IGU4MTFkNGQxYzgyNC4uYjVjODY3ZGQyYzhkIDEwMDY0NA0KPiAtLS0gYS9h
cmNoL3g4Ni9rZXJuZWwva3ZtY2xvY2suYw0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwva3ZtY2xv
Y2suYw0KPiBAQCAtMjUxLDggKzI1MSw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBrdm1jbG9ja19p
bml0X21lbSh2b2lkKQ0KPiAgCSAqIGJlIG1hcHBlZCBkZWNyeXB0ZWQuDQo+ICAJICovDQo+ICAJ
aWYgKHNldl9hY3RpdmUoKSkgew0KPiAtCQlyID0gc2V0X21lbW9yeV9kZWNyeXB0ZWQoKHVuc2ln
bmVkIGxvbmcpIGh2Y2xvY2tfbWVtLA0KPiAtCQkJCQkgMVVMIDw8IG9yZGVyKTsNCj4gKwkJciA9
IHNldF9tZW1vcnlfZGVjcnlwdGVkKCh1bnNpZ25lZCBsb25nKSBodmNsb2NrX21lbSwgMSk7DQoN
CkFnYWluLCBub3QgY29ycmVjdC4gQSBudW1iZXIgb2YgcGFnZXMgd2VyZSBhbGxvY2F0ZWQgYmFz
ZWQgb24gdGhlIG9yZGVyLg0KVGhhdCBudW1iZXIgaXMgY2FsY3VsYXRlZCB1c2luZyB0aGUgc2hp
ZnQgaW4gdGhlIGNhbGwuIEhhcmRjb2RpbmcgdGhpcyB0bw0KMSBpcyB3cm9uZy4NCg0KVGhhbmtz
LA0KVG9tDQoNCj4gIAkJaWYgKHIpIHsNCj4gIAkJCV9fZnJlZV9wYWdlcyhwLCBvcmRlcik7DQo+
ICAJCQlodmNsb2NrX21lbSA9IE5VTEw7DQo+IA0K
