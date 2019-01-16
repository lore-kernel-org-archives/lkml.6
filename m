Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00770C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5DA20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="AAxgkoMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388984AbfAPIie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:38:34 -0500
Received: from mail-oln040092000076.outbound.protection.outlook.com ([40.92.0.76]:6544
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731501AbfAPIie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUC9sTABUlNvnz7PcA1F5QZVBz2nov3/VDKWTr5nEPI=;
 b=AAxgkoMcTJXkJp4OiKNyo+iPfKPRSBBe7dYhO68jBLJZWTr+XU8sy/rwY5UzHWDVgYQVV//WOosxm6Ti9KuCx3nCZ3t2gpkKG5D3MQCFfa7ckkIfTD4vQz+ujfVUo2brBre3LyORNoB8ha2rFQIyqkG3N/0o65xQboaUcgm5lqeyvuWEsD30NdgdzHAqH1YAFloOyXMV9c4CJEf08//IsYTRbzXa+OhJtJC0QJm7UQhmZwP2llm3j6A3C2sbv+YpJRkjb/z4tiis/4ihRAl0qhwholilYCURi5r/AvLK+8J2Z300U/5F7As/erPbo2L5zQWvc9geQpVxufZuYUVESQ==
Received: from BN3NAM01FT023.eop-nam01.prod.protection.outlook.com
 (10.152.66.58) by BN3NAM01HT070.eop-nam01.prod.protection.outlook.com
 (10.152.66.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1537.26; Wed, 16 Jan
 2019 08:38:31 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com (10.152.66.57) by
 BN3NAM01FT023.mail.protection.outlook.com (10.152.67.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1471.13 via Frontend Transport; Wed, 16 Jan 2019 08:38:31 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::dd7d:4ced:858f:a868]) by BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::dd7d:4ced:858f:a868%2]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 08:38:31 +0000
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
Thread-Index: AQHUm1vkcfAdS8kQrUSpqXhyNic5x6WNpCYAgAEYtgCAAlAzAIAgVdQAgABG6QCAAA0ogA==
Date:   Wed, 16 Jan 2019 08:38:31 +0000
Message-ID: <BLUPR13MB0289B8C3D58E9A3FAD2CF3DEDF820@BLUPR13MB0289.namprd13.prod.outlook.com>
References: <BLUPR13MB0289A32373545C7FBE3400CBDFBB0@BLUPR13MB0289.namprd13.prod.outlook.com>
 <CAKv+Gu_m353cv=Pf2cEUDLn8=5YTLjLDDO23n=P14nWXydQWDQ@mail.gmail.com>
 <BLUPR13MB02892B82F5EB663B2FECF20EDFB40@BLUPR13MB0289.namprd13.prod.outlook.com>
 <CAKv+Gu-YTdQmhU_br4amNZYn12=6Amr7w=wP57DyNn7_axptCg@mail.gmail.com>
 <BLUPR13MB028993B73A531E5C7EA62DCEDF820@BLUPR13MB0289.namprd13.prod.outlook.com>
 <CAKv+Gu-0JUqihHGQt+YyvUHRTizTOWywXqMaE4RiXOjQ7xi7zA@mail.gmail.com>
In-Reply-To: <CAKv+Gu-0JUqihHGQt+YyvUHRTizTOWywXqMaE4RiXOjQ7xi7zA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0080.apcprd03.prod.outlook.com
 (2603:1096:203:72::20) To BLUPR13MB0289.namprd13.prod.outlook.com
 (2a01:111:e400:5951::22)
