Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E72ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806B22086E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806B22086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbeIRAH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 20:07:27 -0400
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:20578 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeIRAH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 20:07:26 -0400
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3426.houston.hpe.com (Postfix) with ESMTPS id 845EB5A;
        Mon, 17 Sep 2018 18:38:51 +0000 (UTC)
Received: from G9W8677.americas.hpqcorp.net (16.220.49.24) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 17 Sep 2018 18:38:30 +0000
Received: from G1W8106.americas.hpqcorp.net (16.193.72.61) by
 G9W8677.americas.hpqcorp.net (16.220.49.24) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 17 Sep 2018 18:38:30 +0000
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (15.241.52.11) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Mon, 17 Sep 2018 18:38:30 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB0753.NAMPRD84.PROD.OUTLOOK.COM (10.169.5.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 17 Sep 2018 18:38:28 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac4f:ac06:14f9:d283]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac4f:ac06:14f9:d283%2]) with mapi id 15.20.1143.014; Mon, 17 Sep 2018
 18:38:28 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "will.deacon@arm.com" <will.deacon@arm.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "Hocko, Michal" <MHocko@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/5] ioremap: Rework pXd_free_pYd_page() API
Thread-Topic: [PATCH 1/5] ioremap: Rework pXd_free_pYd_page() API
Thread-Index: AQHUSoMKoOShLl5RW0iSVsyGvjy8o6TwQCwAgAAJcoCABBXdAIAAdrcA
Date:   Mon, 17 Sep 2018 18:38:28 +0000
Message-ID: <f4b73d9d61e87712fec1712bb6225e2b385a16e3.camel@hpe.com>
References: <1536747974-25875-1-git-send-email-will.deacon@arm.com>
         <1536747974-25875-2-git-send-email-will.deacon@arm.com>
         <71baefb8e0838fba89ee06262bbb2456e9091c7a.camel@hpe.com>
         <db3f513bf3bfafb85b99f57f741f5bb07952af70.camel@hpe.com>
         <20180917113328.GC22717@arm.com>
