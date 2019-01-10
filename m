Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F2CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD3D2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ClRwzP0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfAJIEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:04:55 -0500
Received: from mail-eopbgr800044.outbound.protection.outlook.com ([40.107.80.44]:12829
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727401AbfAJIEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKyu5UH75e1dO/f0+MGJarVpNispPljzMPGWkDvS3Io=;
 b=ClRwzP0xJHqRdQtJva/O3XRvJkLovJWlv3RymaieuGGqDggTAYSf6GsFrKDEii0zKmeOTzT6LvS6+dH9sOR+j8KQb5Rtv4WduZrG2LXwc39MakjNHNPdNZGeSz2SKR0Ynv4tSQjKocLc3s2IyLHYDGell4+nt2T6XpCz0OrN6uY=
Received: from BYAPR12MB3237.namprd12.prod.outlook.com (20.179.93.25) by
 BYAPR12MB2920.namprd12.prod.outlook.com (20.179.91.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 10 Jan 2019 08:04:49 +0000
Received: from BYAPR12MB3237.namprd12.prod.outlook.com
 ([fe80::a96e:ffd:3bd6:c5f5]) by BYAPR12MB3237.namprd12.prod.outlook.com
 ([fe80::a96e:ffd:3bd6:c5f5%4]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 08:04:49 +0000
From:   S@vger.kernel.org
To:     Borislav Petkov <bp@alien8.de>, "S, Shirish" <Shirish.S@amd.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list : X86 ARCHITECTURE" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/mce/amd: Ensure quirks are applied in resume path
 as well
Thread-Topic: [PATCH 2/2] x86/mce/amd: Ensure quirks are applied in resume
 path as well
Thread-Index: AQHUpnT6RX1zZkZcBk29IptIsRwq2qWngtqAgACqJYA=
Date:   Thu, 10 Jan 2019 08:04:49 +0000
Message-ID: <7a9227c0-1bc3-67c5-14a8-a40d186a5ef8@amd.com>
References: <1546857399-2926-1-git-send-email-shirish.s@amd.com>
 <1546857399-2926-3-git-send-email-shirish.s@amd.com>
 <20190109220843.GK15665@zn.tnic>
In-Reply-To: <20190109220843.GK15665@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::20) To BYAPR12MB3237.namprd12.prod.outlook.com
 (2603:10b6:a03:136::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shirish.S@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [202.56.249.162]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2920;20:acdEFZWZpng1aDu4548Nzarnitk/7vLO6R6CM9pSIrGdha0SxCnttSW/lyYtLWmk6UjQpR7sZWR7XfDp1ZOkNwzVAbq0BdJp49E75PsN9bel9S69lOrfT8WHi84kK3AsiyoELaA8YmyUdas+ATRfpI9Pns3NeWM34R+LkMy6qKGXI15CKH5Oe9pFrRySf8E9BTJM6coZ3aIY27iiR168v4+iB3IwD1c9stWBBRmVLdLFuCdpTWO3wWa2D52GDdlj
x-ms-office365-filtering-correlation-id: bf370542-4e25-4c38-8589-08d676d24af7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2920;
x-ms-traffictypediagnostic: BYAPR12MB2920:
x-microsoft-antispam-prvs: <BYAPR12MB292035A6C4B0954FB402EAC3F2840@BYAPR12MB2920.namprd12.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(136003)(346002)(39860400002)(199004)(189003)(71190400001)(31686004)(81166006)(6506007)(8936002)(5660300001)(478600001)(25786009)(53936002)(76176011)(316002)(71200400001)(81156014)(486006)(4326008)(2616005)(106356001)(11346002)(72206003)(6436002)(476003)(256004)(2906002)(6636002)(14444005)(446003)(966005)(6512007)(97736004)(6306002)(105586002)(7736002)(229853002)(54906003)(102836004)(66066001)(31696002)(6246003)(110136005)(36756003)(99286004)(6116002)(3846002)(53546011)(8676002)(52116002)(6486002)(305945005)(26005)(186003)(68736007)(386003)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2920;H:BYAPR12MB3237.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pll+vhEA03rgLGIl1YbOSxe9H5uGaegm/fhlakcAOazxh4xaw1Wvv97omchaDVaUiKus5Aii7oB5P2NGZfaTGK6RdKfK0UXFD0ariXnAZSr2Voa3NQ5DzEpEV4qZ5O7p2tsPp3TY2NTq+7H4FoNARVGZZFAfNHCA82rd8oO+XHK3yGnWj7Q/aypCARmDc8MNXGPOdsVywvzWLGB3PjgMk47ZgLSqVmUlKyHy52xnyaojvjudK2evmevIWpydV9cknryRryNld4w8sWj+zHgUQUtLbTmlr5bLeeWmf/RVHKvqrgkdXqeyj1IEE/9dOuBT
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <035DC0AFD25463429A3178C48F42476C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf370542-4e25-4c38-8589-08d676d24af7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 08:04:49.4167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2920
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXNsYXYsDQoNCk9uIDEvMTAvMjAxOSAzOjM4IEFNLCBCb3Jpc2xhdiBQZXRrb3Ygd3Jv
dGU6DQo+IE9uIE1vbiwgSmFuIDA3LCAyMDE5IGF0IDEwOjM3OjI0QU0gKzAwMDAsIFMsIFNoaXJp
c2ggd3JvdGU6DQo+PiBUaGlzIHBhdGNoIGFkZHMgdGhyZXNob2xkIHF1aXJrIGFwcGxpY2FibGUg
Zm9yIGZhbWlseSAxNQ0KPiBTYW1lIGlzc3VlIHdpdGggIlRoaXMgcGF0Y2giIGhlcmUuDQpBZ3Jl
ZSwgaGF2ZSBhdm9pZGVkIHRoZSBwaHJhc2UgaW4gYm90aCBwYXRjaGVzIHRoYXQgb3JpZ2luYXRl
IGZyb20gdGhpcyANCmRpc2N1c3Npb24uDQo+DQo+PiBpbiByZXN1bWUgcGF0aCBhcyB3ZWxsLCBz
aW5jZSBtY2VfYW1kX2ZlYXR1cmVfaW5pdCgpDQo+PiBkb2VzIG5vdCBoYXZlIHF1aXJrcyBhcHBs
aWVkIHdoZW4gb3JpZ2luYXRpbmcgZnJvbSBtY2Vfc3lzY29yZV9yZXN1bWUoKSwNCj4+IHJlc3Vs
dGluZyBpbiB0aGUgYmVsb3cgbWVzc2FnZSBhdCBldmVyeSBzdWNjZXNzZnVsIHJlc3VtZToNCj4+
DQo+PiAiW0Zpcm13YXJlIEJ1Z106IGNwdSAwLCBpbnZhbGlkIHRocmVzaG9sZCBpbnRlcnJ1cHQg
b2Zmc2V0IC4uLiINCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTaGlyaXNoIFMgPHNoaXJpc2guc0Bh
bWQuY29tPg0KPj4gLS0tDQo+PiAgIGFyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FtZC5jIHwgMzQg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwg
MzQgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1
L21jZS9hbWQuYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FtZC5jDQo+PiBpbmRleCA4OTI5
OGM4Li4yN2NiZjY2IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvYW1k
LmMNCj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FtZC5jDQo+PiBAQCAtNTQ1LDYg
KzU0NSwzNCBAQCBwcmVwYXJlX3RocmVzaG9sZF9ibG9jayh1bnNpZ25lZCBpbnQgYmFuaywgdW5z
aWduZWQgaW50IGJsb2NrLCB1MzIgYWRkciwNCj4+ICAgCXJldHVybiBvZmZzZXQ7DQo+PiAgIH0N
Cj4+ICAgDQo+PiArdm9pZCBkaXNhYmxlX2Vycl90aHJlc2hvbGRpbmcoc3RydWN0IGNwdWluZm9f
eDg2ICpjKQ0KPj4gK3sNCj4+ICsJaW50IGk7DQo+PiArCXU2NCBod2NyOw0KPj4gKwlib29sIG5l
ZWRfdG9nZ2xlOw0KPj4gKwl1MzIgbXNyc1tdID0gew0KPj4gKwkJMHgwMDAwMDQxMywgLyogTUM0
X01JU0MwICovDQo+PiArCQkweGMwMDAwNDA4LCAvKiBNQzRfTUlTQzEgKi8NCj4+ICsJfTsNCj4+
ICsNCj4+ICsJaWYgKGMtPng4Nl9tb2RlbCA+PSAweDEwICYmIGMtPng4Nl9tb2RlbCA8PSAweDdm
KSB7DQo+IFlvdSBjYW4gc2F2ZSB5b3Vyc2VsZiBhbiBpbmRlbnRhdGlvbiBsZXZlbCBieSByZXZl
cnNpbmcgdGhlIGxvZ2ljIGhlcmU6DQo+DQo+IAlpZiAoYy0+eDg2ICE9IDB4MTUpDQo+IAkJcmV0
dXJuOw0KPg0KPiBBbHNvLCBJJ20gd29uZGVyaW5nIGlmIHlvdSBzaW1wbHkgY2FuJ3QgZG8NCj4N
Cj4gCWlmIChjLT54ODZfbW9kZWwgPCAweDEwKQ0KPiAJCXJldHVybjsNCj4NCj4gVGhlIGFzc3Vt
cHRpb24gYmVpbmcgdGhhdCBhbGwgdGhlIG1vZGVscyAtIGV2ZW4gYWZ0ZXIgMHg3ZiAtIGFyZSBo
aWdobHkNCj4gdW5saWtlbHkgdG8gZ2V0IE1DNF9NSVNDIHRocmVzaG9sZGluZyBzdXBwb3J0ZWQs
IGFsbCBvZiBhIHN1ZGRlbi4gTWlnaHQNCj4gd2FubmEgcnVuIGl0IGJ5IEhXIGd1eXMgZmlyc3Qg
dGhvdWdoLg0KDQpQZXJoYXBzIG5vIG5lZWQgdG8gY2hlY2sgdGhlIG1vZGVsIGFsdG9nZXRoZXIs
IHRoaXMgaXMgYXBwbGljYWJsZSB0byANCmVudGlyZSBmYW1pbHkgMTUsIHNpbmNlIHRoZXJlIGlz
IG5vIDh0aCBHZW4uDQoNCj4NCj4+ICsJCXJkbXNybChNU1JfSzdfSFdDUiwgaHdjcik7DQo+PiAr
DQo+PiArCQkvKiBNY1N0YXR1c1dyRW4gaGFzIHRvIGJlIHNldCAqLw0KPj4gKwkJbmVlZF90b2dn
bGUgPSAhKGh3Y3IgJiBCSVQoMTgpKTsNCj4+ICsNCj4+ICsJCWlmIChuZWVkX3RvZ2dsZSkNCj4+
ICsJCQl3cm1zcmwoTVNSX0s3X0hXQ1IsIGh3Y3IgfCBCSVQoMTgpKTsNCj4+ICsNCj4+ICsJCS8q
IENsZWFyIENudFAgYml0IHNhZmVseSAqLw0KPj4gKwkJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJ
WkUobXNycyk7IGkrKykNCj4+ICsJCQltc3JfY2xlYXJfYml0KG1zcnNbaV0sIDYyKTsNCj4+ICsN
Cj4+ICsJCS8qIHJlc3RvcmUgb2xkIHNldHRpbmdzICovDQo+PiArCQlpZiAobmVlZF90b2dnbGUp
DQo+PiArCQkJd3Jtc3JsKE1TUl9LN19IV0NSLCBod2NyKTsNCj4+ICsJfQ0KPiBTbyB5b3UgY29w
aWVkIHRoZSBzYW1lIGNvZGUgZnJvbSBfX21jaGVja19jcHVfYXBwbHlfcXVpcmtzKCkuDQo+DQo+
IE5vLg0KPg0KPiBJbiBhIGZpcnN0IHBhdGNoLCB5b3UgY2FydmUgdGhhdCBDbnRQIGNsZWFyaW5n
IGNvZGUgaW4gYSBzZXBhcmF0ZQ0KPiBmdW5jdGlvbiBkaXNhYmxlX2Vycl90aHJlc2hvbGRpbmco
KSBsaWtlIHlvdSd2ZSBkb25lIGJlZm9yZS4NCkFncmVlLCBmaXJzdCBwYXRjaCBoZXJlOsKgIGh0
dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5LzEvMTAvNzANCj4gVGhlbiwgaW4gYSBzZWNvbmQgcGF0
Y2gsIHlvdSBjYWxsIGl0IGZyb20gbWNlL2FtZC5jIGFuZCB5b3UgbW92ZSBhbGwgdGhlDQo+IGZh
bWlseS9tb2RlbCBjaGVja3MgaW5zaWRlIHRoZSBmdW5jdGlvbiBzbyB0aGF0IHlvdSBoYXZlIGEg
c29sZQ0KPg0KPiAJZGlzYWJsZV9lcnJfdGhyZXNob2xkaW5nKCk7DQo+DQo+IGNhbGxzIHdoZXJl
IHlvdSBuZWVkIHRoZW0uDQo+DQo+IFlvdSBkb24ndCBoYXZlIHRvIHBhc3MgaW4gc3RydWN0IGNw
dWluZm9feDg2ICpjIC0geW91IGNhbiB1c2UNCj4gYm9vdF9jcHVfZGF0YSBpbiB0aGUgZnVuY3Rp
b24uDQpBZ3JlZSwgc2Vjb25kIHBhdGNoIGhlcmU6IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5
LzEvMTAvNzINCj4NCj4+ICt9DQo+PiAgIC8qIGNwdSBpbml0IGVudHJ5IHBvaW50LCBjYWxsZWQg
ZnJvbSBtY2UuYyB3aXRoIHByZWVtcHQgb2ZmICovDQo+PiAgIHZvaWQgbWNlX2FtZF9mZWF0dXJl
X2luaXQoc3RydWN0IGNwdWluZm9feDg2ICpjKQ0KPj4gICB7DQo+PiBAQCAtNTUyLDYgKzU4MCwx
MiBAQCB2b2lkIG1jZV9hbWRfZmVhdHVyZV9pbml0KHN0cnVjdCBjcHVpbmZvX3g4NiAqYykNCj4+
ICAgCXVuc2lnbmVkIGludCBiYW5rLCBibG9jaywgY3B1ID0gc21wX3Byb2Nlc3Nvcl9pZCgpOw0K
Pj4gICAJaW50IG9mZnNldCA9IC0xOw0KPj4gICANCj4+ICsJLyogRGlzYWJsZSBlcnJvciB0aHJl
c2hvbGRpbmcgYmFuayBpbiBTMyByZXN1bWUgcGF0aCBhcyB3ZWxsLA0KPiBXaGF0IFMzIHJlc3Vt
ZSBwYXRoPyBUaGF0J3MgdGhlIENQVSBpbml0IHBhdGguDQoNCkkgaGF2ZSBhbHNvIHB1dCBpbiB0
aGUgY29tbWl0IG1lc3NhZ2UsIGJ1dCBmb3IgZGlzY3Vzc2lvbiBzYWtlLCB0aGVyZSANCmFyZSAy
IGNvZGUgcGF0aHMgbGVhZGluZyB0byBtY2VfYW1kX2ZlYXR1cmVfaW5pdCgpIGFzIGJlbG93Lg0K
MSkgUzUgLT4gUzA6IChib290KQ0Kc2Vjb25kYXJ5X3N0YXJ0dXBfNjQgLT4gc3RhcnRfa2VybmVs
IC0+IGlkZW50aWZ5X2Jvb3RfY3B1IC0+DQppZGVudGlmeV9jcHUgLT4NCm1jaGVja19jcHVfaW5p
dCAoY2FsbHPCoCBfX21jaGVja19jcHVfYXBwbHlfcXVpcmtzIGJlZm9yZSkgLT4NCm1jZV9hbWRf
ZmVhdHVyZV9pbml0DQoNCjIpIFMzIC0+IFMwOiAocmVzdW1lKQ0Kc3lzY29yZV9yZXN1bWUgLT4g
bWNlX3N5c2NvcmVfcmVzdW1lIC0+IG1jZV9hbWRfZmVhdHVyZV9pbml0DQoNCkkgaGF2ZSBzdW1t
YXJpemVkIHRoaXMgc2VxdWVuY2UgYWZ0ZXIgY2FwdHVyaW5nIHRoZSBjYWxsIHRyYWNlIGluIGJv
dGggDQpzY2VuYXJpb3MuDQoNCkl0cyBjbGVhciB0aGF0IHRoZSBxdWlya3MgYXJlIG5vdCBhcHBs
aWVkIGR1cmluZyBTMy0+IFMwIHRyYW5zaXRpb24sIA0KaGVuY2UgdGhlIHBhdGNoLg0KDQpJIGNh
bm5vdCBtb3ZlIHRoZSBxdWlyayB0byBtY2VfYW1kX2ZlYXR1cmVfaW5pdCgpIHNpbmNlIGFtZC5j
IGlzIGd1YXJkZWQgDQpieSBDT05GSUdfWDg2X01DRV9BTUQgYW5kIHRoZSBxdWlyayBzaG91bGQg
YmUgYXBwbGljYWJsZSBpbiBjYXNlIHRoZSANCmNvbmZpZyBpcyBvZmYgdmlhDQoNCl9fbWNoZWNr
X2NwdV9hcHBseV9xdWlya3MoKSBhdCBib290Lg0KDQo+IEFsc28sIGtlcm5lbCBjb21tZW50cyBz
dHlsZSBpczoNCj4NCj4gCS8qDQo+IAkgKiBBIHNlbnRlbmNlIGVuZGluZyB3aXRoIGEgZnVsbC1z
dG9wLg0KPiAJICogQW5vdGhlciBzZW50ZW5jZS4gLi4uDQo+IAkgKiBNb3JlIHNlbnRlbmNlcy4g
Li4uDQo+IAkgKi8NCj4NCkFncmVlLCBmb2xsb3dlZCBpdCBpbiB0aGUgYWJvdmUgbWVudGlvbmVk
IHBhdGNoZXMuDQoNClRoYW5rcy4NCg0KUmVnYXJkcywNCg0KU2hpcmlzaCBTDQoNCj4gR29vZCBs
dWNrIQ0KPg0KPiA6LSkNCj4NCi0tIA0KUmVnYXJkcywNClNoaXJpc2ggUw0KDQo=
