Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDFEC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31DF217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YsGzEqOA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GNzfCNup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfBEOGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:06:22 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26236 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfBEOGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549375581; x=1580911581;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CXH/29kEHTIuyiAzdOtzo3kO4MJt6uu+kCvIM4FkKjQ=;
  b=YsGzEqOA97eCUFyFbNWiY4BU6C8Jw4/06BuVe3ufefvd/k6bR0wpv2HV
   RdE51H1J0yxCqz6Ovk+5Nz2oqpm7IPWflY+njwkacg95qnlxQWED++AKT
   P06DSKAXt4J7LRU2ow/H/1yQjqJOCfg2ub0RLnT2Mh3p540pAUPoPXVAF
   aQ+yezA8ipiO/5rNWVo/NhlIGEc1nTA9cgqj3o3JssQPGp+zqOOJ83mZ0
   DO5ThaW/SGQOUoFsNL5k3ZSLk5Yna5ddscXxESZVZgrFR9bzX8nUg9UgY
   d9M72FQgBVlBpLkUAFaGUtNI6GkjEBbHhcyeQYmDmM9V7mM/WPGvrEjyZ
   A==;
X-IronPort-AV: E=Sophos;i="5.56,564,1539619200"; 
   d="scan'208";a="205635686"
Received: from mail-bn3nam01lp2051.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.51])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2019 22:06:14 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXH/29kEHTIuyiAzdOtzo3kO4MJt6uu+kCvIM4FkKjQ=;
 b=GNzfCNupWuno7VcBk+4VtVuEhD4PKvTu/NgID8G9pKVT+lf/mUq3WW4QDNkzvnFhazaO8j2yGroyn1sgKL+l3QB627cBN33BgE3gwWdbTR7XCCPDuQ34ZRXD9h4FTiiwLiBm2POipqcuHJqB+WBbNC9jPe8LbXj/E+kU8XeTQ80=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB5229.namprd04.prod.outlook.com (20.177.254.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Tue, 5 Feb 2019 14:06:12 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0%3]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 14:06:12 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Alex Lemberg <Alex.Lemberg@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] mmc: core: Calculate the discard arg only once
Thread-Topic: [PATCH 1/3] mmc: core: Calculate the discard arg only once
Thread-Index: AQHUu52aKriqS8ZswEOxYLyGNu4DXqXRN3IAgAAIhhA=
Date:   Tue, 5 Feb 2019 14:06:11 +0000
Message-ID: <SN6PR04MB4925571AA6EE81FD289F4BA4FC6E0@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1549183828-17316-1-git-send-email-avri.altman@wdc.com>
 <1549183828-17316-2-git-send-email-avri.altman@wdc.com>
 <CAPDyKFqO0RX-Nz+WDo6VA5Sqh-npJKkqfHN9cpH6gxMPo1tJPw@mail.gmail.com>