x-incomingtopheadermarker: OriginalChecksum:8CBF141CB0179666A69D1612D89480E29E52AEF2C7BF11574DD98D94D88170F7;UpperCasedChecksum:329E41B1E6911E6F91044BF8E3B76A840D53E6AF299D69842FD456158B9E8A2E;SizeAsReceived:9437;Count:65
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [NkqjnhVau7GQV0ctpQN5sdzmBSEo1e+X]
x-microsoft-original-message-id: <0b823594-4434-2c5a-92e7-711b22a96de9@live.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3NAM01HT070;6:uoCrJFyKRyDt/OZmTBIniLPuekPq+2NZZvS4oI/EeGJ+EbF0uBkb9KGZkJarvDalcLX0nF8MN7AlpVnYbvBB+bnr9gYfwRmMqlE4jMXXBISaaaoFSPWMxeui1NMs+7My/LCSdcraiPjFj6ke37ufsrDe0LkgMDgLFuDxA2f3AEJhYwN2E4nCfhi+/7PatqMElJTvXlULIMg4nyOIXHVeLM7OD1cMOTrw0Jvj2fo3o/qMUFdxU5lMdAGY8kQkWEeeiUcDaOjY53Id5Gnn4ROH1DD/lJUsLZIPo9FsGZCSHaqbNyrIRsLHO6P6Efp4ZVdAJcmR9HkPkzQKvw4TgodgEcqxCTL8uMcJAGKgG01Tw7HrmfY2Grwbv8Sru+EypGsNwnkDbBvBfL1g7uCmN9ZLZMKH0gSfR8W1G9+ZkWN3oIWkZ1xfWyA5lvXsjXTJkcVtwPPj+PPGxfMrvzETBdQa0Q==;5:7R8nt1bQuXflFQwYmuWT0uWUOdgYRKe6xSQI6UgiUIU3e8kC40maOJB/e2wqaABYA+8Nw9H4tSHobR1UgG9TPhALCQ79xkrwf3Iw/US8osAGQhxU1S6BQPLx/s37GlqVdTv48f8qTmbHRz+pcnbUuI8auVwpbt+QaTl3HGkDirefQPXtYQOIdmM6y6vJzMgHz3TzMISDg8HwpOSvuSsBBw==;7:R2FRUcNatNbbLIJ9aPiSgIN6cKYs2c6kwc7nqqTe9kxlHPEhH/3jHAxeQRAet379XvYyiTbbwwm2DcOQWRsOY6rUJ/PisLMUNEHzAWfMqI4t6DWd4YeBUzvAEfPc1lgBVmk9H2M4/QdmGshD+Et3IQ==
x-incomingheadercount: 65
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:BN3NAM01HT070;
x-ms-traffictypediagnostic: BN3NAM01HT070:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:BN3NAM01HT070;BCL:0;PCL:0;RULEID:;SRVR:BN3NAM01HT070;
x-microsoft-antispam-message-info: ocWRTy5wYmLfvgdhOpEeYpu73raIRx3Mug5O7T++08mDQeAqSVuXUy9BWRkERGbe
Content-Type: text/plain; charset="utf-8"
Content-ID: <60409A429487BE47ADC190BB1A9D2994@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-Network-Message-Id: 75972ae4-8155-404d-9371-08d67b8dfe1a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 08:38:27.8293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3NAM01HT070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIwMTkvMS8xNiAxNTo1MSwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6DQo+IE9uIFdlZCwg
MTYgSmFuIDIwMTkgYXQgMDQ6MzcsIFl1ZXlpIExpIDxsaXl1ZXlpQGxpdmUuY29tPiB3cm90ZToN
Cj4+IE9LLCB0aGFua3MuIEJ1dCBzZWVtcyB0aGlzIG1haWwgYmUgaWdub3JlZCwgZG8gaSBuZWVk
IHJlLXNlbnQgdGhlIHBhdGNoPw0KPj4NCj4+IE9uIDIwMTgvMTIvMjYgMjE6NDksIEFyZCBCaWVz
aGV1dmVsIHdyb3RlOg0KPj4+IE9uIFR1ZSwgMjUgRGVjIDIwMTggYXQgMDM6MzAsIFl1ZXlpIExp
IDxsaXl1ZXlpQGxpdmUuY29tPiB3cm90ZToNCj4+Pj4gSGkgQXJkLA0KPj4+Pg0KPj4+Pg0KPj4+
PiBPbiAyMDE4LzEyLzI0IDE3OjQ1LCBBcmQgQmllc2hldXZlbCB3cm90ZToNCj4+Pj4+IERvZXMg
dGhlIGZvbGxvd2luZyBjaGFuZ2UgZml4IHlvdXIgaXNzdWUgYXMgd2VsbD8NCj4+Pj4+DQo+Pj4+
PiBpbmRleCA5YjQzMmQ5ZmNhZGEuLjlkY2YwZmY3NWExMSAxMDA2NDQNCj4+Pj4+IC0tLSBhL2Fy
Y2gvYXJtNjQvbW0vaW5pdC5jDQo+Pj4+PiArKysgYi9hcmNoL2FybTY0L21tL2luaXQuYw0KPj4+
Pj4gQEAgLTQ0Nyw3ICs0NDcsNyBAQCB2b2lkIF9faW5pdCBhcm02NF9tZW1ibG9ja19pbml0KHZv
aWQpDQo+Pj4+PiAgICAgICAgICAgICAgICAgICAgICogbWVtb3J5IHNwYW5zLCByYW5kb21pemUg
dGhlIGxpbmVhciByZWdpb24gYXMgd2VsbC4NCj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgKi8N
Cj4+Pj4+ICAgICAgICAgICAgICAgICAgICBpZiAobWVtc3RhcnRfb2Zmc2V0X3NlZWQgPiAwICYm
IHJhbmdlID49IEFSTTY0X01FTVNUQVJUX0FMSUdOKSB7DQo+Pj4+PiAtICAgICAgICAgICAgICAg
ICAgICAgICByYW5nZSA9IHJhbmdlIC8gQVJNNjRfTUVNU1RBUlRfQUxJR04gKyAxOw0KPj4+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgcmFuZ2UgLz0gQVJNNjRfTUVNU1RBUlRfQUxJR047DQo+
Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICBtZW1zdGFydF9hZGRyIC09IEFSTTY0X01F
TVNUQVJUX0FMSUdOICoNCj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKChyYW5nZSAqIG1lbXN0YXJ0X29mZnNldF9zZWVkKSA+PiAxNik7DQo+Pj4+PiAg
ICAgICAgICAgICAgICAgICAgfQ0KPj4+PiBZZXMsIGl0IGNhbiBmaXggdGhpcyBhbHNvLiBJIGp1
c3QgdGhpbmsgbW9kaWZ5IHRoZSBmaXJzdCAqcmFuZ2UqDQo+Pj4+IGNhbGN1bGF0aW9uIHdvdWxk
IGJlIGVhc2llciB0byBncmFzcCwgd2hhdCBkbyB5b3UgdGhpbms/DQo+Pj4+DQo+Pj4gSSBkb24n
dCB0aGluayB0aGVyZSBpcyBhIGRpZmZlcmVuY2UsIHRvIGJlIGhvbmVzdCwgYnV0IEkgd2lsbCBs
ZWF2ZSBpdA0KPj4+IHVwIHRvIHRoZSBtYWludGFpbmVycyB0byBkZWNpZGUgd2hpY2ggYXBwcm9h
Y2ggdGhleSBwcmVmZXIuDQo+IE5vIGl0IGhhcyBiZWVuIG1lcmdlZCBhbHJlYWR5LiBJdCBpcyBp
biB2NS4wLXJjMiBJIHRoaW5rLg0KDQpPSywgdGhhbmtzLiA6LSkNCg==
