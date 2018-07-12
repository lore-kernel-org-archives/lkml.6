Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591FFC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A42B213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="bKH1FAkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A42B213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732437AbeGLNlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:41:37 -0400
Received: from mail-eopbgr40110.outbound.protection.outlook.com ([40.107.4.110]:60890
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726782AbeGLNlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5q+nERZ5Zp1urYLjKnB9pCIy9mNMXSif8MN9ns/qHTQ=;
 b=bKH1FAkSLydwXyVWwxzaqgln70ZBp6abUQNJsu29Q9vBmnbbVkVQg6HA/X7UjefE6NcwB3/mX9d/nyQ4CsZ3i+9Z61sLkknlslSRUHkL9d9DZBjPWgKH3YJPymsHd6KXTut0FBAAn9ATeWVUEPTPPrYQq1ik1+Pph/4FiJxhUcg=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2222.eurprd05.prod.outlook.com (10.169.134.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Thu, 12 Jul 2018 13:31:58 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::5570:f225:bd5b:1aa3]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::5570:f225:bd5b:1aa3%10]) with mapi id 15.20.0930.022; Thu, 12 Jul
 2018 13:31:57 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "dev@lynxeye.de" <dev@lynxeye.de>,
        "benjamin.lindqvist@endian.se" <benjamin.lindqvist@endian.se>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "mirza.krak@gmail.com" <mirza.krak@gmail.com>,
        "gaireg@gaireg.de" <gaireg@gaireg.de>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>
