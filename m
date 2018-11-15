Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20FCC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BDE21582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aodlX5H7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BDE21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbeKOQ3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 11:29:05 -0500
Received: from mail-eopbgr10089.outbound.protection.outlook.com ([40.107.1.89]:36614
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726574AbeKOQ3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 11:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5X7yOC5MGYibW3U4BoU0Rdr9J+zOlcATm6stdzU9xoQ=;
 b=aodlX5H7nvT3TXrIS0ViOMMzNtcSwWHY5gD3hOwWv9/6AjH7IwkgvQhWeHdlO/KDGIuqHMJN7zSkfPYd74FNzv/C9MgCpGBc4LID8xD4edC9OWn+mXetsICwlAwja30c0GPr6a82VoB1xD12WgVM5ubZGNWU48ykwv4usZFR9XU=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB1584.eurprd04.prod.outlook.com (10.164.84.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Thu, 15 Nov 2018 06:22:12 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::297b:bb50:9b83:48e1]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::297b:bb50:9b83:48e1%4]) with mapi id 15.20.1294.045; Thu, 15 Nov 2018
 06:22:12 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.De>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mark Brown <broonie@kernel.org>, Han Xu <han.xu@nxp.com>
CC:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 3/9] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Topic: [PATCH v5 3/9] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Index: AQHUe1duroFEkzCsFkCoS8/TUWpV/KVO8aOggAAF6ACAAAOAgIAAGyKggAAHfQCAATWVMA==
Date:   Thu, 15 Nov 2018 06:22:12 +0000
Message-ID: <VI1PR04MB57265222E26C013D5D9C009B99DC0@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1542116782-13118-1-git-send-email-frieder.schrempf@kontron.de>
 <1542116782-13118-4-git-send-email-frieder.schrempf@kontron.de>
 <VI1PR04MB572679944542ED6A438FD2FB99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <ce9cbfc0-3257-f117-aa21-cdee068579ce@kontron.de>
 <65577d13-b17d-8f69-313c-01d23240d1d9@kontron.de>
 <VI1PR04MB572664063A0E237D2EB7203A99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <eb4b79be-c12b-16e7-e1dd-86a157cfdc7d@kontron.de>
