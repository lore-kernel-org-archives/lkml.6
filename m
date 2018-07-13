Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962B6ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387AD208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="ctyqu8xr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387AD208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbeGMPyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:54:39 -0400
Received: from mail-he1eur01on0108.outbound.protection.outlook.com ([104.47.0.108]:14663
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729771AbeGMPyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6h11tVAXSkMzSXTVEG8+z1kKyICYM70VFYuskBoP/Zc=;
 b=ctyqu8xr4hre3NT6gR13o/elgnNPudxQUfR7QT0HTjZmp49R6926EbWpM62KGjFvoNOAbCk7g3FYeQU1ii+yUtI/WrOlXllAYZRRuXdPIluQt+InD27j9Z22gNNxM4TmET0/OBP/nZIltEOOvgEFSxMx9BFkGKku0uGWC3DWCmg=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2383.eurprd05.prod.outlook.com (10.168.135.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Fri, 13 Jul 2018 15:39:25 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::5570:f225:bd5b:1aa3]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::5570:f225:bd5b:1aa3%10]) with mapi id 15.20.0930.022; Fri, 13 Jul
 2018 15:39:24 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 1/3] mmc: tegra: prevent HS200 on Tegra 3
Thread-Topic: [PATCH 1/3] mmc: tegra: prevent HS200 on Tegra 3
Thread-Index: AQHUGbOK5gNAcOdEskKCtB7Tq3qm46SNS/AA
Date:   Fri, 13 Jul 2018 15:39:24 +0000
Message-ID: <1531496362.5479.34.camel@toradex.com>
References: <20180712073904.4705-1-stefan@agner.ch>
In-Reply-To: <20180712073904.4705-1-stefan@agner.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [89.217.215.226]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2383;7:3y7DB3wL0J8xzeAtRfo84e3Mo5OyEpo8oKcUsEKKd7tDvAoN8nj+Sglat+e/HeJ0auZ9NT3Hb+RnIqLv/JNCN80Bx0fOYahk8g2VLVIWFrXLCjgsHhAleyYiQZyIAAz8tvhgGU2ozq8JfMOCuaL3yZEeRx45vzDw+bbwtQvv3sqqdQavAbp+bJa++x1MBavd9fDYxrOLEDGwt/gS+SBUeNw+4EwCIId6Cu4Rw919TQsfG/RJLd8cARanYdoOWlJ0
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 21cdc9fb-aa7e-4a56-7e51-08d5e8d6cfcc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2383;
x-ms-traffictypediagnostic: VI1PR0501MB2383:
x-microsoft-antispam-prvs: <VI1PR0501MB23832368E888E35FB5AFB26AFB580@VI1PR0501MB2383.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(18589796830644);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB2383;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2383;
x-forefront-prvs: 07326CFBC4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(39850400004)(366004)(396003)(189003)(199004)(316002)(5250100002)(6486002)(25786009)(2900100001)(14444005)(2906002)(6506007)(256004)(53936002)(54906003)(2201001)(6436002)(3846002)(11346002)(81156014)(6512007)(81166006)(110136005)(36756003)(6116002)(106356001)(8936002)(102836004)(6246003)(229853002)(305945005)(6306002)(966005)(8676002)(26005)(7736002)(86362001)(14454004)(2501003)(66066001)(99286004)(446003)(476003)(478600001)(2616005)(103116003)(5660300001)(486006)(44832011)(68736007)(97736004)(4326008)(186003)(105586002)(76176011)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2383;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3kgxfrfOwv2xwNjV2Kt1f0KzWZpCxfv/xJ64IZwemUX317Wxp6GnIXWuyjiB4wEw54QSDDkhAxfOzVd8tV7nO8RSfRjG7eZ2tbCGdKXjYPlGuqAh3WMBxCT2vwDxf5Sf8k73IjHTJ86z4N7ew7ax5F62d2OKtb8AoCmgifxhgG6vPj2SMtzfOp3k5IfdwSS6IYkAPC/ak8TSBNT0ya6C1HBqjE6Bw2r4RFmHSudS9HfPrHnAk6j4ZDDfX6Aktj9W5aO61SY00KJNZlHVv0bGwA4WVneR4e/B6hs9ks5W65rObbaeqvKG4KS5GsgVcTOW/zxtjO4hJZ4JJfZsW1cKA5TL73PY4c9BZZSPq/u4PIg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B68E3230CB86349A40D3B819127BEC6@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cdc9fb-aa7e-4a56-7e51-08d5e8d6cfcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2018 15:39:24.8633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA3LTEyIGF0IDA5OjM5ICswMjAwLCBTdGVmYW4gQWduZXIgd3JvdGU6DQo+
IFRoZSBzdGFjayBhc3N1bWVzIHRoYXQgU0RIQyBjb250cm9sbGVyIHdoaWNoIHN1cHBvcnQgU0Qz
LjAgKFNEUjEwNCkNCj4gZG8NCj4gc3VwcG9ydCBIUzIwMC4gVGhpcyBpcyBub3QgdGhlIGNhc2Ug
Zm9yIFRlZ3JhIDMsIHdoaWNoIGRvZXMgc3VwcG9ydA0KPiBTRA0KPiAzLjANCj4gYnV0IG9ubHkg
c3VwcG9ydHMgZU1NQyBzcGVjIDQuNDEuDQo+IA0KPiBVc2UgU0RIQ0lfUVVJUksyX0JST0tFTl9I
UzIwMCB0byBpbmRpY2F0ZSB0aGF0IHRoZSBjb250cm9sbGVyIGRvZXMNCj4gbm90DQo+IHN1cHBv
cnQgSFMyMDAuDQo+IA0KPiBOb3RlIHRoYXQgY29tbWl0IDE1NmUxNGIxMjZmZiAoIm1tYzogc2Ro
Y2k6IGZpeCBjYXBzMiBmb3IgSFMyMDAiKQ0KPiBhZGRlZA0KPiB0aGUgdGllIGJldHdlZW4gU0Qz
LjAgKFNEUjEwNCkgYW5kIEhTMjAwLiBJIGRvbid0IHRoaW5rIHRoYXQgdGhpcyBpcw0KPiBuZWNl
c3Nhcmx5IHRydWUuIEl0IGlzIGZ1bGx5IGxlZ2l0aW1hdGUgdG8gc3VwcG9ydCBTRDMuMCBhbmQg
bm90DQo+IHN1cHBvcnQNCj4gSFMyMDAuIFRoZSBxdWlyayBuYW1pbmcgc3VnZ2VzdHMgc29tZXRo
aW5nIGlzIGJyb2tlbiBpbiB0aGUNCj4gY29udHJvbGxlciwNCj4gYnV0IHRoaXMgaXMgbm90IHRo
ZSBjYXNlOiBUaGUgY29udHJvbGxlciBzaW1wbHkgZG9lcyBub3Qgc3VwcG9ydA0KPiBIUzIwMC4N
Cj4gDQo+IEZpeGVzOiA3YWQyZWQxZGZjYmUgKCJtbWM6IHRlZ3JhOiBlbmFibGUgVUhTLUkgbW9k
ZXMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gQWduZXIgPHN0ZWZhbkBhZ25lci5jaD4NCg0K
VGhlIHdob2xlIHNlcmllcyBzdHJlc3MtdGVzdGVkIG92ZXJuaWdodCBvbiB2YXJpb3VzIEFwYWxp
cyBUMzAgYXMgd2VsbA0KYXMgQ29saWJyaSBUMzAgbW9kdWxlczoNCg0KVGVzdGVkLWJ5OiBNYXJj
ZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCg0KPiAtLS0NCj4gIGRy
aXZlcnMvbW1jL2hvc3Qvc2RoY2ktdGVncmEuYyB8IDMgKystDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tbWMvaG9zdC9zZGhjaS10ZWdyYS5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS0NCj4gdGVn
cmEuYw0KPiBpbmRleCA5NzBkMzhmNjg5MzkuLjEzN2RmMDZiOWI2ZSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS10ZWdyYS5jDQo+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qv
c2RoY2ktdGVncmEuYw0KPiBAQCAtMzM0LDcgKzMzNCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
c2RoY2lfcGx0Zm1fZGF0YQ0KPiBzZGhjaV90ZWdyYTMwX3BkYXRhID0gew0KPiAgCQkgIFNESENJ
X1FVSVJLX05PX0hJU1BEX0JJVCB8DQo+ICAJCSAgU0RIQ0lfUVVJUktfQlJPS0VOX0FETUFfWkVS
T0xFTl9ERVNDIHwNCj4gIAkJICBTREhDSV9RVUlSS19DQVBfQ0xPQ0tfQkFTRV9CUk9LRU4sDQo+
IC0JLnF1aXJrczIgPSBTREhDSV9RVUlSSzJfUFJFU0VUX1ZBTFVFX0JST0tFTiwNCj4gKwkucXVp
cmtzMiA9IFNESENJX1FVSVJLMl9QUkVTRVRfVkFMVUVfQlJPS0VOIHwNCj4gKwkJICAgU0RIQ0lf
UVVJUksyX0JST0tFTl9IUzIwMCwNCj4gIAkub3BzICA9ICZ0ZWdyYV9zZGhjaV9vcHMsDQo+ICB9
Ow0KDQpXb3JrcyBxdWl0ZSBuaWNlbHkgb24gdG9kYXkncyBuZXh0IG9uY2UgWzFdIGlzIGFsc28g
YXBwbGllZDoNCg0Kcm9vdEBhcGFsaXMtdDMwOn4jIGNhdCAvc3lzL2tlcm5lbC9kZWJ1Zy9tbWMx
L2lvcyANCmNsb2NrOiAgICAgICAgICA1MjAwMDAwMCBIeg0KYWN0dWFsIGNsb2NrOiAgIDUxMDAw
MDAwIEh6DQp2ZGQ6ICAgICAgICAgICAgMjEgKDMuMyB+IDMuNCBWKQ0KYnVzIG1vZGU6ICAgICAg
IDIgKHB1c2gtcHVsbCkNCmNoaXAgc2VsZWN0OiAgICAwIChkb24ndCBjYXJlKQ0KcG93ZXIgbW9k
ZTogICAgIDIgKG9uKQ0KYnVzIHdpZHRoOiAgICAgIDMgKDggYml0cykNCnRpbWluZyBzcGVjOiAg
ICA4IChtbWMgRERSNTIpDQpzaWduYWwgdm9sdGFnZTogMSAoMS44MCBWKQ0KZHJpdmVyIHR5cGU6
ICAgIDAgKGRyaXZlciB0eXBlIEIpDQpyb290QGFwYWxpcy10MzA6fiMgaGRwYXJtIC10IC9kZXYv
bW1jYmxrMQ0KDQovZGV2L21tY2JsazE6DQogVGltaW5nIGJ1ZmZlcmVkIGRpc2sgcmVhZHM6IDIz
NiBNQiBpbiAgMy4wMSBzZWNvbmRzID0gIDc4LjQyIE1CL3NlYw0KDQpyb290QGNvbGlicmktdDMw
On4jIGNhdCAvc3lzL2tlcm5lbC9kZWJ1Zy9tbWMwL2lvcyANCmNsb2NrOiAgICAgICAgICA1MjAw
MDAwMCBIeg0KYWN0dWFsIGNsb2NrOiAgIDUxMDAwMDAwIEh6DQp2ZGQ6ICAgICAgICAgICAgMjEg
KDMuMyB+IDMuNCBWKQ0KYnVzIG1vZGU6ICAgICAgIDIgKHB1c2gtcHVsbCkNCmNoaXAgc2VsZWN0
OiAgICAwIChkb24ndCBjYXJlKQ0KcG93ZXIgbW9kZTogICAgIDIgKG9uKQ0KYnVzIHdpZHRoOiAg
ICAgIDMgKDggYml0cykNCnRpbWluZyBzcGVjOiAgICA4IChtbWMgRERSNTIpDQpzaWduYWwgdm9s
dGFnZTogMSAoMS44MCBWKQ0KZHJpdmVyIHR5cGU6ICAgIDAgKGRyaXZlciB0eXBlIEIpDQpyb290
QGNvbGlicmktdDMwOn4jIGhkcGFybSAtdCAvZGV2L21tY2JsazANCg0KL2Rldi9tbWNibGswOg0K
IFRpbWluZyBidWZmZXJlZCBkaXNrIHJlYWRzOiAxNjggTUIgaW4gIDMuMDAgc2Vjb25kcyA9ICA1
NS45OSBNQi9zZWMNCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMTUzMTQ4Nzg2
NS0xNzQyNy0xLWdpdC1zZW5kLWVtYWlsLWF2aWUNCm5hbW9AbnZpZGlhLmNvbQ==
