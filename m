Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8886CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D2C23D88
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D2C23D88
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932069AbeFZVbI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:31:08 -0400
Received: from g4t3425.houston.hpe.com ([15.241.140.78]:50312 "EHLO
        g4t3425.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbeFZVbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:31:04 -0400
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id D94CCB4;
        Tue, 26 Jun 2018 21:31:03 +0000 (UTC)
Received: from G4W9332.americas.hpqcorp.net (16.208.32.118) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 26 Jun 2018 21:31:03 +0000
Received: from G4W10204.americas.hpqcorp.net (2002:10cf:5210::10cf:5210) by
 G4W9332.americas.hpqcorp.net (2002:10d0:2076::10d0:2076) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 26 Jun 2018 21:31:03 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (15.241.52.12) by
 G4W10204.americas.hpqcorp.net (16.207.82.16) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 26 Jun 2018 21:31:03 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB0706.NAMPRD84.PROD.OUTLOOK.COM (10.169.5.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.20; Tue, 26 Jun 2018 21:31:01 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8%5]) with mapi id 15.20.0906.018; Tue, 26 Jun 2018
 21:31:01 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [PATCH v3 1/3] pmem: only set QUEUE_FLAG_DAX for fsdax mode
Thread-Topic: [PATCH v3 1/3] pmem: only set QUEUE_FLAG_DAX for fsdax mode
Thread-Index: AQHUDXd4PTx+x6DffESqIaVXKnR6dKRy4tKAgAABlwCAAAKPAIAAAbUAgAAbeoCAAAMKgIAABTCAgAAB0gCAAABIgA==
Date:   Tue, 26 Jun 2018 21:31:01 +0000
Message-ID: <1530048545.14039.288.camel@hpe.com>
References: <20180626175932.8899-1-ross.zwisler@linux.intel.com>
         <20180626175932.8899-2-ross.zwisler@linux.intel.com>
         <CAPcyv4iWgPnHmBKhUvhManC6UL9CkLqN_d8vBo6KmcPJdPzuUw@mail.gmail.com>
         <20180626185830.GA7171@redhat.com>
         <CAPcyv4h6HO6fs6k7QMD77jkz2djCeWCtWomCdNb0-1Q4VKanqw@mail.gmail.com>
         <20180626191346.GA7233@redhat.com> <1530046327.14039.273.camel@hpe.com>
         <CAPcyv4hP_Y3xdyCa-UkYCMJ5OtnjnkwPZDS2Z2Ge8+5ymBONwQ@mail.gmail.com>
         <1530048093.14039.286.camel@hpe.com>
         <CAPcyv4gXAC7imJs5qfsDNLeN545Rqyd2b1M9s5kr4f9y48LXgQ@mail.gmail.com>
