Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2B0C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3253627755
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3253627755
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967651AbeF1SBG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:01:06 -0400
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:30785 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965829AbeF1SBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:01:03 -0400
X-Greylist: delayed 160198 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jun 2018 14:01:02 EDT
Received: from G4W9119.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.210.20.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3426.houston.hpe.com (Postfix) with ESMTPS id 3A6265D;
        Thu, 28 Jun 2018 18:01:02 +0000 (UTC)
Received: from G9W8456.americas.hpqcorp.net (2002:10d8:a15f::10d8:a15f) by
 G4W9119.americas.hpqcorp.net (2002:10d2:14d6::10d2:14d6) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Thu, 28 Jun 2018 18:01:02 +0000
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (15.241.52.12) by
 G9W8456.americas.hpqcorp.net (16.216.161.95) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Thu, 28 Jun 2018 18:01:02 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB1252.NAMPRD84.PROD.OUTLOOK.COM (10.169.9.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.20; Thu, 28 Jun 2018 18:01:00 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8%5]) with mapi id 15.20.0906.023; Thu, 28 Jun 2018
 18:01:00 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "snitzer@redhat.com" <snitzer@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [PATCH v3 1/3] pmem: only set QUEUE_FLAG_DAX for fsdax mode
Thread-Topic: [PATCH v3 1/3] pmem: only set QUEUE_FLAG_DAX for fsdax mode
Thread-Index: AQHUDZmxPUiSRvMdYEiEXSaB5fTEZaR18wmAgAACJICAAAMCgA==
Date:   Thu, 28 Jun 2018 18:01:00 +0000
Message-ID: <1530208741.14039.314.camel@hpe.com>
References: <CAPcyv4h6HO6fs6k7QMD77jkz2djCeWCtWomCdNb0-1Q4VKanqw@mail.gmail.com>
         <20180626191346.GA7233@redhat.com> <1530046327.14039.273.camel@hpe.com>
         <CAPcyv4hP_Y3xdyCa-UkYCMJ5OtnjnkwPZDS2Z2Ge8+5ymBONwQ@mail.gmail.com>
         <1530048093.14039.286.camel@hpe.com>
         <CAPcyv4gXAC7imJs5qfsDNLeN545Rqyd2b1M9s5kr4f9y48LXgQ@mail.gmail.com>
         <1530048545.14039.288.camel@hpe.com>
         <CAPcyv4ifHX95fCM9Xj87CugwNWzgq=y-4LxPQ5L6RdjX0jdctQ@mail.gmail.com>
         <20180626220430.GA4269@linux.intel.com>
         <1530207635.14039.308.camel@hpe.com> <20180628174815.GA18768@redhat.com>
