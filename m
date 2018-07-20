Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F05FECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF47F206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="gN4vC/7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF47F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbeGTOp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:45:57 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:17087 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728362AbeGTOp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:45:57 -0400
Received: from unknown (HELO relmlir4.idc.renesas.com) ([10.200.68.154])
  by relmlie3.idc.renesas.com with ESMTP; 20 Jul 2018 22:57:29 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir4.idc.renesas.com (Postfix) with ESMTP id 36B448C6B5;
        Fri, 20 Jul 2018 22:57:29 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,379,1526310000"; 
   d="scan'208";a="287435351"
Received: from mail-os2jpn01lp0144.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.144])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2018 22:57:28 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEn/PtpUBlIZJ59EnlMkicP15Dk/Rc4ePmogl9SR760=;
 b=gN4vC/7cumUVl8uSdsbBmWJ5SLHg2ruR+I9OovIzz84wk7I/QPZNGrX385KwbtQGpGBTzfSXQj0YJoctPjb19XKOJUHWl2JjDigPJaxgD0aVEww2og1N3Cpng+Dm0jhxBRzXASe1RKWUihDLvUcwDOHSX6Ha+8heqC/I1SPZsZ8=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB0841.jpnprd01.prod.outlook.com (10.167.159.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Fri, 20 Jul 2018 13:57:23 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::3133:4289:d2fa:48f8]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::3133:4289:d2fa:48f8%3]) with mapi id 15.20.0973.018; Fri, 20 Jul 2018
 13:57:23 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Simon Horman <horms@verge.net.au>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] clk: renesas: r9a06g032: Avoid needless probe deferring
Thread-Topic: [PATCH] clk: renesas: r9a06g032: Avoid needless probe deferring
Thread-Index: AQHUHqR4ngr277zL6E6HaJ4wGORD/aSX+jGAgAABQRCAAA0ggIAAAshQgAAFSACAABH3MA==
Date:   Fri, 20 Jul 2018 13:57:22 +0000
Message-ID: <TY1PR01MB176963BDA18D948161AAD264F5510@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1531924476-23261-1-git-send-email-phil.edworthy@renesas.com>
 <CAMuHMdVEgj7kJFxNuR8w468FoGRaP_mEDv6JqB_7deuQjsed_Q@mail.gmail.com>
 <TY1PR01MB1769588F9C53755C0FD56D98F5510@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <CAMuHMdWqdg9KV4h_U-VZGVdOL6upUpDgqO7kwQh8tFQjDFh-Ug@mail.gmail.com>
 <TY1PR01MB17697FBCBDC6296E7B2589C9F5510@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <CAMuHMdVMGWWcFZvjgBWZAabxWXdtBeH4XLYaXZVkQ=rOaeCH0g@mail.gmail.com>
