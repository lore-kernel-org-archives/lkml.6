Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0A1C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2B021BC7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A2B021BC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754462AbeFZUy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:54:29 -0400
Received: from g9t5008.houston.hpe.com ([15.241.48.72]:35592 "EHLO
        g9t5008.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbeFZUy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:54:27 -0400
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5008.houston.hpe.com (Postfix) with ESMTPS id 9BCDB72;
        Tue, 26 Jun 2018 20:54:26 +0000 (UTC)
Received: from G9W8676.americas.hpqcorp.net (16.220.49.23) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 26 Jun 2018 20:54:05 +0000
Received: from G1W8106.americas.hpqcorp.net (16.193.72.61) by
 G9W8676.americas.hpqcorp.net (16.220.49.23) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 26 Jun 2018 20:54:05 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (15.241.52.11) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 26 Jun 2018 20:54:05 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB1011.NAMPRD84.PROD.OUTLOOK.COM (10.169.7.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.20; Tue, 26 Jun 2018 20:54:03 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8%5]) with mapi id 15.20.0906.018; Tue, 26 Jun 2018
 20:54:03 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>
CC:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] pmem: only set QUEUE_FLAG_DAX for fsdax mode
Thread-Topic: [PATCH v3 1/3] pmem: only set QUEUE_FLAG_DAX for fsdax mode
Thread-Index: AQHUDXd4PTx+x6DffESqIaVXKnR6dKRy4tKAgAABlwCAAAKPAIAAAbUAgAAbeoA=
Date:   Tue, 26 Jun 2018 20:54:03 +0000
Message-ID: <1530046327.14039.273.camel@hpe.com>
References: <20180626175932.8899-1-ross.zwisler@linux.intel.com>
         <20180626175932.8899-2-ross.zwisler@linux.intel.com>
         <CAPcyv4iWgPnHmBKhUvhManC6UL9CkLqN_d8vBo6KmcPJdPzuUw@mail.gmail.com>
         <20180626185830.GA7171@redhat.com>
         <CAPcyv4h6HO6fs6k7QMD77jkz2djCeWCtWomCdNb0-1Q4VKanqw@mail.gmail.com>
         <20180626191346.GA7233@redhat.com>