In-Reply-To: <CAPcyv4gXAC7imJs5qfsDNLeN545Rqyd2b1M9s5kr4f9y48LXgQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [15.203.227.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0706;7:olqEj4sa5XIZ4fB0d37wKURF/vFniZikckmZkmB29WcFL7OMxBvP9RnCkiErNT1ITRHGmvNIEDhV81oIzY+AwpQRzTe+kFa5YQCd8WOtKUEWhniiJm4rK/vBONyg0j69kavq8/deCMA6Trgrf4U5VhUQpyFIOqojS1ArvYJRPHfYVJjjhc3j6qYsXWy8OgYBMv7IEDnG74aOiEReHS9B/H1Y9/rAnGsoYfwpQAHifKESyKL27mQwo4WD+1jGlVL4
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e96f0cd4-d543-4dd2-ce26-08d5dbac1d4d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0706;
x-ms-traffictypediagnostic: AT5PR8401MB0706:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-microsoft-antispam-prvs: <AT5PR8401MB0706AC9AFBE641F7D12B614682490@AT5PR8401MB0706.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(222181515654134);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AT5PR8401MB0706;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0706;
x-forefront-prvs: 071518EF63
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(366004)(376002)(396003)(136003)(39860400002)(54534003)(199004)(189003)(53546011)(6506007)(53936002)(103116003)(102836004)(14454004)(54906003)(6512007)(2616005)(93886005)(316002)(186003)(486006)(476003)(81156014)(11346002)(8936002)(5640700003)(6486002)(36756003)(446003)(6436002)(81166006)(4326008)(8676002)(5660300001)(26005)(6916009)(99286004)(76176011)(97736004)(66066001)(6246003)(305945005)(2900100001)(229853002)(478600001)(2351001)(2906002)(7736002)(25786009)(2501003)(106356001)(5250100002)(6116002)(105586002)(14444005)(256004)(86362001)(3846002)(68736007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0706;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hu12jYGa/vIBJDgxWengpzffHGUT9j1XXg/JiXTgrhkRTuxP0ON8nLCncxcFnkFs/aHY8vb47ObOKRI9iLik75u1x2wfziBtwsjhLqIwfolJ52AQ2BuPbGK+E9t8GVYy+ecSWj2uy6aHAzvGxYWF2m01dcYrb4LSZDrvm+rjLhcGX69MHRbRFYG52zQ6ohD3XNN4zO4gZPNXZX84xJAjjQsTxUP9OIlYRF9XipoFUpdb1TNBDvoqwse/x3wErHMJNUcJprveLcfKx02aVwxpJxmpFbtB4X8buLP/ardcFpmJBQxi0960A2JddqSZY+i6AbraAQ2qmyMEmkVAlrjJgIepo9rUg7oJqt7IwZUDS/I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E691B1B6B1F6B641A12FEB7DF2ED0153@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e96f0cd4-d543-4dd2-ce26-08d5dbac1d4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2018 21:31:01.4949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0706
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA2LTI2IGF0IDE0OjI4IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IE9uIFR1ZSwgSnVuIDI2LCAyMDE4IGF0IDI6MjMgUE0sIEthbmksIFRvc2hpIDx0b3NoaS5rYW5p
QGhwZS5jb20+IHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAxOC0wNi0yNiBhdCAxNDowMiAtMDcwMCwg
RGFuIFdpbGxpYW1zIHdyb3RlOg0KPiA+ID4gT24gVHVlLCBKdW4gMjYsIDIwMTggYXQgMTo1NCBQ
TSwgS2FuaSwgVG9zaGkgPHRvc2hpLmthbmlAaHBlLmNvbT4gd3JvdGU6DQo+IA0KPiBbLi5dDQo+
ID4gPiA+IFdoZW4gdGhpcyBkbSBjaGFuZ2Ugd2FzIG1hZGUsIHRoZSBwbWVtIGRyaXZlciBzdXBw
b3J0ZWQgREFYIGZvciBib3RoIHJhdw0KPiA+ID4gPiBhbmQgbWVtb3J5IG1vZGVzIChub3RlOiBz
ZWN0b3IgbW9kZSBkb2VzIG5vdCB1c2UgdGhlIHBtZW0gZHJpdmVyKS4gIEkNCj4gPiA+ID4gdGhp
bmsgdGhlIGlzc3VlIHdhcyBpbnRyb2R1Y2VkIHdoZW4gd2UgZHJvcHBlZCBEQVggc3VwcG9ydCBm
cm9tIHJhdw0KPiA+ID4gPiBtb2RlLg0KPiA+ID4gDQo+ID4gPiBTdGlsbCBEQVggd2l0aCByYXcg
bW9kZSBuZXZlciByZWFsbHkgd29ya2VkIGFueSB3YXkuIEl0IHdhcyBhbHNvDQo+ID4gPiBzb21l
dGhpbmcgdGhhdCB3YXMgYnJva2VuIGZyb20gZGF5IG9uZS4gU28gd2hhdCBoYXBwZW5zIHRvIHNv
bWVvbmUgd2hvDQo+ID4gPiBoYXBwZW5lZCB0byBhdm9pZCBhbGwgdGhlIHByb2JsZW1zIHdpdGgg
cGFnZS1sZXNzIERBWCBhbmQgZW5hYmxlZA0KPiA+ID4gZGV2aWNlLW1hcHBlciBvbiB0b3A/IFRo
YXQgZmFpbHVyZSBtb2RlIGRldGFpbCBuZWVkcyB0byBiZSBhZGRlZCB0bw0KPiA+ID4gdGhpcyBj
aGFuZ2Vsb2cgaWYgd2Ugd2FudCB0byBwcm9wb3NlIHRoaXMgZm9yIC1zdGFibGUuDQo+ID4gDQo+
ID4gTXkgcG9pbnQgaXMgdGhhdCB0aGUgYmVoYXZpb3Igc2hvdWxkIGJlIGNvbnNpc3RlbnQgYmV0
d2VlbiBwbWVtIGFuZA0KPiA+IGRldmljZS1tYXBwZXIuICBXaGVuIC1vIGRheCBzdWNjZWVkcyBv
biBhIHBtZW0sIHRoZW4gaXQgc2hvdWxkIHN1Y2NlZWQNCj4gPiBvbiBhIGRldmljZS1tYXBwZXIg
b24gdG9wIG9mIHRoYXQgcG1lbS4NCj4gPiANCj4gPiBIYXMgdGhlIGRyb3Agb2YgZGF4IHN1cHBv
cnQgZnJvbSByYXcgbW9kZSBtYWRlIHRvIC1zdGFibGUgYmFjayB0byB0aGUNCj4gPiBiYXNlbGlu
ZSBhY2NlcHRlZCA1NDVlZDIwZTZkZjY/ICBJdCB3aWxsIGludHJvZHVjZSBpbmNvbnNpc3RlbmN5
LA0KPiA+IG90aGVyd2lzZS4NCj4gDQo+IFRoYXQgY29tbWl0LCA1NjlkMDM2NWY1NzEgImRheDog
cmVxdWlyZSAnc3RydWN0IHBhZ2UnIGJ5IGRlZmF1bHQgZm9yDQo+IGZpbGVzeXN0ZW0gZGF4Iiwg
aGFzIG5vdCBiZWVuIHRhZ2dlZCBmb3IgLXN0YWJsZS4NCg0KVGhlbiwgRml4ZXMgdGFnIHNob3Vs
ZCBiZSBzZXQgdG8gNTY5ZDAzNjVmNTcxIHRvIGtlZXAgdGhlIGJlaGF2aW9yDQpjb25zaXN0ZW50
Lg0KDQotVG9zaGk=
