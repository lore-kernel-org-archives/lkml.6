Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27998C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4E820652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bN2edBNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4E820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbeIFUto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:49:44 -0400
Received: from mail-by2nam01on0132.outbound.protection.outlook.com ([104.47.34.132]:36081
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725918AbeIFUtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxLilKWVxbfOuX0Rs2hlLgxJKHqa6m4rtGb3kgAD3lk=;
 b=bN2edBNP5Uu40jbbl47awml/AwnGV2k65/UVAFIBa5h7iaModYJyuHXSNOY5yH3lKJHZ5FigcKEE5pjEWYb+lP+EQqiQLKzr9G6IUeUdMjL0IRT+3OGPckZ8XPsMwoFAxz9481vFNuO49oeXD+4WaqG11lSze12nDZnW1UbcZy0=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0122.namprd21.prod.outlook.com (10.173.173.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Thu, 6 Sep 2018 16:12:36 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1143.000; Thu, 6 Sep 2018
 16:12:36 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>
CC:     Dave Hansen <dave.hansen@intel.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 1/2] mm: Move page struct poisoning to
 CONFIG_DEBUG_VM_PAGE_INIT_POISON
Thread-Topic: [PATCH v2 1/2] mm: Move page struct poisoning to
 CONFIG_DEBUG_VM_PAGE_INIT_POISON
Thread-Index: AQHURV1NzbtPIVbq00mlNM0Zm0ByOKTiv36AgACaFICAAAQQAIAAB+YAgAAIlYA=
Date:   Thu, 6 Sep 2018 16:12:36 +0000
Message-ID: <4f154937-118c-96cf-cf8e-c95a2ca68d44@microsoft.com>
References: <20180905211041.3286.19083.stgit@localhost.localdomain>
 <20180905211328.3286.71674.stgit@localhost.localdomain>
 <20180906054735.GJ14951@dhcp22.suse.cz>
 <0c1c36f7-f45a-8fe9-dd52-0f60b42064a9@intel.com>
 <20180906151336.GD14951@dhcp22.suse.cz>
 <CAKgT0UfiKWZO6hyjc1RpRTgD+CvM=KnbYokSueLFi7X5h+GMKQ@mail.gmail.com>
In-Reply-To: <CAKgT0UfiKWZO6hyjc1RpRTgD+CvM=KnbYokSueLFi7X5h+GMKQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0122;6:GF1d6+avTbFUNeBl9BVughDiQF+v9gHhYRnD5VIJRLyYNJ3s70rgyvcxvlXF7eqoQVfpJb5Y/RukQxME+lB7Swdkx5EyTd/Ir8kpD8WkUwqsvtRIPh/O6f2sVa01z+8nn43IPio6iX7eH2WSq6KARStUdp9EbMU5ancHbgh0OK21MQOMhQ/FXvbbxmrMYigQiy+b2kcEXTCh+WkEvP3mMmcHKS9BlnwTKQvM2hW1HKINns/lpzWcFXVfOumlxoMl9uC8bPfJJJPgW0SZgTfGwqwfleudjKKfjoosZmrPL3Cl1yMS5zi3WK9pP9zOQ3thGhb6PGIgIOEEIM0j2S3XvWi/tKYlGZkdO8DtLUvBkxOvwLshT+bxhqZBbuIXzJHx7wy3yPxkznUkB78fhIKAhY2tktfGANAu8ymH1QllSRGSwObC8TqEdU5qrpmvO3yjF13t05PdUzZahmxI22dB7Q==;5:QG2ihnB7RuX0y/fiacEM2haNgPzdLdlKiohfcXfETPP/oU+hBB3UYmTVLm371+U287lB0pOU9SkAFqHk5vsgdUtzD7Oq/L4wulKOIkv7C1YNoxQPRUwbVXUg2mmjNyhYY/LX6ZYnnP4X1VzE98mrV0T5yso9SaIvxgXhbjb7CxA=;7:NkwFnHoWUo7C9JD3s+B0nn7WZ4nM20mwgpuenz1XySFB+hzC0F5+zrMQVBg/D+FBnf570vKBsfacffnLbTHPurxETdA5gum9A06Mk5iZx2ZTnhliqpDMwG0qK6dY2XYXX/28LRfCv+y1YXRd6uHF0JK03lnH9ZCGDqocdMAAcWILYCovzBDi6v6rDThhaZtaFE+Qvp4ZxzIbe/8kJd7cnk7btz2efspZL47qBQVC/AIwwh41zcj0J+tdzL8PvQ4V
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7ed16a33-695c-4493-cbae-08d614138f9e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0122;
x-ms-traffictypediagnostic: DM5PR21MB0122:
x-microsoft-antispam-prvs: <DM5PR21MB0122C1CED6C4FCE0F8094EFA9D010@DM5PR21MB0122.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0122;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0122;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(396003)(376002)(346002)(199004)(189003)(476003)(76176011)(7736002)(305945005)(11346002)(446003)(2616005)(25786009)(486006)(10090500001)(229853002)(5660300001)(66066001)(6486002)(105586002)(31686004)(106356001)(10290500003)(6436002)(478600001)(22452003)(72206003)(81156014)(97736004)(14454004)(256004)(14444005)(5250100002)(6506007)(8676002)(102836004)(2501003)(54906003)(316002)(110136005)(36756003)(8936002)(68736007)(2900100001)(2906002)(81166006)(93886005)(53546011)(31696002)(6116002)(3846002)(53936002)(4326008)(86612001)(186003)(99286004)(39060400002)(26005)(6512007)(6246003)(6346003)(575784001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0122;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: VSqZNGuf1Oh3l5/fNGW+EO2OGOszEdz4YVlfn5HEdT4ziw8rnM6r/mIqk3msIMG73m8bh3UfaoWtBZ4Wwvgu2xqy2Ji/07hyj7TOTJeRASp1BMb+no50x62FxutLWLsayoaanKTcF7BCyrBQ2i07RWCvrG+1c7LFZ9Y6ofe2gLDC62iZGQxrpJs4wmqgpp759NeMi2vSgb5fBb2kNaZ//guWj6jqk4Cl5Ph9Cn1YkThmOWluqhsLoFtqaBq/9+hhRPnU63xxSTAmAQwbV2GX240AP2HOeRMMzVv2fU/fWxnal/87xgRiCHZ4LUctfIr+rSwDLZSbxRR4z77H8EB8rbd69Y7tgBC6oqM4VjITYa4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <92D9F6F3EE95D24493636AF43D018029@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed16a33-695c-4493-cbae-08d614138f9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 16:12:36.4111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDkvNi8xOCAxMTo0MSBBTSwgQWxleGFuZGVyIER1eWNrIHdyb3RlOg0KPiBPbiBUaHUs
IFNlcCA2LCAyMDE4IGF0IDg6MTMgQU0gTWljaGFsIEhvY2tvIDxtaG9ja29Aa2VybmVsLm9yZz4g
d3JvdGU6DQo+Pg0KPj4gT24gVGh1IDA2LTA5LTE4IDA3OjU5OjAzLCBEYXZlIEhhbnNlbiB3cm90
ZToNCj4+PiBPbiAwOS8wNS8yMDE4IDEwOjQ3IFBNLCBNaWNoYWwgSG9ja28gd3JvdGU6DQo+Pj4+
IHdoeSBkbyB5b3UgaGF2ZSB0byBrZWVwIERFQlVHX1ZNIGVuYWJsZWQgZm9yIHdvcmtsb2FkcyB3
aGVyZSB0aGUgYm9vdA0KPj4+PiB0aW1lIG1hdHRlcnMgc28gbXVjaCB0aGF0IGZldyBzZWNvbmRz
IG1hdHRlcj8NCj4+Pg0KPj4+IFRoZXJlIGFyZSBhIG51bWJlciBvZiBkaXN0cmlidXRpb25zIHRo
YXQgcnVuIHdpdGggaXQgZW5hYmxlZCBpbiB0aGUNCj4+PiBkZWZhdWx0IGJ1aWxkLiAgRmVkb3Jh
LCBmb3Igb25lLiAgV2UndmUgYmFzaWNhbGx5IGFzc3VtZWQgZm9yIGEgd2hpbGUNCj4+PiB0aGF0
IHdlIGhhdmUgdG8gbGl2ZSB3aXRoIGl0IGluIHByb2R1Y3Rpb24gZW52aXJvbm1lbnRzLg0KPj4+
DQo+Pj4gU28sIHdoZXJlIGRvZXMgbGVhdmUgdXM/ICBJIHRoaW5rIHdlIGVpdGhlciBuZWVkIGEg
X2dlbmVyaWNfIGRlYnVnDQo+Pj4gb3B0aW9uIGxpa2U6DQo+Pj4NCj4+PiAgICAgICBDT05GSUdf
REVCVUdfVk1fU0xPV19BU19IRUNLDQo+Pj4NCj4+PiB1bmRlciB3aGljaCB3ZSBjYW4gcHV0IHRo
aXMgYW4gb3RoZXIgcmVhbGx5IHNsb3cgVk0gZGVidWdnaW5nLiAgT3IsIHdlDQo+Pj4gbmVlZCBz
b21lIGtpbmQgb2YgYm9vdC10aW1lIHBhcmFtZXRlciB0byB0cmlnZ2VyIHRoZSBleHRyYSBjaGVj
a2luZw0KPj4+IGluc3RlYWQgb2YgYSBuZXcgQ09ORklHIG9wdGlvbi4NCj4+DQo+PiBJIHN0cm9u
Z2x5IHN1c3BlY3Qgbm9ib2R5IHdpbGwgZXZlciBlbmFibGUgc3VjaCBhIHNjYXJ5IGxvb2tpbmcg
Y29uZmlnDQo+PiBUQkguIEJlc2lkZXMgSSBhbSBub3Qgc3VyZSB3aGF0IHNob3VsZCBnbyB1bmRl
ciB0aGF0IGNvbmZpZyBvcHRpb24uDQo+PiBTb21ldGhpbmcgdGhhdCB0YWtlcyBmZXcgY3ljbGVz
IGJ1dCBpdCBpcyBjYWxsZWQgb2Z0ZW4gb3Igb25lIHRpbWUgc3R1ZmYNCj4+IHRoYXQgdGFrZXMg
cXVpdGUgYSBsb25nIGJ1dCBsZXNzIHRoYW4gYWdncmVnYXRlZCBvdmVyaGVhZCBvZiB0aGUgZm9y
bWVyPw0KPj4NCj4+IEp1c3QgY29uc2lkZXIgdGhpcyBwYXJ0aWN1bGFyIGNhc2UuIEl0IGJhc2lj
YWxseSByZS1hZGRzIGFuIG92ZXJoZWFkDQo+PiB0aGF0IGhhcyBhbHdheXMgYmVlbiB0aGVyZSBi
ZWZvcmUgdGhlIHN0cnVjdCBwYWdlIGluaXQgb3B0aW1pemF0aW9uDQo+PiB3ZW50IGl0LiBUaGUg
cG9pc29uaW5nIGp1c3QgcmV0dXJucyBpdCBpbiBhIGRpZmZlcmVudCBmb3JtIHRvIGNhdGNoDQo+
PiBwb3RlbnRpYWwgbGVmdCBvdmVycy4gQW5kIHdlIHdvdWxkIGxpa2UgdG8gaGF2ZSBhcyBtYW55
IHBlb3BsZSB3aWxsaW5nDQo+PiB0byBydW5uaW5nIGluIGRlYnVnIG1vZGUgdG8gdGVzdCBmb3Ig
dGhvc2UgcGF0aHMgYmVjYXVzZSB0aGV5IGFyZQ0KPj4gYmFzaWNhbGx5IGltcG9zc2libGUgdG8g
cmV2aWV3IGJ5IHRoZSBjb2RlIGluc3BlY3Rpb24uIE1vcmUgaW1wb3J0YW50bmx5DQo+PiB0aGUg
bWFqb3Igb3ZlcmhlYWQgaXMgYm9vdCB0aW1lIHNvIG15IHF1ZXN0aW9uIHN0aWxsIHN0YW5kcy4g
SXMgdGhpcw0KPj4gd29ydGggYSBzZXBhcmF0ZSBjb25maWcgb3B0aW9uIGFsbW9zdCBub2JvZHkg
aXMgZ29pbmcgdG8gZW5hYmxlPw0KPj4NCj4+IEVuYWJsaW5nIERFQlVHX1ZNIGJ5IEZlZG9yYSBh
bmQgb3RoZXJzIHNlcnZlcyB1cyBhIHZlcnkgZ29vZCB0ZXN0aW5nDQo+PiBjb3ZlcmFnZSBhbmQg
SSBhcHByZWNpYXRlIHRoYXQgYmVjYXVzZSBpdCBoYXMgZ2VuZXJhdGVkIHNvbWUgdXNlZnVsIGJ1
Zw0KPj4gcmVwb3J0cy4gVGhvc2UgcGVvcGxlIGFyZSBwYXlpbmcgcXVpdGUgYSBsb3Qgb2Ygb3Zl
cmhlYWQgaW4gcnVudGltZQ0KPj4gd2hpY2ggY2FuIGFnZ3JlZ2F0ZSBvdmVyIHRpbWUgaXMgaXQg
c28gbXVjaCB0byBhc2sgYWJvdXQgb25lIHRpbWUgYm9vdA0KPj4gb3ZlcmhlYWQ/DQo+IA0KPiBU
aGUga2luZCBvZiBib290IHRpbWUgYWRkLW9uIEkgc2F3IGFzIGEgcmVzdWx0IG9mIHRoaXMgd2Fz
IGFib3V0IDE3MA0KPiBzZWNvbmRzLCBvciAyIG1pbnV0ZXMgYW5kIDUwIHNlY29uZHMgb24gYSAx
MlRCIHN5c3RlbS4gSSBzcGVudCBhDQo+IGNvdXBsZSBtaW51dGVzIHdvbmRlcmluZyBpZiBJIGhh
ZCBidWlsdCBhIGJhZCBrZXJuZWwgb3Igbm90IGFzIEkgd2FzDQo+IHN0YXJpbmcgYXQgYSBkZWFk
IGNvbnNvbGUgdGhlIGVudGlyZSB0aW1lIGFmdGVyIHRoZSBncnViIHByb21wdCBzaW5jZQ0KPiBJ
IGhpdCB0aGlzIHNvIGVhcmx5IGluIHRoZSBib290LiBUaGF0IGlzIHRoZSByZWFzb24gd2h5IEkg
YW0gc28gZWFnZXINCj4gdG8gc2xpY2UgdGhpcyBvZmYgYW5kIG1ha2UgaXQgc29tZXRoaW5nIHNl
cGFyYXRlLiBJIGNvdWxkIGVhc2lseSBzZWUNCj4gdGhpcyBhcyBzb21ldGhpbmcgdGhhdCB3b3Vs
ZCBnZXQgaW4gdGhlIHdheSBvZiBvdGhlciBkZWJ1Z2dpbmcgdGhhdCBpcw0KPiBnb2luZyBvbiBp
biBhIHN5c3RlbS4NCj4gDQo+IElmIHdlIGRvbid0IHdhbnQgdG8gZG8gYSBjb25maWcgb3B0aW9u
LCB0aGVuIHdoYXQgYWJvdXQgYWRkaW5nIGENCj4ga2VybmVsIHBhcmFtZXRlciB0byBwdXQgYSBs
aW1pdCBvbiBob3cgbXVjaCBtZW1vcnkgd2Ugd2lsbCBpbml0aWFsaXplDQo+IGxpa2UgdGhpcyBi
ZWZvcmUgd2UganVzdCBzdGFydCBza2lwcGluZyBpdC4gV2UgY291bGQgcHV0IGEgZGVmYXVsdA0K
PiBsaW1pdCBvbiBpdCBsaWtlIDI1NkdCIGFuZCB0aGVuIG9uY2Ugd2UgY3Jvc3MgdGhhdCB0aHJl
c2hvbGQgd2UganVzdA0KPiBkb24ndCBib3RoZXIgcG9pc29uaW5nIGFueSBtb3JlIG1lbW9yeS4g
V2l0aCB0aGF0IHdlIHdvdWxkIHByb2JhYmx5IGJlDQo+IGFibGUgdG8gYXQgbGVhc3QgY292ZXIg
bW9zdCBvZiB0aGUgZWFybHkgbWVtb3J5IGluaXQsIGFuZCB0aGF0IHZhbHVlDQo+IHNob3VsZCBj
b3ZlciBtb3N0IHN5c3RlbXMgd2l0aG91dCBnZXR0aW5nIGludG8gZGVsYXlzIG9uIHRoZSBvcmRl
ciBvZg0KPiBtaW51dGVzLg0KDQpJIGFtIE9LIHdpdGggYSBib290IHBhcmFtZXRlciB0byBvcHRp
b25hbGx5IGRpc2FibGUgaXQgd2hlbiBERUJVR19WTSBpcw0KZW5hYmxlZC4gQnV0LCBJIGRvIG5v
dCB0aGluayBpdCBpcyBhIGdvb2QgaWRlYSB0byBtYWtlIHRoYXQgcGFyYW1ldGVyDQoic21hcnQi
IGJhc2ljYWxseSBhbHdheXMgcG9pc29uIG1lbW9yeSB3aXRoIERFQlVHX1ZNIHVubGVzcyBib290
ZXQgd2l0aA0KYSBwYXJhbWV0ZXIgdGhhdCB0ZWxscyBub3QgdG8gcG9pc29uIG1lbW9yeS4NCg0K
Q09ORklHX0RFQlVHX1ZNIGlzIGRpc2JsZWQgb246DQoNClJlZEhhdCwgT3JhY2xlIExpbnV4LCBD
ZW50T1MsIFVidW50dSwgQXJjaCBMaW51eCwgU1VTRQ0KDQpFbmFibGVkIG9uOg0KDQpGZWRvcmEN
Cg0KQXJlIHRoZXJlIG90aGVyIGRpc3Ryb3Mgd2hlcmUgaXQgaXMgZW5hYmxlZD8gSSB0aGluaywg
dGhpcyBjb3VsZCBiZQ0KZmlsZWQgYXMgYSBwZXJmb3JtYW5jZSBidWcgYWdhaW5zdCBGZWRvcmEg
ZGlzdHJvLCBhbmQgbGV0IHRoZSBkZWNpZGUNCndoYXQgdG8gZG8gYWJvdXQgaXQuDQoNCkkgZG8g
bm90IHdhbnQgdG8gbWFrZSB0aGlzIGZlYXR1cmUgbGVzcyB0ZXN0ZWQuIFBvaXNvbmluZyBtZW1v
cnkgYWxsb3dlZA0KdXMgdG8gY2F0Y2ggY29ybmVyIGNhc2UgYnVncyBsaWtlIHRoZXNlOg0KDQph
YjFlOGQ4OTYwYjY4ZjU0YWY0MmI2NDg0YjU5NTBiZDEzYTQwNTRiDQptbTogZG9uJ3QgYWxsb3cg
ZGVmZXJyZWQgcGFnZXMgd2l0aCBORUVEX1BFUl9DUFVfS00NCg0KZTE4MWFlMGM1ZGI5NTQ0ZGU5
YzUzMjM5ZWIyMmJjMDEyY2U3NTAzMw0KbW06IHplcm8gdW5hdmFpbGFibGUgcGFnZXMgYmVmb3Jl
IG1lbW1hcCBpbml0DQoNCkFuZCBzZXZlcmFsIG1vcmUgdGhhdCB3ZXJlIGZpeGVkIGJ5IG90aGVy
IHBlb3BsZS4NCg0KRm9yIGEgdmVyeSBsb25nIGxpbnV4IHJlbGllZCBvbiBhc3N1bXB0aW9uIHRo
YXQgYm9vdCBtZW1vcnkgaXMgemVyb2VkLA0KYW5kIEkgYW0gc3VyZSB3ZSB3aWxsIGNvbnRpbnVl
IGRldGVjdCBtb3JlIGJ1Z3Mgb3ZlciB0aW1lLg0KDQpUaGFuayB5b3UsDQpQYXZlbA0KDQo+IA0K
PiAtIEFsZXgNCj4g