In-Reply-To: <20180628174815.GA18768@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-originating-ip: [15.219.163.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB1252;7:CjlhilhufoVwpAvl6SmLlhjcWUnaVFdPsElRsE4X2iKEIcziGjJZEwrtPsVMLc2E/XN2bhijCtCDyppcC4CoCTyYfl7QDkhpIFfFWeDNp4MQechlgTscTeYnvxCcq6475rrQJ/iasHY95JpOMjvgeb+a100a94tlNXxZlPTK7OjaCKWQZJG1TfmEFT3fwNkd4fTOfd/Gxa8CGnFufnwM87ZMVjamA4iyE+dOLS/Cj+o5l3p3BL388hccba0XJAWj
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8c433cdf-6154-49bc-7783-08d5dd211b31
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB1252;
x-ms-traffictypediagnostic: AT5PR8401MB1252:
x-microsoft-antispam-prvs: <AT5PR8401MB1252B8011484501546B9FB5A824F0@AT5PR8401MB1252.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(9452136761055)(222181515654134);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AT5PR8401MB1252;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB1252;
x-forefront-prvs: 0717E25089
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(54534003)(4326008)(2900100001)(478600001)(5660300001)(8676002)(53936002)(7736002)(36756003)(6916009)(68736007)(305945005)(2906002)(6486002)(81156014)(5250100002)(81166006)(106356001)(186003)(1730700003)(6246003)(8936002)(26005)(5640700003)(86362001)(105586002)(3846002)(6116002)(102836004)(256004)(14444005)(2501003)(25786009)(2351001)(76176011)(97736004)(53546011)(14454004)(6436002)(6506007)(66066001)(6512007)(103116003)(99286004)(2616005)(476003)(54906003)(316002)(229853002)(93886005)(11346002)(486006)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1252;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bBpf4i/32kcb9DxWCRPb4JIa3ta30JS+TTl7lonSKOHplmkIZbnEHoBdK6kSZLC4N8AdhDwP8KFC8wrUOoeZto1pFeF3qwPxSywCxQ3XB7NjoTP7vrafeGyslIcBLoUGBzdkubsr+JwsmGZArd70AjqsY41TepKTWq9uJrHScrYtqlvJmZsbqugVp9C4NuBlHOm+mfJ5FvORt6EhNd+MSOqxyFkTB5pkxKtIrIlVNGKxTy4h8E8O9g7N/2KMZT98ER/4JW7KGHcJNPAUFkvDRt6fC8nUl36qH1ulHSj/jcBCoa5XHEG5rtVuACvivN7VwBpkaktxqufN4jJPsaCTeBHAGMnpFuey1hhxbN4cY/8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <44A85094F25DD14AA2EB648AA51D10FF@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c433cdf-6154-49bc-7783-08d5dd211b31
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2018 18:01:00.1057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1252
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA2LTI4IGF0IDEzOjQ4IC0wNDAwLCBNaWtlIFNuaXR6ZXIgd3JvdGU6DQo+
IE9uIFRodSwgSnVuIDI4IDIwMTggYXQgIDE6NDJwbSAtMDQwMCwNCj4gS2FuaSwgVG9zaGkgPHRv
c2hpLmthbmlAaHBlLmNvbT4gd3JvdGU6DQo+IA0KPiA+IE9uIFR1ZSwgMjAxOC0wNi0yNiBhdCAx
NjowNCAtMDYwMCwgUm9zcyBad2lzbGVyIHdyb3RlOg0KPiA+ID4gT24gVHVlLCBKdW4gMjYsIDIw
MTggYXQgMDI6NTE6NTJQTSAtMDcwMCwgRGFuIFdpbGxpYW1zIHdyb3RlOg0KPiA+ID4gPiBPbiBU
dWUsIEp1biAyNiwgMjAxOCBhdCAyOjMxIFBNLCBLYW5pLCBUb3NoaSA8dG9zaGkua2FuaUBocGUu
Y29tPiB3cm90ZToNCj4gPiA+ID4gPiBPbiBUdWUsIDIwMTgtMDYtMjYgYXQgMTQ6MjggLTA3MDAs
IERhbiBXaWxsaWFtcyB3cm90ZToNCj4gPiA+ID4gPiA+IE9uIFR1ZSwgSnVuIDI2LCAyMDE4IGF0
IDI6MjMgUE0sIEthbmksIFRvc2hpIDx0b3NoaS5rYW5pQGhwZS5jb20+IHdyb3RlOg0KPiA+ID4g
PiA+ID4gPiBPbiBUdWUsIDIwMTgtMDYtMjYgYXQgMTQ6MDIgLTA3MDAsIERhbiBXaWxsaWFtcyB3
cm90ZToNCj4gPiA+ID4gPiA+ID4gPiBPbiBUdWUsIEp1biAyNiwgMjAxOCBhdCAxOjU0IFBNLCBL
YW5pLCBUb3NoaSA8dG9zaGkua2FuaUBocGUuY29tPiB3cm90ZToNCj4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gWy4uXQ0KPiA+ID4gPiA+ID4gPiA+ID4gV2hlbiB0aGlzIGRtIGNoYW5nZSB3YXMg
bWFkZSwgdGhlIHBtZW0gZHJpdmVyIHN1cHBvcnRlZCBEQVggZm9yIGJvdGggcmF3DQo+ID4gPiA+
ID4gPiA+ID4gPiBhbmQgbWVtb3J5IG1vZGVzIChub3RlOiBzZWN0b3IgbW9kZSBkb2VzIG5vdCB1
c2UgdGhlIHBtZW0gZHJpdmVyKS4gIEkNCj4gPiA+ID4gPiA+ID4gPiA+IHRoaW5rIHRoZSBpc3N1
ZSB3YXMgaW50cm9kdWNlZCB3aGVuIHdlIGRyb3BwZWQgREFYIHN1cHBvcnQgZnJvbSByYXcNCj4g
PiA+ID4gPiA+ID4gPiA+IG1vZGUuDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4g
U3RpbGwgREFYIHdpdGggcmF3IG1vZGUgbmV2ZXIgcmVhbGx5IHdvcmtlZCBhbnkgd2F5LiBJdCB3
YXMgYWxzbw0KPiA+ID4gPiA+ID4gPiA+IHNvbWV0aGluZyB0aGF0IHdhcyBicm9rZW4gZnJvbSBk
YXkgb25lLiBTbyB3aGF0IGhhcHBlbnMgdG8gc29tZW9uZSB3aG8NCj4gPiA+ID4gPiA+ID4gPiBo
YXBwZW5lZCB0byBhdm9pZCBhbGwgdGhlIHByb2JsZW1zIHdpdGggcGFnZS1sZXNzIERBWCBhbmQg
ZW5hYmxlZA0KPiA+ID4gPiA+ID4gPiA+IGRldmljZS1tYXBwZXIgb24gdG9wPyBUaGF0IGZhaWx1
cmUgbW9kZSBkZXRhaWwgbmVlZHMgdG8gYmUgYWRkZWQgdG8NCj4gPiA+ID4gPiA+ID4gPiB0aGlz
IGNoYW5nZWxvZyBpZiB3ZSB3YW50IHRvIHByb3Bvc2UgdGhpcyBmb3IgLXN0YWJsZS4NCj4gPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IE15IHBvaW50IGlzIHRoYXQgdGhlIGJlaGF2aW9yIHNo
b3VsZCBiZSBjb25zaXN0ZW50IGJldHdlZW4gcG1lbSBhbmQNCj4gPiA+ID4gPiA+ID4gZGV2aWNl
LW1hcHBlci4gIFdoZW4gLW8gZGF4IHN1Y2NlZWRzIG9uIGEgcG1lbSwgdGhlbiBpdCBzaG91bGQg
c3VjY2VlZA0KPiA+ID4gPiA+ID4gPiBvbiBhIGRldmljZS1tYXBwZXIgb24gdG9wIG9mIHRoYXQg
cG1lbS4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IEhhcyB0aGUgZHJvcCBvZiBkYXgg
c3VwcG9ydCBmcm9tIHJhdyBtb2RlIG1hZGUgdG8gLXN0YWJsZSBiYWNrIHRvIHRoZQ0KPiA+ID4g
PiA+ID4gPiBiYXNlbGluZSBhY2NlcHRlZCA1NDVlZDIwZTZkZjY/ICBJdCB3aWxsIGludHJvZHVj
ZSBpbmNvbnNpc3RlbmN5LA0KPiA+ID4gPiA+ID4gPiBvdGhlcndpc2UuDQo+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+IFRoYXQgY29tbWl0LCA1NjlkMDM2NWY1NzEgImRheDogcmVxdWlyZSAnc3Ry
dWN0IHBhZ2UnIGJ5IGRlZmF1bHQgZm9yDQo+ID4gPiA+ID4gPiBmaWxlc3lzdGVtIGRheCIsIGhh
cyBub3QgYmVlbiB0YWdnZWQgZm9yIC1zdGFibGUuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhl
biwgRml4ZXMgdGFnIHNob3VsZCBiZSBzZXQgdG8gNTY5ZDAzNjVmNTcxIHRvIGtlZXAgdGhlIGJl
aGF2aW9yDQo+ID4gPiA+ID4gY29uc2lzdGVudC4NCj4gPiA+ID4gDQo+ID4gPiA+IFN1cmUsIGFu
ZCB0aGUgZmFpbHVyZSBtb2RlIGlzLi4uPyBJJ20gdGhpbmtpbmcgdGhlIGNvbW1pdCBsb2cgc2hv
dWxkIHNheToNCj4gPiA+ID4gDQo+ID4gPiA+ICJTdGFydGluZyB3aXRoIGNvbW1pdCA1NjlkMDM2
NWY1NzEgImRheDogcmVxdWlyZSAnc3RydWN0IHBhZ2UnIGJ5DQo+ID4gPiA+IGRlZmF1bHQgZm9y
IGZpbGVzeXN0ZW0gZGF4IiwgZGF4IGlzIG5vIGxvbmdlciBzdXBwb3J0ZWQgZm9yIHBhZ2UtbGVz
cw0KPiA+ID4gPiBjb25maWd1cmF0aW9ucy4gSG93ZXZlciwgZGV2aWNlLW1hcHBlciBzZWVzIHRo
ZSBRVUVVRV9GTEFHX0RBWCBzdGlsbA0KPiA+ID4gPiBiZWluZyBzZXQgYW5kIGZhbHNlbHkgYXNz
dW1lcyB0aGF0IERBWCBpcyBlbmFibGVkLCB0aGlzIGxlYWRzIHRvDQo+ID4gPiA+IDxpbnNlcnQg
dXNlciB2aXNpYmxlIGZhaWx1cmUgbW9kZSBkZXRhaWxzIGhlcmU+Ig0KPiA+ID4gDQo+ID4gPiBE
YW4gaXMgY29ycmVjdCB0aGF0IHRoZXJlIGlzIG5vIHVzZXIgdmlzaWJsZSBjaGFuZ2UgZm9yIHRo
aXMuICBJdCBpcyB0aGUgcmlnaHQNCj4gPiA+IHRoaW5nIHRvIGRvIGZvciBjb25zaXN0ZW5jeSBh
bmQgc2FuaXR5LCBidXQgaXQgZG9lc24ndCBhY3R1YWxseSBoYXZlIHVzZXINCj4gPiA+IHZpc2li
bGUgYmVoYXZpb3IgdGhhdCBuZWVkcyB0byBiZSBiYWNrcG9ydGVkIHRvIHN0YWJsZS4NCj4gPiA+
IA0KPiA+ID4gVG9zaGkgaXMgY29ycmVjdCB0aGF0IHRoaXMgY2hhbmdlIGlzIG9ubHkgZm9yIHJh
dyBtb2RlIG5hbWVzcGFjZXMsIG5vdCBidHQNCj4gPiA+IG5hbWVzcGFjZXMuDQo+ID4gPiANCj4g
PiA+IEknbGwgYWRqdXN0IHRoZSBjaGFuZ2Vsb2cgYW5kIHJlbW92ZSB0aGUgc3RhYmxlIGZsYWcg
Zm9yIHY1LCBhbmQgSSdsbCBhZGQgYQ0KPiA+ID4gRml4ZXM6IHRhZyBmb3IgcGF0Y2ggMi4NCj4g
PiANCj4gPiBIaSBSb3NzLA0KPiA+IA0KPiA+IFlvdXIgcGF0Y2hlcyBsb29rIGdvb2QuICBCdXQg
SSBhbSBzdGlsbCBub3QgY2xlYXIgYWJvdXQgdGhlIEZpeGVzICYNCj4gPiBzdGFibGUgaGFuZGxp
bmcuICBUYWxraW5nIGFib3V0IHVzZXIgdmlzaWJsZSBiZWhhdmlvciwgSSBkbyBub3QgdGhpbmsg
d2UNCj4gPiBoYWQgYW55IGlzc3VlIHVudGlsIGRheCBzdXBwb3J0IHdhcyBkcm9wcGVkIGZyb20g
cmF3IG1vZGUuICBVbnRpbCB0aGVuLA0KPiA+IHRoZSBwbWVtIGRyaXZlciBzdXBwb3J0ZWQgZGF4
IGZvciBhbGwgbW9kZXMsIGFuZCB0aGUgY2hlY2sgZm9yDQo+ID4gZGlyZWN0X2FjY2VzcyB3b3Jr
ZWQuICAgIA0KPiANCj4gSSd2ZSBzdGFnZWQgdGhlIGNoYW5nZXMgdG8gc2VuZCB0byBMaW51cyBz
aG9ydGx5Lg0KPiANCj4gVGhlIGZpcnN0IHBhdGNoIGhhczoNCj4gDQo+IEZpeGVzOiA1NjlkMDM2
NWY1NzEgKCJkYXg6IHJlcXVpcmUgJ3N0cnVjdCBwYWdlJyBieSBkZWZhdWx0IGZvciBmaWxlc3lz
dGVtIGRheCIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IA0KPiBBcyB0aGF0IGlz
IHRoZSByaWdodCB0aGluZyB0byBkbyBnaXZlbiB0aGUgb3RoZXIgMiBwYXRjaGVzIGFyZSBtYXJr
ZWQNCj4gZm9yIHN0YWJsZS4gIFdlIGRvbid0IHdhbnQgdG8gaGF2ZSBhIHN0YWJsZSBrZXJuZWwg
d2l0aCB0aGUgbGFzdCAyDQo+IHBhdGNoZXMgYnV0IG5vdCB0aGUgZmlyc3QuDQoNCkFncmVlZC4N
Cg0KVGVjaG5pY2FsbHksIGFsbCAzIHBhdGNoZXMgbWF5IGhhdmUgIkZpeGVzOiA1NjlkMDM2NWY1
NzEgZGF4Li4iLCBidXQgSQ0KdGhpbmsgaGF2aW5nICJGaXhlcyA1NDVlZDIwZTZkZjYgZG0uLiIg
Zm9yIHBhdGNoIDIgJiAzIHByb3ZpZGUgYQ0KcHJvdGVjdGlvbiBpbiBjYXNlIDU2OWQwMzY1ZjU3
MSBnZXRzIGJhY2twb3J0ZWQgaW4gZnV0dXJlLg0KDQpGb3IgdGhlIHNlcmllczoNClJldmlld2Vk
LWJ5OiBUb3NoaSBLYW5pIDx0b3NoaS5rYW5pQGhwZS5jb20+DQoNClRoYW5rcywNCi1Ub3NoaQ0K
