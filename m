Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F881ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F6F206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="E8mWEPL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F6F206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391337AbeIVA4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:56:46 -0400
Received: from mail-eopbgr720138.outbound.protection.outlook.com ([40.107.72.138]:35910
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728456AbeIVA4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pOCgFUISleO1LffKEYdS05I6xLDvo83PJDAQTp7XxE=;
 b=E8mWEPL6x8LqqGKNjbgi+kslzpyAy/PRVDNGOqXkjwe63X0oJTQkQeqYdC3ARWpc9QNtuGUGT8xbR9FchkJE9z41yCug7ylHQYXQJRPDTksdS4tvDDSTzXg+HQaSGbCY40sXYdX9ISG9NuskLNS8K1EPqU5OZV9U2DxoZWBjdrM=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0635.namprd21.prod.outlook.com (10.175.111.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Fri, 21 Sep 2018 19:06:30 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1185.010; Fri, 21 Sep 2018
 19:06:30 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC:     "mhocko@suse.com" <mhocko@suse.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 2/5] mm: Create non-atomic version of SetPageReserved
 for init use
Thread-Topic: [PATCH v4 2/5] mm: Create non-atomic version of SetPageReserved
 for init use
Thread-Index: AQHUUTEv94BrDMQoPUO+UY9dTgyn8KT7GgMA
Date:   Fri, 21 Sep 2018 19:06:30 +0000
Message-ID: <b3a1bf0a-3cce-21a7-0543-716627c753db@microsoft.com>
References: <20180920215824.19464.8884.stgit@localhost.localdomain>
 <20180920222641.19464.75787.stgit@localhost.localdomain>
In-Reply-To: <20180920222641.19464.75787.stgit@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0635;6:A9zIHG5VNHnY9gkJrOzahDBWp4LDb5+psmvoUWSPN/5zf1l7lJis1PXyfcngCITtOC0wHLNEspVFH/y8LHOjIpZZ7+GD/R9uUdcrNhPXDAH0c9ZJI6ta+XgXPSmKDXBAf/nqkgszrp4nvnXcUXPc4QAfIYW8ZoqyAShSRscQ+QYnqTSUtm+2IZtT/B61YYrNM4Y8iQhdqWd7zpdSe09ZuRp9rwlxXyaR2LOEBQaAvLTT5gBEuX3LvvKKs97Lfc0ig5YZADR1ye2zm3n3kSCcsS8SDoyglnydUW9DN3FLyCuKLEyuHt2qGQNdDDFpAQWVuNz2uGlTaNwWGMGasyeJMHWWZHHFqLas3U5qPOfmEsjM2OKw/SnkakXeryeuDIqJc9vBG2qp+TzY4STKMb7pOYYX0i5QXp3TwdP5Jem6o6exj7SeFH7e6oBSKeF5z5IOAifQdFVBzjO/tVjbfvHN1g==;5:6yLOJV69x2QMHzxfo3H0isPM+HMu0RYKrKzdcDuGrOmg5k53S+kf7L3PD/QgcQAU2FaJYevek19n+ziA8tmHZeBDIfWUjqmFReDpSVzvsQa/DsG6pK+SOlJPYw271R/nbiwyNSXMTrIM08tBMpJ35T7lj6thDdSr5kT+Am8ms3k=;7:QvdLvLwnk+naOKdX/TrwkX0OsjdEu6xHshYCCZnvA7V1bPPm06ptO8Ythl38CxUTI4O3C/JcvxDnWj5ZXS9N+yahElxnbffA1fi3vst5VjQ+MxGeszrjiRnL6Szp2u43eyY6gErtIdWTlfDc8KDRxudJt2X1JldM15oHMYW3PmOwDSTv3AOqWsGi3iskS/A7bytRyr6YWsUaLVw5ZdlmqfNXfyhmOag2dfB86fWkqg19fO32J9Osyy6IYTOZ8vzu
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d19c4369-764c-46cc-eea3-08d61ff556b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0635;
x-ms-traffictypediagnostic: DM5PR21MB0635:
x-microsoft-antispam-prvs: <DM5PR21MB0635C9E5AA0406BAE2FAF6849D120@DM5PR21MB0635.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(209352067349851)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149050)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:DM5PR21MB0635;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0635;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(396003)(376002)(366004)(189003)(199004)(4326008)(105586002)(106356001)(186003)(22452003)(6346003)(102836004)(31686004)(110136005)(26005)(54906003)(316002)(2900100001)(8936002)(7416002)(53936002)(68736007)(2906002)(7736002)(81156014)(81166006)(36756003)(305945005)(66066001)(53546011)(6436002)(6512007)(229853002)(72206003)(6486002)(8676002)(5660300001)(99286004)(486006)(6246003)(97736004)(476003)(11346002)(14444005)(256004)(3846002)(6116002)(478600001)(2501003)(2616005)(76176011)(5250100002)(31696002)(86612001)(86362001)(2201001)(446003)(25786009)(6506007)(14454004)(10090500001)(71200400001)(10290500003)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0635;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: LE4li78WmU6W1ESIADN55VWgwCeaP8DZHjslXYGZ3uSCKNsAMPpx8MBYjwgMQ/ykMHzQg4YGMglsgh/UWiBECMXeeQeW5VOkKtFbMU7Uan4ByHBAcDJMIhq6fwLn6BcYkP7auaImixrgNa8NJJsEeGc8ZuW+3puw9t9fq20SXj5g0cdLhzRuiKdrbjIhhyvYtqrb2tB3ncFh6wgS4ZrYGQ63S6byhr9yQu/njDxl0luOeSWDLM1fmPoUyOFD2jXF9qG8eIQyfPWNYmI2V0fVRLDfv8hNvrWitByIwcd01lQWfjwb/YTmyxeUQJQM87oXkI4NmkgTT+K0oeVkv6Yx+fX9LWztBJfo9qOsH9goExE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D98AE5FDAC9A084687AB3C1C63482F26@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19c4369-764c-46cc-eea3-08d61ff556b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 19:06:30.0654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0635
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDkvMjAvMTggNjoyNyBQTSwgQWxleGFuZGVyIER1eWNrIHdyb3RlOg0KPiBJdCBkb2Vz
bid0IG1ha2UgbXVjaCBzZW5zZSB0byB1c2UgdGhlIGF0b21pYyBTZXRQYWdlUmVzZXJ2ZWQgYXQg
aW5pdCB0aW1lDQo+IHdoZW4gd2UgYXJlIHVzaW5nIG1lbXNldCB0byBjbGVhciB0aGUgbWVtb3J5
IGFuZCBtYW5pcHVsYXRpbmcgdGhlIHBhZ2UNCj4gZmxhZ3MgdmlhIHNpbXBsZSAiJj0iIGFuZCAi
fD0iIG9wZXJhdGlvbnMgaW4gX19pbml0X3NpbmdsZV9wYWdlLg0KPiANCj4gVGhpcyBwYXRjaCBh
ZGRzIGEgbm9uLWF0b21pYyB2ZXJzaW9uIF9fU2V0UGFnZVJlc2VydmVkIHRoYXQgY2FuIGJlIHVz
ZWQNCj4gZHVyaW5nIHBhZ2UgaW5pdCBhbmQgc2hvd3MgYWJvdXQgYSAxMCUgaW1wcm92ZW1lbnQg
aW4gaW5pdGlhbGl6YXRpb24gdGltZXMNCj4gb24gdGhlIHN5c3RlbXMgSSBoYXZlIGF2YWlsYWJs
ZSBmb3IgdGVzdGluZy4gT24gdGhvc2Ugc3lzdGVtcyBJIHNhdw0KPiBpbml0aWFsaXphdGlvbiB0
aW1lcyBkcm9wIGZyb20gYXJvdW5kIDM1IHNlY29uZHMgdG8gYXJvdW5kIDMyIHNlY29uZHMgdG8N
Cj4gaW5pdGlhbGl6ZSBhIDNUQiBibG9jayBvZiBwZXJzaXN0ZW50IG1lbW9yeS4gSSBiZWxpZXZl
IHRoZSBtYWluIGFkdmFudGFnZQ0KPiBvZiB0aGlzIGlzIHRoYXQgaXQgYWxsb3dzIGZvciBtb3Jl
IGNvbXBpbGVyIG9wdGltaXphdGlvbiBhcyB0aGUgX19zZXRfYml0DQo+IG9wZXJhdGlvbiBjYW4g
YmUgcmVvcmRlcmVkIHdoZXJlYXMgdGhlIGF0b21pYyB2ZXJzaW9uIGNhbm5vdC4NCj4gDQo+IEkg
dHJpZWQgYWRkaW5nIGEgYml0IG9mIGRvY3VtZW50YXRpb24gYmFzZWQgb24gY29tbWl0IDxmMWRk
MmNkMTNjND4gKCJtbSwNCj4gbWVtb3J5X2hvdHBsdWc6IGRvIG5vdCBhc3NvY2lhdGUgaG90YWRk
ZWQgbWVtb3J5IHRvIHpvbmVzIHVudGlsIG9ubGluZSIpLg0KPiANCj4gSWRlYWxseSB0aGUgcmVz
ZXJ2ZWQgZmxhZyBzaG91bGQgYmUgc2V0IGVhcmxpZXIgc2luY2UgdGhlcmUgaXMgYSBicmllZg0K
PiB3aW5kb3cgd2hlcmUgdGhlIHBhZ2UgaXMgaW5pdGlhbGl6YXRpb24gdmlhIF9faW5pdF9zaW5n
bGVfcGFnZSBhbmQgd2UgaGF2ZQ0KPiBub3Qgc2V0IHRoZSBQR19SZXNlcnZlZCBmbGFnLiBJJ20g
bGVhdmluZyB0aGF0IGZvciBhIGZ1dHVyZSBwYXRjaCBzZXQgYXMNCj4gdGhhdCB3aWxsIHJlcXVp
cmUgYSBtb3JlIHNpZ25pZmljYW50IHJlZmFjdG9yLg0KPiANCj4gQWNrZWQtYnk6IE1pY2hhbCBI
b2NrbyA8bWhvY2tvQHN1c2UuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgRHV5Y2sg
PGFsZXhhbmRlci5oLmR1eWNrQGxpbnV4LmludGVsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFBhdmVs
IFRhdGFzaGluIDxwYXZlbC50YXRhc2hpbkBtaWNyb3NvZnQuY29tPg0KDQo+IC0tLQ0KPiANCj4g
djQ6IEFkZGVkIGNvbW1lbnQgYWJvdXQgX19zZXRfYml0IHZzIHNldF9iaXQgdG8gdGhlIHBhdGNo
IGRlc2NyaXB0aW9uDQo+IA0KPiAgaW5jbHVkZS9saW51eC9wYWdlLWZsYWdzLmggfCAgICAxICsN
Cj4gIG1tL3BhZ2VfYWxsb2MuYyAgICAgICAgICAgIHwgICAgOSArKysrKysrLS0NCj4gIDIgZmls
ZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvcGFnZS1mbGFncy5oIGIvaW5jbHVkZS9saW51eC9wYWdlLWZs
YWdzLmgNCj4gaW5kZXggOTM0ZjkxZWYzZjU0Li41MGNlMWJkZGFmNTYgMTAwNjQ0DQo+IC0tLSBh
L2luY2x1ZGUvbGludXgvcGFnZS1mbGFncy5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvcGFnZS1m
bGFncy5oDQo+IEBAIC0zMDMsNiArMzAzLDcgQEAgc3RhdGljIGlubGluZSB2b2lkIHBhZ2VfaW5p
dF9wb2lzb24oc3RydWN0IHBhZ2UgKnBhZ2UsIHNpemVfdCBzaXplKQ0KPiAgDQo+ICBQQUdFRkxB
RyhSZXNlcnZlZCwgcmVzZXJ2ZWQsIFBGX05PX0NPTVBPVU5EKQ0KPiAgCV9fQ0xFQVJQQUdFRkxB
RyhSZXNlcnZlZCwgcmVzZXJ2ZWQsIFBGX05PX0NPTVBPVU5EKQ0KPiArCV9fU0VUUEFHRUZMQUco
UmVzZXJ2ZWQsIHJlc2VydmVkLCBQRl9OT19DT01QT1VORCkNCj4gIFBBR0VGTEFHKFN3YXBCYWNr
ZWQsIHN3YXBiYWNrZWQsIFBGX05PX1RBSUwpDQo+ICAJX19DTEVBUlBBR0VGTEFHKFN3YXBCYWNr
ZWQsIHN3YXBiYWNrZWQsIFBGX05PX1RBSUwpDQo+ICAJX19TRVRQQUdFRkxBRyhTd2FwQmFja2Vk
LCBzd2FwYmFja2VkLCBQRl9OT19UQUlMKQ0KPiBkaWZmIC0tZ2l0IGEvbW0vcGFnZV9hbGxvYy5j
IGIvbW0vcGFnZV9hbGxvYy5jDQo+IGluZGV4IDcxMmNhYjE3Zjg2Zi4uMjliZDY2MmZmZmQ3IDEw
MDY0NA0KPiAtLS0gYS9tbS9wYWdlX2FsbG9jLmMNCj4gKysrIGIvbW0vcGFnZV9hbGxvYy5jDQo+
IEBAIC0xMjM5LDcgKzEyMzksMTIgQEAgdm9pZCBfX21lbWluaXQgcmVzZXJ2ZV9ib290bWVtX3Jl
Z2lvbihwaHlzX2FkZHJfdCBzdGFydCwgcGh5c19hZGRyX3QgZW5kKQ0KPiAgCQkJLyogQXZvaWQg
ZmFsc2UtcG9zaXRpdmUgUGFnZVRhaWwoKSAqLw0KPiAgCQkJSU5JVF9MSVNUX0hFQUQoJnBhZ2Ut
PmxydSk7DQo+ICANCj4gLQkJCVNldFBhZ2VSZXNlcnZlZChwYWdlKTsNCj4gKwkJCS8qDQo+ICsJ
CQkgKiBubyBuZWVkIGZvciBhdG9taWMgc2V0X2JpdCBiZWNhdXNlIHRoZSBzdHJ1Y3QNCj4gKwkJ
CSAqIHBhZ2UgaXMgbm90IHZpc2libGUgeWV0IHNvIG5vYm9keSBzaG91bGQNCj4gKwkJCSAqIGFj
Y2VzcyBpdCB5ZXQuDQo+ICsJCQkgKi8NCj4gKwkJCV9fU2V0UGFnZVJlc2VydmVkKHBhZ2UpOw0K
PiAgCQl9DQo+ICAJfQ0KPiAgfQ0KPiBAQCAtNTUxMyw3ICs1NTE4LDcgQEAgdm9pZCBfX21lbWlu
aXQgbWVtbWFwX2luaXRfem9uZSh1bnNpZ25lZCBsb25nIHNpemUsIGludCBuaWQsIHVuc2lnbmVk
IGxvbmcgem9uZSwNCj4gIAkJcGFnZSA9IHBmbl90b19wYWdlKHBmbik7DQo+ICAJCV9faW5pdF9z
aW5nbGVfcGFnZShwYWdlLCBwZm4sIHpvbmUsIG5pZCk7DQo+ICAJCWlmIChjb250ZXh0ID09IE1F
TU1BUF9IT1RQTFVHKQ0KPiAtCQkJU2V0UGFnZVJlc2VydmVkKHBhZ2UpOw0KPiArCQkJX19TZXRQ
YWdlUmVzZXJ2ZWQocGFnZSk7DQo+ICANCj4gIAkJLyoNCj4gIAkJICogTWFyayB0aGUgYmxvY2sg
bW92YWJsZSBzbyB0aGF0IGJsb2NrcyBhcmUgcmVzZXJ2ZWQgZm9yDQo+IA==
