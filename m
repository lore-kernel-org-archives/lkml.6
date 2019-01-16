Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38430C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD82F20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EICBcEA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391078AbfAPOJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:09:03 -0500
Received: from mail-eopbgr810073.outbound.protection.outlook.com ([40.107.81.73]:15499
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733035AbfAPOJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LFx0RSA2xqDbsRsmMngz2HlG4BtIv0KxGb8DLzctS0=;
 b=EICBcEA0EBIDFnWCb2/ET7Hzq6Jcv0CTeF0UERlMVIOGyrEBybreaegWg/xQ+j8gwqeDJdkcM9pcmHwIk/+2hShH/cNdIXUvsC+Xp/SQ3EpgTIwznTx2qPEyDHXhC5+3xJppXUHMLYepagA91fFnBTjB2b4VFTxI7M0y+SHB2rM=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3115.namprd12.prod.outlook.com (20.178.31.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Wed, 16 Jan 2019 14:08:55 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 14:08:55 +0000
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
Thread-Index: AQHUrVI/ylqJsNQGs0C49TFTH04R5KWx458AgAALuQA=
Date:   Wed, 16 Jan 2019 14:08:55 +0000
Message-ID: <60c24182-c58e-0575-b085-c7eebc00c49b@amd.com>
References: <20190116041546.3541-1-Suravee.Suthikulpanit@amd.com>
 <20190116132648.i5n3hz3k7d2wxbrx@8bytes.org>
In-Reply-To: <20190116132648.i5n3hz3k7d2wxbrx@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
x-originating-ip: [110.169.70.41]
x-clientproxiedby: SG2PR06CA0160.apcprd06.prod.outlook.com
 (2603:1096:1:1e::14) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3115;20:ALANgy9Fxp12Uu0MQV1wEDXfuV092KlpJMaK4oIA+cDE/CzneA4zS+tiiCFr9Ef3+2Jh6XJsdGcSe0NifLMJrioAoexAeWqwQpD37GY1pvT0JVa9KgD9Zn/q8nZfENU2pi76vb7QekAeiV3hFQc1foPkmpS5e+fqaKHuxNFTEjJYQT1dfe/r5ftWwFtphmMiHNMdFF+jasKwiZzffPzmJSctvKPSbLN3iIcHhrl5mTh9bWk1ahXZWY7uuLULOksX
x-ms-office365-filtering-correlation-id: 367631f2-3dba-4057-100b-08d67bbc269e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3115;
x-ms-traffictypediagnostic: DM6PR12MB3115:
x-microsoft-antispam-prvs: <DM6PR12MB3115AF57BE7F6815DB4DDC23F3820@DM6PR12MB3115.namprd12.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(5024004)(14444005)(256004)(8936002)(53546011)(386003)(2906002)(26005)(6506007)(102836004)(71200400001)(71190400001)(6246003)(65806001)(66066001)(65956001)(25786009)(4326008)(305945005)(1730700003)(64126003)(8676002)(81156014)(3846002)(86362001)(81166006)(6116002)(72206003)(68736007)(478600001)(31696002)(53936002)(97736004)(7736002)(2501003)(14454004)(65826007)(5640700003)(99286004)(6512007)(6486002)(6436002)(2351001)(316002)(6916009)(5660300001)(105586002)(76176011)(486006)(2616005)(476003)(36756003)(446003)(11346002)(58126008)(186003)(52116002)(229853002)(54906003)(106356001)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3115;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /qFlrvaKYCxdp+quvy6t4pFaDtbJC6G+JyZY/1OKcsTU2iVFjVUc4u674U7H/L9Je8PlXaU+e/cGW1y5Lxbk4IX0ocP8mvHFBNjFszbfJhcl9orApbg/wOR4aYlVivMThwAa+DLB18wdvneZNK1njSuUTOmAo+cLjR0W1DP1B0nzzgAn2QHSPLd5Bv5C8euC1jtVSlZe6EtQZp+VZW4oyKfSm6JZdZq3Vz5+31jiGNL8MVxfN5i9672Fy7OVBFSqYYuBixDQTNORB8T/mhyNvVZFKXah3Jjba6pBL1I9UKrDGFff7g+9ydYklmF2LXibqw6kIfH8TdNzVujluwnk8O7yDYcpE1Um+GWeBihAFxeAjtr3n+diH1fECaYI6Dg0cCz+KoO12AyQEbw9bexRBl+MKm8bHnJiluBg2wEJMUQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5D6EE8EA4D0564E83AE9DF91E392B13@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367631f2-3dba-4057-100b-08d67bbc269e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 14:08:53.3964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sm9lcmcsDQoNCk9uIDEvMTYvMTkgODoyNiBQTSwgam9yb0A4Ynl0ZXMub3JnIHdyb3RlOg0KPiBP
biBXZWQsIEphbiAxNiwgMjAxOSBhdCAwNDoxNjoyNUFNICswMDAwLCBTdXRoaWt1bHBhbml0LCBT
dXJhdmVlIHdyb3RlOg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvYW1kX2lvbW11LmMg
Yi9kcml2ZXJzL2lvbW11L2FtZF9pb21tdS5jDQo+PiBpbmRleCA1MjU2NTliODhhZGUuLmFiMzFi
YTc1ZGExYiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvYW1kX2lvbW11LmMNCj4+ICsr
KyBiL2RyaXZlcnMvaW9tbXUvYW1kX2lvbW11LmMNCj4+IEBAIC0xMjQ4LDcgKzEyNDgsMTMgQEAg
c3RhdGljIHZvaWQgX19kb21haW5fZmx1c2hfcGFnZXMoc3RydWN0IHByb3RlY3Rpb25fZG9tYWlu
ICpkb21haW4sDQo+PiAgIAlidWlsZF9pbnZfaW9tbXVfcGFnZXMoJmNtZCwgYWRkcmVzcywgc2l6
ZSwgZG9tYWluLT5pZCwgcGRlKTsNCj4+ICAgDQo+PiAgIAlmb3IgKGkgPSAwOyBpIDwgYW1kX2lv
bW11X2dldF9udW1faW9tbXVzKCk7ICsraSkgew0KPj4gLQkJaWYgKCFkb21haW4tPmRldl9pb21t
dVtpXSkNCj4+ICsJCS8qDQo+PiArCQkgKiBUaGUgZGV2X2NudCBpcyB6ZXJvIHdoZW4gYWxsIGRl
dmljZXMgYXJlIGRldGFjaGVkDQo+PiArCQkgKiBmcm9tIHRoZSBkb21haW4uIFRoaXMgaXMgdGhl
IGNhc2Ugd2hlbiBWRklPIGRldGFjaGVzDQo+PiArCQkgKiBhbGwgZGV2aWNlcyBmcm9tIHRoZSBn
cm91cCBiZWZvcmUgZmx1c2hpbmcgSU9NTVUgcGFnZXMuDQo+PiArCQkgKiBTbywgYWx3YXlzIGlz
c3VlIHRoZSBmbHVzaCBjb21tYW5kLg0KPj4gKwkJICovDQo+PiArCQlpZiAoZG9tYWluLT5kZXZf
Y250ICYmICFkb21haW4tPmRldl9pb21tdVtpXSkNCj4+ICAgCQkJY29udGludWU7DQo+IA0KPiBU
aGlzIGRvZXNuJ3QgbG9vayBsaWtlIHRoZSBjb3JyZWN0IGZpeC4gV2Ugc3RpbGwgbWlzcyB0aGUg
Zmx1c2ggaWYgd2UNCj4gZGV0YWNoIHRoZSBsYXN0IGRldmljZSBmcm9tIHRoZSBkb21haW4uIA0K
DQpBY3R1YWxseSwgSSBhbSBub3Qgc3VyZSBob3cgd2Ugd291bGQgYmUgbWlzc2luZyB0aGUgZmx1
c2ggb24gdGhlIGxhc3QgZGV2aWNlLg0KSW4gbXkgdGVzdCwgSSBhbSBzZWVpbmcgdGhlIGZsdXNo
IGNvbW1hbmQgYmVpbmcgaXNzdWVkIGNvcnJlY3RseSBkdXJpbmcNCnZmaW9fdW5tYXBfdW5waW4o
KSwgd2hpY2ggaXMgYWZ0ZXIgYWxsIGRldmljZXMgYXJlIGRldGFjaGVkLg0KQWx0aG91Z2gsIEkg
bWlnaHQgYmUgbWlzc2luZyB5b3VyIHBvaW50IGhlcmUuIENvdWxkIHlvdSBwbGVhc2UgZWxhYm9y
YXRlPw0KDQo+IEhvdyBhYm91dCB0aGUgYXR0YWNoZWQgZGlmZj8gSWYNCj4gSSB1bmRlcnN0YW5k
IHRoZSBwcm9ibGVtIGNvcnJlY3RseSwgaXQgc2hvdWxkIGZpeCB0aGUgcHJvYmxlbSBtb3JlDQo+
IHJlbGlhYmx5Lg0KPiANCj4gVGhhbmtzLA0KPiANCj4gCUpvZXJnDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pb21tdS9hbWRfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvYW1kX2lvbW11LmMN
Cj4gaW5kZXggODdiYTIzYTc1YjM4Li5kYzFlMmE4YTE5ZDcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvaW9tbXUvYW1kX2lvbW11LmMNCj4gKysrIGIvZHJpdmVycy9pb21tdS9hbWRfaW9tbXUuYw0K
PiBAQCAtMTk5MSwyNSArMTk5MSwzNiBAQCBzdGF0aWMgdm9pZCBkb19hdHRhY2goc3RydWN0IGlv
bW11X2Rldl9kYXRhICpkZXZfZGF0YSwNCj4gICANCj4gICBzdGF0aWMgdm9pZCBkb19kZXRhY2go
c3RydWN0IGlvbW11X2Rldl9kYXRhICpkZXZfZGF0YSkNCj4gICB7DQo+ICsJc3RydWN0IHByb3Rl
Y3Rpb25fZG9tYWluICpkb21haW4gPSBkZXZfZGF0YS0+ZG9tYWluOw0KPiAgIAlzdHJ1Y3QgYW1k
X2lvbW11ICppb21tdTsNCj4gICAJdTE2IGFsaWFzOw0KPiAgIA0KPiAgIAlpb21tdSA9IGFtZF9p
b21tdV9ybG9va3VwX3RhYmxlW2Rldl9kYXRhLT5kZXZpZF07DQo+ICAgCWFsaWFzID0gZGV2X2Rh
dGEtPmFsaWFzOw0KPiAgIA0KPiAtCS8qIGRlY3JlYXNlIHJlZmVyZW5jZSBjb3VudGVycyAqLw0K
PiAtCWRldl9kYXRhLT5kb21haW4tPmRldl9pb21tdVtpb21tdS0+aW5kZXhdIC09IDE7DQo+IC0J
ZGV2X2RhdGEtPmRvbWFpbi0+ZGV2X2NudCAgICAgICAgICAgICAgICAgLT0gMTsNCj4gLQ0KPiAg
IAkvKiBVcGRhdGUgZGF0YSBzdHJ1Y3R1cmVzICovDQo+ICAgCWRldl9kYXRhLT5kb21haW4gPSBO
VUxMOw0KPiAgIAlsaXN0X2RlbCgmZGV2X2RhdGEtPmxpc3QpOw0KPiAtCWNsZWFyX2R0ZV9lbnRy
eShkZXZfZGF0YS0+ZGV2aWQpOw0KPiAtCWlmIChhbGlhcyAhPSBkZXZfZGF0YS0+ZGV2aWQpDQo+
IC0JCWNsZWFyX2R0ZV9lbnRyeShhbGlhcyk7DQo+ICAgDQo+ICsJY2xlYXJfZHRlX2VudHJ5KGRl
dl9kYXRhLT5kZXZpZCk7DQo+ICAgCS8qIEZsdXNoIHRoZSBEVEUgZW50cnkgKi8NCj4gICAJZGV2
aWNlX2ZsdXNoX2R0ZShkZXZfZGF0YSk7DQo+ICsNCj4gKwlpZiAoYWxpYXMgIT0gZGV2X2RhdGEt
PmRldmlkKSB7DQo+ICsJCWNsZWFyX2R0ZV9lbnRyeShhbGlhcyk7DQo+ICsJCS8qIEZsdXNoIHRo
ZSBBbGlhcyBEVEUgZW50cnkgKi8NCj4gKwkJZGV2aWNlX2ZsdXNoX2R0ZShhbGlhcyk7DQo+ICsJ
fQ0KPiArDQo+ICsJLyogRmx1c2ggSU9UTEIgKi8NCj4gKwlkb21haW5fZmx1c2hfdGxiX3BkZShk
b21haW4pOw0KPiArDQo+ICsJLyogV2FpdCBmb3IgdGhlIGZsdXNoZXMgdG8gZmluaXNoICovDQo+
ICsJZG9tYWluX2ZsdXNoX2NvbXBsZXRlKGRvbWFpbik7DQo+ICsNCj4gKwkvKiBkZWNyZWFzZSBy
ZWZlcmVuY2UgY291bnRlcnMgLSBuZWVkcyB0byBoYXBwZW4gYWZ0ZXIgdGhlIGZsdXNoZXMgKi8N
Cj4gKwlkb21haW4tPmRldl9pb21tdVtpb21tdS0+aW5kZXhdIC09IDE7DQo+ICsJZG9tYWluLT5k
ZXZfY250ICAgICAgICAgICAgICAgICAtPSAxOw0KPiAgIH0NCg0KSSBoYXZlIGFsc28gY29uc2lk
ZXJlZCB0aGlzLiBUaGlzIHdvdWxkIGFsc28gd29yay4gQnV0IHNpbmNlIHdlIGFyZSBhbHJlYWR5
DQpkb2luZyBwYWdlIGZsdXNoZXMgZHVyaW5nIHBhZ2UgdW5tYXBwaW5nIGxhdGVyIG9uIGFmdGVy
IGFsbCBkZXZpY2VzIGFyZSBkZXRhY2hlZC4NClNvLCB3b3VsZCB0aGlzIGJlIG5lY2Vzc2FyeT8g
UGxlYXNlIHNlZSB2ZmlvX2lvbW11X3R5cGUxX2RldGFjaF9ncm91cCgpLg0KDQpBbHNvLCBpZiB3
ZSBjb25zaWRlciB0aGUgY2FzZSB3aGVyZSB0aGVyZSBhcmUgbW9yZSB0aGFuIG9uZSBkZXZpY2Vz
IHNoYXJpbmcNCnRoZSBkb21haW4uIFRoaXMgd291bGQgaXNzdWUgcGFnZSBmbHVzaCBldmVyeSB0
aW1lIHdlIGRldGFjaCBhIGRldmljZSwNCmFuZCB3aGlsZSBvdGhlciBkZXZpY2VzIHN0aWxsIGF0
dGFjaGVkIHRvIHRoZSBkb21haW4uDQoNClJlZ2FyZHMsDQpTdXJhdmVlDQoNCg==