In-Reply-To: <eb4b79be-c12b-16e7-e1dd-86a157cfdc7d@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1584;6:peFd2Ssce57GeSSSPMnB70ezm3nfsJHMapxc/gXzpDRA/L9FqElvNvG0zozondGuUjDWBHIK6TiRBPHxMF2w0GerjzFVJ9ugAy/qrBVFaVL+UhGQjFG0HQCUO1fHjlTBziJsWaG1xljvdtRXaIN2cZfGQ1iKLNGhfBVuwZlZdZg5rfLHgkRG4FQApPSiYLPAQUJa1ZC3gymUyE1vb1zH5bGLV4+GqS3cQ8M0CEUbsjkH5132P5laD7aEv4E3egbmsGrVhA4+jFIKWxNNWe5X1zzz/BLRGMq3BbJ0seTvisfNNWQ/2Kbhvcz6adZVq4PphfjGcf2ZMSdtI82dVQAM/0nqt583kNAJKfJ0hlK9DQekX1qSz6ZZaOQSFnN8fWRyTdbTkJ38ZeUhC5aL9kylCifpd5aXIPHXy+UCsjAOqJfYqlTEw6b6l6rtrmKeOKos5Ir5I+qr6f89gWwJ87+EWQ==;5:YTmUpOsY27lsxuS+zI/tqWSTF0B+r2se18xEK0T8XIGS1JfqqAx15H1R/ioaFF7MZlvCfK3XJw5J9busLJDHunIgYIDq3fx51CQBmBZbzua1mp6MoGISvu91n8RrE6lkq0aAV5fA2I4seq6oJRrU8Clt7QDJW6A2cNV+OkuCobU=;7:6k806riwT5i4qC0kWSWZJVNIcu54niSEYCbe0tJaj6cLYxoZTKbp76hASTcBSHpnq/EZXKA+P29+4eITXfUuYgFgc7T92+3L5gqGho2JXblRI6rD/USq9/2095onx2xO58zt+hh+Pi05N3IQnBRBwA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 25df7566-4354-4b33-0a71-08d64ac2adf4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1584;
x-ms-traffictypediagnostic: VI1PR04MB1584:
x-microsoft-antispam-prvs: <VI1PR04MB1584C9CFA994FCAF3CCD5D1099DC0@VI1PR04MB1584.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231415)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB1584;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1584;
x-forefront-prvs: 08572BD77F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(229853002)(6436002)(93886005)(6116002)(26005)(3846002)(53936002)(68736007)(25786009)(105586002)(106356001)(7736002)(305945005)(99286004)(476003)(74316002)(2501003)(486006)(7416002)(55016002)(8936002)(11346002)(9686003)(446003)(316002)(6506007)(102836004)(14454004)(8676002)(55236004)(76176011)(5660300001)(81156014)(7696005)(81166006)(478600001)(110136005)(54906003)(2900100001)(66066001)(2201001)(39060400002)(186003)(97736004)(2906002)(6246003)(71190400001)(78486014)(71200400001)(6636002)(86362001)(256004)(14444005)(4326008)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1584;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: c/Xobn52xPDiiG7Udxm/48lI8xM/hp6gH6OI+z2koGPTojCFCqrctGW9DeK0+yBMYmgrkUJFYhod9JYPB61fM/yZ8FgSd6Muu+HO8GPXoCm64CYjI/EimepVz+UfSyigsxNroEsxgTLzzRlm9UyKStuurNHn8F1VfW2wtNarfh4EMY5Klpp8aG9ksyOTn8SbFm1f6rJPKo7ZK+NsKKh4wVB2YLSMkjAEytHdl1ivjIo5gZEq//WcDd/aIIC8YwfNQvgywMOW+gzQVtWYpgb3YsSSDSc9/+838fVGFKOYLqEG565Lv9kAZEfmY5rHNCiAkHheIZkz9Rmk2x8St2bufEict29vN2Lb0F8J706wSLc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25df7566-4354-4b33-0a71-08d64ac2adf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2018 06:22:12.0545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1584
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRnJpZWRlciwNCg0KV2l0aCBiZWxvdyBwYXRjaCBvbiB0b3Agb2YgeW91ciB2NSwgUmVhZC9X
cml0ZS9FcmFzZSBvbiBDUzEgaXMgd29ya2luZyBmaW5lIGZvciBtZS4NCg0KSSBoYXZlIHRlc3Rl
ZCB3aXRoIEpGRlMyIG1vdW50aW5nIGFuZCBib290aW5nIGFsc28gZm9yIGJvdGggQ1MwIGFuZCBD
UzEuDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktZnNsLXFzcGkuYyBiL2RyaXZlcnMv
c3BpL3NwaS1mc2wtcXNwaS5jDQppbmRleCBjZTQ1ZThlLi40NDY3OTgzIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9zcGkvc3BpLWZzbC1xc3BpLmMNCisrKyBiL2RyaXZlcnMvc3BpL3NwaS1mc2wtcXNw
aS5jDQpAQCAtNDkwLDI4ICs0OTAsMTAgQEAgc3RhdGljIHZvaWQgZnNsX3FzcGlfc2VsZWN0X21l
bShzdHJ1Y3QgZnNsX3FzcGkgKnEsIHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQogew0KICAgICAg
ICB1bnNpZ25lZCBsb25nIHJhdGUgPSBzcGktPm1heF9zcGVlZF9oejsNCiAgICAgICAgaW50IHJl
dCwgaTsNCi0gICAgICAgdTMyIG1hcF9hZGRyOw0KDQogICAgICAgIGlmIChxLT5zZWxlY3RlZCA9
PSBzcGktPmNoaXBfc2VsZWN0KQ0KICAgICAgICAgICAgICAgIHJldHVybjsNCg0KLSAgICAgICAv
Kg0KLSAgICAgICAgKiBJbiBIVyB0aGVyZSBjYW4gYmUgYSBtYXhpbXVtIG9mIGZvdXIgY2hpcHMg
b24gdHdvIGJ1c2VzIHdpdGgNCi0gICAgICAgICogdHdvIGNoaXAgc2VsZWN0cyBvbiBlYWNoIGJ1
cy4gV2UgdXNlIGZvdXIgY2hpcCBzZWxlY3RzIGluIFNXDQotICAgICAgICAqIHRvIGRpZmZlcmVu
dGlhdGUgYmV0d2VlbiB0aGUgZm91ciBjaGlwcy4NCi0gICAgICAgICogV2UgdXNlIHRoZSBTRkEx
QUQsIFNGQTJBRCwgU0ZCMUFELCBTRkIyQUQgcmVnaXN0ZXJzIHRvIHNlbGVjdA0KLSAgICAgICAg
KiB0aGUgY2hpcCB3ZSB3YW50IHRvIGFjY2Vzcy4NCi0gICAgICAgICovDQotICAgICAgIGZvciAo
aSA9IDA7IGkgPCA0OyBpKyspIHsNCi0gICAgICAgICAgICAgICBpZiAoaSA8IHNwaS0+Y2hpcF9z
ZWxlY3QpDQotICAgICAgICAgICAgICAgICAgICAgICBtYXBfYWRkciA9IHEtPm1lbW1hcF9waHk7
DQotICAgICAgICAgICAgICAgZWxzZQ0KLSAgICAgICAgICAgICAgICAgICAgICAgbWFwX2FkZHIg
PSBxLT5tZW1tYXBfcGh5ICsNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMiAq
IHEtPmRldnR5cGVfZGF0YS0+YWhiX2J1Zl9zaXplOw0KLQ0KLSAgICAgICAgICAgICAgIHFzcGlf
d3JpdGVsKHEsIG1hcF9hZGRyLCBxLT5pb2Jhc2UgKyBRVUFEU1BJX1NGQTFBRCArIChpICogNCkp
Ow0KLSAgICAgICB9DQotDQogICAgICAgIGlmIChuZWVkc180eF9jbG9jayhxKSkNCiAgICAgICAg
ICAgICAgICByYXRlICo9IDQ7DQoNCkBAIC01MzQsNyArNTE2LDkgQEAgc3RhdGljIHZvaWQgZnNs
X3FzcGlfc2VsZWN0X21lbShzdHJ1Y3QgZnNsX3FzcGkgKnEsIHN0cnVjdCBzcGlfZGV2aWNlICpz
cGkpDQoNCiBzdGF0aWMgdm9pZCBmc2xfcXNwaV9yZWFkX2FoYihzdHJ1Y3QgZnNsX3FzcGkgKnEs
IGNvbnN0IHN0cnVjdCBzcGlfbWVtX29wICpvcCkNCiB7DQotICAgICAgIG1lbWNweV9mcm9taW8o
b3AtPmRhdGEuYnVmLmluLCBxLT5haGJfYWRkciwgb3AtPmRhdGEubmJ5dGVzKTsNCisgICAgICAg
bWVtY3B5X2Zyb21pbyhvcC0+ZGF0YS5idWYuaW4sDQorICAgICAgICAgICAgICAgICAgICAgcS0+
YWhiX2FkZHIgKyBxLT5zZWxlY3RlZCAqIHEtPmRldnR5cGVfZGF0YS0+YWhiX2J1Zl9zaXplLA0K
KyAgICAgICAgICAgICAgICAgICAgIG9wLT5kYXRhLm5ieXRlcyk7DQogfQ0KDQogc3RhdGljIHZv
aWQgZnNsX3FzcGlfZmlsbF90eGZpZm8oc3RydWN0IGZzbF9xc3BpICpxLA0KQEAgLTYzNCw3ICs2
MTgsOSBAQCBzdGF0aWMgaW50IGZzbF9xc3BpX2V4ZWNfb3Aoc3RydWN0IHNwaV9tZW0gKm1lbSwg
Y29uc3Qgc3RydWN0IHNwaV9tZW1fb3AgKm9wKQ0KDQogICAgICAgIGZzbF9xc3BpX3NlbGVjdF9t
ZW0ocSwgbWVtLT5zcGkpOw0KDQotICAgICAgIHFzcGlfd3JpdGVsKHEsIHEtPm1lbW1hcF9waHks
IGJhc2UgKyBRVUFEU1BJX1NGQVIpOw0KKyAgICAgICBxc3BpX3dyaXRlbChxLA0KKyAgICAgICAg
ICAgICAgICAgICBxLT5zZWxlY3RlZCAqIHEtPmRldnR5cGVfZGF0YS0+YWhiX2J1Zl9zaXplLA0K
KyAgICAgICAgICAgICAgICAgICBiYXNlICsgUVVBRFNQSV9TRkFSKTsNCg0KICAgICAgICBxc3Bp
X3dyaXRlbChxLCBxc3BpX3JlYWRsKHEsIGJhc2UgKyBRVUFEU1BJX01DUikgfA0KICAgICAgICAg
ICAgICAgICAgICBRVUFEU1BJX01DUl9DTFJfUlhGX01BU0sgfCBRVUFEU1BJX01DUl9DTFJfVFhG
X01BU0ssDQpAQCAtNzMzLDYgKzcxOSwxOSBAQCBzdGF0aWMgaW50IGZzbF9xc3BpX2RlZmF1bHRf
c2V0dXAoc3RydWN0IGZzbF9xc3BpICpxKQ0KICAgICAgICAgICAgICAgICAgICBRVUFEU1BJX0JV
RjNDUl9BREFUU1oocS0+ZGV2dHlwZV9kYXRhLT5haGJfYnVmX3NpemUgLyA4KSwNCiAgICAgICAg
ICAgICAgICAgICAgYmFzZSArIFFVQURTUElfQlVGM0NSKTsNCg0KKyAgICAgICAvKg0KKyAgICAg
ICAgKiBJbiBIVyB0aGVyZSBjYW4gYmUgYSBtYXhpbXVtIG9mIGZvdXIgY2hpcHMgb24gdHdvIGJ1
c2VzIHdpdGgNCisgICAgICAgICogdHdvIGNoaXAgc2VsZWN0cyBvbiBlYWNoIGJ1cy4gV2UgdXNl
IGZvdXIgY2hpcCBzZWxlY3RzIGluIFNXDQorICAgICAgICAqIHRvIGRpZmZlcmVudGlhdGUgYmV0
d2VlbiB0aGUgZm91ciBjaGlwcy4NCisgICAgICAgICogV2UgdXNlIHRoZSBTRkExQUQsIFNGQTJB
RCwgU0ZCMUFELCBTRkIyQUQgcmVnaXN0ZXJzIHRvIHNlbGVjdA0KKyAgICAgICAgKiB0aGUgY2hp
cCB3ZSB3YW50IHRvIGFjY2Vzcy4NCisgICAgICAgICovDQorDQorICAgICAgIHFzcGlfd3JpdGVs
KHEsIHEtPmRldnR5cGVfZGF0YS0+YWhiX2J1Zl9zaXplLCBiYXNlICsgUVVBRFNQSV9TRkExQUQp
Ow0KKyAgICAgICBxc3BpX3dyaXRlbChxLCBxLT5kZXZ0eXBlX2RhdGEtPmFoYl9idWZfc2l6ZSAq
IDIgLCBiYXNlICsgUVVBRFNQSV9TRkEyQUQpOw0KKyAgICAgICBxc3BpX3dyaXRlbChxLCBxLT5k
ZXZ0eXBlX2RhdGEtPmFoYl9idWZfc2l6ZSAqIDMgLCBiYXNlICsgUVVBRFNQSV9TRkIxQUQpOw0K
KyAgICAgICBxc3BpX3dyaXRlbChxLCBxLT5kZXZ0eXBlX2RhdGEtPmFoYl9idWZfc2l6ZSAqIDQg
LCBiYXNlICsgUVVBRFNQSV9TRkIyQUQpOw0KKw0KICAgICAgICBxLT5zZWxlY3RlZCA9IC0xOw0K
DQotLQ0KUmVnYXJkcw0KWW9nZXNoIEdhdXINCg0KWy4uXQ0K
