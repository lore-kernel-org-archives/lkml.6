Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C3FC5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE2620869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="UgakgZ1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE2620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeJQDVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 23:21:21 -0400
Received: from mail-by2nam03on0137.outbound.protection.outlook.com ([104.47.42.137]:9728
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727154AbeJQDVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 23:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvE/qfmbi6kVyGEaAgq+XQklSKP9aRfFmwYE09wXlxQ=;
 b=UgakgZ1OuLsKXcvvm96hAnp29VvWAT5uCEqE9uZCLB5zMrJydJFLNI56PTHyihV2HCswBITGKTc891wAy8GYwYkNH6u6kuUxXKhKzvI/V90gz1EZ2qJF0gOIU+Uj7VFterVDCFu4+YYfCSNLzhqJRQPx6gFFEkdVv+TBEpdkTEE=
Received: from CY4PR0601MB3697.namprd06.prod.outlook.com (52.132.101.36) by
 CY4PR0601MB3747.namprd06.prod.outlook.com (52.132.101.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.20; Tue, 16 Oct 2018 19:29:21 +0000
Received: from CY4PR0601MB3697.namprd06.prod.outlook.com
 ([fe80::30a4:b4ca:8b09:7e87]) by CY4PR0601MB3697.namprd06.prod.outlook.com
 ([fe80::30a4:b4ca:8b09:7e87%3]) with mapi id 15.20.1228.027; Tue, 16 Oct 2018
 19:29:21 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "phil@raspberrypi.org" <phil@raspberrypi.org>
Subject: Re: [PATCH] spi: Make GPIO CSs honour the SPI_NO_CS flag
Thread-Topic: [PATCH] spi: Make GPIO CSs honour the SPI_NO_CS flag
Thread-Index: AQHUYg6qgVDgnl/GyEOPS7X1+cjlbqUgpz6AgADywwCAAK7zAA==
Date:   Tue, 16 Oct 2018 19:29:21 +0000
Message-ID: <1539718160.30311.10.camel@impinj.com>
References: <1539336198-84179-1-git-send-email-phil@raspberrypi.org>
         <1539628457.30311.5.camel@impinj.com> <20181016090310.GA7449@sirena.org.uk>
In-Reply-To: <20181016090310.GA7449@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR0601MB3747;6:7zH8h4rEJv6j31OxefhvFel309hm75pSWRv3PR896GQD+qIRdp8oQJ8xFanHGtchYN/XW2LFDkqgWiQmKnZhsGoLd5sVvQKWoffGGJhDQk2VroEkLjnOO3gKqGqND/vK/BKv2VeWJTHZtrnF+ug0E83I8/GyynCXv8q8KuUbcE5wF0u1pV6Sn8BeJsf89grmM4lBdB/MDMaFIcWDr7GenBl6jZ9URtNKebIBqI0KhHgt2Ma6FPF2FjVATiIJpPa3n7DTrEWkDfrflw2NvMnPljplXct2JaI/LZ16B9Ltg9HnuvgGR42u5Z5l12w+Bk4bpeFfYX1/siFBsd71Wg81Nckdo56fuLmJsyD3PRQAZEBmSEqFTFBU8yGUHFKy1Pm5dG479ueDD/kxLCnPffKUppYedu4V9ot/8eNhCj8KcBUsHC9yYOyjPG0pCpFLK7gVgJg0VqWS04Ts4MJ2ZsUlnw==;5:tg6GBQMcbskWy2d0fdQWHN3bZr0fVM4bFZciQLGE6Bir8du8m4iZ57xlGRQ2SxKpeKB7bS1r6j3pUArbvOci6v2wPON4v5bvl24BKJJbwJa1WwPlFDUtJbqS5lWCB+xWXNNWNSPiRcUwTQq/1TWm6id5Ocmy0jzFcdSj++NDH/M=;7:bGtTlRyy1BMWa0AWNIgiFV9MGntrWMKv20mWUl4xY598xaJvKxDo00rJHIpMkS+gHNd2Xiv9EjDf2Fx+K2r9qDax2yLfbhSNDa2T42cscTh47Ao6Ukd87tmhxwm85tutVzF4zwbi8/7O2+HK6JiEpJvXbjoiM97QXBAVqlXtV+LcPBfln6mRTUI+rCM/RBvuxmKoy37L2OzfKCAhyWC5l6hBiMeecpMKzoddeglJP5wQ/RZIslwEaxyP+o8zgqS0
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 63caf996-6b0e-4af5-d73f-08d6339dac73
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR0601MB3747;
x-ms-traffictypediagnostic: CY4PR0601MB3747:
x-microsoft-antispam-prvs: <CY4PR0601MB374795C6404F89CDE8ACD48CD3FE0@CY4PR0601MB3747.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991072);SRVR:CY4PR0601MB3747;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0601MB3747;
x-forefront-prvs: 0827D7ACB9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39850400004)(136003)(346002)(376002)(366004)(189003)(199004)(8936002)(476003)(2616005)(486006)(71190400001)(256004)(71200400001)(25786009)(66066001)(6916009)(5660300001)(478600001)(2906002)(2351001)(14454004)(105586002)(54906003)(106356001)(6506007)(81156014)(81166006)(7736002)(102836004)(11346002)(446003)(99286004)(6246003)(305945005)(86362001)(4326008)(68736007)(186003)(316002)(26005)(8676002)(1730700003)(229853002)(6512007)(5640700003)(6436002)(6486002)(2900100001)(4001150100001)(97736004)(36756003)(103116003)(76176011)(2501003)(53936002)(5250100002)(3846002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR0601MB3747;H:CY4PR0601MB3697.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: m5xu3q/DCU9xBqnLNL7KSQ7umBxOEGjWULIO2MhRIAzuetuANPRAHTOiU91edVI58Z5IzHmbiOaD7XbVQFI2XN2bbWg7ZyRNyrxfQrQZujmcV9ucevC50BBE4m5vFgqAmPa88fFXTZ2AmAqkWIDJRd2lsPokAlvV/HNngHkIoDxjEGjWWylUKvdmtZSh0S6hKu+mkNeHQPib4u+TWKRBS4CZDGivBaLoHv4jTk2GVFx0k3ATs/uPchM9maIBzlhfuFu1Pq71MVA7vsdOBihnP80e7u5RVkJE4Upck/2XytFU6JjCIJabgtAZ0+AIYeIWCm7ESU37CqPaX+Zwy2FX4TBTcNAaqX73WYaidaIzccs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E8EE9126C446A4DAB7C80A2BAA55DAA@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63caf996-6b0e-4af5-d73f-08d6339dac73
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2018 19:29:21.4808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0601MB3747
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTEwLTE2IGF0IDEwOjAzICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBNb24sIE9jdCAxNSwgMjAxOCBhdCAwNjozNDoxOFBNICswMDAwLCBUcmVudCBQaWVwaG8gd3Jv
dGU6DQo+IA0KPiA+IFdoYXQgYWJvdXQgdGhlIGNhbGxzIHRvIHNwaS0+Y29udHJvbGxlci0+c2V0
X2NzKCkgYWZ0ZXIgdGhpcz8gU2hvdWxkIGENCj4gPiBkcml2ZXIgcHJvdmlkZWQgc2V0X2NzIG1l
dGhvZCBiZSByZXNwb25zaWJsZSBmb3IgY2hlY2tpbmcgU1BJX05PX0NTPyANCj4gPiBPciBzaG91
bGQgaXQgbm90IGJlIGNhbGxlZCBpbiB0aGUgZmlyc3QgcGxhY2U/DQo+IA0KPiBUaGlzIHNlZW1z
IGxpa2Ugc29tZXRoaW5nIHRoYXQgc2hvdWxkIGJlIGRvbmUgZW50aXJlbHkgaW4gdGhlIGZyYW1l
d29yaywNCj4gbm8gcG9pbnQgaW4gZXZlcnkgc2luZ2xlIGRyaXZlciBoYXZpbmcgdG8gb3BlbiBj
b2RlIHRoZSBzYW1lIHRoaW5nLg0KPiANCj4gPiBJIGltYWdpbmUgaXQgZGVwZW5kcyBvbiB3aGF0
IHNldF9jcyBuZWVkcyB0byBkbywgd2hpY2ggbWlnaHQgbm90IGJlDQo+ID4gc29sZWx5IHJlbGF0
ZWQgdG8gY2hhbmdpbmcgdGhlIENTIGxpbmUuDQo+IA0KPiBJdCBzaG91bGQgYmUuICBJZiBzb21l
dGhpbmcgaXMgaGFuZ2luZyBvdGhlciB3b3JrIG9uIHNldF9jcygpIHRoZW4gaXQncw0KPiBnb2lu
ZyB0byBicmVhay4NCg0KSUlSQywgZm9yIHNwaS1kdyBzZXR0aW5nIENTIGlzIHRoZSBvbmx5IHdh
eSB0byB0cmlnZ2VyIHRoZSBtYXN0ZXIgdG8gZG8NCmFueXRoaW5nLiAgSSB0aGluayBvcmlvbiBp
cyB0aGUgc2FtZSB3YXkuICBFdmVuIGlmIHlvdSBkb24ndCB3YW50IGEgQ1MNCmxpbmUgdGhlIGRy
aXZlciBzdGlsbCBuZWVkcyB0byBhc3NlcnQgb25lLiAgV2hpY2ggQ1MgdG8gdXNlIGFzIHRoZQ0K
ZHVtbXkgQ1MgaXMgYSBjaGFsbGVuZ2UgdGhhdCBoYXMgY29tZSB1cCBiZWZvcmUuDQoNCmJjbTI4
MzVfc3BpX3NldF9jcygpIGRvZXMgY2hlY2sgU1BJX05PX0NTLCBidXQgaXQgc3RpbGwgZG9lcyBh
IGxvdCBvZg0Kb3RoZXIgc3R1ZmYgZXZlbiBpZiB0aGF0IGlzIHNldCwgbGlrZWx5IGJlY2F1c2Ug
b2YgdGhlIGFib3ZlIGlzc3VlLg==
