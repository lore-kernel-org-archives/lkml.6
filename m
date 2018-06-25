Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CF5C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BDC2616F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BDC2616F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755621AbeFYVPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:15:09 -0400
Received: from g9t5008.houston.hpe.com ([15.241.48.72]:47534 "EHLO
        g9t5008.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752488AbeFYVPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:15:06 -0400
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5008.houston.hpe.com (Postfix) with ESMTPS id C373E57;
        Mon, 25 Jun 2018 21:15:05 +0000 (UTC)
Received: from G9W8676.americas.hpqcorp.net (16.220.49.23) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 25 Jun 2018 21:15:06 +0000
Received: from G1W8106.americas.hpqcorp.net (16.193.72.61) by
 G9W8676.americas.hpqcorp.net (16.220.49.23) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 25 Jun 2018 21:15:05 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (15.241.52.10) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Mon, 25 Jun 2018 21:15:05 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB1137.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.19; Mon, 25 Jun 2018 21:15:03 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8%5]) with mapi id 15.20.0884.024; Mon, 25 Jun 2018
 21:15:03 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "mhocko@kernel.org" <mhocko@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>
Subject: Re: [PATCH v3 0/3] fix free pmd/pte page handlings on x86
Thread-Topic: [PATCH v3 0/3] fix free pmd/pte page handlings on x86
Thread-Index: AQHUC73/TYYF8RoO3UmhiJVFAtgPVKRxEVsAgAAx7QCAADfbgA==
Date:   Mon, 25 Jun 2018 21:15:03 +0000
Message-ID: <1529961187.14039.206.camel@hpe.com>
References: <20180516233207.1580-1-toshi.kani@hpe.com>
         <alpine.DEB.2.21.1806241516410.8650@nanos.tec.linutronix.de>
         <1529938470.14039.134.camel@hpe.com>
         <20180625175225.GQ28965@dhcp22.suse.cz>
