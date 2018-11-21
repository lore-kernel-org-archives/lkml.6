Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56147C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 01:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F77320989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 01:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XaTS6FTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F77320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbeKUMb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 07:31:58 -0500
Received: from mail-eopbgr130087.outbound.protection.outlook.com ([40.107.13.87]:36381
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbeKUMb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 07:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCJq7Gw27KHVcCU4hkAPxosMWgXgxp6Hs3dMqZlMzoY=;
 b=XaTS6FTyUM6ZKHEYfadGOe5zdZ/6TXk+zxTJMh7Tgzuc47Gsyy19jQTKXJI8MAASsyVTqo3xFVCOlrn01TT4gdUTcUQqT5n7J69uUAzYTPz63gYTzYx4uh3vJ6lS6jltdMzLl1qdcuFgib+7l+oglIzdX+20cX4Wssl5aK+5YwE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3852.eurprd04.prod.outlook.com (52.134.71.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Wed, 21 Nov 2018 01:58:58 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.048; Wed, 21 Nov 2018
 01:58:58 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] thermal: imx: fix for dependency on cpu-freq
Thread-Topic: [PATCH] thermal: imx: fix for dependency on cpu-freq
Thread-Index: AQHUa2Ref+fMFTxEzkOrPUZd06/1XqVYpmyAgAD+MYA=
Date:   Wed, 21 Nov 2018 01:58:58 +0000
Message-ID: <DB3PR0402MB3916F122EA873F847A115C91F5DA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1540362909-32481-1-git-send-email-Anson.Huang@nxp.com>
 <CAOh2x=kwGUto-TMsQORtx0CkgZSDsq6Mg1e=QKL=LeDPWJ=NPQ@mail.gmail.com>
In-Reply-To: <CAOh2x=kwGUto-TMsQORtx0CkgZSDsq6Mg1e=QKL=LeDPWJ=NPQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3852;6:DWj5wuDLJdOU/9wIcUR9OcAq+/JmoUyr+ti7pwH05u2BLi2Es+oAPX2iNWOyRPH3Q1QfBg3frVs+epQmFBPDiPmrC3LrsCdmY1xt8DOV9yrwMdSwFeBXoulLBXoaRA/ZtHaE83BDEHgL2ZC8GPQVbMsghuCCq/Lu0O8zosbkYiqGOptryMUHzsodC7DHZnCcnL55/VpZD+grSR5M+E2whtP7c4TLSkdS80rFukAjZe52dLkvUCbBzAp/Cs1qAlL+P+tkvEj8oO9mQUc+hlqKnRAOxHlDB92cK7ugj5DrPip1J2QoKLR/z5EUJNg9rUBeS2n7XQhR/i/+j2xli4LY/FqxkLpVqGohkhXUkKQ2hL/0sGxWZZn35oVMGXrLs5xX14mQAXEIXBc8+7M8a97+WR2Goo363vV9Wu5ki1QAwm5YJlnVhOKINehH+pw+bUhBZjSKiwd+npaDMn2erZxN9Q==;5:4HahrmIawWM7JCoh5+v30NATp0qLLFYJoY+ajLKiMkPJBHcrh5QvfEbPOwfPOohIChpYui0cJOVwcMJGe14nyFK6qx7IXuQBwOIi/cWT8HI+FF7p4jvRD1Kj3VOdH8EcN/yF6QCTFtu3x2im7IP8EW0aUf7eVEsDICDOl7csDqc=;7:zSNS/9SQjaVqnDCO3IvN5Bh/fDSycv60cswzVeF0C3xfQeGeEAqD7TIT0Wsiv4Bt0RSJ5HT2UwVKd1HJi89g0QHgHAPxJCSpy7ElNPuSM50CHedQQxlk+m7Lq+xjWWoANjQCGMgPhfRiGuQeYvCzdA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2cb347ee-a39a-4db8-a99c-08d64f54e6be
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3852;
x-ms-traffictypediagnostic: DB3PR0402MB3852:
x-microsoft-antispam-prvs: <DB3PR0402MB38526DE3B42DF08C80D528C9F5DA0@DB3PR0402MB3852.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(228905959029699)(85827821059158)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3852;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3852;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(396003)(376002)(13464003)(199004)(189003)(316002)(71200400001)(8676002)(25786009)(81166006)(4326008)(71190400001)(54906003)(6116002)(3846002)(106356001)(97736004)(5660300001)(66066001)(2906002)(478600001)(81156014)(8936002)(6246003)(256004)(14454004)(68736007)(11346002)(39060400002)(26005)(186003)(2900100001)(6916009)(6506007)(102836004)(86362001)(6436002)(55016002)(9686003)(53546011)(53936002)(33656002)(7736002)(105586002)(76176011)(74316002)(476003)(305945005)(486006)(99286004)(44832011)(446003)(7696005)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3852;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DUCZtW6oDg8LbhaBx/T37aLaSloQuInGhnXbH+S1HilW9u8S4aKY/oxa2TnSVR6HlkWELCmKCvIc8FRMBnAffzgjMzzl/MfExGAs4cmzZlCHrkwK9dGw50+q/gShd33OzcneALVunBrL13eqBTrgmvaI9Ypl74YzPZPs8tVznu3vvcKUTYSYval9LVfM8G3UOceyiB+VopDy2KOBbSCeqda0mLE/vbf9TR3LGlxzgOLgnoYn9ZXAbdkljdZOmpMQ/+41xi0TwFAr3+cgT8rPs9AxdxKMsG48oUMhJUkNkNBWH6ppmMOYI5Isy7L/xgYpB9vK07HzpshhyLymk9gpvP1U6wQ/XPYWEgVsknp/AWM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb347ee-a39a-4db8-a99c-08d64f54e6be
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 01:58:58.5665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3852
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFZpcmVzaA0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpcmVzaCBLdW1hciBbbWFpbHRvOnZpcmVzaC5rdW1h
ckBsaW5hcm8ub3JnXQ0KPiBTZW50OiAyMDE45bm0MTHmnIgyMOaXpSAxODo0OQ0KPiBUbzogQW5z
b24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IENjOiBaaGFuZyBSdWkgPHJ1aS56aGFu
Z0BpbnRlbC5jb20+OyBFZHVhcmRvIFZhbGVudGluDQo+IDxlZHViZXp2YWxAZ21haWwuY29tPjsg
TGludXggUE0gbGlzdCA8bGludXgtcG1Admdlci5rZXJuZWwub3JnPjsgTGludXgNCj4gS2VybmVs
IE1haWxpbmcgTGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IGRsLWxpbnV4LWlt
eA0KPiA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHRoZXJtYWw6
IGlteDogZml4IGZvciBkZXBlbmRlbmN5IG9uIGNwdS1mcmVxDQo+IA0KPiBXaGlsZSBJIGFtIGFs
aWduZWQgd2l0aCB0aGUgZmFjdCB0aGF0IHdlIG5lZWQgdG8gY2FycnkgdGhpcyBjb2RlIGZvciBi
YWNrd2FyZA0KPiBjb21wYXRpYmlsaXR5LCB0aGVyZSBhcmUgZmV3IHRoaW5ncyBJIHdvdWxkIHN1
Z2dlc3QgdG8gaW1wcm92ZS4NCj4gDQo+IE9uIFdlZCwgT2N0IDI0LCAyMDE4IGF0IDEyOjEwIFBN
IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiB3cm90ZToNCj4gPiAgc3RhdGlj
IGludCBpbXhfdGhlcm1hbF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KSAgeyBA
QA0KPiA+IC03NDMsNiArNzQ1LDcgQEAgc3RhdGljIGludCBpbXhfdGhlcm1hbF9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiA+ICAgICAgICAgcmVnbWFwX3dyaXRlKG1h
cCwgZGF0YS0+c29jZGF0YS0+c2Vuc29yX2N0cmwgKyBSRUdfU0VULA0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgIGRhdGEtPnNvY2RhdGEtPnBvd2VyX2Rvd25fbWFzayk7DQo+ID4NCj4gPiArI2lm
ZGVmIENPTkZJR19DUFVfRlJFUQ0KPiA+ICAgICAgICAgZGF0YS0+cG9saWN5ID0gY3B1ZnJlcV9j
cHVfZ2V0KDApOw0KPiA+ICAgICAgICAgaWYgKCFkYXRhLT5wb2xpY3kpIHsNCj4gPiAgICAgICAg
ICAgICAgICAgcHJfZGVidWcoIiVzOiBDUFVGcmVxIHBvbGljeSBub3QgZm91bmRcbiIsIF9fZnVu
Y19fKTsNCj4gPiBAQCAtNzU1LDYgKzc1OCw3IEBAIHN0YXRpYyBpbnQgaW14X3RoZXJtYWxfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAiZmFpbGVkIHRvIHJlZ2lzdGVyIGNwdWZyZXEgY29vbGluZyBkZXZpY2U6ICVkXG4i
LA0KPiByZXQpOw0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICAgICAgICAg
fQ0KPiA+ICsjZW5kaWYNCj4gPg0KPiA+ICAgICAgICAgZGF0YS0+dGhlcm1hbF9jbGsgPSBkZXZt
X2Nsa19nZXQoJnBkZXYtPmRldiwgTlVMTCk7DQo+ID4gICAgICAgICBpZiAoSVNfRVJSKGRhdGEt
PnRoZXJtYWxfY2xrKSkgew0KPiANCj4gWW91IG1pc3NlZCB0aGUgZXJyb3IgaGFuZGxpbmcgY29k
ZSB3aGljaCB1bnJlZ2lzdGVycyBjb29saW5nL2NwdWZyZXEgc3R1ZmYuDQo+IA0KPiBBbmQgaXQg
d291bGQgYmUgYmV0dGVyIHRvIHdyaXRlIHRoaW5ncyBpbiBhIHNvbWV3aGF0IGJldHRlciB3YXks
IGxpa2UgdGhpczoNCj4gDQo+ICNpZmRlZiBDT05GSUdfQ1BVX0ZSRVENCj4gDQo+IHN0YXRpYyBp
bnQgaW14X3RoZXJtYWxfcmVnaXN0ZXJfbGVnYWN5X2Nvb2xpbmcoLi4uKQ0KPiB7DQo+ICAgICAg
ICAgLi4uIGN1cnJlbnQgZnVuY3Rpb24gYm9keQ0KPiB9DQo+IA0KPiBzdGF0aWMgdm9pZCBpbXhf
dGhlcm1hbF91bnJlZ2lzdGVyX2xlZ2FjeV9jb29saW5nKC4uLikNCj4gew0KPiAgICAgICAgIG5l
dyByb3V0aW5lIGJvZHkgdG8gdW5yZWdpc3RlciB0aGluZ3MgfQ0KPiANCj4gI2Vsc2UNCj4gc3Rh
dGljIGlubGluZSAgaW50IGlteF90aGVybWFsX3JlZ2lzdGVyX2xlZ2FjeV9jb29saW5nKC4uLikN
Cj4gew0KPiAgICAgICAgIHJldHVybiAwOw0KPiB9DQo+IA0KPiBzdGF0aWMgdm9pZCBpbXhfdGhl
cm1hbF91bnJlZ2lzdGVyX2xlZ2FjeV9jb29saW5nKC4uLikgeyB9DQo+IA0KPiAjZW5kaWYNCj4g
DQo+IA0KPiBBbmQgdGhlbiB5b3UgY2FuIGdldCByaWQgb2YgaWZkZWYgaGFja2VyeSBpbiB0aGUg
bWlkZGxlIG9mIHByb2JlKCkuDQoNClRoYW5rcyBmb3IgZ29vZCBzdWdnZXN0aW9uLCBwbGVhc2Ug
aGVscCByZXZpZXcgdGhlIFYyIHBhdGNoIEkganVzdCBzZW50IG91dC4NCg0KQW5zb24uDQo=
