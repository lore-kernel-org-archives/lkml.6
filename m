Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F2DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1361C20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=landisgyr.com header.i=@landisgyr.com header.b="l2Ya1AyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1361C20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=landisgyr.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409129AbeKWUTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:19:46 -0500
Received: from mail-eopbgr130127.outbound.protection.outlook.com ([40.107.13.127]:33815
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387987AbeKWUTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:19:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YM/MY8UKFllEOEmubel7q2TjxUWWKONwySE1py5xaE=;
 b=l2Ya1AyWh5cmGwTgvKN0+Is7jvBNAbFg+YR3HgJIRNwl1MCiq0r5iwnG6PVVbe46yni7kLzShR8B1XftURMTrZ/tbQuGuRL/9423hBah4RbYaSajxAah7saK38vnOQMA0xz/oGK7PafrOaPWeVSaeMmD68AklKA3e4xZA+jjJ/M=
Received: from AM6PR01MB4262.eurprd01.prod.exchangelabs.com (20.176.242.28) by
 AM6PR01MB5042.eurprd01.prod.exchangelabs.com (20.177.188.159) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.28; Fri, 23 Nov 2018 09:36:11 +0000
Received: from AM6PR01MB4262.eurprd01.prod.exchangelabs.com
 ([fe80::d547:38d1:d542:d499]) by AM6PR01MB4262.eurprd01.prod.exchangelabs.com
 ([fe80::d547:38d1:d542:d499%4]) with mapi id 15.20.1361.018; Fri, 23 Nov 2018
 09:36:11 +0000
From:   "Onnasch, Alexander (EXT)" <Alexander.Onnasch@landisgyr.com>
CC:     "Onnasch, Alexander (EXT)" <Alexander.Onnasch@landisgyr.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 net] phy: Micrel KSZ8061: link failure after cable connect
Thread-Topic: [PATCH v2 net] phy: Micrel KSZ8061: link failure after cable
 connect
