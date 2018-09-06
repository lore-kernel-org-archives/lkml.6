Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91EFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A42320652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="JQy7MaxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A42320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeIFUyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:54:02 -0400
Received: from mail-bn3nam01on0041.outbound.protection.outlook.com ([104.47.33.41]:37607
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726456AbeIFUyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTtiZyB9RLE5nOyYNLbVSzajKzlNiDgttbxuzsO1eDU=;
 b=JQy7MaxRGPUlRGDDiefX+7L46RjTKkEsbnT9cGUQf+fCxFz2/H0K/N1CqDXjipYaS/R95h6Vb7yg7kAGv/injhWt0HGKlXWoWN5Iw3qMIW627+w0V+8KBeFc1Qyfzke5lNkBlBC+6cQx5DXOGzx15D74OJlWa4mYCsZR7Fxgzlc=
Received: from BYAPR07MB5144.namprd07.prod.outlook.com (20.176.254.209) by
 BYAPR07MB5464.namprd07.prod.outlook.com (20.177.229.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Thu, 6 Sep 2018 16:17:42 +0000
Received: from BYAPR07MB5144.namprd07.prod.outlook.com
 ([fe80::581:6eee:fab6:4c99]) by BYAPR07MB5144.namprd07.prod.outlook.com
 ([fe80::581:6eee:fab6:4c99%4]) with mapi id 15.20.1122.009; Thu, 6 Sep 2018
 16:17:42 +0000
From:   Przemyslaw Gaj <pgaj@cadence.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        vitor <Vitor.Soares@synopsys.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v6 01/10] i3c: Add core I3C infrastructure
Thread-Topic: [PATCH v6 01/10] i3c: Add core I3C infrastructure
Thread-Index: AQHUH3VT99XuaYWr3kWHpjq9POOKYqTML50AgALgfQCAAFeJAIAABncAgAXdiQCAAANWgIAAMGEAgAMUiwCAAHYxAIAFiUGAgAUNtQD//+MCAIAABCaAgAABw4CAAAgjgIAABuWAgAARrACAAA2fgIAAJJ6A
Date:   Thu, 6 Sep 2018 16:17:41 +0000
Message-ID: <B6FB5A1F-EBE3-4A30-A27F-1051969F0E25@cadence.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <20180719152930.3715-2-boris.brezillon@bootlin.com>
 <d2f40cc2-b344-69d1-4314-83524ad7b178@synopsys.com>
 <20180824143934.6d6b6487@bbrezillon>
 <bdb2924f-ecfa-1da3-41db-9ac77d4d933b@synopsys.com>
 <20180824201600.7d80bca9@bbrezillon>
 <fe839027-c4d7-4d6f-412b-5b315cbc7a39@synopsys.com>
 <20180828140209.29155d00@bbrezillon>
 <4DBE768F-3CDC-41BE-9CC8-E294E7277CB1@cadence.com>
 <8abfb007-d755-36a4-5960-fddd61d04aa2@synopsys.com>
 <3D2681D9-1ACC-42FF-9FAB-D86B3C689003@cadence.com>
 <9584757a-e7e2-5bfe-fc2c-e9bc14ad65a8@synopsys.com>
 <25862F03-9823-42B0-87AC-AE36D7E9C780@cadence.com>
 <CAK8P3a3pkddD9VnogYryQKoL9Z_5qVRBXd6yr1z6CqGU692rXg@mail.gmail.com>
 <20180906151437.4259d6fc@bbrezillon> <20180906152055.5618d235@bbrezillon>
 <a08a0f8b-395b-f956-47d1-e29e0de4aae9@synopsys.com>
 <20180906161443.0f76b246@bbrezillon>
 <5a2ed122-b56f-421b-34e0-74ef551b76b8@synopsys.com>
 <20180906180643.3b1420fc@bbrezillon>
In-Reply-To: <20180906180643.3b1420fc@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pgaj@cadence.com; 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5464;20:uvQ4+6lUfvfmTcmPNP72SitmCkNwdYHl7qPnlUVe+oumd354oDVY5YsC8NaBAk6Vb7y/Ayf8vqQzw94wSUOWyJBuaGMznFVOCDGYjBpdSQXbKpn4NRzuCInQSdGtmjTc1Gm+gtGSFMdtobz3b5rGrWrAiG6mL2IOGu19ob/dPqzCviM5Ooq6VNn0vdYRy8gC7JRIL4BxqcBpJs9PEMb3MGZi7YMOmk+wc1m767ZvKhHkNyZ4XtROXztnFZM+wJUI
x-ms-office365-filtering-correlation-id: d14a1192-586d-41a3-5bfe-08d6141445ab
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5464;
x-ms-traffictypediagnostic: BYAPR07MB5464:
x-microsoft-antispam-prvs: <BYAPR07MB54648E3063DB21C79D26CDEFC2010@BYAPR07MB5464.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(60795455431006)(10436049006162)(72170088055959)(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BYAPR07MB5464;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5464;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(54014002)(199004)(189003)(52164004)(36092001)(93886005)(53546011)(6506007)(14444005)(5024004)(256004)(110136005)(36756003)(2900100001)(102836004)(54906003)(82746002)(99286004)(316002)(4326008)(486006)(11346002)(446003)(476003)(2616005)(186003)(26005)(97736004)(5660300001)(5250100002)(33656002)(3846002)(68736007)(6116002)(6246003)(25786009)(53936002)(6306002)(966005)(6436002)(8676002)(14454004)(105586002)(7736002)(8936002)(305945005)(7416002)(2906002)(66066001)(6512007)(6486002)(76176011)(83716003)(81166006)(86362001)(575784001)(478600001)(81156014)(229853002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5464;H:BYAPR07MB5144.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DuohwIBYmHFza89sZjksKWmQKq04gDOegIv33Dm7F/1bqsga/SyEu6Y0Df5AZovtSlJKNHO0q6eQuwxj4vI5KAdcHk5NPBeVljBvs7RceztREPHgUzgczbBAScCOxV/ijC5gxrBG92FoWDz+woDgoYfFo8+ODGpHuqHMvhQHhejN5mJXb8xg0eDQdPv7sonfdn1lffzkLCMRFB/M5KkhUTEU3kghNzTWCYek24edOAb+2FHvSepHhrIjwso9efIS2r1jSubNcI4ulkv+5U4x93RZOb3hXOdKPYJzfeK6e3UFJ94oHuJB8+S9L1I3WZmYcDOViSWXoMOcQ9tcWYhIt3LdLEqETbKfKbKQoFcEG8k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A558AE448C23FB49888F6D3909166BCB@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14a1192-586d-41a3-5bfe-08d6141445ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 16:17:41.9362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDkvNi8xOCwgNjowNyBQTSwgIkJvcmlzIEJyZXppbGxvbiIgPGJvcmlzLmJyZXpp
bGxvbkBib290bGluLmNvbT4gd3JvdGU6DQoNCiAgICBFWFRFUk5BTCBNQUlMDQogICAgDQogICAg
DQogICAgT24gVGh1LCA2IFNlcCAyMDE4IDE2OjE3OjU4ICswMTAwDQogICAgdml0b3IgPFZpdG9y
LlNvYXJlc0BzeW5vcHN5cy5jb20+IHdyb3RlOg0KICAgIA0KICAgID4gSGkgQm9yaXMsDQogICAg
PiANCiAgICA+IA0KICAgID4gT24gMDYtMDktMjAxOCAxNToxNCwgQm9yaXMgQnJlemlsbG9uIHdy
b3RlOg0KICAgID4gPiBPbiBUaHUsIDYgU2VwIDIwMTggMTQ6NTA6MDMgKzAxMDANCiAgICA+ID4g
dml0b3IgPFZpdG9yLlNvYXJlc0BzeW5vcHN5cy5jb20+IHdyb3RlOg0KICAgID4gPiAgDQogICAg
PiA+PiBIaSwNCiAgICA+ID4+DQogICAgPiA+Pg0KICAgID4gPj4gT24gMDYtMDktMjAxOCAxNDoy
MCwgQm9yaXMgQnJlemlsbG9uIHdyb3RlOiAgDQogICAgPiA+Pj4gT24gVGh1LCA2IFNlcCAyMDE4
IDE1OjE0OjM3ICswMjAwDQogICAgPiA+Pj4gQm9yaXMgQnJlemlsbG9uIDxib3Jpcy5icmV6aWxs
b25AYm9vdGxpbi5jb20+IHdyb3RlOg0KICAgID4gPj4+ICAgICANCiAgICA+ID4+Pj4gT24gVGh1
LCA2IFNlcCAyMDE4IDE0OjU5OjQ2ICswMjAwDQogICAgPiA+Pj4+IEFybmQgQmVyZ21hbm4gPGFy
bmRAYXJuZGIuZGU+IHdyb3RlOg0KICAgID4gPj4+PiAgICAgDQogICAgPiA+Pj4+PiBPbiBUaHUs
IFNlcCA2LCAyMDE4IGF0IDI6NDMgUE0gUHJ6ZW15c2xhdyBHYWogPHBnYWpAY2FkZW5jZS5jb20+
IHdyb3RlOiAgDQogICAgPiA+Pj4+Pj4gSGkgQm9yaXMsIFZpdG9yLA0KICAgID4gPj4+Pj4+DQog
ICAgPiA+Pj4+Pj4gVGhpcyByZXBvc2l0b3J5IGRvZXMgbm90IGNvbnRhaW4gZnVsbCBrZXJuZWwg
c291cmNlcywgYnV0IGl0IHNob3VsZCBiZSBlbm91Z2ggdG8gZGlzY3VzcyBtYXN0ZXJzaGlwIHJl
cXVlc3QgZmVhdHVyZS4NCiAgICA+ID4+Pj4+PiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2lu
dC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX2dpdGh1Yi5jb21fcHJ6ZW1la2dhal9pM2MtMkRsaW51
eF9jb21taXRfZDU0ZmU2OGE5ZDNlNTczYzBjNDU0YTJjNmYxYWZhZmMyMDE0MmVjNSZkPUR3SUNB
ZyZjPURQTDZfWF82SmtYRng3QVhXcUIwdGcmcj1xVnVVNjR1OXg3N1kwS2QwUGhES19scHhGZ2c2
UEs5UGF0ZUh3amJfRFkwJm09UTlEV3czS0dtc2hHdzBmNVFUaWZmYnBiRVN5VWxQeDZLbUFTdURC
dFg5WSZzPUhIRV95MWt5TXN6SnZQX3RTUDlKa0RsUFl4RHl3QmVId2tNR2dDUjExdUkmZT0NCiAg
ICA+ID4+Pj4+Pg0KICAgID4gPj4+Pj4+IFBsZWFzZSBrZWVwIGluIG1pbmQgdGhhdCB0aGlzIGlz
IGluaXRpYWwgdmVyc2lvbiwgYnV0IG1hc3RlcnNoaXAgd29ya3MgY29ycmVjdGx5LiBJIGFkZGVk
IG9uZSBwcm9wZXJ0eSB0byBEVCB0byByZWZsZWN0IHJlbGF0aW9uc2hpcCBiZXR3ZWVuIG1hc3Rl
cnMuDQogICAgPiA+Pj4+Pj4gSXQgaXMgcG9zc2libGUgdG8gcmVxdWVzdCBtYXN0ZXJzaGlwIG9u
IGRlbWFuZCAodXNpbmcgc3lzZnMuIFVzZWZ1bCBpbiBjYXNlIHdoZW4gTGludXggbWFjaGluZSBp
cyBlcXVpcHBlZCBvbmx5IHdpdGggc2Vjb25kYXJ5IG1hc3RlciBjb250cm9sbGVyKSBvciBhdXRv
bWF0aWNhbGx5IGNoYW5nZSBvcGVyYXRpb24gbW9kZSB3aGVuIGRldmljZSBkcml2ZXIgd2FudHMg
dG8gcmVhZC93cml0ZSBzb21ldGhpbmcgZnJvbS90byBkZXZpY2UuDQogICAgPiA+Pj4+Pj4NCiAg
ICA+ID4+Pj4+PiBJJ20gc3VyZSBJIHdpbGwgaGF2ZSB0byByZXdvcmsgc29tZXRoaW5nIGJlY2F1
c2UgdGhpcyB3YXMgaW1wbGVtZW50ZWQgb24gc291cmNlcyBmcm9tIFBBVENIIHY0LiBJIHNhdyB0
aGF0IEJvcmlzIHJlbGVhc2VkIHY3IHllc3RlcmRheSA6KSAgDQogICAgPiA+Pj4+PiBDYW4geW91
IGV4cGxhaW4gdGhlIHJlYXNvbiBmb3IgaGF2aW5nIGEgdXNlciBzcGFjZSBpbnRlcmZhY2UgYW5k
IERUIHByb3BlcnR5Pw0KICAgID4gPj4+Pj4gSSB0aG91Z2h0IHdlIGhhZCBjb25jbHVkZWQgZWFy
bGllciB0aGF0IHdlIHdvdWxkbid0IG5lZWQgdGhhdCwgYnV0IGl0J3MgcG9zc2libGUNCiAgICA+
ID4+Pj4+IHRoYXQgSSBtaXNzZWQgc29tZXRoaW5nIGluIHRoZSBkaXNjdXNzaW9uIHNpbmNlIHRo
ZW4uICANCiAgICA+ID4+Pj4gSSBkb24ndCB0aGluayB0aGUgc3lzZnMga25vYiBpcyBuZWVkZWQs
IHRoaXMgYmVpbmcgc2FpZCwgYWZ0ZXIgdGhpbmtpbmcNCiAgICA+ID4+Pj4gYSBiaXQgbW9yZSBh
Ym91dCBtYXN0ZXJzaGlwIGhhbmRvdmVyIGFuZCB0aGUgc2Vjb25kYXJ5IG1hc3RlciBjYXNlLCBJ
DQogICAgPiA+Pj4+IHRoaW5rIHdlIGhhdmUgc29tZXRoaW5nIGltcG9ydGFudCB0byBzb2x2ZS4N
CiAgICA+ID4+Pj4NCiAgICA+ID4+Pj4gV2hlbiBhIG1hc3RlciBpcyBub3QgaW4gY29udHJvbCBv
ZiB0aGUgYnVzLCBpdCBnZXRzIGluZm9ybWVkIG9mIGRldmljZXMNCiAgICA+ID4+Pj4gcHJlc2Vu
dCBvbiB0aGUgYnVzIGJ5IG1vbml0b3JpbmcgREFBIG9yIERFRlNMVlMgYnJvYWRjYXN0IGV2ZW50
cy4gVGhhdA0KICAgID4gPj4+PiBtZWFucyB0aGUgc2Vjb25kYXJ5IG1hc3RlciBzaG91bGQgcG9w
dWxhdGUgdGhlIGJ1cyB3aXRoIEkzQy9JMkMgZGV2aWNlcw0KICAgID4gPj4+PiBvbiBzdWNoIGV2
ZW50cywgYnV0IHRoYXQncyBub3QgZW5vdWdoLCBiZWNhdXNlIERFRlNMVlMvREFBIGRvIG5vdA0K
ICAgID4gPj4+PiBwcm92aWRlIGFsbCBkZXZpY2UgaW5mby5Tb21lIG9mIHRoZW0gKGxpa2UgcmVh
ZC93cml0ZS9pYmkgbGltaXRhdGlvbnMpDQogICAgPiA+Pj4+IHJlcXVpcmUgZXh0cmEgQ0NDIGNv
bW1hbmRzLCBhbmQsIHRvIHNlbmQgdGhvc2UgQ0NDIGNvbW1hbmRzLCB0aGUNCiAgICA+ID4+Pj4g
c2Vjb25kYXJ5IG1hc3RlciBtdXN0IGNsYWltIHRoZSBidXMuIFdlIGNvdWxkIGFkZCBhIGNhc2Ug
d2hlcmUgd2UNCiAgICA+ID4+Pj4gZGVjbGFyZSBkZXZpY2VzIGFzIHBhcnRpYWxseSBkaXNjb3Zl
cmVkIHVudGlsIHRoZSBtYXN0ZXIgYWNxdWlyZXMNCiAgICA+ID4+Pj4gb3duZXJzaGlwIG9mIHRo
ZSBidXMsIGJ1dCB0aGF0IG1lYW5zIHBhcnQgb2YgdGhlIGRhdGEgcmV0dXJuZWQgYnkNCiAgICA+
ID4+Pj4gaTNjX2RldmljZV9nZXRfaW5mbygpIHdpbGwgYmUgaW5hY2N1cmF0ZSwgd2hpY2ggbWln
aHQgaGF2ZSBhbiBpbXBhY3Qgb24NCiAgICA+ID4+Pj4gc29tZSBpM2MgZHJpdmVyIC0+cHJvYmUo
KSBmdW5jdGlvbnMuICANCiAgICA+ID4+PiBIbSwgb25lIHBvc3NpYmxlIHNvbHV0aW9uIHdvdWxk
IGJlIHRvIHJlZ2lzdGVyIHBhcnRpYWxseSBkaXNjb3ZlcmVkDQogICAgPiA+Pj4gZGV2aWNlcyB0
byB0aGUgZGV2aWNlIG1vZGVsIGFuZCBsZXQgaTNjX2RldmljZV9nZXRfaW5mbygpIGNsYWltIHRo
ZSBidXMNCiAgICA+ID4+PiBhbmQgcmVxdWVzdCBtaXNzaW5nIGRhdGEgd2hlbiBuZWVkZWQuIFRo
aXMgd2F5LCBpZiB0aGUgZHJpdmVyIG5lZWRzIHRvDQogICAgPiA+Pj4gY2FsbCBpM2NfZGV2aWNl
X2dldF9pbmZvKCkgaW4gaXRzIHByb2JlIHBhdGgsIGl0IHNob3VsZCB3b3JrIGp1c3QgZmluZS4g
IA0KICAgID4gPj4gV2h5IGRvbid0IHVzZSB0aGUgaTNjX21hc3Rlcl9hZGRfaTNjX2Rldl9sb2Nr
ZWQgdGhhdCBqb2I/IEl0IGNyZWF0ZSwNCiAgICA+ID4+IGF0dGFjaCBhbmQgcmV0cmlldmUgdGhl
IGRldmljZSBpbmZvLiAgDQogICAgPiA+IFdoZW4gd2lsbCB5b3UgY2FsbCBpM2NfbWFzdGVyX2Fk
ZF9pM2NfZGV2X2xvY2tlZCgpPyBBZnRlciByZWNlaXZpbmcgYQ0KICAgID4gPiBERUZTTFZTIGlu
dGVycnVwdC9ldmVudD8gV2hlbiB0aGF0IGhhcHBlbnMgeW91J3JlIG5vdCBpbiBjb250cm9sIG9m
IHRoZQ0KICAgID4gPiBidXMsIHdoaWNoIG1lYW5zIHlvdSdsbCBoYXZlIHRvIGZvcmNlIGJ1cyBv
d25lcnNoaXAgaGFuZG92ZXIuIElzIHRoaXMNCiAgICA+ID4gcmVhbGx5IHdoYXQgd2Ugd2FudD8N
CiAgICA+ID4NCiAgICA+ID4gVGhlc2UgYXJlIG5vdCByaGV0b3JpY2FsIHF1ZXN0aW9ucywgSSdt
IHJlYWxseSBhc2tpbmcgZm9yIHlvdXIgb3Bpbmlvbg0KICAgID4gPiBoZXJlLiAgDQogICAgPiBX
aGF0IEkgdW5kZXJzdGFuZCBmcm9tIGxhc3QgZGlzY3Vzc2lvbiB3YXMgdGhhdCBldmVyeSB0aW1l
IHRoYXQgZGV2aWNlIA0KICAgID4gbmVlZCB0byBkbyBzb21ldGhpbmcgKHByaXZhdGUgbWVzc2Fn
ZXMpIG9uIHRoZSBidXMgYW5kIGRvbid0IGhhdmUgdGhlIA0KICAgID4gYnVzIGNvbnRyb2wgaXQg
c2hvdWxkIGZvcmNlIG93bmVyc2hpcCBoYW5kb3Zlci4NCiAgICA+IElmIG15IHVuZGVyc3RhbmRp
bmcgaXMgY29ycmVjdCB0aGlzIGNhbiBiZSBhbHNvIGFwcGxpZWQgdG8gQ0NDIGNvbW1hbmRzLg0K
ICAgIA0KICAgIFN1cmUsIGJ1dCB0aGUgcXVlc3Rpb24gaXMgbW9yZSwgd2hlbiBkbyB3ZSB3YW50
IHRvIGRvIHRoYXQ/DQogICAgDQogICAgPiANCiAgICA+ID4gIA0KICAgID4gPj4gVGhpcyBjYW4g
YmUgdHJpZ2dlcmVkIGFmdGVyIHRoZSBzZWNvbmRhcnkgbWFzdGVyIHJlY2VpdmUgRU5FQyBNUiB1
bnRpbA0KICAgID4gPj4gdGhlbSBpcyBrZWVwIGluIHRoZSBkcml2ZXIgbWVtb3J5LiAgDQogICAg
PiA+IEJ1dCB0aGF0IG1lYW5zIG5vLW9uZSB3aWxsIGFjdHVhbGx5IHRyaWdnZXIgYSBtYXN0ZXJz
aGlwIHJlcXVlc3QsDQogICAgPiA+IGJlY2F1c2UgZGV2aWNlcyB3b24ndCBiZSByZWdpc3RlcmVk
IHVudGlsIGFsbCBpbmZvIGFyZSBhdmFpbGFibGUuIElmIHdlDQogICAgPiA+IHRha2UgdGhpcyBw
YXRoLCB3ZSBzaG91bGQgaGF2ZSBhIHdheSB0byBleHBsaWNpdGx5IHRyaWdnZXIgYSBtYXN0ZXJz
aGlwDQogICAgPiA+IHJlcXVlc3QgKHN5c2ZzIGtub2Igb3IgYW55IG90aGVyIG1lYW5zKS4gIA0K
ICAgID4gQnkgdGhlIGN1cnJlbnQgZmxvdyB0aGF0IHdlIGhhdmUgbm93LCB3ZSBlbmFibGUgdGhl
IElCSSBldmVudHMgYXQgdGhlIA0KICAgID4gZW5kIG9mIC5kb19kYWEuIEF0IHRoaXMgdGltZSB0
aGUgbWFpbiBtYXN0ZXIgYnVzIGlzIGluaXRpYWxpemVkIHdpdGggYWxsIA0KICAgID4gZGV2aWNl
cy4NCiAgICA+IA0KICAgID4gIEZyb20gdGhlIHBvaW50IG9mIHZpZXcgb2Ygc2Vjb25kYXJ5IG1h
c3RlciwgaXQgZmlyc3QgcGFydGljaXBhdGUgb24gREFBIA0KICAgID4gcHJvY2VzcywgbmV4dCBp
dCBzZW5kIGl0cyBpbmZvIChNYWluIG1hc3RlciBkbyANCiAgICA+IGkzY19tYXN0ZXJfcmV0cmll
dmVfZGV2X2luZm8oKSkgYW5kIHRoZW0gcmVjZWl2ZSBERUZTTFZTLiBJbiB0aGUgc3RhZ2UgDQog
ICAgPiBpdCBjYW5ub3QgcmVxdWVzdCB0aGUgYnVzIG1hc3RlcnNoaXAgaXQgbmVlZCB0aGUgTVIg
ZW5hYmxlLg0KICAgIA0KICAgIFlvdSBtZWFuIHRoZSBicm9hZGNhc3QgRU5FQyhNUikgZXZlbnQs
IHJpZ2h0PyBUaGVuIHllcywgdGhpcyBvbmUgaXMNCiAgICBwcm9iYWJseSBtaXNzaW5nIChvciBt
YXliZSBJIGFkZGVkIGl0IGluIHRoZSBtYXN0ZXIgY29udHJvbGxlciBkcml2ZXIsDQogICAgSSBk
b24ndCByZW1lbWJlcikuDQogICAgDQogICAgPiANCiAgICA+IFNvLCB3aGF0IEkgd291bGQgc3Vn
Z2VzdCBpcyB0byBrZWVwIERFRlNMVlMgZGF0YSBpbiBzZWNvbmRhcnkgbWFzdGVyIA0KICAgID4g
ZHJpdmVyIG1lbW9yeSAuIFdoZW4gc2Vjb25kYXJ5IG1hc3RlciByZWNlaXZlIHRoZSBNUiBlbmFi
bGUsIGl0IGNhbiBnZXQgDQogICAgPiB0aGUgYnVzIG93bmVyc2hpcCBhbmQgZG8gaTNjX21hc3Rl
cl9hZGRfaTNjX2Rldl9sb2NrZWQoKSBhbmQgZWFjaCBkZXZpY2UgDQogICAgPiBpbiBERUZTTFZT
IGNvbW1hbmQuIEFmdGVyIHRoaXMgc3RlcCBkZWxlZ2F0ZSB0aGUgYnVzIG93bmVyc2hpcCB0byB0
aGUgDQogICAgPiBtYWluIG1hc3Rlci4NCiAgICANCiAgICBUaGF0J3MgYW4gb3B0aW9uLCBpbmRl
ZWQuDQogICAgDQogICAgPiANCiAgICA+IFdoYXQgZG8geW91IHRoaW5rIGFib3V0IHRoaXM/DQog
ICAgDQogICAgU291bmRzIGxpa2UgYSBnb29kIHN0YXJ0LiBJZiBNUiBpcyByZWplY3RlZCBieSB0
aGUgbWFzdGVyLCB3ZSB3aWxsIGp1c3QNCiAgICBrZWVwIGFsbCBkZXZpY2VzIGluIGFuIHVucmVn
aXN0ZXJlZCBzdGF0ZS4gV2UgY2FuIGFsc28gYWRkIGEgc3lzZnMNCiAgICBlbnRyeSB0byBtYW51
YWxseSByZS10cmlnZ2VyIHRoaXMgb3BlcmF0aW9uIGluIGNhc2UgdGhlIGluaXRpYWwgb25lDQog
ICAgZmFpbGVkLg0KICAgIA0KVGhpcyBldmVyeXRoaW5nIHNvdW5kcyBsaWtlIG15IHByZXZpb3Vz
IHZlcnNpb24uIEVuZWMgZXZlbnQgd2FzIG1pc3NpbmcsIA0KZXZlcnl0aGluZyB3YXMgdHJpZ2dl
cmVkIG1hbnVhbGx5IGZyb20gc3lzZnMuDQoNCg==
