Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEE2C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20F526F7A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20F526F7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbeFZVXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:23:36 -0400
Received: from g9t5008.houston.hpe.com ([15.241.48.72]:59362 "EHLO
        g9t5008.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbeFZVXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:23:33 -0400
X-Greylist: delayed 1746 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Jun 2018 17:23:33 EDT
Received: from G9W8453.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.216.160.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5008.houston.hpe.com (Postfix) with ESMTPS id 7C28D57;
        Tue, 26 Jun 2018 21:23:32 +0000 (UTC)
Received: from G2W6310.americas.hpqcorp.net (2002:10c5:4034::10c5:4034) by
 G9W8453.americas.hpqcorp.net (2002:10d8:a0d3::10d8:a0d3) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 26 Jun 2018 21:23:32 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (15.241.52.12) by
 G2W6310.americas.hpqcorp.net (16.197.64.52) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 26 Jun 2018 21:23:32 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB0817.NAMPRD84.PROD.OUTLOOK.COM (10.169.6.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.21; Tue, 26 Jun 2018 21:23:30 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8%5]) with mapi id 15.20.0906.018; Tue, 26 Jun 2018
 21:23:30 +0000
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
Thread-Index: AQHUDXd4PTx+x6DffESqIaVXKnR6dKRy4tKAgAABlwCAAAKPAIAAAbUAgAAbeoCAAAMKgIAABTCA
Date:   Tue, 26 Jun 2018 21:23:29 +0000
Message-ID: <1530048093.14039.286.camel@hpe.com>
References: <20180626175932.8899-1-ross.zwisler@linux.intel.com>
         <20180626175932.8899-2-ross.zwisler@linux.intel.com>
         <CAPcyv4iWgPnHmBKhUvhManC6UL9CkLqN_d8vBo6KmcPJdPzuUw@mail.gmail.com>
         <20180626185830.GA7171@redhat.com>
         <CAPcyv4h6HO6fs6k7QMD77jkz2djCeWCtWomCdNb0-1Q4VKanqw@mail.gmail.com>
         <20180626191346.GA7233@redhat.com> <1530046327.14039.273.camel@hpe.com>
         <CAPcyv4hP_Y3xdyCa-UkYCMJ5OtnjnkwPZDS2Z2Ge8+5ymBONwQ@mail.gmail.com>