In-Reply-To: <20180917113328.GC22717@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-originating-ip: [15.219.163.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0753;6:AP3cD8/AaQu40vxkIFGj5oJ7FIvK+3NEshwDxZVfpnmBa//mABTh58zj0gTvhdHrkQJH/Uyo3t2jnzxnO/UcNLxdkDsR0bNEGFeSYegPhXsdBnlUXL+YPGleluFoAniAOZpFP/R7c0dOxjDX243OaxsZZpkwN/aQK1e4qPfiqYhZCMVzMtolhX6z50Eg4ormssaxnnjT1qpOKII3ET7PIi2RJhSMHSXBKwuA8nJt600BGw5qLwyh/9yTDuZ4bq5tUODFV9nvMhTZxkt5D4ubIAXuSIXjyaHdFu7rFjq4+AlrzFknQ2Xhv3P+akg73AC599aywHh5Rw2ULzp6dCiiW5WT8mY2sBlaQ/VqbjsxbJ/IIjkUUN8vK8wwJaMzMJrNezLxc5MNrobDX4RcTyQu5xH9DIXY7MXeD3Q0PfCKznJgF4sZ4OabDwKhsdz+ujvxIMtE9sNCmJ49fSSbtbNuZg==;5:KIinVkx2Q/WhcCv/R1MDsdqYKsna4CBAgd64QcMIBA4m6YdDlkiqCHHZ0YfUekCNo5H2vUJbsUAGQUT6Wr4YQozKrG25cJf3JMNweF0B/CK7O5BYdHbpC65Aknfr8ZBESAZGbwr4Z0XycLn6bW1G5rmxp8zQW9SYzjf58DBK/tM=;7:kHhWpd0DkWGCW70xNbFepjdoLhJil8efA5Oixztx85UqrfSeZ6uzxxkdSHVrdM2AvQzyJb2FC68UieMuJDCnf4EEZhQddicmoyFzk/ZFDyoi4OHEWJVD/oEDigxUv3ICAxSz1Som1Y0EkiJc7BzLsv/aEZ2bi0YrcBhfci5DPQWEFtyP2JQPBhW0QhxkW2Rzxw+vfurHuNlLh6yhJ7x65yaqv9bm6DYk4xAyFo4y4UajGPc4yEpkytT4Y4dEoPLO
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 101f5e65-b434-47a4-642e-08d61cccc293
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0753;
x-ms-traffictypediagnostic: AT5PR8401MB0753:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB07530940B5E291344DA6BDC1821E0@AT5PR8401MB0753.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(180628864354917)(222181515654134);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:AT5PR8401MB0753;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0753;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(346002)(396003)(366004)(136003)(189003)(199004)(54094003)(6512007)(2900100001)(305945005)(6246003)(7736002)(478600001)(102836004)(118296001)(256004)(6506007)(486006)(476003)(446003)(2616005)(11346002)(2501003)(66066001)(4326008)(86362001)(106356001)(105586002)(5250100002)(2351001)(76176011)(26005)(8676002)(186003)(5640700003)(25786009)(99286004)(93886005)(68736007)(3846002)(2906002)(6916009)(81166006)(81156014)(53936002)(36756003)(8936002)(6486002)(54906003)(14454004)(229853002)(6436002)(97736004)(316002)(6116002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0753;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: v2EXr1HR9RpcRFQNvfmRYnnb9WV730hYVYqWOtHdBDglqZvI/J6aCImaK/phtDYPqCTj96ouhemj/CH7Pqy0hbHHnkmJ+jnTMXuGJt6is5cJyYFtbQkMpNcJKr+2Wg/XN9cbMtMhBmUbZhsJXRZPnIg+Onmriqobwdtj/MQkfyaDztWiGXSrSpq23Rz7P/JqXW5QZ2lNLLHTQFoXXqXRU2ukMXkHAwQ1lmKZ/BXzCQn7NXuiwHAjVWPi3ETJ8XHQZhf0o5tDOkF+aRH5d4sJglnPey1hupKdIxdNxPz9kKW1z/81Vao9TJkiH7ZndWYTMis+Hy9diGNUSZTxgClKZdv6/9P9xOwQqm5GnohaMVw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F5E38911718DD40A11C9C087ED37C9F@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 101f5e65-b434-47a4-642e-08d61cccc293
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 18:38:28.2398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0753
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA5LTE3IGF0IDEyOjMzICswMTAwLCBXaWxsIERlYWNvbiB3cm90ZToNCj4g
T24gRnJpLCBTZXAgMTQsIDIwMTggYXQgMDk6MTA6NDlQTSArMDAwMCwgS2FuaSwgVG9zaGkgd3Jv
dGU6DQo+ID4gT24gRnJpLCAyMDE4LTA5LTE0IGF0IDE0OjM2IC0wNjAwLCBUb3NoaSBLYW5pIHdy
b3RlOg0KPiA+ID4gT24gV2VkLCAyMDE4LTA5LTEyIGF0IDExOjI2ICswMTAwLCBXaWxsIERlYWNv
biB3cm90ZToNCj4gPiA+ID4gVGhlIHJlY2VudGx5IG1lcmdlZCBBUEkgZm9yIGVuc3VyaW5nIGJy
ZWFrLWJlZm9yZS1tYWtlIG9uIHBhZ2UtdGFibGUNCj4gPiA+ID4gZW50cmllcyB3aGVuIGluc3Rh
bGxpbmcgaHVnZSBtYXBwaW5ncyBpbiB0aGUgdm1hbGxvYy9pb3JlbWFwIHJlZ2lvbiBpcw0KPiA+
ID4gPiBmYWlybHkgY291bnRlci1pbnR1aXRpdmUsIHJlc3VsdGluZyBpbiB0aGUgYXJjaCBmcmVl
aW5nIGZ1bmN0aW9ucw0KPiA+ID4gPiAoZS5nLiBwbWRfZnJlZV9wdGVfcGFnZSgpKSBiZWluZyBj
YWxsZWQgZXZlbiBvbiBlbnRyaWVzIHRoYXQgYXJlbid0DQo+ID4gPiA+IHByZXNlbnQuIFRoaXMg
cmVzdWx0ZWQgaW4gYSBtaW5vciBidWcgaW4gdGhlIGFybTY0IGltcGxlbWVudGF0aW9uLCBnaXZp
bmcNCj4gPiA+ID4gcmlzZSB0byBzcHVyaW91cyBWTV9XQVJOIG1lc3NhZ2VzLg0KPiA+ID4gPiAN
Cj4gPiA+ID4gVGhpcyBwYXRjaCBtb3ZlcyB0aGUgcFhkX3ByZXNlbnQoKSBjaGVja3Mgb3V0IGlu
dG8gdGhlIGNvcmUgY29kZSwNCj4gPiA+ID4gcmVmYWN0b3JpbmcgdGhlIGNhbGxzaXRlcyBhdCB0
aGUgc2FtZSB0aW1lIHNvIHRoYXQgd2UgYXZvaWQgdGhlIGNvbXBsZXgNCj4gPiA+ID4gY29uanVu
Y3Rpb25zIHdoZW4gZGV0ZXJtaW5pbmcgd2hldGhlciBvciBub3Qgd2UgY2FuIHB1dCBkb3duIGEg
aHVnZQ0KPiA+ID4gPiBtYXBwaW5nLg0KPiA+ID4gPiANCj4gPiA+ID4gQ2M6IENoaW50YW4gUGFu
ZHlhIDxjcGFuZHlhQGNvZGVhdXJvcmEub3JnPg0KPiA+ID4gPiBDYzogVG9zaGkgS2FuaSA8dG9z
aGkua2FuaUBocGUuY29tPg0KPiA+ID4gPiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0
cm9uaXguZGU+DQo+ID4gPiA+IENjOiBNaWNoYWwgSG9ja28gPG1ob2Nrb0BzdXNlLmNvbT4NCj4g
PiA+ID4gQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQo+ID4g
PiA+IFN1Z2dlc3RlZC1ieTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRp
b24ub3JnPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBXaWxsIERlYWNvbiA8d2lsbC5kZWFjb25A
YXJtLmNvbT4NCj4gPiA+IA0KPiA+ID4gWWVzLCB0aGlzIGxvb2tzIG5pY2VyLg0KPiA+ID4gDQo+
ID4gPiBSZXZpZXdlZC1ieTogVG9zaGkgS2FuaSA8dG9zaGkua2FuaUBocGUuY29tPg0KPiA+IA0K
PiA+IFNvcnJ5LCBJIHRha2UgaXQgYmFjayBzaW5jZSBJIGdvdCBhIHF1ZXN0aW9uLi4uDQo+ID4g
DQo+ID4gK3N0YXRpYyBpbnQgaW9yZW1hcF90cnlfaHVnZV9wbWQocG1kX3QgKnBtZCwgdW5zaWdu
ZWQgbG9uZyBhZGRyLA0KPiA+ID4gKwkJCQl1bnNpZ25lZCBsb25nIGVuZCwgcGh5c19hZGRyX3QN
Cj4gPiANCj4gPiBwaHlzX2FkZHIsDQo+ID4gPiArCQkJCXBncHJvdF90IHByb3QpDQo+ID4gPiAr
ew0KPiA+ID4gKwlpZiAoIWlvcmVtYXBfcG1kX2VuYWJsZWQoKSkNCj4gPiA+ICsJCXJldHVybiAw
Ow0KPiA+ID4gKw0KPiA+ID4gKwlpZiAoKGVuZCAtIGFkZHIpICE9IFBNRF9TSVpFKQ0KPiA+ID4g
KwkJcmV0dXJuIDA7DQo+ID4gPiArDQo+ID4gPiArCWlmICghSVNfQUxJR05FRChwaHlzX2FkZHIs
IFBNRF9TSVpFKSkNCj4gPiA+ICsJCXJldHVybiAwOw0KPiA+ID4gKw0KPiA+ID4gKwlpZiAocG1k
X3ByZXNlbnQoKnBtZCkgJiYgIXBtZF9mcmVlX3B0ZV9wYWdlKHBtZCwgYWRkcikpDQo+ID4gPiAr
CQlyZXR1cm4gMDsNCj4gPiANCj4gPiBJcyBwbV9wcmVzZW50KCkgYSBwcm9wZXIgY2hlY2sgaGVy
ZT8gIFdlIHByb2JhYmx5IGRvIG5vdCBoYXZlIHRoaXMgY2FzZQ0KPiA+IGZvciBpb21hcCwgYnV0
IEkgd29uZGVyIGlmIG9uZSBjYW4gZHJvcCBwLWJpdCB3aGlsZSBpdCBoYXMgYSBwdGUgcGFnZQ0K
PiA+IHVuZGVybmVhdGguDQo+IA0KPiBGb3IgaW9yZW1hcC92dW5tYXAgdGhlIHBYZF9wcmVzZW50
KCkgY2hlY2sgaXMgY29ycmVjdCwgeWVzLiBUaGUgdnVubWFwKCkNCj4gY29kZSBvbmx5IGV2ZXIg
Y2xlYXJzIGxlYWYgZW50cmllcywgbGVhdmluZyB0YWJsZSBlbnRyaWVzIGludGFjdC4gDQoNClJp
Z2h0LiBJIHdhcyB0aGlua2luZyBpZiBzdWNoIGNhc2UgaGFwcGVucyBpbiBmdXR1cmUuDQoNCj4g
SWYgaXQNCj4gZGlkIGNsZWFyIHRhYmxlIGVudHJpZXMsIHlvdSdkIGJlIHN0dWNrIGhlcmUgYmVj
YXVzZSB5b3Ugd291bGRuJ3QgaGF2ZQ0KPiB0aGUgYWRkcmVzcyBvZiB0aGUgdGFibGUgdG8gZnJl
ZS4NCj4gDQo+IElmIHNvbWVib2R5IGNhbGxlZCBwbWRfbWtub3RwcmVzZW50KCkgb24gYSB0YWJs
ZSBlbnRyeSwgd2UgbWF5IHJ1biBpbnRvDQo+IHByb2JsZW1zLCBidXQgaXQncyBvbmx5IHVzZWQg
Zm9yIGh1Z2UgbWFwcGluZ3MgYWZhaWN0Lg0KDQpUcmVhdGluZyBhIHRhYmxlIGVudHJ5IHZhbGlk
IHdoZW4gcC1iaXQgaXMgb2ZmIGlzIHJpc2t5IGFzIHdlbGwuIFNvLCBJDQphZ3JlZSB3aXRoIHRo
ZSBwWGRfcHJlc2VudCgpIGNoZWNrLg0KDQpSZXZpZXdlZC1ieTogVG9zaGkgS2FuaSA8dG9zaGku
a2FuaUBocGUuY29tPg0KDQpUaGFua3MsDQotVG9zaGkNCg0K
