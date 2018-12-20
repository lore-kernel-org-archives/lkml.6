Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BA5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF7D218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="IZyTKzM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbeLTMOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:14:02 -0500
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:17074
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729603AbeLTMOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsGRekB77J+vblLX02ojiXzXVQSi/nqFWm4Oh5ZW9ps=;
 b=IZyTKzM744Yi3/IfJqw5HCuagNhWXxHGEu6YiyFGmFpK3mqfczTvYUbSMZAhAaCfVACbDkzEB6ICyg/ik2zKiZm77Z/Kji+EWY8I4CYgLKg3Py+T9P3BUEada4YPvWkoxFMNUmndjI83GgPz2M4iQt0ShBOrK4N/vru7f+P7FV8=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4459.eurprd04.prod.outlook.com (52.135.137.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Thu, 20 Dec 2018 12:13:53 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490%3]) with mapi id 15.20.1446.020; Thu, 20 Dec 2018
 12:13:53 +0000
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
Subject: [PATCH v2 0/4] Fix ssd1307fb OLED driver reset
Thread-Topic: [PATCH v2 0/4] Fix ssd1307fb OLED driver reset
Thread-Index: AQHUmF15WoGNRFWFWUuBaPqr02JEOg==
Date:   Thu, 20 Dec 2018 12:13:53 +0000
Message-ID: <1545308005-51559-1-git-send-email-michal.vokac@ysoft.com>
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
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4459;6:t3W/iZxVHgc9U6lB6Uf/qyM8Ghrooip8RhRrAkvd3IuYCfRAS2uVNBI7W2rNytuIGr72GYtTr6TaQbHE85vizWlIPPHS0h35ru2syMDxD5Q46A2Bz6IqLImyREFyIgFxHPv7lRbDhnUKQKqHBIZcs6Dh+3S5sEIVPjBdOxNgKCfb8o+r2qr72Z3kNoDTWlBq2UC4cXDzC2aDf/liKwi8H8V+XCaTLM77WNnUnsyPyKgwzt2tCwre33DXyaVYQVgsMs5TgwEZ4hqOWuG97too/QBpqazYvoII9RRyU/N7FjAEpl90jBFIZBpQfL5sbFpxqVs7YgO2tEb/RZR+jS0aX6JDfFzPeUUQZDghVy0NIbkmdC4hFUuZR1t4X/cxlQ2A6VyayGXbj+acseEnAG6oNbpMEJTh6keXFRVY4AsyhURfk8m6+NX+x3w1McP3bkWYMjtFFUvxHF087WmiaWUo2Q==;5:lqTYI7Ig8pZW3I7VEQb6MDA3qEF3nbC+mVSfeqcMfUg0iWFXhZFgoljAVmH0Ehkm62p5Mtv4A+HlIxwiQaM81xEt5w7+ER9ZZ/YyQY38WAVQpyoyH2/5XAHgogn/eUGhhHC5JNC0ilfDLUL4SVLLzk2EkLsYvUiAjU/h/id0IyQ=;7:vulUJiRk7hQKTWbXunLx2aWHY85TP+tRwZV+J/vEdIrDQY6Z9/hFcZIZfyOYjBmuU/ITdYgH1VDy2o8gtJCGvjWhamGjWe5Ui+CrY0IC3+Wnw6FjGEEuoolLLsMdtHKBdDTTkwCojMIiSwlpX9VwZQ==
x-ms-office365-filtering-correlation-id: 0ca12943-a25e-4032-72da-08d666749b7f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4459;
x-ms-traffictypediagnostic: DB7PR04MB4459:
x-microsoft-antispam-prvs: <DB7PR04MB445970D39A73FD2A9027C6C59EBF0@DB7PR04MB4459.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4459;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4459;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(39850400004)(376002)(53754006)(189003)(199004)(86362001)(71190400001)(6436002)(5660300001)(53936002)(6512007)(186003)(102836004)(26005)(386003)(6506007)(85182001)(66066001)(478600001)(105586002)(6306002)(71200400001)(36756003)(7736002)(4326008)(97736004)(6486002)(2616005)(486006)(476003)(68736007)(52116002)(305945005)(8676002)(8936002)(99286004)(106356001)(6116002)(3846002)(110136005)(107886003)(2906002)(256004)(316002)(81166006)(81156014)(54906003)(25786009)(14454004)(72206003)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4459;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5KW2URrHugDDoO9njMMHkDMLvMr2q2N75oRI9DaAPrswc8op5ODSChWDjxDUPAq0hvsu2U+Uh8rZQip+frTkFUDQsuTrm5ty5VziG/zsnDP1DuX/w8DeVKVYdZOiuSyGmPQPFWIn/w6htY0qq90WVHQzXDJ9SPFcEjbtpWUMHZn7lgxmpn8P/36nTNsQ7K/MsiRIRaPjslfWT656TdGHaA1+gsiWMarnj+w5f5r2j1Z5GJ11aa16quuNs1zMIIihLBCVkMBP58fgRLSTZvVFJSj7rYazeJAyRf1pALqCJBQFLwGWsajTGX++7+Bi7P0Bfh69LmjsRYxWs48P49lRGE5YWeReQ7WwO5lHcg8dQ8M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE9F8F3C2D7E084EA058249DA01044F1@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca12943-a25e-4032-72da-08d666749b7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 12:13:53.3706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgYWxsLA0KDQp0aGlzIGlzIG15IHRoaXJkIGF0dGVtcHQgdG8gZml4IHRoZSBzc2QxMzA3ZmIg
T0xFRCBkcml2ZXIgcmVzZXQuIEluIHRoZQ0Kc2Vjb25kIGF0dGVtcHQgWzFdIFJvYiBzdWdnZXN0
ZWQgdG8gdGFrZSBkaWZmZXJlbnQgYXByb2FjaC4gVGhhdCBpcyB0bw0KYXBwbHkgd2hhdCB3YXMg
b3JpZ2luYWx5IHBhcnQgb2YgdGhlIGZpcnN0IHJvdW5kIGFuZCBldmVudHVhbGx5IG1lcmdlZA0K
YnV0IHJldmVydGVkIGxhdGVyIG9uIFsyXVszXS4NCg0KTmV4dCBzdGVwIGlzIHRvIGFwcGx5IGEg
Zml4dXAgZm9yIHRoZSBzaW5nbGUgdXNlciAoaW4tdHJlZSkgdGhhdCB1c2VzDQp0aGlzIE9MRUQu
IEFzIFJvYiBzdWdnZXN0ZWQsIHRoZSBmaXh1cCBtYXkgYmUgYXBwbGllZCBvbmx5IGFmdGVyDQpz
b21lb25lIGNvbXBsYWlucyB0aGVpciBkaXNwbGF5IGJyb2tlLg0KDQpJIGFtIG5vdCByZWFsbHkg
c3VyZSB3aGF0IGlzIHRoZSBwcm9wcGVyIHdheSB0byBoYW5kbGUgdGhpcyBzbyB0aGUNCnNlcmll
cyBjb250YWlucyB0aGUgb3JpZ2luYWwgcGF0Y2hlcyArIGEgbWlub3IgZml4IGluIHRoZSBkb2Nz
IGFuZA0KdGhlIGZpeHVwIGFzIHRoZSBsYXN0IHBhdGNoLg0KDQpBZGRpbmcgQWxleGFuZHJlIGFu
ZCBNYXhpbWUgZnJvbSBCb290bGluIHRvIHRoZSBDYyBsaXN0IGFzIHlvdSBzZWVtDQp0byBiZSB0
aGUgbGFzdCBvbmVzIHdobyB0b3VjaGVkIHRoZSBDcnlzdGFsZm9udHogcGxhdGZvcm0uIFlvdXIg
Y29tZW50DQpyZWdhcmRpbmcgdGhlIHN0YXR1cyBvZiB0aGUgcGxhdGZvcm0gYW5kIHdoZXRoZXIg
dGhlIGZpeHVwIHNob3VsZCBiZQ0KYXBwbGllZCBzdHJhaWdodCBhd2F5IG9yIG5vdCBhdCBhbGwg
d2lsbCBiZSBhcHByZWNpYXRlZC4NCg0KVGhhbmsgeW91LA0KTWljaGFsDQoNClsxXSBodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwNjY1NTk3LyMyMjMyNzIyNw0KWzJdIGh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA2MTc3MjkvDQpbM10gaHR0cHM6Ly9wYXRj
aHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDYxNzczMS8jMjIyNTcxNzUNCg0KTWljaGFsIFZva8Oh
xI0gKDQpOg0KICBkdC1iaW5kaW5nczogZGlzcGxheTogc3NkMTMwN2ZiOiBSZW1vdmUgcmVzZXQt
YWN0aXZlLWxvdyBmcm9tIGV4YW1wbGVzDQogIHZpZGVvOiBzc2QxMzA3ZmI6IERvIG5vdCBoYXJk
IGNvZGUgYWN0aXZlLWxvdyByZXNldCBzZXF1ZW5jZQ0KICBBUk06IGR0czogaW14MjgtY2ZhMTAw
MzY6IEZpeCB0aGUgcmVzZXQgZ3BpbyBzaWduYWwgcG9sYXJpdHkNCiAgQVJNOiBteHM6IGNmYTEw
MDM2OiBGaXh1cCBPTEVEwqBkaXNwbGF5IHJlc2V0IHBvbGFyaXR5DQoNCiAuLi4vZGV2aWNldHJl
ZS9iaW5kaW5ncy9kaXNwbGF5L3NzZDEzMDdmYi50eHQgICAgICB8ICAyIC0NCiBhcmNoL2FybS9i
b290L2R0cy9pbXgyOC1jZmExMDAzNi5kdHMgICAgICAgICAgICAgICB8ICAzICstDQogYXJjaC9h
cm0vbWFjaC1teHMvbWFjaC1teHMuYyAgICAgICAgICAgICAgICAgICAgICAgfCA0NCArKysrKysr
KysrKysrKysrKysrKysrDQogZHJpdmVycy92aWRlby9mYmRldi9zc2QxMzA3ZmIuYyAgICAgICAg
ICAgICAgICAgICAgfCAgNCArLQ0KIDQgZmlsZXMgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKSwg
NSBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjEuNA0KDQo=
