Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93545C04EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF5320820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JWHskxEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF5320820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394462AbeKVVlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:41:04 -0500
Received: from mail-eopbgr10042.outbound.protection.outlook.com ([40.107.1.42]:64457
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387923AbeKVVlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:41:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4uOlPk9YGj/BEkkxNzLEtWLH+1839id1nhsA5NSavQ=;
 b=JWHskxEkqBUVZZXcfJIoKP2ypQH+Wk6x9iNzSYdsjxyBmqnP+eTdLn57tPnZf4KlhlPBEAPi1Q0S35cEDEe/kHMnY+LjfmJ3ym7c/+xg9hShdGoEwYIRl5SOAyvGwmMPwtv4IKjAbzv+Ux8I1eLu1WTOuHRRI3lgMJKq5ovx31U=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5586.eurprd04.prod.outlook.com (20.178.117.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Thu, 22 Nov 2018 11:01:56 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1339.029; Thu, 22 Nov 2018
 11:01:56 +0000
From:   Aisheng DONG <aisheng.dong@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 1/1] can: flexcan: Add self wakeup support
Thread-Topic: [PATCH V3 1/1] can: flexcan: Add self wakeup support
Thread-Index: AQHUeipzLGhxc+FcrUWbbTW8KJQ8BKVZnCKwgAIApICAABPTUA==
Date:   Thu, 22 Nov 2018 11:01:56 +0000
Message-ID: <AM0PR04MB4211E93B707BEBADD5E5B63E80DB0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20181112015047.4252-1-qiangqing.zhang@nxp.com>
 <20181112015047.4252-2-qiangqing.zhang@nxp.com>
 <AM0PR04MB4211BE08EADBACBEC809067E80DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <af4e2030-c54d-d613-972a-25769bdff199@pengutronix.de>
In-Reply-To: <af4e2030-c54d-d613-972a-25769bdff199@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5586;6:3Ybt/NWqRwR0k7G+kJzushhpzlLOtqb2YlYFiu0M+9yFcYidWfqLPROoFH+h741EzJKC7QEX9Dy5jTHNFEPpMRC1LI3rwAnz5BMfnOrh4q4Wjqwuo4YwTxA94VyjE9txsVcJLqlZs5a/AstevBLLNxX+FpgygOh2ppeJMbJjzPa8fSAwT1IdjBEGVmSJmXGGEUS4iQHOx8D4QXJWFi3iApvb0AhelWtk8UhwGgDNXzhIIi7PitMdLb0MYod/7qH7mfbRFt3dc5l7qoGIHreSJg8zRT/Jb44DA1hxkw22l4LWuBZttKQQDDccRdQRoDPUT5CFdJ9fNTqbTjWIG6BDYEhzDDTTF5yNBFKtc0+yK4vMXHNDzNvUcTRcAQGfkMAgkfjD69UQQouRwToegpsHGA9kRpYc/RRBwE0a5rDhmnRCYCX1kfOQAr25Py31eanz0IFG5QLrErQEGs8tDeRpug==;5:4QpKz3/56mQqaKPyfHW0N4AIdGgqiIk7Ib9asBA7QT5hceqI3hkZ7JLqK0+nJi1vPp2FB7Fju9q2w15ZyEBRVkfRY4nx59aBaeceXIuW6UmgnoDIEeZH4a8uytuycSohVv6hijrPhzhVxgIy3+yt377zHEs8w7IRG6CYntrOjwI=;7:gsMloJan4J4XQ6cqA18pP2876e16vzHO1v8r+TaDIJwIbZv5OtMV02zJBJXldu4mUAwaKeHSeHlvScCzrkstz+/x3AVztLFogqb/swZR4FWfv6VyqzXhtmcR+O35MqzLrQTYSbFpdOGNGwz8gQrLIQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1adaff5c-9c36-4035-117e-08d65069eb1a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5586;
x-ms-traffictypediagnostic: AM0PR04MB5586:
x-microsoft-antispam-prvs: <AM0PR04MB55860EAFE3C203DA48800E4680DB0@AM0PR04MB5586.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(4982022)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5586;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5586;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(366004)(376002)(189003)(199004)(53386004)(25786009)(6306002)(55016002)(9686003)(6246003)(966005)(8936002)(6506007)(8676002)(81156014)(81166006)(76176011)(71190400001)(71200400001)(53936002)(229853002)(4326008)(97736004)(105586002)(478600001)(14454004)(14444005)(256004)(86362001)(106356001)(66066001)(316002)(7736002)(2906002)(6436002)(54906003)(486006)(305945005)(110136005)(74316002)(2900100001)(2501003)(102836004)(446003)(26005)(33656002)(5660300001)(186003)(93886005)(99286004)(11346002)(476003)(68736007)(3846002)(6116002)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5586;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aO8LfwSGIEW6rzU9fQ/NSFU8FFJtDzMth+QycBDpdqH6DSn9NYKGmLvdXtgVhCOi5Yiy28o560DvtfwgSyGA/gth6Bd+JZhxIC/Q/ACGDdXF9nzxT/UVLcp9C19rFBBbOSzqR+L43HeLUNy09Nnv8qgxfJbT2oCRr8Xa9j8nmCEUygyS4Xg+o4a+SDjUPjXaw23w5by9uye171Dyk20LyXQqhlp4L5oGAXnHKETuoJCyO/BYyUgyeaMZKDD0wZHqd9G8d+PEIa6MXKilCMzW3IuzGMh5xpEhh1IZU/63LPDRGDcJj2fkXs01hMFCNHjfbNlellVF8JcjvM6OL154AyfPWjFXLass9Vggl2DF6BQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adaff5c-9c36-4035-117e-08d65069eb1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 11:01:56.4864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5586
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wy4uLl0NCj4gPj4gQEANCj4gPj4gLTE0MzcsMTAgKzE1NTIsMTggQEAgc3RhdGljIGludCBfX21h
eWJlX3VudXNlZCBmbGV4Y2FuX3N1c3BlbmQoc3RydWN0DQo+ID4+IGRldmljZSAqZGV2aWNlKQ0K
PiA+PiAgCWludCBlcnIgPSAwOw0KPiA+Pg0KPiA+PiAgCWlmIChuZXRpZl9ydW5uaW5nKGRldikp
IHsNCj4gPj4gLQkJZXJyID0gZmxleGNhbl9jaGlwX2Rpc2FibGUocHJpdik7DQo+ID4+IC0JCWlm
IChlcnIpDQo+ID4+IC0JCQlyZXR1cm4gZXJyOw0KPiA+PiAtCQllcnIgPSBwbV9ydW50aW1lX2Zv
cmNlX3N1c3BlbmQoZGV2aWNlKTsNCj4gPj4gKwkJLyogaWYgd2FrZXVwIGlzIGVuYWJsZWQsIGVu
dGVyIHN0b3AgbW9kZQ0KPiA+PiArCQkgKiBlbHNlIGVudGVyIGRpc2FibGVkIG1vZGUuDQo+ID4+
ICsJCSAqLw0KPiA+PiArCQlpZiAoZGV2aWNlX21heV93YWtldXAoZGV2aWNlKSkgew0KPiA+PiAr
CQkJZW5hYmxlX2lycV93YWtlKGRldi0+aXJxKTsNCj4gPj4gKwkJCWZsZXhjYW5fZW50ZXJfc3Rv
cF9tb2RlKHByaXYpOw0KPiA+PiArCQl9IGVsc2Ugew0KPiA+PiArCQkJZXJyID0gZmxleGNhbl9j
aGlwX2Rpc2FibGUocHJpdik7DQo+ID4+ICsJCQlpZiAoZXJyKQ0KPiA+PiArCQkJCXJldHVybiBl
cnI7DQo+ID4+ICsJCQllcnIgPSBwbV9ydW50aW1lX2ZvcmNlX3N1c3BlbmQoZGV2aWNlKTsNCj4g
Pg0KPiA+IFRoaXMgaXMgbWl4ZWQgd2l0aCBydW50aW1lIHBtLg0KPiA+IEkgd291bGQgc3VnZ2Vz
dGlvbiB5b3UgZmlyc3QgdXBzdHJlYW0gd2FrZXVwIHN1cHBvcnQuDQo+ID4gVGhlbiBydW50aW1l
IHBtIGxhdGVyIHNlcGFyYXRlbHkuDQo+IA0KPiBJbiBmYWN0IHRoaXMgcGF0Y2ggaXMgYmFzZWQg
b24gdGhlIHBhdGNoICJjYW46IGZsZXhjYW46IEltcGxlbWVudCBDQU4gUnVudGltZQ0KPiBQTSIs
IHdoaWNoIGlzIHN0aWxsIHVuZGVyIHJldmlldywgdG9vLg0KDQpZZXMsIHBsZWFzZSBpZ25vcmUg
cnBtIHBhdGNoIGZpcnN0Lg0KVGhpcyBwYXRjaCB3aWxsIGJlIHJlLW1hZGUgYW5kIG5vdCBkZXBl
bmRzIG9uIHJwbSBmb3IgZWFzeSByZXZpZXcuDQpBZnRlciB3YWtldXAgaXMgcmVhZHksIHJwbSBw
YXRjaCB3aWxsIHJlYmFzZSBvbiBpdC4NCg0KUmVnYXJkcw0KRG9uZyBBaXNoZW5nDQoNCj4gDQo+
IE1hcmMNCj4gDQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4gICAgICAgICAgICAgICAgICB8IE1h
cmMgS2xlaW5lLUJ1ZGRlICAgICAgICAgICB8DQo+IEluZHVzdHJpYWwgTGludXggU29sdXRpb25z
ICAgICAgICB8IFBob25lOiArNDktMjMxLTI4MjYtOTI0ICAgICB8DQo+IFZlcnRyZXR1bmcgV2Vz
dC9Eb3J0bXVuZCAgICAgICAgICB8IEZheDogICArNDktNTEyMS0yMDY5MTctNTU1NSB8DQo+IEFt
dHNnZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2ICB8IGh0dHA6Ly93d3cucGVuZ3V0cm9uaXgu
ZGUgICB8DQoNCg==
