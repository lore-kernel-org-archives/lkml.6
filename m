Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7BBC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28124208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LWuCKH2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28124208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732438AbeHBDtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 23:49:07 -0400
Received: from mail-eopbgr50085.outbound.protection.outlook.com ([40.107.5.85]:59904
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726839AbeHBDtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 23:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JY9Fg798TD5rOR4RSxFEwc+G3eK//jYoXqlrCBFLkY=;
 b=LWuCKH2/OT3vog+JpRWGvbeEHrAlZ3IVFwsYbrZM/qcCIol2LHbJOqPUcMT6aZURkG04nSovovZ7L3pH6Da4AJOMtZnD//W3tWFewOGGpH6IubJg5uxAjwZv6mcbLAqzn7qowL7jzgRmWDt6RkVdaf//Ieb3I+urnVEszamsenU=
Received: from AM4PR0401MB2260.eurprd04.prod.outlook.com (10.165.45.7) by
 AM4PR0401MB1873.eurprd04.prod.outlook.com (10.166.130.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 2 Aug 2018 02:00:20 +0000
Received: from AM4PR0401MB2260.eurprd04.prod.outlook.com
 ([fe80::cdbd:a535:32b1:255c]) by AM4PR0401MB2260.eurprd04.prod.outlook.com
 ([fe80::cdbd:a535:32b1:255c%7]) with mapi id 15.20.1017.010; Thu, 2 Aug 2018
 02:00:20 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Stefan Agner <stefan@agner.ch>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "krzk@kernel.org" <krzk@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: fec: check DMA addressing limitations
Thread-Topic: [PATCH] net: fec: check DMA addressing limitations
Thread-Index: AQHUKY0SPs9eOpnX9kGVrCAsh50anaSrs7Cw
Date:   Thu, 2 Aug 2018 02:00:19 +0000
Message-ID: <AM4PR0401MB22608258EB2B045E708A3779FF2C0@AM4PR0401MB2260.eurprd04.prod.outlook.com>
References: <20180801114449.21208-1-stefan@agner.ch>
In-Reply-To: <20180801114449.21208-1-stefan@agner.ch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR0401MB1873;6:bUVvJOzR4KrYc47EdFKEwUODX1uXjxuGqqFmFaCyjIfbHZAZNUW9od5EzydhgdE9fpCJBD+oZpGPq61wFFUn6emviJnDUDxH80nUnDQoJjWn3MjiohLm7Pi5JJT2WtjrwD6e7/iXWOG2R/Kj320uze+quSAY4p+obL6KDINL7LW78x8rDN2Wc00gQGzgPwrbNjoHDJN8gQUFyEQRsf0NmGqMdsqaPZcZlPz/+YTA92WyyZk38mGsmOSzEq0+M3By19bf9bUFfmD9jjVd9e1Y4prX26cs1Qg7H08IBNPM5CzdI2T1EYIvkRG+u1iJsGR/oNaSXwY8aww5by/JGEyr+ZUgk+FCc6tk0oIraPhTzHxckU1LadebyzEPCYv30cKVJeBvlk3vI+DtEC4hdQYSAIlApOCgFNSsql2XJ9qIO8iz0+pfaOri2IQPmcEq45jTP4bZhxjqdW4zZAXYmYTJZA==;5:YixwKaA4LpPo971OKIKoZJc8TM4cXFuTZxM48Z0xDv/Oi46Eo+DnS7YgUxUSalfrv1FmoCaAbU7JRErt8rKP8nLsfoxLp0fBNTlUqzxEj6VQsWvqexZVElmZuJ8mEDA6RhfkkZAJh/l+SOzbC3rNekhFtSUGxb2cIe9+8Fn2Q94=;7:NhM/NLHDUncYKynkLDmyZbcRAnH+A2vbfeIOIqvn0oFgU9Ua/meHo0p9U6mnkzcSgyeB/xMoXvLGoeDqI4F/wqHp4lmFdds5/fp8zNxcD+lsC+yu2yYN6eVdDHhLzfFR4OWanUBB9HDBgcGryCSdYpuuKmL9mi2qynHsw+eoB98F5iDRRToTo3WlOMJdqJm0suZD56r5VwqpHVvEna5m7PTLpIB1btu6m76UBfHbE5/svyoddN8NNwyI7GFdDJ0L
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fb96765b-db22-4003-85c5-08d5f81bb360
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB1873;
x-ms-traffictypediagnostic: AM4PR0401MB1873:
x-microsoft-antispam-prvs: <AM4PR0401MB1873F23C32C6E57ACB48C411FF2C0@AM4PR0401MB1873.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM4PR0401MB1873;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB1873;
x-forefront-prvs: 07521929C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(366004)(39860400002)(346002)(189003)(199004)(7696005)(53936002)(3846002)(6116002)(86362001)(575784001)(26005)(106356001)(6246003)(186003)(446003)(102836004)(25786009)(105586002)(4326008)(14454004)(2501003)(76176011)(5250100002)(486006)(6506007)(478600001)(33656002)(305945005)(5660300001)(55016002)(229853002)(9686003)(8676002)(7736002)(11346002)(256004)(68736007)(476003)(6436002)(74316002)(2900100001)(97736004)(54906003)(66066001)(2906002)(316002)(8936002)(110136005)(81156014)(81166006)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB1873;H:AM4PR0401MB2260.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2IApM+saJkdZVpTx3lSLKmtxgp/fFxkxRL9ECSNZPCUUEVCXQzl7spRnibO6m3hrsbgvklZOnM8OKdQhpCmQ/VzaCWgZml19M7tJfikwEMJT6RREB9IwXAz6W0uxeU3wSKimBVhcNvsnz6xzaA6qaYlzA6Jt6x/OA9QAak6iI6o714PWEYum5pr3kjF669KOz6yiwlG/Nvq3+rpE5/onwEmqwcMcYHBDA2jwo6My078N+VgkEvsodHnD0ajtc7LV35Lh0e7lCXig25dBfhl86XwOIZHyBLA8wxmetHbJTS6o3I8Du5otGYvy3CqGTNXubiRSuncxm+BfFPiCJAplc2/yikdv599UtVplb6UvseQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb96765b-db22-4003-85c5-08d5f81bb360
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2018 02:00:19.9145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB1873
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3RlZmFuIEFnbmVyIDxzdGVmYW5AYWduZXIuY2g+IFNlbnQ6IDIwMTjE6jjUwjHI1SAx
OTo0NQ0KPiBDaGVjayBETUEgYWRkcmVzc2luZyBsaW1pdGF0aW9ucyBhcyBzdWdnZXN0ZWQgYnkg
dGhlIERNQSBBUEkgaG93LXRvLg0KPiBUaGlzIGRvZXMgbm90IGZpeCBhIHBhcnRpY3VsYXIgaXNz
dWUgc2VlbiBidXQgaXMgY29uc2lkZXJlZCBnb29kIHN0eWxlLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogU3RlZmFuIEFnbmVyIDxzdGVmYW5AYWduZXIuY2g+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQv
ZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMgfCA2ICsrKysrKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNj
YWxlL2ZlY19tYWluLmMNCj4gaW5kZXggYzcyOTY2NTEwN2Y1Li5hZjBmYjIwMGU5MzYgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+ICsr
KyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+IEBAIC0zMTQ2
LDYgKzMxNDYsMTIgQEAgc3RhdGljIGludCBmZWNfZW5ldF9pbml0KHN0cnVjdCBuZXRfZGV2aWNl
DQo+ICpuZGV2KQ0KPiAgCWZlcC0+dHhfYWxpZ24gPSAweDM7DQo+ICAjZW5kaWYNCj4gDQo+ICsJ
LyogQ2hlY2sgbWFzayBvZiB0aGUgc3RyZWFtaW5nIGFuZCBjb2hlcmVudCBBUEkgKi8NCj4gKwlp
ZiAoZG1hX3NldF9tYXNrX2FuZF9jb2hlcmVudCgmZmVwLT5wZGV2LT5kZXYsDQo+IERNQV9CSVRf
TUFTSygzMikpKSB7DQo+ICsJCWRldl93YXJuKCZmZXAtPnBkZXYtPmRldiwgIk5vIHN1aXRhYmxl
IERNQSBhdmFpbGFibGVcbiIpOw0KPiArCQlyZXR1cm4gLUVOT0RFVjsNCkl0IGlzIGJldHRlcjoN
Cg0KcmV0ID0gZG1hX3NldF9tYXNrX2FuZF9jb2hlcmVudCgmZmVwLT5wZGV2LT5kZXYsIERNQV9C
SVRfTUFTSygzMikpOw0KaWYgKHJldCA8IDApIHsNCglkZXZfd2FybigmZmVwLT5wZGV2LT5kZXYs
ICJObyBzdWl0YWJsZSBETUEgYXZhaWxhYmxlXG4iKTsNCglyZXR1cm4gcmV0Ow0KfQ0KDQoNCklm
IHRoZSBwYXRjaCBhaW0gdG8gIk9GOiBEb24ndCBzZXQgZGVmYXVsdCBjb2hlcmVudCBETUEgbWFz
ayIsIEkgdGhpbmsgbm90IG9ubHkgdGhpcyBkcml2ZXIgbmVlZCB0byBhZGQgdGhlIERNQSBtYXNr
IGxpbWl0YXRpb25zLCAgbWFueSBvdGhlciBkcml2ZXJzIGFsc28gbmVlZC4NCg0KDQo+ICsJfQ0K
PiArDQo+ICAJZmVjX2VuZXRfYWxsb2NfcXVldWUobmRldik7DQo+IA0KPiAgCWJkX3NpemUgPSAo
ZmVwLT50b3RhbF90eF9yaW5nX3NpemUgKyBmZXAtPnRvdGFsX3J4X3Jpbmdfc2l6ZSkgKiBkc2l6
ZTsNCj4gLS0NCj4gMi4xOC4wDQoNCg==
