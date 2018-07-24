Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23C3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E81F20893
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="Pw3Xg41K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E81F20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388524AbeGXI7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:59:50 -0400
Received: from mail-by2nam01on0081.outbound.protection.outlook.com ([104.47.34.81]:32724
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388351AbeGXI7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OOGcFNkp7hAprYYZ0g6f1VMX6rpizPG/jLOjtMoUME=;
 b=Pw3Xg41KAoJJ+AfSUjJx7/8lLofdtrRPZ1aJsAEr0t58dx7QSoM6Uf0uvp2iHON+nbNs1pOc41qKpYcFHyM4liQC5dUVqqXPD0XtpUxmgHZSfoiSERJMcxA6/5nZxmsW1z+dr3Ysf0ER8kaVPFdVhjLdjWvGHA4nYUB4cn9Hj0M=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB508.namprd06.prod.outlook.com (10.141.198.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 07:54:35 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287%7]) with mapi id 15.20.0973.022; Tue, 24 Jul 2018
 07:54:34 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     Hans Holmberg <hans.holmberg@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: recover chunk state on 1.2 devices
Thread-Topic: [PATCH] lightnvm: pblk: recover chunk state on 1.2 devices
Thread-Index: AQHUDsAqECp4D0lQUUKx9mO19FFp2KR1YqSAgAG0kwCAAAIjgIAAAc0AgCcOdIA=
Date:   Tue, 24 Jul 2018 07:54:33 +0000
Message-ID: <D6AFE2C1-D273-4945-9A12-D4A0A57FD108@cnexlabs.com>
References: <1530177121-24908-1-git-send-email-javier@cnexlabs.com>
 <1530177121-24908-2-git-send-email-javier@cnexlabs.com>
 <e42e5ab4-48c7-e822-618d-dc28c25262ed@lightnvm.io>
 <43D7E3C4-765F-46AB-9B84-27E37FCAE016@cnexlabs.com>
 <19b2f125-d373-cf2b-43c7-140b3872cd64@lightnvm.io>
