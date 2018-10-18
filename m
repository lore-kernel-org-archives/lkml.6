Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452D9C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A626C204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="pVrJtvIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A626C204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbeJSCQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:16:22 -0400
Received: from mail-sn1nam01on0073.outbound.protection.outlook.com ([104.47.32.73]:20896
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726698AbeJSCQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BXACWuOIuwkSn1gRaVhP2gg3RHPZz8kyq2eDL+PGow=;
 b=pVrJtvIyaFCtH6iLX51r0blrKCeK5zzYD4OWu7upoOmQAWJywPfX1kMazPMJI0YNeJ2bAkZDFWaGJwcuxO7knHWhU3hyBKEU7QuzKr/AVVSNgNI5teSDaZG9sgnGUO/izU4VBb9GLlsw35ZWIjLvsdwXJzovYAJgMnSG32tOEGE=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5047.namprd05.prod.outlook.com (20.177.230.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.19; Thu, 18 Oct 2018 18:14:09 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%5]) with mapi id 15.20.1250.024; Thu, 18 Oct 2018
 18:14:09 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>
CC:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [RFC PATCH 1/5] x86: introduce preemption disable prefix
Thread-Topic: [RFC PATCH 1/5] x86: introduce preemption disable prefix
Thread-Index: AQHUZn1pCzXLEno8kUGEBsbCNoIC6KUkNS4AgABtUoCAAK09gA==
Date:   Thu, 18 Oct 2018 18:14:09 +0000
Message-ID: <6A5CE8F9-EA36-4A4F-94B3-BAD1642F574C@vmware.com>
References: <20181018005420.82993-1-namit@vmware.com>
 <20181018005420.82993-2-namit@vmware.com>
 <D247AB7C-2890-49CE-B102-163E5B368FC2@amacapital.net>
 <20181018075405.GS3121@hirez.programming.kicks-ass.net>
