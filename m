Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C36C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A5F27446
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A5F27446
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966799AbeF2QCB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:02:01 -0400
Received: from g4t3425.houston.hpe.com ([15.241.140.78]:58807 "EHLO
        g4t3425.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936279AbeF2QB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:01:58 -0400
Received: from G9W8453.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.216.160.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id 3CCB49D;
        Fri, 29 Jun 2018 16:01:57 +0000 (UTC)
Received: from G1W8107.americas.hpqcorp.net (2002:10c1:483b::10c1:483b) by
 G9W8453.americas.hpqcorp.net (2002:10d8:a0d3::10d8:a0d3) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Fri, 29 Jun 2018 16:01:57 +0000
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (15.241.52.12) by
 G1W8107.americas.hpqcorp.net (16.193.72.59) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Fri, 29 Jun 2018 16:01:57 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB0530.NAMPRD84.PROD.OUTLOOK.COM (10.169.4.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.21; Fri, 29 Jun 2018 16:01:54 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8%5]) with mapi id 15.20.0906.025; Fri, 29 Jun 2018
 16:01:54 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hocko, Michal" <MHocko@suse.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 2/3] ioremap: Update pgtable free interfaces with addr
Thread-Topic: [PATCH v4 2/3] ioremap: Update pgtable free interfaces with addr
Thread-Index: AQHUDiFnEX50gQPXr0aGJMF/fXfE2KR0QpSAgAAEJ4CAAuUegIAAPFWA
Date:   Fri, 29 Jun 2018 16:01:54 +0000
Message-ID: <1530287995.14039.361.camel@hpe.com>
References: <20180627141348.21777-1-toshi.kani@hpe.com>
         <20180627141348.21777-3-toshi.kani@hpe.com>
         <20180627155632.GH30631@arm.com> <1530115885.14039.295.camel@hpe.com>
         <20180629122358.GC17859@arm.com>