In-Reply-To: <CAPcyv4hP_Y3xdyCa-UkYCMJ5OtnjnkwPZDS2Z2Ge8+5ymBONwQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-originating-ip: [15.203.227.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0817;7:+ibLl4/9ugPvYj6mcga3T828s2u88Fb2wapIijft60f8RgHYIR/14twqTsArGvF2CJiGJ+Mna7GWNcH2k4KtoEu/CWI094gTvu6bKJpX+Ux+n696ADydulQHMhZ0Z8Cy2rPrfysG76LThxi50IIpdwgjACbHXl5+mBNNyJgMC/m3QcpFj0tSEYvuQ2dUv89rNPU0uY/nkN+xazvRvUMjBUAzKIDMWjrXWn3YrsGcOr+WW244YZdj4qOQe4T/wLjW
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cbfc2e48-f58e-4a0d-7dd6-08d5dbab1033
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0817;
x-ms-traffictypediagnostic: AT5PR8401MB0817:
x-microsoft-antispam-prvs: <AT5PR8401MB0817940508B9210E0154B42D82490@AT5PR8401MB0817.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(9452136761055)(222181515654134)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AT5PR8401MB0817;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0817;
x-forefront-prvs: 071518EF63
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(346002)(376002)(396003)(199004)(189003)(54534003)(36756003)(6506007)(103116003)(2906002)(25786009)(53546011)(68736007)(4326008)(5660300001)(105586002)(106356001)(86362001)(6246003)(76176011)(256004)(14444005)(6916009)(99286004)(7736002)(26005)(186003)(97736004)(305945005)(102836004)(5640700003)(2616005)(316002)(8936002)(93886005)(14454004)(478600001)(6486002)(446003)(6436002)(2351001)(81156014)(11346002)(81166006)(2501003)(54906003)(5250100002)(8676002)(486006)(6512007)(53936002)(229853002)(66066001)(6116002)(2900100001)(3846002)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0817;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ywvwynNPMl+rmJ0cBpy9ZC9oSTREAE6yDoDUNQS1zUZJiE9UlsbtJKketpXYHJbU+7zPbgolwsmoYN4xDq/Dm0Db1OBaX3I0p4c4hQxMwxq0E8qOtz8469LacT9AcWsjsHtg03/clp0iP9Op2CHOZLNKSpP8FJGikD03D1pM6fPKcnLw20m96dpmfOocO3f2xm97rkb04qI5bKQN/I51fwPHxVLR1guCt8N0sQleo6aA2eqBf7ctkzlnADKKNslGwzjoZhZUpmwRfOWZC3cFRgxVPeWU+QhE9q77nimdJGNA43pXSkbpPEGXhYrdbqxVY8aknIlOy/cEFjN5XUuDFyEyBo+YFqqNi2jHEbm7Mz0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <75043E6597155E4E8B827A7631A8CDEC@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cbfc2e48-f58e-4a0d-7dd6-08d5dbab1033
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2018 21:23:29.9953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0817
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA2LTI2IGF0IDE0OjAyIC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IE9uIFR1ZSwgSnVuIDI2LCAyMDE4IGF0IDE6NTQgUE0sIEthbmksIFRvc2hpIDx0b3NoaS5rYW5p
QGhwZS5jb20+IHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAxOC0wNi0yNiBhdCAxNToxMyAtMDQwMCwg
TWlrZSBTbml0emVyIHdyb3RlOg0KPiA+ID4gT24gVHVlLCBKdW4gMjYgMjAxOCBhdCAgMzowN3Bt
IC0wNDAwLA0KPiA+ID4gRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+IHdy
b3RlOg0KPiA+ID4gDQo+ID4gPiA+IE9uIFR1ZSwgSnVuIDI2LCAyMDE4IGF0IDExOjU4IEFNLCBN
aWtlIFNuaXR6ZXIgPHNuaXR6ZXJAcmVkaGF0LmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gT24gVHVl
LCBKdW4gMjYgMjAxOCBhdCAgMjo1MnBtIC0wNDAwLA0KPiA+ID4gPiA+IERhbiBXaWxsaWFtcyA8
ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
IE9uIFR1ZSwgSnVuIDI2LCAyMDE4IGF0IDEwOjU5IEFNLCBSb3NzIFp3aXNsZXINCj4gPiA+ID4g
PiA+IDxyb3NzLnp3aXNsZXJAbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4g
UVVFVUVfRkxBR19EQVggaXMgYW4gaW5kaWNhdGlvbiB0aGF0IGEgZ2l2ZW4gYmxvY2sgZGV2aWNl
IHN1cHBvcnRzDQo+ID4gPiA+ID4gPiA+IGZpbGVzeXN0ZW0gREFYIGFuZCBzaG91bGQgbm90IGJl
IHNldCBmb3IgUE1FTSBuYW1lc3BhY2VzIHdoaWNoIGFyZSBpbiAicmF3Ig0KPiA+ID4gPiA+ID4g
PiBvciAic2VjdG9yIiBtb2Rlcy4gIFRoZXNlIG5hbWVzcGFjZXMgbGFjayBzdHJ1Y3QgcGFnZSBh
bmQgYXJlIHByZXZlbnRlZA0KPiA+ID4gPiA+ID4gPiBmcm9tIHBhcnRpY2lwYXRpbmcgaW4gZmls
ZXN5c3RlbSBEQVguDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBSb3NzIFp3aXNsZXIgPHJvc3Muendpc2xlckBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiA+ID4g
PiA+IFN1Z2dlc3RlZC1ieTogTWlrZSBTbml0emVyIDxzbml0emVyQHJlZGhhdC5jb20+DQo+ID4g
PiA+ID4gPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+IFdoeSBpcyB0aGlzIGNjOiBzdGFibGU/IFdoYXQgaXMgdGhlIHVzZXIgdmlzaWJsZSBp
bXBhY3Qgb2YgdGhpcyBjaGFuZ2UNCj4gPiA+ID4gPiA+IGVzcGVjaWFsbHkgZ2l2ZW4gdGhlIHJl
cXVpcmVtZW50IHRvIHZhbGlkYXRlIFFVRVVFX0ZMQUdfREFYIHdpdGgNCj4gPiA+ID4gPiA+IGJk
ZXZfZGF4X3N1cHBvcnRlZCgpPyBQYXRjaCBsb29rcyBnb29kLCBidXQgaXQncyBqdXN0IGEgY29z
bWV0aWMgZml4dXANCj4gPiA+ID4gPiA+IGFmYWljcy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBU
aGlzIGlzbid0IGNvc21ldGljIHdoZW4geW91IGNvbnNpZGVyIHRoYXQgc3RhY2tpbmcgdXAgYSBE
TSBkZXZpY2UgaXMNCj4gPiA+ID4gPiBsb29raW5nIGF0IHRoaXMgZmxhZyB0byBkZXRlcm1pbmUg
d2hldGhlciBhIHRhYmxlIGRvZXMgb3IgZG9lcyBfbm90Xw0KPiA+ID4gPiA+IHN1cHBvcnQgREFY
Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFNvIHRoaXMgcGF0Y2gsIGluIGNvbmp1bmN0aW9uIHdp
dGggdGhlIG90aGVyIGNoYW5nZXMgaW4gdGhlIHNlcmllcywgaXMNCj4gPiA+ID4gPiBjZXJ0YWlu
bHkgc29tZXRoaW5nIEknZCBjb25zaWRlciBhcHByb3ByaWF0ZSBmb3Igc3RhYmxlLg0KPiA+ID4g
PiANCj4gPiA+ID4gSSB0aGluayB0aGlzIGNsYXNzaWZpZXMgYXMgc29tZXRoaW5nIHRoYXQgbmV2
ZXIgd29ya2VkIGNvcnJlY3RseSBhbmQNCj4gPiA+ID4gaXMgbm90IGEgcmVncmVzc2lvbi4gSXQg
ZG9lcyBub3QgaWRlbnRpZnkgd2hpY2ggY29tbWl0IGl0IGlzIHJlcGFpcmluZw0KPiA+ID4gPiBv
ciB0aGUgdXNlciB2aXNpYmxlIGZhaWx1cmUgbW9kZS4NCj4gPiA+IA0KPiA+ID4gU28geW91J3Jl
IHRha2luZyBpc3N1ZSB3aXRoIG1ha2luZyBzdGFja2VkIGRheCBjb25maWdzIHdvcmsgaW4gb2xk
ZXINCj4gPiA+IGtlcm5lbHM/ICBUaGF0J3MgZmluZS4gIFdlIGNhbiBkcm9wIHRoZSBzdGFibGUg
Y2MgaWYgeW91IGxpa2UuDQo+ID4gPiANCj4gPiA+IEJ1dCBJIG1lYW4gd2UgaW50ZW5kZWQgZm9y
IHRoaXMgdG8gd29yay4uIHNvIHRoZSBGaXhlcyBjb21taXQgcmVmZXJlbmNlcw0KPiA+ID4gY2Fu
IGVhc2lseSBiZSBhZGRlZCwgZS5nLjogNTQ1ZWQyMGU2ZGY2OGE0ZDI1ODRhMjlhMmEyOGVlOGIy
ZjdlOTU0Nw0KPiA+ID4gKCJkbTogYWRkIGluZnJhc3RydWN0dXJlIGZvciBEQVggc3VwcG9ydCIp
DQo+ID4gDQo+ID4gV2hlbiB0aGlzIGRtIGNoYW5nZSB3YXMgbWFkZSwgdGhlIHBtZW0gZHJpdmVy
IHN1cHBvcnRlZCBEQVggZm9yIGJvdGggcmF3DQo+ID4gYW5kIG1lbW9yeSBtb2RlcyAobm90ZTog
c2VjdG9yIG1vZGUgZG9lcyBub3QgdXNlIHRoZSBwbWVtIGRyaXZlcikuICBJDQo+ID4gdGhpbmsg
dGhlIGlzc3VlIHdhcyBpbnRyb2R1Y2VkIHdoZW4gd2UgZHJvcHBlZCBEQVggc3VwcG9ydCBmcm9t
IHJhdw0KPiA+IG1vZGUuDQo+IA0KPiBTdGlsbCBEQVggd2l0aCByYXcgbW9kZSBuZXZlciByZWFs
bHkgd29ya2VkIGFueSB3YXkuIEl0IHdhcyBhbHNvDQo+IHNvbWV0aGluZyB0aGF0IHdhcyBicm9r
ZW4gZnJvbSBkYXkgb25lLiBTbyB3aGF0IGhhcHBlbnMgdG8gc29tZW9uZSB3aG8NCj4gaGFwcGVu
ZWQgdG8gYXZvaWQgYWxsIHRoZSBwcm9ibGVtcyB3aXRoIHBhZ2UtbGVzcyBEQVggYW5kIGVuYWJs
ZWQNCj4gZGV2aWNlLW1hcHBlciBvbiB0b3A/IFRoYXQgZmFpbHVyZSBtb2RlIGRldGFpbCBuZWVk
cyB0byBiZSBhZGRlZCB0bw0KPiB0aGlzIGNoYW5nZWxvZyBpZiB3ZSB3YW50IHRvIHByb3Bvc2Ug
dGhpcyBmb3IgLXN0YWJsZS4NCg0KTXkgcG9pbnQgaXMgdGhhdCB0aGUgYmVoYXZpb3Igc2hvdWxk
IGJlIGNvbnNpc3RlbnQgYmV0d2VlbiBwbWVtIGFuZA0KZGV2aWNlLW1hcHBlci4gIFdoZW4gLW8g
ZGF4IHN1Y2NlZWRzIG9uIGEgcG1lbSwgdGhlbiBpdCBzaG91bGQgc3VjY2VlZA0Kb24gYSBkZXZp
Y2UtbWFwcGVyIG9uIHRvcCBvZiB0aGF0IHBtZW0uDQoNCkhhcyB0aGUgZHJvcCBvZiBkYXggc3Vw
cG9ydCBmcm9tIHJhdyBtb2RlIG1hZGUgdG8gLXN0YWJsZSBiYWNrIHRvIHRoZQ0KYmFzZWxpbmUg
YWNjZXB0ZWQgNTQ1ZWQyMGU2ZGY2PyAgSXQgd2lsbCBpbnRyb2R1Y2UgaW5jb25zaXN0ZW5jeSwN
Cm90aGVyd2lzZS4NCg0KVGhhbmtzLA0KLVRvc2hpDQoNCg0KIA0KDQoNCg==
