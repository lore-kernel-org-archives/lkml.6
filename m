Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3D3C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11F72082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ok6VhZ/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F11F72082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbeLCKeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:34:07 -0500
Received: from mail-eopbgr140042.outbound.protection.outlook.com ([40.107.14.42]:52057
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725947AbeLCKeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL9sQ9CNXk/Ddce8sg2HStetp/IA5BzlRevH07kk/t4=;
 b=ok6VhZ/FNYHnKxZRAg+xHpmuzCgDc4VPCU9QdnLUFObdwEUmwDewvs/4jD1r/usSbXBSVKa+P+CKy5AIqCx/qa0Q9dQNlK4RH/sk2eNiyER69hDj507Lu+3h0NoVaePu3R27XAvWFz6l08hZjpEMMuu265VDHkkxy2WgVevTlGg=
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com (52.134.110.24) by
 DB7PR08MB3628.eurprd08.prod.outlook.com (20.177.120.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 10:33:34 +0000
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::971:f108:751f:a081]) by DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::971:f108:751f:a081%4]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 10:33:34 +0000
From:   Julien Thierry <Julien.Thierry@arm.com>
To:     Mark Rutland <Mark.Rutland@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoffer Dall <Christoffer.Dall@arm.com>,
        James Morse <James.Morse@arm.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>
Subject: Re: [PATCH v6 03/24] arm64: cpufeature: Add cpufeature for IRQ
 priority masking
Thread-Topic: [PATCH v6 03/24] arm64: cpufeature: Add cpufeature for IRQ
 priority masking
Thread-Index: AQHUen7n/WwLlgLNB0KOZP7C5Kq2z6VnGG8AgAXZ2QA=
Date:   Mon, 3 Dec 2018 10:33:34 +0000
Message-ID: <a6529e7b-1191-7ec0-8adf-8d512b57b78d@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-4-git-send-email-julien.thierry@arm.com>
 <20181129171231.ho5a3hx3ig3skm2x@lakrids.cambridge.arm.com>
In-Reply-To: <20181129171231.ho5a3hx3ig3skm2x@lakrids.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0032.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::20) To DB7PR08MB3082.eurprd08.prod.outlook.com
 (2603:10a6:5:1d::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Julien.Thierry@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.51]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR08MB3628;6:ugtQBVv8Re8UJTSN7Y1/7qmcWVKm3kK/XEZ+lcL1nIvAIrdiJWJpKDG+FloW9s+InfseCSeLkRaG5X6m8XeTVTIb39ugO/NFC56eszG6pJ//VmFVjBUFsFfChH2RzmvQB2WioxewEsZDf8S3zkdXXxyW3RR4W7o3wH/FzQCdzjB7mGwGIbQupKg6ru4Pzxh8TSEg/18bfDe5140oatHULCR2PPkyvWhcNAvPPT6herz4VuMSevZvuDT4rndtAJTMpD5ppg9AIP+fwLIkgdYpf3VoHury4Bq6BuF708aB70NEpA3Hw3I8Vwz2x1z/xI/W1fMnzt7++gO0EcK9U9MX30y+wkOBB1IxYeGJP7EMXyMVAT1qR3V8hLbgjfsu+vaaQuo1jBDUut5tf2kCpgS6tbOmXFYSanLFpZdLc6HlaKU8i+4Fozja+SCgs7rsv2LNt3IjgLlbPN3KFEL+QSFQ7A==;5:kff7sg0gr5+93C16Y5KbgJ0j177RirJFLfGmVrEubPFnOxQApdCD3CWnLXlNZOZDUq2stAsOuIKODS6MC+pGQcCoB1Wz3iD3B/x0hzZMkDCYkiKoFc/58lCct8XoyAefwfA5fFvfcn7nQOTQ/U2IJ4zzIhWOsYx2cPadiTUCtuA=;7:Bv9FDcj51q4jxmXX4KNS/CcoKKEd2M0TWMe9YCcABVe9BG9jp8CVqk2rG47Uh+tNuSXNFMpOh3u6neHtVTshoY3A4ULEh0J2DDq3YsuvHnOfHWJjbxuPO+YFeaM9O6sIHkYNNHT1BOE6vFbkletPgQ==
