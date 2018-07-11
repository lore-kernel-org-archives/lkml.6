Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53941C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98DA20B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RCQAAaCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98DA20B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeGKHIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:08:19 -0400
Received: from mail-he1eur01on0066.outbound.protection.outlook.com ([104.47.0.66]:62337
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbeGKHIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mb7MgQlK0Fi3TqytvVyFlB5ccK5QEg7o0rfX4hxCU2o=;
 b=RCQAAaCsInqtSC71O/8TscUkgWPihfXSd8b4rTmHTrgIIEoYe9W6Obe2KNVLEdX+DvV7QKIrxj6RfT6sPxdJxq4u0PqIXhiFcfE/L4wd85NVAN8LxECclmIvefUHZrMlnLeZAlx+cIopvhekc5DMTCrzzyj7KEvjUhCq0ZrmKX8=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB3110.eurprd04.prod.outlook.com (10.170.214.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Wed, 11 Jul 2018 07:05:24 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd%4]) with mapi id 15.20.0930.022; Wed, 11 Jul 2018
 07:05:24 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v1 1/4] dmaengine: imx-sdma: add memcpy interface
Thread-Topic: [PATCH v1 1/4] dmaengine: imx-sdma: add memcpy interface
Thread-Index: AQHUGCdnmbVt1awXk0GOfzs3jCNhZKSJj1wAgAAEOQCAAAX9gIAAAI3A
Date:   Wed, 11 Jul 2018 07:05:23 +0000
Message-ID: <DB6PR04MB32238D762101425CC0CEE0F2895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
 <1531239793-11781-2-git-send-email-yibin.gong@nxp.com>
 <20180711062434.x6waumlh6wtfmvzy@pengutronix.de>
 <DB6PR04MB3223B22099D9C7A079608409895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <20180711070107.roscdmzw4pbyvia6@pengutronix.de>
