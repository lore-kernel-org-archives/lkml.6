Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85F3ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7273D20858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f3cyC05a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7273D20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387998AbeGWHg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:36:57 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:31914
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387979AbeGWHg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7BQzk2+XILJXC3eMKWe2a2aa+UVBrea87xjyZY4NKM=;
 b=f3cyC05aGduR7CRh4LC6eFYN8mSJf17JyuzIubS/SnNC9xSN71kA8n0o7cUBAFP3QM2Pqpr3enl3jv9UBtNHZzGzbqSCKZyNRYocf+Jwu3fYdEVWKuw5TQt9YPudmIHMTCEmlhPi+JpAFvutwXdgpoofUVeA6dzJgfgZ7odpi1k=
Received: from AM0PR0402MB3747.eurprd04.prod.outlook.com (52.133.39.11) by
 AM0PR0402MB3923.eurprd04.prod.outlook.com (52.133.39.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.20; Mon, 23 Jul 2018 06:37:14 +0000
Received: from AM0PR0402MB3747.eurprd04.prod.outlook.com
 ([fe80::f13e:2610:6ff8:cc13]) by AM0PR0402MB3747.eurprd04.prod.outlook.com
 ([fe80::f13e:2610:6ff8:cc13%5]) with mapi id 15.20.0973.018; Mon, 23 Jul 2018
 06:37:13 +0000
From:   Pengbo Mu <pengbo.mu@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: RE: [PATCH] usb: dwc3: call set incr burst type func()
Thread-Topic: [PATCH] usb: dwc3: call set incr burst type func()
Thread-Index: AQHUIjYNPC9Ugap3IUCwapLPVjRhAqScRBaAgAAUvuA=
Date:   Mon, 23 Jul 2018 06:37:13 +0000
Message-ID: <AM0PR0402MB3747A7EA275D6680ACEFD821F4560@AM0PR0402MB3747.eurprd04.prod.outlook.com>
References: <1532316853-29184-1-git-send-email-pengbo.mu@nxp.com>
 <20180723051605.GA13377@kroah.com>
In-Reply-To: <20180723051605.GA13377@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pengbo.mu@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3923;6:dQxJeUbDIroZTtbSD397vrudqumOhR757Hvp9t2YFC9JZiB7ppLFvnkOlb66oQFmV2QGmCeL5YwRyMNhKyUCRTvA7b26iuIv7RWpZ1DAvX1jhD4gSeckLTISQRwN3S1XIJr1bUFrfEkA7XAAs00kg6NWicoiSS4Stv/K8slKof7jvxRDvmPvIsNQr8CMianF1r7Lk6UK46jhnaW5t1Vrnju0hlH1qpuOTLh/AQERU6/Dp2PZdIyAOR4gGxvINeVMQybd4qBDDi4kDNioGFXC0uQKfEtIxtR3rIq0ikTBZ3aehKMSlsVbi4959rQO438HOuT4Lg7MJKpyPrTTc0vEomsbJmhBpSb3QxShlz5v56zHZ8fkyBsVBsvzI7Ak5MZcbgVoy7FAmuJdHs/NmBm+PYEVJoPcsSZUzJt1Sz6zTZpNMOEVpkeR0ymTf6E2cIQApU3RsVAiOiFAZilrT/9u4g==;5:pWoCpYzzDpf6AWcx+1vF9cbAR9CiaqjviojkzkAYex2Db3AnUWTi3A+Y10G7bmBllczBga/Rl2Wuie3nvYY4f0gDlHNplLu1v5a1BoM1S9sgZ9GYQer85XyN2dgUrMJWcNWIphICEjcESZ/jZQBpFfAD8zXP1raCyK835Co4ULE=;7:0h+kGOmng9faVePZ2O8azPoQjLim4nYA0A39a8VOruS5Z1GB4roInc4yrRxTU2s3Pf/uYZwKvf24tQP+NhFkpxYF7aSw1JWCf7Yq+tyTvLl/03b/mnSGqOAWC4DlpZFc2HogSaIQE6EeN1zv9MtHlV3JV3HqsstF63ZVUMteNyZrigpVHW7r5eQ+jkbxxKbodn9sozAIKS4w2Vnz3Vw1ZTmYHSkquW1go1eLVREzTbNTUO8cG37mqotK9cjJj8D4
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ad945fba-011e-4c40-de3c-08d5f066b9f4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3923;
x-ms-traffictypediagnostic: AM0PR0402MB3923:
x-microsoft-antispam-prvs: <AM0PR0402MB3923DABC2CD0DE57404A5FE7F4560@AM0PR0402MB3923.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR0402MB3923;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3923;
x-forefront-prvs: 0742443479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(39860400002)(346002)(396003)(199004)(189003)(13464003)(478600001)(5250100002)(9686003)(3846002)(6116002)(2900100001)(76176011)(2906002)(99286004)(33656002)(53936002)(66066001)(74316002)(86362001)(81166006)(305945005)(7736002)(8676002)(81156014)(97736004)(8936002)(256004)(476003)(44832011)(446003)(486006)(68736007)(6506007)(53546011)(102836004)(106356001)(26005)(105586002)(11346002)(4326008)(14454004)(54906003)(316002)(186003)(6306002)(966005)(25786009)(229853002)(7696005)(6916009)(6246003)(5660300001)(55016002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3923;H:AM0PR0402MB3747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: P9bO60KR61YKt4CrC+C9Xw3AssBpqkGBI9yia3TCjUby3Is+/jE56ol34k/Ye0WkIrPNZawJ3mCmQYKXM5sdr3H+w8TLq6dIbL7hEe1TVjMnLuZltUu/OhPePGisr6l8bi6t6vylO1P9/HRzSx9B6XB83sthplVAjDEVDLZuSw9VoSrZKdOTFZWSn4L3czhL8uFCsFq6M0gUlG6wCe1+ylsa/AqnYhmdny7CGWTk4L6p+qoaosxodMT/Mv9Hjnbq+/2jvYMnl2SaqMuG5KS4/XLagyAiMTi7nN5Ze18KYxlEugxWrikzlOL1LYAwFVx3xQelIKSntg4POcLC5qBmRqFuh86OsDLXT6IbRa7n9HI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad945fba-011e-4c40-de3c-08d5f066b9f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2018 06:37:13.9145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3923
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KVGhpcyBwYXRjaCBzaG91bGQgYmUgdGllZCB3aXRoIGh0dHBzOi8vcGF0Y2h3
b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA1Mzk1MzUvLg0KQWZ0ZXIgc2VudCBmb3VyIHBhdGNoZXMs
IEkgZm91bmQgSSB3YXMgbWlzc2luZyB0aGlzIGNhbGwuDQpUaGFua3MgZm9yIHlvdXIgYWR2aWNl
LiBJIHdpbGwgZml4IGl0IGltbWVkaWF0ZWx5IQ0KDQpQZW5nYm8gTXUNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBHcmVnIEtyb2FoLUhhcnRtYW4gW21haWx0bzpncmVna2hAbGlu
dXhmb3VuZGF0aW9uLm9yZ10gDQpTZW50OiAyMDE4xOo31MIyM8jVIDEzOjE2DQpUbzogUGVuZ2Jv
IE11IDxwZW5nYm8ubXVAbnhwLmNvbT4NCkNjOiBGZWxpcGUgQmFsYmkgPGJhbGJpQGtlcm5lbC5v
cmc+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC11c2JAdmdlci5rZXJuZWwu
b3JnOyBSYW4gV2FuZyA8cmFuLndhbmdfMUBueHAuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0g
dXNiOiBkd2MzOiBjYWxsIHNldCBpbmNyIGJ1cnN0IHR5cGUgZnVuYygpDQoNCk9uIE1vbiwgSnVs
IDIzLCAyMDE4IGF0IDExOjM0OjEzQU0gKzA4MDAsIFBlbmdibyBNdSB3cm90ZToNCj4gQ2FsbCBk
d2MzX3NldF9pbmNyX2J1cnN0X3R5cGUoKSBpbiBkd2MzX2NvcmVfaW5pdCgpLg0KPiANCg0KVGhh
dCBzYXlzIHdoYXQgeW91IGRpZCwgbm90IHdoeSB5b3UgYXJlIGRvaW5nIHRoaXMuDQoNClBsZWFz
ZSBmaXggdXAuDQoNCmdyZWcgay1oDQo=
