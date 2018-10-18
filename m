Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ED9ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E94E20838
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="WEggnml0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E94E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeJRLZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 07:25:29 -0400
Received: from mail-eopbgr680040.outbound.protection.outlook.com ([40.107.68.40]:41871
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727272AbeJRLZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 07:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcTH0huJZGTcGnIcPldyGU6hPXLuDpoNeFZSl/3ha8A=;
 b=WEggnml0U3592JWhyPrg3HqBjm80QoIlW6wKH5fc/c9W8X8GHNL3zpYZ9641SUHO6B+XCQRjVqf6cSGbRb5Wglf/cyfbNJZ4u3se4/qMgMrrGzXybvxV/9v4CAVrLqhtaDvr2CTAMLkAUHDjTklBYl96y68mD+fec9YJedhiyo4=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4071.namprd05.prod.outlook.com (52.135.199.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.14; Thu, 18 Oct 2018 03:26:36 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%5]) with mapi id 15.20.1250.020; Thu, 18 Oct 2018
 03:26:36 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@amacapital.net>
CC:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [RFC PATCH 1/5] x86: introduce preemption disable prefix
Thread-Topic: [RFC PATCH 1/5] x86: introduce preemption disable prefix
Thread-Index: AQHUZn1pCzXLEno8kUGEBsbCNoIC6KUkNS4AgAAefQCAAAQXAA==
Date:   Thu, 18 Oct 2018 03:26:36 +0000
Message-ID: <D6DFB6E0-B7B7-4FAB-A6BE-A2DFE4642069@vmware.com>
References: <20181018005420.82993-1-namit@vmware.com>
 <20181018005420.82993-2-namit@vmware.com>
 <D247AB7C-2890-49CE-B102-163E5B368FC2@amacapital.net>
 <07255D2B-0243-4254-B62A-37050C44207E@vmware.com>
