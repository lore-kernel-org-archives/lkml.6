Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DDEC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE6C20844
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BtGMrppi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfBABLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 20:11:34 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:1291 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbfBABLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 20:11:33 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c539cc40000>; Fri, 01 Feb 2019 09:11:32 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 31 Jan 2019 17:11:30 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 31 Jan 2019 17:11:30 -0800
Received: from DRBGMAIL102.nvidia.com (10.18.16.21) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 01:11:28 +0000
Received: from HKMAIL104.nvidia.com (10.18.16.13) by DRBGMAIL102.nvidia.com
 (10.18.16.21) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 01:11:27 +0000
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.53) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 1 Feb 2019 01:11:27 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3528.namprd12.prod.outlook.com (20.179.94.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Fri, 1 Feb 2019 01:11:06 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1580.019; Fri, 1 Feb 2019
 01:11:06 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V8 3/5] i2c: tegra: Add DMA Support
Thread-Topic: [PATCH V8 3/5] i2c: tegra: Add DMA Support
Thread-Index: AQHUuSyS8D4y2PEYbkigLw9+iOz1C6XJUwmAgADLhYCAAAH90A==
Date:   Fri, 1 Feb 2019 01:11:06 +0000
Message-ID: <BYAPR12MB33986DDF4267ED1F499317B0C2920@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548915387-28826-1-git-send-email-skomatineni@nvidia.com>
        <1548915387-28826-3-git-send-email-skomatineni@nvidia.com>
        <20190131124423.GG23438@ulmo> <20190201035249.5b1cdfe2@dimatab>
