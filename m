Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638BFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11541223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="BTIpFRjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11541223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733192AbeKODyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:54:02 -0500
Received: from mail-eopbgr740042.outbound.protection.outlook.com ([40.107.74.42]:45088
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727576AbeKODyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 22:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sych0o/7l/M7UQJtKTMx3QfhzJ1wxvOJc8QUvZHgkw8=;
 b=BTIpFRjE+cwpYOJ2ooLF/Q3MwyuwdS1CTpvWngkJfeVEwje3Vxm9T8pcFY1wSMWEw13lqeR9MtjR1nZ7djkTLnW9mLsPSsG8p8Bui+8LSm3Kr1Orcc5eaT46jwmZQdLAjcHmRduiPVG2fNiuP1m2JstLb+wNNiQ33tWpCRGSeIg=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5224.namprd05.prod.outlook.com (20.177.231.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.17; Wed, 14 Nov 2018 17:46:54 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1339.021; Wed, 14 Nov 2018
 17:46:54 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        Ingo Molnar <mingo@kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Makefile: Fix distcc compilation with x86 macros
Thread-Topic: [PATCH 1/2] Makefile: Fix distcc compilation with x86 macros
Thread-Index: AQHUetXZ1x6cjbBfk0ugZnU2RuWk66VNksAAgABrugCAAArpgIAA2IoAgACsc4A=
Date:   Wed, 14 Nov 2018 17:46:53 +0000
Message-ID: <7072A2D8-30F8-45CB-AB0C-B1BE4A30259A@vmware.com>
References: <20181112150215.508-1-namit@vmware.com>
 <20181112150215.508-2-namit@vmware.com> <20181113113000.GB4788@gmail.com>
 <40E4E1B4-EF5F-43A1-B42C-C4CF6349FC62@vmware.com>
 <48577A3F-0F76-4CCA-A959-965344D7259F@vmware.com>
 <7ff5de62-d1df-9a67-1c86-497ce00a4de4@deltatee.com>
In-Reply-To: <7ff5de62-d1df-9a67-1c86-497ce00a4de4@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5224;20:M2YJqG7V7x4F3k5xkhwR4hMJlcjqmT7wmLo5QUBPc1HlEQI1ZllpCpaBQq5ywN/zWOt7CgFYWtY6Rgql1e58dtl5eog9iPpjolFJGrWGKZbrEf0N8ICye7uYbVFi0e/7FVSMOKbVldlz91E69C/pTMXraWd4Z6ODy5d87ye4kPg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 31208478-57b6-4552-9186-08d64a592a38
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5224;
x-ms-traffictypediagnostic: BYAPR05MB5224:
x-microsoft-antispam-prvs: <BYAPR05MB5224B9746052037E1A86B219D0C30@BYAPR05MB5224.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231414)(944501410)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5224;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5224;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(136003)(346002)(39860400002)(199004)(189003)(6486002)(86362001)(81166006)(81156014)(256004)(8936002)(33656002)(71200400001)(83716004)(71190400001)(8676002)(6436002)(53936002)(6246003)(6512007)(5660300001)(82746002)(7736002)(6116002)(3846002)(97736004)(229853002)(305945005)(2906002)(316002)(66066001)(7416002)(93886005)(2900100001)(4326008)(110136005)(106356001)(105586002)(54906003)(76176011)(486006)(36756003)(99286004)(102836004)(6506007)(446003)(11346002)(6346003)(26005)(25786009)(186003)(68736007)(14454004)(476003)(2616005)(478600001)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5224;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-message-info: JVfiMny3rUApZQnSWEfZle+U6sSGKj7V/ZqWdlb5tiiDBG2xz9WFr5pKSyvJnx7CZ56BF0uzPJasnIHJgfs7CtC3oSmHIYERdsLlwn+cG1qL4Wv8RxfjuP89ZiivXX3UvYJSrymrXegUYnrUSfHwXICR4GY6OGWg77S9ScUJfe8V+gN6a2ERkvO8opO7OXiETnOWyAHio0E33e4/h48zuTV0L7FbRMQaPVtj9BbCo8K8ffUECfNFjWIqZzxVGHWwhiGoOB7W+uhWa0NN60IharKHgHsftdPVAPg5wYnaaP2OqK19xhk4cMd+tGbbx8h5o8hUPbJSD+WC2Jnt0EOwmjGyqkZGaRk+y6WEB4LJ8EM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AC4BD521730244AAB06835F19EA0000@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31208478-57b6-4552-9186-08d64a592a38
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 17:46:53.8523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5224
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTG9nYW4gR3VudGhvcnBlDQpTZW50OiBOb3ZlbWJlciAxNCwgMjAxOCBhdCA3OjI5OjM4
IEFNIEdNVA0KPiBUbzogTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4sIEluZ28gTW9sbmFy
IDxtaW5nb0BrZXJuZWwub3JnPg0KPiBDYzogSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+
LCBNYXNhaGlybyBZYW1hZGEgPHlhbWFkYS5tYXNhaGlyb0Bzb2Npb25leHQuY29tPiwgTWljaGFs
IE1hcmVrIDxtaWNoYWwubGttbEBtYXJrb3ZpLm5ldD4sIFRob21hcyBHbGVpeG5lciA8dGdseEBs
aW51dHJvbml4LmRlPiwgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+LCBILiBQZXRlciBB
bnZpbiA8aHBhQHp5dG9yLmNvbT4sIFg4NiBNTCA8eDg2QGtlcm5lbC5vcmc+LCBMaW51eCBLYnVp
bGQgbWFpbGluZyBsaXN0IDxsaW51eC1rYnVpbGRAdmdlci5rZXJuZWwub3JnPiwgTEtNTCA8bGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIE1h
a2VmaWxlOiBGaXggZGlzdGNjIGNvbXBpbGF0aW9uIHdpdGggeDg2IG1hY3Jvcw0KPiANCj4gDQo+
IA0KPiANCj4gT24gMTMvMTEvMTggMTE6MzQgQU0sIE5hZGF2IEFtaXQgd3JvdGU6DQo+PiBKdXN0
IG9uZSBxdWVzdGlvbiBiZWZvcmUgSSBzZW5kIHYyLCBzaW5jZSBJIGhhdmUgc2Vjb25kIHRob3Vn
aHRzLiBEb2VzIGl0DQo+PiBtYWtlIHNlbnNlIHRvIHJlcXVpcmUgdGhlIOKAnERJU1RDQ+KAnSBt
YWtlIHBhcmFtZXRlciwgb3Igc2hvdWxkIGl0IGJlIHNldCBpbg0KPj4gdGhlIEtjb25maWc/IEl0
IGNhbiBiZSBkZXRlY3RlZCBhdXRvbWF0aWNhbGx5LCB0aGUgc2FtZSB3YXkgZ2NjL2NsYW5nIGFy
ZQ0KPj4gZGV0ZWN0ZWQgb3IgbWFudWFsbHkgdGhyb3VnaCBhIGNvbmZpZyBvcHRpb24uDQo+IA0K
PiBJIHZlcnkgbXVjaCBwcmVmZXIgdGhlIG1ha2UgdmFyaWFibGUgYXMgaXQgY2FuIGJlIHNldCBp
biB0aGUgZW52aXJvbm1lbnQNCj4gd2l0aG91dCBoYXZpbmcgdG8gY2hhbmdlIHRoZSBLY29uZmln
Lg0KDQpBY3R1YWxseSwgd2UgY2FuIGp1c3QgZmlndXJlIG91dCB3aGV0aGVyIGRpc3RjYyBvciBp
Y2VjYyBhcmUgdXNlZCBpbiB0aGUNCk1ha2VmaWxlIGFjY29yZGluZyB0byB0aGUg4oCcdmVyc2lv
buKAnSwgc2ltaWxhcmx5IHRvIHRoZSB3YXkgY2xhbmcgaXMgZGV0ZWN0ZWQuDQpUaGlzIHdvdWxk
IG5laXRoZXIgcmVxdWlyZSBuZXcgTWFrZWZpbGUgYXJndW1lbnRzIG9yIEtjb25maWcgb3B0aW9u
cy4NCg0KV2hhdCBkbyB5b3Ugc2F5IGFib3V0IHRoZSBmb2xsb3dpbmc/DQoNCi0tID44IC0tDQoN
ClN1YmplY3Q6IFtQQVRDSF0gTWFrZWZpbGU6IEZpeCBkaXN0Y2MgY29tcGlsYXRpb24gd2l0aCB4
ODYgbWFjcm9zDQoNCkludHJvZHVjaW5nIHRoZSB1c2Ugb2YgYXNtIG1hY3JvcyBpbiBjLWNvZGUg
YnJva2UgZGlzdGNjLCBzaW5jZSBpdCBvbmx5DQpzZW5kcyB0aGUgcHJlcHJvY2Vzc2VkIHNvdXJj
ZSBmaWxlLiBUaGUgc29sdXRpb24gaXMgdG8gYnJlYWsgdGhlDQpjb21waWxhdGlvbiBpbnRvIHR3
byBzZXBhcmF0ZSBwaGFzZXMgb2YgY29tcGlsYXRpb24gYW5kIGFzc2VtYmx5LCBhbmQNCmJldHdl
ZW4gdGhlIHR3byBjb25jYXRlbmF0ZSB0aGUgYXNzZW1ibHkgbWFjcm9zIGFuZCB0aGUgY29tcGls
ZWQgKHlldA0Kbm90IGFzc2VtYmxlZCkgc291cmNlIGZpbGUuIFNpbmNlIHRoaXMgaXMgbGVzcyBl
ZmZpY2llbnQsIHRoaXMNCmNvbXBpbGF0aW9uIG1vZGUgaXMgb25seSB1c2VkIHdoZW4gZGlzdGNj
IG9yIGljZWNjIGFyZSB1c2VkLg0KDQpOb3RlIHRoYXQgdGhlIGFzc2VtYmx5IHN0YWdlIHNob3Vs
ZCBhbHNvIGJlIGRpc3RyaWJ1dGVkLCBpZiBkaXN0Y2MgaXMNCmNvbmZpZ3VyZWQgdXNpbmcgIkNG
TEFHUz0tREVOQUJMRV9SRU1PVEVfQVNTRU1CTEUiLg0KDQpSZXBvcnRlZC1ieTogTG9nYW4gR3Vu
dGhvcnBlIDxsb2dhbmdAZGVsdGF0ZWUuY29tPg0KU2lnbmVkLW9mZi1ieTogTmFkYXYgQW1pdCA8
bmFtaXRAdm13YXJlLmNvbT4NCi0tLQ0KIE1ha2VmaWxlICAgICAgICAgICAgICAgfCAgNCArKyst
DQogYXJjaC94ODYvTWFrZWZpbGUgICAgICB8ICA3ICsrKysrLS0NCiBzY3JpcHRzL01ha2VmaWxl
LmJ1aWxkIHwgMzAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQogMyBmaWxlcyBjaGFu
Z2VkLCAzNiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvTWFr
ZWZpbGUgYi9NYWtlZmlsZQ0KaW5kZXggOWZjZThiOTFjMTVmLi5jMDczNDlmYzM4YzcgMTAwNjQ0
DQotLS0gYS9NYWtlZmlsZQ0KKysrIGIvTWFrZWZpbGUNCkBAIC03NDMsNyArNzQzLDkgQEAgS0JV
SUxEX0NGTEFHUyAgICs9ICQoY2FsbCBjYy1vcHRpb24sIC1nc3BsaXQtZHdhcmYsIC1nKQ0KIGVs
c2UNCiBLQlVJTERfQ0ZMQUdTCSs9IC1nDQogZW5kaWYNCi1LQlVJTERfQUZMQUdTCSs9IC1XYSwt
Z2R3YXJmLTINCitBRkxBR1NfREVCVUdfSU5GTyA9IC1XYSwtZ2R3YXJmLTINCitleHBvcnQgQUZM
QUdTX0RFQlVHX0lORk8NCitLQlVJTERfQUZMQUdTCSs9ICQoQUZMQUdTX0RFQlVHX0lORk8pDQog
ZW5kaWYNCiBpZmRlZiBDT05GSUdfREVCVUdfSU5GT19EV0FSRjQNCiBLQlVJTERfQ0ZMQUdTCSs9
ICQoY2FsbCBjYy1vcHRpb24sIC1nZHdhcmYtNCwpDQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvTWFr
ZWZpbGUgYi9hcmNoL3g4Ni9NYWtlZmlsZQ0KaW5kZXggZjVkN2Y0MTM0NTI0Li5iNTk1M2NiY2M5
YzggMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9NYWtlZmlsZQ0KKysrIGIvYXJjaC94ODYvTWFrZWZp
bGUNCkBAIC0yMzUsMTAgKzIzNSwxMyBAQCBhcmNoc2NyaXB0czogc2NyaXB0c19iYXNpYw0KIGFy
Y2hoZWFkZXJzOg0KIAkkKFEpJChNQUtFKSAkKGJ1aWxkKT1hcmNoL3g4Ni9lbnRyeS9zeXNjYWxs
cyBhbGwNCiANCitBU01fTUFDUk9fRklMRSA9IGFyY2gveDg2L2tlcm5lbC9tYWNyb3Mucw0KK2V4
cG9ydCBBU01fTUFDUk9fRklMRQ0KKw0KIGFyY2htYWNyb3M6DQotCSQoUSkkKE1BS0UpICQoYnVp
bGQpPWFyY2gveDg2L2tlcm5lbCBhcmNoL3g4Ni9rZXJuZWwvbWFjcm9zLnMNCisJJChRKSQoTUFL
RSkgJChidWlsZCk9YXJjaC94ODYva2VybmVsICQoQVNNX01BQ1JPX0ZJTEUpDQogDQotQVNNX01B
Q1JPX0ZMQUdTID0gLVdhLGFyY2gveDg2L2tlcm5lbC9tYWNyb3Mucw0KK0FTTV9NQUNST19GTEFH
UyA9IC1XYSwkKEFTTV9NQUNST19GSUxFKQ0KIGV4cG9ydCBBU01fTUFDUk9fRkxBR1MNCiBLQlVJ
TERfQ0ZMQUdTICs9ICQoQVNNX01BQ1JPX0ZMQUdTKQ0KIA0KZGlmZiAtLWdpdCBhL3NjcmlwdHMv
TWFrZWZpbGUuYnVpbGQgYi9zY3JpcHRzL01ha2VmaWxlLmJ1aWxkDQppbmRleCA2YTZiZTlmNDQw
Y2YuLmJhYzc2MWMwN2JmOCAxMDA2NDQNCi0tLSBhL3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQNCisr
KyBiL3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQNCkBAIC0xNTUsOCArMTU1LDM0IEBAICQob2JqKS8l
LmxsOiAkKHNyYykvJS5jIEZPUkNFDQogDQogcXVpZXRfY21kX2NjX29fYyA9IENDICQocXVpZXRf
bW9kdGFnKSAgJEANCiANCisjIElmIGRpc3RjYyBpcyB1c2VkLCBhbmQgd2hlbiBhc3NlbWJseSBt
YWNybyBmaWxlcyBhcmUgbmVlZGVkLCB0aGUgY29tcGlsYXRpb24NCisjIHN0YWdlIGFuZCB0aGUg
YXNzZW1ibHkgc3RhZ2UgbmVlZHMgdG8gYmUgc2VwYXJhdGVkLiBQcm92aWRpbmcgdGhlICJESVNU
Q0M9eSINCisjIG9wdGlvbiBlbmFibGVzIHNlcGFyYXRlIGNvbXBpbGF0aW9uIGFuZCBhc3NlbWJs
eS4NCisNCitjbWRfY2Nfb19jX2RpcmVjdCA9ICQoQ0MpICQoY19mbGFncykgLWMgLW8gJCgxKSAk
PA0KKw0KK2lmbmVxICgkKHNoZWxsICQoQ0MpIC0tdmVyc2lvbiAyPiYxIHwgaGVhZCAtbiAxIHwg
Z3JlcCAtRSAnZGlzdGNjfGljZWNjJyksKQ0KK2FfZmxhZ3Nfbm9fZGVidWcgPSAkKGZpbHRlci1v
dXQgJChBRkxBR1NfREVCVUdfSU5GTyksICQoYV9mbGFncykpDQorY19mbGFnc19ub19tYWNyb3Mg
PSAkKGZpbHRlci1vdXQgJChBU01fTUFDUk9fRkxBR1MpLCAkKGNfZmxhZ3MpKQ0KKw0KK2NtZF9j
Y19vX2NfdHdvX3N0ZXBzID0JCQkJCQkJXA0KKwkkKENDKSAkKGNfZmxhZ3Nfbm9fbWFjcm9zKSAk
KERJU0FCTEVfTFRPKSAtZnZlcmJvc2UtYXNtIC1TCVwNCisJCS1vICQoQEQpLy4kKEBGOi5vPS5z
KSAkPDsJCQkJXA0KKwljYXQgJChBU01fTUFDUk9fRklMRSkgJChARCkvLiQoQEY6Lm89LnMpID4J
CQlcDQorCQkkKEBEKS8udG1wXyQoQEY6Lm89LnMpOwkJCQkJXA0KKwkkKENDKSAkKGFfZmxhZ3Nf
bm9fZGVidWcpIC1jIC1vICQoMSkgJChARCkvLnRtcF8kKEBGOi5vPS5zKTsJXA0KKwlybSAtZiAk
KEBEKS8uJChARjoubz0ucykgJChARCkvLnRtcF8kKEBGOi5vPS5zKQkJCVwNCisNCitjbWRfY2Nf
b19jX2hlbHBlciA9CQkJCQkJCVwNCisJJChpZiAkKGZpbmRzdHJpbmcgJChBU01fTUFDUk9fRkxB
R1MpLCQoY19mbGFncykpLAkJXA0KKwkJJChjYWxsIGNtZF9jY19vX2NfdHdvX3N0ZXBzLCAkKDEp
KSwJCQlcDQorCQkkKGNhbGwgY21kX2NjX29fY19kaXJlY3QsICQoMSkpKQ0KK2Vsc2UNCitjbWRf
Y2Nfb19jX2hlbHBlciA9ICQoY2FsbCBjbWRfY2Nfb19jX2RpcmVjdCwgJCgxKSkNCitlbmRpZg0K
Kw0KIGlmbmRlZiBDT05GSUdfTU9EVkVSU0lPTlMNCi1jbWRfY2Nfb19jID0gJChDQykgJChjX2Zs
YWdzKSAtYyAtbyAkQCAkPA0KK2NtZF9jY19vX2MgPSAkKGNhbGwgY21kX2NjX29fY19oZWxwZXIs
JEApDQogDQogZWxzZQ0KICMgV2hlbiBtb2R1bGUgdmVyc2lvbmluZyBpcyBlbmFibGVkIHRoZSBm
b2xsb3dpbmcgc3RlcHMgYXJlIGV4ZWN1dGVkOg0KQEAgLTE3MSw3ICsxOTcsNyBAQCBlbHNlDQog
IyAgIHJlcGxhY2UgdGhlIHVucmVzb2x2ZWQgc3ltYm9scyBfX2NyY19leHBvcnRlZF9zeW1ib2wg
d2l0aA0KICMgICB0aGUgYWN0dWFsIHZhbHVlIG9mIHRoZSBjaGVja3N1bSBnZW5lcmF0ZWQgYnkg
Z2Vua3N5bXMNCiANCi1jbWRfY2Nfb19jID0gJChDQykgJChjX2ZsYWdzKSAtYyAtbyAkKEBEKS8u
dG1wXyQoQEYpICQ8DQorY21kX2NjX29fYyA9ICQoY2FsbCBjbWRfY2Nfb19jX2hlbHBlciwkKEBE
KS8udG1wXyQoQEYpKQ0KIA0KIGNtZF9tb2R2ZXJzaW9uc19jID0JCQkJCQkJCVwNCiAJaWYgJChP
QkpEVU1QKSAtaCAkKEBEKS8udG1wXyQoQEYpIHwgZ3JlcCAtcSBfX2tzeW10YWI7IHRoZW4JCVwN
Ci0tIA0KMi4xNy4xDQoNCiANCg0K