In-Reply-To: <20180625175225.GQ28965@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-originating-ip: [15.219.163.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB1137;7:vkW5d7aDMReFxkM6/HpJTiPzEGualuk44Sx3C/q1fosOM6nz4rf2o7LPhrEJ+m+APhe5A3mPjZRtRbwodWrQLj2UfaKc8zxV93MCrltUhob93ZwkNa+NANazkac35zovBRTi5Zz75X15WNXwc8k34BwaVP8spgdfYOPeZ/xSZ736aFo1GP4JkyBUnX8YOf+GL6LFFlsrl4uRLqWA2jjAETesczTOV5vP6oSk2kRi5ruCPzcg7Agf4Cdslbw/2Qy/
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c56de95b-de55-4235-2932-08d5dae0b7b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB1137;
x-ms-traffictypediagnostic: AT5PR8401MB1137:
x-microsoft-antispam-prvs: <AT5PR8401MB11373A2F23E4A23FB0E98EC6824A0@AT5PR8401MB1137.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AT5PR8401MB1137;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB1137;
x-forefront-prvs: 0714841678
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(39860400002)(376002)(396003)(199004)(189003)(8936002)(81166006)(6246003)(1730700003)(2900100001)(81156014)(53936002)(6486002)(6436002)(68736007)(66066001)(229853002)(5640700003)(478600001)(256004)(97736004)(14454004)(2351001)(6512007)(103116003)(93886005)(316002)(54906003)(476003)(2616005)(6116002)(102836004)(2906002)(486006)(106356001)(6506007)(5250100002)(105586002)(2501003)(6916009)(3846002)(186003)(26005)(76176011)(7736002)(99286004)(4326008)(36756003)(305945005)(7416002)(25786009)(446003)(5660300001)(14444005)(86362001)(8676002)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1137;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dHH2EOFD1K17/juU8VwGTcX3UA5EGQv/z52se6/4gBQ1JIhZcSg0t2OxttyxVTXZj9l7phRCjf4K/0U0xiyLonalTvKd/GOdeRDbnwG6vP4j56A/9NSUjiLQweV2ag/HvCnuMTvAcpDLJezxNaSb1vu4cVtmu5qxOI8VtUGWwysPPY0Jb1r7rJoRgh2hgBMPV6fIAtGZ7LR1PpMCby7vL+PbCU/j58ClvZjuuW11TNUNTHdUBOUra1tWLAgh/EbfFcdVnw/xxxCZzVWRkQ11bez83AzLRSBrn9CnFs4vl4o8T3QWswcLFYYmHWiB1OMC0XDVyXbWBzz6sjLzWW5DkRUDEud9l5zNVoORj+NTAFU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9CA7751DBCA9E48979D3B542B81D95F@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c56de95b-de55-4235-2932-08d5dae0b7b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2018 21:15:03.0687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1137
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA2LTI1IGF0IDE5OjUzICswMjAwLCBNaWNoYWwgSG9ja28gd3JvdGU6DQo+
IE9uIE1vbiAyNS0wNi0xOCAxNDo1NjoyNiwgS2FuaSBUb3NoaW1pdHN1IHdyb3RlOg0KPiA+IE9u
IFN1biwgMjAxOC0wNi0yNCBhdCAxNToxOSArMDIwMCwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0K
PiA+ID4gT24gV2VkLCAxNiBNYXkgMjAxOCwgVG9zaGkgS2FuaSB3cm90ZToNCj4gPiA+IA0KPiA+
ID4gPiBUaGlzIHNlcmllcyBmaXhlcyB0d28gaXNzdWVzIGluIHRoZSB4ODYgaW9yZW1hcCBmcmVl
IHBhZ2UgaGFuZGxpbmdzDQo+ID4gPiA+IGZvciBwdWQvcG1kIG1hcHBpbmdzLg0KPiA+ID4gPiAN
Cj4gPiA+ID4gUGF0Y2ggMDEgZml4ZXMgQlVHX09OIG9uIHg4Ni1QQUUgcmVwb3J0ZWQgYnkgSm9l
cmcuICBJdCBkaXNhYmxlcw0KPiA+ID4gPiB0aGUgZnJlZSBwYWdlIGhhbmRsaW5nIG9uIHg4Ni1Q
QUUuDQo+ID4gPiA+IA0KPiA+ID4gPiBQYXRjaCAwMi0wMyBmaXhlcyBhIHBvc3NpYmxlIGlzc3Vl
IHdpdGggc3BlY3VsYXRpb24gd2hpY2ggY2FuIGNhdXNlDQo+ID4gPiA+IHN0YWxlIHBhZ2UtZGly
ZWN0b3J5IGNhY2hlLg0KPiA+ID4gPiAgLSBQYXRjaCAwMiBpcyBmcm9tIENoaW50YW4ncyB2OSAw
MS8wNCBwYXRjaCBbMV0sIHdoaWNoIGFkZHMgYSBuZXcgYXJnDQo+ID4gPiA+ICAgICdhZGRyJywg
d2l0aCBteSBtZXJnZSBjaGFuZ2UgdG8gcGF0Y2ggMDEuDQo+ID4gPiA+ICAtIFBhdGNoIDAzIGFk
ZHMgYSBUTEIgcHVyZ2UgKElOVkxQRykgdG8gcHVyZ2UgcGFnZS1zdHJ1Y3R1cmUgY2FjaGVzDQo+
ID4gPiA+ICAgIHRoYXQgbWF5IGJlIGNhY2hlZCBieSBzcGVjdWxhdGlvbi4gIFNlZSB0aGUgcGF0
Y2ggZGVzY3JpcHRpb25zIGZvcg0KPiA+ID4gPiAgICBtb3JlIGRldGFsLg0KPiA+ID4gDQo+ID4g
PiBUb3NoaSwgSm9lcmcsIE1pY2hhbCENCj4gPiANCj4gPiBIaSBUaG9tYXMsDQo+ID4gDQo+ID4g
VGhhbmtzIGZvciBjaGVja2luZy4gSSB3YXMgYWJvdXQgdG8gcGluZyBhcyB3ZWxsLg0KPiA+IA0K
PiA+ID4gSSdtIGZhaWxpbmcgdG8gZmluZCBhIGNvbmNsdXNpb24gb2YgdGhpcyBkaXNjdXNzaW9u
LiBDYW4gd2UgZmluYWxseSBtYWtlDQo+ID4gPiBzb21lIHByb2dyZXNzIHdpdGggdGhhdD8NCj4g
PiANCj4gPiBJIGhhdmUgbm90IGhlYXJkIGZyb20gSm9lcmcgc2luY2UgSSBsYXN0IHJlcGxpZWQg
dG8gaGlzIGNvbW1lbnRzIHRvDQo+ID4gUGF0Y2ggMy8zIC0tIEkgZGlkIG15IGJlc3QgdG8gZXhw
bGFpbiB0aGF0IHRoZXJlIHdhcyBubyBpc3N1ZSBpbiB0aGUNCj4gPiBzaW5nbGUgcGFnZSBhbGxv
Y2F0aW9uIGluIHB1ZF9mcmVlX3BtZF9wYWdlKCkuICBGcm9tIG15IHBlcnNwZWN0aXZlLCB0aGUN
Cj4gPiAgdjMgc2VyaWVzIGlzIGdvb2QgdG8gZ28uDQo+IA0KPiBXZWxsLCBJIGFkbWl0IHRoYXQg
dGhpcyBub3QgbXkgYXJlYSBidXQgSSBhZ3JlZSB3aXRoIEpvZXJnIHRoYXQNCj4gYWxsb2NhdGlu
ZyBtZW1vcnkgaW5zaWRlIGFmdW5jdGlvbiB0aGF0IGlzIHN1cHBvc2VkIHRvIGZyZWUgcGFnZSB0
YWJsZQ0KPiBpcyBmYXIgZnJvbSBpZGVhbC4gTW9yZSBzbyB0aGF0IHRoZSBhbGxvY2F0aW9uIGlz
IGhhcmRjb2RlZCBHRlBfS0VSTkVMLg0KPiBXZSBhbHJlYWR5IGhhdmUgdGhpcyBhbnRpcGF0dGVy
biBpbiBmdW5jdGlvbnMgdG8gYWxsb2NhdGUgcGFnZSB0YWJsZXMNCj4gYW5kIGl0IGhhcyB0dXJu
ZWQgdG8gYmUgbWFpbnRlbmFuY2UgUElUQSBsb25ndGVybS4gU28gaWYgdGhlcmUgaXMgYSB3YXkN
Cj4gYXJvdW5kIHRoYXQgdGhlbiBJIHdvdWxkIHN0cm9uZ2x5IHN1Z2dlc3QgZmluZGluZyBhIGRp
ZmZlcmVudCBzb2x1dGlvbi4NCj4gDQo+IFdoZXRoZXIgdGhhdCBpcyBzdWZmaWNpZW50IHRvIGRp
dGNoIHRoZSB3aG9sZSBzZXJpZXMgaXMgbm90IG15IGNhbGwNCj4gdGhvdWdoLg0KDQpJJ2QgYWdy
ZWUgaWYgdGhpcyBjb2RlIGlzIGluIGEgbWVtb3J5IGZyZWUgcGF0aC4gIEhvd2V2ZXIsIHRoaXMg
Y29kZSBpcw0KaW4gdGhlIGlvcmVtYXAoKSBwYXRoLCB3aGljaCBpcyBleHBlY3RlZCB0byBhbGxv
Y2F0ZSBuZXcgcGFnZShzKS4NCg0KRm9yIGV4YW1wbGUsIHNldHRpbmcgYSBmcmVzaCBQVUQgbWFw
IGFsbG9jYXRlcyBhIG5ldyBwYWdlIHRvIHNldHVwIHBhZ2UNCnRhYmxlcyBhcyBmb2xsb3dzOg0K
DQogIGlvcmVtYXBfcHVkX3JhbmdlKCkNCiAgICBwdWRfYWxsb2MoKQ0KICAgICAgX19wdWRfYWxs
b2MoKQ0KICAgICAgICBwdWRfYWxsb2Nfb25lKCkNCiAgICAgICAgICBnZXRfemVyb2VkX3BhZ2Uo
KSB3aXRoIEdGUF9LRVJORUwNCiAgICAgICAgICAgIF9fZ2V0X2ZyZWVfcGFnZXMoKSB3aXRoIEdG
UF9LRVJORUwgfCBfX0dGUF9aRVJPDQoNCkluIGEgcmFyZSBjYXNlLCBhIFBVRCBtYXAgaXMgc2V0
IHRvIGEgcHJldmlvdXNseS11c2VkLWZvci1QTUQgcmFuZ2UsDQp3aGljaCBsZWFkcyB0byBjYWxs
IHB1ZF9mcmVlX3BtZF9wYWdlKCkgdG8gZnJlZSB1cCB0aGUgcGFnZSBjb25zaXN0aW5nDQpvZiBj
bGVhcmVkIFBNRCBlbnRyaWVzLiAgVG8gbWFuYWdlIHRoaXMgcHJvY2VkdXJlLCBwdWRfZnJlZV9w
bWRfcGFnZSgpDQp0ZW1wb3JhcnkgYWxsb2NhdGVzIGEgcGFnZSB0byBzYXZlIHRoZSBjbGVhcmVk
IFBNRCBlbnRyaWVzIGFzIGZvbGxvd3M6DQoNCiAgaW9yZW1hcF9wdWRfcmFuZ2UoKQ0KICAgIHB1
ZF9mcmVlX3BtZF9wYWdlKCkNCiAgICAgIF9fZ2V0X2ZyZWVfcGFnZSgpIHdpdGggR0ZQX0tFUk5F
TA0KDQpUaGVzZSBkZXRhaWxzIGFyZSBhbGwgaW50ZXJuYWwgdG8gdGhlIGlvcmVtYXAoKSBjYWxs
ZXJzLCB3aG8gc2hvdWxkDQphbHdheXMgZXhwZWN0IHRoYXQgaW9yZW1hcCgpIGFsbG9jYXRlcyBw
YWdlcyBmb3Igc2V0dGluZyBwYWdlIHRhYmxlcy4NCg0KQXMgZm9yIHBvc3NpYmxlIHBlcmZvcm1h
bmNlIGltcGxpY2F0aW9ucyBhc3NvY2lhdGVkIHdpdGggdGhpcyBwYWdlDQphbGxvY2F0aW9uLCBw
bWRfZnJlZV9wdGVfcGFnZSgpIGFuZCBwdWRfZnJlZV9wbWRfcGFnZSgpIGFyZSB2ZXJ5DQpkaWZm
ZXJlbnQgaW4gdGVybXMgb2YgaG93IGxpa2VseSB0aGV5IGNhbiBiZSBjYWxsZWQuDQoNCnBtZF9m
cmVlX3B0ZV9wYWdlKCksIHdoaWNoIGRvZXMgbm90IGFsbG9jYXRlIGEgcGFnZSwgZ2V0cyBjYWxs
ZWQNCm11bHRpcGxlIHRpbWVzIGR1cmluZyBub3JtYWwgYm9vdCBvbiBteSB0ZXN0IHN5c3RlbXMu
ICBNeSBpb3JlbWFwIHRlc3RzDQpjYXVzZSB0aGlzIGZ1bmN0aW9uIGJlIGNhbGxlZCBxdWl0ZSBm
cmVxdWVudGx5LiAgVGhpcyBpcyBiZWNhdXNlIDRLQiBhbmQNCjJNQiB2YWRkciBhbGxvY2F0aW9u
IGNvbWVzIGZyb20gc2ltaWxhciB2bWFsbG9jIHJhbmdlcy4gDQoNCnB1ZF9mcmVlX3BtZF9wYWdl
KCksIHdoaWNoIGFsbG9jYXRlcyBhIHBhZ2UsIHNlZW1zIHRvIGJlIG5ldmVyIGNhbGxlZA0KdW5k
ZXIgbm9ybWFsIGNpcmN1bXN0YW5jZXMsIGF0IGxlYXN0IEkgd2FzIG5vdCBhYmxlIHRvIHdpdGgg
bXkgaW9yZW1hcA0KdGVzdHMuICBJIGZvdW5kIHRoYXQgMUdCIHZhZGRyIGFsbG9jYXRpb24gZG9l
cyBub3Qgc2hhcmUgd2l0aCA0S0IvMk1CDQpyYW5nZXMuICBJIGhhZCB0byBoYWNrIHRoZSBhbGxv
Y2F0aW9uIGNvZGUgdG8gZm9yY2UgdGhlbSBzaGFyZWQgdG8gdGVzdA0KdGhpcyBmdW5jdGlvbi4g
IEhlbmNlLCB0aGlzIG1lbW9yeSBhbGxvY2F0aW9uIGRvZXMgbm90IGhhdmUgYW55DQppbXBsaWNh
dGlvbnMgaW4gcGVyZm9ybWFuY2UuDQoNCkxhc3RseSwgZm9yIHRoZSBjb2RlIG1haW50ZW5hbmNl
LCBJIGJlbGlldmUgdGhpcyBtZW1vcnkgYWxsb2NhdGlvbiBrZWVwcw0KdGhlIGNvZGUgbXVjaCBz
aW1wbGVyIHRoYW4gaXQgd291bGQgb3RoZXJ3aXNlIG5lZWQgdG8gbWFuYWdlIGEgc3BlY2lhbA0K
cGFnZSBsaXN0Lg0KDQpUaGFua3MsDQotVG9zaGkNCg==
