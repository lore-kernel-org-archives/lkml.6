Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5066FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D204D20820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O6/nQOnu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D204D20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404557AbeKVPrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 10:47:13 -0500
Received: from mail-eopbgr10061.outbound.protection.outlook.com ([40.107.1.61]:38385
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730366AbeKVPrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 10:47:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FijcK78HCSghpN1Qz5ZzIGgQQ+DadjRHevaldPZJMIk=;
 b=O6/nQOnuK/kxJ4VZd3riiksSlEqmB81eB37CQtpnjckaWlqHoNc6jzalr9ZW1vz2QSdeYsbkIP1MXjDLb9LBVIGhExdjN+0eXqPkHohsvTH0YtA27mUsJICWvzJ/Wmht6xHtnF/8fDEeOE4i/LwumcKIraRAf1z2iZHNjFSTCps=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5082.eurprd04.prod.outlook.com (20.176.235.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Thu, 22 Nov 2018 05:08:46 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b%3]) with mapi id 15.20.1339.029; Thu, 22 Nov 2018
 05:08:40 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Aisheng DONG <aisheng.dong@nxp.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 1/1] can: flexcan: add self wakeup support
Thread-Topic: [PATCH V4 1/1] can: flexcan: add self wakeup support
Thread-Index: AQHUgZY37Zcqeh+WZkOJKhpyijlTpaVbE5IAgAAnzvA=
Date:   Thu, 22 Nov 2018 05:08:40 +0000
Message-ID: <DB7PR04MB4618F4EB4EC48CE22F89BAD2E6DB0@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20181121122957.2684-1-qiangqing.zhang@nxp.com>
 <20181121122957.2684-2-qiangqing.zhang@nxp.com>
 <AM0PR04MB4211B8283948F8DB63115DD580DB0@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211B8283948F8DB63115DD580DB0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5082;6:DVS2xn2dhsbnZQiTg+hemszLUojQNuTQNqyTC2KBpUboxar8n8ZvSUj4pb9uaqpCYL/m393khxuK6ipVqIHMuyvxEA+YgX9vNQjOp3QTMUp+nvoO6Yx5H7kfSe7aSlKDbPS59NgYYvVZc6LDGp4wC9T2GpRwMnt+OpDef5F82CyEwTePwLZyMVOTt08Ph2Dc15e5dY1UB2bLqcX9yKxLSidg9qHi0EFaqAU/YXoJOO2iGy1GQ8V9Ke+sUJWs8JXE/zmnsZ4kYdhlaEbneCRHrP6Rtnz7Qzv0BpXc1Vtn/ScEuGiBvaXaXd6sENe2EVmW+A1+b9FQrp+x9Foed5Ev8roooPbuSSdFfD6BCWVN7H0XUWMXgYU86cOCK3rtRe8R4nWSVfkzDZt31B17MnlMZ5Arv/mMlKH5M2SEJEE9XHCDL1UdBhoEwUTL0izQFVk2tEo/jeNuWKhWfQmaD2mZcQ==;5:sdZwZ6wGJlG9JpFqJIBU033N2zFyZkaONJWxquu1xPCUU1cvLal6Qx6svaYdhNDOnJ/xVZ9x68q9GZywRrzKlvgnO9GwZTUhYa4sdpz3sB5TqmZYAugQiUKtF1m6AOlh28PO0MOHPzUpFK7CAhIA49gAfqgfQbbVTnsoLaXhOEA=;7:DGK3jXao/9QfZ2mR/p1AlVEkWyV6Lde1UGs42FF6XfE8Ve6cn2F423Nogl81CMNVoES2oTqzeksUqliY0VhOosy8/QmMyXmyRzXr+SywPsMtcH9LlbOfgfuq/epOxGplCphlitBpuVGyDMRUtJU+2g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cf4654e0-5394-43e9-5ef9-08d65038912c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5082;
