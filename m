Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3C9C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DDA20879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="o3Va7G9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DDA20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbeLMT1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:27:52 -0500
Received: from mail-eopbgr680070.outbound.protection.outlook.com ([40.107.68.70]:58592
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726453AbeLMT1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBa88g8IVoevOU5IxOI7WeRRvybuDNA+TN5QZ74PTa0=;
 b=o3Va7G9cHSv9ok/KzIkbb1b0Hpx6CQ7LKf6gswhI6BjF8sVJwXJjfpo9Cs55ubVnRIb85cTgq8+cmHlsOvXN3tnJ0y4if1TvoS0uTUePT+5wnyPi/VdGr5FQNpd7cnEekI9gll5NLt4vsrDlSsGAVKVQEIoeqj5fMAZyJPNiVDU=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5525.namprd05.prod.outlook.com (20.177.186.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.11; Thu, 13 Dec 2018 19:27:45 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7%4]) with mapi id 15.20.1446.006; Thu, 13 Dec 2018
 19:27:45 +0000
From:   Nadav Amit <namit@vmware.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jannh@google.com" <jannh@google.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH v2 2/4] modules: Add new special vfree flags
Thread-Topic: [PATCH v2 2/4] modules: Add new special vfree flags
Thread-Index: AQHUka9VVa9O1a3XNkKRZw/OZUeHJqV7xLuAgAFEyoCAAAbygA==
Date:   Thu, 13 Dec 2018 19:27:45 +0000
Message-ID: <60C7B565-9009-4070-A632-8C982B692806@vmware.com>
References: <20181212000354.31955-1-rick.p.edgecombe@intel.com>
 <20181212000354.31955-3-rick.p.edgecombe@intel.com>
 <3AD9DBCA-C6EC-4FA6-84DC-09F3D4A9C47B@vmware.com>
 <ae9292380803f891a2472ebec70361b7c1af48d8.camel@intel.com>