In-Reply-To: <19b2f125-d373-cf2b-43c7-140b3872cd64@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB508;6:uFTYoQ+HmaPTniDZcpz4cI0uvtsiJVDCQFTY1qWvfM+hfY9n5hICJr6wDw2YLlq7ee+BZu0mijhCcIVeNWxHc9odCJtt5KGhzByz6iOcefN9pAhzMBIgrgOCJnZbkeCDQB72aOgyXjG30uJjbD9rWh+2zrgYGZFsJq9aAXw059gPzgiISpgoQ8h3UyLkGMuIKec6h77U91zcba4j4WRZKCPeZ2MEwjtyDxcq2kA1rmgRSg2E0fioxFFIqWJkZb9w+drIuQ5PufYonQx7VvREuZI/Yvp8GD+IdgHr7gB+rGutk2zfKiLbLlN2r8dAN7LjP8yb6Gdw9LpbAEbpFFDk8xwCrcg06K7t5Z5UH61yiXLMLqvPaXnftvqOngdUMtS876ZKKEuH1HYDSVTyxbDghKvuHIo9j2aMBTi9tMGTtdKfI8KCPyN5VCw4ewx2ZbjyRM87RFxnUDdijVu9xsuzRA==;5:0j6/giDfXOqRBBZPo45SkI7pdzATR9XqssE3TwU5uOGeek3EMSTH4+pJ5B0zX6yzDt94ErdVYsEdOb//R7WSIO0fEMhd9Q7+KU7yXhWHiJeDXhfG1FIszF26ELoOM78TfhWeI1VjhhaVh8bvY1LEUxXO8AW540LIPBt+vS16hX8=;7:URQXP10F/uSYrgCh+kL4SMdRId5ahtR9yCDGh6zuyhRCQIntl7/k+/zEtXGf6hzfk5Kd2ts5KyeznN2ES50lOr/YWawBa1dd1+OB2vMSg+rq6I9Yt5X0V7sDT/5ca/ezO3Gn4ykAcKv1V5b+t0B6kkMxuj9vSdiPRZAftrfD+ZutMlqA6skz1Ai3LyPrbe87rerqfsWHS4kqpjO7SRM/9Cy+9SCuXnp3f7N25rQ6Yh8UkSCw1O2z8EjSfW8yQNke
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39840400004)(366004)(396003)(346002)(136003)(376002)(189003)(199004)(105586002)(66066001)(106356001)(25786009)(6246003)(83716003)(4326008)(316002)(478600001)(6512007)(86362001)(54906003)(53936002)(6916009)(93886005)(82746002)(97736004)(99286004)(6436002)(76176011)(5660300001)(446003)(486006)(2616005)(36756003)(476003)(53546011)(26005)(102836004)(229853002)(11346002)(14454004)(6486002)(33656002)(8936002)(186003)(8676002)(6116002)(6506007)(81156014)(81166006)(3846002)(14444005)(305945005)(256004)(68736007)(5250100002)(2900100001)(2906002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB508;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 5f5ce00b-d222-4d29-62f4-08d5f13ab216
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CO2PR06MB508;
x-ms-traffictypediagnostic: CO2PR06MB508:
x-microsoft-antispam-prvs: <CO2PR06MB508490939C5B1C998DF7BCBBA550@CO2PR06MB508.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB508;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB508;
x-forefront-prvs: 0743E8D0A6
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: l1tFSHCcfIP8GUrY1/9A77wyytiTZtYNUp/VNmevPPLV//4vAQVwfQMYCf9o2IpRFbxjaHFoemwQl6wnNqQKFzhxS/wWx+RS/7tiyD4BHtQIM3f/Qizia2DTk+yMEJNVjq5AKX/Lv4N+5ylBIQcEs+K292ic9xXWcT/aBeGoKFjtEVu4ltvRKiFvOTL14GlUpQlyyAVdSv0/FEOnSOCfEFNFfsPl5ACbZAWK4y/0DOeCgClVwsIN6eTehPTG4e7rD7wa9AUO557VQztqgSRO+f9cs+jYtuI0VJhjmLIE6R/htcPOrYpS+jZArcRuGCq04lsqoMmUS35iZz8kUcu/vPEQf7LxvFZQzuvT7qWUJCg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <98B5A61EB5F8654EB19323470497C1F9@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5ce00b-d222-4d29-62f4-08d5f13ab216
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2018 07:54:34.0064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB508
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAyOSBKdW4gMjAxOCwgYXQgMTMuMjgsIE1hdGlhcyBCasO4cmxpbmcgPG1iQGxpZ2h0bnZt
LmlvPiB3cm90ZToNCj4gDQo+IE9uIDA2LzI5LzIwMTggMDE6MjIgUE0sIEphdmllciBHb256YWxl
eiB3cm90ZToNCj4+PiBPbiAyOSBKdW4gMjAxOCwgYXQgMTMuMTQsIE1hdGlhcyBCasO4cmxpbmcg
PG1iQGxpZ2h0bnZtLmlvPiB3cm90ZToNCj4+PiANCj4+PiBPbiAwNi8yOC8yMDE4IDExOjEyIEFN
LCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOg0KPj4+PiBUaGUgT3Blbi1DaGFubmVsIDEuMiBzcGVj
IGRvZXMgbm90IGRlZmluZSBhIG1lY2hhbmlzbSBmb3IgdGhlIGhvc3QgdG8NCj4+Pj4gcmVjb3Zl
ciB0aGUgYmxvY2sgKGNodW5rKSBzdGF0ZS4gQXMgYSBjb25zZXF1ZW5jZSwgYSBuZXdseSBmb3Jt
YXQgZGV2aWNlDQo+Pj4+IHdpbGwgbmVlZCB0byByZWNvbnN0cnVjdCB0aGUgc3RhdGUuIEN1cnJl
bnRseSwgcGJsayBhc3N1bWVzIHRoYXQgYmxvY2tzDQo+Pj4+IGFyZSBub3QgZXJhc2VkLCB3aGlj
aCBtaWdodCBjYXVzZSBkb3VibGUtZXJhc2VzIGluIGNhc2UgdGhhdCB0aGUgZGV2aWNlDQo+Pj4+
IGRvZXMgbm90IHByb3RlY3QgaXRzZWxmIGFnYWluc3QgdGhlbSAod2hpY2ggaXMgbm90IHNwZWNp
ZmllZCBpbiB0aGUgc3BlYw0KPj4+PiBlaXRoZXIpLg0KPj4+IA0KPj4+IEl0IHNob3VsZCBub3Qg
YmUgc3BlY2lmaWVkIGluIHRoZSBzcGVjLiBJdCBpcyB1cCB0byB0aGUgZGV2aWNlIHRvIGhhbmRs
ZQ0KPj4+IGRvdWJsZSBlcmFzZXMgYW5kIG5vdCBkbyBpdC4NCj4+PiANCj4+Pj4gVGhpcyBwYXRj
aCwgcmVjb25zdHJ1Y3RzIHRoZSBzdGF0ZSBiYXNlZCBvbiByZWFkIGVycm9ycy4gSWYgdGhlIGZp
cnN0DQo+Pj4+IHNlY3RvciBvZiBhIGJsb2NrIHJldHVybnMgYW5kIGVtcHR5IHBhZ2UgKE5WTV9S
U1BfRVJSX0VNUFRZUEFHRSksIHRoZW4NCj4+Pj4gdGhlIGJsb2NrIHMgbWFya2VkIGZyZWUsIGku
ZS4sIGVyYXNlZCBhbmQgcmVhZHkgdG8gYmUgdXNlZA0KPj4+PiAoTlZNX0NIS19TVF9GUkVFKS4g
T3RoZXJ3aXNlLCB0aGUgYmxvY2sgaXMgbWFya2VkIGFzIGNsb3NlZA0KPj4+PiAoTlZNX0NIS19T
VF9DTE9TRUQpLiBOb3RlIHRoYXQgZXZlbiBpZiBhIGJsb2NrIGlzIG9wZW4gYW5kIG5vdCBmdWxs
eQ0KPj4+PiB3cml0dGVuLCBpdCBoYXMgdG8gYmUgZXJhc2VkIGluIG9yZGVyIHRvIGJlIHVzZWQg
YWdhaW4uDQo+Pj4gDQo+Pj4gU2hvdWxkIHdlIGV4dGVuZCBpdCB0byBkbyB0aGUgc2NhbiwgYW5k
IHVwZGF0ZSB0aGUgd3JpdGUgcG9pbnRlciBhcw0KPj4+IHdlbGw/IEkgdGhpbmsgdGhpcyBraW5k
IG9mIGZlYXR1cmUgYWxyZWFkeSBpcyBiYWtlZCBpbnRvIHBibGs/DQo+PiBUaGlzIGlzIGFscmVh
ZHkgaW4gcGxhY2U6IHdlIHNjYW4gdW50aWwgZW1wdHkgcGFnZSBhbmQgdGFrZSBpdCBmcm9tDQo+
PiB0aGVyZS4gVGhpcyBwYXRjaCBpcyBvbmx5IGZvciB0aGUgY2FzZSBpbiB3aGljaCB3ZSBzdGFy
dCBhIHBibGsgaW5zdGFuY2UNCj4+IGZvcm0gc2NyYXRjaC4gT24gYSBkZXZpY2UgYWxyZWFkeSBv
d25lZCBieSBwYmxrLCB3ZSB3b3VsZCBub3QgaGF2ZSB0aGUNCj4+IHByb2JsZW0gd2UgYXJlIHRy
eWluZyB0byBzb2x2ZSBoZXJlIGJlY2F1c2Ugd2Uga25vdyB0aGUgc3RhdGUuDQo+IA0KPiBBZ3Jl
ZS4gV2hhdCBJIG1lYW50IHdhcyB0aGF0IHdoZW4gd2UgYW55d2F5IGFyZSByZWNvdmVyaW5nIHRo
ZSBzdGF0ZSwNCj4gd2UgY291bGQganVzdCBhcyB3ZWxsIHVwZGF0ZSAtPndwIGFuZCBzZXQgdG8g
TlZNX0NIS19TVF9PUEVOIGFuZCBzbw0KPiBmb3J0aCBmb3IgdGhlIGluaXRpYWxpemF0aW9uIHBo
YXNlLg0KPiANCg0KSW4gMS4yIHRoZSB1c2Ugb2YgY2h1bmsgbWV0YWRhdGEgaXMgcHVyZWx5IGZp
Y3Rpb25hbC4gV2UgcmVzcGVjdCB0aGUNCmNodW5rIHN0YXRlIG1hY2hpbmUgYXMgd2UgdHJhbnNp
dGlvbiBsaW5lcywgYnV0IGFsbCB0aGUgd3JpdGUgcG9pbnRlcnMNCmFyZSBpZ25vcmVkLiBJbnN0
ZWFkLCB3ZSB1c2UgdGhlIGxpbmUgYml0bWFwIHRvIHBvaW50IHRvIHRoZSBuZXh0DQp3cml0YWJs
ZSBlbnRyeS4gVGhpcyBpcyBCVFcgdGhlIHNhbWUgd2F5IHdlIGl0IGluIG9wZW4gbGluZXMgb24g
Mi4wIHRvby4NCg0KQ2h1bmsgbWV0YWRhdGEgaXMgb25seSB1c2VkIHRvIHNldHVwIHRoZSBiaXRt
YXBzIG9uIGluaXQvcmVjb3ZlcnkuIEZyb20NCmhlcmUgb24sIHdlIHVzZSB0aGUgYml0bWFwIHRv
IGZpbmQgdGhlIG5leHQgd3JpdGFibGUgc2VjdG9yLCB3aXRob3V0DQp3b3JyeWluZyBhYm91dCB0
aGUgc3BlY2lmaWMgcGVyLWNodW5rIHdyaXRlIHBvaW50ZXIuIFRodXMsIHVwZGF0aW5nDQpjaHVu
ayBtZXRhZGF0YSBoZXJlIGhhcyBubyBlZmZlY3QuDQoNCkRvZXMgdGhpcyBtYWtlIHNlbnNlIHRv
IHlvdT8NCg0KSmF2aWVy
