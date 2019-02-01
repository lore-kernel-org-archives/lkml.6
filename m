Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE73C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8AF218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zs+Iw8bq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbfBALBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:01:25 -0500
Received: from mail-eopbgr710058.outbound.protection.outlook.com ([40.107.71.58]:31572
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726657AbfBALBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 06:01:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ot0hhd45BmJI0shaFpYC+oNEPvnFVoVzLqhZBVuQvdE=;
 b=zs+Iw8bqzrV2NGbmwhzvYMGEg6I9Bz8QPhHrob7QRyNO4pHxGSnttnIaCfXFSpoZlBUlpESoybnWoJLjvORE8mpsPWiEXhKNLrQxSLWw06eVuMx9XhMhCekQkxTmmhdNPwXKR5/qL2ZNd08wCFMu4C5W45ZJx5b7zYmmWFEB2wQ=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3036.namprd12.prod.outlook.com (20.178.30.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Fri, 1 Feb 2019 11:01:22 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1558.023; Fri, 1 Feb 2019
 11:01:22 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>
Subject: Re: [PATCH] svm: Fix improper check when deactivate AVIC
Thread-Topic: [PATCH] svm: Fix improper check when deactivate AVIC
Thread-Index: AQHUt6n/PbEp8KQZn0iUg2/B2tUkjaXIALmAgALK0oA=
Date:   Fri, 1 Feb 2019 11:01:22 +0000
Message-ID: <e587eb0a-cd73-bbf9-5a77-1cc598bd49ac@amd.com>
References: <20190129080913.40998-1-suravee.suthikulpanit@amd.com>
 <8663e279-5ea2-a3a9-9ecc-7b7226ab48bc@redhat.com>
In-Reply-To: <8663e279-5ea2-a3a9-9ecc-7b7226ab48bc@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
x-originating-ip: [124.121.4.12]
x-clientproxiedby: SG2PR06CA0226.apcprd06.prod.outlook.com
 (2603:1096:4:68::34) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3036;20:y1+Tjuz15meX0EGd3yYPEewqzMip3Z7+rZodudKc7e52kjOYWXwq8v28D+4lCSGrer6EO70b85OWdjewHbHNjqfqJjHQsq2l0wUZ0pZsQYsGE5oJUl1g7/czJsZ9Bu2MyH9t4ClCPwMkrMDA5DlCNZamSfgt3vIpc7tFCAGKxcf9MyhKQlXjs1ZQr8J8stfzyail4uaMAObswHlDPUBa1fdL9CUn8c3vouwIGRoJgGRDU6o2RbgkSQM4jODivqPj
x-ms-office365-filtering-correlation-id: 3d49effe-2bf8-4d6b-c7ff-08d6883499a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3036;
x-ms-traffictypediagnostic: DM6PR12MB3036:
x-microsoft-antispam-prvs: <DM6PR12MB3036A18B13649E4511CEA8C5F3920@DM6PR12MB3036.namprd12.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(366004)(39860400002)(189003)(199004)(97736004)(65806001)(102836004)(53936002)(66066001)(6116002)(6506007)(3846002)(71200400001)(446003)(7416002)(71190400001)(68736007)(65956001)(26005)(6486002)(386003)(53546011)(11346002)(186003)(64126003)(6246003)(25786009)(256004)(6512007)(36756003)(229853002)(52116002)(76176011)(81166006)(2201001)(8676002)(2501003)(54906003)(110136005)(72206003)(486006)(65826007)(2616005)(81156014)(316002)(31686004)(2906002)(105586002)(8936002)(305945005)(476003)(7736002)(106356001)(31696002)(6436002)(4326008)(86362001)(478600001)(14454004)(99286004)(58126008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3036;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WHFATZ0UvqS847D6iuz7LxOlOwRYBxh6Jz9gmulfdbZIH3sDtvdrkUnPaBdAMkjv39aoW71u5e9ZG0HZRLvEblWEVxzZrVVmysU9X0k+Oth2f1m1gP4LiT32BSq+a1/E6HGmt5gC/Pcwf4HOw1GDAHW+ZutyoE8f0rtI21oOsUUxTYwEkY4GLgQSAe+mG2drAHQ6iK0rb5NT6jwg193W2AelJacoVVLkhc5r0oztCeO3oFfqEXlOdj5H2g5D7r3VoHPugzUqAFbBasvPWhpt5Abli8mRKfaiyhcACKSkiNRUgTwrvxO8kCZwpGMOxzt8Jwvti5P4DB8u5AwB8jLP9ybSgl2/V/02AXW4KCgdsnJL3ls2XxAaxDoFZQSbK7o15lHmS9lmICPw0F7Gk1+su8gqHv+IS7EfgpW5L6HByfE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C074990CFB51C44B82A85E861EE3E5A5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d49effe-2bf8-4d6b-c7ff-08d6883499a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 11:01:18.7284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGFvbG8sDQoNCk9uIDEvMzAvMTkgMTE6MjIgUE0sIFBhb2xvIEJvbnppbmkgd3JvdGU6DQo+IE9u
IDI5LzAxLzE5IDA5OjA5LCBTdXRoaWt1bHBhbml0LCBTdXJhdmVlIHdyb3RlOg0KPj4gVGhlIGZ1
bmN0aW9uIHN2bV9yZWZyZXNoX2FwaWN2X2V4ZWNfY3RybCgpIGFsd2F5cyByZXR1cm5pbmcgcHJl
bWF0dXJlbHkNCj4+IGFzIGt2bV92Y3B1X2FwaWN2X2FjdGl2ZSgpIGFsd2F5cyByZXR1cm4gZmFs
c2Ugd2hlbiBjYWxsaW5nIGZyb20NCj4+IHRoZSBmdW5jdGlvbiBhcmNoL3g4Ni9rdm0veDg2LmM6
a3ZtX3ZjcHVfZGVhY3RpdmF0ZV9hcGljdigpLg0KPj4gVGhpcyBpcyBiZWNhdXNlIHRoZSBhcGlj
dl9hY3RpdmUgaXMgc2V0IHRvIGZhbHNlIGp1c3QgYmVmb3JlIGNhbGxpbmcNCj4+IHJlZnJlc2hf
YXBpY3ZfZXhlY19jdHJsKCkuDQo+Pg0KPj4gQWxzbywgd2UgbmVlZCB0byBtYXJrIFZNQ0JfQVZJ
QyBiaXQgYXMgZGlydHkgaW5zdGVhZCBvZiBWTUNCX0lOVFIuDQo+Pg0KPj4gU28sIGZpeCBzdm1f
cmVmcmVzaF9hcGljdl9leGVjX2N0cmwoKSB0byBwcm9wZXJseSBkZWFjdGl2YXRlIEFWSUMuDQo+
Pg0KPj4gRml4ZXM6IDY3MDM0YmI5ZGQ1ZSAoJ0tWTTogU1ZNOiBBZGQgaXJxY2hpcF9zcGxpdCgp
IGNoZWNrcyBiZWZvcmUgZW5hYmxpbmcgQVZJQycpDQo+IA0KPiBIYXZpbmcgdGhlIGxhcGljX2lu
X2tlcm5lbCBjaGVjayBpbiB5b3VyIGNvZGUgaXMgYSBiaXQgdWdseSAtIHRoZSBjYWxsZXINCj4g
c2hvdWxkIGNoZWNrIGl0LiAgQW5kIGFjdHVhbGx5LCBldmVuIHRob3VnaCBpdCBkb2Vzbid0IGNo
ZWNrIGl0IHJpZ2h0DQo+IG5vdywgc3ZtX3JlZnJlc2hfYXBpY3ZfZXhlY19jdHJsIGlzIG9ubHkg
cmVhY2hhYmxlIGlmIGxhcGljX2luX2tlcm5lbA0KPiByZXR1cm5zIHRydWU7IHNlZSB0aGUgS1ZN
X0NBUF9IWVBFUlZfU1lOSUMgY2FzZSBvZg0KPiBrdm1fdmNwdV9pb2N0bF9lbmFibGVfY2FwLg0K
PiANCj4gV2hhdCBhYm91dCB0aGlzIHNpbXBsZXIgcGF0Y2g6DQo+IA0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYva3ZtL3N2bS5jIGIvYXJjaC94ODYva3ZtL3N2bS5jDQo+IGluZGV4IDAxYjY2YmJj
ZGQ3YS4uNzRjZWRhNDcwZWFlIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rdm0vc3ZtLmMNCj4g
KysrIGIvYXJjaC94ODYva3ZtL3N2bS5jDQo+IEBAIC01MTIyLDExICs1MTIyLDExIEBAIHN0YXRp
YyB2b2lkIHN2bV9yZWZyZXNoX2FwaWN2X2V4ZWNfY3RybCgNCj4gICAJc3RydWN0IHZjcHVfc3Zt
ICpzdm0gPSB0b19zdm0odmNwdSk7DQo+ICAgCXN0cnVjdCB2bWNiICp2bWNiID0gc3ZtLT52bWNi
Ow0KPiANCj4gLQlpZiAoIWt2bV92Y3B1X2FwaWN2X2FjdGl2ZSgmc3ZtLT52Y3B1KSkNCj4gLQkJ
cmV0dXJuOw0KPiAtDQo+IC0Jdm1jYi0+Y29udHJvbC5pbnRfY3RsICY9IH5BVklDX0VOQUJMRV9N
QVNLOw0KPiAtCW1hcmtfZGlydHkodm1jYiwgVk1DQl9JTlRSKTsNCj4gKwlpZiAoa3ZtX3ZjcHVf
YXBpY3ZfYWN0aXZlKHZjcHUpKQ0KPiArCQl2bWNiLT5jb250cm9sLmludF9jdGwgfD0gQVZJQ19F
TkFCTEVfTUFTSzsNCj4gKwllbHNlDQo+ICsJCXZtY2ItPmNvbnRyb2wuaW50X2N0bCAmPSB+QVZJ
Q19FTkFCTEVfTUFTSzsNCj4gKwltYXJrX2RpcnR5KHZtY2IsIFZNQ0JfQVZJQyk7DQo+ICAgfQ0K
PiANCj4gICBzdGF0aWMgdm9pZCBzdm1fbG9hZF9lb2lfZXhpdG1hcChzdHJ1Y3Qga3ZtX3ZjcHUg
KnZjcHUsIHU2NA0KPiAqZW9pX2V4aXRfYml0bWFwKQ0KPiANCj4gPw0KPiANCj4gVGhhbmtzLA0K
PiANCj4gUGFvbG8NCj4gDQoNClllcywgdGhpcyB3b3VsZCB3b3JrLg0KDQpUaGlzIHBhdGNoIGlz
IGFjdHVhbGx5IGEgcHJlY3Vyc29yIG9mIGEgcGF0Y2ggc2VyaWVzIHRoYXQgSSBhbSB3b3JraW5n
IG9uDQp0byBhbGxvdyBBVklDIGVuYWJsaW5nL2Rpc2FibGluZyBkdXJpbmcgcnVuLXRpbWUuIEkg
d2lsbCBzZW5kIG91dCBhIHNlcmllcw0KZm9yIFJGQyBzb29uLg0KDQpUaGFua3MsDQpTdXJhdmVl
DQo=