Thread-Index: AQHUgw/47vC48FtyF0moC2bokhV8ng==
Date:   Fri, 23 Nov 2018 09:36:11 +0000
Message-ID: <1542965762-26822-1-git-send-email-alexander.onnasch@landisgyr.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0269.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::36) To AM6PR01MB4262.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:20::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [80.239.165.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR01MB5042;6:ZjmYOg5pgOhcnBkXKF1ftVKGbykFhzUJVlnWkNq/aWSDnJ6K5hXRWKa8l5XeR9bkpmlVCvaNwIUatWTJYxL25VsEFNW8RfMTfa3jMHuZXZZXlUlB94CmEKqDf2pLOxiNof6zbS6YutzsrnEWaU1WwJ91UrhQwwDKm7JOfgQHdnIEHBDp2se91Y+2maXeaT3Sj7uIHxYnNeYMHcIiAnXj2NiC7V/9UtghzgmQU+UoQ8F3enxR0y3vm15ut+rOtvp0OqpZGLW7gI8/O/Jg92LT/UQ8knFAvP20MQvkoHI/7SiaujfHdgqLf0djECoXiCE3d+cA9lYJwKOOUhbxgqxulS8tTMNWGaVwosW2Hdixz0gKEL82GkX83qhdsIB5PU5iCu7t3n4+fA3a81ER5T7hekBIkqbDbAl2bv80eJ5Ow0hq0X2a8z2M7dbF3UyhcwHKpFSW407T7e6uLXIG//6SRw==;5:VAzUUiNek7UyEaQh47DgDCyxWM0sgB8DtWvSy/t95c4hZSU3tZ6/Cnx7DUAKEImaZbiIeDuZ1u5l0Nc9ypRibbkWlC8eTWqFQUrUfYwfXM9wc4i7cQZVVzPqMU4tsJhlGFCI5H7eVSId4f3JXmOjPCC87vLoH+OB7Sic8aCIQMM=;7:kEEm3L49ze+C89Hy5cgLeiKReOpAlInEFn+I7+iOivZgpyN672Ctv/wUmPIkFj42dRYr+1A6Eg8wdTaGhFlybW12kMpTShr5eB4VzbSf/gYebpAECSjGzSgfW9m5+cj1nJwPFVEz5oVgVptBwRgR/w==
x-ms-office365-filtering-correlation-id: ff122224-ce7d-4f3a-00b1-08d651271a69
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR01MB5042;
x-ms-traffictypediagnostic: AM6PR01MB5042:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Onnasch@landisgyr.com; 
x-microsoft-antispam-prvs: <AM6PR01MB5042FEABBD671905AB354C99F0D40@AM6PR01MB5042.eurprd01.prod.exchangelabs.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR01MB5042;BCL:0;PCL:0;RULEID:;SRVR:AM6PR01MB5042;
x-forefront-prvs: 086597191B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(376002)(396003)(366004)(199004)(189003)(59246006)(5660300001)(106356001)(305945005)(6116002)(7736002)(105586002)(3846002)(54906003)(36756003)(72206003)(478600001)(316002)(25786009)(8676002)(2900100001)(66066001)(8936002)(14454004)(81156014)(81166006)(86362001)(97736004)(53936002)(1671002)(71200400001)(71190400001)(52116002)(6436002)(256004)(14444005)(109986005)(39060400002)(26005)(186003)(4326008)(68736007)(6506007)(102836004)(6512007)(386003)(476003)(2616005)(486006)(99286004)(2906002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR01MB5042;H:AM6PR01MB4262.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: landisgyr.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pt0AT2zWNihVdnmpkRFxt6dFMD/E2IimUpd6fngmRPzdcZ0MAtZ3926UTLJGtX6LJj/YTEHOYnNo8Ac3D0CW/L83mwzxfEMZHHSX2iQzimMTam/Hh5h980cyiJIMwmq31wXZoOS/zgr5mQVZLqaIep5XrsnuoUd96v7XrK1PJiKnqCAPae3AKL6oPZ5TW5YZB9dVNGYb4Su2dKi98OEBnoHqY5nWgOh5UdMVLSFk6lyX19PMW+aHaKt3N4sAnLsV2iAMrVbkF+dLXlaXhFKOqymuPn0oDd+yGcseUOp8THB8SZIW9PBND3AiqeyZOiF4aHnBmSWmXKMzfcLOm09K/HGhvkpOzBfQP5zvGG548tQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB5CE4F340454D4BBFE9076EFB33D40C@eurprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: landisgyr.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff122224-ce7d-4f3a-00b1-08d651271a69
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 09:36:11.0667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ee2cd48b-958f-4be4-9852-b8f104c001b9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR01MB5042
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2l0aCBNaWNyZWwgS1NaODA2MSBQSFksIHRoZSBsaW5rIG1heSBvY2Nhc2lvbmFsbHkgbm90IGNv
bWUgdXAgYWZ0ZXINCkV0aGVybmV0IGNhYmxlIGNvbm5lY3QuIFRoZSB2ZW5kb3IncyAoTWljcm9j
aGlwLCBmb3JtZXIgTWljcmVsKSBlcnJhdGENCnNoZWV0IDgwMDAwNjg4QS5wZGYgZGVzY3JpYmVz
IHRoZSBwcm9ibGVtIGFuZCBwb3NzaWJsZSB3b3JrYXJvdW5kcyBpbg0KZGV0YWlsLCBzZWUgYmVs
b3cuDQpUaGUgcGF0Y2ggaW1wbGVtZW50cyB3b3JrYXJvdW5kIDEsIHdoaWNoIHBlcm1hbmVudGx5
IGZpeGVzIHRoZSBpc3N1ZS4NCg0KREVTQ1JJUFRJT04NCkxpbmstdXAgbWF5IG5vdCBvY2N1ciBw
cm9wZXJseSB3aGVuIHRoZSBFdGhlcm5ldCBjYWJsZSBpcyBpbml0aWFsbHkNCmNvbm5lY3RlZC4g
VGhpcyBpc3N1ZSBvY2N1cnMgbW9yZSBjb21tb25seSB3aGVuIHRoZSBjYWJsZSBpcyBjb25uZWN0
ZWQNCnNsb3dseSwgYnV0IGl0IG1heSBvY2N1ciBhbnkgdGltZSBhIGNhYmxlIGlzIGNvbm5lY3Rl
ZC4gVGhpcyBpc3N1ZSBvY2N1cnMNCmluIHRoZSBhdXRvLW5lZ290aWF0aW9uIGNpcmN1aXQsIGFu
ZCB3aWxsIG5vdCBvY2N1ciBpZiBhdXRvLW5lZ290aWF0aW9uDQppcyBkaXNhYmxlZCAod2hpY2gg
cmVxdWlyZXMgdGhhdCB0aGUgdHdvIGxpbmsgcGFydG5lcnMgYmUgc2V0IHRvIHRoZQ0Kc2FtZSBz
cGVlZCBhbmQgZHVwbGV4KS4NCg0KRU5EIFVTRVIgSU1QTElDQVRJT05TDQpXaGVuIHRoaXMgaXNz
dWUgb2NjdXJzLCBsaW5rIGlzIG5vdCBlc3RhYmxpc2hlZC4gU3Vic2VxdWVudCBjYWJsZQ0KcGx1
Zy91bnBsdWcgY3ljbGVzIHdpbGwgbm90IGNvcnJlY3QgdGhlIGlzc3VlLg0KDQpXT1JLIEFST1VO
RA0KVGhlcmUgYXJlIGZvdXIgYXBwcm9hY2hlcyB0byB3b3JrIGFyb3VuZCB0aGlzIGlzc3VlOg0K
MS4gIFRoaXMgaXNzdWUgY2FuIGJlIHByZXZlbnRlZCBieSBzZXR0aW5nIGJpdCAxNSBpbiBNTUQg
ZGV2aWNlIGFkZHJlc3MgMSwNCiAgICByZWdpc3RlciAyLCBwcmlvciB0byBjb25uZWN0aW5nIHRo
ZSAgY2FibGUgb3IgcHJpb3IgdG8gc2V0dGluZyB0aGUNCiAgICBSZXN0YXJ0IEF1dG8tTmVnb3Rp
YXRpb24gYml0IGluIHJlZ2lzdGVyIDBoLlRoZSBNTUQgcmVnaXN0ZXJzIGFyZQ0KICAgIGFjY2Vz
c2VkIHZpYSB0aGUgaW5kaXJlY3QgYWNjZXNzIHJlZ2lzdGVycyBEaCBhbmQgRWgsIG9yIHZpYSB0
aGUgTWljcmVsDQogICAgRXRoVXRpbCB1dGlsaXR5IGFzIHNob3duIGhlcmU6DQogICAg4oCiICBJ
ZiB1c2luZyB0aGUgRXRoVXRpbCB1dGlsaXR5ICh1c3VhbGx5IHdpdGggYSBNaWNyZWwgS1NaODA2
MQ0KICAgICAgIEV2YWx1YXRpb24gQm9hcmQpLCB0eXBlIHRoZSBmb2xsb3dpbmcgY29tbWFuZHM6
DQogICAgICAgPiBhZGRyZXNzIDENCiAgICAgICA+IG1tZCAxDQogICAgICAgPiBpdyAyIGI2MWEN
CiAgICDigKIgIEFsdGVybmF0aXZlbHksIHdyaXRlIHRoZSBmb2xsb3dpbmcgcmVnaXN0ZXJzIHRv
IHdyaXRlIHRvIHRoZQ0KICAgICAgIGluZGlyZWN0IE1NRCByZWdpc3RlcjoNCiAgICAgICBXcml0
ZSByZWdpc3RlciBEaCwgZGF0YSAwMDAxaA0KICAgICAgIFdyaXRlIHJlZ2lzdGVyIEVoLCBkYXRh
IDAwMDJoDQogICAgICAgV3JpdGUgcmVnaXN0ZXIgRGgsIGRhdGEgNDAwMWgNCiAgICAgICBXcml0
ZSByZWdpc3RlciBFaCwgZGF0YSBCNjFBaA0KMi4gIFRoZSBpc3N1ZSBjYW4gYmUgYXZvaWRlZCBi
eSBkaXNhYmxpbmcgYXV0by1uZWdvdGlhdGlvbiBpbiB0aGUgS1NaODA2MSwNCiAgICBlaXRoZXIg
YnkgdGhlIHN0cmFwcGluZyBvcHRpb24sIG9yIGJ5IGNsZWFyaW5nIGJpdCAxMiBpbiByZWdpc3Rl
ciAwaC4NCiAgICBDYXJlIG11c3QgYmUgdGFrZW4gdG8gZW5zdXJlIHRoYXQgdGhlIEtTWjgwNjEg
YW5kIHRoZSBsaW5rIHBhcnRuZXINCiAgICB3aWxsIGxpbmsgd2l0aCB0aGUgc2FtZSBzcGVlZCBh
bmQgZHVwbGV4LiBOb3RlIHRoYXQgdGhlIEtTWjgwNjENCiAgICBkZWZhdWx0cyB0byBmdWxsLWR1
cGxleCB3aGVuIGF1dG8tbmVnb3RpYXRpb24gaXMgb2ZmLCBidXQgb3RoZXINCiAgICBkZXZpY2Vz
IG1heSBkZWZhdWx0IHRvIGhhbGYtZHVwbGV4IGluIHRoZSBldmVudCBvZiBmYWlsZWQNCiAgICBh
dXRvLW5lZ290aWF0aW9uLg0KMy4gIFRoZSBpc3N1ZSBjYW4gYmUgYXZvaWRlZCBieSBjb25uZWN0
aW5nIHRoZSBjYWJsZSBwcmlvciB0byBwb3dlcmluZy11cA0KICAgIG9yIHJlc2V0dGluZyB0aGUg
S1NaODA2MSwgYW5kIGxlYXZpbmcgaXQgcGx1Z2dlZCBpbiB0aGVyZWFmdGVyLg0KNC4gIElmIHRo
ZSBhYm92ZSBtZWFzdXJlcyBhcmUgbm90IHRha2VuIGFuZCB0aGUgcHJvYmxlbSBvY2N1cnMsIGxp
bmsgY2FuDQogICAgYmUgcmVjb3ZlcmVkIGJ5IHNldHRpbmcgdGhlIFJlc3RhcnQgQXV0by1OZWdv
dGlhdGlvbiBiaXQgaW4NCiAgICByZWdpc3RlciAwaCwgb3IgYnkgcmVzZXR0aW5nIG9yIHBvd2Vy
IGN5Y2xpbmcgdGhlIGRldmljZS4gUmVzZXQgbWF5DQogICAgYmUgZWl0aGVyIGhhcmR3YXJlIHJl
c2V0IG9yIHNvZnR3YXJlIHJlc2V0IChyZWdpc3RlciAwaCwgYml0IDE1KS4NCg0KUExBTg0KVGhp
cyBlcnJhdGEgd2lsbCBub3QgYmUgY29ycmVjdGVkIGluIGEgZnV0dXJlIHJldmlzaW9uLg0KDQpT
aWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgT25uYXNjaCA8YWxleGFuZGVyLm9ubmFzY2hAbGFuZGlz
Z3lyLmNvbT4NClJldmlld2VkLWJ5OiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQotLS0N
CiBkcml2ZXJzL25ldC9waHkvbWljcmVsLmMgfCAxMyArKysrKysrKysrKystDQogMSBmaWxlIGNo
YW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3BoeS9taWNyZWwuYyBiL2RyaXZlcnMvbmV0L3BoeS9taWNyZWwuYw0KaW5kZXgg
NmM0NWZmNi4uZWI4NWNmNCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3BoeS9taWNyZWwuYw0K
KysrIGIvZHJpdmVycy9uZXQvcGh5L21pY3JlbC5jDQpAQCAtMzM5LDYgKzMzOSwxNyBAQCBzdGF0
aWMgaW50IGtzejgwNDFfY29uZmlnX2FuZWcoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikNCiAJ
cmV0dXJuIGdlbnBoeV9jb25maWdfYW5lZyhwaHlkZXYpOw0KIH0NCiANCitzdGF0aWMgaW50IGtz
ejgwNjFfY29uZmlnX2luaXQoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikNCit7DQorCWludCBy
ZXQ7DQorDQorCXJldCA9IHBoeV93cml0ZV9tbWQocGh5ZGV2LCBNRElPX01NRF9QTUFQTUQsIE1E
SU9fREVWSUQxLCAweEI2MUEpOw0KKwlpZiAocmV0KQ0KKwkJcmV0dXJuIHJldDsNCisNCisJcmV0
dXJuIGtzenBoeV9jb25maWdfaW5pdChwaHlkZXYpOw0KK30NCisNCiBzdGF0aWMgaW50IGtzejkw
MjFfbG9hZF92YWx1ZXNfZnJvbV9vZihzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2LA0KIAkJCQkg
ICAgICAgY29uc3Qgc3RydWN0IGRldmljZV9ub2RlICpvZl9ub2RlLA0KIAkJCQkgICAgICAgdTE2
IHJlZywNCkBAIC05MzgsNyArOTQ5LDcgQEAgc3RhdGljIHN0cnVjdCBwaHlfZHJpdmVyIGtzcGh5
X2RyaXZlcltdID0gew0KIAkucGh5X2lkX21hc2sJPSBNSUNSRUxfUEhZX0lEX01BU0ssDQogCS5m
ZWF0dXJlcwk9IFBIWV9CQVNJQ19GRUFUVVJFUywNCiAJLmZsYWdzCQk9IFBIWV9IQVNfSU5URVJS
VVBULA0KLQkuY29uZmlnX2luaXQJPSBrc3pwaHlfY29uZmlnX2luaXQsDQorCS5jb25maWdfaW5p
dAk9IGtzejgwNjFfY29uZmlnX2luaXQsDQogCS5jb25maWdfYW5lZwk9IGdlbnBoeV9jb25maWdf
YW5lZywNCiAJLnJlYWRfc3RhdHVzCT0gZ2VucGh5X3JlYWRfc3RhdHVzLA0KIAkuYWNrX2ludGVy
cnVwdAk9IGtzenBoeV9hY2tfaW50ZXJydXB0LA0KLS0gDQoyLjcuNA0KDQo=
