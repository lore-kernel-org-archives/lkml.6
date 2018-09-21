Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB346C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E7621547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A6OitNxl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E7621547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389338AbeIUNDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:03:24 -0400
Received: from mail-eopbgr00081.outbound.protection.outlook.com ([40.107.0.81]:3488
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388909AbeIUNDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEtMwUrMh4fCB6Kpir5G/ZUDTBAlnccJmmYEp9w3d4s=;
 b=A6OitNxlbqTCrqM+vSlMR5dnQTEzSXkTlsgA3go+SVZfRAGpJ4JvqdeQ/o3jfOfy8ftIGw6fjADgKhcHSITgmKpvPhSdlCfU9iz010pmO/xHti5nYNrxwpqo5I7F9OfwlUFASEeXOW/IXE5loBnaGJ2Est4KRzWu1A81bNSImeE=
Received: from AM6PR04MB4357.eurprd04.prod.outlook.com (52.135.167.33) by
 AM6PR04MB4054.eurprd04.prod.outlook.com (52.135.167.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Fri, 21 Sep 2018 07:15:48 +0000
Received: from AM6PR04MB4357.eurprd04.prod.outlook.com
 ([fe80::e955:4d48:f0eb:3fe]) by AM6PR04MB4357.eurprd04.prod.outlook.com
 ([fe80::e955:4d48:f0eb:3fe%2]) with mapi id 15.20.1143.017; Fri, 21 Sep 2018
 07:15:48 +0000
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     Chuanhua Han <chuanhua.han@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eha@deif.com" <eha@deif.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] spi: spi-mem: Adjust op len based on message/transfer
 size limitations
Thread-Topic: [PATCH] spi: spi-mem: Adjust op len based on message/transfer
 size limitations
Thread-Index: AQHUUXmXCcQwkdkPGU+yfSxV16yFYKT6UeZw
Date:   Fri, 21 Sep 2018 07:15:48 +0000
Message-ID: <AM6PR04MB435758E6422596CB5FB0E2B397120@AM6PR04MB4357.eurprd04.prod.outlook.com>
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
 <20180921070628.35153-3-chuanhua.han@nxp.com>
In-Reply-To: <20180921070628.35153-3-chuanhua.han@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chuanhua.han@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4054;6:KrcfjbG5EpXYzVbKbjIy0lPoYbVt75Fmg5+x9xDvyYGB9snWYekq9npIPeZvMs2Jd7Resj4SbXj2jPZOO3L0+2k8RMUXQDEnO2S2Gqzim/xXXPJHGbeVG1fZJSolC9O+Gu3toRoPk7k0/c/0D7VaAj7JOQsTTGa27zBdptS0P3F7zDVHLeMYISZK2Ufn0l0aKd+1ebTgotf6evo+rGaKh4m/PQDHk9q5XRN92lG6GeCK0PyM6S1R8DP7wLwY5Drl6YVylhdZ8V/6Mfum5cCyUAd+xsOr6tJG0Fl0YrF3grIhiNNBf4/xGa/mVyC+EKtgo8WBDviT5IFLqQ7BCj36ukKCHW23hG+OmNOYi7P67aHlryPS40cI/9G6nwyRS002N8TVsrpY3jCHYkEB5mVvHHGiUYV2iBAb71zCA9/0goMSxdrGg0xITItVSnj8p/PCmLnQGR1taBzbQYuOn5jGjg==;5:HOPLhxJUnYYMf33/whoXgDeVhrM88vld7iSgTCg9DDsTZP1Wz+nRGh+8cSgSURT0k9PIm9xTmEPoZw3HUadfa/fONfKX24csHtHchsNpzLhesWR+9eWSFA2Z9gpY11L6B02kQ21dgGTNNJDKef4HVwUR652biWH/UnPw2oypbG0=;7:/fDADmAJCUFOxBzvukM5Bi/G285MAZq6o6HX2PsyMJXV4qvSHSdsfDCdDraajauSehjvZysGYKl62xMJDXl4c4LuvVO63GaqTnLjMV1auC+ra5lFhXiijwsMi9SpHJQE+Y2n3Ktsj7LOKDsJtL5ONHI+gTmK+lCSLdSFciCLspy3TqiT1znw7OJOS7v4ix0edsUshmc1RnIgBIlqo15swr8d4S4cxM3i2QbpMhj85hzueHYoD1VNDgzQFUJlskg/
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a1004489-1e23-4ada-34ff-08d61f920e5b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4054;
x-ms-traffictypediagnostic: AM6PR04MB4054:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR04MB4054FD0E9C65E6E29E154A2397120@AM6PR04MB4054.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM6PR04MB4054;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4054;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(376002)(39860400002)(396003)(13464003)(199004)(189003)(25786009)(106356001)(4326008)(15650500001)(105586002)(33656002)(229853002)(68736007)(9686003)(6116002)(55016002)(3846002)(6436002)(256004)(54906003)(6246003)(110136005)(316002)(2906002)(97736004)(14454004)(74316002)(66066001)(7736002)(478600001)(305945005)(8936002)(102836004)(486006)(11346002)(446003)(53546011)(575784001)(476003)(86362001)(7696005)(76176011)(2900100001)(8676002)(99286004)(2501003)(81156014)(81166006)(5250100002)(26005)(6506007)(53936002)(5660300001)(71200400001)(71190400001)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4054;H:AM6PR04MB4357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: u69Y/qWOUcaweB8Nk/r/CLlYA0YJlo4+pfsKWzKpOIZsRGMY9kgqzIb5wZglHzoSv5VdLV6Nk5FAqTMGloK6d1efXqAvO7MDl1uQ+1y6JXeBFD9re8K/ozFbhJ4gV8v2cqn1ZSJD+9IjPVzTpK6iSvFVpiq4x/bqwFQmsg6YP4rEpXCB2no0M9/3WRaX/cPqCOYpTPwKTu8grxebxPyOgdW4df5oMp78br9ptqS1tBJ1CyYXyzCNFZEMX1eYstiTr1b+QXZ3m2RAhBHZvDAy042G7Dbmfpwh0ALBpHc2usqb9GCV6clXk44bL4d0Lf19yZyFOH5onq1t5GnJpqf4JUHH9juHjHroHsrvfWDOyHs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1004489-1e23-4ada-34ff-08d61f920e5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 07:15:48.4897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2h1YW5odWEgSGFuIDxj
aHVhbmh1YS5oYW5AbnhwLmNvbT4NCj4gU2VudDogMjAxOMTqOdTCMjHI1SAxNTowNg0KPiBUbzog
YnJvb25pZUBrZXJuZWwub3JnDQo+IENjOiBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBlaGFAZGVpZi5jb207DQo+IGJvcmlzLmJyZXppbGxv
bkBib290bGluLmNvbTsgQ2h1YW5odWEgSGFuIDxjaHVhbmh1YS5oYW5AbnhwLmNvbT47DQo+IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIXSBzcGk6IHNwaS1tZW06IEFk
anVzdCBvcCBsZW4gYmFzZWQgb24gbWVzc2FnZS90cmFuc2ZlciBzaXplDQo+IGxpbWl0YXRpb25z
DQo+IA0KPiBXZSBuZWVkIHRoYXQgdG8gYWRqdXN0IHRoZSBsZW4gb2YgdGhlIDJuZCB0cmFuc2Zl
ciAoY2FsbGVkIGRhdGEgaW4NCj4gc3BpLW1lbSkgaWYgaXQncyB0b28gbG9uZyB0byBmaXQgaW4g
YSBTUEkgbWVzc2FnZSBvciBTUEkgdHJhbnNmZXIuDQo+IA0KPiBGaXhlczogYzM2ZmYyNjZkYzgy
ICgic3BpOiBFeHRlbmQgdGhlIGNvcmUgdG8gZWFzZSBpbnRlZ3JhdGlvbiBvZiBTUEkgbWVtb3J5
DQo+IGNvbnRyb2xsZXJzIikNCj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBDaHVhbmh1YSBIYW4gPGNodWFuaHVhLmhhbkBueHAuY29tPg0KPiBSZXZpZXdl
ZC1ieTogQm9yaXMgQnJlemlsbG9uIDxib3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4NCj4gLS0tDQo+ICBk
cml2ZXJzL3NwaS9zcGktbWVtLmMgfCAxNSArKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvc3Bp
LW1lbS5jIGIvZHJpdmVycy9zcGkvc3BpLW1lbS5jIGluZGV4DQo+IDk5MDc3MGRmYTVjZi4uZWMw
YzI0ZTg3M2NkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktbWVtLmMNCj4gKysrIGIv
ZHJpdmVycy9zcGkvc3BpLW1lbS5jDQo+IEBAIC0zMjgsMTAgKzMyOCwyNSBAQCBFWFBPUlRfU1lN
Qk9MX0dQTChzcGlfbWVtX2V4ZWNfb3ApOw0KPiAgaW50IHNwaV9tZW1fYWRqdXN0X29wX3NpemUo
c3RydWN0IHNwaV9tZW0gKm1lbSwgc3RydWN0IHNwaV9tZW1fb3AgKm9wKQ0KPiB7DQo+ICAJc3Ry
dWN0IHNwaV9jb250cm9sbGVyICpjdGxyID0gbWVtLT5zcGktPmNvbnRyb2xsZXI7DQo+ICsJc2l6
ZV90IGxlbjsNCj4gKw0KPiArCWxlbiA9IHNpemVvZihvcC0+Y21kLm9wY29kZSkgKyBvcC0+YWRk
ci5uYnl0ZXMgKyBvcC0+ZHVtbXkubmJ5dGVzOw0KPiANCj4gIAlpZiAoY3Rsci0+bWVtX29wcyAm
JiBjdGxyLT5tZW1fb3BzLT5hZGp1c3Rfb3Bfc2l6ZSkNCj4gIAkJcmV0dXJuIGN0bHItPm1lbV9v
cHMtPmFkanVzdF9vcF9zaXplKG1lbSwgb3ApOw0KPiANCj4gKwlpZiAoIWN0bHItPm1lbV9vcHMg
fHwgIWN0bHItPm1lbV9vcHMtPmV4ZWNfb3ApIHsNCj4gKwkJaWYgKGxlbiA+IHNwaV9tYXhfdHJh
bnNmZXJfc2l6ZShtZW0tPnNwaSkpDQo+ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiArCQlv
cC0+ZGF0YS5uYnl0ZXMgPSBtaW4zKChzaXplX3Qpb3AtPmRhdGEubmJ5dGVzLA0KPiArCQkJCSAg
ICAgICBzcGlfbWF4X3RyYW5zZmVyX3NpemUobWVtLT5zcGkpLA0KPiArCQkJCSAgICAgICBzcGlf
bWF4X21lc3NhZ2Vfc2l6ZShtZW0tPnNwaSkgLQ0KPiArCQkJCSAgICAgICBsZW4pOw0KPiArCQlp
ZiAoIW9wLT5kYXRhLm5ieXRlcykNCj4gKwkJCXJldHVybiAtRUlOVkFMOw0KPiArCX0NCj4gKw0K
PiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJPTF9HUEwoc3BpX21lbV9hZGp1c3Rf
b3Bfc2l6ZSk7DQo+IC0tDQo+IDIuMTcuMQ0KSSdtIHJlYWxseSBzb3JyeSBmb3IgbXkgZXJyb3Ig
aW4gb3BlcmF0aW9uLCB0aGlzIGhhcyBiZWVuIGFwcGxpZWQgdG8gdGhlIGxhdGVzdCBrZXJuZWws
IHBsZWFzZSBpZ25vcmUgdGhpcyBwYXRjaCBpbiBlbWFpbCEhIQ0K
