Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8321ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3592020881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3592020881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbeIOC1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 22:27:04 -0400
Received: from g4t3425.houston.hpe.com ([15.241.140.78]:48098 "EHLO
        g4t3425.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbeIOC1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 22:27:03 -0400
X-Greylist: delayed 2070 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Sep 2018 22:27:03 EDT
Received: from G1W8107.americas.hpqcorp.net (g1w8107.austin.hp.com [16.193.72.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id 1386CA9;
        Fri, 14 Sep 2018 21:10:51 +0000 (UTC)
Received: from G2W6309.americas.hpqcorp.net (2002:10c5:4033::10c5:4033) by
 G1W8107.americas.hpqcorp.net (2002:10c1:483b::10c1:483b) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Fri, 14 Sep 2018 21:10:50 +0000
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (15.241.52.11) by
 G2W6309.americas.hpqcorp.net (16.197.64.51) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Fri, 14 Sep 2018 21:10:50 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB0609.NAMPRD84.PROD.OUTLOOK.COM (10.169.4.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Fri, 14 Sep 2018 21:10:49 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac4f:ac06:14f9:d283]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac4f:ac06:14f9:d283%2]) with mapi id 15.20.1143.014; Fri, 14 Sep 2018
 21:10:49 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "Hocko, Michal" <MHocko@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/5] ioremap: Rework pXd_free_pYd_page() API
Thread-Topic: [PATCH 1/5] ioremap: Rework pXd_free_pYd_page() API
Thread-Index: AQHUSoMKoOShLl5RW0iSVsyGvjy8o6TwQCwAgAAJcoA=
Date:   Fri, 14 Sep 2018 21:10:49 +0000
Message-ID: <db3f513bf3bfafb85b99f57f741f5bb07952af70.camel@hpe.com>
References: <1536747974-25875-1-git-send-email-will.deacon@arm.com>
         <1536747974-25875-2-git-send-email-will.deacon@arm.com>
         <71baefb8e0838fba89ee06262bbb2456e9091c7a.camel@hpe.com>