In-Reply-To: <CAMuHMdVMGWWcFZvjgBWZAabxWXdtBeH4XLYaXZVkQ=rOaeCH0g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0841;20:Eyi0YOF+/XJvnZF/2+uvi6lTKvofNz2T1uCDpUeG0HBnt/O6ntCbc9PaKr+rV7yQj5uNPxDL9HtfztzRYQCt+fObDO04a4j3aIcqemdQJCSygzO/ZUSBnZyiEoA+65hK2Wzwf394wFbgBKf9hHOF/uIY/EYp441IE0L+H/j9v3o=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c533bf53-f0b3-4a4f-db39-08d5ee48b7c3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0841;
x-ms-traffictypediagnostic: TY1PR01MB0841:
x-microsoft-antispam-prvs: <TY1PR01MB084171409F9A99B9E6423AE9F5510@TY1PR01MB0841.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB0841;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0841;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(366004)(39860400002)(199004)(189003)(6916009)(7696005)(76176011)(74316002)(6436002)(446003)(11346002)(186003)(25786009)(53936002)(316002)(229853002)(7736002)(6246003)(54906003)(305945005)(4326008)(33656002)(2900100001)(93886005)(8676002)(478600001)(99286004)(8936002)(106356001)(6506007)(105586002)(53546011)(81156014)(81166006)(2906002)(9686003)(102836004)(44832011)(6116002)(3846002)(55016002)(14454004)(86362001)(5250100002)(26005)(68736007)(476003)(66066001)(486006)(256004)(14444005)(97736004)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0841;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ByTH0zP6jhGxyL+f8wLu+ugAczSl/R6OF3AcSvMWeTbxaouDMvs33Lb0v8V5kYCa/CvI9e2436/zGuwmCoVuZZh61IOQ0VRw+OS8d6Gb8zA084okaTfSgidD9S2GJ9Tnnm+giYNYXQFL01iUTSv4aWBSU0z9YJiY5MBajiABHzrMs1D2VFu0pF4h2OJX3AZvkgEKepGeObl4LtCD6QBOxWwPbTSyvrnIz8yreaHXfl/wP82F4pfXprKg97BnweZt8KO8loNSE4z8i5+0beu5G0GfBPInhLGnWgFACw+6fKeeOSih8stXMJSifJkCM1EuGuhONCT0+WgU5/4gaFRxpNsZeWtuAi9nn0eRcRHC+mk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c533bf53-f0b3-4a4f-db39-08d5ee48b7c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 13:57:22.7321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0841
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIDIwIEp1bHkgMjAxOCAxMzo0MSwgR2VlcnQgVXl0dGVyaG9ldmVuIHdy
b3RlOg0KPiBPbiBGcmksIEp1bCAyMCwgMjAxOCBhdCAyOjI2IFBNIFBoaWwgRWR3b3J0aHkgd3Jv
dGU6DQo+ID4gT24gMjAgSnVseSAyMDE4IDEzOjEyLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6
DQo+ID4gPiBPbiBGcmksIEp1bCAyMCwgMjAxOCBhdCAyOjA2IFBNIFBoaWwgRWR3b3J0aHkgIHdy
b3RlOg0KPiA+ID4gPiBPbiAyMCBKdWx5IDIwMTggMTI6MjEsIEdlZXJ0IFV5dHRlcmhvZXZlbiB3
cm90ZToNCj4gPiA+ID4gPiBPbiBXZWQsIEp1bCAxOCwgMjAxOCBhdCA0OjM0IFBNIFBoaWwgRWR3
b3J0aHkgd3JvdGU6DQo+ID4gPiA+ID4gPiBUbyBhdm9pZCBhbGwgU29DIHBlcmlwaGVyYWwgZHJp
dmVycyBkZWZlcnJpbmcgdGhlaXIgcHJvYmVzLA0KPiA+ID4gPiA+ID4gYm90aCBjbG9jayBhbmQg
cGluY3RybCBkcml2ZXJzIHNob3VsZCBhbHJlYWR5IGJlIHByb2JlZC4gU2luY2UNCj4gPiA+ID4g
PiA+IHRoZSBwaW5jdHJsIGRyaXZlciByZXF1aXJlcyBhIGNsb2NrIHRvIGFjY2VzcyB0aGUgcmVn
aXN0ZXJzLA0KPiA+ID4gPiA+ID4gdGhlIGNsb2NrIGRyaXZlciBzaG91bGQgYmUgcHJvYmVkIGJl
Zm9yZSB0aGUgcGluY3RybCBkcml2ZXIuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gVGhlcmVm
b3JlLCBtb3ZlIHRoZSBjbG9jayBkcml2ZXIgZnJvbSBzdWJzeXNfaW5pdGNhbGwgdG8NCj4gY29y
ZV9pbml0Y2FsbC4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBQaGls
IEVkd29ydGh5IDxwaGlsLmVkd29ydGh5QHJlbmVzYXMuY29tPg0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiA+ID4gPiBUaGFua3MgZm9yIHlvdXIgcmV2aWV3
IQ0KPiA+ID4gPg0KPiA+ID4gPiA+IFRoZSAobm90IHlldCB1cHN0cmVhbWVkKSBwaW5jdHJsIGRy
aXZlciB1c2VzIHBvc3Rjb3JlX2luaXRjYWxsKCksIHJpZ2h0Pw0KPiA+ID4gPiBObywgdGhlIHBp
bmN0cmwgZHJpdmVyIHVzZXMgc3Vic3lzX2luaXRjYWxsLCBidXQgcG9zdGNvcmVfaW5pdGNhbGwN
Cj4gPiA+ID4gb3IgYXJjaF9pbml0Y2FsbCBtYXkgYmUgYmV0dGVyIHRvIG1ha2UgaXQgY2xlYXIg
YWJvdXQgdGhlIGRlcGVuZGVuY2llcy4NCj4gPiA+DQo+ID4gPiBpZiB0aGUgcGluY3RybCBkcml2
ZXIgdXNlcyBzdWJzeXNfaW5pdGNhbGwoKSwgLi4uDQo+IA0KPiA+ID4gPiA+ID4gLXN1YnN5c19p
bml0Y2FsbChyOWEwNmcwMzJfY2xvY2tzX2luaXQpOw0KPiA+ID4gPiA+ID4gK2NvcmVfaW5pdGNh
bGwocjlhMDZnMDMyX2Nsb2Nrc19pbml0KTsNCj4gPiA+DQo+ID4gPiAuLi4gdXNpbmcgcG9zdGNv
cmVfaW5pdGNhbGwoKSBvciBhcmNoX2luaXRjYWxsKCkgaGVyZSwgc2hvdWxkIHdvcmsNCj4gPiA+
IHdpdGggcGxhdGZvcm1fZHJpdmVyX3Byb2JlKCk/DQo+ID4gTm9wZSwgeW91IGhhdmUgdG8gdXNl
IHBsYXRmb3JtX2RyaXZlcl9yZWdpc3RlcigpIGZvciBEVCBiYXNlZCBkcml2ZXJzLg0KPiA+IHN1
YnN5c19pbml0Y2FsbCBpcyB0aGUgZWFybGllc3QgeW91IGNhbiB1c2UgcGxhdGZvcm1fZHJpdmVy
X3Byb2JlKCkuDQo+IA0KPiBTbyBkcml2ZXJzL21pc2MvYXRtZWxfdGNsaWIuYyBhbmQgZHJpdmVy
cy9waW5jdHJsL3BpbmN0cmwtY29oOTAxLmMsIHdoaWNoIHVzZQ0KPiBhcmNoX2luaXRjYWxsKCks
IGNhbm5vdCB3b3JrPw0KSG93IHRob3NlIGRyaXZlcnMgd29yayBJIGRvIG5vdCBrbm93LiBIb3dl
dmVyLCBJIHRyaWVkIHdpdGggdGhlIHJ6bjEgY2xvY2sNCmRyaXZlciBhbmQgaXQgZG9lcyBub3Qg
d29yay4NCg0KPiBJZiB0aGF0IGlzIHJlYWxseSB0cnVlLCB5b3UgY2FuIHN0aWxsIHVzZSBzdWJz
eXNfaW5pdGNhbGwoKSBpbiB0aGUgY2xvY2sgZHJpdmVyLCBhbmQNCj4gc3Vic3lzX2luaXRjYWxs
X3N5bmMoKSBpbiB0aGUgcGluY3RybCBkcml2ZXIuDQpUcnVlLCBJJ20gbm90IHN1cmUgaG93IHBl
b3BsZSBkZWNpZGUgd2hpY2ggaW5pdGNhbGwgdG8gdXNlIGFuZCB3aGV0aGVyIHRoZQ0KX3N5bmMg
dmFyaWFudHMgb2YgdGhlIGluaXRjYWxscyBoYXZlIGEgc3BlY2lhbCBtZWFuaW5nIG9yIGludGVu
dGlvbi4gQXMgZmFyIGFzDQpJIGtub3cgdGhleSB3ZXJlIGludHJvZHVjZWQgZm9yIHRocmVhZGVk
IHByb2Jlcywgc28gYXJlIHdlIHN1cHBvc2VkIHRvDQp1c2UgdGhlbSBmb3IgZHJpdmVyIGRlcGVu
ZGVuY2llcyBsaWtlIHRoaXM/DQoNCkRvIHlvdSBrbm93IHdoeSB0aGUgcnphMSBwaW5jdHJsIGRy
aXZlciBpcyBydW5uaW5nIGZyb20gY29yZV9pbml0Y2FsbCgpPw0KDQpUaGFua3MNClBoaWwNCg==
