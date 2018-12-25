Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4FDC64E79
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 02:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE6E218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 02:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="gb68k9nW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbeLYCaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 21:30:35 -0500
Received: from mail-oln040092008030.outbound.protection.outlook.com ([40.92.8.30]:31861
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725813AbeLYCaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 21:30:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWFakmN9dLQonjGFCCXaisoPPPkm9wz2Tqq2hY8IpRs=;
 b=gb68k9nWNeC6JyicST54eRnwHIgWNJsP2LhdzABL9hrUeONOaEFbm25jkkiUtGNARhtQFcl4hfzAIhmwAIOVRvAF2115K+eBBz2b/ylOzIPV3rBQtFBR96U8HOl9EMQhV7YXJYWLQyHZdWy1JPgp+w84c78HpNTcQ9fVD5Hw0rc1Lzri37epCx58uVjq0Bx09jQ1FGK2JkWEKzdIDq5YamI5VlK6ZeslFZT7fPWcnCbyEfDjKOKVvYnU51vokzbuKdAb4l0NDs4CMMs9kUYIiJlG/rTbTTxhnKxcrGFuulDmtix+u5gClxGds8JE3hSkXYCxwCvjaOK/r2QMiadcxw==
Received: from CO1NAM03FT009.eop-NAM03.prod.protection.outlook.com
 (10.152.80.52) by CO1NAM03HT197.eop-NAM03.prod.protection.outlook.com
 (10.152.80.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1471.13; Tue, 25 Dec
 2018 02:30:33 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com (10.152.80.53) by
 CO1NAM03FT009.mail.protection.outlook.com (10.152.80.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1471.13 via Frontend Transport; Tue, 25 Dec 2018 02:30:33 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::19ff:b7ea:dfaa:2ee3]) by BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::19ff:b7ea:dfaa:2ee3%2]) with mapi id 15.20.1471.019; Tue, 25 Dec 2018
 02:30:33 +0000
From:   Yueyi Li <liyueyi@live.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in
 linear region
Thread-Topic: [PATCH] arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in
 linear region
Thread-Index: AQHUm1vkcfAdS8kQrUSpqXhyNic5x6WNpCYAgAEYtgA=
Date:   Tue, 25 Dec 2018 02:30:32 +0000
Message-ID: <BLUPR13MB02892B82F5EB663B2FECF20EDFB40@BLUPR13MB0289.namprd13.prod.outlook.com>
References: <BLUPR13MB0289A32373545C7FBE3400CBDFBB0@BLUPR13MB0289.namprd13.prod.outlook.com>
 <CAKv+Gu_m353cv=Pf2cEUDLn8=5YTLjLDDO23n=P14nWXydQWDQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu_m353cv=Pf2cEUDLn8=5YTLjLDDO23n=P14nWXydQWDQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::30) To BLUPR13MB0289.namprd13.prod.outlook.com
 (2a01:111:e400:5951::22)