In-Reply-To: <07255D2B-0243-4254-B62A-37050C44207E@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [24.23.137.57]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4071;20:9hG7WBOPhFXQFuRYsxeHtLXeIh+JqVeAkH5nLLT64R9qf3HvM5fO3bZ/KEF9uOhsxxeApnjFlL1P9rBkMbK9kakmem0dKBE+OmI0X/kRi0PZWqtsI+4MBG6xLC+9Z/Q7wwwozSifEV+V1RGfCVKjzSk/NzLg7ZeYeKAJj2aBLOw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 869bb485-68ef-4219-99dc-08d634a98290
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4071;
x-ms-traffictypediagnostic: BYAPR05MB4071:
x-microsoft-antispam-prvs: <BYAPR05MB4071CEB5DC27ECD5DB58A537D0F80@BYAPR05MB4071.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4071;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4071;
x-forefront-prvs: 08296C9B35
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39860400002)(396003)(136003)(51444003)(199004)(189003)(8936002)(99286004)(14454004)(81166006)(81156014)(2906002)(478600001)(76176011)(476003)(36756003)(7416002)(68736007)(11346002)(6916009)(105586002)(8676002)(97736004)(6512007)(5660300001)(2616005)(106356001)(54906003)(6486002)(186003)(316002)(86362001)(217873002)(83716004)(6116002)(71200400001)(229853002)(14444005)(66066001)(53546011)(4326008)(6246003)(305945005)(82746002)(5250100002)(7736002)(6436002)(33656002)(93886005)(53936002)(256004)(25786009)(102836004)(71190400001)(2900100001)(3846002)(26005)(6506007)(446003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4071;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FZle6vj6uQspPFGMrafE39R9P0lfK5VjT7ynWwtHEW9RWGumoFZfQOUnGvN964V6vtbtflxTOXkMUOQ8RKHVELMoIHEKr829dKAVq2zXPrHC65nkWJyzn8yHUHsA2yVBaynjQB6/ruywTe5+mRqZf0UFipDy1yd8maJyziLbaCqkP7dOZjRCuswP/jqxPCNNS86WQSBHrnVfvKBGv8sH+raRLdVQBJvAMPNuOaNVT9wzTDdCYrSOu8x2WTx6+5l9ti2q51YwNudF71f3Mdm243clLq6w6h2Behk7u0Rz6RcvbtJXnGNB6hLcxcJvbkvtJrqVtyxaaHZyl1w2XrU+v6XrX27WgP+wEXxtAkyhjY0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E7A29530CC0F547B1113E4DA3BE15DE@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 869bb485-68ef-4219-99dc-08d634a98290
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2018 03:26:36.2484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgODoxMSBQTSwgTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4gd3JvdGU6DQoNCj4gYXQg
NjoyMiBQTSwgQW5keSBMdXRvbWlyc2tpIDxsdXRvQGFtYWNhcGl0YWwubmV0PiB3cm90ZToNCj4g
DQo+Pj4gT24gT2N0IDE3LCAyMDE4LCBhdCA1OjU0IFBNLCBOYWRhdiBBbWl0IDxuYW1pdEB2bXdh
cmUuY29tPiB3cm90ZToNCj4+PiANCj4+PiBJdCBpcyBzb21ldGltZXMgYmVuZWZpY2lhbCB0byBw
cmV2ZW50IHByZWVtcHRpb24gZm9yIHZlcnkgZmV3DQo+Pj4gaW5zdHJ1Y3Rpb25zLCBvciBwcmV2
ZW50IHByZWVtcHRpb24gZm9yIHNvbWUgaW5zdHJ1Y3Rpb25zIHRoYXQgcHJlY2VkZQ0KPj4+IGEg
YnJhbmNoICh0aGlzIGxhdHRlciBjYXNlIHdpbGwgYmUgaW50cm9kdWNlZCBpbiB0aGUgbmV4dCBw
YXRjaGVzKS4NCj4+PiANCj4+PiBUbyBwcm92aWRlIHN1Y2ggZnVuY3Rpb25hbGl0eSBvbiB4ODYt
NjQsIHdlIHVzZSBhbiBlbXB0eSBSRVgtcHJlZml4DQo+Pj4gKG9wY29kZSAweDQwKSBhcyBhbiBp
bmRpY2F0aW9uIHRoYXQgcHJlZW1wdGlvbiBpcyBkaXNhYmxlZCBmb3IgdGhlDQo+Pj4gZm9sbG93
aW5nIGluc3RydWN0aW9uLg0KPj4gDQo+PiBOaWZ0eSENCj4+IA0KPj4gVGhhdCBiZWluZyBzYWlk
LCBJIHRoaW5rIHlvdSBoYXZlIGEgZmV3IGJ1Z3MuIEZpcnN0LCB5b3UgY2Fu4oCZdCBqdXN0IGln
bm9yZQ0KPj4gYSByZXNjaGVkdWxpbmcgaW50ZXJydXB0LCBhcyB5b3UgaW50cm9kdWNlIHVuYm91
bmRlZCBsYXRlbmN5IHdoZW4gdGhpcw0KPj4gaGFwcGVucyDigJQgeW914oCZcmUgZWZmZWN0aXZl
bHkgZW11bGF0aW5nIHByZWVtcHRfZW5hYmxlX25vX3Jlc2NoZWQoKSwgd2hpY2gNCj4+IGlzIG5v
dCBhIGRyb3AtaW4gcmVwbGFjZW1lbnQgZm9yIHByZWVtcHRfZW5hYmxlKCkuIFRvIGZpeCB0aGlz
LCB5b3UgbWF5DQo+PiBuZWVkIHRvIGp1bXAgdG8gYSBzbG93LXBhdGggdHJhbXBvbGluZSB0aGF0
IGNhbGxzIHNjaGVkdWxlKCkgYXQgdGhlIGVuZCBvcg0KPj4gY29uc2lkZXIgcmV3aW5kaW5nIG9u
ZSBpbnN0cnVjdGlvbiBpbnN0ZWFkLiBPciB1c2UgVEYsIHdoaWNoIGlzIG9ubHkgYQ0KPj4gbGl0
dGxlIGJpdCB0ZXJyaWZ5aW5n4oCmDQo+IA0KPiBZZXMsIEkgZGlkbuKAmXQgcGF5IGVub3VnaCBh
dHRlbnRpb24gaGVyZS4gRm9yIG15IHVzZS1jYXNlLCBJIHRoaW5rIHRoYXQgdGhlDQo+IGVhc2ll
c3Qgc29sdXRpb24gd291bGQgYmUgdG8gbWFrZSBzeW5jaHJvbml6ZV9zY2hlZCgpIGlnbm9yZSBw
cmVlbXB0aW9ucw0KPiB0aGF0IGhhcHBlbiB3aGlsZSB0aGUgcHJlZml4IGlzIGRldGVjdGVkLiBJ
dCB3b3VsZCBzbGlnaHRseSBjaGFuZ2UgdGhlDQo+IG1lYW5pbmcgb2YgdGhlIHByZWZpeC4NCg0K
SWdub3JlIHRoaXMgbm9uc2Vuc2UgdGhhdCBJIHdyb3RlLiBJ4oCZbGwgdHJ5IHRvIGNvbWUgdXAg
d2l0aCBhIGRlY2VudA0Kc29sdXRpb24uDQoNCj4+IFlvdSBhbHNvIGFyZW7igJl0IGFjY291bnRp
bmcgZm9yIHRoZSBjYXNlIHdoZXJlIHlvdSBnZXQgYW4gZXhjZXB0aW9uIHRoYXQNCj4+IGlzLCBp
biB0dXJuLCBwcmVlbXB0ZWQuDQo+IA0KPiBIbW0uLiBDYW4geW91IGdpdmUgbWUgYW4gZXhhbXBs
ZSBmb3Igc3VjaCBhbiBleGNlcHRpb24gaW4gbXkgdXNlLWNhc2U/IEkNCj4gY2Fubm90IHRoaW5r
IG9mIGFuIGV4Y2VwdGlvbiB0aGF0IG1pZ2h0IGJlIHByZWVtcHRlZCAoYXNzdW1pbmcgI0JQLCAj
TUMNCj4gY2Fubm90IGJlIHByZWVtcHRlZCkuDQo+IA0KPiBJIGFncmVlIHRoYXQgZm9yIHN1cGVy
LWdlbmVyYWwgY2FzZSB0aGlzIG1pZ2h0IGJlIGluYXBwcm9wcmlhdGUuDQoNCg0K
