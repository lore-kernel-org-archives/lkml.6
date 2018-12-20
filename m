Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6198C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD35621741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="CzgsCMxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbeLTMOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:14:18 -0500
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:17074
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731646AbeLTMOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4npooQ5gk7pmesT5Z5877t9kFKx+egz+i7UbUFatCqg=;
 b=CzgsCMxRDaQAW86AbGW3Oo+/kfk3KW7X8tBL8P6pJABatLWgn2aum6kjrJ7JgXa3NYxbsGieSrSiQ3EOLRGSyUiS8bGKKy5uraGYBK92gvi2/3/x/XLh069GMa5FYpsgv+OK0hW2cV/yIJIYKdaf+MWax61wgbeLUArV8xhp4hM=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4459.eurprd04.prod.outlook.com (52.135.137.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Thu, 20 Dec 2018 12:13:58 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490%3]) with mapi id 15.20.1446.020; Thu, 20 Dec 2018
 12:13:58 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Subject: [PATCH v2 2/4] video: ssd1307fb: Do not hard code active-low reset
 sequence
Thread-Topic: [PATCH v2 2/4] video: ssd1307fb: Do not hard code active-low
 reset sequence
Thread-Index: AQHUmF168kKI5FRVIkC3wDG9Rm7srQ==
Date:   Thu, 20 Dec 2018 12:13:55 +0000
Message-ID: <1545308005-51559-3-git-send-email-michal.vokac@ysoft.com>
References: <1545308005-51559-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1545308005-51559-1-git-send-email-michal.vokac@ysoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0015.eurprd07.prod.outlook.com
 (2603:10a6:203:51::25) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4459;6:02zt2fPjDMUvcqE7T6z+VeVaB11FKdwrbBZ9WemM74Of6sijRprAsfOkBQEF7nt3AWAfEfCEsQ0fFp0+0hZFGpwFRZU2Q0o34wz7OuYFuvk2R3Y27jbXrvS8CNAzPaJ/Xhs1qVlofpYw+U0Ut8LVYFDrDfG48x4yzU5n6Km4Pf+YpNA/V1xmPt2wY2onBz1pcMJQoLMFaJZ6L90+MowOTxUZYK8idpf7N/rXEVwifGYqdcQtq+2lms481s7Nnnm6CtRpoTG0C+b5PhADOrfeNx2evWHnbNCpaEqCRxt7TKmFMMKrzKu008tjS/wavZtSB8ulqUlYbaE0jXF/73DbPBLdsH2ZNTOspG2OjZdW86ZIoe/slykqLYD2i3pU/lJdziV3MeP01nPB+8Uo8lu4es1bhXcK1hUHsXYTyVtfnhcliQ+wEVmdcZ7YH7XnusJ3oSLtcZkT2miveCU7Y2rBlg==;5:JDvA3HJnR3Z7lruewCYylfoMJP73HwuYW2uTlXHbYX6It/nSGtBG3zvqgqZI7bTEi3PtWRpKoRhVdTCHOH7QnbmoULuFQB60uucN4Pl6etVTrU36SYyvz18kaGrdb8I1o7m9cn9FbkxlR3pcakmsZKIm9R5R0sHYmEBHL7zsNxo=;7:np7m6/Ng/1CkoVY/ij9nUcRmwmDdU7qIMdSWObjMRKSjpWYJg8UC2T1G93HkQz0FPqB2oqj4RsnnBX92/dhEBpIdOmh90xCuway9UXt1u038lMX9Or/Zkwikg1dGQSQiEF8GoJcqNmmLzy+c5DIf9w==
