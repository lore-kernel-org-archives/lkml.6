Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D8BC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF123208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF123208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755789AbeFYXzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:55:42 -0400
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:34493 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754502AbeFYXzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:55:41 -0400
Received: from G4W9120.americas.hpqcorp.net (g4w9120.houston.hp.com [16.210.21.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3426.houston.hpe.com (Postfix) with ESMTPS id 24E694E;
        Mon, 25 Jun 2018 23:55:39 +0000 (UTC)
Received: from G9W8453.americas.hpqcorp.net (2002:10d8:a0d3::10d8:a0d3) by
 G4W9120.americas.hpqcorp.net (2002:10d2:150f::10d2:150f) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Mon, 25 Jun 2018 23:55:39 +0000
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (15.241.52.11) by
 G9W8453.americas.hpqcorp.net (16.216.160.211) with Microsoft SMTP Server
 (TLS) id 15.0.1367.3 via Frontend Transport; Mon, 25 Jun 2018 23:55:38 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB1251.NAMPRD84.PROD.OUTLOOK.COM (10.169.9.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.20; Mon, 25 Jun 2018 23:55:36 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8%5]) with mapi id 15.20.0884.024; Mon, 25 Jun 2018
 23:55:36 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "Chen, Guomin" <Guomin.Chen@suse.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lee, Joey" <JLee@suse.com>, "bp@suse.de" <bp@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "baiyaowei@cmss.chinamobile.com" <baiyaowei@cmss.chinamobile.com>
Subject: Re: [PATCH 1/1] resource: Fixed iomem resource release failed on
 release_mem_region_adjustable() when memory node or cpu node hot-remove.
Thread-Topic: [PATCH 1/1] resource: Fixed iomem resource release failed on
 release_mem_region_adjustable() when memory node or cpu node hot-remove.
Thread-Index: AQHUCn+KtL4GdKFDSEizw7QBg55RA6RxqnwA
Date:   Mon, 25 Jun 2018 23:55:36 +0000
Message-ID: <1529970820.14039.224.camel@hpe.com>
References: <20180622120138.5411-1-guomin.chen@suse.com>
         <20180622231930.GA2834@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180622231930.GA2834@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-originating-ip: [15.219.163.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB1251;7:Zn4i2+nNmaHJ1/dswrtD6EudRSQpGbJ8aZRNO9pLBnXxxO8tIZc8CT7SW7/uc4zJrZND0Tik2QoeMJmuSHzw1nqa/TujddZiWfJTtPLyaCkniyD6qm6bLzGcZP9pM/1Uphpn2+ukBIAtNI2yLfbGbg5785wLOf2aymf4hyG2xpVGxYRAVrqMP1HRyXJ4HVMJRIxSJzxo2TPuUjvxQrao+1vpXaQwjQyvrGtnwBWPBL95kkDW+WTVbGXVRQ4hnF/A
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 09a08790-744d-46e3-4de5-08d5daf725af
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB1251;
x-ms-traffictypediagnostic: AT5PR8401MB1251:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB1251DB1070A06656C3F68462824A0@AT5PR8401MB1251.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201703031522075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AT5PR8401MB1251;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB1251;
x-forefront-prvs: 0714841678
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(366004)(376002)(396003)(199004)(189003)(11346002)(446003)(26005)(8676002)(102836004)(186003)(14454004)(76176011)(6512007)(103116003)(3846002)(6506007)(478600001)(6116002)(7416002)(99286004)(8936002)(110136005)(6486002)(296002)(316002)(81166006)(54906003)(81156014)(2900100001)(5660300001)(2906002)(7736002)(97736004)(86362001)(575784001)(68736007)(4326008)(6246003)(2501003)(53936002)(6436002)(5250100002)(229853002)(486006)(305945005)(25786009)(106356001)(36756003)(105586002)(476003)(2616005)(256004)(14444005)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1251;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: n3saYig7VYOd/S2uelOMYoYAf4q1kqqlib4rSd3p8uip6NNHuArDjMJS4SccvrogDU8NheMyVlMqUSAMbm/kK2Dz7FXB5g805DajMGC0zmPu5LqO1D4tYElMhcjt9pTXMA25SYH5g+DfVeZPcIrqh9PqsPNxvEo68jvdjbTsKf0iTKxHiMWqwo3Y24gJ/yRfn5XFT0D1aDQsO6MQvxuK4hoAE4uNkvC4Ps5zaX+srE6Gai3MstLhvB9sZqIMLfjsPIUGjDhzO+zmQQzLfQLW+unUh3iqh6vyOm413c/S9HbkSdVK+NLcSQhg144OkilM+UVESmYDipmdITLeJoJ+0oC6QALlGggQ+GrBxCKo4jI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B784A9CF924F8B4CB71A3819FF5BC6CA@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a08790-744d-46e3-4de5-08d5daf725af
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2018 23:55:36.5745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1251
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA2LTIyIGF0IDE4OjE5IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBbK2NjIFRvc2hpXQ0KPiANCj4gT24gRnJpLCBKdW4gMjIsIDIwMTggYXQgMDg6MDE6MzhQTSAr
MDgwMCwgZ3VvbWluIGNoZW4gd3JvdGU6DQo+ID4gV2UndmUgZ290IGEgYnVnIHJlcG9ydCBpbmRp
Y2F0aW5nIHRoZSBob3QtcmVtb3ZlIG5vZGUgcmVzb3VyY2UNCj4gPiByZWxlYXNlIGZhaWxlZCx3
aGVuIHRoZSBtZW1vcnkgb24gdGhpcyBub2RlIGlzIGRpdmlkZWQgaW50bw0KPiA+IHNldmVyYWwg
c2VjdGlvbnMuYmVjYXVzZSB0aGUgcmVsZWFzZV9tZW1fcmVnaW9uX2FkanVzdGFibGUoKQ0KPiA+
IGNhbiBvbmx5IHJlbGVhc2Ugb25lIHJlc291cmNlIHRoYXQgbXVzdCBiZSBbc3RhcnQsZW5kXS4N
Cj4gDQo+IENhbiB5b3UgcGxlYXNlIGluY2x1ZGUgYSBVUkwgZm9yIHRoZSBidWcgcmVwb3J0PyAg
VGhhdCdzIHVzZWZ1bCBmb3INCj4gYWRkaXRpb25hbCBkZXRhaWxzIGFuZCBnaXZlcyBoaW50cyBh
Ym91dCBob3cgZnV0dXJlIGNoYW5nZXMgaW4gdGhpcw0KPiBhcmVhIG1pZ2h0IGJlIHRlc3RlZC4N
Cj4gDQo+IHJlbGVhc2VfbWVtX3JlZ2lvbl9hZGp1c3RhYmxlKCkgYW5kIHRoZSBvbmx5IGNhbGwg
dG8gaXQgd2VyZSBhZGRlZA0KPiBieSBUb3NoaSAoY2MnZCk6DQo+IA0KPiAgIDgyNWY3ODdiYjQ5
NiAoInJlc291cmNlOiBhZGQgcmVsZWFzZV9tZW1fcmVnaW9uX2FkanVzdGFibGUoKSIpDQo+ICAg
ZmU3NGViYjEwNmE1ICgibW06IGNoYW5nZSBfX3JlbW92ZV9wYWdlcygpIHRvIGNhbGwgcmVsZWFz
ZV9tZW1fcmVnaW9uX2FkanVzdGFibGUoKSIpDQo+IA0KPiA+IEluIG15IGNhc2UsIHRoZSBCSU9T
IHN1cHBvcnRzIGZhdWx0eSBtZW1vcnkgaXNvbGF0aW9uLiBpZiBCSU9TDQo+ID4gZGV0ZWN0ZWQg
YmFkIG1lbW9yeSBibG9jaywgdGhlIEJJT1Mgd2lsbCBpc29sYXRlcyB0aGlzIGJhZGJsb2NrLg0K
PiA+IEFuZCBzZXQgdGhpcyBiYWRibG9jayBtZW1vcnkgdG8gRWZpVW51c2FibGVNZW1vcnkgaW4g
RUZJIG1lbW9yeSBtYXANCj4gPiBiYXNlIG9uIFVFRkkgMi43IHNwZWMuRm9yIGV4YW1wbGUgaW4g
bXkgc3lzdGVtLCB0aGUgbWVtb3J5IHJhbmdlIG9uDQo+ID4gbm9kZTIgaXMgW21lbSAweDAwMDAw
ODAwMDAwMDAwMDAtMHgwMDAwMDgwN2ZmZmZmZmZmXS5idXQgdGhlIEJJT1MNCj4gPiBkZXRlY3Rl
ZCB0aGUgWzgwMDRlMDAwMDAwLTgwMDRlMGZmZmZmXSBpcyBhIGJhZGJsb2NrIG1lbW9yeS4NCj4g
PiBTbyB0aGUgbWVtb3J5IG9uIG5vZGUyIHNlZW0gbGlrZSB0aGlzOg0KPiA+ICAgIAkJODAwMDAw
MDAwMDAtODAwNGRmZmZmZmYgOiBTeXN0ZW0gUkFNDQo+ID4gCQk4MDA0ZTAwMDAwMC04MDA0ZTBm
ZmZmZiA6IFVudXNhYmxlIG1lbW9yeQ0KPiA+IAkJODAwNGUxMDAwMDAtODA3ZmZmZmZmZmYgOiBT
eXN0ZW0gUkFNDQo+ID4gDQo+ID4gTm93LCB3aGVuIG9mZmxpbmUgdGhlIGNwdSBub2RlMix0aGUg
a2VybmVsIHdpbGwgdHJ5IHRvIHJlbGVhc2UNCj4gPiBpb3Jlc291cmNlIFttZW0gMHgwMDAwMDgw
MDAwMDAwMDAwLTB4MDAwMDA4MDdmZmZmZmZmZl0uIGF0IHRoaXMNCj4gPiB0aW1lLCB0aGUga2Vy
bmVsIHdpbGwgcmVsZWFzZSBmYWlsZWQsYW5kIG91dHB1dCBlcnJvciBtZXNzYWdlOg0KPiA+ICJV
bmFibGUgdG8gcmVsZWFzZSByZXNvdXJjZSA8MHgwMDAwMDgwMDAwMDAwMDAwLTB4MDAwMDA4MDdm
ZmZmZmZmZj4NCj4gPiAoLTIyKSIuDQoNCkhtbS4uLiB0aGlzIEJJTyBpbXBsZW1lbnRhdGlvbiBk
b2VzIG5vdCBzb3VuZCByaWdodCB0byBtZS4gIFdoZW4gRUZJDQptZW1vcnkgbWFwIGhhcyBhIGhv
bGUsIEFDUEkgbWVtb3J5IG9iamVjdCBzaG91bGQgaGF2ZSB0aGUgc2FtZSBob2xlIGluDQppdHMg
cmVzb3VyY2UgaW5mby4gIElmIHNvLCB0aGlzIG5vZGUyIG1lbW9yeSBob3QtZGVsZXRlIHdvdWxk
IGhhdmUNCnJlcXVlc3RlZCBhIGRlbGV0aW9uIG9mIDIgc2VwYXJhdGUgU3lzdGVtIFJBTSByYW5n
ZXMsIG5vdCBhIHNpbmdsZSByYW5nZQ0KaW5jbHVkaW5nIHRoaXMgaG9sZS4gIFRoaXMgaXMgYWxz
byBpbXBvcnRhbnQgZm9yIG1lbW9yeSBob3QtYWRkLiAgQUNQSQ0KbWVtb3J5IG9iamVjdCBuZWVk
cyB0byBkZXNjcmliZSB0aGlzIGhvbGUgaW4gb3JkZXIgZm9yIHRoZSBPUyB0byBhdm9pZA0KYWRk
aW5nIHRoaXMgYmFkYmxvY2sgbWVtb3J5Lg0KDQpUaGFua3MsDQotVG9zaGkNCg==
