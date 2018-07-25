Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA9FC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E83620844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="KQaloXYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E83620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbeGYMZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 08:25:47 -0400
Received: from mail-eopbgr30116.outbound.protection.outlook.com ([40.107.3.116]:23523
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728555AbeGYMZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 08:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3JjLA+woeb3ZGwOaBxIVFkzJA3oQonnQKJ7ho9BV/g=;
 b=KQaloXYLCraHoCXLLzijpMMzbXPv1WKfVNXoIu54rgZ+0cw4uIUbbgvjpR1YhjpU7xc/tIdl1QnIzTU05y0n8k+CTfYEWEJC+rUkBQK2une6XDV7tSeuwRIwZd94eeIfIkFTpuIazdkJ+Et80odKkzyQQJXNWQPvKK0+fSeZZP0=
Received: from DB6PR0501MB2583.eurprd05.prod.outlook.com (10.168.74.23) by
 DB6PR0501MB2566.eurprd05.prod.outlook.com (10.168.74.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.16; Wed, 25 Jul 2018 11:14:32 +0000
Received: from DB6PR0501MB2583.eurprd05.prod.outlook.com
 ([fe80::24a6:f7a1:3235:a6b9]) by DB6PR0501MB2583.eurprd05.prod.outlook.com
 ([fe80::24a6:f7a1:3235:a6b9%9]) with mapi id 15.20.0973.022; Wed, 25 Jul 2018
 11:14:32 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 15/26] ARM: tegra: colibri_t30: add i2c-thermtrip
Thread-Topic: [PATCH 15/26] ARM: tegra: colibri_t30: add i2c-thermtrip
Thread-Index: AQHUIoH3uDIsAAijakyZZiA66sKvx6SfzEwA
Date:   Wed, 25 Jul 2018 11:14:32 +0000
Message-ID: <1532517270.6124.39.camel@toradex.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
         <20180723123658.980-16-marcel@ziswiler.com>
In-Reply-To: <20180723123658.980-16-marcel@ziswiler.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0501MB2566;6:UQ1uPtPXZBrUtKZgcp/881o/UFFla9c7jEaIaE72s3NBB2n6CA1lpTZlKOPGvo0NMrNO0zFetRYsGVvbLV/p4ljAdLxhubk1POsX5NwNvle6VoBYmO8eHPZjjxKE76iGLACfxwjGkKzkSQIJKHxQwg2umnOpbhNjsXjaT1hP5O5J7VeVgxsOjeYjgvq8GfjtbDyqAZ70rXXTQgFWHTDx3XaRYpO4ITTjVyZkQRoHCIlfmOW2vhv4XghSqx1FWKYKCBVg3F5oVeIInWc2tyIEbSr0YHArTzyIVhzEntGr/hGVrEyUxJlXXXZNj0i0AhEmmEwb8Qs9joq7CDQ7KLpQJUbqRBpkGmx874wWRqslJJV+cuLFnwRK1BrX9pk23q8g3w6Gj/3NIhhepy/jl6UeqUPEtSZhZ1uj0Be3vCzzDvmsxanr4rIuAr8GYd6f+sHBv0K56T96DqnSMpoMqSEWEA==;5:ZyiCRvPXiPUGIsjSxOrcMJEf3bGZTg+wCvR+2ZRB2w/7eARBEPTvMsMKU0D1vOpypK6gy+3si/eoVAkiWxVeNSeeN+oXfgbtuauioeN260grO5/KqTmCkyhN5jIAAcqwRwqaQ82ZdDLGq5y3kYoZLNuCtYKv54exlc9rv5vnCT8=;7:Pgjxn4+uAnrBSTYQeegtPl9pSROO4pfh+SK51dkafZcWqPICgzeU40EdcrB2gtjNk4T9UNl1rh6ZpXLx1soab4qbFG4N63IsMk8y8BbBq6cNorpApD8hH6/OQsMt2Ujsgl9/4k441tzGWJQ9HmQFtdir7uBRU2hIyxxHmb+9c13k0q45iZhM9in5VmdiTmyYAmxsG+E4g4479HM8Szia/cBXE3GP/I/W0Osa7DSGeXTiuU3sR06MRxQpuvJkw9to
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 97164f7c-2f8b-45ee-4416-08d5f21fcc1a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0501MB2566;
x-ms-traffictypediagnostic: DB6PR0501MB2566:
x-microsoft-antispam-prvs: <DB6PR0501MB2566CB9D31B7AB37514A785AFB540@DB6PR0501MB2566.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0501MB2566;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0501MB2566;
x-forefront-prvs: 0744CFB5E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39840400004)(366004)(376002)(346002)(136003)(199004)(189003)(8936002)(66066001)(68736007)(8676002)(2900100001)(86362001)(81166006)(105586002)(14454004)(106356001)(2906002)(2501003)(2616005)(81156014)(476003)(486006)(256004)(6116002)(44832011)(3846002)(97736004)(2201001)(478600001)(5250100002)(6246003)(6512007)(102836004)(103116003)(26005)(6506007)(186003)(11346002)(4326008)(76176011)(39060400002)(25786009)(53936002)(229853002)(7736002)(6436002)(305945005)(446003)(5660300001)(54906003)(316002)(110136005)(99286004)(36756003)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0501MB2566;H:DB6PR0501MB2583.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hwIbfHqiN7YcW54aCfylAnS//NLJ81MSoBAI674cuD6ObP+VXmR/xIGZF9ogISJ3R+nkHWCHXt1FOwcakW/TKQp0YQeo88sjmJLpRFO227SjuaXXocdQHEeLPwE3zdtK/T0fVTQa+PtcQiFCQ1bp/5NPeiYUdlDDDZY3FsTw84m28pn3+fGMqvHyYHOCQDhsQeciBp0rdnWixZxj6fY7LVxgjOMAaWpYDHcVpaOdCURUcE/hbmPtKHZQX4Xll83+fICcTNDM65fOwKE2Dg+KS2r+AckW51O5z2Bdqbd02ISi2+fCzQI3qs89P0CaDdpUHQ3FTLT4kHA2C7/0gQ9ucVYUt8o1zXR4OwZNIhdPUi0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3EF246323F23249B9BC433CE55EEC69@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97164f7c-2f8b-45ee-4416-08d5f21fcc1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2018 11:14:32.4003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2566
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA3LTIzIGF0IDE0OjM2ICswMjAwLCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6
DQo+IEZyb206IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0K
PiANCj4gQWRkIGkyYy10aGVybXRyaXAgd2hpY2ggd291bGQgc2V0IHRoZSBERVZfT0ZGIGJpdCBp
biB0aGUgRENEQyBjb250cm9sDQo+IHJlZ2lzdGVyIG9mIHRoZSBUUFM2NTkxMSBQTUlDLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRl
eC5jb20+DQo+IA0KPiAtLS0NCj4gDQo+ICBhcmNoL2FybS9ib290L2R0cy90ZWdyYTMwLWNvbGli
cmkuZHRzaSB8IDggKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy90ZWdyYTMwLWNvbGlicmkuZHRz
aQ0KPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMzAtY29saWJyaS5kdHNpDQo+IGluZGV4IDgy
NjZlNDJlMTYzMC4uNjYwODI0M2UxZDU1IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0
cy90ZWdyYTMwLWNvbGlicmkuZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy90ZWdyYTMw
LWNvbGlicmkuZHRzaQ0KPiBAQCAtOTAyLDYgKzkwMiwxNCBAQA0KPiAgCQludmlkaWEsY29yZS1w
d3Itb2ZmLXRpbWUgPSA8MD47DQo+ICAJCW52aWRpYSxjb3JlLXBvd2VyLXJlcS1hY3RpdmUtaGln
aDsNCj4gIAkJbnZpZGlhLHN5cy1jbG9jay1yZXEtYWN0aXZlLWhpZ2g7DQo+ICsNCj4gKwkJLyog
U2V0IERFVl9PRkYgYml0IGluIERDREMgY29udHJvbCByZWdpc3RlciBvZg0KPiBUUFM2NTkxMSBQ
TUlDICovDQo+ICsJCWkyYy10aGVybXRyaXAgew0KPiArCQkJbnZpZGlhLGkyYy1jb250cm9sbGVy
LWlkID0gPDQ+Ow0KPiArCQkJbnZpZGlhLGJ1cy1hZGRyID0gPDB4MmQ+Ow0KPiArCQkJbnZpZGlh
LHJlZy1hZGRyID0gPDB4M2U+Ow0KDQpXaGVuIHJ1bm5pbmcgc29tZSBtb3JlIHRlc3RzIEkganVz
dCByZWFsaXplZCB0aGF0IHRoZSByZWctYWRkciBzaG91bGQNCnJlYWxseSBiZSAweDNmIGluc3Rl
YWQuIFdpbGwgY2hhbmdlIHRoaXMgaW4gYSB2Mi4NCg0KPiArCQkJbnZpZGlhLHJlZy1kYXRhID0g
PDB4MT47DQo+ICsJCX07DQo+ICAJfTsNCj4gIA0KPiAgCWFodWJANzAwODAwMDAgew==
