Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6539EC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268AA20863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VzLOOLlu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbfBAUVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:21:48 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:34883 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731353AbfBAUVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 15:21:47 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c54aa590001>; Sat, 02 Feb 2019 04:21:45 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 01 Feb 2019 12:21:43 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 01 Feb 2019 12:21:43 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 20:21:41 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.52) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 1 Feb 2019 20:21:41 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3301.namprd12.prod.outlook.com (20.179.93.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.20; Fri, 1 Feb 2019 20:21:39 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1580.019; Fri, 1 Feb 2019
 20:21:39 +0000
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
Subject: RE: [PATCH V9 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V9 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUulC5gnNOlUi0AEWt0UGRYeTykqXLS2aAgAAWV5A=
Date:   Fri, 1 Feb 2019 20:21:39 +0000
Message-ID: <BYAPR12MB339865C0876E1BF7278DC7C8C2920@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549040867-18149-1-git-send-email-skomatineni@nvidia.com>
 <1549040867-18149-3-git-send-email-skomatineni@nvidia.com>
 <951cf1f5-ba3a-94ef-0399-2259effebc99@gmail.com>
In-Reply-To: <951cf1f5-ba3a-94ef-0399-2259effebc99@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3301;6:IbOUKjtwzhFA1HjbNpw8DmiArLl22yZu/rNt17K8BrpM2bj4Tsj7/FpmAlGQDMNLOHj2fbl8PxuPw3jiu+L31QxcfgCSzHGjB7c366+zSxnV28ZKd5zWn6KTYdGnxNmLr+GDDhn77wGUEyGUn7k7CZ+rxuNqpc6HxB51CQZWq/w8vyOv0dWd57wPce7ihAVnv42gVLHJ/+Ns4zo8S9MMuzCbO81UQHOYIx+QK6Q+awZABsSahSv9+Htxr+8qhLRWhiSIEciAsMgqUb2TovWYPohGV4A6taCXLtz5zabAWSOWQ6oWPScviZ3f4bmIDTlVV7vI8mCpduOXfkYgoRv3i8POlJqCpwd+Hm2ApEv68mzf3bA8MKY9Ze17FIK3CbuYqVKCd8OeI0Q9ZhVpx4t/m/gX8/xuUqBqY29zlkqvE2cZk5ksBeUrFx5YB3j3BnG5iYK5eArbTr7o9vOWWm4eDg==;5:2wN07dA7DkPnk9IvdF+ZfXIHmJ6rdrI+nFgm6/nT1UI/ni/TwD/s8Qxq89zlylhqMfOr13ChFWuvDEx4iWNxSSyBA/dnSW90e9au7aPTGn0+rcw9SEf2l6wTxJAWuUrEjnPhNPyTLIpkiJ14LvzjisauJ3OWRECSHCixETfLAz99Stfm5nx9tpzTozBLkqJTZV3lC151UGGjFS3zzLE4Xw==;7:pMBkNpqz6MRv9dW402UANj8nlLFT4eFvuCVJHkGSgwnUeX5fvAVrkHdbvFwmRaiVr3pKTnxOevpE4Vx/F7R6/jrvqijuEgM7LmsNm7ggb28oU6qaJeaqN/sMcBzDFa1b/yb0iVyY1EAfaKmcJarz2Q==
x-ms-office365-filtering-correlation-id: 981f87ab-f6d2-4019-f220-08d68882df53
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3301;
x-ms-traffictypediagnostic: BYAPR12MB3301:
x-microsoft-antispam-prvs: <BYAPR12MB33015A8C5F9F3E0603C11B6AC2920@BYAPR12MB3301.namprd12.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(39860400002)(376002)(396003)(199004)(189003)(76176011)(7696005)(71200400001)(102836004)(186003)(26005)(97736004)(53936002)(6246003)(305945005)(14444005)(2906002)(6506007)(478600001)(6116002)(3846002)(71190400001)(256004)(105586002)(86362001)(74316002)(7736002)(229853002)(68736007)(33656002)(8936002)(54906003)(446003)(8676002)(81156014)(486006)(81166006)(110136005)(476003)(9686003)(25786009)(6636002)(106356001)(99286004)(4326008)(6436002)(55016002)(39060400002)(14454004)(2501003)(11346002)(66066001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3301;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LCNbiSd7c5kj2egCSsfPFLtaTX9NPRnHIJQu+3aGejqB/oJYUZ9rldH8aRpLZoxJHDHUQjNAUgwpaqAYxMND1kgQ0ne3UMuwIZCr3+UbHEuPIspD/6LZpAhDBm46O+2Yjp5EtR1cFeFgre2UQJFLQujvxqDZKiglRTi0ZVsAcdkXOZa/bW2gnt5o7GBPMYyATowgY7IhRgtRmXsV2PWS4aRYhjqD9IQihqfjQNYBUPlcLqLaX8MNkThLfjmwTrMqT06T9ElV3cL5rSF+b3zcprUEGtnbAhWJvxIFLb8U6OM62LYf14HWDAALoZTyjlds/WllPAI4zZ4wr+p1b2p1n16w52FdJBMQoDtJTPvAjdNNjCANViGviBqUD+I9hcVdE84wQkR13Sk/uNdGEC8xRRqFyCJTghPKmv3XCfkp7zw=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 981f87ab-f6d2-4019-f220-08d68882df53
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 20:21:39.2389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3301
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549052506; bh=0nh5Hc83vfy1VTXurHkyU2q+lYqre1nBzayplclKRVs=;
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
        b=VzLOOLlu8veg6+uTC+TA14SYv4bDotWOK919OZpOf6vNkuINA7h9Sp+rJ5vWIunjR
         TY/YgRwzPhmwP8zVl+W26WZ6FNsmj0Hm+Tqyv6tqU1l59zl37teBg8GwfPtloKcbj9
         fWIRDRHuvP+HLfrNKOLWO8D/Af8AsALpcJaOynzeyyMCg4Pd5KJW3L/hli+HHGBI5N
         EOSkNoY7imHgbcDKQhAmBTX9xSI6F5N0KDA+kvJL99FOTRP2K8ClcD3bk3c1gOj+jI
         Q+XOQNEhZXALtf8ASz2fBSMcYdEbZALzcEsirQNASRCfGJAenJ4ivxWxWxu+6aFJeQ
         Plkabb7zUoEbQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+CXJ4X2NoYW4gPSBkbWFfcmVxdWVzdF9zbGF2ZV9jaGFubmVsX3JlYXNvbihpMmNfZGV2LT5k
ZXYsICJyeCIpOw0KPglpZiAoSVNfRVJSKHJ4X2NoYW4pKQ0KPgkJcmV0dXJuIFBUUl9FUlIocnhf
Y2hhbik7DQo+DQo+DQo+ID4gKw0KPiA+ICsJZG1hX2NoYW4gPSBkbWFfcmVxdWVzdF9zbGF2ZV9j
aGFubmVsX3JlYXNvbihpMmNfZGV2LT5kZXYsICJ0eCIpOw0KPiA+ICsJaWYgKElTX0VSUihkbWFf
Y2hhbikpIHsNCj4gPiArCQllcnIgPSBQVFJfRVJSKGRtYV9jaGFuKTsNCj4gPiArCQlnb3RvIGVy
cm9yOw0KPg0KPiBJdCdzIGEgZ29vZCBwcmFjdGljZSB0byByZWxlYXNlIHJlc291cmNlcyBpbiBv
cHBvc2l0ZSBvcmRlciB0byB0aGUgYWxsb2NhdGlvbi4gSGVuY2UgYmV0dGVyIHRvIHdyaXRlIHRo
aXMgYXM6DQo+DQo+CQlnb3RvIGVycl9yZWxlYXNlX3J4Ow0KPg0KPiA+ICsJfQ0KPiA+ICsNCj4g
PiArCWkyY19kZXYtPnR4X2RtYV9jaGFuID0gZG1hX2NoYW47DQo+ID4gKw0KPiA+ICsJZG1hX2J1
ZiA9IGRtYV9hbGxvY19jb2hlcmVudChpMmNfZGV2LT5kZXYsDQo+ID4gKwkJCQkgICAgIGkyY19k
ZXYtPmRtYV9idWZfc2l6ZSwgJmRtYV9waHlzLA0KPiA+ICsJCQkJICAgICBHRlBfS0VSTkVMIHwg
X19HRlBfTk9XQVJOKTsNCj4gPiArDQo+ID4gKwlpZiAoIWRtYV9idWYpIHsNCj4gPiArCQlkZXZf
ZXJyKGkyY19kZXYtPmRldiwgImZhaWxlZCB0byBhbGxvY2F0ZSB0aGUgRE1BIGJ1ZmZlclxuIik7
DQo+ID4gKwkJZXJyID0gLUVOT01FTTsNCj4gPiArCQlnb3RvIGVycm9yOw0KPg0KPgkJZ290byBl
cnJfcmVsZWFzZV90eDsNCj4NCj4gPiArCX0NCj4gPiArDQo+ID4gKwlpMmNfZGV2LT5kbWFfYnVm
ID0gZG1hX2J1ZjsNCj4gPiArCWkyY19kZXYtPmRtYV9waHlzID0gZG1hX3BoeXM7CWkyY19kZXYt
PnJ4X2RtYV9jaGFuID0gcnhfY2hhbjsNCj4JaTJjX2Rldi0+dHhfZG1hX2NoYW4gPSB0eF9jaGFu
Ow0KPg0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICtlcnJvcjoNCj4gPiArCWlmIChpMmNf
ZGV2LT50eF9kbWFfY2hhbikNCj4gPiArCQlkbWFfcmVsZWFzZV9jaGFubmVsKGkyY19kZXYtPnR4
X2RtYV9jaGFuKTsNCj4gPiArDQo+ID4gKwlpZiAoaTJjX2Rldi0+cnhfZG1hX2NoYW4pDQo+ID4g
KwkJZG1hX3JlbGVhc2VfY2hhbm5lbChpMmNfZGV2LT5yeF9kbWFfY2hhbik7DQo+DQo+IGVycm9y
X3JlbGVhc2VfdHg6DQo+CWRtYV9yZWxlYXNlX2NoYW5uZWwodHhfY2hhbik7DQo+IGVycm9yX3Jl
bGVhc2Vfcng6DQo+CWRtYV9yZWxlYXNlX2NoYW5uZWwocnhfY2hhbik7DQo+DQo+ID4gKw0KPiA+
ICsJcmV0dXJuIGVycjsNCg0KSSBhbSByZWxlYXNpbmcgcmVzb3VyY2VzIGluIHJldmVyc2Ugb3Jk
ZXIgdG8gYWxsb2NhdGlvbi4NClRyeWluZyBmb3IgcnggYWxsb2NhdGlvbiBmb2xsb3dlZCBieSB0
eCBhbGxvY2F0aW9uDQpEdXJpbmcgcmVsZWFzZSByZWxlYXNpbmcgdHggYW5kIHRoZW4gcnguDQpJ
biBjYXNlIGlmIHR4IGFsbG9jYXRpb24gZmFpbHMsIGRvZXNu4oCZdCBnbyB0aHJ1IHJlbGVhc2Uu
IElmIHJ4IG9yIGJ1ZiBhbGxvY2F0aW9uIGZhaWxzLCByZWxlYXNlcyB0eCBmaXJzdCBhbmQgdGhl
biByeA0KDQo=
