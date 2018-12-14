Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE88C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81EBE206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="yznXgIlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbeLNQke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:40:34 -0500
Received: from mail-eopbgr150041.outbound.protection.outlook.com ([40.107.15.41]:24640
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729672AbeLNQke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PLml7wBhSI+w/Nxvs6/51jZ+I1XV3Uwd8BTliBO8do=;
 b=yznXgIlxHief0QN74+724Pn9HHES8cW+PcS/Mpnm6zP58O4W1Hw9rVo5tpkX/vAVaHD9uiw2F11T4nCjg58vNv5C05mvKIhKHedR/oJrTdxJbyyv10nmso9RMr2ij8ytmoSwi4GFKKTD3LOVE1a7C8cjeyVO6fF78M0bNGgYoBQ=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4204.eurprd04.prod.outlook.com (52.135.131.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Fri, 14 Dec 2018 16:40:30 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490%3]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 16:40:30 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <uwe@kleine-koenig.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [3/3] pwm: imx: Implement get_state() function for hardware
 readout
Thread-Topic: [3/3] pwm: imx: Implement get_state() function for hardware
 readout
Thread-Index: AQHUkgijcYBGTtAP70mgN1nU8kTgYKV+c18A
Date:   Fri, 14 Dec 2018 16:40:30 +0000
Message-ID: <37cc424e-cafd-acb6-d7d2-c6c98abf53de@ysoft.com>
References: <1538403588-68850-3-git-send-email-michal.vokac@ysoft.com>
 <20181212105118.GA9268@taurus.defre.kleine-koenig.org>
In-Reply-To: <20181212105118.GA9268@taurus.defre.kleine-koenig.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0202CA0011.eurprd02.prod.outlook.com
 (2603:10a6:803:14::24) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4204;6:pFjrei3UFGpZREF48YFRXvwQyicRZMlRH1kPHY4MdF1Oj6INJ5DHrEQfAeyPNitQnAX6XNKdtGsBYHv7W+kcHPCRZmgWGILUekWJS91m1I+5gkKPAzz9lhXoEvUyrWRU1wwB6zCOUDAnBKq8LNVndTAwd2q4bmQGKRgPfEeTypFn8Xsw5engcSGGxGmkWOwiQgiraqQDtR39g4Vl8FWdz3Wwko68S6K+dBTqZBrPgFlZ6wVPvCG8eAybkLTMzQAHbKlbJ4igi6BqE2JO5dUDk3MYRt0ZvN1PRkBCdPrdF0mqYQEyuHRreTWfqJvStEe6+xDyqzJxyJuj0bIAP2ILfD8WSh6ki2F2d8Ce6Ll3v5vtKUHGcjKJoj9aPYopFG1KUV9xTIz/uLBx9iI/60GUxKezTPqPw1Er/D63D2XHXK9lS3sfwKkUqF82YNlmFVpmhpiXtm5l42gcIAUYLRYOvA==;5:wXbF+IGxBEACYoPa7TbQ8G28bto/qDx4ngX5DnZdcyj79CPMlbY1WfjDsuztDxUBEW2fa/pD1Ln7WbkXNRGGbSGMRNFMfhBgLKlxAYr80o/E2LRqp9MIGUfWaYZgBveM2xVQckTeVQvCRexx6vUQARtcRh45Z8PIRYt3oA6QyJg=;7:5uza+eRnMdXfObs1DchYos56mDNgJLLfpcgbnPSlSGhjXy9x+r/A2xLmjJGnYvEoxQgIupzf2+Nkr4gtbsPvz+QZIwbz8wlNMrJbz38mHI62IO54JbvvykhZSd3hCgQyRgS/Ur0hT0gnQl7DjRm+tQ==
x-ms-office365-filtering-correlation-id: e1bb04cc-6cd4-49f9-7d19-08d661e2dc49
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4204;
x-ms-traffictypediagnostic: DB7PR04MB4204:
x-microsoft-antispam-prvs: <DB7PR04MB42045E8FD8C2C5849CB243369EA10@DB7PR04MB4204.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231475)(944501520)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4204;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4204;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39850400004)(396003)(136003)(199004)(189003)(386003)(6506007)(53546011)(6486002)(54906003)(6246003)(316002)(102836004)(66066001)(99286004)(6116002)(3846002)(2906002)(6916009)(71190400001)(76176011)(81166006)(5660300001)(71200400001)(36756003)(97736004)(25786009)(8936002)(31686004)(6512007)(256004)(14444005)(39060400002)(53936002)(66574011)(486006)(2616005)(11346002)(446003)(8676002)(52116002)(81156014)(476003)(4326008)(229853002)(31696002)(7736002)(305945005)(186003)(86362001)(478600001)(68736007)(72206003)(14454004)(106356001)(85182001)(105586002)(6436002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4204;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: il33yXLyoVRHjRkpPMGLMpvl7lCwBMlF8fSaq6DgJGIQBWUxMEohs108R5upET+/txEurj1rc5U3p6klbu+wvxRgtbbhhuSytWMR66sDKD3y1/qFCPi5kJcWB5tEGqqdoSrymIonvHfZjb7h1chNLRD5wqSFGycZvcJ55OMBh1vLT2c3gLHDGF8tZPA8V4IvOHWAajqUdPppUPvI63And21LNj8qWNgh5Sz9gVUB9XEBnp/KUAkuPMUfUcVE+WcbYB5/gZGB6JrXmONVxjmYU2ApI5t9y2p4gzCgnhEjMT5s8bA3WjJUJXnAj3DDVVL3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <000F27EA2DB23041AA4355250AD4BF89@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bb04cc-6cd4-49f9-7d19-08d661e2dc49
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 16:40:30.8072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIuMTIuMjAxOCAxMTo1MSwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+IEhlbGxvLA0K
PiANCj4gT24gTW9uLCBPY3QgMDEsIDIwMTggYXQgMDQ6MTk6NDhQTSArMDIwMCwgTWljaGFsIFZv
a8OhxI0gd3JvdGU6DQo+PiBJbXBsZW1lbnQgdGhlIGdldF9zdGF0ZSgpIGZ1bmN0aW9uIGFuZCBz
ZXQgdGhlIGluaXRpYWwgc3RhdGUgdG8gcmVmbGVjdA0KPj4gcmVhbCBzdGF0ZSBvZiB0aGUgaGFy
ZHdhcmUuIFRoaXMgYWxsb3dzIHRvIGtlZXAgdGhlIFBXTSBydW5uaW5nIGlmIGl0IHdhcw0KPj4g
ZW5hYmxlZCBpbiBib290bG9hZGVyLiBJdCBpcyB2ZXJ5IHNpbWlsYXIgdG8gdGhlIEdQSU8gYmVo
YXZpb3IuIEdQSU8gcGluDQo+PiBzZXQgYXMgb3V0cHV0IGluIGJvb3Rsb2FkZXIga2VlcCB0aGUg
c2FtZSBzZXR0aW5nIGluIExpbnV4IHVubGVzcyBpdCBpcw0KPj4gcmVjb25maWd1cmVkLg0KPj4N
Cj4+IElmIHdlIGZpbmQgdGhlIFBXTSBibG9jayBlbmFibGVkIHdlIG5lZWQgdG8gcHJlcGFyZSBh
bmQgZW5hYmxlIGl0cyBzb3VyY2UNCj4+IGNsb2NrIG90aGVyd2lzZSB0aGUgY2xvY2sgd2lsbCBi
ZSBkaXNhYmxlZCBsYXRlIGluIHRoZSBib290IGFzIHVudXNlZC4NCj4+IFRoYXQgd2lsbCBsZWF2
ZSB0aGUgUFdNIGluIGVuYWJsZWQgc3RhdGUgYnV0IHdpdGggZGlzYWJsZWQgY2xvY2suIFRoYXQg
aGFzDQo+PiBhIHNpZGUgZWZmZWN0IHRoYXQgdGhlIFBXTSBvdXRwdXQgaXMgbGVmdCBhdCBpdHMg
Y3VycmVudCBsZXZlbCBhdCB3aGljaA0KPj4gdGhlIGNsb2NrIHdhcyBkaXNhYmxlZC4gSXQgaXMg
dG90YWxseSBub24tZGV0ZXJtaW5pc3RpYyBhbmQgaXQgbWF5IGJlIExPVw0KPj4gb3IgSElHSC4N
Cj4gDQo+IERvZXMgdGhpcyBwcm9ibGVtIHN0aWxsIGV4aXN0IGlmIHRoZSBwd20taW14IGRyaXZl
ciBpcyBhIG1vZHVsZT8NCg0KWWVzLiBUaGUgc291cmNlIGNsb2NrIGZvciBQV00gaXMgc3RvcHBl
ZCBieSB0aGUgY2xvY2sgY29yZSBzaG9ydGx5DQpiZWZvcmUgaW5pdCBwcm9jZXNzIGlzIHN0YXJ0
ZWQgYW5kIGl0IGRvZXMgbm90IG1hdHRlciBpZiB0aGUgcHdtLWlteA0KZHJpdmVyIGlzIGJ1aWx0
IGFzIGEgbW9kdWxlIG9yIGJ1aWx0IGludG8gdGhlIGtlcm5lbC4NCg0KV2hlbiB0aGUgbW9kdWxl
IGlzIGxvYWRlZCwgdGhlIC5nZXRfc3RhdGUgZnVuY3Rpb24gaXMgZXhlY3V0ZWQgYW5kDQpyZWFk
cyB0aGUgUFdNIHJlZ2lzdGVycy4gSWYgdGhlIEVOIGJpdCBpcyBzZXQgdGhlIGNsb2NrIGlzIHN0
YXJ0ZWQNCmFuZCBQV00gY29udGludWVzIGZyb20gd2hlcmUgaXQgd2FzIHN0b3BwZWQuDQoNCk1p
Y2hhbA0K
