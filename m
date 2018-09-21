Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AFFECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F0B2147C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TpdLk4GP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F0B2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388584AbeIUHEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:04:48 -0400
Received: from mail-eopbgr30073.outbound.protection.outlook.com ([40.107.3.73]:34004
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725749AbeIUHEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7kFpvLpM2SuRV1lcxdhDSH7oTrRvvrlEeq+VvovASA=;
 b=TpdLk4GPlmhZywb6tN06XbCkhMWrHvywoV9TLsUMOB4dCOXbRYmmsBJDAA0tsFoMGmd4+GxYQzwNeOwj5qZ9o6XgS4BZtVCc+f/KqQA8Q73ZKWkmN/f8fZlGRzZBTv4WbuCASeT6zxAVPc1QJcocxjBZ9t8tEHdso/DjAi4PIK8=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 21 Sep 2018 01:18:25 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::2d86:d831:13dd:3849]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::2d86:d831:13dd:3849%6]) with mapi id 15.20.1143.017; Fri, 21 Sep 2018
 01:18:25 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
CC:     YueHaibing <yuehaibing@huawei.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: RE: [PATCH] serial: imx: restore handshaking irq for imx1
Thread-Topic: [PATCH] serial: imx: restore handshaking irq for imx1
Thread-Index: AQHUUNsZrDta6d3E40uSMIdUsSoS0KT58Bzw
Date:   Fri, 21 Sep 2018 01:18:25 +0000
Message-ID: <VI1PR0402MB36009DCBD9F9F823EE216FF6FF120@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20180920071957.xnwni4lqb5kgncfc@pengutronix.de>
 <20180920121117.19041-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20180920121117.19041-1-u.kleine-koenig@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3600;6:RcBpdAk0cCzXCofovgLZeGQzAihGUyx39TbJa+WEArRysHpTOYHuXo1vERMd6WRS4Je6dj4PfSaprt4+dnI5U3ea4+pAwbNu9fcT3g0GKCaGHNOxbF8cLP+QKhzH+al6XHAzMfpyFLHYTE7Oq45bd6MU4CHh7Q6DYITsqdtyPY0X4dcCX9vUcK9B8K3hsDqfU9j2QDKjdThNlmb8o3k2XyWWM+r9oXPr42eqbrz7e4LVXPA6L7vUzRpsTzGWPQVUmimDlu+rbRb6OGOu2uuyZswPGO0zG9H2pviGWGFPuAs7nWL3oADqaRlYopGHJD5g9qIUiJ8ZJhche+0l6gStYKqs3eRy8v54QX7YSZbCqThmYisRXR5WYEMdknHVxLNNBqQX8jeFNFOrSOdLS0bZDxnp82+ekp2cIzuCXBws1Jy0aK4tiEjnLGHhplbQRDLvF7m42YUrz1EoE+ighTIulQ==;5:pEnDaSc8guFJpIGs6cKhulgbm6wjlAKcn9y3u2Z3Nn2VicwR+ks/gjaSbPdQ1LCpSq/mRb6AutN1pNEsn4qAYyYYFnMlSEr0mZSok55C3egGDcIoM2WUj+m2dNQlwKp0fFlBG5ni2CaxGJuE3/ykRBLyG95KdnI/N7mGCH9+F7Y=;7:KlTtTpNnJjpQo4TG8OQPP44KG71L/d/I8bDhGY/CKBmUlkMbyCuO6jmWhJBfotF8ef7ji000rWnuqtp63Q33uccQVRQd6QvncCT8ndPiuSngAIQer7LFWVHIYhdp1kFpC5sprGlGnVisdJZaNEsHPCCo9j4CEajbTuvQyq0/0LPRWBBKZm9S/Ty+opQqugpIERoybNUp/KnEsYNH9Kh54CM0JcLewERJ/64DU0iWO2SnrPKnMO6pj/4JS55MF/7e
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8f194e76-7344-4a97-4592-08d61f602159
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3600;
x-ms-traffictypediagnostic: VI1PR0402MB3600:
x-microsoft-antispam-prvs: <VI1PR0402MB360099CAFE4FD37DBA8C48EBFF120@VI1PR0402MB3600.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:VI1PR0402MB3600;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3600;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(366004)(396003)(199004)(189003)(25786009)(478600001)(26005)(486006)(5250100002)(6506007)(81156014)(86362001)(102836004)(81166006)(106356001)(105586002)(2900100001)(256004)(14444005)(446003)(11346002)(186003)(97736004)(476003)(74316002)(55016002)(305945005)(6436002)(76176011)(6246003)(7696005)(4326008)(2906002)(8676002)(3846002)(99286004)(6116002)(316002)(33656002)(5660300001)(68736007)(110136005)(14454004)(53936002)(7736002)(229853002)(66066001)(9686003)(71200400001)(54906003)(8936002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3600;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ob+BuwyX+RFXr2b9kJw0ulyg7UKssaIsk/IP7S/KEhTAEWJKPib6itg+fMnYH0vl3+dxTLpYKDLzenohMPotD5w5GeXtNZtUXU5gwWkh93eATGkOL6SOfwgA7QiTDhM0bJnH1Iklg8odN9V1Mj3tMuGhYlW1KeZz/2Q/jIPpYzr1QFPfE9UdmbmfY1QVtve/gC26lvNFPr/z0QfED9MWLYrQJFrbQ5oEoamGbd3+5TgWKQBgmNhMEM8yg+P19qCNSXeHsisL00Ym0ZfSJedo81zYrllk6UhHhUwGXik8WIXE2ZT1We8KTzAK2ndPGr87zZ2UQNUd3SRzQ2FG3/8p3CIjAUCT+foN/sp2AfbbK1c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f194e76-7344-4a97-4592-08d61f602159
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 01:18:25.4973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3600
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4g
U2VudDogMjAxOOW5tDnmnIgyMOaXpSAyMDoxMQ0KPiBCYWNrIGluIDIwMTUgd2hlbiBpcmRhIHdh
cyBkcm9wcGVkIGZyb20gdGhlIGRyaXZlciBpbXgxIHdhcyBicm9rZW4uDQo+IFRoaXMgY2hhbmdl
IHJlaW50cm9kdWNlcyB0aGUgc3VwcG9ydCBmb3IgdGhlIHRoaXJkIGludGVycnVwdCBvZiB0aGUg
VUFSVC4NCj4gDQo+IEZpeGVzOiBhZmU5Y2JiMWE2YWQgKCJzZXJpYWw6IGlteDogZHJvcCBzdXBw
b3J0IGZvciBJUkRBIikNCj4gU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xl
aW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCj4gLS0tDQo+ICBkcml2ZXJzL3R0eS9zZXJpYWwv
aW14LmMgfCA4ICsrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jIGIvZHJpdmVycy90dHkv
c2VyaWFsL2lteC5jIGluZGV4DQo+IDRlODUzNTcwZWE4MC4uNTU0YTY5ZGIxYmNhIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMNCj4gKysrIGIvZHJpdmVycy90dHkvc2Vy
aWFsL2lteC5jDQo+IEBAIC0yMzUwLDYgKzIzNTAsMTQgQEAgc3RhdGljIGludCBpbXhfdWFydF9w
cm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCQkJCXJldCk7DQo+ICAJ
CQlyZXR1cm4gcmV0Ow0KPiAgCQl9DQo+ICsNCj4gKwkJcmV0ID0gZGV2bV9yZXF1ZXN0X2lycSgm
cGRldi0+ZGV2LCBydHNpcnEsIGlteF91YXJ0X3J0c2ludCwgMCwNCj4gKwkJCQkgICAgICAgZGV2
X25hbWUoJnBkZXYtPmRldiksIHNwb3J0KTsNCj4gKwkJaWYgKHJldCkgew0KPiArCQkJZGV2X2Vy
cigmcGRldi0+ZGV2LCAiZmFpbGVkIHRvIHJlcXVlc3QgcnRzIGlycTogJWRcbiIsDQo+ICsJCQkJ
cmV0KTsNCj4gKwkJCXJldHVybiByZXQ7DQo+ICsJCX0NCj4gIAl9IGVsc2Ugew0KPiAgCQlyZXQg
PSBkZXZtX3JlcXVlc3RfaXJxKCZwZGV2LT5kZXYsIHJ4aXJxLCBpbXhfdWFydF9pbnQsIDAsDQo+
ICAJCQkJICAgICAgIGRldl9uYW1lKCZwZGV2LT5kZXYpLCBzcG9ydCk7DQo+IC0tDQo+IDIuMTgu
MA0KDQpSZXZpZXdlZC1ieTogRnVnYW5nIER1YW4gPGZ1Z2FuZy5kdWFuQG54cC5jb20+DQoNCg==
