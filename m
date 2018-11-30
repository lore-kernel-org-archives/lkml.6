Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D608C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371B3206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ASUiLGVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371B3206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeK3VyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:54:05 -0500
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:62617
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbeK3VyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:54:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhTXjIPjG5/gN3dGHo4JpbbFS6pBu8f/WkeD1BcWI6Q=;
 b=ASUiLGVIEfocqJq9biWKmAd8YYVEiNO8tmjgG30iIx6PLOgMS/iorsYenyc7UtIXU2t25b7Ce3z7FqDQgvrMeqJaN6V7S9PQQeJPtucPR+BR1q0qyHkrJ5G/ivKIIyVFMTTRbNxNWY5zn6S1+4NFEPlyjMMenZULc9QaWVGzHp4=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2302.eurprd08.prod.outlook.com (10.172.13.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 10:45:08 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1382.020; Fri, 30 Nov
 2018 10:45:08 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     nd <nd@arm.com>
Subject: Re: [PATCH 7/7] lib/lzo: separate lzo-rle from lzo
Thread-Topic: [PATCH 7/7] lib/lzo: separate lzo-rle from lzo
Thread-Index: AQHUhmz8mgLwzeoYokiWGTdfe93T2aVmL1CAgAH3WoA=
Date:   Fri, 30 Nov 2018 10:45:08 +0000
Message-ID: <5b504430-fb4b-340b-66c2-1300c816cc3a@arm.com>
References: <20181127161913.23863-1-dave.rodgman@arm.com>
 <20181127161913.23863-8-dave.rodgman@arm.com>
 <20181129044333.GH6379@jagdpanzerIV>
In-Reply-To: <20181129044333.GH6379@jagdpanzerIV>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LO2P265CA0221.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::17) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2302;6:gWgYkPU0OfluWAU/rdCQFStNCwRJjtdQqTQuE+75AkuK43Vr819e1RYI12GeeSMAHmHqZzqaFybDrKFLFJAJhDR/K9r37EEwyjpijVPE8djcNcmjqZS6hYx2coPb8xB9G4qRpgpw8g9yblE9B9piAtFBejrtiVOntJo1u78EiqDVrn9/BXXetpUh0qsnXLVqADP83EUClUZ4VMn1IXvlPi7C6zw6yu9d4oHkqvFMkzdN1pqkt3EAnFOZhbxxOjrw07npIep67sJWwTsKbgk6noBygRrv1f9FeRlcNcJjZUsKZYnJuWxMs079JCz6NpCOSUWSizarc4H0KNPMzwxntiziZ99hCWfRyQBGKjwtZCTg8e3iUBiddJebv/RoXsZpfZw+IukZJdEKcJgV7CwJwOSTuDPZuhMhq/tRWzzZ0lM5tUueR002a8mA4dbvXuDpuaNDdTY09PlCNePGd16EYA==;5:TA04bMjb3rVemOzOGQTSYQ1k7YWwIXLu0Lv0WF0M4kP8LhplEy58jfXbjcna8ZnLvOadvIghKEpDNG29E1w4yAhMgz0nV27LcP+I9krBmiMRrSp/uCuFC0A2QfJV4RDeuxUBF5jSw4XTss7zcDMhKMQOG6A236nAsbP4deFcEjQ=;7:/AUkBM1AVsh7D8H8pynMyFoQw5a8AehVag6eCQneuDoylE7bBEO9rkITlDay/LbEqaOZTXuj1NfdqLj2q+K4CVnPwb94NBSzH/AnCkn9oSHf2NyNtojUo57RvkRVXB7BA2IVFgZos3zoW23lQ4B0Vg==
x-ms-office365-filtering-correlation-id: 95ba5130-3503-4123-2f3c-08d656b0e56f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2302;
x-ms-traffictypediagnostic: VI1PR0802MB2302:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB2302EECCE2F7AC030C1764858FD30@VI1PR0802MB2302.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231453)(999002)(944501466)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2302;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2302;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(366004)(136003)(189003)(199004)(39060400002)(3846002)(4326008)(66066001)(2906002)(8936002)(6512007)(110136005)(2501003)(5660300001)(36756003)(256004)(31696002)(14454004)(2201001)(86362001)(6486002)(478600001)(71190400001)(99286004)(106356001)(7736002)(25786009)(71200400001)(186003)(102836004)(229853002)(26005)(6436002)(97736004)(105586002)(316002)(6246003)(53936002)(8676002)(6116002)(2616005)(81166006)(81156014)(11346002)(486006)(476003)(53546011)(6506007)(386003)(68736007)(305945005)(446003)(44832011)(52116002)(76176011)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2302;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 07wVGfBwUvx9zq4xZmqmRcUYN0IhUsXFJx43KF39tNrJgWoG0AUFTGZ0rvvrxnBnD3sU1Zw+GeBucU8dnyUIS5Ov1pmUajK02qLWo7DJ+juP4TEXbDtvhBeIozd227FQcrsRpr6jn2gT+xyOkfIiq0IiKUnPzmxnm6BMVzvO7paI7N7evUjy768oO9g/HixPlX7QRkNoESgc3HiN/a2uMzu5FGwEaAyyoPTvFxA4AxkCkAnNB9/3MoP9JLr3RcMGo7oOMlu9+S0YBH7N84XZT/aZTKM7jLEeYUpc3E8fVo1bilDklmO4eUizS8X7n8Vocu4QlPErL4xE8v1sT7NqqoYJpq7jJIu5YEsWRhbkoEk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DBEF794B5A4064BA3379D17127C2993@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ba5130-3503-4123-2f3c-08d656b0e56f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 10:45:08.7089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2302
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkvMTEvMjAxOCA0OjQzIGFtLCBTZXJnZXkgU2Vub3poYXRza3kgd3JvdGU6DQo+IE9uICgx
MS8yNy8xOCAxNjoxOSksIERhdmUgUm9kZ21hbiB3cm90ZTo+IA0KPj4gK3N0YXRpYyBzdHJ1Y3Qg
Y3J5cHRvX2FsZyBhbGcgPSB7DQo+PiArCS5jcmFfbmFtZQkJPSAibHpvLXJsZSIsDQo+PiArCS5j
cmFfZmxhZ3MJCT0gQ1JZUFRPX0FMR19UWVBFX0NPTVBSRVNTLA0KPj4gKwkuY3JhX2N0eHNpemUJ
CT0gc2l6ZW9mKHN0cnVjdCBsem9ybGVfY3R4KSwNCj4+ICsJLmNyYV9tb2R1bGUJCT0gVEhJU19N
T0RVTEUsDQo+PiArCS5jcmFfaW5pdAkJPSBsem9ybGVfaW5pdCwNCj4+ICsJLmNyYV9leGl0CQk9
IGx6b3JsZV9leGl0LA0KPj4gKwkuY3JhX3UJCQk9IHsgLmNvbXByZXNzID0gew0KPj4gKwkuY29h
X2NvbXByZXNzCQk9IGx6b3JsZV9jb21wcmVzcywNCj4+ICsJLmNvYV9kZWNvbXByZXNzCQk9IGx6
b3JsZV9kZWNvbXByZXNzIH0gfQ0KPj4gK307DQo+IA0KPiBBIG5pdHBpY2s6DQo+ICAgIGluZGVu
dGF0aW9uIGZvciAuY29tcHJlc3MgYXNzaWdubWVudCBpcyBhIGJpdCBjb25mdXNpbmcsIG1heWJl
Lg0KDQpMb29raW5nIGEgYml0IG1vcmUgY2xvc2VseSwgdGhlc2Ugc3RydWN0cyBhcmUgZm9ybWF0
dGVkIGZhaXJseSANCmluY29uc2lzdGVudGx5IGluIHRoZSBjcnlwdG8gZGlyZWN0b3J5LiBTbywg
bHpvLXJsZSBpcyBjb25zaXN0ZW50IHdpdGggDQp3aGF0IGx6byBkb2VzLi4uIGJ1dCB2YXJpb3Vz
IG90aGVyIGZpbGVzIGRvIGl0IGRpZmZlcmVudGx5Lg0KDQpJJ20gaGFwcHkgdG8gc3VibWl0IGEg
d2hpdGVzcGFjZSBjbGVhbnVwIHBhdGNoIGlmIHBlb3BsZSB3b3VsZCBsaWtlLCBhbmQgDQpnZXQg
ZXZlcnl0aGluZyBpbiB0aGF0IGRpcmVjdG9yeSBjb25zaXN0ZW50IChpLmUuIGFkb3B0IGEgc3R5
bGUgc2ltaWxhciANCnRvIHRoZSBleGFtcGxlIGJlbG93KT8NCg0Kc3RhdGljIHN0cnVjdCBzY29t
cF9hbGcgc2NvbXAgPSB7DQogICAgICAgICAuYWxsb2NfY3R4ICAgICAgICAgICAgICA9IGx6b3Js
ZV9hbGxvY19jdHgsDQogICAgICAgICAuZnJlZV9jdHggICAgICAgICAgICAgICA9IGx6b3JsZV9m
cmVlX2N0eCwNCiAgICAgICAgIC5jb21wcmVzcyAgICAgICAgICAgICAgID0gbHpvcmxlX3Njb21w
cmVzcywNCiAgICAgICAgIC5kZWNvbXByZXNzICAgICAgICAgICAgID0gbHpvcmxlX3NkZWNvbXBy
ZXNzLA0KICAgICAgICAgLmJhc2UgICAgICAgICAgICAgICAgICAgPSB7DQogICAgICAgICAgICAg
ICAgIC5jcmFfbmFtZSAgICAgICAgICAgICAgID0gImx6by1ybGUiLA0KICAgICAgICAgICAgICAg
ICAuY3JhX2RyaXZlcl9uYW1lICAgICAgICA9ICJsem8tcmxlLXNjb21wIiwNCiAgICAgICAgICAg
ICAgICAgLmNyYV9tb2R1bGUgICAgICAgICAgICAgPSBUSElTX01PRFVMRSwNCiAgICAgICAgIH0N
Cn07DQoNCkRhdmUNCg==
