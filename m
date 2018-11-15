Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C81C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 01:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AE820866
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 01:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="N7cbousl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47AE820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeKOMDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 07:03:44 -0500
Received: from mail-eopbgr800078.outbound.protection.outlook.com ([40.107.80.78]:8000
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725895AbeKOMDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 07:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbFEIWEv2a9IvNB7V7eEjcWZQNyZEa3MhWR+Elbkr78=;
 b=N7cbouslHBgq1UJDn9Urzwev5cr4NLsXg4zwPD9rm2d3+hDXlwIHxSo1yFCQfnNiI9/7Lc136OosF23GR/y613lDF9IpGwuJd4DLbfzHI+uOvhIiJQLCPHgOQBzfJCF96bDOc/SMzzoYZzlom2q1vv19/wzqP5M2Lca8WAE93MM=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4151.namprd05.prod.outlook.com (52.135.199.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.17; Thu, 15 Nov 2018 01:57:53 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1339.021; Thu, 15 Nov 2018
 01:57:52 +0000
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
Thread-Index: AQHUetXZ1x6cjbBfk0ugZnU2RuWk66VNksAAgABrugCAAArpgIAA2IoAgACsc4CAAH6KgIAACqQA
Date:   Thu, 15 Nov 2018 01:57:52 +0000
Message-ID: <521458D7-A27C-4112-81ED-1974EFE96A76@vmware.com>
References: <20181112150215.508-1-namit@vmware.com>
 <20181112150215.508-2-namit@vmware.com> <20181113113000.GB4788@gmail.com>
 <40E4E1B4-EF5F-43A1-B42C-C4CF6349FC62@vmware.com>
 <48577A3F-0F76-4CCA-A959-965344D7259F@vmware.com>
 <7ff5de62-d1df-9a67-1c86-497ce00a4de4@deltatee.com>
 <7072A2D8-30F8-45CB-AB0C-B1BE4A30259A@vmware.com>
 <db8293cf-9abc-e899-8f43-6e42039006d9@deltatee.com>
In-Reply-To: <db8293cf-9abc-e899-8f43-6e42039006d9@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4151;20:bqDhEeEXT+IMopBnp2qpTZOOmu/pE+EzCH93BYx7OUj4w+HkUbQCBVV3vMLLm8rne2YZdSAk72Xrk/ORKKEi2k71bkIeue7cmUCw9FJbsJio3Oac6sMLiJplLQCrYt9vmdGuUMS5iRfaPEhY7wSuNxVDLGs7mmxHOFcZTEt/bwA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f8d9741a-8319-4a0b-8c70-08d64a9dc11a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4151;
x-ms-traffictypediagnostic: BYAPR05MB4151:
x-microsoft-antispam-prvs: <BYAPR05MB41518341036F1BB0B5A46B9ED0DC0@BYAPR05MB4151.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231415)(944501410)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4151;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4151;
x-forefront-prvs: 08572BD77F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(366004)(346002)(199004)(189003)(316002)(25786009)(4326008)(33656002)(81166006)(6246003)(8676002)(81156014)(66066001)(97736004)(6116002)(3846002)(36756003)(7416002)(305945005)(5660300001)(7736002)(71200400001)(71190400001)(86362001)(53936002)(110136005)(54906003)(186003)(83716004)(256004)(2906002)(6512007)(486006)(105586002)(476003)(76176011)(106356001)(6436002)(2616005)(11346002)(14454004)(229853002)(8936002)(478600001)(446003)(102836004)(2900100001)(68736007)(6486002)(6506007)(93886005)(53546011)(26005)(82746002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4151;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Nxwuj7Xu+TUiMudFHedoXD2980in5v/1GL+jXPcU1vVk0QxU/Bvsxd9BI+mghFuKgWqp5zw1hp5IjlQ7N3EOSfIof9L0tZlgxz+cD+rlg7E6RC0oo8MlnBsToCi7gzgOhGWtR9UiGY2JzVt8Lx6p4QnJSsOlsAMVOZFiXU/VdHIWmX0EKYB1uCyIfJoPC7/Rs9IRRr8HBm3jPG2dAlYhiliWH6Y2iYnZWtxb6OgdcHzLfYj4pRFo4xduOl+K+/NPGBL9J2wg1eVA4j1tRPg9AferE6wIA5iuXvB+iCLF5bNV3zRF9LpdoEDUdRcN6t0Mpz/vRWcP/n1jNSOkn/bYp30/YFqHIhQLaUjSg9HAjtk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <76E9724BC3F0074D925520914DA1C496@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d9741a-8319-4a0b-8c70-08d64a9dc11a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2018 01:57:52.8317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTG9nYW4gR3VudGhvcnBlDQpTZW50OiBOb3ZlbWJlciAxNSwgMjAxOCBhdCAxOjE5OjQ1
IEFNIEdNVA0KPiBUbzogTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4sIEluZ28gTW9sbmFy
IDxtaW5nb0BrZXJuZWwub3JnPg0KPiBDYzogSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+
LCBNYXNhaGlybyBZYW1hZGEgPHlhbWFkYS5tYXNhaGlyb0Bzb2Npb25leHQuY29tPiwgTWljaGFs
IE1hcmVrIDxtaWNoYWwubGttbEBtYXJrb3ZpLm5ldD4sIFRob21hcyBHbGVpeG5lciA8dGdseEBs
aW51dHJvbml4LmRlPiwgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+LCBILiBQZXRlciBB
bnZpbiA8aHBhQHp5dG9yLmNvbT4sIFg4NiBNTCA8eDg2QGtlcm5lbC5vcmc+LCBMaW51eCBLYnVp
bGQgbWFpbGluZyBsaXN0IDxsaW51eC1rYnVpbGRAdmdlci5rZXJuZWwub3JnPiwgTEtNTCA8bGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIE1h
a2VmaWxlOiBGaXggZGlzdGNjIGNvbXBpbGF0aW9uIHdpdGggeDg2IG1hY3Jvcw0KPiANCj4gDQo+
IA0KPiANCj4gT24gMTQvMTEvMTggMTA6NDYgQU0sIE5hZGF2IEFtaXQgd3JvdGU6DQo+PiBBY3R1
YWxseSwgd2UgY2FuIGp1c3QgZmlndXJlIG91dCB3aGV0aGVyIGRpc3RjYyBvciBpY2VjYyBhcmUg
dXNlZCBpbiB0aGUNCj4+IE1ha2VmaWxlIGFjY29yZGluZyB0byB0aGUg4oCcdmVyc2lvbuKAnSwg
c2ltaWxhcmx5IHRvIHRoZSB3YXkgY2xhbmcgaXMgZGV0ZWN0ZWQuDQo+PiBUaGlzIHdvdWxkIG5l
aXRoZXIgcmVxdWlyZSBuZXcgTWFrZWZpbGUgYXJndW1lbnRzIG9yIEtjb25maWcgb3B0aW9ucy4N
Cj4+IA0KPj4gV2hhdCBkbyB5b3Ugc2F5IGFib3V0IHRoZSBmb2xsb3dpbmc/DQo+IA0KPiBUaGF0
IG1heSBiZSBhIGdvb2QgaWRlYSwgYnV0IEkgd2FzIGtpbmQgb2YgaG9waW5nIHRvIGJlIGFibGUg
dG8gYWRkDQo+IHN1cHBvcnQgZm9yIHRoaXMgdG8gYXQgbGVhc3QgYSBmdXR1cmUgdmVyc2lvbiBv
ZiBpY2VjYyAodGhvdWdoIEknbSBub3QNCj4gY29tbWl0dGluZyB0byB0aGF0Li4uKS4gU28gaXQg
d291bGQgYmUgbmljZSB0byBoYXZlIGEgd2F5IHRvIGZvcmNlIGl0DQo+IG9uZSB3YXkgb3IgdGhl
IG90aGVyIHdpdGggYW4gZW52aXJvbm1lbnQgdmFyaWFibGUuDQoNCkFzIGxvbmcgYXMgdGhlIGFy
Z3VtZW50IHdhcyAqcmVxdWlyZWQqIHRvIGdldCBkaXN0Y2MgdG8gd29yayBhdCBhbGwsIHlvdQ0K
Y291bGQgZXhwZWN0IHBlb3BsZSB3b3VsZCBmaWd1cmUgb3V0IGFuIGFyZ3VtZW50IGlzIG5lZWRl
ZC4gSW4gdGhpcyBjYXNlLCBJDQpzdXNwZWN0IG5vYm9keSB3aWxsIGV2ZXIga25vdyBhYm91dCB0
aGlzIGFyZ3VtZW50IChleGNlcHQgeW91KS4NCg0KRXZlbnR1YWxseSwgaWYgeW91IGdldCBhIGZp
eCBpbnRvIGljZWNjLCB3ZSB3aWxsIG5lZWQgdG8gY2hhbmdlIHRoZQ0KTWFrZWZpbGUsIGNvbnNp
ZGVyIHRoZSB2ZXJzaW9uIG51bWJlciBhbmQgYWN0IGFjY29yZGluZ2x5Lg0KDQpBbnlob3csIEni
gJlsbCBhZGQgYW4gYXJndW1lbnQgYXMgeW91IGFza2VkLCBhbmQgbGV0IEluZ28gKCYgb3RoZXJz
KSBiZSB0aGUNCmp1ZGdlKHMpLg0KDQo=
