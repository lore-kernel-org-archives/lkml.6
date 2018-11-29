Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A40AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1419F2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="oHekPWSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1419F2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeK2MfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:35:08 -0500
Received: from mail-eopbgr810071.outbound.protection.outlook.com ([40.107.81.71]:39072
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726786AbeK2MfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:35:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oui7iBtAa11kC482wZ24TSoF5xShYgfR0PVDIlWjrRU=;
 b=oHekPWSdo66+4c0nkkxHY3mhuDiyW7gtVwzGgD06xs78lntP3cLVJ2xFOXdvoiOpkG2B+gF5RzFpQZeKRiqrg2UG0aVwtGOPq+VUszm3NDBOAAb+9sZzLvBX2uE3OA7120dQYiQLRxLPst7zZ9gOV1prCpptpcpdgdPPfbu4Jdg=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB3941.namprd05.prod.outlook.com (52.135.195.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.7; Thu, 29 Nov 2018 01:31:28 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1404.008; Thu, 29 Nov 2018
 01:31:28 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Logan Gunthorpe <logang@deltatee.com>
CC:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Makefile: Fix distcc compilation with x86 macros
Thread-Topic: [PATCH 1/2] Makefile: Fix distcc compilation with x86 macros
Thread-Index: AQHUetXZ1x6cjbBfk0ugZnU2RuWk66VNksAAgABrugCAAArpgIAA2IoAgACsc4CAAH6KgIAACqQAgBXRgICAABjcAIAAAzkAgAALrgA=
Date:   Thu, 29 Nov 2018 01:31:27 +0000
Message-ID: <1CAF7187-4732-4BC9-8F7F-93EB16ED14E9@vmware.com>
References: <20181112150215.508-1-namit@vmware.com>
 <20181112150215.508-2-namit@vmware.com> <20181113113000.GB4788@gmail.com>
 <40E4E1B4-EF5F-43A1-B42C-C4CF6349FC62@vmware.com>
 <48577A3F-0F76-4CCA-A959-965344D7259F@vmware.com>
 <7ff5de62-d1df-9a67-1c86-497ce00a4de4@deltatee.com>
 <7072A2D8-30F8-45CB-AB0C-B1BE4A30259A@vmware.com>
 <db8293cf-9abc-e899-8f43-6e42039006d9@deltatee.com>
 <521458D7-A27C-4112-81ED-1974EFE96A76@vmware.com>
 <be24a6eb-ebf0-8d9f-0051-681f0da66109@deltatee.com>
 <5682CCB4-B7D3-4DDC-81BB-2D4DCE968A3D@vmware.com>
 <336cf7d8-6495-b112-8d3a-c146222fda78@deltatee.com>
In-Reply-To: <336cf7d8-6495-b112-8d3a-c146222fda78@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB3941;20:yzuY15f7CFeSEaH+TcwqFwQRE+e2BUJTRVhEJWCQprm4Clxpcs8p373YxG3BHd8KlFz54ja8rkgzTbBxj5Yae4GtlpJQ7beGnefYjKfvxYlW2BzysQTMGuprZ7eIz1EFi/f2sGzUuYNiv91dsEe+Lfa3tRSBlSxFdWhZT+I+yuQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 20290f7c-395c-4da5-c90b-08d6559a6267
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB3941;
x-ms-traffictypediagnostic: BYAPR05MB3941:
x-microsoft-antispam-prvs: <BYAPR05MB39412830AB7247936DB0C9ADD0D20@BYAPR05MB3941.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231452)(999002)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB3941;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB3941;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(376002)(366004)(396003)(189003)(199004)(81166006)(6506007)(81156014)(186003)(8936002)(25786009)(476003)(7416002)(93886005)(82746002)(446003)(26005)(11346002)(2616005)(4326008)(71190400001)(97736004)(71200400001)(68736007)(86362001)(6486002)(53936002)(6512007)(229853002)(6916009)(14454004)(83716004)(8676002)(4001150100001)(478600001)(316002)(6436002)(54906003)(486006)(256004)(7736002)(14444005)(6246003)(305945005)(2906002)(76176011)(6116002)(3846002)(106356001)(5660300001)(105586002)(66066001)(99286004)(33656002)(102836004)(36756003)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB3941;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9BMzRA1IR9wp3T2bXVNXczY6lEOCFVQsGWHd/PV9yXINmK2tBUZOn1o2jAq0uVPDNP0IPx/WUScCb2Q1gH9Cluqcv59tUttpPWVVe6haj8BnB6VbRGBQ2/Xr9q9dDZFdUomtg662Ta405/reEFxEjue6zie/hGM8kUvCkzEI9NGqyI2D6ox3r2IaYx08ASe4kU2u9Ktxlwe6BYV8puwr/CMdQaIfNeEILUl2bFTEnEC+nfLvZc3zXHB59cGiU1TAugdQpIeKSk9JKxlnd+FbnkDTNtptQe9lQjwN/qPC9j4sRzCF0JpyntH7ZXCd+ciEglcxlk0aIknAQMc6bf7mhU9CW3HG+4rkqX/g3KgSa+4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <51092CDFA830E44589A437910A7D3571@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20290f7c-395c-4da5-c90b-08d6559a6267
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 01:31:27.8634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB3941
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBOb3YgMjgsIDIwMTgsIGF0IDQ6NDkgUE0sIExvZ2FuIEd1bnRob3JwZSA8bG9nYW5nQGRl
bHRhdGVlLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+IE9uIDIwMTgtMTEtMjggNTozOCBwLm0u
LCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4gU28gd2hhdOKAmXMgeW91ciB0YWtlPyBXb3VsZCB5b3Ug
dGhpbmsgdGhpcyBwYXRjaCBpcyBzdGlsbCBuZWVkZWQ/IFNob3VsZCBpdA0KPj4gb25seSBiZSBl
bmFibGVkIGF1dG9tYXRpY2FsbHkgZm9yIGRpc3RjYyBhbmQgbm90IGZvciBkaXN0Y2MtcHVtcD8N
Cj4gDQo+IE5vdCBzdXJlLiBUaGUgcGF0Y2ggd2lsbCBwcm9iYWJseSBzbG93IHRoaW5ncyBkb3du
IGEgbG90IChzZWVpbmcNCj4gYXNzZW1ibHkgaXMgYWx3YXlzIGRvbmUgbG9jYWxseSBhbmQgdGhl
cmUgYXJlIHR3aWNlIGFzIG1hbnkgY29tcGlsZQ0KPiBzdGVwcykgYW5kIHdpbGwgY3JlYXRlIHNv
bWUgY29uZnVzaW9uIG9uY2UgaXQncyBwb3NzaWJsZSB0byBkaXNhYmxlIGl0DQo+IGZvciB0aGUg
bmV3IHZlcnNpb25zLiBNYXliZSBob2xkIG9mZiBhbmQgc2VlIGlmIGFueW9uZSBlbHNlIGNvbXBs
YWlucz8NCj4gDQo+IEkgZG9uJ3QgcmVhbGx5IGtub3cgaG93IHlvdSdkIGRldGVjdCB3aGV0aGVy
IHB1bXAgaXMgaW4gdXNlIG9yIG5vdCBhbmQNCj4gSSdtIHVuY2VydGFpbiBhcyB0byB3aGV0aGVy
IGFueSBvZiB0aGUgYXV0byBkZXRlY3Rpb24gY2FuIGFjdHVhbGx5IGJlDQo+IG1hZGUgdG8gYmUg
cmVsaWFibGUuDQoNCkEgc2lsbHkgYCQoQ0MpIOKAlHZlcnNpb24gfCBncmVwIHB1bXAgYCB0ZXN0
Lg0KDQpBbnlob3csIGl0IGlzIHVwIHRvIE1hc2FoaXJvLg0KDQo=