x-ms-office365-filtering-correlation-id: 301b50e4-bf29-40ec-7ba9-08d6590ac6c1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3628;
x-ms-traffictypediagnostic: DB7PR08MB3628:
x-microsoft-antispam-prvs: <DB7PR08MB36285012467A5EE52CCEC49E9DAE0@DB7PR08MB3628.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501493)(4982022)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB7PR08MB3628;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3628;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(346002)(376002)(40434004)(189003)(199004)(68736007)(81156014)(6436002)(6116002)(8936002)(305945005)(476003)(478600001)(81166006)(72206003)(44832011)(7736002)(4326008)(53936002)(3846002)(31686004)(2616005)(6306002)(6512007)(486006)(5660300001)(446003)(86362001)(11346002)(97736004)(105586002)(6636002)(229853002)(6862004)(99286004)(26005)(186003)(76176011)(14454004)(52116002)(6246003)(25786009)(106356001)(31696002)(386003)(53546011)(102836004)(2906002)(14444005)(256004)(5024004)(316002)(37006003)(36756003)(66066001)(6486002)(966005)(71190400001)(71200400001)(8676002)(54906003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3628;H:DB7PR08MB3082.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CA4g+Nb3Yv+l/dQb+ENU0ncWCQksB4HthOAAz+Do342bv4/i+tQBqtpKglPXVi5squLfjqtw3r2ymZFAIt4C5W9m1Q6osEqFyLfxlWIEnSs/CeAofUz3j7lcrnLJvoqpq5PP7YpK0bDg0n/DmPllsWf6p7d+ebVjAp0usSeUY9MN4eROgoUEhLA9mJql5sBiVPw+87UX84zmz8QXHFh6hGPAYnhUoDV4ToOCn7019I0Y68jUhUynT//NMMvnszmBRa3F4W7ZPJJQgEmgHtB1a1kAe559oumFQnVy7CYtShvM01liayowcp/kG5z45+eVIOkAn3WBkEEwbP+NAaMlLjhxXGZFDftKH06rY8vc6Kg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <902ED79CEF9B7442A2EC60CD001C44E0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 301b50e4-bf29-40ec-7ba9-08d6590ac6c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 10:33:34.4351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3628
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDI5LzExLzE4IDE3OjEyLCBNYXJrIFJ1dGxhbmQgd3JvdGU6DQo+IE9uIE1vbiwgTm92
IDEyLCAyMDE4IGF0IDExOjU2OjU0QU0gKzAwMDAsIEp1bGllbiBUaGllcnJ5IHdyb3RlOg0KPj4g
QWRkIGEgY3B1ZmVhdHVyZSBpbmRpY2F0aW5nIHdoZXRoZXIgYSBjcHUgc3VwcG9ydHMgbWFza2lu
ZyBpbnRlcnJ1cHRzDQo+PiBieSBwcmlvcml0eS4NCj4+DQo+PiBUaGUgZmVhdHVyZSB3aWxsIGJl
IHByb3Blcmx5IGVuYWJsZWQgaW4gYSBsYXRlciBwYXRjaC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBKdWxpZW4gVGhpZXJyeSA8anVsaWVuLnRoaWVycnlAYXJtLmNvbT4NCj4+IENjOiBDYXRhbGlu
IE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPg0KPj4gQ2M6IFdpbGwgRGVhY29uIDx3
aWxsLmRlYWNvbkBhcm0uY29tPg0KPj4gQ2M6IE1hcmMgWnluZ2llciA8bWFyYy56eW5naWVyQGFy
bS5jb20+DQo+PiBDYzogU3V6dWtpIEsgUG91bG9zZSA8c3V6dWtpLnBvdWxvc2VAYXJtLmNvbT4N
Cj4+IC0tLQ0KPj4gIGFyY2gvYXJtNjQvaW5jbHVkZS9hc20vY3B1Y2Fwcy5oICAgIHwgIDMgKyst
DQo+PiAgYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9jcHVmZWF0dXJlLmggfCAgNiArKysrKysNCj4+
ICBhcmNoL2FybTY0L2tlcm5lbC9jcHVmZWF0dXJlLmMgICAgICB8IDIzICsrKysrKysrKysrKysr
KysrKysrKysrDQo+PiAgMyBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vY3B1Y2Fw
cy5oIGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9jcHVjYXBzLmgNCj4+IGluZGV4IDZlMmQyNTQu
LmYzNjdlNWMgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2NwdWNhcHMu
aA0KPj4gKysrIGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9jcHVjYXBzLmgNCj4+IEBAIC01NCw3
ICs1NCw4IEBADQo+PiAgI2RlZmluZSBBUk02NF9IQVNfQ1JDMzIzMw0KPj4gICNkZWZpbmUgQVJN
NjRfU1NCUzM0DQo+PiAgI2RlZmluZSBBUk02NF9XT1JLQVJPVU5EXzExODg4NzMzNQ0KPj4gKyNk
ZWZpbmUgQVJNNjRfSEFTX0lSUV9QUklPX01BU0tJTkczNg0KPj4NCj4+IC0jZGVmaW5lIEFSTTY0
X05DQVBTMzYNCj4+ICsjZGVmaW5lIEFSTTY0X05DQVBTMzcNCj4+DQo+PiAgI2VuZGlmIC8qIF9f
QVNNX0NQVUNBUFNfSCAqLw0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20v
Y3B1ZmVhdHVyZS5oIGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9jcHVmZWF0dXJlLmgNCj4+IGlu
ZGV4IDdlMmVjNjQuLmE2ZTA2M2YgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL2FybTY0L2luY2x1ZGUv
YXNtL2NwdWZlYXR1cmUuaA0KPj4gKysrIGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9jcHVmZWF0
dXJlLmgNCj4+IEBAIC01MTQsNiArNTE0LDEyIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBzeXN0ZW1f
c3VwcG9ydHNfY25wKHZvaWQpDQo+PiAgY3B1c19oYXZlX2NvbnN0X2NhcChBUk02NF9IQVNfQ05Q
KTsNCj4+ICB9DQo+Pg0KPj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBzeXN0ZW1fc3VwcG9ydHNfaXJx
X3ByaW9fbWFza2luZyh2b2lkKQ0KPj4gK3sNCj4+ICtyZXR1cm4gSVNfRU5BQkxFRChDT05GSUdf
QVJNNjRfUFNFVURPX05NSSkgJiYNCj4+ICsgICAgICAgY3B1c19oYXZlX2NvbnN0X2NhcChBUk02
NF9IQVNfSVJRX1BSSU9fTUFTS0lORyk7DQo+PiArfQ0KPg0KPiBUaGlzIHNob3VsZCBwcm9iYWJs
eSBiZSBzL3N1cHBvcnRzL3VzZXMvLg0KPg0KDQpGaXhlZCBsb2NhbGx5Lg0KDQo+IFdpdGggdGhh
dDoNCj4NCj4gUmV2aWV3ZWQtYnk6IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+
DQo+DQoNClRoYW5rcywNCg0KSnVsaWVuDQoNCj4gTWFyay4NCj4NCj4+ICsNCj4+ICAjZGVmaW5l
IEFSTTY0X1NTQkRfVU5LTk9XTi0xDQo+PiAgI2RlZmluZSBBUk02NF9TU0JEX0ZPUkNFX0RJU0FC
TEUwDQo+PiAgI2RlZmluZSBBUk02NF9TU0JEX0tFUk5FTDENCj4+IGRpZmYgLS1naXQgYS9hcmNo
L2FybTY0L2tlcm5lbC9jcHVmZWF0dXJlLmMgYi9hcmNoL2FybTY0L2tlcm5lbC9jcHVmZWF0dXJl
LmMNCj4+IGluZGV4IDAzYTlkOTYuLjFiNWI1NTMgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL2FybTY0
L2tlcm5lbC9jcHVmZWF0dXJlLmMNCj4+ICsrKyBiL2FyY2gvYXJtNjQva2VybmVsL2NwdWZlYXR1
cmUuYw0KPj4gQEAgLTExNDUsNiArMTE0NSwxNCBAQCBzdGF0aWMgdm9pZCBjcHVfY2xlYXJfZGlz
cihjb25zdCBzdHJ1Y3QgYXJtNjRfY3B1X2NhcGFiaWxpdGllcyAqX191bnVzZWQpDQo+PiAgfQ0K
Pj4gICNlbmRpZiAvKiBDT05GSUdfQVJNNjRfUkFTX0VYVE4gKi8NCj4+DQo+PiArI2lmZGVmIENP
TkZJR19BUk02NF9QU0VVRE9fTk1JDQo+PiArc3RhdGljIGJvb2wgY2FuX3VzZV9naWNfcHJpb3Jp
dGllcyhjb25zdCBzdHJ1Y3QgYXJtNjRfY3B1X2NhcGFiaWxpdGllcyAqZW50cnksDQo+PiArICAg
aW50IHNjb3BlKQ0KPj4gK3sNCj4+ICtyZXR1cm4gZmFsc2U7DQo+PiArfQ0KPj4gKyNlbmRpZg0K
Pj4gKw0KPj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXJtNjRfY3B1X2NhcGFiaWxpdGllcyBhcm02
NF9mZWF0dXJlc1tdID0gew0KPj4gIHsNCj4+ICAuZGVzYyA9ICJHSUMgc3lzdGVtIHJlZ2lzdGVy
IENQVSBpbnRlcmZhY2UiLA0KPj4gQEAgLTEzNjgsNiArMTM3NiwyMSBAQCBzdGF0aWMgdm9pZCBj
cHVfY2xlYXJfZGlzcihjb25zdCBzdHJ1Y3QgYXJtNjRfY3B1X2NhcGFiaWxpdGllcyAqX191bnVz
ZWQpDQo+PiAgLmNwdV9lbmFibGUgPSBjcHVfZW5hYmxlX2NucCwNCj4+ICB9LA0KPj4gICNlbmRp
Zg0KPj4gKyNpZmRlZiBDT05GSUdfQVJNNjRfUFNFVURPX05NSQ0KPj4gK3sNCj4+ICsvKg0KPj4g
KyAqIERlcGVuZHMgb24gaGF2aW5nIEdJQ3YzDQo+PiArICovDQo+PiArLmRlc2MgPSAiSVJRIHBy
aW9yaXR5IG1hc2tpbmciLA0KPj4gKy5jYXBhYmlsaXR5ID0gQVJNNjRfSEFTX0lSUV9QUklPX01B
U0tJTkcsDQo+PiArLnR5cGUgPSBBUk02NF9DUFVDQVBfU1RSSUNUX0JPT1RfQ1BVX0ZFQVRVUkUs
DQo+PiArLm1hdGNoZXMgPSBjYW5fdXNlX2dpY19wcmlvcml0aWVzLA0KPj4gKy5zeXNfcmVnID0g
U1lTX0lEX0FBNjRQRlIwX0VMMSwNCj4+ICsuZmllbGRfcG9zID0gSURfQUE2NFBGUjBfR0lDX1NI
SUZULA0KPj4gKy5zaWduID0gRlRSX1VOU0lHTkVELA0KPj4gKy5taW5fZmllbGRfdmFsdWUgPSAx
LA0KPj4gK30sDQo+PiArI2VuZGlmDQo+PiAge30sDQo+PiAgfTsNCj4+DQo+PiAtLQ0KPj4gMS45
LjENCj4+DQo+Pg0KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18NCj4+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+PiBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbA0KDQotLQ0KSnVsaWVuIFRoaWVycnkNCklN
UE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNo
bWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91
IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVy
IGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhl
ciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGlu
Zm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
