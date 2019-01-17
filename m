Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CF2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7146C20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Si7xZ42f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfAQLsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 06:48:47 -0500
Received: from mail-eopbgr730051.outbound.protection.outlook.com ([40.107.73.51]:42112
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726795AbfAQLsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 06:48:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbSMYOkeriWMJEf0JSYikrKue1BwrM4qc0jxH11UCUo=;
 b=Si7xZ42fMXKhSacCBtemrr9WSd4jM2s2G6SFqM+FdsUjMLdZ6Z5i9lflGn9LiBSyPlQEu4dNuGJLQQhll9U1lnL2Wn+HlzHA5syBgfXx/D1Ca245KmAJ5CYWUwun/1OThLMjeY6FCzMlc8WOM+zEaOw48CQBFMXqMxYuId4w9pM=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB2619.namprd12.prod.outlook.com (20.176.116.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.19; Thu, 17 Jan 2019 11:48:44 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1516.019; Thu, 17 Jan 2019
 11:48:44 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "joro@8bytes.org" <joro@8bytes.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [PATCH] iommu/amd: Fix IOMMU page flush when detach all devices
 from a domain
Thread-Topic: [PATCH] iommu/amd: Fix IOMMU page flush when detach all devices
 from a domain
Thread-Index: AQHUrVI/ylqJsNQGs0C49TFTH04R5KWx458AgAALuQCAADJSAIABBWMAgAAzdwA=
Date:   Thu, 17 Jan 2019 11:48:44 +0000
Message-ID: <d5d1e325-cbbd-487a-66b9-8723c505ec02@amd.com>
References: <20190116041546.3541-1-Suravee.Suthikulpanit@amd.com>
 <20190116132648.i5n3hz3k7d2wxbrx@8bytes.org>
 <60c24182-c58e-0575-b085-c7eebc00c49b@amd.com>
 <20190116170852.GD4681@8bytes.org>
 <0a61c07d-edfe-2738-380d-33d39e40fc0a@amd.com>
In-Reply-To: <0a61c07d-edfe-2738-380d-33d39e40fc0a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
x-originating-ip: [124.121.4.136]
x-clientproxiedby: SG2PR0302CA0016.apcprd03.prod.outlook.com
 (2603:1096:3:2::26) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB2619;20:TwwE1teHXxx8WG0lDBINFIm6OHXTC/mRR0sghsYFpU2Se/G5+BpP6V1SXl+kEMwD/Bat6lx4DvQleA9d9abWm74pbhko+gDpqiiXJDlhIgyA7i4J/1hkyh5H/0ewRERiVpsQzQlo4paFlLl1qSFZ5W0JVAaUxFOZmslcHp0NMDSZlr0DDeSF3GY+TCCD7njtLqRKf6BvfhwKajm5js0cmmgcxzAF/D4j17Q3wWmQbs30ZQobd+C8weEQOeUgZmBL
x-ms-office365-filtering-correlation-id: 7cc054fb-080c-43c9-f960-08d67c71bbf1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2619;
x-ms-traffictypediagnostic: DM6PR12MB2619:
x-microsoft-antispam-prvs: <DM6PR12MB26198558FCA49ACEF409931EF3830@DM6PR12MB2619.namprd12.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(346002)(136003)(376002)(189003)(199004)(65806001)(65956001)(66066001)(1730700003)(36756003)(99286004)(81166006)(81156014)(93886005)(8676002)(7736002)(6436002)(106356001)(8936002)(105586002)(305945005)(2616005)(11346002)(2906002)(446003)(229853002)(2351001)(476003)(31686004)(6512007)(486006)(6246003)(5640700003)(53936002)(6486002)(4326008)(6506007)(25786009)(65826007)(26005)(186003)(76176011)(14454004)(68736007)(478600001)(386003)(102836004)(5660300001)(71200400001)(316002)(97736004)(64126003)(256004)(72206003)(31696002)(5024004)(58126008)(71190400001)(86362001)(54906003)(2501003)(52116002)(6916009)(6116002)(3846002)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2619;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qnFAn5PwoxbCy03ANdcV7dco8Je+22xAvJebu1Ale6dO5vvqS9ugzvRpttEKAv8fPCYjzoXsHvLKZOwUcjYQRaobjvVKsg/crGq2z+Xk+yMPoGsOtLI7eVO9TXhOA9KpxM5wJN/fYyKsWIB+LdAuPFYHskX1mK5QHxdVrkFv/9Sf1Pq0hsbpB62OPB9Nj0BB7MtGpPS5WZhneOA88BY1tKCwkhTbyyIFdQG/z/qPeoVXfr8cJiiI33W3xYOQLAcuhVC3PpofNTPoBApR6xcW1L3UOj9/+wT1u0mor7rm77Kf/LnI2tLAvx5AGKKtkk+WU0nHOcDH+4opxj/MRBesxiYNpkxNdEhK/8AfPU0WkoUog8BYpPn6VpsPnA1QUCjY7ZIa7pwMlD4NvRndAL17EfE+koR1PddspsIMmkbcp/c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E65043004400F14F8E5630B4CD67589E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc054fb-080c-43c9-f960-08d67c71bbf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 11:48:42.7099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2619
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sm9lcmcsDQoNCk9uIDEvMTcvMTkgMzo0NCBQTSwgU3VyYXZlZSBTdXRoaWt1bHBhbml0IHdyb3Rl
Og0KPiBKb2VyZywNCj4gDQo+IE9uIDEvMTcvMTkgMTI6MDggQU0sIGpvcm9AOGJ5dGVzLm9yZyB3
cm90ZToNCj4+IE9uIFdlZCwgSmFuIDE2LCAyMDE5IGF0IDAyOjA4OjU1UE0gKzAwMDAsIFN1dGhp
a3VscGFuaXQsIFN1cmF2ZWUgd3JvdGU6DQo+Pj4gQWN0dWFsbHksIEkgYW0gbm90IHN1cmUgaG93
IHdlIHdvdWxkIGJlIG1pc3NpbmcgdGhlIGZsdXNoIG9uIHRoZSBsYXN0IGRldmljZS4NCj4+PiBJ
biBteSB0ZXN0LCBJIGFtIHNlZWluZyB0aGUgZmx1c2ggY29tbWFuZCBiZWluZyBpc3N1ZWQgY29y
cmVjdGx5IGR1cmluZw0KPj4+IHZmaW9fdW5tYXBfdW5waW4oKSwgd2hpY2ggaXMgYWZ0ZXIgYWxs
IGRldmljZXMgYXJlIGRldGFjaGVkLg0KPj4+IEFsdGhvdWdoLCBJIG1pZ2h0IGJlIG1pc3Npbmcg
eW91ciBwb2ludCBoZXJlLiBDb3VsZCB5b3UgcGxlYXNlIGVsYWJvcmF0ZT8NCj4+DQo+PiBPa2F5
LCB5b3UgYXJlIHJpZ2h0LCB0aGUgcGF0Y2ggZWZmZWN0aXZseSBhZGRzIGFuIHVuY29uZGl0aW9u
YWwgZmx1c2ggb2YNCj4+IHRoZSBkb21haW4gb24gYWxsIGlvbW11cyB3aGVuIHRoZSBsYXN0IGRl
dmljZSBpcyBkZXRhY2hlZC4gU28gaXQgaXMNCj4+IGNvcnJlY3QgaW4gdGhhdCByZWdhcmQuIEJ1
dCB0aGF0IGNvZGUgcGF0aCBpcyBhbHNvIHVzZWQgaW4gdGhlDQo+PiBpb21tdV91bm1hcCgpIHBh
dGguDQo+Pg0KPj4gVGhlIHByb2JsZW0gbm93IGlzLCB0aGF0IHdpdGggeW91ciBjaGFuZ2Ugd2Ug
c2VuZCBmbHVzaCBjb21tYW5kcyB0byBhbGwNCj4+IElPTU1VcyBpbiB0aGUgdW5tYXAgcGF0aCB3
aGVuIG5vIGRldmljZSBpcyBhdHRhY2hlZCB0byB0aGUgZG9tYWluLg0KPj4gVGhpcyB3aWxsIGh1
cnQgcGVyZm9ybWFuY2UgdGhlcmUsIG5vPw0KPj4NCj4+IFJlZ2FyZHMsDQo+Pg0KPj4gwqDCoMKg
wqBKb2VyZw0KPj4NCj4gDQo+IFNvdW5kcyBsaWtlIHdlIG5lZWQgYSB3YXkgdG8gdHJhY2sgc3Rh
dGUgb2YgZWFjaCBJT01NVSBmb3IgYSBkb21haW4uDQo+IFdoYXQgaWYgd2UgZGVmaW5lIHRoZSBm
b2xsb3dpbmc6DQo+IA0KPiAgwqAgZW51bSBJT01NVV9ET01BSU5fU1RBVEVTIHsNCj4gIMKgwqDC
oCBET01BSU5fRlJFRSA9IC0xLA0KPiAgwqDCoMKgIERPTUFJTl9ERVRBQ0hFRCA9IDAsDQo+ICDC
oMKgwqAgRE9NQUlOX0FUVEFDSEVEID49IDENCj4gIMKgIH0NCj4gDQo+IFdlIHNob3VsZCBiZSBh
YmxlIHRvIHVzZSB0aGUgZGV2X2lvbW11W10gdG8gaGVscCB0cmFjayB0aGUgc3RhdGUuDQo+ICDC
oMKgwqAgLSBJbiBhbWRfaW9tbXVfZG9tYWluX2FsbG9jLCB3ZSBpbml0aWFsaXplIHRoZSBhcnJh
eSB0byBET01BSU5fRlJFRQ0KPiAgwqDCoMKgIC0gSW4gZG9fYXR0YWNoKCksIHdlIGNoYW5nZSB0
byBET01BSU5fQVRUQUNIIG9yIHdlIGNhbiBpbmNyZW1lbnQgdGhlIGNvdW50DQo+ICDCoMKgwqDC
oMKgIGlmIGl0IGlzIGFscmVhZHkgaW4gRE9NQUlOX0FUVEFDSCBzdGF0ZS4NCj4gIMKgwqDCoCAt
IEluIGRvX2RldGFjaCgpLiB3ZSBjaGFuZ2UgdG8gRE9NQUlOX0RFVEFDSC4NCj4gDQo+IFRoZW4s
IGluIF9fZG9tYWluX2ZsdXNoX3BhZ2VzLCB3ZSBpc3N1ZSBjb21tYW5kIHdoZW4gdGhlIGRldl9p
b21tdVtdID49IDAuDQo+IFRoaXMgc2hvdWxkIHByZXNlcnZlIHByZXZpb3VzIGJlaGF2aW9yLCBh
bmQgb25seSBhZGQgZmx1c2hpbmcgY29uZGl0aW9uIHRvDQo+IHRoZSBzcGVjaWZpYyBJT01NVSBp
biBkZXRhY2hlZCBzdGF0ZS4gUGxlYXNlIGxldCBtZSBrbm93IHdoYXQgeW91IHRoaW5rLg0KPiAN
Cj4gUmVnYXJkcywNCj4gU3VyYXZlZQ0KDQpCeSB0aGUgd2F5LCBJIGp1c3Qgc2VudCBWMiBvZiB0
aGlzIHBhdGNoIHNpbmNlIGl0IG1pZ2h0IGJlIG1vcmUgY2xlYXIuDQoNClJlZ2FyZHMsDQpTdXJh
dmVlDQo=