In-Reply-To: <20180711070107.roscdmzw4pbyvia6@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB3110;7:B436vh8RjCqd/8GBsmrURs2aUS0wfD+xdrFzWEkTZo7AucBSPHoYjCS9fSWHZiCrvQhIKskkx1lO5m66buMGC0zZatnnp14a6n6TrwYnFR1l92WXBaNR7PJs7urjTGCs/wpugjTidoumchfqF7uWSRalUhqSBpatscElYDUcfrqePc3HvvTrCAHoNotummbXV4fZyqpupPJgjRhZE0mLLHSFLLpGVWYvS2zwYiikJC/6lY1h75SNtDkECvHqqT4R
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e91761b5-fff5-4712-1481-08d5e6fcac67
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3110;
x-ms-traffictypediagnostic: DB6PR04MB3110:
x-microsoft-antispam-prvs: <DB6PR04MB3110FFC7D44CBC921BD700D2895A0@DB6PR04MB3110.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(189930954265078)(185117386973197)(258649278758335)(45079756050767)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3110;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3110;
x-forefront-prvs: 0730093765
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(366004)(136003)(13464003)(189003)(199004)(6506007)(8676002)(7696005)(81156014)(76176011)(2906002)(53546011)(6916009)(6116002)(8936002)(25786009)(68736007)(26005)(316002)(33656002)(5660300001)(966005)(4326008)(14454004)(53936002)(3846002)(6246003)(186003)(305945005)(74316002)(81166006)(7736002)(446003)(86362001)(99286004)(476003)(54906003)(486006)(102836004)(256004)(11346002)(478600001)(45080400002)(2900100001)(105586002)(106356001)(93886005)(6306002)(66066001)(5250100002)(229853002)(6436002)(97736004)(55016002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3110;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Hu6DoXcLYuo8dZS7H5hLq7O6H7PuogII9MErag4OTPlmvhhXs+R/gTkKQZKztNhYa3xD4a1bqE1YlZF7HpLt4z9xzkqII8X1bS+G79PC4EzxVoSrzRr6MQ7SvjymrH3NAm/2dGJcA8c7aXGYBJu9c23DRcRITvmU2DNV6j9caBEtSBqaOhP0w+BcfnHr+G9RPhPatbfzoTqc5+tFOB7OpwItFt41cwTMLENNYv6rpsB1SX42mtt2sxgbeMt+B9huX1NE8QVDLFDKfA4nO+k+zx6jdepN1VzL2bhmO4jSm9Q92K8nJdF7QAxxXAXigA2xjdGCye3QgUZ7zTn45TUYAGJMqtN3rYi/Xgqt0SW4kOo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91761b5-fff5-4712-1481-08d5e6fcac67
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2018 07:05:24.0106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2FzY2hhIEhhdWVyIFtt
YWlsdG86cy5oYXVlckBwZW5ndXRyb25peC5kZV0NCj4gU2VudDogMjAxOOW5tDfmnIgxMeaXpSAx
NTowMQ0KPiBUbzogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0KPiBDYzogdmtvdWxA
a2VybmVsLm9yZzsgZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tOyBzaGF3bmd1b0BrZXJuZWwub3Jn
OyBGYWJpbw0KPiBFc3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+OyBsaW51eEBhcm1saW51
eC5vcmcudWs7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsga2VybmVs
QHBlbmd1dHJvbml4LmRlOw0KPiBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlteEBueHAuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDEvNF0gZG1hZW5naW5lOiBpbXgtc2RtYTogYWRkIG1l
bWNweSBpbnRlcmZhY2UNCj4gDQo+IE9uIFdlZCwgSnVsIDExLCAyMDE4IGF0IDA2OjU2OjE4QU0g
KzAwMDAsIFJvYmluIEdvbmcgd3JvdGU6DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4gPiBGcm9tOiBTYXNjaGEgSGF1ZXIgW21haWx0bzpzLmhhdWVyQHBlbmd1dHJv
bml4LmRlXQ0KPiA+ID4gU2VudDogMjAxOOW5tDfmnIgxMeaXpSAxNDoyNQ0KPiA+ID4gVG86IFJv
YmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4NCj4gPiA+IENjOiB2a291bEBrZXJuZWwub3Jn
OyBkYW4uai53aWxsaWFtc0BpbnRlbC5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+ID4gPiBG
YWJpbyBFc3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+OyBsaW51eEBhcm1saW51eC5vcmcu
dWs7DQo+ID4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGtlcm5lbEBw
ZW5ndXRyb25peC5kZTsNCj4gPiA+IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxLzRdIGRtYWVuZ2luZTogaW14LXNk
bWE6IGFkZCBtZW1jcHkNCj4gPiA+IGludGVyZmFjZQ0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgSnVs
IDExLCAyMDE4IGF0IDEyOjIzOjEwQU0gKzA4MDAsIFJvYmluIEdvbmcgd3JvdGU6DQo+ID4gPiA+
IEFkZCBNRU1DUFkgc3VwcG9ydCwgbWVhbndoaWxlLCBhZGQgU0RNQV9CRF9NQVhfQ05UIGluc3Rl
YWQgb2YNCj4gPiA+ID4gJzB4ZmZmZicuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICtz
dGF0aWMgc3RydWN0IGRtYV9hc3luY190eF9kZXNjcmlwdG9yICpzZG1hX3ByZXBfbWVtY3B5KA0K
PiA+ID4gPiArCQlzdHJ1Y3QgZG1hX2NoYW4gKmNoYW4sIGRtYV9hZGRyX3QgZG1hX2RzdCwNCj4g
PiA+ID4gKwkJZG1hX2FkZHJfdCBkbWFfc3JjLCBzaXplX3QgbGVuLCB1bnNpZ25lZCBsb25nIGZs
YWdzKSB7DQo+ID4gPiA+ICsJc3RydWN0IHNkbWFfY2hhbm5lbCAqc2RtYWMgPSB0b19zZG1hX2No
YW4oY2hhbik7DQo+ID4gPiA+ICsJc3RydWN0IHNkbWFfZW5naW5lICpzZG1hID0gc2RtYWMtPnNk
bWE7DQo+ID4gPiA+ICsJaW50IGNoYW5uZWwgPSBzZG1hYy0+Y2hhbm5lbDsNCj4gPiA+ID4gKwlz
aXplX3QgY291bnQ7DQo+ID4gPiA+ICsJaW50IGkgPSAwLCBwYXJhbTsNCj4gPiA+ID4gKwlzdHJ1
Y3Qgc2RtYV9idWZmZXJfZGVzY3JpcHRvciAqYmQ7DQo+ID4gPiA+ICsJc3RydWN0IHNkbWFfZGVz
YyAqZGVzYzsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCWlmICghY2hhbiB8fCAhbGVuKQ0KPiA+ID4g
PiArCQlyZXR1cm4gTlVMTDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCWRldl9kYmcoc2RtYS0+ZGV2
LCAibWVtY3B5OiAlcGFkLT4lcGFkLCBsZW49JXp1LA0KPiBjaGFubmVsPSVkLlxuIiwNCj4gPiA+
ID4gKwkJJmRtYV9zcmMsICZkbWFfZHN0LCBsZW4sIGNoYW5uZWwpOw0KPiA+ID4gPiArDQo+ID4g
PiA+ICsJZGVzYyA9IHNkbWFfdHJhbnNmZXJfaW5pdChzZG1hYywgRE1BX01FTV9UT19NRU0sIGxl
biAvDQo+ID4gPiBTRE1BX0JEX01BWF9DTlQNCj4gPiA+ID4gKwkJCQkJKyAxKTsNCj4gPiA+ID4g
KwlpZiAoIWRlc2MpDQo+ID4gPiA+ICsJCWdvdG8gZXJyX291dDsNCj4gPiA+ID4gKw0KPiA+ID4g
PiArCWRvIHsNCj4gPiA+ID4gKwkJY291bnQgPSBtaW5fdChzaXplX3QsIGxlbiwgU0RNQV9CRF9N
QVhfQ05UKTsNCj4gPiA+DQo+ID4gPiBXaGVuIGxlbiBpcyBiaWdnZXIgdGhhbiAweGZmZmYgeW91
IGluaXRpYWxpemUgY291bnQgdG8gMHhmZmZmLi4uDQo+ID4gSW4gdGhpcyBjYXNlLCB0aGUgZGF0
YSB3aWxsIGJlIHNwbGl0IGludG8gc2V2ZXJhbCBiZHMsIGZvciBleGFtcGxlLCBJZg0KPiA+IHRo
ZSB0b3RhbCBjb3VudCBpcyAweDEwMDAwLCB0d28gYmQgdXNlZCB0aGVuLiBPbmUgaXMgZm9yIDB4
ZmZmZiwNCj4gPiBBbm90aGVyIGlzIGZvciB0aGUgbGFzdCAxDQo+IA0KPiBBbmQgeW91IGFyZSBk
b2luZyBieXRlIHNpemUgRE1BPyBXb3VsZG4ndCB3b3JkIHNpemUgYWNjZXNzZXMgYmUgbW9yZQ0K
PiBvcHRpbWFsPw0KPiANCj4gU2FzY2hhDQpEZWZhdWx0IGlzIHdvcmRzLCBhbmQgSSdsbCBmb3Jj
ZSB0aGUgYnVzd2lkdGggdG8gd29yZCBhbmQgc2V0IGludG8gQkQuDQpzZG1hLT5kbWFfZGV2aWNl
LmNvcHlfYWxpZ24gPSBETUFFTkdJTkVfQUxJR05fNF9CWVRFUzsNCj4gDQo+IA0KPiAtLQ0KPiBQ
ZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiB8DQo+IEluZHVz
dHJpYWwgTGludXggU29sdXRpb25zICAgICAgICAgICAgICAgICB8DQo+IGh0dHBzOi8vZW1lYTAx
LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnd3dy4N
Cj4gcGVuZ3V0cm9uaXguZGUlMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q3lpYmluLmdvbmclNDBueHAu
Y29tJTdDNDFmYmQNCj4gMzc2NWIxMDQyNGE3ZjFlMDhkNWU2ZmMxOTZkJTdDNjg2ZWExZDNiYzJi
NGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MNCj4gMCU3QzAlN0M2MzY2Njg4OTI3OTMwMzU4MjImYW1w
O3NkYXRhPW1MS2pUS2FvanVPMVp2JTJGNG9od2tremVLDQo+IEZERmJtcVl0dXJxaDZlU2JsSU0l
M0QmYW1wO3Jlc2VydmVkPTAgIHwNCj4gUGVpbmVyIFN0ci4gNi04LCAzMTEzNyBIaWxkZXNoZWlt
LCBHZXJtYW55IHwgUGhvbmU6ICs0OS01MTIxLTIwNjkxNy0wICAgIHwNCj4gQW10c2dlcmljaHQg
SGlsZGVzaGVpbSwgSFJBIDI2ODYgICAgICAgICAgIHwgRmF4Og0KPiArNDktNTEyMS0yMDY5MTct
NTU1NSB8DQo=