In-Reply-To: <20190201035249.5b1cdfe2@dimatab>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3528;6:/5ACWmsxCAiDo3p3zTUDJQqtmdhdzBKO2rbjMojV3eH2RRSPyTpVJwYURJGI2Muq0oa5Sx6mhsYtZ2xIXiwJX319ytVtCT8iYaMVKPu7M4yppdJSN9tVBNebVAdA20fmF4tRtG0uj/FN2iMJvCHbmtdh7a1BnY1XbVVrYlRgBGgGK401F+/9+odX2Lz5Mge+uJ3Kr/F6I8TF+70CUaIakvkRH2iE4DX1zphmOtZ3nigOU3Hbq791iNGe5Lk5ni/jNPYykcHoAjTL4V9SvsoPdBM+iG/HU274tFQKwRf/aDQtagkWjaviXBv3bzMpnXSnn61mV7QGOnSeF+5TOgzh26VVPGlQ4WL98QdzlImnlZoj4SXeQZFkUkPgm7Zx6Yh/JwxSXgECRNYcAmzipidlacMfSlRV/Ht0S2EtpTyapS86aZgLgBRWkXNo6gblDeCI7f07dZi4DU99IlIjUw6Eaw==;5:23f0HMubyOARWHSMfkPr+ya7bKlsklhhf0TpERRPKUIGfSTfwCmHkAkAoKBhefqLuunKQYOXgQB+/MdHYtVbUho+7dQYDRx6UpdAITrLvlv+vSAdtmhtrUEOIYHXjAD044u9ClanLOFPo6OnlEiH+xmKGU5Bcu4lVnOeIFl2ye5sZpvvXsGsHA33AMwI1Gi5azM1kstkDhHqRU3bRlNMzw==;7:hVI9vNQtEE8YsJ7OR5wJFzSCLgK3iRpXDBSONXkULTqGk7P6KxbRy4HAJNXApW+Tr+a9qjSRd0wmZ+S82PsXH3SQmo3WPeBbc5Zl6L5Fhd34erhCjWPLidHK8drbHdJ0DbgiLHdHjQ2PhYDpssGAQg==
x-ms-office365-filtering-correlation-id: 9f8b3733-0495-4e45-f8ad-08d687e22484
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3528;
x-ms-traffictypediagnostic: BYAPR12MB3528:
x-microsoft-antispam-prvs: <BYAPR12MB352849EBD2BA8644D308974CC2920@BYAPR12MB3528.namprd12.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(366004)(376002)(39850400004)(189003)(199004)(51444003)(4326008)(39060400002)(66066001)(478600001)(14454004)(7696005)(2906002)(74316002)(81166006)(81156014)(8676002)(86362001)(316002)(229853002)(110136005)(7736002)(54906003)(305945005)(25786009)(8936002)(68736007)(6436002)(97736004)(476003)(71200400001)(71190400001)(11346002)(446003)(102836004)(486006)(106356001)(99286004)(26005)(33656002)(186003)(6506007)(55016002)(9686003)(14444005)(53936002)(256004)(3846002)(6116002)(105586002)(93886005)(76176011)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3528;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NmaAR5sXAbUlZcSej6LlzOZuyFVJCJujyw7PARUKMK6xAeOTlk39snY8UdrRYQHZpE8s4ITCVmL37IWk2rFQRX73BAM8dfgWKVJQsvs9ZLmfaHwYPT7tJkV8G39GsIsvcb+2wCXywhh1XHwiD6Qf0IyWrqINSzs21AzzRUb2rDYh4z7sJ4xmrK1scFk+ioOtc5MTlha9xBjb42iCiaZLCMvZDj3fXHYIgnSB/MfNh0i05yussHJ1i984mNKE3iW7KSAVtbqh6EP4Etrp8c6OH7qtSkGVkiZhRESvzO5G2ARk5bt+EnCm3vRVwi42mRUAo4R6R+5TluT552WUCRi0MttGNkOPn9romHrfHkFpROK/aCjR80E20OI16r7tcMHFj6qzW+LxAwOIFxgePg9sprLLbAwRswNd3zzf6SDVOjY=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8b3733-0495-4e45-f8ad-08d687e22484
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 01:11:06.2945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3528
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548983492; bh=vJPByfL3fvLDYBvLqGvvJb36bI/9mgqEzPZjNTQMn14=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=BtGMrppiRYibQ4wu9R5HJZQi3+FxGndEzYeRyCQAEJwzmq/J6G22IT67wALcdYDMR
         jRYVEOACUK8YhlFDy3LgsQ/44WEiOpS+eo6wVJ88LYUI4dOYyso7MYFkKqPJvsSDPA
         88NRmRwP0VZ9UUQl2xOnU3xXizdp1dRirVQAqNs3g+av5aR2UpVrCcLqWq9/Ye+75I
         G495j+3EwvGDmsKaA7IJIcrygMLB/foJp/E1ITTHgj83r280LbF4tq6+5d90rA37Au
         /2GbznOFg4yEA3vkOvuIKkGZNPDHJNVMPclArxcVL/ui3NLvs3bjA0L0S7aultzG6o
         UcPFhYUe2hEXw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gKwlpZiAoZG1hKSB7DQo+ID4gPiArCQlpZiAoaTJjX2Rldi0+bXNnX3JlYWQpIHsNCj4g
