Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470FBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C5E20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ryiBASXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbfAQIoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:44:39 -0500
Received: from mail-eopbgr790043.outbound.protection.outlook.com ([40.107.79.43]:32573
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbfAQIoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaWouA7b0vSmxqLykS+65rMwdJue7wjZMYAigPkPIW4=;
 b=ryiBASXx/niDwDunRpOCYZLkVouuakenMsmnIIXR0jdB7sxMg99IXz2Vm8R8kUaoNE7g5DEiE6E6CPk0dzNxbCIz+kQeyy7VeejOByW+nx16aNKx8UkKYtV1tpGrNEqyhftq7exNMWkAU21mEZQMlVFYeqn4g0ns1TdTGDlV7D8=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB2745.namprd12.prod.outlook.com (20.176.118.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.19; Thu, 17 Jan 2019 08:44:36 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1516.019; Thu, 17 Jan 2019
 08:44:36 +0000
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
Thread-Index: AQHUrVI/ylqJsNQGs0C49TFTH04R5KWx458AgAALuQCAADJSAIABBWMA
Date:   Thu, 17 Jan 2019 08:44:36 +0000
Message-ID: <0a61c07d-edfe-2738-380d-33d39e40fc0a@amd.com>
References: <20190116041546.3541-1-Suravee.Suthikulpanit@amd.com>
 <20190116132648.i5n3hz3k7d2wxbrx@8bytes.org>
 <60c24182-c58e-0575-b085-c7eebc00c49b@amd.com>
 <20190116170852.GD4681@8bytes.org>
In-Reply-To: <20190116170852.GD4681@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
x-originating-ip: [61.90.30.2]
x-clientproxiedby: SG2PR06CA0182.apcprd06.prod.outlook.com (2603:1096:4:1::14)
 To DM6PR12MB2844.namprd12.prod.outlook.com (2603:10b6:5:45::32)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB2745;20:7NItNWTVvhTTYxlGOD2inEWCnr24Gjfu/e6COKh1CeM1r4QUc31MbryODAJfn3HEQO97bhuxZzLjpyzEifXLAvy4EIhopOwd9J/G76C5BQlOmNZOps5xQTIgBUolnEIRvAkLUM8WanA7vMyfaT2fhHK3JxjLpI/MCAMBtnxRcOQ7DQlVQGm/mPz5jn9GwCKYswbBAf65oKEXHngKkhsNb+BM1jsEjhm7laIfKKlV+KBeuEn9LevA8xdR2qnOHQXm
x-ms-office365-filtering-correlation-id: 8f4a2f20-ad6e-4d8c-4773-08d67c58025f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2745;
x-ms-traffictypediagnostic: DM6PR12MB2745:
x-microsoft-antispam-prvs: <DM6PR12MB27456155936AA3F48B938A89F3830@DM6PR12MB2745.namprd12.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(4326008)(186003)(14454004)(1730700003)(8936002)(71200400001)(8676002)(31686004)(105586002)(53936002)(86362001)(72206003)(68736007)(26005)(99286004)(305945005)(476003)(7736002)(6506007)(25786009)(36756003)(11346002)(386003)(2616005)(486006)(53546011)(6436002)(65826007)(81156014)(5660300001)(81166006)(71190400001)(6916009)(102836004)(6486002)(478600001)(229853002)(5640700003)(446003)(2351001)(6246003)(93886005)(52116002)(316002)(5024004)(6346003)(64126003)(2906002)(58126008)(76176011)(256004)(97736004)(6116002)(3846002)(2501003)(31696002)(6512007)(54906003)(66066001)(65806001)(106356001)(65956001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2745;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Jt8WyJveB7MXwbjUg5A1Qi1b5YM0g4bnhsL70wEwyrT/dqcEbsZPUHEb1LQ0SBlrvS58XCxWZJdyblnzrSmNOauzAyHO1cFDfdre7dMOw/FVlCHkbtc3DD3yEIHJnu5szwzj8bXkroZqkS4QjZw7yQPDmLrDOofxaAmDAWNQ33I3CBBgTBs6RJyTmj8T4PZDCX5Jb+6KXaPtqlpU4K/shOE4TXERrxIhTPEdibPDNqSFZS+09dxprDd185QdQEihtuUY5fFQAc+cr6n0WxJhwfKwPqjLeZ826TJ06HuPNE5nte9cf8UT+J0+cE6eyqOZWqlsFP82XtKvSsEz1KeJyLGlwC3H7zOx6AxyOHb/QWliHmetXkQb9uAcbQzfChti7GwvlNs6K3gdALnRWPckfUZaTLggnIN1+xUZha6t1UM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEDC9507A1464F4B82B738600F34B9E8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4a2f20-ad6e-4d8c-4773-08d67c58025f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 08:44:34.0924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2745
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sm9lcmcsDQoNCk9uIDEvMTcvMTkgMTI6MDggQU0sIGpvcm9AOGJ5dGVzLm9yZyB3cm90ZToNCj4g
T24gV2VkLCBKYW4gMTYsIDIwMTkgYXQgMDI6MDg6NTVQTSArMDAwMCwgU3V0aGlrdWxwYW5pdCwg
U3VyYXZlZSB3cm90ZToNCj4+IEFjdHVhbGx5LCBJIGFtIG5vdCBzdXJlIGhvdyB3ZSB3b3VsZCBi
ZSBtaXNzaW5nIHRoZSBmbHVzaCBvbiB0aGUgbGFzdCBkZXZpY2UuDQo+PiBJbiBteSB0ZXN0LCBJ
IGFtIHNlZWluZyB0aGUgZmx1c2ggY29tbWFuZCBiZWluZyBpc3N1ZWQgY29ycmVjdGx5IGR1cmlu
Zw0KPj4gdmZpb191bm1hcF91bnBpbigpLCB3aGljaCBpcyBhZnRlciBhbGwgZGV2aWNlcyBhcmUg
ZGV0YWNoZWQuDQo+PiBBbHRob3VnaCwgSSBtaWdodCBiZSBtaXNzaW5nIHlvdXIgcG9pbnQgaGVy
ZS4gQ291bGQgeW91IHBsZWFzZSBlbGFib3JhdGU/DQo+IA0KPiBPa2F5LCB5b3UgYXJlIHJpZ2h0
LCB0aGUgcGF0Y2ggZWZmZWN0aXZseSBhZGRzIGFuIHVuY29uZGl0aW9uYWwgZmx1c2ggb2YNCj4g
dGhlIGRvbWFpbiBvbiBhbGwgaW9tbXVzIHdoZW4gdGhlIGxhc3QgZGV2aWNlIGlzIGRldGFjaGVk
LiBTbyBpdCBpcw0KPiBjb3JyZWN0IGluIHRoYXQgcmVnYXJkLiBCdXQgdGhhdCBjb2RlIHBhdGgg
aXMgYWxzbyB1c2VkIGluIHRoZQ0KPiBpb21tdV91bm1hcCgpIHBhdGguDQo+IA0KPiBUaGUgcHJv
YmxlbSBub3cgaXMsIHRoYXQgd2l0aCB5b3VyIGNoYW5nZSB3ZSBzZW5kIGZsdXNoIGNvbW1hbmRz
IHRvIGFsbA0KPiBJT01NVXMgaW4gdGhlIHVubWFwIHBhdGggd2hlbiBubyBkZXZpY2UgaXMgYXR0
YWNoZWQgdG8gdGhlIGRvbWFpbi4NCj4gVGhpcyB3aWxsIGh1cnQgcGVyZm9ybWFuY2UgdGhlcmUs
IG5vPw0KPiANCj4gUmVnYXJkcywNCj4gDQo+IAlKb2VyZw0KPiANCg0KU291bmRzIGxpa2Ugd2Ug
bmVlZCBhIHdheSB0byB0cmFjayBzdGF0ZSBvZiBlYWNoIElPTU1VIGZvciBhIGRvbWFpbi4NCldo
YXQgaWYgd2UgZGVmaW5lIHRoZSBmb2xsb3dpbmc6DQoNCiAgIGVudW0gSU9NTVVfRE9NQUlOX1NU
QVRFUyB7DQogICAgIERPTUFJTl9GUkVFID0gLTEsDQogICAgIERPTUFJTl9ERVRBQ0hFRCA9IDAs
DQogICAgIERPTUFJTl9BVFRBQ0hFRCA+PSAxDQogICB9DQoNCldlIHNob3VsZCBiZSBhYmxlIHRv
IHVzZSB0aGUgZGV2X2lvbW11W10gdG8gaGVscCB0cmFjayB0aGUgc3RhdGUuDQogICAgIC0gSW4g
YW1kX2lvbW11X2RvbWFpbl9hbGxvYywgd2UgaW5pdGlhbGl6ZSB0aGUgYXJyYXkgdG8gRE9NQUlO
X0ZSRUUNCiAgICAgLSBJbiBkb19hdHRhY2goKSwgd2UgY2hhbmdlIHRvIERPTUFJTl9BVFRBQ0gg
b3Igd2UgY2FuIGluY3JlbWVudCB0aGUgY291bnQNCiAgICAgICBpZiBpdCBpcyBhbHJlYWR5IGlu
IERPTUFJTl9BVFRBQ0ggc3RhdGUuDQogICAgIC0gSW4gZG9fZGV0YWNoKCkuIHdlIGNoYW5nZSB0
byBET01BSU5fREVUQUNILg0KDQpUaGVuLCBpbiBfX2RvbWFpbl9mbHVzaF9wYWdlcywgd2UgaXNz
dWUgY29tbWFuZCB3aGVuIHRoZSBkZXZfaW9tbXVbXSA+PSAwLg0KVGhpcyBzaG91bGQgcHJlc2Vy
dmUgcHJldmlvdXMgYmVoYXZpb3IsIGFuZCBvbmx5IGFkZCBmbHVzaGluZyBjb25kaXRpb24gdG8N
CnRoZSBzcGVjaWZpYyBJT01NVSBpbiBkZXRhY2hlZCBzdGF0ZS4gUGxlYXNlIGxldCBtZSBrbm93
IHdoYXQgeW91IHRoaW5rLg0KDQpSZWdhcmRzLA0KU3VyYXZlZQ0K
