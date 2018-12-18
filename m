Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88ADAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431B7217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Cy6Jegq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeLRJZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:25:47 -0500
Received: from mail-oln040092002074.outbound.protection.outlook.com ([40.92.2.74]:33550
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726365AbeLRJZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deTetb0LGiESkE0fBWfoOEJk8q3s2Jnfi/jIQB5TOK8=;
 b=Cy6Jegq+XYgJdSjXGaC8gaD39ZbW5FWbg+wzB3t40UvqS6wLR/fBDYbPiVWpVtl5UZibx/vsmjWcYNVKNsdpiTKmXOQwYcduDfZ77DbzIT2KzwFsnIrmvDqux0ntk43rL0Csj//P5rQ4m1C08snWqu8Q/mZpzmOO9Rzh2FHcekVHo6NerXrsCB9EEyXFXU645EeMfg/wXpuWKsMyXiQFwxB8lheYjFp5D4jXxy+IUNWjR9IB+SB/K64zpKBlEBOkvMqVM+n/9Z1Nknr87t40JlVp3L/kEDCGTAuDo5sCQd/atzVhwEFpQ4tyrxuW00wg/I3cWKoQB8+YkysnWQwt0A==
Received: from BN3NAM01FT030.eop-nam01.prod.protection.outlook.com
 (10.152.66.55) by BN3NAM01HT098.eop-nam01.prod.protection.outlook.com
 (10.152.67.169) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1446.11; Tue, 18 Dec
 2018 09:25:44 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com (10.152.66.54) by
 BN3NAM01FT030.mail.protection.outlook.com (10.152.66.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1446.11 via Frontend Transport; Tue, 18 Dec 2018 09:25:44 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::19ff:b7ea:dfaa:2ee3]) by BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::19ff:b7ea:dfaa:2ee3%2]) with mapi id 15.20.1446.015; Tue, 18 Dec 2018
 09:25:44 +0000
From:   Yueyi Li <liyueyi@live.com>
To:     "Markus F.X.J. Oberhumer" <markus@oberhumer.com>,
        Kees Cook <keescook@chromium.org>,
        richard -rw- weinberger <richard.weinberger@gmail.com>
CC:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Greg KH <gregkh@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>,
        Don Bailey <donb@securitymouse.com>,
        Jiri Kosina <jikos@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] lzo: fix ip overrun during compress.
Thread-Topic: [PATCH v2] lzo: fix ip overrun during compress.
Thread-Index: AQHUhuxfhCM/itRkZUmE23ES7mjh0qVlNWoAgAkytACAARlyAIACWjQAgAjLaACAAHk+gIADO1kAgAAveACAAydegIACpsyA
Date:   Tue, 18 Dec 2018 09:25:44 +0000
Message-ID: <BLUPR13MB0289005209052E44716FC4A6DFBD0@BLUPR13MB0289.namprd13.prod.outlook.com>
References: <BLUPR13MB0289EFEB79833470EE62F48EDFD10@BLUPR13MB0289.namprd13.prod.outlook.com>
 <20181128135242.gy3avmbp2pdmjaka@twin.jikos.cz>
 <5C0654EE.5040001@oberhumer.com>
 <SN1PR13MB030484F09EE8A00DB094CDFADFA80@SN1PR13MB0304.namprd13.prod.outlook.com>
 <5C093A30.4020705@oberhumer.com>
 <BLUPR13MB0289EC81589A10E95912675FDFA70@BLUPR13MB0289.namprd13.prod.outlook.com>
 <5C110083.8060502@oberhumer.com>
 <CAFLxGvzj=P2FY6w7CBYztsUjJ5Td53zCzGa_FUjrfxA94cmSgA@mail.gmail.com>
 <CAGXu5jLR06ti_xhC8OODbF8m+Tsf6a0ebJLBe8KLcC+csG_i=w@mail.gmail.com>
 <5C1683A1.5090803@oberhumer.com>
In-Reply-To: <5C1683A1.5090803@oberhumer.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0066.apcprd03.prod.outlook.com
 (2603:1096:203:52::30) To BLUPR13MB0289.namprd13.prod.outlook.com
 (2a01:111:e400:5951::22)
