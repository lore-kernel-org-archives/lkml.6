Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8B9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F092175B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="f5p4gVw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F092175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbeKNEeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:34:02 -0500
Received: from mail-eopbgr790087.outbound.protection.outlook.com ([40.107.79.87]:33952
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726659AbeKNEeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILvJZwrwVKJamubga5nLFJ/huflWX2MUVbgqT6tpBG0=;
 b=f5p4gVw1cAnf2sJmfYwo5xZRmE2w3RdUJvgLLH7HJFzltRH2Fan0/8GGw92hg9pwjyLjnRBGi1pim7uiKIWsBdmI6P9q0xYrKsnnvGYnSEEb0VbgnsFi2b9/1e4vHxjSQdvLjLn82Z1vdwRSq2J4149hGf1TYtdDDYfo1rayZPc=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4534.namprd05.prod.outlook.com (52.135.203.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.10; Tue, 13 Nov 2018 18:34:39 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1339.021; Tue, 13 Nov 2018
 18:34:39 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 1/2] Makefile: Fix distcc compilation with x86 macros
Thread-Topic: [PATCH 1/2] Makefile: Fix distcc compilation with x86 macros
Thread-Index: AQHUetXZ1x6cjbBfk0ugZnU2RuWk66VNksAAgABrugCAAArpgA==
Date:   Tue, 13 Nov 2018 18:34:39 +0000
Message-ID: <48577A3F-0F76-4CCA-A959-965344D7259F@vmware.com>
References: <20181112150215.508-1-namit@vmware.com>
 <20181112150215.508-2-namit@vmware.com> <20181113113000.GB4788@gmail.com>
 <40E4E1B4-EF5F-43A1-B42C-C4CF6349FC62@vmware.com>
In-Reply-To: <40E4E1B4-EF5F-43A1-B42C-C4CF6349FC62@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4534;20:566wO5U/78wJXQjngtg2KtnR+GrgkiXMizuMKok3iLe5Zb/c9QoSLLd10wHqOf350cAiBr3LR+GeTC5zFUyJfPI2G9ywkeHs+V6CJwUgH2R6RBug/swwpzoldUHqgRcHHRqa1V9tpwuxqHZdOE4wqgRuIR33p5uX76y6o0mJPzY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 60703090-edf0-44a3-cf3e-08d64996abca
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4534;
x-ms-traffictypediagnostic: BYAPR05MB4534:
x-microsoft-antispam-prvs: <BYAPR05MB453452EC384C1431B5576D48D0C20@BYAPR05MB4534.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231382)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4534;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4534;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(366004)(396003)(39860400002)(199004)(189003)(82746002)(68736007)(36756003)(4326008)(53936002)(6486002)(6512007)(6436002)(6246003)(229853002)(8936002)(106356001)(316002)(81156014)(105586002)(256004)(2616005)(486006)(83716004)(446003)(476003)(54906003)(11346002)(81166006)(71200400001)(71190400001)(8676002)(93886005)(26005)(66066001)(7416002)(2906002)(99286004)(97736004)(5660300001)(3846002)(186003)(7736002)(6916009)(305945005)(6506007)(2900100001)(76176011)(53546011)(102836004)(6116002)(478600001)(14454004)(33656002)(25786009)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4534;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2NaU3PqgJ0QE4ZKh4joQshgj70jF31lRxxWOzhj6clmzNUr03Kf5BGVz5J0lSwKRG+TTTlFgPSDaUsdZQve5ZO1ScI9nVdvO0tApijQt5uAkGwjpjLPyl1u13xZ2+p2r93cuy69cMX5asNUvxF0Nke8vaQYDte2fGBQVJ7FazgoIr9FLtZne4MI8s8cM9wLNKxmxX4NOV/nh/+6N0kYt71kPVsIClPmKFtTOj4fAnm2aJjnykH7PQwdl+awrEfIXLzPheM8YmUI5gKq0NHPmCfmRXOpR64dayRQJ88xYPEMnmXwjXoJKb32khIl76zzVAPqzNSjlLwnUfGPh4bb63GEDFLDhDdwWnNpgGE8XjJg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <40926D1688691E4786CEC86ED85F4D8B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60703090-edf0-44a3-cf3e-08d64996abca
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 18:34:39.4058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4534
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTmFkYXYgQW1pdA0KU2VudDogTm92ZW1iZXIgMTMsIDIwMTggYXQgNTo1NTozNCBQTSBH
TVQNCj4gVG86IEluZ28gTW9sbmFyIDxtaW5nb0BrZXJuZWwub3JnPg0KPiBDYzogSW5nbyBNb2xu
YXIgPG1pbmdvQHJlZGhhdC5jb20+LCBNYXNhaGlybyBZYW1hZGEgPHlhbWFkYS5tYXNhaGlyb0Bz
b2Npb25leHQuY29tPiwgTWljaGFsIE1hcmVrIDxtaWNoYWwubGttbEBtYXJrb3ZpLm5ldD4sIFRo
b21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPiwgQm9yaXNsYXYgUGV0a292IDxicEBh
bGllbjguZGU+LCBILiBQZXRlciBBbnZpbiA8aHBhQHp5dG9yLmNvbT4sIFg4NiBNTCA8eDg2QGtl
cm5lbC5vcmc+LCBMaW51eCBLYnVpbGQgbWFpbGluZyBsaXN0IDxsaW51eC1rYnVpbGRAdmdlci5r
ZXJuZWwub3JnPiwgTEtNTCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4sIExvZ2FuIEd1
bnRob3JwZSA8bG9nYW5nQGRlbHRhdGVlLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJd
IE1ha2VmaWxlOiBGaXggZGlzdGNjIGNvbXBpbGF0aW9uIHdpdGggeDg2IG1hY3Jvcw0KPiANCj4g
DQo+IEZyb206IEluZ28gTW9sbmFyDQo+IFNlbnQ6IE5vdmVtYmVyIDEzLCAyMDE4IGF0IDExOjMw
OjAwIEFNIEdNVA0KPj4gVG86IE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+DQo+PiBDYzog
SW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+LCBNYXNhaGlybyBZYW1hZGEgPHlhbWFkYS5t
YXNhaGlyb0Bzb2Npb25leHQuY29tPiwgTWljaGFsIE1hcmVrIDxtaWNoYWwubGttbEBtYXJrb3Zp
Lm5ldD4sIFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPiwgQm9yaXNsYXYgUGV0
a292IDxicEBhbGllbjguZGU+LCBILiBQZXRlciBBbnZpbiA8aHBhQHp5dG9yLmNvbT4sIHg4NkBr
ZXJuZWwub3JnLCBsaW51eC1rYnVpbGRAdmdlci5rZXJuZWwub3JnLCBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gTWFrZWZpbGU6IEZpeCBk
aXN0Y2MgY29tcGlsYXRpb24gd2l0aCB4ODYgbWFjcm9zDQo+PiANCj4+IA0KPj4gDQo+PiAqIE5h
ZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4gDQo+Pj4gSW50cm9kdWNpbmcg
dGhlIHVzZSBvZiBhc20gbWFjcm9zIGluIGMtY29kZSBicm9rZSBkaXN0Y2MsIHNpbmNlIGl0IG9u
bHkNCj4+PiBzZW5kcyB0aGUgcHJlcHJvY2Vzc2VkIHNvdXJjZSBmaWxlLiBUaGUgc29sdXRpb24g
aXMgdG8gYnJlYWsgdGhlDQo+Pj4gY29tcGlsYXRpb24gaW50byB0d28gc2VwYXJhdGUgcGhhc2Vz
IG9mIGNvbXBpbGF0aW9uIGFuZCBhc3NlbWJseSwgYW5kDQo+Pj4gYmV0d2VlbiB0aGUgdHdvIGNv
bmNhdGFuYXRlIHRoZSBhc3NlbWJseSBtYWNyb3MgYW5kIHRoZSBjb21waWxlZCAoeWV0DQo+PiAN
Cj4+IHMvY29uY2F0ZW5hdGUNCj4+IA0KPj4+IG5vdCBhc3NlbWJsZWQpIHNvdXJjZSBmaWxlLiBT
aW5jZSB0aGlzIGlzIGxlc3MgZWZmaWNpZW50LCB0aGlzDQo+Pj4gY29tcGlsYXRpb24gbW9kZSBp
cyBvbmx5IHVzZWQgd2hlbiBtYWtlIGlzIGNhbGxlZCB3aXRoIHRoZSAiRElTVENDPXkiDQo+Pj4g
cGFyYW1ldGVyLg0KPj4+IA0KPj4+IE5vdGUgdGhhdCB0aGUgYXNzZW1ibHkgc3RhZ2Ugc2hvdWxk
IGFsc28gYmUgZGlzdHJpYnV0ZWQsIGlmIGRpc3RjYyBpcw0KPj4+IGNvbmZpZ3VyZWQgdXNpbmcg
IkNGTEFHUz0tREVOQUJMRV9SRU1PVEVfQVNTRU1CTEUiLg0KPj4gDQo+PiBJdCdzIGEgYml0IHNh
ZCB0aGF0IHdlIHJlZ3Jlc3NlZCBkaXN0Y2MgcGVyZm9ybWFuY2Ug4oCmDQo+IA0KPiBJIGRvbuKA
mXQga25vdyB3aGF0IHRoZSBhY3R1YWwgaW1wYWN0IGlzLCBidXQgTG9nYW4sIHdobyByZXBvcnRl
ZCB0aGUgYnVnIHNheXMNCj4gdGhlcmUgaXMgYW4gYWx0ZXJuYXRpdmUgc29sdXRpb24gZm9yIHdo
ZW4gZGlzdGNjLXB1bXAgaXMgdXNlZCAod2hpY2gNCj4gcHJlc3VtYWJseSB3b3VsZCBoYXZlIH56
ZXJvIHBlcmZvcm1hbmNlIGRlZ3JhZGF0aW9uKS4gZGlzdGNjIGlzIHJlYWxseQ0KPiBmcmFnaWxl
IElNSE8gLSBpdOKAmXMgZW5vdWdoIHRoYXQgaXQgZmluZHMgd2hhdCBsb29rcyBsaWtlIHR3byBz
b3VyY2UgZmlsZXMgaW4NCj4gdGhlIGNvbXBpbGVyIGNvbW1hbmQgYXJndW1lbnRzIGZvciBpdCB0
byBmYWxsIGJhY2sgdG8gbG9jYWwgY29tcGlsYXRpb24uDQo+IA0KPiBbIEluIHRoaXMgcmVnYXJk
LCB0aGUgZGlzdGNjLXB1bXAgc29sdXRpb24gd291bGQgKm5vdCogd29yayBpZiBkaXN0Y2MgaXMN
Cj4gYnVpbHQgd2l0aCBzdXBwb3J0IGZvciBkaXN0cmlidXRlZCBhc3NlbWJseSwgc2luY2UgaXQg
d2lsbCBjb25zaWRlciB0aGUgLnMNCj4gZmlsZSBhcyBhIHNlY29uZCBzb3VyY2UgZmlsZS4gXQ0K
PiANCj4+PiArIyBJZiBkaXN0Y2MgaXMgdXNlZCwgdGhlbiB3aGVuIGFuIGFzc2VtYmx5IG1hY3Jv
IGZpbGVzIGlzIG5lZWRlZCwgdGhlDQo+Pj4gKyMgY29tcGlsYXRpb24gc3RhZ2UgYW5kIHRoZSBh
c3NlbWJseSBzdGFnZSBuZWVkIHRvIGJlIHNlcGFyYXRlZC4gUHJvdmlkaW5nDQo+Pj4gKyMgIkRJ
U1RDQz15IiBvcHRpb24gZW5hYmxlcyB0aGUgc2VwYXJhdGUgY29tcGlsYXRpb24gYW5kIGFzc2Vt
Ymx5Lg0KPj4gDQo+PiBMZXQncyBmaXggdGhlIHZhcmlvdXMgdHlwb3M6DQo+PiANCj4+PiArIyBJ
ZiBkaXN0Y2MgaXMgdXNlZCwgYW5kIHdoZW4gYXNzZW1ibHkgbWFjcm8gZmlsZXMgYXJlIG5lZWRl
ZCwgdGhlDQo+Pj4gKyMgY29tcGlsYXRpb24gc3RhZ2UgYW5kIHRoZSBhc3NlbWJseSBzdGFnZSBu
ZWVkcyB0byBiZSBzZXBhcmF0ZWQuIA0KPj4+ICsjIFByb3ZpZGluZyB0aGUgIkRJU1RDQz15IiBv
cHRpb24gZW5hYmxlcyBzZXBhcmF0ZSBjb21waWxhdGlvbiBhbmQgDQo+Pj4gKyMgYXNzZW1ibHku
DQo+IA0KPiBUaGF04oCZcyBncmFtbWFyLCBub3QgdHlwb3MgOy0pDQo+IA0KPiBTb3JyeSBmb3Ig
dGhhdCAtIEkgd2lsbCBmaXggaXQgYW4gc2VuZCB2MiAoYXMgd2VsbCBhcyB0aGUgd2hpdGVzcGFj
ZSBub2lzZSkuDQoNCkp1c3Qgb25lIHF1ZXN0aW9uIGJlZm9yZSBJIHNlbmQgdjIsIHNpbmNlIEkg
aGF2ZSBzZWNvbmQgdGhvdWdodHMuIERvZXMgaXQNCm1ha2Ugc2Vuc2UgdG8gcmVxdWlyZSB0aGUg
4oCcRElTVEND4oCdIG1ha2UgcGFyYW1ldGVyLCBvciBzaG91bGQgaXQgYmUgc2V0IGluDQp0aGUg
S2NvbmZpZz8gSXQgY2FuIGJlIGRldGVjdGVkIGF1dG9tYXRpY2FsbHksIHRoZSBzYW1lIHdheSBn
Y2MvY2xhbmcgYXJlDQpkZXRlY3RlZCBvciBtYW51YWxseSB0aHJvdWdoIGEgY29uZmlnIG9wdGlv
bi4NCg0K