In-Reply-To: <20180626191346.GA7233@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-originating-ip: [15.203.227.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB1011;7:hl27rCfN3XRwmN9YDwTQXdbSBQCmU7e25+axgMSRBw7pReSEdTiAxVamaYw9KFNLbx094w9qED/K72AAEoEKuYNllDYq3YjQEY2PC/Vmg4kflQoaUz/hAc6uxbaT8A30e/W5g8zniHvh3NedizzrYIjWO/U59BKaCJkor/c/Ms554GwPNPtoWTn54xsTkg4btChZxw0u7et1/Zv6/TSD754wsMcG0LF8mNgiWd9pm7AzrrAm69QBgl52HWhDX3C+
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 92d4f4c6-4c82-4963-9e6c-08d5dba6f34d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB1011;
x-ms-traffictypediagnostic: AT5PR8401MB1011:
x-microsoft-antispam-prvs: <AT5PR8401MB1011A8B9BB83751617FB8A1C82490@AT5PR8401MB1011.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(9452136761055)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AT5PR8401MB1011;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB1011;
x-forefront-prvs: 071518EF63
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(376002)(366004)(39860400002)(189003)(199004)(6246003)(2900100001)(229853002)(2906002)(99286004)(68736007)(5660300001)(6116002)(3846002)(106356001)(86362001)(66066001)(53936002)(81156014)(93886005)(81166006)(105586002)(7736002)(14454004)(305945005)(97736004)(8936002)(53546011)(186003)(486006)(6506007)(2616005)(256004)(8676002)(446003)(476003)(14444005)(11346002)(26005)(25786009)(76176011)(36756003)(478600001)(6436002)(316002)(110136005)(54906003)(103116003)(5250100002)(102836004)(6486002)(2501003)(6512007)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1011;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rZeNoRA4ayxwmI9ET0eKDa2HLh5lMib3TudNtfifSu/QMSrFCUewrWPaU4KIVW+hYxzAehQD/K7PC7VgcERwnt7n/tVYsTjGxbvms8l3QibiIN69XTa/Af09mFTeACHSIhexJYcK89nZD9PhIqEBThuUHqjw5Ei7VuhdEDRcZNRqaG1xyNOrndzsLggtMHjjdFt7K/hXZiqYeyFIguv0qY2QG2laJ+B1Ojod0TCyCKfswlyhRdHKDEPZoAY4qArQ82uzcu0KCe/Ad6FoP4G1Wn4KQhV2Ady2Tn9l/MTfIUkroe45K/K2YXa5d10i/YgbK9je+oT1Fy/wS4GAHiRLj9gwKjWFferpMWktWLe6XH8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D1889CB4901114A9FD8D1212F7DAD23@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d4f4c6-4c82-4963-9e6c-08d5dba6f34d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2018 20:54:03.4746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1011
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA2LTI2IGF0IDE1OjEzIC0wNDAwLCBNaWtlIFNuaXR6ZXIgd3JvdGU6DQo+
IE9uIFR1ZSwgSnVuIDI2IDIwMTggYXQgIDM6MDdwbSAtMDQwMCwNCj4gRGFuIFdpbGxpYW1zIDxk
YW4uai53aWxsaWFtc0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiBPbiBUdWUsIEp1biAyNiwg
MjAxOCBhdCAxMTo1OCBBTSwgTWlrZSBTbml0emVyIDxzbml0emVyQHJlZGhhdC5jb20+IHdyb3Rl
Og0KPiA+ID4gT24gVHVlLCBKdW4gMjYgMjAxOCBhdCAgMjo1MnBtIC0wNDAwLA0KPiA+ID4gRGFu
IFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4gDQo+ID4g
PiA+IE9uIFR1ZSwgSnVuIDI2LCAyMDE4IGF0IDEwOjU5IEFNLCBSb3NzIFp3aXNsZXINCj4gPiA+
ID4gPHJvc3Muendpc2xlckBsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4gPiA+IFFVRVVF
X0ZMQUdfREFYIGlzIGFuIGluZGljYXRpb24gdGhhdCBhIGdpdmVuIGJsb2NrIGRldmljZSBzdXBw
b3J0cw0KPiA+ID4gPiA+IGZpbGVzeXN0ZW0gREFYIGFuZCBzaG91bGQgbm90IGJlIHNldCBmb3Ig
UE1FTSBuYW1lc3BhY2VzIHdoaWNoIGFyZSBpbiAicmF3Ig0KPiA+ID4gPiA+IG9yICJzZWN0b3Ii
IG1vZGVzLiAgVGhlc2UgbmFtZXNwYWNlcyBsYWNrIHN0cnVjdCBwYWdlIGFuZCBhcmUgcHJldmVu
dGVkDQo+ID4gPiA+ID4gZnJvbSBwYXJ0aWNpcGF0aW5nIGluIGZpbGVzeXN0ZW0gREFYLg0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFJvc3MgWndpc2xlciA8cm9zcy56d2lz
bGVyQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+ID4gPiBTdWdnZXN0ZWQtYnk6IE1pa2UgU25pdHpl
ciA8c25pdHplckByZWRoYXQuY29tPg0KPiA+ID4gPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwu
b3JnDQo+ID4gPiA+IA0KPiA+ID4gPiBXaHkgaXMgdGhpcyBjYzogc3RhYmxlPyBXaGF0IGlzIHRo
ZSB1c2VyIHZpc2libGUgaW1wYWN0IG9mIHRoaXMgY2hhbmdlDQo+ID4gPiA+IGVzcGVjaWFsbHkg
Z2l2ZW4gdGhlIHJlcXVpcmVtZW50IHRvIHZhbGlkYXRlIFFVRVVFX0ZMQUdfREFYIHdpdGgNCj4g
PiA+ID4gYmRldl9kYXhfc3VwcG9ydGVkKCk/IFBhdGNoIGxvb2tzIGdvb2QsIGJ1dCBpdCdzIGp1
c3QgYSBjb3NtZXRpYyBmaXh1cA0KPiA+ID4gPiBhZmFpY3MuDQo+ID4gPiANCj4gPiA+IFRoaXMg
aXNuJ3QgY29zbWV0aWMgd2hlbiB5b3UgY29uc2lkZXIgdGhhdCBzdGFja2luZyB1cCBhIERNIGRl
dmljZSBpcw0KPiA+ID4gbG9va2luZyBhdCB0aGlzIGZsYWcgdG8gZGV0ZXJtaW5lIHdoZXRoZXIg
YSB0YWJsZSBkb2VzIG9yIGRvZXMgX25vdF8NCj4gPiA+IHN1cHBvcnQgREFYLg0KPiA+ID4gDQo+
ID4gPiBTbyB0aGlzIHBhdGNoLCBpbiBjb25qdW5jdGlvbiB3aXRoIHRoZSBvdGhlciBjaGFuZ2Vz
IGluIHRoZSBzZXJpZXMsIGlzDQo+ID4gPiBjZXJ0YWlubHkgc29tZXRoaW5nIEknZCBjb25zaWRl
ciBhcHByb3ByaWF0ZSBmb3Igc3RhYmxlLg0KPiA+IA0KPiA+IEkgdGhpbmsgdGhpcyBjbGFzc2lm
aWVzIGFzIHNvbWV0aGluZyB0aGF0IG5ldmVyIHdvcmtlZCBjb3JyZWN0bHkgYW5kDQo+ID4gaXMg
bm90IGEgcmVncmVzc2lvbi4gSXQgZG9lcyBub3QgaWRlbnRpZnkgd2hpY2ggY29tbWl0IGl0IGlz
IHJlcGFpcmluZw0KPiA+IG9yIHRoZSB1c2VyIHZpc2libGUgZmFpbHVyZSBtb2RlLg0KPiANCj4g
U28geW91J3JlIHRha2luZyBpc3N1ZSB3aXRoIG1ha2luZyBzdGFja2VkIGRheCBjb25maWdzIHdv
cmsgaW4gb2xkZXINCj4ga2VybmVscz8gIFRoYXQncyBmaW5lLiAgV2UgY2FuIGRyb3AgdGhlIHN0
YWJsZSBjYyBpZiB5b3UgbGlrZS4NCj4gDQo+IEJ1dCBJIG1lYW4gd2UgaW50ZW5kZWQgZm9yIHRo
aXMgdG8gd29yay4uIHNvIHRoZSBGaXhlcyBjb21taXQgcmVmZXJlbmNlcw0KPiBjYW4gZWFzaWx5
IGJlIGFkZGVkLCBlLmcuOiA1NDVlZDIwZTZkZjY4YTRkMjU4NGEyOWEyYTI4ZWU4YjJmN2U5NTQ3
DQo+ICgiZG06IGFkZCBpbmZyYXN0cnVjdHVyZSBmb3IgREFYIHN1cHBvcnQiKQ0KDQpXaGVuIHRo
aXMgZG0gY2hhbmdlIHdhcyBtYWRlLCB0aGUgcG1lbSBkcml2ZXIgc3VwcG9ydGVkIERBWCBmb3Ig
Ym90aCByYXcNCmFuZCBtZW1vcnkgbW9kZXMgKG5vdGU6IHNlY3RvciBtb2RlIGRvZXMgbm90IHVz
ZSB0aGUgcG1lbSBkcml2ZXIpLiAgSQ0KdGhpbmsgdGhlIGlzc3VlIHdhcyBpbnRyb2R1Y2VkIHdo
ZW4gd2UgZHJvcHBlZCBEQVggc3VwcG9ydCBmcm9tIHJhdw0KbW9kZS4NCg0KVGhhbmtzLA0KLVRv
c2hpDQoNCg==
