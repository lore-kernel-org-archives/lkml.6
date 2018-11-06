Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08353C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B4520862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="mckT1EUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B4520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388570AbeKGEo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:44:56 -0500
Received: from mail-co1nam03on0087.outbound.protection.outlook.com ([104.47.40.87]:23637
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388320AbeKGEo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:44:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrIC8PG4q6jahSAhDUUWCPXExHapzQLXtYBVHRxxg0Y=;
 b=mckT1EUpOuWNNWSlpU0DByHNMFSeNrbdhs4K4Xh194fPrHoIBMCzOEh4W+WOF6jwMytYhh5L25AtWDmfukRh0PHJYhcES9Q9IeLSe6be3FCrv2zi7PVnXksBfMTIrlSjgsA9kDL0pjQoWffUdHBCrMCPo6ustFQHv63VeORO7Es=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5544.namprd05.prod.outlook.com (20.177.186.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.19; Tue, 6 Nov 2018 19:18:10 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%5]) with mapi id 15.20.1294.034; Tue, 6 Nov 2018
 19:18:10 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        Ingo Molnar <mingo@redhat.com>
CC:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v9 02/10] Makefile: Prepare for using macros for inline
 asm
Thread-Topic: [PATCH v9 02/10] Makefile: Prepare for using macros for inline
 asm
Thread-Index: AQHUW2CZ0dZfAolPxUG9hT8O5ZUp5qVDToGAgAAFpAA=
Date:   Tue, 6 Nov 2018 19:18:10 +0000
Message-ID: <6651971B-E3AB-4CDD-868C-2338593F7D83@vmware.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181003213100.189959-3-namit@vmware.com>
 <89262174-6f15-6116-e67f-436f7c1bfe99@deltatee.com>
