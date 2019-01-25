Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456F7C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3DA218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lmO/lcOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbfAYX1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:27:07 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:30208 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbfAYX1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:27:07 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4b9b460000>; Sat, 26 Jan 2019 07:27:02 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 25 Jan 2019 15:27:02 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 25 Jan 2019 15:27:02 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 23:27:00 +0000
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.51) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 25 Jan 2019 23:27:00 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2598.namprd12.prod.outlook.com (20.176.255.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Fri, 25 Jan 2019 23:26:57 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064%5]) with mapi id 15.20.1558.021; Fri, 25 Jan 2019
 23:26:57 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
CC:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V2 2/4] i2c: tegra: Update I2C transfer using buffer
Thread-Topic: [PATCH V2 2/4] i2c: tegra: Update I2C transfer using buffer
Thread-Index: AQHUtCaqSMUv+qypUUWuTCZ/iDn5aKXAZ3CAgAAFD2CAABRTAIAAIJkAgAAAtXA=
Date:   Fri, 25 Jan 2019 23:26:57 +0000
Message-ID: <BYAPR12MB33983C7CAD44A6466E04241BC29B0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548363113-25969-1-git-send-email-skomatineni@nvidia.com>
 <1548363113-25969-2-git-send-email-skomatineni@nvidia.com>
 <185da588-1080-1589-46b6-5b63dff681eb@gmail.com>
 <BYAPR12MB33982FC612F99AC5CAE29EDBC29B0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <9b80cfc0-6cb4-a08e-ad78-2ce9bbea7036@gmail.com>
 <2a9c9637-c8af-f3ff-ff40-fc2a4b810846@gmail.com>