In-Reply-To: <71baefb8e0838fba89ee06262bbb2456e9091c7a.camel@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-originating-ip: [15.211.195.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0609;6:9W00WoXlAGiROXUESIaXZQ5Ex7GGrTvphhSoMOZYrMf7m9hvl1KGAQndJRKRPAa7BbyTc8/GJ9tlb400wmd2U0TBohjezq3b7AQKDflPxKcnzZRybAcUHjiY7vJ6L9LisB4MOzg7jjoZUuMa+bR9oWckCBMUr2RuH+5hShFpqcy/prbIFHtyJsPHdpB6hUzgmUGzu5nIpaENz19bMdJ8pgf0ZJZsoOz5CJzj1N9LSvma5qA3RRItpQoDJHJ0PRMc2/BBMhtx5Je27hN6SpZj75EhwTSWrx6kGr2aw/cAemOs8/532uRBBtbqv/FCNKJX8eXb7m/bGBsJMkU9RHaReLE0sDc0kcCeIbwRSeOpJUOsIvKa68+vYlkX+GblwTHPQQmffyqeQNHestQGuchl9SOEkLewoccgOn+O8YpnEpTS5LZHvF7ul3MgjVyMmaYZThi0LFKfs9BgjPWGOMg2fw==;5:aQ+M4cpCYXSwfvbdlnmr4qSMSzhBp5kmUzrU/gwzk9YldTCJTfHHNt6XVEN3Dw9aMPaF4uU/AtJROqnob+5ambrMQpXkAclQBULbSWw9nxYK1f3DGMWDmSQYVqhYh3WNToluAX0cBSdNVKZK7loBad/da6UQzfptIy3GV+Qq+Co=;7:OvLkGdUh8JLYmOXqlaJ6XMgp1DTmpzgrv88zymVYg2v3/zKiQnnvBzoGMxeRksVR0+GOrduyE6o4JoWvpbEnSxACftOdqsfFUpcTP4MYwVE6yUpOALLOBvj9Jgf40pn6ed32waDY54DGrL1TdJhP/yy67260YLD1SkwF9UV5wrwemgvR2hX0q7yv6wm5qHPo32QmdvV8RhgDo3X62VP8q3pAQc/OS3yBzftGTjKKD6rLuITTZ/7cvztVWqjngybt
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bc95b530-41c2-4ff3-6cc0-08d61a868be3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0609;
x-ms-traffictypediagnostic: AT5PR8401MB0609:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB060952E5F21700916B7892C582190@AT5PR8401MB0609.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(180628864354917)(222181515654134);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:AT5PR8401MB0609;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0609;
x-forefront-prvs: 07954CC105
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39860400002)(396003)(136003)(199004)(189003)(54094003)(81166006)(25786009)(229853002)(6436002)(5250100002)(316002)(2906002)(3846002)(6116002)(8936002)(2501003)(36756003)(6512007)(53936002)(6486002)(81156014)(68736007)(5660300001)(256004)(106356001)(478600001)(14454004)(186003)(2201001)(26005)(6506007)(118296001)(110136005)(102836004)(6246003)(86362001)(105586002)(7736002)(4326008)(305945005)(99286004)(66066001)(97736004)(446003)(76176011)(54906003)(476003)(2616005)(486006)(11346002)(2900100001)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0609;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: B1+6TbGnoN+U8x9wVc1iuIJ2DQelPAV58u1mTJBL5uNNs5PlGjNoDPQm3e1pB7u91+NlZ2bjCVTpIaMnNN/wjui3NYNwfEtDMnh19ALZ/wN+2Orgo9bDW+2TnaHAqZt30JMsfc9cZvJVVKJEATtutefvRLgKHLl01xtbgzoFIytdFP9GYLYnEqZSJAfk0qOEZ0qRQcJ1+VkF+fG37RNz22Rjc46+llyfIvUeZ3mRp+C69fX/5l/7eOg1Ai4pgnS9Q71dMj65dA0uTMDxIgu8nenncflCZ8mX806mOnNjuBy9Na2p+zAqblE0ZtKSe4mz7p6III8bOKq9j3ua9kBnNkQ8y8+gnbkiGGdMxLhkO0k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BBA5E9960E2D24F94F5733855EE94A0@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bc95b530-41c2-4ff3-6cc0-08d61a868be3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2018 21:10:49.3320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0609
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA5LTE0IGF0IDE0OjM2IC0wNjAwLCBUb3NoaSBLYW5pIHdyb3RlOg0KPiBP
biBXZWQsIDIwMTgtMDktMTIgYXQgMTE6MjYgKzAxMDAsIFdpbGwgRGVhY29uIHdyb3RlOg0KPiA+
IFRoZSByZWNlbnRseSBtZXJnZWQgQVBJIGZvciBlbnN1cmluZyBicmVhay1iZWZvcmUtbWFrZSBv
biBwYWdlLXRhYmxlDQo+ID4gZW50cmllcyB3aGVuIGluc3RhbGxpbmcgaHVnZSBtYXBwaW5ncyBp
biB0aGUgdm1hbGxvYy9pb3JlbWFwIHJlZ2lvbiBpcw0KPiA+IGZhaXJseSBjb3VudGVyLWludHVp
dGl2ZSwgcmVzdWx0aW5nIGluIHRoZSBhcmNoIGZyZWVpbmcgZnVuY3Rpb25zDQo+ID4gKGUuZy4g
cG1kX2ZyZWVfcHRlX3BhZ2UoKSkgYmVpbmcgY2FsbGVkIGV2ZW4gb24gZW50cmllcyB0aGF0IGFy
ZW4ndA0KPiA+IHByZXNlbnQuIFRoaXMgcmVzdWx0ZWQgaW4gYSBtaW5vciBidWcgaW4gdGhlIGFy
bTY0IGltcGxlbWVudGF0aW9uLCBnaXZpbmcNCj4gPiByaXNlIHRvIHNwdXJpb3VzIFZNX1dBUk4g
bWVzc2FnZXMuDQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBtb3ZlcyB0aGUgcFhkX3ByZXNlbnQoKSBj
aGVja3Mgb3V0IGludG8gdGhlIGNvcmUgY29kZSwNCj4gPiByZWZhY3RvcmluZyB0aGUgY2FsbHNp
dGVzIGF0IHRoZSBzYW1lIHRpbWUgc28gdGhhdCB3ZSBhdm9pZCB0aGUgY29tcGxleA0KPiA+IGNv
bmp1bmN0aW9ucyB3aGVuIGRldGVybWluaW5nIHdoZXRoZXIgb3Igbm90IHdlIGNhbiBwdXQgZG93
biBhIGh1Z2UNCj4gPiBtYXBwaW5nLg0KPiA+IA0KPiA+IENjOiBDaGludGFuIFBhbmR5YSA8Y3Bh
bmR5YUBjb2RlYXVyb3JhLm9yZz4NCj4gPiBDYzogVG9zaGkgS2FuaSA8dG9zaGkua2FuaUBocGUu
Y29tPg0KPiA+IENjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gPiBD
YzogTWljaGFsIEhvY2tvIDxtaG9ja29Ac3VzZS5jb20+DQo+ID4gQ2M6IEFuZHJldyBNb3J0b24g
PGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQo+ID4gU3VnZ2VzdGVkLWJ5OiBMaW51cyBUb3J2
YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTog
V2lsbCBEZWFjb24gPHdpbGwuZGVhY29uQGFybS5jb20+DQo+IA0KPiBZZXMsIHRoaXMgbG9va3Mg
bmljZXIuDQo+IA0KPiBSZXZpZXdlZC1ieTogVG9zaGkgS2FuaSA8dG9zaGkua2FuaUBocGUuY29t
Pg0KDQpTb3JyeSwgSSB0YWtlIGl0IGJhY2sgc2luY2UgSSBnb3QgYSBxdWVzdGlvbi4uLg0KDQor
c3RhdGljIGludCBpb3JlbWFwX3RyeV9odWdlX3BtZChwbWRfdCAqcG1kLCB1bnNpZ25lZCBsb25n
IGFkZHIsDQo+ICsJCQkJdW5zaWduZWQgbG9uZyBlbmQsIHBoeXNfYWRkcl90DQpwaHlzX2FkZHIs
DQo+ICsJCQkJcGdwcm90X3QgcHJvdCkNCj4gK3sNCj4gKwlpZiAoIWlvcmVtYXBfcG1kX2VuYWJs
ZWQoKSkNCj4gKwkJcmV0dXJuIDA7DQo+ICsNCj4gKwlpZiAoKGVuZCAtIGFkZHIpICE9IFBNRF9T
SVpFKQ0KPiArCQlyZXR1cm4gMDsNCj4gKw0KPiArCWlmICghSVNfQUxJR05FRChwaHlzX2FkZHIs
IFBNRF9TSVpFKSkNCj4gKwkJcmV0dXJuIDA7DQo+ICsNCj4gKwlpZiAocG1kX3ByZXNlbnQoKnBt
ZCkgJiYgIXBtZF9mcmVlX3B0ZV9wYWdlKHBtZCwgYWRkcikpDQo+ICsJCXJldHVybiAwOw0KDQpJ
cyBwbV9wcmVzZW50KCkgYSBwcm9wZXIgY2hlY2sgaGVyZT8gIFdlIHByb2JhYmx5IGRvIG5vdCBo
YXZlIHRoaXMgY2FzZQ0KZm9yIGlvbWFwLCBidXQgSSB3b25kZXIgaWYgb25lIGNhbiBkcm9wIHAt
Yml0IHdoaWxlIGl0IGhhcyBhIHB0ZSBwYWdlDQp1bmRlcm5lYXRoLg0KDQpUaGFua3MsDQotVG9z
aGkNCg0KDQo+ICsNCj4gKwlyZXR1cm4gcG1kX3NldF9odWdlKHBtZCwgcGh5c19hZGRyLCBwcm90
KTsNCj4gK30NCj4gKw0KDQoNCg==