In-Reply-To: <89262174-6f15-6116-e67f-436f7c1bfe99@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5544;20:CFhtYQksA6BTNbWbvP0R+CKeFz3ZJ2YL4RaW2WJ+mQ7lAN47mEbL1aM38e5jw03og/w7eMgJPH6Wt8xR1tqfllKq8G6qTZihjdsUhF1MnpPeFXSLK0YzKkYR5rDUvLtfRfrIuao2dj+cI6rs9+3yXHIgX9J90QFPiVwxN705Tb8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c90d8d4c-26b1-4e18-c22f-08d6441c9745
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5544;
x-ms-traffictypediagnostic: BYAPR05MB5544:
x-microsoft-antispam-prvs: <BYAPR05MB554449337E50680BDBF031ADD0CB0@BYAPR05MB5544.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5544;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5544;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(366004)(136003)(376002)(189003)(199004)(105586002)(71200400001)(478600001)(4326008)(71190400001)(106356001)(83716004)(33656002)(25786009)(68736007)(14454004)(2900100001)(8936002)(8676002)(81166006)(81156014)(36756003)(6436002)(6512007)(6246003)(6486002)(66066001)(97736004)(99286004)(82746002)(26005)(53936002)(2906002)(6506007)(102836004)(53546011)(305945005)(7416002)(86362001)(76176011)(7736002)(3846002)(6116002)(446003)(186003)(486006)(110136005)(256004)(5660300001)(316002)(11346002)(2616005)(476003)(54906003)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5544;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RHxE0EnPAlAV+5tmHlppca+lkyeYf9ot83CDkbq+c38lDRO8ArQpj6RPsSkxa9Sc4Dr+hhSg+XQLhg2T12My187pu0UUxumVDuwTk8GLNStkHJoJqv94R32lpVM7bQn1Bvw0lA5R5tXv+EiAFDiwgJcMM9ZxkOFp1SsZQIFXNzZMEI56QtnxeS03TikJB3BSlsD9S+IXiBH8vVRu2yprwMOmnrN/klMNTOIY4/ezAi5RPGjtTZ92iVT8SDRbLVGtAha0KLFlrbeWoWvvx41ZLxCQ1Qdp0OyfzIGS3GI7YFnt03X2g5oXDQQQP5JaRume07iP8D6WyQOoYIHyddgGBh0U6c9WrALXS8owXO2QzDo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAE7421B1337784A9326978E4229FDD8@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c90d8d4c-26b1-4e18-c22f-08d6441c9745
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 19:18:10.5436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5544
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTG9nYW4gR3VudGhvcnBlDQpTZW50OiBOb3ZlbWJlciA2LCAyMDE4IGF0IDY6NTc6NTcg
UE0gR01UDQo+IFRvOiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPiwgSW5nbyBNb2xuYXIg
PG1pbmdvQHJlZGhhdC5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPiwg
eDg2QGtlcm5lbC5vcmc+LCBTYW0gUmF2bmJvcmcgPHNhbUByYXZuYm9yZy5vcmc+LCBNaWNoYWwg
TWFyZWsgPG1pY2hhbC5sa21sQG1hcmtvdmkubmV0PiwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxp
bnV0cm9uaXguZGU+LCBILiBQZXRlciBBbnZpbiA8aHBhQHp5dG9yLmNvbT4sIGxpbnV4LWtidWls
ZEB2Z2VyLmtlcm5lbC5vcmc+LCBTdGVwaGVuIEJhdGVzIDxzYmF0ZXNAcmFpdGhsaW4uY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHY5IDAyLzEwXSBNYWtlZmlsZTogUHJlcGFyZSBmb3IgdXNp
bmcgbWFjcm9zIGZvciBpbmxpbmUgYXNtDQo+IA0KPiANCj4gDQo+IA0KPiBPbiAyMDE4LTEwLTAz
IDM6MzAgcC5tLiwgTmFkYXYgQW1pdCB3cm90ZToNCj4+ICtBU01fTUFDUk9fRkxBR1MgPSAtV2Es
YXJjaC94ODYva2VybmVsL21hY3Jvcy5zIC1XYSwtDQo+PiArZXhwb3J0IEFTTV9NQUNST19GTEFH
Uw0KPj4gK0tCVUlMRF9DRkxBR1MgKz0gJChBU01fTUFDUk9fRkxBR1MpDQo+IA0KPiBJJ20gbm90
IHN1cmUgaG93IG11Y2ggd2UgY2FyZSBhYm91dCB0aGlzIG9yIHdoYXQgd2UgY2FuIGRvIGFib3V0
IGl0LCBidXQNCj4gYWRkaW5nIHRoZSBtYWNyb3MucyB0byB0aGUgY29tbWFuZCBsaW5lIGxpa2Ug
dGhpcyBoYXMgZWZmZWN0aXZlbHkgYnJva2VuDQo+IGRpc3RyaWJ1dGVkIGNvbXBpbGluZyB3aXRo
IGRpc3RjYyBhbmQgaWNlY2MgYXMgb2YgdjQuMjAtcmMxLiBOZWl0aGVyDQo+IHRvb2wgd2lsbCBz
dWNjZXNzZnVsbHkgZGlzdHJpYnV0ZSBhbnkgY29tcGlsZSBwcm9jZXNzZXMgYmVjYXVzZSB0aGUN
Cj4gbm9uLWxvY2FsIG1hY2hpbmVzIHdvbid0IGhhdmUgYSBjb3B5IG9mIG1hY3Jvcy5zLg0KDQpF
cnIuLiBJIGRvbuKAmXQgaGF2ZSBhIGRpc3QtY2MgZW52aXJvbm1lbnQuIEkgd29uZGVyIHdoZXRo
ZXIgc29tZXRoaW5nIGxpa2UNCnRoYXQgd291bGQgZG8gdGhlIHRyaWNrOg0KDQotLSA+OCDigJQN
Cg0KU3ViamVjdDogW1BBVENIXSB4ODY6IEZpeCBkaXN0LWNjDQoNCi0tLQ0KIGFyY2gveDg2L01h
a2VmaWxlIHwgNCArKy0tDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L01ha2VmaWxlIGIvYXJjaC94ODYvTWFr
ZWZpbGUNCmluZGV4IDViNTYyZTQ2NDAwOS4uODFkNzZjYmNmZmZmIDEwMDY0NA0KLS0tIGEvYXJj
aC94ODYvTWFrZWZpbGUNCisrKyBiL2FyY2gveDg2L01ha2VmaWxlDQpAQCAtMjM3LDkgKzIzNyw5
IEBAIGFyY2hoZWFkZXJzOg0KIAkkKFEpJChNQUtFKSAkKGJ1aWxkKT1hcmNoL3g4Ni9lbnRyeS9z
eXNjYWxscyBhbGwNCiANCiBhcmNobWFjcm9zOg0KLQkkKFEpJChNQUtFKSAkKGJ1aWxkKT1hcmNo
L3g4Ni9rZXJuZWwgYXJjaC94ODYva2VybmVsL21hY3Jvcy5zDQorCSQoUSkkKE1BS0UpICQoYnVp
bGQpPWFyY2gveDg2L2tlcm5lbCAke29ianRyZWV9L2FyY2gveDg2L2tlcm5lbC9tYWNyb3Mucw0K
IA0KLUFTTV9NQUNST19GTEFHUyA9IC1XYSxhcmNoL3g4Ni9rZXJuZWwvbWFjcm9zLnMgLVdhLC0N
CitBU01fTUFDUk9fRkxBR1MgPSAtV2EsJHtvYmp0cmVlfS9hcmNoL3g4Ni9rZXJuZWwvbWFjcm9z
LnMgLVdhLC0NCiBleHBvcnQgQVNNX01BQ1JPX0ZMQUdTDQogS0JVSUxEX0NGTEFHUyArPSAkKEFT
TV9NQUNST19GTEFHUykNCiANCi0tIA0KMi4xNy4xDQoNCg==