x-ms-office365-filtering-correlation-id: 28447fda-467a-4cdc-c2e9-08d666749cba
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4459;
x-ms-traffictypediagnostic: DB7PR04MB4459:
x-microsoft-antispam-prvs: <DB7PR04MB445985B7DACADA2B8C469D2C9EBF0@DB7PR04MB4459.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4459;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4459;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(39850400004)(376002)(189003)(199004)(11346002)(86362001)(446003)(71190400001)(6436002)(5660300001)(53936002)(6512007)(186003)(102836004)(26005)(386003)(6506007)(85182001)(66066001)(478600001)(105586002)(71200400001)(36756003)(7736002)(4326008)(76176011)(97736004)(6486002)(2616005)(486006)(476003)(68736007)(52116002)(305945005)(8676002)(8936002)(99286004)(106356001)(6116002)(3846002)(110136005)(107886003)(2906002)(256004)(316002)(81166006)(81156014)(54906003)(25786009)(6666004)(14454004)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4459;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VBiR6mp0AjVvoEIYhornsk0ico+7Yi2+i48ETNjG+LM1L6xTZqgoyjbYW+8YaZw227ovXwhaKSmyQ7iOIaMJ5SlEUWrZZO18OsOWO4vWC9kV2slP/SyZu0YywCPl9yRJ2Q8nSgDkQw1jIJLWU2AG7GPIy9jJSns4x1/Srt3B7A1isSXMVrI3N+oARbpNYdBtCAfHTb6vF1hJcue8rtu53TsaLuBf1DjYvW2KK55LxQj2sVBnYn66QHtXET5YE5MhPOd0UeVrqptdnvTDu20WEstbQ+5uHzNiZYgCC0ZkJ8MnJv755Kf+yVoLyjoGXHMsA5gThmKL39qc5wyAcVZZFDI9GUh7r8Y6Lr/t6w8kRzI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <08F1D6373BC021469D0A985A8791D70E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28447fda-467a-4cdc-c2e9-08d666749cba
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 12:13:55.3540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIFNTRDEzMHggT0xFRMKgZGlzcGxheSByZXNldCBzaWduYWwgaXMgYWN0aXZlIGxvdy4gTm93
IHRoZSByZXNldA0Kc2VxdWVuY2UgaXMgaW1wbGVtZW50ZWQgaW4gc3VjaCBhIHdheSB0aGF0IHVz
ZXJzIGFyZSBmb3JjZWQgdG8NCmRlZmluZSByZXNldC1ncGlvcyBhcyBHUElPX0FDVElWRV9ISUdI
IGluIERUIHRvIG1ha2UgdGhlIHJlc2V0IHdvcmsuDQoNCkRvIG5vdCBoYXJkIGNvZGUgdGhlIGFj
dGl2ZS1sb3cgc2VxdWVuY2UgaW50byB0aGUgZHJpdmVyIGJ1dCBpbnN0ZWFkDQphbGxvdyB0aGUg
dXNlciB0byBzcGVjaWZ5IHRoZSBncGlvIGFzIEdQSU9fQUNUSVZFX0xPVyB0byByZWZsZWN0DQp0
aGUgcmVhbCB3b3JsZC4NCg0KUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5v
cmc+DQpTaWduZWQtb2ZmLWJ5OiBNaWNoYWwgVm9rw6HEjSA8bWljaGFsLnZva2FjQHlzb2Z0LmNv
bT4NCi0tLQ0KQ2hhbmdlcyBmcm9tIHYxOg0KIC0gQWRkIFItYnkgZnJvbSBSb2INCg0KIGRyaXZl
cnMvdmlkZW8vZmJkZXYvc3NkMTMwN2ZiLmMgfCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRl
by9mYmRldi9zc2QxMzA3ZmIuYyBiL2RyaXZlcnMvdmlkZW8vZmJkZXYvc3NkMTMwN2ZiLmMNCmlu
ZGV4IDQwNjFhMjAuLjNiMzYxYmMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L3Nz
ZDEzMDdmYi5jDQorKysgYi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L3NzZDEzMDdmYi5jDQpAQCAtNjY3
LDEwICs2NjcsMTAgQEAgc3RhdGljIGludCBzc2QxMzA3ZmJfcHJvYmUoc3RydWN0IGkyY19jbGll
bnQgKmNsaWVudCwNCiANCiAJaWYgKHBhci0+cmVzZXQpIHsNCiAJCS8qIFJlc2V0IHRoZSBzY3Jl
ZW4gKi8NCi0JCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChwYXItPnJlc2V0LCAwKTsNCi0JCXVk
ZWxheSg0KTsNCiAJCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChwYXItPnJlc2V0LCAxKTsNCiAJ
CXVkZWxheSg0KTsNCisJCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChwYXItPnJlc2V0LCAwKTsN
CisJCXVkZWxheSg0KTsNCiAJfQ0KIA0KIAlpZiAocGFyLT52YmF0X3JlZykgew0KLS0gDQoyLjEu
NA0KDQo=
