Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D31C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F65F20835
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="thUR7FdF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406246AbfBNJ43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:56:29 -0500
Received: from mail-eopbgr60078.outbound.protection.outlook.com ([40.107.6.78]:43936
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392838AbfBNJ42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2rgmQNynwy0hghpxKgelIwX8+0o4eT9NUh56sT6LZQ=;
 b=thUR7FdFx00gXVCalysmOI4RjqwFr3KmomXxEPyClmT68EVNj5c9Pm+bRch9DDQnvql6UpNGdVrsHiptgx2+gP0JkPKcdnVebmZ9STrivIFS5p+SXwEX8ar6wRIXn2tKslnAPPWiw3bPdHoIS9uGDJYYyvXDg4KK4u8ERvQxQ3Y=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4540.eurprd04.prod.outlook.com (52.135.138.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 14 Feb 2019 09:56:21 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::2083:76ce:c2b6:6a39]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::2083:76ce:c2b6:6a39%4]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 09:56:21 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] can: flexcan: fix timeout when set small bitrate
Thread-Topic: [PATCH] can: flexcan: fix timeout when set small bitrate
Thread-Index: AQHUuUiQ4yWIPYpxOkiOxPx7F+znnqXfJDqw
Date:   Thu, 14 Feb 2019 09:56:20 +0000
Message-ID: <DB7PR04MB4618F97F69DCCEA3853AAFDDE6670@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20190131093509.12613-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20190131093509.12613-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4896751d-2a8e-46e9-362b-08d69262ac14
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4540;
x-ms-traffictypediagnostic: DB7PR04MB4540:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtEQjdQUjA0TUI0NTQwOzIzOjJEQXVENTRtTFhDZ0xoY2ppUG81QzdXVUFw?=
 =?gb2312?B?TTZYdlRhTTlWdlRRb0J2VVZXMDJScW1JNXpLRHo1UHFTNHBITEFpTFplaG9w?=
 =?gb2312?B?Z1cweHlsYXJXRkpIWnBpcE56anBqak9zYXpkNnY5ZEkzWWJKRlFBdURDTkxX?=
 =?gb2312?B?YVk3a09FMmYrQ1pPVDUvaW8yL3hxbE1SRzloRC9uTzNjS01hOTNodDBoRXpN?=
 =?gb2312?B?OVJnSUVydHNiMEhoWUtlY3Brc3JDUjRmZk9rTEx1ODB6VmJVOUZXUzVYWFBx?=
 =?gb2312?B?czl1d3VKbUo1NElPb2JqNlFocWtjOG1wV1Vub1RvYTl6UnhxaVJDWC80ZHk4?=
 =?gb2312?B?b3ZOM1YvOWxIVjhxOEFIamk1clAralZIMVByRXRNQzJGK3hHMjBZRDh5NDVy?=
 =?gb2312?B?czhZbittOUxubFFVSSs5TkJmSTVmLy9MM3k2c3NGc3NqRjR0S1dYbzVibUhv?=
 =?gb2312?B?Z1ZSemd2c2NJNjdNTDMvREhmSUtGclhZVlhHSUY4bG1CazJsNjdIaWkxRVpv?=
 =?gb2312?B?TUlIZ0wxRzZBQXU0OUJDTWUwdFkwNStpS2ZibytYa3dGR1JFTUxiQWd1Vjlo?=
 =?gb2312?B?OTlnR240VWVuZHhCVHFhWUx5endDZWpXN1RmZFEzMXZuUVdTMTA2QTk3VnFO?=
 =?gb2312?B?a1ord1ZJZTlobFdlQnBkWHFLRFZabnUzUzRtWVVQcWtiM2JJZnZvWGF2ajdT?=
 =?gb2312?B?MmE0VDBsZDE5bW84Y2xqYjhWRXJ3Lzh3ZGdSVWNtb214ZTYzc24vTTdzT2w2?=
 =?gb2312?B?TE1jQjVseWkrUVR4M0RjUHFNSTZ3ajBadk8wbWdMa1VDT21ZSXIwYm1yMWUv?=
 =?gb2312?B?dUhOMmRQeE9NM3RmNlpNQU0raUFBWHcxQ2hnNW4rSys4NlZkbUdZbmFGMTF4?=
 =?gb2312?B?akJSWWtsN1JidDRNQi9QUENleFRoQ2VXUkZyTHpCWTA2TW15TDFUYkFLbFI5?=
 =?gb2312?B?bnlJUHRack9vR29oN1REeWowYUhMelR6Y2dSZEwwdUZwWXBLK2k0SFR2L2Zx?=
 =?gb2312?B?VFdZZGFHTjhFMEJDMk5rWnFHcU1DanBZSkp4RFhvTEQ0SHFJUHFWK1RhMkpZ?=
 =?gb2312?B?MUNFTE16TFF3aUVzR2pwMlhFTHlqb3BmRnUyeWsvbmhvdkUza3dBMUh4SGZh?=
 =?gb2312?B?Rk1HellwWEJlNUVHSlppSkhpcnhkTEVrSTF4Tk11ZFlRS2Zua1dIVHI3ekJT?=
 =?gb2312?B?Rnh6UmRlazI4OWdJMTZzL0ludlZmUUdjQWxxS1VZeXR6cEhoSExvbUVEQnYv?=
 =?gb2312?B?dEVvd3hIWTZyOHlhczZGTy9QaVRDQTVSWlVlOVdEaHlZdTNTMVVHUmxKOENt?=
 =?gb2312?B?UkcyRXNNRHpVNFBrSm9qeGp1dnFka0ZtTXh3Vnd0eVZuT1VtYUw4ZXZZcWwy?=
 =?gb2312?B?ODkvd2kzcGJYYnF5ODhRMEk2TVlMdnFabWc0Y2JZdkRqaTREOGRiRnhsWDNZ?=
 =?gb2312?B?clE1UlFOaWgxNHUwQTQ4V09uc0d6d2ZXbmRNLytwMzl5RU5QSFV2Y0FCOTBt?=
 =?gb2312?B?WXlFbmorbyt0VFRQOFBkd1FUU2dmQ0p3Rm94NmlzeDdIOHhVNjVXVVpWbnlt?=
 =?gb2312?B?VGRnUVFuQVEvYmdhRXNZZGFHT2NxaVBHSThvRExwanFYZVgwMGxLaXpPSHVU?=
 =?gb2312?B?Z3V1WW55WFRKTmpUUTVDQUY3N0cweXoxc2lFN0lIS1lHTWx3dGtGdHo0Tyt2?=
 =?gb2312?B?YXRhWVA2cytJVk5pUlIxTWZKYlJkNEZqTDJib0FyRk9Wbml4djhxVCtJcGNZ?=
 =?gb2312?B?eUNiMlVUU2hlSEJEbUNJdz09?=
