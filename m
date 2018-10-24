Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9BBC46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB3420651
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="acn87Zj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB3420651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeJXLPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:15:01 -0400
Received: from mail-eopbgr20088.outbound.protection.outlook.com ([40.107.2.88]:47648
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725979AbeJXLO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Mr0oEWwTb2Xf4Y6S60sOZRm/Zbnirhl2Sl2mSV3qZQ=;
 b=acn87Zj51ISbs3pFCIEydQhR/5/IARJcAj6r0lRbNVWGUYlSsPmuX0eOb33QqowC8hUiR+VTqhEntM43DLSzLVXMPhLG0HTuUy4SBtIUSLDK3CmTTvIlBxVhoXEAweGH1E4Pby6PjAZ76DCoEd4RUHkCBF+fRscrHx+3QdbFoi0=
Received: from DB5PR0401MB2213.eurprd04.prod.outlook.com (10.166.173.8) by
 DB5PR0401MB1992.eurprd04.prod.outlook.com (10.166.11.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Wed, 24 Oct 2018 02:48:53 +0000
Received: from DB5PR0401MB2213.eurprd04.prod.outlook.com
 ([fe80::24b9:d390:896d:12f7]) by DB5PR0401MB2213.eurprd04.prod.outlook.com
 ([fe80::24b9:d390:896d:12f7%3]) with mapi id 15.20.1250.028; Wed, 24 Oct 2018
 02:48:53 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>
CC:     "edubezval@gmail.com" <edubezval@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: RE: [PATCH] thermal: qoriq: add multiple sensors support
Thread-Topic: [PATCH] thermal: qoriq: add multiple sensors support
Thread-Index: AQHUVgwqs1dc/YvhnUCR91KdT64vpqUdvnSAgAHhzUCAAH1WAIABJW0QgACVgACADALmMA==
Date:   Wed, 24 Oct 2018 02:48:53 +0000
Message-ID: <DB5PR0401MB221381AD65417D17AAD7B16DF3F60@DB5PR0401MB2213.eurprd04.prod.outlook.com>
References: <20180927024204.17314-1-andy.tang@nxp.com>
 <3d1f8304-9005-23f3-2e0e-ef9c962c9f6e@linaro.org>
 <DB5PR0401MB2213D4C1874291B87F231547F3FD0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
 <cf157e9f-a4cb-6d7d-f51d-8b9d91f3335c@linaro.org>
 <DB5PR0401MB2213E291AC455D61ED15AF4AF3FE0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
 <77993e69-db55-a2a0-799f-5225d5ffb010@linaro.org>
In-Reply-To: <77993e69-db55-a2a0-799f-5225d5ffb010@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR0401MB1992;6:lG6OOKeW9Sp043xm10iWXPaXo15P9swStJ75+dP/hkny6Bp5h9IqhWAXnL911NX8rGcIahJplj3+Q1RHWb6Y+DMIxnkVJBNkIV0mFbgfFAKgt7Fq6VpIIcDmgY6cUuq1t7i0Hz9WRvKxsrTnXomvYzzIYjFc1uvU1xEtt9T5B7V5EtZHF2ugYavvyUkOfbf+y11oRZZHzZ5EPYdb+M56JPZzzkqFvv6k/srlES33CLwWNJI9T7NrZTdkKxVNjGrxMbBavCMfFj6b/tXkmmGDc7Bmxgo1pJ0NlnOkJ9IbIpndmjw4e08Q/Qy7qLOTz6H7VixYo057OLQEpwSPuxFuBbOP/sHk3V3+Tp20L9O1hw4QRYu6UQHn6WXlr0gFOCD6WX1zm8dNOuCusJH/iF4D4nMobyDA/V7xMxTvbwz3+M66HLD+NmEpaeLZ3oc1O8x5HNZRaV7++265nsLb5iZrqA==;5:4lcdb2xvh2yMfOvYknFcSXCTBIjuqt4fgr7d87MK7ZlLMlrhZdyTVv/i88IJowGPHIY59TOFuzuF667cuerMmDujDSRKvQonKzAM7PjBRxajrGs8VNplDRnASzIu2ZHCc/0oH6pWqiIirK9PPEaDPNDX2M5fZskXdp5FR1cOA7g=;7:ywtVdjcojKAETam5Ztdx6KvG2ji4ZOyla/1sLQAJXNGskXRDGvejwj+m+XtllbwVhELIp46CeS9p+zfMuSMplQEzC3/c/nT26aOaR0IzpGVOZRWmEP9XCGfWrqMmSNK86/nDjTIfvophnsyc4ZjP8/mUGQhBMfx9GGsYyjVOlurqyucRGl4QDheujAW35RTg5ByQEYiEf/wJp2gP1qCj62rQF+a9EzhV/5ufI5kr0YktStxLRC+SpACtnMm3lIJF
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f550332c-993c-4c18-2ae4-08d6395b3c4e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB5PR0401MB1992;
x-ms-traffictypediagnostic: DB5PR0401MB1992:
x-microsoft-antispam-prvs: <DB5PR0401MB1992666529FB69490FB7A088F3F60@DB5PR0401MB1992.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(85827821059158)(9452136761055)(86561027422486)(64217206974132)(81227570615382)(148322886591682)(185117386973197)(45079756050767)(189930954265078);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB5PR0401MB1992;BCL:0;PCL:0;RULEID:;SRVR:DB5PR0401MB1992;
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(396003)(366004)(189003)(199004)(13464003)(6306002)(316002)(33656002)(105586002)(3846002)(81156014)(5660300001)(106356001)(76176011)(478600001)(2906002)(186003)(25786009)(26005)(2900100001)(39060400002)(5250100002)(7736002)(305945005)(53936002)(2501003)(55016002)(99286004)(102836004)(6436002)(9686003)(14444005)(74316002)(7696005)(256004)(6246003)(476003)(71200400001)(97736004)(446003)(4326008)(93886005)(11346002)(486006)(8936002)(14454004)(53546011)(229853002)(110136005)(54906003)(66066001)(71190400001)(6116002)(15974865002)(575784001)(68736007)(81166006)(44832011)(8676002)(6506007)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR0401MB1992;H:DB5PR0401MB2213.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: i58jY4B7JjXlYPW+LS/jva+4ABQo4MaBKldxRTcPn7YxQ7ciDW0P36BVZZVTdN1rLYOawRbfOon1ZUCC8oEKnXTV5knwQQxYK7IBV/sSX5s5OefRKmFjFhwzyZ8pLg6c4MaI6blLeOM2lDEZ5/Ltr+EPWbhL70ho5I/k/kX1FNcsDwg8TwbKyLDrgoha6lQUfjd7azTn8n2qEMHWrpmXOyrBs9XwuwLjx1Mxyrqb6rYJDns7YPvUo0CpkaRT1Sy0YmhNDWJadHCip2Gwvye575wZYIwtF8GUPWesaWfugaKEYj5DQM+sc6CvGXGpPuhVb1Frx6CiYcg++fd9mKkvkTAJ2jDR4qwHZsRv1DUF83s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f550332c-993c-4c18-2ae4-08d6395b3c4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 02:48:53.5285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR0401MB1992
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuaWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmll
bCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDE45bm0MTDm
nIgxNuaXpSAxOToyMQ0KPiBUbzogQW5keSBUYW5nIDxhbmR5LnRhbmdAbnhwLmNvbT47IHJ1aS56
aGFuZ0BpbnRlbC5jb20NCj4gQ2M6IGVkdWJlenZhbEBnbWFpbC5jb207IGxpbnV4LXBtQHZnZXIu
a2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgUm9iIEhlcnJpbmcg
PHJvYmgrZHRAa2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdGhlcm1hbDogcW9y
aXE6IGFkZCBtdWx0aXBsZSBzZW5zb3JzIHN1cHBvcnQNCj4gDQo+ID4+Pj4gVGhlIGN1cnJlbnQg
Y29kZSBpcyByZWFkaW5nIHRoZSBEVCBpbiBvcmRlciB0byBnZXQgdGhlIHNlbnNvciBpZA0KPiA+
Pj4+IGFuZCBpbml0aWFsaXplIGl0LiBJT1csIHRoZSBEVCBnaXZlcyB0aGUgc2Vuc29ycyB0byB1
c2UuDQo+ID4+Pj4NCj4gPj4+PiBJTU8sIGl0IHdvdWxkIGJlIG1vcmUgc2VsZiBjb250YWluZWQg
aWYgdGhlIGRyaXZlciBpbml0aWFsaXplcyBhbGwNCj4gPj4+PiB0aGUgc2Vuc29ycyB3aXRob3V0
IHRha2luZyBjYXJlIG9mIHRoZSBEVCBhbmQgbGV0IHRoZSBvZi0gY29kZSB0bw0KPiA+Pj4+IGRv
IHRoZSBiaW5kaW5nIHdoZW4gdGhlIHRoZXJtYWwgem9uZSwgbm8gPw0KPiA+Pj4gW0FuZHldIGNv
dWxkIHlvdSBwbGVhc2UgZXhwbGFpbiBtb3JlIGFib3V0IHRoaXMgd2F5PyBJIGFtIG5vdCBzdXJl
DQo+ID4+PiBob3cNCj4gPj4gdG8gaW1wbGVtZW50IGl0Lg0KPiA+Pj4gQnV0IG9uZSB0aGluZyBp
cyBmb3Igc3VyZTogd2UgbXVzdCBnZXQgdGhlIHNlbnNvciBJRHMgZXhwbGljaXRseSBzbw0KPiA+
Pj4gdGhhdCB3ZSBjYW4gZW5hYmxlIHRoZW0gYnkgdGhlIGZvbGxvd2luZyBjb21tYW5kOg0KPiB0
bXVfd3JpdGUocWRhdGEsDQo+ID4+PiBzaXRlcyB8IFRNUl9NRSB8IFRNUl9BTFBGLCAmcWRhdGEt
PnJlZ3MtPnRtcik7DQo+ID4+DQo+ID4+IFdoYXQgSSBtZWFudCBpcyBhYm91dCBjb2RlIHNlcGFy
YXRpb24gYmV0d2VlbiB0aGUgZHJpdmVyIGl0c2VsZiBhbmQNCj4gPj4gdGhlIG9mLXRoZXJtYWwg
Y29kZS4NCj4gPj4NCj4gPj4gVGhlIGNvZGUgYWJvdmUgcmUtaW5zcGVjdCB0aGUgRFQgdG8gZmlu
ZCBvdXQgdGhlIHNlbnNvciBpZHMgaW4gb3JkZXINCj4gPj4gdG8gZW5hYmxlIHRoZW0gYW5kIHNv
bWVob3cgdGhpcyBpcyBub3Qgd3JvbmcgYnV0IGJyZWFrcyB0aGUgc2VsZg0KPiA+PiBlbmNhcHN1
bGF0aW9uIG9mIHRoZSBkcml2ZXIuIEkgd2FzIHN1Z2dlc3RpbmcgaWYgaXQgaXNuJ3QgcG9zc2li
bGUgdG8NCj4gPj4gZW5hYmxlIGFsbCB0aGUgc2Vuc29ycyB3aXRob3V0IHRha2luZyBjYXJlIG9m
IGRpZ2dpbmcgaW50byB0aGUgRFQuDQo+ID4NCj4gPiBbQW5keV0gSSBkb24ndCB3YW50IHRvIHJl
LXBhcnNlIHRoZSBEVCBoZXJlIHRvby4gQnV0IEkgaGF2ZSB0by4NCj4gPiBUaGlzIGRyaXZlciB3
aWxsIGJlIHVzZWQgYnkgYWxsIG91ciBTT0NzIHdpdGggZGlmZmVyZW50IHNlbnNvciBJRHMgYW5k
DQo+IG51bWJlci4NCj4gPiBGb3IgZXhhbXBsZTogdGhlcmUgYXJlIDIgc2Vuc29ycyBvbiBsczEw
ODhhIHBsYXRmb3JtIHdpdGggSUQgMCBhbmQgMS4NCj4gPiBXaGlsZSBvbiBsczEwNDNhIHRoZXJl
IGFyZSA2IHNlbnNvcnMgd2l0aCBJRCAwLCAxLCAyLCAzLCA0LCA1Lg0KPiA+IElmIHdlIGRvbid0
IHNjYW4gdGhlIERUIHdlIHdvdWxkIG5vdCBrbm93IGhvdyBtYW55IHNlbnNvcnMgaXQgaXMgYW5k
DQo+ID4gd2hhdCBhcmUgdGhlIHNlbnNvcidzIElEcywgdW5sZXNzIHdlIGhhcmRjb2RlIGl0IGlu
IGRyaXZlci4NCj4gDQo+IFllcywgeW91IGFyZSBub3QgdGhlIG9ubHkgb25lIGluIHRoaXMgc2l0
dWF0aW9uIElNTyBhbmQgdGhlIGRyaXZlcnMNCj4gc3VwcG9ydGluZyBtdWx0aXBsZSBzZW5zb3Jz
IGFyZSBpbmNyZWFzaW5nLCBzbyB0aGlzIHdpbGwgcmVwZWF0IGFnYWluIGFuZA0KPiBhZ2Fpbi4N
Cj4gDQo+IFRoYXQgY291bGQgYmUgaGFyZGNvZGVkIGluIHRoZSBkcml2ZXIgYnkgdXNpbmcgdGhl
IGNvbXBhdGlibGUgc3RyaW5nIGJ1dCBpdA0KPiB3aWxsIGJlIG5pY2VyIGlmIHdlIGNhbiBmaXgg
dGhhdCBpbiB0aGUgRFQuDQo+IA0KPiBbQ2MnaW5nIFJvYl0NCj4gDQo+IFdoYXQgaXMgbWlzc2lu
ZyBpcyBhIGRlc2NyaXB0aW9uIG9mIHRoZSBzZW5zb3JzIGlkIGluIHRoZSB0ZW1wZXJhdHVyZQ0K
PiBkZXZpY2Ugbm9kZS4gV2UgaGF2ZSB0aGUgPHRoZXJtYWwtc2Vuc29yLWNlbGxzPiB3aXRoIDAg
b3IgMSB0ZWxsaW5nIGlmDQo+IHRoZXJlIGlzIG9uZSBvciBzZXZlcmFsIHNlbnNvcnMgYnV0IHdl
IGNhbid0IHNwZWNpZnkgd2hpY2ggc2Vuc29yIGlkcyB3ZQ0KPiBoYXZlLiBUaGUgb25seSBhbHRl
cm5hdGl2ZSBpcyB0byBwYXJzZSB0aGUgdGhlcm1hbCB6b25lcyB0byBmb3VuZCBvdXQgd2hpY2gN
Cj4gc2Vuc29ycyBhcmUgaW4gdXNlIGFuZCB1c2UgdGhlbSB0byBpbml0aWFsaXplIHRoZSBkcml2
ZXIsIGFuIGFwcHJvYWNoIHdoaWNoDQo+IGJyZWFrcyB0aGUgc2VsZi1lbmNhcHN1bGF0aW9uOiB0
aGUgb2YtdGhlcm1hbCBmcmFtZXdvcmsgaXMgdGhlIG9uZSBpbg0KPiBjaGFyZ2Ugb2YgZG9pbmcg
dGhlIGxpbmsgYmV0d2VlbiB0aGUgdGhlcm1hbCB6b25lIGFuZCBhIHNlbnNvciBpZC4NCj4gDQo+
IElzIGl0IGFjY2VwdGFibGUgdG8gYWRkIHRoZSBsaXN0IG9mIHRoZSBzZW5zb3JzIGlkIGluIHRo
ZSB0ZW1wIGRldmljZSBub2RlLCBzbw0KPiB0aGUgZHJpdmVyIGNhbiBpbml0aWFsaXplIHRoZXNl
IHNlbnNvcnMgd2l0aG91dCBwYXJzaW5nIHRoZSB0aGVybWFsIHpvbmUgaW4NCj4gdGhlIERUID8N
Cj4gDQpIYXZlIHlvdSBnb3QgYW55IGNvbmNsdXNpb24geWV0Pw0KV2hlbiBjYW4gSSBzZW5kIHRo
ZSBuZXh0IHZlcnNpb24gb2YgdGhpcyBwYXRjaD8NCg0KQlIsDQpBbmR5DQo+IA0KPiANCj4gDQo+
IC0tDQo+IA0KPiA8aHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwJTNBJTJGJTJGDQo+IHd3dy5saW5hcm8ub3JnJTJGJmFtcDtkYXRhPTAyJTdD
MDElN0NhbmR5LnRhbmclNDBueHAuY29tJTdDZjYNCj4gMzQzYmQyOGUwNjQzODMzZmExMDhkNjMz
NTk3M2NhJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMNCj4gMzAxNjM1JTdDMCU3QzAlN0M2
MzY3NTI4NTY2NDQwMDY1NjgmYW1wO3NkYXRhPU9LSVhZakhiNFB2Yw0KPiA4bG1ldnElMkZ3SmU5
c29zdk5SRnhodlBBYjhUVDNGV1ElM0QmYW1wO3Jlc2VydmVkPTA+DQo+IExpbmFyby5vcmcg4pSC
IE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29Dcw0KPiANCj4gRm9sbG93IExpbmFybzoN
Cj4gPGh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9
aHR0cCUzQSUyRiUyRg0KPiB3d3cuZmFjZWJvb2suY29tJTJGcGFnZXMlMkZMaW5hcm8mYW1wO2Rh
dGE9MDIlN0MwMSU3Q2FuZHkudGFuDQo+IGclNDBueHAuY29tJTdDZjYzNDNiZDI4ZTA2NDM4MzNm
YTEwOGQ2MzM1OTczY2ElN0M2ODZlYTFkM2INCj4gYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0Mw
JTdDMCU3QzYzNjc1Mjg1NjY0NDAwNjU2OCZhbXA7cw0KPiBkYXRhPUxRM1Q1a3BYRnJxUnJRUjFK
dDlPalk1NDdUV3NmeGFJVTF6OHRLJTJGNng4WSUzRCZhbXA7cmVzDQo+IGVydmVkPTA+IEZhY2Vi
b29rIHwNCj4gPGh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29t
Lz91cmw9aHR0cCUzQSUyRiUyRnQNCj4gd2l0dGVyLmNvbSUyRiUyMyElMkZsaW5hcm9vcmcmYW1w
O2RhdGE9MDIlN0MwMSU3Q2FuZHkudGFuZyU0MG4NCj4geHAuY29tJTdDZjYzNDNiZDI4ZTA2NDM4
MzNmYTEwOGQ2MzM1OTczY2ElN0M2ODZlYTFkM2JjMmI0YzYNCj4gZmE5MmNkOTljNWMzMDE2MzUl
N0MwJTdDMCU3QzYzNjc1Mjg1NjY0NDAwNjU2OCZhbXA7c2RhdGE9aA0KPiBNT1MxV3hRQmNTJTJC
dnh5and6Njhua1pGYUIlMkZlWjIxRTMzVTUwR2RGOXBZJTNEJmFtcDtyZXMNCj4gZXJ2ZWQ9MD4g
VHdpdHRlciB8DQo+IDxodHRwczovL2VtZWEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29r
LmNvbS8/dXJsPWh0dHAlM0ElMkYlMkYNCj4gd3d3LmxpbmFyby5vcmclMkZsaW5hcm8tYmxvZyUy
RiZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5keS50YW5nJTQwDQo+IG54cC5jb20lN0NmNjM0M2JkMjhl
MDY0MzgzM2ZhMTA4ZDYzMzU5NzNjYSU3QzY4NmVhMWQzYmMyYjRjDQo+IDZmYTkyY2Q5OWM1YzMw
MTYzNSU3QzAlN0MwJTdDNjM2NzUyODU2NjQ0MTYyODM2JmFtcDtzZGF0YT0NCj4gMmowYkpMSmd6
WHNtbHJHOGhSNmFLU1l2bWczUnJpYUglMkJ6dDF4NE9GOGtVJTNEJmFtcDtyZXNlcnZlZD0NCj4g
MD4gQmxvZw0KDQo=