x-ms-traffictypediagnostic: DB7PR04MB5082:
x-microsoft-antispam-prvs: <DB7PR04MB508298C6F333C61E29C65089E6DB0@DB7PR04MB5082.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5082;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5082;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(396003)(366004)(13464003)(189003)(199004)(81166006)(81156014)(53936002)(8676002)(316002)(26005)(71200400001)(71190400001)(99286004)(6116002)(3846002)(54906003)(110136005)(5660300001)(97736004)(33656002)(229853002)(11346002)(2900100001)(2906002)(186003)(55016002)(7696005)(76176011)(9686003)(7736002)(25786009)(2201001)(6436002)(478600001)(446003)(68736007)(6246003)(102836004)(86362001)(53546011)(106356001)(486006)(105586002)(6506007)(14454004)(8936002)(4326008)(476003)(256004)(74316002)(305945005)(66066001)(14444005)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5082;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EELIBI1gixCb6wzoidGUV8KKmeFbsVtcZbdxJI2eBSr9W/LFNNlc4XeRbPCJ70GHpIH5smkaNOmF8LAhrSLOqm2VoWz0L9a793BnjmEKzzcqZMAYMJ0u/nrgqTThwumBtsiXMSQC1y/CDLdIGmBmMs4nYrMfXzjkTnUwkpX2WF6ZTYNFh8fp76VqMW7NjfJm7ZZM5ShZ1/RMaoPNHxdMLFGFSQ2kwUl+ALvJzaHblZ84ChZZTkXG+/A1Wt+SUfJngBTk3HHiCZYF1tOSp24NHAVtmnCK6Dz3Mv0tNCDPe7p+4a8NKO7JZam6W3JXqbjDL5H3157WyrIOT5dM799/Xho7WuTZKDoGAVbACDz8Z7k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4654e0-5394-43e9-5ef9-08d65038912c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 05:08:40.2561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWlzaGVuZywNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFp
c2hlbmcgRE9ORw0KPiBTZW50OiAyMDE4xOoxMdTCMjLI1SAxMDozMQ0KPiBUbzogSm9ha2ltIFpo
YW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT47IGxpbnV4LWNhbkB2Z2VyLmtlcm5lbC5vcmc7
DQo+IG1rbEBwZW5ndXRyb25peC5kZQ0KPiBDYzogd2dAZ3JhbmRlZ2dlci5jb207IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+
DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggVjQgMS8xXSBjYW46IGZsZXhjYW46IGFkZCBzZWxmIHdh
a2V1cCBzdXBwb3J0DQo+IA0KPiBbLi4uXQ0KPiANCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgX19t
YXliZV91bnVzZWQgZmxleGNhbl9ub2lycV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UNCj4gPiArKmRl
dmljZSkgew0KPiA+ICsJc3RydWN0IG5ldF9kZXZpY2UgKmRldiA9IGRldl9nZXRfZHJ2ZGF0YShk
ZXZpY2UpOw0KPiA+ICsJc3RydWN0IGZsZXhjYW5fcHJpdiAqcHJpdiA9IG5ldGRldl9wcml2KGRl
dik7DQo+ID4gKw0KPiA+ICsJaWYgKG5ldGlmX3J1bm5pbmcoZGV2KSAmJiBkZXZpY2VfbWF5X3dh
a2V1cChkZXZpY2UpKQ0KPiA+ICsJCWZsZXhjYW5fZW5hYmxlX3dha2V1cF9pcnEocHJpdiwgdHJ1
ZSk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBp
bnQgX19tYXliZV91bnVzZWQgZmxleGNhbl9ub2lycV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2
aWNlKSB7DQo+ID4gKwlzdHJ1Y3QgbmV0X2RldmljZSAqZGV2ID0gZGV2X2dldF9kcnZkYXRhKGRl
dmljZSk7DQo+ID4gKwlzdHJ1Y3QgZmxleGNhbl9wcml2ICpwcml2ID0gbmV0ZGV2X3ByaXYoZGV2
KTsNCj4gPiArDQo+ID4gKwlpZiAobmV0aWZfcnVubmluZyhkZXYpICYmIGRldmljZV9tYXlfd2Fr
ZXVwKGRldmljZSkpIHsNCj4gPiArCQlkaXNhYmxlX2lycV93YWtlKGRldi0+aXJxKTsNCj4gDQo+
IEEgYml0IG1vcmUgdGhpbmtpbmc6DQo+IENhbiB3ZSBwdXQgZmxleGNhbl9lbmFibGVfd2FrZXVw
X2lycShwcml2LCBmYWxzZSkgaGVyZSBhbmQgbW92ZQ0KPiBkaXNhYmxlX2lycV93YWtlIHRvIHJl
c3VtZSBmdW5jdGlvbj8NCj4gVGhlbiBpdCBsb29rcyBiZXR0ZXIgb24gcGFpcnMgZm9yIHRob3Nl
IGZ1bmN0aW9ucy4NCj4gDQo+IEknbSBub3Qgc3VyZSBpZiBpcnEgd2lsbCBiZSBsb3N0IG9yIHdl
IG1heSBldmVuIG5vdCBuZWVkIHdha2V1cCBpcnEuDQo+IFBsZWFzZSBoZWxwIGNoZWNrIGl0Lg0K
DQoxLiBJIGhhdmUgdHJ5IHRoYXQgZmxleGNhbl9lbmFibGVfd2FrZXVwX2lycShwcml2LCBmYWxz
ZSkgY2FuIG1vdmUgaW50byBmbGV4Y2FuX25vaXJxX3Jlc3VtZSgpIGFuZCBkaXNhYmxlX2lycV93
YWtlKCkgY2FuIG1vdmUgaW50byBmbGV4Y2FuX3Jlc3VtZSgpLg0KICBJZiB5b3UgdGhpbmsgdGhh
dCBpcyBiZXR0ZXIsIEkgd2lsbCBtb2RpZnkgaXQuDQoNCjIuIElmIHdlIGRvbid0IGRpc2FibGUg
d2FrZXVwIGlycSBhZnRlciBpdCBleGl0cyBzdG9wIG1vZGUsIGl0IHdpbGwgY29udGludWUgZW50
ZXIgd2FrZXVwIGludGVycnVwdCBoYW5kbGUgZnVuY3Rpb24gd2hlbiB0aGUgd2FrZXVwIGV2ZW50
IGFycml2aW5nIGR1cmluZyBzdXNwZW5kIGFmdGVyDQogIHRoZSBzeXN0ZW0gaGFzIGRvbmUgb25j
ZSBtb3JlIHN1c3BlbmQvcmVzdW1lLg0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcNCg0K
PiBSZWdhcmRzDQo+IERvbmcgQWlzaGVuZw0KPiANCj4gPiArCQlmbGV4Y2FuX2V4aXRfc3RvcF9t
b2RlKHByaXYpOw0KPiA+ICAJfQ0KPiA+ICsNCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4N
Cj4gPiAtc3RhdGljIFNJTVBMRV9ERVZfUE1fT1BTKGZsZXhjYW5fcG1fb3BzLCBmbGV4Y2FuX3N1
c3BlbmQsDQo+ID4gZmxleGNhbl9yZXN1bWUpOw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGRl
dl9wbV9vcHMgZmxleGNhbl9wbV9vcHMgPSB7DQo+ID4gKwlTRVRfU1lTVEVNX1NMRUVQX1BNX09Q
UyhmbGV4Y2FuX3N1c3BlbmQsIGZsZXhjYW5fcmVzdW1lKQ0KPiA+ICsJU0VUX05PSVJRX1NZU1RF
TV9TTEVFUF9QTV9PUFMoZmxleGNhbl9ub2lycV9zdXNwZW5kLA0KPiA+ICtmbGV4Y2FuX25vaXJx
X3Jlc3VtZSkgfTsNCj4gPg0KPiA+ICBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBmbGV4
Y2FuX2RyaXZlciA9IHsNCj4gPiAgCS5kcml2ZXIgPSB7DQo+ID4gLS0NCj4gPiAyLjE3LjENCg0K
