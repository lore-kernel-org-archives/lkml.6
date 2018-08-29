Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F936C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB322084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AbSpQadL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB322084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbeH2RMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:12:48 -0400
Received: from mail-db5eur01on0071.outbound.protection.outlook.com ([104.47.2.71]:51328
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727456AbeH2RMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3N1BDI5QX11eglwNBO6jCggS1shcadEhh8PyfJMsRI=;
 b=AbSpQadLN0PPbV9jIWNgcFajgDK3/DZ4jH3GMwI8RO13H9fW5kRZ1q7gGeXOxz2JdjNvLCV3TNEgQhVcqWPve39/XpFENSjS40FpEpNseIqTh2TLmFD7KU8R53qeOjIH0T2tKgOaV635clLdZF+9GJmfHVeRkAn1yTr73QWDt7M=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4020.eurprd04.prod.outlook.com (52.134.90.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 13:15:50 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5d61:a56c:c249:290]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5d61:a56c:c249:290%3]) with mapi id 15.20.1080.015; Wed, 29 Aug 2018
 13:15:50 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "thor.thayer@linux.intel.com" <thor.thayer@linux.intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: RE: [PATCH V4 4/4] video: simplefb: switch to use clk_bulk API to
 simplify clock operations
Thread-Topic: [PATCH V4 4/4] video: simplefb: switch to use clk_bulk API to
 simplify clock operations
Thread-Index: AQHUP5eSTlPLsghY6Um7RpYLGDyUjaTWsWKAgAADGCA=
Date:   Wed, 29 Aug 2018 13:15:50 +0000
Message-ID: <AM0PR04MB4211E934272EE1A212711FAE80090@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1535547100-25634-1-git-send-email-aisheng.dong@nxp.com>
 <1535547100-25634-5-git-send-email-aisheng.dong@nxp.com>
 <66eb6870-3674-0fdb-f5fb-4915a76191f6@redhat.com>