In-Reply-To: <2a9c9637-c8af-f3ff-ff40-fc2a4b810846@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2598;6:Y6BEULlyZvGxyzrFqb5eSvIlvL9avP4k/AtrXVlesxLd0tADlexkM8D1d1Q6faSt9ROlbuFRp/re+Mvzlga6w1OTSvib1HBDYZGGMtVn3bvAPyaX/DWDXaHcxoUo6D76Bko1VyDBWMO/9qJxUOMSQ9Uygsy63/DEieTwHSV+9gMm7WokJPbHgvNE1B/ZHf1g7NZxsSPEMYkzUmhFqAo7/AIwEYOmMWUEreWw3LnxunGYgSA5ekK55wjz6r7DUSmSerOq83HvM7Q2RhjeFkMlCJTq9u12IL+ZQ93AMZzU+EzQzK0HC0btsMZPUGPrsxX+eVnOQkNEJJ1iU1F1Yv+iJPYli0EZUtCWdIJWF0qw5jj5Jqr7KZhRUVTSRU4zGy2Ryil5YvZkzb8953uh7cAwZmYr7++GFDcbtAgsbxr6FDZ/bsl/mkHEJzFb/UkiRj4COHIeL55uz55kTe6QyH1GoA==;5:VHyfeHCpn18XMZfaQ3BXSaxAVzOjBKhh2KKntLdxAB9+4AwvxW3pOZdZ3nHM3H+mxzFivplGX7QRO5his7M5W3B049uMX9w9v+wj+R1A7WDR8lHKv2mvxPTs5yboSsMd0azmuixD8u5sKCphbuw6UQZy4MUSG7pmWr4GrtCEaCgXVRpn9F4LO3elAd4+sV8Hwvum4yIL0LJPcP6YQSZ1vA==;7:QUV9FR2qAMACqQlX3neUjUeluBJY4500MeP9Jck0itWK8ZpJgp5LdF/kH6s/PhbhM4cSeUWpchK1628MSHS8jU0SvslpK6BFGya/eNL4BsBKYFrRiAjqOTdUCBx1rPHyA4/x07warCBc4Dkmy7UmMw==
x-ms-office365-filtering-correlation-id: b99a6b54-e48f-40af-95b6-08d6831c9973
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2598;
x-ms-traffictypediagnostic: BYAPR12MB2598:
x-microsoft-antispam-prvs: <BYAPR12MB259868200ACC9B92F9670E94C29B0@BYAPR12MB2598.namprd12.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(346002)(376002)(189003)(199004)(2906002)(68736007)(6636002)(66066001)(26005)(3846002)(6116002)(6506007)(478600001)(14454004)(102836004)(186003)(256004)(4326008)(97736004)(6246003)(229853002)(6436002)(39060400002)(53936002)(55016002)(25786009)(9686003)(110136005)(8936002)(99286004)(76176011)(54906003)(71200400001)(81166006)(86362001)(316002)(8676002)(7696005)(71190400001)(2501003)(105586002)(446003)(11346002)(93886005)(305945005)(476003)(33656002)(74316002)(106356001)(486006)(7736002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2598;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oSqd0fzjGAc+BBhaU4YBJqxE80S+u6wk3LBh7WX37CMWaF2ymcb7Y7izqpncgFJme1FNYNcDC0YxIdGkfsXXGbjh74rWyfmrwwbthOke+Vk1/rS/+E2DBPjGtkX+jTsKk9UNRj1BbE+/j2Pwp5XxVYsoMQsYmSBMFEGwxt+a7hV+Uvvp/14kqG+EISJFpGFznUmO6H/AKsZX9HGQmjucJaL0FZrlBqZVJtnwYcTZcRL+MOTXRRpRmk0s/3SqFwkxgGkBfF9Sl5sEGgECr5H13Itb1EzyYDkjk5DBW0/ev4Evf8d2MtnQ/PKhH61Lz3zwzwyfGMPkHWa2MAewiKMRJHpfg1KgH++DpCQxfcdC9faj5iWmMzxb3DxMRNK7RJxi0TAM6GasSQxUdXBZXo+ojN3z1ygSCfsjbOMWeSyV+ls=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b99a6b54-e48f-40af-95b6-08d6831c9973
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 23:26:57.5235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2598
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548458822; bh=VBqWuI7gJuon2OZAvzRC3V6ZAg5gi0YsdpCDiBP/puo=;
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
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=lmO/lcOdo/oD18fes9SQcHJ7dJ9cJDT3jd1JlHRtRIXQ8h11m/R3BsmXUdj0yzU9B
         PRHfTalNXsgs/haSqzmhrhTdeHOebJXmZ6KVlB7JpyUupb0GboUX5vng8PuGFGgaRj
         DZPzm+LoJV2Sl1bDxtbVMnKnwY0FrvCFaskGdzmlwZyTYVe8MtQ+V4K1kn93pZLtQ+
         /5JWk1zHKphGCrdXQfgLV0Wgc8GgYY20Zpve6Se+vzz01MUqASVoRQD1OprYLBl6+y
         rBG2dwDF3Jm0xfxqD0osJkIv6sh0cAEU8K7+/wRsxYb3FIqXJQh7op76gskjY2W3lM
         P7nEEoM2o7kmA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4+Pj4gKwlidWZmZXIgPSBrbWFsbG9jKEFMSUdOKG1zZy0+bGVuLCBCWVRFU19QRVJfRklG
T19XT1JEKSArDQo+ID4+Pj4gKwkJCQkJSTJDX1BBQ0tFVF9IRUFERVJfU0laRSwgR0ZQX0tFUk5F
TCk7DQo+ID4+Pj4gKwlpZiAoIWJ1ZmZlcikNCj4gPj4+PiArCQlyZXR1cm4gLUVOT01FTTsNCj4g
Pj4+DQo+ID4+PiBJc24ndCBpdCBwb3NzaWJsZSB0byBhdm9pZCAiYnVmZmVyIiBhbGxvY2F0aW9u
IC8gY29weWluZyBvdmVyaGVhZCBhbmQga2VlcCBjb2RlIGFzLWlzIGZvciB0aGUgUElPIG1vZGU/
DQo+ID4+Pg0KPiA+Pg0KPiA+PiBLZWVwaW5nIFBJTyBtb2RlIGNvZGUgYXMgaXMgYW5kIGFkZGlu
ZyBETUEgbW9kZSB3aWxsIGhhdmUgcmVkdW5kYW50IGNvZGUgZm9yIGhlYWRlciBnZW5lcmF0aW9u
IGFuZCBtc2cgY29tcGxldGUgdGltZW91dCBzZWN0aW9ucy4NCj4gPj4gQWxzbyBpbiBleGlzdGlu
ZyBQSU8gbW9kZSBpbXBsZW1lbnRhdGlvbiwgVFggRklGTyBpcyBmaWxsZWQgYXMgc29vbiBhcyB0
aGUgd29yZCBpcyByZWFkeSBidXQgZm9yIERNQSBtb2RlIG5lZWQgdG8gcHV0IGFsbCBtc2cgYnl0
ZXMgYWxvbmcgd2l0aCBoZWFkZXIgdG9nZXRoZXIgdG8gc2VuZCB0aHJ1IERNQS4NCj4gPj4gU28g
Y3JlYXRlZCBjb21tb24gYnVmZmVyIHRvIHBlcmZvcm0gUElPL0RNQSB0byByZWR1Y2UgcmVkdW5k
YW5jeS4NCj4gPj4NCj4gPiANCj4gPiBPa2F5LCB3aGF0IGFib3V0IHNvbWV0aGluZyBsaWtlIGlu
IHRoaXMgc2tldGNoOg0KPiA+IA0KPiA+IC4uLg0KPiA+IAlpZiAobXNnLT5mbGFncyAmIEkyQ19N
X1JEKQ0KPiA+IAkJeGZlcl9zaXplID0gbXNnLT5sZW47DQo+ID4gCWVsc2UNCj4gPiAJCXhmZXJf
c2l6ZSA9IEFMSUdOKG1zZy0+bGVuLCBCWVRFU19QRVJfRklGT19XT1JEKSArDQo+ID4gCQkJICAg
IEkyQ19QQUNLRVRfSEVBREVSX1NJWkU7DQo+ID4gDQo+ID4gCWRtYSA9ICgoeGZlcl9zaXplID4g
STJDX1BJT19NT0RFX01BWF9MRU4pICYmDQo+ID4gCQlpMmNfZGV2LT50eF9kbWFfY2hhbiAmJiBp
MmNfZGV2LT5yeF9kbWFfY2hhbik7DQo+ID4gDQo+ID4gCWlmIChkbWEpIHsNCj4gPiAJCWJ1ZmZl
ciA9IGttYWxsb2MoQUxJR04obXNnLT5sZW4sIEJZVEVTX1BFUl9GSUZPX1dPUkQpICsNCj4gPiAJ
CQkJSTJDX1BBQ0tFVF9IRUFERVJfU0laRSwgR0ZQX0tFUk5FTCk7DQo+ID4gCQlpMmNfZGV2LT5t
c2dfYnVmID0gKHU4ICopYnVmZmVyOw0KPiA+IAl9DQo+ID4gDQo+ID4gCXBhY2tldF9oZWFkZXIg
PSAoMCA8PCBQQUNLRVRfSEVBREVSMF9IRUFERVJfU0laRV9TSElGVCkgfA0KPiA+IAkJCQlQQUNL
RVRfSEVBREVSMF9QUk9UT0NPTF9JMkMgfA0KPiA+IAkJCQkoaTJjX2Rldi0+Y29udF9pZCA8PCBQ
QUNLRVRfSEVBREVSMF9DT05UX0lEX1NISUZUKSB8DQo+ID4gCQkJCSgxIDw8IFBBQ0tFVF9IRUFE
RVIwX1BBQ0tFVF9JRF9TSElGVCk7DQo+ID4gCQlpMmNfd3JpdGVsKGkyY19kZXYsIHBhY2tldF9o
ZWFkZXIsIEkyQ19UWF9GSUZPKTsNCj4gPiANCj4gPiAJaWYgKGRtYSkNCj4gPiAJCSgqYnVmZmVy
KyspID0gcGFja2V0X2hlYWRlcjsNCj4gPiAJZWxzZQ0KPiA+IAkJaTJjX3dyaXRlbChpMmNfZGV2
LCBwYWNrZXRfaGVhZGVyLCBJMkNfVFhfRklGTyk7DQo+ID4gDQo+ID4gLi4uIGFuZCBzbyBvbi4N
Cj4gPiANCj4gPiBMaWtlbHkgdGhhdCBrbWFsbG9jIG92ZXJoZWFkIHdpbGwgYmUgYmlnZ2VyIHRo
YW4gdGhlIGFib3ZlIHZhcmlhbnQuIFBsZWFzZSBjb25zaWRlciB0byBhdm9pZCBrbWFsbG9jIGFu
ZCBjb3B5aW5nIGZvciB0aGUgUElPIGNhc2UgaW4gdGhlIG5leHQgdmVyc2lvbi4NCj4gPiANCj4N
Cj4gQWxzbywgaXMgdGhlIGludGVybWVkaWF0ZSBrbWFsbG9jICJidWZmZXIiIHJlYWxseSBuZWVk
ZWQgYXQgYWxsPyBXaHkganVzdCBub3QgdG8gd3JpdGUgZGlyZWN0bHkgaW50byB0aGUgRE1BIGJ1
ZmZlcj8NCg0KWWVzLCB0aGF04oCZcyB3aGF0IEkgYW0gdGhpbmtpbmcgdG9vLiBDaGFuZ2luZyBp
dC4gV2lsbCBzZW5kIHJldmlzZWQgcGF0Y2guLg0KDQo=