In-Reply-To: <20180629122358.GC17859@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-originating-ip: [15.219.163.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0530;7:t+L6jRyBn7PPEjnlwryDgGAyl1Lz6Mo3qSz6XaADDKciDmuRZG3K3IYoM4DkXPkcZHWi5uIL4FxiO7rVoVeMtEYsfs+SAN5PBjF5ngkW3+3ihigi6n5l8zOlmc8zg2cwP8D8Ica2h5kFXCQx4mHn40uhLAIPtVb5Dm1IuSTwhEDrYD54m/3hJ/dqPZy9lSx/N6ne5kFuH7BshOzxwWm7EIB/sQWoljU32xXrYwW1FGqCXGzpcvmzRAFbsAUWKFFW
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9e02fbbd-5e06-4422-1fa5-08d5ddd9a278
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600026)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0530;
x-ms-traffictypediagnostic: AT5PR8401MB0530:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB053031D2C3983930C936496C824E0@AT5PR8401MB0530.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AT5PR8401MB0530;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0530;
x-forefront-prvs: 0718908305
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(136003)(376002)(346002)(199004)(189003)(86362001)(25786009)(105586002)(54906003)(106356001)(102836004)(81156014)(110136005)(8676002)(26005)(81166006)(10710500007)(7110500001)(2906002)(186003)(99286004)(14454004)(476003)(103116003)(229853002)(11346002)(486006)(2616005)(446003)(2900100001)(6306002)(478600001)(966005)(97736004)(305945005)(6486002)(316002)(6512007)(93886005)(6436002)(4326008)(6506007)(5250100002)(2420400007)(66066001)(256004)(76176011)(7736002)(14444005)(36756003)(6246003)(3846002)(2501003)(6116002)(7416002)(15650500001)(68736007)(53936002)(5660300001)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0530;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kPAPsllDBbGrTzJr6C1cfQZ50C/9gCHJvDucJey0r/Z7EPrjKUZIgOKKavGkGbBIwKVIaE8CvE4E73nAqrXqEvVupN1HdZmM/Vucw21/Xph75t4XDhhsbNE5E7O5ztbs1Di0O8KnllS42Z6W79euhrc7jkFSLtdDs35BnRkXuC1XTUqhVr07pnVNlOeo39QK/m/iFpZILT6sg0ZZ5iLk7EtSIMk/ouDLpVHrQXGGRT9dnTxpLvDo5lJ9abOm8yDhuJBt15+GDIxuwefjROqlA3gPe5q9rtKd0YCaHx+y9fg+Dq6Paxuxwomh+/J0NgeOxgI2yD4NzJpzd6jSjCfwb4+W4AnFLbT8CxIpprSaa1E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <84DC9C22A8370C43990D4CEF85DFAAC7@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e02fbbd-5e06-4422-1fa5-08d5ddd9a278
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2018 16:01:54.4885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0530
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA2LTI5IGF0IDEzOjIzICswMTAwLCBXaWxsIERlYWNvbiB3cm90ZToNCj4g
SGkgVG9zaGksIFRob21hcywNCj4gDQo+IE9uIFdlZCwgSnVuIDI3LCAyMDE4IGF0IDA0OjEzOjIy
UE0gKzAwMDAsIEthbmksIFRvc2hpIHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAxOC0wNi0yNyBhdCAx
Njo1NiArMDEwMCwgV2lsbCBEZWFjb24gd3JvdGU6DQo+ID4gPiBPbiBXZWQsIEp1biAyNywgMjAx
OCBhdCAwODoxMzo0N0FNIC0wNjAwLCBUb3NoaSBLYW5pIHdyb3RlOg0KPiA+ID4gPiBGcm9tOiBD
aGludGFuIFBhbmR5YSA8Y3BhbmR5YUBjb2RlYXVyb3JhLm9yZz4NCj4gPiA+ID4gDQo+ID4gPiA+
IFRoZSBmb2xsb3dpbmcga2VybmVsIHBhbmljIHdhcyBvYnNlcnZlZCBvbiBBUk02NCBwbGF0Zm9y
bSBkdWUgdG8gYSBzdGFsZQ0KPiA+ID4gPiBUTEIgZW50cnkuDQo+ID4gPiA+IA0KPiA+ID4gPiAg
MS4gaW9yZW1hcCB3aXRoIDRLIHNpemUsIGEgdmFsaWQgcHRlIHBhZ2UgdGFibGUgaXMgc2V0Lg0K
PiA+ID4gPiAgMi4gaW91bm1hcCBpdCwgaXRzIHB0ZSBlbnRyeSBpcyBzZXQgdG8gMC4NCj4gPiA+
ID4gIDMuIGlvcmVtYXAgdGhlIHNhbWUgYWRkcmVzcyB3aXRoIDJNIHNpemUsIHVwZGF0ZSBpdHMg
cG1kIGVudHJ5IHdpdGgNCj4gPiA+ID4gICAgIGEgbmV3IHZhbHVlLg0KPiA+ID4gPiAgNC4gQ1BV
IG1heSBoaXQgYW4gZXhjZXB0aW9uIGJlY2F1c2UgdGhlIG9sZCBwbWQgZW50cnkgaXMgc3RpbGwg
aW4gVExCLA0KPiA+ID4gPiAgICAgd2hpY2ggbGVhZHMgdG8gYSBrZXJuZWwgcGFuaWMuDQo+ID4g
PiA+IA0KPiA+ID4gPiBDb21taXQgYjZiZGI3NTE3YzNkICgibW0vdm1hbGxvYzogYWRkIGludGVy
ZmFjZXMgdG8gZnJlZSB1bm1hcHBlZCBwYWdlDQo+ID4gPiA+IHRhYmxlIikgaGFzIGFkZHJlc3Nl
ZCB0aGlzIHBhbmljIGJ5IGZhbGxpbmcgdG8gcHRlIG1hcHBpbmdzIGluIHRoZSBhYm92ZQ0KPiA+
ID4gPiBjYXNlIG9uIEFSTTY0Lg0KPiA+ID4gPiANCj4gPiA+ID4gVG8gc3VwcG9ydCBwbWQgbWFw
cGluZ3MgaW4gYWxsIGNhc2VzLCBUTEIgcHVyZ2UgbmVlZHMgdG8gYmUgcGVyZm9ybWVkDQo+ID4g
PiA+IGluIHRoaXMgY2FzZSBvbiBBUk02NC4NCj4gPiA+ID4gDQo+ID4gPiA+IEFkZCBhIG5ldyBh
cmcsICdhZGRyJywgdG8gcHVkX2ZyZWVfcG1kX3BhZ2UoKSBhbmQgcG1kX2ZyZWVfcHRlX3BhZ2Uo
KQ0KPiA+ID4gPiBzbyB0aGF0IFRMQiBwdXJnZSBjYW4gYmUgYWRkZWQgbGF0ZXIgaW4gc2VwcmF0
ZSBwYXRjaGVzLg0KPiA+ID4gDQo+ID4gPiBTbyBJIGFja2VkIHYxMyBvZiBDaGludGFuJ3Mgc2Vy
aWVzIHBvc3RlZCBoZXJlOg0KPiA+ID4gDQo+ID4gPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9waXBlcm1haWwvbGludXgtYXJtLWtlcm5lbC8yMDE4LUp1bmUvNTgyOTUzLmh0bWwNCj4gPiA+
IA0KPiA+ID4gYW55IGNoYW5jZSB0aGlzIGxvdCBjb3VsZCBhbGwgYmUgbWVyZ2VkIHRvZ2V0aGVy
LCBwbGVhc2U/DQo+ID4gDQo+ID4gQ2hpbnRhbidzIHBhdGNoIDIvMyBhbmQgMy8zIGFwcGx5IGNs
ZWFubHkgb24gdG9wIG9mIG15IHNlcmllcy4gQ2FuIHlvdQ0KPiA+IHBsZWFzZSBjb29yZGluYXRl
IHdpdGggVGhvbWFzIG9uIHRoZSBsb2dpc3RpY3M/DQo+IA0KPiBTdXJlLiBJIGd1ZXNzIGhhdmlu
ZyB0aGlzIHNlcmllcyBvbiBhIGNvbW1vbiBicmFuY2ggdGhhdCBJIGNhbiBwdWxsIGludG8NCj4g
YXJtNjQgYW5kIGFwcGx5IENoaW50YW4ncyBvdGhlciBwYXRjaGVzIG9uIHRvcCB3b3VsZCB3b3Jr
Lg0KPiANCj4gSG93IGRvZXMgdGhhdCBzb3VuZD8NCg0KU2hvdWxkIHRoaXMgZ28gdGhydSAtbW0g
dHJlZSB0aGVuPw0KDQpBbmRyZXcsIFRob21hcywgd2hhdCBkbyB5b3UgdGhpbms/IA0KDQpUaGFu
a3MsDQotVG9zaGkNCg0KDQoNCg==