In-Reply-To: <66eb6870-3674-0fdb-f5fb-4915a76191f6@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4020;6:GkLp3JQ+l3EBzU/Rqj+GZvEaoWRzDHZLWUj/yfObRI7/s7ZipT0dHiOL1dvMwmQxMVs6cH/nxqQkw5Cn/9xPE7+fz2JcxaSPcCQh2Pf5mwxiD+tRlJAnqvJmqAacvT6JC99UIHqtgnQGJrRVULORD0eZkxib0I7kK+7yQg7k/crbziPBA6M8YIUBYbPmtjQII8ImUSIv7UGglmnyHzR8k1bH7In78R6QpEhj5Dkdz9apGc+OP+wLdeXACr3UYCflFcvNcEMhFz5j2a/R7aahY+C8y8723ngCIr6OKPs/Tnx2OkTghjNaCilLRMTF+TQgk8d71eI2MDkudPdCxVGk2x8CY8UMAf7vz1tlxoJdIAkUEeJII9beJAKn3ZtchzVl6wbLiDCrSpxrKbWkq5VwkrfulkbEvCSRBU0W14zSyFaCk3mzufNBJYZa86VGM4xTGEtpGT6bBx5npWoIKiQVEQ==;5:a88C7RVIRZ1HFnZGjA44fbe4EEOQsBHFcWX9H6JV3uD9vp43AgBr2QRx2nZHeMiCzgb06TCYz31oA6c4jtKd3aNSqWPwJvCm13WCVYAXO9CWkxaXMWG401H1efzZkmAk+Nn++rRPRBQNC8LprjFmnz7UPbqERWgGlDY1pF7hnp8=;7:9y5caI5AsInRAh2a/NK8LCVjVMZnRH8H55zw4laPbME0KwCatzVt6M7zN0mTP8/BhRcX6K2cCNzMQq1yFSx+fjnFRPjWkru0xZZ1Wwjmr+5z+oOTRC5TWlYK6gKdxwgXigBskR8d6mxPGaiakiih2sqtijW8zfKx3/sZy51WI2eOjOMnYNKF7YNDM5Yme8qJk1lMVctrjEFmkD9RM/o9qUucfp4hikaWDT92y49HtPW8XcYNYD99B8DzexMmcTN2
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e02f4e50-8a02-40ad-9214-08d60db18a8c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4020;
x-ms-traffictypediagnostic: AM0PR04MB4020:
x-microsoft-antispam-prvs: <AM0PR04MB4020E73BC7F036839C76E9BD80090@AM0PR04MB4020.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:AM0PR04MB4020;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4020;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(199004)(189003)(13464003)(8936002)(14444005)(97736004)(54906003)(55016002)(6246003)(5250100002)(9686003)(81166006)(476003)(110136005)(2501003)(11346002)(68736007)(53936002)(8676002)(6436002)(102836004)(186003)(446003)(6506007)(2906002)(486006)(26005)(316002)(3846002)(5660300001)(229853002)(33656002)(81156014)(6116002)(99286004)(66066001)(7736002)(305945005)(106356001)(74316002)(7696005)(2900100001)(478600001)(14454004)(76176011)(256004)(86362001)(4326008)(25786009)(7416002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4020;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VsKp2kX/a3xeMr8df2XVx20BuS4eYd2ARo9SgO/i4E4qR0lCTlA6hM2paeTe/iiJDvBn0DRCmsk1GrsRH4wXbwzauVybRkgItRR2Gbu+p1IByK+Yq4p0QckBpCcJ+5xGgIPdYculRP5qR4CxsbZEYzTMAoCj+f6vw/6F9fPMgIr5l6CJQEnpSm2ABWojFrikqc/Rs2I/Cg0jbEskGW/CXEwxl4dStrIaryoaCCGMZ3dH+gucWm6GhHKxsK2m5ivTJ8OjEwCl4L0YYFv/hIiCVY8qjcyOZviAkui1meq7N8QE8WIC9Qbgi/tDRhIQtuQHGHXFVCIqIYX9Xsgn7WgR1o0zvEjHsWqDA515JPYF/P8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e02f4e50-8a02-40ad-9214-08d60db18a8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 13:15:50.4032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYW5zIGRlIEdvZWRlIFttYWls
dG86aGRlZ29lZGVAcmVkaGF0LmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMjksIDIw
MTggOTowMSBQTQ0KDQpbLi4uXQ0KDQo+ID4gQEAgLTI1MiwzOSArMjI4LDIxIEBAIHN0YXRpYyBp
bnQgc2ltcGxlZmJfY2xvY2tzX2dldChzdHJ1Y3Qgc2ltcGxlZmJfcGFyDQo+ICpwYXIsDQo+ID4g
ICBzdGF0aWMgdm9pZCBzaW1wbGVmYl9jbG9ja3NfZW5hYmxlKHN0cnVjdCBzaW1wbGVmYl9wYXIg
KnBhciwNCj4gPiAgIAkJCQkgICBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAg
ew0KPiA+IC0JaW50IGksIHJldDsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJcmV0ID0g
Y2xrX2J1bGtfcHJlcGFyZV9lbmFibGUocGFyLT5jbGtfY291bnQsIHBhci0+Y2xrcyk7DQo+ID4g
KwlpZiAocmV0KQ0KPiA+ICsJCWRldl93YXJuKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gZW5hYmxl
IGNsb2Nrc1xuIik7DQo+IA0KPiBJZiBjbGtfYnVsa19wcmVwYXJlX2VuYWJsZSgpIGZhaWxzLCBp
dCBsZWF2ZXMgYWxsIGNsb2NrcyBkaXNhYmxlZCwgc28geW91IHNob3VsZA0KPiBub3Qgc2V0IHBh
ci0+Y2xrc19lbmFibGVkID0gdHJ1ZTsgdGhlbi4NCj4gDQoNClRoYW5rcyBmb3Igc3BvdHRpbmcg
dGhpcy4NClRoZSBvcmlnaW5hbCBjb2RlIHdhbnRlZCB0byBrZWVwIHRoZSBiZWhhdmlvciBhcyBi
ZWZvcmUuDQpCdXQgYSBiaXQgbW9yZSB0aGlua2luZyB0aGF0IHVubGlrZSB0aGUgZXhpc3QgY29k
ZSwgY2xrX2J1bGtfcHJlcGFyZV9lbmFibGUgd2lsbA0KYXV0b21hdGljYWxseSBkbyByZXZlcnNl
IGNsZWFuIHVwIG9uY2UgaXQgZmFpbHMuDQpTbyBubyBuZWVkIHRvIHNldCBwYXItPmNsa3NfZW5h
YmxlZCA9IHRydWUgYW55bW9yZS4NCg0KV2lsbCBmaXggaXQgYW5kIHJlc2VuZC4NCg0KUmVnYXJk
cw0KRG9uZyBBaXNoZW5nDQoNCj4gT3RoZXJ3aXNlIHRoaXMgcGF0Y2ggbG9va3MgZ29vZC4NCj4g
DQo+IFJlZ2FyZHMsDQo+IA0KPiBIYW5zDQo=