In-Reply-To: <ae9292380803f891a2472ebec70361b7c1af48d8.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5525;20:8lGHvtrXZAl253CT7NKgunJVCYYdRSR+jnPr/79ZXXuO7Om44ZNH1IWi5h8km7SjTVnDh1ZsH9EVSzZ6pMDQXl9RIGkez9oPBxPbCZVQR+twEDa7PZaXiqrJxSbbkEk41sz/y6NLjbqQBUrvdhbkkocYGexpLP3wxIvl+TLBZKs=
x-ms-office365-filtering-correlation-id: f903e1a3-4d2c-4302-a538-08d661310f1d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5525;
x-ms-traffictypediagnostic: BYAPR05MB5525:
x-microsoft-antispam-prvs: <BYAPR05MB5525ABA0C986E466ACB31C4BD0A00@BYAPR05MB5525.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5525;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5525;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(366004)(346002)(376002)(189003)(199004)(4001150100001)(97736004)(6436002)(25786009)(229853002)(14454004)(6116002)(33656002)(81156014)(82746002)(105586002)(36756003)(6486002)(486006)(86362001)(7416002)(3846002)(6916009)(5660300001)(7736002)(99286004)(6512007)(476003)(186003)(11346002)(66066001)(478600001)(53936002)(93886005)(2616005)(26005)(106356001)(446003)(54906003)(71200400001)(71190400001)(305945005)(76176011)(83716004)(53546011)(256004)(102836004)(81166006)(4326008)(68736007)(6246003)(316002)(8676002)(8936002)(2906002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5525;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NaTRLFXhuhRBwWbo/p2GYCEj+2eDYOXRHv6GN7jOvpzWk8WMmWKFBHKosuAq37B9yDnZI9U3ZiF/wxx47dR7Aqvg70XaJR3VyXGSxstcBUypfIVRZwRfs13i+rJjOm+hOg+FkyLVIEcecHLj0AyaI16mmYC57mN/UY1G7p3aHA9p1lw1tloZ+6RuZ43PdsUzHpUZoDKiZVHBzJ1Ha4ZHG76ZbBVNW5/6C7SQ/YYofJbf3p4kP4Ad7ObIjmBiwvKEDsn2HYfdAzMgz/HFINFhs/RnOfzAiOQ/aMzFFuamvGknzgRaaCRhvnbcWxlErMMr
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0142D38DFCE0BA4B8AA61D16F5CE4B99@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f903e1a3-4d2c-4302-a538-08d661310f1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 19:27:45.1264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5525
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBEZWMgMTMsIDIwMTgsIGF0IDExOjAyIEFNLCBFZGdlY29tYmUsIFJpY2sgUCA8cmljay5w
LmVkZ2Vjb21iZUBpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gT24gV2VkLCAyMDE4LTEyLTEyIGF0
IDIzOjQwICswMDAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4+IE9uIERlYyAxMSwgMjAxOCwgYXQg
NDowMyBQTSwgUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPj4+
IHdyb3RlOg0KPj4+IA0KPj4+IEFkZCBuZXcgZmxhZ3MgZm9yIGhhbmRsaW5nIGZyZWVpbmcgb2Yg
c3BlY2lhbCBwZXJtaXNzaW9uZWQgbWVtb3J5IGluDQo+Pj4gdm1hbGxvYywNCj4+PiBhbmQgcmVt
b3ZlIHBsYWNlcyB3aGVyZSB0aGUgaGFuZGxpbmcgd2FzIGRvbmUgaW4gbW9kdWxlLmMuDQo+Pj4g
DQo+Pj4gVGhpcyB3aWxsIGVuYWJsZSB0aGlzIGZsYWcgZm9yIGFsbCBhcmNoaXRlY3R1cmVzLg0K
Pj4+IA0KPj4+IFNpZ25lZC1vZmYtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJl
QGludGVsLmNvbT4NCj4+PiAtLS0NCj4+PiBrZXJuZWwvbW9kdWxlLmMgfCA0MyArKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4gMSBmaWxlIGNoYW5nZWQsIDEy
IGluc2VydGlvbnMoKyksIDMxIGRlbGV0aW9ucygtKQ0KPj4gDQo+PiBJIGNvdW50IG9uIHlvdSBm
b3IgbWVyZ2luZyB5b3VyIHBhdGNoLXNldCB3aXRoIG1pbmUsIHNpbmNlIGNsZWFybHkgdGhleQ0K
Pj4gY29uZmxpY3QuDQo+IFllcywgSSBjYW4gcmViYXNlIG9uIHRvcCBvZiB5b3VycyBpZiB5b3Ug
b21pdCB0aGUgY2hhbmdlcyBhcm91bmQgbW9kdWxlX21lbWZyZWUgDQo+IGZvciB5b3VyIG5leHQg
dmVyc2lvbi4gSXQgc2hvdWxkIGZpdCB0b2dldGhlciBwcmV0dHkgY2xlYW5seSBmb3IgQlBGIGFu
ZCBtb2R1bGVzDQo+IEkgdGhpbmsuIE5vdCBzdXJlIHdoYXQgeW91IGFyZSBwbGFubmluZyBmb3Ig
a3Byb2JlcyBhbmQgZnRyYWNlLg0KDQpBcmUgeW91IGFza2luZyBhZnRlciBsb29raW5nIGF0IHRo
ZSBsYXRlc3QgdmVyc2lvbiBvZiBteSBwYXRjaC1zZXQ/DQoNCktwcm9iZXMgaXMgZG9uZSBhbmQg
YWNrJ2QuIGZ0cmFjZSBuZWVkcyB0byBiZSBicm9rZW4gaW50byB0d28gc2VwYXJhdGUNCmNoYW5n
ZXMgKHNldHRpbmcgeCBhZnRlciB3cml0aW5nLCBhbmQgdXNpbmcgdGV4dF9wb2tlIGludGVyZmFj
ZXMpLCB1bmxlc3MNClN0ZXZlbiBhY2vigJlzIHRoZW0uIFRoZSBjaGFuZ2VzIGludHJvZHVjZSBz
b21lIG92ZXJoZWFkICgzeCksIGJ1dCBJIHRoaW5rIGl0DQppcyBhIHJlYXNvbmFibGUgc2xvd2Rv
d24gZm9yIGEgZGVidWcgZmVhdHVyZS4NCg0KQ2FuIHlvdSBoYXZlIGEgbG9vayBhdCB0aGUgc2Vy
aWVzIEnigJl2ZSBzZW50IGFuZCBsZXQgbWUga25vdyB3aGljaCBwYXRjaGVzDQp0byBkcm9wPyBJ
dCB3b3VsZCBiZSBiZXN0IChmb3IgbWUpIGlmIHRoZSB0d28gc2VyaWVzIGFyZSBmdWxseSBtZXJn
ZWQu
