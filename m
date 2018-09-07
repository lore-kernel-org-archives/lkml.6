Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B919C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111722075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="fr6oV7zB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111722075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeIGMbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:31:38 -0400
Received: from mail-dm3nam03on0062.outbound.protection.outlook.com ([104.47.41.62]:17073
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbeIGMbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2wGb76fBByUN527NfTxryt0YmieYWBieixRlx+pPjs=;
 b=fr6oV7zBV6RG3Rud/7mZMGCaOeYXlG9Uh6lsbbvQYfQnwh1DEc1/eoYAP2tQXessbo5R7Dy7bc8QZVJv7x0y/o25in4wg0MJ/FjWECKKkM8VVgEaQfvEAX5jstGT9nfFnvJqStw7RltYq9L2soAB6IoZHeORF3iCxqNwqQ9v3sA=
Received: from BYAPR07MB5144.namprd07.prod.outlook.com (20.176.254.209) by
 BYAPR07MB4501.namprd07.prod.outlook.com (52.135.225.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Fri, 7 Sep 2018 07:51:32 +0000
Received: from BYAPR07MB5144.namprd07.prod.outlook.com
 ([fe80::581:6eee:fab6:4c99]) by BYAPR07MB5144.namprd07.prod.outlook.com
 ([fe80::581:6eee:fab6:4c99%4]) with mapi id 15.20.1122.009; Fri, 7 Sep 2018
 07:51:31 +0000
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
Thread-Index: AQHUH3VT99XuaYWr3kWHpjq9POOKYqTML50AgALgfQCAAFeJAIAABncAgAXdiQCAAANWgIAAMGEAgAMUiwCAAHYxAIAFiUGAgAUNtQD//+MCAIAABCaAgAABw4CAAAgjgIAABuWAgAARrACAAA2fgIABKX6A
Date:   Fri, 7 Sep 2018 07:51:31 +0000
Message-ID: <192D8CFB-333F-4C9C-BAED-854F80321171@cadence.com>
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
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4501;20:T9G9jldWPE6y8TIQfPrprYvtKjKkct5YPfhAIiH9y67RtXms+uHBhhlYfb4voH7OfyhphfCTkZFgHt+Rtq8dJ4cuMvo5zXymhv1xQySAfWmQGLVMIl+mnOOPZbZHE4OfM4UTntbXaGHWrtlGFAskOqIbRKEPArZXTs7xB6MYhMs6eRUYKvYlv0Ku/koDMr2aXJ7uQbRI6EGZ1m5ojUm2UrFF/CexB1b1PGoWIN1hoErp0ChRi63fihHrGhs554Ga
x-ms-office365-filtering-correlation-id: f5834646-5294-4437-a360-08d61496ba1f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4501;
x-ms-traffictypediagnostic: BYAPR07MB4501:
x-microsoft-antispam-prvs: <BYAPR07MB45015156B2C5BBB8E83EB2D8C2000@BYAPR07MB4501.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(60795455431006)(10436049006162)(72170088055959)(166708455590820)(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:BYAPR07MB4501;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4501;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(136003)(346002)(366004)(396003)(39860400002)(199004)(54014002)(52164004)(189003)(36092001)(6512007)(6436002)(5250100002)(14444005)(5024004)(256004)(7416002)(83716003)(97736004)(2906002)(14454004)(966005)(68736007)(305945005)(6246003)(110136005)(478600001)(316002)(2900100001)(8936002)(6486002)(86362001)(575784001)(7736002)(81156014)(81166006)(54906003)(53936002)(6506007)(66066001)(6116002)(105586002)(8676002)(3846002)(4326008)(93886005)(106356001)(5660300001)(102836004)(229853002)(26005)(53546011)(186003)(76176011)(36756003)(25786009)(82746002)(99286004)(11346002)(476003)(446003)(2616005)(6306002)(486006)(33656002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4501;H:BYAPR07MB5144.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: X9t89YQyiz8IeEnn7zTMUFFtfP041NiEjTH7DCWdmhpX0MYC2b5tXiIMKDTbKCFXnNZkzXkD/5VYQHzI4HzTp4Aje/PMLjuTXnj9gaTz9U69OtliGkep2iJowMPqpMygtFmqQSAkcnkedw90xRItVu9MgxKngKs3gkk0yAR7AajgAU1w37wfYGRAyjJyQ64ckmLcO4+xpeaYEoYil6L+dR0Q+Fd4yVWvBP8iBvuX1Xf2LxNE0dYv1PQWXQJ3dzCL0bIehGfsvgaLC/xLmqNtoJWFfSEp+swRfLwuyuX4lgudUmCAJQ/R3abzALtLF8XZrU7GFliHmsVNMNyRj2yIFCaNeB+iREmu9y5u2zMEDHM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <09EB1BA493D38B4997E9FF75385877A7@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5834646-5294-4437-a360-08d61496ba1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 07:51:31.7077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4501
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsIFZpdG9yLA0KDQrvu79PbiA5LzYvMTgsIDY6MDcgUE0sICJCb3JpcyBCcmV6aWxs
b24iIDxib3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb20+IHdyb3RlOg0KDQogICAgRVhURVJOQUwg
TUFJTA0KICAgIA0KICAgIA0KICAgIE9uIFRodSwgNiBTZXAgMjAxOCAxNjoxNzo1OCArMDEwMA0K
ICAgIHZpdG9yIDxWaXRvci5Tb2FyZXNAc3lub3BzeXMuY29tPiB3cm90ZToNCiAgICANCiAgICA+
IEhpIEJvcmlzLA0KICAgID4gDQogICAgPiANCiAgICA+IE9uIDA2LTA5LTIwMTggMTU6MTQsIEJv
cmlzIEJyZXppbGxvbiB3cm90ZToNCiAgICA+ID4gT24gVGh1LCA2IFNlcCAyMDE4IDE0OjUwOjAz
ICswMTAwDQogICAgPiA+IHZpdG9yIDxWaXRvci5Tb2FyZXNAc3lub3BzeXMuY29tPiB3cm90ZToN
CiAgICA+ID4gIA0KICAgID4gPj4gSGksDQogICAgPiA+Pg0KICAgID4gPj4NCiAgICA+ID4+IE9u
IDA2LTA5LTIwMTggMTQ6MjAsIEJvcmlzIEJyZXppbGxvbiB3cm90ZTogIA0KICAgID4gPj4+IE9u
IFRodSwgNiBTZXAgMjAxOCAxNToxNDozNyArMDIwMA0KICAgID4gPj4+IEJvcmlzIEJyZXppbGxv
biA8Ym9yaXMuYnJlemlsbG9uQGJvb3RsaW4uY29tPiB3cm90ZToNCiAgICA+ID4+PiAgICAgDQog
ICAgPiA+Pj4+IE9uIFRodSwgNiBTZXAgMjAxOCAxNDo1OTo0NiArMDIwMA0KICAgID4gPj4+PiBB
cm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPiB3cm90ZToNCiAgICA+ID4+Pj4gICAgIA0KICAg
ID4gPj4+Pj4gT24gVGh1LCBTZXAgNiwgMjAxOCBhdCAyOjQzIFBNIFByemVteXNsYXcgR2FqIDxw
Z2FqQGNhZGVuY2UuY29tPiB3cm90ZTogIA0KICAgID4gPj4+Pj4+IEhpIEJvcmlzLCBWaXRvciwN
CiAgICA+ID4+Pj4+Pg0KICAgID4gPj4+Pj4+IFRoaXMgcmVwb3NpdG9yeSBkb2VzIG5vdCBjb250
YWluIGZ1bGwga2VybmVsIHNvdXJjZXMsIGJ1dCBpdCBzaG91bGQgYmUgZW5vdWdoIHRvIGRpc2N1
c3MgbWFzdGVyc2hpcCByZXF1ZXN0IGZlYXR1cmUuDQogICAgPiA+Pj4+Pj4gaHR0cHM6Ly91cmxk
ZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19naXRodWIuY29tX3ByemVt
ZWtnYWpfaTNjLTJEbGludXhfY29tbWl0X2Q1NGZlNjhhOWQzZTU3M2MwYzQ1NGEyYzZmMWFmYWZj
MjAxNDJlYzUmZD1Ed0lDQWcmYz1EUEw2X1hfNkprWEZ4N0FYV3FCMHRnJnI9cVZ1VTY0dTl4NzdZ
MEtkMFBoREtfbHB4RmdnNlBLOVBhdGVId2piX0RZMCZtPVE5RFd3M0tHbXNoR3cwZjVRVGlmZmJw
YkVTeVVsUHg2S21BU3VEQnRYOVkmcz1ISEVfeTFreU1zekp2UF90U1A5SmtEbFBZeER5d0JlSHdr
TUdnQ1IxMXVJJmU9DQogICAgPiA+Pj4+Pj4NCiAgICA+ID4+Pj4+PiBQbGVhc2Uga2VlcCBpbiBt
aW5kIHRoYXQgdGhpcyBpcyBpbml0aWFsIHZlcnNpb24sIGJ1dCBtYXN0ZXJzaGlwIHdvcmtzIGNv
cnJlY3RseS4gSSBhZGRlZCBvbmUgcHJvcGVydHkgdG8gRFQgdG8gcmVmbGVjdCByZWxhdGlvbnNo
aXAgYmV0d2VlbiBtYXN0ZXJzLg0KICAgID4gPj4+Pj4+IEl0IGlzIHBvc3NpYmxlIHRvIHJlcXVl
c3QgbWFzdGVyc2hpcCBvbiBkZW1hbmQgKHVzaW5nIHN5c2ZzLiBVc2VmdWwgaW4gY2FzZSB3aGVu
IExpbnV4IG1hY2hpbmUgaXMgZXF1aXBwZWQgb25seSB3aXRoIHNlY29uZGFyeSBtYXN0ZXIgY29u
dHJvbGxlcikgb3IgYXV0b21hdGljYWxseSBjaGFuZ2Ugb3BlcmF0aW9uIG1vZGUgd2hlbiBkZXZp
Y2UgZHJpdmVyIHdhbnRzIHRvIHJlYWQvd3JpdGUgc29tZXRoaW5nIGZyb20vdG8gZGV2aWNlLg0K
ICAgID4gPj4+Pj4+DQogICAgPiA+Pj4+Pj4gSSdtIHN1cmUgSSB3aWxsIGhhdmUgdG8gcmV3b3Jr
IHNvbWV0aGluZyBiZWNhdXNlIHRoaXMgd2FzIGltcGxlbWVudGVkIG9uIHNvdXJjZXMgZnJvbSBQ
QVRDSCB2NC4gSSBzYXcgdGhhdCBCb3JpcyByZWxlYXNlZCB2NyB5ZXN0ZXJkYXkgOikgIA0KICAg
ID4gPj4+Pj4gQ2FuIHlvdSBleHBsYWluIHRoZSByZWFzb24gZm9yIGhhdmluZyBhIHVzZXIgc3Bh
Y2UgaW50ZXJmYWNlIGFuZCBEVCBwcm9wZXJ0eT8NCiAgICA+ID4+Pj4+IEkgdGhvdWdodCB3ZSBo
YWQgY29uY2x1ZGVkIGVhcmxpZXIgdGhhdCB3ZSB3b3VsZG4ndCBuZWVkIHRoYXQsIGJ1dCBpdCdz
IHBvc3NpYmxlDQogICAgPiA+Pj4+PiB0aGF0IEkgbWlzc2VkIHNvbWV0aGluZyBpbiB0aGUgZGlz
Y3Vzc2lvbiBzaW5jZSB0aGVuLiAgDQogICAgPiA+Pj4+IEkgZG9uJ3QgdGhpbmsgdGhlIHN5c2Zz
IGtub2IgaXMgbmVlZGVkLCB0aGlzIGJlaW5nIHNhaWQsIGFmdGVyIHRoaW5raW5nDQogICAgPiA+
Pj4+IGEgYml0IG1vcmUgYWJvdXQgbWFzdGVyc2hpcCBoYW5kb3ZlciBhbmQgdGhlIHNlY29uZGFy
eSBtYXN0ZXIgY2FzZSwgSQ0KICAgID4gPj4+PiB0aGluayB3ZSBoYXZlIHNvbWV0aGluZyBpbXBv
cnRhbnQgdG8gc29sdmUuDQogICAgPiA+Pj4+DQogICAgPiA+Pj4+IFdoZW4gYSBtYXN0ZXIgaXMg
bm90IGluIGNvbnRyb2wgb2YgdGhlIGJ1cywgaXQgZ2V0cyBpbmZvcm1lZCBvZiBkZXZpY2VzDQog
ICAgPiA+Pj4+IHByZXNlbnQgb24gdGhlIGJ1cyBieSBtb25pdG9yaW5nIERBQSBvciBERUZTTFZT
IGJyb2FkY2FzdCBldmVudHMuIFRoYXQNCiAgICA+ID4+Pj4gbWVhbnMgdGhlIHNlY29uZGFyeSBt
YXN0ZXIgc2hvdWxkIHBvcHVsYXRlIHRoZSBidXMgd2l0aCBJM0MvSTJDIGRldmljZXMNCiAgICA+
ID4+Pj4gb24gc3VjaCBldmVudHMsIGJ1dCB0aGF0J3Mgbm90IGVub3VnaCwgYmVjYXVzZSBERUZT
TFZTL0RBQSBkbyBub3QNCiAgICA+ID4+Pj4gcHJvdmlkZSBhbGwgZGV2aWNlIGluZm8uU29tZSBv
ZiB0aGVtIChsaWtlIHJlYWQvd3JpdGUvaWJpIGxpbWl0YXRpb25zKQ0KICAgID4gPj4+PiByZXF1
aXJlIGV4dHJhIENDQyBjb21tYW5kcywgYW5kLCB0byBzZW5kIHRob3NlIENDQyBjb21tYW5kcywg
dGhlDQogICAgPiA+Pj4+IHNlY29uZGFyeSBtYXN0ZXIgbXVzdCBjbGFpbSB0aGUgYnVzLiBXZSBj
b3VsZCBhZGQgYSBjYXNlIHdoZXJlIHdlDQogICAgPiA+Pj4+IGRlY2xhcmUgZGV2aWNlcyBhcyBw
YXJ0aWFsbHkgZGlzY292ZXJlZCB1bnRpbCB0aGUgbWFzdGVyIGFjcXVpcmVzDQogICAgPiA+Pj4+
IG93bmVyc2hpcCBvZiB0aGUgYnVzLCBidXQgdGhhdCBtZWFucyBwYXJ0IG9mIHRoZSBkYXRhIHJl
dHVybmVkIGJ5DQogICAgPiA+Pj4+IGkzY19kZXZpY2VfZ2V0X2luZm8oKSB3aWxsIGJlIGluYWNj
dXJhdGUsIHdoaWNoIG1pZ2h0IGhhdmUgYW4gaW1wYWN0IG9uDQogICAgPiA+Pj4+IHNvbWUgaTNj
IGRyaXZlciAtPnByb2JlKCkgZnVuY3Rpb25zLiAgDQogICAgPiA+Pj4gSG0sIG9uZSBwb3NzaWJs
ZSBzb2x1dGlvbiB3b3VsZCBiZSB0byByZWdpc3RlciBwYXJ0aWFsbHkgZGlzY292ZXJlZA0KICAg
ID4gPj4+IGRldmljZXMgdG8gdGhlIGRldmljZSBtb2RlbCBhbmQgbGV0IGkzY19kZXZpY2VfZ2V0
X2luZm8oKSBjbGFpbSB0aGUgYnVzDQogICAgPiA+Pj4gYW5kIHJlcXVlc3QgbWlzc2luZyBkYXRh
IHdoZW4gbmVlZGVkLiBUaGlzIHdheSwgaWYgdGhlIGRyaXZlciBuZWVkcyB0bw0KICAgID4gPj4+
IGNhbGwgaTNjX2RldmljZV9nZXRfaW5mbygpIGluIGl0cyBwcm9iZSBwYXRoLCBpdCBzaG91bGQg
d29yayBqdXN0IGZpbmUuICANCiAgICA+ID4+IFdoeSBkb24ndCB1c2UgdGhlIGkzY19tYXN0ZXJf
YWRkX2kzY19kZXZfbG9ja2VkIHRoYXQgam9iPyBJdCBjcmVhdGUsDQogICAgPiA+PiBhdHRhY2gg
YW5kIHJldHJpZXZlIHRoZSBkZXZpY2UgaW5mby4gIA0KICAgID4gPiBXaGVuIHdpbGwgeW91IGNh
bGwgaTNjX21hc3Rlcl9hZGRfaTNjX2Rldl9sb2NrZWQoKT8gQWZ0ZXIgcmVjZWl2aW5nIGENCiAg
ICA+ID4gREVGU0xWUyBpbnRlcnJ1cHQvZXZlbnQ/IFdoZW4gdGhhdCBoYXBwZW5zIHlvdSdyZSBu
b3QgaW4gY29udHJvbCBvZiB0aGUNCiAgICA+ID4gYnVzLCB3aGljaCBtZWFucyB5b3UnbGwgaGF2
ZSB0byBmb3JjZSBidXMgb3duZXJzaGlwIGhhbmRvdmVyLiBJcyB0aGlzDQogICAgPiA+IHJlYWxs
eSB3aGF0IHdlIHdhbnQ/DQogICAgPiA+DQogICAgPiA+IFRoZXNlIGFyZSBub3QgcmhldG9yaWNh
bCBxdWVzdGlvbnMsIEknbSByZWFsbHkgYXNraW5nIGZvciB5b3VyIG9waW5pb24NCiAgICA+ID4g
aGVyZS4gIA0KICAgID4gV2hhdCBJIHVuZGVyc3RhbmQgZnJvbSBsYXN0IGRpc2N1c3Npb24gd2Fz
IHRoYXQgZXZlcnkgdGltZSB0aGF0IGRldmljZSANCiAgICA+IG5lZWQgdG8gZG8gc29tZXRoaW5n
IChwcml2YXRlIG1lc3NhZ2VzKSBvbiB0aGUgYnVzIGFuZCBkb24ndCBoYXZlIHRoZSANCiAgICA+
IGJ1cyBjb250cm9sIGl0IHNob3VsZCBmb3JjZSBvd25lcnNoaXAgaGFuZG92ZXIuDQogICAgPiBJ
ZiBteSB1bmRlcnN0YW5kaW5nIGlzIGNvcnJlY3QgdGhpcyBjYW4gYmUgYWxzbyBhcHBsaWVkIHRv
IENDQyBjb21tYW5kcy4NCiAgICANCiAgICBTdXJlLCBidXQgdGhlIHF1ZXN0aW9uIGlzIG1vcmUs
IHdoZW4gZG8gd2Ugd2FudCB0byBkbyB0aGF0Pw0KICAgIA0KICAgID4gDQogICAgPiA+ICANCiAg
ICA+ID4+IFRoaXMgY2FuIGJlIHRyaWdnZXJlZCBhZnRlciB0aGUgc2Vjb25kYXJ5IG1hc3RlciBy
ZWNlaXZlIEVORUMgTVIgdW50aWwNCiAgICA+ID4+IHRoZW0gaXMga2VlcCBpbiB0aGUgZHJpdmVy
IG1lbW9yeS4gIA0KICAgID4gPiBCdXQgdGhhdCBtZWFucyBuby1vbmUgd2lsbCBhY3R1YWxseSB0
cmlnZ2VyIGEgbWFzdGVyc2hpcCByZXF1ZXN0LA0KICAgID4gPiBiZWNhdXNlIGRldmljZXMgd29u
J3QgYmUgcmVnaXN0ZXJlZCB1bnRpbCBhbGwgaW5mbyBhcmUgYXZhaWxhYmxlLiBJZiB3ZQ0KICAg
ID4gPiB0YWtlIHRoaXMgcGF0aCwgd2Ugc2hvdWxkIGhhdmUgYSB3YXkgdG8gZXhwbGljaXRseSB0
cmlnZ2VyIGEgbWFzdGVyc2hpcA0KICAgID4gPiByZXF1ZXN0IChzeXNmcyBrbm9iIG9yIGFueSBv
dGhlciBtZWFucykuICANCiAgICA+IEJ5IHRoZSBjdXJyZW50IGZsb3cgdGhhdCB3ZSBoYXZlIG5v
dywgd2UgZW5hYmxlIHRoZSBJQkkgZXZlbnRzIGF0IHRoZSANCiAgICA+IGVuZCBvZiAuZG9fZGFh
LiBBdCB0aGlzIHRpbWUgdGhlIG1haW4gbWFzdGVyIGJ1cyBpcyBpbml0aWFsaXplZCB3aXRoIGFs
bCANCiAgICA+IGRldmljZXMuDQogICAgPiANCiAgICA+ICBGcm9tIHRoZSBwb2ludCBvZiB2aWV3
IG9mIHNlY29uZGFyeSBtYXN0ZXIsIGl0IGZpcnN0IHBhcnRpY2lwYXRlIG9uIERBQSANCiAgICA+
IHByb2Nlc3MsIG5leHQgaXQgc2VuZCBpdHMgaW5mbyAoTWFpbiBtYXN0ZXIgZG8gDQogICAgPiBp
M2NfbWFzdGVyX3JldHJpZXZlX2Rldl9pbmZvKCkpIGFuZCB0aGVtIHJlY2VpdmUgREVGU0xWUy4g
SW4gdGhlIHN0YWdlIA0KICAgID4gaXQgY2Fubm90IHJlcXVlc3QgdGhlIGJ1cyBtYXN0ZXJzaGlw
IGl0IG5lZWQgdGhlIE1SIGVuYWJsZS4NCiAgICANCiAgICBZb3UgbWVhbiB0aGUgYnJvYWRjYXN0
IEVORUMoTVIpIGV2ZW50LCByaWdodD8gVGhlbiB5ZXMsIHRoaXMgb25lIGlzDQogICAgcHJvYmFi
bHkgbWlzc2luZyAob3IgbWF5YmUgSSBhZGRlZCBpdCBpbiB0aGUgbWFzdGVyIGNvbnRyb2xsZXIg
ZHJpdmVyLA0KICAgIEkgZG9uJ3QgcmVtZW1iZXIpLg0KICAgIA0KICAgID4gDQogICAgPiBTbywg
d2hhdCBJIHdvdWxkIHN1Z2dlc3QgaXMgdG8ga2VlcCBERUZTTFZTIGRhdGEgaW4gc2Vjb25kYXJ5
IG1hc3RlciANCiAgICA+IGRyaXZlciBtZW1vcnkgLiBXaGVuIHNlY29uZGFyeSBtYXN0ZXIgcmVj
ZWl2ZSB0aGUgTVIgZW5hYmxlLCBpdCBjYW4gZ2V0IA0KICAgID4gdGhlIGJ1cyBvd25lcnNoaXAg
YW5kIGRvIGkzY19tYXN0ZXJfYWRkX2kzY19kZXZfbG9ja2VkKCkgYW5kIGVhY2ggZGV2aWNlIA0K
ICAgID4gaW4gREVGU0xWUyBjb21tYW5kLiBBZnRlciB0aGlzIHN0ZXAgZGVsZWdhdGUgdGhlIGJ1
cyBvd25lcnNoaXAgdG8gdGhlIA0KICAgID4gbWFpbiBtYXN0ZXIuDQogICAgDQogICAgVGhhdCdz
IGFuIG9wdGlvbiwgaW5kZWVkLg0KICAgIA0KICAgID4gDQogICAgPiBXaGF0IGRvIHlvdSB0aGlu
ayBhYm91dCB0aGlzPw0KICAgIA0KICAgIFNvdW5kcyBsaWtlIGEgZ29vZCBzdGFydC4gSWYgTVIg
aXMgcmVqZWN0ZWQgYnkgdGhlIG1hc3Rlciwgd2Ugd2lsbCBqdXN0DQogICAga2VlcCBhbGwgZGV2
aWNlcyBpbiBhbiB1bnJlZ2lzdGVyZWQgc3RhdGUuIFdlIGNhbiBhbHNvIGFkZCBhIHN5c2ZzDQog
ICAgZW50cnkgdG8gbWFudWFsbHkgcmUtdHJpZ2dlciB0aGlzIG9wZXJhdGlvbiBpbiBjYXNlIHRo
ZSBpbml0aWFsIG9uZQ0KICAgIGZhaWxlZC4NCiAgICANCkkgZm91bmQgdGhhdCB2ZXJzaW9uLiBJ
IGFkZGVkIGFsc28gbWFzdGVyc2hpcCByZXF1ZXN0IGFmdGVyIEVORUMoTVIpIGV2ZW50IHRvIHJ1
bg0KdGVzdHMgYW5kIHZlcmlmeSBpZiBldmVyeXRoaW5nIHdvcmtzIGNvcnJlY3RseS4gSXQgbG9v
a2VkIHF1aXRlIHNpbXBsZS4gU2Vjb25kYXJ5IG1hc3Rlcg0KZG9lcyBub3QgZ2l2ZSBjb250cm9s
IGJhY2sgYXV0b21hdGljYWxseSBhZnRlciBidXMgaW5pdGlhbGl6YXRpb24gYW5kIG1hc3RlciBk
b2Vzbid0DQp5ZXQgcmVxdWVzdCBtYXN0ZXJzaGlwIHdoZW4gZGV2aWNlIGRyaXZlciB3YW50cyB0
byB1c2UgdGhlIGJ1cyAvIHRyYW5zZmVyIGRhdGEuDQoNClRoaXMgY2FuIGJlIHRoZSBiYXNlIGZv
ciBmdXJ0aGVyIHdvcmtzLg0KaHR0cHM6Ly9naXRodWIuY29tL3ByemVtZWtnYWovaTNjLWxpbnV4
L3RyZWUvbWFzdGVyc2hpcF90YWtlb3Zlcg0KDQpSZWdhcmRzLA0KUHJ6ZW1law0KDQo=
