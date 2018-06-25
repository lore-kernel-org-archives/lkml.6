Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCCEC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E237260C7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="odr1NzHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E237260C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755712AbeFYUZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 16:25:56 -0400
Received: from mail-eopbgr720121.outbound.protection.outlook.com ([40.107.72.121]:49696
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752219AbeFYUZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 16:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bg+NXFOVtfWER+ZaqaCUwZAjJDPr1BM4qqT+77qLgog=;
 b=odr1NzHY+UiPWPUOoICBPzWUMWGq+06++AcitDIsp6c+Pda7baqUfWb2Zz4WkVt4iIRA3EISrvUxvGvaG7XzcyLh6obmrklYW4zi10TtKrAoSbWlMce79oGdp0mr2L+jk0Kt2AoAjm4zJCGogh7hVvyiVET2Wq+tQXnFibzwPXI=
Received: from CY4PR2101MB0722.namprd21.prod.outlook.com (52.132.100.10) by
 CY4PR2101MB0722.namprd21.prod.outlook.com (52.132.100.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.2; Mon, 25 Jun 2018 20:25:52 +0000
Received: from CY4PR2101MB0722.namprd21.prod.outlook.com
 ([fe80::a849:9c0c:337b:2ee7]) by CY4PR2101MB0722.namprd21.prod.outlook.com
 ([fe80::a849:9c0c:337b:2ee7%5]) with mapi id 15.20.0930.005; Mon, 25 Jun 2018
 20:25:52 +0000
From:   Long Li <longli@microsoft.com>
To:     Tom Talpey <tom@talpey.com>, Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [Patch v2 02/15] CIFS: Add support for direct pages in rdata
Thread-Topic: [Patch v2 02/15] CIFS: Add support for direct pages in rdata
Thread-Index: AQHT+E9dvsQOBWcv606hJ7KjQvSo1KRuyssAgALIjTA=
Date:   Mon, 25 Jun 2018 20:25:52 +0000
Message-ID: <CY4PR2101MB07229D570089E6057F2C8B4BCE4A0@CY4PR2101MB0722.namprd21.prod.outlook.com>
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
 <20180530194807.31657-3-longli@linuxonhyperv.com>
 <67b8afe7-f5e0-b36a-fcc1-87f1ae08eaa4@talpey.com>
In-Reply-To: <67b8afe7-f5e0-b36a-fcc1-87f1ae08eaa4@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:a:fdde:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2101MB0722;7:6banl0o0UX92tndm29eSqaRYEEAs6OG57syvyrj2zWsZVQ2tDAJt/zOYzpP9pvFyTtYFaSOkVkAsq3TbbBYFJvuecuvTHuc9Jw7NU5gN/mvWmh99rirHRY3wioFzR3LY5MDLIG6Ao2oXRfnqNjzPXypmjyUmHDZGCr5+KG7nqyKCDvGYRLCP+cGgg0mFJVKaljtW7QTREuJnc0ZtKsGBTRVvsOd1E5aoBtOo9HzjfiC1UBXN4tmLYCeao/yVopQ4
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 59a70818-35c9-4594-a0da-08d5dad9d8ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:CY4PR2101MB0722;
x-ms-traffictypediagnostic: CY4PR2101MB0722:
x-microsoft-antispam-prvs: <CY4PR2101MB072291D3DFE0339CF5343A9DCE4A0@CY4PR2101MB0722.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY4PR2101MB0722;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2101MB0722;
x-forefront-prvs: 0714841678
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(376002)(136003)(346002)(199004)(189003)(486006)(6506007)(2900100001)(10290500003)(476003)(478600001)(14454004)(102836004)(446003)(76176011)(53546011)(99286004)(186003)(7696005)(97736004)(11346002)(86362001)(2906002)(86612001)(5660300001)(8990500004)(6116002)(2201001)(6346003)(25786009)(10090500001)(53936002)(55016002)(6436002)(8936002)(68736007)(229853002)(110136005)(33656002)(9686003)(6246003)(74316002)(305945005)(2501003)(5250100002)(7736002)(106356001)(105586002)(81156014)(8676002)(46003)(316002)(81166006)(22452003)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2101MB0722;H:CY4PR2101MB0722.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-microsoft-antispam-message-info: F/cOqD9pxS1YwczSz4aupKJUvtLKPkwNT+5exmBqRlPPg0u6qow/0XNPz+A0GcbuE7ciW6XClnuYRPsWJEYUez8yrglgLGtPYRXJYOSxmWqLKTKLN9JM0VkWA4exqYkGG1mXthyLKn+HMtrZVRygoti8j/oqQ/n//7eSUBjqgmZ7htqHZ1X0z9pDQ9wi96uQkL1U10HSd5fOrITFL2SuFesj37Z+BpxOZnpQjZHNMX25cF6nA5vheuCNAy8b5w70kv3dwqWCUaX+PmmbywGrXbWjm4vTk702H5H4Y7deBKD44OrYL9xsflfz5upli1Pr7Lrb/97hl+UuRqiQOB4jQnyll3xnQL0whiSa1X69oDg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a70818-35c9-4594-a0da-08d5dad9d8ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2018 20:25:52.1459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2101MB0722
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBUb20gVGFscGV5IDx0b21AdGFscGV5LmNvbT4NCj4gU2VudDogU2F0dXJkYXksIEp1
bmUgMjMsIDIwMTggNjo1MCBQTQ0KPiBUbzogTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+
OyBTdGV2ZSBGcmVuY2ggPHNmcmVuY2hAc2FtYmEub3JnPjsNCj4gbGludXgtY2lmc0B2Z2VyLmtl
cm5lbC5vcmc7IHNhbWJhLXRlY2huaWNhbEBsaXN0cy5zYW1iYS5vcmc7IGxpbnV4LQ0KPiBrZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBSZTogW1BhdGNoIHYyIDAyLzE1XSBDSUZTOiBBZGQgc3VwcG9ydCBmb3IgZGlyZWN0IHBhZ2Vz
IGluIHJkYXRhDQo+IA0KPiBPbiA1LzMwLzIwMTggMzo0NyBQTSwgTG9uZyBMaSB3cm90ZToNCj4g
PiBGcm9tOiBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT4NCj4gPg0KPiA+IEFkZCBhIGZ1
bmN0aW9uIHRvIGFsbG9jYXRlIHJkYXRhIHdpdGhvdXQgYWxsb2NhdGluZyBwYWdlcyBmb3IgZGF0
YQ0KPiA+IHRyYW5zZmVyLiBUaGlzIGdpdmVzIHRoZSBjYWxsZXIgYW4gb3B0aW9uIHRvIHBhc3Mg
YSBudW1iZXIgb2YgcGFnZXMNCj4gPiB0aGF0IHBvaW50IHRvIHRoZSBkYXRhIGJ1ZmZlci4NCj4g
Pg0KPiA+IHJkYXRhIGlzIHN0aWxsIHJlcG9uc2libGUgZm9yIGZyZWUgdGhvc2UgcGFnZXMgYWZ0
ZXIgaXQncyBkb25lLg0KPiANCj4gIkNhbGxlciIgaXMgc3RpbGwgcmVzcG9uc2libGU/IE9yIGlz
IHRoZSByZGF0YSBzb21laG93IGZyZWVpbmcgaXRzZWxmIHZpYSBhbm90aGVyDQo+IG1lY2hhbmlz
bT8NCg0KSSBtZWFudCB0byBzYXkgZnJlZSB0aGUgYXJyYXkgInN0cnVjdCBwYWdlICoqcGFnZXMi
LCBub3QgdGhlIHBhZ2VzIHRoZW1zZWx2ZXMuDQoNCkJlZm9yZSB0aGUgcGF0Y2gsIHRoZSBwYWdl
IGFycmF5IGlzIGFsbG9jYXRlZCBhdCB0aGUgZW5kIG9mIHRoZSBzdHJ1Y3QgY2lmc19yZWFkZGF0
YToNCg0KICAgICAgcmRhdGEgPSBremFsbG9jKHNpemVvZigqcmRhdGEpICsgKHNpemVvZihzdHJ1
Y3QgcGFnZSAqKSAqIG5yX3BhZ2VzKSwNCiAgICAgICAgICAgICAgICAgICAgICAgR0ZQX0tFUk5F
TCk7DQoNCklmIHRoaXMgaXMgdGhlIGNhc2UsIHRoZXkgYXJlIGF1dG9tYXRpY2FsbHkgZnJlZWQg
d2hlbiBjaWZzX3JlYWRkYXRhIGlzIGZyZWVkLg0KDQpXaXRoIHRoZSBkaXJlY3QgSS9PIHBhdGNo
LCB0aGUgcGFnZSBhcnJheSBpcyBoYW5kbGVkIHNlcGFyYXRlbHkuIFNvIHRoZXkgbmVlZCB0byBi
ZSBmcmVlZCBhZnRlciBiZWluZyB1c2VkLg0KDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
TG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+DQo+ID4gLS0tDQo+ID4gICBmcy9jaWZzL2Np
ZnNnbG9iLmggfCAgMiArLQ0KPiA+ICAgZnMvY2lmcy9maWxlLmMgICAgIHwgMjMgKysrKysrKysr
KysrKysrKysrKystLS0NCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9mcy9jaWZzL2NpZnNnbG9iLmgg
Yi9mcy9jaWZzL2NpZnNnbG9iLmggaW5kZXgNCj4gPiA4ZDE2YzNlLi41Njg2NGE4NyAxMDA2NDQN
Cj4gPiAtLS0gYS9mcy9jaWZzL2NpZnNnbG9iLmgNCj4gPiArKysgYi9mcy9jaWZzL2NpZnNnbG9i
LmgNCj4gPiBAQCAtMTE3OSw3ICsxMTc5LDcgQEAgc3RydWN0IGNpZnNfcmVhZGRhdGEgew0KPiA+
ICAgCXVuc2lnbmVkIGludAkJCXRhaWxzejsNCj4gPiAgIAl1bnNpZ25lZCBpbnQJCQljcmVkaXRz
Ow0KPiA+ICAgCXVuc2lnbmVkIGludAkJCW5yX3BhZ2VzOw0KPiA+IC0Jc3RydWN0IHBhZ2UJCQkq
cGFnZXNbXTsNCj4gPiArCXN0cnVjdCBwYWdlCQkJKipwYWdlczsNCj4gDQo+IFRlY2huaWNhbGx5
IHNwZWFraW5nLCB0aGVzZSBhcmUgc3ludGFjdGljYWxseSBlcXVpdmFsZW50LiBJdCBtYXkgbm90
IGJlIHdvcnRoDQo+IGNoYW5naW5nIHRoaXMgaGlzdG9yaWMgZGVmaW5pdGlvbi4NCj4gDQo+IFRv
bS4NCj4gDQo+IA0KPiA+ICAgfTsNCj4gPg0KPiA+ICAgc3RydWN0IGNpZnNfd3JpdGVkYXRhOw0K
PiA+IGRpZmYgLS1naXQgYS9mcy9jaWZzL2ZpbGUuYyBiL2ZzL2NpZnMvZmlsZS5jIGluZGV4IDIz
ZmQ0MzAuLjFjOTgyOTMNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9mcy9jaWZzL2ZpbGUuYw0KPiA+
ICsrKyBiL2ZzL2NpZnMvZmlsZS5jDQo+ID4gQEAgLTI4ODAsMTMgKzI4ODAsMTMgQEAgY2lmc19z
dHJpY3Rfd3JpdGV2KHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0DQo+IGlvdl9pdGVyICpmcm9t
KQ0KPiA+ICAgfQ0KPiA+DQo+ID4gICBzdGF0aWMgc3RydWN0IGNpZnNfcmVhZGRhdGEgKg0KPiA+
IC1jaWZzX3JlYWRkYXRhX2FsbG9jKHVuc2lnbmVkIGludCBucl9wYWdlcywgd29ya19mdW5jX3Qg
Y29tcGxldGUpDQo+ID4gK2NpZnNfcmVhZGRhdGFfZGlyZWN0X2FsbG9jKHN0cnVjdCBwYWdlICoq
cGFnZXMsIHdvcmtfZnVuY190IGNvbXBsZXRlKQ0KPiA+ICAgew0KPiA+ICAgCXN0cnVjdCBjaWZz
X3JlYWRkYXRhICpyZGF0YTsNCj4gPg0KPiA+IC0JcmRhdGEgPSBremFsbG9jKHNpemVvZigqcmRh
dGEpICsgKHNpemVvZihzdHJ1Y3QgcGFnZSAqKSAqIG5yX3BhZ2VzKSwNCj4gPiAtCQkJR0ZQX0tF
Uk5FTCk7DQo+ID4gKwlyZGF0YSA9IGt6YWxsb2Moc2l6ZW9mKCpyZGF0YSksIEdGUF9LRVJORUwp
Ow0KPiA+ICAgCWlmIChyZGF0YSAhPSBOVUxMKSB7DQo+ID4gKwkJcmRhdGEtPnBhZ2VzID0gcGFn
ZXM7DQo+ID4gICAJCWtyZWZfaW5pdCgmcmRhdGEtPnJlZmNvdW50KTsNCj4gPiAgIAkJSU5JVF9M
SVNUX0hFQUQoJnJkYXRhLT5saXN0KTsNCj4gPiAgIAkJaW5pdF9jb21wbGV0aW9uKCZyZGF0YS0+
ZG9uZSk7DQo+ID4gQEAgLTI4OTYsNiArMjg5NiwyMiBAQCBjaWZzX3JlYWRkYXRhX2FsbG9jKHVu
c2lnbmVkIGludCBucl9wYWdlcywNCj4gd29ya19mdW5jX3QgY29tcGxldGUpDQo+ID4gICAJcmV0
dXJuIHJkYXRhOw0KPiA+ICAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBzdHJ1Y3QgY2lmc19yZWFkZGF0
YSAqDQo+ID4gK2NpZnNfcmVhZGRhdGFfYWxsb2ModW5zaWduZWQgaW50IG5yX3BhZ2VzLCB3b3Jr
X2Z1bmNfdCBjb21wbGV0ZSkgew0KPiA+ICsJc3RydWN0IHBhZ2UgKipwYWdlcyA9DQo+ID4gKwkJ
a3phbGxvYyhzaXplb2Yoc3RydWN0IHBhZ2UgKikgKiBucl9wYWdlcywgR0ZQX0tFUk5FTCk7DQo+
ID4gKwlzdHJ1Y3QgY2lmc19yZWFkZGF0YSAqcmV0ID0gTlVMTDsNCj4gPiArDQo+ID4gKwlpZiAo
cGFnZXMpIHsNCj4gPiArCQlyZXQgPSBjaWZzX3JlYWRkYXRhX2RpcmVjdF9hbGxvYyhwYWdlcywg
Y29tcGxldGUpOw0KPiA+ICsJCWlmICghcmV0KQ0KPiA+ICsJCQlrZnJlZShwYWdlcyk7DQo+ID4g
Kwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJldDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgIHZvaWQN
Cj4gPiAgIGNpZnNfcmVhZGRhdGFfcmVsZWFzZShzdHJ1Y3Qga3JlZiAqcmVmY291bnQpDQo+ID4g
ICB7DQo+ID4gQEAgLTI5MTAsNiArMjkyNiw3IEBAIGNpZnNfcmVhZGRhdGFfcmVsZWFzZShzdHJ1
Y3Qga3JlZiAqcmVmY291bnQpDQo+ID4gICAJaWYgKHJkYXRhLT5jZmlsZSkNCj4gPiAgIAkJY2lm
c0ZpbGVJbmZvX3B1dChyZGF0YS0+Y2ZpbGUpOw0KPiA+DQo+ID4gKwlrdmZyZWUocmRhdGEtPnBh
Z2VzKTsNCj4gPiAgIAlrZnJlZShyZGF0YSk7DQo+ID4gICB9DQo+ID4NCj4gPg0K
