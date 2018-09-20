Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFE1C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD442150F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dV13zoYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD442150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbeITWp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:45:56 -0400
Received: from mail-cys01nam02on0105.outbound.protection.outlook.com ([104.47.37.105]:29664
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726128AbeITWpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtmunRTHDXzRLkZXZdzN8qZN807w/gm3iuSCed0pJ2s=;
 b=dV13zoYiDt9GK1L2lQ1S7HjHu0LfakHbB+Hqzsn7QVM31Zwy5lUVU1lfkNXi8ZFoRzuUbTC05VSjItCiytZ/2qk4E1ZQUKV3eK1ibb05EFij3zxQXf4+l5T2hLlji1A1xO4hMq0hY+KX5aZ0ZvFDecpIRtkX1BdDy7BTQ3n1pFY=
Received: from MWHPR2101MB0729.namprd21.prod.outlook.com (10.167.161.167) by
 MWHPR2101MB0812.namprd21.prod.outlook.com (10.167.236.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Thu, 20 Sep 2018 17:01:27 +0000
Received: from MWHPR2101MB0729.namprd21.prod.outlook.com
 ([fe80::ad1f:11e2:801f:21af]) by MWHPR2101MB0729.namprd21.prod.outlook.com
 ([fe80::ad1f:11e2:801f:21af%2]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 17:01:27 +0000
From:   Long Li <longli@microsoft.com>
To:     Tom Talpey <tom@talpey.com>, Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Tom Talpey <ttalpey@microsoft.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: RE: [Patch v7 21/22] CIFS: SMBD: Upper layer performs SMB read via
 RDMA write through memory registration
Thread-Topic: [Patch v7 21/22] CIFS: SMBD: Upper layer performs SMB read via
 RDMA write through memory registration
Thread-Index: AQHUT939hL6LwJmlP0yxgcHUVAtsoaT5ZzDw
Date:   Thu, 20 Sep 2018 17:01:27 +0000
Message-ID: <MWHPR2101MB07299688B64A015CC93E0CB0CE130@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20171107085514.12693-1-longli@exchange.microsoft.com>
 <20171107085514.12693-22-longli@exchange.microsoft.com>
 <9b02dadb-d21b-7a8d-7803-910041f66047@talpey.com>
In-Reply-To: <9b02dadb-d21b-7a8d-7803-910041f66047@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:2:edeb:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2101MB0812;6:hMWtXtTRhyoscA9fOOVea57SrX6bLlFkWmaAp9/ewfzrlmqv9aw51wSRDFopDlyO/yRq3P4fKMlCHRIObTeDnXSE4cdP6tq38/TAvQMtjreKf4Zp+2vH5OsUqKAn4cj2Bc5QpQ3uwW9HUWY2eXyCjjh1zGtEQLGvm8u/tRZp1UgwjVOCmgT2ADrTpdcS1tGRrmKDMtC1GJfcXdba1sjjQNjdxV3SjNyJiF9HxpiJak8VzfiZuDx996k55sEN13ownuALFssd2oq+8QFubVlZHNoLh1W30AQPu7GfWNrMYyssaXL6+Hk0/3wi6oDPa/5bZWzjvBhfsJs2Kwn6qIhnm9h3jCpNFhS3jH52L7aHaUCYeTrplYbvus+KernG+yLTSN95V9NcRVoXcuHdNguvHIRQiOSbxgPzZg4XesmlIv4vBFTuwEB86/y50SOKqiy1mZ6ZZKjgDLq5gN21Xz0HYA==;5:bTx/I2Tkn0wLeSEMWs19JmdJLJiRZR1tb5c9/a+j23vKiK20seZmbrMink5qTkrt9ntuBKSdOU9SG64MujMBE1TBpHDJBgmTZDv2NqrWJLklFXJK2mvhqGxQ/wmn73hnIRjisu16BrzwD9svabZXYJBCd77u5vhq8wXka87Xqr0=;7:S5wwQU0AhLoRMjsVlJ6QURCyUesFnL1J4KuzyicTXnr4gfno4S1LT6hp882gLxQZhVwdpsiBEXup5DZKwcNHuorznrlz0YR9iEc/Eb35QgelQJ2yvVtbH1yUqfUUXWH1IUNd0nR3gkeV/8loP+mmMc3fjJSHp9Njh6gpUNxpKA+sbvAua1mIr6k0ap7cMXW4qtUicA9VwOlAYWwc3C1W9SW9WqY/TCLbdej8myxw34aoe2Nxk/13ejroUFO4wB+O
x-ms-office365-filtering-correlation-id: d1cd9ba4-ba51-4f7a-9494-08d61f1ab495
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MWHPR2101MB0812;
x-ms-traffictypediagnostic: MWHPR2101MB0812:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-microsoft-antispam-prvs: <MWHPR2101MB081224380E5BC63AA6F1CF0DCE130@MWHPR2101MB0812.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:MWHPR2101MB0812;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2101MB0812;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(136003)(396003)(39860400002)(189003)(199004)(5250100002)(102836004)(110136005)(6636002)(446003)(186003)(46003)(11346002)(14454004)(8676002)(6436002)(68736007)(8990500004)(53936002)(106356001)(71200400001)(71190400001)(55016002)(10090500001)(7736002)(9686003)(2900100001)(476003)(478600001)(6246003)(105586002)(8936002)(1511001)(81156014)(81166006)(33656002)(2906002)(229853002)(25786009)(22452003)(316002)(74316002)(97736004)(6116002)(305945005)(99286004)(86612001)(5660300001)(14444005)(2201001)(7696005)(76176011)(486006)(86362001)(2501003)(6506007)(53546011)(256004)(10290500003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0812;H:MWHPR2101MB0729.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lPoyij1kMMzsYZVdWfMhorcpg6fa4O18Eo84hTu6CZLrm7SSwW+qBNCbcXAL/2HhOebhXfWmfOI4G14q+Tqg45cjzftRQfVGwzDWG89Wi+UCQIWtJxtXzptykeuwNE0dk0jMAETbuOIi2eJH7q0k52VWKp2ECRf2OEosaoznS+GvOCOPXNThK7V0bqyfpniONhh/vzHVcNjjD8vCU04mReInKOu8VtHldFK48Xof5sukiOvHHXmHDsdAJb0WGinqRmhsN0M9q1fFfKjBy2FlkLxucg5NyOBB3K1s3AmT6Htx5CuySjt3ZwGUdGHxVOHSIGy1IwwDMhBAqyx2ZVTFcZDT1DsRB1YTw/ZJfZyzdBM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1cd9ba4-ba51-4f7a-9494-08d61f1ab495
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 17:01:27.6314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0812
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BhdGNoIHY3IDIxLzIyXSBDSUZTOiBTTUJEOiBVcHBlciBsYXllciBw
ZXJmb3JtcyBTTUIgcmVhZCB2aWENCj4gUkRNQSB3cml0ZSB0aHJvdWdoIG1lbW9yeSByZWdpc3Ry
YXRpb24NCj4gDQo+IFJlcGx5aW5nIHRvIGEgdmVyeSBvbGQgbWVzc2FnZSwgYnV0IGl0J3Mgc29t
ZXRoaW5nIHdlIGRpc2N1c3NlZCB0b2RheSBhdCB0aGUNCj4gSU9MYWIgZXZlbnQgc28gdG8gY2Fw
dHVyZSBpdDoNCj4gDQo+IE9uIDExLzcvMjAxNyAxMjo1NSBBTSwgTG9uZyBMaSB3cm90ZToNCj4g
PiBGcm9tOiBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT4NCj4gPg0KPiA+IC0tLQ0KPiA+
ICAgZnMvY2lmcy9maWxlLmMgICAgfCAxNyArKysrKysrKysrKysrKystLQ0KPiA+ICAgZnMvY2lm
cy9zbWIycGR1LmMgfCA0NQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0NCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgNTkgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkgLi4uDQo+ID4gZGlmZiAtLWdpdCBhL2ZzL2NpZnMvc21iMnBkdS5jIGIvZnMvY2lm
cy9zbWIycGR1LmMgaW5kZXgNCj4gPiBjOGFmYjgzLi44YTVmZjkwIDEwMDY0NA0KPiA+IC0tLSBh
L2ZzL2NpZnMvc21iMnBkdS5jDQo+ID4gKysrIGIvZnMvY2lmcy9zbWIycGR1LmMNCj4gPiBAQCAt
MjM3OSw3ICsyMzc5LDQwIEBAIHNtYjJfbmV3X3JlYWRfcmVxKHZvaWQgKipidWYsIHVuc2lnbmVk
IGludA0KPiAqdG90YWxfbGVuLA0KPiA+ICAgCXJlcS0+TWluaW11bUNvdW50ID0gMDsNCj4gPiAg
IAlyZXEtPkxlbmd0aCA9IGNwdV90b19sZTMyKGlvX3Bhcm1zLT5sZW5ndGgpOw0KPiA+ICAgCXJl
cS0+T2Zmc2V0ID0gY3B1X3RvX2xlNjQoaW9fcGFybXMtPm9mZnNldCk7DQo+ID4gKyNpZmRlZiBD
T05GSUdfQ0lGU19TTUJfRElSRUNUDQo+ID4gKwkvKg0KPiA+ICsJICogSWYgd2Ugd2FudCB0byBk
byBhIFJETUEgd3JpdGUsIGZpbGwgaW4gYW5kIGFwcGVuZA0KPiA+ICsJICogc21iZF9idWZmZXJf
ZGVzY3JpcHRvcl92MSB0byB0aGUgZW5kIG9mIHJlYWQgcmVxdWVzdA0KPiA+ICsJICovDQo+ID4g
KwlpZiAoc2VydmVyLT5yZG1hICYmIHJkYXRhICYmDQo+ID4gKwkJcmRhdGEtPmJ5dGVzID49IHNl
cnZlci0+c21iZF9jb25uLQ0KPiA+cmRtYV9yZWFkd3JpdGVfdGhyZXNob2xkKSB7DQo+ID4gKw0K
PiA+ICsJCXN0cnVjdCBzbWJkX2J1ZmZlcl9kZXNjcmlwdG9yX3YxICp2MTsNCj4gPiArCQlib29s
IG5lZWRfaW52YWxpZGF0ZSA9DQo+ID4gKwkJCWlvX3Bhcm1zLT50Y29uLT5zZXMtPnNlcnZlci0+
ZGlhbGVjdCA9PQ0KPiBTTUIzMF9QUk9UX0lEOw0KPiA+ICsNCj4gPiArCQlyZGF0YS0+bXIgPSBz
bWJkX3JlZ2lzdGVyX21yKA0KPiA+ICsJCQkJc2VydmVyLT5zbWJkX2Nvbm4sIHJkYXRhLT5wYWdl
cywNCj4gPiArCQkJCXJkYXRhLT5ucl9wYWdlcywgcmRhdGEtPnRhaWxzeiwNCj4gPiArCQkJCXRy
dWUsIG5lZWRfaW52YWxpZGF0ZSk7DQo+ID4gKwkJaWYgKCFyZGF0YS0+bXIpDQo+ID4gKwkJCXJl
dHVybiAtRU5PQlVGUzsNCj4gPiArDQo+ID4gKwkJcmVxLT5DaGFubmVsID0gU01CMl9DSEFOTkVM
X1JETUFfVjFfSU5WQUxJREFURTsNCj4gPiArCQlpZiAobmVlZF9pbnZhbGlkYXRlKQ0KPiA+ICsJ
CQlyZXEtPkNoYW5uZWwgPSBTTUIyX0NIQU5ORUxfUkRNQV9WMTsNCj4gPiArCQlyZXEtPlJlYWRD
aGFubmVsSW5mb09mZnNldCA9DQo+ID4gKwkJCW9mZnNldG9mKHN0cnVjdCBzbWIyX3JlYWRfcGxh
aW5fcmVxLCBCdWZmZXIpOw0KPiA+ICsJCXJlcS0+UmVhZENoYW5uZWxJbmZvTGVuZ3RoID0NCj4g
PiArCQkJc2l6ZW9mKHN0cnVjdCBzbWJkX2J1ZmZlcl9kZXNjcmlwdG9yX3YxKTsNCj4gPiArCQl2
MSA9IChzdHJ1Y3Qgc21iZF9idWZmZXJfZGVzY3JpcHRvcl92MSAqKSAmcmVxLT5CdWZmZXJbMF07
DQo+ID4gKwkJdjEtPm9mZnNldCA9IHJkYXRhLT5tci0+bXItPmlvdmE7DQo+IA0KPiBJdCdzIHVu
bmVjZXNzYXJ5LCBhbmQgcG9zc2libHkgbGVha2luZyBrZXJuZWwgaW5mb3JtYXRpb24sIHRvIHVz
ZSB0aGUgSU9WQSBhcw0KPiB0aGUgb2Zmc2V0IG9mIGEgbWVtb3J5IHJlZ2lvbiB3aGljaCBpcyBy
ZWdpc3RlcmVkIHVzaW5nIGFuIEZSV1IuIEJlY2F1c2UNCj4gc3VjaCByZWdpb25zIGFyZSBiYXNl
ZCBvbiB0aGUgZXhhY3QgYnl0ZXMgdGFyZ2V0ZWQgYnkgdGhlIG1lbW9yeSBoYW5kbGUsDQo+IHRo
ZSBvZmZzZXQgY2FuIGJlIHNldCB0byBhbnkgdmFsdWUsIHR5cGljYWxseSB6ZXJvLCBidXQgbmVh
cmx5IGFyYml0cmFyeS4gQXMgbG9uZw0KPiBhcyB0aGUgKG9mZnNldCArIGxlbmd0aCkgZG9lcyBu
b3Qgd3JhcCBvciBvdGhlcndpc2Ugb3ZlcmZsb3csIG9mZnNldCBjYW4gYmUNCj4gc2V0IHRvIGFu
eXRoaW5nIGNvbnZlbmllbnQuDQo+IA0KPiBTaW5jZSBTTUIgcmVhZHMgYW5kIHdyaXRlcyByYW5n
ZSB1cCB0byA4TUIsIEknZCBzdWdnZXN0IHplcm9pbmcgdGhlIGxlYXN0DQo+IHNpZ25pZmljYW50
IDIzIGJpdHMsIHdoaWNoIHNob3VsZCBndWFyYW50ZWUgaXQuIFRoZSBvdGhlciA0MSBiaXRzLCBw
YXJ0eSBvbi4gWW91DQo+IGNvdWxkIHJhbmRvbWl6ZSB0aGVtLCBwYXNzIHNvbWUgY2xldmVyIGlk
ZW50aWZpZXIgc3VjaCBhcyBNSUQgc2VxdWVuY2UsDQo+IHdoYXRldmVyLg0KPiANCj4gVG9tLg0K
DQpUaGFua3MgVG9tLiBJIHdpbGwgZml4IHRoaXMuDQoNCj4gDQo+ID4gKwkJdjEtPnRva2VuID0g
cmRhdGEtPm1yLT5tci0+cmtleTsNCj4gPiArCQl2MS0+bGVuZ3RoID0gcmRhdGEtPm1yLT5tci0+
bGVuZ3RoOw0K
