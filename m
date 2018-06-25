Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A7DC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44C925BDC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44C925BDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934644AbeFYO4c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:56:32 -0400
Received: from g4t3425.houston.hpe.com ([15.241.140.78]:21093 "EHLO
        g4t3425.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934614AbeFYO4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:56:30 -0400
Received: from G4W9120.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.210.21.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id 2ACBABA;
        Mon, 25 Jun 2018 14:56:29 +0000 (UTC)
Received: from G1W8107.americas.hpqcorp.net (2002:10c1:483b::10c1:483b) by
 G4W9120.americas.hpqcorp.net (2002:10d2:150f::10d2:150f) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Mon, 25 Jun 2018 14:56:29 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (15.241.52.12) by
 G1W8107.americas.hpqcorp.net (16.193.72.59) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Mon, 25 Jun 2018 14:56:28 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB1028.NAMPRD84.PROD.OUTLOOK.COM (10.169.7.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.19; Mon, 25 Jun 2018 14:56:26 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8%5]) with mapi id 15.20.0884.024; Mon, 25 Jun 2018
 14:56:26 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "Hocko, Michal" <MHocko@suse.com>
Subject: Re: [PATCH v3 0/3] fix free pmd/pte page handlings on x86
Thread-Topic: [PATCH v3 0/3] fix free pmd/pte page handlings on x86
Thread-Index: AQHUC73/TYYF8RoO3UmhiJVFAtgPVKRxEVsA
Date:   Mon, 25 Jun 2018 14:56:26 +0000
Message-ID: <1529938470.14039.134.camel@hpe.com>
References: <20180516233207.1580-1-toshi.kani@hpe.com>
         <alpine.DEB.2.21.1806241516410.8650@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1806241516410.8650@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-originating-ip: [15.219.163.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB1028;7:hEKY+CD8iju2hawmm3zO4CD3mIHT9g1A+U+t275iw2Sr7gkh62B9aeAy91XSd2S8leCJAN0+IHihSW5bzPJFSQqZMUGNOpfTLkyFfMks2YLXDj8UT7ANu4XvX+pJ+1TdmpGXQ9RxXQP8Z+CVn/NukkXro8vRCFX1qYiaMJm17Agb4BkLypS8r5EJUwOn636uoPDODnsc+nEHdmACqhZqO85k/Rl8Xti7oo56Sz4gcN55z27RDR7W0/81tMe0ey/+
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d95e319d-f16a-4887-c661-08d5daabd389
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB1028;
x-ms-traffictypediagnostic: AT5PR8401MB1028:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB1028C56FF2368FBD8F0F91DA824A0@AT5PR8401MB1028.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(222181515654134);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AT5PR8401MB1028;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB1028;
x-forefront-prvs: 0714841678
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(39380400002)(346002)(396003)(199004)(189003)(7416002)(7736002)(105586002)(6506007)(106356001)(305945005)(2900100001)(6246003)(76176011)(59450400001)(26005)(102836004)(316002)(4326008)(103116003)(966005)(14454004)(186003)(8936002)(54906003)(6486002)(5250100002)(25786009)(2501003)(97736004)(81166006)(81156014)(6306002)(68736007)(1730700003)(86362001)(8676002)(3660700001)(99286004)(6916009)(6512007)(2906002)(229853002)(66066001)(5640700003)(5660300001)(3280700002)(486006)(2351001)(476003)(53936002)(6436002)(2616005)(446003)(6116002)(3846002)(36756003)(478600001)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1028;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Mj2jSHfVv5XgjiSP+O04YaovoZHFmeLRXK72kUpXKlWa4EjaVVQX0j70jgiu72pR0BQbCMFXfpY7lVJAPZ9i/miFKYFi58Uht4orTrn+t31V4bGUe4V1sbtp77BbxGr4e4/6/EWew15oea68+VkZtRFeRVcTNjR0/OVqUTWU4/r836EETWrclUsyS5iU8S+moG/NYBjLJfAzBCseloBztFBd3FM2Cd0b1d47/Z0v1OE7Khr0SU+7ajO+d4U26Lyt5jOg7D3+RT7PMD1S38NhpNmUwjEqYIqMaC4xJPGbgLmefvQLwYNJsdNDL4vTU8Mks0QuoIx4y7QBlIQGIzIeFmaAxYPtM+WCv3AIoK3k/vU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4246762E255CE349A995678638C71999@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d95e319d-f16a-4887-c661-08d5daabd389
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2018 14:56:26.4136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1028
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDE4LTA2LTI0IGF0IDE1OjE5ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIFdlZCwgMTYgTWF5IDIwMTgsIFRvc2hpIEthbmkgd3JvdGU6DQo+IA0KPiA+IFRoaXMg
c2VyaWVzIGZpeGVzIHR3byBpc3N1ZXMgaW4gdGhlIHg4NiBpb3JlbWFwIGZyZWUgcGFnZSBoYW5k
bGluZ3MNCj4gPiBmb3IgcHVkL3BtZCBtYXBwaW5ncy4NCj4gPiANCj4gPiBQYXRjaCAwMSBmaXhl
cyBCVUdfT04gb24geDg2LVBBRSByZXBvcnRlZCBieSBKb2VyZy4gIEl0IGRpc2FibGVzDQo+ID4g
dGhlIGZyZWUgcGFnZSBoYW5kbGluZyBvbiB4ODYtUEFFLg0KPiA+IA0KPiA+IFBhdGNoIDAyLTAz
IGZpeGVzIGEgcG9zc2libGUgaXNzdWUgd2l0aCBzcGVjdWxhdGlvbiB3aGljaCBjYW4gY2F1c2UN
Cj4gPiBzdGFsZSBwYWdlLWRpcmVjdG9yeSBjYWNoZS4NCj4gPiAgLSBQYXRjaCAwMiBpcyBmcm9t
IENoaW50YW4ncyB2OSAwMS8wNCBwYXRjaCBbMV0sIHdoaWNoIGFkZHMgYSBuZXcgYXJnDQo+ID4g
ICAgJ2FkZHInLCB3aXRoIG15IG1lcmdlIGNoYW5nZSB0byBwYXRjaCAwMS4NCj4gPiAgLSBQYXRj
aCAwMyBhZGRzIGEgVExCIHB1cmdlIChJTlZMUEcpIHRvIHB1cmdlIHBhZ2Utc3RydWN0dXJlIGNh
Y2hlcw0KPiA+ICAgIHRoYXQgbWF5IGJlIGNhY2hlZCBieSBzcGVjdWxhdGlvbi4gIFNlZSB0aGUg
cGF0Y2ggZGVzY3JpcHRpb25zIGZvcg0KPiA+ICAgIG1vcmUgZGV0YWwuDQo+IA0KPiBUb3NoaSwg
Sm9lcmcsIE1pY2hhbCENCg0KSGkgVGhvbWFzLA0KDQpUaGFua3MgZm9yIGNoZWNraW5nLiBJIHdh
cyBhYm91dCB0byBwaW5nIGFzIHdlbGwuDQoNCj4gSSdtIGZhaWxpbmcgdG8gZmluZCBhIGNvbmNs
dXNpb24gb2YgdGhpcyBkaXNjdXNzaW9uLiBDYW4gd2UgZmluYWxseSBtYWtlDQo+IHNvbWUgcHJv
Z3Jlc3Mgd2l0aCB0aGF0Pw0KDQpJIGhhdmUgbm90IGhlYXJkIGZyb20gSm9lcmcgc2luY2UgSSBs
YXN0IHJlcGxpZWQgdG8gaGlzIGNvbW1lbnRzIHRvDQpQYXRjaCAzLzMgLS0gSSBkaWQgbXkgYmVz
dCB0byBleHBsYWluIHRoYXQgdGhlcmUgd2FzIG5vIGlzc3VlIGluIHRoZQ0Kc2luZ2xlIHBhZ2Ug
YWxsb2NhdGlvbiBpbiBwdWRfZnJlZV9wbWRfcGFnZSgpLiAgRnJvbSBteSBwZXJzcGVjdGl2ZSwg
dGhlDQogdjMgc2VyaWVzIGlzIGdvb2QgdG8gZ28uDQoNCj4gQ2FuIHNvbWVvbmUgZ2l2ZSBtZSBh
IGhpbnQgd2hhdCB0byBwaWNrIHVwIHVyZ2VudGx5IHBsZWFzZT8NCg0KSSd2ZSBjb25maXJtZWQg
dGhhdCB0aGUgdjMgc2VyaWVzIHN0aWxsIGFwcGxpZXMgY2xlYXJseSB0byA0LjE4LXIyDQpsaW51
cy5naXQuDQoNClBhdGNoIDEvMywgdjMgDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Bh
dGNoLzEwNDA1MDcxLw0KDQpQYXRjaCAyLzMsIHYzLVVQREFURQ0KaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wYXRjaC8xMDQwNzA2NS8NCg0Kbml0OiBzb3JyeSwgcGxlYXNlIGZpeCBteSBl
bWFpbCBhZGRyZXNzIGJlbG93Lg0KLSBbdG9zaGlAaHBlLmNvbTogbWVyZ2UgY2hhbmdlcywgcmV3
cml0ZSBwYXRjaCBkZXNjcmlwdGlvbl0NCisgW3Rvc2hpLmthbmlAaHBlLmNvbTogbWVyZ2UgY2hh
bmdlcywgcmV3cml0ZSBwYXRjaCBkZXNjcmlwdGlvbl0NCg0KUGF0Y2ggMy8zLCB2Mw0KaHR0cHM6
Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDQwNTA3My8NCg0KVGhhbmtzLA0KLVRvc2hp
DQo=
