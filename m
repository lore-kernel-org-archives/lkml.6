Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A929C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84F021547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dlvJNIeN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84F021547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeI0HbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:31:20 -0400
Received: from mail-db5eur01on0056.outbound.protection.outlook.com ([104.47.2.56]:36185
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726477AbeI0HbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=On6BvXx2LjprCnM5i4Ux79e+VMTz5xM0YwP6fnGB7QI=;
 b=dlvJNIeNOuiaPav/I3ZPmKy7OiIaYLqTC1Ba/84ObZaS76wyeZyIJn4nTTIb83460TpTciPvcPlwfPr9NkW4UPWfa4QCaLgJe6tNW4fy9EMWmDmqmfNQgwJoB2CL9U5s2gZGa217jcdld3F7RYcsbXjMOrqDeSkU94JwPEU9K2w=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4228.eurprd04.prod.outlook.com (52.134.126.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Thu, 27 Sep 2018 01:15:37 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1164.024; Thu, 27 Sep 2018
 01:15:37 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Subject: nfs+tcp boot failures on linuxnext-20180924 from switch tcp_clock_ns
 to CLOCK_TAI
Thread-Topic: nfs+tcp boot failures on linuxnext-20180924 from switch
 tcp_clock_ns to CLOCK_TAI
Thread-Index: AQHUVf+YOxeZc/fiuUOVFjRjgOz69Q==
Date:   Thu, 27 Sep 2018 01:15:37 +0000
Message-ID: <30e76d01dd08c2d9127072ad28c5a99afc5daabf.camel@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [85.204.4.237]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4228;6:uvN4mW6Zx9+fMkn4SXhYorz4k/w6xDw9H3G9AkpzD1AI5nefaS/IOVu7HvtNSZw4nTJ+uSmeYs/f6ujODu8ujxu5LJFXRqYAoFKu9mLuVDfWtnJvhADzHBusdRrqn5qQXtoCpCD6/VnkBekKwQhYfiw2RiRjbCNfDsr6SOYYjJO7ntegxoVoleCEaHM2vZD1cdCkiPjxtjNZV3gt1mckMqU7Wd0q6AFCn6P83R/QL53353hcS81ckAhaUC0SgdX5i5uU9NeYYKOYOhs2bvtIuOCiNGCrfAFI4iq2GPtDNDBhX1Yr0qtprgZXR0xm0AWW2zQd/Qton67MgRXhhLQO/D8y9JuQxkm2XH+Sa7qJ8x+djOgCBwxaPCfFWt8O7R6Ivwi2DudwZ+cyCfHzPwCiQdqLPgMnn0RHhk6ELlZItwEs1bXwOn+s5LM+yoavtBVfu8a8xAWu75YPDDHerx9Z/Q==;5:Rz8wjNXazeoImJ3Xgh/ws/EP2y7Gyb9vxp0v4HEazfIGH0lcFsiQsUlFyNCd4RCwAvpeRZDiYpun6H5A5BMjLeom6aHFYzqeG+3LTmQw5op5aiAgrjwedjqJu0Q/mALJzU+PRGpVCqO8p0IOC1qAaCIut/Uy0yYu+K6YfyGCm7U=;7:LzoIMu/HPqqoWGdeW6HbyqE/mzUwpeJzUE962BnktLSMJIPXNKRZncINbaaJF4cbp74MvhwRgBwqvIXloXpudtYFa0lE6Xkg6Ew+12jxDvEWiwg/nOnsGewwO8QmkxqmHT1BU9a3zwTgOxwY14UO2GPtj8UYgC2jD31J0Q1J/xN2JVNz8VT+g6Nfbq4+8uT4Uy87Xb+69/oDCuzc5oO3Ke4u8aoDCq87Px6rrgW7pbHPUK9bYhDR2lZQCYULEaRN
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0e50ea6f-83a2-4347-d87a-08d62416bb74
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4228;
x-ms-traffictypediagnostic: AM0PR04MB4228:
x-microsoft-antispam-prvs: <AM0PR04MB42282D911DA3F46F23FF518AEE140@AM0PR04MB4228.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051);SRVR:AM0PR04MB4228;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4228;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(396003)(366004)(199004)(189003)(66066001)(99286004)(6436002)(256004)(102836004)(186003)(5250100002)(6512007)(6486002)(118296001)(26005)(97736004)(2201001)(2501003)(86362001)(110136005)(54906003)(25786009)(34290500001)(2900100001)(4326008)(53936002)(478600001)(105586002)(7736002)(305945005)(6506007)(81156014)(81166006)(106356001)(71200400001)(486006)(44832011)(36756003)(476003)(2616005)(5660300001)(3846002)(6116002)(71190400001)(14454004)(8676002)(2906002)(8936002)(68736007)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4228;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sIJ8PhSkQprurhFWE8IJa3gBDOVaS6ph0NUwbuvDtGgwHHAlaYLvn8ChPTHOhqAcbSqn6Kc/4rL+0ItV/rZSzhUchTUm0/xq6lkd/Utojg+PFQmeu2gaTDvjMTE+JjSHkZahb61BLgMFv3uIEQLbHGY/lmb/3TBwJrV4OKjrzgNchJrOfh33G2pFS6kPl51OFJRmsPLJd22gEcL9ffjCDV42kCartgW5sNuDWpFfkjG9mIS1sZMqm4V3yO9l+VGYlyJmVQED07aZt61PsRRTpZzbHgWv7lNvjBhg3/6tOR/ZfP1C4be10GI7OnAw/Po4PPOFQsi/w0DFtbilsGUEay2Sj3vbT9Wv+mt96/ypME8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DB2FAE00880BC40839F0F886B543003@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e50ea6f-83a2-4347-d87a-08d62416bb74
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 01:15:37.1600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4228
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQogDQpJdCBzZWVtcyB0aGF0IGFmdGVyIGNvbW1pdCA3MmIwMDk0ZjkxODIgKCJ0Y3A6
IHN3aXRjaCB0Y3BfY2xvY2tfbnMoKSB0bw0KQ0xPQ0tfVEFJIGJhc2UiKSBzb21lIHN5c3RlbXMg
dGhhdCB1c2UgbmZzIG92ZXIgdGNwIGZhaWwgdG8gYm9vdC4gVGhlDQpsYXN0IGxpbmUgcHJpbnRl
ZCBpbiB0aGUgbG9nIGlzIGZyb20gc3lzdGVtZDoNCiANClsgICAgNy4yMzI1NzldIHN5c3RlbWRb
MV06IFN5c3RlbSB0aW1lIGJlZm9yZSBidWlsZCB0aW1lLCBhZHZhbmNpbmcgY2xvY2suDQogDQpT
dXBlcmZpY2lhbGx5IGl0IGxvb2tzIGxpa2UgdmVyeSBsYXJnZSBjbG9jayBkaXNjb250aW51aXRp
ZXMgbm93IGJyZWFrDQpUQ1AuIE1heWJlIGJvb3R0aW1lIGNvdWxkIGF2b2lkIHN1Y2ggaXNzdWVz
Pw0KIA0KSSBkaWRuJ3QgZmluZCBzaW1pbGFyIHJlcG9ydHMgYW55d2hlcmUgZWxzZS4gVGhlIG1h
Y2hpbmVzIEnigJltIHNlZWluZw0KdGhpcyBhcmUgYWxsIDMyYml0IGFybSBpbXggKHRoaXMgc2hv
dWxkbuKAmXQgbWF0dGVyKSBhbmQgaXQgc2VlbXMgdGhlaXINClJUQyBpc27igJl0IHByb3Blcmx5
IHNldHVwIHNvIHRoZXkgYm9vdCB3aXRoIHJlYWx0aW1lIHNldCB0byB1bml4IHplcm8sDQp0aGVu
IGEgfjUwIHllYXJzIGp1bXAgaGFwcGVucyB3aGVuIHN5c3RlbWQgc3RhcnRzIHVwLiBUaGlzIGlz
IHRoZQ0KbGlrZWx5IHRyaWdnZXIgZm9yIHRoaXMgaXNzdWUuDQogDQotLQ0KUmVnYXJkcywNCkxl
b25hcmQNCg==