PiA+ICsJCQljaGFuID0gaTJjX2Rldi0+cnhfZG1hX2NoYW47DQo+ID4gPiArCQkJdGVncmFfaTJj
X2NvbmZpZ19maWZvX3RyaWcoaTJjX2RldiwNCj4gPiA+IHhmZXJfc2l6ZSwNCj4gPiA+ICsNCj4g
PiA+IERBVEFfRE1BX0RJUl9SWCk7DQo+ID4gPiArCQkJZG1hX3N5bmNfc2luZ2xlX2Zvcl9kZXZp
Y2UoaTJjX2Rldi0+ZGV2LA0KPiA+ID4gKw0KPiA+ID4gaTJjX2Rldi0+ZG1hX3BoeXMsDQo+ID4g
PiArCQkJCQkJICAgeGZlcl9zaXplLA0KPiA+ID4gKw0KPiA+ID4gRE1BX0ZST01fREVWSUNFKTsN
Cj4gPiANCj4gPiBEbyB3ZSByZWFsbHkgbmVlZCB0aGlzPyBXZSdyZSBub3QgYWN0dWFsbHkgcGFz
c2luZyB0aGUgZGV2aWNlIGFueSANCj4gPiBkYXRhLCBzbyBubyBjYWNoZXMgdG8gZmx1c2ggaGVy
ZS4gSSB3ZSdyZSBjYXV0aW91cyBhYm91dCBmbHVzaGluZyANCj4gPiBjYWNoZXMgd2hlbiB3ZSBk
byB3cml0ZSB0byB0aGUgYnVmZmVyIChhbmQgSSB0aGluayB3ZSBkbyB0aGF0IHByb3Blcmx5IA0K
PiA+IGFscmVhZHkpLCB0aGVuIHRoZXJlIHNob3VsZCBiZSBubyBuZWVkIHRvIGRvIGl0IGhlcmUg
YWdhaW4uDQo+ID4gDQo+DQo+IElJVUMsIERNQSBBUEkgaGFzIGEgY29uY2VwdCBvZiBidWZmZXIg
aGFuZGluZyB3aGljaCB0ZWxscyB0byB1c2UNCmRtYV9zeW5jX3NpbmdsZV9mb3JfZGV2aWNlKCkg
YmVmb3JlIGlzc3VpbmcgaGFyZHdhcmUgam9iIHRoYXQgdG91Y2hlcyB0aGUgYnVmZmVyIGFuZCB0
byB1c2UgZG1hX3N5bmNfc2luZ2xlX2Zvcl9jcHUoKSBhZnRlciBoYXJkd2FyZSBkb25lIHRoZSBl
eGVjdXRpb24uIEluIGZhY3QgdGhlIENQVSBjYWNoZXMgYXJlIGdldHRpbmcgZmx1c2hlZCBvciBp
bnZhbGlkYXRlZCBhcyBhcHByb3ByaWF0ZSBpbiBhIHJlc3VsdC4NCj4NCj4gZG1hX3N5bmNfc2lu
Z2xlX2Zvcl9kZXZpY2UoRE1BX0ZST01fREVWSUNFKSBpbnZhbGlkYXRlcyBidWZmZXIgaW4gdGhl
IENQVSBjYWNoZSwgcHJvYmFibHkgdG8gYXZvaWQgQ1BVIGV2aWN0aW5nIGRhdGEgZnJvbSBjYWNo
ZSB0byBEUkFNIHdoaWxlIGhhcmR3YXJlIHdyaXRlcyB0byB0aGUgYnVmZmVyLiBIZW5jZSB0aGlz
IGh1bmsgaXMgY29ycmVjdC4NCj4NCj4gPiA+ICsJCQllcnIgPSB0ZWdyYV9pMmNfZG1hX3N1Ym1p
dChpMmNfZGV2LA0KPiA+ID4geGZlcl9zaXplKTsNCj4gPiA+ICsJCQlpZiAoZXJyIDwgMCkgew0K
PiA+ID4gKwkJCQlkZXZfZXJyKGkyY19kZXYtPmRldiwNCj4gPiA+ICsJCQkJCSJzdGFydGluZyBS
WCBETUEgZmFpbGVkLA0KPiA+ID4gZXJyICVkXG4iLA0KPiA+ID4gKwkJCQkJZXJyKTsNCj4gPiA+
ICsJCQkJZ290byB1bmxvY2s7DQo+ID4gPiArCQkJfQ0KPiA+ID4gKwkJfSBlbHNlIHsNCj4gPiA+
ICsJCQljaGFuID0gaTJjX2Rldi0+dHhfZG1hX2NoYW47DQo+ID4gPiArCQkJdGVncmFfaTJjX2Nv
bmZpZ19maWZvX3RyaWcoaTJjX2RldiwNCj4gPiA+IHhmZXJfc2l6ZSwNCj4gPiA+ICsNCj4gPiA+
IERBVEFfRE1BX0RJUl9UWCk7DQo+ID4gPiArCQkJZG1hX3N5bmNfc2luZ2xlX2Zvcl9jcHUoaTJj
X2Rldi0+ZGV2LA0KPiA+ID4gKwkJCQkJCWkyY19kZXYtPmRtYV9waHlzLA0KPiA+ID4gKwkJCQkJ
CXhmZXJfc2l6ZSwNCj4gPiA+ICsJCQkJCQlETUFfVE9fREVWSUNFKTsNCj4gPiANCj4gPiBUaGlz
LCBvbiB0aGUgb3RoZXIgaGFuZCBzZWVtcyBjb3JyZWN0IGJlY2F1c2Ugd2UgbmVlZCB0byBpbnZh
bGlkYXRlIA0KPiA+IHRoZSBjYWNoZXMgZm9yIHRoaXMgYnVmZmVyIHRvIG1ha2Ugc3VyZSB0aGUg
ZGF0YSB0aGF0IHdlIHB1dCB0aGVyZSANCj4gPiBkb2Vzbid0IGdldCBvdmVyd3JpdHRlbi4NCj4N
Cj4gQXMgSSBzdGF0ZWQgYmVmb3JlIGluIGEgY29tbWVudCB0byB2NiwgdGhpcyBwYXJ0aWN1bGFy
IGNhc2Ugb2YNCj4gZG1hX3N5bmNfc2luZ2xlX2Zvcl9jcHUoKSB1c2FnZSBpcyBpbmNvcnJlY3Qg
YmVjYXVzZSBDUFUgc2hvdWxkIHRha2Ugb3duZXJzaGlwIG9mIHRoZSBidWZmZXIgYWZ0ZXIgY29t
cGxldGlvbiBvZiBoYXJkd2F0ZSBqb2IuIEJ1dCBpbiBmYWN0DQo+IGRtYV9zeW5jX3NpbmdsZV9m
b3JfY3B1KERNQV9UT19ERVZJQ0UpIGlzIGEgTk8tT1AgYmVjYXVzZSBDUFUgZG9lc24ndCBuZWVk
IHRvIGZsdXNoIG9yIGludmFsaWRhdGUgYW55dGhpbmcgdG8gdGFrZSBvd25lcnNoaXAgb2YgdGhl
IGJ1ZmZlciBpZiBoYXJkd2FyZSBkaWQgYSByZWFkLW9ubHkgYWNjZXNzLg0KPg0KPiA+IA0KPiA+
ID4gKwlpZiAoIWkyY19kZXYtPm1zZ19yZWFkKSB7DQo+ID4gPiArCQlpZiAoZG1hKSB7DQo+ID4g
PiArCQkJbWVtY3B5KGJ1ZmZlciwgbXNnLT5idWYsIG1zZy0+bGVuKTsNCj4gPiA+ICsJCQlkbWFf
c3luY19zaW5nbGVfZm9yX2RldmljZShpMmNfZGV2LT5kZXYsDQo+ID4gPiArDQo+ID4gPiBpMmNf
ZGV2LT5kbWFfcGh5cywNCj4gPiA+ICsJCQkJCQkgICB4ZmVyX3NpemUsDQo+ID4gPiArDQo+ID4g
PiBETUFfVE9fREVWSUNFKTsNCj4gPiANCj4gPiBBZ2FpbiwgaGVyZSB3ZSBwcm9wZXJseSBmbHVz
aCB0aGUgY2FjaGVzIHRvIG1ha2Ugc3VyZSB0aGUgZGF0YSB0aGF0IA0KPiA+IHdlJ3ZlIHdyaXR0
ZW4gdG8gdGhlIERNQSBidWZmZXIgaXMgdmlzaWJsZSB0byB0aGUgRE1BIGVuZ2luZS4NCj4gPiAN
Cj4NCj4gKzEgdGhpcyBpcyBjb3JyZWN0DQo+DQo+DQo+DQo+ID4gPiArDQo+ID4gPiArCQlpZiAo
aTJjX2Rldi0+bXNnX3JlYWQpIHsNCj4gPiA+ICsJCQlpZiAobGlrZWx5KGkyY19kZXYtPm1zZ19l
cnIgPT0NCj4gPiA+IEkyQ19FUlJfTk9ORSkpIHsNCj4gPiA+ICsNCj4gPiA+IGRtYV9zeW5jX3Np
bmdsZV9mb3JfY3B1KGkyY19kZXYtPmRldiwNCj4gPiA+ICsNCj4gPiA+IGkyY19kZXYtPmRtYV9w
aHlzLA0KPiA+ID4gKwkJCQkJCQl4ZmVyX3NpemUsDQo+ID4gPiArDQo+ID4gPiBETUFfRlJPTV9E
RVZJQ0UpOw0KPiA+IA0KPiA+IEhlcmUgd2UgaW52YWxpZGF0ZSB0aGUgY2FjaGVzIHRvIG1ha2Ug
c3VyZSB3ZSBkb24ndCBnZXQgc3RhbGUgZGF0YSANCj4gPiB0aGF0IG1heSBiZSBpbiB0aGUgY2Fj
aGVzIGZvciBkYXRhIHRoYXQgd2UncmUgY29weWluZyBvdXQgb2YgdGhlIERNQSANCj4gPiBidWZm
ZXIuIEkgdGhpbmsgdGhhdCdzIGFib3V0IGFsbCB0aGUgY2FjaGUgbWFpbnRlbmFuY2UgdGhhdCB3
ZSByZWFsIA0KPiA+IG5lZWQuDQo+DQo+IENvcnJlY3QuDQo+DQo+IEFuZCB0ZWNobmljYWxseSBo
ZXJlIHNob3VsZCBiZSBkbWFfc3luY19zaW5nbGVfZm9yX2NwdShETUFfVE9fREVWSUNFKQ0KPiBm
b3IgdGhlIFRYLiBCdXQgYWdhaW4sIGl0J3MgYSBOTy1PUC4NCg0KSXMgbXkgYmVsb3cgdW5kZXJz
dGFuZGluZyBjb3JyZWN0PyBDYW4geW91IHBsZWFzZSBjb25maXJtPw0KDQpEdXJpbmcgVHJhbnNt
aXQgdG8gZGV2aWNlOg0KLSBCZWZvcmUgd3JpdGluZyBtc2cgZGF0YSBpbnRvIGRtYSBidWYgYnkg
Q1BVLCBnaXZpbmcgRE1BIG93bmVyc2hpcCB0byBDUFUNCglkbWFfc3luY19zaW5nbGVfZm9yX2Nw
dSB3aXRoIGRpciBETUFfVE9fREVWSUNFDQoNCi0gQWZ0ZXIgd3JpdGluZyB0byBkbWEgYnVmIGJ5
IENQVSwgZ2l2aW5nIGJhY2sgdGhlIG93bmVyc2hpcCB0byBkZXZpY2UgdG8gYWNjZXNzIGJ1ZmZl
ciB0byBzZW5kIGR1cmluZyBETUEgdHJhbnNtaXQNCglkbWFfc3luY19zaW5nbGVfZm9yX2Rldmlj
ZSB3aXRoIGRpciBETUFfVE9fREVWSUNFDQoNCkR1cmluZyBSZWNlaXZpbmcgZnJvbSBEZXZpY2U6
DQotIGJlZm9yZSBzdWJtaXR0aW5nIFJYIERNQSB0byBnaXZlIGJ1ZmZlciBhY2Nlc3MgdG8gRE1B
ZW5naW5lDQoJZG1hX3N5bmNfc2luZ2xlX2Zvcl9EZXZpY2UoRE1BX0ZST01fREVWSUNFKSANCi0g
YWZ0ZXIgRE1BIFJYIGNvbXBsZXRpb24sIGdpdmluZyBkbWEgb3duZXJzaGlwIHRvIENQVSBmb3Ig
cmVhZGluZyBkbWFidWYgZGF0YSB3cml0dGVuIGJ5IERNQSBmcm9tIGRldmljZQ0KCWRtYV9zeW5j
X3NpbmdsZV9mb3JfY3B1IHdpdGggZGlyIERNQV9GUk9NX0RFVklDRQ0KDQo=