x-microsoft-antispam-prvs: <DB7PR04MB4540713196A482603922ED09E6670@DB7PR04MB4540.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(376002)(136003)(366004)(13464003)(189003)(199004)(45904002)(106356001)(229853002)(2906002)(6436002)(478600001)(99286004)(14454004)(66066001)(54906003)(105586002)(110136005)(316002)(2501003)(11346002)(446003)(6246003)(97736004)(6116002)(3846002)(7736002)(486006)(476003)(4326008)(71190400001)(71200400001)(305945005)(25786009)(53546011)(14444005)(186003)(68736007)(256004)(9686003)(26005)(6506007)(76176011)(74316002)(7696005)(53936002)(33656002)(81156014)(81166006)(86362001)(569044001)(8936002)(8676002)(55016002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4540;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kLl+UO8dAcohFkcRi1wzWFrOnOvgf235EyCYVHMs/qVNVcxNWll8BPUznNdZIoIK6S6V6bVJWjaZmofS0K5ed0O/z34OXufKvjzCcJaP27BSIzqR9iIjz6w8jDdS8kukTA01uVQ4MOmQPIHNoLtXYd7CkQo9QDVOoU3++q058IDiWa36rmWcVFRUeQe0m0C7hw5O+GnP7PUz9lyGwNflzC8sd4FFwFTplsGf26OZptmjN8Vgq4Lst7PsBCkASq1irw3Gshe9qIrzq+o7H3MSOZ9TlnsYEsNFRo1jvbU0niEC1+mkLnccCNZAs3+cJMKFq9NIXZs9Y0VT4jnguycE5dDEinexJFFlemNN0KG7j1uRV1O0q6DstRB+TrhqLWVy0GiSmR3mVZEPEJCW3+/y8ILVsGU2w2noijC4bh6ZGi0=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4896751d-2a8e-46e9-362b-08d69262ac14
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 09:56:20.9679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4540
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpLaW5kbHkgUGluZy4uLg0KDQpSZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRv
bmdAbnhwLmNvbT4NCg0KQmVzdCBSZWdhcmRzLA0KSm9ha2ltIFpoYW5nDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9ha2ltIFpoYW5nDQo+IFNlbnQ6IDIwMTnE6jHU
wjMxyNUgMTc6MzcNCj4gVG86IG1rbEBwZW5ndXRyb25peC5kZTsgbGludXgtY2FuQHZnZXIua2Vy
bmVsLm9yZw0KPiBDYzogd2dAZ3JhbmRlZ2dlci5jb207IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14
QG54cC5jb20+OyBKb2FraW0NCj4gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPg0KPiBT
dWJqZWN0OiBbUEFUQ0hdIGNhbjogZmxleGNhbjogZml4IHRpbWVvdXQgd2hlbiBzZXQgc21hbGwg
Yml0cmF0ZQ0KPiANCj4gQ3VycmVudCB3ZSBjYW4gbWVldCB0aW1lb3V0IGlzc3VlIHdoZW4gc2V0
dGluZyBhIHNtYWxsIGJpdHJhdGUgbGlrZSAxMDAwMCBhcw0KPiBmb2xsb3dzIG9uIGkuTVg2VUwg
RVZLIGJvYXJkIChpcGcgY2xvY2sgPSA2Nk1IWiwgcGVyIGNsb2NrID0gMzBNSFopOg0KPiByb290
QGlteDZ1bDdkOn4jIGlwIGxpbmsgc2V0IGNhbjAgdXAgdHlwZSBjYW4gYml0cmF0ZSAxMDAwMCBB
IGxpbmsgY2hhbmdlDQo+IHJlcXVlc3QgZmFpbGVkIHdpdGggc29tZSBjaGFuZ2VzIGNvbW1pdHRl
ZCBhbHJlYWR5Lg0KPiBJbnRlcmZhY2UgY2FuMCBtYXkgaGF2ZSBiZWVuIGxlZnQgd2l0aCBhbiBp
bmNvbnNpc3RlbnQgY29uZmlndXJhdGlvbiwgcGxlYXNlDQo+IGNoZWNrLg0KPiBSVE5FVExJTksg
YW5zd2VyczogQ29ubmVjdGlvbiB0aW1lZCBvdXQNCj4gDQo+IEl0IGlzIGNhdXNlZCBieSBjYWxs
aW5nIG9mIGZsZXhjYW5fY2hpcF91bmZyZWV6ZSgpIHRpbWVvdXQuDQo+IA0KPiBPcmlnaW5hbGx5
IHRoZSBjb2RlIGlzIHVzaW5nIHVzbGVlcF9yYW5nZSgxMCwgMjApIGZvciB1bmZyZWV6ZSBvcGVy
YXRpb24sIGJ1dA0KPiB0aGUgcGF0Y2ggKDhiYWRkNjUgY2FuOiBmbGV4Y2FuOiBhdm9pZCBjYWxs
aW5nIHVzbGVlcF9yYW5nZSBmcm9tIGludGVycnVwdA0KPiBjb250ZXh0KSBjaGFuZ2VkIGl0IGlu
dG8gdWRlbGF5KDEwKSB3aGljaCBpcyBvbmx5IGEgaGFsZiBkZWxheSBvZiBiZWZvcmUsDQo+IHRo
ZXJlJ3JlIGFsc28gc29tZSBvdGhlciBkZWxheSBjaGFuZ2VzLg0KPiANCj4gQWZ0ZXIgZG91Ymxl
IHRvIEZMRVhDQU5fVElNRU9VVF9VUyB0byAxMDAgY2FuIGZpeCB0aGUgaXNzdWUuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPg0KPiAt
LS0NCj4gIGRyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC9jYW4vZmxleGNhbi5jIGIvZHJpdmVycy9uZXQvY2FuL2ZsZXhjYW4uYyBpbmRleA0K
PiAyYmNhODY3YmNmYWEuLjFmMmI0ZGI3ZGE4OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQv
Y2FuL2ZsZXhjYW4uYw0KPiArKysgYi9kcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jDQo+IEBAIC0x
NjYsNyArMTY2LDcgQEANCj4gICNkZWZpbmUgRkxFWENBTl9NQl9DTlRfTEVOR1RIKHgpCSgoKHgp
ICYgMHhmKSA8PCAxNikNCj4gICNkZWZpbmUgRkxFWENBTl9NQl9DTlRfVElNRVNUQU1QKHgpCSgo
eCkgJiAweGZmZmYpDQo+IA0KPiAtI2RlZmluZSBGTEVYQ0FOX1RJTUVPVVRfVVMJCSg1MCkNCj4g
KyNkZWZpbmUgRkxFWENBTl9USU1FT1VUX1VTCQkoMTAwKQ0KPiANCj4gIC8qIEZMRVhDQU4gaGFy
ZHdhcmUgZmVhdHVyZSBmbGFncw0KPiAgICoNCj4gLS0NCj4gMi4xNy4xDQoNCg==
