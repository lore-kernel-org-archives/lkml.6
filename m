Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A754C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315C22098A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="kocpr8mi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315C22098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeJPCUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:20:47 -0400
Received: from mail-by2nam01on0110.outbound.protection.outlook.com ([104.47.34.110]:34643
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726588AbeJPCUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XSNIO3N92+vBJJ8nndHVkvyRVwukXcJHhmaC7Bz1Ls=;
 b=kocpr8miw0jGlGNReSrTgm+xZIbtwdI9EmTPqYkk1OVQhQ4q8OSlKTyZ05Ja2aY+dCoH/JTTod12B73gfLPd0P3Kr4/nzv2mKMsr7ldrmbvOoDpKux1qlZlumjoN5W/Nl2UuMaKF9RK9zbXP81g/alG8sIedAzeZXUS7imi9D6c=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3785.namprd06.prod.outlook.com (10.167.236.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.25; Mon, 15 Oct 2018 18:34:18 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f4ee:3633:74c0:ab4]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f4ee:3633:74c0:ab4%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 18:34:18 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "phil@raspberrypi.org" <phil@raspberrypi.org>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH] spi: Make GPIO CSs honour the SPI_NO_CS flag
Thread-Topic: [PATCH] spi: Make GPIO CSs honour the SPI_NO_CS flag
Thread-Index: AQHUYg6qgVDgnl/GyEOPS7X1+cjlbqUgpz6A
Date:   Mon, 15 Oct 2018 18:34:18 +0000
Message-ID: <1539628457.30311.5.camel@impinj.com>
References: <1539336198-84179-1-git-send-email-phil@raspberrypi.org>
In-Reply-To: <1539336198-84179-1-git-send-email-phil@raspberrypi.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3785;6:U74NuoyViKWGpQxdpfHdZPTcsS7W695bVanqKeGm3MJKSJSImdO6N+Pw/SXCqFePcJo99qL/pdfuQdlif0Hgzya6fw1moL/LhMXiKmQ5f7pbfvRS9/Isp5f2x3lOT08LkzySFiQ/RwQbNoK4p88oQTRwez+vsxyP8Braa2M1rbmqeRcqwfAGyVJFRhTG5G3GMYu4JZdNXlajyB0w7i2PPqhmIBCCONQDl0Cp4MjK0HLAvsJtT+C6kZin5Fvff+JmpWx+/qZt2fbB8ebZHL1jOGuLf9lUnFpUXg26UnCpeExH/1u0hI9Zt45VVQbu67HPdHv5+TkxPX9Eqq5wv3XG1k7m64tWqbnvllJcasPy0lknIHhaxSODUlca6SZrocWCOLunOU4M76t9ANlh018lHpnNyCtzsh9ZcHu4ZBz4+W7+D1qN480DxXcK+/zh4+ff0ULwGTwzbsd+MT7dM3Gz/Q==;5:hJcnY/E4EdLSK+Q1dUgYz0vcWimPNG+Jpe1N4LjikFttPIvX4/rHash3Tlz1n7tJIkG/OOyrQy2fxOmSx3ijLNfpcAlNU0n23h20TxKFgJ9gY3oqxINhjK8oIivJtwjhxC6ZWtom5QO9E5kn3vZF9bklT0Zw32Wib0uogNqqrw4=;7:AqHdoKMLzHJrTWFTIptlk9T0QzzZJo+IcRZ3nfZ7Y89I0hPLId0v2bcDbqAZ233fhiZTaZZL+m5TUuS9pmGNiAgtoaUbHZCEBO+r18j38BSig4Pvk6Dkb7McPfxa+Ju6d3IVuuERHA3bWS7MyZdkvQJk60C0RnHBehg9JhWZNulYKRiCnIb+bZ/1stXRqs9ruGgRoYLpkwL0RSs6t1gll8TSYlWa0EbMOEDj21KXHIWAkEc30xqVYDCs30BI1mfn
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e4b3f35c-109e-4db2-474f-08d632ccd16a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3785;
x-ms-traffictypediagnostic: MWHPR0601MB3785:
x-microsoft-antispam-prvs: <MWHPR0601MB378564E0C588B1230B5062FED3FD0@MWHPR0601MB3785.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(278428928389397);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991067);SRVR:MWHPR0601MB3785;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3785;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39850400004)(136003)(346002)(366004)(376002)(189003)(199004)(2906002)(99286004)(2616005)(71190400001)(476003)(256004)(71200400001)(3846002)(53936002)(8936002)(6116002)(478600001)(486006)(6506007)(86362001)(2501003)(4001150100001)(186003)(26005)(66066001)(97736004)(5250100002)(76176011)(316002)(102836004)(68736007)(2201001)(14454004)(229853002)(2900100001)(105586002)(6486002)(106356001)(6436002)(25786009)(305945005)(7736002)(5660300001)(103116003)(81166006)(6512007)(110136005)(8676002)(81156014)(446003)(11346002)(6246003)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3785;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2097IjMnnYTV3holaJ6Oxd2wf0ohd3Qr1jUoBxoeueBN9guin338NCKckDFAq33vpgdGvrvpb82ppMFhbVolzy5EKquCS9DypflGUGHVPdwk51XB5Of33rkI9MEdruSeV/WEhCAgPveB7VTQdumT/zrzcLwqLlphJUJrykkHb8g0AQ1Q9fwJizIXeULt10a23/801LKgPwPA1RmlYc0NtLRZuy+fhaXv3Es9x7EJY/KviyZ0MHSaSgpzJm/PUp+sTOdSyiGmnsC3GSM6zbpTY8TR4PLtKrJjAfgzwOT+OmSkHEKG0ZM951s9FGD6xh8012EHv5RMVjqS/hmIHNprKFU4vp8Ahkx6r+aJHuMAKqQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B933B9511D28C4FBC6B2214E1F2F79F@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b3f35c-109e-4db2-474f-08d632ccd16a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 18:34:18.5462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3785
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTEwLTEyIGF0IDEwOjIzICswMTAwLCBQaGlsIEVsd2VsbCB3cm90ZToNCj4g
VGhlIFNQSSBjb25maWd1cmF0aW9uIHN0YXRlIGluY2x1ZGVzIGFuIFNQSV9OT19DUyBmbGFnIHRo
YXQgZGlzYWJsZXMNCj4gYWxsIENTIGxpbmUgbWFuaXB1bGF0aW9uLCBmb3IgYXBwbGljYXRpb25z
IHRoYXQgd2FudCB0byBtYW5hZ2UgdGhlaXINCj4gb3duIGNoaXAgc2VsZWN0cy4gSG93ZXZlciwg
dGhpcyBmbGFnIGlzIGlnbm9yZWQgYnkgdGhlIEdQSU8gQ1MgY29kZQ0KPiBpbiB0aGUgU1BJIGZy
YW1ld29yay4NCg0KPiBAQCAtNzI5LDcgKzcyOSw5IEBAIHN0YXRpYyB2b2lkIHNwaV9zZXRfY3Mo
c3RydWN0IHNwaV9kZXZpY2UgKnNwaSwgYm9vbCBlbmFibGUpDQo+ICAJCWVuYWJsZSA9ICFlbmFi
bGU7DQo+ICANCj4gIAlpZiAoZ3Bpb19pc192YWxpZChzcGktPmNzX2dwaW8pKSB7DQo+IC0JCWdw
aW9fc2V0X3ZhbHVlKHNwaS0+Y3NfZ3BpbywgIWVuYWJsZSk7DQo+ICsJCS8qIEhvbm91ciB0aGUg
U1BJX05PX0NTIGZsYWcgKi8NCj4gKwkJaWYgKCEoc3BpLT5tb2RlICYgU1BJX05PX0NTKSkNCj4g
KwkJCWdwaW9fc2V0X3ZhbHVlKHNwaS0+Y3NfZ3BpbywgIWVuYWJsZSk7DQo+ICAJCS8qIFNvbWUg
U1BJIG1hc3RlcnMgbmVlZCBib3RoIEdQSU8gQ1MgJiBzbGF2ZV9zZWxlY3QgKi8NCj4gIAkJaWYg
KChzcGktPmNvbnRyb2xsZXItPmZsYWdzICYgU1BJX01BU1RFUl9HUElPX1NTKSAmJg0KPiAgCQkg
ICAgc3BpLT5jb250cm9sbGVyLT5zZXRfY3MpDQoNCldoYXQgYWJvdXQgdGhlIGNhbGxzIHRvIHNw
aS0+Y29udHJvbGxlci0+c2V0X2NzKCkgYWZ0ZXIgdGhpcz8gU2hvdWxkIGENCmRyaXZlciBwcm92
aWRlZCBzZXRfY3MgbWV0aG9kIGJlIHJlc3BvbnNpYmxlIGZvciBjaGVja2luZyBTUElfTk9fQ1M/
IA0KT3Igc2hvdWxkIGl0IG5vdCBiZSBjYWxsZWQgaW4gdGhlIGZpcnN0IHBsYWNlPw0KDQpJIGlt
YWdpbmUgaXQgZGVwZW5kcyBvbiB3aGF0IHNldF9jcyBuZWVkcyB0byBkbywgd2hpY2ggbWlnaHQg
bm90IGJlDQpzb2xlbHkgcmVsYXRlZCB0byBjaGFuZ2luZyB0aGUgQ1MgbGluZS4=
