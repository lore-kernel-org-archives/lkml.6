Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF5DC282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3D5217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="OpaqloTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfBFL1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:27:33 -0500
Received: from mail-eopbgr150119.outbound.protection.outlook.com ([40.107.15.119]:8352
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726708AbfBFL1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIc2qsRVVTRDIbn+bQsQWakrerVASEAPZFRQSr+QV6w=;
 b=OpaqloTxc+38/TLze3jpZWGYGlk87DkVhO4xTwAgS0bKUHWYSaoJq6oXyOydO5H9tU4BVd6UVpq0RplULVZ9K2+sOQCEJvTipqFEiZs17p8qlNGzFdn9NlWsXK6Nu/TdiVU98p6waUWMi33O4wVnlDerThIrbiladeUeIBrdtGw=
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (52.133.6.141) by
 HE1PR0702MB3833.eurprd07.prod.outlook.com (52.133.7.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.16; Wed, 6 Feb 2019 11:27:28 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128%6]) with mapi id 15.20.1622.006; Wed, 6 Feb 2019
 11:27:27 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "greg@kroah.com" <greg@kroah.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 4.14 "uio: Prevent device destruction while fds are open"
Thread-Topic: 4.14 "uio: Prevent device destruction while fds are open"
Thread-Index: AQHUvg7wg0ospR92P0WaWK1t0X0nwA==
Date:   Wed, 6 Feb 2019 11:27:27 +0000
Message-ID: <007d90a957944409abd32af82a3680444a1e4399.camel@nokia.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.2.20]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0702MB3833;6:x3M4fLgdDo2iT5ubHaRatzRcdi67tnSWTtgPKywfx5wBcY17xVp+waMmkkPmX9cV7CW5Fz6bVb4u7vvdi8kWrWD1N8s1MCL3Q3fOSU73QDmJ2rC0r0y4CEArB/vcnumJmdEz7epTp8VBNapDT1EnwImTL3omAUdzvI81cDtcBA2hVO290aLY5sIM7b7ADOChfGBFKN0qlsBw1mlX0aZx7YPOo8M8Uts1dgcnTNUxm2CeIu7205seQO7E6FhDT8mMntNjXG0v9KbRCZg/DyAbs9yvLKg5B3ggxgWSDm9TP7y4vGcab8tcpDs0K2uNSEXl0AHIdSYsp1v4sBVhlEfF7gwHFdCCvplmsKQadXuA0HqBVOo7VlW18i79Dv6zimh/lFzKxGLxuG4E4EeuYzRua8hGuOa8Cs5BRy7SMNVJ7xxq0effelrAUsvc57fDgGFE4i7DqlsXDd0QQfFRTVOyjw==;5:o8rGh05+xUgAyXUVkbEhZpC5PzEl/wIjMOyVLJKLjTtCxo3nPq5EqV7jXCgX4V3OocIPdi84xnRJtYwl3E2vHPs7GQVVmH5uOgflGZIL13Yi+KcjB3TUsgZSYUftjty3WzlKdEKONv+aYbccE+55teVpG0b/QbCaOqqnUFT0DUdTke1r20SKmJDb04fBQjhZEjrSNB7uHvsM73/krdeZLA==;7:wo4zUH+9kV9cIqH+gdRqsiKhP9vHQ8CmuT0kFeiiXTyE4pd/OKQyjrl6uLRY65xvUp3ngsboOL6q+tWK9mXVVQOulAIPyfn8f1IvOwGpqk76GSYAg3AM8l2tBcust1XGvH8vfmt3TwsrTOSnZTkrUg==
x-ms-office365-filtering-correlation-id: dc8413d1-1014-45d1-9566-08d68c261349
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:HE1PR0702MB3833;
x-ms-traffictypediagnostic: HE1PR0702MB3833:
x-microsoft-antispam-prvs: <HE1PR0702MB3833FF164DCF0D60860EA7E0B46F0@HE1PR0702MB3833.eurprd07.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(136003)(366004)(396003)(199004)(189003)(25786009)(102836004)(26005)(8676002)(6346003)(478600001)(305945005)(476003)(68736007)(2616005)(2501003)(81166006)(8936002)(97736004)(7736002)(81156014)(6506007)(486006)(186003)(14454004)(118296001)(36756003)(71190400001)(71200400001)(316002)(3846002)(6116002)(6486002)(2906002)(110136005)(6436002)(4326008)(256004)(14444005)(86362001)(53936002)(66066001)(6512007)(99286004)(106356001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3833;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FFj08fje9dRxIdlrFG5q6kO4g1UuP2LKNm+NH6KpASc1aGxNAQGYi3gHBGhTSsiNpgIDIby5Pf/AnxV3SU85XsyOpx3l6FLGVkthWXwLaoV9ELWlw/bPkx02/3OSQPfGk0fJ4DLWCNd/OP8ETkEf7esqMQNDN3agiiZiRJPOVd/vFq7M6YHt3wEr/aszca1H6qPmHauKhgIhdm97yeJd/gfu7kR5DVCcjjcRFb+gTiNUEIqJNKpAhKzj5IyscWmBtJlIsn/vESDnUdfSGKrAAcYNdvyckSLia41b//P1/HVmTxQSnVeL7HP5cBULAg+cFXp+fW4bYGR3pN3xp2BrmwzJVARzMJXpKMzhumwrEUkascxAXD5vsDmrHo5GZZldEAC9fsE60V38HdmuazAYKMT3Zmuv+9mgVr0awGVJfiQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <841D9883B0D4644F96DBDF24CA4E6D5D@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8413d1-1014-45d1-9566-08d68c261349
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 11:27:27.8558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3833
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkkgaGl0IHVzZS1hZnRlci1mcmVlIGlzc3VlcyBpbiBVSU8gaW4gNC4xNC54LCBhbmQg
ZGlzY292ZXJlZCB0aGF0IGl0J3MNCmFscmVhZHkgZml4ZWQgaW4gbGF0ZXIga2VybmVsIHZlcnNp
b25zOg0KDQpjb21taXQgYTkzZTdiMzMxNTY4MjI3NTAwMTg2YTQ2NWZlZTNjMmNiNWRmZmQxZg0K
QXV0aG9yOiBIYW1pc2ggTWFydGluIDxoYW1pc2gubWFydGluQGFsbGllZHRlbGVzaXMuY28ubno+
DQpEYXRlOiAgIE1vbiBNYXkgMTQgMTM6MzI6MjMgMjAxOCArMTIwMA0KDQogICAgdWlvOiBQcmV2
ZW50IGRldmljZSBkZXN0cnVjdGlvbiB3aGlsZSBmZHMgYXJlIG9wZW4NCg0KQ2FuIHdlIGhhdmUg
dGhpcyBpbiA0LjE0Lnk/DQooZ29vZCBpZGVhIHRvIG9sZGVyIExUUyBrZXJuZWxzIHRvbykNCkkg
cGlja2VkIGFuZCB0ZXN0ZWQgdGhlIGZvbGxvd2luZyBjb21taXRzIGluIDQuMTQueDoNCg0KDQoj
IFRlbXBvcmFyaWx5IHJldmVydCAidWlvOiBGaXggYW4gT29wcyBvbiBsb2FkIiwNCiMgdG8gYXZv
aWQgbWVyZ2UgY29uZmxpY3QgbGF0ZXIgd2l0aCAidWlvOiB1c2UNCiMgcmVxdWVzdF90aHJlYWRl
ZF9pcnEgaW5zdGVhZCINCmdpdCByZXZlcnQgZjZhNmFlNGUwZjM0NWFhNDgxNTM1YmZlMjA0NmNk
MzNmNGRjMzdiOA0KDQojICJ1aW86IFJlZHVjZSByZXR1cm4gcGF0aHMgZnJvbSB1aW9fd3JpdGUo
KSINCmdpdCBjaGVycnktcGljayA4MWRhYTQwNmMyY2M5N2Q4NWVlZjk0MDk0MDA0MDRlZmMyYTNm
NzU2DQoNCiMgInVpbzogUHJldmVudCBkZXZpY2UgZGVzdHJ1Y3Rpb24gd2hpbGUgZmRzIGFyZSBv
cGVuIg0KIyBBbHNvIGFtZW5kIHRoaXMsIGNoYW5nZSBfX3BvbGxfdCB0byBwbGFpbiB1bnNpZ25l
ZCBpbnQsDQojIHRoZSBmb3JtZXIgbm90IGZvdW5kIGluIDQuMTQuDQpnaXQgY2hlcnJ5LXBpY2sg
YTkzZTdiMzMxNTY4MjI3NTAwMTg2YTQ2NWZlZTNjMmNiNWRmZmQxZg0Kc2VkIC1pICJzL19fcG9s
bF90L3Vuc2lnbmVkIGludC8iIGRyaXZlcnMvdWlvL3Vpby5jDQpnaXQgY29tbWl0IC0tYW1lbmQg
ZHJpdmVycy91aW8vdWlvLmMNCg0KIyAidWlvOiB1c2UgcmVxdWVzdF90aHJlYWRlZF9pcnEgaW5z
dGVhZCINCmdpdCBjaGVycnktcGljayA5NDIxZTQ1ZjVmZjNkNTU4Y2Y4Yjc1YThjYzA4MjQ1MzBj
YWYzNDUzDQoNCiMgInVpbzogY2hhbmdlIHRvIHVzZSB0aGUgbXV0ZXggbG9jayBpbnN0ZWFkIG9m
IHRoZSBzcGluIGxvY2siDQojIFJlc29sdmUgY29uZmxpY3QgZHVlIHRvIF9fcG9sbF90IGluIHBh
dGNoIGNvbnRleHQuDQpnaXQgY2hlcnJ5LXBpY2sgNTQzYWY1ODYxZjQxYWYwYTVkMjQzMmY2ZmI1
OTc2YWY1MGY5Y2VlNQ0Kc2VkIC1pIC1lICcvPDw8PDw8PC8sLz09PT09PT0vZCcgLWUgJy8+Pj4+
Pj4+L2QnIFwNCi1lICdzL19fcG9sbF90L3Vuc2lnbmVkIGludC8nIGRyaXZlcnMvdWlvL3Vpby5j
DQpnaXQgYWRkIGRyaXZlcnMvdWlvL3Vpby5jDQpnaXQgY2hlcnJ5LXBpY2sgLS1jb250aW51ZQ0K
DQojIHVpbzogZml4IGNyYXNoIGFmdGVyIHRoZSBkZXZpY2UgaXMgdW5yZWdpc3RlcmVkDQpnaXQg
Y2hlcnJ5LXBpY2sgNTdjNWY0ZGYwYTVhMGVlODNkZjc5OTk5MTI1MWUyZWU5M2E1ZTRlOQ0KDQoj
IHVpbzogZml4IHdyb25nIHJldHVybiB2YWx1ZSBmcm9tIHVpb19tbWFwKCkNCmdpdCBjaGVycnkt
cGljayBlN2RlMjU5MGYxOGEyNzJlNjM3MzJiOWQ1MTkyNTBkMWI1MjJiMmM0DQoNCiMgdWlvOiBm
aXggcG9zc2libGUgY2lyY3VsYXIgbG9ja2luZyBkZXBlbmRlbmN5DQpnaXQgY2hlcnJ5LXBpY2sg
YjM0ZTlhMTViMzdiOGRkYmYwNmE0ZGExNDJiMGMzOWM3NDIxMWViNA0KDQojIFJldmVydCAidWlv
OiB1c2UgcmVxdWVzdF90aHJlYWRlZF9pcnEgaW5zdGVhZCINCmdpdCBjaGVycnktcGljayAzZDI3
YzRkZThkNGZiMmQ0MDk5ZmYzMjQ2NzE3OTJhYTI1NzhjNmY5DQoNCiMgcmUtYXBwbHk6IHVpbzog
Rml4IGFuIE9vcHMgb24gbG9hZA0KZ2l0IGNoZXJyeS1waWNrIDQzMjc5ODE5NWJiY2UxZjhjZDMz
ZDFjMDI4NGQwNTM4ODM1ZTI1ZmINCg0KLVRvbW1pDQoNCg==
