Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4609AC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037D720844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="WSD++b//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfBHOMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:12:38 -0500
Received: from mail-eopbgr130134.outbound.protection.outlook.com ([40.107.13.134]:36736
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727470AbfBHOMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVibLp9x6wA+Qecy0ynvF8r80s8bsOWqeBenHi34ovM=;
 b=WSD++b//qZJBkfHmzWq0xa6OjbDgzM1iUMOpgMMkasNUJTpimx3hhT3yuZA9ZkQntNS1jMK/6YzeXHdMC1zs7CDfT9meveIvsp4KHerOhzupbhFvjM7mUC9ZojCdEKL9HXow811qXiU+puSkpnfhDbTNT/LwNqluaix5LrkV+bo=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB5056.eurprd02.prod.outlook.com (20.178.14.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Fri, 8 Feb 2019 14:12:32 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::a1f1:5dc8:99c1:c590]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::a1f1:5dc8:99c1:c590%5]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 14:12:32 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mkarthik@nvidia.com" <mkarthik@nvidia.com>,
        "smohammed@nvidia.com" <smohammed@nvidia.com>,
        "talho@nvidia.com" <talho@nvidia.com>
CC:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH V15 3/6] i2c: tegra: fix maximum transfer size
Thread-Topic: [PATCH V15 3/6] i2c: tegra: fix maximum transfer size
Thread-Index: AQHUvy7NJBLrpTTPCEyyJI+oqzsy0KXU5U6AgAAEVgCAAPC2AIAAF+sA
Date:   Fri, 8 Feb 2019 14:12:31 +0000
Message-ID: <9e8f26bb-2159-6ca4-783e-91a73dac0823@axentia.se>
References: <1549576040-15907-1-git-send-email-skomatineni@nvidia.com>
 <1549576040-15907-3-git-send-email-skomatineni@nvidia.com>
 <1202cc91-cacf-673e-c32b-b4d1c78b71f2@gmail.com>
 <515cb722-c345-8dd6-dbe5-557dec0d1384@gmail.com>
 <a57f0374-8468-f24a-1743-b446b8260a46@gmail.com>