In-Reply-To: <CAPDyKFqO0RX-Nz+WDo6VA5Sqh-npJKkqfHN9cpH6gxMPo1tJPw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR04MB5229;6:YyOFzP+HjndNBszpCqJ/uXatg6pTS5gcqrXaB7t/1jj2ZMOoQeK2MsTbT7lg4etEWHmdssS6DZUSaPfnxbwrLwmrOXJjeaRDVcqbhxooWVi5UuGZLyEr7L5hZdLuZjet1TMZoH7RseeITEFdPXqsEO2Iir8xTY7B4aDRPDUAGodkqNVmAiKPm4haVTwFWJTzO3mgdFtl+GHGXWqfKMhNvc6Hu85QFXqM5uxhRJj5LuhElqQ9QjMJ0Nzqn5ub+5nX8pISbKjmAUzl97yrYMkK8l5Llw0Zhu9dUcNhI5wV2oj66Ok2kwdJUIltknNaDcZ0UHAI9QovkIMc3Ezy/D+AThsCCANU5HFKvrR55RvBZDYHQ/aVWsyamAlejiCXlTIXcSTN4bB/TOUuwg61AHikEoUCmZ+KZzY8IKnFxDyveP8jx5l/30PAWEvktcRwK4YDqBSUbYP95EE8WAsZxjgTkg==;5:hFhvYeiwl0LhbYkZXkD5yHvKFsmcUxT3asO8xNxHdrHGrDdFnOLL9gjnPMGHeDAqYkZ2zzVlTRVJNUAm1LDUQ/h7Nd3GrUZo0+WFbwNsTnpOKdkmIT6M8jSbG54R5Km0S4415ETESOduCsYWcGN0cPYoBoTr7vjfmqO8hEZYARDg/oSRKUpN7XVYNHvj4dgQCQkAsHrueUAg4iajW0p7Fg==;7:6+5xx8gxmV+VfE6m+z80a3TCSNgMc7alFg9OF3YkDCZ8L//PBx2mTCQlv4XkLCIuP6HSbO17IwW4Y9VZ6IkOjUZ1CX1KhuTKPbt0iUnGn8WHKR1wpS1mNUd60RPrLIq84AgrIwqZo6XVaVToOkxr0g==
x-ms-office365-filtering-correlation-id: 8199dd5a-5ed1-4869-82c8-08d68b7315a3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB5229;
x-ms-traffictypediagnostic: SN6PR04MB5229:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB522976547A55C719BE7ED26DFC6E0@SN6PR04MB5229.namprd04.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(376002)(396003)(39860400002)(54534003)(199004)(189003)(106356001)(186003)(26005)(81156014)(8676002)(3846002)(68736007)(6116002)(74316002)(102836004)(7696005)(76176011)(55016002)(446003)(316002)(66066001)(478600001)(72206003)(6506007)(6916009)(486006)(81166006)(8936002)(305945005)(476003)(7736002)(14454004)(6246003)(97736004)(4326008)(25786009)(9686003)(11346002)(6436002)(256004)(14444005)(33656002)(71200400001)(71190400001)(229853002)(2906002)(86362001)(105586002)(53936002)(54906003)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5229;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hrp3qGI9yTbf/Jm3q/bW1rmbhUregS9dPVXe06t1CD6aNP8251xecyuT0RhJ8gJ1Gwa7nl0ywDrH8JA9R7Xa7dqjcanluQokhbdX4VthfxksgAe1rYCalG+PyPPOXumL0XQH+QelTnLgYtdyjzSH1/tmxAKknTEUbvLjww5Tkf5W8fkcnq0x3KCoIF1qcd8vk65WXf1NBnmK4bpnaU6tv0UUkGzKiViFsNOjRLojQLf/Y/LoRMW7x5zKoXkJ915ayUGTyU8kfqNrzeg5LHmUXeY1EbOuE8vWefPOfe1C1Md91XkKXkZAHi/s9puQZijMF9t8Dj+0FFx/AomNPvgZBlYTmbRTvrwUUyvxhXAIMoJWCifTdvuALHeTiPzfkHYQ/Cnoh2UKLZ7YpFpu5YDL5Thw25tBjvL6WE5ZL2fRwpY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8199dd5a-5ed1-4869-82c8-08d68b7315a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 14:06:11.8930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBTdW4sIDMgRmViIDIwMTkgYXQgMDk6NTEsIEF2cmkgQWx0bWFuIDxhdnJpLmFsdG1hbkB3
ZGMuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoZSBkaXNjYXJkIGFyZyBpcyBhIHJlYWQtb25seSBl
eHRfY3NkIHBhcmFtZXRlciAtDQo+ID4gc2V0IGl0IG9uY2Ugb24gY2FyZCBpbml0Lg0KPiANCj4g
SSBsaWtlIHRoZSBpZGVhIGhlcmUuIFRoZXJlIGlzIHJlYWxseSBubyBwb2ludCBjaGVja2luZyB0
aGlzIGZvciBldmVyeQ0KPiBjb3JyZXNwb25kaW5nIHJlcXVlc3QsIG5pY2UhDQo+IA0KPiBIb3dl
dmVyLCB0aGUgImRpc2NhcmQgYXJnIiBpc24ndCBzcGVjaWZpYyB0byBlTU1DLCBhcyBpdCdzIGFs
c28gdXNlZA0KPiBmb3IgU0QgY2FyZHMuIFNvLCB0aGUgY2hhbmdlIGxvZyBpcyBhIGJpdCBtaXNz
LWxlYWRpbmcsIEkgdGhpbmsuIENhbg0KPiB5b3UgcGxlYXNlIGNsYXJpZnkgdGhpcy4NCkRvbmUu
DQoNCj4gPg0KPiA+ICsgICAgICAgLyogc2V0IGRpc2NhcmRfYXJnICovDQo+ID4gKyAgICAgICBp
ZiAobW1jX2Nhbl9kaXNjYXJkKGNhcmQpKQ0KPiA+ICsgICAgICAgICAgICAgICBjYXJkLT5kaXNj
YXJkX2FyZyA9IE1NQ19ESVNDQVJEX0FSRzsNCj4gPiArICAgICAgIGVsc2UgaWYgKG1tY19jYW5f
dHJpbShjYXJkKSkNCj4gPiArICAgICAgICAgICAgICAgY2FyZC0+ZGlzY2FyZF9hcmcgPSBNTUNf
VFJJTV9BUkc7DQo+ID4gKyAgICAgICBlbHNlDQo+ID4gKyAgICAgICAgICAgICAgIGNhcmQtPmRp
c2NhcmRfYXJnID0gTU1DX0VSQVNFX0FSRzsNCj4gDQo+IFlvdSBhcmUgYXNzaWduaW5nIGNhcmQt
PmRpc2NhcmRfYXJnIG9ubHkgZm9yIChlKU1NQywgd2hpbGUgSSB0aGluayB5b3UNCj4gc2hvdWxk
IGRvIHRoYXQgYWxzbyBmb3IgU0QuDQo+IA0KPiBJIGd1ZXNzIGl0IHByYWN0aWNlIGl0IGRvZXNu
J3QgbWF0dGVyLCBiZWNhdXNlIE1NQ19FUkFTRV9BUkcgaXMgemVyby4NCj4gQWx0aG91Z2gsIEkg
d291bGQgcHJlZmVyIHRvIGtlZXAgdGhlIGNvZGUgY29uc2lzdGVudCwgc28gSSB0aGluayB5b3UN
Cj4gc2hvdWxkIGFzc2lnbiBjYXJkLT5kaXNjYXJkX2FyZyBmb3IgZm9yIFNEIGNhcmRzIGFzIHdl
bGwuDQpEb25lLg0KDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW1jL2NhcmQuaCBi
L2luY2x1ZGUvbGludXgvbW1jL2NhcmQuaA0KPiA+IGluZGV4IGRlNzM3NzguLjQ0NzY0OGIgMTAw
NjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9tbWMvY2FyZC5oDQo+ID4gKysrIGIvaW5jbHVk
ZS9saW51eC9tbWMvY2FyZC5oDQo+ID4gQEAgLTMwOCw2ICszMDgsOCBAQCBzdHJ1Y3QgbW1jX2Nh
cmQgew0KPiA+ICAgICAgICAgdW5zaWduZWQgaW50ICAgIG5yX3BhcnRzOw0KPiA+DQo+ID4gICAg
ICAgICB1bnNpZ25lZCBpbnQgICAgICAgICAgICBib3VuY2VzejsgICAgICAgLyogQm91bmNlIGJ1
ZmZlciBzaXplICovDQo+ID4gKw0KPiA+ICsgICAgICAgdW5zaWduZWQgaW50ICAgICAgICAgICAg
ZGlzY2FyZF9hcmc7ICAgIC8qIGRpc2NhcmQgYXJncyAqLw0KPiANCj4gUGxlYXNlIG1vdmUgdGhp
cyBhIGNvdXBsZSBvZiBsaW5lcyBhYm92ZSwgY2xvc2UgdG8gdGhlIG90aGVyICJlcmFzZSINCj4g
cmVsYXRlZCB2YXJpYWJsZXMuDQpEb25lLg0KDQo+IA0KPiBZb3UgbWF5IGV2ZW4gY29uc2lkZXIg
dG8gcmVuYW1lIHRoZSBhcmcgdG8gImVyYXNlX2FyZyIsIGJ1dCBJIGhhdmUgbm8NCj4gc3Ryb25n
IG9waW5pb24gY2hhbmdpbmcgdG8gdGhhdC4NCkRvbmUuDQoNCj4gDQo+ID4gIH07DQo+ID4NCj4g
PiAgc3RhdGljIGlubGluZSBib29sIG1tY19sYXJnZV9zZWN0b3Ioc3RydWN0IG1tY19jYXJkICpj
YXJkKQ0KPiA+IC0tDQo+ID4gMS45LjENCj4gPg0KPiANCj4gS2luZCByZWdhcmRzDQo+IFVmZmUN
Cg==