x-incomingtopheadermarker: OriginalChecksum:ED8CAFCDDAAC72BC79F84A445901B78D61BCE5473B6CEE8A632B44068641364F;UpperCasedChecksum:720A7341F854FF4A24886FCE207ABD44CFD04736EEF6C855DE53299E64DE7D23;SizeAsReceived:7984;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [e6ETr/gPwoZ4KSwZ0cOvb65rZDPT6UUS]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO1NAM03HT197;6:w0tNl2ayrq1mJBHdPhAvGVtIW91BYm4HXY2JKlmlH1jk0QmT3O/cfLxyj9qSozYcO4z1MoZPCV1K+77AFHYXGfTSeIeX45wWkMX7dDwesNvRknqFAPgw9rqJfkMhdyJbftgNbyIlurASZFijg3sr3E76dJ5/MwKM3aL64X0X6mRNvtRRfagJoysLwHzG9TBEYAaNBav62N99Jthm/iXYZyYhjQ6FNAHyttI/kRWBIbc2UIaJqbZGMYKrZgapzvgJr5++2PIts01y4ci1amTpzhYlOXZTjDS0DhosQOk0MRaLq8krBxxVujgr5A3bnnvaD4gL55XzI3Ad/rPjYXLo2Xfr2QiMH4I6RZCMB67VJJHFAQSLPj/PffPyzLv6YttDActihBzGsUAP2DwQ1CCfVm51Nd+OrCqU7ysJB7oLVNeggN1mfUs2s+55LOs//W330SyLv8gPWNcOGOv4JAaXAg==;5:vXLf7/LV6MdKK5jDtcTSReng1NVnOmytZIGvzr/EA34DolsrHgbsv3Q687RYU40dqvwxySqhwtJU3OUMJIr8iL9R3WvzOu7EWEVC3llFAfiirXbzpTE+UnlcqV7l8njFg+HEWtozHxhup7SEMHyfwUMErqDw50dieIYvWYITVIQ=;7:/ggbrV6cioCc8VeqmHzvsDX2c0anfqxtAkkJ5Ui2vTuEmWH6KfV9bd2i9pXCFeHmsJ2T/ZIdiZsbjhEV6xWU5wFTSRSiZCOljfzVr4Fz6R6v4BcgK/2sY64VExhUsjECXSoqquGbp+lC29FEAVj6bQ==
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119063)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:CO1NAM03HT197;
x-ms-traffictypediagnostic: CO1NAM03HT197:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:CO1NAM03HT197;BCL:0;PCL:0;RULEID:;SRVR:CO1NAM03HT197;
x-microsoft-antispam-message-info: bzs2yNjAzCgTl/+ExUjvwzm/As/r3b//q/4IGQMMLib/I9oJKrQ8MTW6LMuBtS6a
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FD45580FFC0B745A13E84CA26AFCA29@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-Network-Message-Id: 05506636-fe52-4bc9-b481-08d66a10f152
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2018 02:30:32.9231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1NAM03HT197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJkLA0KDQoNCk9uIDIwMTgvMTIvMjQgMTc6NDUsIEFyZCBCaWVzaGV1dmVsIHdyb3RlOg0K
PiBEb2VzIHRoZSBmb2xsb3dpbmcgY2hhbmdlIGZpeCB5b3VyIGlzc3VlIGFzIHdlbGw/DQo+DQo+
IGluZGV4IDliNDMyZDlmY2FkYS4uOWRjZjBmZjc1YTExIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2Fy
bTY0L21tL2luaXQuYw0KPiArKysgYi9hcmNoL2FybTY0L21tL2luaXQuYw0KPiBAQCAtNDQ3LDcg
KzQ0Nyw3IEBAIHZvaWQgX19pbml0IGFybTY0X21lbWJsb2NrX2luaXQodm9pZCkNCj4gICAgICAg
ICAgICAgICAgICAgKiBtZW1vcnkgc3BhbnMsIHJhbmRvbWl6ZSB0aGUgbGluZWFyIHJlZ2lvbiBh
cyB3ZWxsLg0KPiAgICAgICAgICAgICAgICAgICAqLw0KPiAgICAgICAgICAgICAgICAgIGlmICht
ZW1zdGFydF9vZmZzZXRfc2VlZCA+IDAgJiYgcmFuZ2UgPj0gQVJNNjRfTUVNU1RBUlRfQUxJR04p
IHsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgcmFuZ2UgPSByYW5nZSAvIEFSTTY0X01FTVNU
QVJUX0FMSUdOICsgMTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmFuZ2UgLz0gQVJNNjRf
TUVNU1RBUlRfQUxJR047DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBtZW1zdGFydF9hZGRy
IC09IEFSTTY0X01FTVNUQVJUX0FMSUdOICoNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgKChyYW5nZSAqIG1lbXN0YXJ0X29mZnNldF9zZWVkKSA+PiAxNik7DQo+
ICAgICAgICAgICAgICAgICAgfQ0KDQpZZXMsIGl0IGNhbiBmaXggdGhpcyBhbHNvLiBJIGp1c3Qg
dGhpbmsgbW9kaWZ5IHRoZSBmaXJzdCAqcmFuZ2UqIA0KY2FsY3VsYXRpb24gd291bGQgYmUgZWFz
aWVyIHRvDQogIGdyYXNwLCB3aGF0IGRvIHlvdSB0aGluaz8NCg0KDQoNClRoYW5rcywNCll1ZXlp
DQo=