In-Reply-To: <a57f0374-8468-f24a-1743-b446b8260a46@gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR1001CA0001.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::11) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR02MB5056;6:hpTre5e8ubTZ0lPMSegZIu0Mw/C9YUY6Oh3cA1PcMEs1SRMYhrhWrpKNNmiRjl37of+k071j6XNY8ttd7MrOV/Wh4Md0bwH8ZJkZyNNBoAy99rXDSyBN4zeeMXNETQootCmB7ORrQJPbi+MkhyIVN+59mE2CPYadpTZU/GzEsHGGt0LsbvccYN3f17BsJaPrZYNgOVbhgbBE/h5mpWi/7yslkarC3GdSMCwuJo6JJqx535B1jxHBe1XbXYutB9VuOgEHU9P/nIEX51YQYx1/oJ9mk2MhctuopIA4gQCWcQeSE1RgpWyumx8RG/euhAk5xYoprDl18s3XKoiEm623IugJBm9dYrxUioqIwnXRweheIVcFlQhJhXxxx3czVINoEQoInc/l1wyQuviWHpR6gNURzVitIbpjfQ7oicxmZRYStr6lZANgi/xqIWzc4vje5m1Ux/JSPeL+sKOJS07geA==;5:YixWjEmR50HMcc4l8jI0seZy9L05SPpfsFJBnNti+KtjMt90azb6asKZCo/dVOCKfvmtsHhmiitKkv6ytEbDLV3bE4EfgUqoDPHEUSoHxEHFwv1oUtmKT5Vr3pR+89EMExqc4thE/3qVefl0RJ+bzAS0f5ISJi1v854laJ6xB3KF9m01WJ3LZiV1cP0txV+wloDzQgOdUtA7W6tGvK5E7Q==;7:/WdsXReAdcSr/ee+3PJf2vl0ryBP38KXh9P8ZnF6NKKgdmQzv0xMlWOLZCOAQFGnZIdBGqwB8iu+WU8oNs4HCw1JTl3/NT8bjeeuQ5Zvfm+/D9hlC1ed1QbcXbMcQxYGfI9Z0GaH7HZY/b1AHmDKVw==
x-ms-office365-filtering-correlation-id: c6b120f1-a848-464c-bb88-08d68dcf766e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB5056;
x-ms-traffictypediagnostic: VI1PR02MB5056:
x-microsoft-antispam-prvs: <VI1PR02MB50568D79AFAFDA603BCBE12CBC690@VI1PR02MB5056.eurprd02.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(136003)(39830400003)(396003)(366004)(376002)(346002)(199004)(189003)(65956001)(66066001)(65806001)(71190400001)(71200400001)(4326008)(36756003)(99286004)(93886005)(7736002)(316002)(305945005)(58126008)(54906003)(256004)(68736007)(110136005)(11346002)(446003)(6246003)(486006)(25786009)(2501003)(476003)(74482002)(2616005)(97736004)(6486002)(508600001)(31696002)(2201001)(102836004)(53936002)(2906002)(86362001)(6436002)(386003)(26005)(186003)(53546011)(6506007)(6116002)(64126003)(3846002)(14454004)(81166006)(81156014)(106356001)(8676002)(52116002)(76176011)(8936002)(65826007)(31686004)(6512007)(7416002)(105586002)(229853002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB5056;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2+LRtqzbWP5gm9OaHMJtK8L1qMXBrQvS7psN6b/x9aRf6VOz3oMbF3QxwsKwukvwh8crP9PYyRh3J9fr/NV5WUklXzoOkoV/p3N2fdi1ALy/kSrpQz3P0FVrEfbR8lohopONK5yVvzmTQHiZQxinXvQLqsp4O7AghQFbW1AVvHZMmTPPJq+bivUpN8I2ODLKRbzMhjsrZl/YTJbV2IMnFyStU3oEdQjaJpRBykqQ2KqmDmZgf1lSu7BtFYucp2s9YPddNQs5JT3cZyOz/J24/O42eXCTAxfpwvYHNyuGiQ7A3gdy9goQnym22jmEs9vnyHfnJUmQ7feeHrRSG1cKvS6F8YsN1k+hpJUep/NE0odWfwvFrP++PVcFgVBOrNQ4QEEsmFtGIrm0O7cmIbG9u7fsyhW1GCP7+/b7RtRfqj8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F24C5B0BABB034F8164F69C66B65F2C@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b120f1-a848-464c-bb88-08d68dcf766e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 14:12:29.5552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB5056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMi0wOCAxMzo0NiwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOg0KPiAwOC4wMi4yMDE5
IDE6MjUsIERtaXRyeSBPc2lwZW5rbyDQv9C40YjQtdGCOg0KPj4+IDA4LjAyLjIwMTkgMToxNiwg
U293amFueWEgS29tYXRpbmVuaSDQv9C40YjQtdGCOj4gDQo+Pj4+PiBUaGlzIGlzIHdyb25nLCA2
NTUzNSA9IDY0ICogMTAyNCAtIDEuDQo+Pj4+Pg0KPj4+Pj4gTGV0J3MganVzdCB1c2Ugc2l6ZS1j
b25zdGFudHMgcHJvdmlkZWQgYnkga2VybmVsOg0KPj4+Pj4NCj4+Pj4+IHN0YXRpYyBjb25zdCBz
dHJ1Y3QgaTJjX2FkYXB0ZXJfcXVpcmtzIHRlZ3JhX2kyY19xdWlya3MgPSB7DQo+Pj4+PiAJLmZs
YWdzID0gSTJDX0FRX05PX1pFUk9fTEVOLA0KPj4+Pj4gCS5tYXhfcmVhZF9sZW4gPSBTWl80SywN
Cj4+Pj4+IAkubWF4X3dyaXRlX2xlbiA9IFNaXzRLIC0gSTJDX1BBQ0tFVF9IRUFERVJfU0laRSwg
fTsNCj4+Pj4+DQo+Pj4+PiBzdGF0aWMgY29uc3Qgc3RydWN0IGkyY19hZGFwdGVyX3F1aXJrcyB0
ZWdyYTE5NF9pMmNfcXVpcmtzID0gew0KPj4+Pj4gCS5mbGFncyA9IEkyQ19BUV9OT19aRVJPX0xF
TiwNCj4+Pj4+IAkubWF4X3JlYWRfbGVuID0gU1pfNjRLLA0KPj4+Pj4gCS5tYXhfd3JpdGVfbGVu
ID0gU1pfNjRLIC0gSTJDX1BBQ0tFVF9IRUFERVJfU0laRSwgfTsNCj4+Pj4+DQo+Pj4+Pg0KPj4+
Pj4gSSdsbCB0YWtlIGEgbG9vayBhdCBvdGhlciBwYXRjaGVzIGxhdGVyIHRvZGF5LCBubyBuZWVk
IHRvIHNlbmQgb3V0IG5ldyB2ZXJzaW9uIHJpZ2h0IG5vdy4NCj4+Pj4+DQo+Pj4+Pg0KPj4+Pg0K
Pj4+PiBTSVpFXzY0SyBpcyAweDAwMDEwMDAwICg2NTUzNikNCj4+Pj4NCj4+Pj4gbXNnIGxlbiBp
cyB1MTYgYW5kIG1heCB0aGF0IGNhbiBiZSBzZXQgdG8gbXNnLmxlbiBpcyA2NTUzNQ0KPj4NCj4+
IEFoLCBva2F5LiBUaGVuIGl0IGxvb2tzIGFib3V0IHJpZ2h0LCBtYXliZSBpdCdzIHRpbWUgdG8g
Y2hhbmdlIHUxNiB0byB1MzIgaW4gdGhlIEkyQyBjb3JlLg0KPj4NCj4gDQo+IEhlcmUgaXMgbXkg
c3VnZ2VzdGlvbjoNCj4gDQo+IDEpIFVzZSBTWl80SyAvIFNaXzY0SyB0aGF0IEkgc3VnZ2VzdGVk
IGFib3ZlLg0KPiANCj4gMikgU3F1YXNoIHRoaXMgcGF0Y2ggaW50byB0aGUgRE1BLXBhdGNoLg0K
PiANCj4gMykgQWRkIGFub3RoZXIgcGF0Y2ggKGJlZm9yZSB0aGUgRE1BLXBhdGNoKSB0aGF0IGNo
YW5nZXMgbWF4X3JlYWRfbGVuL21heF93cml0ZV9sZW4gdHlwZXMgdG8gdTMyIGluIHRoZSBpbmNs
dWRlL2xpbnV4L2kyYy5oDQoNClRoYXQgaXMgYSBiaXQgbmFpdmUgYW5kIHdpbGwgbm90IGZseSBz
aW5jZSB0aGUgSTJDIGNvcmUgaGFzIGEgbWF4IG1lc3NhZ2UNCnNpemUgb2YgNjU1MzUuIFdoaWNo
IGlzIGV4cG9zZWQgdG8gdXNlciBzcGFjZS4uLg0KDQpHaXZlbiB0aGUgYWJvdmUsIHNheWluZyAu
bWF4X3JlYWRfbGVuID0gNjU1MzUgYSBOT1AgKGFuZCBpcyBpbiBmYWN0IG9taXR0ZWQNCmluIHBs
YWNlcyB3aGVyZSBpdCB3b3VsZCBiZSBuZWVkZWQgaWYgdGhlIHR5cGUgaXMgY2hhbmdlZCkuIEkg
c3VnZ2VzdCB0aGF0DQppdCBpcyBvbWl0dGVkIGhlcmUgYXMgd2VsbC4gQnV0IFNaXzY0SyAtIEky
Q19QQUNLRVRfSEVBREVSX1NJWkUgaXMgc3RpbGwNCm5lZWRlZCBvZiBjb3Vyc2UuIEF0IGxlYXN0
IGlmIEkyQ19QQUNLRVRfSEVBREVSX1NJWkUgaXMgZ3VhcmFudGVlZCB0byBiZQ0Kbm9uLXplcm8/
DQoNCkNoZWVycywNClBldGVyDQo=