In-Reply-To: <20181018075405.GS3121@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5047;20:YFAxdzPCwoIv3m5LBLZer4x+JaXbmNZujXrCOWepfRyBoQvC2KJxnDnTEqlH+eJQ9mKrzDgTsjpFkfpAPDuocnci+hgtFadfe3BtdDhJNt63/EdpA7MA/J1MKKc+izhgeMHAaY0fFqG1AXl5c+gg/NxH9KCTIlZOZdol2cLXLkk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 817af1e5-16c1-49f5-d932-08d635257fda
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5047;
x-ms-traffictypediagnostic: BYAPR05MB5047:
x-microsoft-antispam-prvs: <BYAPR05MB5047D5D37F5D02A9B35DC0A8D0F80@BYAPR05MB5047.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5047;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5047;
x-forefront-prvs: 08296C9B35
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(366004)(189003)(199004)(5660300001)(316002)(8936002)(7416002)(4326008)(93886005)(8676002)(2900100001)(36756003)(3846002)(6116002)(81166006)(478600001)(54906003)(66066001)(82746002)(6486002)(71190400001)(2906002)(6436002)(110136005)(81156014)(486006)(68736007)(229853002)(2616005)(476003)(99286004)(14454004)(53936002)(446003)(6512007)(217873002)(186003)(105586002)(33656002)(83716004)(97736004)(26005)(7736002)(6506007)(256004)(6246003)(53546011)(14444005)(5250100002)(102836004)(86362001)(25786009)(71200400001)(76176011)(11346002)(305945005)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5047;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sqkkdcJ1KaSIMM9H0OIYmL8Ygy8RlMWF7ipC9cIlffP9vA9qlDXSpFvy61o6m9Wt4+YZlf59s0nadMsRA7zZdJSTrnGrGVwjIocT1Tedpj+4ZoCTnhW2KEac4yB/ve4qMuzEYQfvO7mfz0elcbarAPiJhK/0tYzogX7WQ7rqTfTD+SluYlJr63zEt5NDW7fth+UL4gt5xjWtKFgNTP+q+9RTBU/KRjcDKhhArrYKepjBzMDVQCrvpSQMooxjLCk5OpirAqqXzGkvCKSwLEm5Li+cWd0V8A+E/cRLzyAe3CU4w32vbadgFar8zOsxcMjz+tgVuAv/fMUSd7GcD/KcicNGfYmxhTWiNq7K3gAiKEU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D27E67CBD28199448E850A173F894261@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817af1e5-16c1-49f5-d932-08d635257fda
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2018 18:14:09.2743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMTI6NTQgQU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4gd3JvdGU6
DQoNCj4gT24gV2VkLCBPY3QgMTcsIDIwMTggYXQgMDY6MjI6NDhQTSAtMDcwMCwgQW5keSBMdXRv
bWlyc2tpIHdyb3RlOg0KPj4+IE9uIE9jdCAxNywgMjAxOCwgYXQgNTo1NCBQTSwgTmFkYXYgQW1p
dCA8bmFtaXRAdm13YXJlLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gSXQgaXMgc29tZXRpbWVzIGJl
bmVmaWNpYWwgdG8gcHJldmVudCBwcmVlbXB0aW9uIGZvciB2ZXJ5IGZldw0KPj4+IGluc3RydWN0
aW9ucywgb3IgcHJldmVudCBwcmVlbXB0aW9uIGZvciBzb21lIGluc3RydWN0aW9ucyB0aGF0IHBy
ZWNlZGUNCj4+PiBhIGJyYW5jaCAodGhpcyBsYXR0ZXIgY2FzZSB3aWxsIGJlIGludHJvZHVjZWQg
aW4gdGhlIG5leHQgcGF0Y2hlcykuDQo+Pj4gDQo+Pj4gVG8gcHJvdmlkZSBzdWNoIGZ1bmN0aW9u
YWxpdHkgb24geDg2LTY0LCB3ZSB1c2UgYW4gZW1wdHkgUkVYLXByZWZpeA0KPj4+IChvcGNvZGUg
MHg0MCkgYXMgYW4gaW5kaWNhdGlvbiB0aGF0IHByZWVtcHRpb24gaXMgZGlzYWJsZWQgZm9yIHRo
ZQ0KPj4+IGZvbGxvd2luZyBpbnN0cnVjdGlvbi4NCj4+IA0KPj4gTmlmdHkhDQo+PiANCj4+IFRo
YXQgYmVpbmcgc2FpZCwgSSB0aGluayB5b3UgaGF2ZSBhIGZldyBidWdzLg0KPiANCj4+IEZpcnN0
LCB5b3UgY2Fu4oCZdCBqdXN0IGlnbm9yZSBhIHJlc2NoZWR1bGluZyBpbnRlcnJ1cHQsIGFzIHlv
dQ0KPj4gaW50cm9kdWNlIHVuYm91bmRlZCBsYXRlbmN5IHdoZW4gdGhpcyBoYXBwZW5zIOKAlCB5
b3XigJlyZSBlZmZlY3RpdmVseQ0KPj4gZW11bGF0aW5nIHByZWVtcHRfZW5hYmxlX25vX3Jlc2No
ZWQoKSwgd2hpY2ggaXMgbm90IGEgZHJvcC1pbg0KPj4gcmVwbGFjZW1lbnQgZm9yIHByZWVtcHRf
ZW5hYmxlKCkuDQo+IA0KPj4gVG8gZml4IHRoaXMsIHlvdSBtYXkgbmVlZCB0byBqdW1wIHRvIGEg
c2xvdy1wYXRoIHRyYW1wb2xpbmUgdGhhdCBjYWxscw0KPj4gc2NoZWR1bGUoKSBhdCB0aGUgZW5k
IG9yIGNvbnNpZGVyIHJld2luZGluZyBvbmUgaW5zdHJ1Y3Rpb24gaW5zdGVhZC4NCj4+IE9yIHVz
ZSBURiwgd2hpY2ggaXMgb25seSBhIGxpdHRsZSBiaXQgdGVycmlmeWluZy4uLg0KPiANCj4gQXQg
d2hpY2ggcG9pbnQgd2UncmUgdmVyeSBjbG9zZSB0byBpbi1rZXJuZWwgcnNlcS4NCg0KSW50ZXJl
c3RpbmcuIBBJIGRpZG7igJl0IGtub3cgYWJvdXQgdGhpcyBmZWF0dXJlLiBJ4oCZbGwgc2VlIGlm
IEkgY2FuIGRyYXcgc29tZQ0KaWRlYXMgZnJvbSB0aGVyZS4NCg0K