x-incomingtopheadermarker: OriginalChecksum:D2D746BAAEE9A48870FD4693DF0B68A347247779C172B46BB9082B46999EE480;UpperCasedChecksum:C9DB23BF5304BE3CBC540AA3C98F33FDE3FFC1E97A93DB2174CA5546E4BB7797;SizeAsReceived:8306;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [HOd1K+zdQoE4idQ7RKLx+pmgnbA+sF+C]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3NAM01HT098;6:PNlmdmzSoLq7LXsUCunIhsZR64B1pmaMmBDgP+DoGF6ZYMFo64VeCga2MaQdp9PIrW8qIP1MEVvsRWwMYWWsoIwYXbePO6dlvWydJhvG6CbHiMCtWNjRtJuLkH2lcHrfpuywMu62auTCHsfhs16dAG/W6ku2/0uC10fCLU5kjWT3bU616wyVhPFJ5frwZ/GeVsWt29DGWOaANTsNyMpmBFUCeLl9Tb2EN/mTsi92bkwXez+X0cBgou49Q4+IggfannPZAj+LWKlIrV31n/u+uleACFBmAw8yG9Cd6s85Lst27hTFSP22RxeSrzs/PuRV326iw/B4nTsEDnRh2yIJGiQYrfV31i1ID07+sl2U4OYGfJgxz4yOdh3Mjeov52GqIUbQ21680ObUuere7JHLLrh/6dyF/tHeCcTKcms82gtnmHct8FhASn4C/5Hv9xum8CgzJ2UeHCjxt2p+G0GFyA==;5:eDfd+cvMBNEufxb1T75/8eq0ByO4xJdqwadMSaotH+z2LRsoDAF2fL3+z9BnG8u5GqxKkCZ7yx3+w1WCOtYex+Wn9xG3lChJqeO+icszKty9lX5D+GHaA/rfQpIsS7sL54cftccWOWm+SoDI94a/gWo842Ey4Fcs1JHKoL/rhyM=;7:/T0BzJXbJv9RbbopUpgBtIZePIsihLtQBxa/XUY6v6InGQR2iutdKVfLdStQegMclizgLIbCVa92EdOWrRIfASsGajMrN2QNSps4MSnLOTm3hfelwX1ipePj0Gh0wlcpm8yaRppBZBSFV2n+ZdSGNw==
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:BN3NAM01HT098;
x-ms-traffictypediagnostic: BN3NAM01HT098:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:BN3NAM01HT098;BCL:0;PCL:0;RULEID:;SRVR:BN3NAM01HT098;
x-microsoft-antispam-message-info: UbjlKCrB8lK+8JlyOstcG0KrglXziQ044iDNeq2xION5RaovrluZl6TFzyoMx/R/
Content-Type: text/plain; charset="utf-8"
Content-ID: <5986929341657A4ABF6F670A2259FF23@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-Network-Message-Id: cbcf325c-f702-4f4d-53ed-08d664cac7a3
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 09:25:44.1736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3NAM01HT098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFya3VzICYgS2VlcywNCg0KT24gMjAxOC8xMi8xNyAwOjU2LCBNYXJrdXMgRi5YLkouIE9i
ZXJodW1lciB3cm90ZToNCj4gWXVleWksDQo+DQo+IGlmIEFTTFIgZG9lcyBpbmRlZWQgZXhjbHVk
ZSB0aGUgbGFzdCBwYWdlIChsaWtlIGl0IHNob3VsZCksIGhvdyBkbw0KPiB5b3UgZ2V0IHRoZSBp
bnZhbGlkICgweGZmZmZmZmZmZmZmZmYwMDAsIDQwOTYpIG1hcHBpbmcgdGhlbj8NClJlZ2FyZGlu
ZyBmb2xsb3dpbmcgY29kZSwgc2VlbXMgQVNMUiBpcyBhbGlnbiB0byBBUk02NF9NRU1TVEFSVF9B
TElHTixJDQpkb25gdCB0aGluayBpdCB3aWxsIGV4Y2x1ZGUgdGhlIHRvcCA0SyBhZGRyZXNzIHNw
YWNlLg0KDQpgYGANCmlmIChJU19FTkFCTEVEKENPTkZJR19SQU5ET01JWkVfQkFTRSkpIHsNCiAg
ICAgICAgIGV4dGVybiB1MTYgbWVtc3RhcnRfb2Zmc2V0X3NlZWQ7DQogICAgICAgICB1NjQgcmFu
Z2UgPSBsaW5lYXJfcmVnaW9uX3NpemUgLQ0KICAgICAgICAgICAgICAgICAgICAoYm9vdGxvYWRl
cl9tZW1vcnlfbGltaXQgLSBtZW1ibG9ja19zdGFydF9vZl9EUkFNKCkpOw0KDQogICAgICAgICAv
Kg0KICAgICAgICAgICogSWYgdGhlIHNpemUgb2YgdGhlIGxpbmVhciByZWdpb24gZXhjZWVkcywg
YnkgYSBzdWZmaWNpZW50DQogICAgICAgICAgKiBtYXJnaW4sIHRoZSBzaXplIG9mIHRoZSByZWdp
b24gdGhhdCB0aGUgYXZhaWxhYmxlIHBoeXNpY2FsDQogICAgICAgICAgKiBtZW1vcnkgc3BhbnMs
IHJhbmRvbWl6ZSB0aGUgbGluZWFyIHJlZ2lvbiBhcyB3ZWxsLg0KICAgICAgICAgICovDQogICAg
ICAgICBpZiAobWVtc3RhcnRfb2Zmc2V0X3NlZWQgPiAwICYmIHJhbmdlID49IEFSTTY0X01FTVNU
QVJUX0FMSUdOKSB7DQogICAgICAgICAgICAgICAgIHJhbmdlID0gcmFuZ2UgLyBBUk02NF9NRU1T
VEFSVF9BTElHTiArIDE7DQogICAgICAgICAgICAgICAgIG1lbXN0YXJ0X2FkZHIgLT0gQVJNNjRf
TUVNU1RBUlRfQUxJR04gKg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICgocmFu
Z2UgKiBtZW1zdGFydF9vZmZzZXRfc2VlZCkgPj4gMTYpOw0KICAgICAgICAgfQ0KfQ0KYGBgDQoN
ClRoYW5rcywNCll1ZXlpDQoNCg==