Subject: Re: [PATCH] mtd: rawnand: tegra: check bounds of die_nr properly
Thread-Topic: [PATCH] mtd: rawnand: tegra: check bounds of die_nr properly
Thread-Index: AQHUGeS0pyEGRbQPRUWImmAyq6IKYw==
Date:   Thu, 12 Jul 2018 13:31:57 +0000
Message-ID: <1531402315.1390.6.camel@toradex.com>
References: <20180704091310.22003-1-stefan@agner.ch>
In-Reply-To: <20180704091310.22003-1-stefan@agner.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2222;7:Xks53G4XE5w2TPpiq0Z1ql9SSfb6vHetBCLtnW/Hhjg8AaNcnv2PtkYyN7mmqHbwQx/36W8xuYxdy6v3JLEobSyIQvNmEOapH3cZ8N1x03XjSgHvfI+b3+JMoYrV71aZcyMHC/YpTD9jwkvZg482AVfSxcpDTPf+c5PCLa6zRrSZQ17XhdSJ1Zs6oyLCwMlcbcq3+MVMudtszbrkU+x3baiUqfFNvk9ZcWCAdehbHoyUjMdQE5MgQHzoLw+DvKbG
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 495bf30a-d062-4bbb-5277-08d5e7fbd72f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2222;
x-ms-traffictypediagnostic: VI1PR0501MB2222:
x-microsoft-antispam-prvs: <VI1PR0501MB222213D7EFF90AFDED882C23FB590@VI1PR0501MB2222.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB2222;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2222;
x-forefront-prvs: 0731AA2DE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(366004)(396003)(346002)(136003)(376002)(189003)(199004)(99286004)(316002)(39060400002)(25786009)(54906003)(110136005)(229853002)(6512007)(44832011)(2201001)(5250100002)(2501003)(105586002)(102836004)(6506007)(2906002)(186003)(11346002)(446003)(26005)(14454004)(4326008)(478600001)(476003)(2616005)(53936002)(106356001)(486006)(66066001)(36756003)(305945005)(8676002)(81156014)(81166006)(8936002)(14444005)(103116003)(256004)(76176011)(6246003)(6116002)(86362001)(7736002)(68736007)(7416002)(3846002)(575784001)(5660300001)(2900100001)(97736004)(6486002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2222;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Piwpqy7JRZEX6ivUPZz0nBLPMSoOLNa4+MOXZueUO4GYSrL69+0IGIvjj1lpv2lE4bw0axZrxz4aoNktrjdrj40Ajq2S5NT+S6EtobOt+iF4MtH1HYGgmKHNXuC9eZzo0ePAinamwGdUrlNQ4Hvsl1IAuAspJuW4lqgO+eDaesdeYubnimvBaWPWxLW12NiKInmlAU1HS2Ip9z+7EynEePwI9ZswF/tGl5yJBgrxEVnhQ1RA9Jip/CE84hK+YIUPUQjt4HpAg3DpBkOfHRna73q3iNIvUSt27k5iUqT4489jN09vjAyTXSUUk9fgF50b2D6ci/dJfBoGsXLTVgkRW+Sme0FyX50zeKNUtPm1TUw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B4C462F86C8A84DB5B35B481971228B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 495bf30a-d062-4bbb-5277-08d5e7fbd72f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2018 13:31:57.3051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA3LTA0IGF0IDExOjEzICswMjAwLCBTdGVmYW4gQWduZXIgd3JvdGU6DQo+
IFRoZSBUZWdyYSBkcml2ZXIgY3VycmVudGx5IG9ubHkgc3VwcG9ydCBhIHNpbmdsZSBjaGlwIHNl
bGVjdCwgaGVuY2UNCj4gY2hlY2sgYm91bmRhcmllcyBhY2NvcmRpbmdseS4gVGhpcyBmaXhlcyBh
IG9mZiBieSBvbmUgaXNzdWUgY2F0Y2hlZA0KPiB3aXRoIFNtYXRjaDoNCj4gICAgIGRyaXZlcnMv
bXRkL25hbmQvcmF3L3RlZ3JhX25hbmQuYzo0NzYgdGVncmFfbmFuZF9zZWxlY3RfY2hpcCgpDQo+
ICAgICB3YXJuOiBhcnJheSBvZmYgYnkgb25lPyAnbmFuZC0+Y3NbZGllX25yXScNCj4gDQo+IEFs
c28gd2FybiBpbiBjYXNlIHRoZSBzdGFjayBhc2tzIGZvciBhIGNoaXAgc2VsZWN0IHdlIGN1cnJl
bnRseSBkbw0KPiBub3Qgc3VwcG9ydC4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBEYW4gQ2FycGVudGVy
IDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBBZ25l
ciA8c3RlZmFuQGFnbmVyLmNoPg0KPiAtLS0NCj4gIGRyaXZlcnMvbXRkL25hbmQvcmF3L3RlZ3Jh
X25hbmQuYyB8IDQgKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvcmF3L3RlZ3Jh
X25hbmQuYw0KPiBiL2RyaXZlcnMvbXRkL25hbmQvcmF3L3RlZ3JhX25hbmQuYw0KPiBpbmRleCA0
ZGFhODhkODE0MTM0Li5lNjVlZjU4NGRmMGI5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9u
YW5kL3Jhdy90ZWdyYV9uYW5kLmMNCj4gKysrIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvdGVncmFf
bmFuZC5jDQo+IEBAIC00NjgsNyArNDY4LDkgQEAgc3RhdGljIHZvaWQgdGVncmFfbmFuZF9zZWxl
Y3RfY2hpcChzdHJ1Y3QNCj4gbXRkX2luZm8gKm10ZCwgaW50IGRpZV9ucikNCj4gIAlzdHJ1Y3Qg
dGVncmFfbmFuZF9jaGlwICpuYW5kID0gdG9fdGVncmFfY2hpcChjaGlwKTsNCj4gIAlzdHJ1Y3Qg
dGVncmFfbmFuZF9jb250cm9sbGVyICpjdHJsID0gdG9fdGVncmFfY3RybChjaGlwLQ0KPiA+Y29u
dHJvbGxlcik7DQo+ICANCj4gLQlpZiAoZGllX25yIDwgMCB8fCBkaWVfbnIgPiAxKSB7DQo+ICsJ
V0FSTl9PTihkaWVfbnIgPj0gQVJSQVlfU0laRShuYW5kLT5jcykpOw0KDQpVbmZvcnR1bmF0ZWx5
LCB0aGF0IGhhcyBhIHRpbnkgbGl0dGxlIGlzc3VlIGFzIGRpZV9uciBpcyBhIHNpZ25lZA0KaW50
ZWdlciBhbmQgQVJSQVlfU0laRSBvZiBjb3Vyc2UgaXMgdW5zaWduZWQuIFdoaWxlIEkgY291bGQg
aGF2ZSBzd29ybg0KbXkgc2hpcnQgb2ZmIHRoYXQgdGhlIGNvbXBpbGVyIHdvdWxkIGhhdmUgdG8g
cHJvbW90ZSB0aGlzIHRvIHNpZ25lZA0KdGhpcyBpcyBub3QgcXVpdGUgd2hhdCBoYXBwZW5zIGFu
ZCB1cG9uIGRlc2VsZWN0aW5nIHdpdGggLTEgdGhpcw0Kd2FybmluZyBnZXRzIHRyaWdnZXJlZCEN
Cg0KSSB3aWxsIHNlbmQgYW4gdXBkYXRlZCBwYXRjaCBleHBsaWNpdGx5IGNhc3RpbmcgdGhlIEFS
UkFZX1NJWkUgc2lkZSB0bw0KaW50IGFzIHdlbGwgc2hvcnRseS4NCg0KPiArDQo+ICsJaWYgKGRp
ZV9uciA8IDAgfHwgZGllX25yID4gMCkgew0KPiAgCQljdHJsLT5jdXJfY3MgPSAtMTsNCj4gIAkJ
cmV0dXJuOw0KPiAgCX0=
